Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815521B2250
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2020 11:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDUJHK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 21 Apr 2020 05:07:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39059 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgDUJHK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 21 Apr 2020 05:07:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id b11so15543815wrs.6;
        Tue, 21 Apr 2020 02:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OApgUDHOmjUQMN+Xg9vaPzXx/XkuJ1d8P0kWX1KFmuo=;
        b=HIGNg2v6TN1WDPb3O0zMnn0NQ3YiXRXpZOn3eIoHv+mXdqqyHtBes3YG8xu2egZl3j
         eLFYXOgakX0/5R1C5HSKRHxsenNhG7QgZ4QQ0O/A6ZImwakfMEzpCnjdd02VYb4TSL2M
         IfEOErNqGsAyo8fyRasIR/AZfsymvG/EC3nCrDOxWxxCTFybOrvuPs5HrLv1tB4QRgou
         ibuYf5ptHcQHx6wnVo2psPNLO/BjZM453ZdRIZwEla4+Bp0bGcezOIt8oUPcq2vq9yZK
         AjACrQ6AdRSfUX0hE69xvEAOGIrwMiPOGXob1ezmbziwKYLzgMeKaOJMgKHTslDFxgeq
         qYpA==
X-Gm-Message-State: AGi0PuZUBQCy5Tm549iW5eenbXnORr3B//p6ciX79Ldx6je8U/hMkkG9
        2RSBzfxhdZbPCe9ckglWX+m5qsSW
X-Google-Smtp-Source: APiQypLmq7hNT2lRAkk8C/XtVOSchv0MAtJmj05a6Q93atotAeok+5HKF5GhyiNx7W7SS2ry0KWHkQ==
X-Received: by 2002:adf:ab18:: with SMTP id q24mr19382949wrc.214.1587460028014;
        Tue, 21 Apr 2020 02:07:08 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id k184sm2655942wmf.9.2020.04.21.02.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 02:07:06 -0700 (PDT)
Date:   Tue, 21 Apr 2020 10:07:04 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: Move AEOI determination to architecture
 dependent code
Message-ID: <20200421090704.gypbtaiplde7ebbq@debian>
References: <20200420164926.24471-1-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420164926.24471-1-mikelley@microsoft.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Apr 20, 2020 at 09:49:26AM -0700, Michael Kelley wrote:
> Hyper-V on ARM64 doesn't provide a flag for the AEOI recommendation
> in ms_hyperv.hints, so having the test in architecture independent
> code doesn't work. Resolve this by moving the check of the flag
> to an architecture dependent helper function. No functionality is
> changed.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-fixes. Thanks.

> ---
>  arch/x86/include/asm/mshyperv.h | 2 ++
>  drivers/hv/hv.c                 | 6 +-----
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 1c42ecbe75cb..d30805ed323e 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -35,6 +35,8 @@ typedef int (*hyperv_fill_flush_list_func)(
>  	rdmsrl(HV_X64_MSR_SINT0 + int_num, val)
>  #define hv_set_synint_state(int_num, val) \
>  	wrmsrl(HV_X64_MSR_SINT0 + int_num, val)
> +#define hv_recommend_using_aeoi() \
> +	(!(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED))
>  
>  #define hv_get_crash_ctl(val) \
>  	rdmsrl(HV_X64_MSR_CRASH_CTL, val)
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 6098e0cbdb4b..533c8b82b344 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -184,11 +184,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  
>  	shared_sint.vector = HYPERVISOR_CALLBACK_VECTOR;
>  	shared_sint.masked = false;
> -	if (ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED)
> -		shared_sint.auto_eoi = false;
> -	else
> -		shared_sint.auto_eoi = true;
> -
> +	shared_sint.auto_eoi = hv_recommend_using_aeoi();
>  	hv_set_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
>  
>  	/* Enable the global synic bit */
> -- 
> 2.18.2
> 
