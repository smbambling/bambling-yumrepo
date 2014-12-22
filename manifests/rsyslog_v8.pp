# Add the Adiscon Rsyslog Version 8 Repository
class yumrepo::rsyslog_v8 (
  $rsyslog_v8_url         = $yumrepo::params::rsyslog_v8_url,
  $rsyslog_v8_enabled     = $yumrepo::params::rsyslog_v8_enabled,
  $rsyslog_v8_gpgcheck    = $yumrepo::params::rsyslog_v8_gpgcheck,
  $rsyslog_v8_includepkgs = $yumrepo::params::rsyslog_v8_includepkgs,
  $rsyslog_v8_exclude     = $yumrepo::params::rsyslog_v8_exclude,
  $rsyslog_v8_descr       = $yumrepo::params::rsyslog_v8_descr,
) inherits yumrepo::params {

  include yumrepo::cleanall
  
  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-Adiscon':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/yumrepo/rsyslog_v8/RPM-GPG-KEY-Adiscon',
  }

  yumrepo::rpm_gpg_key { 'RPM-GPG-KEY-Adiscon':
    path   => '/etc/pki/rpm-gpg/RPM-GPG-KEY-Adiscon',
    before => Yumrepo['rsyslog_v8'],
  }

  yumrepo { 'rsyslog_v8':
    descr       => $rsyslog_v8_descr,
    baseurl     => $rsyslog_v8_url,
    enabled     => $rsyslog_v8_enabled,
    gpgcheck    => $rsyslog_v8_gpgcheck,
    includepkgs => $rsyslog_v8_includepkgs,
    exclude     => $rsyslog_v8_exclude,
    gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Adiscon',
    require     => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-Adiscon'],
    notify      => [ Exec['cleanall'], Exec['makecache'] ],
  }
}
