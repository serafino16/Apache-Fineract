no# Apache-Fineract

Apache Fineract is an open-source platform for core banking and financial services. Application consist of 20 microservices.The languages for the application are java 17 for backend and HTML/CSS/JavaScript for frontend.For build process is used maven:3.9.4.PostgreSQL for RDS and Redis for cache.

Docker: backend image-for dev maven:3.9.4-openjdk-17 AS dev-builder for prod maven:3.9.4-openjdk-17 AS prod-builder to openjdk:17-slim defined in multi stage build.For fronted image-node:18 with images for dev/stage and for prod cleaned for unecessary dependencies.Standart images for PostgreSQL and Redis.


Kubernetes services : you can check the folder services ,every file have templates for deployment,service and service account and load balancers and values for them. Deployment file consist of replicas,image from ecr,service account name,resource request and limit,livness and readiness probe volume mount for efs for backend services and ebs for database and redis. Service account is connected to eks-irsa. Service contains load balancers with annotations for ALB,Ingress and NLB. Database contains headless service and also verticaland horizontal load balancers and secrets.


For CI/CD is used jenkins.

Regions:eu-west-1(main region),eu west 2,3 and eu-central 1(used for regolatory complience based on DE,FR and GBR local laws for data sovereignity)

EKS: Diffrent clusters for every nviroment and regions(9).In the cluster are used public and private node groups,cluster autoscaler.

VPC:components for the network include public,private and database subnets,nat gateway,internet gateway,dns hostname,route table,availability zones,and vpc name.

The networking  solution also integrates AWS Cloud WAN to enable centralized hybrid connectivity across multiple AWS regions and on-premises data centers. Calico CNI with VXLAN overlay networking is used within Kubernetes clusters for secure pod-to-pod communication. Cloud WAN segments and routing policies ensure seamless, secure traffic flow between environments

Transit Gateway strategy:Inter-Region Peering

Mesh Peering Topology: Each TGW will be peered with every other TGW for full regional mesh.

Use TGW Peering Attachments for each region pair.

Enable route propagation in each TGW’s route table for peering attachments

EKS_IRSA:Config for iam for service account with oidc token and necessary policies and permissions.

Pan European Multi-Region Global Load Balancing using Route 53 with ALB and Global Accelerator with NLB

Strategy uses  Global accelerator,Route 53, ALB and NLB for high availability, geo-based routing, and failover across multiple AWS regions. Route 53 is configured with geolocation routing to direct users to the nearest region and failover routing to switch to a backup region during outages. Each region uses an Application Load Balancer (ALB) for frontend service load balancing and as an Ingress Controller for backend APIs via Kubernetes (e.g., EKS), supporting host-based routing. For the most critical services Global Accelerator handles the traffic to NLBs in multiple regions to provide static IPs, low-latency routing, and automatic failover based on health  for Network Load Balancer (NLB)  that handles TCP traffic to high-performance services like RDS,Redis,Payemnt etc.This architecture ensures low latency, regional compliance, resilient failover, and secure separation between application and database layers.

Storage: for filesystem is used efs with replications in diffrent regions and datasync between backend services and for RDS and Redis is used block storage on provisioned iops.Storageclss is enabled on both for dyanmic provisioning,csi add-on plugins and pvcs.

Event driven system with SQS and Lambda for Loan managment and Client Data Managment.

Geo-Partitioned Disaster Recovery Strategy
The disaster recovery strategy for Amazon RDS and Redis ensures high availability and fault tolerance across multiple AWS regions. The primary region is eu-west-1 (Ireland), with disaster recovery extending to eu-west-2 (London), eu-west-3 (Paris), and eu-central-1 (Frankfurt). RDS utilizes cross-region read replicas for asynchronous data replication from the primary region to secondary regions. In the event of primary region failure, a read replica can be promoted to a standalone instance with DNS updates or manual promotion.Redis uses Global Datastore for Redis for asynchronous replication between the primary and secondary regions, allowing for failover by DNS redirection or application reconfiguration. The RTO (Recovery Time Objective) is set to under 15 minutes, and the RPO (Recovery Point Objective) is under 5 minutes. All data is encrypted in transit and at rest, and backup snapshots are stored in cross-region S3 buckets.

WAF: firewall rules for every VPC and SQL injection protection for RDS.
