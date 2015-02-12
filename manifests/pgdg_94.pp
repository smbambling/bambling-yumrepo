# Add the PostgreSQL 9.4 PGDG Repository
class yumrepo::pgdg_94 (
  $pgdg_94_name        = $yumrepo::params::pgdg_94_name,
  $pgdg_94_url         = $yumrepo::params::pgdg_94_url,
  $pgdg_94_enabled     = $yumrepo::params::pgdg_94_enabled,
  $pgdg_94_gpgcheck    = $yumrepo::params::pgdg_94_gpgcheck,
  $pgdg_94_includepkgs = $yumrepo::params::pgdg_94_includepkgs,
  $pgdg_94_exclude     = $yumrepo::params::pgdg_94_exclude,
  $pgdg_94_descr       = $yumrepo::params::pgdg_94_descr,
) inherits yumrepo::params {

  include yumrepo::cleanall
  
  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-94':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/yumrepo/pgdg_94/RPM-GPG-KEY-PGDG-94',
  }

  yumrepo::rpm_gpg_key { 'PGDG-94':
    path   => '/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-94',
    before => Yumrepo['pgdg_94'],
  }

  yumrepo { 'pgdg_94':
    name        => $pgdg_94_name,
    descr       => $pgdg_94_descr,
    baseurl     => $pgdg_94_url,
    enabled     => $pgdg_94_enabled,
    gpgcheck    => $pgdg_94_gpgcheck,
    includepkgs => $pgdg_94_includepkgs,
    exclude     => $pgdg_94_exclude,
    gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-94',
    require     => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-94'],
    notify      => [ Exec['cleanall'], Exec['makecache'] ],
  }
}
