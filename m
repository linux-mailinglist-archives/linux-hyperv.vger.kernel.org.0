Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A427573F797
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jun 2023 10:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjF0ImK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Jun 2023 04:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjF0ImI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Jun 2023 04:42:08 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30B34187;
        Tue, 27 Jun 2023 01:42:06 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1099)
        id B1396207D83B; Tue, 27 Jun 2023 01:42:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B1396207D83B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1687855325;
        bh=2KhsgklTJJaf0I/dxhisnlWyMa17gEUnOtoB8ishPDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N9jY+iMVNcRgMwUaQo2wkWk9W16yiY1lclAFcYXi8opOcFjrWo44LNghZtFNGv1e/
         J+J8yOE6HWqaZ96cHwHoR3cYbIjf96diP6n0wtaJLzHMbC6XvyNXoe/ZTZd5PNyz3Z
         NelyoubP4QxQrNHpXXybeO9E/eXx6QTIY3rgh8tQ=
Date:   Tue, 27 Jun 2023 01:42:05 -0700
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
Subject: Re: [PATCH 2/2 V3 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Message-ID: <20230627084205.GB31802@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1687771098-26775-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1687771224-27162-1-git-send-email-schakrabarti@linux.microsoft.com>
 <578faf91-35e6-d946-d9ec-c949e57eadef@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <578faf91-35e6-d946-d9ec-c949e57eadef@linux.microsoft.com>
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

On Mon, Jun 26, 2023 at 07:43:07PM +0530, Praveen Kumar wrote:
> On 6/26/2023 2:50 PM, souradeep chakrabarti wrote:
> > From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> > 
> > This is the second part of the fix.
> > 
> > Also this patch adds a new attribute in mana_context, which gets set when
> > mana_hwc_send_request() hits a timeout because of host unresponsiveness.
> > This flag then helps to avoid the timeouts in successive calls.
> > 
> > Fixes: ca9c54d2d6a5ab2430c4eda364c77125d62e5e0f (net: mana: Add a driver for
> > Microsoft Azure Network Adapter)
> > Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> > ---
> > V2 -> V3:
> > * Removed the initialization of vf_unload_timeout
> > * Splitted the patch in two.
> > * Fixed extra space from the commit message.
> > ---
> >  drivers/net/ethernet/microsoft/mana/gdma_main.c  |  4 +++-
> >  drivers/net/ethernet/microsoft/mana/hw_channel.c | 12 +++++++++++-
> >  include/net/mana/mana.h                          |  2 ++
> >  3 files changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index 8f3f78b68592..6411f01be0d9 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -946,10 +946,12 @@ int mana_gd_deregister_device(struct gdma_dev *gd)
> >  	struct gdma_context *gc = gd->gdma_context;
> >  	struct gdma_general_resp resp = {};
> >  	struct gdma_general_req req = {};
> > +	struct mana_context *ac;
> >  	int err;
> >  
> >  	if (gd->pdid == INVALID_PDID)
> >  		return -EINVAL;
> > +	ac = gd->driver_data;
> >  
> >  	mana_gd_init_req_hdr(&req.hdr, GDMA_DEREGISTER_DEVICE, sizeof(req),
> >  			     sizeof(resp));
> > @@ -957,7 +959,7 @@ int mana_gd_deregister_device(struct gdma_dev *gd)
> >  	req.hdr.dev_id = gd->dev_id;
> >  
> >  	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
> > -	if (err || resp.hdr.status) {
> > +	if ((err || resp.hdr.status) && !ac->vf_unload_timeout) {
> >  		dev_err(gc->dev, "Failed to deregister device: %d, 0x%x\n",
> >  			err, resp.hdr.status);
> 
> With !ac->vf_unload_timeout option, this message may not be correctly showing err, status. Probably you want to add explicit information during timeouts so that it give right information ? Or have the err, status field properly updated.
This check !ac->vf_unload_timeout here means if ac->vf_unload_timeout is not yet set,
then only consider the err path, else continue the remaining operation.
> 
> >  		if (!err)
> > diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > index 9d1507eba5b9..492cb2c6e2cb 100644
> > --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > @@ -1,8 +1,10 @@
> >  // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> >  /* Copyright (c) 2021, Microsoft Corporation. */
> >  
> > +#include "asm-generic/errno.h"
> >  #include <net/mana/gdma.h>
> >  #include <net/mana/hw_channel.h>
> > +#include <net/mana/mana.h>
> >  
> >  static int mana_hwc_get_msg_index(struct hw_channel_context *hwc, u16 *msg_id)
> >  {
> > @@ -786,12 +788,19 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
> >  	struct hwc_wq *txq = hwc->txq;
> >  	struct gdma_req_hdr *req_msg;
> >  	struct hwc_caller_ctx *ctx;
> > +	struct mana_context *ac;
> >  	u32 dest_vrcq = 0;
> >  	u32 dest_vrq = 0;
> >  	u16 msg_id;
> >  	int err;
> >  
> >  	mana_hwc_get_msg_index(hwc, &msg_id);
> > +	ac = hwc->gdma_dev->driver_data;
> 
> Is there a case where gdma_dev be invalid here ? If so, lets check the state and then proceed further ?
I can see Haiyang has already in his comment, responded on the same.
hwc->gdma_dev will be valid here, but as Haiyang pointed we need to use
hwc->gdma_dev->gdma_context->mana.driver_data, or better to relocate the
attribute in gdma_context.
> 
> > +	if (ac->vf_unload_timeout) {
> > +		dev_err(hwc->dev, "HWC: vport is already unloaded.\n");
> > +		err = -ETIMEDOUT;
> > +		goto out;
> > +	}
> >  
> >  	tx_wr = &txq->msg_buf->reqs[msg_id];
> >  
> > @@ -825,9 +834,10 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
> >  		goto out;
> >  	}
> >  
> > -	if (!wait_for_completion_timeout(&ctx->comp_event, 30 * HZ)) {
> > +	if (!wait_for_completion_timeout(&ctx->comp_event, 5 * HZ)) {
> 
> IMHO we should have macros instead of magic numbers (5 , 30 or so). But would like others to comment here.
> 
> >  		dev_err(hwc->dev, "HWC: Request timed out!\n");
> >  		err = -ETIMEDOUT;
> > +		ac->vf_unload_timeout = true;
> >  		goto out;
> >  	}
> >  
> > diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> > index 9eef19972845..5f5affdca1eb 100644
> > --- a/include/net/mana/mana.h
> > +++ b/include/net/mana/mana.h
> > @@ -358,6 +358,8 @@ struct mana_context {
> >  
> >  	u16 num_ports;
> >  
> > +	bool vf_unload_timeout;
> > +
> >  	struct mana_eq *eqs;
> >  
> >  	struct net_device *ports[MAX_PORTS_IN_MANA_DEV];
