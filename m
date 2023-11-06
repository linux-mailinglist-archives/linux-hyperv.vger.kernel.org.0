Return-Path: <linux-hyperv+bounces-707-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D067E2891
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Nov 2023 16:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C64EB20BDE
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Nov 2023 15:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC90D28E00;
	Mon,  6 Nov 2023 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQWSzc2g"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D16728DCF
	for <linux-hyperv@vger.kernel.org>; Mon,  6 Nov 2023 15:23:22 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A822134;
	Mon,  6 Nov 2023 07:23:20 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6c343921866so636132b3a.0;
        Mon, 06 Nov 2023 07:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699284199; x=1699888999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qS7e87bvh6ANEDUsn8lN4pszguiB/ZmyAjUwIxwMFWU=;
        b=DQWSzc2gvrzV7MFGWSH1XCp796M1EGBrZlLWnj0uCQxYRVI6APa8zdZGCTLWyO8L9Z
         La/AnRNT+14N/MyCbktXtjj0ypMCL/wThCjzRaENZB3sjUd2WFh5HQbW6ZRhlwYsQNIa
         /vQVDjTTPw+JRMd/TdZMI8gjr23fdFIbCtVtAsRcFm1t+UIZ4gMBspHzgX95KGsdonGj
         HFO8wtXDSrTqV0QCon1aBMqIWpJttY8mfl8PC65s3uNQn9J/b71tmJeD6+GXJQHZ9xlQ
         SIpJgLsRVeqGHgLSI4a2aYZjFPBfLOvKNrGH70Qs7pWnUhuBuzMKMcZnaq3KVcqQ2TjI
         FCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699284199; x=1699888999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qS7e87bvh6ANEDUsn8lN4pszguiB/ZmyAjUwIxwMFWU=;
        b=P4EQ5DaZlIoZY9JNqb54G/OKwBG9Y4D6CI5XkHz5GAcd9aI3MNGZbzBBqBoaLXvzQ4
         jLMXAJbEVg0v2Bb0l+plpcv/WrZvlVWJPzXu9Ld5XBo49a6w0bF8N8sj0SDjzgnhYO8n
         cXyTkL05EpIqOb6TmN+P67vPkbfN0nryulmbY5mQnohWMzNyLA5bTzb39FRUOe+/E3fu
         RnRkA2l776s3mTHxuQ0/sPuDU76b8UcvELmXDbbui2xb9yI3fimJjUstQLceV3O86LXY
         hMjyiJ/bk3o8FIcgGqiAwm6XTwoOyoz45Vaxwn5rfbt7kwgRVBzaiIxdmyrYhY0pl2+D
         LldQ==
X-Gm-Message-State: AOJu0YwiVErR/CSwiZAdcPmIvQlQsjUQXJBiV4ODMqOtXge9Hj3nWWNY
	bihFCI4XBb88ycZ21kxAgl0=
X-Google-Smtp-Source: AGHT+IGE4WDYZL+D3hYGH4AdlAH2S5YWiD/fnwM0vf7z2ryBGR9WfkkO3jm7mz8IlXs+VmY8rJN08A==
X-Received: by 2002:a05:6a20:93a2:b0:171:737:df97 with SMTP id x34-20020a056a2093a200b001710737df97mr37063452pzh.2.1699284198823;
        Mon, 06 Nov 2023 07:23:18 -0800 (PST)
Received: from [192.168.0.152] ([103.75.161.211])
        by smtp.gmail.com with ESMTPSA id gu6-20020a056a004e4600b0068fe7e07190sm5737738pfb.3.2023.11.06.07.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 07:23:18 -0800 (PST)
Message-ID: <8662a7cc-f18e-43a5-a38f-15212a5f93b8@gmail.com>
Date: Mon, 6 Nov 2023 20:53:07 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/hyperv : Fixing removal of __iomem address space
 warning
Content-Language: en-US
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "niyelchu@linux.microsoft.com" <niyelchu@linux.microsoft.com>
References: <20231030225003.374717-1-singhabhinav9051571833@gmail.com>
 <BY3PR18MB46927A33E493191AA4F23B03D4ABA@BY3PR18MB4692.namprd18.prod.outlook.com>
From: Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <BY3PR18MB46927A33E493191AA4F23B03D4ABA@BY3PR18MB4692.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/23 20:55, Michael Kelley wrote:
> From: Abhinav Singh <singhabhinav9051571833@gmail.com> Sent: Monday, October 30, 2023 3:50 PM
>>
>> This patch fixes two sparse warnings
>>
>> 1. sparse complaining about the removal of __iomem address
>> space when casting the return value of this ioremap_cache(...)
>> from `void __ioremap*` to `void*`.
>> Fixed this by replacing the ioremap_cache(...)
>> by memremap(...) and using MEMREMAP_DEC and MEMREMAP_WB flag for
>> making
>> sure the memory is always decrypted and it will support full write back
>> cache.
>>
>> 2. sparse complaining `expected void volatile [noderef] __iomem *addr`
>> when calling iounmap with a non __iomem pointer.
>> Fixed this by replacing iounmap(...) with memumap(...).
>>
>> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> 
> Since Nischala has posted her more comprehensive patch,
> this patch can be dropped.  But see one comment below for
> future reference.
> 
>> ---
>>
>> v1:
>> https://lore.kernel.org/all/19cec6f0-e176-4bcc-95a0-9d6eb0261ed1@gmail.com/T/
>>
>> v1 to v2:
>> 1. Fixed the comment which was earlier describing ioremap_cache(...).
>> 2. Replaced iounmap(...) with memremap(...) inside function hv_cpu_die(...).
>>
>>   arch/x86/hyperv/hv_init.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index 21556ad87f4b..2a14928b8a36 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -68,9 +68,11 @@ static int hyperv_init_ghcb(void)
>>   	 */
>>   	rdmsrl(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
>>
>> -	/* Mask out vTOM bit. ioremap_cache() maps decrypted */
>> +	/* Mask out vTOM bit.
>> +	MEMREMAP_WB full write back cache
>> +	MEMREMAP_DEC maps decrypted memory */
> 
> This isn't the right style for multi-line patches.  Correct would be:
> 
> 	/*
> 	 * Mask out vTOM bit.
> 	 * MEMREMAP_WB full write back cache
> 	 * MEMREMAP_DEC maps decrypted memory
> 	 */
> 
> Section 8 of coding-style.rst under Documentation/process covers
> these details.   Note that the style is slightly different for code
> under net and drivers/net.
> 
> Michael
> 
>>   	ghcb_gpa &= ~ms_hyperv.shared_gpa_boundary;
>> -	ghcb_va = (void *)ioremap_cache(ghcb_gpa, HV_HYP_PAGE_SIZE);
>> +	ghcb_va = memremap(ghcb_gpa, HV_HYP_PAGE_SIZE, MEMREMAP_WB | MEMREMAP_DEC);
>>   	if (!ghcb_va)
>>   		return -ENOMEM;
>>
>> @@ -238,7 +240,7 @@ static int hv_cpu_die(unsigned int cpu)
>>   	if (hv_ghcb_pg) {
>>   		ghcb_va = (void **)this_cpu_ptr(hv_ghcb_pg);
>>   		if (*ghcb_va)
>> -			iounmap(*ghcb_va);
>> +			memunmap(*ghcb_va);
>>   		*ghcb_va = NULL;
>>   	}
>>
>> --
>> 2.39.2
> 
Thanks a lot for taking a look and the suggestion, will keep this in 
mind in future patches.

Thanks,
Abhinav

