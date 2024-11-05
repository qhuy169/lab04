-- 1. Cập nhật số tiết của môn Văn phạm thành 45 tiết
UPDATE MonHoc
SET Sotiet = 45
WHERE TenMH = N'Văn phạm';

-- 2. Cập nhật tên của sinh viên Trần Thanh Mai thành Trần Thanh Kỳ
UPDATE SinhVien
SET TenSV = N'Kỳ'
WHERE HoSV = N'Trần Thanh' AND TenSV = N'Mai';

-- 3. Cập nhật phái của sinh viên Trần Thanh Kỳ thành phái Nam
UPDATE SinhVien
SET Phai = 1
WHERE HoSV = N'Trần Thanh' AND TenSV = N'Kỳ';

-- 4. Cập nhật ngày sinh của sinh viên Trần Thị Thu Thủy thành ngày 05/07/1990
UPDATE SinhVien
SET NgaySinh = '1990-07-05'
WHERE HoSV = N'Trần Thị Thu' AND TenSV = N'Thủy';

-- 5. Tăng học bổng cho tất cả sinh viên của khoa Anh văn thêm 100,000
UPDATE SinhVien
SET HocBong = ISNULL(HocBong, 0) + 100000
WHERE MaKH = (SELECT MaKH FROM Khoa WHERE TenKH = N'Anh văn');

-- 6. Cộng thêm 5 điểm môn Trí Tuệ Nhân Tạo cho các sinh viên thuộc khoa Anh văn với điểm tối đa là 10
UPDATE Ketqua
SET Diem = CASE 
             WHEN Diem + 5 > 10 THEN 10 
             ELSE Diem + 5 
           END
WHERE MaMH = (SELECT MaMH FROM MonHoc WHERE TenMH = N'Trí Tuệ Nhân Tạo')
  AND MaSV IN (SELECT MaSV FROM SinhVien WHERE MaKH = (SELECT MaKH FROM Khoa WHERE TenKH = N'Anh văn'));

-- 7. Tăng học bổng cho sinh viên theo mô tả
UPDATE SinhVien
SET HocBong = ISNULL(HocBong, 0) + 
              CASE 
                WHEN Phai = 0 AND MaKH = (SELECT MaKH FROM Khoa WHERE TenKH = N'Anh văn') THEN 100000
                WHEN Phai = 1 AND MaKH = (SELECT MaKH FROM Khoa WHERE TenKH = N'Tin học') THEN 150000
                ELSE 50000
              END;

-- 8. Thay đổi kết quả thi của các sinh viên theo mô tả
UPDATE Ketqua
SET Diem = CASE 
             WHEN MaSV IN (SELECT MaSV FROM SinhVien WHERE MaKH = (SELECT MaKH FROM Khoa WHERE TenKH = N'Anh văn'))
                  AND Diem + 2 <= 10 THEN Diem + 2
             WHEN MaSV IN (SELECT MaSV FROM SinhVien WHERE MaKH = (SELECT MaKH FROM Khoa WHERE TenKH = N'Anh văn'))
                  AND Diem + 2 > 10 THEN 10
             WHEN MaSV IN (SELECT MaSV FROM SinhVien WHERE MaKH = (SELECT MaKH FROM Khoa WHERE TenKH = N'Tin học'))
                  AND Diem - 1 >= 0 THEN Diem - 1
             WHEN MaSV IN (SELECT MaSV FROM SinhVien WHERE MaKH = (SELECT MaKH FROM Khoa WHERE TenKH = N'Tin học'))
                  AND Diem - 1 < 0 THEN 0
             ELSE Diem
           END
WHERE MaMH = (SELECT MaMH FROM MonHoc WHERE TenMH = N'Cơ sở dữ liệu');
