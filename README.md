# Apache-Fineract

Apache Fineract is an open-source platform for core banking and financial services. Application consist of 20 microservices.The languages for the application are java 17 for backend and HTML/CSS/JavaScript for frontend.For build process is used maven:3.9.4.PostgreSQL for RDS and Redis for cache.

Docker: backend image-for dev maven:3.9.4-openjdk-17 AS dev-builder for prod maven:3.9.4-openjdk-17 AS prod-builder to openjdk:17-slim defined in multi stage build.For fronted image-node:18 with images for dev/stage and for prod cleaned for unecessary dependencies.Standart images for PostgreSQL and Redis.


Kubernetes services : you can check the folder services ,every file have templates for deployment,service and service account and load balancers and values for them. Deployment file consist of replicas,image from ecr,service account name,resource request and limit,livness and readiness probe volume mount for efs for backend services and ebs for database and redis. Service account is connected to eks-irsa. Service contains load balancers with annotations for ALB,Ingress and NLB. Database contains headless service and also verticaland horizontal load balancers and secrets.


For CI/CD is used jenkins.

Regions:eu-west-1(main region),eu west 2,3 and eu-central 1(used for regolatory complience based on DE,FR and GBR local laws for data sovereign ity)

EKS: Diffrent clusters for every nviroment and regions(9).In the cluster are used public and private node groups,cluster autoscaler.

VPC:components for the network include public,private and database subnets,nat gateway,internet gateway,dns hostname,route table,availability zones,and vpc name.

The solution integrates AWS Cloud WAN to enable centralized hybrid connectivity across multiple AWS regions and on-premises data centers. Calico CNI with VXLAN overlay networking is used within Kubernetes clusters for secure pod-to-pod communication. Cloud WAN segments and routing policies ensure seamless, secure traffic flow between environments

Transit Gateway strategy:Inter-Region Peering

Mesh Peering Topology: Each TGW will be peered with every other TGW for full regional mesh.

Use TGW Peering Attachments for each region pair.

Enable route propagation in each TGW’s route table for peering attachments

EKS_IRSA:Config for iam for service account with oidc token and necessary policies and permissions.

Ingress controller to work with ALB for the services with Http and NLB for RDS and Redis.

Route53 works like global load balancer with failover routing connected to alb and nlb.

Storage: for filesystem is used efs with replications in diffrent regions and datasync between backend services and for RDS and Redis is used block storage on provisioned iops.Storageclss is enabled on both for dyanmic provisioning,csi add-on plugins and pvcs.

Event driven system with SQS and Lambda for Loan managment and Client Data Managment.



ChatGPT
Запаметената памет е пълна
Вие казахте:
If you are using cloud wan with transit gateway for diffrent partitions do you also need direct connect
ChatGPT каза:
If you are using AWS Cloud WAN with Transit Gateway to connect different AWS partitions (e.g., commercial AWS, AWS GovCloud, AWS China), you may still need Direct Connect in certain cases — depending on your performance, security, and data residency requirements.

Here’s a breakdown:

When Cloud WAN + Transit Gateway is Enough:
For connecting VPCs across regions within the same partition, Cloud WAN handles the routing.

Transit Gateway attachments (either directly or via peering) can be used for multi-region connectivity.

No Direct Connect needed if you’re staying within the same partition and your use case tolerates standard internet/VPN latency.

When You Still Need Direct Connect:
Cross-partition connectivity (e.g., Commercial AWS to GovCloud/China):

AWS Cloud WAN and Transit Gateway do not support native cross-partition routing.

You must use Direct Connect or VPNs for connectivity between partitions.

For example, to connect a VPC in GovCloud to one in Commercial, you’d often use:

Direct Connect Gateway + Hosted Connections.

Or IPSec VPN over the internet.

Dedicated private connectivity:

If you need lower latency, higher throughput, or private link-style access between your on-premises and AWS, then Direct Connect is useful.

Cloud WAN and Transit Gateway work over AWS's backbone, but not necessarily with the performance guarantees of Direct Connect.

Compliance or data sovereignty:

Some regulated environments require private circuits like Direct Connect for compliance.

Conclusion:
If your architecture spans different AWS partitions, or you require dedicated, private connectivity, then yes, Direct Connect is still needed. Cloud WAN and Transit Gateway are not sufficient on their own for such cases.

Would you like an example architecture showing how Cloud WAN, TGW, and Direct Connect work together across partitions?

Вие казахте:
But does eu west 2 in france partition
ChatGPT каза:
No, eu-west-2 (London) is not in the France partition — in fact, it is in the standard (commercial) AWS partition.

Here’s a quick breakdown:

AWS Commercial Partition (Standard)
Regions like:

eu-west-1 (Ireland)

eu-west-2 (London)

eu-west-3 (Paris)

eu-central-1 (Frankfurt)

etc.

All of these are part of the same commercial partition and can be connected using Cloud WAN and Transit Gateway without needing Direct Connect for cross-region communication.

France-specific AWS Region
eu-west-3 is the Paris region, and it is also in the commercial partition — it is not a separate partition.

Special Partitions
AWS GovCloud (US) – partition for US government workloads.

AWS China – isolated partition with different operators (Beijing, Ningxia).

AWS Top Secret / Secret – government-classified partitions.

Conclusion:
eu-west-2 is in the commercial partition — no special partitioning. You do not need Direct Connect just because it's in a different geographic location like France or the UK. Cloud WAN and Transit Gateway can connect all commercial regions natively.

Would you like a reference architecture for this kind of setup?

Вие казахте:
Who are the commercial partitions who are not
ChatGPT каза:
Great question. Here's a clear breakdown of which AWS partitions are considered "commercial" and which are not:

1. Commercial AWS Partition (Standard AWS)
These are the default AWS regions everyone uses unless explicitly working in regulated or restricted environments.
Partition name: aws

Regions (some examples):

US: us-east-1, us-west-1, us-west-2

Europe: eu-west-1 (Ireland), eu-west-2 (London), eu-west-3 (Paris), eu-central-1 (Frankfurt), eu-north-1 (Stockholm), eu-south-1 (Milan)

Asia Pacific: ap-southeast-1 (Singapore), ap-northeast-1 (Tokyo), ap-south-1 (Mumbai)

South America: sa-east-1 (São Paulo)

Africa: af-south-1 (Cape Town)

Middle East: me-central-1 (UAE), me-south-1 (Bahrain)

Canada: ca-central-1 (Canada Central)

These can all be connected natively using Cloud WAN, Transit Gateway, VPC Peering, etc.

2. AWS GovCloud (US) Partition
Partition name: aws-us-gov
For workloads that require FedRAMP High, ITAR, DoD SRG, etc.

Regions:

us-gov-west-1

us-gov-east-1

Cannot connect natively to commercial AWS (e.g., no direct TGW peering with us-east-1) — use Direct Connect or VPN.

3. AWS China Partition
Partition name: aws-cn
Operated by local Chinese partners under separate legal and operational controls.

Regions:

cn-north-1 (Beijing) – operated by Sinnet

cn-northwest-1 (Ningxia) – operated by NWCD

Cannot connect natively to commercial AWS or GovCloud. Must use VPN or Direct Connect (if approved).

4. AWS Secret / Top Secret
These are classified environments used by U.S. intelligence and defense.

Partition names:

aws-iso – Secret

aws-iso-b – Secret (East)

aws-us-iso-east-1, aws-us-iso-west-1, etc.

aws-us-isob-east-1 – Top Secret

These are highly restricted and cannot connect to any commercial AWS resources.

Summary Table:
Partition	Example Regions	Native Cloud WAN/TGW Support	Direct Connect/VPN Needed for Commercial?
aws (Commercial)	us-east-1, eu-west-2	Yes	No
aws-us-gov	us-gov-west-1	No	Yes
aws-cn	cn-north-1	No	Yes (with approval)
aws-iso / isob	aws-us-iso-east-1	No	Yes
Would you like a diagram showing how connectivity works between these partitions?

Вие казахте:
Can you tell me how to describe for project documentation geo partitioned disaster recovery strategy for rds and redis
ChatGPT каза:
Certainly! Here's how you can describe a Geo-Partitioned Disaster Recovery Strategy for Amazon RDS and Redis (typically ElastiCache) in your project documentation. This template balances technical clarity with architectural reasoning:

Geo-Partitioned Disaster Recovery Strategy
Overview
This document outlines the disaster recovery (DR) architecture for Amazon RDS and Redis across multiple AWS regions to ensure high availability, fault tolerance, and business continuity in the event of regional outages or disasters.

1. Objectives
Ensure minimal downtime and data loss during a regional failure.

Enable automatic or manual failover to a secondary AWS region.

Maintain data consistency and performance under failover conditions.

2. Strategy Summary
Component	Primary Region	Secondary Region	DR Approach	RTO (Recovery Time Objective)	RPO (Recovery Point Objective)
RDS	eu-west-1	eu-west-3	Cross-Region Read Replica or Aurora Global DB	< 15 minutes	< 5 minutes
Redis	eu-west-1	eu-west-3	Asynchronous replication via Global Datastore (ElastiCache for Redis)	< 5 minutes	< 1 minute
3. RDS (Relational Database Service)
Option A: Cross-Region Read Replicas (for MySQL/PostgreSQL)
A read replica is created in the secondary region (eu-west-3).

In case of primary region failure, promote the replica to standalone master.

Failover process is manual or automated via Route 53 and application logic.

Option B: Aurora Global Database (for Aurora MySQL/PostgreSQL)
Supports multi-region clusters with low-latency replication (< 1s).

Automatic failover supported with Aurora Global Database Failover feature.

Supports application failover with minimal impact.

4. Redis (Amazon ElastiCache for Redis)
Global Datastore for Redis
Redis is configured with Global Datastore for asynchronous replication between regions.

Primary region (eu-west-1) writes replicate to secondary region (eu-west-3).

In case of failure, failover to the replica cluster is initiated manually or scripted.

Applications re-point to the secondary endpoint (Route 53 DNS shift or configuration update).

5. Data Synchronization
All replication strategies are eventually consistent, with replication lag typically < 1s.

Monitoring is in place using CloudWatch Alarms, Amazon SNS, and AWS Health Dashboard.

6. Failover and Recovery Process
Detection: Automated via health checks (CloudWatch, Route 53, ELB health).

Initiation: Manual promotion or automated failover.

Redirection: DNS or service discovery redirects traffic to secondary endpoints.

Recovery: Once the primary region is restored, reverse replication or re-sync is performed before failback.

7. Security and Compliance
All data in transit and at rest is encrypted using KMS.

IAM roles and cross-region policies are configured to restrict unauthorized access.

Backup snapshots are stored in cross-region S3 buckets as part of compliance.

8. Testing and Validation
Disaster Recovery drills are conducted quarterly.

Failover simulations include region disablement, replica promotion, and application switchover.

Logs and metrics are collected for post-event review.

Would you like me to generate a visual architecture diagram based on this documentation?

Вие казахте:
I want to write it in a small text
ChatGPT каза:
Here’s a concise version you can include in your project documentation:

Geo-Partitioned Disaster Recovery Strategy

Our disaster recovery design ensures high availability for Amazon RDS and Redis across AWS regions. RDS (PostgreSQL/Aurora) uses cross-region read replicas or Aurora Global Database to replicate from the primary region (eu-west-1) to the DR region (eu-west-3). In case of failure, replicas are promoted to standalone instances with DNS failover.

Redis (ElastiCache) uses Global Datastore for asynchronous replication between regions. The DR region maintains a replica cluster that can be promoted during regional outages. Failover involves DNS switching or reconfiguration to route traffic to the secondary region.

Recovery objectives: RTO < 15 mins, RPO < 5 mins. Data is encrypted in transit and at rest. Failover processes are tested quarterly.

Would you like a version of this tailored for stakeholders or compliance teams?

Вие казахте:
What means asynchronus replication
ChatGPT каза:
Asynchronous replication means that data is copied from the primary database or cache to the replica after the write is completed on the primary, not at the same exact moment.

Key Points:
Primary first: The write happens on the primary system.

Replica later: The data is then sent to the replica, but there can be a delay (replication lag).

Risk: If the primary fails before the latest changes are replicated, those changes may be lost.

Example:
You write a value to Redis in eu-west-1. It accepts the write and immediately returns success to your app. A few milliseconds or seconds later, that write is copied to eu-west-3. If eu-west-1 crashes before that sync, eu-west-3 may not have that write.

This contrasts with synchronous replication, where the write only succeeds after all replicas confirm they received it — more durable but slower.

Would you like a simple diagram showing this flow?

Вие казахте:
Can you write it again but i want startegy to be from eu west 1 emea region to eu west 2 and eu west 2 3 and eu central 1 to the primary region
ChatGPT каза:
Sure! Here's an updated version of the disaster recovery strategy with a focus on cross-region replication from eu-west-1 (primary region) to eu-west-2, eu-west-3, and eu-central-1 (secondary regions):

Geo-Partitioned Disaster Recovery Strategy

The disaster recovery strategy ensures high availability and fault tolerance for Amazon RDS and Redis across multiple AWS regions. The primary region is eu-west-1 (Ireland), with failover to eu-west-2 (London), eu-west-3 (Paris), and eu-central-1 (Frankfurt).

RDS (PostgreSQL/Aurora):

Uses cross-region read replicas to replicate data asynchronously from the primary region (eu-west-1) to secondary regions (eu-west-2, eu-west-3, eu-central-1).

In case of failure, the read replica can be promoted to a standalone instance in the secondary region.

Failover is managed by DNS updates (via Route 53) or manual promotion of replicas.

Redis (ElastiCache):

Uses Global Datastore for Redis for asynchronous replication between the primary region (eu-west-1) and secondary regions (eu-west-2, eu-west-3, eu-central-1).

Replication lag is minimized, but in case of a primary region failure, the secondary region can be promoted to take over.

Failover is achieved by DNS redirection or application-level reconfiguration.

Recovery Objectives:

RTO (Recovery Time Objective): < 15 minutes

RPO (Recovery Point Objective): < 5 minutes

All data is encrypted in transit and at rest. Regular disaster recovery drills are performed to ensure processes are tested, and backup snapshots are stored in cross-region S3 buckets for compliance.

This concise version should work for a quick overview. Let me know if you'd like any more details or additional adjustments!

Вие казахте:
Write it in one text for the documentation
ChatGPT каза:
Certainly! Here's the entire disaster recovery strategy written in one concise paragraph for your documentation:

Geo-Partitioned Disaster Recovery Strategy

The disaster recovery strategy for Amazon RDS and Redis ensures high availability and fault tolerance across multiple AWS regions. The primary region is eu-west-1 (Ireland), with disaster recovery extending to eu-west-2 (London), eu-west-3 (Paris), and eu-central-1 (Frankfurt). RDS utilizes cross-region read replicas for asynchronous data replication from the primary region to secondary regions. In the event of primary region failure, a read replica can be promoted to a standalone instance with DNS updates or manual promotion. Redis uses Global Datastore for Redis for asynchronous replication between the primary and secondary regions, allowing for failover by DNS redirection or application reconfiguration.The RTO (Recovery Time Objective) is set to under 15 minutes, and the RPO (Recovery Point Objective) is under 5 minutes.

WAF: firewall rules for every VPC and SQL injection protection for RDS.
