Return-Path: <linux-hyperv+bounces-6766-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ABCB46709
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Sep 2025 01:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D9ECAA73B6
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 23:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6D52BE629;
	Fri,  5 Sep 2025 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kDIBFtX8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E94872639;
	Fri,  5 Sep 2025 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757114022; cv=none; b=h5owx5loBz2OgLaTsif+lxfYEIchXhADgq4vvUcKokDwmeU7+Kn6YYf5oWnrW3McGAUi5Cv2NoLCFizBFc2SWjJyEb8aEWiWWwTJ3lSHoLsdzGf2pPURRA0F+9p+imXaG4udFu0Gtr3vX2FiS4w4H6fBVUBY7xCublUXy59bJWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757114022; c=relaxed/simple;
	bh=y2vhlta3Q0TfJ3Myh8VF+IoRh9E4gJNZe8XZ/GQ/oAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ba5YtPl+AFILlVjSs76Jwnt7DCdARgQqe3vZ+jAdJ3WPfX8MVBVK+nETZScju2xZOPIfuDj5SlCbKdna7WQBDUs3cVw2NnCAcMQ/ck2bWRuJc5VPdNGadXgMmUAbQF8pWkN8EHvm/37+AB3TxOAiTmLjRAEAhA83zxn6ngAzkmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kDIBFtX8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.33.30] (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id B857220171DA;
	Fri,  5 Sep 2025 16:13:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B857220171DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757114020;
	bh=l8he/I4e0NPNbmFIi+pzKcKpyE1ifvXUABrSLN+Spkk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kDIBFtX8k0Y8i/SJorFeFJcX/WSq4OnLkJ/4saGweUYUaLdSVc+96S4GILB/j/SpA
	 ukwKoG+13oXIeT7FoEklJjiHAuNTccTgZi1rLztLaVcT5AN6szCI2lR60s9lDQ8GTs
	 3C31cGuequzvzGYJM/SzJ5Uib+yILPtiAf6oa6Ro=
Message-ID: <e710deed-99eb-431a-ab79-26934e934bcb@linux.microsoft.com>
Date: Fri, 5 Sep 2025 16:13:40 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] mshv: Add the HVCALL_GET_PARTITION_PROPERTY_EX
 hypercall
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 mhklinux@outlook.com, decui@microsoft.com, paekkaladevi@linux.microsoft.com
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-4-git-send-email-nunodasneves@linux.microsoft.com>
 <daa0202d-3f9e-42eb-a356-2a1ac08e69d2@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <daa0202d-3f9e-42eb-a356-2a1ac08e69d2@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/2025 12:28 PM, Easwar Hariharan wrote:
> On 8/28/2025 5:43 PM, Nuno Das Neves wrote:
>> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>>
>> This hypercall can be used to fetch extended properties of a
>> partition. Extended properties are properties with values larger than
>> a u64. Some of these also need additional input arguments.
>>
>> Add helper function for using the hypercall in the mshv_root driver.
>>
>> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  drivers/hv/mshv_root.h         |  2 ++
>>  drivers/hv/mshv_root_hv_call.c | 31 ++++++++++++++++++++++++++
>>  include/hyperv/hvgdk_mini.h    |  1 +
>>  include/hyperv/hvhdk.h         | 40 ++++++++++++++++++++++++++++++++++
>>  include/hyperv/hvhdk_mini.h    | 26 ++++++++++++++++++++++
>>  5 files changed, 100 insertions(+)
>>
>> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
>> index e3931b0f1269..4aeb03bea6b6 100644
>> --- a/drivers/hv/mshv_root.h
>> +++ b/drivers/hv/mshv_root.h
>> @@ -303,6 +303,8 @@ int hv_call_unmap_stat_page(enum hv_stats_object_type type,
>>  int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
>>  				   u64 page_struct_count, u32 host_access,
>>  				   u32 flags, u8 acquire);
>> +int hv_call_get_partition_property_ex(u64 partition_id, u64 property_code, u64 arg,
>> +				      void *property_value, size_t property_value_sz);
>>  
>>  extern struct mshv_root mshv_root;
>>  extern enum hv_scheduler_type hv_scheduler_type;
>> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
>> index 1c38576a673c..7589b1ff3515 100644
>> --- a/drivers/hv/mshv_root_hv_call.c
>> +++ b/drivers/hv/mshv_root_hv_call.c
>> @@ -590,6 +590,37 @@ int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>>  	return hv_result_to_errno(status);
>>  }
>>  
>> +int
>> +hv_call_get_partition_property_ex(u64 partition_id, u64 property_code, u64 arg,
> 
> One line like in patch 2..

Ack, thanks> 
> <snip>
> 
> Thanks,
> Easwar (he/him)


