Return-Path: <linux-hyperv+bounces-10755-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKSdH9IKAmrinQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10755-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 18:58:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA490512D72
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 18:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA352312DEDA
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 16:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C9D42885F;
	Mon, 11 May 2026 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EBqZ3lvw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA11D428462;
	Mon, 11 May 2026 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516657; cv=none; b=Ys4EMr7YkAmTN0LSGJ4N5gWgmwh5loaM0XbnVroP+IuJjdUhivp5zFfJiTuPDiMoTApjfR0V7mj8i72GoLjILMlzpoQJE0RltB9cnSjLUM6Lh9yV/P4Wia71TTnhridJV+NQW+DCR7B/8O1rSLYCU13wzvk5lrq8ZCU/2mKa3fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516657; c=relaxed/simple;
	bh=A7DrKuKjFqBnsiYVQmkH3SPF4bmEh990rRhIOilh9r0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VWsUovGPapn9hnEwnDwrDCfnRdHu7BZ9UdaM/UxXH84XHJmzpqY0qMkfBli023VYQgXiD/wbFUPg0JFr57afLV0+DPJO6FcxKXGBE28jMvOVInRQJX1hUI5bqpk4uCO6kZnl3FldSET7+n1DMGw2LTzeH5hxhol8TMIo/crd0c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EBqZ3lvw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.233.27])
	by linux.microsoft.com (Postfix) with ESMTPSA id C0A4D20B7166;
	Mon, 11 May 2026 09:24:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C0A4D20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778516653;
	bh=73rJxfgCC5Iw4KlYZQwmxccecFIL/PKYVBRFOATZJGo=;
	h=From:To:Cc:Subject:Date:From;
	b=EBqZ3lvwbrU/InU7SQvNY6nh5ozELraKlQuDboLwVcf0azCgvdrTBRntSMUFI6Xa5
	 U2mm/6w3jl1ZYDXdk4Bf594KZbXt6L43dLrP6rFpYy+n0HzvHh2PbWBuW5qV+JGVoc
	 YCtDSiP9x4Gu9oh+H1eY8w0BNqBG3XMwVI+Y6Xew=
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
	easwar.hariharan@linux.microsoft.com
Subject: [PATCH v1 0/4] Hyper-V: Add para-virtualized IOMMU support for Linux guests
Date: Tue, 12 May 2026 00:24:04 +0800
Message-ID: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BA490512D72
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,8bytes.org,arm.com,google.com,arndb.de,ziepe.ca,outlook.com,linux.microsoft.com];
	TAGGED_FROM(0.00)[bounces-10755-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
    hypercall interfaces, handling domain allocation, attachment,
    and detachment for endpoint devices.

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

Changes since RFC v1 [1]:
- Scoped platform support to x86 only (Intel VT-d and AMD IOMMU);
  initialization now uses x86_init.iommu.iommu_init
- Added page-selective IOTLB flush support (new Patch 4)
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

[1] https://lore.kernel.org/linux-hyperv/20251209051128.76913-1-zhangyu1@linux.microsoft.com/

Easwar Hariharan (1):
  iommu: Move Hyper-V IOMMU driver to its own subdirectory

Wei Liu (1):
  hyperv: Introduce new hypercall interfaces used by Hyper-V guest IOMMU

Yu Zhang (2):
  iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest
  iommu/hyperv: Add page-selective IOTLB flush support

 MAINTAINERS                                   |   2 +-
 arch/x86/hyperv/hv_init.c                     |   4 +
 arch/x86/include/asm/mshyperv.h               |   4 +
 drivers/iommu/Kconfig                         |  10 +-
 drivers/iommu/Makefile                        |   2 +-
 drivers/iommu/hyperv/Kconfig                  |  27 +
 drivers/iommu/hyperv/Makefile                 |   3 +
 drivers/iommu/hyperv/iommu.c                  | 794 ++++++++++++++++++
 drivers/iommu/hyperv/iommu.h                  |  54 ++
 .../irq_remapping.c}                          |   2 +-
 drivers/pci/controller/pci-hyperv.c           |  19 +-
 include/asm-generic/mshyperv.h                |  12 +
 include/hyperv/hvgdk_mini.h                   |   9 +
 include/hyperv/hvhdk_mini.h                   | 141 ++++
 14 files changed, 1070 insertions(+), 13 deletions(-)
 create mode 100644 drivers/iommu/hyperv/Kconfig
 create mode 100644 drivers/iommu/hyperv/Makefile
 create mode 100644 drivers/iommu/hyperv/iommu.c
 create mode 100644 drivers/iommu/hyperv/iommu.h
 rename drivers/iommu/{hyperv-iommu.c => hyperv/irq_remapping.c} (99%)

-- 
2.52.0


