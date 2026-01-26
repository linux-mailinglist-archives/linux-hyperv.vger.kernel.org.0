Return-Path: <linux-hyperv+bounces-8529-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OQHNoLTd2mFlwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8529-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 21:50:10 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 391438D48B
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 21:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99020301BEC7
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 20:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D262D8396;
	Mon, 26 Jan 2026 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="K74TQNGc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42A528643A;
	Mon, 26 Jan 2026 20:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460607; cv=none; b=UFlMe9LS2otAzx8t2rkklyhLh46v22ffwgZfJy7+D2IrRHiyLW89IzptC6dTWUGBGdPu0ug3WrahHGPX52xtNKkkb+lU3wD4GyKK15dcUp7uOZqKlYb576zdnju0Mi6F6W/SR0nz5CEhbQNXDSGewTTcoP0s6A3D44ORqHqNfl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460607; c=relaxed/simple;
	bh=S1uSk3BD8ULucBF3SDqkazr75drJ3at/HYBKxGFswEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1LNzBy4+3dlQQe6/TEDuW1gARWB+KM1zOzjiDqDHXfJmq4Z4NNCi9+rDtPmOaG1c1dwSP8EJQlbFOiXO9YfXgRYgoC2motd3TSNA0QbGaE6Zh2yXg7nA/yJOUSieWMuZ8FrPLJZNXRF5qeI6yTNEgsz5bxcpYSYGxt8q3vOG9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=K74TQNGc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id E3D6220B716E;
	Mon, 26 Jan 2026 12:50:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E3D6220B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769460605;
	bh=aMPla4QrmCDTRq11ONPUsMeTtcU4Ek4C0hGQgcBMl74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K74TQNGczFpAfhA3gfdl31xMldWM2jUiuWpBExIFe8FFA6T5VENcXMxblu6H+Fd5J
	 q31ZsLv/+62nFidQMGJr5Cq+fCxyk5SPvvE1q3mXtZMAVywKuoK9pr5vk4Vvdey2oC
	 u17S0GoZNJ5mz+dz8ev/+3idfQ7uW/nxPVpCrXyE=
Date: Mon, 26 Jan 2026 12:50:03 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, catalin.marinas@arm.com,
	will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	nunodasneves@linux.microsoft.com, mhklinux@outlook.com,
	romank@linux.microsoft.com
Subject: Re: [PATCH v0 10/15] PCI: hv: Build device id for a VMBus device
Message-ID: <aXfTezmeX52VWFx6@skinsburskii.localdomain>
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-11-mrathor@linux.microsoft.com>
 <aXAAH4G9ztAGDWuy@skinsburskii.localdomain>
 <a2e54fff-3cbb-e332-c35e-7520c36eceed@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2e54fff-3cbb-e332-c35e-7520c36eceed@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8529-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,linux.microsoft.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 391438D48B
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 04:42:54PM -0800, Mukesh R wrote:
> On 1/20/26 14:22, Stanislav Kinsburskii wrote:
> > On Mon, Jan 19, 2026 at 10:42:25PM -0800, Mukesh R wrote:
> > > From: Mukesh Rathor <mrathor@linux.microsoft.com>
> > > 
> > > On Hyper-V, most hypercalls related to PCI passthru to map/unmap regions,
> > > interrupts, etc need a device id as a parameter. This device id refers
> > > to that specific device during the lifetime of passthru.
> > > 
> > > An L1VH VM only contains VMBus based devices. A device id for a VMBus
> > > device is slightly different in that it uses the hv_pcibus_device info
> > > for building it to make sure it matches exactly what the hypervisor
> > > expects. This VMBus based device id is needed when attaching devices in
> > > an L1VH based guest VM. Before building it, a check is done to make sure
> > > the device is a valid VMBus device.
> > > 
> > > Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> > > ---
> > >   arch/x86/include/asm/mshyperv.h     |  2 ++
> > >   drivers/pci/controller/pci-hyperv.c | 29 +++++++++++++++++++++++++++++
> > >   2 files changed, 31 insertions(+)
> > > 
> > > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > > index eef4c3a5ba28..0d7fdfb25e76 100644
> > > --- a/arch/x86/include/asm/mshyperv.h
> > > +++ b/arch/x86/include/asm/mshyperv.h
> > > @@ -188,6 +188,8 @@ bool hv_vcpu_is_preempted(int vcpu);
> > >   static inline void hv_apic_init(void) {}
> > >   #endif
> > > +u64 hv_pci_vmbus_device_id(struct pci_dev *pdev);
> > > +
> > >   struct irq_domain *hv_create_pci_msi_domain(void);
> > >   int hv_map_msi_interrupt(struct irq_data *data,
> > > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > > index 8bc6a38c9b5a..40f0b06bb966 100644
> > > --- a/drivers/pci/controller/pci-hyperv.c
> > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > @@ -579,6 +579,8 @@ static void hv_pci_onchannelcallback(void *context);
> > >   #define DELIVERY_MODE		APIC_DELIVERY_MODE_FIXED
> > >   #define HV_MSI_CHIP_FLAGS	MSI_CHIP_FLAG_SET_ACK
> > > +static bool hv_vmbus_pci_device(struct pci_bus *pbus);
> > > +
> > 
> > Why not moving this static function definition above the called instead of
> > defining the prototype?
> 
> Did you see the function implementation? It has other dependencies that
> are later, it would need code reorg.
> 

Why not placing the caller side after the function definition then?

Thanks,
Stanislav

> Thanks,
> -Mukesh
> 
> 
> > >   static int hv_pci_irqchip_init(void)
> > >   {
> > >   	return 0;
> > > @@ -598,6 +600,26 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
> > >   #define hv_msi_prepare		pci_msi_prepare
> > > +u64 hv_pci_vmbus_device_id(struct pci_dev *pdev)
> > > +{
> > > +	u64 u64val;
> > 
> > This variable is redundant.
> 
> Not really. It helps with debug by putting a quick print, and is
> harmless.
> 
> > > +	struct hv_pcibus_device *hbus;
> > > +	struct pci_bus *pbus = pdev->bus;
> > > +
> > > +	if (!hv_vmbus_pci_device(pbus))
> > > +		return 0;
> > > +
> > > +	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
> > > +	u64val = (hbus->hdev->dev_instance.b[5] << 24) |
> > > +		 (hbus->hdev->dev_instance.b[4] << 16) |
> > > +		 (hbus->hdev->dev_instance.b[7] << 8) |
> > > +		 (hbus->hdev->dev_instance.b[6] & 0xf8) |
> > > +		 PCI_FUNC(pdev->devfn);
> > > +
> > 
> > It looks like this value always fits into 32 bit, so what is the value
> > in returning 64 bit?
> 
> The ABI has device id defined as 64bits where this is assigned.
> 
> Thanks,
> -Mukesh
> 
> 
> 
> 
> > Thanks,
> > Stanislav
> > 
> > > +	return u64val;
> > > +}
> > > +EXPORT_SYMBOL_GPL(hv_pci_vmbus_device_id);
> > > +
> > >   /**
> > >    * hv_irq_retarget_interrupt() - "Unmask" the IRQ by setting its current
> > >    * affinity.
> > > @@ -1404,6 +1426,13 @@ static struct pci_ops hv_pcifront_ops = {
> > >   	.write = hv_pcifront_write_config,
> > >   };
> > > +#ifdef CONFIG_X86
> > > +static bool hv_vmbus_pci_device(struct pci_bus *pbus)
> > > +{
> > > +	return pbus->ops == &hv_pcifront_ops;
> > > +}
> > > +#endif /* CONFIG_X86 */
> > > +
> > >   /*
> > >    * Paravirtual backchannel
> > >    *
> > > -- 
> > > 2.51.2.vfs.0.1
> > > 

