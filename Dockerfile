From ruby:2
MAINTAINER Caleb Tutty

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive
ENV RAILS_ENV production

# Update
RUN apt-get update

# Start editing
RUN apt-get -y install supervisor ca-certificates git postgresql-client build-essential catdoc elinks \
gettext ghostscript gnuplot-nox imagemagick \
libicu-dev libmagic-dev libmagickwand-dev libmagickcore-dev libpq-dev libxml2-dev libxslt1-dev links \
sqlite3 lockfile-progs mutt pdftk poppler-utils \
postgresql-client tnef unrtf uuid-dev wkhtmltopdf wv xapian-tools

RUN git clone https://github.com/nzherald/alaveteli.git --branch develop /opt/alaveteli

# Add files
ADD assets/setup.sh /opt/setup.sh

RUN cd /opt/alaveteli; git submodule init && git submodule update
RUN cd /opt/alaveteli; bundle install --deployment --without development test --retry=10


# Run
CMD /opt/setup.sh; /usr/bin/supervisord -c /etc/supervisor/supervisord.conf

