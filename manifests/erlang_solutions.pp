# Add the erlang-solutions.com yum repository
class yumrepo::erlang_solutions (
  $erlang_solutions_url              = $yumrepo::params::erlang_solutions_url,
  $erlang_solutions_enabled          = $yumrepo::params::erlang_solutions_enabled,
  $erlang_solutions_gpgcheck         = $yumrepo::params::erlang_solutions_gpgcheck,
  $erlang_solutions_includepkgs      = $yumrepo::params::erlang_solutions_includepkgs,
  $erlang_solutions_exclude          = $yumrepo::params::erlang_solutions_exclude,
  $erlang_solutions_descr            = $yumrepo::params::erlang_solutions_descr,
) inherits yumrepo::params {

  include yumrepo::cleanall

  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-erlang-solutions':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/yumrepo/erlang_solutions/RPM-GPG-KEY-erlang-solutions',
  }

  yumrepo::rpm_gpg_key { 'erlang_solutions':
    path   => '/etc/pki/rpm-gpg/RPM-GPG-KEY-erlang-solutions',
    before => Yumrepo[ 'erlang_solutions' ],
  }

  yumrepo { 'erlang_solutions':
    descr       => $erlang_solutions_descr,
    baseurl     => $erlang_solutions_url,
    enabled     => $erlang_solutions_enabled,
    gpgcheck    => $erlang_solutions_gpgcheck,
    includepkgs => $erlang_solutions_includepkgs,
    exclude     => $erlang_solutions_exclude,
    gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-erlang-solutions',
    require     => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-erlang-solutions'],
    notify      => [ Exec['cleanall'], ],
  }
  
}
