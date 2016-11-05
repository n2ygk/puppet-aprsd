# == Class: aprsd
#
# Install and configure Dale A. Heatherington, WA4DSY's Amateur Radio AX.25 APRS-IS client.
#
# === Parameters
#
# Document parameters here.
#
# [*callsign*]
#   Amateur radio AX.25 call sign.
# 
# [*intf*]
#   Network interface name. Default 'sm0'
#   
# [*aliases*]
#   List of aliases that this digipeater responds to. Default ["TRACE","WIDE1-1","TRACE1-1"],
# 
# [*traces*]
#   List of aliases that this digipester will perform tracing for. Default ["TRACE"]
# 
# [*lat*]
#   _DDMM.SSn_
#   Latitude of the digipeater in degrees, minutes, decimal seconds, northing. 
#   Allows for increasing levels of location ambiguity by leaving blanks in the low-order digits.
#
#   Examples: ```
#     lat => "4048.  N"
#     lat => "4048.56N"
#   ```
# 
# [*lon*]
#   _DDDMM.SSn_
#   Longitude of the digipeater in degrees, minutes, decimal seconds, easting. 
#   Allows for increasing levels of location ambiguity by leaving blanks in the low-order digits.
# 
#   Examples: ```
#     lon => "07357.61W"
#   ```
#
# [*phg*]
#   _phgd_
#   Power-height-gain-directivity encoded per the [APRS specification](http://www.aprs.org/doc/APRS101.PDF)
#   Chapter 7, page 38.
# 
#   Example: `phg => "7300"`
# 
# [*txt*]
#   Beacon text. Example: `txt => "fill in digipeater www.weca.org"`
# 
# [*dst*]
#   Destination callsign and digipeater path. Default "APRS via WIDE2-2"
#
# [*logfile*]
#   Log file path. Default "/var/log/aprsd.log",
# 
# [*kill_dupes*]
#   Supress duplicate packets. Default true.
# 
# [*kill_loops*]
#   Supress looping packets. Default true.
# 
# [*subst_mycall*]
#   Substitute *callsign* in place of the generic digipeat alias that is consumed.
# 
# [*x1j4_xlate*]
#   Translate weird X1J4 TNC software header to standard APRS format. Default true.
#
# === Examples
#
#  class { 'aprsd':
#    callsign                     => 'N0NE-15',
#    intf                         => 'sm0',
#  }
#
# === Authors
#
# Alan Crosswell <n2ygk@weca.org>
#
# === Copyright
#
# Copyright 2016 Alan Crosswell
#
class aprsd (
  $callsign                = $aprsd::params::callsign,
  $location                = $aprsd::params::location,
  $email                   = $aprsd::params::email,
  $intf                    = $aprsd::params::intf,
  $netbeacon_time          = $aprsd::params::netbeacon_time,
  $lat	                   = $aprsd::params::lat,
  $lon		           = $aprsd::params::lon,
  $phg		           = $aprsd::params::phg,
  $txt		           = $aprsd::params::txt,
  $dst		           = $aprsd::params::dst,
  $logdir	           = $aprsd::params::logdir,
  $aprs_is_pass            = $aprsd::params::aprs_is_pass,
  $aprs_is_server          = $aprsd::params::aprs_is_server,
  $rawtncport              = $aprsd::params::rawtncport,
  $localport               = $aprsd::params::localport,
  $mainport                = $aprsd::params::mainport,
  $mainport_nh             = $aprsd::params::mainport_nh,
  $linkport                = $aprsd::params::linkport,
  $msgport                 = $aprsd::params::msgport,
  $udpport                 = $aprsd::params::udpport,
  $sysopPort               = $aprsd::params::sysopPort,
  $httpport                = $aprsd::params::httpport,
  $ipwatchport             = $aprsd::params::ipwatchport,
  $errorport               = $aprsd::params::errorport,
  $omniport                = $aprsd::params::omniport,
) inherits aprsd::params {
  validate_string($callsign)
  validate_string($location)
  validate_string($intf)
  validate_integer($netbeacon_time)
  validate_string($dst)
  validate_string($lat)
  validate_string($lon)
  validate_string($phg)
  validate_string($txt)
  validate_absolute_path($logdir)
  validate_string($aprs_is_pass)
  validate_string($aprs_is_server)
  validate_string($rawtncport)
  validate_string($localport)
  validate_string($mainport)
  validate_string($mainport_nh)
  validate_string($linkport)
  validate_string($msgport)
  validate_string($udpport)
  validate_string($sysopPort)
  validate_string($httpport)
  validate_string($ipwatchport)
  validate_string($errorport)
  validate_string($omniport)

  anchor { 'aprsd::begin': } ->
  class { '::aprsd::install': } ->
  class { '::aprsd::config': } ~>
  class { '::aprsd::service': } ->
  anchor { 'aprsd::end': }

}
