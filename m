Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE9360E486
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Oct 2022 17:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbiJZPdy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Oct 2022 11:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiJZPdw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Oct 2022 11:33:52 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C820130D5C;
        Wed, 26 Oct 2022 08:33:51 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so1904256wmb.0;
        Wed, 26 Oct 2022 08:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rpy3zNSL/y/tD/d9yfVMzCJsLEWWsJUHpcwvg6PJ/JA=;
        b=aLs6Xv1d4O0vutxfGVpdp2GkXhKAFFCBpTTKIpaLKaNBFgTvayaUqXk1XDgk0AdQ9e
         Xuu4QXMqxHIrENeO80HTDblD4zei/5+DjjttaNqP+i3ewtkSkNe/RF/H0gsKvV7hJo9l
         /AQlbwqrIOQXH4b9+43nZNfjK2fHYNI2UmSvSv9sEEg9FQgQcAea44x9hyAgo1dSElqy
         tXCv4Hy0TBEq6YsihpmPP75qZZYaqr1aExQpNPuGAUE4vENVTS1YWvXP0VC+04/LYzSK
         KPvpisvDLwh7pqdyXRVWA+tJ0TmujjZBsuDXcJb0eHPSogknCxh8wzv6YeOBi8MPHT7l
         jddw==
X-Gm-Message-State: ACrzQf3Ohtoex0hxosdCxFUGGCZZh+Is49sGGuD/SbGWQ2RDbvgzzOZe
        R/Lta/X91/GgTJX4EbhXZp3ujRBQQD4=
X-Google-Smtp-Source: AMsMyM4Axp+Fa7CgEJvzWt4sr8Nyu2jUTvpMABm/oeliK2HiYmE8ODrqHBmjg8gr00pbnp2x8ceRlg==
X-Received: by 2002:a05:600c:310a:b0:3c6:f9a6:5a7d with SMTP id g10-20020a05600c310a00b003c6f9a65a7dmr2924497wmo.29.1666798429687;
        Wed, 26 Oct 2022 08:33:49 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d58f2000000b0022b315b4649sm5736607wrd.26.2022.10.26.08.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:33:48 -0700 (PDT)
Date:   Wed, 26 Oct 2022 15:33:47 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v2 1/2] mm/page_reporting: Add checks for
 page_reporting_order param
Message-ID: <Y1lTWxMnk3lnS+3V@liuwe-devbox-debian-v2>
References: <1664447081-14744-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1664517699-1085-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1664517699-1085-2-git-send-email-shradhagupta@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1664517699-1085-2-git-send-email-shradhagupta@linux.microsoft.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Sep 29, 2022 at 11:01:38PM -0700, Shradha Gupta wrote:
> Current code allows the page_reporting_order parameter to be changed
> via sysfs to any integer value.  The new value is used immediately
> in page reporting code with no validation, which could cause incorrect
> behavior.  Fix this by adding validation of the new value.
> Export this parameter for use in the driver that is calling the
> page_reporting_register().
> This is needed by drivers like hv_balloon to know the order of the
> pages reported. Traditionally the values provided in the kernel boot
> line or subsequently changed via sysfs take priority therefore, if
> page_reporting_order parameter's value is set, it takes precedence
> over the value passed while registering with the driver.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

Andrew and other MM reviewers, can I get an ack / nack for this patch?

> ---
>  mm/page_reporting.c | 50 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index 382958eef8a9..29d67c824fd2 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -11,10 +11,42 @@
>  #include "page_reporting.h"
>  #include "internal.h"
>  
> -unsigned int page_reporting_order = MAX_ORDER;
> -module_param(page_reporting_order, uint, 0644);
> +/* Initialize to an unsupported value */
> +unsigned int page_reporting_order = -1;
> +
> +int page_order_update_notify(const char *val, const struct kernel_param *kp)
> +{
> +	/*
> +	 * If param is set beyond this limit, order is set to default
> +	 * pageblock_order value
> +	 */
> +	return  param_set_uint_minmax(val, kp, 0, MAX_ORDER-1);
> +}
> +
> +const struct kernel_param_ops page_reporting_param_ops = {
> +	.set = &page_order_update_notify,
> +	/*
> +	 * For the get op, use param_get_int instead of param_get_uint.
> +	 * This is to make sure that when unset the initialized value of
> +	 * -1 is shown correctly
> +	 */
> +	.get = &param_get_int,
> +};
> +
> +module_param_cb(page_reporting_order, &page_reporting_param_ops,
> +			&page_reporting_order, 0644);
>  MODULE_PARM_DESC(page_reporting_order, "Set page reporting order");
>  
> +/*
> + * This symbol is also a kernel parameter. Export the page_reporting_order
> + * symbol so that other drivers can access it to control order values without
> + * having to introduce another configurable parameter. Only one driver can
> + * register with the page_reporting driver for the service, so we have just
> + * one control parameter for the use case(which can be accessed in both
> + * drivers)
> + */
> +EXPORT_SYMBOL_GPL(page_reporting_order);
> +
>  #define PAGE_REPORTING_DELAY	(2 * HZ)
>  static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
>  
> @@ -330,10 +362,18 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
>  	}
>  
>  	/*
> -	 * Update the page reporting order if it's specified by driver.
> -	 * Otherwise, it falls back to @pageblock_order.
> +	 * If the page_reporting_order value is not set, we check if
> +	 * an order is provided from the driver that is performing the
> +	 * registration. If that is not provided either, we default to
> +	 * pageblock_order.
>  	 */
> -	page_reporting_order = prdev->order ? : pageblock_order;
> +
> +	if (page_reporting_order == -1) {
> +		if (prdev->order > 0 && prdev->order <= MAX_ORDER)
> +			page_reporting_order = prdev->order;
> +		else
> +			page_reporting_order = pageblock_order;
> +	}
>  
>  	/* initialize state and work structures */
>  	atomic_set(&prdev->state, PAGE_REPORTING_IDLE);
> -- 
> 2.37.2
> 
