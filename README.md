#Installation:

* Ruby Version: 2.6.6

    rvm install ruby-2.6.6

* Redis installation (in WSL)

    ```
    sudo apt update
    sudo apt install redis-server
    ```
    The redis connection details are in /etc/redis/redis.conf.
    https://redis.io/docs/getting-started/installation/install-redis-on-windows/
    
    127.0.0.1:6379
    
    Redis server can be tested with
    ```
    $ redis-cli
    127.0.0.1:6379> ping
    PONG
    127.0.0.1:6379> ping 'hi'
    "hi"
    127.0.0.1:6379> set test "it's working" EX 10
    OK
    127.0.0.1:6379> get test
    "it's working"
    127.0.0.1:6379> get test
    (nil)
    ```

* Secure redis

    Security settings are in /etc/redis/redis.conf
    
    See https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-redis-on-ubuntu-18-04
    for how to set a password

* Linting

    Run the following
    ```
    $ rubocop
    ```

NOTES:
* We need to secure redis with credentials
* Do we care about accept and content-type negotiation?
* I Decided that only known internal users can do admin on users (find, create)
  * I was going to add a route constraint on the admin routes, but that gives a 404 instead of a 401. 
* We should be using the `devise` for authentication. DIY security is not a great idea.
  * if not devise, at least lets hash passwords with bcrypt
  * update: implemented this with ActiveModel::SecurePassword
* Or we should be using OAuth via `doorkeeper` gem.
  * What is the end goal of this authentication? That will determine if we need to be an oauth or Open ID Connect server.
* `pundit` is a good gem for setting policies about who can do which action.
* We should consider adopting a standard like JSONAPI and the fast_jsonapi gem. This might be tricky with Redis as a backend.
* We should install `Rack::Attack` to throttle brute-force authentication attempts
* I chose to require password_confirmation on creating a user because it was easy and fun
* I looked around for gems for checking password complexity. We could do that with regex checks, and I still might, but I also decided to install strong_password to do some fancier checks.
  * v0.0.7 of the strong_password gem was hijacked by a malicious user, but control has been restored to the original author. See https://news.ycombinator.com/item?id=20377136
  * If there's a business need for password complexity to include "special characters", we can add that with a set of regex validations.
* The models that use Redis as storage should be enhanced to inherit from a base class that provides storage access. 
* I added Oj gem for serialization for greater performance
* TODO: need to isolate test traffic in redis. Currently it's hitting the same redis as development.
  * Relatedly, I have a bunch of "after this test, clean up your data manually" hooks, which is a terrible idea.

.