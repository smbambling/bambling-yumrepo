# Add the PostgreSQL 9.3 PGDG Repository
class yumrepo::postgresql_9_3 (
  $postgresql_9_3_url         = $yumrepo::params::postgresql_9_3_url,
  $postgresql_9_3_enabled     = $yumrepo::params::postgresql_9_3_enabled,
  $postgresql_9_3_gpgcheck    = $yumrepo::params::postgresql_9_3_gpgcheck,
  $postgresql_9_3_includepkgs = $yumrepo::params::postgresql_9_3_includepkgs,
  $postgresql_9_3_exclude     = $yumrepo::params::postgresql_9_3_exclude,
  $postgresql_9_3_descr       = $yumrepo::params::postgresql_9_3_descr,
) inherits yumrepo::params {
  
  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-93':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/yumrepo/postgresql_9_3/RPM-GPG-KEY-PGDG-93',
  }

  yumrepo::rpm_gpg_key { 'PGDG-93':
    path   => '/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-93',
    before => Yumrepo['postgresql_9_3'],
  }

  yumrepo { 'postgresql_9_3':
    descr       => $postgresql_9_3_descr,
    baseurl     => $postgresql_9_3_url,
    enabled     => $postgresql_9_3_enabled,
    gpgcheck    => $postgresql_9_3_gpgcheck,
    includepkgs => $postgresql_9_3_includepkgs,
    exclude     => $postgresql_9_3_exclude,
    gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-93',
    require     => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-93'],
  }
}
