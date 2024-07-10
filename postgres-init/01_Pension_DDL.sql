-- SCHEMA: cts_pension

DROP SCHEMA IF EXISTS cts_pension ;

CREATE SCHEMA IF NOT EXISTS cts_pension AUTHORIZATION postgres;

-- Table: cts_pension."P_MD_EMP_NOMINEE_DTL"

-- DROP TABLE IF EXISTS cts_pension."P_MD_EMP_NOMINEE_DTL";

CREATE TABLE IF NOT EXISTS "cts_pension"."P_MD_EMP_NOMINEE_DTL" 
(   "INT_PEN_NOM_ID" integer NOT NULL, 
	"INT_PENSIONER_ID" integer NOT NULL, 
	"INT_NOM_ID" integer NOT NULL , 
	"INT_EMPLOYEE_ID" integer NOT NULL , 
	"NOMINEE_NAME" VARCHAR(200) NOT NULL ,
	"GENDER" CHAR(1), 
	"INT_MARITAL_STATUS_ID" integer, 
	"DATE_OF_BIRTH" DATE NOT NULL , 
	"MINOR_FLAG" CHAR(1) DEFAULT 'N' NOT NULL , 
	"GUARDIAN_NAME" character varying(200), 
	"IDENTIFICATION_MARK" character varying(100), 
	"SHARE_PERCENTAGE" integer, 
	"BANK_AC_NO" character varying(30), 
	"IFSC_CODE" character varying(11), 
	"PRIORITY_LEVEL" integer DEFAULT 0 NOT NULL , 
	"MINOR_FLAG_CALCULATED_ON" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"BENF_TYPE_ID" integer NOT NULL , 
	"NOMINEE_TYPE" CHAR(1) DEFAULT 'O' NOT NULL , 
	"MOBILE_NUMBER" character varying(11), 
	"DML_STATUS_FLAG" integer DEFAULT 0 NOT NULL , 
	"USER_ID" integer DEFAULT 0 NOT NULL , 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 0 NOT NULL , 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP , 
	"INT_EMP_RELATIONSHIP_ID" integer, 
	"NOM_INT_OMI_PHYSIC_CHALLENGED" integer, 
	"NOM_PHYSIC_CHALLENGED_PERC_VH" integer, 
	"NOM_PHYSIC_CHALLENGED_PERC_PH" integer, 
	"INT_RELATION_ADDR_ID" integer, 
	"HOUSE_NO_STREET_LANE" character varying(100), 
	"CITY_TOWN_VILLAGE" character varying(100), 
	"POST_OFFICE" character varying(100), 
	"POLICE_STATION" character varying(100), 
	"STATE_ID" integer, 
	"INT_DISTRICT_ID" integer, 
	"PIN" character varying(10), 
	"GUARDIAN_ADDR" character varying(500), 
	"RELATION_IN_OUT" character varying(1), 
	"ROLE_ID" integer, 
	"MODIFIED_ROLE_ID" integer, 
	"REQUEST_ID" integer, 
	"ORG_NOM_ID_FOR_ALTERNATE" integer, 
	"ACTIVE_FLAG" character varying(1), 
	"DECLARATION_FOR_NOMINEE" character varying(300), 
	"ESE_FLAG" character varying(1), 
	"PROCESSING_FLAG" integer, 
	"EMAIL_ID" character varying(100), 
	"NOM_CONTINGENCY" character varying(500), 
	"REMARKS" character varying(500), 
	"REASON" character varying(500), 
	"CREATION_AFTER_DEATH_FLAG" character varying(1), 
	"NOM_DECEASED_FLAG" character varying(1) DEFAULT 'N' NOT NULL , 
	"AGE_ON_CREATED_DATE" character varying(100), 
	"OUT_REL_DESC" character varying(500), 
	"NOMINEE_LEGAL_HIRE_FLAG" character varying(1) DEFAULT 'N' NOT NULL , 
	 CONSTRAINT "PK_P_MD_EMP_NOMINEE_DTL" PRIMARY KEY ("INT_PEN_NOM_ID") 
);


COMMENT ON COLUMN cts_pension."P_MD_EMP_NOMINEE_DTL"."CREATED_TIMESTAMP" IS 'nominee creation and application date -- added by ritu';
COMMENT ON COLUMN cts_pension."P_MD_EMP_NOMINEE_DTL"."RELATION_IN_OUT" IS 'Relation In - 0, out - 1 --added by ritu';
COMMENT ON COLUMN cts_pension."P_MD_EMP_NOMINEE_DTL"."ORG_NOM_ID_FOR_ALTERNATE" IS 'original nominee id for whom this person is an alternate --added by ritu';
COMMENT ON COLUMN cts_pension."P_MD_EMP_NOMINEE_DTL"."PROCESSING_FLAG" IS '0 initiate, 1    approved, -1 rejected';
COMMENT ON COLUMN cts_pension."P_MD_EMP_NOMINEE_DTL"."REASON" IS 'reason for relation - out --added by ritu';
COMMENT ON COLUMN cts_pension."P_MD_EMP_NOMINEE_DTL"."CREATION_AFTER_DEATH_FLAG" IS 'Nominee created after death of employee Y/N';
COMMENT ON COLUMN cts_pension."P_MD_EMP_NOMINEE_DTL"."NOM_DECEASED_FLAG" IS '''Y'' for alive ''N'' for dead';
COMMENT ON COLUMN cts_pension."P_MD_EMP_NOMINEE_DTL"."AGE_ON_CREATED_DATE" IS 'Nominee age on created date for report';
COMMENT ON COLUMN cts_pension."P_MD_EMP_NOMINEE_DTL"."NOMINEE_LEGAL_HIRE_FLAG" IS 'N - nominee L - Legal Hier --added by pk pandit';

ALTER TABLE IF EXISTS cts_pension."P_MD_EMP_NOMINEE_DTL"
    OWNER to postgres;

CREATE TYPE "cts_pension"."ADDR_TYPE" AS ENUM ('PM','PR','CC');
CREATE TABLE IF NOT EXISTS "cts_pension"."P_MD_PENSIONER_ADDRESS" 
(	"INT_PENSIONER_ADDR_ID" integer NOT NULL, 
	"INT_EMPLOYEE_ID" integer NOT NULL, 
	"INT_PENSIONER_ID" integer NOT NULL, 
	"HOUSE_NO_STREET_LANE" character varying(100), 
	"CITY_TOWN_VILLAGE" character varying(100), 
	"POST_OFFICE" character varying(100), 
	"POLICE_STATION" character varying(100), 
	"STATE_ID" integer, 
	"INT_DISTRICT_ID" integer, 
	"PIN" character varying(10), 
	"WEF" DATE, 
	"ADDR_TYPE" "cts_pension"."ADDR_TYPE", 
	"SAME_AS_PERMANENT_ADDR" character varying(5) DEFAULT 'N', 
	"ACTIVE_FLAG" character varying(1) DEFAULT 'N' NOT NULL, 
	"CREATED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"EFFECTIVE_END_DATE" DATE, 
	"DML_STATUS_FLAG" integer DEFAULT 0 NOT NULL, 
	"REQUEST_ID" integer, 
	"COUNTRY_ID" integer, 
	"ROLE_ID" integer, 
	"MODIFIED_ROLE_ID" integer, 
	 CONSTRAINT "PK_P_MD_PENSIONER_ADDRESS" PRIMARY KEY ("INT_PENSIONER_ADDR_ID")
);

COMMENT ON COLUMN "cts_pension"."P_MD_PENSIONER_ADDRESS"."ADDR_TYPE" IS 'PM for Permanent, PR for present CM for communication address';
COMMENT ON COLUMN "cts_pension"."P_MD_PENSIONER_ADDRESS"."SAME_AS_PERMANENT_ADDR" IS 'N or Y';

ALTER TABLE IF EXISTS cts_pension."P_MD_PENSIONER_ADDRESS"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS "cts_pension"."P_MD_PEN_EMP_COPY_FORWARD_TO" 
(	"INT_COPY_FORWARD_ID" integer NOT NULL, 
	"INT_PENSIONER_ID" integer, 
	"SEQ_NO" integer, 
	"COPY_FORWARD_TO_TEXT" character varying(500), 
	"ACTIVE_FLAG" character varying(1), 
	"DML_STATUS_FLAG" integer, 
	 CONSTRAINT "PK_P_MD_PEN_COPY_FORWARD_TO" PRIMARY KEY ("INT_COPY_FORWARD_ID")
);

ALTER TABLE IF EXISTS cts_pension."P_MD_PEN_EMP_COPY_FORWARD_TO"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS "cts_pension"."P_MD_PEN_EMP_WISE_FORWARD_LIST" 
(	"INT_PEN_FORWARDING_ID" integer NOT NULL , 
	"INT_PENSIONER_ID" integer, 
	"SL_NO" integer, 
	"FORWARDING_TEXT" character varying(500), 
	"ACTIVE_FLAG" character varying(1) DEFAULT 'Y', 
	"DML_STATUS_FLAG" integer, 
	 CONSTRAINT "PK_MD_PEN_EMP_WISE_FORWARDING" PRIMARY KEY ("INT_PEN_FORWARDING_ID") 
);

COMMENT ON COLUMN "cts_pension"."P_MD_PEN_EMP_WISE_FORWARD_LIST"."ACTIVE_FLAG" IS '''Y'' / ''N'' Flag';
ALTER TABLE IF EXISTS cts_pension."P_MD_PEN_EMP_WISE_FORWARD_LIST"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS "cts_pension"."P_MD_PEN_PREP_ATTACHMENT" 
(	"INT_PEN_PREP_ATTACHEMENT" integer NOT NULL , 
	"SERVICE_BOOK_EXIT_MNGMNT_FLAG" character varying(1) NOT NULL , 
	"DOCUMENT_ID" integer NOT NULL , 
	"CONTENT_ID" character varying(38) NOT NULL , 
	"INT_EMPLOYEE_ID" integer NOT NULL , 
	"REQUEST_ID" integer, 
	"REQUEST_TYPE" character varying(15), 
	"FILE_NAME" character varying(100), 
	"FILE_TYPE" character varying(20), 
	"ACTIVE_FLAG" character varying(1) DEFAULT 'Y' NOT NULL , 
	"DML_STATUS_FLAG" integer DEFAULT 0 NOT NULL , 
	"CREATED_USER_ID" integer DEFAULT 0 NOT NULL , 
	"CREATED_ROLE_ID" integer NOT NULL , 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 0, 
	"MODIFIED_ROLE_ID" integer, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"INT_OMI_UPD_DOC_TYPE" integer, 
	 CONSTRAINT "PK_P_MD_PEN_PREP_ATTACHEMENT" PRIMARY KEY ("INT_PEN_PREP_ATTACHEMENT") , 
	 CONSTRAINT "UK_P_MD_PEN_PREP_ATTACHEMENT1" UNIQUE ("DOCUMENT_ID") , 
	 CONSTRAINT "UK_P_MD_PEN_PREP_ATTACHEMENT2" UNIQUE ("CONTENT_ID") 
);

COMMENT ON COLUMN cts_pension."P_MD_PEN_PREP_ATTACHMENT"."SERVICE_BOOK_EXIT_MNGMNT_FLAG" IS 'For Service book : ''S'' for Exit Management ''E''';
COMMENT ON COLUMN cts_pension."P_MD_PEN_PREP_ATTACHMENT"."INT_OMI_UPD_DOC_TYPE" IS 'document type from other master master type: ''AFT''';
ALTER TABLE IF EXISTS cts_pension."P_MD_PEN_PREP_ATTACHMENT"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS "cts_pension"."P_MD_PEN_PREP_CALCULATED_AMT" 
(	"INT_PREP_CALCULATED_AMT_ID" integer NOT NULL, 
	"INT_PENSIONER_ID" integer NOT NULL, 
	"INT_PEN_PREP_CALC_HEADER_ID" integer NOT NULL, 
	"ITERATION_NO" integer NOT NULL, 
	"BENF_TYPE_ID" integer,
	"PEN_TYPE_ID" integer NOT NULL, 
	"INT_PEN_PREP_CALC_HDR_ID" integer NOT NULL, 
	"INT_PEN_RULE_DTLS_ID" integer NOT NULL, 
	"AMOUNT_SYSTEM" integer, 
	"AMOUNT_APPLICABLE_FOR_CALC" integer, 
	"ACTIVE_FLAG" character varying(1) NOT NULL, 
	"REQUEST_ID" integer NOT NULL, 
	"DML_STATUS_FLAG" integer DEFAULT 0 NOT NULL, 
	"CREATED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"CREATED_ROLE_ID" integer NOT NULL, 
	"MODIFIED_ROLE_ID" integer NOT NULL, 
	"FORMULA_WITH_VALUE" character varying(500), 
	"WORKFLOW_STATUS_FLAG" character varying(2) NOT NULL, 
	 CONSTRAINT "PK_PEN_PREP_CALCULATED_AMT" PRIMARY KEY ("INT_PREP_CALCULATED_AMT_ID")
);
ALTER TABLE IF EXISTS cts_pension."P_MD_PEN_PREP_CALCULATED_AMT"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS "cts_pension"."P_MD_PEN_PREP_CALCULATION_HDR" 
(	"INT_PEN_PREP_CALC_HDR_ID" integer NOT NULL, 
	"INT_PENSIONER_ID" integer NOT NULL, 
	"INT_PEN_PREP_CALC_HEADER_ID" integer NOT NULL, 
	"ITERATION_NO" integer NOT NULL, 
	"REQUEST_ID" integer NOT NULL, 
	"INT_PEN_RULE_NAME_ID" integer NOT NULL, 
	"NET_QUALIFYING_SERVICE_YR" integer, 
	"NET_QUALIFYING_SERVICE_MON" integer, 
	"NET_QUALIFYING_SERVICE_DAYS" integer, 
	"LAST_PAY" integer, 
	"LAST_BASIC" integer, 
	"LAST_GRADE_PAY" integer, 
	"LAST_DA" integer, 
	"DATE_OF_BIRTH" DATE NOT NULL, 
	"DATE_OF_RETIREMENT" DATE NOT NULL, 
	"AGE_AT_NEXT_BIRTHDAY" integer NOT NULL, 
	"DML_STATUS_FLAG" integer DEFAULT 0 NOT NULL, 
	"CREATED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"CREATED_ROLE_ID" integer NOT NULL, 
	"MODIFIED_ROLE_ID" integer NOT NULL, 
	"WORKFLOW_STATUS_FLAG" character varying(2) NOT NULL, 
	"LAST_MA" integer, 
	 CONSTRAINT "PK_PEN_PREP_CALCULATION_HDR" PRIMARY KEY ("INT_PEN_PREP_CALC_HDR_ID")
);
ALTER TABLE IF EXISTS cts_pension."P_MD_PEN_PREP_CALCULATION_HDR"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS "cts_pension"."P_MD_PEN_PREP_EMOLUMENT_DTLS" 
(	"INT_PEN_PREP_EML_DTLS_ID" integer NOT NULL, 
	"INT_PENSIONER_ID" integer NOT NULL, 
	"INT_PEN_PREP_CALC_HEADER_ID" integer NOT NULL, 
	"ITERATION_NO" integer NOT NULL, 
	"INT_COMPONENT_ID" integer, 
	"COMPONENT_NAME" character varying(300), 
	"INT_COMPONENT_ID_DEPUTATION" integer, 
	"WEF_DATE" DATE, 
	"AMOUNT_SYSTEM" integer, 
	"AMOUNT_APPLICABLE_FOR_CALC" integer, 
	"HRMS_DEPUTATION_FLAG" character varying(2), 
	"ACTIVE_FLAG" character varying(1) NOT NULL, 
	"REQUEST_ID" integer NOT NULL, 
	"DML_STATUS_FLAG" integer DEFAULT 0 NOT NULL, 
	"CREATED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"CREATED_ROLE_ID" integer NOT NULL, 
	"MODIFIED_ROLE_ID" integer NOT NULL, 
	"WORKFLOW_STATUS_FLAG" character varying(2) NOT NULL, 
	"CALC_INCLUDE_FLAG" character varying(1) NOT NULL, 
	 CONSTRAINT "PK_P_MD_PEN_PREP_EMOL_DTLS" PRIMARY KEY ("INT_PEN_PREP_EML_DTLS_ID")
);

ALTER TABLE IF EXISTS cts_pension."P_MD_PEN_PREP_EMOLUMENT_DTLS"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS "cts_pension"."P_MD_PEN_PREP_OTH_OUTSTANDING" 
(	"INT_PEN_OTH_OUTSTANDING_ID" integer NOT NULL, 
	"INT_PENSIONER_ID" integer NOT NULL, 
	"INT_PEN_PREP_CALC_HEADER_ID" integer NOT NULL, 
	"ITERATION_NO" integer NOT NULL, 
	"OUTSTANDING_TYPE" character varying(2) NOT NULL, 
	"COMP_DESCRIPTION" character varying(200), 
	"INT_OVERDRAWL_DETAILS_ID" integer, 
	"INT_COMPONENT_ID" integer NOT NULL, 
	"AMOUNT" integer NOT NULL, 
	"FROM_DATE" DATE, 
	"RECOVERY_FLAG" character varying(1), 
	"HOA_ID" integer, 
	"DEMAND_NO" character varying(2), 
	"MAJOR_HEAD" character varying(4), 
	"SUBMAJOR_HEAD" character varying(2), 
	"MINOR_HEAD" character varying(3), 
	"PLAN_STATUS" character varying(2), 
	"SCHEME_HEAD" character varying(3), 
	"DETAIL_HEAD" character varying(2) NOT NULL, 
	"SUBDETAIL_HEAD" character varying(2) NOT NULL, 
	"CHARGED_VOTED" character varying(1), 
	"MODIFIABLE_FLAG" character varying(1) NOT NULL, 
	"ACTIVE_FLAG" character varying(1) NOT NULL, 
	"REQUEST_ID" integer NOT NULL, 
	"DML_STATUS_FLAG" integer DEFAULT 0 NOT NULL, 
	"CREATED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"CREATED_ROLE_ID" integer NOT NULL, 
	"MODIFIED_ROLE_ID" integer NOT NULL, 
	"WORKFLOW_STATUS_FLAG" character varying(2) NOT NULL, 
	"REMARKS" character varying(100), 
	"OVRDRAWAL_REASON" character varying(500), 
	"RECOVERED_AMOUNT" integer, 
	"DIFFERENCE_AMOUNT" integer, 
	 CONSTRAINT "PK_P_MD_PEN_PREP_OTH_OUTSTAND" PRIMARY KEY ("INT_PEN_OTH_OUTSTANDING_ID")
);

COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_OTH_OUTSTANDING"."OUTSTANDING_TYPE" IS '''PA''--- Pay Allowance type overdrawl out standing, ''OTH'' other outstanding';
ALTER TABLE IF EXISTS cts_pension."P_MD_PEN_PREP_OTH_OUTSTANDING"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS "cts_pension"."P_MD_PEN_PREP_OUTSTANDING_LOAN" 
(	"INT_PEN_OUTSTANDING_LOAN_ID" integer NOT NULL, 
	"INT_PENSIONER_ID" integer NOT NULL, 
	"INT_PEN_PREP_CALC_HEADER_ID" integer NOT NULL, 
	"ITERATION_NO" integer NOT NULL, 
	"INT_LOAN_ADVANCE_TYPE_ID" integer NOT NULL, 
	"INT_EMP_LOAN_ADVANCE_ID" integer NOT NULL, 
	"INT_COMPONENT_ID_PRIN" integer NOT NULL, 
	"INT_COMPONENT_ID_INT" integer, 
	"OUTSTANDING_AS_ON_DATE" DATE, 
	"SANCTION_DATE" DATE, 
	"OUT_STANDING_PRIN_AMT" integer, 
	"OUT_STANDING_INT_AMT" integer, 
	"REMARKS" character varying(100), 
	"MODIFIABLE_FLAG" character varying(1) NOT NULL, 
	"ACTIVE_FLAG" character varying(1) NOT NULL, 
	"REQUEST_ID" integer NOT NULL, 
	"DML_STATUS_FLAG" integer DEFAULT 0 NOT NULL, 
	"CREATED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"CREATED_ROLE_ID" integer NOT NULL, 
	"MODIFIED_ROLE_ID" integer NOT NULL, 
	"WORKFLOW_STATUS_FLAG" character varying(2) NOT NULL, 
	 CONSTRAINT "PK_P_MD_PEN_PREP_OS_LOAN" PRIMARY KEY ("INT_PEN_OUTSTANDING_LOAN_ID")
);
ALTER TABLE IF EXISTS cts_pension."P_MD_PEN_PREP_OUTSTANDING_LOAN"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS "cts_pension"."P_MD_PEN_PREP_OUTSTND_LOAN_DTL" 
(	"INT_PEN_OUTSTND_LOAN_DTL_ID" integer NOT NULL, 
	"INT_PEN_OUTSTANDING_LOAN_ID" integer NOT NULL, 
	"INT_PENSIONER_ID" integer NOT NULL, 
	"INT_PEN_PREP_CALC_HEADER_ID" integer NOT NULL, 
	"ITERATION_NO" integer NOT NULL, 
	"INT_EMP_RECOVERY_ID" integer NOT NULL, 
	"INT_COMP_ID" integer NOT NULL, 
	"RECOVERY_AMOUNT" integer NOT NULL, 
	"WEF" DATE NOT NULL, 
	"EFFECTIVE_END_DATE" DATE NOT NULL, 
	"INT_EMP_LOAN_ADVANCE_ID" integer NOT NULL, 
	"PAID_FLAG" character varying(1) NOT NULL, 
	"PAID_DATE" DATE, 
	"PAID_AMOUNT" integer, 
	"LEGACY_FLAG" character varying(1), 
	"INT_EMP_LOAN_ADV_FC_ID" integer, 
	"REMARKS" character varying(100), 
	"MODIFIABLE_FLAG" character varying(1) NOT NULL, 
	"ACTIVE_FLAG" character varying(1) NOT NULL, 
	"REQUEST_ID" integer NOT NULL, 
	"DML_STATUS_FLAG" integer DEFAULT 0 NOT NULL, 
	"CREATED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"CREATED_ROLE_ID" integer, 
	"MODIFIED_ROLE_ID" integer, 
	 CONSTRAINT "PK_P_MD_PEN_OUTS_LOAN_DTL" PRIMARY KEY ("INT_PEN_OUTSTND_LOAN_DTL_ID")
);
ALTER TABLE IF EXISTS cts_pension."P_MD_PEN_PREP_OUTSTND_LOAN_DTL"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS "cts_pension"."P_MD_PEN_PREP_PAY_DTLS" 
(	"INT_PEN_PREP_PAY_DTLS_ID" integer NOT NULL, 
	"INT_PENSIONER_ID" integer NOT NULL, 
	"INT_PEN_PREP_CALC_HEADER_ID" integer NOT NULL, 
	"ITERATION_NO" integer NOT NULL, 
	"INT_PAY_BAND_ID" integer, 
	"INT_PAY_SCALE_ID" integer, 
	"INT_REV_PAY_ALLOWANCE_ID" integer NOT NULL, 
	"PAY_SCALE_BAND_NAME" character varying(300) NOT NULL, 
	"ROPA_NAME" character varying(300) NOT NULL, 
	"ACTIVE_FLAG" character varying(1) NOT NULL, 
	"REQUEST_ID" integer NOT NULL, 
	"DML_STATUS_FLAG" integer DEFAULT 0 NOT NULL, 
	"CREATED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"CREATED_ROLE_ID" integer, 
	"MODIFIED_ROLE_ID" integer, 
	"WORKFLOW_STATUS_FLAG" character varying(2) NOT NULL, 
	"INT_PAY_BILL_GROUP_ID" integer, 
	"NEXT_INCRIMENT_DATE" DATE, 
	"NEXT_INCRISE_BASIC_AMT" integer, 
	"NEXT_INCRISE_SPECIAL_PAY" integer, 
	"TOT_SAL_DRAWN" integer, 
	"TOT_SAL_DRAWN_DATE" DATE, 
	"NEXT_INCRISE_NPA_AMT" integer, 
	"NEXT_INCRISE_SPCL_PAY_MODIFIED" integer, 
	"IMMEDIATE_RELIEF_PAID_FLAG" character varying(1), 
	"IMMEDIATE_RELIEF_PAID_AMT" integer, 
	"IMMEDIATE_RELIEF_PAID_REMARKS" character varying(500), 
	 CONSTRAINT "PK_P_MD_PEN_PREP_PAY_DTLS" PRIMARY KEY ("INT_PEN_PREP_PAY_DTLS_ID")
);
ALTER TABLE IF EXISTS cts_pension."P_MD_PEN_PREP_PAY_DTLS"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS "cts_pension"."P_MD_PEN_PREP_PROV_PENSION_DTL" 
(	"INT_PEN_PROV_PENSION_ID" integer NOT NULL, 
	"INT_PENSIONER_ID" integer NOT NULL, 
	"PENSION_START_DATE" DATE NOT NULL, 
	"PENSION_END_DATE" DATE NOT NULL, 
	"MEMO_NO" character varying(100), 
	"MEMO_DATE" DATE, 
	"UO_NO" character varying(100), 
	"UO_DATE" DATE, 
	"ACTIVE_FLAG" character varying(1) NOT NULL, 
	"DML_STATUS_FLAG" integer NOT NULL, 
	"PENSION_HOA_MAP_ID" integer, 
	"GRATUITY_HOA_MAP_ID" integer, 
	"PENSION_HOA_DESC" character varying(200), 
	"GRATUITY_HOA_DESC" character varying(200), 
	"REMARKS" character varying(1000), 
	"REQUEST_ID" integer, 
	"CREATED_USER_ID" integer DEFAULT 99999 NOT NULL, 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 99999 NOT NULL, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"PENSION_RATE_PER_MONTH_USER" integer, 
	"TOTAL_PENSION_PERIOD_USER" character varying(100), 
	 CONSTRAINT "PK_PEN_PREP_PROV_PENSION_DTL" PRIMARY KEY ("INT_PEN_PROV_PENSION_ID")
   );

COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_PROV_PENSION_DTL"."PENSION_RATE_PER_MONTH_USER" IS 'as per CR 181305';
COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_PROV_PENSION_DTL"."TOTAL_PENSION_PERIOD_USER" IS 'as per CR 181305';
ALTER TABLE IF EXISTS cts_pension."P_MD_PEN_PREP_PROV_PENSION_DTL"
    OWNER to postgres;

CREATE TYPE "cts_pension"."QUAL_NON_QUAL_WEIGHTAGE_TYPE" AS ENUM ('Q','N','W');
CREATE TYPE "cts_pension"."PERIOD_TYPE" AS ENUM ('SHRMS','SNHRMS','SADD','SDEPH','SDEPNH','SNQHL','SNQNHL','SNQHS','SNQNHS','SNQO','WSADM');
CREATE TABLE IF NOT EXISTS "cts_pension"."P_MD_PEN_PREP_SERVICE_DTLS" 
(	"INT_PEN_SERVICE_DTLS_ID" integer NOT NULL, 
	"INT_PENSIONER_ID" integer NOT NULL, 
	"INT_SERVICE_TYPE_ID" integer, 
	"INT_PEN_PREP_CALC_HEADER_ID" integer NOT NULL, 
	"SOURCE_ORG_ADD_SERVICE_NAME" character varying(200) NOT NULL, 
	"FROM_DATE" DATE NOT NULL, 
	"TO_DATE" DATE NOT NULL, 
	"YEAR_IN_NUM" integer NOT NULL, 
	"MONTH_IN_NUM" integer NOT NULL, 
	"DAYS_IN_NUM" integer NOT NULL, 
	"REMARKS" character varying(100), 
	"MODIFIABLE_FLAG" character varying(1) NOT NULL, 
	"PERIOD_TYPE" "cts_pension"."PERIOD_TYPE" NOT NULL, 
	"QUAL_NON_QUAL_WEIGHTAGE_TYPE" "cts_pension"."QUAL_NON_QUAL_WEIGHTAGE_TYPE" NOT NULL, 
	"ACTIVE_FLAG" character varying(1) NOT NULL, 
	"REQUEST_ID" integer NOT NULL, 
	"DML_STATUS_FLAG" integer DEFAULT 0 NOT NULL, 
	"CREATED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"CREATED_ROLE_ID" integer NOT NULL, 
	"MODIFIED_ROLE_ID" integer NOT NULL, 
	"ITERATION_NO" integer NOT NULL, 
	"INT_EMP_WORKING_DTLS_ID" integer, 
	"INT_LEAVE_TYPE_ID" integer, 
	"BUSINESS_PK_TYPE" character varying(5), 
	"INT_LEAVE_ID" integer, 
	"INT_OTHER_SERVICE_TYPE_ID" integer, 
	"INT_EMP_WORKING_DTLS_ID_DEPU" integer, 
	"WORKFLOW_STATUS_FLAG" character varying(2) NOT NULL, 
	"CONTRIBUTION_RECEIVED_FLAG" character varying(1), 
	"PENSION_RECEIVED" integer, 
	"GRATUITY_RECEIVED" integer, 
	"CONTRIBUTION_RECEIVED_SOURCE" character varying(500), 
	"GOVT_NAME" character varying(500), 
	"FAMILY_PENSION_FLAG" character varying(1), 
	"GO_NO" character varying(200), 
	"GO_DATE" DATE, 
	"AMT_OF_CONTRIBUTION" integer, 
	 CONSTRAINT "PK_P_MD_PEN_PREP_SERVICE_DTLS" PRIMARY KEY ("INT_PEN_SERVICE_DTLS_ID")
);

COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_SERVICE_DTLS"."PERIOD_TYPE" IS 'SHRMS-  Service HRMS,                 SNHRMS- Service Non HRMS,
SADD-   Additional Service,
SDEPH-  herms deputation,             SDEPNH- deputation non hrms,
SNQHL-  non qualifying hrms leave,    SNQNHL-non qualifying non hrms leave,
SNQHS-  non qualifying hrms suspence, SNQNHS-non qualifying non hrms suspence,
SNQO-   non qualifying others,        WSADM --- Weightage  ';
COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_SERVICE_DTLS"."INT_EMP_WORKING_DTLS_ID" IS 'Not required from fron end';
COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_SERVICE_DTLS"."INT_LEAVE_TYPE_ID" IS 'Not required from fron end';
COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_SERVICE_DTLS"."BUSINESS_PK_TYPE" IS 'Not required from fron end';
COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_SERVICE_DTLS"."INT_LEAVE_ID" IS 'Not required from fron end';
COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_SERVICE_DTLS"."INT_OTHER_SERVICE_TYPE_ID" IS 'will come from hr_mm_gen_other_master p WHERE p.master_abbr = ''OST''';
COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_SERVICE_DTLS"."INT_EMP_WORKING_DTLS_ID_DEPU" IS 'Not required from fron end For Deputation';
COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_SERVICE_DTLS"."CONTRIBUTION_RECEIVED_FLAG" IS '22c Any Contribution Received Y/N flag';
COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_SERVICE_DTLS"."PENSION_RECEIVED" IS '22d';
COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_SERVICE_DTLS"."GRATUITY_RECEIVED" IS '22d';
COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_SERVICE_DTLS"."CONTRIBUTION_RECEIVED_SOURCE" IS '22f';
COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_SERVICE_DTLS"."GOVT_NAME" IS 'Government under which the service';
COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_SERVICE_DTLS"."FAMILY_PENSION_FLAG" IS '22e Y/N flag';
COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_SERVICE_DTLS"."GO_NO" IS 'Added for Block ''B'' & ''C'' see CR No 181316 for Details';
COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_SERVICE_DTLS"."GO_DATE" IS 'Added for Block ''B'' & ''C'' see CR No 181316 for Details';
COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_SERVICE_DTLS"."AMT_OF_CONTRIBUTION" IS 'Added for Block ''B'' & ''C'' see CR No 181316 for Details';
ALTER TABLE IF EXISTS cts_pension."P_MD_PEN_PREP_SERVICE_DTLS"
    OWNER to postgres;

CREATE TYPE "cts_pension"."ACTIVE_FLAG" AS ENUM ('Y','N');
CREATE TABLE IF NOT EXISTS "cts_pension"."P_MD_PEN_PREP_TYPE" 
(	"CATEGORY_ID" integer NOT NULL, 
	"PEN_TYPE_ID" integer NOT NULL, 
	"TYPE_DESC" character varying(400) NOT NULL, 
	"TYPE_ABBR" CHAR(1) NOT NULL, 
	"ACTIVE_FLAG" "cts_pension"."ACTIVE_FLAG" DEFAULT 'Y' NOT NULL, 
	"USER_ID" integer DEFAULT 0 NOT NULL, 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"PEN_TYPE_ABBR" character varying(3), 
	"PENSION_TYPE_FLAG" character varying(1), 
	"PENSION_CALC_TYPE" character varying(2), 
	 CONSTRAINT "PK_P_MD_PEN_PREP_TYPE" PRIMARY KEY ("PEN_TYPE_ID"), 
	 CONSTRAINT "UK_P_MD_PEN_PREP_TYPE1" UNIQUE ("PEN_TYPE_ABBR", "PENSION_TYPE_FLAG")
);

COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_TYPE"."CATEGORY_ID" IS 'Reference column from P_MM_PEN_PREP_CATEGORY..';
COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_TYPE"."PEN_TYPE_ID" IS 'Unique pension ID type.';
COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_TYPE"."TYPE_ABBR" IS '''F'' = Family';
COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_TYPE"."PEN_TYPE_ABBR" IS 'added kalyan';
COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_TYPE"."PENSION_TYPE_FLAG" IS '''P'' for Provisional & ''F'' for Final Pension';
COMMENT ON COLUMN "cts_pension"."P_MD_PEN_PREP_TYPE"."PENSION_CALC_TYPE" IS 'Types are commomn Superannuation & ''Death'' ''SP'' & ''DP''';
ALTER TABLE IF EXISTS cts_pension."P_MD_PEN_PREP_TYPE"
    OWNER to postgres;

CREATE TYPE "cts_pension"."MANDATORY_FLAG" AS ENUM ('Y','O','N');
CREATE TABLE IF NOT EXISTS "cts_pension"."P_MM_EXIT_FORWARDING_LIST" 
(	"INT_FRWDING_LIST_ID" integer NOT NULL, 
	"INT_PENSIONER_ID" integer, 
	"REPORT_NAME" character varying(200) NOT NULL, 
	"REPORT_ABBR" character varying(5), 
	"ACTIVE_FLAG" "cts_pension"."ACTIVE_FLAG" NOT NULL, 
	"IN_USER_ID" integer NOT NULL, 
	"PEN_TYPE_ID" integer, 
	"PEN_TYPE_ABBR" character varying(3), 
	"MANDATORY_FLAG" "cts_pension"."MANDATORY_FLAG", 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"ODR_SL_NO" integer, 
	 CONSTRAINT "PK_FORWARDING_LIST" PRIMARY KEY ("INT_FRWDING_LIST_ID")
);

COMMENT ON TABLE "cts_pension"."P_MM_EXIT_FORWARDING_LIST" IS 'Details required for generating forwarding letter report';
COMMENT ON COLUMN "cts_pension"."P_MM_EXIT_FORWARDING_LIST"."INT_FRWDING_LIST_ID" IS 'primary key of this table';
COMMENT ON COLUMN "cts_pension"."P_MM_EXIT_FORWARDING_LIST"."INT_PENSIONER_ID" IS 'foreign key from pension master table';
COMMENT ON COLUMN "cts_pension"."P_MM_EXIT_FORWARDING_LIST"."REPORT_NAME" IS 'name of the reports whose name needs to be displayed in the forwardign letter report';
COMMENT ON COLUMN "cts_pension"."P_MM_EXIT_FORWARDING_LIST"."ACTIVE_FLAG" IS 'value - Y for active and N for inactive';
COMMENT ON COLUMN "cts_pension"."P_MM_EXIT_FORWARDING_LIST"."IN_USER_ID" IS 'user id of the person who will be generating the report';
COMMENT ON COLUMN "cts_pension"."P_MM_EXIT_FORWARDING_LIST"."PEN_TYPE_ID" IS 'foreign key from pension type table';
COMMENT ON COLUMN "cts_pension"."P_MM_EXIT_FORWARDING_LIST"."PEN_TYPE_ABBR" IS 'abbr for pension type';
COMMENT ON COLUMN "cts_pension"."P_MM_EXIT_FORWARDING_LIST"."MANDATORY_FLAG" IS 'value - Y (when mandatory for all benefit types), O (when mandatory based on a certain benefit type), N - (when not mandatory)';
COMMENT ON COLUMN "cts_pension"."P_MM_EXIT_FORWARDING_LIST"."CREATED_TIMESTAMP" IS 'time when this record was craeted.';
COMMENT ON COLUMN "cts_pension"."P_MM_EXIT_FORWARDING_LIST"."ODR_SL_NO" IS 'used for showing the list in particular order';

CREATE TABLE IF NOT EXISTS "cts_pension"."P_MM_PEN_BENF_TYPE_REL_MAP" 
(	"INT_BENF_TYPE_REL_MAP_ID" integer NOT NULL, 
	"BENF_TYPE_ID" integer NOT NULL, 
	"INT_OTHER_MASTER_ID" integer NOT NULL, 
	 CONSTRAINT "PK_BENF_TYPE_REL_MAP" PRIMARY KEY ("INT_BENF_TYPE_REL_MAP_ID")
);

COMMENT ON COLUMN "cts_pension"."P_MM_PEN_BENF_TYPE_REL_MAP"."BENF_TYPE_ID" IS '5=Family Pension,4=Death Gratuity';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_BENF_TYPE_REL_MAP"."INT_OTHER_MASTER_ID" IS 'master_type  = ''RL''';

CREATE TABLE IF NOT EXISTS "cts_pension"."P_MM_PEN_COMMUTATION_RATE" 
(	"INT_PEN_COMMUTATION_RATE_ID" integer NOT NULL, 
	"AGE_ON_NEXT_BIRTHDAY" integer, 
	"COMMUTATION_RATE" integer, 
	 CONSTRAINT "PK_P_MM_PEN_COMMUTATION_RATE" PRIMARY KEY ("INT_PEN_COMMUTATION_RATE_ID")
);

CREATE TABLE IF NOT EXISTS "cts_pension"."P_MM_PEN_HOA_MAP" 
(	"INT_HOA_MAP_ID" integer NOT NULL, 
	"FULL_HOA" character varying(200), 
	"HOA_NAME" character varying(200), 
	"HOA_TYPE_ABBR" character varying(50), 
	"ACTIVE_FLAG" "cts_pension"."ACTIVE_FLAG" DEFAULT 'Y' NOT NULL, 
	"CREATED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	 CONSTRAINT "PK_P_MM_PEN_HOA_MAP" PRIMARY KEY ("INT_HOA_MAP_ID")
);
CREATE TYPE "cts_pension"."OPTIONAL_MANDATORY_FLAG" AS ENUM ('O','M');
CREATE TABLE IF NOT EXISTS "cts_pension"."P_MM_PEN_PREP_ATTACHEMENT" 
(	"INT_PEN_PREP_ATTACHEMENT" integer NOT NULL, 
	"ATTCHEMENT_DESC" character varying(300) NOT NULL, 
	"OPTIONAL_MANDATORY_FLAG" "cts_pension"."OPTIONAL_MANDATORY_FLAG" NOT NULL, 
	"ACTIVE_FLAG" "cts_pension"."ACTIVE_FLAG" NOT NULL, 
	"DML_STATUS_FLAG" integer DEFAULT 0 NOT NULL, 
	"USER_ID" integer DEFAULT 0 NOT NULL, 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"ROLE_ID" integer, 
	"MODIFIED_ROLE_ID" integer, 
	"REQUEST_TYPE" character varying(15) NOT NULL, 
	 CONSTRAINT "PK_P_MM_PEN_PREP_ATTACH" PRIMARY KEY ("INT_PEN_PREP_ATTACHEMENT"), 
	 CONSTRAINT "UK_P_MM_PEN_PREP_ATTACH1" UNIQUE ("ATTCHEMENT_DESC", "REQUEST_TYPE"), 
	 CONSTRAINT "UK_P_MM_PEN_PREP_ATTACH2" UNIQUE ("REQUEST_TYPE", "INT_PEN_PREP_ATTACHEMENT")
);

CREATE TABLE IF NOT EXISTS "cts_pension"."P_MM_PEN_PREP_CALC_HEADER" 
(	"INT_PEN_PREP_CALC_HEADER_ID" integer NOT NULL, 
	"INT_PENSIONER_ID" integer NOT NULL, 
	"ITERATION_NO" integer NOT NULL, 
	"ACTIVE_FLAG" "cts_pension"."ACTIVE_FLAG" NOT NULL, 
	"REQUEST_ID" integer NOT NULL, 
	"DATE_OF_COMMENCE_PEN_SERVICE" DATE, 
	"DATE_OF_COMMENCE_PEN" DATE, 
	"WORK_CHARGE_EMPLOYEE" character varying(1), 
	"DML_STATUS_FLAG" integer DEFAULT 0 NOT NULL, 
	"CREATED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"CREATED_ROLE_ID" integer NOT NULL, 
	"MODIFIED_ROLE_ID" integer NOT NULL, 
	"WORKFLOW_STATUS_FLAG" character varying(2) NOT NULL, 
	"PENSION_PAY_ORDER_NO" character varying(50), 
	"PENSION_PAY_ORDER_DATE" DATE, 
	"COMMUTATION_SANCTIONED_FLAG" character varying(1), 
	"IMMEDIATE_RELIEF_FLAG" character varying(1), 
	"PENSION_HOA" integer, 
	"GRATUITY_HOA" integer, 
	"SATISFIED_FLAG" character varying(1), 
	"REMARKS" character varying(500), 
	"PENSION_AGREED_PER_AMT_FLAG" character varying(1), 
	"PENSION_AGREED_PER_AMT_VALUE" integer, 
	"PENSION_AGREED_AMT" integer, 
	"PENSION_AGREED_DIFF_AMT" integer, 
	"PENSION_TOTAL_AMOUNT" integer, 
	"GRATUITY_TOTAL_AMOUNT" integer, 
	"GRATUITY_AGREED_PER_AMT_FLAG" character varying(1), 
	"GRATUITY_AGREED_PER_AMT_VALUE" integer, 
	"GRATUITY_AGREED_AMT" integer, 
	"GRATUITY_AGREED_DIFF_AMT" integer, 
	"REDUCED_PENSION" integer, 
	"MEMO_NO" character varying(200), 
	"MEMO_DATE" DATE, 
	"LAST_PAY" integer, 
	"LAST_BASIC" integer, 
	"LAST_GRADE_PAY" integer, 
	"LAST_DA" integer, 
	"LAST_PAY_BILL_GROUP_ID" integer, 
	"LAST_PAY_VOUCHER_DATE" DATE, 
	"LAST_PAYB_ID" integer, 
	"LAST_PAY_SCALE_ID" integer, 
	"PAY_BAND_SCALE_DESC" character varying(500), 
	"LAST_ROPA_ID" integer, 
	"ENHANCED_FAMILY_PENSION_UPTO" DATE, 
	"ENHANCED_FAMILY_PENSION_AMT" integer, 
	"FAMILY_PENSION_AMT" integer, 
	"PENSION_CALCULATED" integer, 
	"GRATUITY_CALCULATED" integer, 
	"CVP_CALCULATED" integer, 
	"NET_EFFECTIVE_SRV_PERIOD" integer, 
	"PENSION_HOA_DESC" character varying(200), 
	"GRATUITY_HOA_DESC" character varying(200), 
	"LAST_HRA" integer, 
	"LAST_MA" integer, 
	"PENSION_HOA_MAP_ID" integer, 
	"GRATUITY_HOA_MAP_ID" integer, 
	"DEATH_GRATUITY_AMOUNT" integer, 
	"IMMEDIATE_RELIEF_AMOUNT" integer, 
	"COURT_CASE_MEMO_NO" character varying(200), 
	"COURT_CASE_MEMO_DATE" DATE, 
	"NO_DEMAND_MEMO_NO" character varying(200), 
	"NO_DEMAND_MEMO_DATE" DATE, 
	"EPF_ENHANCED_UPTO" DATE, 
	"PROV_MONTHLY_PEN_AMT_SYS" integer, 
	"PROV_MONTHLY_PEN_AMT_USER" integer, 
	"PROV_DEATH_GRATUITY_AMT_SYS" integer, 
	"PROV_DEATH_GRATUITY_AMT_USER" integer, 
	"PROV_FAMILY_PEN_AMT_SYS" integer, 
	"PROV_FAMILY_PEN_AMT_USER" integer, 
	"PROV_GRATUITY_AMT_SYS" integer, 
	"PROV_GRATUITY_AMT_USER" integer, 
	"PROV_GRATUITY_FORMULA_N_VALUE" character varying(500), 
	"INT_PEN_PROV_RULE_DTLS_ID" integer, 
	"INT_PEN_PROV_GRAT_RULE_DTLS_ID" integer, 
	"PROV_FORMULA_WITH_VALUE" character varying(500), 
	"NET_QUALIFING_SERVICE_YEAR" integer, 
	"NET_QUALIFING_SERVICE_MONTH" integer, 
	"NET_QUALIFING_SERVICE_DAYS" integer, 
	"PROV_PEN_INCLUDE_EXCLUDE_FLAG" character varying(1), 
	"PROV_GRAT_INCLUDE_EXCLUDE_FLAG" character varying(1), 
	"LAST_DA_RATE" integer, 
	"LAST_NPA" integer, 
	 CONSTRAINT "PK_P_MM_PEN_PREP_CALC_HEADER" PRIMARY KEY ("INT_PEN_PREP_CALC_HEADER_ID"), 
	 CONSTRAINT "UK_P_MM_PEN_PREP_CALC_HEADER1" UNIQUE ("INT_PENSIONER_ID", "ITERATION_NO"), 
	 CONSTRAINT "UK_P_MM_PEN_PREP_CALC_HEADER2" UNIQUE ("INT_PEN_PREP_CALC_HEADER_ID", "ITERATION_NO")
);

COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_CALC_HEADER"."COMMUTATION_SANCTIONED_FLAG" IS '''Y''/''N'' flag';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_CALC_HEADER"."IMMEDIATE_RELIEF_FLAG" IS '''Y''/''N'' flag';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_CALC_HEADER"."SATISFIED_FLAG" IS '''Y''/''N'' flag';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_CALC_HEADER"."PENSION_AGREED_PER_AMT_FLAG" IS '''P'' for percentage ''A'' for Amount';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_CALC_HEADER"."GRATUITY_AGREED_PER_AMT_FLAG" IS '''P'' for percentage ''A'' for Amount';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_CALC_HEADER"."MEMO_NO" IS 'memo no  to be given before approving calculation';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_CALC_HEADER"."MEMO_DATE" IS 'memo date to be given before approving calculation';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_CALC_HEADER"."PENSION_CALCULATED" IS 'data will be storred for Supperannuation system_calc_Basic Pension_amt or User_updated_Basic Pension_amt';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_CALC_HEADER"."IMMEDIATE_RELIEF_AMOUNT" IS 'If Immidiate Relief Flag is Yes then Immidiate Relief Amount to be filled';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_CALC_HEADER"."INT_PEN_PROV_RULE_DTLS_ID" IS 'Rule used for calculation of normal provisional pension';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_CALC_HEADER"."INT_PEN_PROV_GRAT_RULE_DTLS_ID" IS 'Rule used for calculation of normal provisional Gratuity';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_CALC_HEADER"."PROV_PEN_INCLUDE_EXCLUDE_FLAG" IS '''Y'' = include ''N'' = Exclude';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_CALC_HEADER"."PROV_GRAT_INCLUDE_EXCLUDE_FLAG" IS '''Y'' = include ''N'' = Exclude';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_CALC_HEADER"."LAST_DA_RATE" IS 'Percentage at which DA calculated';

CREATE TABLE IF NOT EXISTS "cts_pension"."P_MM_PEN_PREP_DECLARATION" 
(	"INT_PREP_DECLARATION_ID" integer NOT NULL, 
	"RETIREMENT_TYPE" character varying(2) NOT NULL, 
	"DECLARATIOIN_TEXT" character varying(100) NOT NULL, 
	"ACTIVE_FLAG" "cts_pension"."ACTIVE_FLAG" NOT NULL, 
	"DML_STATUS_FLAG" integer DEFAULT 0 NOT NULL, 
	"CREATED_BY_USER" integer NOT NULL, 
	"MODIFIED_BY_USER" integer, 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"PEN_TYPE_ID" integer NOT NULL, 
	 CONSTRAINT "PK_P_MM_PEN_PREP_DECLARATION" PRIMARY KEY ("INT_PREP_DECLARATION_ID")
);

COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_DECLARATION"."RETIREMENT_TYPE" IS 'P for pension, C for CVP application etc';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_DECLARATION"."PEN_TYPE_ID" IS 'Unique pension ID type.';

CREATE TYPE "cts_pension"."PAYMENT_ORDER_FLAG" AS ENUM ('P','G', 'C'); 
CREATE TYPE "cts_pension"."COMPONENT_TYPE" AS ENUM ('P', 'F', 'C');
CREATE TYPE "cts_pension"."PAY_RECO_FLAG" AS ENUM ('P', 'R');
CREATE TYPE "cts_pension"."RECOVERY_FROM" AS ENUM ('P', 'G');
CREATE TYPE	"TRES_BREAKUP_CLASS_TYPE" AS ENUM ('B', 'C');
CREATE TABLE IF NOT EXISTS "cts_pension"."P_MM_PEN_PREP_PAY_RECO_TYPE" 
(	"PAY_RECO_TYPE_ID" integer NOT NULL, 
	"PAY_RECO_DESC" character varying(200) NOT NULL, 
	"PAY_RECO_ABBR" CHAR(2) NOT NULL, 
	"COMPONENT_TYPE" "cts_pension"."COMPONENT_TYPE" NOT NULL, 
	"PAY_RECO_FLAG" "cts_pension"."PAY_RECO_FLAG" NOT NULL, 
	"RECOVERY_FROM" "cts_pension"."RECOVERY_FROM" NOT NULL, 
	"TRES_BREAKUP_CLASS_ID" integer NOT NULL, 
	"TRES_BREAKUP_CLASS_TYPE" "TRES_BREAKUP_CLASS_TYPE" NOT NULL, 
	"PAYMENT_ORDER_FLAG" CHAR(1) DEFAULT 'P' NOT NULL, 
	"HOA_ID" character varying(6), 
	"ACTIVE_FLAG" CHAR(1) DEFAULT 'Y' NOT NULL, 
	"USER_ID" integer DEFAULT 0 NOT NULL, 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	 CONSTRAINT "PK_P_MM_PEN_PREP_PAY_RECO_TYPE" PRIMARY KEY ("PAY_RECO_TYPE_ID")
);

COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PAY_RECO_TYPE"."PAY_RECO_TYPE_ID" IS 'Recovery type id..';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PAY_RECO_TYPE"."PAY_RECO_DESC" IS 'Recovery type description..';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PAY_RECO_TYPE"."PAY_RECO_ABBR" IS 'Single word abbreviation for recovery type description..';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PAY_RECO_TYPE"."PAY_RECO_FLAG" IS 'R for recovery , P --- payment';

CREATE TYPE "cts_pension"."EMP_GENDER_OBS" AS ENUM ('M','F');
CREATE TYPE "cts_pension"."FAMILY_PEN_RCPT_OTH_PEN_FLAG" AS ENUM ('Y','N');
CREATE TYPE "cts_pension"."PROVISIONAL_PEN_RECEIVED_FLAG" AS ENUM ('Y','N');
CREATE TYPE "cts_pension"."PROVISIONAL_GRATUITY_RCVD_FLAG" AS ENUM ('Y','N');
CREATE TYPE "cts_pension"."OTHER_PENSION_RECEIPT_FLAG" AS ENUM ('Y','N'); 
CREATE TYPE "cts_pension"."VIGILANCE_CASE_PENDING_FLAG" AS ENUM ('Y','N'); 
CREATE TYPE "cts_pension"."DEPT_CRIMINAL_PROC_PENDING_FLG" AS ENUM ('Y','N');
CREATE TYPE "cts_pension"."FINAL_GPF_APPLIED_FLAG" AS ENUM ('Y', 'N');
CREATE TYPE "cts_pension"."PREVIOUS_PENSION_TYPE" AS ENUM ('N', 'F');
CREATE TYPE "cts_pension"."PREVIOUS_PENSION_SOURCE" AS ENUM ('M', 'C', 'O');
CREATE TYPE "cts_pension"."COURT_CASE_PENDING_STATUS" AS ENUM ('Y','N');
CREATE TYPE "cts_pension"."RE_EMPLOYED_AFTER_RETIRE_FLAG" AS ENUM ('Y','N');
CREATE TYPE "cts_pension"."FAMILY_PENSIONER_EMPLOYED_FLAG" AS ENUM ('Y','N');
CREATE TABLE IF NOT EXISTS "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL" 
(	"INT_PENSIONER_ID" integer NOT NULL, 
	"INT_GPF_NO_ID_OBS" integer, 
	"INT_DISTRICT_ID_OBS" integer, 
	"SUBSCR_FIRST_NAME" character varying(100), 
	"SUBSCR_MIDDLE_NAME" character varying(100), 
	"SUBSCR_LAST_NAME" character varying(100), 
	"INT_REL_ID_OBS" integer, 
	"DATE_OF_BIRTH" DATE NOT NULL, 
	"DATE_OF_EXIT" DATE, 
	"RETIREMENT_DATE" DATE, 
	"EMP_GENDER_OBS" "cts_pension"."EMP_GENDER_OBS", 
	"INT_MARITAL_STATUS_ID" integer, 
	"INT_RELIGION_ID" integer, 
	"INT_NATIONALITY_ID" integer, 
	"MOBILE_NUMBER" character varying(11), 
	"EMAIL_ID" character varying(100), 
	"IDENTIFICATION_MARK" character varying(400), 
	"INT_IDENTITY_TYPE_ID_OBS" integer, 
	"IDENTITY_CARD_NUMBER_OBS" character varying(100), 
	"IFSC_CODE" character varying(90), 
	"BANK_AC_NO" character varying(30), 
	"HEIGHT_IN_CENTI" integer, 
	"INT_PAYABLE_TREA_ID_PEN_OBS" integer, 
	"INT_DDO_ID" integer, 
	"CVP_OPTED_FLAG" character varying(1) DEFAULT 'Y', 
	"CVP_PERCENTAGE" integer, 
	"P_CITY_VILLAGE_OBS" character varying(50), 
	"P_TOWN_OBS" character varying(50), 
	"P_POLICE_STATION_OBS" character varying(50), 
	"P_DISTRICT_CODE_OBS" character varying(2), 
	"P_STATE_OBS" integer, 
	"P_PIN_OBS" character varying(50), 
	"C_CITY_VILLAGE_OBS" character varying(50), 
	"C_TOWN_OBS" character varying(50), 
	"C_POLICE_STATION_OBS" character varying(50), 
	"C_DISTRICT_CODE_OBS" character varying(2), 
	"C_STATE_OBS" integer, 
	"C_PIN_OBS" character varying(50), 
	"PEN_FILE_ID" integer, 
	"LAST_POST_ID_OBS" integer, 
	"INSTITUTE_ID_OBS" integer, 
	"SEND_TO_USER_ID_OBS" integer, 
	"ACTIVE_FLAG" CHAR(1) DEFAULT 'Y' NOT NULL, 
	"PROCESSING_FLAG" integer NOT NULL, 
	"PREV_INT_PENSIONER_ID" integer, 
	"IDENTIFICATION_MARK2" character varying(400), 
	"PAN_NO" character varying(10), 
	"FINAL_GPF_APPLIED_FLAG" "cts_pension"."FINAL_GPF_APPLIED_FLAG" DEFAULT 'N' NOT NULL, 
	"FINAL_GPF_APPLIED_DATE" DATE, 
	"REASON_FINAL_GPF_NOT_APPLY" character varying(400), 
	"PREVIOUS_PENSION_TYPE" "cts_pension"."PREVIOUS_PENSION_TYPE", 
	"PREVIOUS_PENSION_SOURCE" "cts_pension"."PREVIOUS_PENSION_SOURCE", 
	"PREVIOUS_PENSION_PPO_NO" character varying(30), 
	"PREVIOUS_PENSION_AMT" integer, 
	"PREVIOUS_PENSION_WEF" DATE, 
	"FINAL_GPF_APPLIED_LETTER_NO" character varying(30), 
	"BSR_CODE" character varying(30), 
	"HRMS_EMP_ID_OBS" character varying(30), 
	"DECLRN_CHECK_FLAG" CHAR(1) DEFAULT 'N' NOT NULL, 
	"DML_STATUS_FLAG" integer DEFAULT 0 NOT NULL, 
	"USER_ID" integer DEFAULT 0 NOT NULL, 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"PREV_INT_TREASURY_ID" integer, 
	"PREV_BANK_IFSC_CODE" character varying(90), 
	"PREV_PIA" character varying(100), 
	"EDU_QUALIFICATION_OBS" character varying(200), 
	"TRAINING_OBS" character varying(400), 
	"PEN_TYPE_ID" integer, 
	"SALUTATION_NAME_OF_RELATIVE_OB" character varying(50), 
	"FIRST_NAME_OF_RELATIVE_OBS" character varying(50), 
	"MIDDLE_NAME_OF_RELATIVE_OBS" character varying(50), 
	"LAST_NAME_OF_RELATIVE_OBS" character varying(50), 
	"INT_DESIGNATION_ID" integer, 
	"INT_POST_ID" integer, 
	"PENSION_FILE_NO" character varying(100), 
	"DESIGNATION_DESC" character varying(500), 
	"POST_DESC" character varying(500), 
	"INT_CADRE_ID" integer, 
	"CADRE_DESC" character varying(500), 
	"INT_SRV_ID" integer, 
	"SERVICE_TYPE_DESC" character varying(500), 
	"INT_EMPLOYMENT_TYPE" integer, 
	"EMPLOYMENT_TYPE_DESC" character varying(500), 
	"TREASURY_CODE_PAYABLE" character varying(4), 
	"INT_EMPLOYEE_ID" integer, 
	"EMPLOYEE_NO" character varying(50), 
	"REQUEST_ID" integer, 
	"TRES_CODE_PAYABLE_OUT_STATE" character varying(500), 
	"WB_HEALTH_SCHEME_FLAG" character varying(1), 
	"HEALTH_SCHEME_TO_BE_CONTINUED" character varying(1), 
	"MEMBER_OF_GPF" character varying(1), 
	"GPF_SERIES" character varying(30), 
	"GPF_SERIES1" character varying(12), 
	"GPF_ACCOUNT_NO" character varying(20), 
	"INT_HEAD_OF_OFFICE_ID" integer, 
	"INT_APP_AUTHORITY_ID" integer, 
	"FROM_ESS" character varying(1), 
	"INT_PREP_DECLARATION_ID" integer, 
	"BANK_OBS" character varying(300), 
	"BRANCH_NAME_OBS" character varying(2000), 
	"BENF_TYPE_ID" integer, 
	"EMP_INT_OMI_GENDER" integer, 
	"MARITAL_STATUS_DESC" character varying(300), 
	"RELIGION_DESC" character varying(300), 
	"GENDER_DESC" character varying(30), 
	"INT_PAYABLE_TREA_ID_GRAT_OBS" integer, 
	"SALUTATION_NAME_OF_EMPL_OBS" character varying(50), 
	"PAYABLE_TREASURY_FLAG" character varying(1), 
	"PAYABLE_OUT_TREASURY_NAME" character varying(50), 
	"ROLE_ID" integer, 
	"MODIFIED_ROLE_ID" integer, 
	"APPLICATION_DATE" DATE, 
	"RETIREMENT_FORE_AFT_NOON" integer DEFAULT 1, 
	"NATIONALITY" character varying(50), 
	"INT_DEPT_ID" integer, 
	"DEPT_DESCRIPTION" character varying(100), 
	"INT_SANCTIONING_AUTHORITY_ID" integer, 
	"SANCTIONING_AUTHORITY_TYPE" character varying(10), 
	"APPOINTMENT_ADD_HOC_FLAG" character varying(1), 
	"PREVIOUS_CVP_APPLICATION_FLAG" character varying(1), 
	"PREVIOUS_CVP_APPLI_REMARKS" character varying(500), 
	"PREV_APPEARANCE_MEDICAL_FLAG" character varying(1), 
	"PREV_APPEAR_MEDICAL_REMARKS" character varying(500), 
	"PPO_NUMBER" character varying(30), 
	"INT_POST_CODE" integer, 
	"POST_CODE" character varying(50), 
	"FORWARDING_AUTHORITY_OBS" character varying(6), 
	"INT_SERVICE_BOOK_AVAIL" integer, 
	"COURT_CASE_PENDING_STATUS" "cts_pension"."COURT_CASE_PENDING_STATUS", 
	"COURT_CASE_REMARKS" character varying(500), 
	"APPROVER_USER_ID" integer, 
	"APPROVER_ROLE_ID" integer, 
	"APPROVE_TIME_STAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"DATE_OF_JOINING" DATE, 
	"PEN_SANCTION_INT_TREASURY_ID" integer, 
	"INT_OMI_PF_NPS_TYPE" integer, 
	"PSA_CODE" character varying(40), 
	"RE_EMPLOYED_AFT_RETIR_REMARKS" character varying(500), 
	"FAMILY_PENSIONER_EMPLOYED_FLAG" "cts_pension"."FAMILY_PENSIONER_EMPLOYED_FLAG", 
	"FAMILY_PEN_EMPLOYED_REMARKS" character varying(500), 
	"FAMILY_PEN_RCPT_PEN_REMARKS" character varying(500), 
	"CPF_SHARE_REMARKS" character varying(1000), 
	"PROVISIONAL_PENSION_REMARKS" character varying(500), 
	"PROVISIONAL_GRATUITY_REMARKS" character varying(500), 
	"APPOINTMENT_ADD_HOC_REMARKS" character varying(500), 
	"OTHER_PENSION_RECEIPT_FLAG" "cts_pension"."OTHER_PENSION_RECEIPT_FLAG", 
	"OTHER_PENSION_RCPT_NAME" character varying(500), 
	"OTHER_PENSION_RCPT_PARTICULAR" character varying(500), 
	"OTHER_PENSION_RCPT_SOURCE" character varying(500), 
	"VIGILANCE_CASE_PENDING_REMARKS" character varying(500), 
	"DEPT_CRIMINAL_PROC_REMARKS" character varying(500), 
	"RE_EMPLOYED_AFTER_RETIRE_FLAG" "cts_pension"."RE_EMPLOYED_AFTER_RETIRE_FLAG", 
	"FAMILY_PEN_RCPT_OTH_PEN_FLAG" "cts_pension"."FAMILY_PEN_RCPT_OTH_PEN_FLAG", 
	"PROVISIONAL_PEN_RECEIVED_FLAG" "cts_pension"."PROVISIONAL_PEN_RECEIVED_FLAG", 
	"PROVISIONAL_GRATUITY_RCVD_FLAG" "cts_pension"."PROVISIONAL_GRATUITY_RCVD_FLAG", 
	"VIGILANCE_CASE_PENDING_FLAG" "cts_pension"."VIGILANCE_CASE_PENDING_FLAG", 
	"DEPT_CRIMINAL_PROC_PENDING_FLG" "cts_pension"."DEPT_CRIMINAL_PROC_PENDING_FLG", 
	"TRES_NAME_PAYABLE_OUT_STATE" character varying(500), 
	"TRES_CODE_PAYABLE_OUT_STATE_ID" integer, 
	"PSA_TREASURY_MODIFIABLE_FLAG" character varying(1) DEFAULT 'N' NOT NULL, 
	"INT_PSA_TREASURY_CODE" character varying(5), 
	"INT_HEAD_OF_OFFICE_ID_SB" integer, 
	"PSA_DDO_AVL_FLAG" character varying(1) DEFAULT 'N', 
	"OTHER_PPO_NO" character varying(30), 
	"OTHER_PPO_DETAILS" character varying(500), 
	"WRIT_PETITION_NO" character varying(30), 
	"WRIT_PETITION_DETAILS" character varying(500), 
	"PROCESSING_STAGE_DTL" character varying(4), 
	"INT_OMI_COURT_CASE_TYPE" integer, 
	"COURT_CASE_TYPE" character varying(100), 
	"COURT_CASE_NO" character varying(100), 
	"COURT_CASE_YEAR" integer, 
	"NAME_OF_COURT" character varying(200), 
	"INT_OMI_CASE_STATUS" integer, 
	"INT_OMI_CASE_RELATION_TO" integer, 
	"CASE_REL_OTHER_REASON" character varying(1000), 
	"NAME_OF_THE_AUTHORITY" character varying(200), 
	"REMARKS" character varying(500), 
	"PENSION_TYPE_FLAG" character varying(1), 
	"PENSION_CALC_TYPE" character varying(2), 
	"INT_PSA_DDO_ID" integer, 
	"PROV_PEN_SYSTEM_RCVD_FLAG" character varying(1) DEFAULT 'N', 
	"PROV_GRAT_SYSTEM_RCVD_FLAG" character varying(1) DEFAULT 'N', 
	"RATE_OF_PROV_PENSION" integer, 
	"PROV_PENSION_PERIOD" character varying(100), 
	"RATE_OF_PROV_GRATUITY" integer, 
	"GRATUITY_PAYMENT_ORDER_NO" character varying(100), 
	"COMMUTED_VALUE_PAY_ORDER_NO" character varying(100), 
	"APPROVAL_AUTH_DESIGNATION" character varying(300), 
	"INT_SPOUSE_RELIGION_ID" integer, 
	"INT_PSA_DESIGNATION_ID" integer, 
	"PSA_ADDRESS" character varying(1000), 
	"TREASURY_BANK" character varying(100), 
	"TREASURY_NAME" character varying(100), 
	 CONSTRAINT "PK_P_MM_PEN_PREP_PEN_DETL" PRIMARY KEY ("INT_PENSIONER_ID"), 
	 CONSTRAINT "UK_P_MM_PEN_PREP_PEN_DETL1" UNIQUE ("PEN_FILE_ID")
);

COMMENT ON TABLE "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL" IS 'Store Pensioner Personal information';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."INT_PENSIONER_ID" IS 'pensioner id which is unique';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."INT_GPF_NO_ID_OBS" IS 'gpf-tpf number id referencing column from PF_MM_GEN_SUBSCR_DETL';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."INT_DISTRICT_ID_OBS" IS 'District id of pensioner';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."RETIREMENT_DATE" IS 'to be fetched from employee master table -- added by ritu';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."INT_MARITAL_STATUS_ID" IS 'referencing from PF_MM_GEN_MARITAL_STATUS table indication maritial states.';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."BANK_AC_NO" IS 'bank account id..';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."PEN_FILE_ID" IS 'unique for every pensioner';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."LAST_POST_ID_OBS" IS 'Last post dat the pensioner hold referencing from P_MM_PEN_PREP_POST';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."INSTITUTE_ID_OBS" IS 'unique id of the institute..';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."FINAL_GPF_APPLIED_FLAG" IS 'Y - Yes, N - No';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."PREVIOUS_PENSION_TYPE" IS 'N for Normal, F for Family';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."PREVIOUS_PENSION_SOURCE" IS 'M - Military, C - Civil, O - Others';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."PEN_TYPE_ID" IS 'Unique pension ID type.';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."BENF_TYPE_ID" IS 'no use of this';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."PAYABLE_TREASURY_FLAG" IS 'B: Bank, I-Treasury, O: outside WB(State ) ';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."PAYABLE_OUT_TREASURY_NAME" IS 'For PAYABLE_TREASURY_FLAG ''I'' Traeasury name ''O'' State name';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."RETIREMENT_FORE_AFT_NOON" IS '0 for forenoon and 1 for afternoon';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."SANCTIONING_AUTHORITY_TYPE" IS 'AA --------- Appointing Auth, HOO----------- Head Of Office';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."COURT_CASE_PENDING_STATUS" IS 'Y/N';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."COURT_CASE_REMARKS" IS 'For Departmental Proceedings & ''Judicial'' Proceedings.';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."CPF_SHARE_REMARKS" IS '19';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."OTHER_PENSION_RECEIPT_FLAG" IS '22/f';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."RE_EMPLOYED_AFTER_RETIRE_FLAG" IS 'Y/N';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."PROVISIONAL_PEN_RECEIVED_FLAG" IS '35/a';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."PROVISIONAL_GRATUITY_RCVD_FLAG" IS '35/b';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."INT_PSA_TREASURY_CODE" IS 'treasury attached with DDO of Service Book HOO';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."INT_HEAD_OF_OFFICE_ID_SB" IS 'SERVICE BOOK HOO';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."PSA_DDO_AVL_FLAG" IS 'SERVICE BOOK HOO tagged with DDO or Not';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."OTHER_PPO_NO" IS 'If family pensioner received any other pension or family pension then that PPO Number to be provided';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."OTHER_PPO_DETAILS" IS 'If family pensioner received any other pension or family pension then that PPO Details to be provided';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."WRIT_PETITION_NO" IS 'If court case pending is Yes Then W.P(Writ Petition) No to be provided';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."WRIT_PETITION_DETAILS" IS 'If court case pending is Yes Then W.P(Writ Petition) Details to be provided';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."PROCESSING_STAGE_DTL" IS 'For Detail Of Processing Status';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."INT_OMI_COURT_CASE_TYPE" IS 'Case Type: ''Judicial Proceedings'', �Departmental Proceedings� Taken from OtherMaster Master Type'' CCT''';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."COURT_CASE_TYPE" IS 'For Judicial Proceedings Only';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."COURT_CASE_NO" IS 'For Judicial Proceedings Only';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."COURT_CASE_YEAR" IS 'For Judicial Proceedings Only';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."NAME_OF_COURT" IS 'For Judicial Proceedings Only';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."INT_OMI_CASE_STATUS" IS 'For Departmental Proceedings & ''Judicial'' Proceedings.';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."INT_OMI_CASE_RELATION_TO" IS 'For Judicial Proceedings Only';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."CASE_REL_OTHER_REASON" IS 'For Judicial Proceedings Only';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."NAME_OF_THE_AUTHORITY" IS 'For Departmental Proceedings Only';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."REMARKS" IS 'Remarks For General Purpose';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."PENSION_TYPE_FLAG" IS '''F'' for Final ''P'' for Provisional';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."PENSION_CALC_TYPE" IS 'Types are commomn Superannuation & ''Death'' ''SP'' & ''DP''';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."INT_PSA_DDO_ID" IS 'Tagged DDO of Service Book HOO';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."PROV_PEN_SYSTEM_RCVD_FLAG" IS 'If Provisional Pension is system calculated then ''Y'' Else ''N''';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."PROV_GRAT_SYSTEM_RCVD_FLAG" IS 'If Provisional Gratuity is system calculated then ''Y'' Else ''N''';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."RATE_OF_PROV_PENSION" IS 'as per CR 181305 Point 1';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."PROV_PENSION_PERIOD" IS 'as per CR 181305 Point 1';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."RATE_OF_PROV_GRATUITY" IS 'as per CR 181305 Point 1';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."GRATUITY_PAYMENT_ORDER_NO" IS 'as per CR 181305 Point 2';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."COMMUTED_VALUE_PAY_ORDER_NO" IS 'as per CR 181305 Point 2';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."APPROVAL_AUTH_DESIGNATION" IS 'as per CR 208818 Point 1';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."INT_SPOUSE_RELIGION_ID" IS 'as per CR 275470';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."TREASURY_BANK" IS 'as per CR 480156';
COMMENT ON COLUMN "cts_pension"."P_MM_PEN_PREP_PENSIONER_DETL"."TREASURY_NAME" IS 'as per CR 480156';

CREATE TABLE IF NOT EXISTS "cts_pension"."P_MM_PEN_PROCESSING_FLAG" 
(	"PROCESSING_FLAG" integer NOT NULL, 
	"DESCRIPTION" character varying(100) NOT NULL, 
	"ACTIVE_FLAG" "cts_pension"."ACTIVE_FLAG" DEFAULT 'Y', 
	"USER_ID" integer DEFAULT 0 NOT NULL, 
	"CREATED_TIMESTAMP" DATE DEFAULT CURRENT_DATE NOT NULL, 
	"MODIFIED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"MODIFIED_TIMESTAMP" DATE DEFAULT CURRENT_DATE NOT NULL, 
	 CONSTRAINT "PK_P_MM_PEN_PROCESSING_FLAG" PRIMARY KEY ("PROCESSING_FLAG")
);


CREATE TABLE IF NOT EXISTS "cts_pension"."P_MM_PEN_RETIREMENT_BENF_TYPE" 
   (	"BENF_TYPE_ID" integer NOT NULL, 
	"BENF_DESC" character varying(300) NOT NULL, 
	"BENF_ABBR" character varying(4) NOT NULL, 
	"ACTIVE_FLAG" CHAR(1) DEFAULT 'Y' NOT NULL, 
	"USER_ID" integer DEFAULT 0 NOT NULL, 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"NOMINEE_FLAG" character varying(1), 
	 CONSTRAINT "PK_P_MM_PEN_RETIRE_BENF_TYPE" PRIMARY KEY ("BENF_TYPE_ID")
   );

COMMENT ON COLUMN "cts_pension"."P_MM_PEN_RETIREMENT_BENF_TYPE"."NOMINEE_FLAG" IS 'For selecting nominee, value should be ''Y''-- added by ritu';

CREATE TABLE IF NOT EXISTS "cts_pension"."P_MM_PEN_RULE_DTLS" 
   (	"INT_PEN_RULE_DTLS_ID" integer NOT NULL, 
	"INT_PEN_RULE_NAME_ID" integer NOT NULL, 
	"PAY_RECO_TYPE_ID" integer NOT NULL, 
	"RULE_NAME" character varying(300), 
	"RULE_ABBR" character varying(10), 
	"RULES_REMARKS" character varying(500), 
	"MIN_SERVICE_YR" integer, 
	"MIN_SERVICE_YR_OPERATOR" character varying(10), 
	"MAX_SERVICE_YR" integer, 
	"MAX_SERVICE_YR_OPERATOT" character varying(10), 
	"PERCENT_OF_AMT" integer, 
	"MAX_SERVICE_YEAR" integer, 
	"RETIREMENT_DATE_FROM" DATE, 
	"RETIREMENT_DATE_TO" DATE, 
	"MIN_CALCULATED_AMT" integer, 
	"MAX_CALCULATED_AMT" integer, 
	"RULES" character varying(999), 
	"ACTIVE_FLAG" "cts_pension"."ACTIVE_FLAG" NOT NULL, 
	"ROPA_ABBR" character varying(50), 
	 CONSTRAINT "PK_P_MM_PEN_RULE_DTLS" PRIMARY KEY ("INT_PEN_RULE_DTLS_ID")
   );

COMMENT ON COLUMN "cts_pension"."P_MM_PEN_RULE_DTLS"."ROPA_ABBR" IS 'pay_allowance_abbr';

CREATE TABLE IF NOT EXISTS "cts_pension"."P_MM_PEN_RULE_NAME" 
(	"INT_PEN_RULE_NAME_ID" integer NOT NULL, 
	"INT_SERVICE_ID" integer NOT NULL, 
	"RULE_NAME" character varying(300) NOT NULL, 
	"RULE_ABBR" character varying(10) NOT NULL, 
	"BENF_TYPE_ID" integer NOT NULL, 
	"PEN_TYPE_ID" integer NOT NULL, 
	"WEF" DATE NOT NULL, 
	"ACTIVE_FLAG" "cts_pension"."ACTIVE_FLAG" NOT NULL, 
	"DML_STATUS_FLAG" integer NOT NULL, 
	"CREATED_USER_ID" integer NOT NULL, 
	"CREATED_TIME_STAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"CREATED_ROLE_ID" integer NOT NULL, 
	"MODIFIED_USER_ID" integer, 
	"MODIFIED_TIME_STAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_ROLE_ID" integer, 
	 CONSTRAINT "PK_P_MM_PEN_RULE_NAME" PRIMARY KEY ("INT_PEN_RULE_NAME_ID"), 
	 CONSTRAINT "UK_P_MM_PEN_RULE_NAME1" UNIQUE ("RULE_NAME"), 
	 CONSTRAINT "UK_P_MM_PEN_RULE_NAME2" UNIQUE ("RULE_ABBR")
);

CREATE TABLE IF NOT EXISTS "cts_pension"."P_MM_PEN_RULE_SUB_DTLS" 
(	"INT_PEN_RULE_SUB_DTLS_ID" integer NOT NULL, 
	"INT_PEN_RULE_DTLS_ID" integer NOT NULL, 
	"MIN_BASIC_PAY" integer, 
	"MAX_BASIC_PAY" integer, 
	"PERCENT_BASIC_PAY" integer, 
	"MIN_CALCULATED_AMT" integer, 
	"MAX_CALCULATED_AMT" integer, 
	"RULES" character varying(999), 
	 CONSTRAINT "UK_P_MM_PEN_RULE_SUB_DTLS" PRIMARY KEY ("INT_PEN_RULE_SUB_DTLS_ID")
);

CREATE TABLE IF NOT EXISTS "cts_pension"."P_TD_PEN_PREP_ATTACHEMENT_DTL" 
(	"INT_ATTACHEMENT_DTL_ID" integer NOT NULL, 
	"DOCUMENT_ID" integer NOT NULL, 
	"CONTENT_ID" character varying(38) NOT NULL, 
	"INT_EMPLOYEE_ID" integer NOT NULL, 
	"ACTIVE_FLAG" "cts_pension"."ACTIVE_FLAG" DEFAULT 'Y' NOT NULL, 
	"DML_STATUS_FLAG" integer DEFAULT 0 NOT NULL, 
	"USER_ID" integer DEFAULT 0 NOT NULL, 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 0, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"ROLE_ID" integer NOT NULL, 
	"MODIFIED_ROLE_ID" integer, 
	"REQUEST_ID" integer, 
	"INT_PEN_PREP_ATTACHEMENT" integer, 
	"REQUEST_TYPE" character varying(15), 
	"FILE_NAME" character varying(100), 
	"FILE_TYPE" character varying(20), 
	 CONSTRAINT "PK_P_TD_PEN_PREP_ATTACH_DTL" PRIMARY KEY ("INT_ATTACHEMENT_DTL_ID"), 
	 CONSTRAINT "UK_P_TD_PEN_PREP_ATTACH_DTL1" UNIQUE ("DOCUMENT_ID"), 
	 CONSTRAINT "UK_P_TD_PEN_PREP_ATTACH_DTL2" UNIQUE ("CONTENT_ID")
);


CREATE TABLE IF NOT EXISTS "cts_pension"."P_TD_PEN_PREP_ATTACHMENT_DTL" 
(	"INT_ATTACHEMENT_DTL_ID" integer NOT NULL, 
	"DOCUMENT_ID" integer NOT NULL, 
	"CONTENT_ID" character varying(38) NOT NULL, 
	"INT_EMPLOYEE_ID" integer NOT NULL, 
	"ACTIVE_FLAG" "cts_pension"."ACTIVE_FLAG" DEFAULT 'Y' NOT NULL, 
	"DML_STATUS_FLAG" integer DEFAULT 0 NOT NULL, 
	"USER_ID" integer DEFAULT 0 NOT NULL, 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 0, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"ROLE_ID" integer NOT NULL, 
	"MODIFIED_ROLE_ID" integer, 
	"REQUEST_ID" integer, 
	"INT_PEN_PREP_ATTACHEMENT" integer, 
	"REQUEST_TYPE" character varying(15), 
	"FILE_NAME" character varying(100), 
	"FILE_TYPE" character varying(20), 
	"INT_PENSIONER_ID" integer, 
	"INT_OMI_UPD_DOC_TYPE" integer
);

COMMENT ON COLUMN "cts_pension"."P_TD_PEN_PREP_ATTACHMENT_DTL"."INT_OMI_UPD_DOC_TYPE" IS 'document type from other master master type: ''AFT''';

CREATE TABLE IF NOT EXISTS "cts_pension"."P_TD_PEN_PREP_FAMILY_ADDRESS" 
(	"INT_FAMILY_ADDR_ID" integer NOT NULL, 
	"INT_PENSIONER_ID" integer, 
	"FAMILY_ID" integer NOT NULL, 
	"HOUSE_NO_STREET_LANE" character varying(100), 
	"CITY_TOWN_VILLAGE" character varying(100), 
	"POST_OFFICE" character varying(100), 
	"POLICE_STATION" character varying(100), 
	"STATE_ID" integer, 
	"INT_DISTRICT_ID" integer, 
	"PIN" character varying(10), 
	"WEF" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"ADDR_TYPE" character varying(5), 
	"SAME_AS_PERMANENT_ADDR" character varying(5) DEFAULT 'N', 
	"ACTIVE_FLAG" "cts_pension"."ACTIVE_FLAG" DEFAULT 'N' NOT NULL, 
	"CREATED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"CREATED_TIMESTAMP" DATE DEFAULT CURRENT_DATE NOT NULL, 
	"CREATED_ROLE_ID" integer DEFAULT 0 NOT NULL, 
	"MODIFIED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"MODIFIED_TIMESTAMP" DATE DEFAULT CURRENT_DATE NOT NULL, 
	"MODIFIED_ROLE_ID" integer DEFAULT 0 NOT NULL, 
	"EFFECTIVE_END_DATE" DATE, 
	"DML_STATUS_FLAG" integer DEFAULT 0 NOT NULL, 
	"REQUEST_ID" integer, 
	"INT_RELATION_ADDR_ID" integer, 
	 CONSTRAINT "PK_P_TD_PEN_PREP_FAMILY_ADDR" PRIMARY KEY ("INT_FAMILY_ADDR_ID")
);

CREATE TYPE "cts_pension"."TI_APPLICABLE_FLAG_OBS" AS ENUM ('Y', 'N'); 
CREATE TYPE "cts_pension"."HANDICAPP_FLAG_OBS" AS ENUM ('Y','N'); 
CREATE TYPE "cts_pension"."GENDER_OBS" AS ENUM ('M','F');
CREATE TYPE "cts_pension"."MINOR_FLAG_OBS" AS ENUM ('Y','N');
CREATE TABLE IF NOT EXISTS "cts_pension"."P_TD_PEN_PREP_FAMILY_DTL" 
(	"PEN_FILE_ID_OBS" integer, 
	"FAMILY_ID" integer NOT NULL, 
	"REL_FIRST_NAME" character varying(200) NOT NULL, 
	"INT_REL_ID_OBS" integer, 
	"GENDER_OBS" "cts_pension"."GENDER_OBS", 
	"DOB" DATE, 
	"INT_MARITAL_STATUS_ID" integer, 
	"EFP_UPTO" DATE, 
	"SHARE_PERCENTAGE_OBS" integer, 
	"HANDICAPP_FLAG_OBS" "cts_pension"."HANDICAPP_FLAG_OBS", 
	"MINOR_FLAG_OBS" "cts_pension"."MINOR_FLAG_OBS", 
	"MINOR_FLAG_CALCULATED_ON_OBS" DATE DEFAULT CURRENT_DATE, 
	"BANK_AC_NO_OBS" character varying(30), 
	"IFSC_CODE_OBS" character varying(11), 
	"HANDICAPP_TYPE_OBS" CHAR(1), 
	"REMARKS" character varying(200), 
	"GUARDIAN_NAME_OBS" character varying(200), 
	"MOBILE_NUMBER" character varying(11), 
	"DML_STATUS_FLAG" integer DEFAULT 0 NOT NULL, 
	"USER_ID" integer DEFAULT 0 NOT NULL, 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"SALUTATION_FAMILY_OBS" character varying(50), 
	"SALUTATION_FAMILY_GUARDIAN_OBS" character varying(50), 
	"TI_APPLICABLE_FLAG_OBS" "cts_pension"."TI_APPLICABLE_FLAG_OBS", 
	"INT_PENSIONER_ID" integer, 
	"INT_EMP_RELATIONSHIP_ID" integer, 
	"REL_INT_OMI_RELATIONSHIP" integer, 
	"ACTIVE_FLAG" "cts_pension"."ACTIVE_FLAG", 
	"REL_INT_OMI_PHYSIC_CHALLENGED" integer, 
	"REL_PHYSIC_CHALLENGED_PERC_VH" integer, 
	"REL_PHYSIC_CHALLENGED_PERC_PH" integer, 
	"REQUEST_ID" integer, 
	"WBHS_CARD_NUMBER" character varying(50), 
	"HEALTH_INSURANCE_TYPE" character varying(1), 
	"RELATIONSHIP_EMP_NO" character varying(50), 
	"INT_EMPLOYEE_ID" integer, 
	"CREATED_ROLE_ID" integer, 
	"MODIFIED_ROLE_ID" integer, 
	"DECEASED_FLAG" character varying(1) DEFAULT 'N' NOT NULL, 
	"FAMILY_PENSION_FLAG" character varying(1) DEFAULT 'N' NOT NULL, 
	"MARRIAGE_DATE" DATE, 
	"REL_EXACT_HEIGHT" integer, 
	"INT_REL_OMI_HEIGHT_UNIT" integer, 
	"REL_IDENTIFICATION_MARK" character varying(200), 
	 CONSTRAINT "PK_P_TD_PEN_PREP_FAMILY_DTL" PRIMARY KEY ("FAMILY_ID")
);

COMMENT ON COLUMN "cts_pension"."P_TD_PEN_PREP_FAMILY_DTL"."PEN_FILE_ID_OBS" IS 'unique pension id for the pensioner..';
COMMENT ON COLUMN "cts_pension"."P_TD_PEN_PREP_FAMILY_DTL"."FAMILY_ID" IS 'unique family id..';
COMMENT ON COLUMN "cts_pension"."P_TD_PEN_PREP_FAMILY_DTL"."REL_FIRST_NAME" IS 'name of the family member';
COMMENT ON COLUMN "cts_pension"."P_TD_PEN_PREP_FAMILY_DTL"."INT_REL_ID_OBS" IS 'relationshp of pensioner with this member..';
COMMENT ON COLUMN "cts_pension"."P_TD_PEN_PREP_FAMILY_DTL"."GENDER_OBS" IS 'gender of the pensioner..';
COMMENT ON COLUMN "cts_pension"."P_TD_PEN_PREP_FAMILY_DTL"."DOB" IS 'date of birth of pensioner..';
COMMENT ON COLUMN "cts_pension"."P_TD_PEN_PREP_FAMILY_DTL"."INT_MARITAL_STATUS_ID" IS 'mariatial status of the relationship of pensionar';
COMMENT ON COLUMN "cts_pension"."P_TD_PEN_PREP_FAMILY_DTL"."EFP_UPTO" IS 'EFP up to date..';
COMMENT ON COLUMN "cts_pension"."P_TD_PEN_PREP_FAMILY_DTL"."SHARE_PERCENTAGE_OBS" IS 'Share percentage of the family member..';
COMMENT ON COLUMN "cts_pension"."P_TD_PEN_PREP_FAMILY_DTL"."HANDICAPP_FLAG_OBS" IS 'Whether this member is handicapped..';
COMMENT ON COLUMN "cts_pension"."P_TD_PEN_PREP_FAMILY_DTL"."MINOR_FLAG_OBS" IS 'whether this member is minor..';
COMMENT ON COLUMN "cts_pension"."P_TD_PEN_PREP_FAMILY_DTL"."BANK_AC_NO_OBS" IS 'bank account id..';
COMMENT ON COLUMN "cts_pension"."P_TD_PEN_PREP_FAMILY_DTL"."HANDICAPP_TYPE_OBS" IS '''P'' for Physically Handicapped and ''M'' for Mentally Handicapped';
COMMENT ON COLUMN "cts_pension"."P_TD_PEN_PREP_FAMILY_DTL"."INT_PENSIONER_ID" IS 'pensioner id which is unique';
COMMENT ON COLUMN "cts_pension"."P_TD_PEN_PREP_FAMILY_DTL"."REL_INT_OMI_RELATIONSHIP" IS 'RL type in other master';
COMMENT ON COLUMN "cts_pension"."P_TD_PEN_PREP_FAMILY_DTL"."REL_INT_OMI_PHYSIC_CHALLENGED" IS 'PHC in Otehr Master';
COMMENT ON COLUMN "cts_pension"."P_TD_PEN_PREP_FAMILY_DTL"."DECEASED_FLAG" IS '''Y'' for alive ''N'' for dead';
COMMENT ON COLUMN "cts_pension"."P_TD_PEN_PREP_FAMILY_DTL"."FAMILY_PENSION_FLAG" IS '''Y'' for family pension admisible else ''N''';
COMMENT ON COLUMN "cts_pension"."P_TD_PEN_PREP_FAMILY_DTL"."MARRIAGE_DATE" IS 'Added for Requirement of Exit Management';

CREATE TABLE IF NOT EXISTS "cts_pension"."P_TD_PEN_PREP_FAMILY_PEN_DTL" 
(	"INT_PREP_FAMILY_PEN_DTL" integer NOT NULL, 
	"INT_PENSIONER_ID" integer NOT NULL, 
	"FAMILY_ID" integer NOT NULL, 
	"REMARKS" character varying(300), 
	"DML_STATUS_FLAG" integer DEFAULT 0 NOT NULL, 
	"USER_ID" integer DEFAULT 0 NOT NULL, 
	"CREATED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"MODIFIED_USER_ID" integer DEFAULT 0 NOT NULL, 
	"MODIFIED_TIMESTAMP" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"REQUEST_ID" integer NOT NULL, 
	"CREATED_ROLE_ID" integer, 
	"MODIFIED_ROLE_ID" integer, 
	"ACTIVE_FLAG" "cts_pension"."ACTIVE_FLAG", 
	"INT_NOM_ID" integer, 
	 CONSTRAINT "PK_P_TD_PEN_PREP_FAM_PEN_DTL" PRIMARY KEY ("INT_PREP_FAMILY_PEN_DTL")
);

-- CREATE TYPE "cts_pension"."PROCESSING_FLAG" AS ENUM (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,-2,-3,-6,-12,-13,99);
CREATE TABLE IF NOT EXISTS "cts_pension"."P_TD_PEN_PREP_FILE_PROCESS_LOG" 
(	"PEN_FILE_PROCESS_LOG_ID" integer NOT NULL, 
	"INT_PENSIONER_ID" integer, 
	"PEN_FILE_PROCESS_SEQ" integer NOT NULL, 
	"PROCESSING_FLAG" integer NOT NULL, 
	"PROCESS_BY" integer NOT NULL, 
	"PROCESS_DATE" timestamp without time zone DEFAULT CURRENT_TIMESTAMP, 
	"DML_STATUS_FLAG" integer DEFAULT 0 NOT NULL, 
	"PROCESSED_BY_USER_TYPE" character varying(2), 
	"SUB_SYSTEM_ID" integer NOT NULL, 
	"PROCESSED_BY_USER_ROLE_ID" integer, 
	"REMARKS" character varying(300), 
	"SEND_TO_USER_ID" integer, 
	"SEND_TO_USER_TYPE" character varying(2), 
	"SEND_TO_USER_ROLE_ID" integer, 
	"PROCESSED_BY_AUTH_ID" integer, 
	"SEND_TO_AUTH_ID" integer, 
	 CONSTRAINT "PK_P_TD_PEN_PREP_FILE_PROC_LOG" PRIMARY KEY ("PEN_FILE_PROCESS_LOG_ID"), 
	 CONSTRAINT "UK_P_TD_PEN_PREP_FILE_PRO_LOG1" UNIQUE ("PEN_FILE_PROCESS_LOG_ID", "PEN_FILE_PROCESS_SEQ")
);