Return-Path: <linux-hyperv+bounces-6831-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0296B53AF5
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Sep 2025 20:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6E43BD99F
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Sep 2025 18:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8018F3629B3;
	Thu, 11 Sep 2025 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="C+oZKZkH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5203629A6;
	Thu, 11 Sep 2025 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757613624; cv=none; b=DAquanXoeLni4PrW+FX0fUBAINwTH0Hzy29RafQapnvS4YXbL3rbVneIDlkOUItpIHGtAX55/q/c/Na0iGQP9n4ooyZI9M2vFcCO6DWO8TLpFAl6pdspT9gecWiLfxEpKpi0rI51jedIaYRkHpRx6q4etnO/0C4xWS+wg1YHVcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757613624; c=relaxed/simple;
	bh=tdvBhQ5ZnKYbcb47s5OjQO4PUGCNXBnLaUkmBb2aqMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTl8wtGiILQBF10aeXojUDROGRyOvCJbnm6s0P3JJr1+UbDVdYYKbfddeGITYQszwa4cdLqouZgvBqGfr7Kt4P435LDG5on5rlZgXVPS/mh6FeUXGTmOrqMg+wFuaxRDP0lEUaM3A8d5kOL4pPnsYZSGMdMo6O/U736ZkwcSEA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=C+oZKZkH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.209.91] (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id B5F8B211AD2F;
	Thu, 11 Sep 2025 11:00:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B5F8B211AD2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757613617;
	bh=pYPpw5QSY0vqFa2WfBw8sfrfmd1IsrmJuPcZom6xu0Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C+oZKZkH1JCXhDGk9O5OVWqRdsW05R5Qgbm4RJLONZsNkAr44elTq8ZHi79I3/p+D
	 GMnSqZRdrEzg4+/tBKvJgZfevpANKGLTqSEnJB7RGw+08qrUnv3f7IyIW9aYi3MsUp
	 PkDCrWYiPHHzg5E2RUNk2afsp3tPAZO13qn8Pef4=
Message-ID: <e1f9590f-4b81-4026-91c3-c4a48373fddc@linux.microsoft.com>
Date: Thu, 11 Sep 2025 11:00:16 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] mshv: Introduce new hypercall to map stats page
 for L1VH partitions
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 prapal@linux.microsoft.com, tiala@microsoft.com, anirudh@anirudhrb.com,
 paekkaladevi@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com,
 Jinank Jain <jinankjain@linux.microsoft.com>
References: <1757546089-2002-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1757546089-2002-6-git-send-email-nunodasneves@linux.microsoft.com>
 <949318ba-7623-42d2-90fd-0664915d994c@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <949318ba-7623-42d2-90fd-0664915d994c@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/2025 9:32 AM, Easwar Hariharan wrote:
> On 9/10/2025 4:14 PM, Nuno Das Neves wrote:
>> From: Jinank Jain <jinankjain@linux.microsoft.com>
>>
>> Introduce HVCALL_MAP_STATS_PAGE2 which provides a map location (GPFN)
>> to map the stats to. This hypercall is required for L1VH partitions,
>> depending on the hypervisor version. This uses the same check as the
>> state page map location; mshv_use_overlay_gpfn().
>>
>> Add mshv_map_vp_state_page() helpers to use this new hypercall or the
>> old one depending on availability.
>>
>> For unmapping, the original HVCALL_UNMAP_STATS_PAGE works for both
>> cases.
>>
>> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  drivers/hv/mshv_root.h         | 10 ++--
>>  drivers/hv/mshv_root_hv_call.c | 89 ++++++++++++++++++++++++++++++++--
>>  drivers/hv/mshv_root_main.c    | 25 ++++++----
>>  include/hyperv/hvgdk_mini.h    |  1 +
>>  include/hyperv/hvhdk_mini.h    |  7 +++
>>  5 files changed, 112 insertions(+), 20 deletions(-)
>>
> <snip>
> 
>> @@ -849,10 +850,13 @@ static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index)
>>  	};
>>  
>>  	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
>> -	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
>> +	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
>> +
>> +	if (stats_pages[HV_STATS_AREA_PARENT] == stats_pages[HV_STATS_AREA_SELF])
>> +		return;
> 
> Nit, without patch 2, this hunk is a no-op. Despite that, looks good to me.
> 
Ah, thanks - in fact it probably should have been in that patch instead of
this one in the first place.

> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> 
>>  
>>  	identity.vp.stats_area_type = HV_STATS_AREA_PARENT;
>> -	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
>> +	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
>>  }
> 
> <snip>


