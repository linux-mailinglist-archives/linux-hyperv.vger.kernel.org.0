Return-Path: <linux-hyperv+bounces-8091-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB529CE8674
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Dec 2025 01:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FA1B3008FBF
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Dec 2025 00:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C8F2836A6;
	Tue, 30 Dec 2025 00:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FsQeQ7MM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DE127F171;
	Tue, 30 Dec 2025 00:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767054455; cv=none; b=Cx7yBCdlj483Glb91zVV+m/ydFqapZhZaEaW82ZTB9d/rdP2kdCik0EBkwlvfDiNTVgZrGBOvRBDwZervDF3xAoJOF+yD/8mr0Xa+q9EqrbuZ3GWoTdj/PM+JvbGax3XbDti3ECkVKokwQ561hlMYZVazx9TV6eQqUO1vYWsGkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767054455; c=relaxed/simple;
	bh=g7RjodGt6MF/mkLiIMyHaVA0mOY4CoZjQ6Lmg+udvvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQCz2RGY1mEjPMutTbceEglDQvyaA3jUHHcPvQ4uqx0sdkrQ+IUcgHsm8ixfyQT0sjIMLyL5GTmaCYNZSmhA/xV25H56WovnmOtqi1E6BHpaoz67soIxbTkeZKyPsgfcuzaIIY+LoDe+14VWGSVEIRpzCcoPCt82aIlIHJwNnHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FsQeQ7MM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.208.55] (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5EF5721246E2;
	Mon, 29 Dec 2025 16:27:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5EF5721246E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767054452;
	bh=3sBeOI2MixFkMjoOM+ZfX7Z9nUAF+2n/aiQ4awwT5Ao=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FsQeQ7MM7/ek5pCVnyQdZnp/tme9UghpxUgJIsCW3wTqdmGetJa4RlDf9WvptG2TD
	 8W5ZYkYzfeOo5e3LJMH0RNwY7F5tIKFY5LCWLYZ9UMbn38kTdQRodab9wS67gqS7mW
	 ntFMauWqt1aCdvD8uSheAz7r8+kIne2g/1zS7raQ=
Message-ID: <9a997f03-f1be-411b-b4b2-c28069b2a3ce@linux.microsoft.com>
Date: Mon, 29 Dec 2025 16:27:31 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mshv: Ignore second stats page map result failure
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "longli@microsoft.com" <longli@microsoft.com>,
 "prapal@linux.microsoft.com" <prapal@linux.microsoft.com>,
 "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
 "paekkaladevi@linux.microsoft.com" <paekkaladevi@linux.microsoft.com>
References: <1764961122-31679-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1764961122-31679-2-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB41578C85BD5C114340677F84D4A2A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41578C85BD5C114340677F84D4A2A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/8/2025 7:12 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, December 5, 2025 10:59 AM
>>
>> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>>
>> Older versions of the hypervisor do not support HV_STATS_AREA_PARENT
>> and return HV_STATUS_INVALID_PARAMETER for the second stats page
>> mapping request.
>>
>> This results a failure in module init. Instead of failing, gracefully
>> fall back to populating stats_pages[HV_STATS_AREA_PARENT] with the
>> already-mapped stats_pages[HV_STATS_AREA_SELF].
> 
> This explains "what" this patch does. But could you add an explanation of "why"
> substituting SELF for the unavailable PARENT is the right thing to do? As a somewhat
> outside reviewer, I don't know enough about SELF vs. PARENT to immediately know
> why this substitution makes sense.
> 
I'll attempt to explain. I'm a little hindered by the fact that like many of the
root interfaces this is not well-documented, but this is my understanding:

The stats areas HV_STATS_AREA_SELF and HV_STATS_AREA_PARENT indicate the privilege
level of the data in the mapped stats page.

Both SELF and PARENT contain the same fields, but some fields that are 0 in the
SELF page may be nonzero in PARENT page, and vice-versa. So, to read all the fields
we need to map both pages if possible, and prioritize reading non-zero data from
each field, by checking both the SELF and PARENT pages.

I don't know if it's possible for a given field to have a different (nonzero) value
in both SELF and PARENT pages. I imagine in that case we'd want to prioritize the
PARENT value, but it may simply not be possible.

The API is designed in this way to be backward-compatible with older hypervisors
that didn't have a concept of SELF and PARENT. Hence on older hypervisors (detectable
via the error code), all we can do is map SELF and use it for everything.

> Also, does this patch affect the logic in mshv_vp_dispatch_thread_blocked() where
> a zero value for the SELF version of VpRootDispatchThreadBlocked is replaced by
> the PARENT value? But that logic seems to be in the reverse direction -- replacing
> a missing SELF value with the PARENT value -- whereas this patch is about replacing
> missing PARENT values with SELF values. So are there two separate PARENT vs. SELF
> issues overall? And after this patch is in place and PARENT values are replaced with
> SELF on older hypervisor versions, the logic in mshv_vp_dispatch_thread_blocked()
> then effectively becomes a no-op if the SELF value is zero, and the return value will
> be zero. Is that problem?
> 
This is the same issue, because we only care about any nonzero value in
mshv_vp_dispatch_thread_blocked(). It doesn't matter which page we check first in that
code, just that any nonzero value is returned as a boolean to indicate a blocked state.

The code in question could be rewritten:

return self_vp_cntrs[VpRootDispatchThreadBlocked] || parent_vp_cntrs[VpRootDispatchThreadBlocked];

>>
>> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>> ---
>>  drivers/hv/mshv_root_hv_call.c | 41 ++++++++++++++++++++++++++++++----
>>  drivers/hv/mshv_root_main.c    |  3 +++
>>  2 files changed, 40 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
>> index 598eaff4ff29..b1770c7b500c 100644
>> --- a/drivers/hv/mshv_root_hv_call.c
>> +++ b/drivers/hv/mshv_root_hv_call.c
>> @@ -855,6 +855,24 @@ static int hv_call_map_stats_page2(enum
>> hv_stats_object_type type,
>>  	return ret;
>>  }
>>
>> +static int
>> +hv_stats_get_area_type(enum hv_stats_object_type type,
>> +		       const union hv_stats_object_identity *identity)
>> +{
>> +	switch (type) {
>> +	case HV_STATS_OBJECT_HYPERVISOR:
>> +		return identity->hv.stats_area_type;
>> +	case HV_STATS_OBJECT_LOGICAL_PROCESSOR:
>> +		return identity->lp.stats_area_type;
>> +	case HV_STATS_OBJECT_PARTITION:
>> +		return identity->partition.stats_area_type;
>> +	case HV_STATS_OBJECT_VP:
>> +		return identity->vp.stats_area_type;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>>  static int hv_call_map_stats_page(enum hv_stats_object_type type,
>>  				  const union hv_stats_object_identity *identity,
>>  				  void **addr)
>> @@ -863,7 +881,7 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
>>  	struct hv_input_map_stats_page *input;
>>  	struct hv_output_map_stats_page *output;
>>  	u64 status, pfn;
>> -	int ret = 0;
>> +	int hv_status, ret = 0;
>>
>>  	do {
>>  		local_irq_save(flags);
>> @@ -878,11 +896,26 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
>>  		pfn = output->map_location;
>>
>>  		local_irq_restore(flags);
>> -		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
>> -			ret = hv_result_to_errno(status);
>> +
>> +		hv_status = hv_result(status);
>> +		if (hv_status != HV_STATUS_INSUFFICIENT_MEMORY) {
>>  			if (hv_result_success(status))
>>  				break;
>> -			return ret;
>> +
>> +			/*
>> +			 * Older versions of the hypervisor do not support the
>> +			 * PARENT stats area. In this case return "success" but
>> +			 * set the page to NULL. The caller should check for
>> +			 * this case and instead just use the SELF area.
>> +			 */
>> +			if (hv_stats_get_area_type(type, identity) == HV_STATS_AREA_PARENT &&
>> +			    hv_status == HV_STATUS_INVALID_PARAMETER) {
>> +				*addr = NULL;
>> +				return 0;
>> +			}
>> +
>> +			hv_status_debug(status, "\n");
>> +			return hv_result_to_errno(status);
> 
> Does the hv_call_map_stats_page2() function need a similar fix? Or is there a linkage
> in hypervisor functionality where any hypervisor version that supports an overlay GPFN
> also supports the PARENT stats? If such a linkage is why hv_call_map_stats_page2()
> doesn't need a similar fix, please add a code comment to that effect in
> hv_call_map_stats_page2().
> 
Exactly; hv_call_map_stats_page2() is only available on hypervisors where the PARENT
page is also available. I'll add a comment.

>>  		}
>>
>>  		ret = hv_call_deposit_pages(NUMA_NO_NODE,
>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>> index bc15d6f6922f..f59a4ab47685 100644
>> --- a/drivers/hv/mshv_root_main.c
>> +++ b/drivers/hv/mshv_root_main.c
>> @@ -905,6 +905,9 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
>>  	if (err)
>>  		goto unmap_self;
>>
>> +	if (!stats_pages[HV_STATS_AREA_PARENT])
>> +		stats_pages[HV_STATS_AREA_PARENT] =
>> stats_pages[HV_STATS_AREA_SELF];
>> +
>>  	return 0;
>>
>>  unmap_self:
>> --
>> 2.34.1


