# Add the Elasticsearch 1.4.x Repository
class yumrepo::elasticsearch_1_4 (
  $elasticsearch_1_4_url         = $yumrepo::params::elasticsearch_1_4_url,
  $elasticsearch_1_4_enabled     = $yumrepo::params::elasticsearch_1_4_enabled,
  $elasticsearch_1_4_gpgcheck    = $yumrepo::params::elasticsearch_1_4_gpgcheck,
  $elasticsearch_1_4_includepkgs = $yumrepo::params::elasticsearch_1_4_includepkgs,
  $elasticsearch_1_4_exclude     = $yumrepo::params::elasticsearch_1_4_exclude,
  $elasticsearch_1_4_descr       = $yumrepo::params::elasticsearch_1_4_descr,
) inherits yumrepo::params {

  include yumrepo::cleanall
  
  file { '/etc/pki/rpm-gpg/GPG-KEY-elasticsearch':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/yumrepo/elasticsearch_1_4/GPG-KEY-elasticsearch',
  }

  yumrepo::rpm_gpg_key { 'GPG-KEY-elasticsearch':
    path   => '/etc/pki/rpm-gpg/GPG-KEY-elasticsearch',
    before => Yumrepo['elasticsearch_1_4'],
  }

  yumrepo { 'elasticsearch_1_4':
    descr       => $elasticsearch_1_4_descr,
    baseurl     => $elasticsearch_1_4_url,
    enabled     => $elasticsearch_1_4_enabled,
    gpgcheck    => $elasticsearch_1_4_gpgcheck,
    includepkgs => $elasticsearch_1_4_includepkgs,
    exclude     => $elasticsearch_1_4_exclude,
    gpgkey      => 'file:///etc/pki/rpm-gpg/GPG-KEY-elasticsearch',
    require     => File['/etc/pki/rpm-gpg/GPG-KEY-elasticsearch'],
    notify      => [ Exec['cleanall'], Exec['makecache'] ],
  }
}
