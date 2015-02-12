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
 - CentOS SCL

## Module Description

Installs YUM repositories and their corosponding RPM GPG Key(s).

Additionally runs the following commands to make the repositories usable "quicker"
 - yum clean all
 - yum makecache

## Helpful Hint

To avoid order of operations issues where the required repository is not installed before
the needed package I recommend adding the following to your manifest.  This will set the correct
order of operations between Yumrepo resources and Package resources

````
Yumrepo <| |> -> Package <| |>
````

## Usage

````
include yumrepo::epel
include yumrepo::puppetlabs
````


