-- Deleting the Procedures
DROP PROCEDURE IF EXISTS SP_SelectMachinesByUserID;
GO
Drop PROCEDURE IF EXISTS SP_SelectBookingsByUserID;
GO
Drop PROCEDURE IF EXISTS SP_InsertErrorReport;
GO
Drop PROCEDURE IF EXISTS SP_InsertTempUser;
GO
Drop PROCEDURE IF EXISTS SP_InsertUserFromTempUser;
GO

---------------- Creating Stored Procedures

-----
CREATE PROCEDURE SP_SelectMachinesByUserID @UserID INT
As
BEGIN
Select 
	MachineID, 
	(
		Select MachineType From MachineTypes
		Where MachineTypeID = Machines.MachineTypeID
	) AS MachineType,
	DepartmentID, 
	Name
From Machines
WHERE DepartmentID IN (
Select DepartmentID From UserDepartmentMappings
WHERE UserID = @UserID
)
END
GO

-----

CREATE PROCEDURE SP_SelectBookingsByUserID @UserID INT
As
SELECT BookingID,MachineID,BookingDate,StartTime,EndTime FROM Bookings WHERE UserID = @UserID;
GO

-----

CREATE PROCEDURE SP_InsertErrorReport @MachineID INT, @UserID INT, @ErrorTypeID INT, @StatusID INT, @Description VarChar(255)
As
Insert Into ErrorReports(MachineID, UserID, ErrorTypeID, StatusID, Description)
Values (@MachineID, @UserID, @ErrorTypeID, @StatusID, @Description)
GO

----

CREATE PROCEDURE SP_InsertTempUser @CreationCode VarChar(50), @CreatedByUserID INT, @ApartmentNumber VarChar(50), @DepartmentID INT, @UserTypeID INT, @Name VarChar(100)
As
Insert Into TempUsers(CreationCode, CreatedByUserID, ApartmentNumber, DepartmentID, UserTypeID, Name, CreationDate)
Values (@CreationCode, @CreatedByUserID, @ApartmentNumber, @DepartmentID, @UserTypeID, @Name, GETDATE())
GO

----

CREATE PROCEDURE SP_InsertUserFromTempUser
    @CreationCode VARCHAR(50),
    @Phone VARCHAR(20),
    @Email VARCHAR(100),
    @Password VARCHAR(255)
AS
BEGIN
    -- Check if the TempUser exists
    IF EXISTS (SELECT 1 FROM TempUsers WHERE CreationCode = @CreationCode)
    BEGIN
        DECLARE @NewUserID INT;
        DECLARE @DepartmentID INT, @UserTypeID INT;

        -- Insert into Users table
        INSERT INTO Users (ApartmentNumber, Name, Phone, Email, Password)
        SELECT ApartmentNumber, Name, @Phone, @Email, @Password
        FROM TempUsers
        WHERE CreationCode = @CreationCode;

        -- Get the new UserID
        SET @NewUserID = SCOPE_IDENTITY();

        -- Get DepartmentID and UserTypeID from TempUsers
        SELECT @DepartmentID = DepartmentID, @UserTypeID = UserTypeID
        FROM TempUsers
        WHERE CreationCode = @CreationCode;

        -- Insert into UserDepartmentMappings
        INSERT INTO UserDepartmentMappings (UserID, DepartmentID, UserTypeID)
        VALUES (@NewUserID, @DepartmentID, @UserTypeID);

        -- Delete the old TempUser
        DELETE FROM TempUsers
        WHERE CreationCode = @CreationCode;
    END
END;

----

