# docker-nuke

This fork runs without modification and removes the GUI capabilities for it to run solely via the terminal. Intended for continuous integration, like Travis-CI.

```bash
$ docker build -t nuke https://github.com/mottosso/docker-nuke.git
$ docker run -ti --rm nuke -t
Nuke 10.0v2, 64 bit, built May 27 2016.
Copyright (c) 2016 The Foundry Visionmongers Ltd.  All Rights Reserved.
>>> 
```

- [Details](https://www.thefoundry.co.uk/products/nuke/developers/63/pythondevguide/command_line.html)
