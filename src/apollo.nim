# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import apollopkg/submodule
import arraymancer
import asynchttpserver, asyncdispatch, httpcore, sequtils, json, sequtils
import rosencrantz

proc sum(params: seq[float]): auto =
  let t = params.toTensor
  t.sum

let handler = get[
  path("/hello")[
    logRequest("$1 $2\n$3")[
      ok("Hello, World")
    ]
  ]
] ~ post[
  path("/world")[
      accept("application/json")[
        contentType("application/json")[
            jsonBody(proc(j: JsonNode): auto =
              ok(%*{"echo": j})
            )
        ]
      ]
  ] ~ path("/sum")[
    logRequest("$1 $2\n$3")[
      accept("application/json")[
        contentType("application/json")[
            jsonBody(proc(j: JsonNode): auto =
                let a = map(j["arr"].getElems, proc(n: JsonNode): float = n.getFloat)
                ok(%*{"sum": a.sum})
            )
        ]
      ]
    ]
  ]
]

when isMainModule:
  let server = newAsyncHttpServer()
  waitFor server.serve(Port(9090), handler)
