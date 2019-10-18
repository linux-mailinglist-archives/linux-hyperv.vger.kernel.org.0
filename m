Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 927A7DC2F5
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Oct 2019 12:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408273AbfJRKkC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 18 Oct 2019 06:40:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55148 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404276AbfJRKkC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Oct 2019 06:40:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so5652660wmp.4;
        Fri, 18 Oct 2019 03:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8cE9YDTfQtBVk2+sSkxkP+PZ5kDH44m1/DG3//iG44o=;
        b=OYNjgMNpsPRROwdjGNNiBj0Bqep2u1crh/BSRjgix0UHWSgr2fJ1L8bKKGc3d7jpnj
         Z+dKBQ14uBKmx18drOTZjlpaB33QatRZaujs5ngCsJ9kkGOryUYi2MRCr27Zmr6NrOKf
         QS30UtWmvwHeWpeEIFTzYSu5rtcjJmKh1SoqMhO/t9mcb1kXPtRulK3kLs8j34R6YOuc
         PgiaPkKdNiWbnHnGJfvO/hhDOdd4Jj9S50muTOo3oVJG+Y964TAFXW3TDtGqX9lZjxgI
         l3mk4+JiWZwKROo6Kp+cOIP7WznJETPuABiCsJNCaUCjJ7//Zb/9qrBxxgUNb/tDnLZq
         z5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8cE9YDTfQtBVk2+sSkxkP+PZ5kDH44m1/DG3//iG44o=;
        b=qMmnIHABpoqiEDo34m17U0QbaYJ387f8ZY18GEiRrmWMEgRMfVPFeF0KIvgJ6zJlQb
         BL0gaI6KlAsMLeESKbXDI7kiCVZq3+dLYJYNJEeYS8mK/CdSJ9zp7z1Gvmnfpi8qBTyw
         adxnae2zYVUo3I8NsnSS1H0XEJHIYWFalyulla7yC1Sl7/sdCLN6chFeGsgkPGwcLlYT
         hnntxGduC1ffD8QQzdffanrYrhY9lb0l0zzu7c9QCTvGJxJJMjYTGeP6F4GqScq1voUf
         v7w78pwuJhoGvcLRiErbS4e1AOzqv1h2zAngoHHoDIolEs9T6wH/62+j0ORrrBqGBSuw
         pZHA==
X-Gm-Message-State: APjAAAVIgIBlg1IljbKEPN8BqwdzBGEC0wj4Y+bxgWbBgkZIiphGV1I3
        /XcooBprHKJ+LmQnqDn32Tg=
X-Google-Smtp-Source: APXvYqyDnHioWi04o934RHn2Z8GlYtnNljWkCs5aIV6oDWEoR7Yn8cnG3grrkQrQEqWxnGMD91wneA==
X-Received: by 2002:a05:600c:40f:: with SMTP id q15mr6944692wmb.30.1571395199943;
        Fri, 18 Oct 2019 03:39:59 -0700 (PDT)
Received: from andrea.guest.corp.microsoft.com ([2a01:110:8012:1012:2d5e:8dac:e57c:2507])
        by smtp.gmail.com with ESMTPSA id p12sm5651757wrm.62.2019.10.18.03.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 03:39:59 -0700 (PDT)
Date:   Fri, 18 Oct 2019 12:39:52 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        mikelley@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] x86/hyperv: Fix build error while CONFIG_PARAVIRT=n
Message-ID: <20191018103952.GA29828@andrea.guest.corp.microsoft.com>
References: <20191018082921.28164-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018082921.28164-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Oct 18, 2019 at 04:29:21PM +0800, YueHaibing wrote:
> while CONFIG_PARAVIRT=n, building fails:
> 
> arch/x86/kernel/cpu/mshyperv.c: In function ms_hyperv_init_platform:
> arch/x86/kernel/cpu/mshyperv.c:219:2: error: pv_info undeclared (first use in this function); did you mean pr_info?
>   pv_info.name = "Hyper-V";
>   ^~~~~~~

Ouch, sorry for this...


> 
> Wrap it into a #ifdef to fix this.
> 
> Fixes: 628270ef628a ("x86/hyperv: Set pv_info.name to "Hyper-V"")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Andrea Parri <parri.andrea@gmail.com>

Thanks,
  Andrea


> ---
>  arch/x86/kernel/cpu/mshyperv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index e7f0776..c656d92 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -216,7 +216,9 @@ static void __init ms_hyperv_init_platform(void)
>  	int hv_host_info_ecx;
>  	int hv_host_info_edx;
>  
> +#ifdef CONFIG_PARAVIRT
>  	pv_info.name = "Hyper-V";
> +#endif
>  
>  	/*
>  	 * Extract the features and hints
> -- 
> 2.7.4
> 
> 
