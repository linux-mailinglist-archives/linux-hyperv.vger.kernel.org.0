Return-Path: <linux-hyperv+bounces-7945-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF18CA185B
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 21:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70E223009421
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 20:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5AF3081DF;
	Wed,  3 Dec 2025 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eysS33Tu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A763074BA;
	Wed,  3 Dec 2025 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764792586; cv=none; b=QzqpK4zsaxlM+s2Yf8wENvhyac3N5eOylCat23cDyknPyEhbHdcY3voqMZ/VHmCbupSGGBU2aleazzD1kWM0kRH+JQ3hsIE5vNMkt+FzyIElTKQQG1DN3vQTtorNXiVy3UqR+XusP7m6T7XYMrqsAf5WBCBXPpWht1iTMYTAzCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764792586; c=relaxed/simple;
	bh=KhsqA51WnskIozLxBq1pvhdaFhvc8hKL9v3IJ/NZzV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2r5rfDJuIZAc2Qe+SfofppXA4m+k5wGYXSOuPUMLJ9cxsNGUjaANp8L35t0bquewrDQxbRNfXredcuudsplnGM9tVoRiRMWjXzt9PShyPUCN9er8F/6T3U748rJeSqHyKYQOO8Spxq2mCZzzNgWrv+eEVZBnSnkMAUL1K68zNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eysS33Tu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.161.205] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 11046212072D;
	Wed,  3 Dec 2025 12:09:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 11046212072D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764792584;
	bh=6rzL1YNotdcpSQo6cCyDJzIHO3ZkgoXLw+S0eN0GDQQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eysS33Tutf8DhpIZcQhPrsHstHjYuY0qdECZn4j4/t88+wH2TZq9hqIlXD7QLXD+G
	 vPXa1djlxu30A4bwYUwAHJMGSccIaenqawrCMisML7m1vYH/TjUo1DYdqB5sGjgBau
	 oeY39kmAIkjBdts4GIhTClY4WJ0hMoI9Gj3WtXjY=
Message-ID: <e00b23dc-c053-4c0c-82cf-c670c557ba71@linux.microsoft.com>
Date: Wed, 3 Dec 2025 12:09:42 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/6] Drivers: hv: Add refcount and locking to mem
 regions
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <176478581828.114132.13305536829966527782.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176478626777.114132.1526389640035436917.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <148ab9a6-4698-46ef-a137-0bb0c110a137@linux.microsoft.com>
 <aTCVsGcIYQmHjqM5@skinsburskii.localdomain>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <aTCVsGcIYQmHjqM5@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/2025 11:55 AM, Stanislav Kinsburskii wrote:
> On Wed, Dec 03, 2025 at 11:26:23AM -0800, Nuno Das Neves wrote:
>> On 12/3/2025 10:24 AM, Stanislav Kinsburskii wrote:
>>> Introduce kref-based reference counting and spinlock protection for
>>> memory regions in Hyper-V partition management. This change improves
>>> memory region lifecycle management and ensures thread-safe access to the
>>> region list.
>>>
>>> Also improves the check for overlapped memory regions during region
>>> creation, preventing duplicate or conflicting mappings.
>>>
>>> Previously, the regions list was protected by the partition mutex.
>>> However, this approach is too heavy for frequent fault and invalidation
>>> operations. Finer grained locking is now used to improve efficiency and
>>> concurrency.
>>>
>>> This is a precursor to supporting movable memory regions. Fault and
>>> invalidation handling for movable regions will require safe traversal of
>>> the region list and holding a region reference while performing
>>> invalidation or fault operations.
>>>
>>> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>>> ---
>>>  drivers/hv/mshv_regions.c   |   19 ++++++++++++++++---
>>>  drivers/hv/mshv_root.h      |    6 +++++-
>>>  drivers/hv/mshv_root_main.c |   32 ++++++++++++++++++++++++--------
>>>  3 files changed, 45 insertions(+), 12 deletions(-)
>>>
>>> @@ -1657,8 +1670,10 @@ static void destroy_partition(struct mshv_partition *partition)
>>>  	remove_partition(partition);
>>>  
>>>  	hlist_for_each_entry_safe(region, n, &partition->pt_mem_regions,
>>> -				  hnode)
>>> -		mshv_region_destroy(region);
>>> +				  hnode) {
>>> +		hlist_del(&region->hnode);
>>> +		mshv_region_put(region);
>>> +	}
>>>  
>>
>> With the following patch introducing movable memory, it looks like the
>> list could be traversed by mshv_partition_region_by_gfn() even while
>> the this hlist_del() is being called.
>>
>> Maybe that's not possible for some reason I'm unaware of, could you
>> explain why we don't need to spin_lock here for hlist_del()?
>> Or, alternatively, use hlist_for_each_entry_safe() in
>> mshv_partition_region_by_gfn() to guard against the deletion?
>>
> 
> This function (destroy_partition) is called when there are no active
> references for neither partition not its VPs (they are destroyed in the
> same function above).
> In other words, there can't be any callers for mshv_partition_region_by_gfn.

Ah, I see, even if the mmu_notifier is still active, it doesn't traverse the
list, as it gets the region by container_of().
Thanks.

> 
> As per mshv_partition_region_by_gfn function itself, the caller is
> supposed to take the lock.
> 
> Giving it more thought, I'm strating to think that rw lock her ewould be
> a better option than a spinlock + reference count, as regions won't be
> added or remove to often and using it would allow to get rid of
> reference counting.
> 
> However, this looks like an optimization that isn't required an its
> usefulness can be investigated in future.
> 
> Thanks,
> Stanislav
> 
>>>  	/* Withdraw and free all pages we deposited */
>>>  	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->pt_id);
>>> @@ -1856,6 +1871,7 @@ mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
>>>  
>>>  	INIT_HLIST_HEAD(&partition->pt_devices);
>>>  
>>> +	spin_lock_init(&partition->pt_mem_regions_lock);
>>>  	INIT_HLIST_HEAD(&partition->pt_mem_regions);
>>>  
>>>  	mshv_eventfd_init(partition);
>>>
>>>


