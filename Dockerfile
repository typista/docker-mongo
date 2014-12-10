#http://qiita.com/hnakamur/items/0b72590136cece29faee
FROM typista/base
#FROM typista/base:0.3
#EXPOSE 27017
RUN wget https://raw.githubusercontent.com/typista/docker-mongo/master/files/entrypoint.sh -O /etc/entrypoint.sh && \
	wget https://raw.githubusercontent.com/typista/docker-mongo/master/files/mongodb.repo -O /etc/yum.repos.d/mongodb.repo && \
	yum update -y && \
	yum -y install mongodb-org && \
	chmod +x /etc/entrypoint.sh
#ENTRYPOINT /etc/entrypoint.sh

