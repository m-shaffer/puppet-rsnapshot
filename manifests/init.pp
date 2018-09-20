# == Class: rsnapshot
#
# Manages rsnapshot.
#
# === Parameters
#
class rsnapshot (
  $hosts                   = $rsnapshot::params::hosts,
  $conf_d                  = $rsnapshot::params::conf_d,
  $logpath                 = $rsnapshot::params::config_logpath,
  $lockpath                = $rsnapshot::params::config_lockpath,
  $default_backup          = $rsnapshot::params::config_default_backup,
  $package_name            = $rsnapshot::params::package_name,
  $package_ensure          = $rsnapshot::params::package_ensure,
  $cron                    = $rsnapshot::params::cron,
  $backup_scripts          = $rsnapshot::params::backup_scripts,
  $include                 = $rsnapshot::params::config_include,
  $exclude                 = $rsnapshot::params::config_exclude,
  $snapshot_root           = $rsnapshot::params::config_snapshot_root,
  $backup_levels           = $rsnapshot::params::config_backup_levels,
  $backup_user             = $rsnapshot::params::config_backup_user,
  $cron_service_name       = $rsnapshot::params::cron_service_name,
  $manage_cron             = $rsnapshot::params::manage_cron,
  $cronfile_prefix         = $rsnapshot::params::config_cronfile_prefix,
  $cronfile_prefix_use     = $rsnapshot::params::config_cronfile_prefix_use,
  $check_mk_job            = $rsnapshot::params::config_check_mk_job,
  $backup_defaults         = $rsnapshot::params::config_backup_defaults,
  $cmd_cp                  = $rsnapshot::params::config_cmd_cp,
  $cmd_rsync               = $rsnapshot::params::config_cmd_rsync,
  $cmd_ssh                 = $rsnapshot::params::config_cmd_ssh,
  $cmd_logger              = $rsnapshot::params::config_cmd_logger,
  $cmd_du                  = $rsnapshot::params::config_cmd_du,
  $cmd_rsnapshot_diff      = $rsnapshot::params::config_cmd_rsnapshot_diff,
  $cmd_preexec             = $rsnapshot::params::config_cmd_preexec,
  $cmd_postexec            = $rsnapshot::params::config_cmd_postexec,
  $use_lvm                 = $rsnapshot::params::config_use_lvm,
  $linux_lvm_cmd_lvcreate  = $rsnapshot::params::config_linux_lvm_cmd_lvcreate,
  $linux_lvm_cmd_lvremove  = $rsnapshot::params::config_linux_lvm_cmd_lvremove,
  $linux_lvm_cmd_mount     = $rsnapshot::params::config_linux_lvm_cmd_mount,
  $linux_lvm_cmd_umount    = $rsnapshot::params::config_linux_lvm_cmd_umount,
  $linux_lvm_snapshotsize  = $rsnapshot::params::config_linux_lvm_snapshotsize,
  $linux_lvm_snapshotname  = $rsnapshot::params::config_linux_lvm_snapshotname,
  $linux_lvm_vgpath        = $rsnapshot::params::config_linux_lvm_vgpath,
  $linux_lvm_mountpath     = $rsnapshot::params::config_linux_lvm_mountpath,
  $no_create_root          = $rsnapshot::params::config_no_create_root,
  $verbose                 = $rsnapshot::params::config_verbose,
  $loglevel                = $rsnapshot::params::config_loglevel,
  $stop_on_stale_lockfile  = $rsnapshot::params::config_stop_on_stale_lockfile,
  $rsync_short_args        = $rsnapshot::params::config_rsync_short_args,
  $rsync_long_args         = $rsnapshot::params::config_rsync_long_args,
  $ssh_args                = $rsnapshot::params::config_ssh_args,
  $du_args                 = $rsnapshot::params::config_du_args,
  $one_fs                  = $rsnapshot::params::config_one_fs,
  $interval                = $rsnapshot::params::config_interval,
  $retain                  = $rsnapshot::params::config_retain,
  $include_file            = $rsnapshot::params::config_include_file,
  $exclude_file            = $rsnapshot::params::config_exclude_file,
  $link_dest               = $rsnapshot::params::config_link_dest,
  $sync_first              = $rsnapshot::params::config_sync_first,
  $use_lazy_deletes        = $rsnapshot::params::config_use_lazy_deletes,
  $rsync_numtries          = $rsnapshot::params::config_rsync_numtries,

) inherits rsnapshot::params {

  $default_backup_scripts = $rsnapshot::params::backup_scripts + $backup_scripts
  $default_exclude        = $rsnapshot::params::config_exclude + $exclude
  if $hosts {
    class { '::rsnapshot::install': }->
    class { '::rsnapshot::config': }~>
    class { '::rsnapshot::service': }
    contain '::rsnapshot::install'
    contain '::rsnapshot::config'
    contain '::rsnapshot::service'
  }
}
