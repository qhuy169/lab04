﻿--1. Cho biết trung bình điểm thi theo từng môn, gồm các thông tin: Mã môn, Tên  môn, Trung bình điểm thi 
SELECT kt.MaMH, 
       mh.TenMH, 
       AVG(kt.Diem) AS TrungBinhDiem
FROM Ketqua AS kt
JOIN MonHoc AS mh ON kt.MaMH = mh.MaMH
GROUP BY kt.MaMH, mh.TenMH;
--2. Danh sách số môn thi của từng sinh viên, gồm các thông tin: Họ tên sinh viên,  Tên khoa, Tổng số môn thi 
SELECT sv.HoSV + ' ' + sv.TenSV AS HoVaTen, 
       k.TenKH, 
       COUNT(kt.MaMH) AS TongSoMonThi
FROM Ketqua AS kt
JOIN SinhVien AS sv ON kt.MaSV = sv.MaSV
JOIN Khoa AS k ON sv.MaKH = k.MaKH
GROUP BY sv.HoSV, sv.TenSV, k.TenKH;
--3. Tổng điểm thi của từng sinh viên, các thông tin: Tên sinh viên, Tên khoa, Phái,  Tổng điểm thi  
SELECT sv.HoSV + ' ' + sv.TenSV AS HoVaTen, 
       k.TenKH, 
       sv.Phai, 
       SUM(kt.Diem) AS TongDiemThi
FROM Ketqua AS kt
JOIN SinhVien AS sv ON kt.MaSV = sv.MaSV
JOIN Khoa AS k ON sv.MaKH = k.MaKH
GROUP BY sv.HoSV, sv.TenSV, k.TenKH, sv.Phai;
--4. Cho biết tổng số sinh viên ở mỗi khoa, gồmcác thông tin: Tên khoa, Tổng số sinh  viên
SELECT k.TenKH, 
       COUNT(sv.MaSV) AS TongSoSinhVien
FROM SinhVien AS sv
JOIN Khoa AS k ON sv.MaKH = k.MaKH
GROUP BY k.TenKH;
--5.Liệt kê điểm cao nhất của mỗi sinh viên, bao gồm: Họ tên sinh viên và Điểm cao nhất
SELECT sv.HoSV + ' ' + sv.TenSV AS HoVaTen, 
       MAX(kt.Diem) AS DiemCaoNhat
FROM Ketqua AS kt
JOIN SinhVien AS sv ON kt.MaSV = sv.MaSV
GROUP BY sv.HoSV, sv.TenSV;
-- 6. Thông tin của môn học có số tiết nhiều nhất: Tên môn học, Số tiết 
SELECT TenMH, SoTiet 
FROM MonHoc 
WHERE SoTiet = (SELECT MAX(SoTiet) FROM MonHoc);
--7. Cho biết học bổng cao nhất của từng khoa, gồm Mã khoa, Tên khoa, Học bổng  cao nhất  
SELECT k.MaKH, 
       k.TenKH, 
       MAX(sv.HocBong) AS HocBongCaoNhat
FROM SinhVien AS sv
JOIN Khoa AS k ON sv.MaKH = k.MaKH
GROUP BY k.MaKH, k.TenKH;
--8. Cho biết điểm cao nhất của mỗi môn, gồm: Tên môn, Điểm cao nhất
SELECT mh.TenMH, 
       MAX(kt.Diem) AS DiemCaoNhat
FROM Ketqua AS kt
JOIN MonHoc AS mh ON kt.MaMH = mh.MaMH
GROUP BY mh.TenMH;
--9. Thống kê số sinh viên học của từng môn, thông tin có: Mã môn, Tên môn, Số  sinh viên đang học  
SELECT kt.MaMH, 
       mh.TenMH, 
       COUNT(DISTINCT kt.MaSV) AS SoSinhVien
FROM Ketqua AS kt
JOIN MonHoc AS mh ON kt.MaMH = mh.MaMH
GROUP BY kt.MaMH, mh.TenMH;
--10.Cho biết môn nào có điểm thi cao nhất, gồmcác thông tin: Tên môn, Số tiết, Tên  sinh viên, Điểm 
SELECT mh.TenMH, 
       mh.SoTiet, 
       sv.HoSV + ' ' + sv.TenSV AS HoVaTen, 
       kt.Diem
FROM Ketqua AS kt
JOIN MonHoc AS mh ON kt.MaMH = mh.MaMH
JOIN SinhVien AS sv ON kt.MaSV = sv.MaSV
WHERE kt.Diem = (SELECT MAX(Diem) FROM Ketqua);
--11.Cho biết khoa nào có đông sinh viên nhất, gồm Mã khoa, Tên khoa, Tổng số sinh  viên  
SELECT TOP 1 k.MaKH, 
       k.TenKH, 
       COUNT(sv.MaSV) AS TongSoSinhVien
FROM SinhVien AS sv
JOIN Khoa AS k ON sv.MaKH = k.MaKH
GROUP BY k.MaKH, k.TenKH
ORDER BY TongSoSinhVien DESC;
--12.Cho biết khoa nào có sinh viên lảnh học bổng cao nhất, gồm các thông tin sau:  Tên khoa, Họ tên sinh viên, Học bổng
SELECT k.TenKH, 
       sv.HoSV + ' ' + sv.TenSV AS HoVaTen, 
       sv.HocBong
FROM SinhVien AS sv
JOIN Khoa AS k ON sv.MaKH = k.MaKH
WHERE sv.HocBong = (SELECT MAX(HocBong) FROM SinhVien);
--13.Cho biết sinh viên của khoa Tin học có có học bổng cao nhất, gồm các thông tin:  Mã sinh viên, Họ sinh viên, Tên sinh viên, Tên khoa, Học bổng  
SELECT sv.MaSV, 
       sv.HoSV, 
       sv.TenSV, 
       k.TenKH, 
       sv.HocBong
FROM SinhVien AS sv
JOIN Khoa AS k ON sv.MaKH = k.MaKH
WHERE k.TenKH = N'Tin học' AND sv.HocBong = (SELECT MAX(HocBong) FROM SinhVien WHERE MaKH = k.MaKH);

--14.Cho biết sinh viên nào có điểm môn Cơ sở dữ liệu lớn nhất, gồm thông tin: Họ  sinh viên, Tên môn, Điểm
SELECT sv.HoSV + ' ' + sv.TenSV AS HoVaTen, 
       mh.TenMH, 
       kt.Diem
FROM Ketqua AS kt
JOIN SinhVien AS sv ON kt.MaSV = sv.MaSV
JOIN MonHoc AS mh ON kt.MaMH = mh.MaMH
WHERE mh.TenMH = N'Cơ sở dữ liệu' AND kt.Diem = (SELECT MAX(Diem) FROM Ketqua WHERE MaMH = mh.MaMH);

--15.Cho biết 3 sinh viên có điểm thi môn Đồ hoạthấp nhất, thông tin: Họ tên sinh  viên, Tên khoa, Tên môn, Điểm 
SELECT TOP 3 sv.HoSV + ' ' + sv.TenSV AS HoVaTen, 
             k.TenKH, 
             mh.TenMH, 
             kt.Diem
FROM Ketqua AS kt
JOIN SinhVien AS sv ON kt.MaSV = sv.MaSV
JOIN MonHoc AS mh ON kt.MaMH = mh.MaMH
JOIN Khoa AS k ON sv.MaKH = k.MaKH
WHERE mh.TenMH = N'Đồ họa ứng dụng'
ORDER BY kt.Diem ASC;

--16.Cho biết nào có nhiều sinh viên nữ nhất, gồm các thông tin: Mã khoa, Tên khoa  
SELECT TOP 1 k.MaKH, 
             k.TenKH
FROM SinhVien AS sv
JOIN Khoa AS k ON sv.MaKH = k.MaKH
WHERE sv.Phai = 1
GROUP BY k.MaKH, k.TenKH
ORDER BY COUNT(sv.MaSV) DESC;


--17.Thống kê sinh viên theo khoa, gồm các thông tin: Mã khoa, Tên khoa, Tổng số  sinh viên, Tổng số sinh viên nữ  
SELECT k.MaKH, 
       k.TenKH, 
       COUNT(sv.MaSV) AS TongSoSinhVien, 
       SUM(CASE WHEN sv.Phai = 1 THEN 1 ELSE 0 END) AS TongSoSinhVienNu
FROM SinhVien AS sv
JOIN Khoa AS k ON sv.MaKH = k.MaKH
GROUP BY k.MaKH, k.TenKH;

--18.Cho biết kết quả học tập của sinh viên, gồm Họ tên sinh viên, Tên khoa, Kết quả.  Trong đó, Kết quả sẽ là Đậu nếu không có môn nào có điểm nhỏ hơn 4  
SELECT sv.HoSV + ' ' + sv.TenSV AS HoVaTen, 
       k.TenKH, 
       CASE 
           WHEN MIN(kt.Diem) < 4 THEN N'Rớt' 
           ELSE N'Đậu' 
       END AS KetQua
FROM Ketqua AS kt
JOIN SinhVien AS sv ON kt.MaSV = sv.MaSV
JOIN Khoa AS k ON sv.MaKH = k.MaKH
GROUP BY sv.HoSV, sv.TenSV, k.TenKH;
-- 19. Danh sách những sinh viên không có môn nào nhỏ hơn 4 điểm, gồm các thông tin: Họ tên sinh viên, Tên khoa, Phái
SELECT sv.HoSV + ' ' + sv.TenSV AS HoVaTen, 
       k.TenKH, 
       sv.Phai 
FROM SinhVien AS sv
JOIN Khoa AS k ON sv.MaKH = k.MaKH
WHERE sv.MaSV NOT IN (SELECT kt.MaSV FROM Ketqua AS kt WHERE kt.Diem < 4);
-- 20. Cho biết danh sách những môn không có điểm thi nhỏ hơn 4, gồm các thông tin: Mã môn, Tên Môn
SELECT mh.MaMH, 
       mh.TenMH 
FROM MonHoc AS mh
WHERE mh.MaMH NOT IN (SELECT kt.MaMH FROM Ketqua AS kt WHERE kt.Diem < 4);
-- 21. Cho biết những khoa không có sinh viên rớt, sinh viên rớt nếu điểm thi của môn nhỏ hơn 5, gồm các thông tin: Mã khoa, Tên khoa
SELECT k.MaKH, 
       k.TenKH 
FROM Khoa AS k
WHERE k.MaKH NOT IN (SELECT sv.MaKH FROM SinhVien AS sv
                     JOIN Ketqua AS kt ON sv.MaSV = kt.MaSV 
                     WHERE kt.Diem < 5);
-- 22. Thống kê số sinh viên đậu và số sinh viên rớt của từng môn, biết rằng sinh viên rớt khi điểm của môn nhỏ hơn 5, gồm có: Mã môn, Tên môn, Số sinh viên đậu, Số sinh viên rớt
SELECT kt.MaMH, 
       mh.TenMH, 
       SUM(CASE WHEN kt.Diem >= 5 THEN 1 ELSE 0 END) AS SoSinhVienDau, 
       SUM(CASE WHEN kt.Diem < 5 THEN 1 ELSE 0 END) AS SoSinhVienRot
FROM Ketqua AS kt
JOIN MonHoc AS mh ON kt.MaMH = mh.MaMH
GROUP BY kt.MaMH, mh.TenMH;
-- 23. Cho biết môn nào không có sinh viên rớt, gồm có: Mã môn, Tên môn
SELECT mh.MaMH, 
       mh.TenMH 
FROM MonHoc AS mh
WHERE mh.MaMH NOT IN (SELECT kt.MaMH FROM Ketqua AS kt WHERE kt.Diem < 5);
-- 24. Danh sách sinh viên không có môn nào rớt, thông tin gồm: Mã sinh viên, Họ tên, Mã khoa
SELECT sv.MaSV, 
       sv.HoSV + ' ' + sv.TenSV AS HoVaTen, 
       sv.MaKH 
FROM SinhVien AS sv
WHERE sv.MaSV NOT IN (SELECT kt.MaSV FROM Ketqua AS kt WHERE kt.Diem < 5);
-- 25. Danh sách các sinh viên rớt trên 2 môn, gồm Mã sinh viên, Họ sinh viên, Tên sinh viên, Mã khoa
SELECT sv.MaSV, 
       sv.HoSV, 
       sv.TenSV, 
       sv.MaKH
FROM SinhVien AS sv
WHERE sv.MaSV IN (SELECT kt.MaSV FROM Ketqua AS kt WHERE kt.Diem < 5 GROUP BY kt.MaSV HAVING COUNT(kt.MaMH) > 2);
-- 26. Cho biết danh sách những khoa có nhiều hơn 10 sinh viên, gồm Mã khoa, Tên khoa, Tổng số sinh viên của khoa
SELECT k.MaKH, 
       k.TenKH, 
       COUNT(sv.MaSV) AS TongSoSinhVien
FROM Khoa AS k
JOIN SinhVien AS sv ON k.MaKH = sv.MaKH
GROUP BY k.MaKH, k.TenKH
HAVING COUNT(sv.MaSV) > 10;
-- 27. Danh sách những sinh viên thi nhiều hơn 4 môn, gồm có Mã sinh viên, Họ tên sinh viên, Số môn thi
SELECT sv.MaSV, 
       sv.HoSV + ' ' + sv.TenSV AS HoVaTen, 
       COUNT(kt.MaMH) AS SoMonThi
FROM Ketqua AS kt
JOIN SinhVien AS sv ON kt.MaSV = sv.MaSV
GROUP BY sv.MaSV, sv.HoSV, sv.TenSV
HAVING COUNT(kt.MaMH) > 4;
-- 28. Cho biết khoa có 5 sinh viên nam trở lên, thông tin gồm có: Mã khoa, Tên khoa, Tổng số sinh viên nam
SELECT k.MaKH, 
       k.TenKH, 
       COUNT(sv.MaSV) AS TongSoSinhVienNam
FROM Khoa AS k
JOIN SinhVien AS sv ON k.MaKH = sv.MaKH
WHERE sv.Phai = 0
GROUP BY k.MaKH, k.TenKH
HAVING COUNT(sv.MaSV) >= 5;
-- 29. Danh sách những sinh viên có trung bình điểm thi lớn hơn 4, gồm các thông tin sau: Họ tên sinh viên, Tên khoa, Phái, Điểm trung bình các môn
SELECT sv.HoSV + ' ' + sv.TenSV AS HoVaTen, 
       k.TenKH, 
       sv.Phai, 
       AVG(kt.Diem) AS DiemTrungBinh
FROM SinhVien AS sv
JOIN Ketqua AS kt ON sv.MaSV = kt.MaSV
JOIN Khoa AS k ON sv.MaKH = k.MaKH
GROUP BY sv.HoSV, sv.TenSV, k.TenKH, sv.Phai
HAVING AVG(kt.Diem) > 4;
-- 30. Cho biết trung bình điểm thi của từng môn, chỉ lấy môn nào có trung bình điểm thi lớn hơn 6, thông tin gồm có: Mã môn, Tên môn, Trung bình điểm
SELECT mh.MaMH, 
       mh.TenMH, 
       AVG(kt.Diem) AS TrungBinhDiem
FROM Ketqua AS kt
JOIN MonHoc AS mh ON kt.MaMH = mh.MaMH
GROUP BY mh.MaMH, mh.TenMH
HAVING AVG(kt.Diem) > 6;