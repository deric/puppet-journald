# puppet-journald

Module for managing journald configuration.

```puppet
class { 'journald':
  options => {
    'Storage' => 'auto',
  }
}
```
or from Hiera:

```yaml
journald::options:
  Storage: 'auto'
  Compress: 'yes'
```

## Parameters

* `conf_file` path to `systemd-journald` configuration file
* `log_dir`
* `manage_service` whether Puppet should manage journald service (default: `true`)
* `service_name` name of the journald service
* `options` hash containing journald directives, see `[man journald.conf](https://www.freedesktop.org/software/systemd/man/journald.conf.html)`

## Requirements

 * Puppet 4 and newer
