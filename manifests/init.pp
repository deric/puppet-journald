# Class: journald
# ===========================
#
# Manages journald configuration
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `options`
# Hash containing journald configuration.
#
#
# Examples
# --------
#
# @example
#    class { 'journald':
#      options => {'Storage' => 'auto'},
#    }
#
# Authors
# -------
#
# Tomas Barton <barton.tomas@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2018 Tomas Barton.
#
class journald (
  String  $conf_file      = '/etc/systemd/journald.conf',
  String  $log_dir        = '/var/log/journal',
  Boolean $manage_service = true,
  String  $service_name   = 'systemd-journald',
  Hash    $options        = {},
) {

  if $manage_service {
    service { $service_name:
      ensure    => 'running',
    }

    $defaults = {
      'path' => $conf_file,
      'notify' => Service[$service_name],
    }
  } else {
    $defaults = {
      'path' => $conf_file,
    }
  }

  if $options {
    inifile::create_ini_settings({ 'Journal' => $options }, $defaults)
    if $options['Storage'] == 'volatile' {
      file { $log_dir:
        ensure => absent,
        force  => true,
      }
    }
  }

}
