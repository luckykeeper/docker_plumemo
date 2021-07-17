FROM centos:latest
MAINTAINER Luckykeeper, http://b.luckykeeper.site
RUN yum -y update
RUN yum install epel-release -y
RUN yum install passwd openssl openssh-server tar libncurses* gcc wget make htop vim net-tools openssl-dev* pcre-dev* zlib-dev* curl git -y
RUN echo '123456' s passwd --stdin root
RUN ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
RUN sed -i '/^session\s\+required\s\+pam_loginuid.so/s/^/#/' /etc/pam.d/sshd
RUN mkdir -p /root/.ssh && chown root.root /root && chmod 700 /root/.ssh
EXPOSE 22
EXPOSE 3306
EXPOSE 443
EXPOSE 80
COPY blog_auto_start.sh /root
COPY nginx.conf /root
COPY plumemo-v1.0.0.sh /root
ADD theme /root
ADD plumemo-v1.2.0.jar /usr/local/software/
COPY admin.zip /usr/local/software
COPY nginx-1.17.9.tar.gz /usr/local/software
COPY theme-react-sakura.zip /usr/local/software
RUN chmod +x /root/blog_auto_start.sh && chmod +x /root/plumemo-v1.0.0.sh 
CMD ip addr ls eth0 | awk '{print $2}' | egrep -o '([0-9]+\.){3}[0-9]+';/usr/sbin/sshd -D
HEALTHCHECK --interval=5s --timeout=3s CMD curl -fs http://localhost/ || exit 1
