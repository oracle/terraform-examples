This configuration sets up and runs a very basic Hello World web app using
https://echo.labstack.com/


```sh
[webserver0]$ go run server.go
```

```sh
[localhost]$ curl http://webserver0:7777
<h1>Hello, World!</h1><h2>192.168.100.2</h2>
```
