USE [DormitoryManagement]
GO

-- Khu
INSERT INTO [dbo].[SECTOR] ([SECTOR_ID], [SECTOR_NAME])
VALUES 
	('A', N'Khu A'),
	('B', N'Khu B'),
	('C', N'Khu C'),
	('D', N'Khu D')
GO

-- Loại phòng
INSERT INTO [dbo].[ROOM_TYPE] ( [ROOM_TYPE_NAME], [PRICE], [AREA], [CAPACITY] )
VALUES
	(N'Phòng đôi', 200000, 25, 2),		-- id 1
	(N'Phòng sáu', 150000, 85, 6),		-- id 2
	(N'Phòng tám', 100000, 100, 8),		-- id 3
	(N'Phòng mười hai', 90000, 140, 12)	-- id 4
GO

-- Phòng
INSERT INTO [dbo].[ROOM] ([ROOM_ID], [SECTOR_ID], [ROOM_TYPE_ID] )
VALUES
	(N'A101', 'A', 1), (N'A102', 'A', 1), (N'A103', 'A', 1),
	(N'B101', 'B', 2), (N'B102', 'B', 2),
	(N'C101', 'C', 3), (N'C102', 'C', 3), (N'C103', 'C', 3), (N'C104', 'C', 3),
	(N'D101', 'D', 4)
GO

-- đơn vị
INSERT INTO dbo.UNIT (UNIT_NAME)
VALUES 
	(N'KWh'),	-- id 1
	(N'Khối'),	-- id 2
	(N'Lần')	-- id 3
GO

-- Dịch vụ
INSERT INTO [dbo].[SERVICE] ([SERVICE_NAME], [UNIT_ID], [PRICE_PER_UNIT], [STATUS])
VALUES
	(N'Điện', 1, 3000, 1),
	(N'Nước', 2, 2500, 1),
	(N'Đổ rác', 3, 10000, 1)
GO


-- start insert Admin
INSERT INTO [dbo].[ADDRESS] ([STREET], [COMMNUNE_ID], [DISTRICT_ID], [PROVINCE_ID])
VALUES
	(N'1 Võ Văn Ngân', '00001', '001', '79'),
    (N'2 Đường ABC', '26764', '761', '79')
GO

INSERT INTO dbo.[USER] (LAST_NAME, FIRST_NAME, DOB, GENDER, SSN, ADDRESS_ID, PHONE_NUMBER_1, PHONE_NUMBER_2, EMAIL, USERNAME, PASSWORD, USER_TYPE, STATUS)
VALUES
	(N'Admin', N'01','20000520', N'Nam', 'admin01', 1, '00', '01', 'admin01@email.com', 'admin01', 'C20AD4D76FE97759AA27A0C99BFF6710', 'ADMIN', 1),
	(N'Admin', N'02','20000520', N'Nữ', 'admin02', 2, '02', '03', 'admin02@email.com', 'admin02', 'C20AD4D76FE97759AA27A0C99BFF6710', 'ADMIN', 1),
	(N'Admin', N'02','20000520', N'Nam', 'an', 2, '02', '03', 'admin02@email.com', 'admin02', 'C20AD4D76FE97759AA27A0C99BFF6710', 'EMPLOYEE', 1)
GO
EXEC dbo.USP_CREATE_LOGIN_USER @Role_Name = 'ADMIN', @Login_Name = 'admin01', @Password_Login = '12'
EXEC dbo.USP_CREATE_LOGIN_USER @Role_Name = 'ADMIN', @Login_Name = 'admin02', @Password_Login = '12'

INSERT INTO [dbo].[EMPLOYEE] ( [USER_ID], [START_DATE], [SALARY])
VALUES (1, GETDATE(), 0), (2, GETDATE(), 0)
-- end insert admin


---- Insert Employee
EXEC dbo.USP_AddEmployee @LAST_NAME = N'Lâm', @FIRST_NAME = N'Khánh', @DOB = '2000-09-02', @GENDER = N'Nam',
	                     @SSN = '072200004503', @PHONE_NUMBER_1 = '0949494029', @PHONE_NUMBER_2 = '0969696029',
	                     @EMAIL = 'quockhanhdev@gmail.com', @IMAGE_PATH = '', @USER_TYPE = 'EMPLOYEE',
	                     @PROVINCE_NAME = N'Tây Ninh', @DISTRICT_NAME = N'Gò Dầu', @COMMUNE_NAME = N'Bàu Đồn', @STREET = N'EM 01',
	                     @STATR_DATE = '2020-05-23', @SALARY = 1840000
GO

EXEC dbo.USP_AddEmployee @LAST_NAME = N'Nguyễn Trần', @FIRST_NAME = N'Phúc', @DOB = '1990-12-25', @GENDER = N'Nam',
	                     @SSN = '212389956', @PHONE_NUMBER_1 = '0385625025', @PHONE_NUMBER_2 = '09004568658',
	                     @EMAIL = 'phucnt@gmail.com', @IMAGE_PATH = '', @USER_TYPE = 'EMPLOYEE',
	                     @PROVINCE_NAME = N'Tây Ninh', @DISTRICT_NAME = N'Dương Minh Châu', @COMMUNE_NAME = N'Cầu Khởi', @STREET = N'EM 02',
	                     @STATR_DATE = '2020-07-23', @SALARY = 863586
GO


EXEC dbo.USP_AddEmployee @LAST_NAME = N'Hồ Huy', @FIRST_NAME = N'Hoàng', @DOB = '2000-03-31', @GENDER = N'Nữ',
	                     @SSN = '212860117', @PHONE_NUMBER_1 = '000003', @PHONE_NUMBER_2 = '000004',
	                     @EMAIL = 'thienly@gmail.com', @IMAGE_PATH = '', @USER_TYPE = 'EMPLOYEE',
	                     @PROVINCE_NAME = N'Hồ Chí Minh', @DISTRICT_NAME = N'Thủ Đức', @COMMUNE_NAME = N'Linh Chiểu', @STREET = N'EM 03',
	                     @STATR_DATE = '2020-02-23', @SALARY = 1840000
GO


EXEC dbo.USP_AddEmployee @LAST_NAME = N'Nguyễn Huỳnh Minh', @FIRST_NAME = N'Tiến', @DOB = '2000-03-14', @GENDER = N'Nữ',
	                     @SSN = '342022600', @PHONE_NUMBER_1 = '000001', @PHONE_NUMBER_2 = '000002',
	                     @EMAIL = 'tiennhm@gmail.com', @IMAGE_PATH = '', @USER_TYPE = 'EMPLOYEE',
	                     @PROVINCE_NAME = N'Hồ Chí Minh', @DISTRICT_NAME = N'Thủ Đức', @COMMUNE_NAME = N'Linh Chiểu', @STREET = N'EM 03',
	                     @STATR_DATE = '2020-04-10', @SALARY = 1840000
GO

EXEC USP_CREATE_LOGIN_USER  'EMPLOYEE','072200004503', 'dbms000000'
EXEC dbo.USP_CREATE_LOGIN_USER @Role_Name = 'EMPLOYEE', @Login_Name = '212389956', @Password_Login = 'dbms000000'
EXEC dbo.USP_CREATE_LOGIN_USER @Role_Name = 'EMPLOYEE', @Login_Name = '212860117', @Password_Login = 'dbms000000'
EXEC dbo.USP_CREATE_LOGIN_USER @Role_Name = 'EMPLOYEE', @Login_Name = '342022600', @Password_Login = 'dbms000000'