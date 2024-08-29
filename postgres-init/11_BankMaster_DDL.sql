-- DROP SCHEMA "cts-bank-master";

CREATE SCHEMA "cts-bank-master" AUTHORIZATION postgres;

-- "cts-bank-master".banks definition

-- Drop table

-- DROP TABLE "cts-bank-master".banks;

CREATE TABLE "cts-bank-master".banks (
	id serial NOT NULL,
	bank_code int2 NOT NULL,
	bank_name varchar(100) NOT NULL,
	is_active bool NOT NULL,
	CONSTRAINT banks_bank_code_key UNIQUE (bank_code),
	CONSTRAINT banks_pkey PRIMARY KEY (id, bank_code)
);

-- "cts-bank-master".branchs definition

-- Drop table

-- DROP TABLE "cts-bank-master".branchs;

CREATE TABLE "cts-bank-master".branchs (
	id bigserial NOT NULL,
	city_code smallint NOT NULL,
	bank_code smallint NOT NULL REFERENCES "cts-bank-master".banks(bank_code),
	branch_code smallint NOT NULL,
	micr_code bpchar(9) NULL,
	branch_name varchar(100) NOT NULL,
	address varchar(100) NULL,
	city_name varchar(100) NULL,
	pincode bpchar(6) NULL,
	state varchar(100) NULL,
	is_active bool NOT NULL,
	CONSTRAINT branchs_pkey PRIMARY KEY (id),
	CONSTRAINT bank_code_fkey FOREIGN KEY (bank_code) REFERENCES "cts-bank-master".banks(bank_code)
);

-- "cts-bank-master".treasury_has_branch definition

-- Drop table

-- DROP TABLE "cts-bank-master".treasury_has_branch;

-- CREATE TABLE "cts-bank-master".treasury_has_branch (
-- 	id bigserial NOT NULL,
-- 	treasury_id smallint NULL REFERENCES master.treasury(id),
-- 	branchs_id bigint NULL REFERENCES "cts-bank-master".branchs(id)
-- );