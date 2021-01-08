Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBF52EF893
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Jan 2021 21:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbhAHUNn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Jan 2021 15:13:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:43448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728894AbhAHUNm (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Jan 2021 15:13:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4408623AAC;
        Fri,  8 Jan 2021 20:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610136781;
        bh=0+oDcnV/Kj32RXiBZBSk7/49tBpNnfdZxwIjSKX2pNw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ex/Uh2MDzPJi1iAkVyhPKlQyJ+jCwoSR5+iRgLWV+odV1dVA6zEtDGIaJANmndtoN
         RiYYwk+sGJFOPEWQV7nOyupWihX1Bs4kFJUxJHxkgXKceqV4uruku7MiUiPbWKre1e
         451/DOO643x1oG+4bv8lrNVgN1VSEKyaS1CR33N8W+Vw9gQ5hC43eR8RLvxOGi17JX
         ua7D9MOeJl5+xdBMQr54EGjDEeJ4XP8lNm0Cco8AUmBKOLuSUKoIqffSEu7wGrkDo1
         n64xDhj5dVXqdUuny3nb/T5P8ayxcXL9NF0x4yUFhK9osdVpkMGvDFhRh1Cw61XWcT
         PKob4D5kb6epg==
Date:   Fri, 8 Jan 2021 14:12:59 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "\"H. Peter Anvin\"" <hpa@zytor.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] Hyper-V: pci: x64: Generalize irq/msi set-up and
 handling
Message-ID: <20210108201259.GA1461930@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR2101MB0880A1BF1E62836EED4B8358C0AE9@SN4PR2101MB0880.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

At the very least you could pick one of the subject line prefixes that
has been used before for either mshyperv.h or pci-hyperv.c instead of
making up something completely new and different.

On Fri, Jan 08, 2021 at 07:31:08AM +0000, Sunil Muthuswamy wrote:
> Currently, operations related to irq/msi in Hyper-V vPCI are
> x86-specific code. In order to support virtual PCI on Hyper-V for
> other architectures, introduce generic interfaces to replace the
> x86-specific ones. There are no functional changes in this patch.
> 
> Co-developed-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
> In V2:
> - Addressed feedback on SoB tab.
> - Added a second patch to move the MSI entry definition.
> ---
>  arch/x86/include/asm/mshyperv.h     | 24 +++++++++++++++++++++
>  drivers/pci/controller/pci-hyperv.c | 33 +++++++++++++++++------------
>  2 files changed, 44 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index ffc289992d1b..05b32ef57e34 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -245,6 +245,30 @@ bool hv_vcpu_is_preempted(int vcpu);
>  static inline void hv_apic_init(void) {}
>  #endif
>  
> +#define hv_msi_handler		handle_edge_irq
> +#define hv_msi_handler_name	"edge"
> +#define hv_msi_prepare		pci_msi_prepare
> +
> +/* Returns the Hyper-V PCI parent MSI vector domain. */
> +static inline struct irq_domain *hv_msi_parent_vector_domain(void)
> +{
> +	return x86_vector_domain;
> +}
> +
> +/* Returns the interrupt vector mapped to the given IRQ. */
> +static inline unsigned int hv_msi_get_int_vector(struct irq_data *data)
> +{
> +	struct irq_cfg *cfg = irqd_cfg(data);
> +
> +	return cfg->vector;
> +}
> +
> +/* Get the IRQ delivery mode. */
> +static inline u8 hv_msi_irq_delivery_mode(void)
> +{
> +	return APIC_DELIVERY_MODE_FIXED;
> +}
> +
>  static inline void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
>  					      struct msi_desc *msi_desc)
>  {
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 6db8d96a78eb..9ca740d275d7 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -43,12 +43,11 @@
>  #include <linux/delay.h>
>  #include <linux/semaphore.h>
>  #include <linux/irqdomain.h>
> -#include <asm/irqdomain.h>
> -#include <asm/apic.h>
>  #include <linux/irq.h>
>  #include <linux/msi.h>
>  #include <linux/hyperv.h>
>  #include <linux/refcount.h>
> +#include <linux/pci.h>
>  #include <asm/mshyperv.h>
>  
>  /*
> @@ -1194,7 +1193,6 @@ static void hv_irq_mask(struct irq_data *data)
>  static void hv_irq_unmask(struct irq_data *data)
>  {
>  	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
> -	struct irq_cfg *cfg = irqd_cfg(data);
>  	struct hv_retarget_device_interrupt *params;
>  	struct hv_pcibus_device *hbus;
>  	struct cpumask *dest;
> @@ -1223,7 +1221,7 @@ static void hv_irq_unmask(struct irq_data *data)
>  			   (hbus->hdev->dev_instance.b[7] << 8) |
>  			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
>  			   PCI_FUNC(pdev->devfn);
> -	params->int_target.vector = cfg->vector;
> +	params->int_target.vector = hv_msi_get_int_vector(data);
>  
>  	/*
>  	 * Honoring apic->delivery_mode set to APIC_DELIVERY_MODE_FIXED by
> @@ -1324,7 +1322,7 @@ static u32 hv_compose_msi_req_v1(
>  	int_pkt->wslot.slot = slot;
>  	int_pkt->int_desc.vector = vector;
>  	int_pkt->int_desc.vector_count = 1;
> -	int_pkt->int_desc.delivery_mode = APIC_DELIVERY_MODE_FIXED;
> +	int_pkt->int_desc.delivery_mode = hv_msi_irq_delivery_mode();
>  
>  	/*
>  	 * Create MSI w/ dummy vCPU set, overwritten by subsequent retarget in
> @@ -1345,7 +1343,7 @@ static u32 hv_compose_msi_req_v2(
>  	int_pkt->wslot.slot = slot;
>  	int_pkt->int_desc.vector = vector;
>  	int_pkt->int_desc.vector_count = 1;
> -	int_pkt->int_desc.delivery_mode = APIC_DELIVERY_MODE_FIXED;
> +	int_pkt->int_desc.delivery_mode = hv_msi_irq_delivery_mode();
>  
>  	/*
>  	 * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
> @@ -1372,7 +1370,6 @@ static u32 hv_compose_msi_req_v2(
>   */
>  static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  {
> -	struct irq_cfg *cfg = irqd_cfg(data);
>  	struct hv_pcibus_device *hbus;
>  	struct vmbus_channel *channel;
>  	struct hv_pci_dev *hpdev;
> @@ -1422,7 +1419,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  		size = hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
>  					dest,
>  					hpdev->desc.win_slot.slot,
> -					cfg->vector);
> +					hv_msi_get_int_vector(data));
>  		break;
>  
>  	case PCI_PROTOCOL_VERSION_1_2:
> @@ -1430,7 +1427,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  		size = hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
>  					dest,
>  					hpdev->desc.win_slot.slot,
> -					cfg->vector);
> +					hv_msi_get_int_vector(data));
>  		break;
>  
>  	default:
> @@ -1541,12 +1538,13 @@ static struct irq_chip hv_msi_irq_chip = {
>  	.irq_compose_msi_msg	= hv_compose_msi_msg,
>  	.irq_set_affinity	= hv_set_affinity,
>  	.irq_ack		= irq_chip_ack_parent,
> +	.irq_eoi		= irq_chip_eoi_parent,
>  	.irq_mask		= hv_irq_mask,
>  	.irq_unmask		= hv_irq_unmask,
>  };
>  
>  static struct msi_domain_ops hv_msi_ops = {
> -	.msi_prepare	= pci_msi_prepare,
> +	.msi_prepare	= hv_msi_prepare,
>  	.msi_free	= hv_msi_free,
>  };
>  
> @@ -1565,17 +1563,26 @@ static struct msi_domain_ops hv_msi_ops = {
>   */
>  static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
>  {
> +	struct irq_domain *parent_domain;
> +
> +	parent_domain = hv_msi_parent_vector_domain();
> +	if (!parent_domain) {
> +		dev_err(&hbus->hdev->device,
> +			"Failed to get parent MSI domain\n");
> +		return -ENODEV;
> +	}
> +
>  	hbus->msi_info.chip = &hv_msi_irq_chip;
>  	hbus->msi_info.ops = &hv_msi_ops;
>  	hbus->msi_info.flags = (MSI_FLAG_USE_DEF_DOM_OPS |
>  		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI |
>  		MSI_FLAG_PCI_MSIX);
> -	hbus->msi_info.handler = handle_edge_irq;
> -	hbus->msi_info.handler_name = "edge";
> +	hbus->msi_info.handler = hv_msi_handler;
> +	hbus->msi_info.handler_name = hv_msi_handler_name;
>  	hbus->msi_info.data = hbus;
>  	hbus->irq_domain = pci_msi_create_irq_domain(hbus->sysdata.fwnode,
>  						     &hbus->msi_info,
> -						     x86_vector_domain);
> +						     parent_domain);
>  	if (!hbus->irq_domain) {
>  		dev_err(&hbus->hdev->device,
>  			"Failed to build an MSI IRQ domain\n");
> -- 
> 2.17.1
