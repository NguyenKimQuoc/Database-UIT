/* Bài 1 */
/* Thêm vào thuộc tính GHICHU có kiểu dữ liệu varchar(20) cho quan hệ SANPHAM */
alter table SANPHAM add GHICHU varchar(20)
/* Thêm vào thuộc tính LOAIKH có kiểu dữ liệu là tinyint cho quan hệ KHACHHANG */
alter table KHACHHANG add LOAIKH tinyint
/* Sửa kiểu dữ liệu của thuộc tính GHICHU trong quan hệ SANPHAM thành varchar(100) */
alter table SANPHAM alter column GHICHU varchar(100)
/* Xóa thuộc tính GHICHU trong quan hệ SANPHAM */
alter table SANPHAM drop column GHICHU
/* Làm thế nào để thuộc tính LOAIKH trong quan hệ KHACHHANG có thể lưu các giá trị là: “Vang lai”, “Thuong xuyen”, “Vip”, …*/
alter table KHACHHANG alter column LOAIKH varchar(25)
/* Đơn vị tính của sản phẩm chỉ có thể là (“cay”,”hop”,”cai”,”quyen”,”chuc”) */
alter table SANPHAM add constraint SANPHAM_DVT check (DVT = 'cay' or DVT ='hop'or DVT = 'cai' or DVT = 'quyen' or DVT = 'chuc')
/* Giá bán của sản phẩm từ 500 đồng trở lên */
alter table SANPHAM add constraint SANPHAM_GIA check (GIA >= 500)
/* Mỗi lần mua hàng, khách hàng phải mua ít nhất 1 sản phẩm */
alter table CTHD add constraint CTHD_SL check (SL >= 1)
/* Ngày khách hàng đăng ký là khách hàng thành viên phải lớn hơn ngày sinh của người đó */
alter table KHACHHANG add constraint KHACHANG_NGDK check (NGDK > NGSINH)
/* Ngày mua hàng (NGHD) của một khách hàng thành viên sẽ lớn hơn hoặc bằng ngày khách hàng đó đăng ký thành viên (NGDK) */
alter table HOADON add constraint NGAYHD_NGDK check (HOADON.NGHD > KHACHHANG.NGDK)
/* Mỗi một hóa đơn phải có ít nhất một chi tiết hóa đơn */
alter table HOADON
/* Bài 2 */
/* Tạo quan hệ SANPHAM1 chứa toàn bộ dữ liệu của quan hệ SANPHAM. Tạo quan hệ KHACHHANG1 chứa toàn bộ dữ liệu của quan hệ KHACHHANG */
create table SANPHAM1(
	MASP char(4) primary key,
	TENSP varchar(40),
	DVT varchar(20),
	NUOCSX varchar(40),
	GIA money
)
create table KHACHHANG1 (
	MAKH char(4) primary key,
	HOTEN varchar(40),
	DCHI varchar(50),
	SODT varchar(20),
	NGSINH datetime,
	NGDK datetime,
	DOANHSO money,
	LOAIKH varchar(250)
)
insert into SANPHAM1 select *from SANPHAM
insert into KHACHHANG1 select *from KHACHHANG
/* Cập nhật giá tăng 5% đối với những sản phẩm do “Thai Lan” sản xuất (cho quan hệ SANPHAM1) */
update SANPHAM1 set GIA = GIA*1.05 where NUOCSX = 'Thai Lan'

/* Cập nhật giá giảm 5% đối với những sản phẩm do “Trung Quoc” sản xuất có giá từ 10.000 trở xuống (cho quan hệ SANPHAM1) */
update SANPHAM1 set GIA = GIA*0.95 where NUOCSX = 'Trung Quoc' and GIA <= 10000

/* Cập nhật giá trị LOAIKH là “Vip” đối với những khách hàng đăng ký thành viên trước ngày 1/1/2007 có doanh số từ 10.000.000 trở lên
hoặc khách hàng đăng ký thành viên từ 1/1/2007 trở về sau có doanh số từ 2.000.000 trở lên (cho quan hệ KHACHHANG1) */
update KHACHHANG1 set LOAIKH = 'Vip' where (NGDK < '01/01/2007' and DOANHSO >= 10000000)  or (NGDK >= '01/01/2007' and DOANHSO >= 2000000)