Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBEC73CD35
	for <lists+linux-hyperv@lfdr.de>; Sun, 25 Jun 2023 00:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjFXWKm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 24 Jun 2023 18:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFXWKl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 24 Jun 2023 18:10:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE411728;
        Sat, 24 Jun 2023 15:10:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5F3E60A72;
        Sat, 24 Jun 2023 22:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D18C433C8;
        Sat, 24 Jun 2023 22:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687644639;
        bh=HWt8oRnYu87Ln4J37mjVUiNFUEhjYUmsz1tsbbm/9FQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AP5cpRleJJxVIBPpCJ76uLDgVgCP/AGaJnlKcIitMzQ/jqV7ODH2Xa3+rHcTjgiWw
         i7kR+s9dHvWl5t9FnQlg8YoOlYgalhCQaufFlEi/dVFFBhGV7rtw/VXQ3LXMU+LE9m
         X/eDmmmiMVQUYrqA52A7wo8hn3Me8u8m356GcndmGixUbgCf+QpEO2DArhhJrFt6cB
         WtvWXmc01AUUSEkpIz5g8t68XhbFA4gSu04WfCAx/1JsvR60WS6aTb+oBHamvj7gBN
         TfNJN+Y4WDxyPp95aHQfb0TAAYlbhIzIzwKZ4hc1ZUlNIZTgsC9vCj7OMaimFZzaxi
         e36XYhHUKSl6w==
Date:   Sat, 24 Jun 2023 15:10:37 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     longli@linuxonhyperv.com
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-rdma@vger.kernel.org,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Message-ID: <20230624151037.699c50c6@kernel.org>
In-Reply-To: <1687450956-6407-1-git-send-email-longli@linuxonhyperv.com>
References: <1687450956-6407-1-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 22 Jun 2023 09:22:36 -0700 longli@linuxonhyperv.com wrote:
> It's inefficient to ring the doorbell page every time a WQE is posted to
> the received queue.
> 
> Move the code for ringing doorbell page to where after we have posted all
> WQEs to the receive queue during a callback from napi_poll().
> 
> Tests showed no regression in network latency benchmarks.
> 
> Cc: stable@vger.kernel.org
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")

If this is supposed to be a fix, you need to clearly explain what the
performance loss was, so that backporters can make an informed decision.

>  drivers/net/ethernet/microsoft/mana/gdma_main.c |  5 ++++-
>  drivers/net/ethernet/microsoft/mana/mana_en.c   | 10 ++++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 8f3f78b68592..ef11d09a3655 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -300,8 +300,11 @@ static void mana_gd_ring_doorbell(struct gdma_context *gc, u32 db_index,
>  
>  void mana_gd_wq_ring_doorbell(struct gdma_context *gc, struct gdma_queue *queue)
>  {
> +	/* BNIC Spec specifies that client should set 0 for rq.wqe_cnt
> +	 * This value is not used in sq
> +	 */
>  	mana_gd_ring_doorbell(gc, queue->gdma_dev->doorbell, queue->type,
> -			      queue->id, queue->head * GDMA_WQE_BU_SIZE, 1);
> +			      queue->id, queue->head * GDMA_WQE_BU_SIZE, 0);
>  }

This change needs to be explained in the commit message, or should be 
a separate patch.
-- 
pw-bot: cr
