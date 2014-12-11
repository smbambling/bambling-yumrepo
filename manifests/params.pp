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

}
