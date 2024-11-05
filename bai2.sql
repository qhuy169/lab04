﻿--1.Liệt kê danh sách sinh viên gồm các thông tin sau: Họ và tên sinh viên, Giới tính,  Tuổi, Mã khoa. Trong đó Giới tính hiển thị ởdạng Nam/Nữ tuỳ theo giá trị của  field Phai là True hay False, Tuổi sẽ được tính bằng cách lấy năm hiện hành trừ  cho năm sinh. Danh sách sẽ được sắp xếp theo thứ tự Tuổi giảm dần 
SELECT HoSV + ' ' + TenSV AS HoVaTen, CASE WHEN Phai = 0 THEN 'Nam' ELSE 'Nữ' END AS GioiTinh, YEAR(GETDATE()) - YEAR(NgaySinh) AS Tuoi, MaKH FROM SinhVien ORDER BY Tuoi DESC;
--2.Danh sách sinh viên sinh vào tháng 2 năm 1994, gồm các thông tin: Họ tên sinh  viên, Phái, Ngày sinh. Trong đó, Ngày sinh chỉ lấy giá trị ngày của trường  NGAYSINH. 
SELECT HoSV + ' ' + TenSV AS HoVaTen, Phai, DAY(NgaySinh) AS NgaySinh 
FROM SinhVien 
WHERE MONTH(NgaySinh) = 2 AND YEAR(NgaySinh) = 1994;
--3.Sắp xếp dữ liệu giảm dần theo cột Ngày sinh 
SELECT HoSV + ' ' + TenSV AS HoVaTen, Phai, NgaySinh 
FROM SinhVien 
ORDER BY NgaySinh DESC;
--4.Mức học bổng của các sinh viên, gồm: Mã sinh viên, Phái,  Mã khoa, Mức học bổng. Trong đó, mức học bổng sẽ hiển thị là “Học bổng cao”  nếu giá trị của field học bổng lớn hơn 500,000 và ngược lại hiển thị là “Mức  trung bình”  
SELECT MaSV, Phai, MaKH, 
       CASE WHEN HocBong > 500000 THEN N'Học bổng cao' ELSE N'Mức trung bình' END AS MucHocBong 
FROM SinhVien;
--5.Điểm thi của các sinh viên, gồm các thông tin: Họ tên sinh viên, Mã  môn học, Điểm. Kết quả sẽ được sắp theo thứ tự Họ tên sinh viên và mã môn  học tăng dần
SELECT * FROM Ketqua
SELECT * FROM SinhVien
SELECT * FROM MonHoc
SELECT * FROM Khoa
--
SELECT sv.HoSV + ' ' + sv.TenSV AS HoVaTen, kt.MaMH, kt.Diem 
FROM Ketqua AS kt
JOIN SinhVien AS sv ON kt.MaSV = sv.MaSV
ORDER BY HoVaTen ASC, kt.MaMH ASC;
--6.Danh sách sinh viên của khoa Anh văn, điều kiện lọc phải sử dụng tên khoa, gồm  các thông tin sau: Họ tên sinh viên, Giới tính, Tên khoa. Trong đó, Giới tính sẽ  hiển thị dạng Nam/Nữ
SELECT sv.HoSV + ' ' + sv.TenSV AS HoVaTen, 
       CASE WHEN sv.Phai = 0 THEN N'Nam' ELSE N'Nữ' END AS GioiTinh, 
       k.TenKH AS TenKhoa
FROM SinhVien AS sv
JOIN Khoa AS k ON sv.MaKH = k.MaKH
WHERE k.TenKH = N'Anh Văn';
--7. Liệt kê bảng điểm của sinh viên khoa Tin Học, gồm các thông tin:Tên khoa, Họ  tên sinh viên, Tên môn học, Số tiết, Điểm
SELECT k.TenKH AS TenKhoa, 
       sv.HoSV + ' ' + sv.TenSV AS HoVaTen, 
       mh.TenMH AS TenMon, 
       mh.SoTiet, 
       kt.Diem
FROM Ketqua AS kt
JOIN SinhVien AS sv ON kt.MaSV = sv.MaSV
JOIN MonHoc AS mh ON kt.MaMH = mh.MaMH
JOIN Khoa AS k ON sv.MaKH = k.MaKH
WHERE k.TenKH = N'Tin học';
--8. Kết quả học tập của sinh viên, gồm các thông tin: Họ tên sinh viên, Mã khoa,  Tên môn học, Điểm thi, Loại. Trong đó, Loại sẽ là Giỏi nếu điểm thi > 8, từ 6 đến  8 thì Loại là Khá, nhỏ hơn 6 thì loại là Trung Bình
SELECT sv.HoSV + ' ' + sv.TenSV AS HoVaTen, 
       sv.MaKH, 
       mh.TenMH AS TenMon, 
       kt.Diem,
       CASE 
           WHEN kt.Diem > 8 THEN N'Giỏi'
           WHEN kt.Diem >= 6 THEN N'Khá'
           ELSE N'Trung Bình'
       END AS Loai
FROM Ketqua AS kt
JOIN SinhVien AS sv ON kt.MaSV = sv.MaSV
JOIN MonHoc AS mh ON kt.MaMH = mh.MaMH;