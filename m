Return-Path: <linux-hyperv+bounces-7697-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE89CC6BE4F
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 23:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 78F543627CC
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 22:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3AC2EA46B;
	Tue, 18 Nov 2025 22:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Pz5SWReq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9481F463E;
	Tue, 18 Nov 2025 22:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763506174; cv=none; b=G36eGgyqR5yb+zwU9z8UE3YUt0PabRqHRvqtcJfzhT3zG7joK4gSf3FwlACL14ZRZ0zQMFl/agltVfNzPD+poRrE1IgCjwnuECTxix8r1/9p0ZA88cd97ZsOycWvD5w5RRit/oqcGgdQqqNVyE+S12R4w7DgEXLtAUsE0N2qVj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763506174; c=relaxed/simple;
	bh=ljf3TSNGOQ2dgYB4kuiTPcO5fIG2SefNyLjLdYDEQmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OEmrlYzrd5OeuK35Fwi236pFNtYraFm60ia9vQ85QzkMtuR+YsF3Z6mlhDBJ0f7Ip/TBhZNt0nyLTCfjqR/au2PX8U3uqx1FMueI6mhRBN8QIsm574y5PMbd8FxCVrThwV1tpCJN6yJZm1lopP5ApZI7DTq9EpVNQOVD8YkmsR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Pz5SWReq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.224.183] (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 979FF211FEC4;
	Tue, 18 Nov 2025 14:49:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 979FF211FEC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763506171;
	bh=3/DVf3XHek1hilFw2GcH047cHi5nIYoQUxoUVpV0NLI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pz5SWReqiF8V4hyt9h1+Piu2AWeeRruZhz38zrA40eIf3gCj5n25aKHTOWkzZZK8u
	 RWXa3kEjUxyB51Prts4uCf1Sf8rI7TUGkQw7eIIRNK3JVInQ0hk8RlEM5DSmqi7d/J
	 L6JXPXWQqLM9JLbDam2yPRRP9KebxIrvoqa31W28=
Message-ID: <86351349-69a1-49df-8b2c-e5c9dad91fde@linux.microsoft.com>
Date: Tue, 18 Nov 2025 14:49:30 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mshv: Extend create partition ioctl to support cpu
 features
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 wei.liu@kernel.org, mhklinux@outlook.com, kys@microsoft.com,
 haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
 prapal@linux.microsoft.com, mrathor@linux.microsoft.com,
 muislam@microsoft.com, anrayabh@linux.microsoft.com,
 Jinank Jain <jinankjain@microsoft.com>
References: <1762903194-25195-1-git-send-email-nunodasneves@linux.microsoft.com>
 <aRu2uC4VVazB_SfV@skinsburskii.localdomain>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <aRu2uC4VVazB_SfV@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/2025 3:58 PM, Stanislav Kinsburskii wrote:
> On Tue, Nov 11, 2025 at 03:19:54PM -0800, Nuno Das Neves wrote:
>> From: Muminul Islam <muislam@microsoft.com>
>>
>> The existing mshv create partition ioctl does not provide a way to
>> specify which cpu features are enabled in the guest. Instead, it
>> attempts to enable all features and those that are not supported are
>> silently disabled by the hypervisor.
>>
>> This was done to reduce unnecessary complexity and is sufficient for
>> many cases. However, new scenarios require fine-grained control over
>> these features.
>>
>> Define a new mshv_create_partition_v2 structure which supports
>> passing the disabled processor and xsave feature bits through to the
>> create partition hypercall directly.
>>
>> Introduce a new flag MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES which enables
>> the new structure. If unset, the original mshv_create_partition struct
>> is used, with the old behavior of enabling all features.
>>
>> Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
>> Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
>> Signed-off-by: Muminul Islam <muislam@microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>> Changes in v4:
>> - Change BIT() to BIT_ULL() [Michael Kelley]
>> - Enforce pt_num_cpu_fbanks == MSHV_NUM_CPU_FEATURES_BANKS and expect
>>   that number to never change. In future, additional processor banks
>>   will be settable as 'early' partition properties. Remove redundant
>>   code that set default values for unspecified banks [Michael Kelley]
>> - Set xsave features to 0 on arm64 [Michael Kelley]
>> - Add clarifying comments in a few places
>>
>> Changes in v3:
>> - Remove the new cpu features definitions in hvhdk.h, and retain the
>>   old behavior of enabling all features for the old struct. For the v2
>>   struct, still disable unspecified feature banks, since that makes it
>>   robust to future extensions.
>> - Amend comments and commit message to reflect the above
>> - Fix unused variable on arm64 [kernel test robot]
>>
>> Changes in v2:
>> - Fix exposure of CONFIG_X86_64 to uapi [kernel test robot]
>> - Fix compilation issue on arm64 [kernel test robot]
>> ---
>>  drivers/hv/mshv_root_main.c | 113 +++++++++++++++++++++++++++++-------
>>  include/uapi/linux/mshv.h   |  34 +++++++++++
>>  2 files changed, 126 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>> index d542a0143bb8..9f9438289b60 100644
>> --- a/drivers/hv/mshv_root_main.c
>> +++ b/drivers/hv/mshv_root_main.c
>> @@ -1900,43 +1900,114 @@ add_partition(struct mshv_partition *partition)
>>  	return 0;
>>  }
>>  
>> -static long
>> -mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
>> +static_assert(MSHV_NUM_CPU_FEATURES_BANKS ==
>> +	      HV_PARTITION_PROCESSOR_FEATURES_BANKS);
>> +
>> +static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
>> +					struct hv_partition_creation_properties *cr_props,
>> +					union hv_partition_isolation_properties *isol_props)
>>  {
>> -	struct mshv_create_partition args;
>> -	u64 creation_flags;
>> -	struct hv_partition_creation_properties creation_properties = {};
>> -	union hv_partition_isolation_properties isolation_properties = {};
>> -	struct mshv_partition *partition;
>> -	struct file *file;
>> -	int fd;
>> -	long ret;
>> +	int i;
>> +	struct mshv_create_partition_v2 args;
>> +	union hv_partition_processor_features *disabled_procs;
>> +	union hv_partition_processor_xsave_features *disabled_xsave;
>>  
>> -	if (copy_from_user(&args, user_arg, sizeof(args)))
>> +	/* First, copy v1 struct in case user is on previous versions */
>> +	if (copy_from_user(&args, user_arg,
>> +			   sizeof(struct mshv_create_partition)))
>>  		return -EFAULT;
>>  
>>  	if ((args.pt_flags & ~MSHV_PT_FLAGS_MASK) ||
>>  	    args.pt_isolation >= MSHV_PT_ISOLATION_COUNT)
>>  		return -EINVAL;
>>  
>> +	disabled_procs = &cr_props->disabled_processor_features;
>> +	disabled_xsave = &cr_props->disabled_processor_xsave_features;
>> +
>> +	/* Check if user provided newer struct with feature fields */
>> +	if (args.pt_flags & BIT_ULL(MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES)) {
>> +		if (copy_from_user(&args, user_arg, sizeof(args)))
>> +			return -EFAULT;
>> +
>> +		if (args.pt_num_cpu_fbanks != MSHV_NUM_CPU_FEATURES_BANKS ||
>> +		    mshv_field_nonzero(args, pt_rsvd) ||
>> +		    mshv_field_nonzero(args, pt_rsvd1))
>> +			return -EINVAL;
>> +
>> +		/*
>> +		 * Note this assumes MSHV_NUM_CPU_FEATURES_BANKS will never
>> +		 * change and equals HV_PARTITION_PROCESSOR_FEATURES_BANKS
>> +		 * (i.e. 2).
>> +		 *
>> +		 * Further banks (index >= 2) will be modifiable as 'early'
>> +		 * properties via the set partition property hypercall.
>> +		 */
>> +		for (i = 0; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
>> +			disabled_procs->as_uint64[i] = args.pt_cpu_fbanks[i];
>> +
>> +#if IS_ENABLED(CONFIG_X86_64)
>> +		disabled_xsave->as_uint64 = args.pt_disabled_xsave;
>> +#else
>> +		/*
>> +		 * In practice this field is ignored on arm64, but safer to
>> +		 * zero it in case it is ever used.
>> +		 */
>> +		disabled_xsave->as_uint64 = 0;
> 
> Why not explicitly treat non-zero value as invalid here instead?
> Isn't it always better than implicitly (and silently) zeroing it?
> 
This is setting the hypercall input field to zero, because it looks like
the hypervisor ignores it on arm64. That's not ideal but it isn't under
our control here so all we can do is zero it.

The ioctl argument which we *do* control lacks the xsave field on ARM64,
instead we have a reserved field which is checked below (pt_rsvd2).

>> +
>> +		if (mshv_field_nonzero(args, pt_rsvd2))
>> +			return -EINVAL;
>> +#endif
>> +	} else {
>> +		/*
>> +		 * v1 behavior: try to enable everything. The hypervisor will
>> +		 * disable features that are not supported. The banks can be
>> +		 * queried via the get partition property hypercall.
>> +		 */
>> +		for (i = 0; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
>> +			disabled_procs->as_uint64[i] = 0;
>> +
>> +		disabled_xsave->as_uint64 = 0;
>> +	}
>> +
>>  	/* Only support EXO partitions */
>> -	creation_flags = HV_PARTITION_CREATION_FLAG_EXO_PARTITION |
>> -			 HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED;
>> +	*pt_flags = HV_PARTITION_CREATION_FLAG_EXO_PARTITION |
>> +		    HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED;
>> +
>> +	if (args.pt_flags & BIT_ULL(MSHV_PT_BIT_LAPIC))
>> +		*pt_flags |= HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED;
>> +	if (args.pt_flags & BIT_ULL(MSHV_PT_BIT_X2APIC))
>> +		*pt_flags |= HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE;
>> +	if (args.pt_flags & BIT_ULL(MSHV_PT_BIT_GPA_SUPER_PAGES))
>> +		*pt_flags |= HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED;
>>  
>> -	if (args.pt_flags & BIT(MSHV_PT_BIT_LAPIC))
>> -		creation_flags |= HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED;
>> -	if (args.pt_flags & BIT(MSHV_PT_BIT_X2APIC))
>> -		creation_flags |= HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE;
>> -	if (args.pt_flags & BIT(MSHV_PT_BIT_GPA_SUPER_PAGES))
>> -		creation_flags |= HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED;
>> +	isol_props->as_uint64 = 0;
> 
> These properties are missing the nested one.
> I'd recommend squeezing that change in this patch
>
The nested flag is not introduced yet. It should be in a separate patch.

FYI, there is a v5 of this patch I posted on November 13.

Nuno

> Thanks,
> Stanislav
> 
>>  
>>  	switch (args.pt_isolation) {
>>  	case MSHV_PT_ISOLATION_NONE:
>> -		isolation_properties.isolation_type =
>> -			HV_PARTITION_ISOLATION_TYPE_NONE;
>> +		isol_props->isolation_type = HV_PARTITION_ISOLATION_TYPE_NONE;
>>  		break;
>>  	}
>>  
>> +	return 0;
>> +}
>> +
>> +static long
>> +mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
>> +{
>> +	u64 creation_flags;
>> +	struct hv_partition_creation_properties creation_properties;
>> +	union hv_partition_isolation_properties isolation_properties;
>> +	struct mshv_partition *partition;
>> +	struct file *file;
>> +	int fd;
>> +	long ret;
>> +
>> +	ret = mshv_ioctl_process_pt_flags(user_arg, &creation_flags,
>> +					  &creation_properties,
>> +					  &isolation_properties);
>> +	if (ret)
>> +		return ret;
>> +
>>  	partition = kzalloc(sizeof(*partition), GFP_KERNEL);
>>  	if (!partition)
>>  		return -ENOMEM;
>> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
>> index 876bfe4e4227..cf904f3aa201 100644
>> --- a/include/uapi/linux/mshv.h
>> +++ b/include/uapi/linux/mshv.h
>> @@ -26,6 +26,7 @@ enum {
>>  	MSHV_PT_BIT_LAPIC,
>>  	MSHV_PT_BIT_X2APIC,
>>  	MSHV_PT_BIT_GPA_SUPER_PAGES,
>> +	MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES,
>>  	MSHV_PT_BIT_COUNT,
>>  };
>>  
>> @@ -41,6 +42,8 @@ enum {
>>   * @pt_flags: Bitmask of 1 << MSHV_PT_BIT_*
>>   * @pt_isolation: MSHV_PT_ISOLATION_*
>>   *
>> + * This is the initial/v1 version for backward compatibility.
>> + *
>>   * Returns a file descriptor to act as a handle to a guest partition.
>>   * At this point the partition is not yet initialized in the hypervisor.
>>   * Some operations must be done with the partition in this state, e.g. setting
>> @@ -52,6 +55,37 @@ struct mshv_create_partition {
>>  	__u64 pt_isolation;
>>  };
>>  
>> +#define MSHV_NUM_CPU_FEATURES_BANKS 2
>> +
>> +/**
>> + * struct mshv_create_partition_v2
>> + *
>> + * This is extended version of the above initial MSHV_CREATE_PARTITION
>> + * ioctl and allows for following additional parameters:
>> + *
>> + * @pt_num_cpu_fbanks: Must be set to MSHV_NUM_CPU_FEATURES_BANKS.
>> + * @pt_cpu_fbanks: Disabled processor feature banks array.
>> + * @pt_disabled_xsave: Disabled xsave feature bits.
>> + *
>> + * pt_cpu_fbanks and pt_disabled_xsave are passed through as-is to the create
>> + * partition hypercall.
>> + *
>> + * Returns : same as above original mshv_create_partition
>> + */
>> +struct mshv_create_partition_v2 {
>> +	__u64 pt_flags;
>> +	__u64 pt_isolation;
>> +	__u16 pt_num_cpu_fbanks;
>> +	__u8  pt_rsvd[6];		/* MBZ */
>> +	__u64 pt_cpu_fbanks[MSHV_NUM_CPU_FEATURES_BANKS];
>> +	__u64 pt_rsvd1[2];		/* MBZ */
>> +#if defined(__x86_64__)
>> +	__u64 pt_disabled_xsave;
>> +#else
>> +	__u64 pt_rsvd2;			/* MBZ */
>> +#endif
>> +} __packed;
>> +
>>  /* /dev/mshv */
>>  #define MSHV_CREATE_PARTITION	_IOW(MSHV_IOCTL, 0x00, struct mshv_create_partition)
>>  
>> -- 
>> 2.34.1


