//PFHSXK0X  JOB ('P94COMM'),'TESTER',
//       CLASS=A,MSGCLASS=R,NOTIFY=PFHSXK0,REGION=0M
/*JOBPARM S=*
//***   SPECIFY JOBCARD IN TOTALTEST PREFERENCES TO SUBSTITUTE
//*
//*** THE JOB CARD MUST INCLUDE A NOTIFY STATEMENT SUCH
//*** AS NOTIFY=&SYSUID and also a REGION=0M parameter
//*
//********************************************************************
//* Execute Target Runner under TSO using the DSN command
//*    and the RUN subcommand
//********************************************************************
//RUNBD2 EXEC PGM=IKJEFT01,REGION=0M
//*
//STEPLIB  DD DSN=SYS2.CW.&CWGACX..SLCXLOAD,DISP=SHR
//*  where MLCXnnn is MLCX170 OR HIGHER
//        DD DISP=SHR,DSN=SALESSUP.SXK1.DEV2.LOAD
//        DD  DISP=SHR,
//             DSN=DSNB10.SDSNLOAD
//         DD  DISP=SHR,
//             DSN=CEE.SCEERUN
//         DD  DISP=SHR,
//             DSN=IGY.SIGYCOMP
//*         DD  DISP=SHR,
//*             DSN=HSTJXL0.RVII.WEBCAST.LOAD
//SYSTSPRT  DD SYSOUT=*
//*       DD DISP=SHR,DSN=<COBOL RUNTIME LOADLIB>
//*
//*-----
//*-----
//*-----
//*      Optional
//*      Add your custom DD statements
//*EMPFILE   DD  DISP=SHR,DSN=HSTJXL0.WORKBNCH.LABS.EMPLOYEE
//EMPFILE   DD  DISP=SHR,DSN=HSTJXL0.RVIIDEMO.EMPFILE
//EMPSTAT   DD  DSN=&&STAT,DISP=(MOD,PASS),UNIT=SYSDA,
//            SPACE=(800,(500,500))
//SYSPRINT  DD  SYSOUT=*,TERM=TS
//SYSOUT    DD  SYSOUT=*,TERM=TS
//SYSUDUMP  DD  SYSOUT=*
//EMPFILE2  DD  DSN=SYS2.CW.XT.R1605.MLXT160.SLXTSAMP(CWXTDATA),
//            DISP=SHR
//EMPCHECK  DD  DSN=SYS2.CW.XT.R1605.MLXT160.SLXTSAMP(CWXTDATA),
//            DISP=SHR
//EMPINP    DD  DSN=HSTJXL0.WBIC.SALES.COMM,DISP=SHR
//SALES     DD  DSN=PFHSXK0.FASAMP.SALES,DISP=SHR
//RPTFILE2  DD  SYSOUT=X
//EMPOUT    DD  SYSOUT=*
//SYSHELP   DD  DISP=SHR,
//            DSN=DSNB10.SDSNEXIT
//SYSIN     DD  DUMMY
//SYSTSIN   DD  *
 DSN SYSTEM(DBCC)
 RUN PROGRAM(WBCI1206) PLAN(HSTJXL02) PARMS('/04')
/*
//