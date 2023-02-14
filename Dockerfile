FROM --platform=linux/amd64 ubuntu:latest
 
RUN apt-get update \
  && apt-get install -y python3-pip python3-dev wget \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip 

# INSTALL DEPENDENCIES
RUN apt-get install -y curl unzip openjdk-8-jre-headless xvfb libxi6 libgconf-2-4

# INSTALL CHROME
RUN apt-get install chromium-browser

# INSTALL CHROMEDRIVER
RUN wget -N https://chromedriver.storage.googleapis.com/79.0.3945.36/chromedriver_linux64.zip -P ~/ \
    && unzip ~/chromedriver_linux64.zip -d ~/ \
    && rm ~/chromedriver_linux64.zip \
    && mv -f ~/chromedriver /usr/local/bin/chromedriver \
    && chown root:root /usr/local/bin/chromedriver \
    && chmod 0755 /usr/local/bin/chromedriver

# INSTALL SELENIUM
RUN pip install selenium

# RUN TEST SCRIPT
COPY test_selenium.py test_selenium.py

CMD ["python3", "test_selenium.py"]
