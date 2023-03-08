# ChatGPT CLI

Use this to talk with ChatGPT from your terminal.

## Prequisites

1. [OpenAI API Key](https://platform.openai.com/account/api-keys)
2. [OpenAI Org ID](https://platform.openai.com/account/org-settings)
3. Ruby v3+

## Setup

1. Clone project

        git clone git@github.com:jkeam/chatgpt-cli.git
        cd chatgpt-cli

2. Install gems

        bundle install

3. Create `.env` file like below:

        OPENAI_ACCESS_TOKEN=rh-35xQDkp8RUynsi6C/XvqU4TdZKbDkR0ehVfI8QMjdkfjJJkd
        OPENAI_ORGANIZATION_ID=org-UZZePtGA6ZXXrwPI3hyZjIEz

## Running

```shell
./run.sh
# or make run
```

## Tests

```shell
make
```
