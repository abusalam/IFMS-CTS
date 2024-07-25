-- SCHEMA: cts_pension

DROP SCHEMA IF EXISTS cts_pension CASCADE;

CREATE SCHEMA IF NOT EXISTS cts_pension AUTHORIZATION postgres;

CREATE TABLE IF NOT EXISTS cts_pension.uploaded_files (
  id bigserial NOT NULL PRIMARY KEY,
  file_path character varying(500) NOT NULL,
  file_name character varying(500) NOT NULL,
  file_mime_type character varying(500) NOT NULL,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean DEFAULT true
);

CREATE TABLE IF NOT EXISTS cts_pension.ppo_receipt_sequences (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
  next_sequence_value integer NOT NULL,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean DEFAULT true
);

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
  active_flag boolean  NOT NULL
);

CREATE TABLE IF NOT EXISTS cts_pension.pensioners (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
	ppo_id integer NOT NULL,
	ppo_no character varying(100) NOT NULL UNIQUE,
  ppo_type CHAR(1) NOT NULL,
  ppo_sub_type CHAR(1) NOT NULL,
  psa_type CHAR(1) NOT NULL,
  ppo_category CHAR(1) NOT NULL,
  ppo_sub_category CHAR(1) NOT NULL,
	pensioner_name character varying(100) NOT NULL , 
	date_of_birth date NOT NULL,
	gender CHAR(1),
	mobile_number character varying(10), 
	email_id character varying(100), 
	pensioner_address character varying(500), 
	identification_mark character varying(100), 
	pan_no character varying(10), 
	aadhaar_no character varying(12),
  date_of_retirement date NOT NULL,
  date_of_commencement date NOT NULL,
  basic_pension_amount integer NOT NULL,
  commuted_pension_amount integer NOT NULL,
  enhance_pension_amount integer NOT NULL,
  reduced_pension_amount integer NOT NULL,
  religion CHAR(1) NOT NULL,
  subdivision CHAR(1) NOT NULL,
  photo_file_id bigint references cts_pension.uploaded_files(id),
  signature_file_id bigint references cts_pension.uploaded_files(id),
	created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL,
  UNIQUE(ppo_id, treasury_code)
);

CREATE TABLE IF NOT EXISTS cts_pension.life_certificates (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
  ppo_id integer NOT NULL,
  ppo_no character varying(100) NOT NULL ,
  bank_ac_no character varying(16) NOT NULL,
  ifsc_code character varying(11) NOT NULL,
  account_holder_name character varying(100) NOT NULL,
  mobile_number character varying(10) NOT NULL,
  certificate_flag boolean default false,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean DEFAULT true,
  UNIQUE(ppo_id, treasury_code)
);

CREATE TABLE IF NOT EXISTS cts_pension.dml_history (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
	ppo_id integer NOT NULL,
  updated_table_field character varying(200) NOT NULL,
	from_record_id bigint NOT NULL , 
	to_record_id bigint NOT NULL,
	updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  updated_by integer
);

CREATE TABLE IF NOT EXISTS cts_pension.ppo_id_sequences (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
  next_sequence_value integer NOT NULL,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean DEFAULT true
);

CREATE TABLE IF NOT EXISTS cts_pension.bank_accounts (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
	ppo_id integer NOT NULL,
	account_holder_name character varying(100) NOT NULL , 
	bank_ac_no character varying(30), 
	ifsc_code character varying(11),
  bank_name character varying(100),
  branch_name character varying(100),
	created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean DEFAULT true,
  UNIQUE(ppo_id, treasury_code)
);

CREATE TABLE IF NOT EXISTS cts_pension.nominees (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
	ppo_id integer NOT NULL,
	nominee_name character varying(100) NOT NULL , 
	date_of_birth date NOT NULL,
	gender CHAR(1),
	mobile_number character varying(10), 
	email_id character varying(100), 
	nominee_address character varying(500), 
	identification_mark character varying(100), 
	pan_no character varying(10), 
	aadhaar_no character varying(12),
  photo_file_id bigint references cts_pension.uploaded_files(id),
  signature_file_id bigint references cts_pension.uploaded_files(id),
	created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean DEFAULT true,
  UNIQUE(ppo_id, treasury_code)
);

CREATE TABLE IF NOT EXISTS cts_pension.ppo_status_flags (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
  ppo_id integer NOT NULL,
  status_flag integer NOT NULL,
  status_wef date NOT NULL,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS cts_pension.ppo_components (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
  ppo_id integer NOT NULL,
  component_type CHAR(1) NOT NULL,
  component_name character varying(100) NOT NULL ,
  component_rate integer NOT NULL,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean DEFAULT true,
  UNIQUE(ppo_id, treasury_code)
);

CREATE TABLE IF NOT EXISTS cts_pension.ppo_payments (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
  ppo_id integer NOT NULL,
  payment_type CHAR(1) NOT NULL,
  payment_amount integer NOT NULL,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean DEFAULT true,
  UNIQUE(ppo_id, treasury_code)
);

CREATE TABLE IF NOT EXISTS cts_pension.ppo_bills (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
  ppo_id integer NOT NULL,
  paid_from date NOT NULL,
  paid_upto date NOT NULL,
  bill_type CHAR(1) NOT NULL,
  bill_no character varying(100) NOT NULL ,
  bill_date date NOT NULL,
  bill_amount integer NOT NULL,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean DEFAULT true,
  UNIQUE(ppo_id, treasury_code)
);

CREATE TABLE IF NOT EXISTS cts_pension.ppo_bill_components (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
  ppo_id integer NOT NULL,
  bill_id bigint NOT NULL references cts_pension.ppo_bills(id),
  component_id bigint NOT NULL references cts_pension.ppo_components(id),
  component_wef date NOT NULL,
  component_amount integer NOT NULL,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean DEFAULT true,
  UNIQUE(ppo_id, treasury_code)
);

CREATE TABLE IF NOT EXISTS cts_pension.ppo_bill_bytransfers (
  id bigserial NOT NULL PRIMARY KEY,
  financial_year integer NOT NULL,
  treasury_code character varying(3) NOT NULL,
  ppo_id integer NOT NULL,
  bill_id bigint NOT NULL references cts_pension.ppo_bills(id),
  bytransfers_hoa_id integer NOT NULL,
  bytransfers_wef date NOT NULL,
  bytransfers_amount integer NOT NULL,
  created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  created_by integer,
  updated_at timestamp without time zone DEFAULT NULL,
  updated_by integer,
  active_flag boolean DEFAULT true,
  UNIQUE(ppo_id, treasury_code)
);