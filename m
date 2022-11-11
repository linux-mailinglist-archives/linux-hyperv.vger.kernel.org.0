Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EA9625767
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Nov 2022 10:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiKKJ4n (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Nov 2022 04:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiKKJ4l (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Nov 2022 04:56:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6F66A74A;
        Fri, 11 Nov 2022 01:56:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C8F0B824C3;
        Fri, 11 Nov 2022 09:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B521C433D6;
        Fri, 11 Nov 2022 09:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668160597;
        bh=pFceQwBLv3tQa3xHYgVfDO9LYsD+eIrIU1cGVDLwPmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aGggXmAzdlD5kYo+ujl+ogGzRJ6krk1mvXnrPn2zFHpnJIGtWxNih7vIt+kMDnC3g
         Q0mqWmr5N0sz+oAoERsHD8T21HBWKUpgOIzVxJa8cevs3mIEOC0bAjRz1TuFLrFmaT
         Rju2nHxAnszrzBYE30DD63vbAx4Qj3u9jZOyycNJEqggxdH8gStZ4P7eFj0SEl/V2i
         xx2d/QieSk4lKHzs34/P33CaM3VDyJc/l9cbXEURjENvkTrR0Cd5+517gcZj3VLX+s
         IzXRfCQzmwOuVCMtCeTwkcKM5EOO5ltnaDQyGIIUwmyBCWajTfCgW3jUbw1aJpFTc/
         wB+dgpLcbZuvg==
Date:   Fri, 11 Nov 2022 10:56:28 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     quic_jhugo@quicinc.com, quic_carlv@quicinc.com, wei.liu@kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, robh@kernel.org, kw@linux.com,
        helgaas@kernel.org, alex.williamson@redhat.com,
        boqun.feng@gmail.com, Boqun.Feng@microsoft.com
Subject: Re: [PATCH v3] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Message-ID: <Y24cTE9+bqXtHics@lpieralisi>
References: <20221104222953.11356-1-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104222953.11356-1-decui@microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Nov 04, 2022 at 03:29:53PM -0700, Dexuan Cui wrote:
> Jeffrey added Multi-MSI support to the pci-hyperv driver by the 4 patches:
> 08e61e861a0e ("PCI: hv: Fix multi-MSI to allow more than one MSI vector")
> 455880dfe292 ("PCI: hv: Fix hv_arch_irq_unmask() for multi-MSI")
> b4b77778ecc5 ("PCI: hv: Reuse existing IRTE allocation in compose_msi_msg()")
> a2bad844a67b ("PCI: hv: Fix interrupt mapping for multi-MSI")
> 
> It turns out that the third patch (b4b77778ecc5) causes a performance
> regression because all the interrupts now happen on 1 physical CPU (or two
> pCPUs, if one pCPU doesn't have enough vectors). When a guest has many PCI
> devices, it may suffer from soft lockups if the workload is heavy, e.g.,
> see https://lwn.net/ml/linux-kernel/20220804025104.15673-1-decui@microsoft.com/
> 
> Commit b4b77778ecc5 itself is good. The real issue is that the hypercall in
> hv_irq_unmask() -> hv_arch_irq_unmask() ->
> hv_do_hypercall(HVCALL_RETARGET_INTERRUPT...) only changes the target
> virtual CPU rather than physical CPU; with b4b77778ecc5, the pCPU is
> determined only once in hv_compose_msi_msg() where only vCPU0 is specified;
> consequently the hypervisor only uses 1 target pCPU for all the interrupts.
> 
> Note: before b4b77778ecc5, the pCPU is determined twice, and when the pCPU
> is determinted the second time, the vCPU in the effective affinity mask is
> used (i.e., it isn't always vCPU0), so the hypervisor chooses different
> pCPU for each interrupt.
> 
> The hypercall will be fixed in future to update the pCPU as well, but
> that will take quite a while, so let's restore the old behavior in
> hv_compose_msi_msg(), i.e., don't reuse the existing IRTE allocation for
> single-MSI and MSI-X; for multi-MSI, we choose the vCPU in a round-robin
> manner for each PCI device, so the interrupts of different devices can
> happen on different pCPUs, though the interrupts of each device happen on
> some single pCPU.
> 
> The hypercall fix may not be backported to all old versions of Hyper-V, so
> we want to have this guest side change for ever (or at least till we're sure
> the old affected versions of Hyper-V are no longer supported).
> 
> Fixes: b4b77778ecc5 ("PCI: hv: Reuse existing IRTE allocation in compose_msi_msg()")
> Co-developed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Co-developed-by: Carl Vanderlip <quic_carlv@quicinc.com>
> Signed-off-by: Carl Vanderlip <quic_carlv@quicinc.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> 
> ---
> 
> v1 is here:
>   https://lwn.net/ml/linux-kernel/20220804025104.15673-1-decui@microsoft.com/
> 
> Changes in v2:
>   round-robin the vCPU for multi-MSI.
>   The commit message is re-worked.
>   Added Jeff and Carl's Co-developed-by and Signed-off-by.
> 
> Changes in v3:
>   Michael Kelley kindly helped to make a great comment, and I added the
>   comment before hv_compose_msi_req_get_cpu(). Thank you, Michael!
> 
>   Rebased to Hyper-V tree's "hyperv-fixes" branch:
>       https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-fixes
> 
>   Bjorn, Lorenzo, it would be great to have your Ack. The patch needs to go
>   through the Hyper-V tree because it's rebased to another hv_pci patch (which
>   only exists in the Hyper-V tree for now):
>       e70af8d040d2 ("PCI: hv: Fix the definition of vector in hv_compose_msi_msg()") 
> 
>   BTW, Michael has some other hv_pci patches, which would also need go through
>       the Hyper-V tree:
>       https://lwn.net/ml/linux-kernel/1666288635-72591-1-git-send-email-mikelley%40microsoft.com/
> 
> 
>  drivers/pci/controller/pci-hyperv.c | 90 ++++++++++++++++++++++++-----
>  1 file changed, 75 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index ba64284eaf9f..fa5a1ba35a82 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1613,7 +1613,7 @@ static void hv_pci_compose_compl(void *context, struct pci_response *resp,
>  }
>  
>  static u32 hv_compose_msi_req_v1(
> -	struct pci_create_interrupt *int_pkt, const struct cpumask *affinity,
> +	struct pci_create_interrupt *int_pkt,
>  	u32 slot, u8 vector, u16 vector_count)
>  {
>  	int_pkt->message_type.type = PCI_CREATE_INTERRUPT_MESSAGE;
> @@ -1631,6 +1631,35 @@ static u32 hv_compose_msi_req_v1(
>  	return sizeof(*int_pkt);
>  }
>  
> +/*
> + * The vCPU selected by hv_compose_multi_msi_req_get_cpu() and
> + * hv_compose_msi_req_get_cpu() is a "dummy" vCPU because the final vCPU to be
> + * interrupted is specified later in hv_irq_unmask() and communicated to Hyper-V
> + * via the HVCALL_RETARGET_INTERRUPT hypercall. But the choice of dummy vCPU is
> + * not irrelevant because Hyper-V chooses the physical CPU to handle the
> + * interrupts based on the vCPU specified in message sent to the vPCI VSP in
> + * hv_compose_msi_msg(). Hyper-V's choice of pCPU is not visible to the guest,
> + * but assigning too many vPCI device interrupts to the same pCPU can cause a
> + * performance bottleneck. So we spread out the dummy vCPUs to influence Hyper-V
> + * to spread out the pCPUs that it selects.
> + *
> + * For the single-MSI and MSI-X cases, it's OK for hv_compose_msi_req_get_cpu()
> + * to always return the same dummy vCPU, because a second call to
> + * hv_compose_msi_msg() contains the "real" vCPU, causing Hyper-V to choose a
> + * new pCPU for the interrupt. But for the multi-MSI case, the second call to
> + * hv_compose_msi_msg() exits without sending a message to the vPCI VSP, so the

Why ? Can't you fix _that_ ? Why can't the initial call to
hv_compose_msi_msg() determine the _real_ target vCPU ?

> + * original dummy vCPU is used. This dummy vCPU must be round-robin'ed so that
> + * the pCPUs are spread out. All interrupts for a multi-MSI device end up using
> + * the same pCPU, even though the vCPUs will be spread out by later calls
> + * to hv_irq_unmask(), but that is the best we can do now.
> + *
> + * With current Hyper-V, the HVCALL_RETARGET_INTERRUPT hypercall does *not*

"current" Hyper-V means nothing, remove it or provide versioning
information. Imagine yourself reading this comment some time
in the future.

I can't claim to understand how this MSI vCPU to pCPU mapping is made to
work in current code but I can't ack this patch sorry, if you feel like
it is good to merge it it is your and Hyper-V maintainers call, feel
free to go ahead - I can review PCI hyper-V changes that affect PCI
and IRQs core APIs, I don't know Hyper-V internals.

Lorenzo

> + * cause Hyper-V to reselect the pCPU based on the specified vCPU. Such an
> + * enhancement is planned for a future version. With that enhancement, the
> + * dummy vCPU selection won't matter, and interrupts for the same multi-MSI
> + * device will be spread across multiple pCPUs.
> + */
> +
>  /*
>   * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
>   * by subsequent retarget in hv_irq_unmask().
> @@ -1640,18 +1669,39 @@ static int hv_compose_msi_req_get_cpu(const struct cpumask *affinity)
>  	return cpumask_first_and(affinity, cpu_online_mask);
>  }
>  
> -static u32 hv_compose_msi_req_v2(
> -	struct pci_create_interrupt2 *int_pkt, const struct cpumask *affinity,
> -	u32 slot, u8 vector, u16 vector_count)
> +/*
> + * Make sure the dummy vCPU values for multi-MSI don't all point to vCPU0.
> + */
> +static int hv_compose_multi_msi_req_get_cpu(void)
>  {
> +	static DEFINE_SPINLOCK(multi_msi_cpu_lock);
> +
> +	/* -1 means starting with CPU 0 */
> +	static int cpu_next = -1;
> +
> +	unsigned long flags;
>  	int cpu;
>  
> +	spin_lock_irqsave(&multi_msi_cpu_lock, flags);
> +
> +	cpu_next = cpumask_next_wrap(cpu_next, cpu_online_mask, nr_cpu_ids,
> +				     false);
> +	cpu = cpu_next;
> +
> +	spin_unlock_irqrestore(&multi_msi_cpu_lock, flags);
> +
> +	return cpu;
> +}
> +
> +static u32 hv_compose_msi_req_v2(
> +	struct pci_create_interrupt2 *int_pkt, int cpu,
> +	u32 slot, u8 vector, u16 vector_count)
> +{
>  	int_pkt->message_type.type = PCI_CREATE_INTERRUPT_MESSAGE2;
>  	int_pkt->wslot.slot = slot;
>  	int_pkt->int_desc.vector = vector;
>  	int_pkt->int_desc.vector_count = vector_count;
>  	int_pkt->int_desc.delivery_mode = DELIVERY_MODE;
> -	cpu = hv_compose_msi_req_get_cpu(affinity);
>  	int_pkt->int_desc.processor_array[0] =
>  		hv_cpu_number_to_vp_number(cpu);
>  	int_pkt->int_desc.processor_count = 1;
> @@ -1660,18 +1710,15 @@ static u32 hv_compose_msi_req_v2(
>  }
>  
>  static u32 hv_compose_msi_req_v3(
> -	struct pci_create_interrupt3 *int_pkt, const struct cpumask *affinity,
> +	struct pci_create_interrupt3 *int_pkt, int cpu,
>  	u32 slot, u32 vector, u16 vector_count)
>  {
> -	int cpu;
> -
>  	int_pkt->message_type.type = PCI_CREATE_INTERRUPT_MESSAGE3;
>  	int_pkt->wslot.slot = slot;
>  	int_pkt->int_desc.vector = vector;
>  	int_pkt->int_desc.reserved = 0;
>  	int_pkt->int_desc.vector_count = vector_count;
>  	int_pkt->int_desc.delivery_mode = DELIVERY_MODE;
> -	cpu = hv_compose_msi_req_get_cpu(affinity);
>  	int_pkt->int_desc.processor_array[0] =
>  		hv_cpu_number_to_vp_number(cpu);
>  	int_pkt->int_desc.processor_count = 1;
> @@ -1715,12 +1762,18 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  			struct pci_create_interrupt3 v3;
>  		} int_pkts;
>  	} __packed ctxt;
> +	bool multi_msi;
>  	u64 trans_id;
>  	u32 size;
>  	int ret;
> +	int cpu;
> +
> +	msi_desc  = irq_data_get_msi_desc(data);
> +	multi_msi = !msi_desc->pci.msi_attrib.is_msix &&
> +		    msi_desc->nvec_used > 1;
>  
>  	/* Reuse the previous allocation */
> -	if (data->chip_data) {
> +	if (data->chip_data && multi_msi) {
>  		int_desc = data->chip_data;
>  		msg->address_hi = int_desc->address >> 32;
>  		msg->address_lo = int_desc->address & 0xffffffff;
> @@ -1728,7 +1781,6 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  		return;
>  	}
>  
> -	msi_desc  = irq_data_get_msi_desc(data);
>  	pdev = msi_desc_to_pci_dev(msi_desc);
>  	dest = irq_data_get_effective_affinity_mask(data);
>  	pbus = pdev->bus;
> @@ -1738,11 +1790,18 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	if (!hpdev)
>  		goto return_null_message;
>  
> +	/* Free any previous message that might have already been composed. */
> +	if (data->chip_data && !multi_msi) {
> +		int_desc = data->chip_data;
> +		data->chip_data = NULL;
> +		hv_int_desc_free(hpdev, int_desc);
> +	}
> +
>  	int_desc = kzalloc(sizeof(*int_desc), GFP_ATOMIC);
>  	if (!int_desc)
>  		goto drop_reference;
>  
> -	if (!msi_desc->pci.msi_attrib.is_msix && msi_desc->nvec_used > 1) {
> +	if (multi_msi) {
>  		/*
>  		 * If this is not the first MSI of Multi MSI, we already have
>  		 * a mapping.  Can exit early.
> @@ -1767,9 +1826,11 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  		 */
>  		vector = 32;
>  		vector_count = msi_desc->nvec_used;
> +		cpu = hv_compose_multi_msi_req_get_cpu();
>  	} else {
>  		vector = hv_msi_get_int_vector(data);
>  		vector_count = 1;
> +		cpu = hv_compose_msi_req_get_cpu(dest);
>  	}
>  
>  	/*
> @@ -1785,7 +1846,6 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	switch (hbus->protocol_version) {
>  	case PCI_PROTOCOL_VERSION_1_1:
>  		size = hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
> -					dest,
>  					hpdev->desc.win_slot.slot,
>  					(u8)vector,
>  					vector_count);
> @@ -1794,7 +1854,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	case PCI_PROTOCOL_VERSION_1_2:
>  	case PCI_PROTOCOL_VERSION_1_3:
>  		size = hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
> -					dest,
> +					cpu,
>  					hpdev->desc.win_slot.slot,
>  					(u8)vector,
>  					vector_count);
> @@ -1802,7 +1862,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  
>  	case PCI_PROTOCOL_VERSION_1_4:
>  		size = hv_compose_msi_req_v3(&ctxt.int_pkts.v3,
> -					dest,
> +					cpu,
>  					hpdev->desc.win_slot.slot,
>  					vector,
>  					vector_count);
> -- 
> 2.25.1
> 
