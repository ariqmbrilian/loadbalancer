Load Balancer round robin performance analysis between nginx and caddy


## RUN TEST
```
k6 run -d 1m -u 100 test.js
```

CADDY
```
echo "GET http://localhost:8080/" | vegeta attack -duration=5s | tee results.bin | vegeta report
Requests      [total, rate, throughput]         250, 50.20, 50.15
Duration      [total, attack, wait]             4.985s, 4.98s, 4.52ms
Latencies     [min, mean, 50, 90, 95, 99, max]  3.282ms, 6.753ms, 7.108ms, 8.368ms, 8.984ms, 11.773ms, 15.499ms
Bytes In      [total, mean]                     6142, 24.57
Bytes Out     [total, mean]                     0, 0.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:250
Error Set:

echo "GET http://localhost:8080/" | vegeta attack -duration=15s | tee results.bin | vegeta report
Requests      [total, rate, throughput]         750, 50.07, 50.05
Duration      [total, attack, wait]             14.984s, 14.98s, 3.756ms
Latencies     [min, mean, 50, 90, 95, 99, max]  3.115ms, 5.436ms, 5.375ms, 6.796ms, 7.585ms, 10.071ms, 17.003ms
Bytes In      [total, mean]                     18642, 24.86
Bytes Out     [total, mean]                     0, 0.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:750
Error Set:

echo "GET http://localhost:8080/" | vegeta attack -duration=1m | tee results.bin | vegeta report
Requests      [total, rate, throughput]         3000, 50.02, 50.01
Duration      [total, attack, wait]             59.988s, 59.98s, 7.706ms
Latencies     [min, mean, 50, 90, 95, 99, max]  3.023ms, 5.528ms, 5.318ms, 6.875ms, 7.586ms, 9.22ms, 22.147ms
Bytes In      [total, mean]                     77751, 25.92
Bytes Out     [total, mean]                     0, 0.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:3000
Error Set:

Bucket           #    %        Histogram
[0s,     100ms]  250  100.00%  ###########################################################################
[100ms,  200ms]  0    0.00%
[200ms,  300ms]  0    0.00%
[300ms,  +Inf]   0    0.00%

```

NGINX
```
echo "GET http://localhost:8081/" | vegeta attack -duration=5s | tee results.bin | vegeta report
Requests      [total, rate, throughput]         250, 50.20, 50.15
Duration      [total, attack, wait]             4.985s, 4.98s, 4.956ms
Latencies     [min, mean, 50, 90, 95, 99, max]  2.55ms, 4.9ms, 4.932ms, 5.367ms, 5.589ms, 6.851ms, 7.709ms
Bytes In      [total, mean]                     6142, 24.57
Bytes Out     [total, mean]                     0, 0.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:250
Error Set:

echo "GET http://localhost:8081/" | vegeta attack -duration=15s | tee results.bin | vegeta report
Requests      [total, rate, throughput]         750, 50.07, 50.05
Duration      [total, attack, wait]             14.986s, 14.98s, 5.416ms
Latencies     [min, mean, 50, 90, 95, 99, max]  2.565ms, 4.565ms, 4.26ms, 6.232ms, 6.81ms, 8.682ms, 24.203ms
Bytes In      [total, mean]                     18752, 25.00
Bytes Out     [total, mean]                     0, 0.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:750
Error Set:

echo "GET http://localhost:8081/" | vegeta attack -duration=1m | tee results.bin | vegeta report
Requests      [total, rate, throughput]         3000, 50.02, 50.01
Duration      [total, attack, wait]             59.984s, 59.98s, 4.195ms
Latencies     [min, mean, 50, 90, 95, 99, max]  2.163ms, 5.008ms, 4.834ms, 6.727ms, 7.547ms, 9.488ms, 99.416ms
Bytes In      [total, mean]                     78000, 26.00
Bytes Out     [total, mean]                     0, 0.00
Success       [ratio]                           100.00%
Status Codes  [code:count]                      200:3000
Error Set:

Bucket           #    %        Histogram
[0s,     100ms]  250  100.00%  ###########################################################################
[100ms,  200ms]  0    0.00%
[200ms,  300ms]  0    0.00%
[300ms,  +Inf]   0    0.00%
```
