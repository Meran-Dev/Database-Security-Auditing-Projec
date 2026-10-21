USE secureDatabaseManagementSystem;
GO

CREATE PROCEDURE sp_ExecuteTransaction
    @EmpName VARCHAR(100),
    @AccountNum VARCHAR(20),
    @NewBalance DECIMAL(15,2)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @UserRole VARCHAR(20);
    SELECT @UserRole = SystemRole FROM Users WHERE FullName = @EmpName;

    -- Validate user authorization profile
    IF @UserRole IS NULL OR @UserRole = 'Staff'
    BEGIN
        INSERT INTO Security_Alerts (AlertMessage, SeverityLevel)
        VALUES ('Unauthorized data modification attempt by ' + @EmpName, 'HIGH');
        
        THROW 51000, 'ACCESS DENIED: Standard staff accounts lack modification rights.', 1;
        RETURN;
    END

    -- Enforce financial validation rule limits
    IF @UserRole = 'Manager' AND @NewBalance > 500000.00
    BEGIN
        INSERT INTO Security_Alerts (AlertMessage, SeverityLevel)
        VALUES ('Manager ' + @EmpName + ' exceeded standard single transaction limit.', 'MEDIUM');
        
        THROW 52000, 'LIMIT EXCEEDED: Managers cannot process individual adjustments over $500,000.', 1;
        RETURN;
    END

    -- If rules pass successfully, update data
    UPDATE Financial_Records 
    SET AccountBalance = @NewBalance 
    WHERE AccountNumber = @AccountNum;
    
    PRINT 'Transaction processed successfully.';
END;
GO

SELECT dbo.fn_CheckUserRisk('Saifullah') AS CurrentRiskAssessment;
