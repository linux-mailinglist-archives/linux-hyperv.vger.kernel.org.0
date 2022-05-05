Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEF651C43D
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 May 2022 17:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381422AbiEEPvL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 May 2022 11:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381430AbiEEPvI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 May 2022 11:51:08 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9489D5A0A7;
        Thu,  5 May 2022 08:47:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y3so9475858ejo.12;
        Thu, 05 May 2022 08:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6sJ8UuODEy3NC6wyCpHZf8GiAWg9BWqDIv7/vSFvVBs=;
        b=EjOOhWbYDU3SdlmPcoe+jlVMvl5YgLqzID/surXAgZRU4Xo6aBfLbci+MMGBB79Ud+
         NWSXjGHGXczwvdDuoNM3PWnrCmoff6Lj2TooAT5BnhuXlGzOPv3erGWba6WXCQR9rA7o
         vCi96/ZmSXQFrAlOcuMQWsV6dTqMelYLsi/jQos6sxomVR/Kvq4qlM9c798YdGVBnm78
         QM8oFkVOLGKGPSPE513RfEg+/609Z+pMWdbFNc0gGxEzTSIjadoWnYkFt6kH/WKm4NQY
         29m9CLPpl+7t7me7yckFjFiw/bO+0nERMSuEaRQ54FSRBKyCJjj7DoHLqfV5ivddoNI+
         Dipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6sJ8UuODEy3NC6wyCpHZf8GiAWg9BWqDIv7/vSFvVBs=;
        b=ANKVDvV6zDXx69lq61d9vrwtF/atkF/bsUrLZ235zRrRogm2ipJAwDHbFiCZKAnPTa
         lRle3w9AjnkjuyYq1L8P3PvMMVcvuxLLdr6rRIOZJblTW/krYLe0QES8Th+kO8BHB+w/
         8HYMxVktXkRAhlCnZXshzawDNhP7Ys2vM3VaOSWYBYq2rif0RgOYuGitsFUS4BKQMxVo
         eOCFaV0YsAdVIqcBXU87nHlHqF95x7YA9K2j/wV4wHigQ4vvFLnGhpGduyxoR5+Zu/nZ
         Mwj67np3ZE/b1HWiRgtUmmJecqdTCThTcZi5qlCJhiSTCcOOhEz7NpIyDODKjP0hnege
         RPJw==
X-Gm-Message-State: AOAM530yJcu83AE+TT39Vk7Prq50GXuXXxSMh8to78OCLFhzyGzG1wtJ
        sI20s194aTjlHDVww2ca7Pg=
X-Google-Smtp-Source: ABdhPJxwkONT0UWZFN8XHbEChQ886c6yFdJ4cQycMR2HBIpwM0AaoQ8mPzUfyK93Ixo9YYGEt/8gfQ==
X-Received: by 2002:a17:907:60d6:b0:6f5:39f:c62d with SMTP id hv22-20020a17090760d600b006f5039fc62dmr2435315ejc.718.1651765646953;
        Thu, 05 May 2022 08:47:26 -0700 (PDT)
Received: from anparri (host-194-243-14-89.business.telecomitalia.it. [194.243.14.89])
        by smtp.gmail.com with ESMTPSA id cm9-20020a0564020c8900b00428148d19besm980793edb.14.2022.05.05.08.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 08:47:25 -0700 (PDT)
Date:   Thu, 5 May 2022 17:47:17 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, brijesh.singh@amd.com,
        venu.busireddy@oracle.com, michael.roth@amd.com,
        Tianyu.Lan@microsoft.com, thomas.lendacky@amd.com, jroedel@suse.de,
        michael.h.kelley@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com
Subject: Re: [PATCH] x86/Hyper-V: Add SEV negotiate protocol support in
 Isolation VM
Message-ID: <20220505154717.GA3526@anparri>
References: <20220505131502.402259-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505131502.402259-1-ltykernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, May 05, 2022 at 09:15:02AM -0400, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> Hyper-V Isolation VM code uses sev_es_ghcb_hv_call() to read/write MSR
> via GHCB page. The SEV-ES guest should negotiate GHCB version before
> reading/writing MSR via GHCB page. Expose sev_es_negotiate_protocol()
> and sev_es_terminate() from AMD SEV code and negotiate GHCB version in
> hyperv_init_ghcb() fro Hyper-V Isolation VM.
> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>

Applied to tip's x86/sev and checked that this can fix the regression (to
be introduced) by commit 2ea29c5abbc2 ("x86/sev: Save the negotiated GHCB
version"):

Tested-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>

Nits: (in the commit message) fro -> for, Isolation VM -> Isolated VM

Thanks,
  Andrea


> ---
>  arch/x86/hyperv/hv_init.c    | 8 ++++++++
>  arch/x86/include/asm/sev.h   | 6 ++++++
>  arch/x86/kernel/sev-shared.c | 4 ++--
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 8b392b6b7b93..56e2c34e7d64 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -29,6 +29,7 @@
>  #include <clocksource/hyperv_timer.h>
>  #include <linux/highmem.h>
>  #include <linux/swiotlb.h>
> +#include <asm/sev.h>
>  
>  int hyperv_init_cpuhp;
>  u64 hv_current_partition_id = ~0ull;
> @@ -70,6 +71,13 @@ static int hyperv_init_ghcb(void)
>  	ghcb_base = (void **)this_cpu_ptr(hv_ghcb_pg);
>  	*ghcb_base = ghcb_va;
>  
> +	/* Negotiate GHCB Version. */
> +	if (!sev_es_negotiate_protocol())
> +		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_PROT_UNSUPPORTED);
> +
> +	/* Write ghcb page back after negotiating protocol. */
> +	wrmsrl(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
> +	VMGEXIT();
>  	return 0;
>  }
>  
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 19514524f0f8..ad69c1dc081b 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -161,6 +161,9 @@ extern enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
>  					  struct es_em_ctxt *ctxt,
>  					  u64 exit_code, u64 exit_info_1,
>  					  u64 exit_info_2);
> +extern bool sev_es_negotiate_protocol(void);
> +extern void sev_es_terminate(unsigned int set, unsigned int reason);
> +
>  static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs)
>  {
>  	int rc;
> @@ -226,6 +229,9 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
>  {
>  	return -ENOTTY;
>  }
> +
> +static bool sev_es_negotiate_protocol(void) { return false; }
> +static void sev_es_terminate(unsigned int set, unsigned int reason) { }
>  #endif
>  
>  #endif
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 2b4270d5559e..bffc38f0d5ed 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -86,7 +86,7 @@ static bool __init sev_es_check_cpu_features(void)
>  	return true;
>  }
>  
> -static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
> +void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
>  {
>  	u64 val = GHCB_MSR_TERM_REQ;
>  
> @@ -137,7 +137,7 @@ static void snp_register_ghcb_early(unsigned long paddr)
>  		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_REGISTER);
>  }
>  
> -static bool sev_es_negotiate_protocol(void)
> +bool sev_es_negotiate_protocol(void)
>  {
>  	u64 val;
>  
> -- 
> 2.25.1
> 
