#!/bin/sh

host=����SMTP������
sender=����������
password=��������
receiver=�ʼ������˵�ַ���ö��Ÿ���

#echo "������������ص�ַ"
#read sgateway
sgateway="tujiao.com"
echo "���ӵĵ�������$sgateway"
delay=400
echo "��������ӳٲ�����$delay����"
nexttime=2
echo "ÿ��$nexttime�����һ�μ��"
echo "########################################"
#while :
#do
    network=`ping -c 1 $sgateway  |  awk 'NR==2 {print $8}' | sed "s/=/ /g"  | awk '{print $2}'`
    expr ${network} + 0 1>/dev/null 2>&1
    if [ $? -eq 0 ]; then
        #/etc/init.d/network restart
        echo "�������" 
        subject="tujiao.com down"
        content=$subject
       /app/java/bin/java -cp /cron/monitor:/cron/lib/* SendMails $host $sender $password "$subject" "$content" $receiver
    else
        value_n=`echo $network | sed "s/\.//g"`
        echo "$value_n"  
        if [ "$value_n" -gt "$delay" ];
        then
            #/etc/init.d/network restart
            echo "�������"                    
            subject="tujiao.com slowly"
            content=$subject
            /app/java/bin/java -cp /cron/monitor:/cron/lib/* SendMails $host $sender $password "$subject" "$content" $receiver
        else
            echo "�����Ϊ"                
            echo "����ͨ��"                
            echo "�����ӳ�Ϊ$network��"               
            echo "########################"             
        fi
    fi
    #sleep $nexttime
#done 