# Cloudformation Templates

If you have yet to look at the NIST templates, here is the link:
http://docs.aws.amazon.com/quickstart/latest/accelerator-nist/templates.html

General Cloudformation Templates

- VPC
  This template creates a multi-az VPC with public, private, and database subnets.
  This template also includes an S3 endpoint as an option.

  NOTE: This template will provision the required Elastic IP for the NAT service.

  * All resources should be tagged with the environment
  * Public subnets are configure to auto-assign public IP addresses for instances
  * A NAT gateway is created using the NAT service for the private subnets,
    and a route is added for internet access (system updates) on the private subnets.
  * Route 53 internal DNS is enabled, but not configured.

- Bastion
  The Bastion host is autoscaling for purposes of availability, so a max of one
  instance is set.  

  NOTE: An EIP needs to be provisioned BEFORE running this template

  * The template creates a role that allows the bastion host to:
    - Attach and detach an EIP
    - Submit metrics to cloudwatch
    - Submit logs to cloudwatch
  * The template provisions a t2.nano
  * An autoscaling group is created so that if the instance is terminated, and new
    one will be provisioned
  * A crontab is created that:
    - Submits metrics to cloudwatch
    - Creates a host file based on running instances
    - Performs security updates, but not kernel updates

- Generic Instance
  This is just a generic instance with no autoscaling that launches in a private
  subnet.

- Docker Cluster
  This is an autoscaling cluster for ECS.
