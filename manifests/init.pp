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
  $conf_file      = $::journald::params::conf_file,
  $log_dir        = $::journald::params::log_dir,
  $manage_service = $::journald::params::manage_service,
  $options        = {},
) inherits ::journald::params {

  $defaults = {
    'path' => $conf_file,
    'notify' => Service['systemd-journald'],
  }

  if $manage_service {
    service { 'systemd-journald':
      ensure    => 'running',
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
