Return-Path: <linux-hyperv+bounces-6764-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E49DB46701
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Sep 2025 01:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188421CC5F3E
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 23:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC0129D29D;
	Fri,  5 Sep 2025 23:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kUxHUoYE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1102A28137A;
	Fri,  5 Sep 2025 23:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757113683; cv=none; b=vEz3KqqGzoOIWoTKlMPJ9HS/QQUhe05sHvL2LikcmR2jUUy8LmA6lzFZyd8ZQZAPhRz3yj3obtW3eXx3tRsCC6vU7MXxrPwvM8SSu4RU8bdRGcSLUDs3/bZpvRpbR5rKmn5f+FCX9jUM7fdrJjyV/93w9QRcYO+lc+Ze6Iirf2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757113683; c=relaxed/simple;
	bh=MBdNXH43+9HtpkLHymsZOepAQ94vVsvRAPh0oD0rdvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KECk+SV/WnRfxJr1GX8oN+g3WoFi/tnbkPrCr6h7rjReMWcCQUX65H8P6HJZMhEa3vBIc8CYF+PqWx3xOrdRIPqxsFCWkRtoEb3ZgPRJIzDXn4w2F5QSZS3zq95kuubcWXBPcoiyoSW3VecTfSC/carEgmSDWROXQEp+0uzyAkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kUxHUoYE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.33.30] (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1B7362015BC2;
	Fri,  5 Sep 2025 16:08:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B7362015BC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757113680;
	bh=fNbKzSFb0mK+fbTg+WUqGA6KJLrB9EG9zfN5YcJiXUY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kUxHUoYE3ALXeXhUzuMIaiikY+XI5obuzfPx01C0IZB0e14VU4bLo5yFcB6ks3U4b
	 Gh5BYBNnpKeThYtY7MQ79now8Lyljs+V+67mx9Ccz9lD7RSo5AJBC8G9RvkkUfAq8T
	 5tThiXNKLQFNE0AWqKDYCTQ8jaQ+oV//xlMrWXQM=
Message-ID: <c3097a7e-9cce-4152-b94c-924018064b22@linux.microsoft.com>
Date: Fri, 5 Sep 2025 16:07:59 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] mshv: Get the vmm capabilities offered by the
 hypervisor
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 mhklinux@outlook.com, decui@microsoft.com, paekkaladevi@linux.microsoft.com
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-5-git-send-email-nunodasneves@linux.microsoft.com>
 <aLsz78GrA_mqucOb@anirudh-surface.localdomain>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <aLsz78GrA_mqucOb@anirudh-surface.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/2025 12:03 PM, Anirudh Rayabharam wrote:
> On Thu, Aug 28, 2025 at 05:43:48PM -0700, Nuno Das Neves wrote:
>> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>>
>> Some newer hypervisor APIs are gated by feature bits in the so-called
>> "vmm capabilities" partition property. Store the capabilities on
>> mshv_root module init, using HVCALL_GET_PARTITION_PROPERTY_EX.
>>
>> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  drivers/hv/mshv_root.h      |  1 +
>>  drivers/hv/mshv_root_main.c | 28 ++++++++++++++++++++++++++++
>>  2 files changed, 29 insertions(+)
>>
>> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
>> index 4aeb03bea6b6..0cb1e2589fe1 100644
>> --- a/drivers/hv/mshv_root.h
>> +++ b/drivers/hv/mshv_root.h
>> @@ -178,6 +178,7 @@ struct mshv_root {
>>  	struct hv_synic_pages __percpu *synic_pages;
>>  	spinlock_t pt_ht_lock;
>>  	DECLARE_HASHTABLE(pt_htable, MSHV_PARTITIONS_HASH_BITS);
>> +	struct hv_partition_property_vmm_capabilities vmm_caps;
>>  };
>>  
>>  /*
>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>> index 56ababab57ce..29f61ecc9771 100644
>> --- a/drivers/hv/mshv_root_main.c
>> +++ b/drivers/hv/mshv_root_main.c
>> @@ -2327,6 +2327,28 @@ static int __init mshv_root_partition_init(struct device *dev)
>>  	return err;
>>  }
>>  
>> +static int mshv_init_vmm_caps(struct device *dev)
>> +{
>> +	int ret;
>> +
>> +	memset(&mshv_root.vmm_caps, 0, sizeof(mshv_root.vmm_caps));
>> +	ret = hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
>> +						HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
>> +						0, &mshv_root.vmm_caps,
>> +						sizeof(mshv_root.vmm_caps));
>> +
>> +	/*
>> +	 * HV_PARTITION_PROPERTY_VMM_CAPABILITIES is not supported in
>> +	 * older hyperv. Ignore the -EIO error code.
>> +	 */
>> +	if (ret && ret != -EIO)
>> +		return ret;
>> +
>> +	dev_dbg(dev, "vmm_caps=0x%llx\n", mshv_root.vmm_caps.as_uint64[0]);
>> +
>> +	return 0;
>> +}
>> +
>>  static int __init mshv_parent_partition_init(void)
>>  {
>>  	int ret;
>> @@ -2377,6 +2399,12 @@ static int __init mshv_parent_partition_init(void)
>>  	if (ret)
>>  		goto remove_cpu_state;
>>  
>> +	ret = mshv_init_vmm_caps(dev);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to get VMM capabilities\n");
>> +		goto exit_partition;
> 
> Should this really be treated as a failure here? We could still offer
> /dev/mshv albeit with potentially limited capabilities.
> 

I agree. It can continue with vmm_caps set to zero, and print an error.

The check for -EIO is meant to achieve something similar but it's kind of
unreliable since so many HV_STATUS's map to EIO. So this idea is better,
thanks.

Nuno

> Thanks,
> Anirudh.
> 
>> +	}
>> +
>>  	ret = mshv_irqfd_wq_init();
>>  	if (ret)
>>  		goto exit_partition;
>> -- 
>> 2.34.1
>>


