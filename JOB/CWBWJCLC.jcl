//PFHSXK0X JOB (MMC),'PFHSXK0X',CLASS=L,
//  MSGCLASS=X,MSGLEVEL=(1,1),NOTIFY=PFHSXK0                            00020002
//*                                                                     00000203
//*JOBPARM S=CWCC
//* *******************************************************************
//*
//*  INSTRUCTIONS:
//*  =============
//*
//*  1) C ALL #APL      TO YOUR APPLICATION CODE
//*  2) C ALL #LVL      TO THE LEVEL YOUR PROGRAM IS CURRENTLY AT
//*  3) C ALL #USERID   TO YOUR USERID
//*  4) C ALL #YYMMDD TO YYMMDD   <== CHG TO CURRENT DATE
//*  5) SUB
//*
//* *******************************************************************
//*
//*   EXECUTION JCL FOR COBOL DEMO PROGRAM CWBWCOBX
//*
//CWBWCOBX EXEC PGM=CWBWCOBX,PARM='00003,190123'
//STEPLIB  DD   DSN=CEE.SCEERUN,DISP=SHR
//         DD   DISP=SHR,DSN=SALESSUP.SXK1.DEV1.LOAD
//EMPFILE  DD   DSN=SYS2.CW.&CWGAXT..SLXTSAMP(CWXTDATA),
//         DISP=SHR
//RPTFILE  DD   SYSOUT=X
//SYSOUT   DD   SYSOUT=X
//