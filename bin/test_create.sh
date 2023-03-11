#!/usr/bin/env bash

curl -X POST localhost:3000/admin/users \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: valid-key" \
  -d '{
  "username": "user1",
  "password": "h2f8057hro",
  "password_confirmation": "h2f8057hro"
}'
