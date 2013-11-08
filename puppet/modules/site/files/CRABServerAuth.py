import cx_Oracle as DB
import socket
fqdn = socket.getfqdn().lower()
dbconfig = { dev:  { *:   { user: sysdba, dsn : devdb11, password : veryinsecure, timeout : 300, type : DB, trace : True, schema : CRAB_MMASCHER, 'clientid': sitedb-web@%s % fqdn, 'liveness': select sysdate from dual  } } }
