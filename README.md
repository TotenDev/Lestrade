Lestrade
========

Simple in-app purchase receipt validator.

Stable code will be on master branch, any other branch may contain unstable code. If you are installing in a production environment, use a tag or the master branch for better experience.


Instalation
-----------

NOTE: This project has only been tested on [Heroku][heroku].

#### Heroku setup:

1. Clone:

        git clone https://github.com/TotenDev/Lestrade.git
        cd Lestrade
        heroku create
        git push heroku master

2. Set the environment variables for the [HTTP Basic Authentication][http_ba]

        heroku config:add LESTRADE_USERNAME=sherlock
        heroku config:add LESTRADE_PASSWORD=secret

#### Non-Heroku:

1. Clone or [download][] the code

        git clone https://github.com/TotenDev/Lestrade.git

2. Move the code to your webserver's document root

3. Set the environment variables for the [HTTP Basic Authentication][http_ba], check your webserver's manual for more information.


Usage
-----

#### Validate Receipt

  - Route:  `/validate`
  - Method: `POST`
  - Body:   `{ "receipt-data": "(receipt bytes)" }`
  - Success Code:
    - 200:  `OK`
  - Error Code:
    - 401:  `Unauthorized`

Example:

    curl --user sherlock:secret \
         --data "{\"receipt-data\":\"(base64 receipt)\"}" \
         https://example.com/validate

The response is a JSON containing the status.

    {
      "status": false
    }

#### Sandbox Validate Receipt

  - Route:  `/sandbox/validate`
  - Method: `POST`
  - Body:   `{ "receipt-data": "(receipt bytes)" }`
  - Success Code:
    - 200:  `OK`
  - Error Code:
    - 401:  `Unauthorized`

Example:

    curl --user sherlock:secret \
         --data "{\"receipt-data\":\"(base64 receipt)\"}" \
         https://example.com/sandbox/validate

The response is a JSON containing the status.

    {
      "status": false
    }


TDMetrics
---------

To send metrics to [TDMetrics][metrics] all you need to do is set this environment variables:

    heroku config:add LESTRADE_SHOULD_SEND_METRICS=true
    heroku config:add LESTRADE_METRICS_PROJECT_ID=1
    heroku config:add LESTRADE_METRICS_USERNAME=watson
    heroku config:add LESTRADE_METRICS_PASSWORD=secret
    heroku config:add LESTRADE_METRICS_URL="http://example.com/"

NOTE: On Non-Heroku environments, please check your webserver's manual for more information.


Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


License
-------

[MIT][license]


[download]: https://github.com/TotenDev/Lestrade/zipball/master
[heroku]: http://www.heroku.com/
[http_ba]: http://en.wikipedia.org/wiki/Basic_access_authentication
[Base64]: http://en.wikipedia.org/wiki/Base64
[license]: https://github.com/TotenDev/Lestrade/blob/master/LICENSE
[metrics]: https://github.com/TotenDev/TDMetrics
