# Package

version       = "0.1.0"
author        = "tomohiko okazaki"
description   = "simple web server"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
binDir        = "bin"
bin           = @["apollo", "apollo_client"]


# Dependencies

requires "nim >= 0.19.0"
requires "Arraymancer"
requires "rosencrantz"
requires "stb_image"
