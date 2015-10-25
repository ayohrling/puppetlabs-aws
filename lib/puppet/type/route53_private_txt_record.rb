require_relative '../../puppet_x/puppetlabs/route53_record'

Puppet::Type.newtype(:route53_private_txt_record) do
  extend PuppetX::Puppetlabs::Route53Record
  @doc = 'Type representing a private Route53 TXT record.'
  create_properties_and_params()
  create_private_autorequire()

  # TXT records should always be wrapped in double quotes
  # this minge avoids the need to pass in a '"value"' to Puppet
  values_property = self.properties.find { |item| item == Puppet::Type::Route53_txt_record::Values }
  values_property.munge do |value|
    value =~ /^".+"$/ ? value : "\"#{value}\""
  end
end
