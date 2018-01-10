#
#
class journald::params {
  $conf_file      = '/etc/systemd/journald.conf'
  $log_dir        = '/var/log/journal'
  $service_name   = 'systemd-journald'
  $manage_service = true
}