var http = require('http');

http.createServer(function (req, res) {

    function cal(a, b, op) {
        switch (op) {
            case '+':
                return a + b
                console.log(add);
                break;
            case '-':
                return a - b
                console.log(sub);
                break;
            case '*':
                return a * b
                console.log(multi);
                break;
            case '/':
                return a / b
                console.log(module);
                break;
            case '%':
                return a % b
                console.log(div);
                break;
            default:
                return 0;
        }
    }
    console.log(cal(5, 5, '-'))
    console.log(cal(10, 5, '+'))
    console.log(cal(5, 5, '*'))
    console.log(cal(5, 5, '/'))
    console.log(cal(13, 5, '%'))
}).listen(8080);