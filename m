Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EF62B0253
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Nov 2020 10:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgKLJ4V (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Nov 2020 04:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgKLJ4U (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Nov 2020 04:56:20 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B0EC0613D1
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2020 01:56:20 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id b6so5318108wrt.4
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2020 01:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cxDZR78f1uAjoaTSqfFbkuzSwbFVGDkZXidPHX71G9c=;
        b=YJ0+2ZMBF11Z542eqUsAqitgHb1xPMZ9lech+gtY3w1F7OShr8zrOCrXG/V2z/Vf9D
         HvJMT0pS3sKdFvG56bx1LvN6uF/lhDOzA1YfuOcJrkfOS77zNBxHMGj8IusEA8/Evn9n
         vEUDFgaNl0eXFe71Zx5ivyXt/FVmjekvELTABnl8IThNTg4mQZES6Ls1Sj+/CCnAaW8s
         D/poUG+CS3XKDKNfiUrnWUKSQX2FNYipld7UOIAeSpgaQ152qnUGHktwJPgARaTmEEWL
         eZN+kAZ3YTV4KiBAUS62tIvHl3nYE2Ii0u3zoEFmkOd5nNkEQTgKsjtihGwlp/GcxvrL
         G9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cxDZR78f1uAjoaTSqfFbkuzSwbFVGDkZXidPHX71G9c=;
        b=L2QMUX/BewdXftPG0b0fG2vSrMf2hTEhY71XCzXB4lsVGhW2bCKCtbpbbTvEpCN/Lw
         6dD51TEt03rFTr8J5/7073gGZoKlW0BzBgGUeFLipHPcRKrgcNmXZQivxDBDNrF3C1iC
         SCBF5vCcHkO9ZzGSnJCarfOSlIwxyIvspTpA3FrFK9c0fgP0HeVpPDwXKbymV9HBnR2t
         AVxMemIcDs2SB9ttDlft1nzkoJPpgqEitinWOogrY6mAROThFKqZI+ryQ2iHVrc5tB3a
         UeB5IlKLgmj2hsjpPsyJwPW41TYrWUSgbu3hUUCxlSNUUIppyC2Fq4lvJGt4WFffNayo
         A4Yg==
X-Gm-Message-State: AOAM530AxxdK7rgOYPifg+yHGbExgXaeMVp5mzua5NOhHygFsJ8nRcHB
        70s/BTdbVVnTOIiR5xYHrUsOyw==
X-Google-Smtp-Source: ABdhPJwZ8/k2DYgb9fv+4YPP3KOxKbE1pra7CozavXciwAz8421GIRgYfLL5qZ+6yrj+dSeMgUX0Pw==
X-Received: by 2002:adf:9d44:: with SMTP id o4mr36796016wre.229.1605174979204;
        Thu, 12 Nov 2020 01:56:19 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6971:b700:3764:fa96? ([2a01:e34:ed2f:f020:6971:b700:3764:fa96])
        by smtp.googlemail.com with ESMTPSA id m126sm5866401wmm.0.2020.11.12.01.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 01:56:18 -0800 (PST)
Subject: Re: [PATCH v2 05/17] clocksource/hyperv: use MSR-based access if
 running as root
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-6-wei.liu@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3527e98a-faab-2360-f521-aa04bbe92edf@linaro.org>
Date:   Thu, 12 Nov 2020 10:56:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105165814.29233-6-wei.liu@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 05/11/2020 17:58, Wei Liu wrote:
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---

I would like to apply this patch but the changelog is too short (one line).

Please add a small paragraph (no need to resend just answer here, I will
amend the log myself.

>  drivers/clocksource/hyperv_timer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index ba04cb381cd3..269a691bd2c4 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -426,6 +426,9 @@ static bool __init hv_init_tsc_clocksource(void)
>  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
>  		return false;
>  
> +	if (hv_root_partition)
> +		return false;
> +
>  	hv_read_reference_counter = read_hv_clock_tsc;
>  	phys_addr = virt_to_phys(hv_get_tsc_page());
>  
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
