-- ========================================
-- 1. DATABASE
-- ========================================
CREATE DATABASE  LaundryManagementDB;
GO

USE LaundryManagementDB;
GO

-- ========================================
-- 2. TABLES
-- ========================================

-- USERS
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    ApartmentNumber VARCHAR(50) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL
);

-- DEPARTMENTS
CREATE TABLE Departments (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    PostalCode INT NOT NULL CHECK (PostalCode > 0),
    City VARCHAR(100) NOT NULL,
    StreetName VARCHAR(100) NOT NULL,
    HouseNumber INT NOT NULL CHECK (HouseNumber > 0)
);

-- USER TYPES
CREATE TABLE UserTypes (
    UserTypeID INT IDENTITY(1,1) PRIMARY KEY,
    UserType VARCHAR(50) NOT NULL UNIQUE
);

-- USER-DEPARTMENT MAPPINGS
CREATE TABLE UserDepartmentMappings (
    MappingID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    DepartmentID INT NOT NULL,
    UserTypeID INT NOT NULL,
    CONSTRAINT FK_UserDepartmentMappings_Users FOREIGN KEY (UserID)
        REFERENCES Users(UserID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_UserDepartmentMappings_Departments FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_UserDepartmentMappings_UserTypes FOREIGN KEY (UserTypeID)
        REFERENCES UserTypes(UserTypeID) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT UQ_UserDepartment UNIQUE (UserID, DepartmentID)
);

-- TEMPORARY USERS
CREATE TABLE TempUsers (
    CreationCode VARCHAR(50) PRIMARY KEY,
    CreatedByUserID INT NOT NULL,
    ApartmentNumber VARCHAR(50) NOT NULL,
    DepartmentID INT NOT NULL,
    UserTypeID INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    CreationDate DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_TempUsers_Users FOREIGN KEY (CreatedByUserID)
        REFERENCES Users(UserID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_TempUsers_Departments FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_TempUsers_UserTypes FOREIGN KEY (UserTypeID)
        REFERENCES Usertypes(UserTypeID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- MACHINE TYPES
CREATE TABLE MachineTypes (
    MachineTypeID INT IDENTITY(1,1) PRIMARY KEY,
    MachineType VARCHAR(50) NOT NULL UNIQUE
);

-- MACHINES
CREATE TABLE Machines (
    MachineID INT IDENTITY(1,1) PRIMARY KEY,
    MachineTypeID INT NOT NULL,
    DepartmentID INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    CONSTRAINT FK_Machines_MachineTypes FOREIGN KEY (MachineTypeID)
        REFERENCES MachineTypes(MachineTypeID) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Machines_Departments FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- BOOKINGS
CREATE TABLE Bookings (
    BookingID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    MachineID INT NOT NULL,
    BookingDate DATE NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    CONSTRAINT FK_Bookings_Users FOREIGN KEY (UserID)
        REFERENCES Users(UserID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Bookings_Machines FOREIGN KEY (MachineID)
        REFERENCES Machines(MachineID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT CK_Booking_Time CHECK (StartTime < EndTime),
    CONSTRAINT UQ_Booking UNIQUE (MachineID, BookingDate, StartTime, EndTime)
);

-- ERROR TYPES
CREATE TABLE ErrorTypes (
    ErrorTypeID INT IDENTITY(1,1) PRIMARY KEY,
    ErrorType VARCHAR(100) NOT NULL UNIQUE
);

-- STATUSES
CREATE TABLE Statuses (
    StatusID INT IDENTITY(1,1) PRIMARY KEY,
    Status VARCHAR(50) NOT NULL UNIQUE
);

-- ERROR REPORTS
CREATE TABLE ErrorReports (
    ErrorID INT IDENTITY(1,1) PRIMARY KEY,
    MachineID INT NOT NULL,
    UserID INT NOT NULL,
    ErrorTypeID INT NOT NULL,
    StatusID INT NOT NULL,
    Description VARCHAR(255),
    CONSTRAINT FK_ErrorReports_Machines FOREIGN KEY (MachineID)
        REFERENCES Machines(MachineID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_ErrorReports_Users FOREIGN KEY (UserID)
        REFERENCES Users(UserID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_ErrorReports_ErrorTypes FOREIGN KEY (ErrorTypeID)
        REFERENCES ErrorTypes(ErrorTypeID) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_ErrorReports_Statuses FOREIGN KEY (StatusID)
        REFERENCES Statuses(StatusID) ON DELETE NO ACTION ON UPDATE CASCADE
);
