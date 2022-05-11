Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D864D523CAA
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 May 2022 20:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346383AbiEKSg7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 May 2022 14:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346357AbiEKSgz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 May 2022 14:36:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0004D1FCEF;
        Wed, 11 May 2022 11:36:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1C72B825FA;
        Wed, 11 May 2022 18:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0704AC340EE;
        Wed, 11 May 2022 18:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652294211;
        bh=9dgk5MMfcSNFnaS9xDsRuvP7ApuSvlKIV/AhUIRrM5M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ayL0/cxgvhOeHusF0CD32lm4iAN55yhdjRh8HYDDLCUFllMtno2DQhW+WShYRZSyo
         NmqdgJNCxmSwJVBMU6iHIFZnLg70bCHID+F7uiNt9wupxI95RcISY7SSBk4L4+p01H
         KYSbUraQlZQYzuwznmAv24/bT3riF9fRjyzVqHc2aQ+gn6nV9TGJ3sf67WsjSjZW2h
         YSl0Kvk3DnmvR0TcEkusO1HUzJNICEg9cdx3IM5oBErOZ7JmTpQLT5j89swbubiG0n
         M6XqBLn0XXewlGbt0xGEGs6mKXpemojhfXr/lZrOtxYpeVQXnCbgDsbNeRFxovFGyE
         QLkEbNjPqUgmA==
Date:   Wed, 11 May 2022 13:36:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        jakeo@microsoft.com, dazhan@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: hv: Fix interrupt mapping for multi-MSI
Message-ID: <20220511183648.GA798565@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652282599-21643-1-git-send-email-quic_jhugo@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In the subject, "Fix interrupt mapping ..." is too general.  Almost
all patches "fix" something, so all we learn is that this is something
to do with multi-MSI.  It's better if you can say something specific,
like the fact that you now ensure that multi-MSI vectors are aligned
and consecutive.

On Wed, May 11, 2022 at 09:23:19AM -0600, Jeffrey Hugo wrote:
> According to Dexuan, the hypervisor folks beleive that multi-msi
> allocations are not correct.  compose_msi_msg() will allocate multi-msi
> one by one.  However, multi-msi is a block of related MSIs, with alignment
> requirements.  In order for the hypervisor to allocate properly aligned
> and consecutive entries in the IOMMU Interrupt Remapping Table, there
> should be a single mapping request that requests all of the multi-msi
> vectors in one shot.

s/beleive/believe/
s/multi-msi/multi-MSI/ (several, and below, and in code comments)

But we don't really need the context of "According to Dexuan, the
hypervisor folks believe ..."  Just describe what this patch does and
why.  Apparently we previously didn't allocate aligned and consecutive
MSI vectors, and presumably that broke something.

> Dexuan suggests detecting the multi-msi case and composing a single
> request related to the first MSI.  Then for the other MSIs in the same
> block, use the cached information.  This appears to be viable, so do it.
> 
> Suggested-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> Tested-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 60 ++++++++++++++++++++++++++++++-------
>  1 file changed, 50 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 5e2e637..e439b81 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1525,6 +1525,10 @@ static void hv_int_desc_free(struct hv_pci_dev *hpdev,
>  		u8 buffer[sizeof(struct pci_delete_interrupt)];
>  	} ctxt;
>  
> +	if (!int_desc->vector_count) {
> +		kfree(int_desc);
> +		return;
> +	}
>  	memset(&ctxt, 0, sizeof(ctxt));
>  	int_pkt = (struct pci_delete_interrupt *)&ctxt.pkt.message;
>  	int_pkt->message_type.type =
> @@ -1609,12 +1613,12 @@ static void hv_pci_compose_compl(void *context, struct pci_response *resp,
>  
>  static u32 hv_compose_msi_req_v1(
>  	struct pci_create_interrupt *int_pkt, struct cpumask *affinity,
> -	u32 slot, u8 vector)
> +	u32 slot, u8 vector, u8 vector_count)
>  {
>  	int_pkt->message_type.type = PCI_CREATE_INTERRUPT_MESSAGE;
>  	int_pkt->wslot.slot = slot;
>  	int_pkt->int_desc.vector = vector;
> -	int_pkt->int_desc.vector_count = 1;
> +	int_pkt->int_desc.vector_count = vector_count;
>  	int_pkt->int_desc.delivery_mode = DELIVERY_MODE;
>  
>  	/*
> @@ -1637,14 +1641,14 @@ static int hv_compose_msi_req_get_cpu(struct cpumask *affinity)
>  
>  static u32 hv_compose_msi_req_v2(
>  	struct pci_create_interrupt2 *int_pkt, struct cpumask *affinity,
> -	u32 slot, u8 vector)
> +	u32 slot, u8 vector, u8 vector_count)
>  {
>  	int cpu;
>  
>  	int_pkt->message_type.type = PCI_CREATE_INTERRUPT_MESSAGE2;
>  	int_pkt->wslot.slot = slot;
>  	int_pkt->int_desc.vector = vector;
> -	int_pkt->int_desc.vector_count = 1;
> +	int_pkt->int_desc.vector_count = vector_count;
>  	int_pkt->int_desc.delivery_mode = DELIVERY_MODE;
>  	cpu = hv_compose_msi_req_get_cpu(affinity);
>  	int_pkt->int_desc.processor_array[0] =
> @@ -1656,7 +1660,7 @@ static u32 hv_compose_msi_req_v2(
>  
>  static u32 hv_compose_msi_req_v3(
>  	struct pci_create_interrupt3 *int_pkt, struct cpumask *affinity,
> -	u32 slot, u32 vector)
> +	u32 slot, u32 vector, u8 vector_count)
>  {
>  	int cpu;
>  
> @@ -1664,7 +1668,7 @@ static u32 hv_compose_msi_req_v3(
>  	int_pkt->wslot.slot = slot;
>  	int_pkt->int_desc.vector = vector;
>  	int_pkt->int_desc.reserved = 0;
> -	int_pkt->int_desc.vector_count = 1;
> +	int_pkt->int_desc.vector_count = vector_count;
>  	int_pkt->int_desc.delivery_mode = DELIVERY_MODE;
>  	cpu = hv_compose_msi_req_get_cpu(affinity);
>  	int_pkt->int_desc.processor_array[0] =
> @@ -1695,6 +1699,8 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	struct cpumask *dest;
>  	struct compose_comp_ctxt comp;
>  	struct tran_int_desc *int_desc;
> +	struct msi_desc *msi_desc;
> +	u8 vector, vector_count;
>  	struct {
>  		struct pci_packet pci_pkt;
>  		union {
> @@ -1716,7 +1722,8 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  		return;
>  	}
>  
> -	pdev = msi_desc_to_pci_dev(irq_data_get_msi_desc(data));
> +	msi_desc  = irq_data_get_msi_desc(data);
> +	pdev = msi_desc_to_pci_dev(msi_desc);
>  	dest = irq_data_get_effective_affinity_mask(data);
>  	pbus = pdev->bus;
>  	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
> @@ -1729,6 +1736,36 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	if (!int_desc)
>  		goto drop_reference;
>  
> +	if (!msi_desc->pci.msi_attrib.is_msix && msi_desc->nvec_used > 1) {
> +		/*
> +		 * If this is not the first MSI of Multi MSI, we already have
> +		 * a mapping.  Can exit early.
> +		 */
> +		if (msi_desc->irq != data->irq) {
> +			data->chip_data = int_desc;
> +			int_desc->address = msi_desc->msg.address_lo |
> +					    (u64)msi_desc->msg.address_hi << 32;
> +			int_desc->data = msi_desc->msg.data +
> +					 (data->irq - msi_desc->irq);
> +			msg->address_hi = msi_desc->msg.address_hi;
> +			msg->address_lo = msi_desc->msg.address_lo;
> +			msg->data = int_desc->data;
> +			put_pcichild(hpdev);
> +			return;
> +		}
> +		/*
> +		 * The vector we select here is a dummy value.  The correct
> +		 * value gets sent to the hypervisor in unmask().  This needs
> +		 * to be aligned with the count, and also not zero.  Multi-msi
> +		 * is powers of 2 up to 32, so 32 will always work here.
> +		 */
> +		vector = 32;
> +		vector_count = msi_desc->nvec_used;
> +	} else {
> +		vector = hv_msi_get_int_vector(data);
> +		vector_count = 1;
> +	}
> +
>  	memset(&ctxt, 0, sizeof(ctxt));
>  	init_completion(&comp.comp_pkt.host_event);
>  	ctxt.pci_pkt.completion_func = hv_pci_compose_compl;
> @@ -1739,7 +1776,8 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  		size = hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
>  					dest,
>  					hpdev->desc.win_slot.slot,
> -					hv_msi_get_int_vector(data));
> +					vector,
> +					vector_count);
>  		break;
>  
>  	case PCI_PROTOCOL_VERSION_1_2:
> @@ -1747,14 +1785,16 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  		size = hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
>  					dest,
>  					hpdev->desc.win_slot.slot,
> -					hv_msi_get_int_vector(data));
> +					vector,
> +					vector_count);
>  		break;
>  
>  	case PCI_PROTOCOL_VERSION_1_4:
>  		size = hv_compose_msi_req_v3(&ctxt.int_pkts.v3,
>  					dest,
>  					hpdev->desc.win_slot.slot,
> -					hv_msi_get_int_vector(data));
> +					vector,
> +					vector_count);
>  		break;
>  
>  	default:
> -- 
> 2.7.4
> 
