# Add the Puppet Labs Products and Dependencies Repositories
class yumrepo::puppetlabs (
  $puppetlabs_products_url         = $yumrepo::params::puppetlabs_products_url,
  $puppetlabs_products_enabled     = $yumrepo::params::puppetlabs_products_enabled,
  $puppetlabs_products_gpgcheck    = $yumrepo::params::puppetlabs_products_gpgcheck,
  $puppetlabs_products_includepkgs = $yumrepo::params::puppetlabs_products_includepkgs,
  $puppetlabs_products_exclude     = $yumrepo::params::puppetlabs_products_exclude,
  $puppetlabs_products_descr        = $yumrepo::params::puppetlabs_products_descr,
  $puppetlabs_deps_url             = $yumrepo::params::puppetlabs_deps_url,
  $puppetlabs_deps_enabled         = $yumrepo::params::puppetlabs_deps_enabled,
  $puppetlabs_deps_gpgcheck        = $yumrepo::params::puppetlabs_deps_gpgcheck,
  $puppetlabs_deps_includepkgs     = $yumrepo::params::puppetlabs_deps_includepkgs,
  $puppetlabs_deps_exclude         = $yumrepo::params::puppetlabs_deps_exclude,
  $puppetlabs_deps_descr           = $yumrepo::params::puppetlabs_deps_descr,
) {

  include yumrepo::params

  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/puppetlabs/RPM-GPG-KEY-puppetlabs',
  }

  yumrepo::rpm_gpg_key { 'puppetlabs':
    path   => '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
    before => Yumrepo['puppetlabs_products', 'puppetlabs_deps'],
  }

  yumrepo { 'puppetlabs_products':
    descr       => $puppetlabs_products_descr,
    baseurl     => $puppetlabs_products_url,
    enabled     => $puppetlabs_products_enabled,
    gpgcheck    => $puppetlabs_products_gpgcheck,
    includepkgs => $puppetlabs_products_includepkgs,
    exclude     => $puppetlabs_products_exclude,
    gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
    require     => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs'],
  }

  yumrepo { 'puppetlabs_deps':
    descr       => $puppetlabs_deps_descr,
    baseurl     => $puppetlabs_deps_url,
    enabled     => $puppetlabs_deps_enabled,
    gpgcheck    => $puppetlabs_deps_gpgcheck,
    includepkgs => $puppetlabs_deps_includepkgs,
    exclude     => $puppetlabs_deps_exclude,
    gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
    require     => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs'],
  }
}
