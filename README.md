# header-popularity

Command line tool to check which headers are used the most in a
project (so you can precompile them).

## Note
This is a very simple program that just searches for '#include's in source files.
It does not (yet) deal with the fact that headers can be nested.

It also assumes that all headers have unique filenames.<br/>
For example: ```#include "foo/bar.hh"``` and ```#include "baz/bar.hh"``` are treated as the same header.

The program should give you a basic idea about header usage though.

## Usage

```console
header-popularity [SOURCE DIRS...] [OPT --verbose] [OPT --no-flames]
```

## Example
```
> header-popularity ~/dev/duel-server/core ~/dev/duel-server/embedded ~/dev/duel-server/rest-api
json.hpp                         | 7 🔥🔥🔥🔥🔥
lobby_ram_repository.hh          | 6 🔥🔥🔥🔥
magic_enum.hpp                   | 6 🔥🔥🔥🔥
server.hh                        | 5 🔥🔥🔥
utils.hh                         | 5 🔥🔥🔥
gtest.h                          | 4 🔥
lobby_upstash_repository.hh      | 4 🔥
create_lobby_controller.hh       | 3 
optional                         | 3 
spdlog.h                         | 3 
create_lobby_endpoint.hh         | 3 
show_lobby_details_endpoint.hh   | 3 
lobby.hh                         | 3 
show_free_lobby_presenter.hh     | 2 
cstdlib                          | 2 
show_free_lobby_controller.hh    | 2 
not_found_endpoint.hh            | 2 
show_lobby_details_presenter.hh  | 2 
uuid_io.hpp                      | 2 
shared.hh                        | 2 
create_lobby_presenter.hh        | 2 
root_endpoint.hh                 | 2 
show_free_lobby_endpoint.hh      | 2 
upstash_repository.hh            | 1 
ranges                           | 1 
redis_hash_commands.hh           | 1 
cassert                          | 1 
stdexcept                        | 1 

```

## Dependencies

Linux with GNUstep and CMake installed.
