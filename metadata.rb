name 'jboss7'
maintainer 'Andrew DuFour'
maintainer_email 'andy.k.dufour@gmail.com'
license 'All rights reserved'
description 'Installs/Configures jboss7'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.0'

depends 'apt'
depends 'java'
depends 'ark'

supports 'ubuntu', '>= 10.04'
supports 'centos', '>= 6.0'
