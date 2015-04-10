FROM ruby:2.1
MAINTAINER Caleb Tutty

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive
ENV RAILS_ENV production

RUN echo deb http://apt.newrelic.com/debian/ newrelic non-free >> /etc/apt/sources.list.d/newrelic.list
RUN wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add -

# Update
RUN apt-get update && apt-get upgrade -y

# Install required packages
RUN apt-get -y install supervisor ca-certificates git postgresql-client build-essential catdoc elinks \
  gettext ghostscript gnuplot-nox imagemagick unzip \
  libicu-dev libmagic-dev libmagickwand-dev libmagickcore-dev libpq-dev libxml2-dev libxslt1-dev links \
  sqlite3 lockfile-progs mutt pdftk poppler-utils \
  postgresql-client tnef unrtf uuid-dev wkhtmltopdf wv xapian-tools \
  newrelic-sysmond

# Clone develop branch
RUN git clone https://github.com/nzherald/alaveteli.git --branch develop /opt/alaveteli

# Add yaml configuration which take environment variables
ADD assets/database.yml /opt/alaveteli/config/database.yml
ADD assets/general.yml /opt/alaveteli/config/general.yml
ADD assets/newrelic.yml /opt/alaveteli/config/newrelic.yml

WORKDIR /opt/alaveteli

RUN git submodule init && git submodule update
# Due to some firewalls blocking git://
RUN git config --global url."https://".insteadOf git://

RUN bundle install --without development debug test --deployment --retry=10
ADD assets/setup.sh /opt/setup.sh

CMD /opt/setup.sh
