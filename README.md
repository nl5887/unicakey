# UniCaKey

Python2 and Python3 including the following modules:

- [Keystone Engine](http://www.keystone-engine.org/)
- [Capstone Engine](http://www.capstone-engine.org/)
- [Unicorn Engine](http://www.unicorn-engine.org/)

## Build

```
docker build . -t unicakey
```

## Usage

```
docker run -it --rm unicakey /bin/bash
docker run -it --rm -v $(pwd):/data:ro unicakey python2 test.py
docker run -it --rm -v $(pwd):/data:ro unicakey python3 test.py
```
