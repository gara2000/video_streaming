# AWS Video Streaming service automation
Refer to the [Getting started](#5--getting-started) section to deploy the service
<br/>

**TABLE OF CONTENTS**
<!-- TOC depthFrom:2 -->
- [1- Introduction](#1--introduction)
- [2- Architecture](#2--architecture)
    - [2.1- Network architecture](#21--network-architecture)
    - [2.2- Instances and roles](#22--instances-and-roles)
        - [2.2.1- Frontend server](#221--frontend-server)
        - [2.2.2- Bastion server](#222--bastion-server)
        - [2.2.3- Backend streamer server](#222--backend-streamer-server)
- [3- Implementation details](#3--implementation-details)
    - [3.1- Infrastructure provisioning with terraform](#31--infrastructure-provisioning-with-terraform)
        - [3.1.1- Modular design](#311-modular-design)
        - [3.1.2- Infra module](#312-infra-module)
        - [3.1.3- Instance module](#312-infra-module)
        - [3.1.4- Inventory module](#312-infra-module)
    - [3.2- Server configuration with Ansible](#31--server-configuration-with-ansible)
        - [3.2.1- Dynamic inventory](#321--dynamic-inventory)
        - [3.2.2- Ansible roles](#322--ansible-roles)
        - [3.2.3- Nginx roles](#323--ansible-roles)
        - [3.2.4- SSL roles](#324--ansible-roles)
        - [3.2.5- Nat roles](#325--ansible-roles)
- [4- Security measures](#4--security-measures)
    - [4.1- Principle of least privilege](#41--principle-of-least-privilege)
    - [4.2- Isolation of backend server](#41--isolation-of-backend-server)
    - [4.3- Use of bastion server](#41--use-of-bastion-server)
    - [4.3- Data encryption with ssl](#41--data-encryption-with-ssl)
        (talk about route53)
- [5- Getting started](#5--getting-started)
    - [5.1- Building the infrastructure](#51--building-the-infrastructure)
    - [5.2- Configuring the servers](#51--configuring-the-servers)
    - [5.3- Testing the video streaming service](#53--testing-the-video-streaming-service)


<!-- /TOC -->
<br/>

## 1- Introduction
This project aims to develop an automated environment for deploying a video streaming service on the AWS public cloud. This project is designed to provide a robust, scalable, and secure infrastructure for video streaming, leveraging the power of AWS services and automation tools such as Terraform and Ansible.

The infrastructure for the project consists of two subnets within the same Virtual Private Cloud (VPC): a public subnet and a private subnet. The public subnet hosts two critical instances: the frontend server, which runs an Nginx server to render video streams on the web, and the bastion server, which acts as a proxy for the backend streamer server. The backend streamer server, located in the private subnet, uses ffmpeg to stream video content to the frontend server and connects to the internet through the bastion server.

To ensure high availability and security, we use Amazon Route 53 to provide a domain name and Certbot to issue SSL certificates for secure HTTPS communication. The entire infrastructure setup is automated using Terraform, while Ansible is used for configuring all the servers. A strong emphasis is placed on security throughout the project, adhering to the principle of least privilege, isolating the backend server, and encrypting data transmissions with SSL.

This README will delve into the design, implementation, and security aspects of the project, highlighting its key features.

![graph](assets/graph.png)

## 2- Architecture
### 2.1- Network architecture
Our infrastructure is hosted within a single VPC, which provides a logically isolated network in the AWS cloud. The VPC is configured with two subnets: a public subnet and a private subnet.  
**Public subnet**: This subnet is accessible from the internet and hosts the frontend server and the bastion server. The public subnet is designed to handle incoming and outgoing internet traffic through an AWS internet gateway, ensuring that the servers hosted in the VPC can interact with external clients and services.
**Private subnet**: This subnet is isolated from direct internet access, providing an additional layer of security for sensitive operations. The private subnet hosts the backend streamer server, which handles the actual video streaming tasks. By isolating the backend server, we limit its exposure to potential external threats. However please note the following:
- Even though the backend server is isolated, it can access the internet by using the bastion server as a nat server. all external traffic from the backend server is routed to the bastion server that routes it to the internet through the internet gateway.
- To configure the backend server with ansible we need SSH access, this is ensured by using the bastion server as proxy, this will be further detailed when we talk about the [Ansible inventory](#321--dynamic-inventory).


## 3- Implementation details
## 4- Security measures

# 5- Getting started