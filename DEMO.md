# Creating a user

## Create a user successfully

```bash
curl -X POST localhost:3000/admin/users \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: valid-key" \
  -d '{
  "username": "user1",
  "password": "h2f8057hro",
  "password_confirmation": "h2f8057hro"
}'
```

```json
{
  "username":"user1"
}
```

## With an invalid api key

```bash
curl -X POST localhost:3000/admin/users \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: expired-key" \
  -d '{
  "username": "user1",
  "password": "h2f8057hro",
  "password_confirmation": "h2f8057hro"
}'
```

```json
{
  "errors":[
    {
      "title":"Unauthorized",
      "status":401,
      "detail":"API key is invalid",
    }
  ]
}
```

## With validation errors

```bash
curl -X POST localhost:3000/admin/users \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: valid-key" \
  -d '{
  "username": "user1",
  "password": "ban"
}'
```

```json
{
  "errors": [
    {
      "title":"Unprocessable Content",
      "status":422,
      "detail":"Password confirmation can't be blank. Username must be unique. Password is too short (minimum is 5 characters). Password is too weak",
    }
  ]
}
```

# Authenticating a user

## Successfully
```bash
curl -X POST 'localhost:3000/users/authenticate' \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{
  "username": "user1",
  "password": "h2f8057hro"
}'
```

```json
{
  "username":"user1"
}
```

## With an invalid password, or with a user that doesn't exist

```bash
curl -X POST 'localhost:3000/users/authenticate' \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{
  "username": "user1",
  "password": "baaaad"
}'
```

```json
{
  "errors":[
    {
      "title":"Unauthorized",
      "status":401,
      "detail":"Credentials are not valid"
    }
  ]
}
```


