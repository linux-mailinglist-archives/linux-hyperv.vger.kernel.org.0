Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C48449430D
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jan 2022 23:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiASWc6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Jan 2022 17:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiASWc6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Jan 2022 17:32:58 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3F8C061574;
        Wed, 19 Jan 2022 14:32:58 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z22so19945112edd.12;
        Wed, 19 Jan 2022 14:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dB81rBGjzH3Uwh+fac3tDo0v+l951xpXPiqr/ZZyMYo=;
        b=Smx+IJx/hidTWiy5wBwlWwGdHCV8qlTH0yM6NbaW0ypD5s27vLNbHqdIsWjnubchGa
         YjhosjQxnr3hAZwLzelMtgSZUok5zYUzQc4KxK6zZD4vBn5BhTvfd3jtT71c0h5Nky4H
         +Um3eVzJ/ltkeu8AMMMaPZ1geQZ7vjxQaFmD2+G7739FxjSf9PFGplx+UO6HfCb9uasE
         eaemxPsz3HzHhZpjAHtEDp81QFqmHfsohfC0BPGqT2aHhovAaUwYWpg+hj2VvWMYnZKf
         9ETEmzdXNLFmB9cCFi1MEe/Rd3/pXKMF8gb4almDJruoV1NYXvOqzla83lzNURwbWnPx
         buEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dB81rBGjzH3Uwh+fac3tDo0v+l951xpXPiqr/ZZyMYo=;
        b=0HRw3EusFEGE7RtJFs4Klz3/Djl6U1GomcmKGcq9ep+gtp+nIh0EX8JZN8xFQLR/Sm
         G2yxmxp8WlbGx16XIMSDWYn9DQH1KH0x93QXikPn4sLRJlJB02229jRT/7tH1Kq6ADWY
         CouCdwVtwEf4VhQTDxjx94BWfX5c/3UZ7hMTNi2zOMj+q6709yi6EXXMJDI9m077EmLw
         9zAYj1iqffmN9nAkGfDWgIuu36x5+0d16wd05p9vkn1o23yYUiEp5+AMneI7bc6rkrE+
         KmYV9eLZpDPG9c/xIEEszPzJydOIvC2bO6VjLwHlO4CLRZI65Lrs8FfY3jrfG49whwaV
         gz3Q==
X-Gm-Message-State: AOAM532igfwJGCrOaOuyFRJVFrYlA6P4HMJv4Fio2A6uXP7Rew7MgSeT
        C3cUzS12593+j6F4MdsCdqEjhDpDv+JDIw==
X-Google-Smtp-Source: ABdhPJyZu6OF3g+RGSIFX/4PPfokUmUfjIf9WIDcsDr/g+1SOOGgeImQEZws3FYcEO9Id5/792xO/A==
X-Received: by 2002:a17:907:75dc:: with SMTP id jl28mr26334674ejc.13.1642631576308;
        Wed, 19 Jan 2022 14:32:56 -0800 (PST)
Received: from anparri (host-79-37-66-48.retail.telecomitalia.it. [79.37.66.48])
        by smtp.gmail.com with ESMTPSA id n5sm311492ejg.21.2022.01.19.14.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 14:32:55 -0800 (PST)
Date:   Wed, 19 Jan 2022 23:32:46 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Yanming Liu <yanminglr@gmail.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andres Beltran <lkmlabelt@gmail.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] Drivers: hv: balloon: account for vmbus packet header in
 max_pkt_size
Message-ID: <20220119223246.GA1539@anparri>
References: <20220119202052.3006981-1-yanminglr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119202052.3006981-1-yanminglr@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jan 20, 2022 at 04:20:52AM +0800, Yanming Liu wrote:
> Commit adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V
> out of the ring buffer") introduced a notion of maximum packet size in
> vmbus channel and used that size to initialize a buffer holding all
> incoming packet along with their vmbus packet header. hv_balloon uses
> the default maximum packet size VMBUS_DEFAULT_MAX_PKT_SIZE which matches
> its maximum message size, however vmbus_open expects this size to also
> include vmbus packet header. This leads to 4096 bytes
> dm_unballoon_request messages being truncated to 4080 bytes. When the
> driver tries to read next packet it starts from a wrong read_index,
> receives garbage and prints a lot of "Unhandled message: type:
> <garbage>" in dmesg.
> 
> Allocate the buffer with HV_HYP_PAGE_SIZE more bytes to make room for
> the header.
> 
> Fixes: adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V out of the ring buffer")
> Suggested-by: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Suggested-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Signed-off-by: Yanming Liu <yanminglr@gmail.com>
> ---
> The patch was "[PATCH v2] hv: account for packet descriptor in maximum
> packet size". As pointed out by Michael Kelley [1], other hv drivers
> already overallocate a lot, and hv_balloon is hopefully the only
> remaining affected driver. It's better to just fix hv_balloon. Patch
> summary is changed to reflect this new (much smaller) scope.

hopefully - adeguately describing what/how we "know" (here), it remarks
us that our estimates are empirical (and that people may have different
opinions about "safe" estimates  ;-))

Reviewed-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>

Thanks,
  Andrea


> [1] https://lore.kernel.org/linux-hyperv/CY4PR21MB1586D30C6CEC81EFC37A9848D7599@CY4PR21MB1586.namprd21.prod.outlook.com/
> 
>  drivers/hv/hv_balloon.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index ca873a3b98db..f2d05bff4245 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1660,6 +1660,13 @@ static int balloon_connect_vsp(struct hv_device *dev)
>  	unsigned long t;
>  	int ret;
>  
> +	/*
> +	 * max_pkt_size should be large enough for one vmbus packet header plus
> +	 * our receive buffer size. Hyper-V sends messages up to
> +	 * HV_HYP_PAGE_SIZE bytes long on balloon channel.
> +	 */
> +	dev->channel->max_pkt_size = HV_HYP_PAGE_SIZE * 2;
> +
>  	ret = vmbus_open(dev->channel, dm_ring_size, dm_ring_size, NULL, 0,
>  			 balloon_onchannelcallback, dev);
>  	if (ret)
> -- 
> 2.34.1
> 
