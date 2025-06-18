 Apache-Fineract

Apache Fineract is an open-source platform for core banking and financial services. Application consist of 20 microservices.The languages for the application are java 17 for backend and HTML/CSS/JavaScript for frontend.For build process is used maven:3.9.4.MySQL for Aurora database and Redis for cache.The architectural patterns for Pan-European financial app include a multi-region, GDPR-compliant cloud setup with data residency, low-latency, high availability,zero data loss and disaster recovery, ensuring compliance and resilience across Europe.

Docker: backend image-for dev maven:3.9.4-openjdk-17 AS dev-builder for prod maven:3.9.4-openjdk-17 AS prod-builder to openjdk:17-slim defined in multi stage build.For fronted image-node:18 with images for dev,stage and prod cleaned for unecessary dependencies.Standart images for MySQL and Redis.


Kubernetes services :  Deployment file consist of replicas,image from ecr,service account name,resource request and limit,livness and readiness probe volume mount for efs for backend services and ebs for database,redis,kafka etc. Service account is connected to eks-irsa. Service contains load balancers with annotations for ALB,Ingress and NLB. Database,redis and kafka contains headless service,for stateful pods is used vertical load balancer and for stateless pods is used horizontall load balancer ,taint and tolerations for rds,redis,kafka and secrets for the database credentials.

Jenkins pipeline builds, pushes, and deploys multiple Apache Fineract  microservices to AWS ECR and EKS. You select the environment (dev, stage, prod) and AWS region (eu-west-1, eu-west-2, eu-west-3, eu-central-1). It builds Docker images for all services, pushes them to ECR, and deploys using Helm to the specified EKS cluster and namespace, automating multi-region, multi-environment releases.


Regions:eu-west-1(main region),eu west 2,3 and eu-central 1(used for regolatory complience based on DE,FR and GBR local laws for data sovereignity)

VPC:The VPC strategy involves using a Shared VPC for hosting common, cross-environment services such as authentication, logging, and notifications, which need to be accessible by all environments (dev, stage, prod). The environment-specific VPCs—dev VPC, stage VPC, and prod VPC—are dedicated to each respective environment to provide isolation.Components for the vpc include
private subnets for backend services, public subnets for internet-facing services also database subnets. NAT Gateways,Internet gateway,Routing tables,DNS resolution,security groups.Calico CNI with VXLAN overlay networking is used within Kubernetes clusters for secure pod-to-pod communication.

The networking solution also integrates AWS Cloud WAN as the global backbone to interconnect regional AWS Transit Gateways (TGWs) in eu-west-1, eu-west-2, eu-west-3, and eu-central-1, enabling scalable, policy-based segmentation and low-latency multi-region communication across isolated network domains.  

Architectural strategy for hybrid cloud connection:

AWS Direct Connect as the primary dedicated link between the on-premises data center and AWS to ensure low-latency, high-throughput, and stable connectivity, while configuring an AWS Site-to-Site VPN over the internet as a secure backup path using IPSec encryption, with both connections terminating at a TGW where BGP routing is implemented to prioritize Direct Connect through lower route cost and automatically fail over to the VPN in the event of a Direct Connect failure.

EKS: Diffrent clusters for every nviroment and regions(9).In the cluster are used public and private node groups,cluster autoscaler.

EKS_IRSA:Config for iam for service account with oidc token and necessary policies and permissions.

Pan European Multi-Region Global Load Balancing using Route 53 with ALB and Global Accelerator with NLB

Strategy uses  Global accelerator,Route 53, ALB and NLB for high availability, geo-based routing, and failover across multiple AWS regions. Route 53 is configured with geolocation routing to direct users to the nearest region and failover routing to switch to a backup region during outages. Each region uses an Application Load Balancer (ALB) for frontend service load balancing and as an Ingress Controller for backend APIs via Kubernetes (e.g., EKS), supporting host-based routing. For the most critical services Global Accelerator handles the traffic to NLBs in multiple regions to provide static IPs, low-latency routing, and automatic failover based on health  for Network Load Balancer (NLB)  that handles TCP traffic to high-performance services like RDS,Redis,Payemnt,TRansactions etc.This architecture ensures low latency, regional compliance, resilient failover.

Storage: for filesystem is used efs with asynchronus replications in diffrent regions  between backend services. For RDS,Redis and Kafka is used block storage on provisioned iops.Storageclss is enabled on both for dyanmic provisioning,csi add-on plugins and pvcs.

The messaging broker strategy utilize Amazon MSK (Managed Streaming for Apache Kafka) to enable low-latency, high-throughput communication between critical services. MSK acts as a durable, scalable, and managed Kafka cluster for streaming real-time events across microservices. These services (Transaction,Payment,Loan Managment) produce messages to specific Kafka topics for downstream processing.
To enable event-driven workflows, AWS Lambda functions are directly integrated with MSK and act as consumers for Kafka topics. Lambda automatically scales and processes messages as they arrive, eliminating the need to manage consumer groups manually. This setup ensures decoupled, resilient, and reactive processing for business-critical events with minimal operational overhead.

Geo-Partitioned Disaster Recovery Strategy

The disaster recovery strategy for  Aurora global database and Redis global Datastore ensures high availability and fault tolerance across multiple AWS regions. The primary region is eu-west-1 (Ireland), with disaster recovery extending to eu-west-2 (London), eu-west-3 (Paris), and eu-central-1 (Frankfurt). RDS utilizes cross-region read replicas for asynchronous data replication from the primary region to secondary regions. In the event of primary region failure, a read replica can be promoted to a standalone instance with DNS updates or manual promotion.Redis uses Global Datastore for Redis for asynchronous replication between the primary and secondary regions, allowing for failover by DNS redirection or application reconfiguration.  All data is encrypted in transit and at rest, and backup snapshots are stored in cross-region S3 buckets.


Network Firewall Manager:Network Firewall with configurable policies, logging, encryption, and delete protection. It aims to secure VPC traffic, support customizable rule groups
