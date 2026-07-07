Return-Path: <linux-hyperv+bounces-11845-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QrZ2MzcVTWojuwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11845-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Jul 2026 17:03:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 382E471CF64
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Jul 2026 17:03:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=jCD1N2xC;
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11845-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11845-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 438C03138E26
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jul 2026 14:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A8530CD92;
	Tue,  7 Jul 2026 14:48:19 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F2730AABE;
	Tue,  7 Jul 2026 14:48:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435699; cv=none; b=ZiBIrYp3J2RKMXHLC/lENhVK6Jri9560B/o9yCAYHxPlLpcgaaqDxoAl/1Xl7wxdwDICkat6Gp+lJETh2MgpiZQLd/insidJgo+DB0jTMZmoTy2ov15haIvYigQm8lGK3tqlOmJxYZAttTGMDanp/S/RoVpcHiAdoQEAvwCJUw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435699; c=relaxed/simple;
	bh=3tWkLtv1r5S9y1Rh08QPuFqmn/Edh3V72WQL303pkDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thpfKRXYu1Z2uV714oKOJNMyp2VLzYlXfCDnJzorsc+iML6ahnvLFi6KgEwGUz77eYOxgzei1qyJBDk/xpm2/6EmG2Zu/xdQjs+y4P3W2xKoJaenevDyKbl3CDgIN5FbV2go85SGfZkF7iP1A+kIKfyODJoei3t7V5J2p3aJA7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jCD1N2xC; arc=none smtp.client-ip=13.77.154.182
Received: from localhost (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2F94920B7166;
	Tue,  7 Jul 2026 07:48:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2F94920B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783435693;
	bh=jZRO96unfBRPa4hmnICsULiigA4xhGgQeUwW9uBSN7c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jCD1N2xCD97HB8h/7Xd9VHwi0f+vmVZsGMEZ0RLfbm9mvrKY8H9ja5k8PSAMrq5US
	 znoXfGfJ2Gg6fI/jfFerPC6XQy/g79MMpXS7tHDNwPG8S/10KbOGHrV+GFbq2Yru/I
	 ilErZQbReXPQ4sF24kgh5fOy7X6ZKcueVHgVWA+U=
Date: Tue, 7 Jul 2026 07:48:14 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: Yu Zhang <zhangyu1@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, wei.liu@kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
 longli@microsoft.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org,
 lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org, arnd@arndb.de,
 jgg@ziepe.ca, mhklinux@outlook.com, tgopinath@linux.microsoft.com,
 easwar.hariharan@linux.microsoft.com, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260707074814.000010a0@linux.microsoft.com>
In-Reply-To: <1f57d1d9-ccbb-ff4e-9680-d45adc7821ea@linux.microsoft.com>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
	<20260702160518.311234-4-zhangyu1@linux.microsoft.com>
	<1f57d1d9-ccbb-ff4e-9680-d45adc7821ea@linux.microsoft.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11845-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mrathor@linux.microsoft.com,m:zhangyu1@linux.microsoft.com,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pci@vger.kernel.org,m:linux-arch@vger.kernel.org,m:wei.liu@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:lpieralisi@kernel.org,m:mani@kernel.org,m:robh@kernel.org,m:arnd@arndb.de,m:jgg@ziepe.ca,m:mhklinux@outlook.com,m:tgopinath@linux.microsoft.com,m:easwar.hariharan@linux.microsoft.com,m:jacob.pan@linux.microsoft.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jacob.pan@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.microsoft.com,vger.kernel.org,lists.linux.dev,kernel.org,microsoft.com,8bytes.org,arm.com,google.com,arndb.de,ziepe.ca,outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.pan@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 382E471CF64

Hi Mukesh,

On Mon, 6 Jul 2026 17:08:50 -0700
Mukesh R <mrathor@linux.microsoft.com> wrote:

> From: Mukesh R <mrathor@linux.microsoft.com>
> To: Yu Zhang <zhangyu1@linux.microsoft.com>,
> linux-kernel@vger.kernel.org,  linux-hyperv@vger.kernel.org,
> iommu@lists.linux.dev,  linux-pci@vger.kernel.org,
> linux-arch@vger.kernel.org Cc: wei.liu@kernel.org, kys@microsoft.com,
> haiyangz@microsoft.com,  decui@microsoft.com, longli@microsoft.com,
> joro@8bytes.org, will@kernel.org,  robin.murphy@arm.com,
> bhelgaas@google.com, kwilczynski@kernel.org,  lpieralisi@kernel.org,
> mani@kernel.org, robh@kernel.org, arnd@arndb.de,  jgg@ziepe.ca,
> mhklinux@outlook.com, jacob.pan@linux.microsoft.com,
> tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com
> Subject: Re: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU
> support  for Hyper-V guest Date: Mon, 6 Jul 2026 17:08:50 -0700
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
> Thunderbird/91.13.1
> 
> On 7/2/26 09:05, Yu Zhang wrote:
> > Add a para-virtualized IOMMU driver for Linux guests running on
> > Hyper-V. This driver implements stage-1 IO translation within the
> > guest OS. It integrates with the Linux IOMMU core, utilizing
> > Hyper-V hypercalls for:
> >   - Capability discovery
> >   - Domain allocation, configuration, and deallocation
> >   - Device attachment and detachment
> >   - IOTLB invalidation
> > 
> > The driver constructs x86-compatible stage-1 IO page tables in the
> > guest memory using consolidated IO page table helpers. This allows
> > the guest to manage stage-1 translations independently of vendor-
> > specific drivers (like Intel VT-d or AMD IOMMU).
> > 
> > Hyper-V consumes this stage-1 IO page table when a device domain is
> > created and configured, and nests it with the host's stage-2 IO page
> > tables, therefore eliminating the VM exits for guest IOMMU mapping
> > operations. For unmapping operations, VM exits to perform the IOTLB
> > flush are still unavoidable.
> > 
> > To identify a device in its hypercall interface, the driver looks
> > up the logical device ID prefix registered for the device's PCI
> > domain (see the logical device ID registry in hv_common.c) and
> > combines it with the PCI function number of the endpoint device.
> > 
> > Co-developed-by: Wei Liu <wei.liu@kernel.org>
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > Co-developed-by: Easwar Hariharan
> > <easwar.hariharan@linux.microsoft.com> Signed-off-by: Easwar
> > Hariharan <easwar.hariharan@linux.microsoft.com> Signed-off-by: Yu
> > Zhang <zhangyu1@linux.microsoft.com> ---
> >   arch/x86/hyperv/hv_init.c       |   4 +
> >   arch/x86/include/asm/mshyperv.h |   4 +
> >   drivers/iommu/Kconfig           |   1 +
> >   drivers/iommu/hyperv/Kconfig    |  16 +
> >   drivers/iommu/hyperv/Makefile   |   1 +
> >   drivers/iommu/hyperv/iommu.c    | 620
> > ++++++++++++++++++++++++++++++++ drivers/iommu/hyperv/iommu.h    |
> > 51 +++ 7 files changed, 697 insertions(+)
> >   create mode 100644 drivers/iommu/hyperv/Kconfig
> >   create mode 100644 drivers/iommu/hyperv/iommu.c  
> 
> Hey Jacob,
> 
> You had suggested I rename iommu.c to iommu-root.c (I called it
> hv-iommu-root.c eventually), so this needs to be renamed also,
> right?

yes, I agree. I feel it is clearer to name it hv-iommu-guest.c since
this is a guest only driver.

