Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7766C764426
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Jul 2023 05:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjG0DK7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Jul 2023 23:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjG0DK6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Jul 2023 23:10:58 -0400
Received: from out-14.mta0.migadu.com (out-14.mta0.migadu.com [91.218.175.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA401BF4
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Jul 2023 20:10:56 -0700 (PDT)
Message-ID: <519602aa-0a6a-70a5-23c7-ce190045e4af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690427454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D6AAFz5LXq+gKWR7MYd9L3gmF4UqvD9x32qWV+TlC8E=;
        b=GNSyC2eocgWDA6uOLCb+43xxY0HaJs/PcYEyA62P/8mi6H8Zz2r84qPqkosCDfGHcVYu6z
        6XhkWS/g1oPw9O+8zeQ2jWyoWJq1aV7vjps54cg4a/WQZrGLMF/wNQ2o9VvwL8+51+xYIU
        pxO8y7gxs9HzphNAfL8KFNHxZo5JFy0=
Date:   Thu, 27 Jul 2023 11:10:37 +0800
MIME-Version: 1.0
Subject: Re: [PATCH V6 net] net: mana: Fix MANA VF unload when hardware is
To:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     schakrabarti@microsoft.com, stable@vger.kernel.org
References: <1690377336-1353-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1690377336-1353-1-git-send-email-schakrabarti@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

在 2023/7/26 21:15, Souradeep Chakrabarti 写道:
> When unloading the MANA driver, mana_dealloc_queues() waits for the MANA
> hardware to complete any inflight packets and set the pending send count
> to zero. But if the hardware has failed, mana_dealloc_queues()
> could wait forever.
> 
> Fix this by adding a timeout to the wait. Set the timeout to 120 seconds,
> which is a somewhat arbitrary value that is more than long enough for
> functional hardware to complete any sends.
> 
> Cc: stable@vger.kernel.org
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
> 
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
> V5 -> V6:
> * Added pcie_flr to reset the pci after timeout.
> * Fixed the position of changelog.
> * Removed unused variable like cq.
> 
> V4 -> V5:
> * Added fixes tag
> * Changed the usleep_range from static to incremental value.
> * Initialized timeout in the begining.
> 
> V3 -> V4:
> * Removed the unnecessary braces from mana_dealloc_queues().
> 
> V2 -> V3:
> * Removed the unnecessary braces from mana_dealloc_queues().
> 
> V1 -> V2:
> * Added net branch
> * Removed the typecasting to (struct mana_context*) of void pointer
> * Repositioned timeout variable in mana_dealloc_queues()
> * Repositioned vf_unload_timeout in mana_context struct, to utilise the
>   6 bytes hole
> ---
>   drivers/net/ethernet/microsoft/mana/mana_en.c | 38 +++++++++++++++++--
>   1 file changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index a499e460594b..ea039e2d4c4b 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -8,6 +8,7 @@
>   #include <linux/ethtool.h>
>   #include <linux/filter.h>
>   #include <linux/mm.h>
> +#include <linux/pci.h>
>   
>   #include <net/checksum.h>
>   #include <net/ip6_checksum.h>
> @@ -2345,9 +2346,12 @@ int mana_attach(struct net_device *ndev)
>   static int mana_dealloc_queues(struct net_device *ndev)
>   {
>   	struct mana_port_context *apc = netdev_priv(ndev);
> +	unsigned long timeout = jiffies + 120 * HZ;
>   	struct gdma_dev *gd = apc->ac->gdma_dev;
>   	struct mana_txq *txq;
> +	struct sk_buff *skb;
>   	int i, err;
> +	u32 tsleep;
>   
>   	if (apc->port_is_up)
>   		return -EINVAL;
> @@ -2363,15 +2367,41 @@ static int mana_dealloc_queues(struct net_device *ndev)
>   	 * to false, but it doesn't matter since mana_start_xmit() drops any
>   	 * new packets due to apc->port_is_up being false.
>   	 *
> -	 * Drain all the in-flight TX packets
> +	 * Drain all the in-flight TX packets.
> +	 * A timeout of 120 seconds for all the queues is used.
> +	 * This will break the while loop when h/w is not responding.
> +	 * This value of 120 has been decided here considering max
> +	 * number of queues.
>   	 */
> +
>   	for (i = 0; i < apc->num_queues; i++) {
>   		txq = &apc->tx_qp[i].txq;
> -
> -		while (atomic_read(&txq->pending_sends) > 0)
> -			usleep_range(1000, 2000);
> +		tsleep = 1000;
> +		while (atomic_read(&txq->pending_sends) > 0 &&
> +		       time_before(jiffies, timeout)) {
> +			usleep_range(tsleep, tsleep + 1000);
> +			tsleep <<= 1;
> +		}
> +		if (atomic_read(&txq->pending_sends)) {
> +			err  = pcie_flr(to_pci_dev(gd->gdma_context->dev));
> +			if (err) {
> +				netdev_err(ndev, "flr failed %d with %d pkts pending in txq %u\n",
> +					   err, atomic_read(&txq->pending_sends),
> +					   txq->gdma_txq_id);
> +			}
> +			break;
> +		}
>   	}
>   
> +	for (i = 0; i < apc->num_queues; i++) {
> +		txq = &apc->tx_qp[i].txq;
> +		while (atomic_read(&txq->pending_sends)) {
> +			skb = skb_dequeue(&txq->pending_skbs);
> +			mana_unmap_skb(skb, apc);
> +			dev_consume_skb_any(skb);
> +			atomic_sub(1, &txq->pending_sends);
> +		}
If I get this commit correctly, txq->pending_sends should be equal to 
the length of txq->pending_skbs?

If yes, can we only handle the pending_skbs?

the above snippet can be changed to as below? So the performance is better?
"
		while ((skb = skb_dequeue(&txq->pending_skbs))) {
			mana_unmap_skb(skb, apc);
			dev_consume_skb_any(skb);
		}
		atomic_set(&txq->pending_sends, 0);
"

Zhu Yanjun

> +	}
>   	/* We're 100% sure the queues can no longer be woken up, because
>   	 * we're sure now mana_poll_tx_cq() can't be running.
>   	 */

