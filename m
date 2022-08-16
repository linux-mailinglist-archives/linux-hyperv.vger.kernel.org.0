Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E71595FA7
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Aug 2022 17:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbiHPPzB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Aug 2022 11:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbiHPPyo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Aug 2022 11:54:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6753A1EAE5;
        Tue, 16 Aug 2022 08:51:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F102C61219;
        Tue, 16 Aug 2022 15:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EF7C433C1;
        Tue, 16 Aug 2022 15:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660665084;
        bh=OV6VJXE+0fWt4xZsdqxIflMMuIFBP3K3SaK3qB6dBE8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YGwtdd7icB+GKhr2UQPBQncxK0tuCwFnaDRjxdJw7CLgT9XFlACDawvLmTMdxEpLa
         fSdBv8nREI/mWgFMQNGyw4+JAUOSwyosHUPxsW6TMbFgD+Qrb6p7WOMMX3Izts+Vf0
         oMhMrBpbRjZ2amNf7ZG7FGDyJvNXRWiF/BJiFABkEoD+9A6q5xwHPkH7dOIK2kI9tY
         rrsY0O66xii6NgmfdZioC5kvD1pg8k1BrEb1rNNqKykqr1qOSl9pciIqN2WQNk4oGe
         6AxI9V2TkDZ0gQ4K24RSA7HJn654Wh1I5m6IuPvL5sgqFZIuMSpMDKjGmWrmnr4CrR
         PDVEEmYDXG8Wg==
Date:   Tue, 16 Aug 2022 10:51:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     quic_jhugo@quicinc.com, wei.liu@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        lpieralisi@kernel.org, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        robh@kernel.org, kw@linux.com, alex.williamson@redhat.com,
        boqun.feng@gmail.com, Boqun.Feng@microsoft.com,
        Carl Vanderlip <quic_carlv@quicinc.com>
Subject: Re: [PATCH] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Message-ID: <20220816155122.GA2064495@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804025104.15673-1-decui@microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 03, 2022 at 07:51:04PM -0700, Dexuan Cui wrote:
> Jeffrey's 4 recent patches added Multi-MSI support to the pci-hyperv driver.
> Unluckily, one of the patches, i.e., b4b77778ecc5, causes a regression to a
> fio test for the Azure VM SKU Standard L64s v2 (64 AMD vCPUs, 8 NVMe drives):
> 
> when fio runs against all the 8 NVMe drives, it runs fine with a low io-depth
> (e.g., 2 or 4); when fio runs with a high io-depth (e.g., 256), somehow
> queue-29 of each NVMe drive suddenly no longer receives any interrupts, and
> the NVMe core code has to abort the queue after a timeout of 30 seconds, and
> then queue-29 starts to receive interrupts again for several seconds, and
> later queue-29 no longer receives interrupts again, and this pattern repeats:
> 
> [  223.891249] nvme nvme2: I/O 320 QID 29 timeout, aborting
> [  223.896231] nvme nvme0: I/O 320 QID 29 timeout, aborting
> [  223.898340] nvme nvme4: I/O 832 QID 29 timeout, aborting
> [  259.471309] nvme nvme2: I/O 320 QID 29 timeout, aborting
> [  259.476493] nvme nvme0: I/O 321 QID 29 timeout, aborting
> [  259.482967] nvme nvme0: I/O 322 QID 29 timeout, aborting
> 
> Some other symptoms are: the throughput of the NVMe drives drops due to
> commit b4b77778ecc5. When the fio test is running, the kernel prints some
> soft lock-up messages from time to time.
> 
> Commit b4b77778ecc5 itself looks good, and at the moment it's unclear where
> the issue is. While the issue is being investigated, restore the old behavior
> in hv_compose_msi_msg(), i.e., don't reuse the existing IRTE allocation for
> single-MSI and MSI-X. This is a stopgap for the above NVMe issue.

This has only observations with no explanations, and I don't see how
it will be useful to future readers of the git history.

I assume you bisected the problem to b4b77778ecc5?  Can you just
revert that?  A revert requires no more explanation than "this broke
something."

I guess this is a fine distinction, but I really don't like random
code changes that "seem to avoid a problem but we don't know how."
A revert at least has the advantage that we can cover our eyes and
pretend the commit never happened.  This patch feels like future
readers will have to try to understand the code even though we
clearly don't understand why it makes a difference.

> Fixes: b4b77778ecc5 ("PCI: hv: Reuse existing IRTE allocation in compose_msi_msg()")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Cc: Carl Vanderlip <quic_carlv@quicinc.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index db814f7b93ba..65d0dab25deb 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1701,6 +1701,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	struct compose_comp_ctxt comp;
>  	struct tran_int_desc *int_desc;
>  	struct msi_desc *msi_desc;
> +	bool multi_msi;
>  	u8 vector, vector_count;
>  	struct {
>  		struct pci_packet pci_pkt;
> @@ -1714,8 +1715,16 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	u32 size;
>  	int ret;
>  
> -	/* Reuse the previous allocation */
> -	if (data->chip_data) {
> +	msi_desc = irq_data_get_msi_desc(data);
> +	multi_msi = !msi_desc->pci.msi_attrib.is_msix &&
> +		    msi_desc->nvec_used > 1;
> +	/*
> +	 * Reuse the previous allocation for Multi-MSI. This is required for
> +	 * Multi-MSI and is optional for single-MSI and MSI-X. Note: for now,
> +	 * don't reuse the previous allocation for MSI-X because this causes
> +	 * unreliable interrupt delivery for some NVMe devices.
> +	 */
> +	if (data->chip_data && multi_msi) {
>  		int_desc = data->chip_data;
>  		msg->address_hi = int_desc->address >> 32;
>  		msg->address_lo = int_desc->address & 0xffffffff;
> @@ -1723,7 +1732,6 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  		return;
>  	}
>  
> -	msi_desc  = irq_data_get_msi_desc(data);
>  	pdev = msi_desc_to_pci_dev(msi_desc);
>  	dest = irq_data_get_effective_affinity_mask(data);
>  	pbus = pdev->bus;
> @@ -1733,11 +1741,18 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
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
> -- 
> 2.25.1
> 
