Return-Path: <linux-hyperv+bounces-7942-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB4DCA16FF
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 20:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16D8C300AB1C
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 19:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28C9312809;
	Wed,  3 Dec 2025 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kD7OFFSH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED26D3164D4;
	Wed,  3 Dec 2025 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764790574; cv=none; b=se/MJeYoNzWgarlND6CiuNA/gx004JaDmd6A4T6j4C2+2jAZUjMAsBh65gYT8fasdOhHl+XuTKorUxmK3GOc4KpXlstGX/55KYI2Wr0IP1eLc76tleqDLhxD8GkVi8dOX+pmoqPxOWeuBWzLSK/ZHzz4x9iGDEDUR7TvYjE33wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764790574; c=relaxed/simple;
	bh=57m7npftAgxoX63DSspGN0u3x5HmlOwRS6G3kuLCMjI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=k6BPa5rcC7bnRYJvxOF45VmlG/s/3Vt6dvAgOxbiMUNJPicRZz7+1cCqEP2QOYXBPTSyJAhGCixLwQACxQzDJ8NZxD3d2vp21XtLKbLkXMg4sPZtG/dutJqLeP7wtEHfZS93avn/UMiJ9j24JOMu8MU4+5/rKNWwCQQ64eIh0IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kD7OFFSH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.161.205] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id C1299200E9F8;
	Wed,  3 Dec 2025 11:36:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C1299200E9F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764790571;
	bh=aPaLcSYb2R7AB267RXHz7BXJ10jFvcvW3MwICx79X9o=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=kD7OFFSH7lVGNbxIphIQXON5faJCEon3Rbdm3731Mrwv8Hr7P5Pk3vH7JG1BbXs7d
	 BCvXK9XVkctpq8MT1pyypbR1Wk0yh8UxfuqCigjmsleGt4jk/QUlMtT42qupTgjEXS
	 DuU2ZdpOmoaABezY9yRZ4t5IEGiS3JwzYiGIddWU=
Message-ID: <dc3fa33d-8f9e-46f0-9fd1-248684a36c8b@linux.microsoft.com>
Date: Wed, 3 Dec 2025 11:36:08 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/7] Drivers: hv: Improve region overlap detection in
 partition create
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176412295734.447063.5692907557041244468.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <2c853152-c2f8-49c6-a16c-be8aa1b59234@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <2c853152-c2f8-49c6-a16c-be8aa1b59234@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/2025 10:58 AM, Nuno Das Neves wrote:
> On 11/25/2025 6:09 PM, Stanislav Kinsburskii wrote:
>> Refactor region overlap check in mshv_partition_create_region to use
>> mshv_partition_region_by_gfn for both start and end guest PFNs, replacing
>> manual iteration.
>>
>> This is a cleaner approach that leverages existing functionality to
>> accurately detect overlapping memory regions.
>>
>> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>> ---
>>  drivers/hv/mshv_root_main.c |    8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>> index 5dfb933da981..ae600b927f49 100644
>> --- a/drivers/hv/mshv_root_main.c
>> +++ b/drivers/hv/mshv_root_main.c
>> @@ -1086,13 +1086,9 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
>>  	u64 nr_pages = HVPFN_DOWN(mem->size);
>>  
>>  	/* Reject overlapping regions */
>> -	hlist_for_each_entry(rg, &partition->pt_mem_regions, hnode) {
>> -		if (mem->guest_pfn + nr_pages <= rg->start_gfn ||
>> -		    rg->start_gfn + rg->nr_pages <= mem->guest_pfn)
>> -			continue;
>> -
>> +	if (mshv_partition_region_by_gfn(partition, mem->guest_pfn) ||
>> +	    mshv_partition_region_by_gfn(partition, mem->guest_pfn + nr_pages - 1))
>>  		return -EEXIST;
> 
> This logic does not work. I fixed this check in
> ba9eb9b86d23 mshv: Fix create memory region overlap check
> 
> This change would just be reverting that fix.
> 
> Consider an existing region at 0x2000 of size 0x1000. The user
> tries to map a new region at 0x1000 of size 0x3000. Since the new region
> starts before and ends after the existing region, the overlap would not
> be detected by this logic. It just checks if an existing region contains
> 0x1000 or 0x4000 - 1 which it does not. This is why a manual iteration
> here is needed.
> 

Apologies, after sending this I realized you already dropped the patch.

>> -	}
>>  
>>  	rg = mshv_region_create(mem->guest_pfn, nr_pages,
>>  				mem->userspace_addr, mem->flags,
>>
>>
> 


