#
#
class journald::params {
  $conf_file      = '/etc/systemd/journald.conf'
  $log_dir        = '/var/log/journal'
  $manage_service = true
}