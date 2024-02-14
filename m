Return-Path: <linux-hyperv+bounces-1541-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358C7855732
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Feb 2024 00:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA360291A38
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Feb 2024 23:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806301419A6;
	Wed, 14 Feb 2024 23:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlb7UciY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B69E13F003;
	Wed, 14 Feb 2024 23:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952986; cv=none; b=mMyBcNkfB1IT9fDTp8eEw2cqulnJtUuk+ZBZcz7DJgAoYTda/Od0guRs+LkXU8sKUQA4L/sHmJSsQKtGBuqZMU4mZBbvd6hWpdhimAkpI3ZOK4fej4CwI+pyI193JIBXl07JC+x4e0U1zr605fXVw3wwEkAjEg/dA+THgYunUzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952986; c=relaxed/simple;
	bh=QZUV7KfLh0I8FO4ob4zXZhcDRJCppteXHeOz8VTXuog=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=LddNzmMep6pmCjdV4kc9TniQme1uDVzCFmkoLgoUUYz/Vllr/L4WjyPvVj3X7YFuWZ8ppIrm4FXGoAw9aWmfodSc+S4q9ehXcT7obiXWZ5qQFgMRre45zwHVehLa3/i4VQ5KMItINIROyPzevJNrltMleoCHtPnEPPvXb5e+S6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlb7UciY; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1db5212e2f6so2374135ad.1;
        Wed, 14 Feb 2024 15:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707952983; x=1708557783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nDrQMmEE/Mb8rtIW+LtKN2gOVhTXwHt8O63H7b/OXSI=;
        b=dlb7UciYahjFt1AgAWPDOhDKoWBWbXrx23XJuoIsF1R9LHNJpM/Z0d+XOVHwTnZ2Wl
         kBPMMfGfhDkhjaidOeLNZTIRQ7pqipTbPXZ8eIW6052rWuw1NaNB1Ogc7akgWyopBRzM
         Ygx5XbEMHv42UYDXk1yvWRLmjtCT4ObhrX66efSiq/d6LFB0ZK46aC18OeHdFd7f/WlX
         ZDN+B7sTqmrbc7vAYvDXaaohsBNXcyxFo6XTq6aH32trUYU/G4pO01XXXledyUHH+oLz
         m+8BPYi9eLAonu3uFGU14MeBX83CxqTCAcJCG4joupYOi1nRSutOX9u+g2OQtnB/pbob
         rcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707952983; x=1708557783;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDrQMmEE/Mb8rtIW+LtKN2gOVhTXwHt8O63H7b/OXSI=;
        b=GlODwUzJcv1EOIMyvXb3lc2eKewGsKvNoi+ahW/EBlmyqTIdB2zPf604atDTUKMT4B
         DKqiKWNBn2lXVU8Suq0GVh1IVMssKPCq/5j7dw0YHzKEqZ0VHx5JX09R5244+bl2MJoa
         Fj2SKsgFHiZqT89Jht96RQtDP9NM4gbNS7hCdDsdwCcBE25ruKLgm7UDb0hxym5dLi/j
         irHJVDIv4CwxXINC3tGfrnHAK3rYzKX2u9wI4zIUrdk25hKEBke0bdNZEResG0yNAOKS
         XWOCZHHEUWrYBd7RVz2QCv69p4NAoNKL2qAhWuLH+4RR+5o7dBtZRycr5la9uVgJlrZS
         qemQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnwh2ga2REMunvynBDFW8s3dqwexUc4JtY2R4r5KjNg0hDKR3Uuu8Kn/PHBD6jBqH4Rwwt8n5cxDqArsuH1M2FqWcGBYegdiLwMukltddMyy56SbsPksL2Lri+cWnqSbNyFIwwQS3+tVYrVmKJHLw1bDEynMNVbs6CYSB6c7K32Quk7pRy
X-Gm-Message-State: AOJu0YyNtKQOm0/kDBr+UXDhB2tzfJo5A7MeCwuLPazIKkk24UX+/EGw
	nmSBT0NdQYmCNIg2O013KEP+qiIcMe8plv8ArInDNbJNEkrbIOfusMR9f/WY
X-Google-Smtp-Source: AGHT+IGk7ecPkDvYGRpVK0RCMxFEC5pE1lsDD9lRNsqitrbUcitJJJTRorCmWPRk8QYm2AAnHcfvBg==
X-Received: by 2002:a17:903:244f:b0:1d9:34ff:f807 with SMTP id l15-20020a170903244f00b001d934fff807mr41964pls.31.1707952983286;
        Wed, 14 Feb 2024 15:23:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWO93v/ndMEmIECnvAojG8AGMNjRCxUxOZorcmZIn6Loek0o094Niwif4sp47oaNNg6ezJ+AJH6OrHT0Pi18Wg5dSzI7j3oS/SENqpz+1Kw1cCbc1mjBRzpkgUL+4cjkbnPQv4oS2eaX3W5/11F5TE+o7OBw8WYApdYrxfpf/cKaQ5nnW1mhm5MYwfKGL0xy5H06PxxNliazrKOzc0QkyeYxRdDJsVZXuqG2QQAq2Ex+Pdt8g5OBlU84BN9geOt
Received: from mhkubun.hawaii.rr.com (076-173-166-017.res.spectrum.com. [76.173.166.17])
        by smtp.gmail.com with ESMTPSA id ji4-20020a170903324400b001da27b24a24sm4291348plb.1.2024.02.14.15.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 15:23:03 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/1] Documentation: hyperv: Add overview of PCI pass-thru device support
Date: Wed, 14 Feb 2024 15:22:53 -0800
Message-Id: <20240214232253.4558-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Add documentation topic for PCI pass-thru devices in Linux guests
on Hyper-V and for the associated PCI controller driver (pci-hyperv.c).

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 Documentation/virt/hyperv/index.rst |   1 +
 Documentation/virt/hyperv/vpci.rst  | 316 ++++++++++++++++++++++++++++
 2 files changed, 317 insertions(+)
 create mode 100644 Documentation/virt/hyperv/vpci.rst

diff --git a/Documentation/virt/hyperv/index.rst b/Documentation/virt/hyperv/index.rst
index 4a7a1b738bbe..de447e11b4a5 100644
--- a/Documentation/virt/hyperv/index.rst
+++ b/Documentation/virt/hyperv/index.rst
@@ -10,3 +10,4 @@ Hyper-V Enlightenments
    overview
    vmbus
    clocks
+   vpci
diff --git a/Documentation/virt/hyperv/vpci.rst b/Documentation/virt/hyperv/vpci.rst
new file mode 100644
index 000000000000..dbca50f31923
--- /dev/null
+++ b/Documentation/virt/hyperv/vpci.rst
@@ -0,0 +1,316 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+PCI pass-thru devices
+=========================
+In a Hyper-V guest VM, PCI pass-thru devices (also called
+virtual PCI devices, or vPCI devices) are physical PCI devices
+that are mapped directly into the VM's physical address space.
+Guest device drivers can interact directly with the hardware
+without intermediation by the host hypervisor.  This approach
+provides higher bandwidth access to the device with lower
+latency, compared with devices that are virtualized by the
+hypervisor.  The device should appear to the guest just as it
+would when running on bare metal, so no changes are required
+to the Linux device drivers for the device.
+
+Hyper-V terminology for vPCI devices is "Discrete Device
+Assignment" (DDA).  Public documentation for Hyper-V DDA is
+available here: `DDA`_
+
+.. _DDA: https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/plan/plan-for-deploying-devices-using-discrete-device-assignment
+
+DDA is typically used for storage controllers, such as NVMe,
+and for GPUs.  A similar mechanism for NICs is called SR-IOV
+and produces the same benefits by allowing a guest device
+driver to interact directly with the hardware.  See Hyper-V
+public documentation here: `SR-IOV`_
+
+.. _SR-IOV: https://learn.microsoft.com/en-us/windows-hardware/drivers/network/overview-of-single-root-i-o-virtualization--sr-iov-
+
+This discussion of vPCI devices includes DDA and SR-IOV
+devices.
+
+Device Presentation
+-------------------
+Hyper-V provides full PCI functionality for a vPCI device when
+it is operating, so the Linux device driver for the device can
+be used unchanged, provided it uses the correct Linux kernel
+APIs for accessing PCI config space and for other integration
+with Linux.  But the initial detection of the PCI device and
+its integration with the Linux PCI subsystem must use Hyper-V
+specific mechanisms.  Consequently, vPCI devices on Hyper-V
+have a dual identity.  They are initially presented to Linux
+guests as VMBus devices via the standard VMBus "offer"
+mechanism, so they have a VMBus identity and appear under
+/sys/bus/vmbus/devices.  The VMBus vPCI driver in Linux at
+drivers/pci/controller/pci-hyperv.c handles a newly introduced
+vPCI device by fabricating a PCI bus topology and creating all
+the normal PCI device data structures in Linux that would
+exist if the PCI device were discovered via ACPI on a bare-
+metal system.  Once those data structures are set up, the
+device also has a normal PCI identity in Linux, and the normal
+Linux device driver for the vPCI device can function as if it
+were running in Linux on bare-metal.  Because vPCI devices are
+presented dynamically through the VMBus offer mechanism, they
+do not appear in the Linux guest's ACPI tables.  vPCI devices
+may be added to a VM or removed from a VM at any time during
+the life of the VM, and not just during initial boot.
+
+With this approach, the vPCI device is a VMBus device and a
+PCI device at the same time.  In response to the VMBus offer
+message, the hv_pci_probe() function runs and establishes a
+VMBus connection to the vPCI VSP on the Hyper-V host.  That
+connection has a single VMBus channel.  The channel is used to
+exchange messages with the vPCI VSP for the purpose of setting
+up and configuring the vPCI device in Linux.  Once the device
+is fully configured in Linux as a PCI device, the VMBus
+channel is used only if Linux changes the vCPU to be
+interrupted in the guest, or if the vPCI device is removed by
+the VM while the VM is running.  The ongoing operation of the
+device happens directly between the Linux device driver for
+the device and the hardware, with VMBus and the VMBus channel
+playing no role.
+
+PCI Device Setup
+----------------
+PCI device setup follows a sequence that Hyper-V originally
+created for Windows guests, and that can be ill-suited for
+Linux guests due to differences in the overall structure of
+the Linux PCI subsystem compared with Windows.  Nonetheless,
+with a bit of hackery in the Hyper-V virtual PCI driver for
+Linux, the virtual PCI device is setup in Linux so that
+generic Linux PCI subsystem code and the Linux driver for the
+device "just work".
+
+Each vPCI device is set up in Linux to be in its own PCI
+domain with a host bridge.  The PCI domainID is derived from
+bytes 4 and 5 of the instance GUID assigned to the VMBus vPCI
+device.  The Hyper-V host does not guarantee that these bytes
+are unique, so hv_pci_probe() has an algorithm to resolve
+collisions.  The collision resolution is intended to be stable
+across reboots of the same VM so that the PCI domainIDs don't
+change, as the domainID appears in the user space
+configuration of some devices.
+
+hv_pci_probe() allocates a guest MMIO range to be used as PCI
+config space for the device.  This MMIO range is communicated
+to the Hyper-V host over the VMBus channel as part of telling
+the host that the device is ready to enter d0.  See
+hv_pci_enter_d0().  When the guest subsequently accesses this
+MMIO range, the Hyper-V host intercepts the accesses and maps
+them to the physical device PCI config space.
+
+hv_pci_probe() also gets BAR information for the device from
+the Hyper-V host, and uses this information to allocate MMIO
+space for the BARs.  That MMIO space is then setup to be
+associated with the host bridge so that it works when generic
+PCI subsystem code in Linux processes the BARs.
+
+Finally, hv_pci_probe() creates the root PCI bus.  At this
+point the Hyper-V virtual PCI driver hackery is done, and the
+normal Linux PCI machinery for scanning the root bus works to
+detect the device, to perform driver matching, and to
+initialize the driver and device.
+
+PCI Device Removal
+------------------
+A Hyper-V host may initiate removal of a vPCI device from a
+guest VM at any time during the life of the VM.  The removal
+is instigated by an admin action taken on the Hyper-V host and
+is not under the control of the guest OS.
+
+A guest VM is notified of the removal by an unsolicited
+"Eject" message sent from the host to the guest over the VMBus
+channel associated with the vPCI device.  Upon receipt of such
+a message, the Hyper-V virtual PCI driver in Linux
+asynchronously invokes Linux kernel PCI subsystem calls to
+shutdown and remove the device.  When those calls are
+complete, an "Ejection Complete" message is sent back to
+Hyper-V over the VMBus channel indicating that the device has
+been removed.  At this point, Hyper-V sends a VMBus rescind
+message to the Linux guest, which the VMBus driver in Linux
+processes by removing the VMBus identity for the device.  Once
+that processing is complete, all vestiges of the device having
+been present are gone from the Linux kernel.  The rescind
+message also indicates to the guest that Hyper-V has stopped
+providing support for the vPCI device in the guest.  If the
+guest were to attempt to access that device's MMIO space, it
+would be an invalid reference. Hypercalls affecting the device
+return errors, and any further messages sent in the VMBus
+channel are ignored.
+
+After sending the Eject message, Hyper-V allows the guest VM
+60 seconds to cleanly shutdown the device and respond with
+Ejection Complete before sending the VMBus rescind
+message.  If for any reason the Eject steps don't complete
+within the allowed 60 seconds, the Hyper-V host forcibly
+performs the rescind steps, which will likely result in
+cascading errors in the guest because the device is now no
+longer present from the guest standpoint and accessing the
+device MMIO space will fail.
+
+Because ejection is asynchronous and can happen at any point
+during the guest VM lifecycle, proper synchronization in the
+Hyper-V virtual PCI driver is very tricky.  Ejection has been
+observed even before a newly offered vPCI device has been
+fully setup.  The Hyper-V virtual PCI driver has been updated
+several times over the years to fix race conditions when
+ejections happen at inopportune times. Care must be taken when
+modifying this code to prevent re-introducing such problems.
+See comments in the code.
+
+Interrupt Assignment
+--------------------
+The Hyper-V virtual PCI driver supports vPCI devices using
+MSI, multi-MSI, or MSI-X.  Assigning the guest vCPU that will
+receive the interrupt for a particular MSI or MSI-X message is
+complex because of the way the Linux setup of IRQs maps onto
+the Hyper-V interfaces.  For the single-MSI and MSI-X cases,
+Linux calls hv_compse_msi_msg() twice, with the first call
+containing a dummy vCPU and the second call containing the
+real vCPU.  Furthermore, hv_irq_unmask() is finally called
+(on x86) or the GICD registers are set (on arm64) to specify
+the real vCPU again.  Each of these three calls interact
+with Hyper-V, which must decide which physical CPU should
+receive the interrupt before it is forwarded to the guest VM.
+Unfortunately, the Hyper-V decision-making process is a bit
+limited, and can result in concentrating the physical
+interrupts on a single CPU, causing a performance bottleneck.
+See details about how this is resolved in the extensive
+comment above the function hv_compose_msi_req_get_cpu().
+
+The Hyper-V virtual PCI driver implements the
+irq_chip.irq_compose_msi_msg function as hv_compose_msi_msg().
+Unfortunately, on Hyper-V the implementation requires sending
+a VMBus message to the Hyper-V host and awaiting an interrupt
+indicating receipt of a reply message.  Since
+irq_chip.irq_compose_msi_msg can be called with IRQ locks
+held, it doesn't work to do the normal sleep until awakened by
+the interrupt. Instead hv_compose_msi_msg() must send the
+VMBus message, and then poll for the completion message. As
+further complexity, the vPCI device could be ejected/rescinded
+while the polling is in progress, so this scenario must be
+detected as well.  See comments in the code regarding this
+very tricky area.
+
+Most of the code in the Hyper-V virtual PCI driver (pci-
+hyperv.c) applies to Hyper-V and Linux guests running on x86
+and on arm64 architectures.  But there are differences in how
+interrupt assignments are managed.  On x86, the Hyper-V
+virtual PCI driver in the guest must make a hypercall to tell
+Hyper-V which guest vCPU should be interrupted by each
+MSI/MSI-X interrupt, and the x86 interrupt vector number that
+the x86_vector IRQ domain has picked for the interrupt.  This
+hypercall is made by hv_arch_irq_unmask().  On arm64, the
+Hyper-V virtual PCI driver manages the allocation of an SPI
+for each MSI/MSI-X interrupt.  The Hyper-V virtual PCI driver
+stores the allocated SPI in the architectural GICD registers,
+which Hyper-V emulates, so no hypercall is necessary as with
+x86.  Hyper-V does not support using LPIs for vPCI devices in
+arm64 guest VMs because it does not emulate a GICv3 ITS.
+
+The Hyper-V virtual PCI driver in Linux supports vPCI devices
+whose drivers create managed or unmanaged Linux IRQs.  If the
+smp_affinity for an unmanaged IRQ is updated via the /proc/irq
+interface, the Hyper-V virtual PCI driver is called to tell
+the Hyper-V host to change the interrupt targeting and
+everything works properly.  However, on x86 if the x86_vector
+IRQ domain needs to reassign an interrupt vector due to
+running out of vectors on a CPU, there's no path to inform the
+Hyper-V host of the change, and things break.  Fortunately,
+guest VMs operate in a constrained device environment where
+using all the vectors on a CPU doesn't happen. Since such a
+problem is only a theoretical concern rather than a practical
+concern, it has been left unaddressed.
+
+DMA
+---
+By default, Hyper-V pins all guest VM memory in the host
+when the VM is created, and programs the physical IOMMU to
+allow the VM to have DMA access to all its memory.  Hence
+it is safe to assign PCI devices to the VM, and allow the
+guest operating system to program the DMA transfers.  The
+physical IOMMU prevents a malicious guest from initiating
+DMA to memory belonging to the host or to other VMs on the
+host. From the Linux guest standpoint, such DMA transfers
+are in "direct" mode since Hyper-V does not provide a virtual
+IOMMU in the guest.
+
+Hyper-V assumes that physical PCI devices always perform
+cache-coherent DMA.  When running on x86, this behavior is
+required by the architecture.  When running on arm64, the
+architecture allows for both cache-coherent and
+non-cache-coherent devices, with the behavior of each device
+specified in the ACPI DSDT.  But when a PCI device is assigned
+to a guest VM, that device does not appear in the DSDT, so the
+Hyper-V VMBus driver propagates cache-coherency information
+from the VMBus node in the ACPI DSDT to all VMBus devices,
+including vPCI devices (since they have a dual identity as a VMBus
+device and as a PCI device).  See vmbus_dma_configure().
+Current Hyper-V versions always indicate that the VMBus is
+cache coherent, so vPCI devices on arm64 always get marked as
+cache coherent and the CPU does not perform any sync
+operations as part of dma_map/unmap_*() calls.
+
+vPCI protocol versions
+----------------------
+As previously described, during vPCI device setup and teardown
+messages are passed over a VMBus channel between the Hyper-V
+host and the Hyper-v vPCI driver in the Linux guest.  Some
+messages have been revised in newer versions of Hyper-V, so
+the guest and host must agree on the vPCI protocol version to
+be used.  The version is negotiated when communication over
+the VMBus channel is first established.  See
+hv_pci_protocol_negotiation(). Newer versions of the protocol
+extend support to VMs with more than 64 vCPUs, and provide
+additional information about the vPCI device, such as the
+guest virtual NUMA node to which it is most closely affined in
+the underlying hardware.
+
+Guest NUMA node affinity
+------------------------
+When the vPCI protocol version provides it, the guest NUMA
+node affinity of the vPCI device is stored as part of the Linux
+device information for subsequent use by the Linux driver. See
+hv_pci_assign_numa_node().  If the negotiated protocol version
+does not support the host providing NUMA affinity information,
+the Linux guest defaults the device NUMA node to 0.  But even
+when the negotiated protocol version includes NUMA affinity
+information, the ability of the host to provide such
+information depends on certain host configuration options.  If
+the guest receives NUMA node value "0", it could mean NUMA
+node 0, or it could mean "no information is available".
+Unfortunately it is not possible to distinguish the two cases
+from the guest side.
+
+PCI config space access in a CoCo VM
+------------------------------------
+Linux PCI device drivers access PCI config space using a
+standard set of functions provided by the Linux PCI subsystem.
+In Hyper-V guests these standard functions map to functions
+hv_pcifront_read_config() and hv_pcifront_write_config()
+in the Hyper-V virtual PCI driver.  In normal VMs,
+these hv_pcifront_*() functions directly access the PCI config
+space, and the accesses trap to Hyper-V to be handled.
+But in CoCo VMs, memory encryption prevents Hyper-V
+from reading the guest instruction stream to emulate the
+access, so the hv_pcifront_*() functions must invoke
+hypercalls with explicit arguments describing the access to be
+made.
+
+Config Block back-channel
+-------------------------
+The Hyper-V host and Hyper-V virtual PCI driver in Linux
+together implement a non-standard back-channel communication
+path between the host and guest.  The back-channel path uses
+messages sent over the VMBus channel associated with the vPCI
+device.  The functions hyperv_read_cfg_blk() and
+hyperv_write_cfg_blk() are the primary interfaces provided to
+other parts of the Linux kernel.  As of this writing, these
+interfaces are used only by the Mellanox mlx5 driver to pass
+diagnostic data to a Hyper-V host running in the Azure public
+cloud.  The functions hyperv_read_cfg_blk() and
+hyperv_write_cfg_blk() are implemented in a separate module
+(pci-hyperv-intf.c, under CONFIG_PCI_HYPERV_INTERFACE) that
+effectively stubs them out when running in non-Hyper-V
+environments.
-- 
2.25.1


