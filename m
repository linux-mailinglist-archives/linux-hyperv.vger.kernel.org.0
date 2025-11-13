Return-Path: <linux-hyperv+bounces-7551-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EB4C59B48
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 20:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A59864EFE02
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 19:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBB12580F3;
	Thu, 13 Nov 2025 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DPgrxCLP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674A629993E;
	Thu, 13 Nov 2025 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763061131; cv=none; b=WdCoOb4aWGJpQ/51S34FTafvDoPvaghWplgsxwBkd3w32gX+wAIVGXQqP7/r4he4tCtFrpEV69r0vf951wK5FHrziAYhS78Z5x4MrjeR94tP1tmcYzKlS/X+Mc0QaJRomHvBUBlkZDiKVfK3IXNB0ZeIpQHW8E6Jv2DrZdAKYmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763061131; c=relaxed/simple;
	bh=SzzVssJKqrefZASVPTYlhJo6W3i1OeCx0h7FMDtgxqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPkLNCgmLds43eUGPmEZp+HsbBENBFcIXfXm0BDoOIL8uh7ceSb19ZY4/aBbZct9yuJpI8HlD9Vf4LLHsIv6ulAImQ/zJhW3Dz6TyM08kTmfEKfg7MXNZSonfzRcgJRSx5LQo75d+I90AQEIkmgAMwGXJR8PIzcbfs/M4OUskSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DPgrxCLP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 09BAD201337E;
	Thu, 13 Nov 2025 11:12:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 09BAD201337E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763061128;
	bh=rplNRdghazSdMMwTPIGxtO+NhtiFxhk0uuUg97JkDEA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DPgrxCLPrhOURFKj7GVOp3aDztXX3mgkyoS+FKr0vp3lvfAc0gbstnuTTUOrC1zy0
	 hAxRTVBu3v8YYcUa0o4j/f+0cRa1LEUeq5TfHjD+RqfGQD9jjDv1vso1jGaQrzAYzW
	 +6IVvOEjyXG/6Wimbjb8tPTEb9jBtCAHTT6Ti1+I=
Message-ID: <b3a05360-0c55-4ec1-81c2-aa093ff78333@linux.microsoft.com>
Date: Thu, 13 Nov 2025 11:11:57 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mshv: Extend create partition ioctl to support cpu
 features
To: Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "longli@microsoft.com" <longli@microsoft.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "prapal@linux.microsoft.com" <prapal@linux.microsoft.com>,
 "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
 "muislam@microsoft.com" <muislam@microsoft.com>,
 "anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>,
 Jinank Jain <jinankjain@microsoft.com>
References: <1762903194-25195-1-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB415718EF45BF1B79F2C15F20D4CCA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20251113184756.GA1175882@liuwe-devbox-debian-v2.local>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20251113184756.GA1175882@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/2025 10:47 AM, Wei Liu wrote:
> On Wed, Nov 12, 2025 at 04:27:05PM +0000, Michael Kelley wrote:
>> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, November 11, 2025 3:20 PM
>>>
>>> The existing mshv create partition ioctl does not provide a way to
>>> specify which cpu features are enabled in the guest. Instead, it
>>> attempts to enable all features and those that are not supported are
>>> silently disabled by the hypervisor.
>>>
>>> This was done to reduce unnecessary complexity and is sufficient for
>>> many cases. However, new scenarios require fine-grained control over
>>> these features.
>>>
>>> Define a new mshv_create_partition_v2 structure which supports
>>> passing the disabled processor and xsave feature bits through to the
>>> create partition hypercall directly.
>>>
>>> Introduce a new flag MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES which enables
>>> the new structure. If unset, the original mshv_create_partition struct
>>> is used, with the old behavior of enabling all features.
>>>
>>> Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
>>> Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
>>> Signed-off-by: Muminul Islam <muislam@microsoft.com>
>>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>>> ---
>>> Changes in v4:
>>> - Change BIT() to BIT_ULL() [Michael Kelley]
>>> - Enforce pt_num_cpu_fbanks == MSHV_NUM_CPU_FEATURES_BANKS and expect
>>>   that number to never change. In future, additional processor banks
>>>   will be settable as 'early' partition properties. Remove redundant
>>>   code that set default values for unspecified banks [Michael Kelley]
>>> - Set xsave features to 0 on arm64 [Michael Kelley]
>>> - Add clarifying comments in a few places
>>>
>>> Changes in v3:
>>> - Remove the new cpu features definitions in hvhdk.h, and retain the
>>>   old behavior of enabling all features for the old struct. For the v2
>>>   struct, still disable unspecified feature banks, since that makes it
>>>   robust to future extensions.
>>> - Amend comments and commit message to reflect the above
>>> - Fix unused variable on arm64 [kernel test robot]
>>>
>>> Changes in v2:
>>> - Fix exposure of CONFIG_X86_64 to uapi [kernel test robot]
>>> - Fix compilation issue on arm64 [kernel test robot]
>>> ---
>>>  drivers/hv/mshv_root_main.c | 113 +++++++++++++++++++++++++++++-------
>>>  include/uapi/linux/mshv.h   |  34 +++++++++++
>>>  2 files changed, 126 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>>> index d542a0143bb8..9f9438289b60 100644
>>> --- a/drivers/hv/mshv_root_main.c
>>> +++ b/drivers/hv/mshv_root_main.c
>>> @@ -1900,43 +1900,114 @@ add_partition(struct mshv_partition *partition)
>>>  	return 0;
>>>  }
>>>
>>> -static long
>>> -mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
>>> +static_assert(MSHV_NUM_CPU_FEATURES_BANKS ==
>>> +	      HV_PARTITION_PROCESSOR_FEATURES_BANKS);
>>> +
>>> +static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
>>> +					struct hv_partition_creation_properties *cr_props,
>>> +					union hv_partition_isolation_properties *isol_props)
>>>  {
>>> -	struct mshv_create_partition args;
>>> -	u64 creation_flags;
>>> -	struct hv_partition_creation_properties creation_properties = {};
>>> -	union hv_partition_isolation_properties isolation_properties = {};
>>> -	struct mshv_partition *partition;
>>> -	struct file *file;
>>> -	int fd;
>>> -	long ret;
>>> +	int i;
>>> +	struct mshv_create_partition_v2 args;
>>> +	union hv_partition_processor_features *disabled_procs;
>>> +	union hv_partition_processor_xsave_features *disabled_xsave;
>>>
>>> -	if (copy_from_user(&args, user_arg, sizeof(args)))
>>> +	/* First, copy v1 struct in case user is on previous versions */
>>> +	if (copy_from_user(&args, user_arg,
>>> +			   sizeof(struct mshv_create_partition)))
>>>  		return -EFAULT;
>>>
>>>  	if ((args.pt_flags & ~MSHV_PT_FLAGS_MASK) ||
>>>  	    args.pt_isolation >= MSHV_PT_ISOLATION_COUNT)
>>>  		return -EINVAL;
>>>
>>> +	disabled_procs = &cr_props->disabled_processor_features;
>>> +	disabled_xsave = &cr_props->disabled_processor_xsave_features;
>>> +
>>> +	/* Check if user provided newer struct with feature fields */
>>> +	if (args.pt_flags & BIT_ULL(MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES)) {
>>> +		if (copy_from_user(&args, user_arg, sizeof(args)))
>>> +			return -EFAULT;
>>
>> There's subtle issue here that I didn't notice previously. This second copy_from_user()
>> re-populates the first two fields of the "args" local variable. These two fields were
>> validated by code a few lines above. But there's no guarantee that a second read of
>> user space will get the same values. User space could have another thread that
>> changes the user space values between the two copy_from_user() calls, and thereby
>> sneak in some bogus values to be used further down in this function. Because of
>> this risk, there's a general rule for kernel code, which is to avoid multiple accesses to
>> the same user space values. There are places in the kernel where such double reads
>> would be an exploitable security hole.
>>

Good catch Michael! It's something I had read about once before long ago but had forgotten.
I wonder if there's some kind of automation that could warn about potential issues - i.e.
copy_from_user() on the same pointer twice.

>> The fix would be to validate the pt_flags and pt_isolation fields again, or to have the
>> second copy_from_user copy only the additional fields. But it's also the case that the
>> way the pt_flags and pt_isolation fields are used further down in this function,
>> nothing bad can happen if malicious user space should succeed in sneaking in some
>> bogus values.
>>
>> Net, as currently coded, there's nothing that needs to be fixed. It would be more
>> robust to do one of the two fixes, if for no other reason than to acknowledge
>> awareness of the risk of reading user space twice. But I'm not going to insist
>> on a respin.
> 
> Nuno, I can commit this patch first. If you can post a diff later I can
> squash it in.

It might be easier if I just spin a v5 today? I'll send it soon.

> 
> 	/* Re-validate fields after the second copy_from_user */
>   	if ((args.pt_flags & ~MSHV_PT_FLAGS_MASK) ||
>   	    args.pt_isolation >= MSHV_PT_ISOLATION_COUNT)
>   		return -EINVAL;
> 
> Perhaps something like this after the second copy_from_user()?
> 

Yes, that sounds fine. I thought about just copying the second part
of the struct but re-checking those fields looks like a simpler and
less error-prone way to me. 

Nuno

>>> Other than the double read of user space, LGTM.
>>
>> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> 
> Thank you for the detailed review!
> 
> Wei


