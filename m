Return-Path: <linux-hyperv+bounces-148-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E249D7A9CBE
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Sep 2023 21:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 622AFB26EE6
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Sep 2023 19:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A534F66BF3;
	Thu, 21 Sep 2023 18:35:26 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3947D6A990
	for <linux-hyperv@vger.kernel.org>; Thu, 21 Sep 2023 18:35:24 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC33B10939
	for <linux-hyperv@vger.kernel.org>; Thu, 21 Sep 2023 11:35:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-405361bba99so8426385e9.2
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Sep 2023 11:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1695321320; x=1695926120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KW8ptBjfzraMHf44Xf+Faj+9o+1k3zhlihjZp+x+Tf8=;
        b=FIPUiHtrekX2UOl9biltg0R5wGP7Qw9b3dQpvf7bF4Q8We45aM6izAC2wacD9y+xAU
         W8Ry4y3iKXu7brgGAADG723i8JorTH0HoNruwFrSn/q30iJ+j9fjNIpdIuQwoeFToikO
         0bl5D2yMknKM2M9NY6W/9YYLkdpspriTUpZStrkQksZSSWnWGMnReQ5Z6E8AnM2gCb5N
         fA79VyV1cGrAyET++/97vPQPBBBD734rowmPSrk2LR1hnkBqWJMjgxpUZpcXvGSD0VOT
         YsO+NtiFy7pr9wzKEEEEUUuV1ONQFmyuXIL6O/MbW0UHMU6A/kXlOXf8yOp6KtLn5bhe
         Yvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321320; x=1695926120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KW8ptBjfzraMHf44Xf+Faj+9o+1k3zhlihjZp+x+Tf8=;
        b=tzSCR41LDTEk9N+RoJwUBZiDT77WmjeW5MEZsahq7yxQXY1nqJe5zzNU76rzEMKNEg
         u6TW/aVg9V0KmuhsV0FvU+RcwlqIBMYCizaz2I1Y+k6JX4n/u39AjuPq4hSN9h2vNIiM
         pKJSGoPjHACI6SIb+ioTSmMWklaF5fRy8ey5SUYqJKhrzlOunGOQuokFrT6PY5u/qG0H
         B8UF84ix1czeXVlYfibFialn43qUKO1Bxk5vOmr/niCsJyJurMJPJWUMCe2ixI97RRgu
         HVwO0QxafTIc28yaIpBHd4hNUY1EWJ4rOEv5RCiR5Dro5xDzeLlWkNm5KQp0Bj7NIXAM
         DZPA==
X-Gm-Message-State: AOJu0Yz1Jk/Wrya2l4eeh4mbdCPvRqm4j8kP3R+qOQ9i8d5SOPQLeS8c
	YvTnXCY3U2w5D8Kyjzp+7N6XvwQkvABRXYfyDdNCPg==
X-Google-Smtp-Source: AGHT+IGB+xWpEg1KqRLjENdA7FRVUtuQvkZPkq5ESDKlloikTKnib1nrIsJDstUiJVr1a0TFc10UJA==
X-Received: by 2002:a05:6512:3e17:b0:502:d35b:5058 with SMTP id i23-20020a0565123e1700b00502d35b5058mr4844512lfv.4.1695280645785;
        Thu, 21 Sep 2023 00:17:25 -0700 (PDT)
Received: from ?IPV6:2003:f6:af0b:f500:9282:fc17:35d3:acf0? (p200300f6af0bf5009282fc1735d3acf0.dip0.t-ipconnect.de. [2003:f6:af0b:f500:9282:fc17:35d3:acf0])
        by smtp.gmail.com with ESMTPSA id dy6-20020a05640231e600b0052718577668sm420330edb.11.2023.09.21.00.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 00:17:25 -0700 (PDT)
Message-ID: <0e86d1cb-a042-7d80-b410-0cc4b31744aa@grsecurity.net>
Date: Thu, 21 Sep 2023 09:17:24 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] x86/hyperv: Remove hv_vtl_early_init initcall
Content-Language: en-US, de-DE
To: Saurabh Sengar <ssengar@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 mikelley@microsoft.com
Cc: ssengar@microsoft.com
References: <1695185552-19910-1-git-send-email-ssengar@linux.microsoft.com>
From: Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <1695185552-19910-1-git-send-email-ssengar@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 20.09.23 06:52, Saurabh Sengar wrote:
> There has been cases reported where HYPERV_VTL_MODE is enabled by mistake,
> on a non Hyper-V platforms. This causes the hv_vtl_early_init function to
> be called in an non Hyper-V/VTL platforms which results the memory
> corruption.
> 
> Remove the early_initcall for vhv_vtl_early_init and call it at the end of
> hyperv_init to make sure it is never called in a non Hyper-V platform by
> mistake.
> 
> Reported-by: Mathias Krause <minipli@grsecurity.net>
> Closes: https://lore.kernel.org/lkml/40467722-f4ab-19a5-4989-308225b1f9f0@grsecurity.net/
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> This patch is dependent on :
> https://lore.kernel.org/lkml/1695182675-13405-1-git-send-email-ssengar@linux.microsoft.com/
> 
>  arch/x86/hyperv/hv_init.c       | 3 +++
>  arch/x86/hyperv/hv_vtl.c        | 3 +--
>  arch/x86/include/asm/mshyperv.h | 2 ++
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index f0128fd4031d..608f4fe41fb7 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -610,6 +610,9 @@ void __init hyperv_init(void)
>  	/* Find the VTL */
>  	ms_hyperv.vtl = get_vtl();
>  
> +	if (ms_hyperv.vtl > 0) /* non default VTL */
> +		hv_vtl_early_init();
> +

As the kernel's console will already be initialized when this code gets
executed, the possible panic() in hv_vtl_early_init() will actually be
visible, thereby...

>  	return;
>  
>  clean_guest_os_id:
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 36a562218010..999f5ac82fe9 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -215,7 +215,7 @@ static int hv_vtl_wakeup_secondary_cpu(int apicid, unsigned long start_eip)
>  	return hv_vtl_bringup_vcpu(vp_id, start_eip);
>  }
>  
> -static int __init hv_vtl_early_init(void)
> +int __init hv_vtl_early_init(void)
>  {
>  	/*
>  	 * `boot_cpu_has` returns the runtime feature support,
> @@ -230,4 +230,3 @@ static int __init hv_vtl_early_init(void)
>  
>  	return 0;
>  }
> -early_initcall(hv_vtl_early_init);
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 033b53f993c6..83019c3aaae9 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -340,8 +340,10 @@ static inline u64 hv_get_non_nested_register(unsigned int reg) { return 0; }
>  
>  #ifdef CONFIG_HYPERV_VTL_MODE
>  void __init hv_vtl_init_platform(void);
> +int __init hv_vtl_early_init(void);
>  #else
>  static inline void __init hv_vtl_init_platform(void) {}
> +static int __init hv_vtl_early_init(void) {}
>  #endif
>  
>  #include <asm-generic/mshyperv.h>

Acked-by: Mathias Krause <minipli@grsecurity.net>

Thanks!

