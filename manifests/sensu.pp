# Add the sensu (sensuapp.org) repo
class yumrepo::sensu (
  $sensu_url              = $yumrepo::params::sensu_url,
  $sensu_enabled          = $yumrepo::params::sensu_enabled,
  $sensu_includepkgs      = $yumrepo::params::sensu_includepkgs,
  $sensu_exclude          = $yumrepo::params::sensu_exclude,
  $sensu_descr            = $yumrepo::params::sensu_descr,
) inherits yumrepo::params {

  include yumrepo::cleanall

  yumrepo { 'sensu':
    descr       => $sensu_descr,
    baseurl     => $sensu_url,
    enabled     => $sensu_enabled,
    gpgcheck    => $sensu_gpgcheck,
    includepkgs => $sensu_includepkgs,
    exclude     => $sensu_exclude,
    notify      => [ Exec['cleanall'], ],
  }
  
}
