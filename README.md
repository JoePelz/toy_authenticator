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

TODO:

* secure redis with credentials
* accept and content-type negotiation?
* Adopt a standard like jsonapi?  This might be tricky with Redis as a backend.


.