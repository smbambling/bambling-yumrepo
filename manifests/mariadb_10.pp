# Add the PostgreSQL 9.3 PGDG Repository
class yumrepo::mariadb_10 (
  $mariadb_10_name        = $yumrepo::params::mariadb_10_name,
  $mariadb_10_url         = $yumrepo::params::mariadb_10_url,
  $mariadb_10_enabled     = $yumrepo::params::mariadb_10_enabled,
  $mariadb_10_gpgcheck    = $yumrepo::params::mariadb_10_gpgcheck,
  $mariadb_10_includepkgs = $yumrepo::params::mariadb_10_includepkgs,
  $mariadb_10_exclude     = $yumrepo::params::mariadb_10_exclude,
  $mariadb_10_descr       = $yumrepo::params::mariadb_10_descr,
) inherits yumrepo::params {

  include yumrepo::cleanall

  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-MariaDB':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/yumrepo/mariadb/RPM-GPG-KEY-MariaDB',
  }

  yumrepo::rpm_gpg_key { 'MariaDB':
    path   => '/etc/pki/rpm-gpg/RPM-GPG-KEY-MariaDB',
    before => Yumrepo['mariadb_10'],
  }

  yumrepo { 'mariadb_10':
    name        => $mariadb_10_name,
    descr       => $mariadb_10_descr,
    baseurl     => $mariadb_10_url,
    enabled     => $mariadb_10_enabled,
    gpgcheck    => $mariadb_10_gpgcheck,
    includepkgs => $mariadb_10_includepkgs,
    exclude     => $mariadb_10_exclude,
    gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-MariaDB',
    require     => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-MariaDB'],
    notify      => [ Exec['cleanall'], ],
  }
}
