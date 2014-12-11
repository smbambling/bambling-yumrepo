# Add the Puppet Labs Products and Dependencies Repositories
class yumrepo::foreman (
  $foreman_url         = $yumrepo::params::foreman_url,
  $foreman_enabled     = $yumrepo::params::foreman_enabled,
  $foreman_gpgcheck    = $yumrepo::params::foreman_gpgcheck,
  $foreman_includepkgs = $yumrepo::params::foreman_includepkgs,
  $foreman_exclude     = $yumrepo::params::foreman_exclude,
  $foreman_descr        = $yumrepo::params::foreman_descr,
) {

  include yumrepo::params

  if $yumrepo::params::os_maj_release == '6' or $yumrepo::params::os_maj_release == '7' {
    file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-foreman':
      ensure => present,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/foreman/RPM-GPG-KEY-foreman',
    }

    yumrepo::rpm_gpg_key { 'foreman':
      path   => '/etc/pki/rpm-gpg/RPM-GPG-KEY-foreman',
      before => Yumrepo['foreman'],
    }

    yumrepo { 'foreman':
      descr       => $foreman_descr,
      baseurl     => $foreman_url,
      enabled     => $foreman_enabled,
      gpgcheck    => $foreman_gpgcheck,
      includepkgs => $foreman_includepkgs,
      exclude     => $foreman_exclude,
      gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-foreman',
      require     => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-foreman'],
    }
  } else {
    notice ('Your system will not have the Foreman repository applied, requires Operating System Major release of 6 or 7')
  }
}
