﻿-- 1. Danh sách sinh viên chưa thi môn nào, thông tin gồm: Mã sinh viên, Mã khoa, Phái
SELECT sv.MaSV, sv.MaKH, sv.Phai 
FROM SinhVien AS sv
WHERE sv.MaSV NOT IN (SELECT kt.MaSV FROM Ketqua AS kt);
-- 2. Danh sách những sinh viên chưa thi môn Cơ sở dữ liệu, gồm các thông tin: Mã sinh viên, Họ tên sinh viên, Mã khoa
SELECT sv.MaSV, 
       sv.HoSV + ' ' + sv.TenSV AS HoVaTen, 
       sv.MaKH 
FROM SinhVien AS sv
WHERE sv.MaSV NOT IN (SELECT kt.MaSV FROM Ketqua AS kt WHERE kt.MaMH = (SELECT MaMH FROM MonHoc WHERE TenMH = N'Cơ sở dữ liệu'));
-- 3. Cho biết môn nào chưa có sinh viên thi, gồm thông tin về: Mã môn, Tên môn, Số tiết
SELECT mh.MaMH, 
       mh.TenMH, 
       mh.SoTiet 
FROM MonHoc AS mh
WHERE mh.MaMH NOT IN (SELECT kt.MaMH FROM Ketqua AS kt);
-- 4. Khoa nào chưa có sinh viên học
SELECT k.MaKH, 
       k.TenKH 
FROM Khoa AS k
WHERE k.MaKH NOT IN (SELECT sv.MaKH FROM SinhVien AS sv);
-- 5. Cho biết những sinh viên của khoa Anh văn chưa thi môn Cơ sở dữ liệu
SELECT sv.MaSV, 
       sv.HoSV + ' ' + sv.TenSV AS HoVaTen 
FROM SinhVien AS sv
WHERE sv.MaKH = (SELECT MaKH FROM Khoa WHERE TenKH = N'Anh Văn') 
  AND sv.MaSV NOT IN (SELECT kt.MaSV FROM Ketqua AS kt WHERE kt.MaMH = (SELECT MaMH FROM MonHoc WHERE TenMH = N'Cơ sở dữ liệu'));
  -- 6. Cho biết môn nào chưa có sinh viên khoa Lý thi
SELECT mh.MaMH, 
       mh.TenMH 
FROM MonHoc AS mh
WHERE mh.MaMH NOT IN (SELECT kt.MaMH FROM Ketqua AS kt
                      JOIN SinhVien AS sv ON kt.MaSV = sv.MaSV
                      WHERE sv.MaKH = (SELECT MaKH FROM Khoa WHERE TenKH = N'Vật Lý'));
-- 7. Danh sách những sinh viên có điểm thi môn Đồ hoạ nhỏ hơn điểm thi môn Đồ hoạ nhỏ nhất của sinh viên khoa Tin học
SELECT sv.MaSV, 
       sv.HoSV + ' ' + sv.TenSV AS HoVaTen 
FROM Ketqua AS kt
JOIN SinhVien AS sv ON kt.MaSV = sv.MaSV
WHERE kt.MaMH = (SELECT MaMH FROM MonHoc WHERE TenMH = N'Đồ hoạ') 
  AND kt.Diem < (SELECT MIN(kt2.Diem) FROM Ketqua AS kt2 
                  JOIN SinhVien AS sv2 ON kt2.MaSV = sv2.MaSV 
                  WHERE sv2.MaKH = (SELECT MaKH FROM Khoa WHERE TenKH = N'Tin học'));
-- 8. Liệt kê những sinh viên sinh sau sinh viên có tuổi nhỏ nhất trong khoa Anh văn
SELECT sv.MaSV, 
       sv.HoSV + ' ' + sv.TenSV AS HoVaTen 
FROM SinhVien AS sv
WHERE sv.NgaySinh > (SELECT MIN(sv2.NgaySinh) FROM SinhVien AS sv2 
                      WHERE sv2.MaKH = (SELECT MaKH FROM Khoa WHERE TenKH = N'Anh Văn'));
-- 9. Cho biết những sinh viên có học bổng lớn hơn tổng học bổng của những sinh viên thuộc khoa Triết
SELECT sv.MaSV, 
       sv.HoSV + ' ' + sv.TenSV AS HoVaTen, 
       sv.HocBong 
FROM SinhVien AS sv
WHERE sv.HocBong > (SELECT SUM(sv2.HocBong) FROM SinhVien AS sv2 
                     WHERE sv2.MaKH = (SELECT MaKH FROM Khoa WHERE TenKH = N'Triết'));
-- 10. Danh sách sinh viên có nơi sinh cùng với nơi sinh của sinh viên có học bổng lớn nhất trong khoa Lý
SELECT sv.MaSV, 
       sv.HoSV + ' ' + sv.TenSV AS HoVaTen, 
       sv.NoiSinh 
FROM SinhVien AS sv
WHERE sv.NoiSinh = (SELECT sv2.NoiSinh FROM SinhVien AS sv2 
                    WHERE sv2.HocBong = (SELECT MAX(sv3.HocBong) FROM SinhVien AS sv3 
                                         WHERE sv3.MaKH = (SELECT MaKH FROM Khoa WHERE TenKH = N'Lý')));
-- 11. Danh sách sinh viên có điểm cao nhất ứng với mỗi môn, gồm thông tin: Mã sinh viên, Họ tên sinh viên, Tên môn, Điểm
SELECT kt.MaSV, 
       sv.HoSV + ' ' + sv.TenSV AS HoVaTen, 
       mh.TenMH, 
       kt.Diem 
FROM Ketqua AS kt
JOIN SinhVien AS sv ON kt.MaSV = sv.MaSV
JOIN MonHoc AS mh ON kt.MaMH = mh.MaMH
WHERE kt.Diem IN (SELECT MAX(Diem) FROM Ketqua WHERE MaMH = kt.MaMH)
ORDER BY mh.MaMH;
-- 12. Các sinh viên có học bổng cao nhất theo từng khoa, gồm Mã sinh viên, Tên khoa, Học bổng
SELECT sv.MaSV, 
       k.TenKH, 
       sv.HocBong 
FROM SinhVien AS sv
JOIN Khoa AS k ON sv.MaKH = k.MaKH
WHERE sv.HocBong IN (SELECT MAX(sv2.HocBong) FROM SinhVien AS sv2 WHERE sv2.MaKH = sv.MaKH)
ORDER BY k.MaKH;