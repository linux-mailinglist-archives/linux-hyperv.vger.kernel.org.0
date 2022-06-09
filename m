Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D377454452D
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jun 2022 09:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiFIH4F (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Jun 2022 03:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238994AbiFIH4E (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Jun 2022 03:56:04 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD57FCFF;
        Thu,  9 Jun 2022 00:56:02 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 15so20433618pfy.3;
        Thu, 09 Jun 2022 00:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uHgF78fjuIxLf3C1+Gtpu2aHT2KsuUvIEflSskna6yw=;
        b=dkknv255h3oV9lugSLBLP9ekZlE2wpkTSwRbiWdKNsjiu7z5znxKzetKM2GXmx5X63
         XnkzoPaEgUlFOPROBlR4A/0uWV+MpYmpIr+P07hXiTkTBxJU0cI+zNXgTI+/cbuDR7Xk
         gH7dV9DEJXePWRMGMoNHVU7Ynmay/qzBMwMKIAG+nOfenX1uPQnQ0HDwgAWEpVubTc0p
         TpmQaVl/W0lfmBckkIWHuz6nvxOvbAcdXoNCIN0BRpN5sdziM5XZ+IjGMtLovrHO+PRl
         lIfIHkn0XWYm5T2nV/DeTP4tLMsRXbl6WZcLV7UyM5VmnLkvNF3sEON7E/fvbGt3YsBX
         7D3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uHgF78fjuIxLf3C1+Gtpu2aHT2KsuUvIEflSskna6yw=;
        b=qODa0um9jVfhvdOKTPzgRVcPSs9CYyQiMIZKcO8Jdlnf9WKb4ZH+p9QDg8OaFctTcA
         NreqIGxKzaEYdfqg/ZqeJte+aNEFvOeZ9zJYKXIHFoeIJEXUQk+6UsHi7o992N+tLZm6
         kAm3HaEtSbPIRM1Kxm9WD/ICmgoJPcZeK3YsyWnYjkL9LfMzoFnNCbJ5Zx3PEW1hXsvr
         +UTL0wEO5ORM4aUTGpOH2Sj8DT7+o4nmZBxamGFfNo+yYX/ocNSVBc/iKKK1hYM4v0SP
         Yf5pDzcQBYp70eJDgnqU24Z9V2fWoXNNmDJxr6grV2c6xyV+DoLp7GY9hZ1v1mGDEXti
         91ZA==
X-Gm-Message-State: AOAM532KQLCxmW5JK+eqi2+WH1R2IkbCPjFq7ZHkcbEc7jz3KyVt1XUE
        JtxpXqJNlUYnv89trTkcrDo=
X-Google-Smtp-Source: ABdhPJx5MezwxElfcsiSciwOUY5HDM427imu+zvylV6WNkH+Ax9PejcgD5rjhDXDIDXtq+hwUnSgrQ==
X-Received: by 2002:a65:6b8a:0:b0:3db:7dc5:fec2 with SMTP id d10-20020a656b8a000000b003db7dc5fec2mr32439107pgw.223.1654761362259;
        Thu, 09 Jun 2022 00:56:02 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::754? ([2404:f801:9000:1a:efea::754])
        by smtp.gmail.com with ESMTPSA id a20-20020aa794b4000000b0050dc76281d9sm17058807pfl.179.2022.06.09.00.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 00:56:01 -0700 (PDT)
Message-ID: <6b77d369-8f8e-b7f6-76c6-ad27fc21f68d@gmail.com>
Date:   Thu, 9 Jun 2022 15:55:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V2] x86/Hyper-V: Add SEV negotiate protocol support in
 Isolation VM
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>
References: <20220602110507.243083-1-ltykernel@gmail.com>
 <PH0PR21MB302527315F7BE39E0709C5E6D7A59@PH0PR21MB3025.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <PH0PR21MB302527315F7BE39E0709C5E6D7A59@PH0PR21MB3025.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Michael:
	Thanks for your review.

On 6/8/2022 4:30 AM, Michael Kelley (LINUX) wrote:
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index 8b392b6b7b93..40b6874accdb 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -29,6 +29,7 @@
>>   #include <clocksource/hyperv_timer.h>
>>   #include <linux/highmem.h>
>>   #include <linux/swiotlb.h>
>> +#include <asm/sev.h>
>>
>>   int hyperv_init_cpuhp;
>>   u64 hv_current_partition_id = ~0ull;
>> @@ -70,6 +71,11 @@ static int hyperv_init_ghcb(void)
>>   	ghcb_base = (void **)this_cpu_ptr(hv_ghcb_pg);
>>   	*ghcb_base = ghcb_va;
>>
>> +	/* Negotiate GHCB Version. */
>> +	if (!hv_ghcb_negotiate_protocol())
>> +		hv_ghcb_terminate(SEV_TERM_SET_GEN,
>> +				  GHCB_SEV_ES_PROT_UNSUPPORTED);
>> +
> Negotiating the protocol here is unexpected for me.  The
> function hyperv_init_ghcb() is called for each CPU as it
> initializes, so the static variable ghcb_version will be set
> multiple times.  I can see that setup_ghbc(), which this is
> patterned after, is also called for each CPU during the early
> CPU initialization, which is also a bit weird.  I see two
> problems:
> 
> 1) hv_ghcb_negotiate_protocol() could get called in parallel
> on two different CPUs at the same time, and the Hyper-V
> version modifies global state (the MSR_AMD64_SEV_ES_GHCB
> MSR).  I'm not sure if the sev_es version has the same
> problem.
> 
> 2) The Hyper-V version would get called when taking a CPU
> from on offline state to an online state.  I'm not sure if taking
> CPUs online and offline is allowed in an SNP isolated VM, but
> if it is, then ghcb_version could be modified well after Linux
> initialization, violating the __ro_after_init qualifier on the
> variable.
> 
> Net, it seems like we should find a way to negotiate the
> GHCB version only once at boot time.

Yes, this makes sense and will update.
> 
>> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
>> index 2b994117581e..4b67c4d7c4f5 100644
>> --- a/arch/x86/hyperv/ivm.c
>> +++ b/arch/x86/hyperv/ivm.c
>> @@ -53,6 +53,8 @@ union hv_ghcb {
>>   	} hypercall;
>>   } __packed __aligned(HV_HYP_PAGE_SIZE);
>>
>> +static u16 ghcb_version __ro_after_init;
>> +
> This is same name as the equivalent sev_es variable.  Could this one
> be changed to hv_ghcb_version to avoid any confusion?
> 
>> +static inline void wr_ghcb_msr(u64 val)
>> +{
>> +	u32 low, high;
>> +
>> +	low  = (u32)(val);
>> +	high = (u32)(val >> 32);
>> +
>> +	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
> This whole function could be coded as just
> 
> 	native_wrmsrl(MSR_AMD64_SEV_ES_GHCB, val);
> 
> since the "l" version handles breaking the 64-bit argument
> into two 32-bit arguments.

This follows SEV ES code and will update.

> 
>> +}
>> +
>> +static enum es_result ghcb_hv_call(struct ghcb *ghcb, u64 exit_code,
>> +				   u64 exit_info_1, u64 exit_info_2)
> Seems like the function name here should be hv_ghcb_hv_call.
> 
>> @@ -152,8 +229,7 @@ void hv_ghcb_msr_read(u64 msr, u64 *value)
>>   	}
>>
>>   	ghcb_set_rcx(&hv_ghcb->ghcb, msr);
>> -	if (sev_es_ghcb_hv_call(&hv_ghcb->ghcb, false, &ctxt,
>> -				SVM_EXIT_MSR, 0, 0))
>> +	if (ghcb_hv_call(&hv_ghcb->ghcb, SVM_EXIT_MSR, 0, 0))
>>   		pr_warn("Fail to read msr via ghcb %llx.\n", msr);
>>   	else
>>   		*value = (u64)lower_32_bits(hv_ghcb->ghcb.save.rax)
> Since these changes remove the two cases where sev_es_ghcb_hv_call()
> is invoked with the 2nd argument as "false", it seems like there should be
> a follow-on patch to remove that argument and Hyper-V specific hack
> from sev_es_ghcb_hv_call().

OK. Will update.
