# Add the The Software Collections ( SCL ) repository
class yumrepo::scl (
  $scl_name        = $yumrepo::params::scl_name,
  $scl_url         = $yumrepo::params::scl_url,
  $scl_enabled     = $yumrepo::params::scl_enabled,
  $scl_gpgcheck    = $yumrepo::params::scl_gpgcheck,
  $scl_includepkgs = $yumrepo::params::scl_includepkgs,
  $scl_exclude     = $yumrepo::params::scl_exclude,
  $scl_descr       = $yumrepo::params::scl_descr,
) inherits yumrepo::params {

  include yumrepo::cleanall

  yumrepo { 'scl':
    name        => $scl_name,
    descr       => $scl_descr,
    baseurl     => $scl_url,
    enabled     => $scl_enabled,
    gpgcheck    => $scl_gpgcheck,
    includepkgs => $scl_includepkgs,
    exclude     => $scl_exclude,
    gpgkey      => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${yumrepo::params::os_maj_release}",
    notify      => [ Exec['cleanall'], Exec['makecache'] ],
    target      => 'CentOS-SCL',
  }
}
