# Parameters Defaults Used for Addition and Management for YUM Repositories within /etc/yum.repos.d/
class yumrepo::params {

  if $::operatingsystemmajrelease {
    $os_maj_release = $::operatingsystemmajrelease
  } else {
    $os_versions    = split($::operatingsystemrelease, '[.]')
    $os_maj_release = $os_versions[0]
  }

  # SCL Parameters
  $scl_name        = 'scl'
  $scl_url         = 'http://mirror.centos.org/centos/$releasever/SCL/$basearch/'
  $scl_enabled     = '1'
  $scl_gpgcheck    = '1'
  $scl_includepkgs = absent
  $scl_exclude     = absent
  $scl_descr       = 'CentOS-$releasever - SCL'

  # RPMFORGE Parameters
  $rpmforge_url         = "http://apt.sw.be/redhat/el${os_maj_release}/\$basearch/rpmforge"
  $rpmforge_enabled     = '1'
  $rpmforge_gpgcheck    = '1'
  $rpmforge_includepkgs = absent
  $rpmforge_exclude     = absent
  $rpmforge_descr       = "Extra Packages for Enterprise Linux ${os_maj_release} - \$basearch"
  $rpmforge_mirrorlist  = "http://mirrorlist.repoforge.org/el${os_maj_release}/mirrors-rpmforge"
  
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

  $puppetlabs_pc1_url         = "http://yum.puppetlabs.com/el/${os_maj_release}/PC1/${::architecture}"
  $puppetlabs_pc1_enabled     = '1'
  $puppetlabs_pc1_gpgcheck    = '1'
  $puppetlabs_pc1_includepkgs = absent
  $puppetlabs_pc1_exclude     = absent
  $puppetlabs_pc1_descr       = "Puppet Labs PC1 Repository el ${os_maj_release} - \$basearch"

  # The Foreman Parameters
  $foreman_url         = "http://yum.theforeman.org/releases/latest/el${os_maj_release}/${::architecture}"
  $foreman_enabled     = '1'
  $foreman_gpgcheck    = '1'
  $foreman_includepkgs = absent
  $foreman_exclude     = absent
  $foreman_descr       = "The Foreman Latest El ${os_maj_release} - \$basearch"

  $foreman_plugins_url         = "http://yum.theforeman.org/plugins/latest/el${os_maj_release}/${::architecture}"
  $foreman_plugins_enabled     = '1'
  $foreman_plugins_gpgcheck    = '0'
  $foreman_plugins_includepkgs = absent
  $foreman_plugins_exclude     = absent
  $foreman_plugins_descr       = "The Foreman Plugings Latest El ${os_maj_release} - \$basearch"

  # PostgreSQL PGDG 9.3 Parameters
  $pgdg_93_name        = 'pgdg-93'
  $pgdg_93_url         = "http://yum.postgresql.org/9.3/redhat/rhel-${os_maj_release}-${::architecture}"
  $pgdg_93_enabled     = '1'
  $pgdg_93_gpgcheck    = '1'
  $pgdg_93_includepkgs = absent
  $pgdg_93_exclude     = absent
  $pgdg_93_descr       = 'PostgreSQL 9.3 $releasever - $basearch'

  # PostgreSQL PGDG 9.4 Parameters
  $pgdg_94_name        = 'pgdg-94'
  $pgdg_94_url         = "http://yum.postgresql.org/9.4/redhat/rhel-${os_maj_release}-${::architecture}"
  $pgdg_94_enabled     = '1'
  $pgdg_94_gpgcheck    = '1'
  $pgdg_94_includepkgs = absent
  $pgdg_94_exclude     = absent
  $pgdg_94_descr       = 'PostgreSQL 9.4 $releasever - $basearch'

  # Elasticsearch 1.4.x Parameters
  $elasticsearch_1_4_url         = 'http://packages.elasticsearch.org/elasticsearch/1.4/centos'
  $elasticsearch_1_4_enabled     = '1'
  $elasticsearch_1_4_gpgcheck    = '1'
  $elasticsearch_1_4_includepkgs = absent
  $elasticsearch_1_4_exclude     = absent
  $elasticsearch_1_4_descr       = 'Elasticsearch repository for 1.4.x packages'

  # Icinga Parameters
  $icinga_url         = "http://packages.icinga.org/epel/${os_maj_release}/release/"
  $icinga_enabled     = '1'
  $icinga_gpgcheck    = '1'
  $icinga_includepkgs = absent
  $icinga_exclude     = absent
  $icinga_descr       = 'ICINGA (stable release for epel)'

  # Dell OMSA Parameters
  # Dell OMSA has two repositories, (indep, specific)
  $dell_omsa_indep_mirrorlist     = 'http://linux.dell.com/repo/hardware/latest/mirrors.cgi?osname=el$releasever&basearch=$basearch&native=1&dellsysidpluginver=$dellsysidpluginver'
  $dell_omsa_indep_enabled        = '1'
  $dell_omsa_indep_gpgcheck       = '1'
  $dell_omsa_indep_includepkgs    = absent
  $dell_omsa_indep_exclude        = absent
  $dell_omsa_indep_failovermethod = 'priority'
  $dell_omsa_indep_descr          = 'Dell OMSA repository - Hardware independent'

  $dell_omsa_specific_mirrorlist     = 'http://linux.dell.com/repo/hardware/latest/mirrors.cgi?osname=el$releasever&basearch=$basearch&native=1&sys_ven_id=$sys_ven_id&sys_dev_id=$sys_dev_id&dellsysidpluginver=$dellsysidpluginver'
  $dell_omsa_specific_enabled        = '1'
  $dell_omsa_specific_gpgcheck       = '1'
  $dell_omsa_specific_includepkgs    = absent
  $dell_omsa_specific_exclude        = absent
  $dell_omsa_specific_failovermethod = 'priority'
  $dell_omsa_specific_descr          = 'Dell OMSA repository - Hardware specific'

  # Rsyslog Version 8 Parameters
  $rsyslog_v8_url         = "http://rpms.adiscon.com/v8-stable/epel-${os_maj_release}/${::architecture}"
  $rsyslog_v8_enabled     = '1'
  $rsyslog_v8_gpgcheck    = '1'
  $rsyslog_v8_includepkgs = absent
  $rsyslog_v8_exclude     = absent
  $rsyslog_v8_descr       = "Adiscon CentOS-${os_maj_release} - local packages for \$basearch"

  # MariaDB 10 Parameters
  $mariadb_10_name        = 'mariadb_10'
  $mariadb_10_url         = "http://yum.mariadb.org/10.0/centos/${os_maj_release}/${::architecture}"
  $mariadb_10_enabled     = '1'
  $mariadb_10_gpgcheck    = '1'
  $mariadb_10_includepkgs = absent
  $mariadb_10_exclude     = absent
  $mariadb_10_descr       = 'MariaDB $releasever - $basearch'

  # Sensu Repo Parameters
  $sensu_url         = "http://repositories.sensuapp.org/yum/${os_maj_release}/${::architecture}"
  $sensu_enabled     = '1'
  $sensu_gpgcheck    = '0'
  $sensu_includepkgs = absent
  $sensu_exclude     = absent
  $sensu_descr       = 'Sensu $releasever - $basearch'

  $erlang_solutions_url         = "http://packages.erlang-solutions.com/rpm/centos/${os_maj_release}/${::architecture}"
  $erlang_solutions_enabled     = '1'
  $erlang_solutions_gpgcheck    = '1'
  $erlang_solutions_includepkgs = absent
  $erlang_solutions_exclude     = absent
  $erlang_solutions_descr       = 'Erlang-Solutions $releasever - $basearch'

  # Powerstack Repo Parameters
  $powerstack_url         = "http://download.powerstack.org/${os_maj_release}/${::architecture}"
  $powerstack_enabled     = '1'
  $powerstack_gpgcheck    = '0'
  $powerstack_includepkgs = absent
  $powerstack_exclude     = absent
  $powerstack_descr       = 'Powerstack $releasever - $basearch'

  # SoftareCollections.org Repo Parameters
  $sclo_url         = "http://mirror.centos.org/centos/${os_maj_release}/sclo/${::architecture}/rh"
  $sclo_enabled     = '1'
  $sclo_gpgcheck    = '1'
  $sclo_includepkgs = absent
  $sclo_exclude     = absent
  $sclo_descr       = 'SoftwareCollectionsOrg $releasever - $basearch'
}
