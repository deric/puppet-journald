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
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
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
  $options        = {}
) inherits ::journald::params {

  $defaults = {
    'path' => $conf_file
  }

  if $manage_service {
    service { 'systemd-journald':
      ensure    => 'running',
      subscribe => $conf_file,
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
