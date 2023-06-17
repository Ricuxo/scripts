DEFINE MACHINE = '&MACHINE';
DEFINE USERNAME = '&USERNAME';  


SET LINESIZE 500
SET PAGESIZE 1000

COLUMN username FORMAT A15
COLUMN service_name FORMAT A15
COLUMN module FORMAT A45
COLUMN machine FORMAT A30
COLUMN logon_time FORMAT A30
COLUMN blocking_session  FORMAT A20

SELECT s.username,
       s.sid,
       s.serial#,
       s.status,
       s.service_name,
       s.machine,
       TO_CHAR(s.logon_Time,'DD-MON-YYYY HH24:MI:SS') AS logon_time,
       s.module,
       s.blocking_session 
FROM   gv$session s
WHERE s.TYPE <> 'BACKGROUND'
AND s.username IS NOT NULL
AND s.machine LIKE upper(NVL2('&MACHINE','%&MACHINE%','%'))
AND s.username LIKE upper(NVL2('&USERNAME','%&USERNAME%','%'))
ORDER BY logon_time;

UNDEFINE MACHINE
UNDEFINE USERNAME