use QLGV

/* 1. Thêm vào 3 thuộc tính GHICHU, DIEMTB, XEPLOAI cho quan hệ HOCVIEN */
alter table HOCVIEN add DIEMTB numeric(4,2), XEPLOAI nvarchar(10), GHICHU nvarchar(50)

/* 2. Mã học viên là một chuỗi 5 ký tự, 3 ký tự đầu là mã lớp, 2 ký tự cuối cùng là số thứ tự học viên trong lớp. VD: “K1101” */

/* 3. Thuộc tính GIOITINH chỉ có giá trị là “Nam” hoặc “Nu” */
alter table HOCVIEN add constraint Check_GT check (GIOITINH = 'Nam' or GIOITINH = 'Nu')

/* 4. Điểm số của một lần thi có giá trị từ 0 đến 10 và cần lưu đến 2 số lẽ (VD: 6.22) */
-- CAST(bieuthuc AS kieudulieu [(do_dai)]): Chuyuyển kiểu dữ liệu --
-- RIGHT(chuoi, so_ky_tu): Trích xuất 1 chuỗi con từ 1 chuỗi lớn --
alter table KETQUATHI add constraint Check_DIEMTHI check (DIEM >= 0 and DIEM <= 10 and right(CAST(DIEM as varchar), 4) like '_.__')

/* 5. Kết quả thi là “Dat” nếu điểm từ 5 đến 10 và “Khong dat” nếu điểm nhỏ hơn 5 */
alter table KETQUATHI add constraint Check_KQ check ((KQUA = 'Dat' and DIEM between 5 and 10) or (KQUA = 'Khong dat' and DIEM < 5))

/* 6. Học viên thi một môn tối đa 3 lần */
alter table KETQUATHI add constraint Check_LANTHI check (LANTHI <= 3)

/* 7. Học kỳ chỉ có giá trị từ 1 đến 3 */
alter table GIANGDAY add constraint Check_HK check (HOCKY between 1 and 3)

/* 8. Học vị của giáo viên chỉ có thể là “CN”, “KS”, “Ths”, ”TS”, ”PTS” */
alter table GIAOVIEN add constraint Check_HOCVI check (HOCVI in ('CN', 'KS', 'Ths', 'TS', 'PTS'))

/* 9. Lớp trưởng của một lớp phải là học viên của lớp đó */

/* 10. Trưởng khoa phải là giáo viên thuộc khoa và có học vị “TS” hoặc “PTS” */

/* 11. Học viên ít nhất là 18 tuổi */
alter table HOCVIEN add constraint Check_TUOI check (year(getdate()) - year(NGSINH) >= 18)

/* 12. Giảng dạy một môn học ngày bắt đầu (TUNGAY) phải nhỏ hơn ngày kết thúc (DENNGAY) */
alter table GIANGDAY add constraint Check_NgBD_NgKT check (TUNGAY < DENNGAY)

/* 13. Giáo viên khi vào làm ít nhất là 22 tuổi */
alter table GIAOVIEN add constraint Check_TUOI_GV check (year(getdate()) - year(NGSINH) >= 22)

/* 14. Tất cả các môn học đều có số tín chỉ lý thuyết và tín chỉ thực hành chênh lệch nhau không quá 3 */
alter table MONHOC add constraint Check_TC check (abs(TCLT - TCTH) <= 3)

/* 15. Học viên chỉ được thi một môn học nào đó khi lớp của học viên đã học xong môn học này */