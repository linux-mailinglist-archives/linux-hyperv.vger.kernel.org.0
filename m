Return-Path: <linux-hyperv+bounces-8163-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C07CFAA40
	for <lists+linux-hyperv@lfdr.de>; Tue, 06 Jan 2026 20:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 985323016DE1
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Jan 2026 18:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA312D47E6;
	Tue,  6 Jan 2026 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="okqL4eVo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EAC2C21E6;
	Tue,  6 Jan 2026 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767725949; cv=none; b=cUlpR6ey8CvCtYWVyZtfgNmb/xkyvgX1EYeOua2IQAU4xYAUc2xxl/44Mj6WlZIi/T+R2Wt61mI9s48HAZLMbOJrhdnTQLeotYCBKBezSf7PK5EUmnL4V9HNluZik//xB0F/yA5B9Vxot9qW7NWUyoZyo6Oz5A50t5OLKBBmrJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767725949; c=relaxed/simple;
	bh=9p+WiRdCrgPj3QdghM9bfMovVJuH/yeFoONYashQssQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7c2gF2xfS48WtcTFSmeUHYCULF2gdRSMjDiwyIuuDNrWbWBwQfadP2Jgi6c0eyusd02Z4h6OGho3cJP1jRvJ7XmBgBSHn2Q9LVQqZEY9SWyp73DmluqNnuyLq9HmmjDOntPC/cyQKK5qJxrdqRIDe13PaEGzcFlzKihQFB5M9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=okqL4eVo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.129.53] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 570DB2016FF5;
	Tue,  6 Jan 2026 10:59:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 570DB2016FF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767725945;
	bh=OslmCoRC+/wYOaCJtHs6jaeNt5qqHeLeMOnms87v9CQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=okqL4eVokcCnjcDL94Wcu9kMjLxjEbEs+mt57cSVMmEIbHPpvxwfhBSzYtr/0Dfj6
	 xwuiWhivr4GcDeLq25MQiGFUdjr+17TEowL1LML5i00fssRf0wfqhxUzjOVUIRGhdr
	 UKxNewBMtqPoHoyeW3Wjt6OlbAeXZoJkmnGoOyJg=
Message-ID: <0f85eb54-7621-4d06-a707-f5cfde04f31f@linux.microsoft.com>
Date: Tue, 6 Jan 2026 10:59:04 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mshv: handle gpa intercepts for arm64
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260105122837.1083896-1-anirudh@anirudhrb.com>
 <20260105122837.1083896-3-anirudh@anirudhrb.com>
 <aVvvAlsohGEdC6Wv@skinsburskii.localdomain>
 <aVy4BUk9X18KiPCO@anirudh-surface.localdomain>
 <aV05_2Lw6x8Qr_Je@skinsburskii.localdomain>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <aV05_2Lw6x8Qr_Je@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/2026 8:36 AM, Stanislav Kinsburskii wrote:
> On Tue, Jan 06, 2026 at 07:21:41AM +0000, Anirudh Rayabharam wrote:
>> On Mon, Jan 05, 2026 at 09:04:02AM -0800, Stanislav Kinsburskii wrote:
>>> On Mon, Jan 05, 2026 at 12:28:37PM +0000, Anirudh Rayabharam wrote:
>>>> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
>>>>
>>>> The mshv driver now uses movable pages for guests. For arm64 guests
>>>> to be functional, handle gpa intercepts for arm64 too (the current
>>>> code implements handling only for x86).
>>>>
>>>> Move some arch-agnostic functions out of #ifdefs so that they can be
>>>> re-used.
>>>>
>>>> Fixes: b9a66cd5ccbb ("mshv: Add support for movable memory regions")
>>>
>>> I'm not sure that this patch needs "Fixes" tag as it introduced new
>>> functionality rather than fixing a bug.
>>
>> This does fix a bug. The commit mentioned here regressed arm64 guests because
>> it didn't have GPA intercept handling for arm64.
>>
> 
> Were ARM guests functional before this commit? If yes, then I agree that
> this patch fixes a bug. If no, then this is just adding new
> functionality.
> I had an impression ARM is not yet supported in MSHV, so please clarify.
> 

Chiming in, I had a similar discussion with Michael regarding correcting
the value of VpRootDispatchThreadBlocked for ARM64:
https://lore.kernel.org/linux-hyperv/SN6PR02MB41574240F18B87346C659DBFD4BBA@SN6PR02MB4157.namprd02.prod.outlook.com/T/#u

Michael didn't see need for a separate patch for that fix (with "Fixes"
tag, I assumed, though we didn't discuss it). This is because the code
is currently not doing anything due to ARM64 not yet being supported.

Keep in mind adding a "Fixes" tag marks the patch for backporting to LTS
kernels (if the original patch is in one of those, of course). There is
no need for such backporting as it has no impact for features that do not
yet exist. This 'fix' is really a precursor for ARM64 support, and we don't
have a special way of tagging those.

I can see that "Fixes" may help someone who is backporting entire features
to help them identify dependencies (e.g. backporting ARM64 support), but
the benefit of that is conjectural so I don't see it as a strong enough
reason given the above.

Nuno

> Thanks,
> Stanislav
> 
>> Thanks,
>> Anirudh.
>>
>>>
>>> Thanks,
>>> Stanislav
>>>
>>>> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
>>>> ---
>>>>  drivers/hv/mshv_root_main.c | 15 ++++++++-------
>>>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>>>> index 9cf28a3f12fe..f8c4c2ae2cc9 100644
>>>> --- a/drivers/hv/mshv_root_main.c
>>>> +++ b/drivers/hv/mshv_root_main.c
>>>> @@ -608,7 +608,6 @@ mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
>>>>  	return NULL;
>>>>  }
>>>>  
>>>> -#ifdef CONFIG_X86_64
>>>>  static struct mshv_mem_region *
>>>>  mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
>>>>  {
>>>> @@ -640,12 +639,17 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
>>>>  {
>>>>  	struct mshv_partition *p = vp->vp_partition;
>>>>  	struct mshv_mem_region *region;
>>>> -	struct hv_x64_memory_intercept_message *msg;
>>>>  	bool ret;
>>>>  	u64 gfn;
>>>> -
>>>> -	msg = (struct hv_x64_memory_intercept_message *)
>>>> +#if defined(CONFIG_X86_64)
>>>> +	struct hv_x64_memory_intercept_message *msg =
>>>> +		(struct hv_x64_memory_intercept_message *)
>>>> +		vp->vp_intercept_msg_page->u.payload;
>>>> +#elif defined(CONFIG_ARM64)
>>>> +	struct hv_arm64_memory_intercept_message *msg =
>>>> +		(struct hv_arm64_memory_intercept_message *)
>>>>  		vp->vp_intercept_msg_page->u.payload;
>>>> +#endif
>>>>  
>>>>  	gfn = HVPFN_DOWN(msg->guest_physical_address);
>>>>  
>>>> @@ -663,9 +667,6 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
>>>>  
>>>>  	return ret;
>>>>  }
>>>> -#else  /* CONFIG_X86_64 */
>>>> -static bool mshv_handle_gpa_intercept(struct mshv_vp *vp) { return false; }
>>>> -#endif /* CONFIG_X86_64 */
>>>>  
>>>>  static bool mshv_vp_handle_intercept(struct mshv_vp *vp)
>>>>  {
>>>> -- 
>>>> 2.34.1
>>>>


