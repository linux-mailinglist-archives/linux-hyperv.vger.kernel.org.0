Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 640A418AE21
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 09:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgCSINC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Mar 2020 04:13:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46666 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgCSINC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Mar 2020 04:13:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id y30so837207pga.13;
        Thu, 19 Mar 2020 01:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ac1YV381+pu+9t+a/snJbLjzWPHz5dhKlor8SQORWwk=;
        b=Za+oOSYZruRvXcb3jvvrfDOxN1r4gMFYrIHrPH+NLDOOV/dU81M8LlZcV71oCnaywF
         nDJifkcOnIy2J8SWGVkoPEGhEElNgNaGOu1j0L2jW41zObzPejqGuryJDOh87NSBdowr
         W6RBvHPVGxLHfzKBegLovxWkuWRkyKKE86N8BNQiyaclUn8Qi88sYGCbsK364tUVa/td
         xnY0+1BmrodEIFu5J7OleM935QQmSYIp4jRLICQPB33Ti4Nogl/mM8sFQ7qEoLUcEfvm
         ifpfC5cnJXlx/QZ6TakYEIIQphlvfM53IY7L8r3HwRL9o8cyUU01gstK/x0Ip3/hhdGs
         AvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ac1YV381+pu+9t+a/snJbLjzWPHz5dhKlor8SQORWwk=;
        b=P3U2S1xXjzvJA19+XpOGMSE4oAbmpIyL36b56+VbLJfT+xNa5izPhPE7P9G/JDRl9o
         SNhLWuMlAciNTVWCj3zfPXM3n62JfdJ5oQgbQzhN583bsCDmytDdAC5J+fOglTpm32A5
         4wVkkzLRMxQZk8oABgmvaDS/QeFFZdDERpHNeyCpq+17eak48qpo2R4rVdc+begiHvRL
         jXeFxcrdXaZCEhAggS4MVtF2NnzMAGR1t/FHFNuNj0QQw0J5EGQhGbTkcU53YhW6nC32
         lA3n2fGmFgSXM1m//t1F8F1k/q2IwkPYMIKYe4PgQyRO5Ee0u9jaMoqS8PWbzxUcIRI5
         cYQA==
X-Gm-Message-State: ANhLgQ3+kMSqMA4E72+fHqUVRmLm5k9QMyjfuOyRCz5j9Lcozjfr8cui
        qmavGxGsEPX6//qo7ab8FfU=
X-Google-Smtp-Source: ADFU+vuUYCNoMeUgkA/1IgD1NG/JZmJhAbBzL1jvwz0SYdcYS0LdsBPwlXa2sPuDTncEr3ayDRgW9g==
X-Received: by 2002:aa7:99c8:: with SMTP id v8mr2640858pfi.151.1584605581088;
        Thu, 19 Mar 2020 01:13:01 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:6:8000::a31c? ([2404:f801:9000:1a:efeb::a31c])
        by smtp.gmail.com with ESMTPSA id 67sm1362804pfe.168.2020.03.19.01.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 01:13:00 -0700 (PDT)
Subject: Re: [PATCH 2/4] x86/Hyper-V: Free hv_panic_page when fail to register
 kmsg dump
To:     Wei Liu <wei.liu@kernel.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
References: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
 <20200317132523.1508-3-Tianyu.Lan@microsoft.com>
 <20200317173600.2hqznyabyj4nckjo@debian>
From:   Tianyu Lan <ltykernel@gmail.com>
Message-ID: <0105c10b-b546-6d93-bb49-e9a4ce4589f6@gmail.com>
Date:   Thu, 19 Mar 2020 16:12:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317173600.2hqznyabyj4nckjo@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Wei:
	Thanks for your review.

On 3/18/2020 1:36 AM, Wei Liu wrote:
> On Tue, Mar 17, 2020 at 06:25:21AM -0700, ltykernel@gmail.com wrote:
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> If fail to register kmsg dump on Hyper-V platform, hv_panic_page
>> will not be used anywhere. So free and reset it.
>>
>> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> ---
>>   drivers/hv/vmbus_drv.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index b56b9fb9bd90..b043efea092a 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -1385,9 +1385,13 @@ static int vmbus_bus_init(void)
>>   			hv_panic_page = (void *)hv_alloc_hyperv_zeroed_page();
>>   			if (hv_panic_page) {
>>   				ret = kmsg_dump_register(&hv_kmsg_dumper);
>> -				if (ret)
>> +				if (ret) {
>>   					pr_err("Hyper-V: kmsg dump register "
>>   						"error 0x%x\n", ret);
>> +					hv_free_hyperv_page(
>> +					    (unsigned long)hv_panic_page);
>> +					hv_panic_page = NULL;
>> +				}
> 
> While this modification looks correct to me, there is a call to free
> hv_panic_page in the err_alloc path. That makes the error handling a bit
> confusing here.
> 
> I think you can just remove that function call in err_alloc path.

OK. Will update in the next version.

> 
> Wei.
> 
>>   			} else
>>   				pr_err("Hyper-V: panic message page memory "
>>   					"allocation failed");
>> -- 
>> 2.14.5
>>
