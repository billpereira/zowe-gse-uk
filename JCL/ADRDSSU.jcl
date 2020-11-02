//USERIDXX JOB (MVSS,ROOM,999,999),ADRDSSU,MSGCLASS=H,SCHENV=ZD00,              
//             NOTIFY=&SYSUID,TIME=NOLIMIT                                      
//*-------------------------------------------------------------------*         
//*   This job uses DFSMSdss to print DASD VTOC, tracks, or datasets. *         
//*-------------------------------------------------------------------*         
//DSSPRINT EXEC PGM=ADRDSSU,PARM='UTILMSG=YES,ABEND=476'                        
//INPUT    DD UNIT=SYSALLDA,VOL=SER=xxxxxx,DISP=SHR                             
//SYSPRINT DD SYSOUT=*                  OUTDDNAME(SYSPRINT) is default          
//SYSMDUMP DD DISP=SHR,DSN=SYS1.DUMP00                                          
//*ENQVTOC DD DUMMY <----- Only if long SYSVTOC ENQ for integrity -----         
//NOTIFY#  DD DUMMY                                                             
//*-------------------------------------------------------------------*         
//*  PRINT INDDNAME(INPUT)  TRACKS(X'025C',X'0000',X'025C',X'0001')             
//*  PRINT INDDNAME(INPUT)  DATASET(SYSD.LOAD)                                  
//*  RELEASE DDNAME(INPUT)  INCLUDE(**)                                         
//*  RELEASE DDNAME(INPUT)  INCLUDE(**) MINSECQTY(0)                            
//*  COPY FULL ALLEXCP INDD(volser) OUTDD(volser) COPYV                         
//*  COPY DATASET(INCLUDE(LH9445.TEST)) -                                       
//*       INDYNAM (xxxxxx) -                                                    
//*       OUTDYNAM(yyyyyy) -                                                    
//*       DELETE RECATALOG(*)                                                   
//*  DUMP TRACKS(X'0001',X'0000',X'025C',X'000E') -                             
//*                INDDNAME(volser) OUTDDNAME(volser)                           
//*  DUMP FULL INDDNAME(DASD) OUTDDNAME(TAPE) COMPRESS                          
//*-------------------------------------------------------------------*         
//SYSIN    DD *                                                                 
     PRINT INDDNAME(INPUT)  TRACKS(X'0010',X'0001',X'0013',X'000D')             
/*                                                                              
//*-------------------------------------------------------------------*         
//*                                                                   *         
//* PARM='ABEND=nnn,               Abend if message ADRnnnx           *         
//*       AMSGCNT=nnnn,      (1)   Abend on nnnn occurrence           *         
//*                                      of message ADRnnnx           *         
//*       DEBUG=FRMSG,             Fast replication messages          *         
//*       LINECNT=nnnn,      (60)  Lines per page                     *         
//*       PAGENO=nnnn,       (1)   Starting page number               *         
//*      #RACFLOG=YES,             RACF logging for all functions     *         
//*       SDUMP=nnn,               SVCDUMP if ADRnnnx message         *         
//*       SIZE=nnnnK,              Storage to be used                 *         
//*       SMSGCNT=nnnn,            SVCDUMP on specified occurrence    *         
//*                                      of message ADRnnnx           *         
//*       TMPMSGDS=YES|NO          Temporary SYSPRINT data set        *         
//*                    --                                             *         
//*       TRACE=YES,               Print relocated DEFRAG extents     *         
//*       TYPRUN=SCAN              Control record syntax checking     *         
//*             |NORUN,            No process but print reports       *         
//*       USEEXCP=YES|NO,          Use EXCP for DUMP, RESTORE, and 1C0*         
//*                                COPYDUMP. Default for tape: NO  1C0*         
//*                                          Default for DASD: YES 1C0*         
//*       UTILMSG=NO|YES           Print invoked utility messages     *         
//*              |ERROR,                 only if error situations     *         
//*               -----                                               *         
//*       WORKUNIT=esoteric        DASD esoteric or generic name,     *         
//*               |generic         or DASD device number to be used   *         
//*               |xxxx,           for DYNALLOC temproary data sets   *         
//*       WORKVOL=volser,          DASD volser for temp DYNALLOC      *         
//*       XABUFF=ABOVE16|BELOW16,  I/O buffers location               *         
//*              -------                                              *         
//*       ZBUFF64R=YES|NO          Buffers use 64-bit real storage 150*         
//*                ---                                             150*         
//*-------------------------------------------------------------------*         
//* PRINT  INDDNAME(X)  VTOC(1,9999)                                  *         
//* PRINT  INDDNAME(X)  DATASET(DSN)                                  *         
//* PRINT  INDDNAME(X)  TRACKS(X'CCCC',X'HHHH',X'CCCC',X'HHHH')       *         
//*                                                                   *         
//*        INDYNAM(VOLSER) - USE INSTEAD OF INDDAME FOR DYNALLOC.     *         
//*                                                                   *         
//*  OPTIONAL KEYWORDS THAT CAN BE USED WITH 'DATASET':               *         
//*        ALLDATA                                                    *         
//*        DATALENGTH(N)   - SPECIFY IF COUNT FIELD HAS DATA CHECKS.  *         
//*        DYNALLOC                                                   *         
//*        ERRORTRACKS     - ONLY PRINT TRACKS THAT HAVE DATA CHECKS. *         
//*        KEYLENGTH(N)    - SPECIFY IF COUNT FIELD HAS DATA CHECKS.  *         
//*        OUTDDNAME(X)                                               *         
//*        PASSWORD(DDNAME)                                           *         
//*               |(DSN/PSWD ,...)                                    *         
//*        SHARE                                                      *         
//*        TOLERATE(IOERROR|ENQFAILURE)                               *         
//*        WAIT(SECONDS,RETRIES)                                      *         
//*                                                                   *         
//*  OPTIONAL KEYWORDS THAT CAN BE USED WITH 'TRACKS' AND 'VTOC':     *         
//*        DATALENGTH(N)   - SPECIFY IF COUNT FIELD HAS DATA CHECKS.  *         
//*        ERRORTRACKS     - ONLY PRINT TRACKS THAT HAVE DATA CHECKS. *         
//*        KEYLENGTH(N)    - SPECIFY IF COUNT FIELD HAS DATA CHECKS.  *         
//*        OUTDDNAME(X)                                               *         
//*        PASSWORD(DDNAME)                                           *         
//*               |(DSN/PSWD ,...)                                    *         
//*        TOLERATE(IOERROR|ENQFAILURE)                               *         
//*        WAIT(SECONDS,RETRIES)                                      *         
//*                                                                   *         
//*-------------------------------------------------------------------*         
//* COMPRESS FILTERDD(DDNAME)                                         *         
//*        INCLUDE(DSNAME,...)                                        *         
//*        EXCLUDE(DSNAME,...)                                        *         
//*        BY((ALLOC,EQ|NE,CYL|TRK,BLK,ABSTR,MOV),...)                *         
//*           (CATLG,EQ,YES|NO),...)                                  *         
//*           (CREDT,LT|GT|EQ|NE|GE|LE,YYDDD),...)                    *         
//*           (EXPDT,LT|GT|EQ|NE|GE|LE,YYDDD),...)                    *         
//*           (REFDT,LT|GT|EQ|NE|GE|LE,YYDDD),...)                    *         
//*           (DSCHA,EQ,YES|NO),...)                                  *         
//*           (DSORG,EQ|NE,PAM)                                       *         
//*           (EXTNT,LT|GT|EQ|NE|GE|LE,NNNNN),...)                    *         
//*           (FSIZE,LT|GT|EQ|NE|GE|LE,NNNNN),...)                    *         
//*           (MULTI,EQ,YES|NO),...)                                  *         
//*        DDNAME(DDNAME,...)                                         *         
//*        DYNAM((VOLSER,UNIT),...)                                   *         
//*                                                                   *         
//*  OPTIONAL KEYWORDS:                                               *         
//*        DYNALLOC                                                   *         
//*        PASSWORD(DDNAME)                                           *         
//*               |(DSN/PSWD ,...)                                    *         
//*        WAIT(SECONDS,RETRIES)                                      *         
//*-------------------------------------------------------------------*         
//* CONVERTV SMS                                                      *         
//*          NOSMS                                                    *         
//*           ALLMULTI                                                *         
//*          PREPARE                                                  *         
//*          TEST                                                     *         
//*        DDNAME(DDNAME,...)                                         *         
//*        DYNAM((VOLSER,UNIT),...)                                   *         
//*                                                                   *         
//*  OPTIONAL KEYWORDS WITH SMS:                                      *         
//*          CATALOG                                                  *         
//*           INCAT(CATNAME)                                          *         
//*          ALLMULTI                                                 *         
//*          REDETERMINE                                              *         
//*-------------------------------------------------------------------*         
//* COPY   FULL                                                       *         
//*        TRACKS(X'CCCC',X'HHHH',X'CCCC',X'HHHH')                    *         
//*        INDDNAME(DDNAME)                                           *         
//*        INDYNAM(VOLSER ,UNIT)                                      *         
//*        OUTDDNAME(DDNAME)                                          *         
//*        OUTDYNAM(VOLSER ,UNIT)                                     *         
//*                                                                   *         
//*  OPTIONAL KEYWORDS THAT CAN BE USED WITH 'FULL':                  *         
//*        ALLDATA (DSN ,... | *)                                     *         
//*        ALLEXCP                                                    *         
//*        CANCELERROR                                                *         
//*        CONCURRENT                                              110*         
//*        COPYVOLID                                                  *         
//*        DEBUG(FRMSG(MINIMAL|SUMMARIZED|DETAILED))               140*         
//*        FASTREPLICATION(REQUIRED|PREFERRED|NONE)                140*         
//*        FCNOCOPY                                                140*         
//*        PASSWORD(DDNAME)                                           *         
//*               |(DSN/PSWD ,...)                                    *         
//*               |(CATNAME/PSWD ,...)                                *         
//*        PURGE                                                      *         
//*        READIOPACING(NNN)                                       110*         
//*        TOLERATE(IOERROR)                                          *         
//*        WAIT(SECONDS,RETRIES)                                      *         
//*        WRITECHECK                                                 *         
//*                                                                   *         
//*  OPTIONAL KEYWORDS THAT CAN BE USED WITH 'TRACKS':                *         
//*        CANCELERROR                                                *         
//*        CONCURRENT                                              110*         
//*        COPYVOLID                                                  *         
//*        DEBUG(FRMSG(MINIMAL|SUMMARIZED|DETAILED))               140*         
//*        FASTREPLICATION(REQUIRED|PREFERRED|NONE)                140*         
//*        FCNOCOPY                                                140*         
//*        OUTTRACKS((X'CCCC',X'HHHH',X'CCCC',X'HHHH'),...)           *         
//*        PASSWORD(DDNAME)                                           *         
//*               |(DSN/PSWD ,...)                                    *         
//*               |(CATNAME/PSWD ,...)                                *         
//*        PURGE                                                      *         
//*        READIOPACING(NNN)                                       110*         
//*        TOLERATE(IOERROR)                                          *         
//*        WAIT(SECONDS,RETRIES)                                      *         
//*        WRITECHECK                                                 *         
//*                                                                   *         
//*  OPTIONAL KEYWORDS THAT CAN BE USED WITH 'DATASET':               *         
//*        ALLDATA (DSN ,... | *)                                     *         
//*        ALLEXCP                                                    *         
//*        ALLMULTI                                                   *         
//*        AUTOREBLOCKADDRESS                                         *         
//*        BYPASSACS(DSNAME)                                          *         
//*        CANCELERROR                                                *         
//*        CATALOG                                                    *         
//*        CONCURRENT                                              110*         
//*         NOTIFYCONCURRENT                                       110*         
//*        CONVERT(PDSE(DSN),...)                                     *         
//*        DEBUG(FRMSG(MINIMAL|SUMMARIZED|DETAILED))               140*         
//*        DELETE                                                     *         
//*        DYNALLOC                                                   *         
//*        FASTREPLICATION(REQUIRED|PREFERRED|NONE)                140*         
//*        FCNOCOPY                                                140*         
//*        FORCE                                                      *         
//*        FREESPACE(NN ,NN)                                          *         
//*        INCAT(CATNAME)                                             *         
//*         ALLMULTI                                                  *         
//*        LOGINDDNAME(DDNAME,...)                                    *         
//*        LOGINDYNAM((VOLSER ,UNIT) ,...)                            *         
//*        MENTITY(MODELDSN) MVOLSER(VOLSER)                          *         
//*        MGMTCLAS(MGMT-CLASS-NAME)                                  *         
//*         |NULLMGMTCLAS                                             *         
//*        NOPACKING(DSN)                                             *         
//*        PASSWORD(DDNAME)                                           *         
//*               |(DSN/PSWD ,...)                                    *         
//*               |(CATNAME/PSWD ,...)                                *         
//*        PERCENTUTILIZED(N,...)                                     *         
//*        PROCESS(SYS1 ,UNDEFINEDSORG)                               *         
//*        PURGE                                                      *         
//*        READIOPACING(NNN)                                       110*         
//*        REBLOCK(DSNAME,...)                                        *         
//*        REBLOCKADDRESS(DSNAME,...)                                 *         
//*        RECATALOG(NEWCATNAME|*)                                    *         
//*        RENAMEUNCONDITIONAL(PREFIX)                                *         
//*                           ((OLDNAME,NEWNAME),...)                 *         
//*                           ((PREFIX),(OLDNAME,NEWNAME),...)        *         
//*        REPLACE                                                    *         
//*        SHARE                                                      *         
//*        SPHERE                                                     *         
//*        STORCLAS(STORAGE-CLASS-NAME)                               *         
//*         |NULLSTORCLAS                                             *         
//*        TGTALLOC(BLK|CYL|TRK|SOURCE|SRC)                           *         
//*        TGTGDS(DEFERRE|ACTIVE|ROLLEDOFF|SOURCE|SRC)                *         
//*        TOLERATE(IOERROR)                                          *         
//*        TOLERATE(ENQFAILURE)                                       *         
//*        TRACKOVERFLOW(DSNAME,...)                                  *         
//*        TTRADDRESS(DSNAME,...)                                     *         
//*        UNCATALOG                                                  *         
//*        WAIT(SECONDS,RETRIES)                                      *         
//*        WRITECHECK                                                 *         
//*-------------------------------------------------------------------*         
//* COPYDUMP                                                          *         
//*        INDDNAME(DDNAME)                                           *         
//*        OUTDDNAME(DDNAME)                                          *         
//*                                                                   *         
//*  OPTIONAL PARMS:                                                  *         
//*        LOGICALVOLUME(VOLSER ,...)                                 *         
//*-------------------------------------------------------------------*         
//* DEFRAG DDNAME(DDNAME)                                             *         
//*        DYNAM(VOLSER ,UNIT)                                        *         
//*                                                                   *         
//*  OPTIONAL PARMS:                                                  *         
//*        DYNALLOC                                                   *         
//*        BY(LIST(ALLOC,EQ|NE,CYL|TRK,BLK,ABSTR,MOV),...)            *         
//*               (CATLG,EQ,YES|NO),...)                              *         
//*               (CREDT,LT|GT|EQ|NE|GE|LE,YYDDD),...)                *         
//*               (EXPDT,LT|GT|EQ|NE|GE|LE,YYDDD),...)                *         
//*               (REFDT,LT|GT|EQ|NE|GE|LE,YYDDD),...)                *         
//*               (DSCHA,EQ,YES|NO),...)                              *         
//*               (DSORG,EQ|NE,SAM|PAM|BDAM|ISAM|VSAM|EXCP),...)      *         
//*               (EXTNT,LT|GT|EQ|NE|GE|LE,NNNNN),...)                *         
//*               (FSIZE,LT|GT|EQ|NE|GE|LE,NNNNN),...)                *         
//*               (MULTI,EQ,YES|NO),...)                              *         
//*        DEBUG(FRMSG(MINIMAL|SUMMARIZED|DETAILED))               140*         
//*        EXCLUDE (LIST(DSNAME ,...))                                *         
//*                (DDNAME(DDNAME ,...)                               *         
//*        FASTREPLICATION(REQUIRED|PREFERRED|NONE)                140*         
//*        FRAGMENTATIONINDEX(N)                                      *         
//*        MAXMOVE(N ,N)                                              *         
//*        PASSDELAY(NNNN)                                            *         
//*        PASSWORD(DDNAME)                                           *         
//*               |(DSN/PSWD ,...)                                    *         
//*        WAIT(SECONDS,RETRIES)                                      *         
//*-------------------------------------------------------------------*         
//* DUMP   FULL                                                       *         
//*        TRACKS(X'CCCC',X'HHHH',X'CCCC',X'HHHH')                    *         
//*        DATASET(FILTER(DDNAME))                                    *         
//*        DATASET(INCLUDE(DSNAME))                                   *         
//*        DATASET(EXCLUDE(DSNAME))                                   *         
//*        DATASET(BY((ALLOC,EQ|NE,CYL|TRK,BLK,ABSTR,MOV),...)        *         
//*                   (CATLG,EQ,YES|NO),...)                          *         
//*                   (CREDT,LT|GT|EQ|NE|GE|LE,YYDDD),...)            *         
//*                   (EXPDT,LT|GT|EQ|NE|GE|LE,YYDDD),...)            *         
//*                   (REFDT,LT|GT|EQ|NE|GE|LE,YYDDD),...)            *         
//*                   (DSCHA,EQ,YES|NO),...)                          *         
//*                   (DSORG,EQ|NE,SAM|PAM|BDAM|ISAM|VSAM|EXCP),.)    *         
//*                   (EXTNT,LT|GT|EQ|NE|GE|LE,NNNNN),...)            *         
//*                   (FSIZE,LT|GT|EQ|NE|GE|LE,NNNNN),...)            *         
//*                   (MULTI,EQ,YES|NO),...)                          *         
//*        INDDNAME(DDNAME)                                           *         
//*        INDYNAM(VOLSER ,UNIT)                                      *         
//*        OUTDDNAME(DDNAME)                                          *         
//*                                                                   *         
//*  OPTIONAL KEYWORDS THAT CAN BE USED WITH 'FULL':                  *         
//*        ALLDATA (DSN ,... | *)                                     *         
//*        ALLEXCP                                                    *         
//*        CANCELERROR                                                *         
//*        COMPRESS                                                   *         
//*        CONCURRENT                                              110*         
//*        FCWITHDRAW                                              140*         
//*        OPTIMIZE(N)                                                *         
//*        PASSWORD(DDNAME)                                           *         
//*               |(DSN/PSWD ,...)                                    *         
//*               |(CATNAME/PSWD ,...)                                *         
//*        READIOPACING(NNN)                                       110*         
//*        RESET                                                      *         
//*        TOLERATE(IOERROR)                                          *         
//*        TRACKOVERFLOW(DSN,...)                                     *         
//*        WAIT(SECONDS,RETRIES)                                      *         
//*                                                                   *         
//*  OPTIONAL KEYWORDS THAT CAN BE USED WITH 'TRACKS':                *         
//*        CANCELERROR                                                *         
//*        COMPRESS                                                   *         
//*        CONCURRENT                                              110*         
//*        FCWITHDRAW                                              140*         
//*        OPTIMIZE(N)                                                *         
//*        PASSWORD(DDNAME)                                           *         
//*               |(DSN/PSWD ,...)                                    *         
//*               |(CATNAME/PSWD ,...)                                *         
//*        READIOPACING(NNN)                                       110*         
//*        TOLERATE(IOERROR)                                          *         
//*        TRACKOVERFLOW(DSN,...)                                     *         
//*        WAIT(SECONDS,RETRIES)                                      *         
//*                                                                   *         
//*  OPTIONAL KEYWORDS THAT CAN BE USED WITH 'DATASET':               *         
//*        ALLDATA (DSN ,... | *)                                     *         
//*        ALLEXCP                                                    *         
//*        ALLMULTI                                                   *         
//*        CANCELERROR                                                *         
//*        COMPRESS                                                   *         
//*        CONCURRENT                                              110*         
//*         NOTIFYCONCURRENT                                       110*         
//*        DELETE                                                     *         
//*        DYNALLOC                                                   *         
//*        FCWITHDRAW                                              140*         
//*        INCAT(CATNAME)                                             *         
//*         ALLMULTI                                                  *         
//*        LOGINDDNAME(DDNAME,...)                                    *         
//*        LOGINDYNAM((VOLSER ,UNIT) ,...)                            *         
//*        OPTIMIZE(N)                                                *         
//*        PASSWORD(DDNAME)                                           *         
//*               |(DSN/PSWD ,...)                                    *         
//*               |(CATNAME/PSWD ,...)                                *         
//*        PURGE                                                      *         
//*        READIOPACING(NNN)                                       110*         
//*        RESET                                                      *         
//*        SHARE                                                      *         
//*        SPHERE                                                     *         
//*        TOLERATE(IOERROR)                                          *         
//*        TOLERATE(ENQFAILURE)                                       *         
//*        UNCATALOG                                                  *         
//*        VALIDATE|NOVALIDATE                                     110*         
//*        WAIT(SECONDS,RETRIES)                                      *         
//*-------------------------------------------------------------------*         
//* RELEASE FILTERDD(DDNAME)                                          *         
//*        INCLUDE(DSNAME,...)                                        *         
//*        EXCLUDE(DSNAME,...)                                        *         
//*        BY((ALLOC,EQ|NE,CYL|TRK,BLK,ABSTR,MOV),...)                *         
//*           (CATLG,EQ,YES|NO),...)                                  *         
//*           (CREDT,LT|GT|EQ|NE|GE|LE,YYDDD),...)                    *         
//*           (EXPDT,LT|GT|EQ|NE|GE|LE,YYDDD),...)                    *         
//*           (REFDT,LT|GT|EQ|NE|GE|LE,YYDDD),...)                    *         
//*           (DSCHA,EQ,YES|NO),...)                                  *         
//*           (DSORG,EQ|NE,SAM|PAM|BDAM|ISAM|VSAM|EXCP),...)          *         
//*           (EXTNT,LT|GT|EQ|NE|GE|LE,NNNNN),...)                    *         
//*           (FSIZE,LT|GT|EQ|NE|GE|LE,NNNNN),...)                    *         
//*           (MULTI,EQ,YES|NO),...)                                  *         
//*        DDNAME(DDNAME,...)                                         *         
//*        DYNAM((VOLSER,UNIT),...)                                   *         
//*                                                                   *         
//*  OPTIONAL KEYWORDS:                                               *         
//*        DYNALLOC                                                   *         
//*        MINSECQTY(N)                                               *         
//*        MINTRACKSUNUSED(N)                                         *         
//*        PASSWORD(DDNAME)                                           *         
//*               |(DSN/PSWD ,...)                                    *         
//*        WAIT(SECONDS,RETRIES)                                      *         
//*-------------------------------------------------------------------*         
//* RESTORE FULL                                                      *         
//*        TRACKS(X'CCCC',X'HHHH',X'CCCC',X'HHHH')                    *         
//*        DATASET(FILTER(DDNAME))                                    *         
//*        DATASET(INCLUDE(DSNAME))                                   *         
//*        DATASET(EXCLUDE(DSNAME))                                   *         
//*        DATASET(BY((ALLOC,EQ|NE,CYL|TRK,BLK,ABSTR,MOV),...)        *         
//*                   (CATLG,EQ,YES|NO),...)                          *         
//*                   (CREDT,LT|GT|EQ|NE|GE|LE,YYDDD),...)            *         
//*                   (EXPDT,LT|GT|EQ|NE|GE|LE,YYDDD),...)            *         
//*                   (REFDT,LT|GT|EQ|NE|GE|LE,YYDDD),...)            *         
//*                   (DSCHA,EQ,YES|NO),...)                          *         
//*                   (DSORG,EQ|NE,SAM|PAM|BDAM|ISAM|VSAM|EXCP),.)    *         
//*                   (EXTNT,LT|GT|EQ|NE|GE|LE,NNNNN),...)            *         
//*                   (FSIZE,LT|GT|EQ|NE|GE|LE,NNNNN),...)            *         
//*                   (MULTI,EQ,YES|NO),...)                          *         
//*        INDDNAME(DDNAME)                                           *         
//*        INDYNAM(VOLSER ,UNIT)                                      *         
//*        OUTDDNAME(DDNAME)                                          *         
//*                                                                   *         
//*  OPTIONAL KEYWORDS THAT CAN BE USED WITH 'FULL':                  *         
//*        CANCELERROR                                                *         
//*        COPYVOLID                                                  *         
//*        PASSWORD(DDNAME)                                           *         
//*               |(DSN/PSWD ,...)                                    *         
//*               |(CATNAME/PSWD ,...)                                *         
//*        PURGE                                                      *         
//*        WAIT(SECONDS,RETRIES)                                      *         
//*        WRITECHECK                                                 *         
//*                                                                   *         
//*  OPTIONAL KEYWORDS THAT CAN BE USED WITH 'TRACKS':                *         
//*        CANCELERROR                                                *         
//*        COPYVOLID                                                  *         
//*        OUTTRACKS((X'CCCC',X'HHHH',X'CCCC',X'HHHH'),...)           *         
//*        PASSWORD(DDNAME)                                           *         
//*               |(DSN/PSWD ,...)                                    *         
//*               |(CATNAME/PSWD ,...)                                *         
//*        PURGE                                                      *         
//*        WAIT(SECONDS,RETRIES)                                      *         
//*        WRITECHECK                                                 *         
//*                                                                   *         
//*  OPTIONAL KEYWORDS THAT CAN BE USED WITH 'DATASET':               *         
//*        BYPASSACS(DSNAME)                                          *         
//*        CANCELERROR                                                *         
//*        CATALOG                                                    *         
//*        DELETECATALOGENTRY                                         *         
//*        DYNALLOC                                                   *         
//*        FORCE                                                      *         
//*        FREESPACE(NN ,NN)                                          *         
//*        IMPORT                                                     M         
//*        LOGICALVOLUME(VOLSER)                                      *         
//*        MENTITY(MODELDSN) MVOLSER(VOLSER)                          *         
//*        MGMTCLAS(MGMT-CLASS-NAME)                                  *         
//*         |NULLMGMTCLAS                                             *         
//*        NOPACKING(DSN,...)                                         *         
//*        OUTDDNAME(DDNAME,...)                                      *         
//*        OUTDYNAM((VOLSER,UNIT),...)                                *         
//*        PASSWORD(DDNAME)                                           *         
//*               |(DSN/PSWD ,...)                                    *         
//*               |(CATNAME/PSWD ,...)                                *         
//*        PERCENTUTILIZED(N,...)                                     *         
//*        PROCESS(UNDEFINEDSORG)                                     *         
//*        RECATALOG(NEWCATNAME|*)                                    *         
//*        RENAMEUNCONDITIONAL(PREFIX)                                *         
//*                           ((OLDNAME,NEWNAME),...)                 *         
//*                           ((PREFIX),(OLDNAME,NEWNAME),...)        *         
//*        REBLOCK                                                    *         
//*        REPLACE                                                    *         
//*        SHARE                                                      *         
//*        SPHERE                                                     *         
//*        STORCLAS(STORAGE-CLASS-NAME)                               *         
//*         |NULLSTORCLAS                                             *         
//*        TGTALLOC(BLK|CYL|TRK|SOURCE|SRC)                           *         
//*        TGTGDS(DEFERRE|ACTIVE|ROLLEDOFF|SOURCE|SRC)                *         
//*        TOLERATE(ENQFAILURE)                                       *         
//*        TTRADDRESS(DSNAME,...)                                     *         
//*        WAIT(SECONDS,RETRIES)                                      *         
//*        WRITECHECK                                                 *         
//*-------------------------------------------------------------------*         
