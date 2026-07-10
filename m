Return-Path: <linux-hyperv+bounces-11899-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jOolMXWgUGpn2gIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11899-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 09:34:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED6773812D
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 09:34:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=sqMxDa4P;
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11899-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11899-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 080BF301D32B
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 07:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4621B2E06ED;
	Fri, 10 Jul 2026 07:34:10 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E866837881D;
	Fri, 10 Jul 2026 07:34:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783668850; cv=none; b=WYD15kzn/Evsg5/TyeMbpx4ZJ1lmGfsznyb03yVmn7sm4DS4eKWnSRQfyjmWie8FjKYtUll5WrJ9IOAlwcxlbI8bQpNIGjvSX0D+to2H0HYVqwPPZdx1l2RmjTVi/2QEgjogoUBYJO6m6wRrg+wyqwLbJVduYSHrqeIQtXGfoA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783668850; c=relaxed/simple;
	bh=O7rbDroGQtmYm6pIEqk0HsHfEH7fi4WEP2mxwdidwXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sw997fTJgibwXmEzzQqTTthS6+y5ca7CuB9RwZsKaqWPhvIwl7Jqxek3iaC2RAu22JKjeceUiYmXsTwKRcwmKwewYA26Mr5oGtDkxnSI9PM9MEsYelSPr0ONTIj4vG5tVStOuLb7/4UEHFfhvSRFyoIZSNtXqz0usJ5AKUuuU90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sqMxDa4P; arc=none smtp.client-ip=13.77.154.182
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id D8ABD20B716E;
	Fri, 10 Jul 2026 00:33:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D8ABD20B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783668840;
	bh=IQqEZcG0wyYMUWGwme4D47nLWfFSubgT2zK5cvAu3kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sqMxDa4PsBwlzgOpQNjMQf0YD3RWLmnBowEx0oSOUEMz3sxsviALcRCOPGJrIESmE
	 BCj61JU87/Wjd+tXQPi/r/FmH1//GLmiJvXPKWoARpktPTd4869Ee2C4TjsBkaQ2tj
	 V4RoiHPEPIdgOjBjFAg/IF+yIElqY9caEaE8C80c=
Date: Fri, 10 Jul 2026 15:34:03 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "kys@microsoft.com" <kys@microsoft.com>, 
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>, 
	"longli@microsoft.com" <longli@microsoft.com>, "joro@8bytes.org" <joro@8bytes.org>, 
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "mani@kernel.org" <mani@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>, "tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>, 
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>, "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>
Subject: Re: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <enpkphavwmqrkded73c43vprczslvei4755lkxuedof4z2k3kk@y2jtklbk4efz>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-4-zhangyu1@linux.microsoft.com>
 <SN6PR02MB4157253E030D477FD91B7E26D4FE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157253E030D477FD91B7E26D4FE2@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mhklinux@outlook.com,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pci@vger.kernel.org,m:linux-arch@vger.kernel.org,m:wei.liu@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:lpieralisi@kernel.org,m:mani@kernel.org,m:robh@kernel.org,m:arnd@arndb.de,m:jgg@ziepe.ca,m:jacob.pan@linux.microsoft.com,m:tgopinath@linux.microsoft.com,m:easwar.hariharan@linux.microsoft.com,m:mrathor@linux.microsoft.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11899-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2ED6773812D

On Thu, Jul 09, 2026 at 07:08:26PM +0000, Michael Kelley wrote:
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Thursday, July 2, 2026 9:05 AM
> > 
> > Add a para-virtualized IOMMU driver for Linux guests running on Hyper-V.
> > This driver implements stage-1 IO translation within the guest OS.
> > It integrates with the Linux IOMMU core, utilizing Hyper-V hypercalls
> > for:
> >  - Capability discovery
> >  - Domain allocation, configuration, and deallocation
> >  - Device attachment and detachment
> >  - IOTLB invalidation
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
> > To identify a device in its hypercall interface, the driver looks up the
> > logical device ID prefix registered for the device's PCI domain (see the
> > logical device ID registry in hv_common.c) and combines it with the PCI
> > function number of the endpoint device.
> > 
> > Co-developed-by: Wei Liu <wei.liu@kernel.org>
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> > ---
> >  arch/x86/hyperv/hv_init.c       |   4 +
> >  arch/x86/include/asm/mshyperv.h |   4 +
> >  drivers/iommu/Kconfig           |   1 +
> >  drivers/iommu/hyperv/Kconfig    |  16 +
> >  drivers/iommu/hyperv/Makefile   |   1 +
> >  drivers/iommu/hyperv/iommu.c    | 620 ++++++++++++++++++++++++++++++++
> >  drivers/iommu/hyperv/iommu.h    |  51 +++
> >  7 files changed, 697 insertions(+)
> >  create mode 100644 drivers/iommu/hyperv/Kconfig
> >  create mode 100644 drivers/iommu/hyperv/iommu.c
> >  create mode 100644 drivers/iommu/hyperv/iommu.h
> > 
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index 55a8b6de2865..094f9f7ddb72 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -578,6 +578,10 @@ void __init hyperv_init(void)
> >  	old_setup_percpu_clockev = x86_init.timers.setup_percpu_clockev;
> >  	x86_init.timers.setup_percpu_clockev = hv_stimer_setup_percpu_clockev;
> > 
> > +#ifdef CONFIG_HYPERV_PVIOMMU
> > +	x86_init.iommu.iommu_init = hv_iommu_init;
> > +#endif
> > +
> 
> This approach to .iommu_init is a bit different from the Intel VT-d and
> AMD IOMMU initialization. Those cases detect the existence of the
> IOMMU first via a "detect" function that is called in pci_iommu_alloc().
> If the detect function finds an IOMMU, it sets .iommu_init. Any
> reason not to use the same approach for the Hyper-V pvIOMMU?
> One problem with exactly the same approach is that Hyper-V
> hypercalls aren't set up at the time pci_iommu_alloc() runs.

Yes. That's why I did not follow Intel VT-d and AMD IOMMU's approach -
the hv_hypercall_pg is not ready yet.

> So you'd have to call the "detect" function here in hyperv_init(),
> and have the detect function set .iommu_init if pvIOMMU
> support is present.
> 

The detecion of the presense and capabilities of the pvIOMMU are done
in one hypercall. But I guess we can:
- do the HVCALL_GET_IOMMU_CAPABILITIES in hyperv_init();
- check the presense and only set .iommu_init to hyperv_iommu_init()
  if pvIOMMU is present;
- and then do other capalibities check in hv_iommu_init();
- only give the error log if an pvIOMMU is present yet its capabilities
  are not legal.
So below errors will not be printed for guest kernels built with
CONFIG_HYPERV_PVIOMMU and running on a host w/o one.

> While the code currently in this patch works, it generates boot
> time errors if the kernel is built with CONFIG_HYPERV_PVIOMMU
> but run in a guest on a host without pvIOMMU support:
> 
> [    0.101673] Hyper-V pvIOMMU: HVCALL_GET_IOMMU_CAPABILITIES failed, status 2
> [    0.101675] Hyper-V pvIOMMU: HVCALL_GET_IOMMU_CAPABILITIES failed: -22
> 
> We really don't want errors if it's just the case that there's no
> pvIOMMU support. A less alarming message (at INFO level instead
> of ERROR level) about running without an IOMMU might be OK, but
> perhaps is unnecessary since you have an INFO message if the
> pvIOMMU is found and successfully initialized.
> 
> >  	hv_apic_init();
> > 
> >  	x86_init.pci.arch_init = hv_pci_init;
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > index f64393e853ee..20d947c2c758 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -313,6 +313,10 @@ static inline void mshv_vtl_return_hypercall(void) {}
> >  static inline void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {}
> >  #endif
> > 
> > +#ifdef CONFIG_HYPERV_PVIOMMU
> > +int __init hv_iommu_init(void);
> > +#endif
> > +
> >  #include <asm-generic/mshyperv.h>
> > 
> >  #endif
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 6e07bd69467a..0d128f377929 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -195,6 +195,7 @@ config MSM_IOMMU
> >  source "drivers/iommu/amd/Kconfig"
> >  source "drivers/iommu/arm/Kconfig"
> >  source "drivers/iommu/intel/Kconfig"
> > +source "drivers/iommu/hyperv/Kconfig"
> >  source "drivers/iommu/iommufd/Kconfig"
> >  source "drivers/iommu/riscv/Kconfig"
> > 
> > diff --git a/drivers/iommu/hyperv/Kconfig b/drivers/iommu/hyperv/Kconfig
> > new file mode 100644
> > index 000000000000..8b6abbaaf9b8
> > --- /dev/null
> > +++ b/drivers/iommu/hyperv/Kconfig
> > @@ -0,0 +1,16 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +# HyperV paravirtualized IOMMU support
> > +config HYPERV_PVIOMMU
> > +	bool "Microsoft Hypervisor para-virtualized IOMMU support"
> > +	depends on X86_64 && HYPERV
> > +	select IOMMU_API
> > +	select GENERIC_PT
> > +	select IOMMU_PT
> > +	select IOMMU_PT_X86_64
> > +	select IOMMU_IOVA
> > +	default HYPERV
> > +	help
> > +	  Para-virtualized IOMMU driver for Linux guests running on
> > +	  Microsoft Hyper-V. Provides DMA remapping and IOTLB
> > +	  flush support to enable DMA isolation for devices
> 
> I think this is specifically "PCI devices", right?  VMBus devices
> that do DMA (storvsc and netvsc) don't use the pvIOMMU.
> The "assigned to the guest" phrase pretty much implies "PCI",
> but it would be clearer to be explicit.
> 

Right. It is specifically "PCI devices".

B.R.
Yu

> > +	  assigned to the guest.
> > diff --git a/drivers/iommu/hyperv/Makefile b/drivers/iommu/hyperv/Makefile
> > index 6ef0ef97f3dd..fefb409d976b 100644
> > --- a/drivers/iommu/hyperv/Makefile
> > +++ b/drivers/iommu/hyperv/Makefile
> > @@ -1,2 +1,3 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_IRQ_REMAP) += hv-irq-remap-x86.o
> > +obj-$(CONFIG_HYPERV_PVIOMMU) += iommu.o
> > diff --git a/drivers/iommu/hyperv/iommu.c b/drivers/iommu/hyperv/iommu.c
> > new file mode 100644
> > index 000000000000..254136946404
> > --- /dev/null
> > +++ b/drivers/iommu/hyperv/iommu.c
> > @@ -0,0 +1,620 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Hyper-V IOMMU driver.
> > + *
> > + * Copyright (C) 2019, 2024-2026 Microsoft, Inc.
> > + */
> > +
> > +#define pr_fmt(fmt) "Hyper-V pvIOMMU: " fmt
> > +#define dev_fmt(fmt) pr_fmt(fmt)
> > +
> > +#include <linux/iommu.h>
> > +#include <linux/pci.h>
> > +#include <linux/dma-map-ops.h>
> > +#include <linux/generic_pt/iommu.h>
> > +#include <linux/pci-ats.h>
> > +
> > +#include <asm/iommu.h>
> > +#include <asm/hypervisor.h>
> > +#include <asm/mshyperv.h>
> > +
> > +#include "iommu.h"
> > +#include "../iommu-pages.h"
> > +
> > +struct hv_iommu_dev *hv_iommu_device;
> > +
> > +/*
> > + * Identity and blocking domains are static singletons: identity is a 1:1
> > + * passthrough with no page table, blocking rejects all DMA. Neither holds
> > + * per-IOMMU state, so one instance suffices even with multiple vIOMMUs.
> > + */
> > +static const struct iommu_domain_ops hv_iommu_identity_domain_ops;
> > +static const struct iommu_domain_ops hv_iommu_blocking_domain_ops;
> > +static struct iommu_ops hv_iommu_ops;
> > +
> > +static struct hv_iommu_domain hv_identity_domain = {
> > +	.domain = {
> > +		.type	= IOMMU_DOMAIN_IDENTITY,
> > +		.ops	= &hv_iommu_identity_domain_ops,
> > +		.owner	= &hv_iommu_ops,
> > +	},
> > +};
> > +static struct hv_iommu_domain hv_blocking_domain = {
> > +	.domain = {
> > +		.type	= IOMMU_DOMAIN_BLOCKED,
> > +		.ops	= &hv_iommu_blocking_domain_ops,
> > +		.owner	= &hv_iommu_ops,
> > +	},
> > +};
> > +
> > +static inline bool hv_iommu_present(u64 cap)
> > +{
> > +	return cap & HV_IOMMU_CAP_PRESENT;
> > +}
> > +
> > +static inline bool hv_iommu_s1_domain_supported(u64 cap)
> > +{
> > +	return cap & HV_IOMMU_CAP_S1;
> > +}
> > +
> > +static inline bool hv_iommu_5lvl_supported(u64 cap)
> > +{
> > +	return cap & HV_IOMMU_CAP_S1_5LVL;
> > +}
> > +
> > +static inline bool hv_iommu_ats_supported(u64 cap)
> > +{
> > +	return cap & HV_IOMMU_CAP_ATS;
> > +}
> > +
> > +static int hv_create_device_domain(struct hv_iommu_domain *hv_domain, u32 domain_stage)
> > +{
> > +	int ret;
> > +	u64 status;
> > +	unsigned long flags;
> > +	struct hv_input_create_device_domain *input;
> > +
> > +	ret = ida_alloc_range(&hv_iommu_device->domain_ids,
> > +			hv_iommu_device->first_domain, hv_iommu_device->last_domain,
> > +			GFP_KERNEL);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	hv_domain->device_domain.partition_id = HV_PARTITION_ID_SELF;
> > +	hv_domain->device_domain.domain_id.type = domain_stage;
> > +	hv_domain->device_domain.domain_id.id = ret;
> > +	hv_domain->hv_iommu = hv_iommu_device;
> > +
> > +	local_irq_save(flags);
> > +
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	memset(input, 0, sizeof(*input));
> > +	input->device_domain = hv_domain->device_domain;
> > +	input->create_device_domain_flags.forward_progress_required = 1;
> > +	input->create_device_domain_flags.inherit_owning_vtl = 0;
> > +	status = hv_do_hypercall(HVCALL_CREATE_DEVICE_DOMAIN, input, NULL);
> > +
> > +	local_irq_restore(flags);
> > +
> > +	if (!hv_result_success(status)) {
> > +		pr_err("HVCALL_CREATE_DEVICE_DOMAIN failed, status %lld\n", status);
> > +		ida_free(&hv_iommu_device->domain_ids, hv_domain->device_domain.domain_id.id);
> > +	}
> > +
> > +	return hv_result_to_errno(status);
> > +}
> > +
> > +static void hv_delete_device_domain(struct hv_iommu_domain *hv_domain)
> > +{
> > +	u64 status;
> > +	unsigned long flags;
> > +	struct hv_input_delete_device_domain *input;
> > +
> > +	local_irq_save(flags);
> > +
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	memset(input, 0, sizeof(*input));
> > +	input->device_domain = hv_domain->device_domain;
> > +	status = hv_do_hypercall(HVCALL_DELETE_DEVICE_DOMAIN, input, NULL);
> > +
> > +	local_irq_restore(flags);
> > +
> > +	if (!hv_result_success(status))
> > +		pr_err("HVCALL_DELETE_DEVICE_DOMAIN failed, status %lld\n", status);
> > +
> > +	ida_free(&hv_domain->hv_iommu->domain_ids, hv_domain->device_domain.domain_id.id);
> > +}
> > +
> > +static bool hv_iommu_capable(struct device *dev, enum iommu_cap cap)
> > +{
> > +	switch (cap) {
> > +	case IOMMU_CAP_CACHE_COHERENCY:
> > +		return true;
> > +	case IOMMU_CAP_DEFERRED_FLUSH:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > +static void hv_flush_device_domain(struct hv_iommu_domain *hv_domain)
> > +{
> > +	u64 status;
> > +	unsigned long flags;
> > +	struct hv_input_flush_device_domain *input;
> > +
> > +	local_irq_save(flags);
> > +
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	memset(input, 0, sizeof(*input));
> > +	input->device_domain = hv_domain->device_domain;
> > +	status = hv_do_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN, input, NULL);
> > +
> > +	local_irq_restore(flags);
> > +
> > +	if (!hv_result_success(status))
> > +		pr_err("HVCALL_FLUSH_DEVICE_DOMAIN failed, status %lld\n", status);
> > +}
> > +
> > +static int hv_iommu_attach_dev(struct iommu_domain *domain, struct device *dev,
> > +			       struct iommu_domain *old)
> > +{
> > +	u64 status;
> > +	u32 prefix;
> > +	unsigned long flags;
> > +	struct pci_dev *pdev;
> > +	struct hv_input_attach_device_domain *input;
> > +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> > +	struct hv_iommu_domain *hv_domain = to_hv_iommu_domain(domain);
> > +	int ret;
> > +
> > +	if (vdev->hv_domain == hv_domain)
> > +		return 0;
> > +
> > +	pdev = to_pci_dev(dev);
> > +	dev_dbg(dev, "attaching to domain %d\n",
> > +		hv_domain->device_domain.domain_id.id);
> > +
> > +	ret = hv_iommu_lookup_logical_dev_id(pci_domain_nr(pdev->bus), &prefix);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "no IOMMU registration for vPCI bus\n");
> > +		return ret;
> > +	}
> > +
> > +	local_irq_save(flags);
> > +
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	memset(input, 0, sizeof(*input));
> > +	input->device_domain = hv_domain->device_domain;
> > +	input->device_id.as_uint64 = (u64)prefix | PCI_FUNC(pdev->devfn);
> > +	status = hv_do_hypercall(HVCALL_ATTACH_DEVICE_DOMAIN, input, NULL);
> > +
> > +	local_irq_restore(flags);
> > +
> > +	if (!hv_result_success(status))
> > +		pr_err("HVCALL_ATTACH_DEVICE_DOMAIN failed, status %lld\n", status);
> > +	else
> > +		vdev->hv_domain = hv_domain;
> > +
> > +	return hv_result_to_errno(status);
> > +}
> > +
> > +static int hv_iommu_blocking_attach_dev(struct iommu_domain *domain,
> > +					struct device *dev,
> > +					struct iommu_domain *old)
> > +{
> > +	int ret = hv_iommu_attach_dev(domain, dev, old);
> > +
> > +	/*
> > +	 * Attaching to the blocking domain only asks the hypervisor to
> > +	 * disable translation and IOPF for the device, so it cannot fail
> > +	 * unless there is a driver or hypervisor bug. Return the hypercall
> > +	 * status rather than 0 so that a failure on the DMA ownership claim
> > +	 * path (VFIO/iommufd) fails the claim instead of leaving the device
> > +	 * unblocked. WARN since such a failure indicates a bug.
> > +	 */
> > +	WARN_ON(ret);
> > +	return ret;
> > +}
> > +
> > +static int hv_iommu_get_logical_device_property(struct device *dev,
> > +					u32 code,
> > +					struct hv_output_get_logical_device_property *property)
> > +{
> > +	u64 status;
> > +	u32 prefix;
> > +	unsigned long flags;
> > +	int ret;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	struct hv_input_get_logical_device_property *input;
> > +	struct hv_output_get_logical_device_property *output;
> > +
> > +	ret = hv_iommu_lookup_logical_dev_id(pci_domain_nr(pdev->bus), &prefix);
> > +	if (ret)
> > +		return ret;
> > +
> > +	local_irq_save(flags);
> > +
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	output = (struct hv_output_get_logical_device_property *)(input + 1);
> > +	memset(input, 0, sizeof(*input));
> > +	input->partition_id = HV_PARTITION_ID_SELF;
> > +	input->logical_device_id = (u64)prefix | PCI_FUNC(pdev->devfn);
> > +	input->code = code;
> > +	status = hv_do_hypercall(HVCALL_GET_LOGICAL_DEVICE_PROPERTY, input, output);
> > +	*property = *output;
> > +
> > +	local_irq_restore(flags);
> > +
> > +	if (!hv_result_success(status))
> > +		pr_err("HVCALL_GET_LOGICAL_DEVICE_PROPERTY failed, status %lld\n", status);
> > +
> > +	return hv_result_to_errno(status);
> > +}
> > +
> > +static struct iommu_device *hv_iommu_probe_device(struct device *dev)
> > +{
> > +	struct pci_dev *pdev;
> > +	struct hv_iommu_endpoint *vdev;
> > +	struct hv_output_get_logical_device_property device_iommu_property = {0};
> > +
> > +	if (!dev_is_pci(dev))
> > +		return ERR_PTR(-ENODEV);
> > +
> > +	pdev = to_pci_dev(dev);
> > +
> > +	if (hv_iommu_get_logical_device_property(dev,
> > +						 HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU,
> > +						 &device_iommu_property) ||
> > +	    !(device_iommu_property.device_iommu & HV_DEVICE_IOMMU_ENABLED))
> > +		return ERR_PTR(-ENODEV);
> > +
> > +	vdev = kzalloc_obj(*vdev, GFP_KERNEL);
> > +	if (!vdev)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	vdev->dev = dev;
> > +	vdev->hv_iommu = hv_iommu_device;
> > +	dev_iommu_priv_set(dev, vdev);
> > +
> > +	if (hv_iommu_ats_supported(hv_iommu_device->cap) &&
> > +	    pci_ats_supported(pdev))
> > +		pci_enable_ats(pdev, __ffs(hv_iommu_device->pgsize_bitmap));
> > +
> > +	return &vdev->hv_iommu->iommu;
> > +}
> > +
> > +static void hv_iommu_release_device(struct device *dev)
> > +{
> > +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +
> > +	if (pdev->ats_enabled)
> > +		pci_disable_ats(pdev);
> > +
> > +	dev_iommu_priv_set(dev, NULL);
> > +
> > +	kfree(vdev);
> > +}
> > +
> > +static struct iommu_group *hv_iommu_device_group(struct device *dev)
> > +{
> > +	if (dev_is_pci(dev))
> > +		return pci_device_group(dev);
> > +
> > +	WARN_ON_ONCE(1);
> > +	return generic_device_group(dev);
> > +}
> > +
> > +static int hv_configure_device_domain(struct hv_iommu_domain *hv_domain, u32 domain_type)
> > +{
> > +	u64 status;
> > +	unsigned long flags;
> > +	struct pt_iommu_x86_64_hw_info pt_info;
> > +	struct hv_input_configure_device_domain *input;
> > +
> > +	local_irq_save(flags);
> > +
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	memset(input, 0, sizeof(*input));
> > +	input->device_domain = hv_domain->device_domain;
> > +	input->settings.flags.blocked = (domain_type == IOMMU_DOMAIN_BLOCKED);
> > +	/*
> > +	 * Clearing translation_enabled bypasses translation (DMA uses the GPA
> > +	 * directly), which only suits identity. The hypervisor requires paging
> > +	 * and blocked domains to keep it set.
> > +	 */
> > +	input->settings.flags.translation_enabled = (domain_type != IOMMU_DOMAIN_IDENTITY);
> > +
> > +	if (domain_type & __IOMMU_DOMAIN_PAGING) {
> > +		pt_iommu_x86_64_hw_info(&hv_domain->pt_iommu_x86_64, &pt_info);
> > +		input->settings.page_table_root = pt_info.gcr3_pt;
> > +		input->settings.flags.first_stage_paging_mode =
> > +			pt_info.levels == 5;
> > +	}
> > +	status = hv_do_hypercall(HVCALL_CONFIGURE_DEVICE_DOMAIN, input, NULL);
> > +
> > +	local_irq_restore(flags);
> > +
> > +	if (!hv_result_success(status))
> > +		pr_err("HVCALL_CONFIGURE_DEVICE_DOMAIN failed, status %lld\n", status);
> > +
> > +	return hv_result_to_errno(status);
> > +}
> > +
> > +static int __init hv_initialize_static_domains(void)
> > +{
> > +	int ret;
> > +	struct hv_iommu_domain *hv_domain;
> > +
> > +	/* Default stage-1 identity domain */
> > +	hv_domain = &hv_identity_domain;
> > +
> > +	ret = hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = hv_configure_device_domain(hv_domain, IOMMU_DOMAIN_IDENTITY);
> > +	if (ret)
> > +		goto delete_identity_domain;
> > +
> > +	/* Default stage-1 blocked domain */
> > +	hv_domain = &hv_blocking_domain;
> > +
> > +	ret = hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
> > +	if (ret)
> > +		goto delete_identity_domain;
> > +
> > +	ret = hv_configure_device_domain(hv_domain, IOMMU_DOMAIN_BLOCKED);
> > +	if (ret)
> > +		goto delete_blocked_domain;
> > +
> > +	return 0;
> > +
> > +delete_blocked_domain:
> > +	hv_delete_device_domain(&hv_blocking_domain);
> > +delete_identity_domain:
> > +	hv_delete_device_domain(&hv_identity_domain);
> > +	return ret;
> > +}
> > +
> > +/* x86 architectural MSI address range */
> > +#define INTERRUPT_RANGE_START	(0xfee00000)
> > +#define INTERRUPT_RANGE_END	(0xfeefffff)
> 
> These same constants are also defined in the Intel and AMD
> IOMMU drivers. Bonus points for creating a common definition
> in a .h file that can be shared by all the drivers. :-)
>  
> > +static void hv_iommu_get_resv_regions(struct device *dev,
> > +		struct list_head *head)
> > +{
> > +	struct iommu_resv_region *region;
> > +
> > +	region = iommu_alloc_resv_region(INTERRUPT_RANGE_START,
> > +				      INTERRUPT_RANGE_END - INTERRUPT_RANGE_START + 1,
> > +				      0, IOMMU_RESV_MSI, GFP_KERNEL);
> > +	if (!region)
> > +		return;
> > +
> > +	list_add_tail(&region->list, head);
> > +}
> > +
> > +static void hv_iommu_flush_iotlb_all(struct iommu_domain *domain)
> > +{
> > +	hv_flush_device_domain(to_hv_iommu_domain(domain));
> > +}
> > +
> > +static void hv_iommu_iotlb_sync(struct iommu_domain *domain,
> > +				struct iommu_iotlb_gather *iotlb_gather)
> > +{
> > +	hv_flush_device_domain(to_hv_iommu_domain(domain));
> > +
> > +	iommu_put_pages_list(&iotlb_gather->freelist);
> > +}
> > +
> > +static void hv_iommu_paging_domain_free(struct iommu_domain *domain)
> > +{
> > +	struct hv_iommu_domain *hv_domain = to_hv_iommu_domain(domain);
> > +
> > +	/* Free all remaining mappings */
> > +	pt_iommu_deinit(&hv_domain->pt_iommu);
> > +
> > +	hv_delete_device_domain(hv_domain);
> > +
> > +	kfree(hv_domain);
> > +}
> > +
> > +static const struct iommu_domain_ops hv_iommu_identity_domain_ops = {
> > +	.attach_dev	= hv_iommu_attach_dev,
> > +};
> > +
> > +static const struct iommu_domain_ops hv_iommu_blocking_domain_ops = {
> > +	.attach_dev	= hv_iommu_blocking_attach_dev,
> > +};
> > +
> > +static const struct iommu_domain_ops hv_iommu_paging_domain_ops = {
> > +	.attach_dev	= hv_iommu_attach_dev,
> > +	IOMMU_PT_DOMAIN_OPS(x86_64),
> > +	.flush_iotlb_all = hv_iommu_flush_iotlb_all,
> > +	.iotlb_sync = hv_iommu_iotlb_sync,
> > +	.free = hv_iommu_paging_domain_free,
> > +};
> > +
> > +static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
> > +{
> > +	int ret;
> > +	struct hv_iommu_domain *hv_domain;
> > +	struct pt_iommu_x86_64_cfg cfg = {};
> > +
> > +	hv_domain = kzalloc_obj(*hv_domain, GFP_KERNEL);
> > +	if (!hv_domain)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	ret = hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
> > +	if (ret)
> > +		goto err_free;
> > +
> > +	hv_domain->pt_iommu.nid = dev_to_node(dev);
> > +
> > +	cfg.common.hw_max_vasz_lg2 = hv_iommu_device->max_iova_width;
> > +	cfg.common.hw_max_oasz_lg2 = 52;
> > +	cfg.top_level = (hv_iommu_device->max_iova_width > 48) ? 4 : 3;
> > +
> > +	ret = pt_iommu_x86_64_init(&hv_domain->pt_iommu_x86_64, &cfg, GFP_KERNEL);
> > +	if (ret)
> > +		goto err_delete_domain;
> > +
> > +	/* Constrain to page sizes the hypervisor supports */
> > +	hv_domain->domain.pgsize_bitmap &= hv_iommu_device->pgsize_bitmap;
> > +
> > +	hv_domain->domain.ops = &hv_iommu_paging_domain_ops;
> > +
> > +	ret = hv_configure_device_domain(hv_domain, __IOMMU_DOMAIN_PAGING);
> > +	if (ret)
> > +		goto err_pt_deinit;
> > +
> > +	return &hv_domain->domain;
> > +
> > +err_pt_deinit:
> > +	pt_iommu_deinit(&hv_domain->pt_iommu);
> > +err_delete_domain:
> > +	hv_delete_device_domain(hv_domain);
> > +err_free:
> > +	kfree(hv_domain);
> > +	return ERR_PTR(ret);
> > +}
> > +
> > +static struct iommu_ops hv_iommu_ops = {
> > +	.capable		  = hv_iommu_capable,
> > +	.domain_alloc_paging	  = hv_iommu_domain_alloc_paging,
> > +	.probe_device		  = hv_iommu_probe_device,
> > +	.release_device		  = hv_iommu_release_device,
> > +	.device_group		  = hv_iommu_device_group,
> > +	.get_resv_regions	  = hv_iommu_get_resv_regions,
> > +	.owner			  = THIS_MODULE,
> > +	.identity_domain	  = &hv_identity_domain.domain,
> > +	.blocked_domain		  = &hv_blocking_domain.domain,
> > +	.release_domain		  = &hv_blocking_domain.domain,
> > +};
> > +
> > +static int hv_iommu_detect(struct hv_output_get_iommu_capabilities *hv_iommu_cap)
> > +{
> > +	u64 status;
> > +	unsigned long flags;
> > +	struct hv_input_get_iommu_capabilities *input;
> > +	struct hv_output_get_iommu_capabilities *output;
> > +
> > +	local_irq_save(flags);
> > +
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	output = (struct hv_output_get_iommu_capabilities *)(input + 1);
> > +	memset(input, 0, sizeof(*input));
> > +	input->partition_id = HV_PARTITION_ID_SELF;
> > +	status = hv_do_hypercall(HVCALL_GET_IOMMU_CAPABILITIES, input, output);
> > +	*hv_iommu_cap = *output;
> > +
> > +	local_irq_restore(flags);
> > +
> > +	if (!hv_result_success(status))
> > +		pr_err("HVCALL_GET_IOMMU_CAPABILITIES failed, status %lld\n", status);
> > +
> > +	return hv_result_to_errno(status);
> > +}
> > +
> > +static void __init hv_init_iommu_device(struct hv_iommu_dev *hv_iommu,
> > +			struct hv_output_get_iommu_capabilities *hv_iommu_cap)
> > +{
> > +	ida_init(&hv_iommu->domain_ids);
> > +
> > +	hv_iommu->cap = hv_iommu_cap->iommu_cap;
> > +	hv_iommu->max_iova_width = hv_iommu_cap->max_iova_width;
> > +	if (!hv_iommu_5lvl_supported(hv_iommu->cap) &&
> > +	    hv_iommu->max_iova_width > 48) {
> > +		pr_info("5-level paging not supported, limiting iova width to 48.\n");
> > +		hv_iommu->max_iova_width = 48;
> > +	}
> > +
> > +	hv_iommu->geometry = (struct iommu_domain_geometry) {
> > +		.aperture_start = 0,
> > +		.aperture_end = (((u64)1) << hv_iommu->max_iova_width) - 1,
> > +		.force_aperture = true,
> > +	};
> > +
> > +	hv_iommu->first_domain = HV_DEVICE_DOMAIN_ID_DEFAULT + 1;
> > +	hv_iommu->last_domain = HV_DEVICE_DOMAIN_ID_NULL - 1;
> > +	hv_iommu->pgsize_bitmap = hv_iommu_cap->pgsize_bitmap;
> > +	hv_iommu_device = hv_iommu;
> > +}
> > +
> > +int __init hv_iommu_init(void)
> > +{
> > +	int ret = 0;
> > +	struct hv_iommu_dev *hv_iommu = NULL;
> > +	struct hv_output_get_iommu_capabilities hv_iommu_cap = {0};
> > +
> > +	if (no_iommu || iommu_detected)
> > +		return -ENODEV;
> > +
> > +	if (!hv_is_hyperv_initialized())
> > +		return -ENODEV;
> > +
> > +	ret = hv_iommu_detect(&hv_iommu_cap);
> > +	if (ret) {
> > +		pr_err("HVCALL_GET_IOMMU_CAPABILITIES failed: %d\n", ret);
> 
> hv_iommu_detect() already outputs an error message in the failure case.
> 
> > +		return -ENODEV;
> > +	}
> > +
> > +	if (!hv_iommu_present(hv_iommu_cap.iommu_cap) ||
> > +	    !hv_iommu_s1_domain_supported(hv_iommu_cap.iommu_cap)) {
> > +		pr_err("IOMMU capabilities not sufficient: cap=0x%llx\n",
> > +		       hv_iommu_cap.iommu_cap);
> > +		return -ENODEV;
> > +	}
> > +
> > +	/*
> > +	 * The page table code only maps x86 page sizes (4K/2M/1G); require the
> > +	 * hypervisor to advertise a non-empty subset of exactly those.
> > +	 */
> > +	if (!hv_iommu_cap.pgsize_bitmap ||
> > +	    (hv_iommu_cap.pgsize_bitmap & ~(u64)(SZ_4K | SZ_2M | SZ_1G))) {
> > +		pr_err("unsupported page sizes: pgsize_bitmap=0x%llx\n",
> > +		       hv_iommu_cap.pgsize_bitmap);
> > +		return -ENODEV;
> > +	}
> > +
> > +	iommu_detected = 1;
> > +	pci_request_acs();
> > +
> > +	hv_iommu = kzalloc_obj(*hv_iommu, GFP_KERNEL);
> > +	if (!hv_iommu)
> > +		return -ENOMEM;
> > +
> > +	hv_init_iommu_device(hv_iommu, &hv_iommu_cap);
> > +
> > +	ret = hv_initialize_static_domains();
> > +	if (ret) {
> > +		pr_err("static domains init failed: %d\n", ret);
> > +		goto err_free;
> > +	}
> > +
> > +	ret = iommu_device_sysfs_add(&hv_iommu->iommu, NULL, NULL, "%s", "hv-iommu");
> > +	if (ret) {
> > +		pr_err("iommu_device_sysfs_add failed: %d\n", ret);
> > +		goto err_delete_static_domains;
> > +	}
> > +
> > +	ret = iommu_device_register(&hv_iommu->iommu, &hv_iommu_ops, NULL);
> > +	if (ret) {
> > +		pr_err("iommu_device_register failed: %d\n", ret);
> > +		goto err_sysfs_remove;
> > +	}
> > +
> > +	pr_info("successfully initialized\n");
> > +	return 0;
> > +
> > +err_sysfs_remove:
> > +	iommu_device_sysfs_remove(&hv_iommu->iommu);
> > +err_delete_static_domains:
> > +	hv_delete_device_domain(&hv_blocking_domain);
> > +	hv_delete_device_domain(&hv_identity_domain);
> > +err_free:
> > +	kfree(hv_iommu);
> > +	return ret;
> > +}
> > diff --git a/drivers/iommu/hyperv/iommu.h b/drivers/iommu/hyperv/iommu.h
> > new file mode 100644
> > index 000000000000..3a9f40fa2403
> > --- /dev/null
> > +++ b/drivers/iommu/hyperv/iommu.h
> > @@ -0,0 +1,51 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * Hyper-V IOMMU driver.
> > + *
> > + * Copyright (C) 2024-2025, Microsoft, Inc.
> > + *
> > + */
> > +
> > +#ifndef _HYPERV_IOMMU_H
> > +#define _HYPERV_IOMMU_H
> > +
> > +struct hv_iommu_dev {
> > +	struct iommu_device iommu;
> > +	struct ida domain_ids;
> > +
> > +	/* Device configuration */
> > +	u8  max_iova_width;
> > +	u8  max_pasid_width;
> > +	u64 cap;
> > +	u64 pgsize_bitmap;
> > +
> > +	struct iommu_domain_geometry geometry;
> > +	u64 first_domain;
> > +	u64 last_domain;
> > +};
> > +
> > +struct hv_iommu_domain {
> > +	union {
> > +		struct iommu_domain    domain;
> > +		struct pt_iommu        pt_iommu;
> > +		struct pt_iommu_x86_64 pt_iommu_x86_64;
> > +	};
> > +	struct hv_iommu_dev *hv_iommu;
> > +	struct hv_input_device_domain device_domain;
> > +	u64		pgsize_bitmap;
> > +};
> > +
> > +PT_IOMMU_CHECK_DOMAIN(struct hv_iommu_domain, pt_iommu, domain);
> > +PT_IOMMU_CHECK_DOMAIN(struct hv_iommu_domain, pt_iommu_x86_64.iommu, domain);
> > +
> > +struct hv_iommu_endpoint {
> > +	struct device *dev;
> > +	struct hv_iommu_dev *hv_iommu;
> > +	struct hv_iommu_domain *hv_domain;
> > +};
> > +
> > +#define to_hv_iommu_domain(d) \
> > +	container_of(d, struct hv_iommu_domain, domain)
> > +
> > +#endif /* _HYPERV_IOMMU_H */
> > --
> > 2.52.0
> > 
> 

