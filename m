Return-Path: <linux-hyperv+bounces-8393-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIOkOlEQcGlyUwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8393-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 00:31:29 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 667CC4DD40
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 00:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6043092F0E3
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jan 2026 22:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F135547885F;
	Tue, 20 Jan 2026 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PkpTcPTf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791513A963D;
	Tue, 20 Jan 2026 22:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768947754; cv=none; b=cMuQDSlaAAvmeuAVFCQr4o2paMiMU0nxgzxtB+KKbez3fZQrHVGuW3TBzOno8WSsGQoOImDEpB3rv00CNBnMpQxRCDDTqnkdgZFSfPpeyD+aGbVcFjGcjfDa8ERxZ9e+RkQvQ6q+OO32fLdtVgPziCNyKZe8HdCbk1vGosJvFRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768947754; c=relaxed/simple;
	bh=htXjwpFtcDg+v9hwmnUT6qXYW6yM4CRiceblTLKew14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PD8TEnE1JV2czVNhpf17oLknpC88n+BrZBDCVaxmGFjgvf/Xncz52+fc3VFp52iMex/Q776UI13Eoy0q4m5oRs7hAfSZPWnCc6MtrtnxYge8DkwobNlDrOXrGXyUpbyyDgrGKN94r/ai0krB5swJFXMM32wQygVep5k/SCgkdCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PkpTcPTf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7158020B7167;
	Tue, 20 Jan 2026 14:22:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7158020B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768947746;
	bh=DgpDHdkXL8du6/waUPCQ2FM+4J0zYPPlgMRTfOScZAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PkpTcPTfH/iUgRsGJW27bcRYfbSMcq5SIpRYQnGpoQkvhXq3wyWCT8osAPxfv80B1
	 tZNtFf7u6QrzimyHJJQu4RPWL7sqH6VIE5nIXHlNMtuGMOyxuDIZ2Vo0MShmeIoSFP
	 3HgEFTvfD8Z81hOA1OC3kCiguMMOqPtyb7zrmNik=
Date: Tue, 20 Jan 2026 14:22:23 -0800
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
Message-ID: <aXAAH4G9ztAGDWuy@skinsburskii.localdomain>
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-11-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120064230.3602565-11-mrathor@linux.microsoft.com>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,linux.microsoft.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-8393-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.microsoft.com,none];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.microsoft.com:dkim,skinsburskii.localdomain:mid]
X-Rspamd-Queue-Id: 667CC4DD40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 10:42:25PM -0800, Mukesh R wrote:
> From: Mukesh Rathor <mrathor@linux.microsoft.com>
> 
> On Hyper-V, most hypercalls related to PCI passthru to map/unmap regions,
> interrupts, etc need a device id as a parameter. This device id refers
> to that specific device during the lifetime of passthru.
> 
> An L1VH VM only contains VMBus based devices. A device id for a VMBus
> device is slightly different in that it uses the hv_pcibus_device info
> for building it to make sure it matches exactly what the hypervisor
> expects. This VMBus based device id is needed when attaching devices in
> an L1VH based guest VM. Before building it, a check is done to make sure
> the device is a valid VMBus device.
> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
>  arch/x86/include/asm/mshyperv.h     |  2 ++
>  drivers/pci/controller/pci-hyperv.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index eef4c3a5ba28..0d7fdfb25e76 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -188,6 +188,8 @@ bool hv_vcpu_is_preempted(int vcpu);
>  static inline void hv_apic_init(void) {}
>  #endif
>  
> +u64 hv_pci_vmbus_device_id(struct pci_dev *pdev);
> +
>  struct irq_domain *hv_create_pci_msi_domain(void);
>  
>  int hv_map_msi_interrupt(struct irq_data *data,
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 8bc6a38c9b5a..40f0b06bb966 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -579,6 +579,8 @@ static void hv_pci_onchannelcallback(void *context);
>  #define DELIVERY_MODE		APIC_DELIVERY_MODE_FIXED
>  #define HV_MSI_CHIP_FLAGS	MSI_CHIP_FLAG_SET_ACK
>  
> +static bool hv_vmbus_pci_device(struct pci_bus *pbus);
> +

Why not moving this static function definition above the called instead of
defining the prototype?

>  static int hv_pci_irqchip_init(void)
>  {
>  	return 0;
> @@ -598,6 +600,26 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
>  
>  #define hv_msi_prepare		pci_msi_prepare
>  
> +u64 hv_pci_vmbus_device_id(struct pci_dev *pdev)
> +{
> +	u64 u64val;

This variable is redundant.

> +	struct hv_pcibus_device *hbus;
> +	struct pci_bus *pbus = pdev->bus;
> +
> +	if (!hv_vmbus_pci_device(pbus))
> +		return 0;
> +
> +	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
> +	u64val = (hbus->hdev->dev_instance.b[5] << 24) |
> +		 (hbus->hdev->dev_instance.b[4] << 16) |
> +		 (hbus->hdev->dev_instance.b[7] << 8) |
> +		 (hbus->hdev->dev_instance.b[6] & 0xf8) |
> +		 PCI_FUNC(pdev->devfn);
> +

It looks like this value always fits into 32 bit, so what is the value
in returning 64 bit?

Thanks,
Stanislav

> +	return u64val;
> +}
> +EXPORT_SYMBOL_GPL(hv_pci_vmbus_device_id);
> +
>  /**
>   * hv_irq_retarget_interrupt() - "Unmask" the IRQ by setting its current
>   * affinity.
> @@ -1404,6 +1426,13 @@ static struct pci_ops hv_pcifront_ops = {
>  	.write = hv_pcifront_write_config,
>  };
>  
> +#ifdef CONFIG_X86
> +static bool hv_vmbus_pci_device(struct pci_bus *pbus)
> +{
> +	return pbus->ops == &hv_pcifront_ops;
> +}
> +#endif /* CONFIG_X86 */
> +
>  /*
>   * Paravirtual backchannel
>   *
> -- 
> 2.51.2.vfs.0.1
> 

