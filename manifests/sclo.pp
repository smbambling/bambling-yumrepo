# Add the The Software Collections ( SCL ) repository
class yumrepo::sclo (
  $sclo_name        = $yumrepo::params::sclo_name,
  $sclo_url         = $yumrepo::params::sclo_url,
  $sclo_enabled     = $yumrepo::params::sclo_enabled,
  $sclo_gpgcheck    = $yumrepo::params::sclo_gpgcheck,
  $sclo_includepkgs = $yumrepo::params::sclo_includepkgs,
  $sclo_exclude     = $yumrepo::params::sclo_exclude,
  $sclo_descr       = $yumrepo::params::sclo_descr,
) inherits yumrepo::params {

  include yumrepo::cleanall

  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-SCLo':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/yumrepo/sclo/RPM-GPG-KEY-CentOS-SIG-SCLo',
  }

  yumrepo::rpm_gpg_key { 'CentOS-SIG-SCLo':
    path   => '/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-SCLo',
    before => Yumrepo['sclo'],
  }

  yumrepo { 'sclo':
    name        => $sclo_name,
    descr       => $sclo_descr,
    baseurl     => $sclo_url,
    enabled     => $sclo_enabled,
    gpgcheck    => $sclo_gpgcheck,
    includepkgs => $sclo_includepkgs,
    exclude     => $sclo_exclude,
    gpgkey      => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-SCLo",
    notify      => [ Exec['cleanall'], ],
    target      => 'CentOS-SCLo',
  }
}
