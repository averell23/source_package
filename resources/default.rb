def initialize(*args)
  super
  @action = :install
end

actions :install

attribute :package_name, :kind_of => String, :name_attribute => true
attribute :package_extension, :kind_of => String
attribute :prefix, :kind_of => String
attribute :checksum, :kind_of => String
attribute :download_url, :kind_of => String
attribute :configure_options, :kind_of => String
attribute :after_install, :kind_of => String