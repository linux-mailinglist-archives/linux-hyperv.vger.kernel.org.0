Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A834BF6C9
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Feb 2022 11:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiBVK4L (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Feb 2022 05:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiBVK4K (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Feb 2022 05:56:10 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3EC158EA5;
        Tue, 22 Feb 2022 02:55:45 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id s13so3807402wrb.6;
        Tue, 22 Feb 2022 02:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y7HxMsThMoOBPkyDBh3eSq5/erLCvzApa8FVrrE65u8=;
        b=v8eCPY5DK4RY+nIF8PJnkB9QIDMmROtPHSKLkrLic8dluD72FEYE0KfPJKGvlJCBck
         547zQUVc6iF71l61BsAP1KxKjBJ8s976h68X7p8AuQnM7T3p7VbkvSFTbru03y+4gHvv
         n12JMykqciFHJPN82tV/dVMfmoOHlpWaII2qj4yUnOxDvFnFN7xGrBFrVMIOvFbA74bl
         X62s1buDVLpR5PA6PGbtbBd2Lfudf/2Ww6ToZVqxwp2ORWdCuhWovYdOIKxJ/GNQg/wG
         e1QV+GQuaaRgzo5iMA+V/VZkdNtZY95leTbeLTsRdbG71R/uM4TtmRHC7RzhymEQP8IX
         41aQ==
X-Gm-Message-State: AOAM5338gZfq9ybJC9E/se3WOm4UXoQfXu9VfTUd1Z7GDldr9emmIDDQ
        Fh3o9YlCCY5yTHcQaNiqHIk=
X-Google-Smtp-Source: ABdhPJySef3HI9qExb8u5Jn6vqX6dL9kxqWyKmxkP7xqh3IGa/Q5u4Nn16bHmsqgIZwLOk9orkAGBg==
X-Received: by 2002:a05:6000:257:b0:1e3:3a1b:d4ca with SMTP id m23-20020a056000025700b001e33a1bd4camr19155649wrz.112.1645527343828;
        Tue, 22 Feb 2022 02:55:43 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m12-20020a7bce0c000000b0037bed2a6fbfsm2011391wmc.37.2022.02.22.02.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 02:55:43 -0800 (PST)
Date:   Tue, 22 Feb 2022 10:55:41 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, brijesh.singh@amd.com,
        michael.roth@amd.com, jroedel@suse.de, Tianyu.Lan@microsoft.com,
        thomas.lendacky@amd.com, michael.h.kelley@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC FATCH] x86/Hyper-V: Add SEV negotiate protocol support in
 Isolation VM.
Message-ID: <20220222105541.izv4psjychjx5ooq@liuwe-devbox-debian-v2>
References: <20220207160928.111718-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207160928.111718-1-ltykernel@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Feb 07, 2022 at 11:09:28AM -0500, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> Hyper-V Isolation VM code uses sev_es_ghcb_hv_call() to read/write MSR
> via ghcb page. The SEV-ES guest should call the sev_es_negotiate_protocol()
> to negotiate the GHCB protocol version before establishing the GHCB. Call
> sev_es_negotiate_protocol() in the hyperv_init_ghcb().
> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> This patch based on the "Add AMD Secure Nested Paging (SEV-SNP) Guest Support"
> patchset. https://lore.kernel.org/lkml/20220128171804.569796-1-brijesh.singh@amd.com/
> 
>  arch/x86/hyperv/hv_init.c    | 6 ++++++
>  arch/x86/include/asm/sev.h   | 2 ++
>  arch/x86/kernel/sev-shared.c | 2 +-
>  arch/x86/kernel/sev.c        | 4 ++--
>  4 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 24f4a06ac46a..a22303fccf02 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -28,6 +28,7 @@
>  #include <linux/syscore_ops.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <linux/highmem.h>
> +#include <asm/sev.h>
>  
>  int hyperv_init_cpuhp;
>  u64 hv_current_partition_id = ~0ull;
> @@ -69,6 +70,11 @@ static int hyperv_init_ghcb(void)
>  	ghcb_base = (void **)this_cpu_ptr(hv_ghcb_pg);
>  	*ghcb_base = ghcb_va;
>  
> +	sev_es_negotiate_protocol();

The return value should be checked, right?

There is no logical connection between this function call and the wrmsrl
below. Is there new information available after calling
sev_es_negotiate_protocol?

> +
> +	/* Write ghcb page back after negotiating protocol. */
> +	wrmsrl(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
> +	VMGEXIT();
>  	return 0;
>  }
>  
[...]
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 3568b3303314..46c53c4885ee 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -167,12 +167,12 @@ void noinstr __sev_es_ist_exit(void)
>  	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], *(unsigned long *)ist);
>  }
>  
> -static inline u64 sev_es_rd_ghcb_msr(void)
> +inline u64 sev_es_rd_ghcb_msr(void)
>  {
>  	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
>  }
>  
> -static __always_inline void sev_es_wr_ghcb_msr(u64 val)
> +__always_inline void sev_es_wr_ghcb_msr(u64 val)

Why are these needed? They are not used anywhere in this patch.

Thanks,
Wei.

>  {
>  	u32 low, high;
>  
> -- 
> 2.25.1
> 
