# Creating a VM or a Container: Pros and Cons

## Introduction
This document discusses the pros and cons of creating resources as virtual machines (VMs) or containers, as well as when to use each option. It is important to choose the right option based on your use case and available resources.

## Virtual Machines vs. Containers

### Resource Usage
- Containers use fewer resources compared to VMs.
- VMs allocate a fixed amount of resources (RAM, CPU) to each instance, while containers use only the resources they need up to a defined limit.
- If you have limited resources, like 4 GB of RAM, it is better to use containers.

### Migration
- VMs can be live migrated, meaning they can be moved from one host to another without any downtime.
- Containers can be migrated, but not live migrated. They need to be shut down, copied to the new host, and then restarted, resulting in downtime.

### Support and Compatibility
- Not all applications run properly in containers, and there is no master list of compatible applications.
- Some vendors might deny support for their applications if run in a container.

## Choosing Between VMs and Containers

1. **Resource Availability**: If you have limited resources (e.g., 4 GB of RAM), it is better to use containers.
2. **Need for Live Migration**: If your application cannot afford any downtime, VMs are a better choice as containers cannot be live migrated.
3. **Vendor Support and Compatibility**: If you need vendor support or know that an application is not compatible with containers, choose VMs.

