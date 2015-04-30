USE tempdb

IF OBJECT_ID('tbl2') IS NOT NULL
	DROP TABLE tbl2

IF OBJECT_ID('tbl1') IS NOT NULL
	DROP TABLE tbl1

IF OBJECT_ID('tbl1') IS NULL
	CREATE TABLE tbl1
	(
		Col1 INT NOT NULL PRIMARY KEY,
		Col2 INT
	)

IF OBJECT_ID('tbl2') IS NULL BEGIN
	CREATE TABLE tbl2
	(
		PrimaryKeyCol INT IDENTITY(1,1) NOT NULL,	-- IDENTITY, PRIMARY KEY
		ForeignKeyCol INT NOT NULL,					-- FOREIGN KEY
		DefaultCol INT NOT NULL,					-- DEFAULT
		UniqueIndexCol INT NOT NULL,				-- UNIQUE INDEX
		NonUniqueIndexCol INT NOT NULL,				-- NON-UNIQUE INDEX
		UniqueConstraintCol INT NOT NULL,			-- UNIQUE CONSTRAINT
		CheckCol INT NOT NULL,						-- CHECK
		ComputedCol AS DefaultCol * 2,				-- COMPUTED
		NullDefaultCol INT,							-- 
		NullCol INT NULL,							-- NULL
		NotNullCol INT NOT NULL						-- NOT NULL
	)
	ALTER TABLE tbl2 ADD CONSTRAINT pk_tbl2_PrimaryKeyCol PRIMARY KEY (PrimaryKeyCol)
	ALTER TABLE tbl2 ADD CONSTRAINT fk_tbl2_ForeignKeyCol FOREIGN KEY (ForeignKeyCol) REFERENCES tbl1(Col1)
	ALTER TABLE tbl2 ADD CONSTRAINT df_tbl2_DefaultCol DEFAULT ((0)) FOR DefaultCol
	CREATE UNIQUE INDEX ux_tbl_UniqueIndexCol ON tbl2(UniqueIndexCol)
	CREATE INDEX ix_tbl1_NonUniqueIndexCol ON tbl2(NonUniqueIndexCol)
	ALTER TABLE tbl2 ADD CONSTRAINT uc_tbl2_UniqueConstraintCol UNIQUE (UniqueConstraintCol)
	ALTER TABLE tbl2 ADD CONSTRAINT chk_tbl2_CheckCol CHECK (CheckCol >= 0)
END
	
DECLARE @object_id int
SELECT TOP 1 @object_id = t.object_id FROM sys.tables t WHERE t.name LIKE 'tbl2%'

SELECT * FROM sys.objects o WHERE @object_id IN (o.object_id, o.parent_object_id)
SELECT * FROM sys.tables t WHERE @object_id IN (t.object_id, t.parent_object_id)
SELECT * FROM sys.columns c WHERE c.object_id = @object_id
SELECT * FROM sys.default_constraints d WHERE @object_id IN (d.object_id, d.parent_object_id)
SELECT * FROM sys.indexes i WHERE i.object_id = @object_id
SELECT * FROM sys.index_columns ic WHERE ic.object_id = @object_id
SELECT * FROM sys.key_constraints p WHERE @object_id IN (p.object_id, p.parent_object_id)
SELECT * from sys.foreign_keys f WHERE @object_id IN (f.object_id, f.parent_object_id, f.referenced_object_id)
SELECT * FROM sys.foreign_key_columns fc WHERE @object_id IN (fc.constraint_object_id, fc.parent_object_id, fc.referenced_object_id) 
SELECT * FROM sys.identity_columns i WHERE i.object_id = @object_id
