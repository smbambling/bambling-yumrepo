# Add the Extra Packages for Enterprise Linux Repository
class yumrepo::collectd_ci (
  $collectd_ci_url         = $yumrepo::params::collect_ci_url,
  $collectd_ci_enabled     = $yumrepo::params::collect_ci_enabled,
  $collectd_ci_gpgcheck    = $yumrepo::params::collect_ci_gpgcheck,
  $collectd_ci_includepkgs = $yumrepo::params::collect_ci_includepkgs,
  $collectd_ci_exclude     = $yumrepo::params::collect_ci_exclude,
  $collectd_ci_descr       = $yumrepo::params::collect_ci_descr,
) inherits yumrepo::params {

  include yumrepo::cleanall

  file { "/etc/pki/rpm-gpg/RPM-GPG-KEY-Collectd-CI":
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => "puppet:///modules/yumrepo/collectd_ci/RPM-GPG-KEY-Collectd-CI",
  }

  yumrepo::rpm_gpg_key { "Collectd-CI":
    path   => "/etc/pki/rpm-gpg/RPM-GPG-KEY-Collectd-CI",
    before => Yumrepo['collect_ci'],
  }

  yumrepo { 'collectd_ci':
    descr       => $collectd_ci_descr,
    baseurl     => $collectd_ci_url,
    enabled     => $collectd_ci_enabled,
    gpgcheck    => $collectd_ci_gpgcheck,
    includepkgs => $collectd_ci_includepkgs,
    exclude     => $collectd_ci_exclude,
    gpgkey      => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Collectd-CI",
    require     => File["/etc/pki/rpm-gpg/RPM-GPG-KEY-Collectd-CI"],
    notify      => [ Exec['cleanall'], ],
  }
}
