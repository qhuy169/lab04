﻿--Danh sách các môn học, gồm các thông tin sau: Mã môn học, Tên môn học, Số tiết.
SELECT * FROM MonHoc
--Danh sách sinh viên, gồm các thông tin sau: Mã sinh viên, Họ sinh viên,Tên sinh viên, Học bổng. Danh sách sẽ được sắp xếp theo thứ tự Mã sinh viên tăng dần.
SELECT * FROM SinhVien ORDER BY MaSV ASC
--. Danh sách sinh viên với Mã sinh viên, Tên sinh viên, Phái, Ngày sinh, sắp xếp theo Tên sinh viên:
SELECT MaSV, TenSV, Phai, NgaySinh FROM SinhVien ORDER BY TenSV ASC
--Thông tin các sinh viên gồm: Họ tên sinh viên, Ngày sinh, Học bổng. Thông tin sẽ được sắp xếp theo thứ tự Ngày sinh tăng dần và Học bổng giảm dần.
SELECT HoSV + '' + TenSV as HoVaTen, NgaySinh, HocBong FROM SinhVien ORDER BY NgaySinh ASC
SELECT HoSV + '' + TenSV as HoVaTen, NgaySinh, HocBong FROM SinhVien ORDER BY HocBong DESC
--Danh sách các môn học có tên bắt đầu bằng chữ T, gồm các thông tin: Mã môn, Tên môn, Số tiết.
SELECT * FROM MonHoc WHERE TenMH LIKE N'T%'
--Liệt kê danh sách những sinh viên có chữ cái cuối cùng trong tên là i, gồm các thông tin: Họ tên sinh viên, Ngày sinh, Phái
SELECT HoSV + '' + TenSV as HoVaTen, NgaySinh, Phai FROM SinhVien WHERE TenSV LIKE N'%i'
--Danh sách những khoa có ký tự thứ hai của tên khoa có chứa chữ N, gồm các thông tin: Mã khoa, Tên khoa.
SELECT * FROM Khoa WHERE SUBSTRING(TenKH, 2, 1) = 'N';
--Liệt kê những sinh viên mà họ có chứa chữ Thị.
SELECT * FROM SinhVien WHERE HoSV LIKE N'%Thị%';
--Danh sách những sinh viên mà ký tự đầu tiên của tên nằm trong khoảng từ "a" đến "m"
SELECT MaSV, HoSV + ' ' + TenSV AS HoVaTen, Phai, HocBong FROM SinhVien WHERE LEFT(TenSV, 1) BETWEEN 'A' AND 'M';
-- Danh sách những sinh viên mà têncó chứa ký tự nằm trong khoảng từ  a đến m, gồm các thông tin: Họ tên sinh viên, Ngày sinh, Nơi sinh, Học bổng.  Danh sách được sắp xếp tăng dần theo họ tên sinh viên. 
SELECT HoSV + ' ' + TenSV AS HoVaTen, NgaySinh, NoiSinh, HocBong FROM SinhVien WHERE TenSV LIKE N'%[a-m]%' ORDER BY HoSV + ' ' + TenSV ASC
--Danh sách các sinh viên của khoa Anh văn, gồm các thông tin sau: Mã  sinh viên, Họ tên sinh viên, Ngày sinh, Mã khoa. 
SELECT MaSV, HoSV + ' ' + TenSV AS HoVaTen, NgaySinh, MaKH FROM SinhVien WHERE MaKH = 'AV'
--Danh sách sinh viên của khoa Vật Lý, gồm các thông tin sau: Mã sinh viên,  Họ tên sinh viên, Ngày sinh. Danh sách sẽ được sắp xếp theo thứ tự Ngày sinh  giảm dần.  
SELECT MaSV, HoSV + ' ' + TenSV AS HoVaTen, NgaySinh FROM SinhVien WHERE MaKH = 'VL' ORDER BY NgaySinh DESC;
--Danh sách các sinh viên có học bổng lớn hơn 500,000, gồm các thông  tin: Mã sinh viên, Họ tên sinh viên, Mã khoa, Học bổng. Danh sách sẽ được sắp  xếp theo thứ tự Mã khoa giảm dần.  
SELECT MaSV, HoSV + ' ' + TenSV AS HoVaTen, MaKH, HocBong FROM SinhVien WHERE HocBong > 500000 ORDER BY MaKH DESC;
--Danh sách sinh viên sinh vào ngày 20/12/1987, gồm các thông tin: Họ  tên sinh viên, Mã khoa, Học bổng.  
SELECT HoSV + ' ' + TenSV AS HoVaTen, MaKH, HocBong FROM SinhVien WHERE NgaySinh = '1987-12-20';
--Các sinh viên sinh sau ngày 20/12/1977, gồm các thông tin: Họ tên sinh  viên, Ngày sinh, Nơi sinh, Học bổng. Danh sách sẽ được sắp xếp theo thứ tự  ngày sinh giảm dần. 
SELECT HoSV + ' ' + TenSV AS HoVaTen, NgaySinh, NoiSinh, HocBong FROM SinhVien WHERE NgaySinh > '1977-12-20' ORDER BY NgaySinh DESC;
--Các sinh viên có học bổng lớnhơn 100,000 và sinh ở Tp HCM, gồm các  thông tin: Họ tên sinh viên, Mã khoa, Nơi sinh, Học bổng.  
SELECT HoSV + ' ' + TenSV AS HoVaTen, MaKH, NoiSinh, HocBong FROM SinhVien WHERE HocBong > 100000 AND NoiSinh = N'Tp. HCM';
--Danh sách các sinh viên của khoa Anh văn và khoa Triết, gồm các thông tin: Mã  sinh viên, Mã khoa, Phái. 
SELECT MaSV, MaKH, Phai FROM SinhVien WHERE MaKH IN ('AV', 'TR');
-- Sinh viên có ngày sinh từ ngày 01/01/1986 đến ngày  05/06/1992, gồm các thông tin: Mã sinh viên, Ngày sinh, Nơi sinh, Học bổng.  
SELECT MaSV, NgaySinh, NoiSinh, HocBong FROM SinhVien WHERE NgaySinh BETWEEN '1986-01-01' AND '1992-06-05';
-- Danh sách những sinh viên có học bổng từ 200,000 đến 800,000, gồm các thông  tin: Mã sinh viên, Ngày sinh, Phái, Mã khoa.  
SELECT * FROM SinhVien WHERE HocBong BETWEEN 200000 AND 800000;
--Những môn học có số tiết lớn hơn 40 và nhỏ hơn 60, gồm các thông  tin: Mã môn học, Tên môn học, Số tiết.  
SELECT MaMH, TenMH, SoTiet FROM MonHoc WHERE SoTiet > 40 AND SoTiet < 60;
--Những sinh viên nam của khoa Anh văn, gồm các thông tin: Mã sinh viên,  Họ tên sinh viên, Phái.  
SELECT MaSV, HoSV + ' ' + TenSV AS HoVaTen, Phai FROM SinhVien WHERE Phai = 0 AND MaKH = 'AV';
--Danh sách sinh viên có nơi sinh ở Hà Nội và ngày sinh sau ngày 01/01/1990,  gồm các thông tin: Họ sinh viên, Tên sinh viên, Nơi sinh, Ngày sinh.  
SELECT HoSV, TenSV, NoiSinh, NgaySinh FROM SinhVien WHERE NoiSinh = N'Hà Nội' AND NgaySinh > '1990-01-01';
--Liệt kê những sinh viên nữ, tên có chứa chữ N.  
SELECT * FROM SinhVien WHERE Phai = 1 AND TenSV LIKE N'%N%';
--Danh sách các nam sinh viên khoa Tin Học có ngày sinh sau ngày 30/5/1986
SELECT * FROM SinhVien WHERE Phai = 0 AND MaKH = 'TH' AND NgaySinh > '1986-05-30';
--Danh sách sinh viên gồm các thông tin sau: Họ và tên sinh viên, Giới tính,  Ngày sinh. Trong đó Giới tính hiển thị ở dạng Nam/Nữ tuỳ theo giá trị của field  Phai là True hay False.
SELECT HoSV + ' ' + TenSV AS HoVaTen, 
       CASE WHEN Phai = 0 THEN N'Nam' ELSE N'Nữ' END AS GioiTinh, 
       NgaySinh 
FROM SinhVien;
--Danh sách sinh viên gồm các thôngtin sau: Mã sinh viên, Tuổi, Nơi sinh,  Mã khoa.
SELECT MaSV, YEAR(GETDATE()) - YEAR(NgaySinh) AS Tuoi, NoiSinh, MaKH  FROM SinhVien;
--Những sinh viên có tuổi lớn hơn 20, thông tin gồm: Họ tên sinh viên,  Tuổi, Học bổng  
SELECT HoSV + ' ' + TenSV AS HoVaTen, YEAR(GETDATE()) - YEAR(NgaySinh) AS Tuoi, HocBong 
FROM SinhVien 
WHERE YEAR(GETDATE()) - YEAR(NgaySinh) > 20;
--Danh sách những sinh viên có tuổi từ 20 đến 30, thông tin gồm: Họ tên sinh  viên, Tuổi, Tên khoa
SELECT sv.HoSV + ' ' + sv.TenSV AS HoVaTen, 
       YEAR(GETDATE()) - YEAR(sv.NgaySinh) AS Tuoi, 
       k.TenKH AS TenKhoa
FROM SinhVien sv
JOIN Khoa k ON sv.MaKH = k.MaKH
WHERE YEAR(GETDATE()) - YEAR(sv.NgaySinh) BETWEEN 20 AND 30;
