Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB99625FD1
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Nov 2022 17:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiKKQup (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Nov 2022 11:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiKKQuo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Nov 2022 11:50:44 -0500
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0322E13E03;
        Fri, 11 Nov 2022 08:50:44 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso5967362wmb.0;
        Fri, 11 Nov 2022 08:50:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOvXDNO49PM7KIqPLjnou7naDaWKpFkuiADPMhOZ5gI=;
        b=kDSC4GqBrDtOsgRomkNQJ+SLalnAOhceF+lq90ubPtuUZE0yurptGyMK0KKRcz1JU1
         M9pVbVedvhNdl5a/nYsBBFu/QJ5GZ2THEZNHEzyLfyD9gvJxGuVmT8+K/IFCrkzZdBuz
         hDBhZbo+IX7h1LQ64iSd/51Gb1z5qctRQT2HpFyMQ6GMG6A2RY1s450tISqU7dKqiyTX
         Jp9p0mhDDpEcdzfV3jN3GobmK9bRjudck9WlPJuucfQFUuAVKsOuZE/Fa7gtktG6iV5f
         YIL1EwrKD6omnGQMnxzJ7nO+EpbO/+WRauJVRtns4tQxvpZHFABTTozuwzFkK9vG76mC
         toAQ==
X-Gm-Message-State: ANoB5pnFq7RI4cE6rkJcdFG2M3PaI0lzGZ/TYTl7DGuVQVGXeS+oNgRC
        4PMO7Kja9zmG2R4PgjtDGUA=
X-Google-Smtp-Source: AA0mqf4QcS3ZEq0og5f/LYnK6wziZVxANgv0ng3LEYHS6q29l8ueZanJfTD08JlZC8plMxB5VwZQlg==
X-Received: by 2002:a1c:cc01:0:b0:3cf:a9c2:2b04 with SMTP id h1-20020a1ccc01000000b003cfa9c22b04mr1884730wmb.152.1668185442522;
        Fri, 11 Nov 2022 08:50:42 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c228600b003cf4d99fd2asm3397453wmf.6.2022.11.11.08.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 08:50:42 -0800 (PST)
Date:   Fri, 11 Nov 2022 16:50:40 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] hv_balloon: Fix committed value in post_status() if
 dynamic memory is disabled
Message-ID: <Y259YF07nSes6zlp@liuwe-devbox-debian-v2>
References: <1667544770-31377-1-git-send-email-shradhagupta@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667544770-31377-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 03, 2022 at 11:52:50PM -0700, Shradha Gupta wrote:
> If Dynamic memory is disabled for VM, the committed value reported by the
> post_status() call by hv_balloon driver includes compute_balloon_floor().
> This is not needed if balloon_up operations or hot_add operations were
> never requested on the VM(or if Dynamic memory was disabled for the VM)
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

Can you put a Fixes: tag here?

You can use git-blame to find out the culprit.

Thanks,
Wei.

> ---
>  drivers/hv/hv_balloon.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index fdf6decacf06..a6f5321d4a2e 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1129,11 +1129,23 @@ static unsigned long compute_balloon_floor(void)
>  
>  static unsigned long get_pages_committed(struct hv_dynmem_device *dm)
>  {
> -	return vm_memory_committed() +
> -		dm->num_pages_ballooned +
> -		(dm->num_pages_added > dm->num_pages_onlined ?
> -		 dm->num_pages_added - dm->num_pages_onlined : 0) +
> -		compute_balloon_floor();
> +	unsigned long pages_committed;
> +
> +	pages_committed = vm_memory_committed();
> +
> +	/*
> +	 * If no balloon_up or hot_add operation was performed do not add
> +	 * num_pages_ballooned, number of pages offline or
> +	 * compute_balloon_floor() to the pages_committed value
> +	 */
> +	if (dm->num_pages_ballooned || dm->num_pages_added) {
> +		pages_committed += dm->num_pages_ballooned +
> +			(dm->num_pages_added > dm->num_pages_onlined ?
> +			 dm->num_pages_added - dm->num_pages_onlined : 0) +
> +			 compute_balloon_floor();
> +	}
> +
> +	return pages_committed;
>  }
>  
>  /*
> -- 
> 2.37.2
> 
