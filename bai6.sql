﻿-- 1. Thêm một sinh viên mới gồm các thông tin sau: Mã sinh viên: C01, Họ sinh viên: Lê Thành, Tên sinh viên: Nguyên, Phái: Nam, Ngày sinh: 20/10/1980, Nơi sinh: Thành phố Hồ Chí Minh, Mã khoa: TH, Học bổng: 850,000
INSERT INTO SinhVien (MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKH, HocBong) 
VALUES ('C01', 'Lê Thành', 'Nguyên', 0, '1980-10-20', 'Thành phố Hồ Chí Minh', 'TH', 850000);
SELECT * FROM SinhVien WHERE MaSV = 'C01';
-- 2. Thêm một môn học mới gồm các thông tin sau: Mã môn học: 06, Tên môn học: Xử lý ảnh, Số tiết: 45
INSERT INTO MonHoc (MaMH, TenMH, SoTiet) 
VALUES ('06', 'Xử lý ảnh', 45);
-- 3. Thêm một khoa mới gồm các thông tin sau: Mã khoa: CT, Tên khoa: Công trình
INSERT INTO Khoa (MaKH, TenKH) 
VALUES ('CT', 'Công trình');
-- 4. Thêm một sinh viên mới gồm các thông tin sau: Mã sinh viên: C02, Họ sinh viên: Nguyễn Trần, Tên sinh viên: Quân, Phái: Nam, Ngày sinh: lấy ngày hiện tại, Nơi sinh: Huế, Mã khoa: CT, Học bổng: 950,000
INSERT INTO SinhVien (MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKH, HocBong) 
VALUES ('C02', 'Nguyễn Trần', 'Quân', 0, GETDATE(), 'Huế', 'CT', 950000);
-- 5. Thêm vào bảng kết quả gồm các thông tin sau: Mã sinh viên: lấy tất cả những sinh viên của khoa Tin học, Mã môn học: 06, Điểm: 7
INSERT INTO Ketqua (MaSV, MaMH, Diem) 
SELECT sv.MaSV, '06', 7 
FROM SinhVien AS sv
WHERE sv.MaKH = (SELECT MaKH FROM Khoa WHERE TenKH = 'Tin học');
-- 6. Thêm vào bảng kết quả gồm các thông tin sau: Mã sinh viên: C02, Mã môn học: lấy tất cả những môn học có trong bảng môn học, Điểm: 8
INSERT INTO Ketqua (MaSV, MaMH, Diem) 
SELECT 'C02', mh.MaMH, 8 
FROM MonHoc AS mh;