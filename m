Return-Path: <linux-hyperv+bounces-7046-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B13BB20B8
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Oct 2025 01:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C053BF3AD
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Oct 2025 23:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9197A17AE1D;
	Wed,  1 Oct 2025 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NoD2gg97"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD986134AC;
	Wed,  1 Oct 2025 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759359804; cv=none; b=qn+K1Omf/xIBdIjnP5zoQdcKuBbIEEYj1WpUTt5tUqEL6R4quNGRfaM5nwfv3xCxB/czUqY1l+kb/sMk6vRZgn48I3gx/9LFrjLhih9j9nfTP5IdUkw18aHK4M1QuQqzRYJp/N8ApV9JeS19JHvj9sJaXrW8yiPdJq7hs1F8hdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759359804; c=relaxed/simple;
	bh=m34wNNvLknlr5kuiW0CndCET9UoCHDxqSyCrLkA6RNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwTBHAFSX0PDPVLP10lTee6b92EnP/monwRepCcXetZxxGfhoUsbc5e1vAbZ6zjkyyAgatO/qouX+c+4YjGT0zu8ZQ0LnChKyIy22fLqWtcWY9NIM+mHWNh9swBoU7KflXnnzp93Goh4HWfMsfqRBM3yCwT3TLCw0GtF0e3rUZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NoD2gg97; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.224.47] (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id 51F7D211AF3D;
	Wed,  1 Oct 2025 16:03:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 51F7D211AF3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759359801;
	bh=vcjMb9AUe5e2gqNqoNfBPXnS8xFTsiAS4tPr6hc9jj8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NoD2gg97zXuUig8IZzooaHRn0ECWtR5glOtrBJqawcasLXR1vO5MWCDhtFL0Ku4Wj
	 FxLE3MqIyNG16V5RxXJBYab6IaQygpuNiVfi9/j12tjLkq5uodMJnHVyU+RT8Volfh
	 OWhDfafPNhwmA4rAQ/GM/N+G7TNs2WazUJ+2yg8E=
Message-ID: <33868cb1-4cb1-40bb-a773-8f15ec75f679@linux.microsoft.com>
Date: Wed, 1 Oct 2025 16:03:19 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] mshv: Introduce new hypercall to map stats page
 for L1VH partitions
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "prapal@linux.microsoft.com" <prapal@linux.microsoft.com>,
 "easwar.hariharan@linux.microsoft.com"
 <easwar.hariharan@linux.microsoft.com>,
 "tiala@microsoft.com" <tiala@microsoft.com>,
 "anirudh@anirudhrb.com" <anirudh@anirudhrb.com>,
 "paekkaladevi@linux.microsoft.com" <paekkaladevi@linux.microsoft.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 Jinank Jain <jinankjain@linux.microsoft.com>
References: <1758903795-18636-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1758903795-18636-6-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB41571CB74AAAB29181443EE9D41BA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41571CB74AAAB29181443EE9D41BA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/2025 10:57 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, September 26, 2025 9:23 AM
>>
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
>> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
>> ---
>>  drivers/hv/mshv_root.h         | 10 ++--
>>  drivers/hv/mshv_root_hv_call.c | 93 ++++++++++++++++++++++++++++++++--
>>  drivers/hv/mshv_root_main.c    | 22 ++++----
>>  include/hyperv/hvgdk_mini.h    |  1 +
>>  include/hyperv/hvhdk_mini.h    |  7 +++
>>  5 files changed, 113 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
>> index dbe2d1d0b22f..0dfccfbe6123 100644
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
>> index 98c6278ff151..5a805b3dec0b 100644
>> --- a/drivers/hv/mshv_root_hv_call.c
>> +++ b/drivers/hv/mshv_root_hv_call.c
>> @@ -804,9 +804,51 @@ hv_call_notify_port_ring_empty(u32 sint_index)
>>  	return hv_result_to_errno(status);
>>  }
>>
>> -int hv_call_map_stat_page(enum hv_stats_object_type type,
>> -			  const union hv_stats_object_identity *identity,
>> -			  void **addr)
>> +static int hv_call_map_stats_page2(enum hv_stats_object_type type,
>> +				   const union hv_stats_object_identity *identity,
>> +				   u64 map_location)
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
>> +
>> +		ret = hv_result_to_errno(status);
>> +
>> +		if (!ret)
>> +			break;
> 
> This logic is incorrect. If the hypercall returns 
> HV_STATUS_INSUFFICIENT_MEMORY, then errno -ENOMEM is immediately
> returned to the caller without any opportunity to do hv_call_deposit_pages().
> 
The loop breaks if (!ret), i.e. on success. Maybe you misread it as `if (ret)`?
>> +
>> +		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
>> +			hv_status_debug(status, "\n");
>> +			break;
>> +		}
>> +
>> +		ret = hv_call_deposit_pages(NUMA_NO_NODE,
>> +					    hv_current_partition_id, 1);
>> +	} while (!ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int hv_call_map_stats_page(enum hv_stats_object_type type,
>> +				  const union hv_stats_object_identity *identity,
>> +				  void **addr)
>>  {
>>  	unsigned long flags;
>>  	struct hv_input_map_stats_page *input;
>> @@ -845,8 +887,36 @@ int hv_call_map_stat_page(enum hv_stats_object_type type,
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
> 
> This should use page_to_hvpfn() per my comments in Patch 4 of this series.
> 
I could change it, but as mentioned in my reply to Patch 4 I'm not sure it's
worth doing without addressing the whole issue which is a much bigger ask.

>> +		*addr = page_address(allocated_page);
>> +	} else {
>> +		ret = hv_call_map_stats_page(type, identity, addr);
>> +	}
>> +
>> +	if (ret && allocated_page)
>> +		__free_page(allocated_page);
> 
> Might want to do *addr = NULL after freeing the page so that the caller
> can't erroneously reference the free page. Again, the current caller doesn't
> do that, so current code isn't broken.
> 
Yep, I can add it to provide a little more robustness against bugs in callers.

>> +
>> +	return ret;
>> +}
>> +
>> +static int hv_call_unmap_stats_page(enum hv_stats_object_type type,
>> +				    const union hv_stats_object_identity *identity)
>>  {
>>  	unsigned long flags;
>>  	struct hv_input_unmap_stats_page *input;
>> @@ -865,6 +935,19 @@ int hv_call_unmap_stat_page(enum hv_stats_object_type type,
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
>> index 2d0ad17acde6..71a8ab5db3b8 100644
>> --- a/drivers/hv/mshv_root_main.c
>> +++ b/drivers/hv/mshv_root_main.c
>> @@ -841,7 +841,8 @@ mshv_vp_release(struct inode *inode, struct file *filp)
>>  	return 0;
>>  }
>>
>> -static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index)
>> +static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index,
>> +				void *stats_pages[])
>>  {
>>  	union hv_stats_object_identity identity = {
>>  		.vp.partition_id = partition_id,
>> @@ -849,10 +850,10 @@ static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index)
>>  	};
>>
>>  	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
>> -	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
>> +	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
>>
>>  	identity.vp.stats_area_type = HV_STATS_AREA_PARENT;
>> -	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
>> +	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
>>  }
>>
>>  static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
>> @@ -865,14 +866,14 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
>>  	int err;
>>
>>  	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
>> -	err = hv_call_map_stat_page(HV_STATS_OBJECT_VP, &identity,
>> -				    &stats_pages[HV_STATS_AREA_SELF]);
>> +	err = hv_map_stats_page(HV_STATS_OBJECT_VP, &identity,
>> +				&stats_pages[HV_STATS_AREA_SELF]);
>>  	if (err)
>>  		return err;
>>
>>  	identity.vp.stats_area_type = HV_STATS_AREA_PARENT;
>> -	err = hv_call_map_stat_page(HV_STATS_OBJECT_VP, &identity,
>> -				    &stats_pages[HV_STATS_AREA_PARENT]);
>> +	err = hv_map_stats_page(HV_STATS_OBJECT_VP, &identity,
>> +				&stats_pages[HV_STATS_AREA_PARENT]);
>>  	if (err)
>>  		goto unmap_self;
>>
>> @@ -880,7 +881,7 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
>>
>>  unmap_self:
>>  	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
>> -	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
>> +	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
>>  	return err;
>>  }
>>
>> @@ -988,7 +989,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
>>  	kfree(vp);
>>  unmap_stats_pages:
>>  	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
>> -		mshv_vp_stats_unmap(partition->pt_id, args.vp_index);
>> +		mshv_vp_stats_unmap(partition->pt_id, args.vp_index, stats_pages);
>>  unmap_ghcb_page:
>>  	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
>>  		hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
>> @@ -1740,7 +1741,8 @@ static void destroy_partition(struct mshv_partition *partition)
>>  				continue;
>>
>>  			if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
>> -				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index);
>> +				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index,
>> +						    (void **)vp->vp_stats_pages);
>>
>>  			if (vp->vp_register_page) {
>>  				(void)hv_unmap_vp_state_page(partition->pt_id,
>> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
>> index ff4325fb623a..f66565106d21 100644
>> --- a/include/hyperv/hvgdk_mini.h
>> +++ b/include/hyperv/hvgdk_mini.h
>> @@ -493,6 +493,7 @@ union hv_vp_assist_msr_contents {	 /*
>> HV_REGISTER_VP_ASSIST_PAGE */
>>  #define HVCALL_GET_PARTITION_PROPERTY_EX		0x0101
>>  #define HVCALL_MMIO_READ				0x0106
>>  #define HVCALL_MMIO_WRITE				0x0107
>> +#define HVCALL_MAP_STATS_PAGE2				0x0131
>>
>>  /* HV_HYPERCALL_INPUT */
>>  #define HV_HYPERCALL_RESULT_MASK	GENMASK_ULL(15, 0)
>> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
>> index bf2ce27dfcc5..064bf735cab6 100644
>> --- a/include/hyperv/hvhdk_mini.h
>> +++ b/include/hyperv/hvhdk_mini.h
>> @@ -177,6 +177,13 @@ struct hv_input_map_stats_page {
>>  	union hv_stats_object_identity identity;
>>  } __packed;
>>
>> +struct hv_input_map_stats_page2 {
>> +	u32 type; /* enum hv_stats_object_type */
>> +	u32 padding;
>> +	union hv_stats_object_identity identity;
>> +	u64 map_location;
>> +} __packed;
>> +
>>  struct hv_output_map_stats_page {
>>  	u64 map_location;
>>  } __packed;
>> --
>> 2.34.1
>>


