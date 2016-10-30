# aprsd

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with aprsd](#setup)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module manages Dale A. Heatherington, WA4DSY's Amateur Radio AX.25 APRS-IS client,
[aprsd](https://sourceforge.net/projects/aprsd/).
_aprsd_ is deprecated software for most functions, but it still works well as an RF to
[APRS-IS](http://www.aprs-is.net/) gateway.

## Module Description

The aprsd Puppet module installs, configures and runs aprsd. Your system must have a working AX.25 interface which
implies Linux kernel support being appropriately configured.

## Setup

### Beginning with aprsd

First set up an AX.25 interface, for example, with [soundmodem](https://github.com/n2ygk/puppet-soundmodem).

## Usage

The following example is all you need for an RF to APRS-IS gateway, leaving it to other software
(like [aprsdigi](https://github.com/n2ygk/puppet-aprsdigi) to do the RF digipeating.

```
  class { 'aprsd':
    callsign  => 'N0NE-15',
    intf => 'sm0',
	xxx
  }

```

_aprsd_ pushes APRS packets it hears to APRS-IS. You can also monitor it via serveral ports
it listens on. For example: `telnet localhost 10151`. If you want to make these ports available
outside our server, you'll likely need to set up some firewall rules. See `templates/aprsd.conf.erb` for the
list of ports.

## Reference

### Parameters
[*callsign*]
  Amateur radio AX.25 call sign.

[*intf*]
  Network interface name. Default 'sm0'
  
[*aliases*]
  List of aliases that this digipeater responds to. Default ["TRACE","WIDE1-1","TRACE1-1"],

[*traces*]
  List of aliases that this digipester will perform tracing for. Default ["TRACE"]

[*lat*]
  _DDMM.SSn_
  Latitude of the digipeater in degrees, minutes, decimal seconds, northing. 
  Allows for increasing levels of location ambiguity by leaving blanks in the low-order digits.

  Examples:
```
    lat => "4048.  N"
    lat => "4048.56N"
```
 
[*lon*]
  _DDDMM.SSn_
  Longitude of the digipeater in degrees, minutes, decimal seconds, easting. 
  Allows for increasing levels of location ambiguity by leaving blanks in the low-order digits.
 
  Example: ```lon => "07357.61W"```

[*phg*]
  _phgd_
  Power-height-gain-directivity encoded per the [APRS specification](http://www.aprs.org/doc/APRS101.PDF)
  Chapter 7, page 38.

  Example: `phg => "7300"`

[*txt*]
  Beacon text. Example: `txt => "fill in digipeater www.weca.org"`

[*dst*]
  Destination callsign and digipeater path. Default "APRS via WIDE2-2"

[*logfile*]
  Log file path. Default "/var/log/aprsd.log",

[*kill_dupes*]
  Supress duplicate packets. Default true.

[*kill_loops*]
  Supress looping packets. Default true.

[*subst_mycall*]
  Substitute *callsign* in place of the generic digipeat alias that is consumed.

[*x1j4_xlate*]
  Translate weird X1J4 TNC software header to standard APRS format. Default true.

## Limitations

This has only been tested on x86 hardware with Fedora and CentOS with one or
two sound cards and/or USB sound adapters. It requires a kernel built with AX.25 support.
It should work with a traditional TNC on a serial port running in KISS mode.

## Development

This module shares a lot of code (via copying!) with [aprsdigi](https://github.com/n2ygk/puppet-aprsdigi).
Try to figure out a way to share the modules -- or maybe install aprsd with aprsdigi?

Clone [here](https://github.com/n2ygk/puppet-aprsd) and submit a PR!

