Return-Path: <linux-hyperv+bounces-8558-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPXWFX0femmv2wEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8558-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 15:38:53 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B543A2EC8
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 15:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F257300106B
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 14:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1BE35B623;
	Wed, 28 Jan 2026 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLgYQaz3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988A0350A14;
	Wed, 28 Jan 2026 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610994; cv=none; b=OxAESKj6ExPuqv8S5LVblWi9rN87B/gPCQNBEJz33P4mUEAk0ROSXLIlBrbukYuO2Z22pZTLVS6tXXZUBlmYndoF1/2v8UYqWD4X+XMVDNt98V5VcpXwHb7oJM31vNKC2KaGMs0X98QhLLQMWOHLi9UnCy+SwJ1nC32B6LP67tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610994; c=relaxed/simple;
	bh=w7RrBBzZIuz8xqrWdZPUre+AvVJylwUW9queAH7gzkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dG258EeYvedlFQQYkhekzd5JjfRxMI1t6+3GcFrwNAIjhp5oVuqv6JlpcS+Ppqk/Sw3n4heSIsDhGVF9GMABmS2bh626I8Z3cr1AA8Q5Of0ls3I/ECPAy9O48ZVCMRnr/JMeFWAwZNTx8hlyepD1UNmh6HE4YNAaS6UfyDJe7eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLgYQaz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DEBC4CEF1;
	Wed, 28 Jan 2026 14:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769610994;
	bh=w7RrBBzZIuz8xqrWdZPUre+AvVJylwUW9queAH7gzkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLgYQaz3hk08B66xJru+tcLyUXLfa2syE5i0+ySVr5hp2pTvBHFoYfN2RUqzL63xr
	 TnXnJYFbFmIqK0F84CfWyeINuD4unEvDN9HxQVQpR/uTo8mtdSMIA6pEe+dNcxk18+
	 GJWNXS6LU16HcUVNJhaTri8i7hdJOaZhFOZIGyFlK0gMlXsenBJFkcC3m/5zQ2SFWZ
	 +B/2/0DdD9Gu9ZhaCDQ83hv55zLYP27Yhesox8Sh5yOEZs5Yoo8RrDJpPH27u9fRnr
	 t222h4hNov3WoLGJ3NJjV9LL8kcHxUjOdj1AeqOS02hJaBhsfWFJNWnVbZiExRrfSs
	 w+hRuUqcOcsYA==
Date: Wed, 28 Jan 2026 20:06:21 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-arch@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, catalin.marinas@arm.com, will@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, joro@8bytes.org, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, arnd@arndb.de, 
	nunodasneves@linux.microsoft.com, mhklinux@outlook.com, romank@linux.microsoft.com
Subject: Re: [PATCH v0 10/15] PCI: hv: Build device id for a VMBus device
Message-ID: <323krpkmg4zmswo567ccah2g7ymprs66nfei3eo6saobl2azda@35jdfloq5g3g>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2e54fff-3cbb-e332-c35e-7520c36eceed@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8558-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.microsoft.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B543A2EC8
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

Such debug print do not exist now. So there is no need of a variable, drop it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

