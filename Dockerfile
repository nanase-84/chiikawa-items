FROM ruby:3.0.6
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
RUN apt-get update -qq \
&& apt-get install -y ca-certificates curl gnupg \
&& mkdir -p /etc/apt/keyrings \
&& curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
&& NODE_MAJOR=19 \
&& wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt-get update -qq \
&& apt-get install -y build-essential libpq-dev nodejs yarn
RUN mkdir /chiikawa_items
WORKDIR /chiikawa_items
RUN gem install bundler
COPY Gemfile /chiikawa_items/Gemfile
COPY Gemfile.lock /chiikawa_items/Gemfile.lock
COPY yarn.lock /chiikawa_items/yarn.lock
RUN bundle install
RUN yarn install
COPY . /chiikawa_items
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN ["/bin/bash", "-c", "source $NVM_DIR/nvm.sh && nvm install node"]