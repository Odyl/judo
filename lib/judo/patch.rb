module Aws
  class Ec2

    def describe_snapshots(list=[], opts={})
      params = {}
      params.merge!(hash_params('SnapshotId',list.to_a))
      params.merge!(hash_params('Owner', [opts[:owner]])) if opts[:owner]
      link = generate_request("DescribeSnapshots", params)
      request_cache_or_info :describe_snapshots, link,  QEc2DescribeSnapshotsParser, @@bench, list.blank?
    rescue Exception
      on_exception
    end

    def stop_instances(list=[])
      link = generate_request("StopInstances", hash_params('InstanceId', list.to_a))
      request_info(link, QEc2TerminateInstancesParser.new(:logger => @logger))
    end

    def start_instances(list=[])
      link = generate_request("StartInstances", hash_params('InstanceId', list.to_a))
      request_info(link, QEc2TerminateInstancesParser.new(:logger => @logger))
    end

  end
end
