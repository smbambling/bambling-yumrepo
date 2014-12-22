# yumrepo

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)

## Overview

Installs and Enables YUM repositories

 - Dell OMSA
 - Elasticsearch
 - EPEL
 - The Foreman
 - Icinga
 - Postgresql 9.3
 - PuppetLabs
 - Rsyslog V8

## Module Description

Installs YUM repositories and their corosponding RPM GPG Key(s).

Additionally runs the following commands to make the repositories usable "quicker"
 - yum clean all
 - yum makecache

## Usage

It's recommended to use run stage with repositories so they are applied
in a pre stage for classes that require a package that resides within them

*Using Stages*

```puppet
# Include stdlib for additional functions and stages
include stdlib

# Classes that run BEFORE the *main* stage
class setup {
  include yumrepo::epel
  include yumrepo::puppetlabs
}

# Roll-up class used for setting stage parameter, anything class declared
# here will be in the *main* stage by default
class base {
  class { setup:
    stage => setup,
  }
}

# Run the roll-up base class
class { 'base': }
```
