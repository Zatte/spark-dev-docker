FROM ubuntu:16.04

ENV SPARK_VERSION="2.2.0"
ENV SPARK_HOME="/usr/lib/spark"
RUN	apt-get update  && \
	echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
	apt-get install -y software-properties-common apt-transport-https  && \
	add-apt-repository -y ppa:webupd8team/java  && \
	echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list  && \
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823  && \
	apt-get update  && \
	apt-get -y install oracle-java8-installer sbt curl wget  && \
	cd /tmp/ && wget http://apache.mirrors.spacedump.net/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz  && \
	tar xvfz spark-${SPARK_VERSION}-bin-hadoop2.7.tgz  && \
	mv spark-${SPARK_VERSION}-bin-hadoop2.7 /usr/lib/spark-${SPARK_VERSION}-bin-hadoop27  && \
	ln -sf /usr/lib/spark-${SPARK_VERSION}-bin-hadoop27 /usr/lib/spark  && \
	echo "export SPARK_HOME=\"$SPARK_HOME\"" >> ~/.profile && \ 
	echo "export PATH=\"\$PATH:\$SPARK_HOME/bin\"" >> ~/.profile