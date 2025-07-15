Return-Path: <linux-hyperv+bounces-6262-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89160B06684
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jul 2025 21:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BF44A5331
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jul 2025 19:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D1323CEF8;
	Tue, 15 Jul 2025 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bBLKI3gy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478211DE4E1;
	Tue, 15 Jul 2025 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606576; cv=none; b=hrAMiyqMFnPnCOdBDRhdWVkN/TFzEYFWhWsjz58A6SY/1Pi1Zn8XpQJqakdAoJdDSfN4ScwW5qd8gS8lHM3k8+VuHASVOy4eaEnF/eJT0+NY7AtftKtHs1nMk4B2MZRR2ACV7+IZVygOI3Nk9/lecKaBPmh1oUQYKxtz+puXxsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606576; c=relaxed/simple;
	bh=M6P0ZCZUomVAUXBv9ibACi6SjPDJDs3jNr7RMSZSYn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kC6sJc50WpHoHTjIlyTslXAzeQgCYtlw355vQCxbVSIL71/ge5A3TS6oKNAay8zRrHkwFRzpBU+QD/afZa4Xn29XPLwtMTp219h7kxY2ftXSNDuqY2eXxFU1MG9ffJFrUgPizhURmmxnk1QKDPowPAQJontEtJyszp2iF0m78Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bBLKI3gy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.161.177] (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 731D5211CE05;
	Tue, 15 Jul 2025 12:09:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 731D5211CE05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752606574;
	bh=TuXXERNoR3AQLAY/nmVnkcRURtLITB5v5fIQvwqsRtY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bBLKI3gyca40TZbHdNsIO/zDAK4nRWXbvFjWsa7OWTmzSz1nrGGNgt2tFPdEKeKe4
	 mP4TY9RzJDg1jYZZ8N3D193cemsnBkYWF644PpvmytFK0ohMIdAS+OZIXX7f0yn3Vl
	 LQ6dYFVi7aFFGSSgSelji4l8xQJPALtALb8hV6Fo=
Message-ID: <c145aebb-4deb-4f1e-95aa-2ba13bf0c453@linux.microsoft.com>
Date: Tue, 15 Jul 2025 12:09:33 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] x86/hyperv: Switch to
 msi_create_parent_irq_domain()
To: Wei Liu <wei.liu@kernel.org>, Nam Cao <namcao@linutronix.de>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>, Marc Zyngier <maz@kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1751277765.git.namcao@linutronix.de>
 <5c0ada725449176dfeeb1f7aa98c324066c39d2c.1751277765.git.namcao@linutronix.de>
 <aG7932u1SvvAYh2l@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <aG7932u1SvvAYh2l@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/2025 4:40 PM, Wei Liu wrote:
> CC Nuno who is also touching on this file.
> 
> Nam, thanks for this patch. 
> 
> Nuno's patches fix a few bugs with the current implementation. I expect
> those patches to have contextual conflicts with this patch. I would like
> to commit Nuno's patches first since those are bug fixes, and then
> circle back to this one.
> 
> Nuno, can you please review this patch?
> 

I don't think I can give a Reviewed-by since I don't have the context
for these changes.

It doesn't look like this conflicts with the changes in my patches.

The TODO looks fine to me, it can be addressed in a followup.

Nuno

> On Mon, Jun 30, 2025 at 12:26:15PM +0200, Nam Cao wrote:
>> Move away from the legacy MSI domain setup, switch to use
>> msi_create_parent_irq_domain().
>>
>> While doing the conversion, I noticed that hv_irq_compose_msi_msg() is
>> doing more than it is supposed to (composing message content). The
>> interrupt allocation bits should be moved into hv_msi_domain_alloc().
>> However, I have no hardware to test this change, therefore I leave a TODO
>> note.
>>
>> Signed-off-by: Nam Cao <namcao@linutronix.de>
>> ---
>>  arch/x86/hyperv/irqdomain.c | 111 ++++++++++++++++++++++++------------
>>  drivers/hv/Kconfig          |   1 +
>>  2 files changed, 77 insertions(+), 35 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
>> index 31f0d29cbc5e3..9b3b65ffbd2e2 100644
>> --- a/arch/x86/hyperv/irqdomain.c
>> +++ b/arch/x86/hyperv/irqdomain.c
>> @@ -10,6 +10,7 @@
>>  
>>  #include <linux/pci.h>
>>  #include <linux/irq.h>
>> +#include <linux/irqchip/irq-msi-lib.h>
>>  #include <asm/mshyperv.h>
>>  
>>  static int hv_map_interrupt(union hv_device_id device_id, bool level,
>> @@ -276,59 +277,99 @@ static void hv_teardown_msi_irq(struct pci_dev *dev, struct irq_data *irqd)
>>  		hv_status_err(status, "\n");
>>  }
>>  
>> -static void hv_msi_free_irq(struct irq_domain *domain,
>> -			    struct msi_domain_info *info, unsigned int virq)
>> -{
>> -	struct irq_data *irqd = irq_get_irq_data(virq);
>> -	struct msi_desc *desc;
>> -
>> -	if (!irqd)
>> -		return;
>> -
>> -	desc = irq_data_get_msi_desc(irqd);
>> -	if (!desc || !desc->irq || WARN_ON_ONCE(!dev_is_pci(desc->dev)))
>> -		return;
>> -
>> -	hv_teardown_msi_irq(to_pci_dev(desc->dev), irqd);
>> -}
>> -
>>  /*
>>   * IRQ Chip for MSI PCI/PCI-X/PCI-Express Devices,
>>   * which implement the MSI or MSI-X Capability Structure.
>>   */
>>  static struct irq_chip hv_pci_msi_controller = {
>>  	.name			= "HV-PCI-MSI",
>> -	.irq_unmask		= pci_msi_unmask_irq,
>> -	.irq_mask		= pci_msi_mask_irq,
>>  	.irq_ack		= irq_chip_ack_parent,
>> -	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>>  	.irq_compose_msi_msg	= hv_irq_compose_msi_msg,
>> -	.irq_set_affinity	= msi_domain_set_affinity,
>> -	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED,
>> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
>>  };
>>  
>> -static struct msi_domain_ops pci_msi_domain_ops = {
>> -	.msi_free		= hv_msi_free_irq,
>> -	.msi_prepare		= pci_msi_prepare,
>> +static bool hv_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
>> +				 struct irq_domain *real_parent, struct msi_domain_info *info)
>> +{
>> +	struct irq_chip *chip = info->chip;
>> +
>> +	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
>> +		return false;
>> +
>> +	chip->flags |= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED;
>> +
>> +	info->ops->msi_prepare = pci_msi_prepare;
>> +
>> +	return true;
>> +}
>> +
>> +#define HV_MSI_FLAGS_SUPPORTED	(MSI_GENERIC_FLAGS_MASK | MSI_FLAG_PCI_MSIX)
>> +#define HV_MSI_FLAGS_REQUIRED	(MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS)
>> +
>> +static struct msi_parent_ops hv_msi_parent_ops = {
>> +	.supported_flags	= HV_MSI_FLAGS_SUPPORTED,
>> +	.required_flags		= HV_MSI_FLAGS_REQUIRED,
>> +	.bus_select_token	= DOMAIN_BUS_NEXUS,
>> +	.bus_select_mask	= MATCH_PCI_MSI,
>> +	.chip_flags		= MSI_CHIP_FLAG_SET_ACK,
>> +	.prefix			= "HV-",
>> +	.init_dev_msi_info	= hv_init_dev_msi_info,
>>  };
>>  
>> -static struct msi_domain_info hv_pci_msi_domain_info = {
>> -	.flags		= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>> -			  MSI_FLAG_PCI_MSIX,
>> -	.ops		= &pci_msi_domain_ops,
>> -	.chip		= &hv_pci_msi_controller,
>> -	.handler	= handle_edge_irq,
>> -	.handler_name	= "edge",
>> +static int hv_msi_domain_alloc(struct irq_domain *d, unsigned int virq, unsigned int nr_irqs,
>> +			       void *arg)
>> +{
>> +	/*
>> +	 * TODO: The allocation bits of hv_irq_compose_msi_msg(), i.e. everything except
>> +	 * entry_to_msi_msg() should be in here.
>> +	 */
>> +
>> +	int ret;
>> +
>> +	ret = irq_domain_alloc_irqs_parent(d, virq, nr_irqs, arg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	for (int i = 0; i < nr_irqs; ++i) {
>> +		irq_domain_set_info(d, virq + i, 0, &hv_pci_msi_controller, NULL,
>> +				    handle_edge_irq, NULL, "edge");
>> +	}
>> +	return 0;
>> +}
>> +
>> +static void hv_msi_domain_free(struct irq_domain *d, unsigned int virq, unsigned int nr_irqs)
>> +{
>> +	for (int i = 0; i < nr_irqs; ++i) {
>> +		struct irq_data *irqd = irq_domain_get_irq_data(d, virq);
>> +		struct msi_desc *desc;
>> +
>> +		desc = irq_data_get_msi_desc(irqd);
>> +		if (!desc || !desc->irq || WARN_ON_ONCE(!dev_is_pci(desc->dev)))
>> +			continue;
>> +
>> +		hv_teardown_msi_irq(to_pci_dev(desc->dev), irqd);
>> +	}
>> +	irq_domain_free_irqs_top(d, virq, nr_irqs);
>> +}
>> +
>> +static const struct irq_domain_ops hv_msi_domain_ops = {
>> +	.select	= msi_lib_irq_domain_select,
>> +	.alloc	= hv_msi_domain_alloc,
>> +	.free	= hv_msi_domain_free,
>>  };
>>  
>>  struct irq_domain * __init hv_create_pci_msi_domain(void)
>>  {
>>  	struct irq_domain *d = NULL;
>> -	struct fwnode_handle *fn;
>>  
>> -	fn = irq_domain_alloc_named_fwnode("HV-PCI-MSI");
>> -	if (fn)
>> -		d = pci_msi_create_irq_domain(fn, &hv_pci_msi_domain_info, x86_vector_domain);
>> +	struct irq_domain_info info = {
>> +		.fwnode		= irq_domain_alloc_named_fwnode("HV-PCI-MSI"),
>> +		.ops		= &hv_msi_domain_ops,
>> +		.parent		= x86_vector_domain,
>> +	};
>> +
>> +	if (info.fwnode)
>> +		d = msi_create_parent_irq_domain(&info, &hv_msi_parent_ops);
>>  
>>  	/* No point in going further if we can't get an irq domain */
>>  	BUG_ON(!d);
>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>> index 1cd188b73b743..e62a0f8b34198 100644
>> --- a/drivers/hv/Kconfig
>> +++ b/drivers/hv/Kconfig
>> @@ -10,6 +10,7 @@ config HYPERV
>>  	select X86_HV_CALLBACK_VECTOR if X86
>>  	select OF_EARLY_FLATTREE if OF
>>  	select SYSFB if !HYPERV_VTL_MODE
>> +	select IRQ_MSI_LIB if X86
>>  	help
>>  	  Select this option to run Linux as a Hyper-V client operating
>>  	  system.
>> -- 
>> 2.39.5
>>


