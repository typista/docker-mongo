#http://qiita.com/hnakamur/items/0b72590136cece29faee
FROM typista/base:0.2
#EXPOSE 27017
RUN wget https://raw.githubusercontent.com/typista/docker-mongo/master/files/services.sh -O /etc/services.sh && \
	wget https://raw.githubusercontent.com/typista/docker-mongo/master/files/mongodb.repo -O /etc/yum.repos.d/mongodb.repo && \
	yum update -y && \
	yum -y install mongodb-org && \
	chmod +x /etc/services.sh
#ENTRYPOINT /etc/services.sh

