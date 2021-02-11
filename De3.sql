create database test1;
use test1;
create table nhacungcap (
	mancc varchar(5),
	tenncc varchar(100),
	quocgia varchar(50),
	loaincc varchar(50),
	constraint pk_nhacungcap primary key (mancc)
);
go
create table duocpham (
	madp varchar(4),
	tendp varchar(100),
	loaidp varchar(50),
	gia smallmoney,
	constraint pk_duocpham primary key (madp)
);
go
create table phieunhap(
	sopn varchar(5),
	ngnhap smalldatetime,
	mancc varchar(5),
	loainhap varchar(50),
	constraint pk_phieunhap primary key (sopn),
	constraint fk_phieunhap_nhacungcap foreign key (mancc) references nhacungcap(mancc)
) 
go
create table ctpn(
	sopn varchar(5),
	madp varchar(4),
	soluong int,
	constraint pk_ctpn primary key (sopn, madp),
	constraint fk_ctpn_phieunhap foreign key (sopn) references phieunhap(sopn),
	constraint fk_ctpn_duocpham foreign key (madp) references duocpham(madp)
)
go
insert into nhacungcap values 
('NCC01', 'Phuc Hung', 'Viet Nam', 'Thuong xuyen'),
('NCC02', 'J. B. Pharmaceuticals', 'India', 'Vang lai'),
('NCC03' , 'Sapharco', 'Singapore', 'Vang lai');
insert into duocpham values 
('DP01', 'Thuoc ho PH', 'Siro', 120.000),
('DP02', 'Zecuf Herbal CouchRemedy', 'Vien nen', 200.000),
('DP03', 'Cotrim', 'Vien sui', 80.000)
SET DATEFORMAT DMY
insert into phieunhap values
('00001', '22/11/2017', 'NCC01', 'Noi dia'),
('00002', '04/12/2017', 'NCC03', 'Nhap khau'),
('00003', '10/12/2017', 'NCC02', 'Nhap khau')
insert into ctpn values 
('00001', 'DP01', 100),
('00001', 'DP02', 200),
('00003', 'DP03' ,543)
go
--3. Hiện thực ràng buộc toàn vẹn sau: Tất cả các dược phẩm có loại là Siro đều có giá lớn hơn 100.000đ (1đ)
create trigger trg_duocpham on duocpham
for insert
as begin
	declare @gia smallmoney, @loaidp varchar(50)
	select @loaidp = loaidp, @gia = gia from inserted
	if(@loaidp = 'Siro')
		begin
			if(@gia <= 100.000)
				begin
					print 'ERROR!!! Tất cả các dược phẩm có loại là Siro đều có giá lớn hơn 100.000đ'
					rollback transaction
				end
			else
				print 'Success!!!'
		end
	else
		print 'Success!!!'
end
--test--
insert into duocpham values 
('DP05', 'Thuoc ho PH', 'Siro', 90.000)
go
--4. Hiện thực ràng buộc toàn vẹn sau: Phiếu nhập của những nhà cung cấp ở những quốc gia khác Việt Nam đều có loại nhập là Nhập khẩu. (2đ).
create trigger trg_phieunhap on phieunhap
for insert
as begin
	declare @mancc varchar(5), @loainhap varchar(50), @quocgia varchar(50)
	select @mancc = mancc, @loainhap = loainhap from inserted
	select @quocgia = quocgia from nhacungcap where @mancc = mancc
	if(@quocgia <> 'Viet Nam')
		begin
			if(@loainhap <> 'Nhap khau')
				begin
					print 'ERROR!!! Hay nhap lai'
					rollback transaction
				end
					print 'Success!!'
		end
	else
		print 'Success!!'
end
--test
insert into phieunhap values
('00004', '22/11/2017', 'NCC01', 'Noi dia')
go
--5. Tìm tất cả các phiếu nhập có ngày nhập trong tháng 12 năm 2017, sắp xếp kết quả tăng dần theo ngày nhập (1đ).
select * from phieunhap
where MONTH(ngnhap) = '12' and YEAR(ngnhap) = '2017'
order by ngnhap ASC
go
--6. Tìm dược phẩm được nhập số lượng nhiều nhất trong năm 2017 (1đ)
select * from duocpham
where madp in (select top 1(madp) from ctpn where sopn in
(select sopn from phieunhap where YEAR(ngnhap) = '2017') order by soluong desc)
go
--7. Tìm dược phẩm chỉ có nhà cung cấp thường xuyên (LOAINCC là Thuong xuyen) cung cấp, nhà cung cấp vãng lai (LOAINCC là Vang lai) không cung cấp. (1đ).
select * from duocpham where madp in(
select madp from ctpn where sopn in( 
select sopn from phieunhap where mancc in (
select mancc from nhacungcap where loaincc = 'Thuong xuyen')))
EXCEPT 
select * from duocpham where madp in(
select madp from ctpn where sopn in( 
select sopn from phieunhap where mancc in (
select mancc from nhacungcap where loaincc = 'Vang lai')))
--8. Tìm nhà cung cấp đã từng cung cấp tất cả những dược phẩm có giá trên 100.000đ trong năm 2017 (1đ).select * from nhacungcap where mancc in(select mancc from phieunhap where YEAR(ngnhap) = '2017' and sopn in(select distinct sopn from ctpn where madp in(select madp from duocpham where gia > 100.000)))