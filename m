Return-Path: <linux-hyperv+bounces-147-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4207A9CA3
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Sep 2023 21:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A57328462E
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Sep 2023 19:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15BB6727A;
	Thu, 21 Sep 2023 18:34:45 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383A966671
	for <linux-hyperv@vger.kernel.org>; Thu, 21 Sep 2023 18:34:40 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2069D62FF
	for <linux-hyperv@vger.kernel.org>; Thu, 21 Sep 2023 11:27:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so163780366b.3
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Sep 2023 11:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1695320833; x=1695925633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+HrO7ldsgAqMO34/GLDqrs/oKiBjOHaDyijQN4RwUM=;
        b=augSRktSCZNcD6JNpeM2IqVcSMln2gwUUSbOJ9F4R+5+sYBocI3a9jgU2g5v5xTwgU
         OsGN2VM0OExTpCtZFqPwSr7RJL335s16i6sHbme1HROuv3G0T3+X7fNbk1pDXE2/oWhe
         /fIBtYpmHCdAvVxEidnLA3jOVd7iZGg2zTXSppwX9kGJPQDGwN1pZrOjXsr386CPqNtI
         7oj+VypYWgqP6W85ryX0aw1MnLUM67hhRqDb2MPe73QKsXzgVyr7NPZgQaCVUTBlO8SY
         SeK73q75ooMbBaXoSGeP9iDfEV5IfqdsYHyCj+y6ZSYLdG7CwMUi/EpPe64GN/dsEJqA
         qc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320833; x=1695925633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+HrO7ldsgAqMO34/GLDqrs/oKiBjOHaDyijQN4RwUM=;
        b=mlu6iwbOVxqyly8bm4MbSPxuixZoFXbQ/GrScIABusDherUbhpQ1gCnyRTxLKlhaCD
         B+Zcp8wcNkjxy2On479T3U9v+Yp4OA8aN4lgeXKFmoamBc+EBmvbv8/Tf0UeKxydS4H1
         6/BUwnLC/nxTidVnG9OX8sOJG4p1JkL/LYb14YX4Q4P2/cmjYm+jdvVbLA5BSnCIltfc
         aygaByXda1eNn2eUeR5/qe+pvAoG1aDLfrkQDZwoWeo5teryEzfrWUJ6CTltZTNj15tU
         viAWZ/LDetW2etnIeSuTJtG7yCoks4MZSLRn9QnDxXxW1011HWEWwPwql0m4lkTXJTk4
         +G/g==
X-Gm-Message-State: AOJu0YztpwKB5+QBs/SEp1X1FnwO1NbbgsATC1Y0olRqYS8RQvME41cx
	KdSAjE150+rTtUp5L62UjYLHPQ==
X-Google-Smtp-Source: AGHT+IFoiM8ZrUT3KpUeDhjFlq2CsLrGEc9c8+nNF8YnzwiEcwY3AeVRUIhAlkjNH2m5vxDQXIrgqg==
X-Received: by 2002:a17:906:2ce:b0:9a5:846d:d81f with SMTP id 14-20020a17090602ce00b009a5846dd81fmr4951426ejk.17.1695320833244;
        Thu, 21 Sep 2023 11:27:13 -0700 (PDT)
Received: from ?IPV6:2003:f6:af0b:f500:9282:fc17:35d3:acf0? (p200300f6af0bf5009282fc1735d3acf0.dip0.t-ipconnect.de. [2003:f6:af0b:f500:9282:fc17:35d3:acf0])
        by smtp.gmail.com with ESMTPSA id k19-20020a170906159300b00985ed2f1584sm1405990ejd.187.2023.09.21.11.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 11:27:12 -0700 (PDT)
Message-ID: <49e81d87-baee-4ba5-873c-ba32615beab0@grsecurity.net>
Date: Thu, 21 Sep 2023 20:27:09 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
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

Missed it in my review, but the kernel bot already noticed it, so....

On 20.09.23 06:52, Saurabh Sengar wrote:
> [...]
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

static inline

>  #endif
>  
>  #include <asm-generic/mshyperv.h>

Thanks,
Mathias

