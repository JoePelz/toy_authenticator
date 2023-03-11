## Setup
This project uses ruby 2.6.6 and Rails 6.1.7

Gems should be installed via Bundler

If redis needs to connect to anything other than the default redis://localhost:6379, it should be configured in ./app/lib/redis_instance.rb

## Demo:

See [DEMO.md](DEMO.md) for a cURL demo of this API

## NOTES:

* We still need to secure redis with credentials
* Do we care about accept and content-type negotiation? I assumed not right now.
* I decided that only known internal users can do admin on users (find, create), and required an api key for access.
  * I was going to add a route constraint on the admin routes, but that gives a 404 instead of a 401. 
* We should be using something known and studied like `devise` for authentication. DIY security is not a great idea.
  * if not devise, at least lets hash passwords with bcrypt
  * update: implemented this with ActiveModel::SecurePassword
* Or we should be using OAuth via `doorkeeper` gem.
  * What is the end goal of this authentication? That will determine if we need to be an oauth or Open ID Connect server.
* `pundit` is a good gem for setting policies about who can do which action. Once we've authenticted a user, we can use pundit for authorization.
* We should consider adopting a standard like JSONAPI and the fast_jsonapi gem. This might be tricky with Redis as a backend.
* We should install `Rack::Attack` to throttle brute-force authentication attempts for added security.
* I chose to require a password_confirmation parameter on creating a user because it was easy and fun
* I looked around for gems for checking password complexity. We could do that with regex checks, and I still might, but I also decided to install strong_password to do some fancier checks.
  * v0.0.7 of the strong_password gem was hijacked by a malicious user, but control has been restored to the original author. See https://news.ycombinator.com/item?id=20377136
  * If there's a business need for password complexity to include "special characters", we can add that with a set of regex validations.
* The models that use Redis as storage should be enhanced to inherit from a base class that provides storage access. 
* I added Oj gem for serialization for greater performance
* TODO: need to isolate test traffic in redis. Currently it's hitting the same redis as development.
  * Relatedly, I have a bunch of "after this test, clean up your data manually" hooks, which is a terrible idea.
* I included an expiration on users persisted into redis because it made dev easier
