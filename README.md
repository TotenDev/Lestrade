Lestrade
========

Simple in-app purchase receipt validator.


Usage
-----

Clone and create a [heroku][] app:

    git clone https://github.com/TotenDev/Lestrade.git
    cd Lestrade
    heroku create
    git push heroku master

Set environment variables for the [HTTP Basic Authentication][http_ba]:

    heroku config:add LESTRADE_USERNAME=sherlock
    heroku config:add LESTRADE_PASSWORD=secret

Send a POST containing the receipt encoded in [Base64][] to `/validate`:

    curl --user sherlock:secret \
         --data "receipt=(base64 receipt)" \
         https://example.com/validate

The response is a JSON containing the status. Example:

    {
      "status": false
    }


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


[heroku]: http://www.heroku.com/
[http_ba]: http://en.wikipedia.org/wiki/Basic_access_authentication
[Base64]: http://en.wikipedia.org/wiki/Base64
[license]: https://github.com/TotenDev/Lestrade/blob/master/LICENSE
