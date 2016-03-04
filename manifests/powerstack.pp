# Add the powerstack (powerstack.org) repo
class yumrepo::powerstack (
  $powerstack_url              = $yumrepo::params::powerstack_url,
  $powerstack_enabled          = $yumrepo::params::powerstack_enabled,
  $powerstack_gpgcheck         = $yumrepo::params::powerstack_gpgcheck,
  $powerstack_includepkgs      = $yumrepo::params::powerstack_includepkgs,
  $powerstack_exclude          = $yumrepo::params::powerstack_exclude,
  $powerstack_descr            = $yumrepo::params::powerstack_descr,
) inherits yumrepo::params {

  include yumrepo::cleanall

  yumrepo { 'powerstack':
    descr       => $powerstack_descr,
    baseurl     => $powerstack_url,
    enabled     => $powerstack_enabled,
    gpgcheck    => $powerstack_gpgcheck,
    includepkgs => $powerstack_includepkgs,
    exclude     => $powerstack_exclude,
    notify      => [ Exec['cleanall'], ],
  }
  
}
