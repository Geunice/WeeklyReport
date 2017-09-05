# image: weeklyreport:0.2
FROM centos:7
MAINTAINER CodingCrush
ENV LANG en_US.UTF-8
# TimeZone: Asia/Shanghai
RUN ln -s -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    curl -fsSL https://setup.ius.io/ | sh && \
    yum update -y && \
    yum install -y python36u python36u-devel python36u-pip && \
    mkdir ~/.pip && \
    echo -e "[global]\nindex-url=http://pypi.douban.com/simple/\ntrusted-host=pypi.douban.com">~/.pip/pip.conf && \
    yum clean all
ADD . .
RUN pip3.6 install -r requirements.txt --timeout=120
WORKDIR /opt/weeklyreport


# Start wp-server container

# docker run -d
#            --restart=unless-stopped \
#            --name weeklyreport-server \
#            --net=host \
#            -v /etc/localtime:/etc/localtime:ro \
#            -v $PWD:/opt/weeklyreport \
#            weeklyreport:0.2 \
#            gunicorn wsgi:app --bind 0.0.0.0:8000 -w 2 --log-file logs/awsgi.log --log-level=DEBUG
