#!/usr/bin/env bash

curl -X POST 'localhost:3000/users/authenticate' \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{
  "username": "user1",
  "password": "password1"
}'
