INSERT INTO cts_pension.primary_categories (
  id,hoa_id,primary_category_name,active_flag) VALUES
	(1,'2071 - 01 - 101 - 00 - 005 - V - 04 - 00','College( Government) Pension',true),
  (43,'2071 - 01 - 101 - 00 - 005 - V - 04 - 00','State Pension',true);

INSERT INTO cts_pension.sub_categories (
  id,sub_category_name,active_flag) VALUES
	(1,'ROPA 2008',true),
	(2,'ROPA 2009',true);

INSERT INTO cts_pension.categories(
  id, primary_category_id, sub_category_id, category_name, active_flag)	VALUES 
  (25, 43, 2, 'State Pension-ROPA 2009',true),
  (48, 1, 2, 'College( Government) Pension-ROPA 2009',true);