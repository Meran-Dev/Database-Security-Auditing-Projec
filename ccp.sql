USE secureDatabaseManagementSystem;
GO

PRINT '==================================================';
PRINT 'TEST 1: ATTEMPTING UNAUTHORIZED DATA UPDATE (STAFF)';
PRINT '==================================================';
-- John Doe is 'Staff'. This should fail and trigger an access error.
BEGIN TRY
    EXEC sp_ExecuteTransaction 
        @EmpName = 'John Doe', 
        @AccountNum = 'ACC-1002', 
        @NewBalance = 99999.00;
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;
GO

PRINT '==================================================';
PRINT 'TEST 2: PROCESSING VALID DATA UPDATE (MANAGER)';
PRINT '==================================================';
-- Assam Sajjad is a 'Manager'. This should succeed flawlessly.
EXEC sp_ExecuteTransaction 
    @EmpName = 'Assam Sajjad', 
    @AccountNum = 'ACC-1002', 
    @NewBalance = 25000.00;
GO

PRINT '==================================================';
PRINT 'TEST 3: ATTEMPTING SCHEMA DESTRUCTION (DDL HACK)';
PRINT '==================================================';
-- Trying to drop a table. This should trigger a ROLLBACK.
BEGIN TRY
    DROP TABLE Users;
END TRY
BEGIN CATCH
    PRINT 'DDL Trigger intercepted and rolled back the command.';
END CATCH;
GO

PRINT '==================================================';
PRINT 'TEST 4: VIEWING SECURITY LOGS & AUDIT TRAILS';
PRINT '==================================================';
-- See your automated security system's work
SELECT * FROM Audit_Log;
SELECT * FROM Security_Alerts;

-- Run your risk assessment function on the active session user
SELECT dbo.fn_CheckUserRisk(SYSTEM_USER) AS CurrentSessionRiskAssessment;
GO