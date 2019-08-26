FROM ubuntu:18.04

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y apt-utils tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&\
    dpkg-reconfigure -f noninteractive tzdata &&\
    apt-get install -y wget apt-transport-https vim git curl net-tools bzip2 cron expect dbus sudo && \
    apt-get install -y libxdamage1 libgtk-3-0 libasound2 libnss3 libxss1 libx11-xcb-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /root


ADD . /root

RUN chmod +x /root/* && \
	echo 'acunetix   ALL=(ALL)       NOPASSWD: ALL' >> /etc/sudoers && \
	/root/auto_install_awvs.sh && \
	# 先运行一次才会生成sign
	nohup su -l acunetix -c '/home/acunetix/.acunetix_trial/start.sh &' && \
	sleep 10 && ps -ef |grep opsrv|grep -v grep|awk {'print$2'}|xargs kill -9 && \
	cp patch_awvs /home/acunetix/.acunetix_trial/v_190515149/scanner/ && \
	cd /home/acunetix/.acunetix_trial/v_190515149/scanner/ && ./patch_awvs && \
	# 锁定文件，防止被修改（偶尔会无法锁定）
	#chattr +i /home/acunetix/.acunetix_trial/data/license/license_info.json && \
	# 每天删除wa_data.dat防止到期后无法使用
	echo '0 0 * * * rm -rf /home/acunetix/.acunetix_trial/data/license/wa_data.dat' >> /var/spool/cron/crontabs/root && \
	rm -f /root/*


EXPOSE 13443

ENTRYPOINT /etc/init.d/cron start && su -l acunetix -c '/home/acunetix/.acunetix_trial/start.sh'
