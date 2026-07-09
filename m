Return-Path: <linux-hyperv+bounces-11882-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zXB2EYGJT2pxjAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11882-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Jul 2026 13:44:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BE673086E
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Jul 2026 13:44:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=hovpNZ3T;
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11882-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11882-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 887B431088AE
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jul 2026 11:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C73041CB48;
	Thu,  9 Jul 2026 11:33:51 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C78141B37F;
	Thu,  9 Jul 2026 11:33:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596830; cv=none; b=VmYftbZuqx/g+0Yz/k/UXSY55T2LQUt+uwVfu2hrsKpU9xJ5C4BkMQk7488CEgAGISI9P9LW3YoaqoWsn+fRez72EnxIlLcmAnUTDFwsoQ+KSR2+f2BwUzdOEVqyUg/RZdXcZUFsoFa6bNK9qR896EYU9muX9IGR4VfQZAuESrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596830; c=relaxed/simple;
	bh=K0THlXNwZqipz/KEI06FjAdUeSpg5s7LDONtQ2Zte8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3Of4dP9I/Akf5phD5Z5OgdQCrc3odfuk4wDVOHz02BSvv8k6XYtKkFOG5H5bw31MAUFu16bOjfnb+bRjoYpYcPypj2/pXTOMSboGVQiTAjZnU1oQ5LA+3/HRkj4kK22CVIEMh1v3SWZRKZgQRxFJWd9ud3HMMPnzHz6wmIGKuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hovpNZ3T; arc=none smtp.client-ip=13.77.154.182
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4A43420B716B;
	Thu,  9 Jul 2026 04:33:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4A43420B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783596818;
	bh=LJd/+GU+PpP/Ium6hNk30csI0fmCJwtgCwZHUVsgKho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hovpNZ3TPhHx/HgG/98cgurUwIpqSkztqwDe0evKW+PVJY8k7FqGSIMz2PlREZPEW
	 5FRx12WtVtyS1Sjp6ozdvLGdCLoGIMag2WiCU2x6FgNo6nsSQ7VensjxunuGYb+i+H
	 undDj7/2n65it5yFFcbnKT4Asefw6BMab67xV/Nk=
Date: Thu, 9 Jul 2026 19:33:41 +0800
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
Subject: Re: [PATCH v2 2/4] Drivers: hv: Add logical device ID registry for
 vPCI devices
Message-ID: <ja2drof5i7xjhpj4vbpavnphtn6cx4y5d3337vjrofxr47gxtq@msvg6xpbkb2h>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-3-zhangyu1@linux.microsoft.com>
 <SN6PR02MB415798534DFCC14E5202D021D4FF2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <u2l4lz5skybcukrb6hwp2u6v3jdibrugokxmclgv3uq4ljj3vw@x7mlfvuwb5f4>
 <BN7PR02MB4148C8DB748CFD863B97D1B7D4FF2@BN7PR02MB4148.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN7PR02MB4148C8DB748CFD863B97D1B7D4FF2@BN7PR02MB4148.namprd02.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mhklinux@outlook.com,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pci@vger.kernel.org,m:linux-arch@vger.kernel.org,m:wei.liu@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:lpieralisi@kernel.org,m:mani@kernel.org,m:robh@kernel.org,m:arnd@arndb.de,m:jgg@ziepe.ca,m:jacob.pan@linux.microsoft.com,m:tgopinath@linux.microsoft.com,m:easwar.hariharan@linux.microsoft.com,m:mrathor@linux.microsoft.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11882-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7BE673086E

On Wed, Jul 08, 2026 at 01:28:42PM +0000, Michael Kelley wrote:
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Wednesday, July 8, 2026 6:09 AM
> > 
> > On Wed, Jul 08, 2026 at 02:52:43AM +0000, Michael Kelley wrote:
> > > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Thursday, July 2, 2026 9:05 AM
> > > >
> > > > From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > > >
> > > > Hyper-V identifies each PCI pass-thru device by a logical device ID in
> > > > its hypercall interface. This ID consists of a per-bus prefix, derived
> > > > from the VMBus device instance GUID, combined with the PCI function
> > > > number of the endpoint device.
> > > >
> > > > Add a small registry in hv_common.c that maps a PCI domain number to its
> > > > logical device ID prefix. The vPCI bus driver (pci-hyperv) registers the
> > > > prefix when a bus is probed and unregisters it when the bus is removed.
> > > > Consumers such as the para-virtualized IOMMU driver look up the prefix
> > > > by PCI domain number and combine it with the function number to form the
> > > > complete logical device ID for hypercalls.
> > > >
> > > > The prefix construction is shared via hv_build_logical_dev_id_prefix() so
> > > > that pci-hyperv's interrupt retargeting path and the registry use exactly
> > > > the same byte layout. It is derived on demand from the constant hv_device
> > > > instance GUID rather than cached in struct hv_pcibus_device, which is
> > > > private to the pci-hyperv module; this keeps the interface narrow and
> > > > avoids depending on pci-hyperv internals.
> > > >
> > > > Co-developed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> > > > Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> > > > Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > > > ---
> > > >  drivers/hv/hv_common.c              | 95 +++++++++++++++++++++++++++++
> > > >  drivers/pci/controller/pci-hyperv.c | 21 +++++--
> > > >  include/asm-generic/mshyperv.h      | 13 ++++
> > > >  include/linux/hyperv.h              |  8 +++
> > > >  4 files changed, 132 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > > > index 6b67ac616789..53493f8d14dc 100644
> > > > --- a/drivers/hv/hv_common.c
> > > > +++ b/drivers/hv/hv_common.c
> > > > @@ -26,6 +26,8 @@
> > > >  #include <linux/kmsg_dump.h>
> > > >  #include <linux/sizes.h>
> > > >  #include <linux/slab.h>
> > > > +#include <linux/list.h>
> > > > +#include <linux/spinlock.h>
> > > >  #include <linux/dma-map-ops.h>
> > > >  #include <linux/set_memory.h>
> > > >  #include <hyperv/hvhdk.h>
> > > > @@ -863,3 +865,96 @@ const char *hv_result_to_string(u64 status)
> > > >  	return "Unknown";
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(hv_result_to_string);
> > > > +
> > > > +#ifdef CONFIG_HYPERV_PVIOMMU
> > > > +/*
> > > > + * Logical device ID registry shared between the vPCI bus driver
> > > > + * (pci-hyperv) and the para-virtualized IOMMU driver. The vPCI driver
> > > > + * registers the per-bus logical device ID prefix at bus probe time, and
> > > > + * the pvIOMMU driver looks it up to build the full logical device ID used
> > > > + * in IOMMU hypercalls.
> > > > + */
> > > > +struct hv_pci_busdata {
> > > > +	int		 pci_domain_nr;
> > > > +	u32		 logical_dev_id_prefix;
> > > > +	struct list_head list;
> > > > +};
> > > > +
> > > > +static LIST_HEAD(hv_pci_bus_list);
> > > > +static DEFINE_SPINLOCK(hv_pci_bus_lock);
> > > > +
> > > > +int hv_iommu_register_pci_bus(int pci_domain_nr, u32 logical_dev_id_prefix)
> > > > +{
> > > > +	struct hv_pci_busdata *bus, *new;
> > > > +	int ret = 0;
> > > > +
> > > > +	new = kzalloc_obj(*new, GFP_KERNEL);
> > > > +	if (!new)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	spin_lock(&hv_pci_bus_lock);
> > > > +	list_for_each_entry(bus, &hv_pci_bus_list, list) {
> > > > +		if (bus->pci_domain_nr != pci_domain_nr)
> > > > +			continue;
> > > > +
> > > > +		if (bus->logical_dev_id_prefix != logical_dev_id_prefix) {
> > > > +			pr_err("stale registration for PCI domain %d (old prefix 0x%08x, new 0x%08x)\n",
> > > > +			       pci_domain_nr, bus->logical_dev_id_prefix,
> > > > +			       logical_dev_id_prefix);
> > > > +			ret = -EEXIST;
> > > > +		}
> > > > +
> > > > +		goto out_free;
> > > > +	}
> > > > +
> > > > +	new->pci_domain_nr = pci_domain_nr;
> > > > +	new->logical_dev_id_prefix = logical_dev_id_prefix;
> > > > +	list_add(&new->list, &hv_pci_bus_list);
> > > > +	spin_unlock(&hv_pci_bus_lock);
> > > > +	return 0;
> > > > +
> > > > +out_free:
> > > > +	spin_unlock(&hv_pci_bus_lock);
> > > > +	kfree(new);
> > > > +	return ret;
> > > > +}
> > > > +EXPORT_SYMBOL_FOR_MODULES(hv_iommu_register_pci_bus, "pci-hyperv");
> > > > +
> > > > +void hv_iommu_unregister_pci_bus(int pci_domain_nr)
> > > > +{
> > > > +	struct hv_pci_busdata *bus, *tmp;
> > > > +
> > > > +	spin_lock(&hv_pci_bus_lock);
> > > > +	list_for_each_entry_safe(bus, tmp, &hv_pci_bus_list, list) {
> > > > +		if (bus->pci_domain_nr == pci_domain_nr) {
> > > > +			list_del(&bus->list);
> > > > +			kfree(bus);
> > > > +			break;
> > > > +		}
> > > > +	}
> > > > +	spin_unlock(&hv_pci_bus_lock);
> > > > +}
> > > > +EXPORT_SYMBOL_FOR_MODULES(hv_iommu_unregister_pci_bus, "pci-hyperv");
> > > > +
> > > > +/*
> > > > + * Look up the logical device ID prefix registered for @pci_domain_nr.
> > > > + * Returns 0 on success with *prefix filled in; -ENODEV if no entry is
> > > > + * registered for that PCI domain.
> > > > + */
> > > > +int hv_iommu_lookup_logical_dev_id(int pci_domain_nr, u32 *prefix)
> > > > +{
> > > > +	struct hv_pci_busdata *bus;
> > > > +	int ret = -ENODEV;
> > > > +
> > > > +	spin_lock(&hv_pci_bus_lock);
> > > > +	list_for_each_entry(bus, &hv_pci_bus_list, list) {
> > > > +		if (bus->pci_domain_nr == pci_domain_nr) {
> > > > +			*prefix = bus->logical_dev_id_prefix;
> > > > +			ret = 0;
> > > > +			break;
> > > > +		}
> > > > +	}
> > > > +	spin_unlock(&hv_pci_bus_lock);
> > > > +	return ret;
> > > > +}
> > >
> > > I started thinking about the mechanism here because it's somewhat
> > > annoying that it takes 77 lines of code (sans comments) to manage
> > > this simple little mapping. I also started thinking about how many entries
> > > are likely to be in the mapping. A guest VM probably has fewer than 10
> > > entries unless it has multiple NICs and maybe some GPUs. But this code
> > > is also intended to be used by the Linux-as-root code, and I'm thinking
> > > that the number of PCI devices managed by the root could easily be a
> > > hundred or more if the root is managing a couple dozen VMs on a large
> > > physical server. Searching a linked list with 100 or more entries could be
> > > a bit slow.
> > >
> > > If only the guest scenario were needed, you could declare a static
> > > array with 64 entries (64 is an arbitrary upper bound), and just search
> > > through the array instead of having to allocate memory, deal with
> > > allocation failures, and deal with linked lists. But a fixed size array
> > > would need to be much bigger for the root scenario, and you would
> > > still be doing a linear search.
> > >
> > > A better alternative to consider is rhashtable, which is an existing
> > > Linux kernel facility. Based on what an AI bot generated for me, the
> > > code for setting up and using rhashtable is straightforward, and
> > > would probably result in far fewer than 77 lines of code. Lookups
> > > would also be faster than a linear search, at least for the root case
> > > with more than just a few entries. I'd suggest looking at rhashtable
> > > to see whether you like how the resulting code comes out for this
> > > use case, and whether it really is simpler than a roll-your-own linked
> > > list.
> > >
> > 
> > Thank you so much for thinking this through, Michael! That is really
> > a valid concern.
> > 
> > How about using XArray? It might be more lightweight compared with
> > rhashtable. Using pci_domain_nr as the key and prefix as the value.
> > Maybe sth. like:
> >                                                                                                                                                         ┃
> > 	static DEFINE_XARRAY(hv_pci_bus_xa);
> > 
> > 	int hv_iommu_register_pci_bus(int domain_nr, u32 prefix)
> > 	{
> > 		return xa_insert(&hv_pci_bus_xa, domain_nr,
> > 				xa_mk_value(prefix), GFP_KERNEL);
> > 	}                                                                                                                                                ┃
> > 
> > 	void hv_iommu_unregister_pci_bus(int domain_nr)
> > 	{
> > 		xa_erase(&hv_pci_bus_xa, domain_nr);
> > 	}
> > 
> > 	int hv_iommu_lookup_logical_dev_id(int domain_nr, u32 *prefix)
> > 	{
> > 		void *entry = xa_load(&hv_pci_bus_xa, domain_nr);
> > 		if (!entry)
> > ┃
> > 			return -ENODEV;
> > 		*prefix = xa_to_value(entry);
> > 		return 0;
> > ┃
> > 	}
> > 
> 
> xarray is best where the keys are dense or mostly dense integers. In
> this use case, the pci_domain_nr keys are essentially random 16-bit
> values, which doesn't fit xarray as well. It would work, but wouldn't
> be very efficient. See the 2nd paragraph of the documentation here:
> 
> https://www.kernel.org/doc/html/latest/core-api/xarray.html#xarray
> 

Thanks for pointing out the documentation. You're right. With sparse
16-bit keys, a hash-based data structure makes more sense than a
radix-based one. I'll try reworking it with rhashtable and let you
know if it doesn't work out.

B.R.
Yu
> Michael

