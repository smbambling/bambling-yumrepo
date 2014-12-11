# Add the Extra Packages for Enterprise Linux Repository
class yumrepo::icinga (
  $icinga_url         = $yumrepo::params::icinga_url,
  $icinga_enabled     = $yumrepo::params::icinga_enabled,
  $icinga_gpgcheck    = $yumrepo::params::icinga_gpgcheck,
  $icinga_includepkgs = $yumrepo::params::icinga_includepkgs,
  $icinga_exclude     = $yumrepo::params::icinga_exclude,
  $icinga_descr       = $yumrepo::params::icinga_descr,
) inherits yumrepo::params {
  
  file { "/etc/pki/rpm-gpg/icinga.key":
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => "puppet:///modules/yumrepo/icinga/icinga.key",
  }

  yumrepo::rpm_gpg_key { "icinga.key":
    path   => "/etc/pki/rpm-gpg/icinga.key",
    before => Yumrepo['icinga'],
  }

  yumrepo { 'icinga':
    descr       => $icinga_descr,
    baseurl     => $icinga_url,
    enabled     => $icinga_enabled,
    gpgcheck    => $icinga_gpgcheck,
    includepkgs => $icinga_includepkgs,
    exclude     => $icinga_exclude,
    gpgkey      => "file:///etc/pki/rpm-gpg/icinga.key",
    require     => File["/etc/pki/rpm-gpg/icinga.key"],
  }
}
