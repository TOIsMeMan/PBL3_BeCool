USE [master]
GO
/****** Object:  Database [QuanLyDatBan]    Script Date: 8/4/2023 1:56:17 PM ******/
CREATE DATABASE [QuanLyDatBan]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyDatBan', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\QuanLyDatBan.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QuanLyDatBan_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\QuanLyDatBan_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [QuanLyDatBan] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyDatBan].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyDatBan] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyDatBan] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyDatBan] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyDatBan] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyDatBan] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyDatBan] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QuanLyDatBan] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyDatBan] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyDatBan] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyDatBan] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyDatBan] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyDatBan] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyDatBan] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyDatBan] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyDatBan] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyDatBan] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyDatBan] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyDatBan] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyDatBan] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyDatBan] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyDatBan] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyDatBan] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyDatBan] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuanLyDatBan] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyDatBan] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyDatBan] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyDatBan] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyDatBan] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuanLyDatBan] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QuanLyDatBan] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuanLyDatBan', N'ON'
GO
ALTER DATABASE [QuanLyDatBan] SET QUERY_STORE = ON
GO
ALTER DATABASE [QuanLyDatBan] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [QuanLyDatBan]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 8/4/2023 1:56:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) 
RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput 
DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) 
SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) 
SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int 
DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) 
BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) 
BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) 
ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) 
BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
GO
/****** Object:  Table [dbo].[Account]    Script Date: 8/4/2023 1:56:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[PassWord] [nvarchar](1000) NOT NULL,
	[Type] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 8/4/2023 1:56:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DateCheckIn] [date] NOT NULL,
	[DateCheckOut] [date] NULL,
	[idTable] [int] NOT NULL,
	[status] [int] NOT NULL,
	[discount] [int] NULL,
	[totalPrice] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillInfo]    Script Date: 8/4/2023 1:56:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idBill] [int] NOT NULL,
	[idFood] [int] NOT NULL,
	[count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Food]    Script Date: 8/4/2023 1:56:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[idCategory] [int] NOT NULL,
	[price] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FoodCategory]    Script Date: 8/4/2023 1:56:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TableFood]    Script Date: 8/4/2023 1:56:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableFood](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[status] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'Admin', N'Admin', N'1962026656160185351301320480154111117132155', 1)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'NhanVien', N'NhanVien', N'1962026656160185351301320480154111117132155', 0)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'NhatHuy', N'NhatHuy', N'1962026656160185351301320480154111117132155', 1)

GO
USE [QuanLyDatBan]
GO

INSERT INTO [QuanLyDatBan].[dbo].[Food] ([name], [idCategory], [price])
VALUES 
    -- Món khai vị (idCategory = 1)
    (N'Súp cua', 1, 35000),
    (N'Gỏi ngó sen tôm thịt', 1, 55000),
    (N'Chả giò rế', 1, 40000),
    (N'Salad rau trộn', 1, 30000),
    (N'Súp bí đỏ', 1, 35000),
    (N'Cánh gà chiên mắm', 1, 45000),
    
    -- Món chính (idCategory = 2)
    (N'Cơm chiên dương châu', 2, 65000),
    (N'Bò bít tết sốt tiêu', 2, 120000),
    (N'Mì xào hải sản', 2, 70000),
    (N'Gà nướng muối ớt', 2, 90000),
    (N'Cá kho tộ', 2, 85000),
    (N'Lẩu thái chua cay', 2, 150000),
    
    -- Tráng miệng (idCategory = 3)
    (N'Chè ba màu', 3, 25000),
    (N'Bánh flan caramel', 3, 20000),
    (N'Trái cây dầm', 3, 30000),
    (N'Kem dâu tây', 3, 35000),
    (N'Bánh mousse socola', 3, 40000),
    (N'Panna cotta', 3, 30000),
    
    -- Đồ uống (idCategory = 4)
    (N'Nước cam ép', 4, 30000),
    (N'Trà sữa trân châu', 4, 40000),
    (N'Sinh tố bơ', 4, 35000),
    (N'Cà phê sữa đá', 4, 25000),
    (N'Nước dừa tươi', 4, 20000),
    (N'Trà đào cam sả', 4, 35000),
    
    -- Món ăn kèm (idCategory = 5)
    (N'Khoai tây chiên', 5, 35000),
    (N'Bánh mì bơ tỏi', 5, 25000),
    (N'Phô mai que', 5, 40000),
    (N'Xúc xích chiên', 5, 30000),
    (N'Dưa chua muối', 5, 15000),
    (N'Rau củ luộc', 5, 20000);
USE [QuanLyDatBan]
GO

INSERT INTO [QuanLyDatBan].[dbo].[FoodCategory] ([name])
VALUES 
    (N'Món khai vị'),
    (N'Món chính'),
    (N'Tráng miệng'),
    (N'Đồ uống'),
    (N'Món ăn kèm')
GO
SET IDENTITY_INSERT [dbo].[TableFood] ON 

INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (1, N'Bàn VVip', N' ')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (2, N'Bàn 1', N' ')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (3, N'Bàn 2', N' ')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (4, N'Bàn 3', N' ')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (6, N'Bàn 5', N' ')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (7, N'Bàn 6', N' ')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (8, N'Bàn 7', N' ')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (9, N'Bàn 8', N' ')
SET IDENTITY_INSERT [dbo].[TableFood] OFF
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT (N'NhatHuy') FOR [DisplayName]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [PassWord]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [Type]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT (getdate()) FOR [DateCheckIn]
GO
ALTER TABLE [dbo].[BillInfo] ADD  DEFAULT ((0)) FOR [count]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[FoodCategory] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Bàn chưa có tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Trống') FOR [status]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([idTable])
REFERENCES [dbo].[TableFood] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idBill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idFood])
REFERENCES [dbo].[Food] ([id])
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD FOREIGN KEY([idCategory])
REFERENCES [dbo].[FoodCategory] ([id])
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAccountByUserName]    Script Date: 8/4/2023 1:56:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetAccountByUserName]
@userName nvarchar(100)
AS
begin
	select * from Account where UserName = @userName
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDate]    Script Date: 8/4/2023 1:56:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetListBillByDate]
@checkIn date, @checkOut date
as
begin
	select t.name as [Tên bàn] , b.totalPrice as [Tổng tiền] , DateCheckIn as [Ngày vào], DateCheckOut as [Ngày ra], discount as [Giảm giá]
	from dbo.Bill as b, dbo.TableFood as t
	where DateCheckIn >= @checkIn and DateCheckOut <= @checkOut and b.status = 1
	and t.id = b.idTable
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDateReport]    Script Date: 8/4/2023 1:56:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetListBillByDateReport]
@checkIn date, @checkOut date
as
begin
	select t.name  , b.totalPrice  , DateCheckIn , DateCheckOut , discount 
	from dbo.Bill as b, dbo.TableFood as t
	where DateCheckIn >= @checkIn and DateCheckOut <= @checkOut and b.status = 1
	and t.id = b.idTable
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListFoodByCategory]    Script Date: 8/4/2023 1:56:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_GetListFoodByCategory]
@namef nvarchar(100)
as
begin
	select    b.name  , b.id , price
	from dbo.Food as b, dbo.FoodCategory as t
	
	where  @namef = t.name and t.id = b.idCategory 
	
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetTableList]    Script Date: 8/4/2023 1:56:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetTableList]
as select * from dbo.TableFood
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]    Script Date: 8/4/2023 1:56:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[USP_InsertBill]
@idTable Int
as
begin
	insert dbo.Bill (DateCheckIn, DateCheckOut, idTable, status, discount)
	values (GETDATE(), Null, @idTable,0,0)
	end
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfo]    Script Date: 8/4/2023 1:56:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_InsertBillInfo]
@idBill Int, @idFood int, @count int
as
begin

	declare @isEXitsBillInfo int
	declare @foodCount int = 1

	select @isEXitsBillInfo = id, @foodCount = b.count
	from dbo.BillInfo as b
	where idBill = @idBill and idFood = @idFood

	if(@isEXitsBillInfo > 0)
	begin
		declare @newCount int = @foodCount + @count
		if(@newCount > 0)
		update dbo.BillInfo set count = @foodCount + @count 
		where idFood = @idFood
		else
		delete dbo.BillInfo where idBill = @idBill and idFood = @idFood
		end
		else
		begin
			insert dbo.BillInfo(idBill, idFood, count)
			values (@idBill, @idFood, @count)
		end
		end
GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 8/4/2023 1:56:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_Login]
@userName nvarchar(100), @passWord nvarchar(100)
as
begin
	select * from dbo.Account WHERE UserName = @userName AND PassWord = @passWord
end
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount]    Script Date: 8/4/2023 1:56:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_UpdateAccount]
@userName NVARCHAR(100), @displayName NVARCHAR(100), @password NVARCHAR(100), @newPassword NVARCHAR(100)
AS
BEGIN
	DECLARE @isRightPass INT = 0
	
	SELECT @isRightPass = COUNT(*) FROM dbo.Account WHERE USERName = @userName AND PassWord = @password
	
	IF (@isRightPass = 1)
	BEGIN
		IF (@newPassword = NULL OR @newPassword = '')
		BEGIN
			UPDATE dbo.Account SET DisplayName = @displayName WHERE UserName = @userName
		END		
		ELSE
			UPDATE dbo.Account SET DisplayName = @displayName, PassWord = @newPassword WHERE UserName = @userName
	end
END
GO
USE [master]
GO
ALTER DATABASE [QuanLyDatBan] SET  READ_WRITE 
GO
