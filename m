Return-Path: <linux-hyperv+bounces-11809-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i9AZOPuPRmqAYgsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11809-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 18:21:15 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CA46FA1A8
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 18:21:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=XBrdEHo+;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11809-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11809-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 459C630ADA29
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2026 16:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB473246EF;
	Thu,  2 Jul 2026 16:05:27 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC4B314B76;
	Thu,  2 Jul 2026 16:05:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008327; cv=none; b=M5AYPJbOIekTn/zazrpss3Vn4pSCeCXtSxzJ+Kgnur2CO5fpqdWHp6aJYJSh2XuxojyUjV69rtscnF3L3WZNy3Cnxj4frE4t4mbz6mGkCiRgMaxlidzf+SoqCXbNJiE6lLyQ50JEHkQ3ng9f6wNh2CjIErGvmwpPIAn9LSp3f+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008327; c=relaxed/simple;
	bh=lpQShleLcnURdAFGoGFwoTepKOWCxvG/AyRe6mlJ8iw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UADLyTdtf9RQWVKsJ6suxKN60GK/5x4CM9slIzz7x4HMRGQmcuG6lyxeHBj1RxOvrBZFe46wZaNdKTV6KFgYdhhX90OeoQhP2kfR+NdHKDaciOVtMxxbuRCsTOIHI2/Cqk4vgWhF0E0VnwedfJYHm7TxPzMNvYvOGP/GXlp/fa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XBrdEHo+; arc=none smtp.client-ip=13.77.154.182
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id DB0A620B7167;
	Thu,  2 Jul 2026 09:05:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DB0A620B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783008323;
	bh=Vjs7ij0yRe5VI0EfYmaoUe/0H9VspAUIQwDoikZjFHc=;
	h=From:To:Cc:Subject:Date:From;
	b=XBrdEHo+qmUvhLer+0cF/N0JsHTdzS6f77qhYqc4aTJTnWRgND90UMNjX/M1O7SFA
	 UkZf25AA8CM+0fxgQIba0dcokWFdS9Xz5sC3tgLyHy/Y6bc0AaEZ8yDOGn0Zlwfir5
	 VKlPqBqess3QMluTgIISxACK9eqWLvNuME6oeZAU=
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: wei.liu@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	arnd@arndb.de,
	jgg@ziepe.ca,
	mhklinux@outlook.com,
	jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	mrathor@linux.microsoft.com
Subject: [PATCH v2 0/4] Hyper-V: Add para-virtualized IOMMU support for Linux guests
Date: Fri,  3 Jul 2026 00:05:14 +0800
Message-ID: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11809-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,8bytes.org,arm.com,google.com,arndb.de,ziepe.ca,outlook.com,linux.microsoft.com];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pci@vger.kernel.org,m:linux-arch@vger.kernel.org,m:wei.liu@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:lpieralisi@kernel.org,m:mani@kernel.org,m:robh@kernel.org,m:arnd@arndb.de,m:jgg@ziepe.ca,m:mhklinux@outlook.com,m:jacob.pan@linux.microsoft.com,m:tgopinath@linux.microsoft.com,m:easwar.hariharan@linux.microsoft.com,m:mrathor@linux.microsoft.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.microsoft.com:dkim,linux.microsoft.com:mid,linux.microsoft.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97CA46FA1A8

This patch series introduces a para-virtualized IOMMU driver for
Linux guests running on Microsoft Hyper-V. The driver enables two
primary use cases:
  1) In-kernel DMA protection for devices assigned to the guest.
  2) Device assignment to guest user space (e.g., via VFIO).

The driver implements the following core functionality:
*   Hypercall-based Enumeration
    Unlike traditional ACPI-based discovery (e.g., DMAR/IVRS),
    this driver enumerates the Hyper-V IOMMU capabilities directly
    via hypercalls. This approach allows the guest to discover
    IOMMU presence and features without requiring specific virtual
    firmware extensions or modifications.

*   Domain Management
    The driver manages IOMMU domains through a new set of Hyper-V
    hypercall interfaces, handling domain allocation and attachment
    for endpoint devices.

*   Nested Translation Support
    This implementation leverages guest-managed stage-1 I/O page
    tables nested with host stage-2 translations. It is built
    upon the consolidated IOMMU page table framework (IOMMU_PT).
    This design eliminates the need for emulating map operations.
    Both Intel VT-d and AMD IOMMU platforms are supported.

*   IOTLB Invalidation
    IOTLB invalidation requests are marshaled and issued to the
    hypervisor through the same hypercall mechanism. Both domain-
    selective and page-selective flushes are supported.

Implementation Notes:
*   Platform Support
    The current implementation targets x86 platforms with Intel
    VT-d and AMD IOMMU hardware.

*   MSI Region Handling
    The hardware MSI region is hard-coded to the standard x86
    interrupt range (0xfee00000 - 0xfeefffff). Future updates may
    allow this configuration to be queried via hypercalls if new
    hardware platforms are to be supported.

*   Reserved Regions (RMRR)
    There is currently no requirement to support assigned devices with
    ACPI RMRR limitations. Consequently, this patch series does not
    specify or query reserved memory regions.

Testing:
This series has been validated with the following configurations:
- Intel DSA devices assigned to the guest, tested with dmatest.
- NVMe devices assigned to the guest on AMD platforms, tested
  with fio.
- dma_map_benchmark for DMA mapping performance evaluation.

Changelog:

v1[1] -> v2:
- Dropped the "move to subdirectory" patch; the directory now exists
  upstream.

- hv: logical device ID registry:
  - Moved the registry to hv_common.c so it can be shared, and derived
    the prefix via a shared helper instead of caching it in pci-hyperv's
    private struct.
  - Moved the lookup out of the irq-disabled region (PREEMPT_RT).

- iommu/hyperv: para-virtualized IOMMU:
  - Removed the unused detach_dev op.
  - Rejected a hypervisor not advertising x86 page sizes instead of
    masking and warning.
  - Statically initialized the identity and blocking domains.
  - Gave the blocking domain its own attach op, which returns the hypercall
    status and WARNs on failure.

- iommu/hyperv: page-selective IOTLB flush:
  - Used a single descriptor covering a slightly larger power-of-two
    range, instead of splitting the range into multiple descriptors.
  - Fixed the inclusive-end corner case in the flush range calculation.

RFC v1[2] -> v1[1]:
- Scoped platform support to x86 only (Intel VT-d and AMD IOMMU);
  initialization now uses x86_init.iommu.iommu_init
- Added page-selective IOTLB flush support
- Disable device ATS in hv_iommu_release_device()
- Addressed review comments from Michael Kelley:
  - Reversed dependency: pvIOMMU exports registration API for
    pci-hyperv to call, instead of pci-hyperv exporting
    hv_build_logical_dev_id()
  - Dropped separate output page allocation patch; hypercall input
    and output now share the same per-CPU page
  - Cleaned up Kconfig (removed PCI_HYPERV dependency, unnecessary
    selects)
  - Removed dev_list, per-domain spinlock, and syscore_ops
  - Removed forward declarations by reordering functions
  - Fixed typos, cleaned up Kconfig selects, improved pr_info
    messages, etc.

[1] https://lore.kernel.org/linux-hyperv/20260511162408.1180069-1-zhangyu1@linux.microsoft.com/
[2] https://lore.kernel.org/linux-hyperv/20251209051128.76913-1-zhangyu1@linux.microsoft.com/


Easwar Hariharan (1):
  Drivers: hv: Add logical device ID registry for vPCI devices

Wei Liu (1):
  hyperv: Introduce new hypercall interfaces used by Hyper-V guest IOMMU

Yu Zhang (2):
  iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest
  iommu/hyperv: Add page-selective IOTLB flush support

 arch/x86/hyperv/hv_init.c           |   4 +
 arch/x86/include/asm/mshyperv.h     |   4 +
 drivers/hv/hv_common.c              |  95 ++++
 drivers/iommu/Kconfig               |   1 +
 drivers/iommu/hyperv/Kconfig        |  16 +
 drivers/iommu/hyperv/Makefile       |   1 +
 drivers/iommu/hyperv/iommu.c        | 686 ++++++++++++++++++++++++++++
 drivers/iommu/hyperv/iommu.h        |  51 +++
 drivers/pci/controller/pci-hyperv.c |  21 +-
 include/asm-generic/mshyperv.h      |  13 +
 include/hyperv/hvgdk_mini.h         |   9 +
 include/hyperv/hvhdk_mini.h         | 141 ++++++
 include/linux/hyperv.h              |   8 +
 13 files changed, 1045 insertions(+), 5 deletions(-)
 create mode 100644 drivers/iommu/hyperv/Kconfig
 create mode 100644 drivers/iommu/hyperv/iommu.c
 create mode 100644 drivers/iommu/hyperv/iommu.h

-- 
2.52.0


