Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F571720771
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jun 2023 18:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbjFBQXE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Jun 2023 12:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236053AbjFBQXD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Jun 2023 12:23:03 -0400
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C8FE59;
        Fri,  2 Jun 2023 09:22:46 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-53fdae76f3aso2057108a12.0;
        Fri, 02 Jun 2023 09:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685722966; x=1688314966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybq1E0/AWbehTk0mJZnJYXKgs4o9xArT4a23WFfiQ5A=;
        b=aEwwURcKkvihTrcM/oDQnCJBw+pLxVLV/dGUvRO7BNgitZfD+AgpESOSDjyeL0MFOa
         Kyzk/FNwegQxeBuTcSYjJS6p/i+lY+HwjTd2eYOJPYcW7wMcr0y5NzlpzYdfe/rRjUpW
         gjQtMSqCfoG1VWD75k7EzPk6tv4zR/6QwEivayM4Ia9M+wJuheKw+IUe9ESvJDjFcbY9
         tY/qkNBbiyb3Yln3bTkM8Nbu+2EYHyoh7je5OF70y1DEg2ZgWb0KPdA20wz+QC9HMuZX
         ohdkFTnWXioMN8GotO87j9yfVM2SNEyO96bF3fh484v5JqBbBMsfTdHnsnG8SRO5bGwz
         p29A==
X-Gm-Message-State: AC+VfDwY1SLEIRHdYqoQZc4pHWmuoxe+m64ASFjAt5iadk9dL/FNhyeF
        U6pOnQ1nUaO+rin70PXJMAI=
X-Google-Smtp-Source: ACHHUZ5bal7f1R4NsfLHjxpmhYiCmeq+6BPmIVRY0nxw01uEcus/uBJYLY5d58DFuRKHfGQetu3ctg==
X-Received: by 2002:a17:903:247:b0:1b0:3f89:9836 with SMTP id j7-20020a170903024700b001b03f899836mr504514plh.22.1685722966095;
        Fri, 02 Jun 2023 09:22:46 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902ec8a00b001ac8e0ea157sm1569545plg.144.2023.06.02.09.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 09:22:45 -0700 (PDT)
Date:   Fri, 2 Jun 2023 16:22:44 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, hpa@zytor.com
Subject: Re: [PATCH] x86/hyperv: add noop functions to x86_init mpparse
 functions
Message-ID: <ZHoXVAvof+STaIxI@liuwe-devbox-debian-v2>
References: <1685709712-13752-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1685709712-13752-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jun 02, 2023 at 05:41:52AM -0700, Saurabh Sengar wrote:
> In !ACPI system, there is no way to disable CONFIG_X86_MPPARSE.
> When CONFIG_X86_MPPARSE is enabled for VTL2, the kernel will
> scan low memory looking for MP tables. Don't allow this, because
> low memory is controlled by VTL0 and may contain actual valid
> tables for VTL0, which can confuse the VTL2 kernel.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_vtl.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 1ba5d3b99b16..ea21d897b5da 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -23,6 +23,10 @@ void __init hv_vtl_init_platform(void)
>  	x86_init.irqs.pre_vector_init = x86_init_noop;
>  	x86_init.timers.timer_init = x86_init_noop;
>  
> +	/* Avoid searching for BIOS MP tables */
> +	x86_init.mpparse.find_smp_config = x86_init_noop;
> +	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
> +

The code looks fine.

Can you expand the commit message a bit so that people who are not
familiar with VTL and your setup can understand what's going on?

Thanks,
Wei.

>  	x86_platform.get_wallclock = get_rtc_noop;
>  	x86_platform.set_wallclock = set_rtc_noop;
>  	x86_platform.get_nmi_reason = hv_get_nmi_reason;
> -- 
> 2.34.1
> 
