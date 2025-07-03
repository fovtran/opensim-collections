# Working resultset
SELECT count(UUID) FROM prims;

DROP TEMPORARY TABLE IF EXISTS foo;
CREATE TEMPORARY TABLE foo 
SELECT id,name,description,length(data) FROM assets 
	WHERE assetType=6 AND id IN 
		(select assetID from primitems where assetID IN
			(SELECT UUID FROM prims 
				WHERE RegionUUID NOT IN 
					(SELECT uuid FROM regions where uuid="634ed6e1-4491-4ddd-a20f-e9f960f6bf89")));
					
SELECT * FROM foo;
SELECT id FROM assets WHERE id IN (SELECT id FROM foo);
