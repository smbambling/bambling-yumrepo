# Parameters Defaults Used for Addition and Management for YUM Repositories within /etc/yum.repos.d/
class yumrepo::params {

  if $::operatingsystemmajrelease {
    $os_maj_release = $::operatingsystemmajrelease
  } else {
    $os_versions    = split($::operatingsystemrelease, '[.]')
    $os_maj_release = $os_versions[0]
  }

  # EPEL Parameters
  $epel_url         = "http://download.fedoraproject.org/pub/epel/${os_maj_release}/${::architecture}"
  $epel_enabled     = '1'
  $epel_gpgcheck    = '1'
  $epel_includepkgs = absent
  $epel_exclude     = absent
  $epel_descr       = "Extra Packages for Enterprise Linux ${os_maj_release} - \$basearch"

  # PuppetLabs Parameters
  # PuppetLabs has two repositories, (products, deps)
  $puppetlabs_products_url         = "http://yum.puppetlabs.com/el/${os_maj_release}/products/${::architecture}"
  $puppetlabs_products_enabled     = '1'
  $puppetlabs_products_gpgcheck    = '1'
  $puppetlabs_products_includepkgs = absent
  $puppetlabs_products_exclude     = absent
  $puppetlabs_products_descr       = "Puppet Labs Products El ${os_maj_release} - \$basearch"

  $puppetlabs_deps_url         = "http://yum.puppetlabs.com/el/${os_maj_release}/dependencies/${::architecture}"
  $puppetlabs_deps_enabled     = '1'
  $puppetlabs_deps_gpgcheck    = '1'
  $puppetlabs_deps_includepkgs = absent
  $puppetlabs_deps_exclude     = absent
  $puppetlabs_deps_descr       = "Puppet Labs Dependencies El ${os_maj_release} - \$basearch"

  # The Foreman Parameters
  $foreman_url         = "http://yum.theforeman.org/releases/latest/el${os_maj_release}/${::architecture}"
  $foreman_enabled     = '1'
  $foreman_gpgcheck    = '1'
  $foreman_includepkgs = absent
  $foreman_exclude     = absent
  $foreman_descr       = "The Foreman Latest El ${os_maj_release} - \$basearch"

  $foreman_plugins_url         = "http://yum.theforeman.org/plugins/latest/el${os_maj_release}/${::architecture}"
  $foreman_plugins_enabled     = '1'
  $foreman_plugins_gpgcheck    = '1'
  $foreman_plugins_includepkgs = absent
  $foreman_plugins_exclude     = absent
  $foreman_plugins_descr       = "The Foreman Plugings Latest El ${os_maj_release} - \$basearch"

  # PostgreSQL PGDG 9.3 Parameters
  $postgresql93_url         = "http://yum.postgresql.org/9.3/redhat/rhel-${os_maj_release}-${::architecture}"
  $postgresql93_enabled     = '1'
  $postgresql93_gpgcheck    = '1'
  $postgresql93_includepkgs = absent
  $postgresql93_exclude     = absent
  $postgresql93_descr       = 'PostgreSQL 9.3 $releasever - $basearch $basearch'

}
