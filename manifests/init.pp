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
  String $conf_file      = $::journald::params::conf_file,
  String $log_dir        = $::journald::params::log_dir,
  Boolean $manage_service = $::journald::params::manage_service,
  String $service_name   = $::journald::params::service_name,
  Hash $options        = {},
) inherits ::journald::params {

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
    create_ini_settings({ 'Journal' => $options }, $defaults)
    if $options['Storage'] == 'volatile' {
      file { $log_dir:
        ensure => absent,
        force  => true,
      }
    }
  }

}
