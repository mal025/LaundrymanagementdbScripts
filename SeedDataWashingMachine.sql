

-- DEPARTMENTS
INSERT INTO Departments (PostalCode, City, StreetName, HouseNumber)
VALUES
(8000, 'Aarhus C', 'Nørregade', 12),
(9000, 'Aalborg', 'Boulevarden', 45),
(5000, 'Odense C', 'Vestergade', 23),
(2100, 'København Ø', 'Østerbrogade', 88),
(2200, 'København N', 'Nørrebrogade', 176),
(2300, 'København S', 'Amagerbrogade', 54),
(7100, 'Vejle', 'Horsensvej', 3),
(6700, 'Esbjerg', 'Skolegade', 29),
(6400, 'Sønderborg', 'Jernbanegade', 10),
(8700, 'Horsens', 'Søndergade', 5);

-- UserTypes
INSERT INTO UserTypes (UserType)
VALUES
('Lejer'),
('Vicevært'),
('Administration'),
('Udlejer'),
('Systemadministrator');

-- Users
INSERT INTO Users (ApartmentNumber, Name, Phone, Email, Password)
VALUES
-- Lejer i afdeling 1
('1A', 'Mads Sørensen', '28674592', 'mads.sorensen@email.com', 'Pass123!'), -- Lejer
('1B', 'Camilla Hansen', '40982345', 'camilla.hansen@email.com', 'Pass123!'), -- Lejer
('2A', 'Jonas Mikkelsen', '27894561', 'jonas.mikkelsen@email.com', 'Pass123!'), -- Lejer
-- ansatte i afdeling 1
('V1', 'Henrik Pedersen', '22114566', 'vicevaert.henrik@email.com', 'Vice123!'), -- Vicevært
('A1', 'Karen Holm', '70123456', 'admin.karen@email.com', 'Admin!234'), -- Administration
('U1', 'Lars Andersen', '33981244', 'udlejer.lars@email.com', 'Udlej!321'), -- Udlejer
-- Lejer i afdeling 2
('1A', 'Mads Sørensen2', '28674592', 'mads.sorensen@email.com2', 'Pass123!'), -- Lejer
('1B', 'Camilla Hanse2', '40982345', 'camilla.hansen@email.com2', 'Pass123!'), -- Lejer
('2A', 'Jonas Mikkelsen2', '27894561', 'jonas.mikkelsen@email.com2', 'Pass123!'), -- Lejer
-- ansatte i afdeling 2
('V1', 'Henrik Pedersen2', '22114566', 'vicevaert.henrik@email.com2', 'Vice123!'), -- Vicevært
('A1', 'Karen Holm2', '70123456', 'admin.karen@email.com2', 'Admin!234'), -- Administration
('U1', 'Lars Andersen2', '33981244', 'udlejer.lars@email.com2', 'Udlej!321'), -- Udlejer
-- Systemadminstrator
('SYS', 'Systemadministrator', NULL, 'sysadmin@boligsystem.dk', 'SysRoot!2024'); -- Systemadministrator

-- UserMapping
INSERT INTO UserDepartmentMappings (UserID, DepartmentID, UserTypeID)
VALUES
-- Afdeling 1 
(1, 1, 1),
(2, 1, 1),
(3, 1, 1),
(4, 1, 2),
(5, 1, 3),
(6, 1, 4),
-- afdeling 2
(7, 2, 1),
(8, 2, 1),
(9, 2, 1),
(10, 2, 2),
(11, 2, 3),
(12, 2, 4),
-- admin
(13, 1, 5);

-- Machinetypes
INSERT INTO MachineTypes (MachineType)
VALUES
('Vaskemaskine'),
('Tørretumbler');

-- Machines
INSERT INTO Machines (MachineTypeID, DepartmentID, Name)
VALUES
-- Afdeling 1 (Aarhus C)
(1, 1, 'Vaskemaskine 1'),
(1, 1, 'Vaskemaskine 2'),
(2, 1, 'Tørretumbler 1'),

-- Afdeling 2 (Aalborg)
(1, 2, 'Vaskemaskine 1'),
(1, 2, 'Vaskemaskine 2'),
(2, 2, 'Tørretumbler 1');


-- Status
INSERT INTO Statuses (Status)
VALUES
('Sendt'),
('Åbnet'),
('Under udførelse'),
('Færdiggjort');

-- Error types
INSERT INTO ErrorTypes (ErrorType)
VALUES
('Lille fejl'),
('Stor fejl'),
('Virker ikke');

-- Bookings
INSERT INTO Bookings (UserID, MachineID, BookingDate, StartTime, EndTime)
VALUES
-- Afdeling 1 (Aarhus C)
(1, 1, '2025-10-07', '08:00', '09:00'),  -- Mads Sørensen booker Vaskemaskine 1
(2, 2, '2025-10-07', '09:30', '10:30'),  -- Camilla Hansen booker Vaskemaskine 2
(3, 3, '2025-10-07', '10:00', '11:00'),  -- Jonas Mikkelsen booker Tørretumbler 1

-- Afdeling 2 (Aalborg)
(7, 4, '2025-10-07', '08:00', '09:00'),  -- Mads Sørensen2 booker Vaskemaskine 1
(8, 5, '2025-10-07', '09:00', '10:00'),  -- Camilla Hansen2 booker Vaskemaskine 2
(9, 6, '2025-10-07', '10:30', '11:30');  -- Jonas Mikkelsen2 booker Tørretumbler 1


