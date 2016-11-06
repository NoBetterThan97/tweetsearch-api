# tweetsearch-api

The api for tweetsearch gem

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Spin Up Server

```bash
bundle exec puma
```

## Search for Tweets

- Single hashtag

  ```
  http://localhost:9292/api/v0.1/tweets/candy
  ```

- Multiple hashtags (separated by commas):

  ```
  http://localhost:9292/api/v0.1/tweets/candy,halloween
  ```
