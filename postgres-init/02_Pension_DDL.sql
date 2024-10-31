-- SCHEMA: cts_pension

DROP SCHEMA IF EXISTS cts_pension CASCADE;

CREATE SCHEMA IF NOT EXISTS cts_pension AUTHORIZATION postgres;

CREATE TABLE IF NOT EXISTS cts_pension.dml_history (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
	ppo_id integer NOT NULL,
  updated_table_field character varying(200) NOT NULL,
	from_record_id bigint NOT NULL,
	to_record_id bigint NOT NULL,
	updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  updated_by integer
);
COMMENT ON TABLE cts_pension.dml_history IS 'PensionModuleSchema v1';


CREATE TABLE IF NOT EXISTS cts_pension.uploaded_files (
  id bigserial NOT NULL PRIMARY KEY,
  file_path character varying(500) NOT NULL,
  file_name character varying(500) NOT NULL,
  file_mime_type character varying(500) NOT NULL,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL
);
COMMENT ON TABLE cts_pension.uploaded_files IS 'PensionModuleSchema v1';


CREATE TABLE IF NOT EXISTS cts_pension.ppo_receipt_sequences (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
  next_sequence_value integer NOT NULL,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL
);
COMMENT ON TABLE cts_pension.ppo_receipt_sequences IS 'PensionModuleSchema v1';


CREATE TABLE IF NOT EXISTS cts_pension.ppo_id_sequences (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
  next_sequence_value integer NOT NULL,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL
);
COMMENT ON TABLE cts_pension.ppo_id_sequences IS 'PensionModuleSchema v1';


CREATE TABLE IF NOT EXISTS cts_pension.ppo_receipts (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
  treasury_receipt_no character varying(100) NOT NULL UNIQUE,
  ppo_no character varying(100) NOT NULL UNIQUE,
  pensioner_name character varying(100) NOT NULL,
  date_of_commencement date NOT NULL,
  mobile_number character varying(10),
  receipt_date date NOT NULL,
  psa_code CHAR(1) NOT NULL,
  ppo_type CHAR(1) NOT NULL,
  ppo_status character varying(100) NOT NULL,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL
);
COMMENT ON TABLE cts_pension.ppo_receipts IS 'PensionModuleSchema v1';


CREATE TABLE IF NOT EXISTS cts_pension.eppo_receipts (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(5) NOT NULL,
	ppo_id integer,
  pension_appln_no character varying(100) NOT NULL UNIQUE,
  fresh_revision_flag CHAR(1) NOT NULL,
  ppo_type_code CHAR(1) NOT NULL,
  ppo_no character varying(100) NOT NULL,
  issuing_letter_no character varying(500),
  issuing_letter_date date,
  pen_cat_id integer NOT NULL,
  sanction_authority character varying(500) NOT NULL,
  sanction_no character varying(500) NOT NULL,
  sanction_date date NOT NULL,
  provisional_pension_status CHAR(1) NOT NULL,
  pensioner_name character varying(100) NOT NULL,
  religion CHAR(1) NOT NULL,
	pensioner_address character varying(500),
  mobile_number character varying(10),
	aadhaar_no character varying(12),
  date_of_birth date NOT NULL,
  date_of_retirement date NOT NULL,
  date_of_death date DEFAULT NULL,
  qualifying_service_gross_years integer,
  qualifying_service_gross_months integer,
  qualifying_service_gross_days integer,
  employee_last_pay integer,
  employee_last_pay_notional integer,
  commuted_pension_amount integer NOT NULL,
  withdrawn boolean,
  withdraw_date date,
  withdraw_reason character varying(500),
  ppo_status character varying(100) NOT NULL,
  photo_file_id bigint references cts_pension.uploaded_files(id),
  signature_file_id bigint references cts_pension.uploaded_files(id),
  eppo_file_id bigint references cts_pension.uploaded_files(id),
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL
);
COMMENT ON TABLE cts_pension.eppo_receipts IS 'PensionModuleSchema v1';


CREATE TABLE IF NOT EXISTS cts_pension.eppo_revisions (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(5) NOT NULL,
	ppo_id integer,
  pension_appln_no character varying(100) NOT NULL UNIQUE,
  ppo_no character varying(100) NOT NULL,
  issuing_letter_no character varying(500),
  issuing_letter_date date,
  fresh_revision_flag CHAR(1) NOT NULL,
  ppo_type_code CHAR(1) NOT NULL,
  ppo_sub_type CHAR(1) NOT NULL,
  pen_cat_id integer NOT NULL,
  employee_last_pay integer,
  employee_last_pay_notional integer,
  commuted_pension_amount integer NOT NULL,
  eppo_file_id bigint references cts_pension.uploaded_files(id),
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL
);
COMMENT ON TABLE cts_pension.eppo_revisions IS 'PensionModuleSchema v1';


CREATE TABLE IF NOT EXISTS cts_pension.primary_categories (
  id bigserial NOT NULL PRIMARY KEY,
  hoa_id character varying(50) NOT NULL,
  primary_category_name character varying(100) NOT NULL UNIQUE,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL
);
COMMENT ON TABLE cts_pension.primary_categories IS 'PensionModuleSchema v1';
COMMENT ON COLUMN cts_pension.primary_categories.hoa_id IS 'Head of Account: 2071 - 01 - 109 - 00 - 001 - V - 04 - 00';


CREATE TABLE IF NOT EXISTS cts_pension.sub_categories (
  id bigserial NOT NULL PRIMARY KEY,
  sub_category_name character varying(100) NOT NULL UNIQUE,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL
);
COMMENT ON TABLE cts_pension.sub_categories IS 'PensionModuleSchema v1';


CREATE TABLE IF NOT EXISTS cts_pension.categories (
  id bigserial NOT NULL PRIMARY KEY,
  primary_category_id bigint NOT NULL references cts_pension.primary_categories(id),
  sub_category_id bigint NOT NULL references cts_pension.sub_categories(id),
  category_name character varying(100) NOT NULL ,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL,
  UNIQUE(primary_category_id, sub_category_id)
);
COMMENT ON TABLE cts_pension.categories IS 'PensionModuleSchema v1';
COMMENT ON COLUMN cts_pension.categories.category_name IS 'primary_category_name - sub_category_name';


CREATE TABLE IF NOT EXISTS cts_pension.breakups (
  id bigserial NOT NULL PRIMARY KEY,
  component_name character varying(100) NOT NULL UNIQUE,
  component_type CHAR(1) NOT NULL,
  relief_flag boolean NOT NULL,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL
);
COMMENT ON TABLE cts_pension.breakups IS 'PensionModuleSchema v1';
COMMENT ON COLUMN cts_pension.breakups.id IS 'BreakupId';
COMMENT ON COLUMN cts_pension.breakups.component_type IS 'P - Payment; D - Deduction;';
COMMENT ON COLUMN cts_pension.breakups.relief_flag IS 'Relief Allowed (Yes/No)';


CREATE TABLE IF NOT EXISTS cts_pension.component_rates (
  id bigserial NOT NULL PRIMARY KEY,
  category_id bigint NOT NULL references cts_pension.categories(id),
  breakup_id bigint NOT NULL references cts_pension.breakups(id),
  effective_from_date date NOT NULL,
  rate_amount integer NOT NULL,
  rate_type CHAR(1) NOT NULL,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL,
  UNIQUE(category_id, breakup_id, effective_from_date)
);
COMMENT ON TABLE cts_pension.component_rates IS 'PensionModuleSchema v1';
COMMENT ON COLUMN cts_pension.component_rates.id IS 'RateId will identify the component rate revised or introduced';
COMMENT ON COLUMN cts_pension.component_rates.effective_from_date IS 'Effective from date the component rate is revised or introduced';
COMMENT ON COLUMN cts_pension.component_rates.rate_type IS 'P - Percentage; A - Amount;';


CREATE TABLE IF NOT EXISTS cts_pension.banks (
  id bigserial NOT NULL PRIMARY KEY,
  treasury_code character varying(3) NOT NULL,
  bank_name character varying(100) NOT NULL UNIQUE,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL
);
COMMENT ON TABLE cts_pension.banks IS 'PensionModuleSchema v1';


CREATE TABLE IF NOT EXISTS cts_pension.branches (
  id bigserial NOT NULL PRIMARY KEY,
  treasury_code character varying(3) NOT NULL,
  bank_id bigint NOT NULL references cts_pension.banks(id),
  branch_name character varying(100) NOT NULL,
  branch_address character varying(500) NOT NULL,
  ifsc_code character varying(11) NOT NULL,
  micr_code character varying(11) NOT NULL,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL
);
COMMENT ON TABLE cts_pension.branches IS 'PensionModuleSchema v1';


CREATE TABLE IF NOT EXISTS cts_pension.pensioners (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
  receipt_id bigint NOT NULL references cts_pension.ppo_receipts(id),
	ppo_id integer NOT NULL,
	ppo_no character varying(100) NOT NULL UNIQUE,
  ppo_type CHAR(1) NOT NULL,
  ppo_sub_type CHAR(1) NOT NULL,
  category_id bigint NOT NULL references cts_pension.categories(id),
  branch_id bigint NOT NULL references cts_pension.branches(id),
	bank_ac_no character varying(30) NOT NULL,
	account_holder_name character varying(100) NOT NULL,
  pay_mode CHAR(1) NOT NULL,
	pensioner_name character varying(100) NOT NULL,
	date_of_birth date NOT NULL,
	date_of_death date DEFAULT NULL,
	gender CHAR(1) NOT NULL,
	mobile_number character varying(10),
	email_id character varying(100),
	pensioner_address character varying(500),
	identification_mark character varying(100),
	pan_no character varying(10),
	aadhaar_no character varying(12),
  date_of_retirement date NOT NULL,
  date_of_commencement date NOT NULL,
  basic_pension_amount integer NOT NULL,
  commuted_from_date date,
  commuted_upto_date date,
  commuted_pension_amount integer NOT NULL,
  enhance_pension_amount integer NOT NULL,
  reduced_pension_amount integer NOT NULL,
  religion CHAR(1) NOT NULL,
	created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL
);
COMMENT ON TABLE cts_pension.pensioners IS 'PensionModuleSchema v1';
COMMENT ON COLUMN cts_pension.pensioners.ppo_type IS 'P - Pension; F - Family Pension; C - CPF;';
COMMENT ON COLUMN cts_pension.pensioners.ppo_sub_type IS 'E - Employed; L - Widow Daughter; U - Unmarried Daughter; V - Divorced Daughter; N - Minor Son; R - Minor Daughter; P - Handicapped Son; G - Handicapped Daughter; J - Dependent Father; K - Dependent Mother; H - Husband; W - Wife;';
COMMENT ON COLUMN cts_pension.pensioners.gender IS 'M - Male; F - Female;';
COMMENT ON COLUMN cts_pension.pensioners.religion IS 'H - Hindu; M - Muslim; O - Other;';

CREATE TABLE IF NOT EXISTS cts_pension.ppo_sanction_details (
  id bigserial NOT NULL PRIMARY KEY,
  treasury_code character varying(3) NOT NULL,
  pensioner_id bigint NOT NULL references cts_pension.pensioners(id),
  ppo_id integer NOT NULL,
  employee_name character varying(500),
  sanction_authority character varying(500) NOT NULL,
  sanction_no character varying(500) NOT NULL,
  sanction_date date NOT NULL,
  employee_dob date,
  employee_gender CHAR(1),
  employee_date_of_appointment date,
  employee_office character varying(500),
  employee_designation character varying(500),
  employee_last_pay integer,
  average_emolument integer,
  employee_hrms_id character varying(500),
  issuing_authority character varying(500),
  issuing_letter_no character varying(500),
  issuing_letter_date date,
  qualifying_service_gross_years integer,
  qualifying_service_gross_months integer,
  qualifying_service_gross_days integer,
  qualifying_service_net_years integer,
  qualifying_service_net_months integer,
  qualifying_service_net_days integer,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL
);
COMMENT ON TABLE cts_pension.ppo_sanction_details IS 'PensionModuleSchema v1';


CREATE TABLE IF NOT EXISTS cts_pension.life_certificates (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
  pensioner_id bigint NOT NULL references cts_pension.pensioners(id),
  ppo_id integer NOT NULL,
  ppo_no character varying(100) NOT NULL ,
  bank_ac_no character varying(16) NOT NULL,
  ifsc_code character varying(11) NOT NULL,
  account_holder_name character varying(100) NOT NULL,
  mobile_number character varying(10) NOT NULL,
  certificate_flag boolean default false,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL
);
COMMENT ON TABLE cts_pension.life_certificates IS 'PensionModuleSchema v1';


CREATE TABLE IF NOT EXISTS cts_pension.nominees (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
  family_pension boolean,
  refused boolean,
  nominee_active boolean,
  serial_no integer NOT NULL,
  pensioner_id bigint NOT NULL references cts_pension.pensioners(id),
	ppo_id integer NOT NULL,
	nominee_name character varying(100) NOT NULL,
	relation CHAR(1) NOT NULL,
	date_of_birth date NOT NULL,
	date_of_death date,
	nominee_type CHAR(1),
  nominee_priority integer,
  nominee_share integer,
	bank_ac_no character varying(30),
  branch_id bigint references cts_pension.branches(id),
	identification_mark character varying(100),
  handicapped boolean,
	created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL
);
COMMENT ON TABLE cts_pension.nominees IS 'PensionModuleSchema v1';

-- CREATE TYPE cts_pension.pension_status AS ENUM(
--   'PpoApproved',
--   'FirstPensionBillApproved',
--   'PpoRunning',
--   'PpoSuspended',
--   'PpoBankAccountApproved'
-- );

CREATE TABLE IF NOT EXISTS cts_pension.ppo_status_flags (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
  pensioner_id bigint NOT NULL references cts_pension.pensioners(id),
  ppo_id integer NOT NULL,
  status_flag integer NOT NULL,
  reason_flag integer,
  -- status_flag cts_pension.pension_status NOT NULL,
  status_wef date NOT NULL,
  status_upto date,
	reason_remark character varying(500),
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL
);
COMMENT ON TABLE cts_pension.ppo_status_flags IS 'PensionModuleSchema v1';


CREATE TABLE IF NOT EXISTS cts_pension.ppo_component_revisions (
  id bigserial NOT NULL PRIMARY KEY,
  pensioner_id bigint NOT NULL references cts_pension.pensioners(id),
  ppo_id integer NOT NULL,
  rate_id bigint NOT NULL references cts_pension.component_rates(id),
  from_date date NOT NULL,
  to_date date,
  amount_per_month integer NOT NULL,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL
);
COMMENT ON TABLE cts_pension.ppo_component_revisions IS 'PensionModuleSchema v1';
COMMENT ON COLUMN cts_pension.ppo_component_revisions.id IS 'RevisionId';
COMMENT ON COLUMN cts_pension.ppo_component_revisions.from_date IS 'From date is the Date of Commencement of pension of the pensioner';
COMMENT ON COLUMN cts_pension.ppo_component_revisions.to_date IS 'To date (will be null for regular active bills)';
COMMENT ON COLUMN cts_pension.ppo_component_revisions.amount_per_month IS 'Amount per month is the actual amount paid for the mentioned period';

CREATE TABLE IF NOT EXISTS cts_pension.bills (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
  hoa_id character varying(50) NOT NULL,
  branch_id bigint NOT NULL references cts_pension.branches(id),
  bill_no integer NOT NULL,
  bill_date date NOT NULL,
  treasury_voucher_no character varying(100),
  treasury_voucher_date date,
  from_date date NOT NULL,
  to_date date NOT NULL,
  gross_amount integer NOT NULL,
  bytransfer_amount integer NOT NULL,
  net_amount integer NOT NULL,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL
);
COMMENT ON TABLE cts_pension.bills IS 'PensionModuleSchema v1';


CREATE TABLE IF NOT EXISTS cts_pension.ppo_bills (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
  bill_id bigint NOT NULL references cts_pension.bills(id),
  pensioner_id bigint NOT NULL references cts_pension.pensioners(id),
  ppo_id integer NOT NULL,
  bill_type CHAR(1) NOT NULL,
  utr_no character varying(100),
  utr_at timestamp without time zone,
  gross_amount integer NOT NULL,
  bytransfer_amount integer NOT NULL,
  net_amount integer NOT NULL,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL
);
COMMENT ON TABLE cts_pension.ppo_bills IS 'PensionModuleSchema v1';
COMMENT ON COLUMN cts_pension.ppo_bills.bill_type IS 'F - First Bill; R - Regular Bill;';
COMMENT ON COLUMN cts_pension.ppo_bills.utr_no IS 'UTRNo to refer to the actual transaction of the payment';
COMMENT ON COLUMN cts_pension.ppo_bills.utr_at IS 'UTRAt timestamp when the UTR is received';


CREATE TABLE IF NOT EXISTS cts_pension.ppo_bill_breakups (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
  ppo_id integer NOT NULL,
  ppo_bill_id bigint NOT NULL references cts_pension.ppo_bills(id),
  revision_id bigint NOT NULL references cts_pension.ppo_component_revisions(id),
  from_date date NOT NULL,
  to_date date NOT NULL,
  breakup_amount integer NOT NULL,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL,
  UNIQUE(treasury_code, ppo_id, ppo_bill_id, revision_id, from_date)
);
COMMENT ON TABLE cts_pension.ppo_bill_breakups IS 'PensionModuleSchema v1';
COMMENT ON COLUMN cts_pension.ppo_bill_breakups.ppo_bill_id IS 'BillId is to identify the bill on which the actual payment made';
COMMENT ON COLUMN cts_pension.ppo_bill_breakups.revision_id IS 'RevisionId is to identify the component rate applied on the bill';


CREATE TABLE IF NOT EXISTS cts_pension.bytransfers (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
  ppo_bill_id bigint NOT NULL references cts_pension.ppo_bills(id),
  bytransfer_hoa_id integer NOT NULL,
  bytransfer_wef date NOT NULL,
  bytransfer_amount integer NOT NULL,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer NOT NULL,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL
);
COMMENT ON TABLE cts_pension.bytransfers IS 'PensionModuleSchema v1';