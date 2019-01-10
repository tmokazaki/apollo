import httpclient, json, strutils, strformat, sequtils

let c = newHttpClient(maxRedirects=0)
defer: c.close()

# Get hello
var url = "http://localhost:9090/hello"
echo "GET request: {url}".fmt

var response = c.request(url,
                         httpMethod=HttpGet,
                         headers=newHttpHeaders(
                           { "Accept": "*/*"
                           , "Connection": "keep-alive"
                           }
                        ))
echo response.status
case parseInt(response.status.split(" ")[0]):
  of 200:
    echo response.body
  else:
    discard

# Post sum
url = "http://localhost:9090/sum"
echo "POST request: {url}".fmt

let data = %*{
    "arr": toSeq(1..5)
}

echo "request data: ", $data
response = c.request(url,
                     httpMethod=HttpPost,
                     body= $data,
                     headers=newHttpHeaders(
                       { "Accept": "application/json"
                       , "Content-type": "application/json"
                       , "Connection": "keep-alive"
                       }
                     ))
echo response.status
case parseInt(response.status.split(" ")[0]):
  of 200:
    echo response.body
  else:
    discard
