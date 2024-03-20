import { check } from 'k6';
import http from 'k6/http';

export default function () {
  http.get('http://10.10.254.169:8081/', (response) => {
    check(response, {
      'Status is 200': (r) => r.status === 200,
      'Response time is less than 500ms': r.timings.duration < 500,
    });
  });
}
