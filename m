Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686B050E63F
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Apr 2022 18:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240081AbiDYQyp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Apr 2022 12:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238170AbiDYQyp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Apr 2022 12:54:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6E461A042;
        Mon, 25 Apr 2022 09:51:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 942261FB;
        Mon, 25 Apr 2022 09:51:40 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.13.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0CFB3F5A1;
        Mon, 25 Apr 2022 09:51:37 -0700 (PDT)
Date:   Mon, 25 Apr 2022 17:51:34 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Hu <weh@microsoft.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] PCI: hv: Fix synchronization between channel
 callback and hv_compose_msi_msg()
Message-ID: <20220425165134.GB17718@lpieralisi>
References: <20220419122325.10078-1-parri.andrea@gmail.com>
 <20220419122325.10078-7-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419122325.10078-7-parri.andrea@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 19, 2022 at 02:23:25PM +0200, Andrea Parri (Microsoft) wrote:
> Dexuan wrote:
> 
>   "[...]  when we disable AccelNet, the host PCI VSP driver sends a
>    PCI_EJECT message first, and the channel callback may set
>    hpdev->state to hv_pcichild_ejecting on a different CPU.  This can
>    cause hv_compose_msi_msg() to exit from the loop and 'return', and
>    the on-stack variable 'ctxt' is invalid.  Now, if the response
>    message from the host arrives, the channel callback will try to
>    access the invalid 'ctxt' variable, and this may cause a crash."
> 
> Schematically:
> 
>   Hyper-V sends PCI_EJECT msg
>     hv_pci_onchannelcallback()
>       state = hv_pcichild_ejecting
>                                        hv_compose_msi_msg()
>                                          alloc and init comp_pkt
>                                          state == hv_pcichild_ejecting
>   Hyper-V sends VM_PKT_COMP msg
>     hv_pci_onchannelcallback()
>       retrieve address of comp_pkt
>                                          'free' comp_pkt and return
>       comp_pkt->completion_func()
> 
> Dexuan also showed how the crash can be triggered after introducing
> suitable delays in the driver code, thus validating the 'assumption'
> that the host can still normally respond to the guest's compose_msi
> request after the host has started to eject the PCI device.
> 
> Fix the synchronization by leveraging the requestor lock as follows:
> 
>   - Before 'return'-ing in hv_compose_msi_msg(), remove the ID (while
>     holding the requestor lock) associated to the completion packet.
> 
>   - Retrieve the address *and call ->completion_func() within a same
>     (requestor) critical section in hv_pci_onchannelcallback().
> 
> Reported-by: Wei Hu <weh@microsoft.com>
> Reported-by: Dexuan Cui <decui@microsoft.com>
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> ---
> v1 included:
> 
> Fixes: de0aa7b2f97d3 ("PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()")
> 
> as a reference, but not a reference for the stable-kernel bots.
> The back-port would depend on the entire series which, in turn,
> shouldn't be backported to commits preceding bf5fd8cae3c8f.
> 
>  drivers/pci/controller/pci-hyperv.c | 33 +++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 0252b4bbc8d15..59f0197b94c78 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1695,7 +1695,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  			struct pci_create_interrupt3 v3;
>  		} int_pkts;
>  	} __packed ctxt;
> -
> +	u64 trans_id;
>  	u32 size;
>  	int ret;
>  
> @@ -1757,10 +1757,10 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  		goto free_int_desc;
>  	}
>  
> -	ret = vmbus_sendpacket(hpdev->hbus->hdev->channel, &ctxt.int_pkts,
> -			       size, (unsigned long)&ctxt.pci_pkt,
> -			       VM_PKT_DATA_INBAND,
> -			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +	ret = vmbus_sendpacket_getid(hpdev->hbus->hdev->channel, &ctxt.int_pkts,
> +				     size, (unsigned long)&ctxt.pci_pkt,
> +				     &trans_id, VM_PKT_DATA_INBAND,
> +				     VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (ret) {
>  		dev_err(&hbus->hdev->device,
>  			"Sending request for interrupt failed: 0x%x",
> @@ -1839,6 +1839,15 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  
>  enable_tasklet:
>  	tasklet_enable(&channel->callback_event);
> +	/*
> +	 * The completion packet on the stack becomes invalid after 'return';
> +	 * remove the ID from the VMbus requestor if the identifier is still
> +	 * mapped to/associated with the packet.  (The identifier could have
> +	 * been 're-used', i.e., already removed and (re-)mapped.)
> +	 *
> +	 * Cf. hv_pci_onchannelcallback().
> +	 */
> +	vmbus_request_addr_match(channel, trans_id, (unsigned long)&ctxt.pci_pkt);
>  free_int_desc:
>  	kfree(int_desc);
>  drop_reference:
> @@ -2717,6 +2726,7 @@ static void hv_pci_onchannelcallback(void *context)
>  	struct pci_dev_inval_block *inval;
>  	struct pci_dev_incoming *dev_message;
>  	struct hv_pci_dev *hpdev;
> +	unsigned long flags;
>  
>  	buffer = kmalloc(bufferlen, GFP_ATOMIC);
>  	if (!buffer)
> @@ -2751,8 +2761,11 @@ static void hv_pci_onchannelcallback(void *context)
>  		switch (desc->type) {
>  		case VM_PKT_COMP:
>  
> -			req_addr = chan->request_addr_callback(chan, req_id);
> +			lock_requestor(chan, flags);
> +			req_addr = __vmbus_request_addr_match(chan, req_id,
> +							      VMBUS_RQST_ADDR_ANY);
>  			if (req_addr == VMBUS_RQST_ERROR) {
> +				unlock_requestor(chan, flags);
>  				dev_err(&hbus->hdev->device,
>  					"Invalid transaction ID %llx\n",
>  					req_id);
> @@ -2760,9 +2773,17 @@ static void hv_pci_onchannelcallback(void *context)
>  			}
>  			comp_packet = (struct pci_packet *)req_addr;
>  			response = (struct pci_response *)buffer;
> +			/*
> +			 * Call ->completion_func() within the critical section to make
> +			 * sure that the packet pointer is still valid during the call:
> +			 * here 'valid' means that there's a task still waiting for the
> +			 * completion, and that the packet data is still on the waiting
> +			 * task's stack.  Cf. hv_compose_msi_msg().
> +			 */
>  			comp_packet->completion_func(comp_packet->compl_ctxt,
>  						     response,
>  						     bytes_recvd);
> +			unlock_requestor(chan, flags);
>  			break;
>  
>  		case VM_PKT_DATA_INBAND:
> -- 
> 2.25.1
> 
