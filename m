Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDCF345CD5
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Mar 2021 12:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhCWL3N (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 Mar 2021 07:29:13 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:36455 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhCWL2m (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Mar 2021 07:28:42 -0400
Received: by mail-wm1-f41.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso4774099wmq.1;
        Tue, 23 Mar 2021 04:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8LbqrlY0e/I2k2EOkhIXKnRaA0GFx4v9lyKMDDc0jhM=;
        b=f1FLlsbMCeDeRsxa58vyPQ1q8vczV9sZAbGU36ByNP6zOLe1/tB8hp38918j1ao2Yz
         zCHqVpe5vrxkRKZmzmMhlYB+TXA2Q8cJeV6IEYqv6d/roXmlSs8MrLOiTi7qAb4YdOuL
         b2ic/hjrCgDwqfCS7/UyRAq14Ylr0aFqvneI4MOfliDtvHubSE9tZbYFKDtEHLn2rr4G
         bezx0Yk1w+N06FoRyBXYVLGsaawMpI3jIG0ezdOgNjv9og9su73spg7vGBipDcHzZjKm
         RV6ugVU+lxdmxKzc4oEa6Hlx5jFHfeyjHxY9gNzR+26wDwZA1hFBZh7v0Mk7H2WD4/au
         YtLg==
X-Gm-Message-State: AOAM531BlwzTClCrgVvYHXDgFJLNOqjxE4J5F6d7vhR5dmYLsnaMi56F
        6Oh5c0F+YVklt0mHf2eLX5eXPp+WRNU=
X-Google-Smtp-Source: ABdhPJzfQNTkQtfE9Jt/vjGsMVVTfI4aNamprQvdmWk3kTbMn0ewGjrwQkPpKUx+ONN5WOO2vjw7gg==
X-Received: by 2002:a7b:c0d1:: with SMTP id s17mr2848291wmh.153.1616498920672;
        Tue, 23 Mar 2021 04:28:40 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t1sm23144490wry.90.2021.03.23.04.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 04:28:40 -0700 (PDT)
Date:   Tue, 23 Mar 2021 11:28:38 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video/fbdev: Fix a double free in hvfb_probe
Message-ID: <20210323112838.xrastmol4fnxqxub@liuwe-devbox-debian-v2>
References: <20210323073350.17697-1-lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323073350.17697-1-lyl2019@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Thanks for your patch.

I would like to change the prefix to "video: hyperv_fb:" to be more
specific.

On Tue, Mar 23, 2021 at 12:33:50AM -0700, Lv Yunlong wrote:
> In function hvfb_probe in hyperv_fb.c, it calls hvfb_getmem(hdev, info)
> and return err when info->apertures is freed.
> 
> In the error1 label of hvfb_probe, info->apertures will be freed twice
> by framebuffer_release(info).
> 

I would say "freed for the second time" here. What you wrote reads to me
fraembuffer_release frees the buffer twice all by itself.

> My patch sets info->apertures to NULL after it was freed to avoid
> double free.
> 

I think this approach works. I would like to give other people a chance
to comment though.

Fixes: 3a6fb6c4255c ("video: hyperv: hyperv_fb: Use physical memory for fb on HyperV Gen 1 VMs.")

> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>  drivers/video/fbdev/hyperv_fb.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> index c8b0ae676809..2fc9b507e73a 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -1032,6 +1032,7 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
>  		if (!pdev) {
>  			pr_err("Unable to find PCI Hyper-V video\n");
>  			kfree(info->apertures);
> +			info->apertures = NULL;
>  			return -ENODEV;
>  		}
>  
> @@ -1130,6 +1131,7 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
>  		pci_dev_put(pdev);
>  	}
>  	kfree(info->apertures);
> +	info->apertures = NULL;
>  
>  	return 0;
>  
> @@ -1142,6 +1144,7 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
>  	if (!gen2vm)
>  		pci_dev_put(pdev);
>  	kfree(info->apertures);
> +	info->apertures = NULL;
>  
>  	return -ENOMEM;
>  }
> -- 
> 2.25.1
> 
> 
