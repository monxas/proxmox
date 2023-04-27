# CrowdSec and Proxmox Firewall Tutorial

This document provides a step-by-step guide on CrowdSec, an open-source intrusion protection system, and Proxmox, an integrated firewall feature. The following topics are covered:

1. [Introduction to CrowdSec](#introduction-to-crowdsec)
2. [Installing CrowdSec](#installing-crowdsec)
3. [Understanding Proxmox Firewall](#understanding-proxmox-firewall)
4. [Configuring Proxmox Firewall Rules](#configuring-proxmox-firewall-rules)

## Introduction to CrowdSec

CrowdSec is an open-source and collaborative intrusion protection system. It blocks unwanted behaviors such as port scans, cross-site scripting, brute forcing, and more. It's a community-based security solution that enhances the protection of your servers by sharing information about intrusion attempts.

## Installing CrowdSec

To install CrowdSec, follow these steps:

1. Add the repository to your server.
2. Install the required packages.
3. Start and enable the service.

For more information and documentation, visit the CrowdSec website. You can also watch the installation video on the same channel.

## Understanding Proxmox Firewall

Proxmox includes an integrated firewall feature by default. To access and configure the firewall, navigate to the Proxmox web console. You'll find firewall sections in Data Center, Host, Container, and VM views.

**Important**: Do not enable the firewall until you have created the necessary rules; otherwise, you risk losing access to the Proxmox web console.

## Configuring Proxmox Firewall Rules

Follow these steps to create and manage firewall rules in Proxmox:

1. **Create a base rule**: Go to Data Center view, click on Firewall, and add a rule. For example, create a rule that accepts traffic going to port 8006 (Proxmox web console).

2. **Enable/disable the firewall**: In Data Center view, click on Firewall, then Options. Set the Firewall to "yes" or "no" depending on your needs. Remember, do not enable the firewall until you have the necessary rules in place.

3. **Create rules for specific hosts**: Navigate to the host view, click on Firewall, and add a rule. For example, create a rule that allows SSH access to the host for a specific IP address.

4. **Create rules for containers and VMs**: In Container or VM view, click on Firewall, and add a rule. Note that you must enable the firewall for each container or VM individually.

5. **Test your rules**: Verify that your firewall rules are working as expected by trying to access the Proxmox web console, SSH, or other services from allowed and disallowed IP addresses.

Remember that the firewall rules in Proxmox are abstracted. Rules created in the Data Center view apply to the entire data center, while rules created for specific hosts, containers, or VMs apply only to those objects.

In the next tutorial, we'll explore the command line in Proxmox for advanced configurations and management.
