Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2952345CF1
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Mar 2021 12:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhCWLc7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 Mar 2021 07:32:59 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:33528 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhCWLcx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Mar 2021 07:32:53 -0400
Received: by mail-wr1-f52.google.com with SMTP id o16so20411301wrn.0;
        Tue, 23 Mar 2021 04:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wjAUQ3VJ6EHaIXZgTmJ4+pSbbBz03ZgUXwggSRQBomk=;
        b=Nu1eLI3SKxz4cdZd5Z0pvpI94Vo9WkHUGtua99c4hAAcEMJX6fyt32m/UJ02mwBjRr
         bakVVTzGRCGPmhmrKN2l0Uxn02Tofw7UO8QqDb8bhbMrhPvJyppFDyIaWOUI2snUVFvb
         D8n5hKKibsBN8rjnabpDrZQ14PD0/sTUklj4UfwwCIstwWaOy8ircRrR7KEUVWvRVkhA
         2Un+LmOtfoGd6ajDlwp3OqQkuYjqEJeNOxlte0QddNoQDUpmluB/XEBTgJKzF0o1U+vr
         kXy7CqwD6NSmAPXbwIzdwS0SF/rgVmTKIGIe1cWAv3la9nUjJnNpElmrkxGA3t4NzjMx
         MDEg==
X-Gm-Message-State: AOAM531bHEoKhhknL9xLFfO3uo0XVEnMz2QRF5Ng6W3to3g1swUGdJYl
        YOWdT8w9MZM2biRqN68hXDo=
X-Google-Smtp-Source: ABdhPJw58wNANSqmZYOtDCW/n5beyjXu0LSUuwj86TtsZvhrgxrzhpmDsn6hcG194qUHaMcGXmVJqw==
X-Received: by 2002:adf:ea8d:: with SMTP id s13mr3499189wrm.32.1616499172029;
        Tue, 23 Mar 2021 04:32:52 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v2sm2952871wmj.1.2021.03.23.04.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 04:32:51 -0700 (PDT)
Date:   Tue, 23 Mar 2021 11:32:50 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Xu Yihang <xuyihang@huawei.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnny.chenyi@huawei.com
Subject: Re: [PATCH -next] x86: Fix unused variable 'hi'
Message-ID: <20210323113250.ktsfwr2wzjycugyk@liuwe-devbox-debian-v2>
References: <20210318074607.124663-1-xuyihang@huawei.com>
 <20210323025013.191533-1-xuyihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323025013.191533-1-xuyihang@huawei.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 23, 2021 at 10:50:13AM +0800, Xu Yihang wrote:
> Fixes the following W=1 kernel build warning(s):
> arch/x86/hyperv/hv_apic.c:58:15: warning: variable ‘hi’ set but not used [-Wunused-but-set-variable]
> 
> Compiled with CONFIG_HYPERV enabled:
> make allmodconfig ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-
> make W=1 arch/x86/hyperv/hv_apic.o ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-
> 
> HV_X64_MSR_EOI stores on bit 31:0 and HV_X64_MSR_TPR stores in bit 7:0, which means higher
> 32 bits are not really used, therefore  potentially cast to void in order to silent this warning.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xu Yihang <xuyihang@huawei.com>
> ---
>  arch/x86/hyperv/hv_apic.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index 284e73661a18..a8b639498033 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -60,9 +60,11 @@ static u32 hv_apic_read(u32 reg)
>  	switch (reg) {
>  	case APIC_EOI:
>  		rdmsr(HV_X64_MSR_EOI, reg_val, hi);
> +		(void) hi;
>  		return reg_val;
>  	case APIC_TASKPRI:
>  		rdmsr(HV_X64_MSR_TPR, reg_val, hi);
> +		(void) hi;

I would like to remove the space while committing this patch. There is
no need for you to do anything.

Wei.

>  		return reg_val;
>  
>  	default:
> -- 
> 2.17.1
> 
