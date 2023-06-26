Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE61E73E1A8
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jun 2023 16:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjFZONm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Jun 2023 10:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjFZONj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Jun 2023 10:13:39 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E95810CB;
        Mon, 26 Jun 2023 07:13:19 -0700 (PDT)
Received: from [10.171.21.113] (unknown [167.220.238.145])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3085221C3F3B;
        Mon, 26 Jun 2023 07:13:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3085221C3F3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1687788798;
        bh=arhrccEDU/8IYlgG/8DTb4iy24jRvQPaA2ChU1M97HI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KwSocRBsFmMC8Ej4aJUFk89Emg2JoHBvQtFNCvnasRIMMlW0DEgMKO/zhjrINro1M
         yPNjhjJPL8l6Z0U0AXgY2lVDfHd9qzGzjZqb/grjA883NsAu+1CNbgXcS3ow3124GZ
         WMCgQj4IuvJ0F10Ezsu+6GPO0FBuISJTQ19xsSvI=
Message-ID: <578faf91-35e6-d946-d9ec-c949e57eadef@linux.microsoft.com>
Date:   Mon, 26 Jun 2023 19:43:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2 V3 net] net: mana: Fix MANA VF unload when host is
 unresponsive
To:     souradeep chakrabarti <schakrabarti@linux.microsoft.com>,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     stable@vger.kernel.org, schakrabarti@microsoft.com
References: <1687771098-26775-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1687771224-27162-1-git-send-email-schakrabarti@linux.microsoft.com>
Content-Language: en-US
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
In-Reply-To: <1687771224-27162-1-git-send-email-schakrabarti@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 6/26/2023 2:50 PM, souradeep chakrabarti wrote:
> From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> 
> This is the second part of the fix.
> 
> Also this patch adds a new attribute in mana_context, which gets set when
> mana_hwc_send_request() hits a timeout because of host unresponsiveness.
> This flag then helps to avoid the timeouts in successive calls.
> 
> Fixes: ca9c54d2d6a5ab2430c4eda364c77125d62e5e0f (net: mana: Add a driver for
> Microsoft Azure Network Adapter)
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
> V2 -> V3:
> * Removed the initialization of vf_unload_timeout
> * Splitted the patch in two.
> * Fixed extra space from the commit message.
> ---
>  drivers/net/ethernet/microsoft/mana/gdma_main.c  |  4 +++-
>  drivers/net/ethernet/microsoft/mana/hw_channel.c | 12 +++++++++++-
>  include/net/mana/mana.h                          |  2 ++
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 8f3f78b68592..6411f01be0d9 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -946,10 +946,12 @@ int mana_gd_deregister_device(struct gdma_dev *gd)
>  	struct gdma_context *gc = gd->gdma_context;
>  	struct gdma_general_resp resp = {};
>  	struct gdma_general_req req = {};
> +	struct mana_context *ac;
>  	int err;
>  
>  	if (gd->pdid == INVALID_PDID)
>  		return -EINVAL;
> +	ac = gd->driver_data;
>  
>  	mana_gd_init_req_hdr(&req.hdr, GDMA_DEREGISTER_DEVICE, sizeof(req),
>  			     sizeof(resp));
> @@ -957,7 +959,7 @@ int mana_gd_deregister_device(struct gdma_dev *gd)
>  	req.hdr.dev_id = gd->dev_id;
>  
>  	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
> -	if (err || resp.hdr.status) {
> +	if ((err || resp.hdr.status) && !ac->vf_unload_timeout) {
>  		dev_err(gc->dev, "Failed to deregister device: %d, 0x%x\n",
>  			err, resp.hdr.status);

With !ac->vf_unload_timeout option, this message may not be correctly showing err, status. Probably you want to add explicit information during timeouts so that it give right information ? Or have the err, status field properly updated.

>  		if (!err)
> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> index 9d1507eba5b9..492cb2c6e2cb 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -1,8 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>  /* Copyright (c) 2021, Microsoft Corporation. */
>  
> +#include "asm-generic/errno.h"
>  #include <net/mana/gdma.h>
>  #include <net/mana/hw_channel.h>
> +#include <net/mana/mana.h>
>  
>  static int mana_hwc_get_msg_index(struct hw_channel_context *hwc, u16 *msg_id)
>  {
> @@ -786,12 +788,19 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
>  	struct hwc_wq *txq = hwc->txq;
>  	struct gdma_req_hdr *req_msg;
>  	struct hwc_caller_ctx *ctx;
> +	struct mana_context *ac;
>  	u32 dest_vrcq = 0;
>  	u32 dest_vrq = 0;
>  	u16 msg_id;
>  	int err;
>  
>  	mana_hwc_get_msg_index(hwc, &msg_id);
> +	ac = hwc->gdma_dev->driver_data;

Is there a case where gdma_dev be invalid here ? If so, lets check the state and then proceed further ?

> +	if (ac->vf_unload_timeout) {
> +		dev_err(hwc->dev, "HWC: vport is already unloaded.\n");
> +		err = -ETIMEDOUT;
> +		goto out;
> +	}
>  
>  	tx_wr = &txq->msg_buf->reqs[msg_id];
>  
> @@ -825,9 +834,10 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
>  		goto out;
>  	}
>  
> -	if (!wait_for_completion_timeout(&ctx->comp_event, 30 * HZ)) {
> +	if (!wait_for_completion_timeout(&ctx->comp_event, 5 * HZ)) {

IMHO we should have macros instead of magic numbers (5 , 30 or so). But would like others to comment here.

>  		dev_err(hwc->dev, "HWC: Request timed out!\n");
>  		err = -ETIMEDOUT;
> +		ac->vf_unload_timeout = true;
>  		goto out;
>  	}
>  
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 9eef19972845..5f5affdca1eb 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -358,6 +358,8 @@ struct mana_context {
>  
>  	u16 num_ports;
>  
> +	bool vf_unload_timeout;
> +
>  	struct mana_eq *eqs;
>  
>  	struct net_device *ports[MAX_PORTS_IN_MANA_DEV];

