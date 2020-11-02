//ALLOCZFS JOB (MVSS,68L6,9,9),'ALLOCZFS',MSGCLASS=A,CLASS=A,           00010000
//    NOTIFY=&SYSUID                                                    00011000
//DEFINE  EXEC PGM=IDCAMS                                               00012000
//SYSPRINT DD SYSOUT=*                                                  00013000
//SYSUDUMP DD SYSOUT=*                                                  00014000
//AMSDUMP DD SYSOUT=*                                                   00015000
//SYSIN DD *                                                            00016000
  DEFINE CLUSTER (NAME(SUPT.OMVS.ZD00.APPL.MVSSUPT) -                   00017000
  LINEAR TRACKS(10 15) SHAREOPTIONS(2)                                  00018000
/*                                                                      00019000
//FORMAT  EXEC PGM=IOEAGFMT,                                            00020000
// PARM=('-aggregate SUPT.OMVS.ZD00.APPL.MVSSUPT -compat')              00030000
//SYSPRINT DD SYSOUT=*                                                  00040000
/*                                                                      00050000
