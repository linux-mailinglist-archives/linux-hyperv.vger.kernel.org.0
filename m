Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424F835DDFF
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Apr 2021 13:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241941AbhDMLqy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Apr 2021 07:46:54 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:46737 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238852AbhDMLqw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Apr 2021 07:46:52 -0400
Received: by mail-wr1-f48.google.com with SMTP id c15so7177946wro.13;
        Tue, 13 Apr 2021 04:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=viU+fHMEqdW75c5aw+RUzyVT5kieLjfcDxdSRhzyk6k=;
        b=BeWTm08FkCV7S6DNaD7QeKz6P/1J5jCJuDufJs9fJqpKLf2neQ3bRhokUvgMpP45Ow
         5raV3HU3J8nPVk2VpBsbFBC1tE0WzBnz5ZbgzQvTTZh/uvs+iEK+8TToXP2JijabSUgZ
         qlImlKQ26d0lqlRloUPWVW+A4K+H2xmyc4WQUK2h6eJR7AnvA8LmgHHDtLyAsLKRCiSX
         55kndmo6ca0okjjkXrNVin3QzXhj+OahvjuTumO0cxNpfNeSMOkI+OmMLIWz67IUSdgT
         wQA8k2+L5jh9A0GQ7piaA5N4KTynF7yILwmbeNBdiBpo6KODigYc9ucQcaWo9/ZD4fSI
         ZnAQ==
X-Gm-Message-State: AOAM5315MoctdN2ejRRXdCldU34/IZTAkzAQ4vsCFO97dA9cq2ZElB3B
        pHDCPoRtt40NIOrnxfMnDrc=
X-Google-Smtp-Source: ABdhPJw5ejgRiJXW67IP5nLKiW/DmEyAU1cwjnP7B9VkUaVVIFPuFMjWiixtasfgydOEVQ+vpATXag==
X-Received: by 2002:a5d:4f82:: with SMTP id d2mr9977881wru.228.1618314392433;
        Tue, 13 Apr 2021 04:46:32 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id b206sm2226445wmc.15.2021.04.13.04.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 04:46:31 -0700 (PDT)
Date:   Tue, 13 Apr 2021 11:46:30 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Use after free in __vmbus_open()
Message-ID: <20210413114630.szpbtjxidefh566g@liuwe-devbox-debian-v2>
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
> ---
> From static analysis.  Untested etc.  There is almost certainly a good
> reason to add it to the list before checking "newchannel->rescind" but I
> don't know the code well enough to know what the reason is.
> 

AIUI the channel management code requires the message be queued before
posting the message to backend, because processing response is done in
another thread, and might happen before this message is added to the
list if the order is reversed.

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

Looking at similar functions in the same file I think there is indeed an
UAF problem in the original code.

I have not studied this piece of code extensively so I will wait for
others to chime in.

Wei.

>  	}
>  
>  	err = vmbus_post_msg(open_msg,
> -- 
> 2.30.2
> 
