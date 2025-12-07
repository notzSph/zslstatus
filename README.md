# zSlstatus

![Version](https://img.shields.io/badge/version-2.0.0-blue)
![Build Status](https://img.shields.io/badge/build-passing-brightgreen)
![Language](https://img.shields.io/badge/language-C-informational)
![Display](https://img.shields.io/badge/display-X11-lightgrey)
![License](https://img.shields.io/badge/license-MIT--X-lightgrey)

## Description

`zSlstatus` is a personal fork of [slstatus](https://tools.suckless.org/slstatus/),  
a lightweight status monitor typically used with window managers like `dwm` / `zdwm`.

It periodically collects system information via modular components and writes a
formatted status line (usually to the X root window) for display in a bar.

---

## Features

- Modular component system (CPU, RAM, disk, Wi-Fi, battery, datetime, etc.)
- Simple C configuration in `config.def.h` / `config.h`
- Tiny, static\-friendly binary
- Designed to pair nicely with `zDwm` and `zDmenu`

---

## Requirements

To build `zSlstatus` you need:

- A C compiler (e.g. `cc`, `clang`, or `gcc`)
- Standard libc headers
- Any extra libs for optional components you use (e.g. ALSA, Pulse, etc.)

Check `config.mk` if you add any additional libraries (e.g. `-lasound`).

---

## Installation

Edit `config.mk` to match your environment (prefix, manpaths, compiler flags):

```sh
make clean install
