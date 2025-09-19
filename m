Return-Path: <linux-hyperv+bounces-6965-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EA5B8B94E
	for <lists+linux-hyperv@lfdr.de>; Sat, 20 Sep 2025 00:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC2A0B656BD
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Sep 2025 22:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D69B2D249F;
	Fri, 19 Sep 2025 22:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MgFAMbo6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9522D5953;
	Fri, 19 Sep 2025 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321427; cv=none; b=Y9q3BL6WEckEyk6TBW0D+ULytCjjDWdXIX00xXz8u3brVUTCNKfYfva/a6rLuqypXU9jvZOPjukNyPAQxXOuSNe2iNK0yCIU4NFoCSpOIUx+Y551dNzca9owJGsKXfX9Im3X/ghvXu+ef/g5nRuoMK0httfJ4APjygLdiaxugbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321427; c=relaxed/simple;
	bh=l0hQwWQjuMnkhbLnGu2CBoE/HRzDlx18idwSYypTxLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Su/5UzC0xQLn0IvNlEI2hthnH8ENWWw4t/9tu+JixPyjJqhIKDnOSW7ImeQjt3AuWTusV3/WYrx5XWhMkynXO3AxvnD4RTaaAk9nB2qvAxvqcOko4biibwqy6diT78/uaLy5bvuX1CEFUh8khAxGQ0vCTbyZxxlM+CSURkf49cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MgFAMbo6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.193.225] (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id A98572018E60;
	Fri, 19 Sep 2025 15:37:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A98572018E60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758321424;
	bh=Xw/A6yOKSQHfupdUFT86rCIsXwAoxcjBF3Ul3P45H1c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MgFAMbo6e1CQ+Kc/NFBnYoKJTNoxGu24b4lCj+5le30z6/5DL4c69TDQzkOisQeFX
	 7kWUNsTT2YLMiVCkednx1QHPEZnb1fjmyjSfb4YFm3r8UGXCxNAMpTtAx5tTaz+FpD
	 ThV8mL8OWBFzCIdzBLPTgdjbco9klSAsg/2elRcc=
Message-ID: <8d6c6f95-7ccd-4471-a391-39a45f95af04@linux.microsoft.com>
Date: Fri, 19 Sep 2025 15:37:03 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] mshv: Get the vmm capabilities offered by the
 hypervisor
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 prapal@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
 tiala@microsoft.com, anirudh@anirudhrb.com,
 paekkaladevi@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com
References: <1758066262-15477-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1758066262-15477-4-git-send-email-nunodasneves@linux.microsoft.com>
 <aMxUe7WLzMXJY16c@skinsburskii.localdomain>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <aMxUe7WLzMXJY16c@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/2025 11:50 AM, Stanislav Kinsburskii wrote:
> On Tue, Sep 16, 2025 at 04:44:20PM -0700, Nuno Das Neves wrote:
>> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>>
>> Some hypervisor APIs are gated by feature bits in the
>> "vmm capabilities" partition property. Store the capabilities on
>> mshv_root module init, using HVCALL_GET_PARTITION_PROPERTY_EX.
>>
>> This is not supported on all hypervisors. In that case, just set the
>> capabilities to 0 and proceed as normal.
>>
>> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
>> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
>> Reviewed-by: Tianyu Lan <tiala@microsoft.com>
>> ---
>>  drivers/hv/mshv_root.h      |  1 +
>>  drivers/hv/mshv_root_main.c | 22 ++++++++++++++++++++++
>>  2 files changed, 23 insertions(+)
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
>> index 24df47726363..f7738cefbdf3 100644
>> --- a/drivers/hv/mshv_root_main.c
>> +++ b/drivers/hv/mshv_root_main.c
>> @@ -2201,6 +2201,26 @@ static int __init mshv_root_partition_init(struct device *dev)
>>  	return err;
>>  }
>>  
>> +static void mshv_init_vmm_caps(struct device *dev)
>> +{
>> +	int ret;
> 
> nit: this is void function so ret looks redundant.
> 

True, it's not needed.

>> +
>> +	memset(&mshv_root.vmm_caps, 0, sizeof(mshv_root.vmm_caps));
> 
> Zeroying is redundant as mshv_root is a statci variable.
> 

Good point.

>> +	ret = hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
>> +						HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
>> +						0, &mshv_root.vmm_caps,
> 
> Also, we align "slow" hypercalls by PAGE_SIZE. Why is it fine to not do
> it here?
> 

I guess you're referring to the output argument of the hypercall?

Check the previous patch to see how hv_call_get_partition_property_ex()
is implemented. It uses the per-cpu input/output args as normal, which
are HV_HYP_PAGE_SIZE in size, and page-aligned.

> Thanks,
> Stanislav
> 
>> +						sizeof(mshv_root.vmm_caps));
>> +
>> +	/*
>> +	 * HVCALL_GET_PARTITION_PROPERTY_EX or HV_PARTITION_PROPERTY_VMM_CAPABILITIES
>> +	 * may not be supported. Leave them as 0 in that case.
>> +	 */
>> +	if (ret)
>> +		dev_warn(dev, "Unable to get VMM capabilities\n");
>> +
>> +	dev_dbg(dev, "vmm_caps=0x%llx\n", mshv_root.vmm_caps.as_uint64[0]);
>> +}
>> +
>>  static int __init mshv_parent_partition_init(void)
>>  {
>>  	int ret;
>> @@ -2253,6 +2273,8 @@ static int __init mshv_parent_partition_init(void)
>>  	if (ret)
>>  		goto remove_cpu_state;
>>  
>> +	mshv_init_vmm_caps(dev);
>> +
>>  	ret = mshv_irqfd_wq_init();
>>  	if (ret)
>>  		goto exit_partition;
>> -- 
>> 2.34.1
>>


