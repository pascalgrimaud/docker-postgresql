FROM ubuntu:14.04
MAINTAINER Pascal Grimaud <pascalgrimaud@gmail.com>

# make sure the package repository is up to date
RUN apt-get -y update

# Ensure UTF-8 locale
RUN echo 'LANGUAGE="en_US.UTF-8"' > /etc/default/locale
RUN echo 'LANG="en_US.UTF-8"' >> /etc/default/locale
RUN echo 'LC_ALL="en_US.UTF-8"' >> /etc/default/locale
RUN locale-gen en_US.UTF-8 &&\
  DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

# install postgresql-9.3
ENV PG_VERSION 9.3
RUN apt-get -y install postgresql-${PG_VERSION} \
	postgresql-client-${PG_VERSION} \
	postgresql-contrib-${PG_VERSION}

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Adjust PostgreSQL configuration so that remote connections to the database are possible. 
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/${PG_VERSION}/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/${PG_VERSION}/main/postgresql.conf

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

ADD postgresql_run.sh /postgresql_run.sh
RUN chmod 755 /*.sh

EXPOSE 5432
CMD ["/postgresql_run.sh"]