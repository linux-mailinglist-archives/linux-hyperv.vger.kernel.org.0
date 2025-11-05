Return-Path: <linux-hyperv+bounces-7413-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42178C37713
	for <lists+linux-hyperv@lfdr.de>; Wed, 05 Nov 2025 20:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03BD84EB5AD
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Nov 2025 19:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449EF329369;
	Wed,  5 Nov 2025 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Lo0K6I2C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772B1321422;
	Wed,  5 Nov 2025 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369842; cv=none; b=pRZ+STO8HMDpKVBwgpS75CedQnIZSY0nqSSwR12niXB1jpi+PzBuuWPqwIq0tezUR+RxRt8/En8c0rPaHaCYxN4HxFHhAl/wxTw7dqHfCK3nVtHAMROoWMdnjnqmLI74Sa5vaUQU12y3k0kskne7gu54qYLN3xaooyXz1cp5ajI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369842; c=relaxed/simple;
	bh=QumDJDKN3BbP+JeTHScZ3LMa/AbubpDuNa6w7jIQhPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ualQN97B0A69LiHPPPQQ+DeI5WtGu5pJh426yUyE0NYKnvMBXnjz4rV6j4UXKk61kj8tZUEiRaoHh4mr5D4V3kwjba9qdn80Oo9qoW2+GXiwijbz9wBi1iX5Gpa8HaNgX9A7/CSKBoKJWuPsIIW2M6dY9cogR1zg4P819/Hu6gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Lo0K6I2C; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 33D1D20120AA;
	Wed,  5 Nov 2025 11:10:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 33D1D20120AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762369839;
	bh=EuwYc2LuCt2GdBfXpQF0MJHPZO9Mje71Y+veLXDEU78=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Lo0K6I2Cf+twolyKhr1Lnb4oLxPBLss2OhD9i3d7RBEG53HfLGL4RDMUbPCDxOjbb
	 eJRHkkheyLWCs0zIgMIh8Jby8OWrRmFbYwGFRGQKw7Iyu5fnBNPQa4JmXd4Wkdvl//
	 HRqG6ebmfCzUEwbSrCZijM+UXKVyDGizQIr5EYZs=
Message-ID: <31e9a5be-05d6-49f8-893e-2d8986dc8ce4@linux.microsoft.com>
Date: Wed, 5 Nov 2025 11:10:28 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mshv: Extend create partition ioctl to support cpu
 features
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "muislam@microsoft.com" <muislam@microsoft.com>,
 "easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "longli@microsoft.com" <longli@microsoft.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "romank@linux.microsoft.com" <romank@linux.microsoft.com>,
 Jinank Jain <jinankjain@microsoft.com>
References: <1762292846-14253-1-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB41571FC666D406397858A377D4C5A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41571FC666D406397858A377D4C5A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/2025 9:41 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, November 4, 2025 1:47 PM
>>
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
>> The kernel does not introspect the bits in these new fields as they
>> are part of the hypervisor ABI. Require the caller to provide the
>> number of cpu feature banks passed, to support extending the number
>> of banks in future. Disable all banks that are not specified to ensure
>> the behavior is predictable with newer hypervisors.
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
>>
>> ---
>>  drivers/hv/mshv_root_main.c | 94 ++++++++++++++++++++++++++++++-------
>>  include/uapi/linux/mshv.h   | 34 ++++++++++++++
>>  2 files changed, 110 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>> index d542a0143bb8..814465a0912d 100644
>> --- a/drivers/hv/mshv_root_main.c
>> +++ b/drivers/hv/mshv_root_main.c
>> @@ -1900,43 +1900,101 @@ add_partition(struct mshv_partition *partition)
>>  	return 0;
>>  }
>>
>> -static long
>> -mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
>> +static_assert(MSHV_NUM_CPU_FEATURES_BANKS <=
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
>> +	/* First, copy orig struct in case user is on previous versions */
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
>> +	if (args.pt_flags & BIT(MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES)) {
> 
> Should probably be "BIT_ULL" instead of "BIT" since args.pt_flags is a long long field,
> though it really doesn't matter as long as the number of flags is <= 32.
> 
Noted, thanks

>> +		if (copy_from_user(&args, user_arg, sizeof(args)))
>> +			return -EFAULT;
>> +
>> +		if (args.pt_num_cpu_fbanks > MSHV_NUM_CPU_FEATURES_BANKS ||
>> +		    mshv_field_nonzero(args, pt_rsvd) ||
>> +		    mshv_field_nonzero(args, pt_rsvd1))
>> +			return -EINVAL;
>> +
>> +
>> +		for (i = 0; i < args.pt_num_cpu_fbanks; i++)
>> +			disabled_procs->as_uint64[i] = args.pt_cpu_fbanks[i];
>> +
>> +		/* Disable any features left unspecified */
>> +		for (; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
>> +			disabled_procs->as_uint64[i] = -1;
> 
> I'm trying to convince myself that disabling unspecified features is the right
> thing to do. In the current hypervisor scenario with 2 banks, if the VMM caller
> specifies only one bank of disable flags, then all the features in the 2nd bank
> are disabled. That's certainly the reverse from the current code which
> always enables all features, and from the hypervisor itself which in the
> hypercall ABI defines the flags as "disable" flags rather than "enable" flags.
> 
> Then in a scenario where a new version of the hypervisor shows up with
> support for 3 banks, the old VMM code that only knows about 2 banks
> will cause all features in that 3rd bank to be disabled. Again, that's the
> reverse of the current code.
> 
> I guess it depends on how the hypervisor defines any such new features.
> Are they typically defined to be benign if they are enabled by default? Or
> is the polarity the opposite, where the VMM must know about new
> features before they are enabled? The hypercall interface seems to imply
> the former but maybe I'm reading too much into it.
> 
The intent is to provide an interface which allows the VMM to control exactly
which features are enabled/disabled. E.g. for live migration of a VM, if the
target machine has more features available and they are enabled inadvertently,
the state may not be restored properly (particularly an issue for xsave).

So to me it makes sense to disable anything unspecified. In general, enabling
features by default doesn't cause problems, it's only for specific scenarios
like the above. I suppose that's why it's a "disable" mask, though I can't
say I fully understand the reasoning...

> A code comment about the thinking here would be useful for future readers.
> 
Noted. I can repeat the reasoning from the commit message if that is
sufficient:
"
Disable all banks that are not specified to ensure
the behavior is predictable with newer hypervisors.
"

>> +
>> +#if IS_ENABLED(CONFIG_X86_64)
>> +		disabled_xsave->as_uint64 = args.pt_disabled_xsave;
>> +#else
>> +		if (mshv_field_nonzero(args, pt_rsvd2))
>> +			return -EINVAL;
>> +
>> +		disabled_xsave->as_uint64 = -1;
> 
> Does the arm64 version of the hypercall do anything with this field?
> Or does it just ignore it? I would be more inclined to set ignored
> fields to zero unless there's an identifiable reason otherwise.
> (especially since the VMM is required to pass in zero on arm64).
> 
Good point. Checking the code, it seems to be completely ignored on arm64.
I will remove this line.

>> +#endif
>> +	} else {
>> +		/* v1 behavior: try to enable everything */
>> +		for (i = 0; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
>> +			disabled_procs->as_uint64[i] = 0;
>> +
>> +		disabled_xsave->as_uint64 = 0;
>> +	}
>> +
>>  	/* Only support EXO partitions */
>> -	creation_flags = HV_PARTITION_CREATION_FLAG_EXO_PARTITION  HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED;
>> +	*pt_flags = HV_PARTITION_CREATION_FLAG_EXO_PARTITION |
>> +		 HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED;
>>
>>  	if (args.pt_flags & BIT(MSHV_PT_BIT_LAPIC))
>> -		creation_flags |= HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED;
>> +		*pt_flags |= HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED;
>>  	if (args.pt_flags & BIT(MSHV_PT_BIT_X2APIC))
>> -		creation_flags |= HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE;
>> +		*pt_flags |= HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE;
>>  	if (args.pt_flags & BIT(MSHV_PT_BIT_GPA_SUPER_PAGES))
>> -		creation_flags |= HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED;
>> +		*pt_flags |= HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED;
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
>> +	struct hv_partition_creation_properties creation_properties = {};
>> +	union hv_partition_isolation_properties isolation_properties = {};
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
>> index 876bfe4e4227..9091946cba23 100644
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
>> + * This is the initial/v0 version for backward compatibility.
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
>> + * @pt_num_cpu_fbanks: number of processor feature banks being provided.
>> + *                     This must not exceed MSHV_NUM_CPU_FEATURES_BANKS.
>> + *                     If set to less than the number of available banks,
>> + *                     additional banks will be set to -1 (disabled).
>> + * @pt_cpu_fbanks: disabled processor feature banks array.
>> + * @pt_disabled_xsave: disabled xsave feature bits.
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
> 
> I presume this is for future expansion of the number of banks?
> And that the choice of 2 additional banks is somewhat arbitrary?
> 
A 3rd bank is sure to be added in the near future. At this rate
it seems likely a 4th will eventually be needed, though it's hard
to say for sure.

Nuno

> Michael
> 
>> +#if defined(__x86_64__)
>> +	__u64 pt_disabled_xsave;
>> +#else
>> +	__u64 pt_rsvd2;			/* MBZ */
>> +#endif
>> +} __packed;
>> +
>>  /* /dev/mshv */
>>  #define MSHV_CREATE_PARTITION	_IOW(MSHV_IOCTL, 0x00, struct
>> mshv_create_partition)
>>
>> --
>> 2.34.1


