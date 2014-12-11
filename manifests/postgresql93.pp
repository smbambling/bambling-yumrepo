# Add the Extra Packages for Enterprise Linux Repository
class yumrepo::postgresql (
  $postgresql_url         = $yumrepo::params::postgresql_url,
  $postgresql_enabled     = $yumrepo::params::postgresql_enabled,
  $postgresql_gpgcheck    = $yumrepo::params::postgresql_gpgcheck,
  $postgresql_includepkgs = $yumrepo::params::postgresql_includepkgs,
  $postgresql_exclude     = $yumrepo::params::postgresql_exclude,
  $postgresql_descr       = $yumrepo::params::postgresql_descr,
) inherits yumrepo::params {
  
  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-93':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/yumrepo/postgresql/RPM-GPG-KEY-PGDG-93',
  }

  yumrepo::rpm_gpg_key { 'PGDG-93':
    path   => '/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-93',
    before => Yumrepo['postgresql'],
  }

  yumrepo { 'postgresql':
    descr       => $postgresql_descr,
    baseurl     => $postgresql_url,
    enabled     => $postgresql_enabled,
    gpgcheck    => $postgresql_gpgcheck,
    includepkgs => $postgresql_includepkgs,
    exclude     => $postgresql_exclude,
    gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-93',
    require     => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-93'],
  }
}
