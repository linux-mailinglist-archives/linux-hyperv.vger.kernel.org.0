Return-Path: <linux-hyperv+bounces-10912-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPcDKr0YB2rNrgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10912-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 14:59:41 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5985500FD
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 14:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ABB430A33C0
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 12:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EC044D01C;
	Fri, 15 May 2026 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WS/Zdg8A"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A60038F95A;
	Fri, 15 May 2026 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848713; cv=none; b=CqYKsJ+kr954R9yCe7tD2wNW4y8M30Uq+NVOQ+Rh3he5HxGUKwqhdb0vw63htS8A3x2cUhEBxt8sbD2eckfzmdc9m54ItUm8FhMVrjIVOrnxIGsijaZCiNjY6q7+iyf0Q4A+2dhO8RkP+JzTrmlVSYw7ksp0dxfjsiKVsVwrXOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848713; c=relaxed/simple;
	bh=QkyGtymRwTBhyCo+ftYaceSh3xAwbb+WqGHKEO0jwkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZxjpuSDs27GTEpvKau1D773GslNvqWCGgPI1aYTZMl06zl8KvJdDk3cb46xFfOwAZmPFafdiUrpEnss89300CvmEejNsatSzz2/mo9MyvvYCCF2nNtraxUbYva+yxLGtIw0bdPxzCfA9NxuKjztWC5lWeRfxcjU/WpGVS7eeFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WS/Zdg8A; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [167.220.233.27])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5F50920B7166;
	Fri, 15 May 2026 05:38:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5F50920B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778848707;
	bh=1OXr0xlN0CYrNFpGl0atHJ7aaaV0aDo3N3oIZvGVagY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WS/Zdg8AIi53513pxUnOp+s9InaN9MqXm8Ct+gGszuzww7WhyOeKAYEzmZFH5C4LC
	 N4WtvrNmTKru+L4Wvy3/mrpRLUIzp7SXf695evqMQzpXzI0vKmUPA9CTnkBUTlDJm0
	 b1d2IH7XXgyxFJYnqOG7QsvllXFywc14HtOV6AzY=
Date: Fri, 15 May 2026 20:38:29 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, 
	wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, 
	longli@microsoft.com, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org, mani@kernel.org, 
	robh@kernel.org, arnd@arndb.de, jgg@ziepe.ca, mhklinux@outlook.com, 
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH v1 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <af2mt3eqnadczs2u2psmsdevjhshsl3v6vamtnde2c44mjealc@3yon3hsi7idi>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-4-zhangyu1@linux.microsoft.com>
 <20260513113952.00005b20@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513113952.00005b20@linux.microsoft.com>
X-Rspamd-Queue-Id: 0D5985500FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10912-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,microsoft.com,8bytes.org,arm.com,google.com,arndb.de,ziepe.ca,outlook.com,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

[...]
> > diff --git a/drivers/iommu/hyperv/Kconfig
> > b/drivers/iommu/hyperv/Kconfig index 30f40d867036..9e658d5c9a77 100644
> > --- a/drivers/iommu/hyperv/Kconfig
> > +++ b/drivers/iommu/hyperv/Kconfig
> > @@ -8,3 +8,20 @@ config HYPERV_IOMMU
> >  	help
> >  	  Stub IOMMU driver to handle IRQs to support Hyper-V Linux
> >  	  guest and root partitions.
> > +
> > +if HYPERV_IOMMU
> > +config HYPERV_PVIOMMU
> > +	bool "Microsoft Hypervisor para-virtualized IOMMU support"
> > +	depends on X86 && HYPERV
> > +	select IOMMU_API
> > +	select GENERIC_PT
> > +	select IOMMU_PT
> > +	select IOMMU_PT_X86_64
> nit:
> If HYPERV_PVIOMMU is enabled on a (hypothetical) platform with
> GENERIC_ATOMIC64=y, the select would force-enable IOMMU_PT_X86_64 even
> though its depends on is unsatisfied — leading to a build failure.
> 
> In practice this can't happen today because HYPERV_PVIOMMU already
> depends on X86 && HYPERV, and x86 never sets GENERIC_ATOMIC64. But
> adding the explicit guard is more defensive.
> i.e.
>        depends on !GENERIC_ATOMIC64    # for cmpxchg64 in IOMMU_PT
> 

Good point. Will add "depends on !GENERIC_ATOMIC64".

[...]

> > +
> > +/*
> > + * Look up the logical device ID for a vPCI device. Returns 0 on
> > success
> > + * with *logical_id filled in; -ENODEV if no entry registered for
> > this
> > + * device's vPCI bus.
> > + */
> > +static int hv_iommu_lookup_logical_dev_id(struct pci_dev *pdev, u64
> > *logical_id) +{
> > +	struct hv_pci_busdata *bus;
> > +	int domain = pci_domain_nr(pdev->bus);
> > +	int ret = -ENODEV;
> > +
> > +	spin_lock(&hv_iommu_pci_bus_lock);
> this is called under local_irq_save, should use  raw_spinlock_t for RT
> kernel?
> 

Yes, this is problematic on PREEMPT_RT. Michael also suggested hoisting
the lookup before the local_irq_save() section instead of using a raw
spinlock, which I think is a great idea - all 3 call sites (detach_dev,
attach_dev, get_logical_device_property) will be changed.

> > +	list_for_each_entry(bus, &hv_iommu_pci_bus_list, list) {
> > +		if (bus->pci_domain_nr == domain) {
> > +			*logical_id =
> > (u64)bus->logical_dev_id_prefix |
> > +				      PCI_FUNC(pdev->devfn);
> > +			ret = 0;
> > +			break;
> > +		}
> > +	}
> > +	spin_unlock(&hv_iommu_pci_bus_lock);
> > +	return ret;
> > +}
> > +

[...]

> > +static void hv_iommu_release_device(struct device *dev)
> > +{
> > +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +
> > +	if (pdev->ats_enabled)
> > +		pci_disable_ats(pdev);
> > +
> > +	dev_iommu_priv_set(dev, NULL);
> > +	set_dma_ops(dev, NULL);
> I don't think this is necessary.
> 

Oh, yes. Thanks!

> > +
> > +	kfree(vdev);
> > +}
> > +
> > +static struct iommu_group *hv_iommu_device_group(struct device *dev)
> > +{
> > +	if (dev_is_pci(dev))
> > +		return pci_device_group(dev);
> > +	else
> > +		return generic_device_group(dev);
> non pci device already rejected during attach, maybe we should warn
> here?
>         WARN_ON_ONCE(1);
>         return generic_device_group(dev);
> 

Good idea. Will add WARN_ON_ONCE(1).

> > +}
> > +
> > +static int hv_configure_device_domain(struct hv_iommu_domain
> > *hv_domain, u32 domain_type) +{
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
> > +	input->settings.flags.blocked = (domain_type ==
> > IOMMU_DOMAIN_BLOCKED);
> > +	input->settings.flags.translation_enabled = (domain_type !=
> > IOMMU_DOMAIN_IDENTITY); +
> Should this be:
> input->settings.flags.translation_enabled =
>      (domain_type & __IOMMU_DOMAIN_PAGING);
> Otherwise, blocked domain will have translation enabled. Maybe add some
> explanation of what HV expects.
> 
I do agree this is not intuitive, but current hypervisor implementation
requires "blocked == 1" to be paired with "translation_enabled = 1",
otherwise it returns HV_STATUS_INVALID_PARAMETER. But I can add some
comment at least.

Thanks for the thorough review, Jacob!

B.R.
Yu



