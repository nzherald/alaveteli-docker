From ruby:2
MAINTAINER Caleb Tutty

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive
ENV RAILS_ENV production

# Update
RUN apt-get update

# Start editing
RUN apt-get -y install supervisor ca-certificates git postgresql-client build-essential catdoc elinks gettext ghostscript gnuplot-nox libicu-dev \
libmagic-dev libmagickwand-dev libpq-dev libxml2-dev libxslt1-dev links lockfile-progs mutt pdftk poppler-utils postgresql postgresql-client \
tnef unrtf uuid-dev wkhtmltopdf wv xapian-tools

RUN git config --global url.https://github.com/.insteadOf git://git@github.com/

RUN git clone https://github.com/nzherald/alaveteli.git --branch develop /opt/alaveteli

# Add files
ADD assets/setup_alaveteli.sh /opt/setup_alaveteli.sh
ADD assets/setup.sh /opt/setup.sh

RUN /opt/setup_alaveteli.sh

# Run
CMD /opt/setup.sh; /usr/bin/supervisord -c /etc/supervisor/supervisord.conf

