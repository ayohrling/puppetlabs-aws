Puppet::Type.newtype(:route53_private_zone) do
  @doc = 'Type representing an Route53 DNS zone.'

  ensurable

  newparam(:name, namevar: true) do
    desc 'The name of DNS private zone group.'
    validate do |value|
      fail Puppet::Error, 'Empty values are not allowed' if value == ''
    end
  end

end
