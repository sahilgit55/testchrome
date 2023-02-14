FROM --platform=linux/amd64 ubuntu:latest
 
RUN apt-get update \
  && apt-get install -y python3-pip python3-dev firefox

# INSTALL DEPENDENCIES
RUN apt-get install -y curl unzip openjdk-8-jre-headless xvfb libxi6 libgconf-2-4 tar wget

# INSTALL CHROMEDRIVER
RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.32.2/geckodriver-v0.32.2-linux64.tar.gz -O /tmp/geckodriver.tar.gz \
  && tar -C /opt -xzf /tmp/geckodriver.tar.gz \
  && chmod 755 /opt/geckodriver \
  && ln -fs /opt/geckodriver /usr/bin/geckodriver \
  && ln -fs /opt/geckodriver /usr/local/bin/geckodriver

# INSTALL SELENIUM
RUN pip3 install selenium==3.0.2

# RUN TEST SCRIPT
COPY test_selenium.py test_selenium.py

CMD ["python3", "test.py"]
