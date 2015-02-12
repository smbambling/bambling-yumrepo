# Add the PostgreSQL 9.4 PGDG Repository
class yumrepo::postgresql_9_4 (
  $postgresql_9_4_url         = $yumrepo::params::postgresql_9_4_url,
  $postgresql_9_4_enabled     = $yumrepo::params::postgresql_9_4_enabled,
  $postgresql_9_4_gpgcheck    = $yumrepo::params::postgresql_9_4_gpgcheck,
  $postgresql_9_4_includepkgs = $yumrepo::params::postgresql_9_4_includepkgs,
  $postgresql_9_4_exclude     = $yumrepo::params::postgresql_9_4_exclude,
  $postgresql_9_4_descr       = $yumrepo::params::postgresql_9_4_descr,
) inherits yumrepo::params {

  include yumrepo::cleanall
  
  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-94':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/yumrepo/postgresql_9_4/RPM-GPG-KEY-PGDG-94',
  }

  yumrepo::rpm_gpg_key { 'PGDG-94':
    path   => '/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-94',
    before => Yumrepo['postgresql_9_4'],
  }

  yumrepo { 'postgresql_9_4':
    name        => $postgresql_9_4_name,
    descr       => $postgresql_9_4_descr,
    baseurl     => $postgresql_9_4_url,
    enabled     => $postgresql_9_4_enabled,
    gpgcheck    => $postgresql_9_4_gpgcheck,
    includepkgs => $postgresql_9_4_includepkgs,
    exclude     => $postgresql_9_4_exclude,
    gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-94',
    require     => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-94'],
    notify      => [ Exec['cleanall'], Exec['makecache'] ],
  }
}
