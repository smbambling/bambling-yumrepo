# Add the Puppet Labs Products and Dependencies Repositories
class yumrepo::puppetlabs_pc1 (
  $puppetlabs_pc1_url              = $yumrepo::params::puppetlabs_pc1_url,
  $puppetlabs_pc1_enabled          = $yumrepo::params::puppetlabs_pc1_enabled,
  $puppetlabs_pc1_gpgcheck         = $yumrepo::params::puppetlabs_pc1_gpgcheck,
  $puppetlabs_pc1_includepkgs      = $yumrepo::params::puppetlabs_pc1_includepkgs,
  $puppetlabs_pc1_exclude          = $yumrepo::params::puppetlabs_pc1_exclude,
  $puppetlabs_pc1_descr            = $yumrepo::params::puppetlabs_pc1_descr,
) inherits yumrepo::params {

  include yumrepo::cleanall

  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/yumrepo/puppetlabs/RPM-GPG-KEY-puppetlabs',
  }

  yumrepo::rpm_gpg_key { 'puppetlabs_pc1':
    path   => '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
    before => Yumrepo[ 'puppetlabs-pc1' ],
  }

  yumrepo { 'puppetlabs-pc1':
    descr       => $puppetlabs_pc1_descr,
    baseurl     => $puppetlabs_pc1_url,
    enabled     => $puppetlabs_pc1_enabled,
    gpgcheck    => $puppetlabs_pc1_gpgcheck,
    includepkgs => $puppetlabs_pc1_includepkgs,
    exclude     => $puppetlabs_pc1_exclude,
    gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
    require     => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs'],
    notify      => [ Exec['cleanall'], ],
  }
  
}
