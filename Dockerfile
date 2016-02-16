FROM gliderlabs/alpine:3.3

WORKDIR /var/app

RUN echo "@edge http://dl-4.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories
RUN apk-install build-base elixir@edge erlang-crypto erlang-parsetools erlang-syntax-tools
RUN mix local.hex --force && mix local.rebar

ADD mix.exs /var/app/mix.exs
ADD mix.lock /var/app/mix.lock

RUN mix deps.get && mix deps.compile

ADD config /var/app/config
ADD lib /var/app/lib

CMD ["sh"]
