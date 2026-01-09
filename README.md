# AWS CloudFormation EC2 Auto Scaling Platform

A production-ready EC2 Auto Scaling platform built using **AWS CloudFormation**.
This project demonstrates how to design, deploy, and operate a scalable and secure
infrastructure using Infrastructure as Code (IaC).

The platform uses:
- Application Load Balancer (ALB)
- Auto Scaling Group (ASG)
- EC2 Launch Templates
- AWS Systems Manager (SSM) instead of SSH
- Modular CloudFormation templates (Nested Stacks)

---

## Architecture Overview

This project is intentionally designed using **nested CloudFormation stacks**.
Each stack has a single responsibility, which makes the infrastructure easier to
understand, maintain, and extend.

**High-level flow:**
1. Internet traffic reaches the Application Load Balancer
2. ALB forwards HTTP traffic to EC2 instances
3. EC2 instances run inside an Auto Scaling Group
4. Auto Scaling adjusts capacity based on CPU utilization
5. EC2 instances are managed securely via AWS Systems Manager (no SSH access)

---

## Repository Structure

aws-cloudformation-ec2-autoscaling-platform/
├─── images/
│   ├── 01-cloudformation-stacks-complete.png
│   ├── 02-cloudformation-outputs.png
│   ├── 03-alb-active.png
│   ├── 04-target-group.png
│   ├── 05-asg-created.png
│   ├── 06-ec2-running.png
│   ├── 07-browser-success.png
│   └── 08-S3-Bucket.png
├─ templates/
│ ├─ main.yaml # Parent stack (orchestrates all nested stacks)
│ ├─ security.yaml # Security Groups + IAM Role (SSM)
│ ├─ alb.yaml # Application Load Balancer resources
│ └─ compute.yaml # Launch Template + ASG + Scaling policies
├─ params/
│ └─ dev.json # Environment-specific parameters
├─ scripts/
│ ├─ validate.sh # Template validation
│ ├─ package.sh # Upload nested stacks to S3
│ └─ deploy.sh # Deploy the CloudFormation stack
└─ README.md


---

## Design Decisions (Why This Approach)

### Why Nested Stacks?
Nested stacks help separate concerns:
- Security
- Load Balancing
- Compute & Scaling

This makes the infrastructure modular and easier to reason about.

> Each template does one thing and does it well.

---

### Why No SSH?
SSH access is intentionally disabled.

EC2 instances are managed using **AWS Systems Manager (SSM)**:
- Reduced attack surface
- No open port 22
- Better auditability

This reflects real production security practices.

---

### Why Default VPC?
The goal of this project is to focus on:
- Auto Scaling
- Load Balancing
- Infrastructure design

Using the default VPC keeps the project simple while still realistic.
In real production environments, a custom VPC would typically be used.

---

## Prerequisites

- AWS CLI installed and configured
- An AWS account
- Default VPC available in the selected region
- Permissions to create:
  - EC2
  - Auto Scaling
  - ALB
  - IAM roles
  - CloudFormation stacks
  - S3 buckets

---

## Deployment Steps

### 1. Make scripts executable
```bash
chmod +x scripts/*.sh


2. Update parameters

Edit params/dev.json and set:

Default VPC ID

At least two subnet IDs from the same VPC

./scripts/validate.sh

This uploads nested templates to S3 and generates packaged.yaml.

./scripts/deploy.sh

After deployment completes:

Open CloudFormation console

Copy the Load Balancer DNS output

Open it in your browser

You should see a simple Healthy web page

Auto Scaling Behavior

Minimum instances: 1

Desired capacity: 2

Maximum instances: 4

Scaling policy: Target Tracking on average CPU utilization (50%)

Security Summary

No SSH access

EC2 instances only accept traffic from the ALB

ALB accepts HTTP traffic from the internet

IAM permissions follow least-privilege principles

IMDSv2 is enforced on EC2 instances

## 📸 Deployment Screenshots

This section documents the successful deployment of the EC2 Auto Scaling platform using AWS CloudFormation.

---

### 1. CloudFormation – Stacks Created Successfully
![CloudFormation Stacks](images/01-cloudformation-stacks-complete.png)

---

### 2. CloudFormation – Stack Outputs
![CloudFormation Outputs](images/02-cloudformation-outputs.png)

---

### 3. Application Load Balancer – Active
![ALB Active](images/03-alb-active.png)

---

### 4. Target Group Created
![Target Group](images/04-target-group.png)

---

### 5. Auto Scaling Group Created
![ASG Created](images/05-asg-created.png)

---

### 6. EC2 Instances Running
![EC2 Running](images/06-ec2-running.png)

---

### 7. Application Accessible via Load Balancer
![Browser Success](images/07-browser-success.png)

---

### 8. S3 Bucket for CloudFormation Artifacts
![S3 Bucket](images/08-S3-Bucket.png)


What This Project Demonstrates :

Infrastructure as Code with CloudFormation

Modular and maintainable template design

Secure EC2 access using AWS Systems Manager

Auto Scaling based on real metrics

Production-oriented security mindset

Clean GitHub repository structure

