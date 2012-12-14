action :install do

  package_name = new_resource.package_name
  package_extension = new_resource.package_extension || 'tar.gz'
  prefix = new_resource.prefix || '/opt/local'
  package_checksum = new_resource.checksum
  package_file = [package_name, package_extension].join('.')
  download_url = [new_resource.download_url, package_file].join('/')
  configure_options = new_resource.configure_options || ''
  after_install = new_resource.after_install

  # Hardcoded ATM
  builder_dir = '/var/builder'
  package_dir = [builder_dir, package_name].join('/')

  directory builder_dir

  remote_file "#{builder_dir}/#{package_file}" do
    source download_url
    action :create_if_missing
    checksum package_checksum if package_checksum
  end

  script "Install #{package_name} from source" do
    not_if "test -f #{package_dir}/install_complete"
    interpreter "bash"
    user "root"
    cwd builder_dir
    code <<-EOH
    tar xzf #{builder_dir}/#{package_file} || exit 1
    cd #{package_dir} || exit 1
    ./configure --prefix=#{prefix} #{configure_options}
    make
    make install || exit 1
    #{after_install ? (after_install + " || exit 1") : ''}
    touch install_complete
    EOH
  end

  new_resource.updated_by_last_action(true)

end