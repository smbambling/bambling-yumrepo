# Add the Extra Packages for Enterprise Linux Repository
class yumrepo::epel (
  $epel_url         = $yumrepo::params::epel_url,
  $epel_enabled     = $yumrepo::params::epel_enabled,
  $epel_gpgcheck    = $yumrepo::params::epel_gpgcheck,
  $epel_includepkgs = $yumrepo::params::epel_includepkgs,
  $epel_exclude     = $yumrepo::params::epel_exclude,
  $epel_descr       = $yumrepo::params::epel_descr,
) inherits yumrepo::params {
  
  include yumrepo::cleanall
  
  file { "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${yumrepo::params::os_maj_release}":
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => "puppet:///modules/yumrepo/epel/RPM-GPG-KEY-EPEL-${yumrepo::params::os_maj_release}",
  }

  yumrepo::rpm_gpg_key { "EPEL-${yumrepo::params::os_maj_release}":
    path   => "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${yumrepo::params::os_maj_release}",
    before => Yumrepo['epel'],
  }

  yumrepo { 'epel':
    descr       => $epel_descr,
    baseurl     => $epel_url,
    enabled     => $epel_enabled,
    gpgcheck    => $epel_gpgcheck,
    includepkgs => $epel_includepkgs,
    exclude     => $epel_exclude,
    gpgkey      => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${yumrepo::params::os_maj_release}",
    require     => File["/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${yumrepo::params::os_maj_release}"],
    notify      => [ Exec['cleanall'], Exec['makecache'] ],
  }
}
