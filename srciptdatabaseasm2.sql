drop database ps29072_phungchauphat_asm2;
create database ps29072_PhungChauPhat_asm2;
use ps29072_PhungChauPhat_asm2;


create table loaihang(
	maLH 			varchar(5)			primary key,
    tenLH			varchar(50)			not null
);

create table mathang(
	maMH			varchar(5)			primary key,
    tenMH			varchar(50)			not null,
    DVT				varchar(10)			not null,
    donGia			float				not null,
    maLH			varchar(5),
    foreign key 	(maLH) 			references loaihang(maLH)
);

create table cuahang(
	maCH			varchar(5)			primary key,
    tenCH			varchar(50)			not null,
    diaChi			varchar(100),
    email			varchar(30)			not null,
    SDT				varchar(10)			not null
);

create table nhanvien(
	maNV					varchar(5)			primary key,
    tenNV					varchar(30)			not null,
    diaChi					varchar(100),
    SDT						varchar(10)			not null
);

create table phieuxuat(
	soPX			varchar(5)			primary key,
	ngayLP			datetime				default now(),
    ngayXH			date,
    maCH			varchar(5),
    maNV			varchar(5),
    foreign key (maCH) references cuahang(maCH),
    foreign key (maNV) references nhanvien(maNV)
);

create table phieuxuatct(
	maMH					varchar(5),
    soPX					varchar(5),
    soluong					int									not null,
    thanhTien				float								not null,
    ghiChu					varchar(100),
	foreign key (maMH) 		references mathang(maMH),
    foreign key (soPX) 		references phieuxuat(soPX),
	primary key (maMH, soPX)
);

INSERT INTO loaihang 
VALUES
("lh001", "Thời trang nam"),
("lh002", "Thời trang nữ"),
("lh003", "Quần áo thiếu nhi"),
("lh004", "đồng hồ"),
("lh005", "phụ kiện kèm theo");


INSERT INTO mathang 
VALUES
("mh001", "Quần âu nam", "cái", 500000, "lh001"),
("mh002", "Áo sơ mi nam", "cái", 250000, "lh001"),
("mh003", "Áo vest nam", "cái", 700000, "lh001"),
("mh004", "Áo công sở nữ", "cái", 650000, "lh002"),
("mh005", "Đầm hoa nữ", "cái", 200000, "lh002"),
("mh006", "Đồng phục thiếu nhi", "bộ", 180000, "lh003"),
("mh007", "Đồng hồ rolex",'chiếc','50000000','lh004'),
('mh008','dây nịt 9999','cái','10000000','lh005');

INSERT INTO cuahang
VALUES
("ch001", "Cửa hàng veston Phương Nam", null, "phuongnamveston@gmail.com", "0387031171"),
("ch002", "Cửa hàng Uniqlo", "Quận 2 TP HCM", "UniquoOfficed@gmail.com", "0979993593"),
("ch003", "Cửa hàng Ngọc Nhung", "Thành phố Dĩ An, Tỉnh Bình Dương", "NgocNhungcute@gmail.com", "0989017073"),
("ch004", "Cửa hàng Phatdepzai", "Thành phố Hà nội", "phatdepzai123@gmail.com", "0967135953"),
("ch005", "Cửa hàng dogle", "Thành phố cà mau ", "tuilacho123@gmail.com", "0123123123");


INSERT INTO nhanvien
VALUES
("nv001", "Nguyễn Văn A", null, "0123456789"),
("nv002", "Nguyễn Văn B", null, "9876543210"),
("nv003", "Nguyễn Văn C", null, "9824543210"),
("nv004", "Nguyễn Văn D", null, "9855543210"),
("nv005", "Nguyễn Văn E", null, "9876503520");

INSERT INTO phieuxuat(soPX, ngayXH, maCH, maNV)
VALUES
("px001", null, "ch001", "nv001"),
("px002", "2023/04/07", "ch002", "nv002"),
("px003", CURDATE() + INTERVAL 4 DAY, "ch005", "nv003"),
("px004", "2023/05/07", "ch003", "nv002"),
("px005", "2023/04/14", "ch004", "nv005"),
('px006','2023/05/15','ch003','nv001');



INSERT INTO phieuxuatct
VALUES
("mh001", "px002", 2, 1000000, null),
("mh002", "px002", 3, 750000, null),
("mh001", "px001", 1, 500000, null),
("mh005", "px003", 4, 800000, null),
("mh006", "px002", 1, 180000, null),
("mh001", "px003", 1, 500000, null),
("mh003", "px003", 2, 1400000, null),
("mh005", "px001", 1, 200000, null),
("mh006", "px003", 1, 180000, null),
("mh005", "px002", 5, 1250000, null),
('mh007','px004',1,50000000,null),
('mh008','px005',2,20000000,null),
('mh008', 'px006', '2', '20000000',null);

-- Giảng viên: Nguyễn Trung Kiên 
-- Họ và tên: Phùng Châu Phát 
-- Thời gian làm bài 30/3/2023
-- ASM2

-- 6.1. Hiển thị tất cả mặt hàng. Danh sách sắp xếp theo đơn giá tăng dần.
select * from mathang order by dongia asc;

-- 6.2. Hiển thị tất cả các mặt hàng thuộc loại hàng “Thời trang”. Thông tin gồm: mã mặt
-- hàng, tên mặt hàng, đơn vị tính, đơn giá, tên loại hàng.
select mh.mamh, mh.tenmh, mh.dvt, mh.dongia, lh.tenlh from mathang mh
inner join loaihang lh on lh.malh = mh.malh
where lh.tenlh like 'thoi trang%';

-- 6.3. Thống kê số mặt hàng theo loại hàng, thông tin gồm: mã loại hàng, tên loại hàng, tổng
-- số mặt hàng. Danh sách sắp xếp theo tổng số mặt hàng giảm dần.
select mh.mamh,lh.tenlh,mh.tenmh,sum(soluong) from loaihang lh
inner join mathang mh on lh.maLH = mh.malh
inner join phieuxuatct pxct on pxct.maMH = mh.maMH
group by pxct.maMH
order by sum(soluong) desc;

-- 6.4. Liệt kê số phiếu xuất, ngày xuất hàng, mã cửa hàng, tên mặt hàng, số lượng, đơn giá,
-- thành tiền.
select px.sopx,px.ngayxh,ch.mach,ch.tench,pxct.soluong,mh.dongia,pxct.thanhtien from phieuxuat px
inner join cuahang ch on px.mach = ch.mach
inner join phieuxuatct pxct on px.sopx = pxct.sopx
inner join mathang mh on mh.mamh = pxct.mamh;

-- 6.5. Thống kế tổng số lần xuất hàng theo từng tháng trong năm 2023, thông tin gồm:
-- tháng/năm, số lần xuất hàng.
select ngayxh,count(pxct.sopx) from phieuxuat px
inner join phieuxuatct pxct on px.sopx = pxct.sopx
where ngayxh like'2023%'
group by ngayxh
order by month(ngayxh) asc;

select * from phieuxuat;
select * from phieuxuatct;


-- 6.6. Liệt kê 5 mặt hàng có số lượng xuất kho nhiều nhất.
-- cách 1 
select mh.tenMH,mh.mamh,sum(pxct.soluong) from phieuxuat px
inner join phieuxuatct pxct on px.sopx = pxct.sopx
inner join mathang mh on pxct.maMH = mh.maMH
group by pxct.mamh
order by sum(pxct.soluong) desc limit 5;
-- cách 2 
-- select pxct.mamh, sum(pxct.soluong) as 'so luong xuat kho',mh.tenMH from phieuxuatct pxct
-- inner join mathang mh on pxct.maMH = mh.mamh
-- group by pxct.mamh
-- order by sum(pxct.soluong) desc limit 5;

-- 6.7. Thống kê số hàng nhập về cửa hàng “Chi nhánh Ngọc Nhung”, thông tin hiển thị: Tên cửa
-- hàng, số lần nhập hàng.
select ch.tench as'tên cửa hàng',count(px.mach) as'số lần nhập hàng' from cuahang ch
inner join phieuxuat px on px.mach = ch.mach
where px.mach = 'ch003';

select * from phieuxuat;
-- 6.8. Thống kê tổng tiền hàng xuất kho theo ngày, thông tin hiển thị: Ngày xuất hàng, tổng
-- thành tiền.
select px.ngayxh,sum(pxct.thanhtien) from phieuxuat px
inner join phieuxuatct pxct on px.sopx = pxct.sopx
group by px.ngayxh
having ngayxh is not null
order by day(px.ngayxh) and month(px.ngayxh) and year(px.ngayxh)   desc ;

-- 6.9. Cập nhật ngày xuất hàng là ngày hiện hành cho các phiếu xuất chưa có ngày xuất
update phieuxuat
set ngayxh = CURDATE()
where ngayxh is null;

-- 6.10. Cập nhật đơn giá của “Đồng phục học sinh” giảm 10% trên đơn giá hiện tại.
update mathang
set dongia = dongia * 0.9
where tenmh = 'dây nịt 9999';

-- 6.11. Thực hiện xóa các cửa hàng chưa có thông tin xuất hàng.
delete from phieuxuat
where ngayxh is null;

-- 6.12. Liệt kê danh sách các mặt hàng có số lượng xuất hàng thấp nhất: Mã hàng, tên hàng,
-- tổng số lượng xuất.
select mh.mamh,mh.tenmh,sum(pxct.soluong) as 'tổng số lượng xuất' from mathang mh
inner join phieuxuatct pxct on mh.mamh = pxct.mamh
inner join phieuxuat px on px.sopx = pxct.sopx
group by mh.mamh 
order by sum(pxct.soluong) asc limit 5; 


select * from phieuxuat;
select * from phieuxuatct;
select * from mathang;

-- 6.13. Liệt kê những mặt hàng chưa từng xuất cho các cửa hàng, thông tin gồm: Mã mặt
-- hàng, tên mặt hàng, tên loại hàng.
select mh.mamh,mh.tenmh,lh.tenlh from mathang mh
inner join phieuxuatct pxct on mh.mamh = pxct.mamh
inner join phieuxuat px on px.sopx = pxct.sopx
inner join loaihang lh on lh.malh = mh.malh
where px.ngayxh is null;


select * from mathang mh
inner join phieuxuatct pxct on mh.mamh = pxct.mamh
inner join phieuxuat px on px.sopx = pxct.sopx
inner join loaihang lh on lh.malh = mh.malh


