require_relative '../../puppet_x/puppetlabs/route53_record'

Puppet::Type.newtype(:route53_private_a_record) do
  extend PuppetX::Puppetlabs::Route53Record
  @doc = 'Type representing a private Route53 DNS record.'
  create_properties_and_params()
  create_private_autorequire()
end
