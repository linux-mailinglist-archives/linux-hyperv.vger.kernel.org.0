Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD4C578095
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Jul 2022 13:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiGRLTs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 18 Jul 2022 07:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiGRLTr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 18 Jul 2022 07:19:47 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786DD1EEC6;
        Mon, 18 Jul 2022 04:19:46 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id bk26so16519654wrb.11;
        Mon, 18 Jul 2022 04:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lDWcJ/P2G+Efw9LFUp8QiMuMlTbsXBhsKq/bavJQHeM=;
        b=g/Wn6E52h3yj2pIJtK+5/+7HE/4kdHPuNL7YtASO+gS3mOMVrblVs+QyoIiLCo02JM
         5cZdMO4W6tZUNVqMCIM0+gxMBcu8XMC6mprdToqGcynjx8RVIA6zaNO7xZR5hQHkmKu+
         4YCcaRQe4WrCLb+RkxAjoeVlmOi4FkR/JUUT86O3iu0iRUY8B4JmOW9uPBvvMeKtB4dh
         9RKy6mh8g2Ao52DTY+DbYF8SIK3XoRvy37GzmeN29ygaPjnFvUNLOBMj7uKfYM5OPWm4
         yc5iTu2wFXDzcXzhuNSzKfB1uHoOWGJ64urDhSU8LUQOVfvBcerL5f8K2M76ipFuf4gQ
         ic0g==
X-Gm-Message-State: AJIora8nVQgjj44WgSLT8P84OtxK2UX6wpbsBsFHRU2e4Sbj/+llDJho
        9EiC3wUGwiQns1+r6y1CZ2w=
X-Google-Smtp-Source: AGRyM1vtPvG/lF0R05NYGfGgpWHdLGsL96KB88LHSDGU386hRYmf4Z6F8FK3n+QRj0Z3SyCntVrwtw==
X-Received: by 2002:a05:6000:60a:b0:21d:9451:e91 with SMTP id bn10-20020a056000060a00b0021d94510e91mr22963793wrb.73.1658143184963;
        Mon, 18 Jul 2022 04:19:44 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a16-20020adfdd10000000b0021d6e917442sm12515814wrm.72.2022.07.18.04.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 04:19:44 -0700 (PDT)
Date:   Mon, 18 Jul 2022 11:19:42 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        linux-hyperv@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] Drivers: hv: Fix spelling mistake
 "total_pages_commited" -> "total_pages_committed"
Message-ID: <20220718111942.nf22xsfikwzphfnp@liuwe-devbox-debian-v2>
References: <20220714102634.22184-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714102634.22184-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jul 14, 2022 at 11:26:34AM +0100, Colin Ian King wrote:
> There is a spelling mistake in a seq_printf message. Fix it.
> 
> Fixes: e237eed373cc ("Drivers: hv: Create debugfs file with hyper-v balloon usage information")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Good catch!

I've folded this into the original patch. Thanks.

> ---
>  drivers/hv/hv_balloon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index ba52d3a3e3e3..fdf6decacf06 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1892,7 +1892,7 @@ static int hv_balloon_debug_show(struct seq_file *f, void *offset)
>  	/* pages we have given back to host */
>  	seq_printf(f, "%-22s: %u\n", "pages_ballooned", dm->num_pages_ballooned);
>  
> -	seq_printf(f, "%-22s: %lu\n", "total_pages_commited",
> +	seq_printf(f, "%-22s: %lu\n", "total_pages_committed",
>  				get_pages_committed(dm));
>  
>  	seq_printf(f, "%-22s: %llu\n", "max_dynamic_page_count",
> -- 
> 2.35.3
> 
