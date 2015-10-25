require_relative '../../../puppet_x/puppetlabs/aws.rb'
require 'securerandom'

Puppet::Type.type(:route53_private_zone).provide(:v2, :parent => PuppetX::Puppetlabs::Aws) do
  confine feature: :aws

  mk_resource_methods

  def self.instances
    zones = []
    response = route53_client.list_hosted_zones()
    response.data.hosted_zones.each do |zone|
      if zone.config.private_zone
        zones << new({
          name: zone.name,
          ensure: :present,
        })
      end
    end
    zones
  end

  def self.prefetch(resources)
    instances.each do |prov|
      if resource = resources[prov.name]
        resource.provider = prov
      end
    end
  end

  def exists?
    Puppet.info("Checking if zone #{name} exists")
    @property_hash[:ensure] == :present
  end

  def create
    reference = SecureRandom.hex
    Puppet.info("Creating zone #{name} with #{reference}")
    route53_client.create_hosted_zone(
      name: name,
      caller_reference: reference,
      vpc: {
        vpc_region: default_region,
        vpc_id: vpc,
      },
    )
    @property_hash[:ensure] = :present
  end

  def destroy
    Puppet.info("Deleting zone #{name}")
    zones = route53_client.list_hosted_zones.data.hosted_zones.select { |zone| zone.name == name && zone.config.private_zone == true }
    zones.each do |zone|
      route53_client.delete_hosted_zone(id: zone.id)
    end
    @property_hash[:ensure] = :absent
  end
end
