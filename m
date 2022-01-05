Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BBC4859F4
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jan 2022 21:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243991AbiAEUWJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jan 2022 15:22:09 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:35483 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243981AbiAEUWG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jan 2022 15:22:06 -0500
Received: by mail-wm1-f52.google.com with SMTP id v10-20020a05600c214a00b00345e59928eeso2622774wml.0;
        Wed, 05 Jan 2022 12:22:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UK+yHTCDLoYvdAcJv06f7NV5dgtFwTsJAMI8c0LxaJI=;
        b=eWYmg/lBBDEsxBRWdD/P7o9LOUwmlHD0F2DYeQB3ZEolqV3StuQlN6inc4g949mhiv
         N5lD1Vd29PrxqA4kTkcKTi9QIl+hyKzVNA2PKd7yccFk+7GnK94Juq8fOAwUfgHCl2mD
         Yx0ARVw7SFlLcmetYWF8aBsvtZFVCGpngTRQFxw2e7mb0x5BUC4t9BnhNJacHU0fHtbx
         R7kX7gSEd0/3jd1KJlS9ks4FFUz36kRUDLIdeC17RpoZZVO50JhingYjOhJTxXV4lH7k
         Cd3RbSJfuGV6NUaCk8LHFIkGGIPhPlXiJSjhSWQ1E8I5hUjYaERqg9lRq5FuadXJsVGr
         K/Cg==
X-Gm-Message-State: AOAM533v+RZdV5KPdADZB2SnHRS0XO7OZjmb6aq/JcTFC7zUwA8XK/jE
        VgXEzrfGq1LuPRmQ+0gy0z4=
X-Google-Smtp-Source: ABdhPJzKuTpU4FH0VhdYUuruenzfWqA2Yp7Scnif9ohKWhVGSldrl9gDCARTHFH7xUu7WhmyXkLNqw==
X-Received: by 2002:a05:600c:1f19:: with SMTP id bd25mr4338996wmb.42.1641414125375;
        Wed, 05 Jan 2022 12:22:05 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u12sm41306599wrf.60.2022.01.05.12.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 12:22:04 -0800 (PST)
Date:   Wed, 5 Jan 2022 20:22:03 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] Drivers: hv: balloon: Temporary disable the driver
 on ARM64 when PAGE_SIZE != 4k
Message-ID: <20220105202203.evk7uckmephnu3ev@liuwe-devbox-debian-v2>
References: <20220105165028.1343706-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105165028.1343706-1-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 05, 2022 at 05:50:28PM +0100, Vitaly Kuznetsov wrote:
> Hyper-V ballooning and memory hotplug protocol always seems to assume
> 4k page size so all PFNs in the structures used for communication are
> 4k PFNs. In case a different page size is in use on the guest (e.g.
> 64k), things go terribly wrong all over:
> - When reporting statistics, post_status() reports them in guest pages
> and hypervisor sees very low memory usage.
> - When ballooning, guest reports back PFNs of the allocated pages but
> the hypervisor treats them as 4k PFNs.
> - When unballooning or memory hotplugging, PFNs coming from the host
> are 4k PFNs and they may not even be 64k aligned making it difficult
> to handle.
> 
> While statistics and ballooning requests would be relatively easy to
> handle by converting between guest and hypervisor page sizes in the
> communication structures, handling unballooning and memory hotplug
> requests seem to be harder. In particular, when ballooning up
> alloc_balloon_pages() shatters huge pages so unballooning request can
> be handled for any part of it. It is not possible to shatter a 64k
> page into 4k pages so it's unclear how to handle unballooning for a
> sub-range if such request ever comes so we can't just report a 64k
> page as 16 separate 4k pages.
> 

How does virtio-balloon handle it? Does its protocol handle different
page sizes?


> Ideally, the protocol between the guest and the host should be changed
> to allow for different guest page sizes.
> 
> While there's no solution for the above mentioned problems, it seems
> we're better off without the driver in problematic cases.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/hv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 0747a8f1fcee..fb353a13e5c4 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -25,7 +25,7 @@ config HYPERV_UTILS
>  
>  config HYPERV_BALLOON
>  	tristate "Microsoft Hyper-V Balloon driver"
> -	depends on HYPERV
> +	depends on HYPERV && (X86 || (ARM64 && ARM64_4K_PAGES))
>  	select PAGE_REPORTING
>  	help
>  	  Select this option to enable Hyper-V Balloon driver.
> -- 
> 2.33.1
> 
