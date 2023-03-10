#!/usr/bin/env bash

curl -X GET 'localhost:3000/admin/users/find?username=user1' \
  -H "Accept: application/json" \
  -H "X-API-Key: expired-key"
