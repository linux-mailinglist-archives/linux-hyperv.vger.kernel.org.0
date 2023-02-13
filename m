Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2390969480B
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Feb 2023 15:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjBMO3O (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Feb 2023 09:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjBMO3C (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Feb 2023 09:29:02 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2321C312;
        Mon, 13 Feb 2023 06:28:48 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id a2so12435212wrd.6;
        Mon, 13 Feb 2023 06:28:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lok3ZLhsjP8W54qn1OxpKnwWM1NZsZOK2mTg9EECtAE=;
        b=q+FftsCwi23qepmTi/BY+T68vSu+LR/50frlQOR2724HDV8iVEkvX31QRhAnvwcA8m
         7v2NkGZnmKhujVH9o+q9+3vkHqerXKjH6dBVeYoYU4i0mQj84Kuv/dGDaBo0tiLgNlNi
         t0COKNI1vXBuDm1v76pHHZ5vUvppYZb2mpJgi6ZggbUtcBd7TFVUK6/Jh+WjFd224gtK
         /IMFudtBKKvjVEh6i8UVlUH/NjK2H0OU8eQ+8XFu2KpjfxnOQtrxzxNo3vz3sNxEsGs5
         RC9qwy9cS+NMj//+QwEdmmUOnhZ71mtFB5yihdYSCs///50f8uOZ1rM6GiQMPbWbuohP
         pfcg==
X-Gm-Message-State: AO0yUKV9RMYK6KIXOzl1RqAixApiGiIYfBCXH1ewgDcj9yhGkJYCyoFr
        MKjncYxfngCOHOyi+uci1Sp+m3LrKo4=
X-Google-Smtp-Source: AK7set+cPxOD96d2gWM2mJKxosOBibOVuQAR8mgbWoc8QvmcQ0xKEUYwlQUDB4PHTo/o3RZooj62Rg==
X-Received: by 2002:a5d:5267:0:b0:2c5:5234:882c with SMTP id l7-20020a5d5267000000b002c55234882cmr5553194wrc.7.1676298526561;
        Mon, 13 Feb 2023 06:28:46 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d4312000000b002c54d970fd8sm6552523wrq.36.2023.02.13.06.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 06:28:45 -0800 (PST)
Date:   Mon, 13 Feb 2023 14:28:29 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, wei.liu@kernel.org, jinankjain@linux.microsoft.com,
        mikelley@microsoft.com, kys@microsoft.com,
        Tianyu.Lan@microsoft.com, haiyangz@microsoft.com,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Subject: Re: [PATCH] x86/hyperv: Fix hv_get/set_register for nested bringup
Message-ID: <Y+pJDbMu8WEPFnEm@liuwe-devbox-debian-v2>
References: <1675980172-6851-1-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675980172-6851-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

A few comments on style.

On Thu, Feb 09, 2023 at 02:02:52PM -0800, Nuno Das Neves wrote:
> hv_get_nested_reg only translates SINT0, resulting in the wrong sint
> being registered by nested vmbus.

Please put a blank line between paragraphs.

> Fix the issue with new utility function hv_is_sint_reg.
> While at it, improve clarity of hv_set_non_nested_register and hv_is_synic_reg.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  arch/x86/include/asm/mshyperv.h | 11 +++++++----
>  arch/x86/kernel/cpu/mshyperv.c  |  8 ++++----
>  2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 9ae1a344536b..684c547c1cca 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -225,10 +225,13 @@ extern bool hv_isolation_type_snp(void);
>  
>  static inline bool hv_is_synic_reg(unsigned int reg)
>  {
> -	if ((reg >= HV_REGISTER_SCONTROL) &&
> -	    (reg <= HV_REGISTER_SINT15))
> -		return true;
> -	return false;
> +	return (reg >= HV_REGISTER_SCONTROL) &&
> +	       (reg <= HV_REGISTER_SINT15);
> +}

Please put a new line here.

I can fix these issues too if you don't end up sending a new version due
to other issues.

Jinank, please take a look. The code looks sensible to me, but I would
like you to have a look too.

Thanks,
Wei.

> +static inline bool hv_is_sint_reg(unsigned int reg)
> +{
> +	return (reg >= HV_REGISTER_SINT0) &&
> +	       (reg <= HV_REGISTER_SINT15);
>  }
>  
>  u64 hv_get_register(unsigned int reg);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 0ceb6d1f9c3c..6bd344e1200f 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -44,6 +44,9 @@ struct ms_hyperv_info ms_hyperv;
>  #if IS_ENABLED(CONFIG_HYPERV)
>  static inline unsigned int hv_get_nested_reg(unsigned int reg)
>  {
> +	if (hv_is_sint_reg(reg))
> +		return reg - HV_REGISTER_SINT0 + HV_REGISTER_NESTED_SINT0;
> +
>  	switch (reg) {
>  	case HV_REGISTER_SIMP:
>  		return HV_REGISTER_NESTED_SIMP;
> @@ -53,8 +56,6 @@ static inline unsigned int hv_get_nested_reg(unsigned int reg)
>  		return HV_REGISTER_NESTED_SVERSION;
>  	case HV_REGISTER_SCONTROL:
>  		return HV_REGISTER_NESTED_SCONTROL;
> -	case HV_REGISTER_SINT0:
> -		return HV_REGISTER_NESTED_SINT0;
>  	case HV_REGISTER_EOM:
>  		return HV_REGISTER_NESTED_EOM;
>  	default:
> @@ -80,8 +81,7 @@ void hv_set_non_nested_register(unsigned int reg, u64 value)
>  		hv_ghcb_msr_write(reg, value);
>  
>  		/* Write proxy bit via wrmsl instruction */
> -		if (reg >= HV_REGISTER_SINT0 &&
> -		    reg <= HV_REGISTER_SINT15)
> +		if (hv_is_sint_reg(reg))
>  			wrmsrl(reg, value | 1 << 20);
>  	} else {
>  		wrmsrl(reg, value);
> -- 
> 2.25.1
> 
