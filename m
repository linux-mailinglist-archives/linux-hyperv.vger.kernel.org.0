Return-Path: <linux-hyperv+bounces-3671-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7D5A0AEC2
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jan 2025 06:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310333A6454
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jan 2025 05:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AAE230D21;
	Mon, 13 Jan 2025 05:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuJFs6AR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2E48F77;
	Mon, 13 Jan 2025 05:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736746154; cv=none; b=ZkwHRHNWyUkbaMPkTz/6QvrH+40KBii4Q3OQ7XRWpTahkGTgYDlggD8LSDBO1LpXZTxACRJ13/G7gArXZiDDd/V4Ahwu2xIZ4xG+UNWOd+eZjk2pr7ZaeF+cjxq0bglZXtmiWa2v7YtISUm+ZsRifjn8Cjb6DFGx+G9I4srlujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736746154; c=relaxed/simple;
	bh=Abaa9/gDQudRCrve1HMUZpuxkffwpKmYqdzyW3xs7so=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=gahxJRiFD6k6VqOPmW3qf+NWuKN2Pc5sfYEyQH/NeuofIqp8qv/g/bAfciOIphjjjGtRCAdXc14wBXMgD2cINT6VLKP/szoxTLXn1T5x5hasgU7MUERS99y4fmhxXcE9ezXxXIIJR8RHpvEwUni9H6yzKGwgFn1XjY07w3uBOPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuJFs6AR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2163dc5155fso69281885ad.0;
        Sun, 12 Jan 2025 21:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736746151; x=1737350951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VxZY5/CkWsKdHdk+i2x0sCxA/1cK5bsDaERiKN0Wsvk=;
        b=IuJFs6ARWkiWXr+nxPgl3VoOe3Unjj/zKLqw9Cakv1tEMT+NIXxNd/jdPfDLAZqJKm
         gPJdR+c14eh+TUlKVaIg5D0c90ZlirbBTSBsTQa+Ei+kz14XBbHAKcDf+Lx/4hyQI9vi
         Dubrk3ZxWBPyGptFPhzmwbaXPFDNIy+Kk7LirSs6PBGwMhytDmHUkrGMJjHBL0mB9UbS
         hX5MRLxg6POYULXU+7jDMWQw0zgCtTo9vxI1fcxcHRPiO4s7pUHNYerCdaNAIjG+y+Og
         wAnUOQXe9/+fwfoUqbyUTOKz6EWLsQOIvXqnL/Jvwt0XwUABf3dp5ubpZa4URJaolLJW
         W7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736746151; x=1737350951;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxZY5/CkWsKdHdk+i2x0sCxA/1cK5bsDaERiKN0Wsvk=;
        b=Ex1f1PuOttbE/7SLKv7/MHCPnxPaDgPCgmW05GsVyVZKAhrzav5t2SI/qY7Sby5VLE
         Ij0R1yT9Xe9aes0gEC28UFVf6ghzh59b5smWZGQr+RDnWvAxmAbCmc1dKOTpIkSHMr6Q
         S1/Jd5UNcviu6c+5LgB5IuWUm/KZlu7kBPf7ZxHLy8rv4/KN2XfGV1egCtfmRjMmzled
         l4snSCYpAbSAvyEhaffSq8imFie61DCDHaAHJIBUf4cXCAwR5lMcU6ua1h7BXzr/R4Fn
         WDXi938opdngzpLEgDk8GBEyxZ0PjtUFyfNhM61hOSR6OBR/ttOkRthducaNAqgk5VD0
         lQbA==
X-Forwarded-Encrypted: i=1; AJvYcCV+ztQFUKNzbQKDLsRr8IesbX7YWSTyYNl41NuET6UpgiZbIDIihdzuJAx+QzrejbijIAbhDSREu90=@vger.kernel.org, AJvYcCWOim1aRR1C3sjHukiNVHSA5oNf7UBSy8/8mIlN+MJWEpDEimpcRr1337w+758fRVn+ZZpPTk9mfjKkGiWm@vger.kernel.org, AJvYcCXIv7WCOll/7mFl2HINmScGbB1TvXI74tJ0zFqN7ZDt9dUqWe6DTdjyZEmoPLCLjvXt6ghBbvYnzIDhV7hb@vger.kernel.org
X-Gm-Message-State: AOJu0YwwBydkgGNZtkzzK/C+hSVtcu/RfiznRV5yqNPb8XI8WN6fJVJk
	53gsi5fm66Im6GJrowFmgTurd4UBWQlBcDa4/+zvZauzoUj17hOqkzdj7g==
X-Gm-Gg: ASbGnctn/klWN+AYtvoqDi+cNbKpW68foKtDQMJi+ZlK4afV0Ars+xGNvA+4x30uRrE
	BqQHDWgshucgPvYdz6dndYrLKp0mxQK5cbj2SJu4GpJdyxu38kwlR6sbszEb0stgTJS46E0zkHX
	vGiV5MQ9/SRYT+2MNQm8XxLHq9Z5B5BHtSsxNet1HO5+JaJsKs5gJHBBCMjdLT5NSHX4jTX4T1X
	I3w1++4MmDa4EMI1jDsai47h6lQLROcJMB9WF3KzQy05flMbrNXe6lYXMMScds63J78T4JtKO3n
	T6IJQkrxl5+tfiIwfiqlDgpMf+XF68xtGao=
X-Google-Smtp-Source: AGHT+IHbtXyF0rS/kf1FbWUPDiEwlj5rQrxo8FRolJiXDmkkbhfJv3qUCLiYJpRu9PguCh2M2CW+tg==
X-Received: by 2002:a05:6a20:e68b:b0:1e0:d837:c929 with SMTP id adf61e73a8af0-1e88cf7f78bmr29538159637.9.1736746151226;
        Sun, 12 Jan 2025 21:29:11 -0800 (PST)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4065c270sm5010151b3a.110.2025.01.12.21.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 21:29:10 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	kys@microsoft.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 1/1] Documentation: hyperv: Add overview of guest VM hibernation
Date: Sun, 12 Jan 2025 21:29:03 -0800
Message-Id: <20250113052903.1319529-1-mhklinux@outlook.com>
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

Add documentation on how hibernation works in a guest VM on Hyper-V.
Describe how VMBus devices and the VMBus itself are hibernated and
resumed, along with various limitations.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
Changes in v3:
* Added missing word "with" in vPCI section [Bagas Sanjaya]
* Reworked wording of SR-IOV NIC handling [Bagas Sanjaya]

Changes in v2:
* Added discussion of implications of moving a hibernated VM to another
  Hyper-V host and resuming on the new host [Roman Kisel]
* Added section describing how UIO devices prevent a VM from being
  hibernated [Roman Kisel]

 Documentation/virt/hyperv/hibernation.rst | 336 ++++++++++++++++++++++
 1 file changed, 336 insertions(+)
 create mode 100644 Documentation/virt/hyperv/hibernation.rst

diff --git a/Documentation/virt/hyperv/hibernation.rst b/Documentation/virt/hyperv/hibernation.rst
new file mode 100644
index 000000000000..4ff27f4a317a
--- /dev/null
+++ b/Documentation/virt/hyperv/hibernation.rst
@@ -0,0 +1,336 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Hibernating Guest VMs
+=====================
+
+Background
+----------
+Linux supports the ability to hibernate itself in order to save power.
+Hibernation is sometimes called suspend-to-disk, as it writes a memory
+image to disk and puts the hardware into the lowest possible power
+state. Upon resume from hibernation, the hardware is restarted and the
+memory image is restored from disk so that it can resume execution
+where it left off. See the "Hibernation" section of
+Documentation/admin-guide/pm/sleep-states.rst.
+
+Hibernation is usually done on devices with a single user, such as a
+personal laptop. For example, the laptop goes into hibernation when
+the cover is closed, and resumes when the cover is opened again.
+Hibernation and resume happen on the same hardware, and Linux kernel
+code orchestrating the hibernation steps assumes that the hardware
+configuration is not changed while in the hibernated state.
+
+Hibernation can be initiated within Linux by writing "disk" to
+/sys/power/state or by invoking the reboot system call with the
+appropriate arguments. This functionality may be wrapped by user space
+commands such "systemctl hibernate" that are run directly from a
+command line or in response to events such as the laptop lid closing.
+
+Considerations for Guest VM Hibernation
+---------------------------------------
+Linux guests on Hyper-V can also be hibernated, in which case the
+hardware is the virtual hardware provided by Hyper-V to the guest VM.
+Only the targeted guest VM is hibernated, while other guest VMs and
+the underlying Hyper-V host continue to run normally. While the
+underlying Windows Hyper-V and physical hardware on which it is
+running might also be hibernated using hibernation functionality in
+the Windows host, host hibernation and its impact on guest VMs is not
+in scope for this documentation.
+
+Resuming a hibernated guest VM can be more challenging than with
+physical hardware because VMs make it very easy to change the hardware
+configuration between the hibernation and resume. Even when the resume
+is done on the same VM that hibernated, the memory size might be
+changed, or virtual NICs or SCSI controllers might be added or
+removed. Virtual PCI devices assigned to the VM might be added or
+removed. Most such changes cause the resume steps to fail, though
+adding a new virtual NIC, SCSI controller, or vPCI device should work.
+
+Additional complexity can ensue because the disks of the hibernated VM
+can be moved to another newly created VM that otherwise has the same
+virtual hardware configuration. While it is desirable for resume from
+hibernation to succeed after such a move, there are challenges. See
+details on this scenario and its limitations in the "Resuming on a
+Different VM" section below.
+
+Hyper-V also provides ways to move a VM from one Hyper-V host to
+another. Hyper-V tries to ensure processor model and Hyper-V version
+compatibility using VM Configuration Versions, and prevents moves to
+a host that isn't compatible. Linux adapts to host and processor
+differences by detecting them at boot time, but such detection is not
+done when resuming execution in the hibernation image. If a VM is
+hibernated on one host, then resumed on a host with a different processor
+model or Hyper-V version, settings recorded in the hibernation image
+may not match the new host. Because Linux does not detect such
+mismatches when resuming the hibernation image, undefined behavior
+and failures could result.
+
+
+Enabling Guest VM Hibernation
+-----------------------------
+Hibernation of a Hyper-V guest VM is disabled by default because
+hibernation is incompatible with memory hot-add, as provided by the
+Hyper-V balloon driver. If hot-add is used and the VM hibernates, it
+hibernates with more memory than it started with. But when the VM
+resumes from hibernation, Hyper-V gives the VM only the originally
+assigned memory, and the memory size mismatch causes resume to fail.
+
+To enable a Hyper-V VM for hibernation, the Hyper-V administrator must
+enable the ACPI virtual S4 sleep state in the ACPI configuration that
+Hyper-V provides to the guest VM. Such enablement is accomplished by
+modifying a WMI property of the VM, the steps for which are outside
+the scope of this documentation but are available on the web.
+Enablement is treated as the indicator that the administrator
+prioritizes Linux hibernation in the VM over hot-add, so the Hyper-V
+balloon driver in Linux disables hot-add. Enablement is indicated if
+the contents of /sys/power/disk contains "platform" as an option. The
+enablement is also visible in /sys/bus/vmbus/hibernation. See function
+hv_is_hibernation_supported().
+
+Linux supports ACPI sleep states on x86, but not on arm64. So Linux
+guest VM hibernation is not available on Hyper-V for arm64.
+
+Initiating Guest VM Hibernation
+-------------------------------
+Guest VMs can self-initiate hibernation using the standard Linux
+methods of writing "disk" to /sys/power/state or the reboot system
+call. As an additional layer, Linux guests on Hyper-V support the
+"Shutdown" integration service, via which a Hyper-V administrator can
+tell a Linux VM to hibernate using a command outside the VM. The
+command generates a request to the Hyper-V shutdown driver in Linux,
+which sends the uevent "EVENT=hibernate". See kernel functions
+shutdown_onchannelcallback() and send_hibernate_uevent(). A udev rule
+must be provided in the VM that handles this event and initiates
+hibernation.
+
+Handling VMBus Devices During Hibernation & Resume
+--------------------------------------------------
+The VMBus bus driver, and the individual VMBus device drivers,
+implement suspend and resume functions that are called as part of the
+Linux orchestration of hibernation and of resuming from hibernation.
+The overall approach is to leave in place the data structures for the
+primary VMBus channels and their associated Linux devices, such as
+SCSI controllers and others, so that they are captured in the
+hibernation image. This approach allows any state associated with the
+device to be persisted across the hibernation/resume. When the VM
+resumes, the devices are re-offered by Hyper-V and are connected to
+the data structures that already exist in the resumed hibernation
+image.
+
+VMBus devices are identified by class and instance GUID. (See section
+"VMBus device creation/deletion" in
+Documentation/virt/hyperv/vmbus.rst.) Upon resume from hibernation,
+the resume functions expect that the devices offered by Hyper-V have
+the same class/instance GUIDs as the devices present at the time of
+hibernation. Having the same class/instance GUIDs allows the offered
+devices to be matched to the primary VMBus channel data structures in
+the memory of the now resumed hibernation image. If any devices are
+offered that don't match primary VMBus channel data structures that
+already exist, they are processed normally as newly added devices. If
+primary VMBus channels that exist in the resumed hibernation image are
+not matched with a device offered in the resumed VM, the resume
+sequence waits for 10 seconds, then proceeds. But the unmatched device
+is likely to cause errors in the resumed VM.
+
+When resuming existing primary VMBus channels, the newly offered
+relids might be different because relids can change on each VM boot,
+even if the VM configuration hasn't changed. The VMBus bus driver
+resume function matches the class/instance GUIDs, and updates the
+relids in case they have changed.
+
+VMBus sub-channels are not persisted in the hibernation image. Each
+VMBus device driver's suspend function must close any sub-channels
+prior to hibernation. Closing a sub-channel causes Hyper-V to send a
+RESCIND_CHANNELOFFER message, which Linux processes by freeing the
+channel data structures so that all vestiges of the sub-channel are
+removed. By contrast, primary channels are marked closed and their
+ring buffers are freed, but Hyper-V does not send a rescind message,
+so the channel data structure continues to exist. Upon resume, the
+device driver's resume function re-allocates the ring buffer and
+re-opens the existing channel. It then communicates with Hyper-V to
+re-open sub-channels from scratch.
+
+The Linux ends of Hyper-V sockets are forced closed at the time of
+hibernation. The guest can't force closing the host end of the socket,
+but any host-side actions on the host end will produce an error.
+
+VMBus devices use the same suspend function for the "freeze" and the
+"poweroff" phases, and the same resume function for the "thaw" and
+"restore" phases. See the "Entering Hibernation" section of
+Documentation/driver-api/pm/devices.rst for the sequencing of the
+phases.
+
+Detailed Hibernation Sequence
+-----------------------------
+1. The Linux power management (PM) subsystem prepares for
+   hibernation by freezing user space processes and allocating
+   memory to hold the hibernation image.
+2. As part of the "freeze" phase, Linux PM calls the "suspend"
+   function for each VMBus device in turn. As described above, this
+   function removes sub-channels, and leaves the primary channel in
+   a closed state.
+3. Linux PM calls the "suspend" function for the VMBus bus, which
+   closes any Hyper-V socket channels and unloads the top-level
+   VMBus connection with the Hyper-V host.
+4. Linux PM disables non-boot CPUs, creates the hibernation image in
+   the previously allocated memory, then re-enables non-boot CPUs.
+   The hibernation image contains the memory data structures for the
+   closed primary channels, but no sub-channels.
+5. As part of the "thaw" phase, Linux PM calls the "resume" function
+   for the VMBus bus, which re-establishes the top-level VMBus
+   connection and requests that Hyper-V re-offer the VMBus devices.
+   As offers are received for the primary channels, the relids are
+   updated as previously described.
+6. Linux PM calls the "resume" function for each VMBus device. Each
+   device re-opens its primary channel, and communicates with Hyper-V
+   to re-establish sub-channels if appropriate. The sub-channels
+   are re-created as new channels since they were previously removed
+   entirely in Step 2.
+7. With VMBus devices now working again, Linux PM writes the
+   hibernation image from memory to disk.
+8. Linux PM repeats Steps 2 and 3 above as part of the "poweroff"
+   phase. VMBus channels are closed and the top-level VMBus
+   connection is unloaded.
+9. Linux PM disables non-boot CPUs, and then enters ACPI sleep state
+   S4. Hibernation is now complete.
+
+Detailed Resume Sequence
+------------------------
+1. The guest VM boots into a fresh Linux OS instance. During boot,
+   the top-level VMBus connection is established, and synthetic
+   devices are enabled. This happens via the normal paths that don't
+   involve hibernation.
+2. Linux PM hibernation code reads swap space is to find and read
+   the hibernation image into memory. If there is no hibernation
+   image, then this boot becomes a normal boot.
+3. If this is a resume from hibernation, the "freeze" phase is used
+   to shutdown VMBus devices and unload the top-level VMBus
+   connection in the running fresh OS instance, just like Steps 2
+   and 3 in the hibernation sequence.
+4. Linux PM disables non-boot CPUs, and transfers control to the
+   read-in hibernation image. In the now-running hibernation image,
+   non-boot CPUs are restarted.
+5. As part of the "resume" phase, Linux PM repeats Steps 5 and 6
+   from the hibernation sequence. The top-level VMBus connection is
+   re-established, and offers are received and matched to primary
+   channels in the image. Relids are updated. VMBus device resume
+   functions re-open primary channels and re-create sub-channels.
+6. Linux PM exits the hibernation resume sequence and the VM is now
+   running normally from the hibernation image.
+
+Key-Value Pair (KVP) Pseudo-Device Anomalies
+--------------------------------------------
+The VMBus KVP device behaves differently from other pseudo-devices
+offered by Hyper-V.  When the KVP primary channel is closed, Hyper-V
+sends a rescind message, which causes all vestiges of the device to be
+removed. But Hyper-V then re-offers the device, causing it to be newly
+re-created. The removal and re-creation occurs during the "freeze"
+phase of hibernation, so the hibernation image contains the re-created
+KVP device. Similar behavior occurs during the "freeze" phase of the
+resume sequence while still in the fresh OS instance. But in both
+cases, the top-level VMBus connection is subsequently unloaded, which
+causes the device to be discarded on the Hyper-V side. So no harm is
+done and everything still works.
+
+Virtual PCI devices
+-------------------
+Virtual PCI devices are physical PCI devices that are mapped directly
+into the VM's physical address space so the VM can interact directly
+with the hardware. vPCI devices include those accessed via what Hyper-V
+calls "Discrete Device Assignment" (DDA), as well as SR-IOV NIC
+Virtual Functions (VF) devices. See Documentation/virt/hyperv/vpci.rst.
+
+Hyper-V DDA devices are offered to guest VMs after the top-level VMBus
+connection is established, just like VMBus synthetic devices. They are
+statically assigned to the VM, and their instance GUIDs don't change
+unless the Hyper-V administrator makes changes to the configuration.
+DDA devices are represented in Linux as virtual PCI devices that have
+a VMBus identity as well as a PCI identity. Consequently, Linux guest
+hibernation first handles DDA devices as VMBus devices in order to
+manage the VMBus channel. But then they are also handled as PCI
+devices using the hibernation functions implemented by their native
+PCI driver.
+
+SR-IOV NIC VFs also have a VMBus identity as well as a PCI
+identity, and overall are processed similarly to DDA devices. A
+difference is that VFs are not offered to the VM during initial boot
+of the VM. Instead, the VMBus synthetic NIC driver first starts
+operating and communicates to Hyper-V that it is prepared to accept a
+VF, and then the VF offer is made. However, the VMBus connection
+might later be unloaded and then re-established without the VM being
+rebooted, as happens in Steps 3 and 5 in the Detailed Hibernation
+Sequence above and in the Detailed Resume Sequence. In such a case,
+the VFs likely became part of the VM during initial boot, so when the
+VMBus connection is re-established, the VFs are offered on the
+re-established connection without intervention by the synthetic NIC driver.
+
+UIO Devices
+-----------
+A VMBus device can be exposed to user space using the Hyper-V UIO
+driver (uio_hv_generic.c) so that a user space driver can control and
+operate the device. However, the VMBus UIO driver does not support the
+suspend and resume operations needed for hibernation. If a VMBus
+device is configured to use the UIO driver, hibernating the VM fails
+and Linux continues to run normally. The most common use of the Hyper-V
+UIO driver is for DPDK networking, but there are other uses as well.
+
+Resuming on a Different VM
+--------------------------
+This scenario occurs in the Azure public cloud in that a hibernated
+customer VM only exists as saved configuration and disks -- the VM no
+longer exists on any Hyper-V host. When the customer VM is resumed, a
+new Hyper-V VM with identical configuration is created, likely on a
+different Hyper-V host. That new Hyper-V VM becomes the resumed
+customer VM, and the steps the Linux kernel takes to resume from the
+hibernation image must work in that new VM.
+
+While the disks and their contents are preserved from the original VM,
+the Hyper-V-provided VMBus instance GUIDs of the disk controllers and
+other synthetic devices would typically be different. The difference
+would cause the resume from hibernation to fail, so several things are
+done to solve this problem:
+
+* For VMBus synthetic devices that support only a single instance,
+  Hyper-V always assigns the same instance GUIDs. For example, the
+  Hyper-V mouse, the shutdown pseudo-device, the time sync pseudo
+  device, etc., always have the same instance GUID, both for local
+  Hyper-V installs as well as in the Azure cloud.
+
+* VMBus synthetic SCSI controllers may have multiple instances in a
+  VM, and in the general case instance GUIDs vary from VM to VM.
+  However, Azure VMs always have exactly two synthetic SCSI
+  controllers, and Azure code overrides the normal Hyper-V behavior
+  so these controllers are always assigned the same two instance
+  GUIDs. Consequently, when a customer VM is resumed on a newly
+  created VM, the instance GUIDs match. But this guarantee does not
+  hold for local Hyper-V installs.
+
+* Similarly, VMBus synthetic NICs may have multiple instances in a
+  VM, and the instance GUIDs vary from VM to VM. Again, Azure code
+  overrides the normal Hyper-V behavior so that the instance GUID
+  of a synthetic NIC in a customer VM does not change, even if the
+  customer VM is deallocated or hibernated, and then re-constituted
+  on a newly created VM. As with SCSI controllers, this behavior
+  does not hold for local Hyper-V installs.
+
+* vPCI devices do not have the same instance GUIDs when resuming
+  from hibernation on a newly created VM. Consequently, Azure does
+  not support hibernation for VMs that have DDA devices such as
+  NVMe controllers or GPUs. For SR-IOV NIC VFs, Azure removes the
+  VF from the VM before it hibernates so that the hibernation image
+  does not contain a VF device. When the VM is resumed it
+  instantiates a new VF, rather than trying to match against a VF
+  that is present in the hibernation image. Because Azure must
+  remove any VFs before initiating hibernation, Azure VM
+  hibernation must be initiated externally from the Azure Portal or
+  Azure CLI, which in turn uses the Shutdown integration service to
+  tell Linux to do the hibernation. If hibernation is self-initiated
+  within the Azure VM, VFs remain in the hibernation image, and are
+  not resumed properly.
+
+In summary, Azure takes special actions to remove VFs and to ensure
+that VMBus device instance GUIDs match on a new/different VM, allowing
+hibernation to work for most general-purpose Azure VMs sizes. While
+similar special actions could be taken when resuming on a different VM
+on a local Hyper-V install, orchestrating such actions is not provided
+out-of-the-box by local Hyper-V and so requires custom scripting.
-- 
2.25.1


