Return-Path: <linux-hyperv+bounces-8391-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LkBKeoIcGlyUwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8391-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jan 2026 23:59:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8AB4D649
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jan 2026 23:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C7A9A4CC8A
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jan 2026 21:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68AC3C1999;
	Tue, 20 Jan 2026 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XdU2nnEI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E95D3A7DEF;
	Tue, 20 Jan 2026 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768945838; cv=none; b=A/4J9znQBlJyGgiMySdNfpB5ZoMfFeI6nlfw4oqXerK5XbbqvtLB9849ue30txAcXTlljGww4i4AP7JDoCSBWj5eVOicaZrmZhmN90u6+Xbkkn1j/KWBSAZUAm/q0biyzc/QF65TL1JXgbPH6+Z5kbKim2kgjXNLKUigDbkl07E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768945838; c=relaxed/simple;
	bh=BnPPPDyiswmapn7ng53S90CUXPw2YkgJ8Uvlh8KUbv4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byBrvhrn0wJ0WFJ2hWpG2/f1VyK131UWyRKFcnUlhOUIb7CWD+g4kOenhmOncdp3d9RAgdYQeKMOn9gbtrPA3rQx4Ox/V+pBS3I6S3Qa5LmhKBAsFaUoohI0Ac16UiUhsbOeHH/cIe91NHuq9H6VwX58jtfzxMIo4KoxbP2/WxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XdU2nnEI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8301220B7167;
	Tue, 20 Jan 2026 13:50:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8301220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768945834;
	bh=DwMx1fGfc/oMBGTHztc/dxOH22dYYQr047Mb7LvAKtc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XdU2nnEITnohdXjTAjZux5Tf14cVyNK+1C0eGq/oK+KE1lzbPRUSq+ZyoEC65z6Nu
	 428sRK77k7ioALgSM4txW6tNcXrwJ2u07BXXVCqLB4vhBS/Keavg5KXscUf6CpEo6j
	 ONB3467l8VndQ/7q+tIfu5XMSAqJ2PcV4iH0KMsk=
Date: Tue, 20 Jan 2026 13:50:32 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
 nunodasneves@linux.microsoft.com, mhklinux@outlook.com
Subject: Re: [PATCH v0 00/15] PCI passthru on Hyper-V (Part I)
Message-ID: <20260120134933.00004f2a@linux.microsoft.com>
In-Reply-To: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8391-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,linux.microsoft.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.microsoft.com,none];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.pan@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 1C8AB4D649
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Mukesh,

On Mon, 19 Jan 2026 22:42:15 -0800
Mukesh R <mrathor@linux.microsoft.com> wrote:

> From: Mukesh Rathor <mrathor@linux.microsoft.com>
>=20
> Implement passthru of PCI devices to unprivileged virtual machines
> (VMs) when Linux is running as a privileged VM on Microsoft Hyper-V
> hypervisor. This support is made to fit within the workings of VFIO
> framework, and any VMM needing to use it must use the VFIO subsystem.
> This supports both full device passthru and SR-IOV based VFs.
>=20
> There are 3 cases where Linux can run as a privileged VM (aka MSHV):
>   Baremetal root (meaning Hyper-V+Linux), L1VH, and Nested.
>=20
I think some introduction/background to L1VH would help.

> At a high level, the hypervisor supports traditional mapped iommu
> domains that use explicit map and unmap hypercalls for mapping and
> unmapping guest RAM into the iommu subsystem.
It may be clearer to state that the hypervisor supports Linux IOMMU
paging domains through map/unmap hypercalls, mapping GPAs to HPAs using
stage=E2=80=912 I/O page tables.

> Hyper-V also has a
> concept of direct attach devices whereby the iommu subsystem simply
> uses the guest HW page table (ept/npt/..). This series adds support
> for both, and both are made to work in VFIO type1 subsystem.
>=20
This may warrant introducing a new IOMMU domain feature flag, as it
performs mappings but does not support map/unmap semantics in the same
way as a paging domain.

> While this Part I focuses on memory mappings, upcoming Part II
> will focus on irq bypass along with some minor irq remapping=20
> updates.
>=20
> This patch series was tested using Cloud Hypervisor verion 48. Qemu
> support of MSHV is in the works, and that will be extended to include
> PCI passthru and SR-IOV support also in near future.
>=20
> Based on: 8f0b4cce4481 (origin/hyperv-next)
>=20
> Thanks,
> -Mukesh
>=20
> Mukesh Rathor (15):
>   iommu/hyperv: rename hyperv-iommu.c to hyperv-irq.c
>   x86/hyperv: cosmetic changes in irqdomain.c for readability
>   x86/hyperv: add insufficient memory support in irqdomain.c
>   mshv: Provide a way to get partition id if running in a VMM process
>   mshv: Declarations and definitions for VFIO-MSHV bridge device
>   mshv: Implement mshv bridge device for VFIO
>   mshv: Add ioctl support for MSHV-VFIO bridge device
>   PCI: hv: rename hv_compose_msi_msg to hv_vmbus_compose_msi_msg
>   mshv: Import data structs around device domains and irq remapping
>   PCI: hv: Build device id for a VMBus device
>   x86/hyperv: Build logical device ids for PCI passthru hcalls
>   x86/hyperv: Implement hyperv virtual iommu
>   x86/hyperv: Basic interrupt support for direct attached devices
>   mshv: Remove mapping of mmio space during map user ioctl
>   mshv: Populate mmio mappings for PCI passthru
>=20
>  MAINTAINERS                         |    1 +
>  arch/arm64/include/asm/mshyperv.h   |   15 +
>  arch/x86/hyperv/irqdomain.c         |  314 ++++++---
>  arch/x86/include/asm/mshyperv.h     |   21 +
>  arch/x86/kernel/pci-dma.c           |    2 +
>  drivers/hv/Makefile                 |    3 +-
>  drivers/hv/mshv_root.h              |   24 +
>  drivers/hv/mshv_root_main.c         |  296 +++++++-
>  drivers/hv/mshv_vfio.c              |  210 ++++++
>  drivers/iommu/Kconfig               |    1 +
>  drivers/iommu/Makefile              |    2 +-
>  drivers/iommu/hyperv-iommu.c        | 1004
> +++++++++++++++++++++------ drivers/iommu/hyperv-irq.c          |
> 330 +++++++++ drivers/pci/controller/pci-hyperv.c |  207 ++++--
>  include/asm-generic/mshyperv.h      |    1 +
>  include/hyperv/hvgdk_mini.h         |   11 +
>  include/hyperv/hvhdk_mini.h         |  112 +++
>  include/linux/hyperv.h              |    6 +
>  include/uapi/linux/mshv.h           |   31 +
>  19 files changed, 2182 insertions(+), 409 deletions(-)
>  create mode 100644 drivers/hv/mshv_vfio.c
>  create mode 100644 drivers/iommu/hyperv-irq.c
>=20


