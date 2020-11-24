FROM oraclelinux:7-slim

RUN  yum -y install oracle-release-el7 oracle-nodejs-release-el7 && \
     yum-config-manager --disable ol7_developer_EPEL && \
     yum -y install oracle-instantclient19.3-basic && \
     yum -y install oracle-instantclient19.3-sqlplus && \
     export PATH=/usr/lib/oracle/19.3/client64/bin:$PATH &&\
     rm -rf /var/cache/yum

RUN mkdir /usr/network
COPY admin /usr/network/admin
ENV TNS_ADMIN /usr/network/admin

COPY workdir /usr/workdir

VOLUME ["/usr/network/admin"]
VOLUME ["/usr/workdir"]

ENV USERNAME ecol,
ENV PASSWORD ecol
ENV SERVICE ECOL
ENV URL ECOL
ENV PORT PORT
WORKDIR "/usr/workdir"

CMD ["sqlplus", "${USERNAME}/${PASSWORD}@${URL}:${PORT}/${SERVICE}"
#docker run --rm migutak/oracledbcron:2.0sqlplus ecol/ecol@ECOL @loans.sql
#docker run --rm -e USERNAME=ecol -e PASSWORD=ecol -e URL=159.122.130.149 -e PORT=1564 -e SERVICE=ORCLCDB.localdomain migutak/oracledbcron:2.0 sqlplus ecol/ecol@ECOL @loans.sql
#docker build -t migutak/oracledbcron:2.0.