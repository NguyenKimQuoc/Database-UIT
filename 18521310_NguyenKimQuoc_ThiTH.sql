--MSSV    : 18521310
--HOTEN   : Nguyễn Kim Quốc
--DE	  : 2
--NGAY THI: 6/1/2021

----------------------------------------------------------------------------------------------------------------------------
--<CAU 1>: 
select distinct MaNB, HoTen, DiaChi from NGUOI_BAN where MaNB in (
select MaNB from PHIEU_DANG_KY where MaPDK in (
select MaPDK from CT_PDK where YEAR(TuNgay) = '2006' and YEAR(DenNgay) = '2006' and MONTH(TuNgay) = '8' and MONTH(DenNgay) = '10'))

--</CAU 1>
----------------------------------------------------------------------------------------------------------------------------
--<CAU 2>:
select DIA_OC.MaDO, So, Duong, Phuong, Quan, SoNgayDangKiLauNhat from DIA_OC join
(select A.MaDO, MAX(SoNgay) as SoNgayDangKiLauNhat from (
select *,(DenNgay-TuNgay) as SoNgay from CT_PDK
where MaPDK in (
select MaPDK from PHIEU_DANG_KY where year(NgayDK) = '2006')) as A
group by MaDO) as B
on DIA_OC.MaDO = B.MaDO

--</CAU 2>
----------------------------------------------------------------------------------------------------------------------------
--<CAU 3>:
select * from PHIEU_DANG_KY join CT_PDK on PHIEU_DANG_KY.MaPDK = CT_PDK.MaPDK where exists
(select MaDV from DICH_VU where TienDV >= 200000) 
go
--</CAU 3>
----------------------------------------------------------------------------------------------------------------------------
--<CAU 4>:
-- BẢNG TẦM ẢNH HƯỞNG --
--					THÊM			XÓA			SỬA
--CT_PDK			-				-			+(DenNgay)
--PHIEU_GIA_HAN		+(TuNgay)		-			+(TuNgay)
create trigger trg_ct_giahan on PHIEU_GIA_HAN
for insert
as begin
	declare @MaPDK char(10), @MaDO char(9), @TuNgay datetime, @DenNgay datetime
	select @MaDO = MaDO, @MaPDK = MAPDK, @TuNgay = TuNgay from inserted
	select @DenNgay = DenNgay from CT_PDK where  @MaDO = MaDO and @MaPDK = MAPDK
	if (@DenNgay >= @TuNgay)
		begin
			print 'ERROR!!!'
			rollback transaction
		end
	else
		print 'Success!!'
end
--</CAU 4>
