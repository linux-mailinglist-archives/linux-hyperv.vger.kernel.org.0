Return-Path: <linux-hyperv+bounces-10529-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMTIHub282kC9QEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10529-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 02:42:14 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB50B4A9418
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 02:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 788FE302B52D
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 May 2026 00:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7134326560B;
	Fri,  1 May 2026 00:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Q4d943jk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D50248F66;
	Fri,  1 May 2026 00:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777596129; cv=none; b=h76gq+qj2dvGxTb6jfgv0OHBnUXhnOW/dv9KKcI4HQ1LSJFjWHUGoj0DBJqQB69zetlABzsVAyIiznq/pv097EXRtWvn1icRjW0V6V4VSdiGQWGs6JXIcrUV2LiFqp+85SH095GtPf2TDwXfynO09wOE98L613bw8QwtRUzAu0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777596129; c=relaxed/simple;
	bh=HgczbydWMyKMmyI8k4BSu6vP0cO81ZFeNwpOwluA5r8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RNi5HfwBxfPQaA+Myi+6mQyVUvEgm8OF1HzLH4MAbejyNxFDHQumpKgNuFiGrQq6gcEL+hmIZmFnshoSk+wwjG9GN3IPVWYCvT1mCkSRLtBqpm0YFekx6Ts1BMl6lrCAdh2+87ckg7UXLv1s5qDYy1qn/ikpkp0ZnBmBoewGTcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Q4d943jk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (unknown [40.86.183.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id D651420B7165;
	Thu, 30 Apr 2026 17:42:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D651420B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777596127;
	bh=sobSl1Jx196MsXs3tYpB2WD+rsl04IeCc/J8ABEWGzo=;
	h=From:To:Cc:Subject:Date:From;
	b=Q4d943jkkAiqHUL3/pHeB+0zJfi0bz679ZcSuvAPmUOrsucCI9R6LWB6Qci6d05G8
	 DLUH6nxICAqHUyod4w2j4qebNLE6LvDPgLd2rCd/xqIsB0tjVRhDE5g0WayRS4rFen
	 wqbIJA1rREJEB0tmWQCJaJ44jDch6e4H5OmzpcI4=
From: Mukesh R <mrathor@linux.microsoft.com>
To: hpa@zytor.com,
	robin.murphy@arm.com,
	robh@kernel.org,
	wei.liu@kernel.org,
	mrathor@linux.microsoft.com,
	mhklinux@outlook.com,
	muislam@microsoft.com,
	namjain@linux.microsoft.com,
	magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de
Subject: [PATCH V2 00/11]  PCI passthru on Hyper-V (Part I)
Date: Thu, 30 Apr 2026 17:41:46 -0700
Message-ID: <20260501004157.3108202-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EB50B4A9418
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10529-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[zytor.com,arm.com,kernel.org,linux.microsoft.com,outlook.com,microsoft.com,vger.kernel.org,lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]

Implement passthru of PCI devices to unprivileged virtual machines
(VMs) when Linux is running as a privileged VM on Microsoft Hyper-V
hypervisor. This support is made to fit within the workings of VFIO
framework, and any VMM needing to use it must use the VFIO subsystem.
This supports both full device passthru and SR-IOV based VFs.

At a high level, the hypervisor supports traditional mapped iommu domains
that use explicit map and unmap hypercalls for mapping and unmapping guest
RAM into the iommu subsystem. Hyper-V also has a concept of direct attach
devices whereby the iommu subsystem simply uses the guest HW page table
(ept/npt/..). This series adds support for both, and both are made to
work with the VFIO subsystem.

While this Part I focuses on memory mappings, Part II focuses on irq 
remapping and irq migrations.

This series rebased to: 5170a82e8921 (origin/hyperv-next)

Testing:
 o Most testing done on hyperv-next:e733a9e28180 using Cloud Hypervisor (51).
 o Limited testing on : 5170a82e8921
 o Tested with impending Part II irq patches.
 o All tests involved PF passthru of devices using MSIx.
 o Following combinations were tested:
    - L1VH(1): test 1: Mellanox ConnectX-6 Lx passthru
               test 2: NVIDIA Tesla Tesla T4 GPU.
               test 3: Both of above simultaneous passthru
    - Baremetal dom0/root: All of above.

(1) L1VH: this is a semi privileged VM that runs on Windows root on
          Hyper-V, and allows users to create more child VMs.

This series strives to establish a base line. Some pending work items:
 o arm64 : some delta to make this work on arm64 (in progress).
 o Qemu and OpenVMM support (in progress).
 o VF testing
 o device sleep/wakeup.
 o More stress testing with high end GPUs

Changes in V2:
 o rebase to 5170a82e8921
 o minor fixes for arm64 build
 o drop patch 03: "x86/hyperv: add insufficient memory support in irqdomain.c" 
     as it that path is no longer used
 o drop patch 08: "PCI: hv: rename hv_compose_msi_msg .. " and do it separately
   outside this series.
 o minor updates to commit messages

Changes in V1:
 o patch 1: Don't tie hyperv-irq.c to CONFIG_HYPERV_IOMMU.
 o patch 4: Redesigned to address security vulnerability found by copilot 
            with passing tgid as a parameter.  Also, do tgid setting right 
            after setting pt_id.
 o patch 5: Remove unused type parameter from mshv_device_ops.device_create
 o patch 7: mshv_partition_ioctl_create_device cleanup on copy_to_user.
 o patch 10: Add export of hv_build_devid_type_pci here to get rid of 
             patch 11.
 o patch 12: Move functions to build device ids from patch 11 here for
             the benefit of arm64. Rename file to: hyperv-iommu-root.c.
 o patch 13: removed to be made part of interrupt part II of this support.
 o patch 14: get rid of fast path to reduce review noise.
 o New (last) patch to pin ram regions if device passthru to a VM.

Thanks,
-Mukesh

Mukesh R (11):
  iommu/hyperv: rename hyperv-iommu.c to hyperv-irq.c
  x86/hyperv: cosmetic changes in irqdomain.c for readability
  mshv: Provide a way to get partition id if running in a VMM process
  mshv: Declarations and definitions for VFIO-MSHV bridge device
  mshv: Implement mshv bridge device for VFIO
  mshv: Add ioctl support for MSHV-VFIO bridge device
  mshv: Import data structs around device passthru from hyperv headers
  PCI: hv: Build device id for a VMBus device, export PCI devid function
  x86/hyperv: Implement hyperv virtual IOMMU
  mshv: Populate mmio mappings for PCI passthru
  mshv: Mark mem regions as non-movable upfront if device passthru

 MAINTAINERS                                   |   3 +-
 arch/x86/hyperv/irqdomain.c                   | 199 ++--
 arch/x86/include/asm/mshyperv.h               |   6 +
 arch/x86/kernel/pci-dma.c                     |   2 +
 drivers/hv/Makefile                           |   3 +-
 drivers/hv/mshv_root.h                        |  21 +
 drivers/hv/mshv_root_main.c                   | 266 ++++-
 drivers/hv/mshv_vfio.c                        | 211 ++++
 drivers/iommu/Kconfig                         |   5 +-
 drivers/iommu/Makefile                        |   3 +-
 drivers/iommu/hyperv-iommu-root.c             | 908 ++++++++++++++++++
 .../iommu/{hyperv-iommu.c => hyperv-irq.c}    |   6 +-
 drivers/iommu/irq_remapping.c                 |   2 +-
 drivers/pci/controller/pci-hyperv.c           |  24 +
 include/asm-generic/mshyperv.h                |  30 +
 include/hyperv/hvgdk_mini.h                   |  11 +
 include/hyperv/hvhdk_mini.h                   | 112 +++
 include/linux/hyperv.h                        |   6 +
 include/uapi/linux/mshv.h                     |  31 +
 19 files changed, 1727 insertions(+), 122 deletions(-)
 create mode 100644 drivers/hv/mshv_vfio.c
 create mode 100644 drivers/iommu/hyperv-iommu-root.c
 rename drivers/iommu/{hyperv-iommu.c => hyperv-irq.c} (99%)

-- 
2.51.2.vfs.0.1


