Return-Path: <linux-hyperv+bounces-6754-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D60AB462D2
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 20:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587C23B1C52
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 18:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CF327E076;
	Fri,  5 Sep 2025 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oCkJT14J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDAA2737E6;
	Fri,  5 Sep 2025 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098161; cv=none; b=XW0iJOxsAt9Ym1MEJUkotkBsdvWzONdyCybJXr6/AZsUyuwpeTtgwBofJL7ON4P6FzUH6c6tPaumukjMYs9XRPcRWmdiaBSzd53wrx/orgzyD1Aw7QfQokYSNfyIjzkYN6sMZoe6pc+fsSNxq0mRlkMQ3uUF54Zz1tJZj0JSSr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098161; c=relaxed/simple;
	bh=1/nuSTD5GWcvPkNQ6+aJ2ZX10mVfvAGh2/eWLRpsF5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWYqNorqE9m0uuYOAPkKoZgjzTBI3RP0uVgGGAaWEUlhbXW5IpIsU9xE9w1ew0WOW0G38RVJUU5bbo5Ox5NY99qPKy6OKuJAzx+9cS/AZRyj+LE4BQgkvzUC1y7hQcpvYMI7eex0xSxlF5EbDCI/6CaQ9QfjJlXHtVjhBGO8o1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oCkJT14J; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.33.189] (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7EBB120171D4;
	Fri,  5 Sep 2025 11:49:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7EBB120171D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757098159;
	bh=dp/kEQKkUi0D1zVyET/IHUg9weUbnlvPbW7U8vYE2eE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oCkJT14JuoJIS6ddd+kfb34hDe7iofsOyLbHyJiVM3ximql0cDkINpdrRwcxiMrOK
	 XGDZ3iI+RaHlU2T9wsrQmryHoPCGy8V5R9uuxZPAXbwmk0531DZ5WKn8itUShcL2GM
	 U/+VehwvLE7iHxNz0eY+jsTTsAORjj5JXrkwGhs4=
Message-ID: <dee3a22e-935c-4500-b9d1-b43109f4897a@linux.microsoft.com>
Date: Fri, 5 Sep 2025 11:49:18 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] mshv: Get the vmm capabilities offered by the
 hypervisor
To: Praveen K Paladugu <praveenkpaladugu@gmail.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 mhklinux@outlook.com, decui@microsoft.com, paekkaladevi@linux.microsoft.com
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-5-git-send-email-nunodasneves@linux.microsoft.com>
 <64adc508-d18b-4075-835d-97ce5b68c4eb@gmail.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <64adc508-d18b-4075-835d-97ce5b68c4eb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/5/2025 8:43 AM, Praveen K Paladugu wrote:
> 
> 
> On 8/28/2025 7:43 PM, Nuno Das Neves wrote:
>> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>>
>> Some newer hypervisor APIs are gated by feature bits in the so-called
>> "vmm capabilities" partition property. Store the capabilities on
> nit: s/xx/Some hypervisor APIs are gated by feature bits exposed in
> "vmm capabilities" partition property./g

Thanks, I'll update it for v2

Nuno

>> mshv_root module init, using HVCALL_GET_PARTITION_PROPERTY_EX.
>>>> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>   drivers/hv/mshv_root.h      |  1 +
>>   drivers/hv/mshv_root_main.c | 28 ++++++++++++++++++++++++++++
>>   2 files changed, 29 insertions(+)
>>
>> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
>> index 4aeb03bea6b6..0cb1e2589fe1 100644
>> --- a/drivers/hv/mshv_root.h
>> +++ b/drivers/hv/mshv_root.h
>> @@ -178,6 +178,7 @@ struct mshv_root {
>>       struct hv_synic_pages __percpu *synic_pages;
>>       spinlock_t pt_ht_lock;
>>       DECLARE_HASHTABLE(pt_htable, MSHV_PARTITIONS_HASH_BITS);
>> +    struct hv_partition_property_vmm_capabilities vmm_caps;
>>   };
>>     /*
>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>> index 56ababab57ce..29f61ecc9771 100644
>> --- a/drivers/hv/mshv_root_main.c
>> +++ b/drivers/hv/mshv_root_main.c
>> @@ -2327,6 +2327,28 @@ static int __init mshv_root_partition_init(struct device *dev)
>>       return err;
>>   }
>>   +static int mshv_init_vmm_caps(struct device *dev)
>> +{
>> +    int ret;
>> +
>> +    memset(&mshv_root.vmm_caps, 0, sizeof(mshv_root.vmm_caps));
>> +    ret = hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
>> +                        HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
>> +                        0, &mshv_root.vmm_caps,
>> +                        sizeof(mshv_root.vmm_caps));
>> +
>> +    /*
>> +     * HV_PARTITION_PROPERTY_VMM_CAPABILITIES is not supported in
>> +     * older hyperv. Ignore the -EIO error code.
>> +     */
>> +    if (ret && ret != -EIO)
>> +        return ret;
>> +
>> +    dev_dbg(dev, "vmm_caps=0x%llx\n", mshv_root.vmm_caps.as_uint64[0]);
>> +
>> +    return 0;
>> +}
>> +
>>   static int __init mshv_parent_partition_init(void)
>>   {
>>       int ret;
>> @@ -2377,6 +2399,12 @@ static int __init mshv_parent_partition_init(void)
>>       if (ret)
>>           goto remove_cpu_state;
>>   +    ret = mshv_init_vmm_caps(dev);
>> +    if (ret) {
>> +        dev_err(dev, "Failed to get VMM capabilities\n");
>> +        goto exit_partition;
>> +    }
>> +
>>       ret = mshv_irqfd_wq_init();
>>       if (ret)
>>           goto exit_partition;
> 
> Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>


