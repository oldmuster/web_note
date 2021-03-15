#!/bin/bash

rm -rf /root/solobf/solo.sql

docker exec -it mysql mysqldump -uroot -p solo > /root/solobf/solo.sql
