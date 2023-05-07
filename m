Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1002C6F9773
	for <lists+linux-hyperv@lfdr.de>; Sun,  7 May 2023 10:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjEGILB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 7 May 2023 04:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEGILA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 7 May 2023 04:11:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3C71161E;
        Sun,  7 May 2023 01:10:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA45760F85;
        Sun,  7 May 2023 08:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1E3C433D2;
        Sun,  7 May 2023 08:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683447058;
        bh=14gt07e2i3xEmFnLE+5SPgbvGJF6N9cFNjqQFSOAoWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f0fLK7L6ZqGuFLkVQVQMw5hbM4Yjj2QAgpv3mHx/kycnIyYy20xe/apIZLbRehQ+e
         QJoi8a0X2LmQnJtWV568Hpj6cTGPEbIZKnSykR7YflPQaOlIazkQGx6wI0YIPNJYNv
         Ppn3Wjyoh4b3RMNv8qD/0CAnkiRuJdpvwg8wrRF8qyde/M4BTMCjqSKV9kvuvu4pIM
         +dnzHAM7bC1FlcbSGHMPbnn9D84iX4pelRrCg2F7+Qu30mTngWD5gp6Y58LzsNePFi
         36GauoyVbhfRyhHejBWLYoPv9Jq6ZZEiLwqPNMdruDGC+SBLTs9Bw0N2IsG4BhTz8T
         y5NPpUb8uei8Q==
Date:   Sun, 7 May 2023 11:10:53 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     longli@microsoft.com
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-rdma@vger.kernel.org,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mana_ib: Use v2 version of cfg_rx_steer_req to
 enable RX coalescing
Message-ID: <20230507081053.GD525452@unreal>
References: <1683312708-24872-1-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683312708-24872-1-git-send-email-longli@linuxonhyperv.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, May 05, 2023 at 11:51:48AM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> With RX coalescing, one CQE entry can be used to indicate multiple packets
> on the receive queue. This saves processing time and PCI bandwidth over
> the CQ.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/qp.c |  5 ++++-
>  include/net/mana/mana.h         | 17 +++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)

Why didn't you change mana_cfg_vport_steering() too?

> 
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
> index 54b61930a7fd..83c768f96506 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -13,7 +13,7 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
>  				      u8 *rx_hash_key)
>  {
>  	struct mana_port_context *mpc = netdev_priv(ndev);
> -	struct mana_cfg_rx_steer_req *req = NULL;
> +	struct mana_cfg_rx_steer_req_v2 *req = NULL;

There is no need in NULL here, req is going to be overwritten almost
immediately.

Thanks

>  	struct mana_cfg_rx_steer_resp resp = {};
>  	mana_handle_t *req_indir_tab;
>  	struct gdma_context *gc;
> @@ -33,6 +33,8 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
>  	mana_gd_init_req_hdr(&req->hdr, MANA_CONFIG_VPORT_RX, req_buf_size,
>  			     sizeof(resp));
>  
> +	req->hdr.req.msg_version = GDMA_MESSAGE_V2;
> +
>  	req->vport = mpc->port_handle;
>  	req->rx_enable = 1;
>  	req->update_default_rxobj = 1;
> @@ -46,6 +48,7 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
>  	req->num_indir_entries = MANA_INDIRECT_TABLE_SIZE;
>  	req->indir_tab_offset = sizeof(*req);
>  	req->update_indir_tab = true;
> +	req->cqe_coalescing_enable = true;
>  
>  	req_indir_tab = (mana_handle_t *)(req + 1);
>  	/* The ind table passed to the hardware must have
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index cd386aa7c7cc..f8314b7c386c 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -596,6 +596,23 @@ struct mana_cfg_rx_steer_req {
>  	u8 hashkey[MANA_HASH_KEY_SIZE];
>  }; /* HW DATA */
>  
> +struct mana_cfg_rx_steer_req_v2 {
> +	struct gdma_req_hdr hdr;
> +	mana_handle_t vport;
> +	u16 num_indir_entries;
> +	u16 indir_tab_offset;
> +	u32 rx_enable;
> +	u32 rss_enable;
> +	u8 update_default_rxobj;
> +	u8 update_hashkey;
> +	u8 update_indir_tab;
> +	u8 reserved;
> +	mana_handle_t default_rxobj;
> +	u8 hashkey[MANA_HASH_KEY_SIZE];
> +	u8 cqe_coalescing_enable;
> +	u8 reserved2[7];
> +}; /* HW DATA */
> +
>  struct mana_cfg_rx_steer_resp {
>  	struct gdma_resp_hdr hdr;
>  }; /* HW DATA */
> -- 
> 2.17.1
> 
