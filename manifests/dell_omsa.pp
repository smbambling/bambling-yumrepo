# Add the Puppet Labs Products and Dependencies Repositories
class yumrepo::dell_omsa (
  $dell_omsa_indep_mirrorlist        = $yumrepo::params::dell_omsa_indep_mirrorlist,
  $dell_omsa_indep_enabled           = $yumrepo::params::dell_omsa_indep_enabled,
  $dell_omsa_indep_gpgcheck          = $yumrepo::params::dell_omsa_indep_gpgcheck,
  $dell_omsa_indep_includepkgs       = $yumrepo::params::dell_omsa_indep_includepkgs,
  $dell_omsa_indep_exclude           = $yumrepo::params::dell_omsa_indep_exclude,
  $dell_omsa_indep_descr             = $yumrepo::params::dell_omsa_indep_descr,
  $dell_omsa_indep_failovermethod    = $yumrepo::params::dell_omsa_indep_failovermethod,
  $dell_omsa_specific_mirrorlist     = $yumrepo::params::dell_omsa_specific_mirrorlist,
  $dell_omsa_specific_enabled        = $yumrepo::params::dell_omsa_specific_enabled,
  $dell_omsa_specific_gpgcheck       = $yumrepo::params::dell_omsa_specific_gpgcheck,
  $dell_omsa_specific_includepkgs    = $yumrepo::params::dell_omsa_specific_includepkgs,
  $dell_omsa_specific_exclude        = $yumrepo::params::dell_omsa_specific_exclude,
  $dell_omsa_specific_descr          = $yumrepo::params::dell_omsa_specific_descr,
  $dell_omsa_specific_failovermethod = $yumrepo::params::dell_omsa_specific_failovermethod,
) inherits yumrepo::params {

  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-dell':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/yumrepo/dell_omsa/RPM-GPG-KEY-dell',
  }

  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-libsmbios':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/yumrepo/dell_omsa/RPM-GPG-KEY-libsmbios',
  }

  yumrepo::rpm_gpg_key { 'dell':
    path   => '/etc/pki/rpm-gpg/RPM-GPG-KEY-dell',
    before => Yumrepo['dell_omsa_indep', 'dell_omsa_specific'],
  }

  yumrepo::rpm_gpg_key { 'libsmbios':
    path   => '/etc/pki/rpm-gpg/RPM-GPG-KEY-libsmbios',
    before => Yumrepo['dell_omsa_indep', 'dell_omsa_specific'],
  }

  $gpgkeys = "/etc/pki/rpm-gpg/RPM-GPG-KEY-dell
  /etc/pki/rpm-gpg/RPM-GPG-KEY-libsmbios"

  yumrepo { 'dell_omsa_indep':
    descr       => $dell_omsa_indep_descr,
    mirrorlist  => $dell_omsa_indep_mirrorlist,
    enabled     => $dell_omsa_indep_enabled,
    gpgcheck    => $dell_omsa_indep_gpgcheck,
    includepkgs => $dell_omsa_indep_includepkgs,
    exclude     => $dell_omsa_indep_exclude,
    gpgkey      => $gpgkeys,
    require     => [ File['/etc/pki/rpm-gpg/RPM-GPG-KEY-dell'], File['/etc/pki/rpm-gpg/RPM-GPG-KEY-libsmbios'] ],
  }

  yumrepo { 'dell_omsa_specific':
    descr       => $dell_omsa_specific_descr,
    mirrorlist  => $dell_omsa_specific_mirrorlist,
    enabled     => $dell_omsa_specific_enabled,
    gpgcheck    => $dell_omsa_specific_gpgcheck,
    includepkgs => $dell_omsa_specific_includepkgs,
    exclude     => $dell_omsa_specific_exclude,
    gpgkey      => $gpgkeys,
    require     => [ File['/etc/pki/rpm-gpg/RPM-GPG-KEY-dell'], File['/etc/pki/rpm-gpg/RPM-GPG-KEY-libsmbios'] ],
  }
}
