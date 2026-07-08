Return-Path: <linux-hyperv+bounces-11872-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YRDiJTJMTmp3KQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11872-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 15:10:10 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A129726A1B
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 15:10:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b="Sy7F/cjK";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11872-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11872-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EB433016C0F
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jul 2026 13:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A7A26F289;
	Wed,  8 Jul 2026 13:09:00 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2855D25524C;
	Wed,  8 Jul 2026 13:08:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516140; cv=none; b=YuHFfQH4NPjGrEHVe6T4Pl2W5qKDz4YU4SZiRUynKcniDhTmwKZJ5gwgo9S2DJF/EfQ7XKzzY2aGHnGB56iAJcBaYBFVYbTaTNg7vNbatGodLt9jsaMEH9t7s1jUiWraACgj9bm5f6uGipOrA5bDrE2rblvrN8oejxxr2jgtX9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516140; c=relaxed/simple;
	bh=nWlM7nDs+Ehx5fhLbXpm/09fzp4EvEITzuNKLHJxYb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvM8k9D6ZHTxanqvalpzcpnSc0t4h/GHyZM90RC4qp6i6JF0B4wqUA19JTyLoI4I8IqtMvhZof5oBi+Nvc5hrm01LZcWIOHxXPjdZMsQ+Si45vMEyPFT2fO2LKV40RL8piKQA8n8qEg+1eaWodFrUxlmCzJm4md9WvSOP/Ub08A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Sy7F/cjK; arc=none smtp.client-ip=13.77.154.182
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id D10D120B7166;
	Wed,  8 Jul 2026 06:08:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D10D120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783516133;
	bh=/hSmkr+dIyafyncKqTXRAo+CdjfIAF4DNB/jk9lnxO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sy7F/cjKk+upbwjLploWfMegU+27nNSPh9IWPQ6muPe1H9SH5JTa2pAKz0Bt117Mk
	 Lc4jqwuyz3jeY+s1frCVhzBitrxEnBrbHfEJiEou0nwXBU7ykvbK34FKUUePGTrBXt
	 Ting0Wwv5me2QZume4tavc7rEFxGOpOPz799+nz0=
Date: Wed, 8 Jul 2026 21:08:55 +0800
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
Message-ID: <u2l4lz5skybcukrb6hwp2u6v3jdibrugokxmclgv3uq4ljj3vw@x7mlfvuwb5f4>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-3-zhangyu1@linux.microsoft.com>
 <SN6PR02MB415798534DFCC14E5202D021D4FF2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB415798534DFCC14E5202D021D4FF2@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mhklinux@outlook.com,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pci@vger.kernel.org,m:linux-arch@vger.kernel.org,m:wei.liu@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:lpieralisi@kernel.org,m:mani@kernel.org,m:robh@kernel.org,m:arnd@arndb.de,m:jgg@ziepe.ca,m:jacob.pan@linux.microsoft.com,m:tgopinath@linux.microsoft.com,m:easwar.hariharan@linux.microsoft.com,m:mrathor@linux.microsoft.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11872-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A129726A1B

On Wed, Jul 08, 2026 at 02:52:43AM +0000, Michael Kelley wrote:
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Thursday, July 2, 2026 9:05 AM
> > 
> > From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > 
> > Hyper-V identifies each PCI pass-thru device by a logical device ID in
> > its hypercall interface. This ID consists of a per-bus prefix, derived
> > from the VMBus device instance GUID, combined with the PCI function
> > number of the endpoint device.
> > 
> > Add a small registry in hv_common.c that maps a PCI domain number to its
> > logical device ID prefix. The vPCI bus driver (pci-hyperv) registers the
> > prefix when a bus is probed and unregisters it when the bus is removed.
> > Consumers such as the para-virtualized IOMMU driver look up the prefix
> > by PCI domain number and combine it with the function number to form the
> > complete logical device ID for hypercalls.
> > 
> > The prefix construction is shared via hv_build_logical_dev_id_prefix() so
> > that pci-hyperv's interrupt retargeting path and the registry use exactly
> > the same byte layout. It is derived on demand from the constant hv_device
> > instance GUID rather than cached in struct hv_pcibus_device, which is
> > private to the pci-hyperv module; this keeps the interface narrow and
> > avoids depending on pci-hyperv internals.
> > 
> > Co-developed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> > Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> > Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > ---
> >  drivers/hv/hv_common.c              | 95 +++++++++++++++++++++++++++++
> >  drivers/pci/controller/pci-hyperv.c | 21 +++++--
> >  include/asm-generic/mshyperv.h      | 13 ++++
> >  include/linux/hyperv.h              |  8 +++
> >  4 files changed, 132 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > index 6b67ac616789..53493f8d14dc 100644
> > --- a/drivers/hv/hv_common.c
> > +++ b/drivers/hv/hv_common.c
> > @@ -26,6 +26,8 @@
> >  #include <linux/kmsg_dump.h>
> >  #include <linux/sizes.h>
> >  #include <linux/slab.h>
> > +#include <linux/list.h>
> > +#include <linux/spinlock.h>
> >  #include <linux/dma-map-ops.h>
> >  #include <linux/set_memory.h>
> >  #include <hyperv/hvhdk.h>
> > @@ -863,3 +865,96 @@ const char *hv_result_to_string(u64 status)
> >  	return "Unknown";
> >  }
> >  EXPORT_SYMBOL_GPL(hv_result_to_string);
> > +
> > +#ifdef CONFIG_HYPERV_PVIOMMU
> > +/*
> > + * Logical device ID registry shared between the vPCI bus driver
> > + * (pci-hyperv) and the para-virtualized IOMMU driver. The vPCI driver
> > + * registers the per-bus logical device ID prefix at bus probe time, and
> > + * the pvIOMMU driver looks it up to build the full logical device ID used
> > + * in IOMMU hypercalls.
> > + */
> > +struct hv_pci_busdata {
> > +	int		 pci_domain_nr;
> > +	u32		 logical_dev_id_prefix;
> > +	struct list_head list;
> > +};
> > +
> > +static LIST_HEAD(hv_pci_bus_list);
> > +static DEFINE_SPINLOCK(hv_pci_bus_lock);
> > +
> > +int hv_iommu_register_pci_bus(int pci_domain_nr, u32 logical_dev_id_prefix)
> > +{
> > +	struct hv_pci_busdata *bus, *new;
> > +	int ret = 0;
> > +
> > +	new = kzalloc_obj(*new, GFP_KERNEL);
> > +	if (!new)
> > +		return -ENOMEM;
> > +
> > +	spin_lock(&hv_pci_bus_lock);
> > +	list_for_each_entry(bus, &hv_pci_bus_list, list) {
> > +		if (bus->pci_domain_nr != pci_domain_nr)
> > +			continue;
> > +
> > +		if (bus->logical_dev_id_prefix != logical_dev_id_prefix) {
> > +			pr_err("stale registration for PCI domain %d (old prefix 0x%08x, new 0x%08x)\n",
> > +			       pci_domain_nr, bus->logical_dev_id_prefix,
> > +			       logical_dev_id_prefix);
> > +			ret = -EEXIST;
> > +		}
> > +
> > +		goto out_free;
> > +	}
> > +
> > +	new->pci_domain_nr = pci_domain_nr;
> > +	new->logical_dev_id_prefix = logical_dev_id_prefix;
> > +	list_add(&new->list, &hv_pci_bus_list);
> > +	spin_unlock(&hv_pci_bus_lock);
> > +	return 0;
> > +
> > +out_free:
> > +	spin_unlock(&hv_pci_bus_lock);
> > +	kfree(new);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_FOR_MODULES(hv_iommu_register_pci_bus, "pci-hyperv");
> > +
> > +void hv_iommu_unregister_pci_bus(int pci_domain_nr)
> > +{
> > +	struct hv_pci_busdata *bus, *tmp;
> > +
> > +	spin_lock(&hv_pci_bus_lock);
> > +	list_for_each_entry_safe(bus, tmp, &hv_pci_bus_list, list) {
> > +		if (bus->pci_domain_nr == pci_domain_nr) {
> > +			list_del(&bus->list);
> > +			kfree(bus);
> > +			break;
> > +		}
> > +	}
> > +	spin_unlock(&hv_pci_bus_lock);
> > +}
> > +EXPORT_SYMBOL_FOR_MODULES(hv_iommu_unregister_pci_bus, "pci-hyperv");
> > +
> > +/*
> > + * Look up the logical device ID prefix registered for @pci_domain_nr.
> > + * Returns 0 on success with *prefix filled in; -ENODEV if no entry is
> > + * registered for that PCI domain.
> > + */
> > +int hv_iommu_lookup_logical_dev_id(int pci_domain_nr, u32 *prefix)
> > +{
> > +	struct hv_pci_busdata *bus;
> > +	int ret = -ENODEV;
> > +
> > +	spin_lock(&hv_pci_bus_lock);
> > +	list_for_each_entry(bus, &hv_pci_bus_list, list) {
> > +		if (bus->pci_domain_nr == pci_domain_nr) {
> > +			*prefix = bus->logical_dev_id_prefix;
> > +			ret = 0;
> > +			break;
> > +		}
> > +	}
> > +	spin_unlock(&hv_pci_bus_lock);
> > +	return ret;
> > +}
> 
> I started thinking about the mechanism here because it's somewhat
> annoying that it takes 77 lines of code (sans comments) to manage
> this simple little mapping. I also started thinking about how many entries
> are likely to be in the mapping. A guest VM probably has fewer than 10
> entries unless it has multiple NICs and maybe some GPUs. But this code
> is also intended to be used by the Linux-as-root code, and I'm thinking
> that the number of PCI devices managed by the root could easily be a
> hundred or more if the root is managing a couple dozen VMs on a large
> physical server. Searching a linked list with 100 or more entries could be
> a bit slow.
> 
> If only the guest scenario were needed, you could declare a static
> array with 64 entries (64 is an arbitrary upper bound), and just search
> through the array instead of having to allocate memory, deal with
> allocation failures, and deal with linked lists. But a fixed size array
> would need to be much bigger for the root scenario, and you would
> still be doing a linear search.
> 
> A better alternative to consider is rhashtable, which is an existing
> Linux kernel facility. Based on what an AI bot generated for me, the
> code for setting up and using rhashtable is straightforward, and
> would probably result in far fewer than 77 lines of code. Lookups
> would also be faster than a linear search, at least for the root case
> with more than just a few entries. I'd suggest looking at rhashtable
> to see whether you like how the resulting code comes out for this
> use case, and whether it really is simpler than a roll-your-own linked
> list.
> 

Thank you so much for thinking this through, Michael! That is really
a valid concern.

How about using XArray? It might be more lightweight compared with
rhashtable. Using pci_domain_nr as the key and prefix as the value.
Maybe sth. like:
                                                                                                                                                        ┃
	static DEFINE_XARRAY(hv_pci_bus_xa);

	int hv_iommu_register_pci_bus(int domain_nr, u32 prefix)
	{
		return xa_insert(&hv_pci_bus_xa, domain_nr,
				xa_mk_value(prefix), GFP_KERNEL);
	}                                                                                                                                                ┃

	void hv_iommu_unregister_pci_bus(int domain_nr)
	{
		xa_erase(&hv_pci_bus_xa, domain_nr);
	}

	int hv_iommu_lookup_logical_dev_id(int domain_nr, u32 *prefix)
	{
		void *entry = xa_load(&hv_pci_bus_xa, domain_nr);
		if (!entry)                                                                                                                                  ┃
			return -ENODEV;
		*prefix = xa_to_value(entry);
		return 0;                                                                                                                                    ┃
	}

B.R.
Yu
	                                                                                                                                                 
                                                                                                                                                        ┃
> Michael
> 
> > +#endif /* CONFIG_HYPERV_PVIOMMU */
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index cfc8fa403dad..58ca2c95bd10 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -641,10 +641,7 @@ static void hv_irq_retarget_interrupt(struct irq_data *data)
> >  	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
> >  	params->int_entry.msi_entry.address.as_uint32 = int_desc->address & 0xffffffff;
> >  	params->int_entry.msi_entry.data.as_uint32 = int_desc->data;
> > -	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
> > -			   (hbus->hdev->dev_instance.b[4] << 16) |
> > -			   (hbus->hdev->dev_instance.b[7] << 8) |
> > -			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
> > +	params->device_id = hv_build_logical_dev_id_prefix(hbus->hdev) |
> >  			   PCI_FUNC(pdev->devfn);
> >  	params->int_target.vector = hv_msi_get_int_vector(data);
> > 
> > @@ -3715,6 +3712,7 @@ static int hv_pci_probe(struct hv_device *hdev,
> >  	struct hv_pcibus_device *hbus;
> >  	int ret, dom;
> >  	u16 dom_req;
> > +	u32 prefix;
> >  	char *name;
> > 
> >  	bridge = devm_pci_alloc_host_bridge(&hdev->device, 0);
> > @@ -3857,13 +3855,22 @@ static int hv_pci_probe(struct hv_device *hdev,
> > 
> >  	hbus->state = hv_pcibus_probed;
> > 
> > -	ret = create_root_hv_pci_bus(hbus);
> > +	/* Notify pvIOMMU before any device on the bus is scanned. */
> > +	prefix = hv_build_logical_dev_id_prefix(hdev);
> > +
> > +	ret = hv_iommu_register_pci_bus(dom, prefix);
> >  	if (ret)
> >  		goto free_windows;
> > 
> > +	ret = create_root_hv_pci_bus(hbus);
> > +	if (ret)
> > +		goto unregister_pviommu;
> > +
> >  	mutex_unlock(&hbus->state_lock);
> >  	return 0;
> > 
> > +unregister_pviommu:
> > +	hv_iommu_unregister_pci_bus(dom);
> >  free_windows:
> >  	hv_pci_free_bridge_windows(hbus);
> >  exit_d0:
> > @@ -3977,6 +3984,8 @@ static void hv_pci_remove(struct hv_device *hdev)
> > 
> >  	hbus = hv_get_drvdata(hdev);
> >  	if (hbus->state == hv_pcibus_installed) {
> > +		int dom = hbus->bridge->domain_nr;
> > +
> >  		tasklet_disable(&hdev->channel->callback_event);
> >  		hbus->state = hv_pcibus_removing;
> >  		tasklet_enable(&hdev->channel->callback_event);
> > @@ -3994,6 +4003,8 @@ static void hv_pci_remove(struct hv_device *hdev)
> >  		hv_pci_remove_slots(hbus);
> >  		pci_remove_root_bus(hbus->bridge->bus);
> >  		pci_unlock_rescan_remove();
> > +
> > +		hv_iommu_unregister_pci_bus(dom);
> >  	}
> > 
> >  	hv_pci_bus_exit(hdev, false);
> > diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> > index bf601d67cecb..f65344f2bb81 100644
> > --- a/include/asm-generic/mshyperv.h
> > +++ b/include/asm-generic/mshyperv.h
> > @@ -73,6 +73,19 @@ extern enum hv_partition_type hv_curr_partition_type;
> >  extern void * __percpu *hyperv_pcpu_input_arg;
> >  extern void * __percpu *hyperv_pcpu_output_arg;
> > 
> > +#ifdef CONFIG_HYPERV_PVIOMMU
> > +int  hv_iommu_register_pci_bus(int pci_domain_nr, u32 logical_dev_id_prefix);
> > +void hv_iommu_unregister_pci_bus(int pci_domain_nr);
> > +int  hv_iommu_lookup_logical_dev_id(int pci_domain_nr, u32 *prefix);
> > +#else
> > +static inline int hv_iommu_register_pci_bus(int pci_domain_nr,
> > +					    u32 logical_dev_id_prefix)
> > +{
> > +	return 0;
> > +}
> > +static inline void hv_iommu_unregister_pci_bus(int pci_domain_nr) { }
> > +#endif
> > +
> >  u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
> >  u64 hv_do_fast_hypercall8(u16 control, u64 input8);
> >  u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
> > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> > index 9de2c8d6037a..10ee2c462d7c 100644
> > --- a/include/linux/hyperv.h
> > +++ b/include/linux/hyperv.h
> > @@ -1287,6 +1287,14 @@ struct hv_device {
> >  #define device_to_hv_device(d)	container_of_const(d, struct hv_device, device)
> >  #define drv_to_hv_drv(d)	container_of_const(d, struct hv_driver, driver)
> > 
> > +static inline u32 hv_build_logical_dev_id_prefix(struct hv_device *hdev)
> > +{
> > +	return ((u32)hdev->dev_instance.b[5] << 24) |
> > +	       ((u32)hdev->dev_instance.b[4] << 16) |
> > +	       ((u32)hdev->dev_instance.b[7] << 8) |
> > +	       (hdev->dev_instance.b[6] & 0xf8u);
> > +}
> > +
> >  static inline void hv_set_drvdata(struct hv_device *dev, void *data)
> >  {
> >  	dev_set_drvdata(&dev->device, data);
> > --
> > 2.52.0
> > 
> 

