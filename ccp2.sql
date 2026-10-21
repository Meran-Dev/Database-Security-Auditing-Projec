use secureDatabaseManagementSystem;
Go
CREATE TRIGGER trg_AuditFinancialRecords
ON Financial_Records
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Case 1: Handle Data Updates
    IF EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
    BEGIN
        INSERT INTO Audit_Log (TableName, ActionType, RecordKeyID, OldValue, NewValue)
        SELECT 
            'Financial_Records', 
            'UPDATE', 
            i.RecordID,
            (SELECT AccountBalance FROM deleted WHERE RecordID = i.RecordID),
            (SELECT AccountBalance FROM inserted WHERE RecordID = i.RecordID)
        FROM inserted i;
    END

    -- Case 2: Handle Data Deletions
    IF NOT EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
    BEGIN
        INSERT INTO Audit_Log (TableName, ActionType, RecordKeyID, OldValue, NewValue)
        SELECT 
            'Financial_Records', 
            'DELETE', 
            d.RecordID,
            CAST(d.AccountBalance AS VARCHAR(50)),
            'RECORD DELETED'
        FROM deleted d;
    END
END;
Go
CREATE TRIGGER trg_PreventSchemaTampering
ON DATABASE
FOR DROP_TABLE, ALTER_TABLE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @EventData XML = EVENTDATA();
    DECLARE @CommandText VARCHAR(MAX) = @EventData.value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]', 'VARCHAR(MAX)');

    -- Log the unauthorized structural alteration attempt
    INSERT INTO Security_Alerts (AlertMessage)
    VALUES ('Unauthorized attempt to alter schema structure. Blocked command: ' + @CommandText);

    PRINT 'CRITICAL SECURITY VIOLATION: You do not have authorization to alter or drop schema tables.';
    
    -- Terminate and rollback the structural transaction completely
    ROLLBACK TRANSACTION;
END;