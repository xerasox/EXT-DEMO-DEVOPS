      * EMPLOYEE-WORK-AREA DESCRIPTION
           05  (X)-EMP-NUM            PIC 9(5).
           05  (X)-EMP-TYPE           PIC X.
               88  HOURLY             VALUE 'H'.
               88  SALES              VALUE 'S'.
               88  MANAGEMENT         VALUE 'M'.
           05  (X)-EMP-REGION         PIC 9.
               88  NORTH              VALUE 1.
               88  SOUTH              VALUE 2.
               88  EAST               VALUE 3.
               88  WEST               VALUE 4.
           05  (X)-EMP-NAME           PIC X(15).
           05  (X)-EMP-ADDRESS.
               10  (X)-EMP-STREET     PIC X(15).
               10  (X)-EMP-CITY       PIC X(8).
               10  (X)-EMP-STATE      PIC XX.
               10  (X)-EMP-ZIP        PIC X(9).
           05  (X)-HOURLY-EMPLOYEE-DATA.
               10  (X)-EMP-HOURS      PIC 9(2).
               10  (X)-EMP-RATE       PIC 9(3)V99     COMP-3.
               10  FILLER             PIC X(8).
           05  (X)-SALES-EMPLOYEE-DATA   REDEFINES
                                        (X)-HOURLY-EMPLOYEE-DATA.
               10  (X)-SALES-SALARY   PIC 9(5)V99     COMP-3.
               10  (X)-SALES-AMOUNT   PIC 9(5)V99.
               10  FILLER             PIC X(2).
           05  (X)-MGMT-EMPLOYEE-DATA   REDEFINES
                                        (X)-SALES-EMPLOYEE-DATA.
               10  (X)-MGMT-SALARY    PIC 9(5)V99     COMP-3.
               10  FILLER             PIC X(9).
           05  (X)-EMP-HIRE-DATE.
               10  (X)-EMP-HIRE-YY    PIC 9(2).
               10  (X)-EMP-HIRE-MM    PIC 9(2).
               10  (X)-EMP-HIRE-DD    PIC 9(2).
           05  FILLER                 PIC X(5).