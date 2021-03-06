# Copyright 2018 Datawire. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License

echo "Building images"

set -x

docker build -q -t dwflynn/auth:0.0.3 auth-service
docker build -q -t dwflynn/auth:0.0.3tls --build-arg TLS=--tls auth-service
docker build -q -t dwflynn/ratelimit-service:0.0.1 ratelimit-service
docker build -q -t dwflynn/stats-test:0.0.1 stats-test-service
docker build -q -t dwflynn/shadow:0.0.2 shadow-service

# seriously? there's no docker push --quiet???
docker push dwflynn/auth:0.0.3 | python ../releng/linify.py push.log
docker push dwflynn/auth:0.0.3tls | python ../releng/linify.py push.log
docker push dwflynn/ratelimit-service:0.0.1 | python ../releng/linify.py push.log
docker push dwflynn/stats-test:0.0.1 | python ../releng/linify.py push.log
docker push dwflynn/shadow:0.0.2 | python ../releng/linify.py push.log

set +x
