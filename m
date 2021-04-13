Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DB435E30F
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Apr 2021 17:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhDMPmx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Apr 2021 11:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhDMPmw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Apr 2021 11:42:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F390C061574;
        Tue, 13 Apr 2021 08:42:32 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id e14so26645537ejz.11;
        Tue, 13 Apr 2021 08:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AHJFlkVHWqO1FHapYslC65eJ8g65HylpEtA4GsqBGy0=;
        b=MCeMQdyjPS5cM7ZQQUlD0dVrnTvjDVPjtejlw4q0xEfCKf3ssp5xhTUKa6/B1ffP4P
         7pS/iruAYATcL96nRfAs2e1IRqygmpm0sQDNh7xnr8jaoJjpsmP3cOB3O/y2ARvWx8Df
         iXJwuepC6u3gpzT9+2j7OLGIApcyAxaPeSdm3MCyU/JTRxrhbI06tEugWwY4yfLvPcey
         Ga9+uaiEMGsuEvTPuPPVC2IXRBxd4hDe/QYcJX8b37JqcrLEPws4G75rCXY9fyglrbSt
         FqNI6fv7vBSJ5Ac3UTk0pCMgiI1Y0eBlgr9chsS/8YC1A50U/ok/8uDADkWGGsh+XPOE
         M/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AHJFlkVHWqO1FHapYslC65eJ8g65HylpEtA4GsqBGy0=;
        b=AW5a5Atnz7sEpvSv7mhw7qWbhs5nlWxPEX9oWx16lR0vkdtpevW6IFA30HvJp2DqHz
         kwyiy6YQjKwbJAkAt6kXeJA86b7B2A0kunhH17aTvVUlWMWAgabnqaZZ4w/376JY/f8K
         DcGkAULgZ+2tNcmn63KLfkl/pPQs7d5tRCqqr2PV+8A8sDMXjqo/BBbxk1tgS9SA9m0o
         307Go/01Lz3SVT1oOnzv26Ixn3uKg5TNQlDDWTJcpx3w4jfSTl4aQjfGSCF6ooZBO03c
         yjywkmkEPavK9qJxPahm2qoTKMgP/oaG37G0pVFHn2P7SmbLMpm3bQ/70q7xs215Nxs7
         X9SA==
X-Gm-Message-State: AOAM532shiFHg+gTFUSwiMwM6CZtXf1jnMeVLBFXKuiBJ0n1aJ87msLb
        3dTBVhHbvkaRd5bgmzFrcWkWhmqAbYPCxqGB
X-Google-Smtp-Source: ABdhPJzy5ANQQ8Us5qvmS5XPmsu6fn52o+F19r72vm/W1oVbwUOYaUw2i+0hOUxaLzlRuTSgdACSwA==
X-Received: by 2002:a17:906:4eda:: with SMTP id i26mr10489085ejv.301.1618328550649;
        Tue, 13 Apr 2021 08:42:30 -0700 (PDT)
Received: from anparri (host-95-232-15-7.retail.telecomitalia.it. [95.232.15.7])
        by smtp.gmail.com with ESMTPSA id t14sm8088868ejc.121.2021.04.13.08.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:42:30 -0700 (PDT)
Date:   Tue, 13 Apr 2021 17:42:21 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Use after free in __vmbus_open()
Message-ID: <20210413154221.GA2369@anparri>
References: <YHV3XLCot6xBS44r@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHV3XLCot6xBS44r@mwanda>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 13, 2021 at 01:50:04PM +0300, Dan Carpenter wrote:
> The "open_info" variable is added to the &vmbus_connection.chn_msg_list,
> but the error handling frees "open_info" without removing it from the
> list.  This will result in a use after free.  First remove it from the
> list, and then free it.
> 
> Fixes: 6f3d791f3006 ("Drivers: hv: vmbus: Fix rescind handling issues")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

I had this 'queued' in my list,

Reviewed-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea


> ---
> From static analysis.  Untested etc.  There is almost certainly a good
> reason to add it to the list before checking "newchannel->rescind" but I
> don't know the code well enough to know what the reason is.
> 
>  drivers/hv/channel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index db30be8f9cce..1c5a418c1962 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -653,7 +653,7 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
>  
>  	if (newchannel->rescind) {
>  		err = -ENODEV;
> -		goto error_free_info;
> +		goto error_clean_msglist;
>  	}
>  
>  	err = vmbus_post_msg(open_msg,
> -- 
> 2.30.2
> 
