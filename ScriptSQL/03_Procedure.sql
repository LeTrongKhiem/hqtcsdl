USE [DormitoryManagement]
GO

-- Dùng để đăng nhập
CREATE  PROC USP_Login
	@USERNAME VARCHAR(16), 
	@PASSWORD VARCHAR(32)
AS
BEGIN
	DECLARE @PASSWORD_GENERATE VARCHAR(32)
	SET @PASSWORD_GENERATE = dbo.UFN_GenerateMD5(@PASSWORD)

	SELECT * FROM dbo.[USER] 
	WHERE USERNAME = @USERNAME COLLATE SQL_Latin1_General_CP1_CS_AS
	AND PASSWORD = @PASSWORD_GENERATE COLLATE SQL_Latin1_General_CP1_CS_AS -- Phân biệt chữ hoa chữ thường
END
GO

-- Dùng để lấy người dùng bằng username.
CREATE  PROC USP_GetUserByUsername
	@USERNAME VARCHAR(16)
AS
BEGIN
	SELECT * FROM dbo.[USER] WHERE USERNAME = @USERNAME
END
GO

-- Dùng để lấy người dùng bằng id.
CREATE  PROC USP_GetUserById
	@USER_ID BIGINT
AS
BEGIN
	SELECT * FROM dbo.[USER] WHERE USER_ID = @USER_ID
END
GO

-- Dùng để lấy sinh viên bằng id.
CREATE  PROC USP_GetStudentById
	@USER_ID BIGINT
AS
BEGIN
	SELECT * FROM dbo.STUDENT WHERE USER_ID = @USER_ID
END
GO

-- Dùng để lấy quản trị viên bằng id.
CREATE  PROC USP_GetAdminById
	@USER_ID BIGINT
AS
BEGIN
	SELECT * FROM dbo.ADMIN WHERE USER_ID = @USER_ID
END
GO

-- Dùng để lấy nhân viên bằng id.
CREATE  PROC USP_GetEmployeeById
	@USER_ID BIGINT
AS
BEGIN
	SELECT * FROM dbo.EMPLOYEE WHERE USER_ID = @USER_ID
END
GO

-- Dùng để lấy Province.
CREATE  PROC USP_GetListProvince
AS
BEGIN
	SELECT * FROM dbo.PROVINCE
END
GO

-- Dùng để lấy quận, huyện bằng tên tỉnh.
CREATE  PROC USP_GetListDistrictByProvinceName
	@PROVINCE_NAME NVARCHAR(20)
AS
BEGIN
	DECLARE @PROVINCE_ID VARCHAR(2)
	SET @PROVINCE_ID = dbo.UFN_GetProvinceIdByProvinceName(@PROVINCE_NAME)
	SELECT * FROM dbo.DISTRICT WHERE PROVINCE_ID = @PROVINCE_ID
END
GO

-- Dùng để lấy xã, phường bằng của huyện bằng tỉnh, huyện.
CREATE  PROC USP_GetListCommuneByProvinceAndDistrict
	@PROVINCE_NAME NVARCHAR(20),
	@DISTRICT_NAME NVARCHAR(40)
AS
BEGIN
	DECLARE @PROVINCE_ID VARCHAR(2)
	DECLARE @DISTRICT_ID VARCHAR(3)
	SET @PROVINCE_ID = dbo.UFN_GetProvinceIdByProvinceName(@PROVINCE_NAME)
	SET @DISTRICT_ID = dbo.UFN_GetDistrictIdByDictrictName(@DISTRICT_NAME,@PROVINCE_ID)
	SELECT * FROM dbo.COMMUNE WHERE DISTRICT_ID = @DISTRICT_ID
END
GO

-- Dùng để lấy danh sách quản trị viên.
CREATE  PROC USP_GetListAdmin
AS
BEGIN
	SELECT * FROM dbo.[USER] WHERE USER_TYPE = 'ADMIN'
END
GO

-- Dùng để thêm nhân viên
CREATE  PROC USP_AddEmployee
	@LAST_NAME NVARCHAR(40),
	@FIRST_NAME NVARCHAR(20),
	@DOB DATE,
	@GENDER NVARCHAR(5),
	@SSN VARCHAR(12),
	@PHONE_NUMBER_1 VARCHAR(15),
	@PHONE_NUMBER_2 VARCHAR(15),
	@EMAIL VARCHAR(40),
	@IMAGE_PATH VARCHAR(300),
	@USER_TYPE VARCHAR(10),
	@PROVINCE_NAME NVARCHAR(20),
	@DISTRICT_NAME NVARCHAR(40),
	@COMMUNE_NAME NVARCHAR(40),
	@STREET NVARCHAR(50),
	@STATR_DATE DATE, 
	@SALARY DECIMAL(19,4)
AS
BEGIN
	-- Tạo ra biến
	DECLARE @PROVINCE_ID VARCHAR(2)
	DECLARE @DISTRICT_ID VARCHAR(3)
	DECLARE @COMMUNE_ID VARCHAR(5)
	DECLARE @ADDRESS_ID BIGINT
	DECLARE @USER_ID BIGINT
	-- Gán dữ liệu cho 3 biến
	SET @PROVINCE_ID = dbo.UFN_GetProvinceIdByProvinceName(@PROVINCE_NAME)
	SET @DISTRICT_ID = dbo.UFN_GetDistrictIdByDictrictName(@DISTRICT_NAME,@PROVINCE_ID)
	SELECT @COMMUNE_ID = COMMUNE_ID FROM dbo.COMMUNE WHERE DISTRICT_ID = @DISTRICT_ID AND COMMUNE_NAME = @COMMUNE_NAME
	-- Thêm địa chỉ
	INSERT INTO dbo.[ADDRESS] (STREET,COMMNUNE_ID,DISTRICT_ID,PROVINCE_ID)
	VALUES (@STREET,@COMMUNE_ID,@DISTRICT_ID,@PROVINCE_ID)
	-- Lấy ra mã địa chỉ
	SET @ADDRESS_ID = ( SELECT TOP 1 ADDRESS_ID FROM dbo.[ADDRESS] ORDER BY ADDRESS_ID DESC)
	--Thêm vào bảng User
	INSERT INTO dbo.[USER] (LAST_NAME, FIRST_NAME, DOB, GENDER, SSN, ADDRESS_ID, PHONE_NUMBER_1, PHONE_NUMBER_2, EMAIL, IMAGE_PATH, USERNAME, PASSWORD, USER_TYPE, STATUS)
	VALUES (@LAST_NAME, @FIRST_NAME, @DOB,@GENDER, @SSN,@ADDRESS_ID, @PHONE_NUMBER_1, @PHONE_NUMBER_2, @EMAIL, @IMAGE_PATH, @SSN,'', @USER_TYPE, 1)
	-- Lấy ra User vừa được thêm vào
	SET @USER_ID = (SELECT TOP 1 USER_ID FROM dbo.[USER] ORDER BY USER_ID DESC)
	-- Thêm vào bảng nhân viên
	INSERT INTO dbo.[EMPLOYEE] (USER_ID, START_DATE, SALARY)
	VALUES(@USER_ID, @STATR_DATE, @SALARY)
END
GO

-- Dùng để thay đổi mật khẩu
CREATE  PROC USP_ChangePassword
	@USER_ID BIGINT,
	@OLDPASS VARCHAR(32),
	@NEWPASS VARCHAR(32)
AS
BEGIN
	DECLARE @newPassword VARCHAR(32), @username VARCHAR(16), @execQuery VARCHAR(100)
	SET @newPassword = dbo.UFN_GenerateMD5(@NEWPASS)
	UPDATE dbo.[USER] SET PASSWORD = @newPassword WHERE USER_ID = @USER_ID
	SELECT @username = CONCAT('_', USERNAME) FROM dbo.[USER] WHERE [USER_ID] = @USER_ID

	SET @execQuery = CONCAT('ALTER LOGIN ', @username, ' WITH PASSWORD = ''', @NEWPASS,''' OLD_PASSWORD = ''',@OLDPASS, '''')
	EXEC(@execQuery)
END
GO

-- Lấy danh sách phòng
CREATE  PROC [dbo].[USP_GetListRoom]
AS
BEGIN
    SELECT * FROM dbo.ROOM
END
GO

-- Lấy danh sách phòng bằng Sector_Id
CREATE  PROC [dbo].[USP_GetListRoomBySectorID]
	@Sector_ID VARCHAR(10)
AS
BEGIN
    SELECT * FROM dbo.ROOM
	WHERE dbo.ROOM.SECTOR_ID = @Sector_ID
END
GO

-- Lấy danh sách khu
CREATE  PROC [dbo].[USP_GetListSector]
AS
BEGIN
    SELECT * FROM dbo.SECTOR
END
GO

--Lấy danh sách dịch vụ
CREATE  PROC [dbo].[USP_GetListService]
AS
BEGIN
	SELECT * FROM dbo.SERVICE
END
GO

-- Lấy danh sách đơn vị của dịch vụ
CREATE  PROC [dbo].[GetUnitByServiceName]
	@Service_name NVARCHAR(60)
AS
BEGIN
    SELECT dbo.UNIT.UNIT_NAME, dbo.UNIT.UNIT_ID
    FROM dbo.SERVICE, dbo.UNIT 
    WHERE dbo.SERVICE.UNIT_ID = dbo.UNIT.UNIT_ID 
		AND SERVICE_NAME = @Service_name
END
GO

-- Dùng để thêm địa chỉ
CREATE  PROC [dbo].[USP_INSERT_ADDRESS]
(
	@Street NVARCHAR(50), 
	@Commune_Name NVARCHAR(50), 
	@District_Name NVARCHAR(50),
	@Province_Name NVARCHAR(50)
)
AS
BEGIN
    DECLARE @Commune_ID VARCHAR(5),
			@District_ID VARCHAR(3),
			@Province_ID VARCHAR(2)

	SELECT @Province_ID = dbo.UFN_GetProvinceIdByProvinceName(@Province_Name)
	SELECT @District_ID = dbo.UFN_GetDistrictIdByDictrictName(@District_Name, @Province_ID)
	SELECT @Commune_ID = dbo.UFN_GetCommuneidByCommuneName(@Commune_Name,@District_ID)

	INSERT INTO dbo.ADDRESS (STREET, COMMNUNE_ID, DISTRICT_ID, PROVINCE_ID)
	VALUES (@Street, @Commune_ID, @District_ID, @Province_ID )
END
GO

-- Thêm Bill
CREATE  PROC [dbo].[USP_InsetBill]
(
	@Employee_ID BIGINT, 
	@Room_Name NVARCHAR(10), 
	@Sector_Name NVARCHAR(50), 
	@Create_date DATETIME, 
	@Month INT, 
	@Year INT, 
	@Status BIT, 
	@total DECIMAL(19,4)
)
AS
BEGIN
	DECLARE @Room_ID NVARCHAR(10), @Sector_ID VARCHAR(10)
	SELECT @Sector_ID = dbo.SECTOR.SECTOR_ID FROM dbo.SECTOR WHERE dbo.SECTOR.SECTOR_NAME = @Sector_Name

	SELECT @Room_ID = dbo.ROOM.ROOM_ID FROM dbo.ROOM 
	WHERE dbo.ROOM.SECTOR_ID = @Sector_ID
		AND dbo.ROOM.ROOM_ID = @Room_Name 

    INSERT INTO dbo.BILL(EMPLOYEE_ID, ROOM_ID, CREATE_TIME, TOTAL, STATUS, MONTH, YEAR, Sector_ID) 
	VALUES (@Employee_ID, @Room_ID, @Create_date, @total, @Status, @Month, @Year, @Sector_ID)
END
GO

-- Thêm dịch vụ  vào chi tiết hóa đơn
CREATE  PROC [dbo].[USP_INSERT_SERVICE_BILL_DETAIL]
(
	@Service_Name NVARCHAR(20), 
	@Quantity INT,
	@Sector_Name VARCHAR(10), 
	@Room_ID NVARCHAR(10),
	@Month INT, 
	@Year INT, 
	@Unit_Name NVARCHAR(20), 
	@Total_Cost DECIMAL(19,4))
AS
BEGIN
    DECLARE @Bill_ID BIGINT, @Service_ID INT, @Old_Quantity INT,@New_Quantity INT, @Sector_ID NVARCHAR(20)
    SELECT @Bill_ID = (SELECT MAX(dbo.BILL.BILL_ID) FROM dbo.BILL)
    SELECT @Sector_ID = dbo.SECTOR.SECTOR_ID FROM dbo.SECTOR WHERE dbo.SECTOR.SECTOR_NAME = @Sector_Name
    SET @Month = @Month - 1
    IF(@Month = 0)
    BEGIN
        SET @Month = 12
        SET @Year = @Year -1
    END
    SELECT @Service_ID = dbo.SERVICE.SERVICE_ID FROM dbo.SERVICE WHERE dbo.SERVICE.SERVICE_NAME = @Service_Name
    SET @Old_Quantity = dbo.UFN_GetOldQuantityForNewBill(@Sector_ID,@Room_ID,@Month,@Year,@Service_Name)
    SET @New_Quantity = @Old_Quantity + @Quantity
    INSERT INTO dbo.BILL_DETAIL(BILL_ID, SERVICE_ID, OLD_QUANTITY, NEW_QUANTITY, UNIT_NAME,TOTAL_COST)
    VALUES
    (   @Bill_ID, -- BILL_ID - bigint
        @Service_ID, -- SERVICE_ID - int
        @Old_Quantity, -- OLD_QUANTITY - int
        @New_Quantity,  -- NEW_QUANTITY - int
        @Unit_Name,
        @Total_Cost
    )
END
GO

-- Thanh toán
CREATE  PROC [dbo].[USP_INSERT_PAYMENT]
(
	@Employee_ID INT, 
	@Paying_Date DATETIME, 
	@Amount DECIMAL(19,4),
	@Sector_Name VARCHAR(10),
	@Room_ID NVARCHAR(10), 
	@Month INT, 
	@Year INT
)
AS
BEGIN
    DECLARE @Bill_ID INT
	SET @Bill_ID = dbo.UFN_GetBillIdBySectornameRoomidMonthYear(@Sector_Name,@Room_ID,@Month,@Year)

	INSERT INTO dbo.PAYMENT (BILL_ID, EMPLOYEE_ID, PAYING_DATE, AMOUNT)
	VALUES (@Bill_ID, @Employee_ID, @Paying_Date, @Amount)
END
GO

-- Lấy danh sách sinh viên general
CREATE  PROC USP_GetListStudentGeneral
AS
BEGIN
	SELECT  * FROM dbo.UFN_GetListStudent(2)
END
GO

-- Lấy danh sách sinh viên general Alive
CREATE  PROC USP_GetListStudentGeneralALive
AS
BEGIN
    SELECT  * FROM dbo.UFN_GetListStudent(1)
END
GO

-- Lấy danh sách sinh viên general Alive
CREATE  PROC USP_GetListStudentGeneralGoingOut
AS
BEGIN
    SELECT * FROM dbo.UFN_GetListStudent(0)
END
GO

-- Tìm kiếm gần đúng sinh viên bởi userId
CREATE  PROC USP_GetListStudentGeneralByUserId(@USER_ID VARCHAR(10))
AS BEGIN

	SELECT * FROM dbo.V_STUDENTGENERAL WHERE dbo.[SearchLike](USER_ID) 
	LIKE N'%' + dbo.[SearchLike](@USER_ID) + '%'
END
GO

-- Tìm kiếm gần đúng sinh viên bởi StudentId
CREATE  PROC USP_GetListStudentGeneralByStudentId(@STUDENT_ID VARCHAR(15))
AS BEGIN

	SELECT * FROM dbo.V_STUDENTGENERAL WHERE dbo.[SearchLike](STUDENT_ID) 
	LIKE N'%' + dbo.[SearchLike](@STUDENT_ID) + '%'
END
GO

-- Tìm kiếm gần đúng sinh viên bởi FullName
CREATE  PROC USP_GetListStudentGeneralByFullName(@FULL_NAME NVARCHAR(100))
AS BEGIN

	SELECT * FROM dbo.V_STUDENTGENERAL WHERE dbo.[SearchLike](FULL_NAME) 
	LIKE N'%' + dbo.[SearchLike](@FULL_NAME) + '%'
END
GO

-- Tìm kiếm gần đúng sinh viên bởi Gender
CREATE  PROC USP_GetListStudentGeneralByGender(@GENDER NVARCHAR(10))
AS BEGIN

	SELECT * FROM dbo.V_STUDENTGENERAL WHERE dbo.[SearchLike](GENDER) 
	LIKE N'%' + dbo.[SearchLike](@GENDER) + '%'
END
GO

-- Tìm kiếm gần đúng sinh viên bởi Ssn
CREATE  PROC USP_GetListStudentGeneralBySsn (@SSN VARCHAR(12))
AS BEGIN

	SELECT * FROM dbo.V_STUDENTGENERAL WHERE dbo.[SearchLike](SSN) 
	LIKE N'%' + dbo.[SearchLike](@SSN) + '%'
END
GO

-- Tìm kiếm gần đúng sinh viên bởi Gender
CREATE  PROC USP_GetListStudentGeneralByCollegeName(@COLLEGE_NAME NVARCHAR(150))
AS BEGIN

	SELECT * FROM dbo.V_STUDENTGENERAL WHERE dbo.[SearchLike](COLLEGE_NAME) 
	LIKE N'%' + dbo.[SearchLike](@COLLEGE_NAME) + '%'
END
GO

-- Lấy danh sách user
CREATE  PROC USP_GetListUser
AS BEGIN
	SELECT * FROM dbo.[USER]
END
GO

-- Lấy danh sách Room_Registration
CREATE  PROC USP_GetListRoomRegistration
AS BEGIN
	SELECT * FROM dbo.V_ROOM_REGISTRATION WHERE dbo.V_ROOM_REGISTRATION.STATUS = 1
END
GO

-- Lấy danh sách Room_Registration bằng StudentId
CREATE  PROC USP_GetListRoomRegistrationByStudentId(@STUDENT_ID VARCHAR(15))
AS BEGIN
	SELECT * FROM dbo.V_ROOM_REGISTRATION WHERE dbo.V_ROOM_REGISTRATION.STATUS = 1 AND dbo.[SearchLike]([Student Id]) 
	LIKE N'%' + dbo.[SearchLike](@STUDENT_ID) + '%'
END
GO

-- Lấy danh sách Room_Registration bằng StudentName
CREATE  PROC USP_GetListRoomRegistrationByStudentName(@STUDENT_NAME NVARCHAR(100))
AS BEGIN
	SELECT * FROM dbo.V_ROOM_REGISTRATION 
	WHERE dbo.V_ROOM_REGISTRATION.STATUS = 1 
		AND dbo.[SearchLike]([Student Name]) LIKE N'%' + dbo.[SearchLike](@STUDENT_NAME) + '%'
END
GO

-- Lấy danh sách Room_Registration bằng Sector và room
CREATE  PROC USP_GetListRoomRegistrationBySectorAndRoom(
	@SECTOR_NAME NVARCHAR(50),
	@ROOM_ID NVARCHAR(10)
	)
AS BEGIN
	SELECT * FROM dbo.V_ROOM_REGISTRATION WHERE Building = @SECTOR_NAME AND Room = @ROOM_ID
END
GO
-- Lấy danh sách đơn vị dịch vụ
CREATE  PROC [dbo].[USP_GetListServiceUnit]
AS
BEGIN
    SELECT *
	FROM dbo.V_SERVICE_UNIT
	WHERE STATUS = 1
END
GO

-- Lấy danh sách College
CREATE  PROC USP_GetListCollege
AS
BEGIN
    SELECT *
	FROM dbo.COLLEGE
END
GO
-- Thêm bảo hiểm
CREATE  PROC USP_INSERT_INSURANCE
(@Insurence_ID VARCHAR(15))
AS
BEGIN
    INSERT INTO dbo.INSURANCE
    (
        INSURANCE_ID,
        BASE_PRACTICE,
        REGISTRATION_DATE,
        DURATION
    )
    VALUES
    (   @Insurence_ID,        
        NULL,       
        NULL, 
        NULL
        )
END
GO
--- THÊM USER - STUDENT
CREATE  PROC USP_INSERT_USER_STUDENT
(
	@LAST_NAME NVARCHAR(40),
	@FIRST_NAME NVARCHAR(20),
	@DOB DATE,@GENDER NVARCHAR(5),
	@SSN VARCHAR(12),
	@PHONE_NUMBER_1 VARCHAR(15),
	@PHONE_NUMBER_2 VARCHAR(15),
	@EMAIL VARCHAR(40),
	@IMAGE_PATH VARCHAR(300),
	@USER_TYPE VARCHAR(10),
	@STATUS BIT
)
AS
BEGIN
	DECLARE @ADDRESS_ID INT
	SELECT @ADDRESS_ID = (SELECT MAX(ADDRESS_ID) FROM dbo.ADDRESS)
	INSERT INTO dbo.[USER] (
	    LAST_NAME,
	    FIRST_NAME,
	    DOB,
	    GENDER,
	    SSN,
	    ADDRESS_ID,
	    PHONE_NUMBER_1,
	    PHONE_NUMBER_2,
	    EMAIL,
	    IMAGE_PATH,
	    USERNAME,
	    PASSWORD,
	    USER_TYPE,
	    STATUS
	)
	VALUES
	(   @LAST_NAME,			-- LAST_NAME - nvarchar(40)
	    @FIRST_NAME,		-- FIRST_NAME - nvarchar(20)
	    @DOB,				-- DOB - date
	    @GENDER,			-- GENDER - nvarchar(5)
	    @SSN,				-- SSN - varchar(12)
	    @ADDRESS_ID,        -- ADDRESS_ID - bigint
	    @PHONE_NUMBER_1,    -- PHONE_NUMBER_1 - varchar(15)
	    @PHONE_NUMBER_2,    -- PHONE_NUMBER_2 - varchar(15)
	    @EMAIL,				-- EMAIL - varchar(40)
	    @IMAGE_PATH,        -- IMAGE_PATH - varchar(300)
	    @SSN,				-- USERNAME - varchar(16)
	    'student',			-- PASSWORD - varchar(32)
	    @USER_TYPE,			-- USER_TYPE - varchar(10)
	    @STATUS				-- STATUS - bit
	    )
END
GO

-- THÊM SINH VIÊN
CREATE  PROC USP_INSERT_STUDENT
(
	@STUDENT_ID VARCHAR(15), 
	@COLLEGE_NAME NVARCHAR(50),
	@FACULTY NVARCHAR(50), 
	@MAJORS NVARCHAR(50),
	@INSURANCE_ID VARCHAR(15),
	@STATUS_REGISTRATION_ROOM BIT
)
AS
BEGIN
    DECLARE @USER_ID BIGINT, @COLLEGE_ID INT
	SELECT @USER_ID = (SELECT MAX(USER_ID) FROM dbo.[USER])
	SELECT @COLLEGE_ID = dbo.COLLEGE.COLLEGE_ID FROM dbo.COLLEGE WHERE dbo.COLLEGE.COLLEGE_NAME = @COLLEGE_NAME
	INSERT INTO dbo.STUDENT
	(
	    USER_ID,
	    STUDENT_ID,
	    COLLEGE_ID,
	    FACULTY,
	    MAJORS,
	    INSURANCE_ID,
	    STATUS_REGISTRATION_ROOM
	)
	VALUES
	(   @USER_ID,   -- USER_ID - bigint
	    @STUDENT_ID,  -- STUDENT_ID - varchar(15)
	    @COLLEGE_ID,   -- COLLEGE_ID - int
	    @FACULTY, -- FACULTY - nvarchar(50)
	    @MAJORS, -- MAJORS - nvarchar(50)
	    @INSURANCE_ID,  -- INSURANCE_ID - varchar(15)
	    @STATUS_REGISTRATION_ROOM -- STATUS_REGISTRATION_ROOM - bit
	    )
END
GO

--USP_INSERT_ROOMREGISTRATION
CREATE  PROC USP_INSERT_ROOMREGISTRATION
(
	@EMPLOYEE_ID BIGINT, 
	@SSN VARCHAR(12), 
	@SECTOR_NAME NVARCHAR(50), 
	@ROOM_ID NVARCHAR(10), 
	@START_DAY DATETIME, 
	@SEMESTER INT, 
	@ACADEMIC_YEAR INT, 
	@DURATION NVARCHAR(20), 
	@STATUS BIT
)
AS
BEGIN
    DECLARE @SECTOR_ID VARCHAR(10)
	SELECT @SECTOR_ID = dbo.UFN_Get_SectorID_By_SectorName(@SECTOR_NAME)

	INSERT INTO dbo.ROOM_REGISTRATION (SSN, ROOM_ID, EMPLOYEE_ID, SECTOR_ID, START_DATE, SEMESTER, ACADEMIC_YEAR, DURATION, STATUS)
	VALUES (@SSN, @ROOM_ID, @EMPLOYEE_ID, @SECTOR_ID,  @START_DAY, @SEMESTER, @ACADEMIC_YEAR,  @DURATION, @STATUS)
END
GO

-- Lấy danh sách Bill
CREATE  PROC USP_GetListBillView
AS
BEGIN
    SELECT * FROM dbo.[V_BILL]
END
GO

-- Lấy danh sách Bill View bằng Sector và room
CREATE  PROC USP_GetListBillViewBySectorAndRoom
(
	@SECTOR_NAME NVARCHAR(50),
	@ROOM_ID NVARCHAR(10)
)
AS BEGIN
	SELECT * FROM dbo.[V_BILL] WHERE Sector = @SECTOR_NAME AND Room = @ROOM_ID
END
GO


-- Lấy danh sách Bill View từ tháng này, năm ngày đến tháng kia năm kia
CREATE  PROC USP_GetListBillViewByDate
(
	@MONTH_FROM INT,
	@YEAR_FROM INT,
	@MONTH_TO INT,
	@YEAR_TO INT
)
AS 
	BEGIN
		IF(@YEAR_FROM > @YEAR_TO)
		BEGIN
			SELECT * FROM dbo.[V_BILL] WHERE Year > @YEAR_FROM AND YEAR < @YEAR_TO
		END

		IF (@YEAR_FROM = @YEAR_TO)
		BEGIN
			SELECT * FROM dbo.[V_BILL] WHERE Month > @MONTH_FROM - 1 AND Month < @MONTH_TO + 1 AND Year = @YEAR_TO
		END

		IF (@YEAR_FROM < @YEAR_TO)
		BEGIN
			SELECT * FROM dbo.[V_BILL] WHERE Month > @MONTH_FROM - 1 AND Month < 13 AND Year = @YEAR_FROM
			UNION 
			SELECT * FROM dbo.[V_BILL] WHERE Month > 0 AND Month < @MONTH_TO + 1 AND Year = @YEAR_TO
			UNION
			SELECT * FROM dbo.[V_BILL] WHERE Month > 0 AND Month < 13 AND Year > @YEAR_FROM AND Year < @YEAR_TO
		END
	END
GO


-- Lấy sinh viên bằng mã
CREATE  PROC USP_GetListStudentView (@USER_ID INT)
AS
BEGIN
    SELECT * FROM dbo.[V_STUDENT] WHERE USER_ID = @USER_ID
END
GO

-- Lấy danh sách nhân viên
CREATE  PROC USP_GetListEmployeeView
AS
BEGIN
    SELECT * FROM dbo.V_EMPLOYEE
END
GO

-- Lấy 1 nhân viên
CREATE  PROC USP_GetEmployeeView (@USER_ID INT)
AS
BEGIN
    SELECT * FROM dbo.V_EMPLOYEE WHERE USER_ID = @USER_ID
END
GO

-- Dùng để sửa nhân viên
CREATE  PROC USP_EditEmployee
	@LAST_NAME NVARCHAR(40),
	@FIRST_NAME NVARCHAR(20),
	@DOB DATE,
	@GENDER NVARCHAR(5),
	@SSN VARCHAR(12),
	@PHONE_NUMBER_1 VARCHAR(15),
	@PHONE_NUMBER_2 VARCHAR(15),
	@EMAIL VARCHAR(40),
	@IMAGE_PATH VARCHAR(300),
	@USER_TYPE VARCHAR(10),
	@PROVINCE_NAME NVARCHAR(20),
	@DISTRICT_NAME NVARCHAR(40),
	@COMMUNE_NAME NVARCHAR(40),
	@STREET NVARCHAR(50),
	@USER_ID BIGINT
AS
BEGIN
	-- Tạo ra biến
	DECLARE @PROVINCE_ID VARCHAR(2)
	DECLARE @DISTRICT_ID VARCHAR(3)
	DECLARE @COMMUNE_ID VARCHAR(5)
	DECLARE @ADDRESS_ID BIGINT

	-- Gán dữ liệu cho 3 biến
	SET @PROVINCE_ID = dbo.UFN_GetProvinceIdByProvinceName(@PROVINCE_NAME)
	SET @DISTRICT_ID = dbo.UFN_GetDistrictIdByDictrictName(@DISTRICT_NAME,@PROVINCE_ID)
	SELECT @COMMUNE_ID = COMMUNE_ID FROM dbo.COMMUNE WHERE DISTRICT_ID = @DISTRICT_ID AND COMMUNE_NAME = @COMMUNE_NAME
	
	-- Sửa địa chỉ
	SELECT @ADDRESS_ID = ADDRESS_ID FROM dbo.[USER] WHERE dbo.[USER].USER_ID = @USER_ID
	UPDATE dbo.ADDRESS SET STREET =@STREET, PROVINCE_ID = @PROVINCE_ID, DISTRICT_ID = @DISTRICT_ID, COMMNUNE_ID = @COMMUNE_ID
	WHERE ADDRESS_ID = @ADDRESS_ID

	-- Sửa tài khoản
	UPDATE dbo.[USER] SET
		LAST_NAME =@LAST_NAME,
		FIRST_NAME = @FIRST_NAME,
		DOB = @DOB,
		GENDER = @GENDER,
		ADDRESS_ID =@ADDRESS_ID,
		PHONE_NUMBER_1 = @PHONE_NUMBER_1,
		PHONE_NUMBER_2 = @PHONE_NUMBER_2,
		EMAIL = @EMAIL,
		IMAGE_PATH  = @IMAGE_PATH,
		SSN = @SSN
	WHERE USER_ID = @USER_ID
END
GO

-- Cập nhật lương cho nhân viên
CREATE  PROC USP_UpdateSalary
(
	@USER_ID INT,
	@SALARY DECIMAL(19,4)
)
AS
BEGIN
    UPDATE dbo.EMPLOYEE SET SALARY = @SALARY WHERE USER_ID = @USER_ID
END
GO

-- Lấy danh sách roomview
CREATE  PROC USP_GetListRoomView
AS
BEGIN
    SELECT * FROM V_GetRoomSectorType ORDER BY SECTOR_NAME ASC
END
GO

-- Lấy danh sách service
CREATE  PROC [dbo].[USP_GetServicesInfo]
AS
BEGIN
	SELECT s.SERVICE_ID, s.SERVICE_NAME, s.PRICE_PER_UNIT, u.UNIT_NAME
	FROM DBO.SERVICE s INNER JOIN dbo.UNIT u ON s.UNIT_ID = u.UNIT_ID
	WHERE s.STATUS = 1;
END
GO

-- cập nhật địa chỉ
CREATE  PROC USP_UpdateAddRess
(
	@AddRess_ID INT,
	@Street NVARCHAR(50), 
	@Commune_Name NVARCHAR(50), 
	@District_Name NVARCHAR(50),
	@Province_Name NVARCHAR(50)
)
AS
BEGIN
	DECLARE @Commune_ID VARCHAR(5),
			@District_ID VARCHAR(3),
			@Province_ID VARCHAR(2)

	SELECT @Province_ID = dbo.UFN_GetProvinceIdByProvinceName(@Province_Name)
	SELECT @District_ID = dbo.UFN_GetDistrictIdByDictrictName(@District_Name, @Province_ID)
	SELECT @Commune_ID = dbo.UFN_GetCommuneidByCommuneName(@Commune_Name, @District_ID)

	UPDATE dbo.ADDRESS
	SET 
		dbo.ADDRESS.STREET = @Street,
		dbo.ADDRESS.COMMNUNE_ID = @Commune_ID,
		dbo.ADDRESS.DISTRICT_ID = @District_ID,
		dbo.ADDRESS.PROVINCE_ID = @Province_ID
	WHERE dbo.ADDRESS.ADDRESS_ID = @AddRess_ID;
END
GO

-- Cập nhật trường đại học
CREATE  PROC USP_UpdateStudentCollege
(
	@User_ID INT,
	@College_Name NVARCHAR(50),
	@Faculty NVARCHAR(50),
	@Major NVARCHAR(50)
)
AS
BEGIN
    DECLARE @College_ID INT
	SELECT @College_ID = dbo.COLLEGE.COLLEGE_ID FROM dbo.COLLEGE WHERE dbo.COLLEGE.COLLEGE_NAME = @College_Name

	UPDATE dbo.STUDENT
	SET dbo.STUDENT.COLLEGE_ID = @College_ID,
		dbo.STUDENT.FACULTY = @Faculty,
		dbo.STUDENT.MAJORS = @Major
	WHERE dbo.STUDENT.USER_ID = @User_ID;
END
GO


-- Hủy đăng kí phòng
CREATE  PROC USP_UpdateRoomRegistration(@Ssn VARCHAR(15))
AS
BEGIN
    UPDATE dbo.ROOM_REGISTRATION
	SET dbo.ROOM_REGISTRATION.STATUS = 0
	WHERE dbo.ROOM_REGISTRATION.SSN = @Ssn;
END
GO

-- cập nhật dịch vụ
CREATE  PROC USP_UpdateService
(
	@Service_Name NVARCHAR(50),
	@Price DECIMAL (19,4)
)
AS
BEGIN
    UPDATE dbo.SERVICE
	SET dbo.SERVICE.PRICE_PER_UNIT = @Price
	WHERE dbo.SERVICE.SERVICE_NAME = @Service_Name;
END
GO

--Insert Unit
CREATE  PROC USP_InsertUnit (@Unit_Name NVARCHAR(20))
AS
BEGIN
    INSERT INTO dbo.UNIT (UNIT_NAME)
    VALUES (@Unit_Name)
END
GO

--Insert service
CREATE  PROC USP_InsertService
(
	@Service_Name NVARCHAR(20), 
	@Price_Per_Unit DECIMAL(19,4), 
	@Unit_Name NVARCHAR(20)
)
AS
BEGIN
	DECLARE @Unit_ID INT
    EXEC dbo.USP_InsertUnit @Unit_Name = @Unit_Name
    SELECT @Unit_ID = (SELECT MAX(dbo.UNIT.UNIT_ID) FROM dbo.UNIT)

	INSERT INTO dbo.SERVICE (SERVICE_NAME, UNIT_ID, PRICE_PER_UNIT, STATUS)
	VALUES (@Service_Name, @Unit_ID, @Price_Per_Unit, 1)
END
GO

--Xóa Service
CREATE  PROC USP_UnableService (@Service_Name NVARCHAR(20))
AS
BEGIN
    UPDATE dbo.SERVICE
	SET dbo.SERVICE.STATUS = 0
	WHERE dbo.SERVICE.SERVICE_NAME = @Service_Name;
END
GO

--Tạo Proc LoadRoomRegistrationByStudentID
CREATE  PROC USP_LoadRoomRegistrationByStudentID (@Student_ID VARCHAR(15))
AS
BEGIN
    DECLARE @User_ID BIGINT,
			@SSN VARCHAR(15)
	SELECT @User_ID = dbo.STUDENT.USER_ID FROM dbo.STUDENT WHERE dbo.STUDENT.STUDENT_ID = @Student_ID
	SELECT @SSN = dbo.[USER].SSN FROM dbo.[USER] WHERE dbo.[USER].USER_ID = @User_ID
	SELECT * FROM dbo.ROOM_REGISTRATION WHERE dbo.ROOM_REGISTRATION.SSN = @SSN
END
GO

-- Tạo Proc tạo login - user -Thêm vào role
CREATE  PROC USP_CREATE_LOGIN_USER
(
	@Role_Name VARCHAR(50),
	@Login_Name VARCHAR(50), 
	@Password_Login VARCHAR(50)
)
AS
BEGIN
    DECLARE @Login_UserName VARCHAR(50),
			@QueryLogin VARCHAR(100),
			@QueryUser VARCHAR(100)

	SET @Login_UserName = CONCAT('_', @Login_Name)
	SET @QueryLogin ='CREATE LOGIN ' + @Login_UserName + ' WITH PASSWORD = ' + QUOTENAME(@Password_Login, '''')
	SET @QueryUser = CONCAT('CREATE USER ', @Login_UserName, ' FOR LOGIN ', @Login_UserName);

	EXEC (@QueryLogin)
	EXEC (@QueryUser)

	EXEC sys.sp_addrolemember @rolename = @Role_Name, 
	                          @membername = @Login_UserName 
END
GO


--GetStudentInfo
CREATE  PROC USP_GetStudentInfo (@SSN VARCHAR(15))
AS
BEGIN
    SELECT STU.STUDENT_ID, 
		   U.FIRST_NAME, U.LAST_NAME, U.DOB, U.GENDER, U.SSN,
		   STU.INSURANCE_ID,
		   A.STREET, A.PROVINCE_ID, A.DISTRICT_ID, A.COMMNUNE_ID, 
		   U.PHONE_NUMBER_1, U.PHONE_NUMBER_2, U.EMAIL, 
		   STU.COLLEGE_ID, STU.FACULTY, STU.MAJORS
	FROM dbo.[USER] AS U INNER JOIN dbo.STUDENT AS STU ON U.USER_ID = STU.USER_ID
					INNER JOIN dbo.INSURANCE ON INSURANCE.INSURANCE_ID = STU.INSURANCE_ID
					INNER JOIN dbo.ADDRESS AS A ON A.ADDRESS_ID = U.ADDRESS_ID
					AND U.SSN = @SSN
END
GO

--Proc Khóa User Student
CREATE  PROC USP_LockUserStudent (@SSN VARCHAR(15))
AS
BEGIN
    UPDATE dbo.[USER]
	SET dbo.[USER].STATUS = 0
	WHERE dbo.[USER].SSN = @SSN;
END
GO

-- Lấy tên tỉnh bằng mã tỉnh
CREATE  PROC USP_GetProvinceNameByProvinceID (@Province_ID VARCHAR(2))
AS
BEGIN
    SELECT P.PROVINCE_NAME FROM dbo.PROVINCE AS P WHERE P.PROVINCE_ID = @Province_ID
END
GO

-- Lấy tên huyện
CREATE  PROC USP_GetDistrictNameByDistrictID (@District_ID VARCHAR(3))
AS
BEGIN
    SELECT D.DISTRICT_NAME FROM dbo.DISTRICT AS D WHERE D.DISTRICT_ID = @District_ID
END
GO

-- lấy tên xã
CREATE  PROC USP_GetCommuneNameByCommuneID (@Commune_ID VARCHAR(5))
AS
BEGIN
    SELECT C.COMMUNE_NAME FROM dbo.COMMUNE AS C WHERE C.COMMUNE_ID = @Commune_ID
END
GO

-- Lấy tên trường đại học
CREATE  PROC USP_GetCollegeNameByCollegeID (@College_ID INT)
AS
BEGIN
    SELECT C.COLLEGE_NAME FROM dbo.COLLEGE AS C WHERE C.COLLEGE_ID = @College_ID
END
GO

-- Xóa sinh viên
CREATE  PROC USP_DropLoginDropUserStudent (@Email VARCHAR(50))
AS
BEGIN
    DECLARE @QueryDropLogin VARCHAR(100),
			@QueryDropUser VARCHAR(100)

	SET @QueryDropLogin = 'DROP LOGIN ' + @Email
	SET @QueryDropUser = 'DROP USER ' + @Email

	EXEC(@QueryDropLogin)
	EXEC(@QueryDropUser)
END
GO