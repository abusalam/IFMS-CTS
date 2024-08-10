INSERT INTO cts_pension.primary_categories (
  id,hoa_id,primary_category_name,active_flag) VALUES
	(1,'2071 - 01 - 101 - 00 - 005 - V - 04 - 00','College( Government) Pension',true),
  (4,'2071 - 01 - 109 - 00 - 001 - V - 04 - 00','Education Pension',true),
  (43,'2071 - 01 - 101 - 00 - 005 - V - 04 - 00','State Pension',true);

INSERT INTO cts_pension.sub_categories (
  id,sub_category_name,active_flag) VALUES
	(1,'ROPA 2008',true),
	(2,'ROPA 2009',true),
  (3,'ROPA 1998',true),
  (6,'NO SUB CATEGORY',true),
  (7,'Pension Rules 1966(Pre 81)',true),
  (8,'ROPA 2016',true),
  (12,'ROPA 2019',true);

INSERT INTO cts_pension.categories(
  id, primary_category_id, sub_category_id, category_name, active_flag)	VALUES 
  (25, 43, 2, 'State Pension-ROPA 2009',true),
  (29, 4, 2, 'Education Pension-ROPA 2009',true),
  (30, 4, 3, 'Education Pension-ROPA 1998',true),
  (31, 4, 7, 'Education Pension-Pension Rules 1966(Pre 81)',true),
  (138, 4, 12, 'Education Pension-ROPA 2019',true),
  (48, 1, 2, 'College( Government) Pension-ROPA 2009',true);

INSERT INTO cts_pension.breakups(
	id, component_name, component_type, relief_flag, active_flag) VALUES 
  (1, 'BASIC PENSION', 'P', false, true),
  (2, 'DEARNESS RELIEF', 'P', true, true),
  (3, 'MEDICAL RELIEF', 'P', true, true),
  (4, 'INTERIM RELIEF', 'P', true, true),
  (5, 'OVERDRAWAL', 'D', false, true),
  (6, 'ARREAR', 'P', false, true),
  (7, 'EXGRATIA', 'P', false, true),
  (8, 'AMOUNT COMMUTED', 'D', false, true);

INSERT INTO cts_pension.component_rates(
	id, category_id, breakup_id, effective_from_date, rate_amount, rate_type, active_flag) VALUES 
  (1, 30, 1, '1900-01-01', 0, 'A', true),
  (2, 30, 2, '1900-01-01', 0, 'A', true),
  (3, 30, 3, '1900-01-01', 100, 'A', true),
  (38, 30, 3, '2009-04-01', 300, 'A', true),
  (39, 31, 1, '2014-01-01', 0, 'A', true),
  (826, 30, 2, '2007-04-01', 24, 'P', true),
  (825, 30, 2, '2009-04-01', 57, 'P', true),
  (827, 30, 2, '2016-01-01', 156, 'P', true),
  (1204, 138, 2, '2019-12-01', 0, 'P', true),
  (1205, 138, 3, '2019-12-01', 500, 'A', true);

INSERT INTO cts_pension.ppo_receipt_sequences (
  id, financial_year, treasury_code, next_sequence_value, active_flag) VALUES
  (1, 2024, 'DAA', 2, true);
INSERT INTO cts_pension.ppo_receipts (
  financial_year,treasury_code,treasury_receipt_no,ppo_no,pensioner_name,date_of_commencement,mobile_number,receipt_date,psa_code,ppo_type,ppo_status,created_by,active_flag) VALUES
  (2024,'DAA','DAA2024000001','PPO-955487','Jack Dowsel','2024-07-15','9090445140','2024-08-01','A','N','PPO Received',39,true);
SELECT nextval('cts_pension.ppo_receipts_id_seq');
INSERT INTO cts_pension.pensioners 
  (id, financial_year, treasury_code, receipt_id, ppo_id, ppo_no, ppo_type, ppo_sub_type, category_id, pensioner_name, date_of_birth, gender, mobile_number, email_id, pensioner_address, identification_mark, pan_no, aadhaar_no, date_of_retirement, date_of_commencement, basic_pension_amount, commuted_pension_amount, enhance_pension_amount, reduced_pension_amount, religion, created_by, active_flag) VALUES
  (1, 2024, 'DAA', 1, 1, 'PPO-296128', 'P', 'N', 30, 'Jack Dowsel', '2024-08-10', 'M', '8882371949', 'string', 'Malda', 'S', 'PANNO4614F', '945148468446', '1997-03-25', '1997-03-26', 10000, 2000, 10000, 8000, 'H', 39, true);
SELECT nextval('cts_pension.pensioners_id_seq');
INSERT INTO cts_pension.ppo_id_sequences 
(id, financial_year, treasury_code, next_sequence_value, active_flag) VALUES
(1, 0, 'DAA', 1, true);