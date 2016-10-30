class aprsd::config inherits aprsd {
  file { '/etc/ax25':
    ensure  => directory,
  }
  # build up the aprsd options to look something like this:

  $beacon_text = "!${lat}/${lon}#PHG${phg}/${txt}"
  file { '/etc/aprsd/aprsd.conf':
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template('aprsd/aprsd.conf.erb'),
  }
}
