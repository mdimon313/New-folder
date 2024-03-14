CREATE OR REPLACE PROCEDURE BMS.P_HR_507286_XL (
    P_START_DATE                DATE,
    P_END_DATE                  DATE,
    P_EMP_NO                    NUMBER,
    P_COMPANY_NO                NUMBER,
    P_BANK_NO                   NUMBER,
    P_HR_TYPE                   NUMBER,
    P_JOBTITLE_NO               NUMBER,
    P_JOBLOC_NO                 NUMBER,
    P_SALARY_BANK_ACC_NO        VARCHAR2,
    P_SAL_FROM_ACCOUNT_NO       NUMBER,
    P_LINE_NO                   NUMBER,
    P_BU_CHK_ALL                VARCHAR2,
    P_BU_NO_ALL                 VARCHAR2,
    P_JOB_TYPE                  NUMBER,
    P_SHIFT_NO                  NUMBER,
    P_EMP_TYPE_NO               NUMBER,
    P_FLOOR_NO                  NUMBER,
    P_SALARY_MIN                NUMBER,
    P_SALARY_MAX                NUMBER,
    P_GRADE                     NUMBER,
    P_MODE                      VARCHAR2,
    P_ACTIVE                    NUMBER,
    P_EXEL_NAME                 VARCHAR2,
    P_SETTLEMENT_TYPE           NUMBER,
    P_JOBTITLE_GROUP_NO         NUMBER,
    P_SUCCESS_STAT          OUT NUMBER,
    G_USER_NO                   NUMBER,
    G_COMPANY_NO                NUMBER)
IS
    V_QUERY       CLOB;
    V_NO_OF_REC   NUMBER (10) := 0;
    V_P_MODE      VARCHAR2 (30);
BEGIN
    IF P_MODE IS NULL
    THEN
        V_P_MODE := 'NULL';
    ELSE
        V_P_MODE := P_MODE;
    END IF;

    V_QUERY := 'SELECT *
FROM (SELECT Q2.EMP_NO,
             Q2.SALARY_NO,
             Q2.SALSTART_DATE,
             Q2.SALEND_DATE,
             Q2.EMP_ID,
             Q2.EMP_NAME,
             Q2.EMP_NAME_ID,
             Q2.JOBTITLE,
             Q2.JOBTITLE_NO,
             Q2.DEPARTMENT,
             Q2.SECTION,
             Q2.BU_NAME,
             Q2.BU_NO,
             Q2.LINE_NAME,
             Q2.FLOOR_NAME,
             Q2.HR_TYPE,
             Q2.JOB_TYPE,
             Q2.EMP_TYPE_NAME,
             Q2.JOIN_DATE,
             Q2.SALARY_GRADE,
             Q2.SALARY_BANK_ACC_NO,
             Q2.COMPANY_NO,
             (CASE WHEN (Q2.NET_PAYABLE_ACT * (NVL (Q2.CASH_RATIO, 0) / 100)) > 0 THEN NULL ELSE Q2.BANK_NAME END)
                 BANK_NAME,
             Q2.ACTUAL_GROSS,
             Q2.ACTUAL_BASIC,
             Q2.ACTUAL_HOUSE_RENT,
             Q2.ACTUAL_MED_ALLOW,
             (NVL (Q2.ACTUAL_CONV, 0) + NVL (Q2.CONVEYNCE_ALLOW, 0))
                 ACTUAL_CONV,
             (NVL (Q2.ACTUAL_FOOD_ALLOW, 0) + NVL (ADDITIONAL_FOOD_BILL, 0))
                 ACTUAL_FOOD_ALLOW,
             NVL (Q2.PRESENT_DAY, 0) PRESENT_DAY,
             NVL (Q2.OSD, 0)
                 OSD,
             Q2.ABSENT_DAY,
             Q2.LEAVE_DAY,
             (Q2.HOLIDAY + Q2.OFF_DAY) WH,
             Q2.WP,
             Q2.CPL,
             Q2.CL,
             Q2.ML,
             Q2.EL,
             Q2.SL,
             Q2.LATE_STAT,
             Q2.DURATION_DAY,
             Q2.TOT_LEAVE,
             Q2.TOT_DAYS,
             Q2.GROSS_SALARY,
             Q2.PARTIAL_SALARY,
             Q2.BASIC,
             Q2.HOUSE_RENT,
             Q2.MEDICAL_ALLOW,
             Q2.CONVEYNCE,
             NVL (Q2.FOOD_ALLOW, 0)
                 FOOD_ALLOW,
             Q2.GROSS_WAGES,
             Q2.BONUS,
             Q2.AREAR,
             Q2.ADV_ADJUST,
             Q2.EMERGENCY_FUND,
             Q2.PRV_FUND,
             Q2.PF_OWN,
             Q2.REVENUE_STAMP,
             Q2.TIFFIN_BILL,
             Q2.SP_NIGHT_ALLOW,
             Q2.ABSENT_DEDUCTION,
             Q2.EARNED_SALARY,
             Q2.ATTENDANCE_BONUS,
             Q2.TOT_SALARY,
             Q2.OTHER_EARNING,
             Q2.WELFARE_FUND,
             Q2.LATE_FINE,
             Q2.LATE_FINE_DAY,
             Q2.LATE_FINE_MIN,
             Q2.LUNCH_BILL,
             Q2.CANTEEN,
             Q2.SPECIAL_ALLOW,
             Q2.OTHER_DEDUCTION,
             Q2.SALARY_ADJUSTMENT,
             Q2.EDUCATIONAL_FUND,
             Q2.MOBILE_BILL,
             Q2.EARLY_OUT_FINE,
             Q2.EARLY_OUT_FINE_DAY,
             Q2.EARLY_OUT_FINE_MIN,
             Q2.TAX,
             Q2.DAY_DED,
             Q2.OT_HOUR,
             Q2.OT_HOUR_2,
             Q2.OT_RATE,
             Q2.TOTAL_OT,
             Q2.TOTAL_OT_2,
             Q2.DAY_AMT_DED,
             Q2.ROHINGA_FUND,
             Q2.PROD_BONUS,
             Q2.CASH_PAYMENT,
             Q2.CHEQUE_PAYMENT,
             Q2.TOT_EARNING,
             Q2.TOTAL_DED,
             Q2.NET_PAYABLE_ACT,
             Q2.NET_PAYABLE_COM,
             (Q2.NET_PAYABLE_COM * (NVL (Q2.CHEQUE_RATIO, 0) / 100))
                 CHECK_AMT,
             (Q2.NET_PAYABLE_COM * (NVL (Q2.CASH_RATIO, 0) / 100))
                 CASH_AMT,
             Q2.CASH_RATIO,
             Q2.SPALLDED_AMT,
             Q2.CHEQUE_RATIO
        FROM (SELECT Q1.EMP_NO,
                     Q1.SALARY_NO,
                     Q1.SALSTART_DATE,
                     Q1.SALEND_DATE,
                     Q1.EMP_ID,
                     Q1.EMP_NAME,
                     Q1.EMP_NAME_ID,
                     Q1.JOBTITLE,
                     Q1.JOBTITLE_NO,
                     Q1.DEPARTMENT,
                     Q1.SECTION,
                     Q1.BU_NAME,
                     Q1.BU_NO,
                     Q1.LINE_NAME,
                     Q1.FLOOR_NAME,
                     Q1.HR_TYPE,
                     Q1.JOB_TYPE,
                     Q1.EMP_TYPE_NAME,
                     Q1.JOIN_DATE,
                     Q1.SALARY_GRADE,
                     Q1.SALARY_BANK_ACC_NO,
                     Q1.COMPANY_NO,
                     Q1.BANK_NAME,
                     Q1.ACTUAL_GROSS,
                     Q1.ACTUAL_BASIC,
                     Q1.ACTUAL_HOUSE_RENT,
                     Q1.ACTUAL_MED_ALLOW,
                     Q1.ACTUAL_CONV,
                     Q1.CONVEYNCE_ALLOW,
                     Q1.ACTUAL_FOOD_ALLOW,
                     Q1.PRESENT_DAY,
                     Q1.OSD,
                     Q1.ABSENT_DAY,
                     Q1.LEAVE_DAY,
                     Q1.HOLIDAY,
                     Q1.OFF_DAY,
                     Q1.WP,
                     Q1.CPL,
                     Q1.CL,
                     Q1.ML,
                     Q1.EL,
                     Q1.SL,
                     Q1.LATE_STAT,
                     Q1.DURATION_DAY,
                     NVL (Q1.CL, 0) + NVL (Q1.CPL, 0) + NVL (Q1.EL, 0) + NVL (Q1.SL, 0)
                         TOT_LEAVE,
                       NVL (Q1.CL, 0)
                     + NVL (Q1.CPL, 0)
                     + NVL (Q1.EL, 0)
                     + NVL (Q1.SL, 0)
                     + NVL (Q1.OSD, 0)
                     + NVL (Q1.PRESENT_DAY, 0)
                     + NVL (Q1.HOLIDAY, 0)
                     + NVL (Q1.OFF_DAY, 0)
                         TOT_DAYS,
                     Q1.GROSS_SALARY,
                     Q1.PARTIAL_SALARY,
                     Q1.BASIC,
                     Q1.HOUSE_RENT,
                     Q1.MEDICAL_ALLOW,
                     Q1.CONVEYNCE,
                     Q1.FOOD_ALLOW,
                     Q1.ADDITIONAL_FOOD_BILL,
                     Q1.GROSS_WAGES,
                     Q1.BONUS,
                     Q1.AREAR,
                     (Q1.ADV_ADJUST + Q1.SPALLDED_AMT)
                         ADV_ADJUST,
                     Q1.EMERGENCY_FUND,
                     Q1.PRV_FUND,
                     Q1.PF_OWN,
                     Q1.REVENUE_STAMP,
                     Q1.TIFFIN_BILL,
                     Q1.SP_NIGHT_ALLOW,
                     Q1.ABSENT_DEDUCTION,
                     ROUND (NVL (Q1.GROSS_WAGES, 0) - NVL (Q1.ABSENT_DEDUCTION, 0))
                         EARNED_SALARY,
                     Q1.ATTENDANCE_BONUS,
                     ROUND (NVL (Q1.GROSS_WAGES, 0) - NVL (Q1.ABSENT_DEDUCTION, 0) + NVL (Q1.ATTENDANCE_BONUS, 0))
                         TOT_SALARY,
                     Q1.OTHER_EARNING,
                     Q1.WELFARE_FUND,
                     Q1.LATE_FINE,
                     Q1.LATE_FINE_DAY,
                     Q1.LATE_FINE_MIN,
                     Q1.LUNCH_BILL,
                     Q1.CANTEEN,
                     Q1.SPECIAL_ALLOW,
                     Q1.OTHER_DEDUCTION,
                     Q1.SALARY_ADJUSTMENT,
                     Q1.EDUCATIONAL_FUND,
                     Q1.MOBILE_BILL,
                     Q1.EARLY_OUT_FINE,
                     Q1.EARLY_OUT_FINE_DAY,
                     Q1.EARLY_OUT_FINE_MIN,
                     Q1.TAX,
                     Q1.DAY_DED,
                     Q1.OT_HOUR,
                     Q1.OT_HOUR_2,
                     Q1.OT_RATE,
                     Q1.TOTAL_OT,
                     Q1.TOTAL_OT_2,
                     Q1.DAY_AMT_DED,
                     Q1.ROHINGA_FUND,
                     Q1.PROD_BONUS,
                     Q1.CASH_PAYMENT,
                     Q1.CHEQUE_PAYMENT,
                     (NVL (Q1.GROSS_WAGES, 0) + NVL (Q1.AREAR, 0) + NVL (Q1.ATTENDANCE_BONUS, 0)) TOT_EARNING,
                     (  NVL (Q1.ADV_ADJUST, 0)
                      + NVL (Q1.EMERGENCY_FUND, 0)
                      + NVL (Q1.PRV_FUND, 0)
                      + NVL (Q1.PF_OWN, 0)
                      + NVL (Q1.LATE_FINE, 0)
                      + NVL (Q1.SALARY_ADJUSTMENT, 0)
                      + NVL (Q1.WELFARE_FUND, 0)
                      + NVL (Q1.REVENUE_STAMP, 0)
                      + NVL (Q1.CANTEEN, 0)
                      + NVL (Q1.EDUCATIONAL_FUND, 0)
                      + NVL (Q1.MOBILE_BILL, 0)
                      + NVL (Q1.EARLY_OUT_FINE, 0)
                      + NVL (Q1.TAX, 0)
                      + NVL (Q1.SPALLDED_AMT, 0)
                      + NVL (Q1.DAY_AMT_DED, 0) + NVL (Q1.OTHER_DEDUCTION, 0) ) TOTAL_DED,
                     ( (NVL (Q1.GROSS_WAGES, 0) + NVL (Q1.AREAR, 0) + NVL (Q1.ATTENDANCE_BONUS, 0) + NVL (Q1.TOTAL_OT, 0))
                      - (  NVL (Q1.ABSENT_DEDUCTION, 0)
                         + NVL (Q1.ADV_ADJUST, 0)
                         + NVL (Q1.EMERGENCY_FUND, 0)
                         + NVL (Q1.PRV_FUND, 0)
                         + NVL (Q1.PF_OWN, 0)
                         + NVL (Q1.LATE_FINE, 0)
                         + NVL (Q1.SALARY_ADJUSTMENT, 0)
                         + NVL (Q1.WELFARE_FUND, 0)
                         + NVL (Q1.REVENUE_STAMP, 0)
                         + NVL (Q1.CANTEEN, 0)
                         + NVL (Q1.EDUCATIONAL_FUND, 0)
                         + NVL (Q1.MOBILE_BILL, 0)
                         + NVL (Q1.EARLY_OUT_FINE, 0)
                         + NVL (Q1.TAX, 0)
                         + NVL (Q1.SPALLDED_AMT, 0)
                         + NVL (Q1.DAY_AMT_DED, 0) + NVL (Q1.OTHER_DEDUCTION, 0)
                                                  ))
                         NET_PAYABLE_ACT,
                     (  (NVL (Q1.GROSS_WAGES, 0) + NVL (Q1.AREAR, 0) + NVL (Q1.ATTENDANCE_BONUS, 0) + NVL (Q1.TOTAL_OT_2, 0))
                      - (  NVL (Q1.ABSENT_DEDUCTION, 0)
                         + NVL (Q1.ADV_ADJUST, 0)
                         + NVL (Q1.PRV_FUND, 0)
                         + NVL (Q1.SALARY_ADJUSTMENT, 0)
                         + NVL (Q1.WELFARE_FUND, 0)
                         + NVL (Q1.REVENUE_STAMP, 0)
                         + NVL (Q1.CANTEEN, 0)
                         + NVL (Q1.MOBILE_BILL, 0)
                         + NVL (Q1.EARLY_OUT_FINE, 0)
                         + NVL (Q1.TAX, 0)
                         + NVL (Q1.SPALLDED_AMT, 0)
                         + NVL (Q1.DAY_AMT_DED, 0) + NVL (Q1.OTHER_DEDUCTION, 0)
                                                  ))
                         NET_PAYABLE_COM,
                     Q1.SPALLDED_AMT,
                     Q1.CASH_RATIO,
                     Q1.CHEQUE_RATIO
                FROM (SELECT V.EMP_NO,
                             V.SALARY_NO,
                             V.SALSTART_DATE,
                             V.SALEND_DATE,
                             E.EMP_ID,
                             E.EMP_NAME,
                             E.EMP_NAME_ID,
                             E.JOBTITLE,
                             E.JOBTITLE_NO,
                             E.DEPARTMENT,
                             E.SECTION,
                             E.BU_NAME,
                             E.BU_NO,
                             E.LINE_NAME,
                             E.FLOOR_NAME,
                             E.HR_TYPE,
                             E.JOB_TYPE,
                             E.EMP_TYPE_NAME,
                             E.JOIN_DATE,
                             E.SALARY_GRADE,
                             E.SALARY_BANK_ACC_NO,
                             E.COMPANY_NO,
                             BN.ALIAS
                                 BANK_NAME,
                             ROUND (NVL (K_HR_PAYROLL.F_EMP_GROSS (V.EMP_NO, V.SALEND_DATE), 0), 0)
                                 ACTUAL_GROSS,
                             ROUND (NVL (K_HR_PAYROLL.F_EMP_BASIC (V.EMP_NO, V.SALEND_DATE), 0), 0)
                                 ACTUAL_BASIC,
                             ROUND (NVL (F_ELEMENT_AMT (V.EMP_NO, ''HOUSE_RENT'', V.SALEND_DATE), 0), 0)
                                 ACTUAL_HOUSE_RENT,
                             ROUND (NVL (F_ELEMENT_AMT (V.EMP_NO, ''MED_ALLOW'', V.SALEND_DATE), 0), 0)
                                 ACTUAL_MED_ALLOW,
                             ROUND (NVL (F_ELEMENT_AMT (V.EMP_NO, ''CONV'', V.SALEND_DATE), 0), 0)
                                 ACTUAL_CONV,
                             ROUND (NVL (F_ELEMENT_AMT (V.EMP_NO, ''FOOD_ALLOW'', V.SALEND_DATE), 0), 0)
                                 ACTUAL_FOOD_ALLOW,
                             NVL (V.PRESENT_DAY, 0)
                                 PRESENT_DAY,
                             NVL (V.ABSENT_DAY, 0)
                                 ABSENT_DAY,
                             NVL (V.LEAVE_DAY, 0)
                                 LEAVE_DAY,
                             NVL (V.HOLIDAY, 0)
                                 HOLIDAY,
                             NVL (V.OFF_DAY, 0)
                                 OFF_DAY,
                             NVL (SA.WP, 0)
                                 WP,
                             NVL (SA.CPL, 0)
                             CPL,
                             NVL (SA.CL, 0)
                                 CL,
                             NVL (SA.ML, 0)
                                 ML,
                             NVL (SA.EL, 0)
                                 EL,
                             NVL (SA.SL, 0)
                                 SL,
                             NVL (SA.OSD, 0)
                                 OSD,
                             NVL (SA.LATE_STAT, 0)
                                 LATE_STAT,
                             (V.SALEND_DATE - E.JOIN_DATE)
                                 DURATION_DAY,
                             ROUND (NVL (V.GROSS_SALARY, 0), 0)
                                 GROSS_SALARY,
                             ROUND (NVL (V.PARTIAL_SALARY_GROUP, 0), 0)
                                 PARTIAL_SALARY,
                             ROUND (NVL (V.BASIC, 0), 0)
                                 BASIC,
                             ROUND (NVL (V.HOUSE_RENT, 0), 0)
                                 HOUSE_RENT,
                             ROUND (NVL (V.MEDICAL_ALLOW, 0), 0)
                                 MEDICAL_ALLOW,
                             ROUND (NVL (V.CONVEYNCE, 0), 0)
                                 CONVEYNCE,
                             ROUND (NVL (V.CONVEYNCE_ALLOW, 0), 0)
                                 CONVEYNCE_ALLOW,
                             ROUND (NVL (V.FOOD_ALLOW, 0), 0)
                                 FOOD_ALLOW,
                             NVL (V.ADDITIONAL_FOOD_BILL, 0)
                                 ADDITIONAL_FOOD_BILL,
                             ROUND (
                                 (  NVL (V.BASIC, 0)
                                  + NVL (V.HOUSE_RENT, 0)
                                  + NVL (V.MEDICAL_ALLOW, 0)
                                  + NVL (V.FOOD_ALLOW, 0)
                                  + NVL (V.CONVEYNCE, 0)
                                  + NVL (V.CONVEYNCE_ALLOW, 0)
                                  + NVL (V.ADDITIONAL_FOOD_BILL, 0)),
                                 0)
                                 GROSS_WAGES,
                             ROUND (NVL (V.ATTENDANCE_BONUS, 0), 0)
                                 ATTENDANCE_BONUS,
                             ROUND (NVL (V.ATTENDANCE_BONUS, 0) + NVL (V.BONUS, 0), 0)
                                 BONUS,
                             ROUND (NVL (V.AREAR, 0), 0)
                                 AREAR,
                             ROUND (NVL (V.ADV_ADJUST, 0), 0)
                                 ADV_ADJUST,
                             ROUND (NVL (V.I_OWE_YOU, 0), 0)
                                 EMERGENCY_FUND,
                             ROUND (NVL (V.PRV_FUND, 0), 0)
                                 PRV_FUND,
                             ROUND (NVL (V.PF_OWN, 0), 0)
                                 PF_OWN,
                             ROUND (NVL (V.REVENUE_STAMP, 0), 0)
                                 REVENUE_STAMP,
                             ROUND (NVL (V.TIFFIN_BILL, 0), 0)
                                 TIFFIN_BILL,
                             ROUND (NVL (V.SP_NIGHT_ALLOW, 0), 0)
                                 SP_NIGHT_ALLOW,
                             ROUND (
                                   NVL (V.ABSENT_DEDUCTION, 0)
                                 + NVL (V.PUNISH_LEAVE_DED, 0)
                                 + NVL (V.LWP_STAFF, 0)
                                 + NVL (V.ABSENT_DEDUCTION_STAFF, 0),
                                 0)
                                 ABSENT_DEDUCTION,
                             ROUND (NVL (V.OTHER_EARNING, 0), 0)
                                 OTHER_EARNING,
                             ROUND (NVL (V.WELFARE_FUND, 0) + NVL (V.ROHINGA_FUND, 0), 0)
                                 WELFARE_FUND,
                             ROUND (NVL (V.LATE_FINE, 0), 0)
                                 LATE_FINE,
                             NVL (V.LATE_FINE_DAY, 0)
                                 LATE_FINE_DAY,
                             NVL (V.LATE_FINE_MIN, 0)
                                 LATE_FINE_MIN,
                             ROUND (NVL (V.LUNCH_BILL, 0), 0)
                                 LUNCH_BILL,
                             ROUND (NVL (V.CANTEEN, 0), 0)
                                 CANTEEN,
                             ROUND (NVL (V.SPECIAL_ALLOW, 0), 0)
                                 SPECIAL_ALLOW,
                             ROUND (NVL (V.OTHER_DEDUCTION, 0), 0)
                                 OTHER_DEDUCTION,
                             ROUND (NVL (V.SALARY_ADJUSTMENT, 0), 0)
                                 SALARY_ADJUSTMENT,
                             ROUND (NVL (V.EDUCATIONAL_FUND, 0) + NVL (V.LUNCH_OUT, 0), 0)
                                 EDUCATIONAL_FUND,
                             ROUND (NVL (V.MOBILE_BILL, 0), 0)
                                 MOBILE_BILL,
                             ROUND (NVL (V.EARLY_OUT_FINE, 0), 0)
                                 EARLY_OUT_FINE,
                             NVL (V.EARLY_OUT_FINE_DAY, 0)
                                 EARLY_OUT_FINE_DAY,
                             NVL (V.EARLY_OUT_FINE_MIN, 0)
                                 EARLY_OUT_FINE_MIN,
                             ROUND (NVL (V.TAX, 0), 0)
                                 TAX,
                             ROUND (NVL (V.DAY_DED, 0), 0)
                                 DAY_DED,
                             (NVL (V.OT_HOUR, 0) + NVL (EOT.HOUR, 0))
                                 OT_HOUR,
                             NVL (V.OT_HOUR, 0)
                                 OT_HOUR_2,
                             V.OT_RATE,
                             ROUND ((NVL (V.OT_HOUR, 0) + NVL (EOT.HOUR, 0)) * NVL (V.OT_RATE, 0))
                                 TOTAL_OT,
                             ROUND (NVL (V.OT_HOUR, 0) * NVL (V.OT_RATE, 0))
                                 TOTAL_OT_2,
                             ROUND (NVL (V.DAY_AMT_DED, 0), 0)
                                 DAY_AMT_DED,
                             ROUND (NVL (V.ROHINGA_FUND, 0), 0)
                                 ROHINGA_FUND,
                             ROUND (NVL (V.PROD_BONUS, 0), 0)
                                 PROD_BONUS,
                             NVL (PS.SPALLDED_AMT, 0)
                                 SPALLDED_AMT,
                             C.CASH_PAYMENT,
                             C.CHEQUE_PAYMENT,
                             P.CASH_RATIO,
                             P.CHEQUE_RATIO
                        FROM HR_SALARY_SHEET_V V,
                             HR_SALARYEMPDTL  E,
                             (  SELECT SPD.EMP_NO, SUM (NVL (SPD.SPALLDED_AMT, 0)) SPALLDED_AMT
                                  FROM HR_SPEALLDED SP, HR_SPEALLDEDDTL SPD
                                 WHERE     SP.SPALLDED_NO = SPD.SPALLDED_NO
                                       AND SP.ELEMENT_NO IN (55, 44)
                                       AND EFFECTIVE_DATE BETWEEN '''||P_START_DATE||''' AND '''||P_END_DATE||'''
                              GROUP BY SPD.EMP_NO) PS,
                             (SELECT SALARY_NO, CASH_RATIO, CHEQUE_RATIO
                                FROM HR_SALARYDTL SD
                               WHERE ELEMENT_NO = 1) P,
                             SA_HRDATA        EOT,
                             (  SELECT SALARY_NO,
                                       SUM (
                                           CASE
                                               WHEN    UPPER (SAD.PREFIX) LIKE ''WP%''
                                                    OR UPPER (SAD.PREFIX) LIKE ''HP%''
                                                    OR UPPER (SAD.PREFIX) LIKE ''OP%''
                                               THEN
                                                   1
                                               ELSE
                                                   0
                                           END)
                                           WP,
                                       SUM (CASE WHEN UPPER (SAD.PREFIX) LIKE ''CL%'' THEN 1 ELSE 0 END)
                                           CL,
                                       SUM (CASE WHEN UPPER (SAD.PREFIX) LIKE ''CPL%'' THEN 1 ELSE 0 END)
                                           CPL,
                                       SUM (CASE WHEN UPPER (SAD.PREFIX) LIKE ''SL%'' THEN 1 ELSE 0 END)
                                           SL,
                                       SUM (CASE WHEN UPPER (SAD.PREFIX) LIKE ''ML%'' THEN 1 ELSE 0 END)
                                           ML,
                                       SUM (CASE WHEN UPPER (SAD.PREFIX) LIKE ''EL%'' THEN 1 ELSE 0 END)
                                           EL,
                                       SUM (CASE WHEN UPPER (SAD.PREFIX) LIKE ''OSD%'' THEN 1 ELSE 0 END)
                                           OSD,
                                       SUM (SAD.LATE_STAT)
                                           LATE_STAT
                                  FROM HR_SALARYATTNDTL SAD
                                 WHERE SAD.CAL_DT BETWEEN '''||P_START_DATE||''' AND '''||P_END_DATE||'''
                              GROUP BY SAD.SALARY_NO) SA,
                             AC_BANKDTL_V     BN,
                             (SELECT A.EMP_NO, A.CASH_PAYMENT, A.CHEQUE_PAYMENT
                                FROM HR_EMPPAYROLL A
                               WHERE A.EFFECTIVE_DATE = (SELECT MAX (EFFECTIVE_DATE)
                                                           FROM HR_EMPPAYROLL B
                                                          WHERE B.EMP_NO = A.EMP_NO)) C,
                             (    SELECT REGEXP_SUBSTR ( '||NVL(P_JOB_TYPE,NULL)||',
                                                        ''[^,]+'',
                                                        1,
                                                        LEVEL)
                                             JOB_TYPE_NO
                                    FROM DUAL
                              CONNECT BY REGEXP_SUBSTR ( '||NVL(P_JOB_TYPE,NULL)||',
                                                        ''[^,]+'',
                                                        1,
                                                        LEVEL)
                                             IS NOT NULL) JTYPE
                       WHERE     V.SALARY_NO = E.SALARY_NO
                             AND V.SALARY_NO = SA.SALARY_NO(+)
                             AND V.SALARY_NO = EOT.SALARY_NO(+)
                             AND V.SALARY_NO = P.SALARY_NO(+)
                             AND E.SALARY_BANK_NO = BN.BANKDTL_NO(+)
                             AND V.EMP_NO = C.EMP_NO(+)
                             AND V.EMP_NO = PS.EMP_NO(+)
                             AND NVL(E.FS_PAID_FLG,0) = 0
                             --AND NVL (E.ACTUAL_SAL_FLAG, 0) = 1
                             --AND E.JOB_TYPE_NO IN (1015000003, 1015000007, 1015000008)
                             AND NVL (V.JOB_TYPE, -1) = NVL (JTYPE.JOB_TYPE_NO, NVL (V.JOB_TYPE, -1))';



    -- ADD CONDITION
--AND NVL (E.ACTIVE_STAT, -1) = NVL ( :P_ACTIVE, NVL (E.ACTIVE_STAT, -1))
    IF P_ACTIVE IS NOT NULL
    THEN
        V_QUERY :=
               V_QUERY
            || ' AND NVL (E.ACTIVE_STAT, -1) = NVL ('
            || P_ACTIVE
            || ', NVL (E.ACTIVE_STAT, -1))';
    END IF;
--    AND V.SALSTART_DATE = NVL ( :P_START_DATE, V.SALSTART_DATE)
    IF P_START_DATE IS NOT NULL
    THEN
        V_QUERY :=
               V_QUERY
            || ' AND V.SALSTART_DATE =  NVL('''
            || P_START_DATE
            || ''', V.SALSTART_DATE)';
    END IF;

--AND V.SALEND_DATE = NVL ( :P_END_DATE, V.SALEND_DATE)
    IF P_END_DATE IS NOT NULL
    THEN
        V_QUERY :=
               V_QUERY
            || ' AND V.SALEND_DATE =  NVL('''
            || P_END_DATE
            || ''',V.SALEND_DATE)';
    END IF;
    
--    AND V.EMP_NO = NVL ( :P_EMP_NO, V.EMP_NO)
    IF P_EMP_NO IS NOT NULL
    THEN
        V_QUERY := V_QUERY || ' AND V.EMP_NO = NVL('||P_EMP_NO||', V.EMP_NO)';
    END IF;
--AND NVL (E.SALARY_BANK_NO, -1) = NVL ( :P_BANK_NO, NVL (E.SALARY_BANK_NO, -1))
    IF P_BANK_NO IS NOT NULL
    THEN
        V_QUERY :=
               V_QUERY
            || ' AND NVL (E.SALARY_BANK_NO, -1) = NVL ( '
            || P_BANK_NO
            || ', NVL (E.SALARY_BANK_NO, -1))';
    END IF;
    
--    AND NVL (V.HR_TYPE, -1) = NVL ( :p_hr_type, NVL (V.HR_TYPE, -1))
    IF P_HR_TYPE IS NOT NULL
    THEN
        V_QUERY :=
               V_QUERY
            || ' AND NVL (V.HR_TYPE, -1) = NVL ('
            || P_HR_TYPE
            || ', NVL (V.HR_TYPE, -1))';
    END IF;
    
--    AND V.JOBTITLE_NO = NVL ( :P_JOBTITLE_NO, V.JOBTITLE_NO)
    IF P_JOBTITLE_NO IS NOT NULL
    THEN
        V_QUERY :=
               V_QUERY
            || ' AND V.JOBTITLE_NO = NVL ( '
            || P_JOBTITLE_NO
            || ', V.JOBTITLE_NO)';
    END IF;

--AND NVL (E.DEFAULT_JOBLOC_NO, -1) = NVL ( :P_JOBLOC_NO, NVL (E.DEFAULT_JOBLOC_NO, -1))
    IF P_JOBLOC_NO IS NOT NULL
    THEN
        V_QUERY :=
               V_QUERY
            || ' AND NVL (E.DEFAULT_JOBLOC_NO, -1) = NVL ( '
            || P_JOBLOC_NO
            || ', NVL (E.DEFAULT_JOBLOC_NO, -1))';
    END IF;

--AND NVL (E.SALARY_BANK_ACC_NO, -1) = NVL ( :P_SALARY_BANK_ACC_NO, NVL (E.SALARY_BANK_ACC_NO, -1))
    IF P_SALARY_BANK_ACC_NO IS NOT NULL
    THEN
        V_QUERY :=
               V_QUERY
            || ' AND NVL (E.SALARY_BANK_ACC_NO, -1) = NVL ('
            || P_SALARY_BANK_ACC_NO
            || ', NVL (E.SALARY_BANK_ACC_NO, -1))';
    END IF;

--AND NVL (E.SAL_FROM_ACCOUNT_NO, -1) = NVL ( :P_SAL_FROM_ACCOUNT_NO, NVL (E.SAL_FROM_ACCOUNT_NO, -1))
    IF P_SAL_FROM_ACCOUNT_NO IS NOT NULL
    THEN
        V_QUERY :=
               V_QUERY
            || ' AND NVL (E.SAL_FROM_ACCOUNT_NO, -1) = NVL ('
            || P_SAL_FROM_ACCOUNT_NO
            || ', NVL (E.SAL_FROM_ACCOUNT_NO, -1))';
    END IF;

    IF P_LINE_NO IS NOT NULL
    THEN
        V_QUERY :=
               V_QUERY
            || ' AND NVL (E.LINE_NO, -1) = NVL ( '
            || P_LINE_NO
            || ', NVL (E.LINE_NO, -1))';
    END IF;

--AND NVL (E.FLOOR_NO, -1) = NVL ( :P_FLOOR_NO, NVL (E.FLOOR_NO, -1))
    IF P_FLOOR_NO IS NOT NULL
    THEN
        V_QUERY :=
               V_QUERY
            || ' AND NVL (E.FLOOR_NO, -1) = NVL ('
            || P_FLOOR_NO
            || ', NVL (E.FLOOR_NO, -1))';
    END IF;
    
--    AND E.BU_NO_ALL LIKE NVL (DECODE ( :P_BU_CHK_ALL, 1, :P_BU_NO_ALL || '%', :P_BU_NO_ALL), E.BU_NO_ALL)
    IF P_BU_NO_ALL IS NOT NULL
    THEN
        V_QUERY :=
               V_QUERY
            || 'AND E.BU_NO_ALL LIKE NVL (DECODE ( '
            || P_BU_CHK_ALL
            || ', 1, '
            || P_BU_NO_ALL
            || '''%'''
            || ','
            || P_BU_NO_ALL
            || '), E.BU_NO_ALL)';
    END IF;

--AND NVL (V.JOB_TYPE, -1) = NVL ( :P_JOB_TYPE, NVL (V.JOB_TYPE, -1))
    IF P_JOB_TYPE IS NOT NULL
    THEN
        V_QUERY :=
               V_QUERY
            || ' NVL (V.JOB_TYPE, -1) = NVL ( '
            || P_JOB_TYPE
            || ', NVL (V.JOB_TYPE, -1))';
    END IF;

-- AND NVL (V.SHIFT_NO, -1) = NVL ( :P_SHIFT_NO, NVL (V.SHIFT_NO, -1))
    IF P_SHIFT_NO IS NOT NULL
    THEN
        V_QUERY :=
               V_QUERY
            || 'AND NVL (V.SHIFT_NO, -1) = NVL ( '
            || P_SHIFT_NO
            || ', NVL (V.SHIFT_NO, -1))';
    END IF;
    
--AND NVL (V.EMP_TYPE_NO, -1) = NVL ( :P_EMP_TYPE_NO, NVL (V.EMP_TYPE_NO, -1))
    IF P_EMP_TYPE_NO IS NOT NULL
    THEN
        V_QUERY :=
               V_QUERY
            || '  NVL (E.EMP_TYPE, -1) = NVL ( '
            || P_EMP_TYPE_NO
            || ', NVL (E.EMP_TYPE, -1))';
    END IF;

--AND E.COMPANY_NO = NVL (DECODE ( :P_COMPANY_NO, 0, NULL, :P_COMPANY_NO), E.COMPANY_NO)
    IF P_COMPANY_NO IS NOT NULL
    THEN
        V_QUERY :=
               V_QUERY
            || ' AND E.COMPANY_NO = NVL (DECODE ( '
            || P_COMPANY_NO
            || ', 0, NULL, '
            || P_COMPANY_NO
            || '), E.COMPANY_NO)';
    END IF;

    IF P_END_DATE IS NOT NULL
    THEN
        V_QUERY :=
               V_QUERY
            || ' AND TO_DATE(E.JOIN_DATE,''DD-MON-RR'') <= '''
            || TO_DATE (P_END_DATE, 'DD-MON-RR')
            || ''') Q1)Q2)Q3';
    END IF;

    V_QUERY :=
           V_QUERY
        || ' WHERE CASE
         WHEN     UPPER ( '''||P_MODE||''') = ''CHEQUE''
              AND (NVL (Q3.NET_PAYABLE_COM, 0) * (NVL (Q3.CHEQUE_RATIO, 0) / 100)) IS NOT NULL
              AND (NVL (Q3.NET_PAYABLE_COM, 0) * (NVL (Q3.CASH_RATIO, 0) / 100)) IS NOT NULL
         THEN
             1
         WHEN     UPPER ( '''||P_MODE||''') = ''CASH''
              AND (NVL (Q3.NET_PAYABLE_COM, 0) * (NVL (Q3.CHEQUE_RATIO, 0) / 100)) IS NOT NULL
              AND (NVL (Q3.NET_PAYABLE_COM, 0) * (NVL (Q3.CASH_RATIO, 0) / 100)) IS NOT NULL
         THEN
             1
         WHEN     UPPER ( '''||P_MODE||''') = ''CASH-CHEQUE''
              AND (   (NVL (Q3.NET_PAYABLE_COM, 0) * (NVL (Q3.CHEQUE_RATIO, 0) / 100)) IS NOT NULL
                   OR (NVL (Q3.NET_PAYABLE_COM, 0) * (NVL (Q3.CASH_RATIO, 0) / 100)) IS NOT NULL)
         THEN
             1
         ELSE
             0
     END =
     1';

    V_QUERY :=
           V_QUERY
        || ' ORDER BY Q3.BU_NAME, Q3.JOBTITLE, Q3.EMP_ID';

    DBMS_OUTPUT.PUT_LINE (V_QUERY);

    K_SA_GEN_XLSX.NEW_SHEET;
    K_SA_GEN_XLSX.QUERY2SHEET (1,
                               5,
                               V_QUERY,
                               TRUE,
                               NULL,
                               NULL,
                               1,
                               FALSE,
                               V_NO_OF_REC);
    K_SA_GEN_XLSX.SAVE ('EXCEL_DIR', P_EXEL_NAME || '.XLSX');
END;
/
-- sql comment