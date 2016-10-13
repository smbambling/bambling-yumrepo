# Add the Extra Packages for Enterprise Linux Repository
class yumrepo::collect_ci (
  $collect_ci_url         = $yumrepo::params::collect_ci_url,
  $collect_ci_enabled     = $yumrepo::params::collect_ci_enabled,
  $collect_ci_gpgcheck    = $yumrepo::params::collect_ci_gpgcheck,
  $collect_ci_includepkgs = $yumrepo::params::collect_ci_includepkgs,
  $collect_ci_exclude     = $yumrepo::params::collect_ci_exclude,
  $collect_ci_descr       = $yumrepo::params::collect_ci_descr,
) inherits yumrepo::params {

  include yumrepo::cleanall

  file { "/etc/pki/rpm-gpg/RPM-GPG-KEY-Collectd-CI":
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => "puppet:///modules/yumrepo/collect_ci/RPM-GPG-KEY-Collectd-CI",
  }

  yumrepo::rpm_gpg_key { "Collectd-CI":
    path   => "/etc/pki/rpm-gpg/RPM-GPG-KEY-Collectd-CI",
    before => Yumrepo['collect_ci'],
  }

  yumrepo { 'collect_ci':
    descr       => $collect_ci_descr,
    baseurl     => $collect_ci_url,
    enabled     => $collect_ci_enabled,
    gpgcheck    => $collect_ci_gpgcheck,
    includepkgs => $collect_ci_includepkgs,
    exclude     => $collect_ci_exclude,
    gpgkey      => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Collectd-CI",
    require     => File["/etc/pki/rpm-gpg/RPM-GPG-KEY-Collectd-CI"],
    notify      => [ Exec['cleanall'], ],
  }
}
