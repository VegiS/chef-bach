#
# Cookbook Name:: ambari-views-chef
# Recipe:: default
#
# Copyright 2018, Bloomberg Finance L.P.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#



# dependencies
%w(openssh-client wget curl unzip tar python2.7 openssl libpq5 ssl-cert).each do |pkg|
  package pkg do
  end
end

case node['platform']
when 'ubuntu'
    apt_repository 'ambari' do
      uri node['ambari']['ambari_ubuntu_repo_url']
      components ['main']
      distribution 'Ambari'
      action :add
      key node['ambari']['repo_key']
    end
else
  raise "Platform #{node['platform']} is not supported"
end

include_recipe 'ambari::ambari_server_install'
