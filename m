Return-Path: <linux-hyperv+bounces-10840-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ9/KqebBGr3LwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10840-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 17:41:27 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AE753653E
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 17:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2F3A31CB0B7
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 15:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D00288C2C;
	Wed, 13 May 2026 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="D4YxqIZp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FF043CEEF;
	Wed, 13 May 2026 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685448; cv=none; b=oYZUTJMPMawg+m5aFsPU4iLDBU3xxezIuT7z7ijMhZ1gIpAql/w08PaY/LkLM64L+95MFE5+lzwil6xSZ71VK49/qhqRrCmj8LgvcrmuBShYlMjV7rIQtSsD+3QXNgak92Xdc3/8G3uZsq7d1hHRzaBsAPx2uKnJaNhW3kWvaMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685448; c=relaxed/simple;
	bh=tY9ISkh+nnLDO6OGB8+yrgnNLLQICyw/IV1SGILZbYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFRZib2aE+5YItk07ZrqCl4qLn/yUzmtl6vgFnkaxNIjtR7GXR8d98pbt1X2oOGyIWyKz88CI0CqXE8953OoamtmgbKVZ5lPcjloL0DqeIiOdC59MvAb9MJfIv8q5wH5hdXaRmDNoqRrwSOkGWBOBbR+stb+Qkt7pPyJ9+eNR+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=D4YxqIZp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 88B8D20B7166; Wed, 13 May 2026 08:17:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88B8D20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778685444;
	bh=5XoM16CEZZE8M5BaxgKJXAh20v7TUVYYdgK20TKPEhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4YxqIZpbq2XAdD+wfF0R3t/Y0ELxE3A6QI/uL8o0lyq0Q98fejUJ7I/8DDIoD/KF
	 XEjs+Q2KDipKSU0rrUriah/+B+0fXJmNgQvqS5UHCgrMvoQ0GPB6k6ZtFTB9ghyMrD
	 HpGTqVusaeX2gTlvVieL/fFLvul6aMu65H6TQ+ag=
Date: Wed, 13 May 2026 08:17:24 -0700
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
	wei.liu@kernel.org, mhklinux@outlook.com, muislam@microsoft.com,
	namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH V3 08/11] PCI: hv: VMBus and PCI device IDs for PCI
 passthru
Message-ID: <agSWBJFQreXDuF3u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
 <20260512020259.1678627-9-mrathor@linux.microsoft.com>
 <agST9ZRXNWhbUGMY@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agST9ZRXNWhbUGMY@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Rspamd-Queue-Id: 11AE753653E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10840-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zytor.com,arm.com,kernel.org,outlook.com,microsoft.com,linux.microsoft.com,vger.kernel.org,lists.linux.dev,redhat.com,alien8.de,linux.intel.com,8bytes.org,google.com,arndb.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schakrabarti@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 08:08:37AM -0700, Souradeep Chakrabarti wrote:
> On Mon, May 11, 2026 at 07:02:56PM -0700, Mukesh R wrote:
> > On Hyper-V, most hypercalls related to PCI passthru to map/unmap regions,
> > interrupts, etc need a device ID as a parameter. This device ID refers
> > to that specific device during the lifetime of passthru.
> > 
> > An L1VH VM only contains VMBus based devices. A device ID for a VMBus
> > device is slightly different in that it uses the hv_pcibus_device info
> > for building it to make sure it matches exactly what the hypervisor
> > expects. This VMBus based device ID is needed when attaching devices in
> > an L1VH based guest VM. Add a function to build and export it. Before
> > building it, a check is done to make sure the device is a valid VMBus
> > device.
> > 
> > In remaining cases, PCI device ID is used. So, also make PCI device ID
> > build function hv_build_devid_type_pci() public.
> >
Reviewed-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Reviewed-by: Souradeep Chakrabarti <schakrabarti@microsoft.com>
> > Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> > ---
> >  arch/x86/hyperv/irqdomain.c         |  9 +++++----
> >  arch/x86/include/asm/mshyperv.h     |  6 ++++++
> >  drivers/pci/controller/pci-hyperv.c | 24 ++++++++++++++++++++++++
> >  include/asm-generic/mshyperv.h      | 11 +++++++++++
> >  4 files changed, 46 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> > index b3ad50a874dc..8780573a4332 100644
> > --- a/arch/x86/hyperv/irqdomain.c
> > +++ b/arch/x86/hyperv/irqdomain.c
> > @@ -112,7 +112,7 @@ static int get_rid_cb(struct pci_dev *pdev, u16 alias, void *data)
> >  	return 0;
> >  }
> >  
> > -static union hv_device_id hv_build_devid_type_pci(struct pci_dev *pdev)
> > +u64 hv_build_devid_type_pci(struct pci_dev *pdev)
> >  {
> >  	int pos;
> >  	union hv_device_id hv_devid;
> > @@ -172,8 +172,9 @@ static union hv_device_id hv_build_devid_type_pci(struct pci_dev *pdev)
> >  	}
> >  
> >  out:
> > -	return hv_devid;
> > +	return hv_devid.as_uint64;
> >  }
> > +EXPORT_SYMBOL_GPL(hv_build_devid_type_pci);
> >  
> >  /*
> >   * hv_map_msi_interrupt() - Map the MSI IRQ in the hypervisor.
> > @@ -196,7 +197,7 @@ int hv_map_msi_interrupt(struct irq_data *data,
> >  
> >  	msidesc = irq_data_get_msi_desc(data);
> >  	pdev = msi_desc_to_pci_dev(msidesc);
> > -	hv_devid = hv_build_devid_type_pci(pdev);
> > +	hv_devid.as_uint64 = hv_build_devid_type_pci(pdev);
> >  	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
> >  
> >  	return hv_map_interrupt(hv_devid, false, cpu, cfg->vector,
> > @@ -271,7 +272,7 @@ static int hv_unmap_msi_interrupt(struct pci_dev *pdev,
> >  {
> >  	union hv_device_id hv_devid;
> >  
> > -	hv_devid = hv_build_devid_type_pci(pdev);
> > +	hv_devid.as_uint64 = hv_build_devid_type_pci(pdev);
> >  	return hv_unmap_interrupt(hv_devid.as_uint64, irq_entry);
> >  }
> >  
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > index f64393e853ee..2ef34001f8d3 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -248,6 +248,12 @@ void hv_crash_asm_end(void);
> >  static inline void hv_root_crash_init(void) {}
> >  #endif  /* CONFIG_MSHV_ROOT && CONFIG_CRASH_DUMP */
> >  
> > +#if IS_ENABLED(CONFIG_HYPERV_IOMMU)
> > +u64 hv_build_devid_type_pci(struct pci_dev *pdev);
> > +#else
> > +static inline u64 hv_build_devid_type_pci(struct pci_dev *pdev) { return 0; }
> > +#endif /* IS_ENABLED(CONFIG_HYPERV_IOMMU) */
> > +
> >  #else /* CONFIG_HYPERV */
> >  static inline void hyperv_init(void) {}
> >  static inline void hyperv_setup_mmu_ops(void) {}
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index cfc8fa403dad..50d793ca8f31 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -573,6 +573,7 @@ struct hv_pci_compl {
> >  };
> >  
> >  static void hv_pci_onchannelcallback(void *context);
> > +static bool hv_vmbus_pci_device(struct pci_bus *pbus);
> >  
> >  #ifdef CONFIG_X86
> >  #define DELIVERY_MODE		APIC_DELIVERY_MODE_FIXED
> > @@ -1005,6 +1006,24 @@ static struct irq_domain *hv_pci_get_root_domain(void)
> >  static void hv_arch_irq_unmask(struct irq_data *data) { }
> >  #endif /* CONFIG_ARM64 */
> >  
> > +u64 hv_pci_vmbus_device_id(struct pci_dev *pdev)
> > +{
> > +	struct hv_pcibus_device *hbus;
> > +	struct pci_bus *pbus = pdev->bus;
> > +
> > +	if (!hv_vmbus_pci_device(pbus))
> > +		return 0;
> > +
> > +	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
> > +
> > +	return	(hbus->hdev->dev_instance.b[5] << 24) |
> > +		(hbus->hdev->dev_instance.b[4] << 16) |
> > +		(hbus->hdev->dev_instance.b[7] << 8) |
> > +		(hbus->hdev->dev_instance.b[6] & 0xf8) |
> > +		PCI_FUNC(pdev->devfn);
> > +}
> > +EXPORT_SYMBOL_GPL(hv_pci_vmbus_device_id);
> > +
> >  /**
> >   * hv_pci_generic_compl() - Invoked for a completion packet
> >   * @context:		Set up by the sender of the packet.
> > @@ -1403,6 +1422,11 @@ static struct pci_ops hv_pcifront_ops = {
> >  	.write = hv_pcifront_write_config,
> >  };
> >  
> > +static bool hv_vmbus_pci_device(struct pci_bus *pbus)
> > +{
> > +	return pbus->ops == &hv_pcifront_ops;
> > +}
> > +
> >  /*
> >   * Paravirtual backchannel
> >   *
> > diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> > index e8cbc4e3f7ad..25ac7ca0fd8b 100644
> > --- a/include/asm-generic/mshyperv.h
> > +++ b/include/asm-generic/mshyperv.h
> > @@ -204,6 +204,9 @@ extern u64 (*hv_read_reference_counter)(void);
> >  /* Sentinel value for an uninitialized entry in hv_vp_index array */
> >  #define VP_INVAL	U32_MAX
> >  
> > +/* Forward declarations */
> > +struct pci_dev;
> > +
> >  int __init hv_common_init(void);
> >  void __init hv_get_partition_id(void);
> >  void __init hv_common_free(void);
> > @@ -316,6 +319,14 @@ void hv_para_set_synic_register(unsigned int reg, u64 val);
> >  void hyperv_cleanup(void);
> >  bool hv_query_ext_cap(u64 cap_query);
> >  void hv_setup_dma_ops(struct device *dev, bool coherent);
> > +
> > +#if IS_ENABLED(CONFIG_PCI_HYPERV)
> > +u64 hv_pci_vmbus_device_id(struct pci_dev *pdev);
> > +#else
> > +static inline u64 hv_pci_vmbus_device_id(struct pci_dev *pdev)
> > +{ return 0; }
> > +#endif /* IS_ENABLED(CONFIG_PCI_HYPERV) */
> > +
> >  #else /* CONFIG_HYPERV */
> >  static inline void hv_identify_partition_type(void) {}
> >  static inline bool hv_is_hyperv_initialized(void) { return false; }
> > -- 
> > 2.51.2.vfs.0.1
> > 

