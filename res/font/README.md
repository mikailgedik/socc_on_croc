# Font Generation for _socc on croc_

Just run the script, e.g.

```sh
./ttf2bitmap.py
./bitmap2svrom.py
dd if=raw.bin count=1 bs=1024 of=rom0.bin
dd if=raw.bin count=1 bs=1024 of=rom1.bin skip=1
dd if=raw.bin count=2 bs=1024 of=rom2.bin skip=2
dd if=raw.bin count=3 bs=1024 of=rom3.bin skip=3

```
You want to use the script 'scripts/gen_bootrom.py' to generate the actual font-roms. You can generate the lower and upper part separately, to avoid congestion during routing
## License

CL-GD5320 ('Eagle III') VGA" font by VileR is licensed under CC BY-SA 4.0. 

* https://int10h.org/oldschool-pc-fonts/fontlist/?3#cirruslogic

* https://int10h.org/oldschool-pc-fonts/readme/#legal_stuff

The binary font data embedded in the ROM of this device is an adaptation of VileR's work and is therefore freely available under the CC BY-SA 4.0 license.