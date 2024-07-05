scenario 1 = normal, 3 backend
    caddy
        Test URL                : http://20.190.71.218
        Specify load            : Virtual users
        Number of virtual users : 1000
        Test duration (minutes) : 1
        Ramp-up time (minutes)  : 0
    nginx
        Test URL                : http://20.190.65.233
        Specify load            : Virtual users
        Number of virtual users : 1000
        Test duration (minutes) : 1
        Ramp-up time (minutes)  : 0

scenario 2 = failure, 2 backend
    caddy
        Test URL                : http://20.190.71.218
        Specify load            : Virtual users
        Number of virtual users : 1000
        Test duration (minutes) : 1
        Ramp-up time (minutes)  : 0
    nginx
        Test URL                : http://20.190.65.233
        Specify load            : Virtual users
        Number of virtual users : 1000
        Test duration (minutes) : 1
        Ramp-up time (minutes)  : 0

scenario 3 = improve, 4 backend
    caddy
        Test URL                : http://20.190.71.218
        Specify load            : Virtual users
        Number of virtual users : 1000
        Test duration (minutes) : 1
        Ramp-up time (minutes)  : 0
    nginx
        Test URL                : http://20.190.65.233
        Specify load            : Virtual users
        Number of virtual users : 1000
        Test duration (minutes) : 1
        Ramp-up time (minutes)  : 0