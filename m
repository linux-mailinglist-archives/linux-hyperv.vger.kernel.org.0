Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6585473F7A4
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jun 2023 10:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjF0IoO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Jun 2023 04:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjF0IoN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Jun 2023 04:44:13 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D286A4;
        Tue, 27 Jun 2023 01:44:12 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1099)
        id BCEA320C08E6; Tue, 27 Jun 2023 01:44:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BCEA320C08E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1687855451;
        bh=iu1fzHHrAYoqD3p/PNFdx6bwpzhWyK77IGunZA+EU9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JuU+rriMdRX2USSmb/GKaVnxIsaYn/6+q2I7yEY/VVjSoh9m5VY/i+2IywFvTiQjT
         vf53zT8bjj177u5x52yfsgCzgM62rqFE8shnCBtm2BvNjonU+Gk0d+Q7ojy1mqM/4C
         s432rxvvgtdmc1PmLlS2CCz9ONpeGTcWS7uf6ELs=
Date:   Tue, 27 Jun 2023 01:44:11 -0700
From:   Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, stable@vger.kernel.org,
        schakrabarti@microsoft.com
Subject: Re: [PATCH 1/2 V3 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Message-ID: <20230627084411.GC31802@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1687771098-26775-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1687771137-26911-1-git-send-email-schakrabarti@linux.microsoft.com>
 <69098dcb-c184-7d93-4045-7ac1bc0ac6d0@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69098dcb-c184-7d93-4045-7ac1bc0ac6d0@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jun 26, 2023 at 07:50:44PM +0530, Praveen Kumar wrote:
> On 6/26/2023 2:48 PM, souradeep chakrabarti wrote:
> > From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> > 
> > This patch addresses the VF unload issue, where mana_dealloc_queues()
> > gets stuck in infinite while loop, because of host unresponsiveness.
> > It adds a timeout in the while loop, to fix it.
> > 
> > Fixes: ca9c54d2d6a5ab2430c4eda364c77125d62e5e0f (net: mana: Add a driver for
> > Microsoft Azure Network Adapter)
> > Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> > ---
> > V2 -> V3:
> > * Splitted the patch in two parts.
> > * Removed the unnecessary braces from mana_dealloc_queues().
> > ---
> >  drivers/net/ethernet/microsoft/mana/mana_en.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index d907727c7b7a..cb5c43c3c47e 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -2329,7 +2329,10 @@ static int mana_dealloc_queues(struct net_device *ndev)
> >  {
> >  	struct mana_port_context *apc = netdev_priv(ndev);
> >  	struct gdma_dev *gd = apc->ac->gdma_dev;
> > +	unsigned long timeout;
> >  	struct mana_txq *txq;
> > +	struct sk_buff *skb;
> > +	struct mana_cq *cq;
> >  	int i, err;
> >  
> >  	if (apc->port_is_up)
> > @@ -2348,13 +2351,25 @@ static int mana_dealloc_queues(struct net_device *ndev)
> >  	 *
> >  	 * Drain all the in-flight TX packets
> >  	 */
> > +
> > +	timeout = jiffies + 120 * HZ;
> >  	for (i = 0; i < apc->num_queues; i++) {
> >  		txq = &apc->tx_qp[i].txq;
> > -
> > -		while (atomic_read(&txq->pending_sends) > 0)
> > +		while (atomic_read(&txq->pending_sends) > 0 &&
> > +		       time_before(jiffies, timeout))
> >  			usleep_range(1000, 2000);
> >  	}
> >  
> > +	for (i = 0; i < apc->num_queues; i++) {
> > +		txq = &apc->tx_qp[i].txq;
> > +		cq = &apc->tx_qp[i].tx_cq;
> > +		while (atomic_read(&txq->pending_sends)) {
> > +			skb = skb_dequeue(&txq->pending_skbs);
> > +			mana_unmap_skb(skb, apc);
> > +			napi_consume_skb(skb, cq->budget);
> > +			atomic_sub(1, &txq->pending_sends);
> > +		}
> > +	}
> 
> Can we combine these 2 loops into 1 something like this ?
> 
> 	for (i = 0; i < apc->num_queues; i++) {
> 		txq = &apc->tx_qp[i].txq;
> 		cq = &apc->tx_qp[i].tx_cq;
> 		while (atomic_read(&txq->pending_sends)) {
> 			if (time_before(jiffies, timeout)) {
> 				usleep_range(1000, 2000);
> 			} else {
> 				skb = skb_dequeue(&txq->pending_skbs);
> 				mana_unmap_skb(skb, apc);
> 				napi_consume_skb(skb, cq->budget);
> 				atomic_sub(1, &txq->pending_sends);
> 			}
> 		}
> 	}
We should free up the skbs only after timeout has happened or after all the
queues are looped.
> >  	/* We're 100% sure the queues can no longer be woken up, because
> >  	 * we're sure now mana_poll_tx_cq() can't be running.
> >  	 */
