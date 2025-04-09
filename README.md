# ChatGPT CLI

Use this to talk with ChatGPT from your terminal.

## Usage

```shell
# run app
make run

# general chatting
> hi chatbot

# for usage help
> /help

# generate an image, like a cat. uses the DALL·E model
> /image cat

# see history of conversation so far
> /history

# by default, every message is part of the same context/conversation
# this resets your context/conversation
> /reset
```

### Context

Context is maintained for all chat inputs only.
Slash commands are not captured.
Use `/reset` to clear your context.

## Prequisites

1. [OpenAI API Key](https://platform.openai.com/account/api-keys)
2. [OpenAI Org ID](https://platform.openai.com/account/org-settings)
3. Ruby v3+
4. Bundler v2.3+

## Running Using Container

```shell
podman run --rm -e ACCESS_TOKEN=rh-35xQDkp8RUynsi6C/qU4TdZKbDkR0thisisobviouslyfake -e ORG_ID=org-UZZePthisisobviouslyfake -it quay.io/jkeam/chatgpt-cli:latest ./run.sh

# or use this image if you are on an m1 mac
# podman run --rm -e ACCESS_TOKEN=rh-35xQDkp8RUynsi6C/qU4TdZKbDkR0thisisobviouslyfake -e ORG_ID=org-UZZePthisisobviouslyfake -it quay.io/jkeam/chatgpt-cli:m1-latest ./run.sh
```

## Running from Source

### Setup

1. Clone project

    ```shell
    git clone git@github.com:jkeam/chatgpt-cli.git
    cd chatgpt-cli
    ```

2. Install gems

    ```shell
    gem install bundler
    bundle install
    ```

3. Create `.env` file like below, replacing with your values obtained from `Prequisites`:

    ```shell
    ACCESS_TOKEN=rh-35xQDkp8RUynsi6C/qU4TdZKbDkR0thisisobviouslyfake
    MODEL_NAME=openai-4o
    # optionally
    ORG_ID=org-UZZePthisisobviouslyfake
    URI_BASE=https://oai.hconeai.com/
    ```

### Running

```shell
./run.sh
# or make run
```

### Development

```shell
# install dev/test dependencies
bundle config set --local with test development

# install test and development dependencies
bundle install

# run tests
make test
```

## References

1. [OpenSSL with Ruby version compat](https://github.com/rbenv/ruby-build/blob/10eb379aecc2fc35874405247060e8a536959fe1/share/ruby-build/3.3.5)
