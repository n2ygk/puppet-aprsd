class aprsd::service inherits aprsd {
  service { 'aprsd':
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
