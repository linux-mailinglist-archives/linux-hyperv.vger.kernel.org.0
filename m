Return-Path: <linux-hyperv+bounces-6765-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90504B46706
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Sep 2025 01:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E94C1CC6896
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 23:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9132C0273;
	Fri,  5 Sep 2025 23:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NoM1US+v"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D8F24DCE5;
	Fri,  5 Sep 2025 23:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757113971; cv=none; b=Uf6MeUxDEX+OEKoF1cN2QmyRkHGRFxEUfYbjAadaBcQWvRvqo9/A1O/rQ2gKiXqbc32V9Y9ctzLmv8/LQLzyKuNi5EdbrECFceUr0RWE1JkfiObZrqbEZjMu9Xur/6iNyf4Grq/oC0IcalfyEU+jFjaBsvDOUszeE5fYzspcbhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757113971; c=relaxed/simple;
	bh=TX9H9ZFKL3HdDWz5zgcSAbYwLR1r+ByJzEf77t5ovBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YR5mvDQrdfcOTy7XiCcWjkkAjaAYG4pCsRCAxyY/7IZQ4teQJXBSSEMNpPTfLRxR5G5l09m49RU1htKkuT81yBW4vCmEjpJyCWrSWzdsLMghhWjOkQtaqmNDkGwIgFCRjhalaJu4V58+wi+PAmeXCuwuDxUAdMWMMCvnpdqY1bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NoM1US+v; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.33.30] (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id D089920171DA;
	Fri,  5 Sep 2025 16:12:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D089920171DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757113969;
	bh=FA+SSQ2o3iC+8ulO68jmtxiLX5DVKhVhb8+TSNjhQMI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NoM1US+vCMIB4fUWnFLOvSTziLQTBgx405+oqcYMzgBC5PknxSWl2+3yQ3WcdxpIk
	 mAjfFUH9R6uxmr3vim805Ixbcc9QE9mvv3gCaxiRbA51T2x7DJOKnGbquTNp/q2Wvm
	 vHnbwQlahxsiQ6BR+0vVv3GwV4gxubsFyYA+Dc50=
Message-ID: <15532d34-0005-4cba-9fca-212c30db1f18@linux.microsoft.com>
Date: Fri, 5 Sep 2025 16:12:48 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] mshv: Introduce new hypercall to map stats page for
 L1VH partitions
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 mhklinux@outlook.com, decui@microsoft.com, paekkaladevi@linux.microsoft.com,
 Jinank Jain <jinankjain@linux.microsoft.com>
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-7-git-send-email-nunodasneves@linux.microsoft.com>
 <ed4ebc67-dc98-4ce4-af5e-b2f371d27c5b@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <ed4ebc67-dc98-4ce4-af5e-b2f371d27c5b@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/2025 12:50 PM, Easwar Hariharan wrote:
> On 8/28/2025 5:43 PM, Nuno Das Neves wrote:
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
>>  drivers/hv/mshv_root_hv_call.c | 92 ++++++++++++++++++++++++++++++++--
>>  drivers/hv/mshv_root_main.c    | 25 +++++----
>>  include/hyperv/hvgdk_mini.h    |  1 +
>>  include/hyperv/hvhdk_mini.h    |  7 +++
>>  5 files changed, 115 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
>> index d7c9520ef788..d16a020ae0ee 100644
>> --- a/drivers/hv/mshv_root.h
>> +++ b/drivers/hv/mshv_root.h
>> @@ -297,11 +297,11 @@ int hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
>>  int hv_call_disconnect_port(u64 connection_partition_id,
>>  			    union hv_connection_id connection_id);
>>  int hv_call_notify_port_ring_empty(u32 sint_index);
>> -int hv_call_map_stat_page(enum hv_stats_object_type type,
>> -			  const union hv_stats_object_identity *identity,
>> -			  void **addr);
>> -int hv_call_unmap_stat_page(enum hv_stats_object_type type,
>> -			    const union hv_stats_object_identity *identity);
>> +int hv_map_stats_page(enum hv_stats_object_type type,
>> +		      const union hv_stats_object_identity *identity,
>> +		      void **addr);
>> +int hv_unmap_stats_page(enum hv_stats_object_type type, void *page_addr,
>> +			const union hv_stats_object_identity *identity);
>>  int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
>>  				   u64 page_struct_count, u32 host_access,
>>  				   u32 flags, u8 acquire);
>> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
>> index 1882cc90f2f5..44013751cfc1 100644
>> --- a/drivers/hv/mshv_root_hv_call.c
>> +++ b/drivers/hv/mshv_root_hv_call.c
>> @@ -804,6 +804,45 @@ hv_call_notify_port_ring_empty(u32 sint_index)
>>  	return hv_result_to_errno(status);
>>  }
>>  
>> +static int
>> +hv_call_map_stats_page2(enum hv_stats_object_type type,
> 
> Again, one line please. Also below.
> 
Ack

>> +			const union hv_stats_object_identity *identity,
>> +			u64 map_location)
>> +{
>> +	unsigned long flags;
>> +	struct hv_input_map_stats_page2 *input;
>> +	u64 status;
>> +	int ret;
>> +
>> +	if (!map_location || !mshv_use_overlay_gpfn())
>> +		return -EINVAL;
>> +
>> +	do {
>> +		local_irq_save(flags);
>> +		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> +
>> +		memset(input, 0, sizeof(*input));
>> +		input->type = type;
>> +		input->identity = *identity;
>> +		input->map_location = map_location;
>> +
>> +		status = hv_do_hypercall(HVCALL_MAP_STATS_PAGE2, input, NULL);
>> +
>> +		local_irq_restore(flags);
>> +		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
>> +			if (hv_result_success(status))
>> +				break;
>> +			hv_status_debug(status, "\n");
>> +			return hv_result_to_errno(status);
>> +		}
>> +
>> +		ret = hv_call_deposit_pages(NUMA_NO_NODE,
>> +					    hv_current_partition_id, 1);
>> +	} while (!ret);
>> +
>> +	return ret;
>> +}
>> +
>>  static int
>>  hv_stats_get_area_type(enum hv_stats_object_type type,
>>  		       const union hv_stats_object_identity *identity)
>> @@ -822,9 +861,10 @@ hv_stats_get_area_type(enum hv_stats_object_type type,
>>  	return -EINVAL;
>>  }
>>  
>> -int hv_call_map_stat_page(enum hv_stats_object_type type,
>> -			  const union hv_stats_object_identity *identity,
>> -			  void **addr)
>> +static int
>> +hv_call_map_stats_page(enum hv_stats_object_type type,
>> +		       const union hv_stats_object_identity *identity,
>> +		       void **addr)
> 
> ...
> 
ack

>>  {
>>  	unsigned long flags;
>>  	struct hv_input_map_stats_page *input;
>> @@ -880,8 +920,37 @@ int hv_call_map_stat_page(enum hv_stats_object_type type,
>>  	return ret;
>>  }
>>  
>> -int hv_call_unmap_stat_page(enum hv_stats_object_type type,
>> -			    const union hv_stats_object_identity *identity)
>> +int hv_map_stats_page(enum hv_stats_object_type type,
>> +		      const union hv_stats_object_identity *identity,
>> +		      void **addr)
>> +{
>> +	int ret;
>> +	struct page *allocated_page = NULL;
>> +
>> +	if (!addr)
>> +		return -EINVAL;
>> +
>> +	if (mshv_use_overlay_gpfn()) {
>> +		allocated_page = alloc_page(GFP_KERNEL);
>> +		if (!allocated_page)
>> +			return -ENOMEM;
>> +
>> +		ret = hv_call_map_stats_page2(type, identity,
>> +					      page_to_pfn(allocated_page));
>> +		*addr = page_address(allocated_page);
>> +	} else {
>> +		ret = hv_call_map_stats_page(type, identity, addr);
>> +	}
>> +
>> +	if (ret && allocated_page)
>> +		__free_page(allocated_page);
>> +
>> +	return ret;
>> +}
>> +
>> +static int
>> +hv_call_unmap_stats_page(enum hv_stats_object_type type,
> 
> ...
> 
ack

>> +			 const union hv_stats_object_identity *identity)
>>  {
>>  	unsigned long flags;
>>  	struct hv_input_unmap_stats_page *input;
>> @@ -900,6 +969,19 @@ int hv_call_unmap_stat_page(enum hv_stats_object_type type,
>>  	return hv_result_to_errno(status);
>>  }
>>  
>> +int hv_unmap_stats_page(enum hv_stats_object_type type, void *page_addr,
>> +			const union hv_stats_object_identity *identity)
>> +{
>> +	int ret;
>> +
>> +	ret = hv_call_unmap_stats_page(type, identity);
>> +
>> +	if (mshv_use_overlay_gpfn() && page_addr)
>> +		__free_page(virt_to_page(page_addr));
>> +
>> +	return ret;
>> +}
>> +
>>  int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
>>  				   u64 page_struct_count, u32 host_access,
>>  				   u32 flags, u8 acquire)
>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>> index f91880cc9e29..1699423cc524 100644
>> --- a/drivers/hv/mshv_root_main.c
>> +++ b/drivers/hv/mshv_root_main.c
>> @@ -894,7 +894,8 @@ mshv_vp_release(struct inode *inode, struct file *filp)
>>  	return 0;
>>  }
>>  
>> -static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index)
>> +static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index,
>> +				void *stats_pages[])
>>  {
>>  	union hv_stats_object_identity identity = {
>>  		.vp.partition_id = partition_id,
>> @@ -902,10 +903,13 @@ static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index)
>>  	};
>>  
>>  	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
>> -	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
>> +	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
>> +
>> +	if (stats_pages[HV_STATS_AREA_PARENT] == stats_pages[HV_STATS_AREA_SELF])
>> +		return;
>>  
>>  	identity.vp.stats_area_type = HV_STATS_AREA_PARENT;
>> -	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
>> +	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
>>  }
>>  
>>  static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
>> @@ -918,14 +922,14 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
>>  	int err;
>>  
>>  	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
>> -	err = hv_call_map_stat_page(HV_STATS_OBJECT_VP, &identity,
>> -				    &stats_pages[HV_STATS_AREA_SELF]);
>> +	err = hv_map_stats_page(HV_STATS_OBJECT_VP, &identity,
>> +				&stats_pages[HV_STATS_AREA_SELF]);
> 
> Shouldn't this be in the previous patch where the other hv_call_map_stat_page() calls were
> converted, same below?
> 
The previous patch converts hv_call_(un)map_vp_state_page to hv_(un)map_vp_state_page, i.e.
"state" not "stats".

>>  	if (err)
>>  		return err;
>>  
>>  	identity.vp.stats_area_type = HV_STATS_AREA_PARENT;
>> -	err = hv_call_map_stat_page(HV_STATS_OBJECT_VP, &identity,
>> -				    &stats_pages[HV_STATS_AREA_PARENT]);
>> +	err = hv_map_stats_page(HV_STATS_OBJECT_VP, &identity,
>> +				&stats_pages[HV_STATS_AREA_PARENT]);
> 
> ...
> 
>>  	if (err)
>>  		goto unmap_self;
>>  
>> @@ -936,7 +940,7 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
>>  
>>  unmap_self:
>>  	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
>> -	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
>> +	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
>>  	return err;
>>  }
>>
> 
> <snip>


