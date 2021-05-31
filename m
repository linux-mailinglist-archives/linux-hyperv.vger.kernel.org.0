Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F006395954
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 May 2021 12:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhEaK7a (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 31 May 2021 06:59:30 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:45709 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhEaK7R (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 31 May 2021 06:59:17 -0400
Received: by mail-wr1-f42.google.com with SMTP id z8so5351396wrp.12;
        Mon, 31 May 2021 03:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lUL1ckOtYUUu49NTJDbLWfsk5Pbl8htShAqQr1AxFVU=;
        b=se1jO6U3+XxHwJmhipgf1NsC8CcnF+RzJVQM/Wf/ETOqyWY7WzeuUGMqC3T9SwBwlT
         pRfFBL2Y5TJCcXM2dCwmO7UUgmn/8JZpVcLMMXqHZVB3ik86WL5LVj89OtpgsPiJtGwD
         9ivOsIp9rwyL3lB9tqlr09hgcdzuPK30+k049KCNindgwc9/1XPZ2Ngq6nvN5XwAyiOz
         KgwvTXS9IRG0ngyBD71+jfT0VEpkNFJ5KzYgwvFV5o4jOTKs3gcO5E67RIdKfx+Oyi5A
         29+DTO7XGdTZOtKB/U29EMfjJXU8/HWZYjCrOHyLYMMgWbi0cOsBinmw2dkbOfVqN2hZ
         6Dgg==
X-Gm-Message-State: AOAM5305UAZoXSLS28rY9f5Puqz0svON1aFl3YAmuerzUJbf7YZReYgV
        NNhhQcfCcI79+2o8ve4n070p+fMEouE=
X-Google-Smtp-Source: ABdhPJzSIDi+OxRdbvKGBc+oXnUYRs5+jaanTyK4UCoEgKtb1jbNbur7+jUpkDYhAi7419ADAmKgdw==
X-Received: by 2002:a05:6000:cb:: with SMTP id q11mr21382633wrx.13.1622458655090;
        Mon, 31 May 2021 03:57:35 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q20sm16250953wrf.45.2021.05.31.03.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 03:57:34 -0700 (PDT)
Date:   Mon, 31 May 2021 10:57:32 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, nunodasneves@linux.microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] x86/hyperv: LP creation with lp_index on same CPU-id
Message-ID: <20210531105732.muzbpk4yksttsfwz@liuwe-devbox-debian-v2>
References: <20210531074046.113452-1-kumarpraveen@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531074046.113452-1-kumarpraveen@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, May 31, 2021 at 01:10:46PM +0530, Praveen Kumar wrote:
> The hypervisor expects the lp_index to be same as cpu-id during LP creation
> This fix correct the same, as cpu_physical_id can give different cpu-id.

Code looks fine to me, but the commit message can be made clearer.

"""
The hypervisor expects the logical processor index to be the same as
CPU's id during logical processor creation. Using cpu_physical_id
confuses Microsoft Hypervisor's scheduler. That causes the root
partition not boot when core scheduler is used.

This patch removes the call to cpu_physical_id and uses the CPU index
directly for bringing up logical processor. This scheme works for both
classic scheduler and core scheduler.

Fixes: 333abaf5abb3 (x86/hyperv: implement and use hv_smp_prepare_cpus)
"""

No action is required from you. If you are fine with this commit message
I can incorporate it and update the subject line when committing this
patch.

> 
> Signed-off-by: Praveen Kumar <kumarpraveen@linux.microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 22f13343b5da..4fa0a4280895 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -236,7 +236,7 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
>  	for_each_present_cpu(i) {
>  		if (i == 0)
>  			continue;
> -		ret = hv_call_add_logical_proc(numa_cpu_node(i), i, cpu_physical_id(i));
> +		ret = hv_call_add_logical_proc(numa_cpu_node(i), i, i);
>  		BUG_ON(ret);
>  	}
>  
> -- 
> 2.25.1
> 
