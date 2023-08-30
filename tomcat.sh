#!/bin/bash
# processname: Tomcat_init
#vars required: tomcat_user
                                  Tomcat_user_home
                                   Tc_process
                                    Tomcat_version

# variables
Tomcat_user= gopi
Tomcat_user_home=/home/gopi
Tc_process=org.apache.catalina
Tomcat_version=apache-tomcat-9.0.80

Catalina_home=${tomcat_user_home} / ${tomcat_version}
#echo ${CATALINA_HOME}
Shutdown_wait=60
Tomcat_pid() {
echo 'ps -ef | grep ${TC_PROCESS} | grep ${TOMCAT_USER_HOME} | awk '{print $2 }'
}
start
TC_PID=$(tomcat_pid)
if [ -n "${TC_PID}" ]
then
echo "${tomcat_user} is already running ${tc_process} (pid: ${tc_pid})"
else
Start tomcat
echo "starting ${tomcat_version} for ${tomcat_user}"
/bin/su - -c "sh ${catalina_home}/bin/Catalina.sh start"  $Tomcat_user
fi
Return 0
}
stop
Tc_pid=$(tomcat_pid)
if [ -n "${Tc_pid} ]
then
echo "stopping ${tomcat_version}" for ${tomcat_user}"
/bin/su - -c "sh ${catalina_home}/bin/Catalina.sh stop"  $Tomcat_user
Let kwait=$shutdown_wait
Count=0
Count_by=5
until [ 'ps -p ${Tc_pid}' == '0' ] || [ $count -gt $kwait ]
do 
echo "waiting for processes to exit. Timeout before we kill the pid:
${count}/${kwait}"
Sleep $Count_by
let count=$count_by
done
if [ $count -gt $kwait ]; then
echo "killing processes which didn't stop after ${Shutdown_wait} seconds"
kill -9 ${Tc_pid}
fi
else 
Echo "${tomcat_version} is not running for ${tomcat_user}"
Kill -9 ${Tc_pid}
fi
else
echo "${tomcat_version} is not running for ${tomcat_user}"
fi
return 0
}
case $1 in
start) 
start
;;
restart)
Stop
Start
;;
Status)

Tc_pid = $(tomcat_pid)
If [ -n "${Tc_pid}" ]
then
Echo " ${tomcat_version} for 
${tomcat_user} is running with pid: ${Tc_pid}"
else
echo "${tomcat_version} is not running for ${tomcat_user}"
fi
;;
*)
echo $"usage: $0 {start|stop|restart|status}"
;;
esac
exit 0