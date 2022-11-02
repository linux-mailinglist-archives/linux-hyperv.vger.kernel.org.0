Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541D86162EA
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Nov 2022 13:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiKBMpp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Nov 2022 08:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiKBMpo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Nov 2022 08:45:44 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E797829C9D;
        Wed,  2 Nov 2022 05:45:41 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so1198780wmg.2;
        Wed, 02 Nov 2022 05:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYSGjCBJjK1FjuLHWeKpyY1fs1Dib8GQvBgPpz9GX5A=;
        b=1he3GESyidvLiL9z1hfFW5urexgMO3Ymh/FlhJNZKwE8z6ixi9MqVC+lmkKWgEOJeh
         On3ktN9OOIM8iOF3ViR8uDwHSMKf335KdIjx0bWvaVLae6DnIqUctaI9Ub5DmtjcfR4J
         pvL/9n/e1FwmMr+pFe5GWjmL0+efA5j0WJn+9ZLIAfyZcjdtjhmRd9E39mE0dvQ0xwAA
         W8LsCBzg/EkRtaWflO6U4UPLQ56Hr9GS9rcFJIvbwLtArH1fWv2uQRM8tkeMBXB2v4Fq
         ajIaTnibPrLJqeMk3nZ2NdIDmwBtJ0a3Zp/ylav8s3rBw5Ox3nfyVLs8LpwAJlrHUOEN
         u4Uw==
X-Gm-Message-State: ACrzQf2ZxnmaJB5yc3ZkLDxhnOEZQQWH2dtkdSqd7Pr2oXTWSbkLUL3K
        qGHjOHuTCkn9kX53h6UsAxo=
X-Google-Smtp-Source: AMsMyM5fC+ddhkrK5/t8pj4rHKDsATGSESc7efT2y0LjPRYnwFY+4ZcWjoHHVoWsMam5xgI4SSL4Jg==
X-Received: by 2002:a05:600c:4588:b0:3c6:f8b2:dd34 with SMTP id r8-20020a05600c458800b003c6f8b2dd34mr25239602wmo.178.1667393140347;
        Wed, 02 Nov 2022 05:45:40 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m36-20020a05600c3b2400b003cf47556f21sm2258584wms.2.2022.11.02.05.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 05:45:39 -0700 (PDT)
Date:   Wed, 2 Nov 2022 12:45:32 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 3/4] drivers/clocksource/hyper-v: Use TSC PFN getter to
 map vvar page
Message-ID: <Y2JmbH3k2pdIaUJV@liuwe-devbox-debian-v2>
References: <166732356767.9827.4925884794177179249.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <166732387510.9827.8987757583900408743.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166732387510.9827.8987757583900408743.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Nov 01, 2022 at 05:31:15PM +0000, Stanislav Kinsburskii wrote:
> From: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>
> 
> Instead of converting the virtual address to physical directly.
> This is a precursor patch for the upcoming support for TSC page mapping into
> hyper-v root partition, which address will be defined by the hypervisor and

Please use "Microsoft Hypervisor" instead of "hyper-v".

Also, it should be "Hyper-V" not "hyper-v" in the future.

> mapped into the kernel.
> 
> Signed-off-by: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>
> CC: Andy Lutomirski <luto@kernel.org>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Borislav Petkov <bp@alien8.de>
> CC: Dave Hansen <dave.hansen@linux.intel.com>
> CC: x86@kernel.org
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: "K. Y. Srinivasan" <kys@microsoft.com>
> CC: Haiyang Zhang <haiyangz@microsoft.com>
> CC: Wei Liu <wei.liu@kernel.org>
> CC: Dexuan Cui <decui@microsoft.com>
> CC: Daniel Lezcano <daniel.lezcano@linaro.org>
> CC: linux-kernel@vger.kernel.org
> CC: linux-hyperv@vger.kernel.org
> ---
>  arch/x86/entry/vdso/vma.c          |    7 +++----
>  drivers/clocksource/hyperv_timer.c |    3 ++-
>  include/clocksource/hyperv_timer.h |    6 ++++++
>  3 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> index 311eae30e089..6976416b2c9f 100644
> --- a/arch/x86/entry/vdso/vma.c
> +++ b/arch/x86/entry/vdso/vma.c
> @@ -210,11 +210,10 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
>  					pgprot_decrypted(vma->vm_page_prot));
>  		}
>  	} else if (sym_offset == image->sym_hvclock_page) {
> -		struct ms_hyperv_tsc_page *tsc_pg = hv_get_tsc_page();
> +		pfn = hv_get_tsc_pfn();
>  
> -		if (tsc_pg && vclock_was_used(VDSO_CLOCKMODE_HVCLOCK))
> -			return vmf_insert_pfn(vma, vmf->address,
> -					virt_to_phys(tsc_pg) >> PAGE_SHIFT);
> +		if (pfn && vclock_was_used(VDSO_CLOCKMODE_HVCLOCK))
> +			return vmf_insert_pfn(vma, vmf->address, pfn);

hv_get_tsc_pfn() can return 0. You will insert PFN 0 into the page
table. I think you should check if the PFN is valid.

>  	} else if (sym_offset == image->sym_timens_page) {
>  		struct page *timens_page = find_timens_vvar_page(vma);
>  
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index d447bc99a399..635c14c1e3bf 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -369,10 +369,11 @@ static union {
>  static struct ms_hyperv_tsc_page *tsc_page = &tsc_pg.page;
>  static unsigned long tsc_pfn;
>  
> -static unsigned long hv_get_tsc_pfn(void)
> +unsigned long hv_get_tsc_pfn(void)
>  {
>  	return tsc_pfn;
>  }
> +EXPORT_SYMBOL_GPL(hv_get_tsc_pfn);
>  
>  struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
>  {
> diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
> index b3f5d73ae1d6..3078d23faaea 100644
> --- a/include/clocksource/hyperv_timer.h
> +++ b/include/clocksource/hyperv_timer.h
> @@ -32,6 +32,7 @@ extern void hv_stimer0_isr(void);
>  
>  extern void hv_init_clocksource(void);
>  
> +extern unsigned long hv_get_tsc_pfn(void);
>  extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
>  
>  static inline notrace u64
> @@ -90,6 +91,11 @@ hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
>  }
>  
>  #else /* CONFIG_HYPERV_TIMER */
> +static inline unsigned long hv_get_tsc_pfn(void)
> +{
> +	return 0;
> +}
> +
>  static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
>  {
>  	return NULL;
> 
> 
