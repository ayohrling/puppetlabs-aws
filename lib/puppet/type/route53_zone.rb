Puppet::Type.newtype(:route53_zone) do
  @doc = 'Type representing an Route53 DNS zone.'

  ensurable

  newparam(:name, namevar: true) do
    desc 'The name of DNS zone group.'
    validate do |value|
      fail Puppet::Error, 'Empty values are not allowed' if value == ''
    end
  end

  newproperty(:private) do
    desc 'Whether the zone is private.'
    defaultto :false
    newvalues(:true, :'false')
    def insync?(is)
      is.to_s = should.to_s
    end
  end

end
