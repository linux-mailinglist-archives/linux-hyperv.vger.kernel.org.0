Return-Path: <linux-hyperv+bounces-644-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8B07DA99C
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Oct 2023 23:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B111C2093D
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Oct 2023 21:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323F817754;
	Sat, 28 Oct 2023 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7WiuQcT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2F3610A
	for <linux-hyperv@vger.kernel.org>; Sat, 28 Oct 2023 21:26:31 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45FCCA;
	Sat, 28 Oct 2023 14:26:29 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cacf449c1aso6174665ad.0;
        Sat, 28 Oct 2023 14:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698528389; x=1699133189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+3EhqydIk8cWL76gCn5A4FQeZ+oe6v5e7gK0rC5kDqw=;
        b=P7WiuQcTvNtX2Jtb6KzV5ytOZiqRH6EHOR4x5+8hEi9To9ZbTJExEjfAuOD2zdUsKX
         SbRa3/26tPOg+yZpJcmsszy3Arz86EiCTzn81yhZ8nMHyPjwufyJeBsPI5AKupjsXoh3
         T/Yos47NnHZT/Ovv/Ms9iTZEpOtmP+zUM8viWQUpy+B9nFxlBnJx4jsuh3v7eg43lUiq
         2wXID7miutg6T4JcSS1aVsp3Dnmfm+FzJUHZ09Lcn8HIifqlNWy0BGMWCb6aFnjK0446
         NFl2OvAdGPI55Ge5pPaRkAOBZz3NoP1r+47ppKcO300yjzCTsa7bEaVNAJnT9NTIQBfL
         tsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698528389; x=1699133189;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+3EhqydIk8cWL76gCn5A4FQeZ+oe6v5e7gK0rC5kDqw=;
        b=ofzmEPDQdEljpot6L3CEf9XzpFfU84ppHcJN/gI9p5c8dZndecTRF7L+PhBF+xtkU6
         /FkcjM8WBxwH4OuHerApl+852BoH5D06/arcRCUJX2SvaegL5cWWXUHpNYJ9jqVpWyjb
         jewLQ0FRGzkaWPF7pKfa47+zL/Y6x3r5h06rYGC5Zoiy/GB9awVqCvwm1GOh1utaI3FY
         PpWiEak0+XH0CFwUe/QXhbH4jGFSHOPe8/XukBPzMAaIWFHTS+OKWMq96+7QcPGxuF8O
         uvKam009DCl1Mh27OGKNyzn3LRW3x/pyzxNJtP/JIRySvrM97aLH1YsY6/T8XEkgkb5w
         BjHQ==
X-Gm-Message-State: AOJu0Yx4sqcT/hF9uIsMnh37MzeP+yWPjn1nzoM8djIhd+vvC5ULtjuo
	7IxIJEsqIKnOIJ4vuqY59imgzMs457ex2mTt
X-Google-Smtp-Source: AGHT+IFJhiYxmbbhG89wSadf2t17HGRHnSMUp97sHZ9VZIMeyKHjtgzwFKu3r2YhZVGlGZpMGdFmXQ==
X-Received: by 2002:a17:902:f213:b0:1c4:1cd3:8062 with SMTP id m19-20020a170902f21300b001c41cd38062mr6495445plc.2.1698528389175;
        Sat, 28 Oct 2023 14:26:29 -0700 (PDT)
Received: from [192.168.0.152] ([103.75.161.209])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902c21100b001bbb8d5166bsm3607338pll.123.2023.10.28.14.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Oct 2023 14:26:28 -0700 (PDT)
Message-ID: <19cec6f0-e176-4bcc-95a0-9d6eb0261ed1@gmail.com>
Date: Sun, 29 Oct 2023 02:56:17 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fixing warning cast removes address space '__iomem' of
 expression
Content-Language: en-US
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 Nischala Yelchuri <Nischala.Yelchuri@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>
References: <20231024112832.737832-1-singhabhinav9051571833@gmail.com>
 <SN6PR2101MB16937C421EA9CDF373835360D7A3A@SN6PR2101MB1693.namprd21.prod.outlook.com>
From: Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <SN6PR2101MB16937C421EA9CDF373835360D7A3A@SN6PR2101MB1693.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/23 01:40, Michael Kelley (LINUX) wrote:
> From: Abhinav Singh <singhabhinav9051571833@gmail.com> Sent: Tuesday, October 24, 2023 4:29 AM
>>
> 
> Subject lines usually have a prefix to indicate the area of the kernel
> the patch is for.   We're not always super consistent with the prefixes,
> but you can look at the commit log for a file to see what is
> typically used.  In this case, the prefix is usually "x86/hyperv:"
> 
>>
>> This patch fixes sparse complaining about the removal of __iomem address
>> space when casting the return value of this function ioremap_cache(...)
>> from `void __ioremap*` to `void*`.
> 
> Should avoid wording like "this patch" in commit messages.  See
> the commit message guidelines in the "Describe your changes"
> section of Documentation/process/submitting-patches.rst.  A
> better approach is to just state the problem:  "Sparse complains
> about the removal .....".  Then describe the fix.  Also avoid
> pronouns like "I" or "you".
> 
>>
>> I think there are two way of fixing it, first one is changing the
>> datatype of variable `ghcb_va` from `void*` to `void __iomem*` .
>> Second way of fixing it is using the memremap(...) which is
>> done in this patch.
>>
>> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
>> ---
>>   arch/x86/hyperv/hv_init.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index 21556ad87f4b..c14161add274 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -70,7 +70,7 @@ static int hyperv_init_ghcb(void)
>>
>>   	/* Mask out vTOM bit. ioremap_cache() maps decrypted */
> 
> This comment mentions ioremap_cache().  Since you are changing
> to use memremap() instead, the comment should be updated to
> match.
> 
>>              ghcb_gpa &= ~ms_hyperv.shared_gpa_boundary;
>> -           ghcb_va = (void *)ioremap_cache(ghcb_gpa, HV_HYP_PAGE_SIZE);
>> +          ghcb_va = memremap(ghcb_gpa, HV_HYP_PAGE_SIZE, MEMREMAP_WB);
> 
> As noted in the comment, ioremap_cache() provides a mapping that
> accesses the memory as decrypted.  To be equivalent, the call to
> memremap() should include the MEMREMAP_DEC flag so that it
> also is assured of producing a decrypted mapping.
> 
> Also, corresponding to the current ioremap_cache() call here,
> there's an iounmap() call in hv_cpu_die().   To maintain proper
> pairing, that iounmap() call should be changed to memunmap().
> 
> It turns out there are other occurrences of this same pattern in
> Hyper-V specific code in the Linux kernel.  See hv_synic_enable_regs(),
> for example.Did "sparse" flag the same problem in those
> occurrences?

The particular warning msg for this case is like this "warning: cast 
removes address space '__iomem' of expression". I only saw these warning 
one time inside the arch/x86/ directory.

>It turns out that Nischala Yelchuri at Microsoft is
> concurrently working on fixing this occurrence as well as the
> others we know about in Hyper-V specific code.

So should I continue or not with this patch?

> 
> Michael
> 
>>
>> --
>> 2.39.2
> 

Thanks for taking out the time for reviewing this and giving the 
suggestions.

Thank You,
Abhinav Singh




