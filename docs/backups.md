# Proxmox Backups and Snapshots Tutorial

This tutorial will cover the process of creating backups and snapshots in Proxmox. Backing up your servers is extremely important, and this guide will teach you how to do it effectively.

## Table of Contents

- [Introduction](#introduction)
- [Snapshots](#snapshots)
  - [Creating a Snapshot](#creating-a-snapshot)
  - [Reverting a Snapshot](#reverting-a-snapshot)
- [Backups](#backups)
  - [Creating a Backup](#creating-a-backup)
  - [Restoring a Backup](#restoring-a-backup)
- [Automating Backups](#automating-backups)

## Introduction

Proxmox supports both snapshots and backups for virtual machines (VMs) and containers. This tutorial will demonstrate how to create and manage both types, using a sample virtual machine.

## Snapshots

Snapshots are part of the virtual machine disk itself and cannot be moved to another system. They are useful for testing new software or changes without committing to them permanently.

### Creating a Snapshot

1. Select the virtual machine from the Proxmox dashboard.
2. Navigate to the "Snapshot" section.
3. Click "Take Snapshot."
4. Name the snapshot to describe its purpose (e.g., "Before removing Apache").
5. Optionally, check "Include RAM" to save the state of the memory as well.
6. Click "Take Snapshot."

### Reverting a Snapshot

1. Select the virtual machine and go to the "Snapshot" section.
2. Click the snapshot you wish to revert to.
3. Click "Rollback" and confirm.

## Backups

Backups are separate from the virtual machine and can be moved to different storage media. They are a full clone of the disk, providing an extra layer of safety.

### Creating a Backup

1. Select the virtual machine from the Proxmox dashboard.
2. Navigate to the "Backup" section.
3. Click "Backup Now."
4. Choose the storage location for the backup.
5. Select the backup mode: Snapshot, Suspend, or Stop. Snapshot mode offers the least downtime, while Stop mode provides the best consistency.
6. Click "Backup" to start the process.

### Restoring a Backup

1. Select the virtual machine from the Proxmox dashboard.
2. Go to the "Backup" section.
3. Click on the backup you want to restore.
4. Click "Restore."
5. Select the storage location and check "Start after restore" if desired.
6. Click "Restore" and confirm.

## Automating Backups

1. Navigate to the "Datacenter" tab in the Proxmox dashboard.
2. Go to the "Backup" section.
3. Click "Add" to create a new backup task.
4. Configure the backup job settings, such as nodes, schedule, email notifications, and compression.
5. Click "Add" to save the backup job.

Remember to store backups on shared storage for added security. And make sure to subscribe to stay updated on future Proxmox tutorials.
