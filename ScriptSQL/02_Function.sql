USE [DormitoryManagement]
GO

-- Hash MD5
CREATE FUNCTION UFN_GenerateMD5 (@PlantText VARCHAR(32))
	RETURNS VARCHAR(32)
AS
BEGIN
	RETURN CONVERT(VARCHAR(32), HashBytes('MD5', @PlantText), 2)
END
GO

-- Hàm lấy mã tỉnh bằng tên tỉnh:
CREATE FUNCTION UFN_GetProvinceIdByProvinceName (@PROVINCE_NAME NVARCHAR(20))
	RETURNS VARCHAR(2)
AS
BEGIN
	DECLARE @PROVINCE_ID VARCHAR(2)
	SELECT @PROVINCE_ID = PROVINCE_ID FROM dbo.PROVINCE 
	WHERE PROVINCE_NAME = @PROVINCE_NAME
	RETURN @PROVINCE_ID
END
GO

-- Hàm lấy mã huyện bằng tên huyện và mã tỉnh
CREATE FUNCTION UFN_GetDistrictIdByDictrictName
(
	@DISTRICT_NAME NVARCHAR(40), 
	@PROVINCE_ID VARCHAR(2)
)
	RETURNS VARCHAR(3)
AS
BEGIN
	DECLARE @DISTRICT_ID VARCHAR(3)
	SELECT @DISTRICT_ID = DISTRICT_ID FROM dbo.DISTRICT 
	WHERE DISTRICT_NAME = @DISTRICT_NAME AND PROVINCE_ID = @PROVINCE_ID
	RETURN @DISTRICT_ID
END
GO

-- Hàm tạo mật khẩu mặt định
CREATE FUNCTION UFN_NewPassword 
(
	@lastPassword VARCHAR(32), 
	@preFix VARCHAR(4), 
	@size INT
)
RETURNS VARCHAR(10)
AS
	BEGIN
	    IF (@lastPassword = '')
			SET @lastPassword = @preFix + REPLICATE(0, @size - LEN(@preFix))
		DECLARE @newPassword VARCHAR(32)
		SET @lastPassword = LTRIM(RTRIM(@lastPassword))
		SET @size = @size - LEN(@preFix)
		SET @newPassword = @preFix + REPLICATE(0, @size - LEN(@preFix))
		RETURN @newPassword
	END
GO


-- Lấy Commune_ID từ Commune_Name
CREATE FUNCTION UFN_GetCommuneidByCommuneName
(
	@Commune_Name NVARCHAR(40),
	@Distric_ID VARCHAR(3)
)
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @COMMUNE_ID VARCHAR(5)
	SELECT @COMMUNE_ID = COMMUNE_ID FROM dbo.COMMUNE WHERE COMMUNE_NAME = @Commune_Name AND DISTRICT_ID = @Distric_ID
	RETURN @COMMUNE_ID
END
GO


-- Lấy Bill ID -- GET_BILL_ID_BY_SECTORNAME_ROOMID_MONTH_YEAR
CREATE FUNCTION UFN_GetBillIdBySectornameRoomidMonthYear
(
	@Sector_Name VARCHAR(10),
	@Room_ID NVARCHAR(10), 
	@Month INT, 
	@Year INT
)
RETURNS INT
AS
BEGIN
	DECLARE @Sector_ID VARCHAR(10), 
			@Bill_ID INT

	SELECT @Sector_ID = dbo.SECTOR.SECTOR_ID FROM dbo.SECTOR WHERE dbo.SECTOR.SECTOR_NAME = @Sector_Name
	SELECT @Bill_ID = dbo.BILL.BILL_ID FROM dbo.BILL WHERE dbo.BILL.Sector_ID = @Sector_ID
														AND dbo.BILL.ROOM_ID = @Room_ID
														AND dbo.BILL.MONTH = @Month
														AND dbo.BILL.YEAR = @Year 
    RETURN @Bill_ID
END
GO

-- Lấy chỉ số mới của tháng trước đó của Bill 
CREATE FUNCTION [dbo].[UFN_GetOldQuantityForNewBill]
(
	@Sector_ID VARCHAR(10), 
	@Room_ID NVARCHAR(10), 
	@Month INT, @Year INT, 
	@Service_Name NVARCHAR(20)
)
RETURNS INT
AS
BEGIN
	DECLARE @Name NVARCHAR(20), 
			@Quantity INT
	
	SET @Name = @Service_Name
	SELECT @Quantity = dbo.BILL_DETAIL.NEW_QUANTITY
	FROM dbo.BILL 
		INNER JOIN dbo.BILL_DETAIL ON BILL_DETAIL.BILL_ID = BILL.BILL_ID 
		INNER JOIN dbo.SERVICE ON SERVICE.SERVICE_ID = BILL_DETAIL.SERVICE_ID
	WHERE dbo.BILL.Sector_ID = @Sector_ID
	   AND dbo.BILL.ROOM_ID = @Room_ID
	   AND dbo.BILL.MONTH = @Month
	   AND dbo.BILL.YEAR = @Year
	   AND dbo.SERVICE.SERVICE_NAME =  @Service_Name
	
	IF @Quantity IS NULL
		SET @Quantity = 0
	
	RETURN @Quantity
END
GO

--Trả về số lượng sinh viên đã đăng ký vào phòng nào đó
CREATE FUNCTION UFN_CountNumberOfStudentInRoom
(
	@Sector_ID VARCHAR(10),
	@Room_ID NVARCHAR(10)
)
RETURNS INT
AS BEGIN
	DECLARE @Number INT
	SELECT @Number = COUNT(dbo.ROOM_REGISTRATION.SSN)
	FROM dbo.ROOM_REGISTRATION
	WHERE ROOM_REGISTRATION.SECTOR_ID = @Sector_ID
		AND ROOM_REGISTRATION.ROOM_ID = @Room_ID
		AND dbo.ROOM_REGISTRATION.STATUS = 1
	RETURN @Number
END
GO

-- Tạo hàm tìm tên gần đúng
CREATE FUNCTION [dbo].[SearchLike] (@strInput NVARCHAR(4000)) 
RETURNS NVARCHAR(4000) 
AS 
BEGIN 
	IF @strInput IS NULL RETURN @strInput 
	IF @strInput = '' RETURN @strInput 
	
	DECLARE @SIGN_CHARS NCHAR(136), @UNSIGN_CHARS NCHAR (136)
	
	SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý 
	ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' + NCHAR(272)+ NCHAR(208) -- hai chữ Đ
	SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy 
	AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' 
	
	DECLARE @COUNTER int = 1, @COUNTER1 INT

	WHILE (@COUNTER <= LEN(@strInput)) 
	BEGIN 
		SET @COUNTER1 = 1
		WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) 
		BEGIN 
			IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) 
			BEGIN 
				IF @COUNTER=1 
				SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1, 1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) 
				ELSE 
				SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) + SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) 
				BREAK 
			END 
		SET @COUNTER1 = @COUNTER1 + 1 
		END 
		SET @COUNTER = @COUNTER + 1 
	END 

	--- xóa dấu cách thừa
	WHILE CHARINDEX('  ',@strInput) > 0
	BEGIN
		SET @strInput = replace(@strInput,'  ',' ') 
	END
	SET @strInput =TRIM(@strInput)
	
	RETURN @strInput
END
GO


-- lấy danh sách sinh viên theo status
-- status = 0 : outgoing, 
-- status = 1 : alive, 
-- status = 2 : all status 
-- Trả về table
CREATE FUNCTION UFN_GetListStudent (@STATUS INT)
RETURNS @Result TABLE (
	[Id] BIGINT NOT NULL,
	[Full name] NVARCHAR(51) NULL,
	[Date of birth] DATE,
	[Gender] VARCHAR(5),
	[Ssn] VARCHAR(12),
	[Phone number] VARCHAR(15),
	[Email] VARCHAR(40),
	[Student Id] VARCHAR(15) NOT NULL,
	[College] NVARCHAR(100) NOT NULL
)
AS
BEGIN
	INSERT @Result
    SELECT 
		U.[USER_ID] AS [Id],
		CONCAT(U.LAST_NAME, ' ', U.FIRST_NAME) AS [Full name],
		U.DOB AS [Date of birth],
		U.GENDER AS [Gender],
		U.SSN,

		U.PHONE_NUMBER_1 AS [Phone number],
		U.EMAIL AS [Email],

		S.STUDENT_ID AS [Student Id],
		C.COLLEGE_NAME AS [College]

	FROM [dbo].[USER] AS U 
		INNER JOIN [dbo].[V_ADDRESS] AS A ON A.ADDRESS_ID = U.ADDRESS_ID
		INNER JOIN [dbo].[STUDENT] AS S ON S.[USER_ID] = U.[USER_ID]
		INNER JOIN [dbo].[COLLEGE] AS C ON C.COLLEGE_ID = S.COLLEGE_ID
	WHERE U.[STATUS] = @STATUS OR @STATUS = 2

	RETURN
END
GO

-- Trả về giao diện Bill
CREATE FUNCTION UFN_ReturnForViewBillDetail
(
	@Sector_Name VARCHAR(10), 
	@Room_ID NVARCHAR(10), 
	@Month INT, 
	@Year INT
)
RETURNS @View_BillDetail TABLE (
	Service_ID INT, 
	ServiceName NVARCHAR(50), 
	Unit_Name NVARCHAR(50), 
	PricePerUnit DECIMAL(19,4), 
	Old_Quantity INT, 
	New_Quantity INT, 
	Total_Cost DECIMAL(19,4),
	Bill_Detail_ID INT, 
	Bill_ID INT)
AS
BEGIN
    DECLARE @Bill_ID INT, @Service_Name NVARCHAR(50)
	SELECT @Bill_ID = dbo.UFN_GetBillIdBySectornameRoomidMonthYear(@Sector_Name,@Room_ID,@Month,@Year)

	INSERT INTO @View_BillDetail
	SELECT 
		BD.SERVICE_ID, 
		S.[SERVICE_NAME], 
		BD.UNIT_NAME, 
		S.PRICE_PER_UNIT, 
		BD.OLD_QUANTITY, 
		BD.NEW_QUANTITY, 
		BD.TOTAL_COST, 
		BD.BILL_DETAIL_ID, 
		BD.BILL_ID
	FROM dbo.BILL_DETAIL AS BD
		INNER JOIN dbo.SERVICE AS S ON S.SERVICE_ID = BD.SERVICE_ID 
		INNER JOIN dbo.BILL AS B ON B.BILL_ID = BD.BILL_ID
	WHERE BD.BILL_ID = @Bill_ID
	RETURN
END
GO

-- GetSectorIDBySectorName
CREATE FUNCTION UFN_Get_SectorID_By_SectorName (@SECTOR_NAME NVARCHAR(50))
RETURNS VARCHAR(10)
AS
BEGIN
    DECLARE @SECTOR_ID VARCHAR(10)
	SELECT @SECTOR_ID = dbo.SECTOR.SECTOR_ID FROM dbo.SECTOR WHERE dbo.SECTOR.SECTOR_NAME = @SECTOR_NAME
	RETURN @SECTOR_ID
END
GO