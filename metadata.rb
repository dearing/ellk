name 'ellk'
maintainer 'Jacob Dearing'
maintainer_email 'jacob.dearing@gmail.com'
license 'MIT'
description 'Installs/Configures ELLK'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.3.1'

%w(ubuntu debian gentoo centos redhat amazon scientific oracle enterpriseenterprise).each do |os|
  supports os
end

depends 'ark'
depends 'runit'
