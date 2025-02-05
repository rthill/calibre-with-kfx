# Calibre with KFX Docker

A Docker image based on linuxserver.io Calibre (KasmVNC) for converting eBooks including KFX support from yshalsager/calibre-with-kfx.

> KFX is Amazon's proprietary eBook format used for Kindle devices.

## Why?

Because Amazon's [Kindle Previewer 3](https://kdp.amazon.com/en_US/help/topic/G202131170) is the only way currently to convert books into KFX using [Calibre](https://calibre-ebook.com/) [KFX Input](https://www.mobileread.com/forums/showthread.php?t=291290)
and [KFX Output](https://www.mobileread.com/forums/showthread.php?t=272407) plugins, and it's not available on Linux, so I run it under docker using [Wine](https://appdb.winehq.org/objectManager.php?sClass=application&iId=18012).

## Sources

  - https://github.com/linuxserver/docker-calibre
  - https://github.com/yshalsager/calibre-with-kfx

## More information

  - https://docs.linuxserver.io/images/docker-calibre/
  - https://hub.docker.com/r/linuxserver/calibre