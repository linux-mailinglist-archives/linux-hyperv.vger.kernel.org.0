Return-Path: <linux-hyperv+bounces-10772-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDcvDGeKAmrVtwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10772-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:03:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E5D518903
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D6FE301BEC2
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D1123BCEE;
	Tue, 12 May 2026 02:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="h9h3+cuI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10FA225788;
	Tue, 12 May 2026 02:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551397; cv=none; b=toxlVVVQ+nkEbF+cSxEfB8R2473BPkieCoO2GMC9UNRc4aHmdN8ehYK141NGRnLJpLxCnDr/JeptoHdVME5Bd49o5ViuScimsoOH/xUORAZ7P9Wwf4WdHahtax0FStxZigzpIKKnTeQm+C1hHQzFWMkTv7stsefqQvnJ3hdGNIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551397; c=relaxed/simple;
	bh=P4zsrTSdnvHC05c8ddf8tdvjXANfQhJaX1T01tZcq7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DgESkY2dLILtoiXr42/qSXo+a5nRoCQE9sZhSK5AvwZm24TL3vHAmYWkAOxSPkrWdCzrieP6LcyZn6Rsbl3qPC924CtISnbT6z9qHxH6PSOQjXy+3tclgQfR8v8+Q8CF5t1bQCZsFd/+bz2qQaVpAVFyOSNb3+uhdrT4HjlHNDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=h9h3+cuI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (unknown [13.88.17.9])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4760E20B7166;
	Mon, 11 May 2026 19:03:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4760E20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778551391;
	bh=L1u+YaYFMS0e2RVPxsOKKP1VrrtsLT3TK/2Ux89jOAw=;
	h=From:To:Cc:Subject:Date:From;
	b=h9h3+cuIH/buTolIld4zsIRqiAELw1bH+Fq5nxzuR0zmanFfMLEBBxMx1/FUdVSQu
	 8jMbzBgTlpurZXL8W+MBY1/8QsQ90osaoVdoF1B3qvTHgVr0ar5ie1FBXnaoQwqg0N
	 zu/fsUD9IpZxH+XZCurrLn1g0YXZrnMeBcbR6ZKI=
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
	arnd@arndb.de,
	jacob.pan@linux.microsoft.com
Subject: [PATCH V3 00/11] PCI passthru on Hyper-V (Part I)
Date: Mon, 11 May 2026 19:02:48 -0700
Message-ID: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 90E5D518903
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10772-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[zytor.com,arm.com,kernel.org,linux.microsoft.com,outlook.com,microsoft.com,vger.kernel.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[31];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
 o All tests involved passthru of devices using MSIx.
 o Following combinations were tested doing PF passthru:
    - L1VH(1): test 1: Mellanox ConnectX-6 Lx passthru
               test 2: NVIDIA Tesla Tesla T4 GPU.
               test 3: Both of above simultaneous passthru
    - Baremetal dom0/root: All of above.
 o VF: Mellanox ConnectX-6 Lx passthru on baremetal dom0/root.

(1) L1VH: this is a semi privileged VM that runs on Windows root on
          Hyper-V, and allows users to create more child VMs.

This series strives to establish a base line. Some pending work items:
 o arm64 : some delta to make this work on arm64 (in progress).
 o Qemu and OpenVMM support (in progress).
 o Further VF testing on l1vh
 o device sleep/wakeup.
 o More stress testing with high end GPUs

Changes in V3:
 o patch #8: fix compiler issues incase of !CONFIG_HYPERV. Also, do forward
   declaration of struct pci_dev instead of including pci.h.
 o patch #9: minor changes to comments. Pass hv_domain instead of 
   iommu_domain to hv_iommu_detach_dev() since that's what it needs. Set
   device private to null if attach fails. Clam down number of PFNs passed
   to hv_iommu_map_pgs().

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
  iommu/hyperv: Rename hyperv-iommu.c to hyperv-irq.c
  x86/hyperv: Cosmetic changes in irqdomain.c for readability
  mshv: Provide a way to get partition ID if running in a VMM process
  mshv: Declarations and definitions for VFIO-MSHV bridge device
  mshv: Implement mshv bridge device for VFIO
  mshv: Add ioctl support for MSHV-VFIO bridge device
  mshv: Import data structs around device passthru from hyperv headers
  PCI: hv: VMBus and PCI device IDs for PCI passthru
  x86/hyperv: Implement Hyper-V virtual IOMMU
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
 drivers/iommu/hyperv-iommu-root.c             | 918 ++++++++++++++++++
 .../iommu/{hyperv-iommu.c => hyperv-irq.c}    |   6 +-
 drivers/iommu/irq_remapping.c                 |   2 +-
 drivers/pci/controller/pci-hyperv.c           |  24 +
 include/asm-generic/mshyperv.h                |  33 +
 include/hyperv/hvgdk_mini.h                   |  11 +
 include/hyperv/hvhdk_mini.h                   | 112 +++
 include/linux/hyperv.h                        |   6 +
 include/uapi/linux/mshv.h                     |  31 +
 19 files changed, 1740 insertions(+), 122 deletions(-)
 create mode 100644 drivers/hv/mshv_vfio.c
 create mode 100644 drivers/iommu/hyperv-iommu-root.c
 rename drivers/iommu/{hyperv-iommu.c => hyperv-irq.c} (99%)

-- 
2.51.2.vfs.0.1


