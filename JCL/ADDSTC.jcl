//USERIDAJ JOB (MVSS,ROOM,999,999),'RFAPBAT SLT0',                              
//             NOTIFY=&SYSUID,TIME=1440                                         
// JCLLIB  ORDER=SUPT.RACF.PROCLIB                                              
//STEP1    EXEC RFAPBAT                                                         
//SYSIN    DD   *                                                               
ADD JOB OMIITOM SUPT ALTER                                                      
LIST JOB OMIITOM                                                                
/*                                                                              
