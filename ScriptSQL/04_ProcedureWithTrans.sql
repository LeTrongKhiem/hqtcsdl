USE [DormitoryManagement]
GO

-- cập nhật sinh viên
CREATE  PROC USP_TRANSACTION_UpdateStudent
(
	@Ssn VARCHAR(12), 
	@Street NVARCHAR(50), 
	@Commune_Name NVARCHAR(50), 
	@District_Name NVARCHAR(50), 
	@Province_Name NVARCHAR(50),
	@College_Name NVARCHAR(50),
	@Faculty NVARCHAR(50), 
	@Major NVARCHAR(50),
	@Phone_Number_1 VARCHAR(15),
	@Phone_Number_2 VARCHAR(15),
	@Email VARCHAR(40)
)
AS
BEGIN
    DECLARE @User_ID INT,
			@Address_ID INT
	SELECT @User_ID = dbo.[USER].USER_ID FROM dbo.[USER] WHERE dbo.[USER].SSN = @Ssn
	SELECT @Address_ID = dbo.[USER].ADDRESS_ID FROM dbo.[USER] WHERE dbo.[USER].SSN = @Ssn
	BEGIN TRANSACTION
		EXEC dbo.USP_UpdateAddRess @AddRess_ID = @Address_ID,    
		                           @Street = @Street,       
		                           @Commune_Name = @Commune_Name, 
		                           @District_Name = @District_Name, 
		                           @Province_Name = @Province_Name 

		EXEC dbo.USP_UpdateStudentCollege @User_ID = @User_ID,
		                                  @College_Name = @College_Name, 
		                                  @Faculty = @Faculty, 
		                                  @Major = @Major 

		UPDATE dbo.[USER]
		SET dbo.[USER].PHONE_NUMBER_1 = NULL,
			dbo.[USER].PHONE_NUMBER_2 = NULL,
			dbo.[USER].EMAIL = NULL
		WHERE dbo.[USER].USER_ID = @User_ID;

		IF (@Phone_Number_1 IN (SELECT dbo.[USER].PHONE_NUMBER_1 FROM dbo.[USER]) 
			OR @Phone_Number_1 IN (SELECT dbo.[USER].PHONE_NUMBER_2 FROM dbo.[USER]))
		BEGIN
		    RAISERROR('Phone_Number_1 Is Exist',16,1)
			ROLLBACK
		END
		ELSE IF (@Phone_Number_2 IN (SELECT dbo.[USER].PHONE_NUMBER_2 FROM dbo.[USER]) 
				 OR @Phone_Number_2 IN (SELECT dbo.[USER].PHONE_NUMBER_1 FROM dbo.[USER]))
		BEGIN
		    RAISERROR('Phone_Number_2 Is Exist',16,1)
			ROLLBACK
		END
		ELSE IF (@Email IN (SELECT dbo.[USER].EMAIL FROM dbo.[USER]))
		BEGIN
		    RAISERROR('Email Is Exist',16,1)
			ROLLBACK
		END
		ELSE
		BEGIN
		    UPDATE dbo.[USER]
			SET dbo.[USER].PHONE_NUMBER_1 = @Phone_Number_1,
				dbo.[USER].PHONE_NUMBER_2 = @Phone_Number_2,
				dbo.[USER].EMAIL = @Email
			WHERE dbo.[USER].USER_ID = @User_ID;
			COMMIT
		END
END
GO

-- TRANSACTION -- THÊM 1 SINH VIÊN
CREATE  PROC TRANS_INSERT_STUDENT
(
	@Street NVARCHAR(50), 
	@Commune_Name NVARCHAR(50), 
	@District_Name NVARCHAR(50),
	@Province_Name NVARCHAR(50),
	@Insurence_ID VARCHAR(15),
	@LAST_NAME NVARCHAR(40),
	@FIRST_NAME NVARCHAR(20),
	@DOB DATE,@GENDER NVARCHAR(5),
	@SSN VARCHAR(12),
	@PHONE_NUMBER_1 VARCHAR(15),
	@PHONE_NUMBER_2 VARCHAR(15),
	@EMAIL VARCHAR(40),
	@IMAGE_PATH VARCHAR(300),
	@USER_TYPE VARCHAR(10),
	@STATUS BIT,
	@STUDENT_ID VARCHAR(15), 
	@COLLEGE_NAME NVARCHAR(50),
	@FACULTY NVARCHAR(50), 
	@MAJORS NVARCHAR(50)
)
AS
BEGIN
	BEGIN TRANSACTION
		CREATE TABLE TEMPT_STUDENT
		(
			T_SSN VARCHAR(12),
			T_INSURANCE_ID VARCHAR(15),
			T_PHONENUMBER1 VARCHAR(15),
			T_PHONENUMBER2 VARCHAR(15),
			T_EMAIL VARCHAR(40)
		)
		INSERT INTO dbo.TEMPT_STUDENT
		(
			T_SSN,
			T_INSURANCE_ID,
			T_PHONENUMBER1,
			T_PHONENUMBER2,
			T_EMAIL
		)
		SELECT dbo.[USER].SSN, dbo.STUDENT.INSURANCE_ID, dbo.[USER].PHONE_NUMBER_1, dbo.[USER].PHONE_NUMBER_2, dbo.[USER].EMAIL
		FROM dbo.[USER] INNER JOIN dbo.STUDENT ON STUDENT.USER_ID = [USER].USER_ID

		EXEC dbo.USP_INSERT_INSURANCE @Insurence_ID = @Insurence_ID 
		EXEC dbo.USP_INSERT_ADDRESS @Street = @Street, 
		                            @Commune_Name = @Commune_Name, 
		                            @District_Name = @District_Name, 
		                            @Province_Name = @Province_Name

		EXEC dbo.USP_INSERT_USER_STUDENT @LAST_NAME = @LAST_NAME,     -- nvarchar(40)
		                                 @FIRST_NAME = @FIRST_NAME,    -- nvarchar(20)
		                                 @DOB = @DOB,  -- date
		                                 @GENDER = @GENDER,        -- nvarchar(5)
		                                 @SSN = @SSN,            -- varchar(12)
		                                 @PHONE_NUMBER_1 = @PHONE_NUMBER_1, -- varchar(15)
		                                 @PHONE_NUMBER_2 = @PHONE_NUMBER_2, -- varchar(15)
		                                 @EMAIL = @EMAIL,          -- varchar(40)
		                                 @IMAGE_PATH = '',     -- varchar(300)
		                                 @USER_TYPE = @USER_TYPE,      -- varchar(10)
		                                 @STATUS = @STATUS        -- bit
		IF( @SSN IN (SELECT dbo.TEMPT_STUDENT.T_SSN FROM dbo.TEMPT_STUDENT))
		BEGIN
			RAISERROR('SSN Is exist',16,1)
			DROP TABLE dbo.TEMPT_STUDENT
		    ROLLBACK TRANSACTION
		END
		ELSE
		BEGIN
		    EXEC dbo.USP_INSERT_STUDENT @STUDENT_ID = @STUDENT_ID,                -- varchar(15)
										@COLLEGE_NAME = @COLLEGE_NAME,             -- nvarchar(50)
										@FACULTY = @FACULTY,                  -- nvarchar(50)
										@MAJORS = @MAJORS,                   -- nvarchar(50)
										@INSURANCE_ID = @Insurence_ID,              -- varchar(15)
										@STATUS_REGISTRATION_ROOM = 0 -- bit
			DROP TABLE dbo.TEMPT_STUDENT
			COMMIT TRANSACTION
		END
END
GO