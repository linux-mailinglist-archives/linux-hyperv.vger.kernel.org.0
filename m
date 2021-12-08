Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD0846D68E
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Dec 2021 16:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhLHPQQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Dec 2021 10:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbhLHPQQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Dec 2021 10:16:16 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98D7C061746;
        Wed,  8 Dec 2021 07:12:44 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so4202403pjb.1;
        Wed, 08 Dec 2021 07:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=LIFot1kuJKaDo2ERTnjJa+YAnRee4XeIz0i7Bu8IHyY=;
        b=UfRrmPYx8LAwu9fVmKCDQf1/CJGMn6Ujzn3/0UGUhZyB21zFlzr8+YbXqdHtFilkJp
         vfcyoyLoccOSdMes1hQtPZbIJ//LipFwapH2OI5I7gkm1W07sQ+htGgArlYxDC/HV0ZH
         Mj0WW1aM/SJvp6Ech8yqDO//tqlyiqFxuW8S7fvNQ1e/rrMunSgNT2gOAw2PFTnNXk6T
         u3M3PYrDaxMRNtsS5tJLQIajZwwwXGAhB+e0AZ9vwSFw7WHSDtpJzSMbC7iAxuVmyA4i
         unQgBzvNdXEKwSoc6B2ku8VvmrfjR+2o1DdySasHM0MVQuQxWZVzIZDcWGvDBQE+1d1q
         lOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=LIFot1kuJKaDo2ERTnjJa+YAnRee4XeIz0i7Bu8IHyY=;
        b=qyTuJ0lxl99Z4Ytd8a4j/Bv6y/hcBy+XnyCnrk2RL3EitYREF0ruZNhrNY8zh6xZRE
         puAOeLyYMSuw2iIqceqngssUWlEIq9jPfU08uFzGTpINjgXwdw8fFodsWv/NHBwuEArO
         QK6rtoaxbd92az5EaJHjQ+cNFayAWIQPDo0dRd+LEhvVoakUpcbG211pByFy6RG5kOpQ
         v5u3He7zHjFJVdArOdPmT2DDcdLapyiAsYmBgwT1O3djOuCY7E8CplytjSCUfyPRxlrm
         dApZczp3YpEUplNheTMrU4nSYfEJsDlOz6bla7H3RjwO7O0vlgaWF7VA2q1c+KJgrfCh
         9qDw==
X-Gm-Message-State: AOAM531cXT3fUalYQqpiU6RX/ecF4aKuPL+XB/HnCKCiCNhj7W3w0KQL
        WKs9SoIJWANQFpVSV3DFmLY=
X-Google-Smtp-Source: ABdhPJxPm0MpsTdkxvb8JIykqKarYeWvhh9jzsUOfLwh3/pl50sTcT99R2JNqB+DnFxEkW96VRl+eg==
X-Received: by 2002:a17:90b:4a8e:: with SMTP id lp14mr7836001pjb.224.1638976364302;
        Wed, 08 Dec 2021 07:12:44 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
        by smtp.gmail.com with ESMTPSA id i2sm4106421pfg.90.2021.12.08.07.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 07:12:43 -0800 (PST)
Message-ID: <70ac7c29-6d04-b08a-f057-0461da19c307@gmail.com>
Date:   Wed, 8 Dec 2021 23:12:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V6.1] x86/hyper-v: Add hyperv Isolation VM check in the
 cc_platform_has()
Content-Language: en-US
From:   Tianyu Lan <ltykernel@gmail.com>
To:     "bp@alien8.de" <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        brijesh.singh@amd.com, konrad.wilk@oracle.com, hch@lst.de,
        wei.liu@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        parri.andrea@gmail.com, dave.hansen@intel.com,
        linux-hyperv@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
        michael.h.kelley@microsoft.com, kys@microsoft.com
References: <20211207075602.2452-3-ltykernel@gmail.com>
 <20211208145228.42048-1-ltykernel@gmail.com>
In-Reply-To: <20211208145228.42048-1-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 12/8/2021 10:52 PM, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> Hyper-V provides Isolation VM which encrypt guest memory. In
> isolation VM, swiotlb bounce buffer size needs to adjust
> according to memory size in the sev_setup_arch(). Add GUEST_MEM_
> ENCRYPT check in the Isolation VM.
> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hi Boris:
	Could you check whether this version is ok with you?

Thanks.

> ---
> Change since v6:
> 	* Change the order in the cc_platform_has() and check sev first.
> 
> Change since v3:
> 	* Change code style of checking GUEST_MEM attribute in the
> 	  hyperv_cc_platform_has().
> ---
>   arch/x86/kernel/cc_platform.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
> index 03bb2f343ddb..6cb3a675e686 100644
> --- a/arch/x86/kernel/cc_platform.c
> +++ b/arch/x86/kernel/cc_platform.c
> @@ -11,6 +11,7 @@
>   #include <linux/cc_platform.h>
>   #include <linux/mem_encrypt.h>
>   
> +#include <asm/mshyperv.h>
>   #include <asm/processor.h>
>   
>   static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
> @@ -58,12 +59,19 @@ static bool amd_cc_platform_has(enum cc_attr attr)
>   #endif
>   }
>   
> +static bool hyperv_cc_platform_has(enum cc_attr attr)
> +{
> +	return attr == CC_ATTR_GUEST_MEM_ENCRYPT;
> +}
>   
>   bool cc_platform_has(enum cc_attr attr)
>   {
>   	if (sme_me_mask)
>   		return amd_cc_platform_has(attr);
>   
> +	if (hv_is_isolation_supported())
> +		return hyperv_cc_platform_has(attr);
> +
>   	return false;
>   }
>   EXPORT_SYMBOL_GPL(cc_platform_has);
> 
