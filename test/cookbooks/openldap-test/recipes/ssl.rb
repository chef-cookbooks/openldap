ssl_dir = "#{openldap_dir}/ssl"
node.default['openldap']['tls_cert'] = "#{ssl_dir}/#{node['openldap']['server']}.crt"
node.default['openldap']['tls_key'] = "#{ssl_dir}/#{node['openldap']['server']}.key"
node.default['openldap']['tls_cafile'] = "#{ssl_dir}/#{node['openldap']['server']}.pem"

node.default[:certs] = ["#{ssl_dir}/#{node['openldap']['server']}.crt",
                        "#{ssl_dir}/#{node['openldap']['server']}.key",
                        "#{ssl_dir}/#{node['openldap']['server']}.pem"]

directory openldap_dir do
  mode '755'
  action :create
end

directory ssl_dir do
  mode '755'
  action :create
end

node['certs'].each do |c|
  cookbook_file c do
    backup false
    action :create_if_missing
    mode '644'
  end
end

include_recipe 'openldap::default'
