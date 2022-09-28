Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF4C5EDE72
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Sep 2022 16:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiI1OIp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 28 Sep 2022 10:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbiI1OIo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 28 Sep 2022 10:08:44 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8414564C2;
        Wed, 28 Sep 2022 07:08:43 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so2348079wmr.1;
        Wed, 28 Sep 2022 07:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/ybRaGWU0laVlDOhJoQj+bu5dznyAXvrYdYe0lJBF/0=;
        b=j0wJ98yPWa9EhlX4Sa+nbR8q7ZymjDBoAQRFqbsO1yenXW1XEtB2XE+OQ6Bjt1jiCY
         sBUvgy/YVaahsWoZzhDjaA5qVH64HfROwVq1X0Om57p+d3pbFfLrDkfKFkOplW1aIZQj
         nXbUt86Nu7MsaUHG+zphQw4LsDwBGUpd7BQpwAhUT2mrPYzj5IIO2upSI8aqWk55xMOM
         xM+fHNcuQG5AygfxXUlFASqpo38nQHLeYXWFGK8W2NM2ehkoedI5x+viqse+qXT6vswp
         a0L8lbMwm3ad+Jc4nGl7dExsc2Iy6pf3lZjRDg/mRx77UjaR4a/cPi5MBbnVCT5sUjh/
         deig==
X-Gm-Message-State: ACrzQf3xm11123xCkyAIDiFTlFoL6yUrtf1YUvn9kjruf3WuHOBYXkVY
        1hmQ4RSGp0dB0StbPPkjOkE=
X-Google-Smtp-Source: AMsMyM4QaHTDYYaKwURnBwFp4DowrK3i0/ypshg4DfKuQlPNQJNP0MImc6rerj2aNEPsinvO1p9bGw==
X-Received: by 2002:a7b:cc85:0:b0:3b4:9fc7:cd4d with SMTP id p5-20020a7bcc85000000b003b49fc7cd4dmr6815217wma.68.1664374122332;
        Wed, 28 Sep 2022 07:08:42 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t15-20020a5d42cf000000b00228c483128dsm5081927wrr.90.2022.09.28.07.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:08:42 -0700 (PDT)
Date:   Wed, 28 Sep 2022 14:08:40 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Zhao Liu <zhao1.liu@linux.intel.com>
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86/hyperv: Replace kmap() with kmap_local_page()
Message-ID: <YzRVaJA0EyfcVisW@liuwe-devbox-debian-v2>
References: <20220928095640.626350-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928095640.626350-1-zhao1.liu@linux.intel.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 28, 2022 at 05:56:40PM +0800, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> kmap() is being deprecated in favor of kmap_local_page()[1].
> 
> There are two main problems with kmap(): (1) It comes with an overhead as
> mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap's pool wraps and it might block when the mapping space is fully
> utilized until a slot becomes available.
> 
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and are still valid.
> 
> In the fuction hyperv_init() of hyperv/hv_init.c, the mapping is used in a
> single thread and is short live. So, in this case, it's safe to simply use
> kmap_local_page() to create mapping, and this avoids the wasted cost of
> kmap() for global synchronization.
> 

The kmap call in that function is not performance critical in any way,
and at this point in the initialization process I don't expect there to
be any contention, so the downside of kmap is not really a concern here.

That being said, kmap getting deprecated is a good enough reason to
switch to kmap_local_page. And I appreciate this well-written,
well-reasoned commit message.

I will apply it to hyperv-next later -- I doubt people will object to
this change, but just in case.

Thanks,
Wei.

> In addtion, the fuction hyperv_init() checks if kmap() fails by BUG_ON().
> From the original discussion[2], the BUG_ON() here is just used to
> explicitly panic NULL pointer. So still keep the BUG_ON() in place to check
> if kmap_local_page() fails. Based on this consideration, memcpy_to_page()
> is not selected here but only kmap_local_page() is used.
> 
> Therefore, replace kmap() with kmap_local_page() in hyperv/hv_init.c.
> 
> [1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com
> [2]: https://lore.kernel.org/lkml/20200915103710.cqmdvzh5lys4wsqo@liuwe-devbox-debian-v2/
> 
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> ---
> Suggested by credits.
> 	Dave: Referred to his comments about whether kmap() can fail and the
> 	      suggestion to keep BUG_ON() in place.
> 	Ira: Referred to his task documentation and review comments about
> 	     keeping BUG_ON() for kmap_local_page().
> 	Fabio: Stole some of his boiler plate commit message.
> ---
>  arch/x86/hyperv/hv_init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 3de6d8b53367..72fe46eb183f 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -459,13 +459,13 @@ void __init hyperv_init(void)
>  		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>  
>  		pg = vmalloc_to_page(hv_hypercall_pg);
> -		dst = kmap(pg);
> +		dst = kmap_local_page(pg);
>  		src = memremap(hypercall_msr.guest_physical_address << PAGE_SHIFT, PAGE_SIZE,
>  				MEMREMAP_WB);
>  		BUG_ON(!(src && dst));
>  		memcpy(dst, src, HV_HYP_PAGE_SIZE);
>  		memunmap(src);
> -		kunmap(pg);
> +		kunmap_local(dst);
>  	} else {
>  		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
>  		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> -- 
> 2.34.1
> 
