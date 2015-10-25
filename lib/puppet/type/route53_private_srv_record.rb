require_relative '../../puppet_x/puppetlabs/route53_record'

Puppet::Type.newtype(:route53_private_srv_record) do
  extend PuppetX::Puppetlabs::Route53Record
  @doc = 'Type representing a private Route53 SRV record.'
  create_properties_and_params()
  create_private_autorequire()
end
