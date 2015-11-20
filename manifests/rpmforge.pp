# Add the Extra Packages for Enterprise Linux Repository
class yumrepo::rpmforge (
  $rpmforge_url         = $yumrepo::params::rpmforge_url,
  $rpmforge_enabled     = $yumrepo::params::rpmforge_enabled,
  $rpmforge_gpgcheck    = $yumrepo::params::rpmforge_gpgcheck,
  $rpmforge_includepkgs = $yumrepo::params::rpmforge_includepkgs,
  $rpmforge_exclude     = $yumrepo::params::rpmforge_exclude,
  $rpmforge_descr       = $yumrepo::params::rpmforge_descr,
  $rpmforge_mirrolist   = $yumrepo::params::rpmforge_mirrorlist,
) inherits yumrepo::params {
  
  include yumrepo::cleanall
  
  file { "/etc/pki/rpm-gpg/RPM-GPG-KEY-RPMFORGE-${yumrepo::params::os_maj_release}":
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => "puppet:///modules/yumrepo/rpmforge/RPM-GPG-KEY-RPMFORGE-${yumrepo::params::os_maj_release}",
  }

  yumrepo::rpm_gpg_key { "RPMFORGE-${yumrepo::params::os_maj_release}":
    path   => "/etc/pki/rpm-gpg/RPM-GPG-KEY-RPMFORGE-${yumrepo::params::os_maj_release}",
    before => Yumrepo['rpmforge'],
  }

  yumrepo { 'rpmforge':
    descr       => $rpmforge_descr,
    baseurl     => $rpmforge_url,
    enabled     => $rpmforge_enabled,
    gpgcheck    => $rpmforge_gpgcheck,
    includepkgs => $rpmforge_includepkgs,
    exclude     => $rpmforge_exclude,
    mirrorlist  => $rpmforge_mirrorlist,
    gpgkey      => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-RPMFORGE-${yumrepo::params::os_maj_release}",
    require     => File["/etc/pki/rpm-gpg/RPM-GPG-KEY-RPMFORGE-${yumrepo::params::os_maj_release}"],
    notify      => [ Exec['cleanall'], ],
  }
}
