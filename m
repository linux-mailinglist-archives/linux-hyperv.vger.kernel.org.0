Return-Path: <linux-hyperv+bounces-10294-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJUbFFI16Gk6GwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10294-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 04:41:22 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A66AC4418BC
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 04:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D93B430075CD
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 02:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7775C3806C3;
	Wed, 22 Apr 2026 02:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lUQ+NBFU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1611E3806D9;
	Wed, 22 Apr 2026 02:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776825220; cv=none; b=DGZkrvtIaGmjlszn2lj7/2Lu1Tdy9YqvUSynddtmQG+OeAABssPDya2OrSizXRnAupLBoY1kv/T5bBSZ2CwciEfENk0sP/Jjp7GkMOb4OUtRc9SQKw/2oVO7CISDnFUFuqXHdK8O8u/YmaTQs90wV20tcV05AbVUoP/q3Q50p8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776825220; c=relaxed/simple;
	bh=GmhkLwfa6h6rSszM+OfJhO9L6pKs23/XT/lrbTGZNX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=suHVzafvR38GbiJzykcBt+vLW/QJifciO2fdeAFN+Jg/D6mKPKeQncb8vRZqV2/hRkpfsarvbE1Rwa5PqPMk2eXSA+N9lt8gpxK+qzgzKBxbPqPW+HbBNuSLYFcf5rYoumBiHA61rq4S+8a5KAiG9bwKGkGJxqXRrhUwFt8+Uaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lUQ+NBFU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id AB52020B6F01;
	Tue, 21 Apr 2026 19:33:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB52020B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776825209;
	bh=O+mpjpLBLfXxNngTSPHR4JXlp5P2eN9Wrs/JOmLiTYs=;
	h=From:To:Cc:Subject:Date:From;
	b=lUQ+NBFUMYhMiCKp5hJ4csDmWh7uDXFoFxm83NvWZ/IwJ9a5RxenB0Yd0zUaoi1pw
	 3yv9M2bPsfObV813+Lm1OuK3i4jcBXSJHx2cUn1pSWMy43jtuQH42gb29McJePj3lT
	 Ej8Q0Cx2NZEoOqbrcfAhwc/jLbsHBVnf65GmjuN0=
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
Subject: [PATCH V1 00/13] PCI passthru on Hyper-V (Part I)
Date: Tue, 21 Apr 2026 19:32:26 -0700
Message-ID: <20260422023239.1171963-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[zytor.com,arm.com,kernel.org,linux.microsoft.com,outlook.com,microsoft.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-10294-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A66AC4418BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

While this Part I focuses on memory mappings, upcoming Part II
will focus on irq bypass along with some minor irq remapping 
updates.

Based on: cd9f2e7d6e5b (origin/hyperv-next)

Testing:
 o Most testing done on hyperv-next:e733a9e28180 using Cloud Hypervisor (51).
 o Limited testing on : cd9f2e7d6e5b
 o Tested with impending Part II irq patches.
 o All tests involved PF passthru of devices using MSIx.
 o Following combinations were tested:
    - L1VH(1): test 1: Mellanox ConnectX-6 Lx passthru
               test 2: NVIDIA Tesla Tesla T4 GPU.
               test 3: Both of above simultaneous passthru
    - Baremetal dom0/root: All of above.

(1) L1VH: this is a semi privileged VM that runs on Windows root on
          Hyper-V, and allows users to create more child VMs.

Pending: This to establish a baseline for further enhancements.
 o arm64 : some delta to make this work on arm64 (in progress).
 o device sleep/wakeup.
 o More stress testing 
 o CH reports it could not unbind vfio group upon guest shutdown. Need 
   to reboot for now.
 o Qemu support (in progress).

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

Mukesh R (13):
  iommu/hyperv: rename hyperv-iommu.c to hyperv-irq.c
  x86/hyperv: cosmetic changes in irqdomain.c for readability
  x86/hyperv: add insufficient memory support in irqdomain.c
  mshv: Provide a way to get partition id if running in a VMM process
  mshv: Declarations and definitions for VFIO-MSHV bridge device
  mshv: Implement mshv bridge device for VFIO
  mshv: Add ioctl support for MSHV-VFIO bridge device
  PCI: hv: rename hv_compose_msi_msg to hv_vmbus_compose_msi_msg
  mshv: Import data structs around device passthru from hyperv headers
  PCI: hv: Build device id for a VMBus device, export PCI devid function
  x86/hyperv: Implement hyperv virtual iommu
  mshv: Populate mmio mappings for PCI passthru
  mshv: pin all ram mem regions if partition has device passthru

 MAINTAINERS                                   |   3 +-
 arch/x86/hyperv/irqdomain.c                   | 229 +++--
 arch/x86/include/asm/mshyperv.h               |   4 +
 arch/x86/kernel/pci-dma.c                     |   2 +
 drivers/hv/Makefile                           |   3 +-
 drivers/hv/mshv_root.h                        |  26 +
 drivers/hv/mshv_root_main.c                   | 256 ++++-
 drivers/hv/mshv_vfio.c                        | 211 ++++
 drivers/iommu/Kconfig                         |   5 +-
 drivers/iommu/Makefile                        |   3 +-
 drivers/iommu/hyperv-iommu-root.c             | 899 ++++++++++++++++++
 .../iommu/{hyperv-iommu.c => hyperv-irq.c}    |   2 +-
 drivers/iommu/irq_remapping.c                 |   2 +-
 drivers/pci/controller/pci-hyperv.c           | 120 ++-
 include/asm-generic/mshyperv.h                |  34 +
 include/hyperv/hvgdk_mini.h                   |  11 +
 include/hyperv/hvhdk_mini.h                   | 112 +++
 include/linux/hyperv.h                        |   6 +
 include/uapi/linux/mshv.h                     |  31 +
 19 files changed, 1790 insertions(+), 169 deletions(-)
 create mode 100644 drivers/hv/mshv_vfio.c
 create mode 100644 drivers/iommu/hyperv-iommu-root.c
 rename drivers/iommu/{hyperv-iommu.c => hyperv-irq.c} (99%)

-- 
2.51.2.vfs.0.1


