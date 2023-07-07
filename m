Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C01974AFAD
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Jul 2023 13:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjGGLZE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 7 Jul 2023 07:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjGGLZB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 7 Jul 2023 07:25:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBEE1FF6;
        Fri,  7 Jul 2023 04:24:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BB4061369;
        Fri,  7 Jul 2023 11:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B16C433CA;
        Fri,  7 Jul 2023 11:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688729097;
        bh=AhIkW8FId3y/Xir9SLNBv5W7iVubEvFSbX9HdicSxiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eiHMDKiQsGf+7J49cNGI+Fjv30mshWLH7+Q6+XEm4SZHPkjFlZ+lKgwCj4TRshKVL
         8Yrr6qtdtxNVtmTKmF4vHeYeX9S1A5/RQccH8Ju1jBLMVgkyUavK4JT+fliB1RsDFo
         2FBqGY3yhTcLtz4SrnKZ4BbmyZVRnB5RIRTuKn0c=
Date:   Fri, 7 Jul 2023 11:17:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, stable@vger.kernel.org,
        schakrabarti@microsoft.com
Subject: Re: [PATCH V2 net] net: mana: Configure hwc timeout from hardware
Message-ID: <2023070713-subway-stony-9ae1@gregkh>
References: <1688723128-14878-1-git-send-email-schakrabarti@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688723128-14878-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 07, 2023 at 02:45:28AM -0700, Souradeep Chakrabarti wrote:
> At present hwc timeout value is a fixed value.
> This patch sets the hwc timeout from the hardware.
> 
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
> V1 -> V2:
> * Added return check for mana_gd_query_hwc_timeout
> * Removed dev_err from mana_gd_query_hwc_timeout
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 30 ++++++++++++++++++-
>  .../net/ethernet/microsoft/mana/hw_channel.c  | 25 +++++++++++++++-
>  include/net/mana/gdma.h                       | 20 ++++++++++++-
>  include/net/mana/hw_channel.h                 |  5 ++++
>  4 files changed, 77 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 8f3f78b68592..949c927c3a7e 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -106,6 +106,27 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
>  	return 0;
>  }
>  
> +static int mana_gd_query_hwc_timeout(struct pci_dev *pdev, u32 *timeout_val)
> +{
> +	struct gdma_context *gc = pci_get_drvdata(pdev);
> +	struct gdma_query_hwc_timeout_req req = {};
> +	struct gdma_query_hwc_timeout_resp resp = {};
> +	int err;
> +
> +	mana_gd_init_req_hdr(&req.hdr, GDMA_QUERY_HWC_TIMEOUT,
> +			     sizeof(req), sizeof(resp));
> +	req.timeout_ms = *timeout_val;
> +	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
> +	if (err || resp.hdr.status)
> +		return err ? err : -EPROTO;
> +
> +	*timeout_val = resp.timeout_ms;
> +	dev_info(gc->dev, "Successfully changed the timeout value %u\n",
> +		 *timeout_val);

When the kernel works properly, it is quiet.  Please always remove your
debugging code before submitting changes for inclusion.

thanks,

greg k-h
