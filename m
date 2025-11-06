Return-Path: <linux-hyperv+bounces-7442-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3917C3CE88
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 18:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6B63A3E5F
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 17:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7198E34BA5B;
	Thu,  6 Nov 2025 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NpKcy7ZT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FC12BFC60;
	Thu,  6 Nov 2025 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450944; cv=none; b=G1jLvPNcrNlnG5YPumCLx5fjAh0q05v7rJkExG//667grsTTpWoVfxZBV/n6rpFRbIbLOSCt9Hc2KdA/gzL2O1rIjrTVXVtXBYa677vSd0DEYmRU0P3sHS0SGQBHhpN5TU+ODYEqyJ7oopVjUoR0QYmVVJ0vCYLKbDqkyfdsY2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450944; c=relaxed/simple;
	bh=yHArg5FBnj30VMUuSdzl1q+XhRzBO42dqitc1BWdDw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFO6ssSgSsynNBITcngP7QU4xAB8UVOyj0o+czRGvqTXDWZTzn0lTOXNTCG63iN9qvgac2H1OC+gZjh4Dn9s9TWFlCWsjsYOWPROd8i1Hfzzd2zPDRyxLnZ1VL3Icrq9LoRt4get7OimRiHpEOIrbfgyz2NPFfcKDS/NQflXnBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NpKcy7ZT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 186FE201CEF4;
	Thu,  6 Nov 2025 09:42:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 186FE201CEF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762450941;
	bh=GLJwZlGePwtg0YW1Z/ca+70xTWZT5B95qkhJxkj6Zds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NpKcy7ZTotGjvBvFSbk8Y7pes0ZKfEToDWzPQSP3GvKmX8z/vBJAVHLrrlghNZW2B
	 +0WoWJ9kvdGpSug5yCSMn7gsM2JA1vsajvVYdkpNfwEPbovHdu7nXPFdFZ1rlrZBwe
	 1f2J4gP6BFqDoYLFO1o+Kpub+BgCbGTRme8W6m2Q=
Message-ID: <66d77b7a-673f-4339-a4fe-81cadc31b018@linux.microsoft.com>
Date: Thu, 6 Nov 2025 09:42:07 -0800
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
 <31e9a5be-05d6-49f8-893e-2d8986dc8ce4@linux.microsoft.com>
 <SN6PR02MB4157D85AE644F1DE8394BB98D4C2A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157D85AE644F1DE8394BB98D4C2A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/2025 8:56 PM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, November 5, 2025 11:10 AM
>>
>> On 11/5/2025 9:41 AM, Michael Kelley wrote:
>>> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, November 4, 2025 1:47 PM
>>>>
>>>> From: Muminul Islam <muislam@microsoft.com>
>>>>
>>>> The existing mshv create partition ioctl does not provide a way to
>>>> specify which cpu features are enabled in the guest. Instead, it
>>>> attempts to enable all features and those that are not supported are
>>>> silently disabled by the hypervisor.
>>>>
>>>> This was done to reduce unnecessary complexity and is sufficient for
>>>> many cases. However, new scenarios require fine-grained control over
>>>> these features.
>>>>
>>>> Define a new mshv_create_partition_v2 structure which supports
>>>> passing the disabled processor and xsave feature bits through to the
>>>> create partition hypercall directly.
>>>>
>>>> The kernel does not introspect the bits in these new fields as they
>>>> are part of the hypervisor ABI. Require the caller to provide the
>>>> number of cpu feature banks passed, to support extending the number
>>>> of banks in future. Disable all banks that are not specified to ensure
>>>> the behavior is predictable with newer hypervisors.
>>>>
>>>> Introduce a new flag MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES which enables
>>>> the new structure. If unset, the original mshv_create_partition struct
>>>> is used, with the old behavior of enabling all features.
>>>>
>>>> Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
>>>> Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
>>>> Signed-off-by: Muminul Islam <muislam@microsoft.com>
>>>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>>>> ---
>>>> Changes in v3:
>>>> - Remove the new cpu features definitions in hvhdk.h, and retain the
>>>>   old behavior of enabling all features for the old struct. For the v2
>>>>   struct, still disable unspecified feature banks, since that makes it
>>>>   robust to future extensions.
>>>> - Amend comments and commit message to reflect the above
>>>> - Fix unused variable on arm64 [kernel test robot]
>>>>
>>>> Changes in v2:
>>>> - Fix exposure of CONFIG_X86_64 to uapi [kernel test robot]
>>>> - Fix compilation issue on arm64 [kernel test robot]
>>>>
>>>> ---
>>>>  drivers/hv/mshv_root_main.c | 94 ++++++++++++++++++++++++++++++-------
>>>>  include/uapi/linux/mshv.h   | 34 ++++++++++++++
>>>>  2 files changed, 110 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>>>> index d542a0143bb8..814465a0912d 100644
>>>> --- a/drivers/hv/mshv_root_main.c
>>>> +++ b/drivers/hv/mshv_root_main.c
>>>> @@ -1900,43 +1900,101 @@ add_partition(struct mshv_partition *partition)
>>>>  	return 0;
>>>>  }
>>>>
>>>> -static long
>>>> -mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
>>>> +static_assert(MSHV_NUM_CPU_FEATURES_BANKS <=
>>>> +	      HV_PARTITION_PROCESSOR_FEATURES_BANKS);
>>>> +
>>>> +static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
>>>> +					struct hv_partition_creation_properties *cr_props,
>>>> +					union hv_partition_isolation_properties *isol_props)
>>>>  {
>>>> -	struct mshv_create_partition args;
>>>> -	u64 creation_flags;
>>>> -	struct hv_partition_creation_properties creation_properties = {};
>>>> -	union hv_partition_isolation_properties isolation_properties = {};
>>>> -	struct mshv_partition *partition;
>>>> -	struct file *file;
>>>> -	int fd;
>>>> -	long ret;
>>>> +	int i;
>>>> +	struct mshv_create_partition_v2 args;
>>>> +	union hv_partition_processor_features *disabled_procs;
>>>> +	union hv_partition_processor_xsave_features *disabled_xsave;
>>>>
>>>> -	if (copy_from_user(&args, user_arg, sizeof(args)))
>>>> +	/* First, copy orig struct in case user is on previous versions */
>>>> +	if (copy_from_user(&args, user_arg,
>>>> +			   sizeof(struct mshv_create_partition)))
>>>>  		return -EFAULT;
>>>>
>>>>  	if ((args.pt_flags & ~MSHV_PT_FLAGS_MASK) ||
>>>>  	    args.pt_isolation >= MSHV_PT_ISOLATION_COUNT)
>>>>  		return -EINVAL;
>>>>
>>>> +	disabled_procs = &cr_props->disabled_processor_features;
>>>> +	disabled_xsave = &cr_props->disabled_processor_xsave_features;
>>>> +
>>>> +	/* Check if user provided newer struct with feature fields */
>>>> +	if (args.pt_flags & BIT(MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES)) {
>>>
>>> Should probably be "BIT_ULL" instead of "BIT" since args.pt_flags is a long long field,
>>> though it really doesn't matter as long as the number of flags is <= 32.
>>>
>> Noted, thanks
>>
>>>> +		if (copy_from_user(&args, user_arg, sizeof(args)))
>>>> +			return -EFAULT;
>>>> +
>>>> +		if (args.pt_num_cpu_fbanks > MSHV_NUM_CPU_FEATURES_BANKS ||
>>>> +		    mshv_field_nonzero(args, pt_rsvd) ||
>>>> +		    mshv_field_nonzero(args, pt_rsvd1))
>>>> +			return -EINVAL;
>>>> +
>>>> +
>>>> +		for (i = 0; i < args.pt_num_cpu_fbanks; i++)
>>>> +			disabled_procs->as_uint64[i] = args.pt_cpu_fbanks[i];
>>>> +
>>>> +		/* Disable any features left unspecified */
>>>> +		for (; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
>>>> +			disabled_procs->as_uint64[i] = -1;
>>>
>>> I'm trying to convince myself that disabling unspecified features is the right
>>> thing to do. In the current hypervisor scenario with 2 banks, if the VMM caller
>>> specifies only one bank of disable flags, then all the features in the 2nd bank
>>> are disabled. That's certainly the reverse from the current code which
>>> always enables all features, and from the hypervisor itself which in the
>>> hypercall ABI defines the flags as "disable" flags rather than "enable" flags.
>>>
>>> Then in a scenario where a new version of the hypervisor shows up with
>>> support for 3 banks, the old VMM code that only knows about 2 banks
>>> will cause all features in that 3rd bank to be disabled. Again, that's the
>>> reverse of the current code.
>>>
>>> I guess it depends on how the hypervisor defines any such new features.
>>> Are they typically defined to be benign if they are enabled by default? Or
>>> is the polarity the opposite, where the VMM must know about new
>>> features before they are enabled? The hypercall interface seems to imply
>>> the former but maybe I'm reading too much into it.
>>>
>> The intent is to provide an interface which allows the VMM to control exactly
>> which features are enabled/disabled. E.g. for live migration of a VM, if the
>> target machine has more features available and they are enabled inadvertently,
>> the state may not be restored properly (particularly an issue for xsave).
>>
>> So to me it makes sense to disable anything unspecified. In general, enabling
>> features by default doesn't cause problems, it's only for specific scenarios
>> like the above. I suppose that's why it's a "disable" mask, though I can't
>> say I fully understand the reasoning...
>>
>>> A code comment about the thinking here would be useful for future readers.
>>>
>> Noted. I can repeat the reasoning from the commit message if that is
>> sufficient:
>> "
>> Disable all banks that are not specified to ensure
>> the behavior is predictable with newer hypervisors.
>> "
> 
> Before deciding on the wording of the comment, one more thought
> occurred to me.  union hv_partition_processor_features is currently
> two 64-bit banks. Bank 0 currently has 63 features plus 1 reserved bit.
> Bank 1 currently has 22 features, and 42 reserved bits. A new version
> of the hypervisor could use one or more of those 42 reserved bits for
> new features.
> 
> If a VMM is running on a newer hypervisor version that implements
> features the VMM is unaware of, the intent is that those features
> should be disabled by default. So is the expectation that when a
> VMM provides Bank 0 and Bank 1 values, it should set all the
> reserved bits to 1?  (currently the single bit in Bank 0 and the 42 bits
> in Bank 1)  My point is that the default disabling of new features can't
> be handled entirely by the kernel implementation of the ioctl based
> on the bank count passed in the argument to the ioctl. The VMM
> must cooperate as well.  And such splitting of the responsibility
> seems rather messy.
> 
> I see three cleaner alternatives:
> 
> 1) Have the argument to the ioctl pass the "max known feature number"
> instead of the bank count. Then the kernel implementation could set to
> 1 all feature bits after that max. This alternative makes the kernel
> fully responsible for doing the default disabling, based on what the
> VMM tells the kernel it knows about.
> 
> 2) Define the expected future Bank 2 and Bank 3 fields in
> struct mshv_create_partition_v2, and require the VMM to set them to
> all 1's as well as the reserved fields in Bank 0 and Bank 1. This alternative
> makes the VMM fully responsible for doing the default disabling.
> 
> 3) As a variant of my #2, invert the polarity of the bits in the pt_cpu_fbanks
> field of the ioctl argument, so that from the VMM's standpoint they are
> feature *enable* bits, not feature *disable* bits. The VMM sets bits for
> the features it knows about and wants to have enabled, which is the
> much more common pattern. Kernel code would then invert each bank
> before passing to the hypercall. The Bank 2 and Bank 3 fields would be
> set to zero by the VMM, and get the same kernel treatment when future
> hypervisor versions accept the additional banks.
> 
> Thoughts?
> 

I discussed the future direction of this API with the hypervisor team.
Surprisingly, it turns out they will add new feature banks but those
will NOT be exposed at partition creation time. Rather, they will be
set via the set partition property hypercall as an "early" property.
That is, after partition creation but before initialization.

This means that we will only need to ever expose 2 banks in this ioctl.
I think requiring the VMM to provide both banks is reasonable, as well
as not doing any default disabling in the kernel. i.e. Your suggested
#2 but with only the 2 banks.

Regarding #3, I want to keep the feature bits as a 'passthrough' field
that the kernel doesn't touch, and anyway with a known number of banks
this is unnecessary.

On a related note, discussing the reasoning for the inversion in the
first place, the hypervisor team told me the primary reason is so that
new processor security features can be added to the mask and enabled
by default when set to 0. This logic is a little funny given the
hypervisor doesn't seem to care whether the reserved bits are 1 or 0
today, but I guess they are meant to be always 0.

In light of all this, now the reserved fields in the ioctl struct aren't
serving any purpose. However, unfortunately I don't think I can remove
them since userspace code already depends on this structure.

I think pt_num_cpu_fbanks has to stay, too, although I think it's better
to enforce that it is set to 2 by userspace and return -EINVAL otherwise.

Does that all make sense or did I miss something?

This information about how the banks will be extended came as a surprise
to me. I only brought it up with the hypervisor folks due to your
questions here. This is a good thing, thanks for promoting this discussion.

Nuno

> Michael

