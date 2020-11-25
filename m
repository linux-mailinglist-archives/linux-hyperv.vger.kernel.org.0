Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D78B2C364C
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Nov 2020 02:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgKYBlq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Nov 2020 20:41:46 -0500
Received: from gateway33.websitewelcome.com ([192.185.146.119]:19958 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726390AbgKYBlp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Nov 2020 20:41:45 -0500
X-Greylist: delayed 1499 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Nov 2020 20:41:44 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id A79A111A53C
        for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2020 18:54:31 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id hj4pkf0nIoE4Dhj4pkHDZg; Tue, 24 Nov 2020 18:54:31 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qBzajxsOiw+apoE+OWjIlkXKzOH/jxlZ5BaJ29pSoJU=; b=pzeK2ou7MYNp4+XCeflXDQ9mdE
        x11bMv4erI7ohJK8zpGpv3Y4QQk0Xrj46Vhhm+vFSNuzuo7lRNYAFi16dJLiyr3IRg+4rjitGnj8g
        Na4Y3boMEQOk8Azk4voFhsYVYf1WUV0Idzpueusp3fNqnxqfVGuSU8flNlZeketb0nXhwkcCfLZ7k
        LDN0M7a5UKnUFYKqOa+hNCc4JwbXXa2b8VonuS6KiS1noSXbnU5UlEVBfAPxBMsqESy1gSWsZa3Xd
        u8aTQhpMmmoZZ2t423ICsVjHWCLJ+6T7h3X/e1jy3lwM8Ydfu9eaDEySsyJFcy6ZY5T3cahDjyMjC
        Xz3nZ/7A==;
Received: from 179-197-124-241.ultrabandalargafibra.com.br ([179.197.124.241]:58888 helo=[192.168.1.69])
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1khj4p-002EPI-9C; Tue, 24 Nov 2020 21:54:31 -0300
Subject: Re: [PATCH 4/6] drivers: hv: vmbus: Fix checkpatch SPLIT_STRING
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "sashal@kernel.org" <sashal@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>
References: <20201115195734.8338-1-matheus@castello.eng.br>
 <20201115195734.8338-5-matheus@castello.eng.br>
 <MW2PR2101MB1052B329DFC5D54F4D7501E9D7E40@MW2PR2101MB1052.namprd21.prod.outlook.com>
From:   Matheus Castello <matheus@castello.eng.br>
Message-ID: <ada0ef93-1443-49a0-914c-1ad03ffa024b@castello.eng.br>
Date:   Tue, 24 Nov 2020 21:54:29 -0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <MW2PR2101MB1052B329DFC5D54F4D7501E9D7E40@MW2PR2101MB1052.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: pt-BR
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 179.197.124.241
X-Source-L: No
X-Exim-ID: 1khj4p-002EPI-9C
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179-197-124-241.ultrabandalargafibra.com.br ([192.168.1.69]) [179.197.124.241]:58888
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 21
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Michael,

Em 11/15/2020 7:25 PM, Michael Kelley escreveu:
> From: Matheus Castello <matheus@castello.eng.br> Sent: Sunday, November 15, 2020 11:58 AM
>>
>> Checkpatch emits WARNING: quoted string split across lines.
>> To keep the code clean and with the 80 column length indentation the
>> check and registration code for kmsg_dump_register has been transferred
>> to a new function hv_kmsg_dump_register.
>>
>> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
>> ---
>>   drivers/hv/vmbus_drv.c | 34 +++++++++++++++++++---------------
>>   1 file changed, 19 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index 61d28c743263..09d8236a51cf 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -1387,6 +1387,23 @@ static struct kmsg_dumper hv_kmsg_dumper = {
>>   	.dump = hv_kmsg_dump,
>>   };
>>
>> +static void hv_kmsg_dump_register(void)
>> +{
>> +	int ret;
>> +
>> +	hv_panic_page = (void *)hv_alloc_hyperv_zeroed_page();
>> +	if (hv_panic_page) {
>> +		ret = kmsg_dump_register(&hv_kmsg_dumper);
>> +		if (ret) {
>> +			pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
>> +			hv_free_hyperv_page((unsigned long)hv_panic_page);
>> +			hv_panic_page = NULL;
>> +		}
>> +	} else {
>> +		pr_err("Hyper-V: panic message page memory allocation failed");
>> +	}
>> +}
>> +
> 
> The above would be marginally better if organized as follows so that the
> main execution path isn't in an "if" clause.  Also reduces indentation.
> 
> 	hv_panic_page = (void *)hv_alloc_hyperv_zeroed_page();
> 	if (!hv_panic_page) {
> 		pr_err("Hyper-V: panic message page memory allocation failed");
> 		return;
> 	}
> 	ret = kmsg_dump_register(&hv_kmsg_dumper);
> 	if (ret) {
> 		pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
> 		hv_free_hyperv_page((unsigned long)hv_panic_page);
> 		hv_panic_page = NULL;
> 	}
> 
> 

Thanks for the review, great I will use it on the v2.

>>   static struct ctl_table_header *hv_ctl_table_hdr;
>>
>>   /*
>> @@ -1477,21 +1494,8 @@ static int vmbus_bus_init(void)
>>   		 * capability is supported by the hypervisor.
>>   		 */
>>   		hv_get_crash_ctl(hyperv_crash_ctl);
>> -		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG) {
>> -			hv_panic_page = (void *)hv_alloc_hyperv_zeroed_page();
>> -			if (hv_panic_page) {
>> -				ret = kmsg_dump_register(&hv_kmsg_dumper);
>> -				if (ret) {
>> -					pr_err("Hyper-V: kmsg dump register "
>> -						"error 0x%x\n", ret);
>> -					hv_free_hyperv_page(
>> -					    (unsigned long)hv_panic_page);
>> -					hv_panic_page = NULL;
>> -				}
>> -			} else
>> -				pr_err("Hyper-V: panic message page memory "
>> -					"allocation failed");
>> -		}
>> +		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
>> +			hv_kmsg_dump_register();
>>
>>   		register_die_notifier(&hyperv_die_block);
>>   	}
>> --
>> 2.28.0
> 
