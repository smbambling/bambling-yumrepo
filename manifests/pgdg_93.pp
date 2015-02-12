# Add the PostgreSQL 9.3 PGDG Repository
class yumrepo::pgdg_93 (
  $pgdg_93_name        = $yumrepo::params::pgdg_93_name,
  $pgdg_93_url         = $yumrepo::params::pgdg_93_url,
  $pgdg_93_enabled     = $yumrepo::params::pgdg_93_enabled,
  $pgdg_93_gpgcheck    = $yumrepo::params::pgdg_93_gpgcheck,
  $pgdg_93_includepkgs = $yumrepo::params::pgdg_93_includepkgs,
  $pgdg_93_exclude     = $yumrepo::params::pgdg_93_exclude,
  $pgdg_93_descr       = $yumrepo::params::pgdg_93_descr,
) inherits yumrepo::params {

  include yumrepo::cleanall
  
  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-93':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/yumrepo/pgdg_93/RPM-GPG-KEY-PGDG-93',
  }

  yumrepo::rpm_gpg_key { 'PGDG-93':
    path   => '/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-93',
    before => Yumrepo['pgdg_93'],
  }

  yumrepo { 'pgdg_93':
    name        => $pgdg_93_name,
    descr       => $pgdg_93_descr,
    baseurl     => $pgdg_93_url,
    enabled     => $pgdg_93_enabled,
    gpgcheck    => $pgdg_93_gpgcheck,
    includepkgs => $pgdg_93_includepkgs,
    exclude     => $pgdg_93_exclude,
    gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-93',
    require     => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-93'],
    notify      => [ Exec['cleanall'], Exec['makecache'] ],
  }
}
