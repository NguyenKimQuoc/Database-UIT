create database QuanLyBanHang
use QuanLyBanHang
set dateformat DMY
create table KHACHHANG(
	MAKH char(4) primary key,
	HOTEN varchar(40),
	DIACHI varchar(50),
	SODT varchar(20),
	NGSINH smalldatetime,
	DOANHSO mONey, 
	NGDK smalldatetime,
)
create table NHANVIEN(
	MANV char(4) primary key,
	HOTEN varchar(40),
	NGVL smalldatetime,
	SODT varchar(20),
)
create table SANPHAM(
	MASP char(4) primary key,
	TENSP varchar(40),
	DVT varchar(20),
	NUOCSX varchar(40),
	GIA mONey,
)
create table HOADON(
	SOHD int primary key,
	NGHD smalldatetime,
	MAKH char(4),
	MANV char(4), 
	TRIGIA mONey,
)
create table CTHD(
	SOHD int,
	MASP char(4),
	SL int,
	primary key (SOHD, MASP),
)
alter table CTHD add cONstraint FK_SOHD foreign key (SOHD) references HOADON(SOHD)
alter table CTHD add cONstraint FK_MASP foreign key (MASP) references SANPHAM(MASP)
alter table HOADON add cONstraint FK_MAKH foreign key (MAKH) references KHACHHANG(MAKH)
alter table HOADON add cONstraint FK_MANV foreign key (MANV) references NHANVIEN(MANV)


--------------------------------------------- Tuan 1---------------------------------------------------


--2--Thêm vào thuộc tính GHICHU có kiểu dữ liệu varchar(20) cho quan hệ SANPHAM
alter table SANPHAM add GHICHU varchar(20)
--3--Thêm vào thuộc tính LOAIKH có kiểu dữ liệu là tinyint cho quan hệ KHACHHANG.
alter table KHACHHANG add LOAIKH tinyint
--4--Sửa kiểu dữ liệu của thuộc tính GHICHU Trong quan hệ SANPHAM thành varchar(100)
alter table SANPHAM alter column GHICHU varchar(100)
--5--Xóa thuộc tính GHICHU Trong quan hệ SANPHAM
alter table SANPHAM drop column GHICHU
--6--Làm thế nào để thuộc tính LOAIKH Trong quan hệ KHACHHANG có thể lưu các giá trị là: “Vang lai”, “ThuONg xuyen”, “Vip”, …
-- Đổi kiểu dữ liệu của thuộc tính LOAIKH từ tinyint thành varchar hoặc char
alter table KHACHHANG alter column LOAIKH varchar(50)
alter table KHACHHANG add cONstraint check_LOAIKH check (LOAIKH IN ('Vang lai', 'ThuONg xuyen', 'Vip'))
--7--Đơn vị tính của sản phẩm chỉ có thể là (“cay”,”hop”,”cai”,”quyen”,”chuc”)
alter table SANPHAM add cONstraint check_DVT check (DVT IN ('cay', 'hop', 'cai', 'quyen', 'chuc'))
--8--Giá bán của sản phẩm từ 500 đồng trở lên.
alter table SANPHAM add cONstraint check_GIA check (GIA >= 500)
--9--Mỗi lần mua hàng, khách hàng phải mua ít nhất 1 sản phẩm.
alter table CTHD add cONstraint check_SL check (SL >= 1)
--10--Ngày khách hàng đăng ký là khách hàng thành viên phải lớn hơn ngày sinh của người đó.
alter table KHACHHANG add cONstraint check_NGSINH_NGDK check (NGSINH<NGDK)


-----------------------------------------------Tuan 2 ------------------------------------------------------------


-- Bài tập 1 Sinh viên tiến hành viết câu lệnh nhập dữ liệu cho CSDL QuanLyBanHang (Phần II, câu 1 bài tập thực hành trang 4).

--II--
--1-- Nhập dữ liệu cho các quan hệ
delete from KHACHHANG;
alter table KHACHHANG drop cONstraint check_LOAIKH
alter table KHACHHANG drop column LOAIKH
insert into KHACHHANG values ('KH01','Nguyen Van A','731, Tran Hung Dao, Q 5, Tp HCM','08823451','22/10/1960',13060000,'22/07/2006')
insert into KHACHHANG values ('KH02','Tran Ngoc Han','23/5, Nguyen Trai, Q 5, Tp HCM','0908256478','03/04/1974',280000,'30/07/2006')
insert into KHACHHANG values ('KH03','Tran Ngoc Linh','45, Nguyen Canh Chan, Q 1, Tp HCM','0938776266','12/06/1980',3860000,'05/08/2006')
insert into KHACHHANG values ('KH04','Tran Minh LONg','50/34 Le Dai Hanh, Q 10, Tp HCM','0917325476','09/03/1965',250000,'02/10/2006')
insert into KHACHHANG values ('KH05','Le Nhat Minh','34, TruONg Dinh, Q 3, Tp HCM','08246108','10/03/1950',21000,'28/10/2006')
insert into KHACHHANG values ('KH06','Le Hoai ThuONg','227, Nguyen Van Cu, Q 5, Tp HCM','08631738','31/12/1981',915000,'24/11/2006')
insert into KHACHHANG values ('KH07','Nguyen Van Tam','32/3, Tran Binh Trong, Q 5, Tp HCM','0916783565','06/04/1971',12500,'01/12/2006')
insert into KHACHHANG values ('KH08','Phan Thi Thanh','45/2, An DuONg VuONg, Q 5, Tp HCM','0938435756','10/01/1971',365000,'13/12/2006')
insert into KHACHHANG values ('KH09','Le Ha Vinh','873, Le HONg PhONg, Q 5, Tp HCM','08654763','03/09/1979',70000,'14/01/2007')
insert into KHACHHANG values ('KH10','Ha Duy Lap','34/34B, Nguyen Trai, Q 1, Tp HCM','08768904','02/05/1983',67500,'16/01/2007')		
--Thêm dũ liệu cho NHANVIEN
delete from NHANVIEN
insert into NHANVIEN values ('NV01','Nguyen Nhu Nhut','13/04/2006','0927345678')
insert into NHANVIEN values ('NV02','Le Thi Phi Yen','21/04/2006','0987567390')
insert into NHANVIEN values ('NV03','Nguyen Van B','27/04/2006','0997047382')
insert into NHANVIEN values ('NV04','Ngo Thanh Tuan','24/06/2006','0913758498')
insert into NHANVIEN values ('NV05','Nguyen Thi Truc Thanh','20/07/2006','0918590387')
--Thêm dũ liệu cho SANPHAM
delete from SANPHAM
insert into SANPHAM values ('BC01','But chi','cay','Singapore',3000)
insert into SANPHAM values ('BC02','But chi','cay','Singapore',5000)
insert into SANPHAM values ('BC03','But chi','cay','Viet Nam',3500)
insert into SANPHAM values ('BC04','But chi','hop','Viet Nam',30000)
insert into SANPHAM values ('BB01','But bi','cay','Viet Nam',5000)
insert into SANPHAM values ('BB02','But bi','cay','Trung Quoc',7000)
insert into SANPHAM values ('BB03','But bi','hop','Thai Lan',100000)
insert into SANPHAM values ('TV01','Tap 100 giay mONg','quyen','Trung Quoc',2500)
insert into SANPHAM values ('TV02','Tap 200 giay mONg','quyen','Trung Quoc',4500)
insert into SANPHAM values ('TV03','Tap 100 giay tot','quyen','Viet Nam',3000)
insert into SANPHAM values ('TV04','Tap 200 giay tot','quyen','Viet Nam',5500)
insert into SANPHAM values ('TV05','Tap 100 trang','chuc','Viet Nam',23000)
insert into SANPHAM values ('TV06','Tap 200 trang','chuc','Viet Nam',53000)
insert into SANPHAM values ('TV07','Tap 100 trang','chuc','Trung Quoc',34000)
insert into SANPHAM values ('ST01','So tay 500 trang','quyen','Trung Quoc',40000)
insert into SANPHAM values ('ST02','So tay loai 1','quyen','Viet Nam',55000)
insert into SANPHAM values ('ST03','So tay loai 2','quyen','Viet Nam',51000)
insert into SANPHAM values ('ST04','So tay ','quyen','Thai Lan',55000)
insert into SANPHAM values ('ST05','So tay mONg','quyen','Thai Lan',20000)
insert into SANPHAM values ('ST06','Phan viet bang','hop','Viet Nam',5000)
insert into SANPHAM values ('ST07','Phan khONg bui','hop','Viet Nam',7000)
insert into SANPHAM values ('ST08','BONg bang','cai','Viet Nam',1000)
insert into SANPHAM values ('ST09','But lONg','cay','Viet Nam',5000)
insert into SANPHAM values ('ST10','But lONg','cay','Trung Quoc',7000)

--Thêm dũ liệu cho HOADON
delete from HOADON
insert into HOADON values (1001,'23/7/2006','KH01','NV01',320000)
insert into HOADON values (1002,'12/8/2006','KH01','NV02',840000)
insert into HOADON values (1003,'23/8/2006','KH02','NV01',100000)
insert into HOADON values (1004,'1/9/2006','KH02','NV01',180000)
insert into HOADON values (1005,'20/10/2006','KH01','NV02',3800000)
insert into HOADON values (1006,'16/10/2006','KH01','NV03',2430000)
insert into HOADON values (1007,'28/10/2006','KH03','NV03',510000)
insert into HOADON values (1008,'28/10/2006','KH01','NV03',440000)
insert into HOADON values (1009,'28/10/2006','KH03','NV04',200000)
insert into HOADON values (1010,'1/11/2006','KH01','NV01',5200000)
insert into HOADON values (1011,'4/11/2006','KH04','NV03',250000)
insert into HOADON values (1012,'30/11/2006','KH05','NV03',21000)
insert into HOADON values (1013,'12/12/2006','KH06','NV01',5000)
insert into HOADON values (1014,'31/10/2006','KH03','NV02',3150000)
insert into HOADON values (1015,'1/1/2007','KH06','NV01',910000)
insert into HOADON values (1016,'1/1/2007','KH07','NV02',12500)
insert into HOADON values (1017,'2/1/2007','KH08','NV03',35000)
insert into HOADON values (1018,'13/1/2007','KH08','NV03',330000)
insert into HOADON values (1019,'13/1/2007','KH01','NV03',30000)
insert into HOADON values (1020,'14/1/2007','KH09','NV04',70000)
insert into HOADON values (1021,'16/1/2007','KH10','NV03',67500)
insert into HOADON values (1022,'16/1/2007',null,'NV03',7000)
insert into HOADON values (1023,'17/1/2007',null,'NV01',330000)


--Thêm dũ liệu cho CTHD
delete from CTHD
insert into CTHD values (1001,'TV02',10)
insert into CTHD values (1001,'ST01',5)
insert into CTHD values (1001,'BC01',5)
insert into CTHD values (1001,'BC02',10)
insert into CTHD values (1001,'ST08',10)
insert into CTHD values (1002,'BC04',20)
insert into CTHD values (1002,'BB01',20)
insert into CTHD values (1002,'BB02',20)
insert into CTHD values (1003,'BB03',10)
insert into CTHD values (1004,'TV01',20)
insert into CTHD values (1004,'TV02',20)
insert into CTHD values (1004,'TV03',20)
insert into CTHD values (1004,'TV04',20)
insert into CTHD values (1005,'TV05',50)
insert into CTHD values (1005,'TV06',50)
insert into CTHD values (1006,'TV07',20)
insert into CTHD values (1006,'ST01',30)
insert into CTHD values (1006,'ST02',10)
insert into CTHD values (1007,'ST03',10)
insert into CTHD values (1008,'ST04',8)
insert into CTHD values (1009,'ST05',10)
insert into CTHD values (1010,'TV07',50)
insert into CTHD values (1010,'ST07',50)
insert into CTHD values (1010,'ST08',100)
insert into CTHD values (1010,'ST04',50)
insert into CTHD values (1010,'TV03',100)
insert into CTHD values (1011,'ST06',50)
insert into CTHD values (1012,'ST07',3)
insert into CTHD values (1013,'ST08',5)
insert into CTHD values (1014,'BC02',80)
insert into CTHD values (1014,'BB02',100)
insert into CTHD values (1014,'BC04',60)
insert into CTHD values (1014,'BB01',50)
insert into CTHD values (1015,'BB02',30)
insert into CTHD values (1015,'BB03',7)
insert into CTHD values (1016,'TV01',5)
insert into CTHD values (1017,'TV02',1)
insert into CTHD values (1017,'TV03',1)
insert into CTHD values (1017,'TV04',5)
insert into CTHD values (1018,'ST04',6)
insert into CTHD values (1019,'ST05',1)
insert into CTHD values (1019,'ST06',2)
insert into CTHD values (1020,'ST07',10)
insert into CTHD values (1021,'ST08',5)
insert into CTHD values (1021,'TV01',7)
insert into CTHD values (1021,'TV02',10)
insert into CTHD values (1022,'ST07',1)
insert into CTHD values (1023,'ST04',6)

-- Bài tập 3 Sinh viên hoàn thành Phần II bài tập QuanLyBanHang từ câu 2 đến câu 5

--II--
--2-- Tạo quan hệ SANPHAM1 chứa toàn bộ dữ liệu của quan hệ SANPHAM. Tạo quan hệ KHACHHANG1 chứa toàn bộ dữ liệu của quan hệ KHACHHANG
select * INTO SANPHAM1 from SANPHAM
select * INTO KHACHHANG1 from KHACHHANG
--3-- Cập nhật giá tăng 5% đối với những sản phẩm do “Thai Lan” sản xuất (cho quan hệ SANPHAM1)
update SANPHAM1 
set GIA = GIA + GIA*(5/100) 
where NUOCSX = 'Thai Lan'
--4-- Cập nhật giá giảm 5% đối với những sản phẩm do “Trung Quoc” sản xuất có giá từ 10.000 trở xuống (cho quan hệ SANPHAM1).
update SANPHAM1 
set GIA = GIA - GIA*(5/100) 
where NUOCSX = 'Trung Quoc' and GIA < 10000
--5-- Cập nhật giá trị LOAIKH là “Vip” đối với những khách hàng đăng ký thành viên trước ngày
	--1/1/2007 có doanh số từ 10.000.000 trở lên hoặc khách hàng đăng ký thành viên từ 1/1/2007 trở về
	--sau có doanh số từ 2.000.000 trở lên (cho quan hệ KHACHHANG1).
update KHACHHANG1
set LOAIKH = 'VIP'
where ((NGDK < '01/01/2007' AND DOANHSO > 10000000) OR (NGDK > '01/01/2007' AND DOANHSO > 2000000))

-- Bài tập 5 Sinh viên hoàn thành Phần III bài tập QuanLyBanHang từ câu 1 đến câu 11.

 --III--
--1--In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất
select MASP,TENSP from SANPHAM where NUOCSX = 'Trung Quoc'
--2--In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cay”, ”quyen”
select MASP,TENSP from SANPHAM where DVT in ('cay', 'quyen')
--3--In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”
select MASP,TENSP from SANPHAM where MASP like 'B%01'
--4--In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 30.000 đến 40.000
select MASP,TENSP from SANPHAM where NUOCSX = 'Trung Quoc' and GIA >= 30000 and GIA <= 40000
--5--In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” hoặc “Thai Lan” sản xuất có giá từ 30.000 đến 40.000.
select MASP,TENSP from SANPHAM where (NUOCSX = 'Trung Quoc' or NUOCSX = 'Thai Lan') and GIA >= 30000 and GIA <= 40000 
--6--In ra các số hóa đơn, trị giá hóa đơn bán ra Trong ngày 1/1/2007 và ngày 2/1/2007
select SOHD, TRIGIA from HOADON where NGHD = '1/1/2007' or NGHD = '2/1/2007'
--7--In ra các số hóa đơn, trị giá hóa đơn Trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần)
select SOHD, TRIGIA from HOADON where mONth(NGHD) = '1' and year(NGHD) = '2007' order by NGHD ASC, TRIGIA DESC
--8-- In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng Trong ngày 1/1/2007
select KH.MAKH, HOTEN 
from KHACHHANG KH inner join HOADON HD
ON KH.MAKH = HD.MAKH
where NGHD = '1/1/2007'
--9-- In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyen Van B” lập Trong ngày 28/10/2006
select SOHD, TRIGIA
from HOADON HD inner join NHANVIEN NV
ON HD.MANV = NV.MANV
where HOTEN = 'Nguyen Van B'
--10--In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua Trong tháng 10/2006
select MASP, TENSP 
from SANPHAM SP
where EXISTS (
	select MASP 
	from CTHD C inner join HOADON HD
	ON C.SOHD = HD.SOHD
	where SP.MASP = C.MASP and MONTH(NGHD) = '10' and YEAR(NGHD) = '2006' and MAKH in (
			select MAKH from KHACHHANG 
			where HOTEN = 'Nguyen Van A')
)
--11--Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”
select DISTINCT SOHD from CTHD where MASP = 'BB01' or MASP = 'BB02'

-----------------------------------------------Tuan 3 ------------------------------------------------------------

-- Bài tập 1 Sinh viên hoàn thành Phần III bài tập QuanLyBanHang câu 12 và câu 13. 
--12-- Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
select SOHD
from CTHD
where MASP IN ('BB01', 'BB02')
AND SL BETWEEN 10 AND 20
--13-- Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
select SOHD
from CTHD A
where MASP IN ('BB01','BB02')
AND SL BETWEEN 10 AND 20
AND EXISTS (select SOHD 
from CTHD B
where MASP IN ('BB01','BB02')
AND SL BETWEEN 10 AND 20
AND A.SOHD = B.SOHD)

-- Bài tập 4 Sinh viên hoàn thành Phần III bài tập QuanLyBanHang từ câu 14 đến 19.
--14-- In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được bán ra Trong ngày 1/1/2007.
select DISTINCT S.MASP, TENSP
from SANPHAM S INNER JOIN CTHD C
ON S.MASP = C.MASP
where NUOCSX = 'TRUNG QUOC'
AND C.SOHD IN(select DISTINCT C2.SOHD
from CTHD C2 INNER JOIN HOADON H
ON C2.SOHD = H.SOHD
where NGHD = '1/1/2007')
--15-- In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
select S.MASP, TENSP
from SANPHAM S
where NOT EXISTS(select * 
from SANPHAM S2 INNER JOIN CTHD C
ON S2.MASP = C.MASP
AND S2.MASP = S.MASP)
--16-- In ra danh sách các sản phẩm (MASP,TENSP) không bán được Trong năm 2006.
select S.MASP, TENSP
from SANPHAM S
where S.MASP NOT IN(select C.MASP 
from CTHD C INNER JOIN HOADON H
ON C.SOHD = H.SOHD
where YEAR(NGHD) = 2006)

--17-- In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được Trong năm 2006.
select S.MASP, TENSP
from SANPHAM S
where NUOCSX = 'TRUNG QUOC' AND S.MASP NOT IN(select C.MASP 
from CTHD C INNER JOIN HOADON H
ON C.SOHD = H.SOHD
where YEAR(NGHD) = 2006)
--18-- Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.
select H.SOHD 
from HOADON H
where NOT EXISTS(select *
from SANPHAM S
where NUOCSX = 'SINGAPORE'
AND NOT EXISTS(select * 
from CTHD C
where C.SOHD = H.SOHD
AND C.MASP = S.MASP))

select DISTINCT CT.SOHD 
from CTHD CT
where NOT EXISTS(select *
from SANPHAM S
where NUOCSX = 'SINGAPORE'
AND NOT EXISTS(select * 
from CTHD C
where C.SOHD = CT.SOHD
AND C.MASP = S.MASP))

--19-- Tìm số hóa đơn Trong năm 2006 đã mua ít nhất tất cả các sản phẩm do Singapore sản xuất.
select H.SOHD 
from HOADON H
where YEAR(NGHD) = 2006 AND NOT EXISTS(select *
from SANPHAM S
where NUOCSX = 'SINGAPORE'
AND NOT EXISTS(select * 
from CTHD C
where C.SOHD = H.SOHD
AND C.MASP = S.MASP))

-------------------------------------------------Tuan 4--------------------------------------------

--Bài tập 1: Sinh viên hoàn thành Phần III bài tập QuanLyBanHang từ câu 20 đến 30
USE QuanLyBanHang
--20.	Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
select COUNT(*)
from HOADON H
where MAKH NOT IN(select MAKH
from KHACHHANG K 
where K.MAKH = H.MAKH)
--21.	Có bao nhiêu sản phẩm khác nhau được bán ra Trong năm 2006.
select COUNT(DISTINCT MASP)
from CTHD C INNER JOIN HOADON H
ON C.SOHD = H.SOHD
where YEAR(NGHD) = 2006
--22.	Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?
select MAX(TRIGIA) as MAX, MIN(TRIGIA) as MIN
from HOADON
--23.	Trị giá trung bình của tất cả các hóa đơn được bán ra Trong năm 2006 là bao nhiêu?
select AVG(TRIGIA) TB
from HOADON
--24.	Tính doanh thu bán hàng Trong năm 2006.
select SUM(TRIGIA) as DOANHTHU
from HOADON
where YEAR(NGHD) = 2006
--25.	Tìm số hóa đơn có trị giá cao nhất Trong năm 2006.
select SOHD
from HOADON
where TRIGIA = (select MAX(TRIGIA) from HOADON)
--26.	Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất Trong năm 2006.
select HOTEN
from KHACHHANG K INNER JOIN HOADON H
ON K.MAKH = H.MAKH 
AND SOHD = (select SOHD from HOADON
			where TRIGIA = (select MAX(TRIGIA) from HOADON))
--27.	In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất.
select TOP 3 MAKH, HOTEN
from KHACHHANG
order by DOANHSO DESC
--28.	In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 Trong 3 mức giá cao nhất.
select MASP, TENSP
from SANPHAM
where GIA IN (select DISTINCT TOP 3 GIA
			  from SANPHAM
			  order by GIA DESC)
--29.	In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 Trong 3 mức giá cao nhất (của tất cả các sản phẩm).
select MASP, TENSP
from SANPHAM
where NUOCSX = 'Thai Lan' AND GIA IN (select DISTINCT TOP 3 GIA
from SANPHAM
order by GIA DESC)
--30.	In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 Trong 3 mức giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất).
select MASP, TENSP
from SANPHAM
where NUOCSX = 'Trung Quoc' AND GIA IN (select DISTINCT TOP 3 GIA
from SANPHAM
where NUOCSX = 'Trung Quoc'
order by GIA DESC)
--Bài tập 3: Sinh viên hoàn thành Phần III bài tập QuanLyBanHang từ câu 31 đến 45
--31.	* In ra danh sách 3 khách hàng có doanh số cao nhất (sắp xếp theo kiểu xếp hạng).
select TOP 3 MAKH, HOTEN
from KHACHHANG
order by DOANHSO DESC
--32.	Tính tổng số sản phẩm do “Trung Quoc” sản xuất.
select COUNT(DISTINCT MASP)
from SANPHAM
where NUOCSX = 'Trung Quoc'
--33.	Tính tổng số sản phẩm của từng nước sản xuất.
select NUOCSX, COUNT(DISTINCT MASP) as TONGSOSANPHAM
from SANPHAM
group by NUOCSX
--34.	Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
select NUOCSX, MAX(GIA) as MAX, MIN(GIA) as MIN, AVG(GIA) as AVG
from SANPHAM
group by NUOCSX
--35.	Tính doanh thu bán hàng mỗi ngày.
select NGHD, SUM(TRIGIA) as DOANHTHU
from HOADON
group by NGHD
--36.	Tính tổng số lượng của từng sản phẩm bán ra Trong tháng 10/2006.
select MASP, SUM(SL) as SOLUONG
from CTHD C INNER JOIN HOADON H
ON C.SOHD = H.SOHD
where MONTH(NGHD) = 10 AND YEAR(NGHD) = 2006
group by MASP
--37.	Tính doanh thu bán hàng của từng tháng Trong năm 2006.
select MONTH(NGHD) as THANG, SUM(TRIGIA) as DOANHTHU
from HOADON
where YEAR(NGHD) = 2006
group by MONTH(NGHD)
--38.	Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau.
select *
from HOADON
where SOHD IN(select SP.SOHD
			  from (select SOHD, COUNT(DISTINCT MASP) as SOSP
			  from CTHD
			  group by SOHD) as SP
			  where SP.SOSP >= 4)
--39.	Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất (3 sản phẩm khác nhau).
select *
from HOADON
where SOHD IN(select V.SOHD from(select SOHD, COUNT(DISTINCT C.MASP) as SOSP
								 from CTHD C INNER JOIN SANPHAM S
								 on C.MASP = S.MASP
								 where NUOCSX = 'Viet Nam'
								 group by SOHD) as V
								 where V.SOSP = 3)
--40.	Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất. 
select MAKH, HOTEN
from KHACHHANG
where MAKH = (select TOP 1 MAKH
from HOADON
group by MAKH
order by COUNT(DISTINCT SOHD) DESC)
--41.	Tháng mấy Trong năm 2006, doanh số bán hàng cao nhất ?
select TOP 1 MONTH(NGHD) as THANGDOANHSOCAONHAT
from HOADON
where YEAR(NGHD) = 2006
group by MONTH(NGHD)
order by SUM(TRIGIA) DESC
--42.	Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất Trong năm 2006.
select MASP, TENSP
from SANPHAM
where MASP = (select TOP 1 MASP
			  from CTHD
			  group by MASP
			  order by SUM(SL) ASC)
--43.	*Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất.
select N.NUOCSX, MASP, TENSP
from (select NUOCSX, MAX(GIA) as MAX
	  from SANPHAM
	  group by NUOCSX) as N INNER JOIN SANPHAM S 
ON S.GIA = N.MAX 
where N.NUOCSX = S.NUOCSX
--44.	Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau.
select NUOCSX
from (select NUOCSX, COUNT(DISTINCT GIA) as LOAIGIA
from SANPHAM
group by NUOCSX) as L
where L.LOAIGIA >= 3
--45.	*Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.
select *
from KHACHHANG
where MAKH = (select TOP 1 A.MAKH
from (select TOP 10 MAKH
	  from KHACHHANG
	  order by DOANHSO DESC) as A
	  INNER JOIN 
	  (select MAKH, COUNT(SOHD) as SL
	  from HOADON
	  group by MAKH) as B
ON A.MAKH = B.MAKH
order by SL DESC)
GO
-------------------------------------------------Tuan 5--------------------------------------------

-- I. Ngôn ngữ định nghĩa dữ liệu (Data Definition Language):
-- 11.	Ngày mua hàng (NGHD) của một khách hàng thành viên sẽ lớn hơn hoặc bằng ngày khách hàng đó đăng ký thành viên (NGDK).
create trigger TRG_HD_KH on HOADON for insert
AS
begin
	declare @NGHD smalldatetime, @NGDK smalldatetime, @MAKH char(4)
	select @NGHD = NGHD, @MAKH = MAKH from inserted
	select	@NGDK = NGDK from KHACHHANG where MAKH = @MAKH

	PRINT @NGHD 
	PRINT @NGDK

	if (@NGHD >= @NGDK)
		PRINT N'Thêm mới một hóa đơn thành công.'
	else
	begin
		PRINT N'Lỗi: Ngày mua hàng của một khách hàng thành viên sẽ lớn hơn hoặc bằng ngày khách hàng đó đăng ký thành viên.'
		ROLLBACK TRANSACTION
	end
end
GO
-- 12.	Ngày bán hàng (NGHD) của một nhân viên phải lớn hơn hoặc bằng ngày nhân viên đó vào làm.
create trigger TRG_HD_NV on HOADON for insert
AS
begin
	declare @NGHD smalldatetime, @NGVL smalldatetime, @MANV char(4)
	select @NGHD = NGHD, @MANV = MANV from inserted
	select	@NGVL = NGVL from NHANVIEN where MANV = @MANV

	if (@NGHD >= @NGVL)
		PRINT N'Thêm mới một hóa đơn thành công.'
	else
	begin
		PRINT N'Lỗi: Ngày bán hàng của một nhân viên phải lớn hơn hoặc bằng ngày nhân viên đó vào làm.'
		ROLLBACK TRANSACTION
	end
end
GO

-- 13.	Mỗi một hóa đơn phải có ít nhất một chi tiết hóa đơn.
create trigger TRG_HD_CTHD on HOADON for insert
AS
begin
	declare @SOHD INT, @COUNT_SOHD INT
	select @SOHD = SOHD from inserted
	select @COUNT_SOHD = COUNT(SOHD) from CTHD where SOHD = @SOHD

	if (@COUNT_SOHD >= 1)
		PRINT N'Thêm mới một hóa đơn thành công.'
	else
	begin
		PRINT N'Lỗi: Mỗi một hóa đơn phải có ít nhất một chi tiết hóa đơn.'
		ROLLBACK TRANSACTION
	end
end
GO

-- 14.	Trị giá của một hóa đơn là tổng thành tiền (số lượng*đơn giá) của các chi tiết thuộc hóa đơn đó.
create trigger TRG_CTHD on CTHD for insert, delete
AS
begin
	declare @SOHD INT, @TONGGIATRI INT

	select @TONGGIATRI = SUM(SL * GIA), @SOHD = SOHD 
	from inserted INNER JOIN SANPHAM
	ON inserted.MASP = SANPHAM.MASP
	group by SOHD

	update HOADON
	SET TRIGIA += @TONGGIATRI
	where SOHD = @SOHD
end
GO

create trigger TR_DEL_CTHD on CTHD for delete
AS
begin
	declare @SOHD INT, @GIATRI INT

	select @SOHD = SOHD, @GIATRI = SL * GIA 
	from deleted INNER JOIN SANPHAM 
	ON SANPHAM.MASP = deleted.MASP

	update HOADON
	SET TRIGIA -= @GIATRI
	where SOHD = @SOHD
end
GO

------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------


create database QuanLyGiaoVu
use QuanLyGiaoVu
create table HOCVIEN(
	MAHV char(5) primary key,
	HO varchar(40), 
	TEN varchar(10), 
	NGSINH smalldatetime,
	GIOITINH varchar(3),
	NOISINH varchar(40),
	MALOP char(3),
)
create table LOP(
	MALOP char(3) primary key,
	TENLOP varchar(40),
	TRGLOP char(5),
	SISO tinyint,
	MAGVCN char(4),
)
create table KHOA(
	MAKHOA varchar(4) primary key, 
	TENKHOA varchar(40), 
	NGTLAP smalldatetime, 
	TRGKHOA char(4),
)
create table MONHOC(
	MAMH varchar(10) primary key,
	TENMH varchar(40),
	TCLT tinyint,
	TCTH tinyint,
	MAKHOA varchar(4),
)
create table DIEUKIEN(
	MAMH varchar(10),
	MAMH_TRUOC varchar(10),
	primary key (MAMH, MAMH_TRUOC)
)
create table GIAOVIEN(
	MAGV char(4) primary key,
	HOTEN varchar(40),
	HOCVI varchar(10),
	HOCHAM varchar(10),
	GIOITINH varchar(3),
	NGSINH smalldatetime,
	NGVL smalldatetime,
	HESO numeric(4,2),
	MUCLUONG mONey,
	MAKHOA varchar(4),
)
create table GIANGDAY(
	MALOP char(3), 
	MAMH varchar(10), 
	MAGV char(4),
	HOCKY tinyint,
	NAM smallint,
	TUNGAY smalldatetime,
	DENNGAY smalldatetime,
	primary key (MALOP, MAMH)
)
create table KETQUATHI(
	MAHV char(5),
	MAMH varchar(10),
	LANTHI tinyint,
	NGTHI smalldatetime,
	DIEM numeric(4,2),
	KQUA varchar(10),
	primary key (MAHV, MAMH, LANTHI)
)
alter table HOCVIEN add cONstraint FK_MALOP foreign key (MALOP) references LOP(MALOP)
alter table LOP add cONstraint FK_TRGLOP foreign key (TRGLOP) references HOCVIEN(MAHV)
alter table LOP add cONstraint FK_MAGVCN foreign key (MAGVCN) references GIAOVIEN(MAGV)
alter table KHOA add cONstraint FK_TRGKHOA foreign key (TRGKHOA) references GIAOVIEN(MAGV)
alter table MONHOC add cONstraint FK_MAKHOA foreign key (MAKHOA) references KHOA(MAKHOA)
alter table DIEUKIEN add cONstraint FK_MAMH foreign key (MAMH) references MONHOC(MAMH)
alter table DIEUKIEN add cONstraint FK_MAMH_TRUOC foreign key (MAMH_TRUOC) references MONHOC(MAMH)
alter table GIAOVIEN add cONstraint FK_MAKHOA1 foreign key (MAKHOA) references KHOA(MAKHOA)
alter table GIANGDAY add cONstraint FK_MALOP1 foreign key (MALOP) references LOP(MALOP)
alter table GIANGDAY add cONstraint FK_MAMH1 foreign key (MAMH) references MONHOC(MAMH)
alter table GIANGDAY add cONstraint FK_MAGV foreign key (MAGV) references GIAOVIEN(MAGV)
alter table KETQUATHI add cONstraint FK_MAHV foreign key (MAHV) references HOCVIEN(MAHV)
alter table KETQUATHI add cONstraint FK_MAMH2 foreign key (MAMH) references MONHOC(MAMH)


--------------------------------------------- Tuan 1---------------------------------------------------


--1--Tạo quan hệ và khai báo tất cả các ràng buộc khóa chính, khóa ngoại. Thêm vào 3 thuộc tính GHICHU, DIEMTB, XEPLOAI cho quan hệ HOCVIEN.
alter table HOCVIEN add GHICHU char(20), DIEMTB float, XEPLOAI char(20)
--2--Mã học viên là một chuỗi 5 ký tự, 3 ký tự đầu là mã lớp, 2 ký tự cuối cùng là số thứ tự học viên Trong lớp. VD: “K1101”
alter table HOCVIEN add cONstraint check_MAHV check (left(MAHV, 3) = MALOP)
--3--Thuộc tính GIOITINH chỉ có giá trị là “Nam” hoặc “Nu”.
alter table HOCVIEN add cONstraint check_GIOITINH_HOCVIEN check (GIOITINH in ('Nam', 'Nu'))
alter table GIAOVIEN add cONstraint check_GIOITINH_GIAOVIEN check (GIOITINH in ('Nam', 'Nu'))
--4--Điểm số của một lần thi có giá trị từ 0 đến 10 và cần lưu đến 2 số lẽ (VD: 6.22).
alter table KETQUATHI add cONstraint check_DIEM check (0<=DIEM and DIEM<=10)
--5--Kết quả thi là “Dat” nếu điểm từ 5 đến 10 và “KhONg dat” nếu điểm nhỏ hơn 5.
update KETQUATHI set KQUA = 'KhONg dat' where DIEM<5
update KETQUATHI set KQUA = 'Dat ' where DIEM>= 5
--6--Học viên thi một môn tối đa 3 lần.
alter table KETQUATHI add cONstraint check_LANTHI check (LANTHI<= 3 AND LANTHI>= 1)
--7--Học kỳ chỉ có giá trị từ 1 đến 3.
alter table GIANGDAY add cONstraint check_HOCKY check (1<= HOCKY and HOCKY<=3)
--8--Học vị của giáo viên chỉ có thể là “CN”, “KS”, “Ths”, ”TS”, ”PTS”
alter table GIAOVIEN add cONstraint check_HOCVI check (HOCVI in ('CN', 'KS', 'Ths', 'TS', 'PTS'))


-------------------------------------------------Tuan 2--------------------------------------------


-- Bài tập 2 Sinh viên tiến hành viết câu lệnh nhập dữ liệu cho CSDL QuanLyGiaoVu.

-- Nhập dữ liệu --
set DATEforMAT DMY
delete from  KHOA
delete from MONHOC
delete from KETQUATHI
delete from DIEUKIEN
delete from GIANGDAY
delete from GIAOVIEN
delete from LOP
delete from HOCVIEN
alter table HOCVIEN nocheck cONstraint FK_MALOP
alter table LOP nocheck cONstraint FK_TRGLOP
alter table LOP nocheck cONstraint FK_MAGVCN
alter table KHOA nocheck cONstraint FK_TRGKHOA
alter table MONHOC nocheck cONstraint FK_MAKHOA
alter table DIEUKIEN nocheck cONstraint FK_MAMH
alter table DIEUKIEN nocheck cONstraint FK_MAMH_TRUOC
alter table GIAOVIEN nocheck cONstraint FK_MAKHOA1
alter table GIANGDAY nocheck cONstraint FK_MALOP1
alter table GIANGDAY nocheck cONstraint FK_MAMH1
alter table GIANGDAY nocheck cONstraint FK_MAGV
alter table KETQUATHI nocheck cONstraint FK_MAHV
alter table KETQUATHI nocheck cONstraint FK_MAMH2
---Khoa
insert into KHOA values('KHMT','Khoa hoc may tinh','7/6/2005','GV01')
insert into KHOA values('HTTT','He thONg thONg tin','7/6/2005','GV02')
insert into KHOA values('CNPM','CONg nghe phan mem','7/6/2005','GV04')
insert into KHOA values('MTT','Mang va truyen thONg','20/10/2005','GV03')
insert into KHOA values('KTMT','Ky thuat may tinh','20/12/2005','')

--Giao vien

insert into GIAOVIEN values('GV01','Ho Thanh SON','PTS','GS','Nam','2/5/1950','11/1/2004',5.00,2250000,'KHMT')
insert into GIAOVIEN values('GV02','Tran Tam Thanh','TS','PGS','Nam','17/12/1965','20/4/2004',4.50,2025000,'HTTT')
insert into GIAOVIEN values('GV03','Do Nghiem Phung','TS','GS','Nu','1/8/1950','23/9/2004',4.00,1800000,'CNPM')
insert into GIAOVIEN values('GV04','Tran Nam SON','TS','PGS','Nam','22/2/1961','12/1/2005',4.50,2025000,'KTMT')
insert into GIAOVIEN values('GV05','Mai Thanh Danh','ThS','GV','Nam','12/3/1958','12/1/2005',3.00,1350000,'HTTT')
insert into GIAOVIEN values('GV06','Tran Doan Hung','TS','GV','Nam','11/3/1953','12/1/2005',4.50,2025000,'KHMT')
insert into GIAOVIEN values('GV07','Nguyen Minh Tien','ThS','GV','Nam','23/11/1971','1/3/2005',4.00,1800000,'KHMT')
insert into GIAOVIEN values('GV08','Le Thi Tran','KS','','Nu','26/3/1974','1/3/2005',1.69,760500,'KHMT')
insert into GIAOVIEN values('GV09','Nguyen To Lan','ThS','GV','Nu','31/12/1966','1/3/2005',4.00,1800000,'HTTT')
insert into GIAOVIEN values('GV10','Le Tran Anh Loan','KS','','Nu','17/7/1972','1/3/2005',1.86,837000,'CNPM')
insert into GIAOVIEN values('GV11','Ho Thanh Tung','CN','GV','Nam','12/1/1980','15/5/2005',2.67,1201500,'MTT')
insert into GIAOVIEN values('GV12','Tran Van Anh','CN','','Nu','29/3/1981','15/5/2005',1.69,760500,'CNPM')
insert into GIAOVIEN values('GV13','Nguyen Linh Dan','CN','','Nu','23/5/1980','15/5/2005',1.69,760500,'KTMT')
insert into GIAOVIEN values('GV14','TruONg Minh Chau','ThS','GV','Nu','30/11/1976','15/5/2005',3.00,1350000,'MTT')
insert into GIAOVIEN values('GV15','Le Ha Thanh','ThS','GV','Nam','4/5/1978','15/5/2005',3.00,1350000,'KHMT')


--MON hoc
insert into MONHOC values('THDC','Tin hoc dai cuONg',4,1,'KHMT')
insert into MONHOC values('CTRR','Cau truc roi rac',5,0,'KHMT')
insert into MONHOC values('CSDL','Co so du lieu',3,1,'HTTT')
insert into MONHOC values('CTDLGT','Cau truc du lieu va giai thuat',3,1,'KHMT')
insert into MONHOC values('PTTKTT','Phan tich thiet ke thuat toan',3,0,'KHMT')
insert into MONHOC values('DHMT','Do hoa may tinh',3,1,'KHMT')
insert into MONHOC values('KTMT','Kien truc may tinh',3,0,'KTMT')
insert into MONHOC values('TKCSDL','Thiet ke co so du lieu',3,1,'HTTT')
insert into MONHOC values('PTTKHTTT','Phan tich thiet ke he thONg thONg tin',4,1,'HTTT')
insert into MONHOC values('HDH','He dieu hanh',4,0,'KTMT')
insert into MONHOC values('NMCNPM','Nhap mON cONg nghe phan mem',3,0,'CNPM')
insert into MONHOC values('LTCFW','Lap trinh C for win',3,1,'CNPM')
insert into MONHOC values('LTHDT','Lap trinh huONg doi tuONg',3,1,'CNPM')

--Lop
insert into LOP values('K11','Lop 1 khoa 1','K1108',11,'GV07')
insert into LOP values('K12','Lop 2 khoa 1','K1205',12,'GV09')
insert into LOP values('K13','Lop 3 khoa 1','K1305',12,'GV14')

alter table HOCVIEN
DROP COLUMN GHICHU
GO
alter table HOCVIEN
DROP COLUMN DIEMTB	
GO
alter table HOCVIEN
DROP COLUMN XEPLOAI	
GO
--Hoc vien
insert into HOCVIEN values('K1101','Nguyen Van','A','27/1/1986','Nam','TpHCM','K11')
insert into HOCVIEN values('K1102','Tran Ngoc','Han','14/3/1986','Nu','Kien Giang','K11')
insert into HOCVIEN values('K1103','Ha Duy','Lap','18/4/1986','Nam','Nghe An','K11')
insert into HOCVIEN values('K1104','Tran Ngoc','Linh','30/3/1986','Nu','Tay Ninh','K11')
insert into HOCVIEN values('K1105','Tran Minh','LONg','27/2/1986','Nam','TpHCM','K11')
insert into HOCVIEN values('K1106','Le Nhat','Minh','24/1/1986','Nam','TpHCM','K11')
insert into HOCVIEN values('K1107','Nguyen Nhu','Nhut','27/1/1986','Nam','Ha Noi','K11')
insert into HOCVIEN values('K1108','Nguyen Manh','Tam','27/2/1986','Nam','Kien Giang','K11')
insert into HOCVIEN values('K1109','Phan Thi Thanh','Tam','27/1/1986','Nu','Vinh LONg','K11')
insert into HOCVIEN values('K1110','Le Hoai','ThuONg','5/2/1986','Nu','Can Tho','K11')
insert into HOCVIEN values('K1111','Le Ha','Vinh','25/12/1986','Nam','Vinh LONg','K11')
insert into HOCVIEN values('K1201','Nguyen Van','B','11/2/1986','Nam','TpHCM','K12')
insert into HOCVIEN values('K1202','Nguyen Thi Kim','Duyen','18/1/1986','Nu','TpHCM','K12')
insert into HOCVIEN values('K1203','Tran Thi Kim','Duyen','17/9/1986','Nu','TpHCM','K12')
insert into HOCVIEN values('K1204','TruONg My','Hanh','19/5/1986','Nu','DONg Nai','K12')
insert into HOCVIEN values('K1205','Nguyen Thanh','Nam','17/4/1986','Nam','TpHCM','K12')
insert into HOCVIEN values('K1206','Nguyen Thi Truc','Thanh','4/3/1986','Nu','Kien Giang','K12')
insert into HOCVIEN values('K1207','Tran Thi Bich','Thuy','8/2/1986','Nu','Nghe An','K12')
insert into HOCVIEN values('K1208','Huynh Thi Kim','Trieu','8/4/1986','Nu','Tay Ninh','K12')
insert into HOCVIEN values('K1209','Pham Thanh','Trieu','23/2/1986','Nam','TpHCM','K12')
insert into HOCVIEN values('K1210','Ngo Thanh','Tuan','14/2/1986','Nam','TpHCM','K12')
insert into HOCVIEN values('K1211','Do Thi','Xuan','9/3/1986','Nu','Ha Noi','K12')
insert into HOCVIEN values('K1212','Le Thi Phi','Yen','12/3/1986','Nu','TpHCM','K12')
insert into HOCVIEN values('K1301','Nguyen Thi Kim','Cuc','9/6/1986','Nu','Kien Giang','K13')
insert into HOCVIEN values('K1302','TruONg Thi My','Hien','18/3/1986','Nu','Nghe An','K13')
insert into HOCVIEN values('K1303','Le Duc','Hien','21/3/1986','Nam','Tay Ninh','K13')
insert into HOCVIEN values('K1304','Le Quang','Hien','18/4/1986','Nam','TpHCM','K13')
insert into HOCVIEN values('K1305','Le Thi','HuONg','27/3/1986','Nu','TpHCM','K13')
insert into HOCVIEN values('K1306','Nguyen Thai','Huu','30/3/1986','Nam','Ha Noi','K13')
insert into HOCVIEN values('K1307','Tran Minh','Man','28/5/1986','Nam','TpHCM','K13')
insert into HOCVIEN values('K1308','Nguyen Hieu','Nghia','8/4/1986','Nam','Kien Giang','K13')
insert into HOCVIEN values('K1309','Nguyen Trung','Nghia','18/1/1987','Nam','Nghe An','K13')
insert into HOCVIEN values('K1310','Tran Thi HONg','Tham','22/4/1986','Nu','Tay Ninh','K13')
insert into HOCVIEN values('K1311','Tran Minh','Thuc','4/4/1986','Nam','TpHCM','K13')
insert into HOCVIEN values('K1312','Nguyen Thi Kim','Yen','7/9/1986','Nu','TpHCM','K13')

--Giang day
insert into GIANGDAY values('K11','THDC','GV07',1,2006,'2/1/2006','12/5/2006')
insert into GIANGDAY values('K12','THDC','GV06',1,2006,'2/1/2006','12/5/2006')
insert into GIANGDAY values('K13','THDC','GV15',1,2006,'2/1/2006','12/5/2006')
insert into GIANGDAY values('K11','CTRR','GV02',1,2006,'9/1/2006','17/5/2006')
insert into GIANGDAY values('K12','CTRR','GV02',1,2006,'9/1/2006','17/5/2006')
insert into GIANGDAY values('K13','CTRR','GV08',1,2006,'9/1/2006','17/5/2006')
insert into GIANGDAY values('K11','CSDL','GV05',2,2006,'1/6/2006','15/7/2006')
insert into GIANGDAY values('K12','CSDL','GV09',2,2006,'1/6/2006','15/7/2006')
insert into GIANGDAY values('K13','CTDLGT','GV15',2,2006,'1/6/2006','15/7/2006')
insert into GIANGDAY values('K13','CSDL','GV05',3,2006,'1/8/2006','15/12/2006')
insert into GIANGDAY values('K13','DHMT','GV07',3,2006,'1/8/2006','15/12/2006')
insert into GIANGDAY values('K11','CTDLGT','GV15',3,2006,'1/8/2006','15/12/2006')
insert into GIANGDAY values('K12','CTDLGT','GV15',3,2006,'1/8/2006','15/12/2006')
insert into GIANGDAY values('K11','HDH','GV04',1,2007,'2/1/2007','18/2/2007')
insert into GIANGDAY values('K12','HDH','GV04',1,2007,'2/1/2007','20/3/2007')
insert into GIANGDAY values('K11','DHMT','GV07',1,2007,'18/2/2007','20/3/2007')

--Dieu kien
insert into DIEUKIEN values('CSDL','CTRR')
insert into DIEUKIEN values('CSDL','CTDLGT')
insert into DIEUKIEN values('CTDLGT','THDC')
insert into DIEUKIEN values('PTTKTT','THDC')
insert into DIEUKIEN values('PTTKTT','CTDLGT')
insert into DIEUKIEN values('DHMT','THDC')
insert into DIEUKIEN values('LTHDT','THDC')
insert into DIEUKIEN values('PTTKHTTT','CSDL')

--Ket qua thi
insert into KETQUATHI values('K1101','CSDL',1,'20/7/2006',10.00,'Dat')
insert into KETQUATHI values('K1101','CTDLGT',1,'28/12/2006',9.00,'Dat')
insert into KETQUATHI values('K1101','THDC',1,'20/5/2006',9.00,'Dat')
insert into KETQUATHI values('K1101','CTRR',1,'13/5/2006',9.50,'Dat')
insert into KETQUATHI values('K1102','CSDL',1,'20/7/2006',4.00,'KhONg Dat')
insert into KETQUATHI values('K1102','CSDL',2,'27/7/2006',4.25,'KhONg Dat')
insert into KETQUATHI values('K1102','CSDL',3,'10/8/2006',4.50,'KhONg Dat')
insert into KETQUATHI values('K1102','CTDLGT',1,'28/12/2006',4.50,'KhONg Dat')
insert into KETQUATHI values('K1102','CTDLGT',2,'5/1/2007',4.00,'KhONg Dat')
insert into KETQUATHI values('K1102','CTDLGT',3,'15/1/2007',6.00,'Dat')
insert into KETQUATHI values('K1102','THDC',1,'20/5/2006',5.00,'Dat')
insert into KETQUATHI values('K1102','CTRR',1,'13/5/2006',7.00,'Dat')
insert into KETQUATHI values('K1103','CSDL',1,'20/7/2006',3.50,'KhONg Dat')
insert into KETQUATHI values('K1103','CSDL',2,'27/7/2006',8.25,'Dat')
insert into KETQUATHI values('K1103','CTDLGT',1,'28/12/2006',7.00,'Dat')
insert into KETQUATHI values('K1103','THDC',1,'20/5/2006',8.00,'Dat')
insert into KETQUATHI values('K1103','CTRR',1,'13/5/2006',6.50,'Dat')
insert into KETQUATHI values('K1104','CSDL',1,'20/7/2006',3.75,'KhONg Dat')
insert into KETQUATHI values('K1104','CTDLGT',1,'28/12/2006',4.00,'KhONg Dat')
insert into KETQUATHI values('K1104','THDC',1,'20/5/2006',4.00,'KhONg Dat')
insert into KETQUATHI values('K1104','CTRR',1,'13/5/2006',4.00,'KhONg Dat')
insert into KETQUATHI values('K1104','CTRR',2,'20/5/2006',3.50,'KhONg Dat')
insert into KETQUATHI values('K1104','CTRR',3,'30/6/2006',4.00,'KhONg Dat')
insert into KETQUATHI values('K1201','CSDL',1,'20/7/2006',6.00,'Dat')
insert into KETQUATHI values('K1201','CTDLGT',1,'28/12/2006',5.00,'Dat')
insert into KETQUATHI values('K1201','THDC',1,'20/5/2006',8.50,'Dat')
insert into KETQUATHI values('K1201','CTRR',1,'13/5/2006',9.00,'Dat')
insert into KETQUATHI values('K1202','CSDL',1,'20/7/2006',8.00,'Dat')
insert into KETQUATHI values('K1202','CTDLGT',1,'28/12/2006',4.00,'KhONg Dat')
insert into KETQUATHI values('K1202','CTDLGT',2,'5/1/2007',5.00,'Dat')
insert into KETQUATHI values('K1202','THDC',1,'20/5/2006',4.00,'KhONg Dat')
insert into KETQUATHI values('K1202','THDC',2,'27/5/2006',4.00,'KhONg Dat')
insert into KETQUATHI values('K1202','CTRR',1,'13/5/2006',3.00,'KhONg Dat')
insert into KETQUATHI values('K1202','CTRR',2,'20/5/2006',4.00,'KhONg Dat')
insert into KETQUATHI values('K1202','CTRR',3,'30/6/2006',6.25,'Dat')
insert into KETQUATHI values('K1203','CSDL',1,'20/7/2006',9.25,'Dat')
insert into KETQUATHI values('K1203','CTDLGT',1,'28/12/2006',9.50,'Dat')
insert into KETQUATHI values('K1203','THDC',1,'20/5/2006',10.00,'Dat')
insert into KETQUATHI values('K1203','CTRR',1,'13/5/2006',10.00,'Dat')
insert into KETQUATHI values('K1204','CSDL',1,'20/7/2006',8.50,'Dat')
insert into KETQUATHI values('K1204','CTDLGT',1,'28/12/2006',6.75,'Dat')
insert into KETQUATHI values('K1204','THDC',1,'20/5/2006',4.00,'KhONg Dat')
insert into KETQUATHI values('K1204','CTRR',1,'13/5/2006',6.00,'Dat')
insert into KETQUATHI values('K1301','CSDL',1,'20/12/2006',4.25,'KhONg Dat')
insert into KETQUATHI values('K1301','CTDLGT',1,'25/7/2006',8.00,'Dat')
insert into KETQUATHI values('K1301','THDC',1,'20/5/2006',7.75,'Dat')
insert into KETQUATHI values('K1301','CTRR',1,'13/5/2006',8.00,'Dat')
insert into KETQUATHI values('K1302','CSDL',1,'20/12/2006',6.75,'Dat')
insert into KETQUATHI values('K1302','CTDLGT',1,'25/7/2006',5.00,'Dat')
insert into KETQUATHI values('K1302','THDC',1,'20/5/2006',8.00,'Dat')
insert into KETQUATHI values('K1302','CTRR',1,'13/5/2006',8.50,'Dat')
insert into KETQUATHI values('K1303','CSDL',1,'20/12/2006',4.00,'KhONg Dat')
insert into KETQUATHI values('K1303','CTDLGT',1,'25/7/2006',4.50,'KhONg Dat')
insert into KETQUATHI values('K1303','CTDLGT',2,'7/8/2006',4.00,'KhONg Dat')
insert into KETQUATHI values('K1303','CTDLGT',3,'15/8/2006',4.25,'KhONg Dat')
insert into KETQUATHI values('K1303','THDC',1,'20/5/2006',4.50,'KhONg Dat')
insert into KETQUATHI values('K1303','CTRR',1,'13/5/2006',3.25,'KhONg Dat')
insert into KETQUATHI values('K1303','CTRR',2,'20/5/2006',5.00,'Dat')
insert into KETQUATHI values('K1304','CSDL',1,'20/12/2006',7.75,'Dat')
insert into KETQUATHI values('K1304','CTDLGT',1,'25/7/2006',9.75,'Dat')
insert into KETQUATHI values('K1304','THDC',1,'20/5/2006',5.50,'Dat')
insert into KETQUATHI values('K1304','CTRR',1,'13/5/2006',5.00,'Dat')
insert into KETQUATHI values('K1305','CSDL',1,'20/12/2006',9.25,'Dat')
insert into KETQUATHI values('K1305','CTDLGT',1,'25/7/2006',10.00,'Dat')
insert into KETQUATHI values('K1305','THDC',1,'20/5/2006',8.00,'Dat')
insert into KETQUATHI values('K1305','CTRR',1,'13/5/2006',10.00,'Dat')
-- check cONstraint again --
alter table HOCVIEN check cONstraint FK_MALOP
alter table LOP check cONstraint FK_TRGLOP
alter table LOP check cONstraint FK_MAGVCN
alter table KHOA check cONstraint FK_TRGKHOA
alter table MONHOC check cONstraint FK_MAKHOA
alter table DIEUKIEN check cONstraint FK_MAMH
alter table DIEUKIEN check cONstraint FK_MAMH_TRUOC
alter table GIAOVIEN check cONstraint FK_MAKHOA1
alter table GIANGDAY check cONstraint FK_MALOP1
alter table GIANGDAY check cONstraint FK_MAMH1
alter table GIANGDAY check cONstraint FK_MAGV
alter table KETQUATHI check cONstraint FK_MAHV
alter table KETQUATHI check cONstraint FK_MAMH2

-- Bài tập 3 Sinh viên hoàn thành Phần II bài tập QuanLyBanHang từ câu 2 đến câu 5.

--II--
--11-- Học viên ít nhất là 18 tuổi.
alter table HOCVIEN
add cONstraint DK_HOCVIEN check((GETDATE()-YEAR(NGSINH)) >=  18 )
--12-- Giảng dạy một môn học ngày bắt đầu (TUNGAY) phải nhỏ hơn ngày kết thúc (DENNGAY).
alter table GIANGDAY
add cONstraint DK_GIANGDAY check((DAY(TUNGAY) + MONTH(TUNGAY)*12 + YEAR(TUNGAY)*365) < (DAY(DENNGAY) + MONTH(DENNGAY)*12 + YEAR(DENNGAY)*365))
--13-- Giáo viên khi vào làm ít nhất là 22 tuổi.
alter table GIAOVIEN
add cONstraint DK_GIAOVIEN check((GETDATE() - YEAR(NGSINH)) >=  22)
--14-- Tất cả các môn học đều có số tín chỉ lý thuyết và tín chỉ thực hành chênh lệch nhau không quá 3.
alter table MONHOC 
add cONstraint DK_TINCHI_LTTH check((TCLT-TCTH) <=  3 )

-- Bài tập 6 Sinh viên hoàn thành Phần III bài tập QuanLyGiaoVu từ câu 1 đến câu 5.

--III--
--1-- In ra danh sách (mã học viên, họ tên, ngày sinh, mã lớp) lớp trưởng của các lớp.
select MAHV, HO, TEN, NGSINH, LOP.MALOP 
from LOP inner join HOCVIEN
ON HOCVIEN.MAHV = LOP.TRGLOP

--2-- In ra bảng điểm khi thi (mã học viên, họ tên , lần thi, điểm số) môn CTRR của lớp “K12”, sắp xếp theo tên, họ học viên.
select HV.MAHV, HO, TEN, LANTHI, DIEM
from KETQUATHI KQ inner join HOCVIEN HV
ON KQ.MAHV = HV.MAHV
where KQ.MAMH = 'CTRR' and HV.MALOP = 'K12'
order by TEN, HO DESC

--3-- In ra danh sách những học viên (mã học viên, họ tên) và những môn học mà học viên đó thi lần thứ nhất đã đạt
select HV.MAHV, HV.HO, HV.TEN, TENMH
from (KETQUATHI KQ inner join MONHOC MH
ON KQ.MAMH = MH.MAMH
) inner join HOCVIEN HV
ON  KQ.MAHV = HV.MAHV
where LANTHI = 1 and KQUA = 'Dat'

--4-- In ra danh sách học viên (mã học viên, họ tên) của lớp “K11” thi môn CTRR không đạt (ở lần thi 1).
select 	HV.MAHV, HO, TEN
from
	HOCVIEN HV inner join KETQUATHI KQ
ON
	HV.MAHV = KQ.MAHV
where	
	MALOP = 'K11'
	AND MAMH = 'CTRR'
	AND KQUA = 'KhONg Dat'
	AND LANTHI  = 1

--5-- * Danh sách học viên (mã học viên, họ tên) của lớp “K” thi môn CTRR không đạt (ở tất cả các lần thi).
select DISTINCT HV.MAHV, HO, TEN
from HOCVIEN HV inner join KETQUATHI KQ
ON	HV.MAHV = KQ.MAHV
where	
	MALOP like 'K%'
	AND MAMH = 'CTRR'
	AND NOT EXISTS
		(select MAHV from KETQUATHI
		where 
			KQUA = 'Dat' 
			AND MAMH = 'CTRR' 
			AND MaHV = HV.MAHV)

-------------------------------------------------Tuan 3--------------------------------------------

--Bài tập 2 Sinh viên hoàn thành Phần II bài tập QuanLyGiaoVu từ câu 1 đến câu 4. 
--1-- Tăng hệ số lương thêm 0.2 cho những giáo viên là trưởng khoa.
update GIAOVIEN
set HESO = HESO + 0.2
where MAGV IN (select TRGKHOA from KHOA)
--2-- Cập nhật giá trị điểm trung bình tất cả các môn học  (DIEMTB) của mỗi học viên (tất cả các môn học đều có hệ số 1 và nếu học viên thi một môn nhiều lần, chỉ lấy điểm của lần thi sau cùng).
update HOCVIEN
set DIEMTB = B.DIEMTB
from (
	select AVG(A.DIEM) as DIEMTB, MAHV
	from (select KQT.MAHV, DIEM, KQT.MAMH
	from KETQUATHI KQT inner join (select MAX(LANTHI) as MAX, MAHV, MAMH from KETQUATHI group by MAMH, MAHV) G
	ON KQT.MAHV = G.MAHV and KQT.LANTHI = G.MAX and KQT.MAMH = G.MAMH) as A
	group by A.MAHV
) as B
where HOCVIEN.MAHV = B.MAHV

select * from HOCVIEN
--3-- Cập nhật giá trị cho cột GHICHU là “Cam thi” đối với trường hợp: học viên có một môn bất kỳ thi lần thứ 3 dưới 5 điểm.
update HOCVIEN
set GHICHU = 'Cam thi'
where MAHV IN
(
	select MAHV 
	from KETQUATHI
	where LANTHI = 3 AND DIEM < 5
)
--4-- Cập nhật giá trị cho cột XEPLOAI Trong quan hệ HOCVIEN như sau:
--o	Nếu DIEMTB  9 thì XEPLOAI  = ”XS”
--o	Nếu  8  DIEMTB < 9 thì XEPLOAI = “G”
--o	Nếu  6.5  DIEMTB < 8 thì XEPLOAI = “K”
--o	Nếu  5    DIEMTB < 6.5 thì XEPLOAI = “TB”
--o	Nếu  DIEMTB < 5 thì XEPLOAI = ”Y”
update HOCVIEN
set XEPLOAI  = 
(
	CASE 
		WHEN DIEMTB >=  9 THEN 'XS'
		WHEN DIEMTB >=  8 AND DIEMTB < 9 THEN 'G'
		WHEN DIEMTB >=  6.5 AND DIEMTB < 8 THEN 'K'
		WHEN DIEMTB >=  5 AND DIEMTB < 6.5 THEN 'TB'
		WHEN DIEMTB < 5 THEN 'Y'
	end
)
--Bài tập 3 Sinh viên hoàn thành Phần III bài tập QuanLyGiaoVu từ câu 6 đến câu 10
--6-- Tìm tên những môn học mà giáo viên có tên “Tran Tam Thanh” dạy Trong học kỳ 1 năm 2006.
select DISTINCT TENMH 
from MONHOC,GIAOVIEN,GIANGDAY
where 
	MONHOC.MAMH = GIANGDAY.MAMH
AND 
	GIANGDAY.MAGV = GIAOVIEN.MAGV
AND 
	HOTEN = 'Tran Tam Thanh' AND HOCKY = 1 AND NAM = 2006

--7-- Tìm những môn học (mã môn học, tên môn học) mà giáo viên chủ nhiệm lớp “K11” dạy Trong học kỳ 1 năm 2006.
select DISTINCT MONHOC.MAMH,TENMH 
from MONHOC,GIANGDAY,LOP
where 
	GIANGDAY.MAMH = MONHOC.MAMH
AND 
	GIANGDAY.MAGV = LOP.MAGVCN
AND 
	GIANGDAY.MALOP = 'K11' 
AND 
	HOCKY = 1 AND NAM = 2006

--8-- Tìm họ tên lớp trưởng của các lớp mà giáo viên có tên “Nguyen To Lan” dạy môn “Co So Du Lieu”.
select DISTINCT (HO + TEN) HOTEN from LOP,GIANGDAY,MONHOC,HOCVIEN,GIAOVIEN
where 
	HOCVIEN.MAHV = LOP.TRGLOP
AND 
	GIANGDAY.MALOP = LOP.MALOP
AND 
	GIANGDAY.MAGV = GIAOVIEN.MAGV
AND 
	GIANGDAY.MAMH = MONHOC.MAMH
AND 
	GIAOVIEN.HOTEN = 'Nguyen To Lan' 
AND 
	MONHOC.TENMH = 'Co So Du Lieu'

--9-- In ra danh sách những môn học (mã môn học, tên môn học) phải học liền trước môn “Co So Du Lieu”.
select MONHOC.MAMH,MONHOC.TENMH from MONHOC,DIEUKIEN,MONHOC as MONHOCTRUOC
where 
	MONHOC.MAMH = DIEUKIEN.MAMH
AND 
	MONHOCTRUOC.MAMH = DIEUKIEN.MAMH_TRUOC
AND 
	MONHOCTRUOC.TENMH = 'Co So Du Lieu'

--10-- Môn “Cau Truc Roi Rac” là môn bắt buộc phải học liền trước những môn học (mã môn học, tên môn học) nào.
select MONHOC.MAMH,MONHOC.TENMH from MONHOC,MONHOC as MONHOCTRUOC,DIEUKIEN
where MONHOC.MAMH = DIEUKIEN.MAMH
AND MONHOCTRUOC.MAMH = DIEUKIEN.MAMH_TRUOC
AND MONHOCTRUOC.TENMH = 'Cau Truc Roi Rac'


-- BAI TAP 5.Sinh viên hoàn thành Phần III bài tập QuanLyGiaoVu từ câu 11 đến câu 18
--11-- Tìm họ tên giáo viên dạy môn CTRR cho cả hai lớp “K11” và “K12” Trong cùng học kỳ 1 năm 2006.
select HOTEN 
from 
	GIAOVIEN,GIANGDAY
where 
	GIAOVIEN.MAGV = GIANGDAY.MAGV
AND 
	MALOP = 'K11'
	AND HOCKY = 1 AND NAM = 2006
INTERSECT
	(select HOTEN 
	from 
		GIAOVIEN,GIANGDAY
	where
		GIAOVIEN.MAGV = GIANGDAY.MAGV
		AND MALOP = 'K12' AND HOCKY = 1 AND NAM = 2006)
--12-- Tìm những học viên (mã học viên, họ tên) thi không đạt môn CSDL ở lần thi thứ 1 nhưng chưa thi lại môn này.
select 
	(HO + TEN) HOTEN 
from 
	HOCVIEN,KETQUATHI
where
	HOCVIEN.MAHV = KETQUATHI.MAHV
AND
	MAMH = 'CSDL' AND LANTHI = 1 AND KQUA = 'KhONg Dat'
AND 
	NOT EXISTS (select * from KETQUATHI where LANTHI>1 AND KETQUATHI.MAHV = HOCVIEN.MAHV)

--13-- Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào.
select MAGV,HOTEN 
from GIAOVIEN
where 
	MAGV NOT IN (select MAGV from GIANGDAY)

--14-- Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào thuộc khoa giáo viên đó phụ trách.
select MAGV,HOTEN
from GIAOVIEN
where NOT EXISTS
(
	select *
	from MONHOC
	where MONHOC.MAKHOA = GIAOVIEN.MAKHOA
	AND NOT EXISTS
	(
		select *
		from GIANGDAY
		where GIANGDAY.MAMH = MONHOC.MAMH
		AND GIANGDAY.MAGV = GIAOVIEN.MAGV
	)
)
--15-- Tìm họ tên các học viên thuộc lớp “K11” thi một môn bất kỳ quá 3 lần vẫn “KhONg dat” hoặc thi lần thứ 2 môn CTRR được 5 điểm.
select DISTINCT
	(HO + TEN) HOTEN
from
	HOCVIEN,KETQUATHI
where 
	HOCVIEN.MAHV = KETQUATHI.MAHV
	AND MALOP = 'K11'
	AND ((LANTHI = 2 AND DIEM = 5)
	OR HOCVIEN.MAHV IN
	(
		select DISTINCT MAHV
		from KETQUATHI
		where KQUA = 'KhONg Dat'
		group by MAHV,MAMH 
		having COUNT (*) >3
	))
--16-- Tìm họ tên giáo viên dạy môn CTRR cho ít nhất hai lớp Trong cùng một học kỳ của một năm học.
select HOTEN
from 
	GIAOVIEN,GIANGDAY
where
	GIAOVIEN.MAGV = GIANGDAY.MAGV
	AND MAMH = 'CTRR'
group by 
	GIAOVIEN.MAGV,HOTEN,HOCKY
having 
	COUNT(*) >= 2
--17-- Danh sách học viên và điểm thi môn CSDL (chỉ lấy điểm của lần thi sau cùng).
select
	HocVien.*, Diem as 'Điểm thi CSDL sau cùng'
from
	HocVien, KetQuaThi
where
	HocVien.MaHV = KetQuaThi.MaHV
	AND MaMH = 'CSDL'
	AND LanThi = 
	(
		select MAX(LanThi) 
		from KetQuaThi 
		where MaMH = 'CSDL' AND KetQuaThi.MaHV = HocVien.MaHV 
		group by MaHV
	)
--18-- Danh sách học viên và điểm thi môn “Co So Du Lieu” (chỉ lấy điểm cao nhất của các lần thi)
select
	HocVien.*, Diem as 'Điểm thi CSDL cao nhất'
from
	HocVien, KetQuaThi, MONHoc
where
	HocVien.MaHV = KetQuaThi.MaHV
	AND KetQuaThi.MaMH = MONHoc.MaMH
	AND TenMH = 'Co So Du Lieu'
	AND Diem = 
	(
		select MAX(Diem) 
		from KetQuaThi, MONHoc
		where
			KetQuaThi.MaMH = MONHoc.MaMH
			AND MaHV = HocVien.MaHV
			AND TenMH = 'Co So Du Lieu'
		group by MaHV
	)

-------------------------------------------------Tuan 4--------------------------------------------

--Bài tập 2: Sinh viên hoàn thành Phần III bài tập QuanLyGiaoVu từ câu 19 đến câu 25
USE QuanLyGiaoVu
--19-- Khoa nào (mã khoa, tên khoa) được thành lập sớm nhất
select DISTINCT TOP 1 MAKHOA, TENKHOA, NGTLAP 
from KHOA 
order by NGTLAP ASC
--20-- Có bao nhiêu giáo viên có học hàm là “GS” hoặc “PGS”.
select COUNT(HOCHAM) as SOGIAOVIEN
from GIAOVIEN
where HOCHAM = 'PGS' OR HOCHAM = 'GS'
--21-- Thống kê có bao nhiêu giáo viên có học vị là “CN”, “KS”, “Ths”, “TS”, “PTS” Trong mỗi khoa
select MAKHOA, COUNT(HOCVI) as SOGIAOVIEN
from GIAOVIEN
where HOCVI = 'CN' OR HOCVI = 'ThS' OR HOCVI = 'TS' OR HOCVI = 'PTS' OR HOCVI = 'KS'
group by MAKHOA
--22-- Mỗi môn học thống kê số lượng học viên theo kết quả (đạt và không đạt)
select D.MAMH, D.SOLUONGDAT, KD.SOLUONGKHONGDAT
from (select MAMH, COUNT(KQUA) as SOLUONGDAT
from KETQUATHI
where KQUA = 'Dat'
group by MAMH) as D
INNER JOIN (select MAMH, COUNT(KQUA) as SOLUONGKHONGDAT
from KETQUATHI
where KQUA = 'KhONg Dat'
group by MAMH) as KD
ON D.MAMH = KD.MAMH
--23-- Tìm giáo viên (mã giáo viên, họ tên) là giáo viên chủ nhiệm của một lớp, đồng thời dạy cho lớp đó ít nhất một môn học.
select MAGV, HOTEN
from GIAOVIEN
where MAGV IN(select G.MAGV as MAGV
			  from LOP L INNER JOIN GIANGDAY G
			  on L.MALOP = G.MALOP
			  where L.MAGVCN = G.MAGV
			  group by MAGV)
--24-- Tìm họ tên lớp trưởng của lớp có sỉ số cao nhất.
select HO, TEN
from HOCVIEN
where MAHV IN (select TOP 1  TRGLOP as MAHV from LOP order by SISO DESC)
--25-- * Tìm họ tên những LOPTRG thi không đạt quá 3 môn (mỗi môn đều thi không đạt ở tất cả các lần thi).
select HO, TEN
from (select MAHV, HO, TEN
	  from LOP LEFT JOIN HOCVIEN
	  on LOP.TRGLOP = HOCVIEN.MAHV) as LOPTRUONG
INNER JOIN
	  (select K.MAHV, COUNT(DISTINCT K.MAMH ) as SOMON 
	   from (select MAHV, MAMH, MAX(LANTHI) as MAX
			from KETQUATHI
			group by MAHV, MAMH) as DEM_MAX
	   RIGHT JOIN
			KETQUATHI as K
	   on DEM_MAX.MAHV = K.MAHV AND DEM_MAX.MAMH = K.MAMH
	   where KQUA = 'KhONg Dat' AND DEM_MAX.MAX = K.LANTHI
	   group by K.MAHV) as MON_K_D
ON LOPTRUONG.MAHV = MON_K_D.MAHV
where MON_K_D.SOMON >= 3
--Bài tập 4: Sinh viên hoàn thành Phần III bài tập QuanLyGiaoVu từ câu 26 đến câu 35.
--26-- Tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
select H.MAHV, HO, TEN
from HOCVIEN H
INNER JOIN
(select TOP 1 MAHV, COUNT(DIEM) as SODIEM
from KETQUATHI
where DIEM BETWEEN 9 AND 10
group by MAHV
order by COUNT(DIEM) DESC) as K
ON H.MAHV = K.MAHV
--27-- Trong từng lớp, tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
select HV.MAHV, (HO +' '+ TEN) HOTEN from 
(HOCVIEN HV inner join (select MAHV, count(Diem) as SL
						from KETQUATHI
						where Diem >= 9 
						group by MAHV) A
						on HV.MAHV = A.MAHV)  inner join (select HV.MALOP, MAX(SL) as MAX from (select MAHV, count(Diem) as SL
						from KETQUATHI
						where Diem >= 9 
						group by MAHV) A, HOCVIEN HV
						where HV.MAHV = A.MAHV group by MALOP) B
on HV.MALOP = B.MALOP
where B.MAX = A.SL
--28-- Trong từng học kỳ của từng năm, mỗi giáo viên phân công dạy bao nhiêu môn học, bao nhiêu lớp.
select NAM, HOCKY, MAGV, COUNT(DISTINCT MAMH) as SOMON, COUNT(MALOP) as SOLOP
from GIANGDAY
group by NAM, HOCKY, MAGV
--29-- Trong từng học kỳ của từng năm, tìm giáo viên (mã giáo viên, họ tên) giảng dạy nhiều nhất.
select LOC1.NAM, LOC1.HOCKY, LOC1.MAGV, HOTEN
from
(select NAM, HOCKY, M.MAGV, HOTEN, SOLOP
from
GIAOVIEN G
INNER JOIN
(select NAM, HOCKY, MAGV, COUNT(DISTINCT MAMH) as SOMON, COUNT(DISTINCT MALOP) as SOLOP
from GIANGDAY
group by NAM, HOCKY, MAGV) M
ON G.MAGV = M.MAGV) as LOC1
RIGHT JOIN
(select NAM, HOCKY, MAX(SOLOP) as SOLOP
from
(select NAM, HOCKY, MAGV, COUNT(DISTINCT MAMH) as SOMON, COUNT(DISTINCT MALOP) as SOLOP
from GIANGDAY
group by NAM, HOCKY, MAGV) as LOC
group by NAM, HOCKY
) as LOC2
ON LOC1.NAM = LOC2.NAM AND LOC1.HOCKY = LOC2.HOCKY AND LOC1.SOLOP = LOC2.SOLOP
--30-- Tìm môn học (mã môn học, tên môn học) có nhiều học viên thi không đạt (ở lần thi thứ 1) nhất.
select M.MAMH, TENMH
from MONHOC M
INNER JOIN
(select TOP 1 MAMH, COUNT(KQUA) as SOKQKD
from KETQUATHI
where LANTHI = 1 AND KQUA = 'KhONg Dat'
group by MAMH
order by COUNT(KQUA) DESC) as KQ
ON M.MAMH = KQ.MAMH
--31-- Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi thứ 1).
select Z1.MAHV, HO, TEN
from
(select H.MAHV, HO, TEN, X1.SOLANDAT
from HOCVIEN H
INNER JOIN
(select MAHV, COUNT(KQUA) as SOLANDAT
from KETQUATHI
where KQUA = 'Dat' AND LANTHI = 1
group by MAHV) X1
ON H.MAHV = X1.MAHV) Z1
INNER JOIN
(select MAHV, COUNT(MAMH) as SOLANTHI
from KETQUATHI
where LANTHI = 1
group by MAHV) X2
ON Z1.MAHV = X2.MAHV
where Z1.SOLANDAT = X2.SOLANTHI
--32-- * Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi sau cùng).
select C.MAHV, HO + ' ' + TEN HOTEN from (
	select MAHV, COUNT(KQUA) SODAT from KETQUATHI A
	where NOT EXISTS (
		select 1 
		from KETQUATHI B 
		where A.MAHV = B.MAHV AND A.MAMH = B.MAMH AND A.LANTHI < B.LANTHI
	) AND KQUA = 'Dat'
	group by MAHV
	INTERSECT
	select MAHV, COUNT(MAMH) SOMH from KETQUATHI 
	where LANTHI = 1
	group by MAHV
) C INNER JOIN HOCVIEN HV
ON C.MAHV = HV.MAHV
--33-- * Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn đều đạt (chỉ xét lần thi thứ 1).
select A.MAHV, HO + ' ' + TEN HOTEN from (
	select MAHV, COUNT(KQUA) SODAT from KETQUATHI 
	where LANTHI = 1 AND KQUA = 'Dat'
	group by MAHV
	INTERSECT
	select MAHV, COUNT(MAMH) SOMH from KETQUATHI 
	where LANTHI = 1
	group by MAHV
) A INNER JOIN HOCVIEN HV
ON A.MAHV = HV.MAHV
--34-- * Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn đều đạt (chỉ xét lần thi sau cùng).
select C.MAHV, HO + ' ' + TEN HOTEN from (
	select MAHV, COUNT(KQUA) SODAT from KETQUATHI A
	where NOT EXISTS (
		select 1 from KETQUATHI B 
		where A.MAHV = B.MAHV AND A.MAMH = B.MAMH AND A.LANTHI < B.LANTHI
	) AND KQUA = 'Dat'
	group by MAHV
	INTERSECT
	select MAHV, COUNT(MAMH) SOMH from KETQUATHI 
	where LANTHI = 1
	group by MAHV
) C INNER JOIN HOCVIEN HV
ON C.MAHV = HV.MAHV
--35-- ** Tìm học viên (mã học viên, họ tên) có điểm thi cao nhất Trong từng môn (lấy điểm ở lần thi sau cùng).
select HOCVIEN.MAHV, (HO + ' ' + TEN) HOTEN, KETQUATHI.MAMH
from KETQUATHI,
(select MAX(DIEM) as MAXDIEM, MAMH
from KETQUATHI
group by MAMH) as A, HOCVIEN
where KETQUATHI.DIEM = A.MAXDIEM and KETQUATHI.MAMH = A.MAMH and KETQUATHI.MAHV = HOCVIEN.MAHV
GO

---------------------------------------------------Tuan 5-------------------------------------------

--9. Lớp trưởng của một lớp phải là học viên của lớp đó.
create trigger CHECK_LTRG ON LOP
for update, insert
AS
begin
	declare @MALOP CHAR(3), @TRGLOP CHAR(5), @MAHV CHAR(5)
	select @MALOP = MALOP, @TRGLOP = TRGLOP
	from inserted
	select @MAHV = MAHV
	from HOCVIEN
	where @MALOP = MALOP
	if (@TRGLOP <> @MAHV)
	begin
		PRINT 'LOP TRUONG PHAI LA HOC VIEN CUA LOP'
		ROLLBACK TRANSACTION
	end
end
GO
--10. Trưởng khoa phải là giáo viên thuộc khoa và có học vị “TS” hoặc “PTS”.
create trigger CHECK_TRGK ON KHOA
for update, insert
AS
begin
	declare @MAKHOA VARCHAR(4),@TRGKHOA CHAR(4), @MAGV CHAR(4), @HOCVI VARCHAR(10)
	select @MAKHOA = MAKHOA, @TRGKHOA = TRGKHOA
	from inserted
	select @MAGV = MAGV, @HOCVI = HOCVI
	from GIAOVIEN GV
	where GV.MAKHOA = @MAKHOA
	if (@TRGKHOA <> @MAGV OR @HOCVI <> 'TS' OR @HOCVI <> 'PTS' )
	begin
		PRINT 'TRGKHOA PHAI LA GIAO VIEN THUOC KHOA'
		ROLLBACK TRANSACTION
	end
end
go
--15. Học viên chỉ được thi một môn học nào đó khi lớp của học viên đã học xong môn học này.


--16. Mỗi học kỳ của một năm học, một lớp chỉ được học tối đa 3 môn. --
create trigger TRG_QLGV_P1_C16 ON GIANGDAY
for insert, update
AS
begin
    declare @Nam smallint, @HocKy tinyint, @check int, @stoploop int

    -- Tạo 1 cursor để kiểm từng học kỳ, năm học được sửa (inserted) xem có bị phạm không --
    declare giangdayCursor CURSOR
    for select DISTINCT HOCKY, NAM from inserted

    open giangdayCursor
        fetch next from giangdayCursor INTO @HocKy, @Nam
        select @stoploop = 0

        -- Duyệt kiểm tra từng học kỳ, năm học --
        while @@FETCH_STATUS = 0 AND @stoploop = 0
        begin
            -- Chọn lớp học nhiều môn nhất trong học kì đó --
            select @check = MAX(SL_MH)
            from
            (
                -- Bảng chứa số lượng môn học của mỗi lớp trong học kỳ đó --
                select COUNT(MAMH) SL_MH
                from GIANGDAY
                where HOCKY = @HocKy AND NAM = @Nam
                group by MALOP
            ) as A

            -- Nếu lớp học nhiều môn nhất học ký đó mà cao hơn 3 thì vi phạm --
            if @check > 3
            begin
                PRINT 'Loi: Moi hoc ky cua nam hoc, mot lop chi duoc hoc toi da 3 mon.'
                ROLLBACK TRANSACTION
                select @stoploop = 1
            end

            fetch next from giangdayCursor INTO @HocKy, @Nam
        end
    close giangdayCursor
    deallocate giangdayCursor
end
GO

--17. Sỉ số của một lớp bằng với số lượng học viên thuộc lớp đó. --
create trigger TRG_QLGV_P1_C17 ON HOCVIEN
for insert, update, DELETE
AS
begin
    declare @MaLop char(3), @SiSo tinyint

    declare hocvienCursor CURSOR
    for (select DISTINCT MALOP from inserted UNION select DISTINCT MALOP from DELETED)

    open hocvienCursor
        fetch next from hocvienCursor INTO @MaLop

        -- Cho mỗi lớp có học viên được sửa, tìm sỉ số mới của lớp đó --
        while @@FETCH_STATUS = 0
        begin
            select @SiSo = COUNT(MAHV)
            from HOCVIEN
            where MALOP = @MaLop

            -- update lại sỉ số mới cho lớp đó --
            update LOP
            SET SISO = @SiSo
            where MALOP = @MaLop

            fetch next from hocvienCursor INTO @MaLop
        end
    close hocvienCursor
    deallocate hocvienCursor
end
GO

--18. Trong quan hệ DIEUKIEN giá trị của thuộc tính MAMH và MAMH_TRUOC trong cùng một bộ không được giống nhau (“A”,”A”) và cũng không tồn tại hai bộ (“A”,”B”) và (“B”,”A”). --
create trigger TRG_QLGV_P1_C18 ON DIEUKIEN
for insert, update
AS
begin
    declare @MaMH varchar(10), @MaMH_Truoc varchar(10), @check varchar(10), @stoploop int

    -- Tạo cursor để kiểm tra từng dòng vừa được sửa --
    declare dieukienCursor CURSOR
    for select DISTINCT MAMH, MAMH_TRUOC from inserted

    open dieukienCursor
        fetch next from dieukienCursor INTO @MaMH, @MaMH_Truoc
        select @stoploop = 0

        while @@FETCH_STATUS = 0 AND @stoploop = 0
        begin
            select @check = MAMH
            from DIEUKIEN
            where MAMH = @MaMH_Truoc AND MAMH_TRUOC = @MaMH

            if @check IS NOT NULL OR @MaMH = @MaMH_Truoc
            begin
                PRINT 'Loi: MAMH va MAMH_TRUOC khong duoc trung nhau, khong duoc ton tai 2 bo (A, B) va (B, A).'
                ROLLBACK TRANSACTION
                select @stoploop = 1
            end

            fetch next from dieukienCursor INTO @MaMH, @MaMH_Truoc
        end
    close dieukienCursor
    deallocate dieukienCursor
end
GO


--19. Các giáo viên có cùng học vị, học hàm, hệ số lương thì mức lương bằng nhau. --
create trigger TRG_QLGV_P1_C19 ON GIAOVIEN
for insert, update
AS
begin
    declare @MaGV char(4), @HocVi varchar(10), @HocHam varchar(10), @HeSo numeric(4, 2), @MucLuong money, @check money, @stoploop int

    declare giaovienCursor CURSOR
    for select DISTINCT MAGV, HOCVI, HOCHAM, HESO, MUCLUONG from inserted

    open giaovienCursor
        fetch next from giaovienCursor INTO @MaGV, @HocVi, @HocHam, @HeSo, @MucLuong
        select @stoploop = 0

        while @@FETCH_STATUS = 0 AND @stoploop = 0
        begin
            select @check =
            (
                select DISTINCT MUCLUONG
                from GIAOVIEN
                where HOCVI = @HocVi AND HOCHAM = @HocHam AND HESO = @HeSo AND MAGV <> @MaGV
            )

            if @check IS NOT NULL AND @check <> @MucLuong
            begin
                PRINT 'Loi: Cac giao vien co cung hoc vi, hoc ham, he so luong thi muc luong phai bang nhau.'
                ROLLBACK TRANSACTION
                select @stoploop = 1
            end

            fetch next from giaovienCursor INTO @MaGV, @HocVi, @HocHam, @HeSo, @MucLuong
        end
    close giaovienCursor
    deallocate giaovienCursor
end
GO

--20. Học viên chỉ được thi lại (lần thi > 1) khi điểm của lần thi trước đó dưới 5. --
create trigger TRG_QLGV_P1_C20 ON KETQUATHI
for insert, update
AS
begin
    declare @MaHV char(5), @MaMH varchar(10), @LanThi tinyint, @Diem_Truoc numeric(4, 2), @stoploop int

    declare ketquathiCursor CURSOR
    for select DISTINCT MAHV, MAMH, LANTHI from inserted

    open ketquathiCursor
        fetch next from ketquathiCursor INTO @MaHV, @MaMH, @LanThi
        select @stoploop = 0

        while @@FETCH_STATUS = 0 AND @stoploop = 0
        begin
            if @LanThi > 1
            begin
                select @Diem_Truoc = DIEM
                from KETQUATHI
                where MAHV = @MaHV AND MAMH = @MaMH AND LANTHI = @LanThi - 1

                if @Diem_Truoc >= 5
                begin
                    PRINT 'Loi: Hoc vien chi duoc thi lai neu diem lan thi truoc duoi 5.'
                    ROLLBACK TRANSACTION
                    select @stoploop = 1
                end
            end

            fetch next from ketquathiCursor INTO @MaHV, @MaMH, @LanThi
        end
    close ketquathiCursor
    deallocate ketquathiCursor
end
GO

--21. Ngày thi của lần thi sau phải lớn hơn ngày thi của lần thi trước (cùng học viên, cùng môn học). --
create trigger TRG_QLGV_P1_C21 ON KETQUATHI
for insert, update
AS
begin
    declare @MaHV char(5), @MaMH varchar(10), @LanThi tinyint, @NgThi datetime, @NgThi_Truoc datetime, @stoploop int

    declare ketquathiCursor CURSOR
    for select DISTINCT MAHV, MAMH, LANTHI, NGTHI from inserted

    open ketquathiCursor
        fetch next from ketquathiCursor INTO @MaHV, @MaMH, @LanThi, @NgThi
        select @stoploop = 0

        while @@FETCH_STATUS = 0 AND @stoploop = 0
        begin
            if @LanThi > 1
            begin
                select @NgThi_Truoc = NGTHI
                from KETQUATHI
                where MAHV = @MaHV AND MAMH = @MaMH AND LANTHI = @LanThi - 1

                if @NgThi <= @NgThi_Truoc
                begin
                    PRINT 'Loi: Ngay thi cua lan thi sau phai lon hon ngay thi cua lan thi truoc.'
                    ROLLBACK TRANSACTION
                    select @stoploop = 1
                end
            end

            fetch next from ketquathiCursor INTO @MaHV, @MaMH, @LanThi, @NgThi
        end
    close ketquathiCursor
    deallocate ketquathiCursor
end
GO

--22. Học viên chỉ được thi những môn mà lớp của học viên đó đã học xong. --
create trigger TRG_QLGV_P1_C22 ON KETQUATHI
for insert, update
AS
begin
    declare @MaHV char(5), @MaMH varchar(10), @NgThi datetime, @NgKetThuc datetime, @stoploop int

    declare ketquathiCursor CURSOR
    for select DISTINCT MAHV, MAMH, NGTHI from inserted

    open ketquathiCursor
        fetch next from ketquathiCursor INTO @MaHV, @MaMH, @NgThi
        select @stoploop = 0

        while @@FETCH_STATUS = 0 AND @stoploop = 0
        begin
            select @NgKetThuc = DENNGAY
            from GIANGDAY
            where MAMH = @MaMH AND MALOP = (select MALOP from HOCVIEN where MAHV = @MaHV)

            if @NgKetThuc >= @NgThi
            begin
                PRINT 'Loi: Hoc vien chi duoc thi nhung mon ma lop cua hoc vien da hoc xong.'
                ROLLBACK TRANSACTION
                select @stoploop = 1
            end

            fetch next from ketquathiCursor INTO @MaHV, @MaMH, @NgThi
        end
    close ketquathiCursor
    deallocate ketquathiCursor
end
GO