class aprsd::config inherits aprsd {
  if !File['/etc/ax25'] {
    file { '/etc/ax25':
      ensure  => directory,
    }
  }
  $beacon_text = "!${lat}/${lon}#PHG${phg}/${txt}"
  file { '/etc/aprsd/aprsd.conf':
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template('aprsd/aprsd.conf.erb'),
  }
}
