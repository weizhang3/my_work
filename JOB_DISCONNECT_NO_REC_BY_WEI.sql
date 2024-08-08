-- SQL Work Sample  

-- Six Tables
-- "YOURSCHEMA"."STG.T_STG_EAI_SVC_ORDERS_HIST"            [DNP info]
-- "YOURSCHEMA"."STG.T_MOBILE_DATA_CREW_ONSITE_HIST"       [Crew onsite info]
-- "YOURSCHEMA"."STG.PREMISE_CHAR"                         [Customer info]
-- "YOURSCHEMA"."STG.METER_CHAR"					                 [Meter info]
-- "YOURSCHEMA"."EIP_RA.EIP_RA_USR.INTERVAL_F"		         [Elec Usage info]
-- "YOURSCHEMA"."EIP_RA.EIP_RA_USR.SDP_D"			             [WID, UDC_ID (ESI_IS)]

-- Business Requirements Doc (BRD)
-- 1. Basic data elements to be included are:
-- 	ESIID, CIS Account Number, Meter Number, Name, Address, Unit No, Zip Code, Srv Center (of address), Acct Status (Active/Inactive)
-- 	HCO, Srv Drop Location, DNP Date, Pending R/C, MVI, MVO, Last Crew Onsite, Last Crew Onsite Time Stamp, Route Number (CIS), Service Order, Billing Cycle
-- 2. This report shall be a daily report pulled to identify if a premise has tampering based upon a pattern.
-- 3. Pull all Disconnect for Non Pay accounts that occur 3 days from the DNP date.
-- 4. The DNP’d account should still be in Active Status.
-- 5. In addition, the Disconnect must not be accompanied by a Reconnect, a Move-Out or and Move-In.
-- 6. There must be 2 months of usage greater than 200 KWH prior to the DNP date.
-- 7. This data shall be refreshed daily to accurately populate the report.

-- Filter the data ASAP.

SELECT
DNP.INSERT_TS AS INSERT_TS_OLD,
DNP.ESI_ID,
DNP.MTR_NO,
DNP.JOB_CD,
DNP.MAX_ACTUAL_END_TS,
prem.ELEC_ACCT_ID,
prem.NAME,
prem.STREET_NUMBER,
prem.STREET_PREFIX,
prem.STREET_NAME,
prem.STREET_SUFFIX,
prem.STREET_APARTMENT,
prem.CITY,
prem.ZIP_CD,
prem.SERVICE_CENTER,
prem.ACCT_RECEIVABLE_STATUS,
prem.ROUTE,
mete.MS_UNGR,
LAST_MONTH.MONTHLY_USAGE as KWH_1,
LAST_LAST_MONTH.MONTHLY_USAGE as KWH_2,
SUBSTR(TROUBLE.JOB_CODE, 1, 6) AS TROUBLE_CALL,
TROUBLE.CREW_ONSITE_TS AS TROUBLE_CALL_TS,
CREW.JOB_CODE AS CREW_ONSITE_JOB,
CREW.CREW_ONSITE_TS AS LAST_CREW_ONSITE_TS

FROM

-- 3. Pull all Disconnect for Non Pay accounts that occur 3 days from the DNP date.
--------------------------------------------------------------------------------------
-- Table: "YOURSCHEMA"."STG.T_STG_EAI_SVC_ORDERS_HIST" table [DNP info]
-- Create DNP table, pull all Disconnect for Non Pay accounts that occur 3 days from the DNP date.
-- (for example, today is 6/13, find user who DNP on 6/10 [6/10 00AM - 6/11 00AM])
-- Make sure the BPI_STATE is not cancelled and JOB_CD is DNP.
-- We want extract and group by INSERT_TS, (ESI_ID, MTR_NO), JOB_CD, MAX(ACTUAL_END_TS) (Last DNP time)
(SELECT
INSERT_TS, ESI_ID, MTR_NO, JOB_CD, MAX(ACTUAL_END_TS) AS MAX_ACTUAL_END_TS
FROM "YOURSCHEMA"."STG.T_STG_EAI_SVC_ORDERS_HIST"
WHERE ACTUAL_END_TS >= TO_TIMESTAMP(ADD_DAYS(CURRENT_DATE, -3))
AND ACTUAL_END_TS <= TO_TIMESTAMP(ADD_DAYS(CURRENT_DATE, -2))
AND (BPI_STATE NOT LIKE '%Cancelled%')
AND (JOB_CD LIKE '%DNP%')
GROUP BY INSERT_TS, ESI_ID, MTR_NO, JOB_CD) DNP
---------------------------------------------------------------------------------------

LEFT JOIN


-- 5. In addition, the Disconnect must not be accompanied by a Reconnect, a Move-Out or and Move-In.
---------------------------------------------------------------------------------------
-- Table: "YOURSCHEMA"."STG.T_STG_EAI_SVC_ORDERS_HIST" table [DNP info]
-- Create FILTER table, within 3 days, the disconnect must not be accompanied by a Reconnect, a Move-Out or and Move-In.
-- (for example, today is 6/13, users who plan to MI, MO, RC may got DNP on 6/10, but due to holiday or weekend, they informed to CenterPoint in later days.)
-- Designed grace period is 3 days.
-- We plan to filter it by [MTR_NO is NULL] later.
(SELECT MTR_NO, JOB_CD, ACTUAL_END_TS
FROM "YOURSCHEMA"."STG.T_STG_EAI_SVC_ORDERS_HIST"
WHERE INSERT_TS >= TO_TIMESTAMP(ADD_DAYS(CURRENT_DATE, -3))
AND INSERT_TS <= TO_TIMESTAMP(CURRENT_DATE)
AND (JOB_CD LIKE '%MVI%' OR JOB_CD LIKE '%RNP%' OR JOB_CD LIKE '%MVO%')) FILTER
---------------------------------------------------------------------------------------

ON DNP.MTR_NO = FILTER.MTR_NO


LEFT JOIN

---------------------------------------------------------------------------------------
-- Table: "YOURSCHEMA"."STG.T_MOBILE_DATA_CREW_ONSITE_HIST" [Crew onsite info]
-- Create TROUBLE table, find the most recent on site crew (with trouble code) for DNP users, to check if they caught the problem in time.
-- Apply window function to find most recent by desc time.
(SELECT ESI_ID, JOB_CODE, CREW_ONSITE_TS
FROM
(SELECT ESI_ID, JOB_CODE,TO_TIMESTAMP((ONSITE_DT||' '||ONSITE_TIME), 'YYYY-MM-DD HH24:MI:SS') AS CREW_ONSITE_TS,
ROW_NUMBER() OVER (PARTITION BY ESI_ID ORDER BY TO_TIMESTAMP((ONSITE_DT||' '||ONSITE_TIME), 'YYYY-MM-DD HH24:MI:SS') DESC) AS MY_RANK
FROM "YOURSCHEMA"."STG.T_MOBILE_DATA_CREW_ONSITE_HIST"
WHERE JOB_CODE IN ('222TBL','CKTTBL','000TBL','SPOTBL') -- TROUBLE CODE
)
WHERE MY_RANK = 1
) TROUBLE
---------------------------------------------------------------------------------------

ON DNP.ESI_ID = TROUBLE.ESI_ID

LEFT JOIN

---------------------------------------------------------------------------------------
-- Table: "YOURSCHEMA"."STG.T_MOBILE_DATA_CREW_ONSITE_HIST" [Crew onsite info]
-- Create CREW table,for crews' job code not depend on trouble.
(SELECT ESI_ID, JOB_CODE, CREW_ONSITE_TS
FROM
(SELECT ESI_ID, JOB_CODE,TO_TIMESTAMP((ONSITE_DT||' '||ONSITE_TIME), 'YYYY-MM-DD HH24:MI:SS') AS CREW_ONSITE_TS,
ROW_NUMBER() OVER (PARTITION BY ESI_ID ORDER BY TO_TIMESTAMP((ONSITE_DT||' '||ONSITE_TIME), 'YYYY-MM-DD HH24:MI:SS') DESC) AS MY_RANK
FROM "YOURSCHEMA"."STG.T_MOBILE_DATA_CREW_ONSITE_HIST"
WHERE JOB_CODE NOT IN ('222TBL','CKTTBL','000TBL','SPOTBL')
)
WHERE MY_RANK = 1
) CREW
---------------------------------------------------------------------------------------

ON DNP.ESI_ID = CREW.ESI_ID

LEFT JOIN

---------------------------------------------------------------------------------------
-- Table: "YOURSCHEMA"."STG.PREMISE_CHAR" [Customer info]
-- Create PREM table, find DNP user info, including ACCT_RECEIVABLE_STATUS
(SELECT ESIID,
ELEC_ACCT_ID,
NAME,
STREET_NUMBER,
STREET_PREFIX,
STREET_NAME,
STREET_SUFFIX,
STREET_APARTMENT,
CITY, ZIP_CD, SERVICE_CENTER, ACCT_RECEIVABLE_STATUS, ROUTE
FROM "YOURSCHEMA"."STG.PREMISE_CHAR") PREM
---------------------------------------------------------------------------------------

ON DNP.ESI_ID = PREM.ESIID

LEFT JOIN

---------------------------------------------------------------------------------------
-- Table: "YOURSCHEMA"."STG.METER_CHAR"[Meter info]
-- Create PREM table, find DNP users' meter info
(SELECT ESIID, MS_UNGR
FROM "YOURSCHEMA"."STG.METER_CHAR") METE
---------------------------------------------------------------------------------------

ON DNP.ESI_ID = METE.ESIID

LEFT JOIN

---------------------------------------------------------------------------------------
-- Table: "YOURSCHEMA"."EIP_RA.EIP_RA_USR.INTERVAL_F"		 [Elec Usage info, WID]
-- Table: "YOURSCHEMA"."EIP_RA.EIP_RA_USR.SDP_D"			 [WID, UDC_ID (ESI_IS)]
-- [5/1/2023 - 6/1/2023] MONTHLY USAGE FOR EACH USER
(SELECT
F.MONTH_END,
D.UDC_ID AS ESI_ID,
F.SDP_WID,
F.MONTHLY_USAGE
FROM
(SELECT SDP_WID, TO_TIMESTAMP(ADD_DAYS(CURRENT_DATE,-DAYOFMONTH(CURRENT_DATE))) AS MONTH_END, SUM(INTERVAL_VALUE) AS MONTHLY_USAGE
FROM "YOURSCHEMA"."EIP_RA.EIP_RA_USR.INTERVAL_F"
WHERE INTERVAL_END_TIME BETWEEN
TO_TIMESTAMP(ADD_MONTHS(ADD_DAYS(CURRENT_DATE, +1- DAYOFMONTH(CURRENT_DATE)), -1))
AND
TO_TIMESTAMP(ADD_MONTHS(ADD_DAYS(CURRENT_DATE, +1- DAYOFMONTH(CURRENT_DATE)), -0))
GROUP BY SDP_WID) F
LEFT JOIN "YOURSCHEMA"."EIP_RA.EIP_RA_USR.SDP_D" D
ON F.SDP_WID = D.WID) LAST_MONTH
---------------------------------------------------------------------------------------

ON DNP.ESI_ID = LAST_MONTH.ESI_ID

LEFT JOIN

---------------------------------------------------------------------------------------
-- Table: "YOURSCHEMA"."EIP_RA.EIP_RA_USR.INTERVAL_F"		 [Elec Usage info, WID]
-- Table: "YOURSCHEMA"."EIP_RA.EIP_RA_USR.SDP_D"			 [WID, UDC_ID (ESI_IS)]
-- [4/1/2023 - 5/1/2023] MONTHLY USAGE FOR EACH USER
(SELECT
F.MONTH_END,
D.UDC_ID AS ESI_ID,
F.SDP_WID,
F.MONTHLY_USAGE
FROM
(SELECT SDP_WID, TO_TIMESTAMP(ADD_DAYS(CURRENT_DATE,-DAYOFMONTH(CURRENT_DATE))) AS MONTH_END, SUM(INTERVAL_VALUE) AS MONTHLY_USAGE
FROM "YOURSCHEMA"."EIP_RA.EIP_RA_USR.INTERVAL_F"
WHERE INTERVAL_END_TIME BETWEEN
TO_TIMESTAMP(ADD_MONTHS(ADD_DAYS(CURRENT_DATE, +1- DAYOFMONTH(CURRENT_DATE)), -2))
AND
TO_TIMESTAMP(ADD_MONTHS(ADD_DAYS(CURRENT_DATE, +1- DAYOFMONTH(CURRENT_DATE)), -1))
GROUP BY SDP_WID) F
LEFT JOIN "YOURSCHEMA"."EIP_RA.EIP_RA_USR.SDP_D" D
ON F.SDP_WID = D.WID) LAST_LAST_MONTH
---------------------------------------------------------------------------------------

ON DNP.ESI_ID = LAST_LAST_MONTH.ESI_ID

---------------------------------------------------------------------------------------
-- 4. The DNP’d account should still be in Active Status.
-- 5. In addition, the Disconnect must not be accompanied by a Reconnect, a Move-Out or and Move-In.
-- 6. There must be 2 months of usage greater than 200 KWH prior to the DNP date.
WHERE
LAST_MONTH.MONTHLY_USAGE >= 200 AND LAST_LAST_MONTH.MONTHLY_USAGE >= 200 AND FILTER.MTR_NO IS NULL AND PREM.ACCT_RECEIVABLE_STATUS = 'A'
