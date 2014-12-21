# Define yumpreo::cleanall
#
# Actions:
#  [yum clean all]
#    : Clean all cached files from any enabled repository.
#  [yum makecahce]
#    : Download and make usable all the metadata for the currently enabled yum repos
define yumrepo::cleanall () {
  exec { 'cleanall':
    path        => '/bin:/usr/bin:/sbin:/usr/sbin',
    command     => 'yum clean all',
    refreshonly => true,
  }

  exec { 'makecache':
    path        => '/bin:/usr/bin:/sbin:/usr/sbin',
    command     => 'yum makecache',
    refreshonly => true,
  }
}
