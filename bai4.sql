﻿-- 1. Cho biết danh sách những sinh viên của một khoa, gồm: Mã sinh viên, Họ tên sinh viên, Giới tính, Tên khoa. Trong đó, giá trị mã khoa cần xem danh sách sinh viên sẽ được người dùng nhập khi thực thi câu truy vấn
DECLARE @MaKhoa NVARCHAR(10);
SET @MaKhoa = N'AV'

SELECT sv.MaSV, 
       sv.HoSV + ' ' + sv.TenSV AS HoVaTen, 
       CASE WHEN sv.Phai = 0 THEN N'Nam' ELSE N'Nữ' END AS GioiTinh, 
       k.TenKH 
FROM SinhVien AS sv
JOIN Khoa AS k ON sv.MaKH = k.MaKH
WHERE k.MaKH = @MaKhoa;
-- 2. Liệt kê danh sách sinh viên có điểm môn Cơ sở dữ liệu lớn hơn một giá trị bất kỳ do người sử dụng nhập vào khi thực thi câu truy vấn, thông tin gồm: Mã sinh viên, Họ tên sinh viên, Tên môn, Điểm
DECLARE @DiemMin FLOAT;
SET @DiemMin = 6;

SELECT sv.MaSV, 
       sv.HoSV + ' ' + sv.TenSV AS HoVaTen, 
       mh.TenMH, 
       kt.Diem 
FROM Ketqua AS kt
JOIN SinhVien AS sv ON kt.MaSV = sv.MaSV
JOIN MonHoc AS mh ON kt.MaMH = mh.MaMH
WHERE mh.TenMH = N'Cơ sở dữ liệu' AND kt.Diem > @DiemMin;
-- 3. Cho kết quả thi của các sinh viên theo môn, tên môn cần xem kết quả sẽ được nhập vào khi thực thi câu truy vấn. Thông tin hiển thị gồm: Mã sinh viên, Tên khoa, Tên môn, Điểm 
DECLARE @TenMon NVARCHAR(100);
SET @TenMon = N'Cơ sở dữ liệu'; 

SELECT sv.MaSV, 
       k.TenKH, 
       mh.TenMH, 
       kt.Diem 
FROM Ketqua AS kt
JOIN SinhVien AS sv ON kt.MaSV = sv.MaSV
JOIN MonHoc AS mh ON kt.MaMH = mh.MaMH
JOIN Khoa AS k ON sv.MaKH = k.MaKH
WHERE mh.TenMH = @TenMon;