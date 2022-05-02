FROM hexpm/elixir:1.13.0-erlang-24.3.2-debian-bullseye-20210902-slim

WORKDIR /app

COPY . .

RUN mix local.hex --force

RUN mix deps.get

CMD ["mix test"]