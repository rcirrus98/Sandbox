SELECT * FROM sys.tables t WHERE t.name = ''
SELECT * FROM sys.objects o WHERE o.object_id = 0
SELECT * FROM sys.tables t WHERE t.object_id = 0
SELECT * FROM sys.columns c WHERE c.object_id = 0
SELECT * FROM sys.indexes i WHERE i.object_id = 0
SELECT * FROM sys.index_columns c WHERE c.object_id = 0
SELECT * FROM sys.key_constraints k WHERE k.object_id = 0
SELECT * FROM sys.default_constraints d WHERE d.object_id = 0