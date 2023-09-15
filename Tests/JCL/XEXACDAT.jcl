//XEXACDA1 JOB (TOPAZ),'ACC DATE',MSGCLASS=X,
//    MSGLEVEL=(1,1),NOTIFY=&SYSUID,
//    CLASS=A
//*   EXECUTE XEXACDAT IN BATCH
//*
//S1    EXEC  PGM=SORT                 
//SYSOUT    DD  SYSOUT=*               
//SORTIN DD *                           
 DUMMY                                 
/*                                     
//SORTOUT DD  SYSOUT=*                 
//SYSIN    DD    *                     
  SORT FIELDS=COPY                     
  OUTFIL REMOVECC,NODETAIL,             
  HEADER1=(DATE=(MDY/))
/*  