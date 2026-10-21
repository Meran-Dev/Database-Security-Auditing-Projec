use secureDatabaseManagementSystem;
Go
INSERT INTO Users (FullName, SystemRole, Salary) VALUES 
('Shah Sayed Meran', 'Admin', 95000.00),
('Assam Sajjad', 'Manager', 75000.00),
('Saifullah', 'Staff', 45000.00);

INSERT INTO Financial_Records (AccountNumber, AccountBalance) VALUES 
('ACC-1001', 250000.00),
('ACC-1002', 15000.50),
('ACC-1003', 890000.00);

select * from dbo.Users;