Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD41638D70
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Nov 2022 16:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiKYP3E (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Nov 2022 10:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKYP3D (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Nov 2022 10:29:03 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DC420991
        for <linux-hyperv@vger.kernel.org>; Fri, 25 Nov 2022 07:29:02 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id t1so3717521wmi.4
        for <linux-hyperv@vger.kernel.org>; Fri, 25 Nov 2022 07:29:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0d7tuWHsJyJxa6+wq5CIoWIyNI37HdwH/FzbNT12MrQ=;
        b=ZCLC7ZDQJujmSa0jMEmLOmxXGBT18anu8HRD3wWmEMqQebwesEnWIMwB0N3+1KDxJG
         WqXQGSwDtqmixJxeXSIsqj3yleDNkDT3tjQHtrfuhBg6nzKwT3v6z/hnrjOm357htA0k
         fwjPu386KO2CCm1QFGxikAYbF/6xRcukHw7MCSouEynVi40BkuwOaL73U6hasHvOxXnf
         ZjtTet+3rsC9gl4ybciY4+PkObOBLcGHP0mN7bAe5m05tCd+pZDDe+MGAUDHs/da1weq
         Vkmq8mNdc07y1JhHV9FX2Q76wieBqGhjk5fF9xy2ATS9uRcJdVOYrArgcGoaqA98YZuH
         i9eA==
X-Gm-Message-State: ANoB5pnC4POaRrj7LUmR31XyQIUX9KdaL+SR4R4FUTotsNYRcdVsYPGJ
        tYNx350Zaccardsv2mAjpic=
X-Google-Smtp-Source: AA0mqf6OJbVdhG1YC+eDAlVcpTzUvQNCDf/rDzeA9gaOfWdGYf6svbRKtdlEmq1kipJA12MZdERKTA==
X-Received: by 2002:a05:600c:4a09:b0:3cf:b545:596 with SMTP id c9-20020a05600c4a0900b003cfb5450596mr14307191wmp.49.1669390141028;
        Fri, 25 Nov 2022 07:29:01 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003cf57329221sm10333973wms.14.2022.11.25.07.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 07:29:00 -0800 (PST)
Date:   Fri, 25 Nov 2022 15:28:58 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Gaurav Kohli <gauravkohli@linux.microsoft.com>
Cc:     kys@microsoft.com, decui@microsoft.com, haiyangz@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-hyperv@vger.kernel.org, wei.liu@kernel.org,
        bp@alien8.de
Subject: Re: [PATCH] x86/hyperv: Remove unregister syscore call from hyperv
 cleanup
Message-ID: <Y4DfOq94C4sPWM5+@liuwe-devbox-debian-v2>
References: <1669267391-9809-1-git-send-email-gauravkohli@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669267391-9809-1-git-send-email-gauravkohli@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Nov 23, 2022 at 09:23:11PM -0800, Gaurav Kohli wrote:
> Hyperv cleanup codes comes under panic path where preemption and irq

Please use "Hyper-V" throughout.

> is already disabled. So calling of unregister_syscore_ops which has mutex
> from hyperv cleanup might schedule out the thread and never comes back.
> 

While on paper this looks problematic -- have you seen this issue
triggered in real life?

This looks to be only triggered when there is another thread already
holding the mutex, which seems rather rare in the life cycle of the
machine?

> To prevent the same remove unwanted unregister_syscore_ops function call.
> 
> Signed-off-by: Gaurav Kohli <gauravkohli@linux.microsoft.com>
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index f49bc3ec76e6..c050de69dfde 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -537,7 +537,12 @@ void hyperv_cleanup(void)
>  	union hv_x64_msr_hypercall_contents hypercall_msr;
>  	union hv_reference_tsc_msr tsc_msr;
>  
> -	unregister_syscore_ops(&hv_syscore_ops);
> +	/*
> +	 * Avoid unregister_syscore_ops(&hv_syscore_ops) from cleanup code,
> +	 * as this is only called in crash path where irq and preemption disabled.
> +	 * If we add this, there is a chance that this get scheduled out due to mutex
> +	 * in unregister_syscore_ops and never comes back.
> +	 */

There is no need to document things we don't do, right?

>  
>  	/* Reset our OS id */
>  	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
> -- 
> 2.17.1
> 
