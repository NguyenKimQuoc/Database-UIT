/* Bài 3 */
/* 1.In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất */
select MASP, TENSP 
from SANPHAM 
where NUOCSX = 'Trung Quoc'

/* 2.In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cay”, ”quyen” */
select MASP, TENSP 
from SANPHAM 
where DVT = 'cay' or DVT = 'quyen'

/* 3.In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01” */
select MASP, TENSP 
from SANPHAM 
where MASP like 'B%01'

/* 4.In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 30.000 đến 40.000 */
select MASP, TENSP 
from SANPHAM 
where GIA between 30000 and 40000

/* 5.In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” hoặc “Thai Lan” sản xuất có giá từ 30.000 đến 40.000 */
select MASP, TENSP 
from SANPHAM 
where (NUOCSX = 'Trung Quoc' or NUOCSX = 'ThaiLan') and GIA between 30000 and 40000

/* 6.In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007 */
select SOHD, TRIGIA, NGHD 
from HOADON 
where NGHD in ('01/01/2007', '02/01/2007')

/* 7.In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần) */
select SOHD, TRIGIA 
from HOADON 
where month(NGHD) = 1 and year(NGHD) = 2007 order by NGHD ASC, TRIGIA DESC 

/* 8.In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007 */
select KHACHHANG.MAKH, HOTEN 
from (HOADON inner join KHACHHANG on KHACHHANG.MAKH = HOADON.MAKH)
where NGHD = '01/01/2007'

/* 9.In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyen Van B” lập trong ngày 28/10/2006 */
select SOHD, TRIGIA 
from (HOADON inner join NHANVIEN on HOADON.MANV = NHANVIEN.MANV) 
where (HOTEN = 'Nguyen Van B' and NGHD = '10/28/2006')

/* 10.In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua trong tháng 10/2006 */
select distinct MASP, TENSP 
from SANPHAM
where MASP in (
	select MASP 
	from (CTHD inner join HOADON on CTHD.SOHD = HOADON.SOHD) 
	where MAKH = 'KH01' and year(NGHD) = '2006' and month(NGHD) = '10')

/* 11. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02” */
select SOHD 
from CTHD 
where MASP in ('BB01', 'BB02')

/* 12. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20 */
select SOHD 
from CTHD 
where MASP in ('BB01', 'BB02') and (SL between 10 and 20)

/* 13. Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20 */
select SOHD
from CTHD 
where MASP = 'BB01' and (SL between 10 and 20) and SOHD in (
	select SOHD 
	from CTHD 
	where MASP = 'BB02' and SL between 10 and 20)

/* 14. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007 */
select distinct SANPHAM.MASP, TENSP 
from (SANPHAM full join CTHD on SANPHAM.MASP = CTHD.MASP) 
where NUOCSX = 'Trung Quoc' or CTHD.SOHD in (
	select SOHD 
	from HOADON 
	where NGHD = '01/01/2007')

/* 15. In ra danh sách các sản phẩm (MASP,TENSP) không bán được */
select distinct SANPHAM.MASP, TENSP
from SANPHAM
where MASP not in (
	select distinct MASP 
	from CTHD)

/* 16. In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006 */
select distinct SANPHAM.MASP, TENSP
from SANPHAM
where MASP not in (
	select distinct MASP 
	from (CTHD inner join HOADON on CTHD.SOHD = HOADON.SOHD) 
	where year(NGHD) = 2006)

/* 17. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được trong năm 2006 */
select MASP, TENSP
from SANPHAM
where NUOCSX = 'Trung Quoc' and MASP not in (
	select distinct MASP 
	from (CTHD inner join HOADON on CTHD.SOHD = HOADON.SOHD) 
	where year(NGHD) = 2006)

/* 18. Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất */
select H.SOHD
from HOADON H
where not exists (
	select*
	from SANPHAM S
	where NUOCSX = 'Singapore' and not exists (
		select*
		from CTHD C
		where S.MASP = C.MASP and C.SOHD = H.SOHD))

/* 19. Tìm số hóa đơn trong năm 2006 đã mua ít nhất tất cả các sản phẩm do Singapore sản xuất */
select H.SOHD
from HOADON H
where year(NGHD) = 2006 and not exists (
	select*
	from SANPHAM S
	where NUOCSX = 'Singapore' and not exists (
		select*
		from CTHD C
		where S.MASP = C.MASP and C.SOHD = H.SOHD))

/* 20. Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua */
select count(SOHD) as SL
from HOADON H
where H.MAKH not in (
	select MAKH 
	from KHACHHANG K 
	where H.MAKH = K.MAKH)

/* 21. Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006 */
select count(distinct MASP) as SL
from (HOADON inner join CTHD on HOADON.SOHD = CTHD.SOHD)
where year(NGHD) = 2006

/*22.  Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu? */
select max(TRIGIA) as MAX_TRIGIA, min(TRIGIA) as MON_TRIGIA
from HOADON

/* 23. Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu? */
select avg(TRIGIA) as TRUNG_BINH
from HOADON
where year(NGHD) = 2006

/* 24. Tính doanh thu bán hàng trong năm 2006 */
select sum(TRIGIA) as DOANH_THU
from HOADON
where year(NGHD) = 2006

/* 25. Tìm số hóa đơn có trị giá cao nhất trong năm 2006 */
select SOHD
from HOADON
where year(NGHD) = 2006 and TRIGIA = (select max(TRIGIA) from HOADON where year(NGHD) = 2006)

/* 26. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006 */
select HOTEN
from (HOADON H inner join KHACHHANG K on H.MAKH = K.MAKH)
where year(NGHD) = 2006 and TRIGIA = (select max(TRIGIA) from HOADON where year(NGHD) = 2006)

/* 27. In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất */
select top 3 MAKH, HOTEN
from KHACHHANG
order by DOANHSO desc

/* 28. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất */
select MASP, TENSP
from SANPHAM
where GIA in (
	select distinct top 3 GIA 
	from SANPHAM 
	order by GIA desc)

/* 29. In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm) */
select MASP, TENSP
from SANPHAM
where NUOCSX = 'Thai Lan' and GIA in (
	select distinct top 3 GIA
	from SANPHAM
	order by GIA desc)

/* 30. In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất) */
select MASP, TENSP
from SANPHAM
where NUOCSX = 'Trung Quoc' and GIA in (
	select distinct top 3 GIA
	from SANPHAM
	order by GIA desc)

/* 31. In ra danh sách 3 khách hàng có doanh số cao nhất (sắp xếp theo kiểu xếp hạng) */
select top 3 MAKH, HOTEN
from KHACHHANG
order by DOANHSO desc

/* 32. Tính tổng số sản phẩm do “Trung Quoc” sản xuất */
select count(distinct MASP) as SL
from SANPHAM
where NUOCSX = 'Trung Quoc'

/* 33. Tính tổng số sản phẩm của từng nước sản xuất */
select NUOCSX, count(distinct MASP) as SL
from SANPHAM
group by NUOCSX

/* 34. Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm */
select NUOCSX, max(distinct GIA) as MAX_GIA, min(distinct GIA) as MAX_GIA, avg(distinct GIA) as AVG_GIA
from SANPHAM
group by NUOCSX

/* 35. Tính doanh thu bán hàng mỗi ngày */
select NGHD, sum(TRIGIA) as DOANH_THU
from HOADON
group by NGHD

/* 36. Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006 */
select MASP, sum(SL) as SL_SP
from HOADON inner join CTHD on HOADON.SOHD = CTHD.SOHD
where month(NGHD) = 10 and year(NGHD) = 2006
group by MASP

/* 37. Tính doanh thu bán hàng của từng tháng trong năm 2006 */
select month(NGHD) as Month_of_2006, sum(TRIGIA) as DOANH_THU
from HOADON
where year(NGHD) = 2006
group by month(NGHD)

/* 38. Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau */
select *
from HOADON
where SOHD in (
	select HOADON.SOHD
	from (HOADON inner join CTHD on HOADON.SOHD = CTHD.SOHD)
	group by HOADON.SOHD
	having count(distinct MASP) >= 4)

/* 39. Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất (3 sản phẩm khác nhau) */
select *
from HOADON
where SOHD in (
	select SOHD
	from (SANPHAM S inner join CTHD C on S.MASP = C.MASP) 
	where NUOCSX = 'Viet Nam'
	group by SOHD
	having count(distinct S.MASP) >= 3)

/* 40. Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất */
select MAKH, HOTEN
from KHACHHANG
where MAKH in (
	select SL_HD_KH.MAKH 
	from (
		select H.MAKH, count(H.MAKH) as SL_HD
		from HOADON H
		group by H.MAKH) as SL_HD_KH
	where SL_HD = (
		select max(SL_HD_KH1.SL_HD1)
		from (
			select H.MAKH, count(H.MAKH) as SL_HD1
			from HOADON H
			group by H.MAKH) as SL_HD_KH1))

select MAKH, HOTEN
from KHACHHANG
where MAKH in (
	select MAKH 
	from HOADON
	group by MAKH
	having count(SOHD) in (
		select top 1 count (SOHD)
		from HOADON
		group by MAKH
		order by count(SOHD) desc))

/* 41. Tháng mấy trong năm 2006, doanh số bán hàng cao nhất ? */
select top 1 month(NGHD) as THANG_DOANHSO_MAX
from HOADON
where year(NGHD) = 2006
group by month(NGHD)
order by sum(TRIGIA) desc

/* 42. Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006 */
select MASP, TENSP
from SANPHAM
where MASP in (
	select MASP
	from (
		select top 1 MASP, sum(SL) as SL_SP
		from ((
			select SOHD, NGHD from HOADON) as H inner join CTHD C on H.SOHD = C.SOHD)
		where year(NGHD) = 2006
		group by MASP
		order by SL_SP asc) as A)

/* 43. *Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất */
select S.MASP, S.TENSP
from SANPHAM S, (select NUOCSX, max(GIA) as MAX_GIA
				from SANPHAM
				group by NUOCSX) as NUOCSX_MAXGIA
where  S.NUOCSX = NUOCSX_MAXGIA.NUOCSX and S.GIA = NUOCSX_MAXGIA.MAX_GIA

/* 44. Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau */
select A.NUOCSX
from (
	select NUOCSX, count(NUOCSX) as SL_SP_NUOCSX
	from SANPHAM
	group by NUOCSX) as A
where A.SL_SP_NUOCSX >= 3

/* 45. *Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất */
select *
from (
	select *
	from (
		select top 10 MAKH
		from KHACHHANG
		order by DOANHSO) as A
	where A.MAKH in (
		select top 1 MAKH
		from HOADON
		group by MAKH
		order by count(MAKH) desc)) as Q inner join KHACHHANG K on Q.MAKH = K.MAKH