Return-Path: <linux-hyperv+bounces-7045-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 869FFBB2064
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Oct 2025 00:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329803BD95C
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Oct 2025 22:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CC3306B04;
	Wed,  1 Oct 2025 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EU+uoGP7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D011C35977;
	Wed,  1 Oct 2025 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759359394; cv=none; b=IZ2OGfCA1KJz1Hg40eMPTU0VG2U2k94KuRITO73qvBND5z+1IIeb/1OJLf/anCvBosZDZ5BFLb97EEJ8Yk/lYHsFAnKx5Pz0Ux+7SPjtkNoNZMJVphH9VC+dVG2oZtKCBPtNG08ZlhIbnQiAvUzD32oTjdBSClhbuQ8LcHq0img=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759359394; c=relaxed/simple;
	bh=TP71bnhb7H+PpHc6UFR8ecP0D/imx5y8udNCpsMCE+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKmY9QbzZaGDlc0ZXPA6wb46LumVzQZ36EeC82PVxiWOcMit3FjJZ1MK8Rwn9Gl60cjqlxvFNt6fLdzYyQwJzOj24C5cvYihVrtMDTk6pqe8RqqNObcIuvOce9iTuVFlWnDgiGHDmGiB1b7BrcZ0hdz99bV69R6GUSBXRxBFyVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EU+uoGP7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.224.47] (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2B46D211AF3E;
	Wed,  1 Oct 2025 15:56:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2B46D211AF3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759359391;
	bh=y2W9DCp8a78EZtV+57V+Ye1xvfaacpMcM2BCo/7IDSc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EU+uoGP73gwkI/aPWBO5RXIq/4OCMfqkooeyXxXA9RoUxOGhqY6qQ2ZsazxZjSXoe
	 lTElD5aVsHWGgbU6r3fOByxWL5rXbeGMy97uWuIo3vMkSCDzfad3h6ZjKogG/aCAzf
	 ljRJiC4NzG4Q8s3qNzSyOMX6AAyF1A031XsHPXd0=
Message-ID: <8bacde85-6406-4b47-b11d-ed5054b270f2@linux.microsoft.com>
Date: Wed, 1 Oct 2025 15:56:29 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] mshv: Allocate vp state page for
 HVCALL_MAP_VP_STATE_PAGE on L1VH
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
 <1758903795-18636-5-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157E95BDC70A1F91228DAF7D41BA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157E95BDC70A1F91228DAF7D41BA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/2025 10:56 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, September 26, 2025 9:23 AM
>>
>> From: Jinank Jain <jinankjain@linux.microsoft.com>
>>
>> Introduce mshv_use_overlay_gpfn() to check if a page needs to be
>> allocated and passed to the hypervisor to map VP state pages. This is
>> only needed on L1VH, and only on some (newer) versions of the
>> hypervisor, hence the need to check vmm_capabilities.
>>
>> Introduce functions hv_map/unmap_vp_state_page() to handle the
>> allocation and freeing.
>>
>> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
>> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
>> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>> Reviewed-by: Anirudh Rayabharam <anirudh@anirudhrb.com>
>> ---
>>  drivers/hv/mshv_root.h         | 11 ++---
>>  drivers/hv/mshv_root_hv_call.c | 61 ++++++++++++++++++++++++---
>>  drivers/hv/mshv_root_main.c    | 76 +++++++++++++++++-----------------
>>  3 files changed, 98 insertions(+), 50 deletions(-)
>>
>> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
>> index 0cb1e2589fe1..dbe2d1d0b22f 100644
>> --- a/drivers/hv/mshv_root.h
>> +++ b/drivers/hv/mshv_root.h
>> @@ -279,11 +279,12 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
>>  			 /* Choose between pages and bytes */
>>  			 struct hv_vp_state_data state_data, u64 page_count,
>>  			 struct page **pages, u32 num_bytes, u8 *bytes);
>> -int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>> -			      union hv_input_vtl input_vtl,
>> -			      struct page **state_page);
>> -int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>> -				union hv_input_vtl input_vtl);
>> +int hv_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>> +			 union hv_input_vtl input_vtl,
>> +			 struct page **state_page);
>> +int hv_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>> +			   struct page *state_page,
>> +			   union hv_input_vtl input_vtl);
>>  int hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
>>  			u64 connection_partition_id, struct hv_port_info *port_info,
>>  			u8 port_vtl, u8 min_connection_vtl, int node);
>> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
>> index 3fd3cce23f69..98c6278ff151 100644
>> --- a/drivers/hv/mshv_root_hv_call.c
>> +++ b/drivers/hv/mshv_root_hv_call.c
>> @@ -526,9 +526,9 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
>>  	return ret;
>>  }
>>
>> -int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>> -			      union hv_input_vtl input_vtl,
>> -			      struct page **state_page)
>> +static int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>> +				     union hv_input_vtl input_vtl,
>> +				     struct page **state_page)
>>  {
>>  	struct hv_input_map_vp_state_page *input;
>>  	struct hv_output_map_vp_state_page *output;
>> @@ -547,7 +547,14 @@ int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>>  		input->type = type;
>>  		input->input_vtl = input_vtl;
>>
>> -		status = hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE, input, output);
> 
> This function must zero the input area before using it. Otherwise,
> flags.map_location_provided is uninitialized when *state_page is NULL. It will
> have whatever value was left by the previous user of hyperv_pcpu_input_arg,
> potentially producing bizarre results. And there's a reserved field that won't be
> set to zero.
> 
Good catch, will add a memset().

>> +		if (*state_page) {
>> +			input->flags.map_location_provided = 1;
>> +			input->requested_map_location =
>> +				page_to_pfn(*state_page);
> 
> Technically, this should be page_to_hvpfn() since the PFN value is being sent to
> Hyper-V. I know root (and L1VH?) partitions must run with the same page size
> as the Hyper-V host, but it's better to not leave code buried here that will blow
> up if the "same page size requirement" should ever change.
> 
Good point...I could change these calls, but the other way doesn't work, see below.

> And after making the hypercall, there's an invocation of pfn_to_page(), which
> should account for the same. Unfortunately, there's not an existing hvpfn_to_page()
> function.
> 
This seems like a tricky scenario to get right. In the root partition case, the
hypervisor allocates the page. That pfn could be some page within a larger Linux page.
Converting that to a Linux pfn (naively) means losing the original hvpfn since it gets
truncated, which is no good if we want to unmap it later. Also page_address() would
give the wrong virtual address.

In other words, we'd have to completely change how we track these pages in order to
support this scenario, and the same goes for various other hypervisor APIs where the
hypervisor does the allocating. I think it's out of scope to try and address that
here, even in part, especially since we will be making assumptions about something
that may never happen.

>> +		}
>> +
>> +		status = hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE, input,
>> +					 output);
>>
>>  		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
>>  			if (hv_result_success(status))
>> @@ -565,8 +572,39 @@ int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>>  	return ret;
>>  }
>>
>> -int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>> -				union hv_input_vtl input_vtl)
>> +static bool mshv_use_overlay_gpfn(void)
>> +{
>> +	return hv_l1vh_partition() &&
>> +	       mshv_root.vmm_caps.vmm_can_provide_overlay_gpfn;
>> +}
>> +
>> +int hv_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>> +			 union hv_input_vtl input_vtl,
>> +			 struct page **state_page)
>> +{
>> +	int ret = 0;
>> +	struct page *allocated_page = NULL;
>> +
>> +	if (mshv_use_overlay_gpfn()) {
>> +		allocated_page = alloc_page(GFP_KERNEL);
>> +		if (!allocated_page)
>> +			return -ENOMEM;
>> +		*state_page = allocated_page;
>> +	} else {
>> +		*state_page = NULL;
>> +	}
>> +
>> +	ret = hv_call_map_vp_state_page(partition_id, vp_index, type, input_vtl,
>> +					state_page);
>> +
>> +	if (ret && allocated_page)
>> +		__free_page(allocated_page);
> 
> For robustness, you might want to set *state_page = NULL here so the
> caller doesn't have a reference to the page that has been freed. I didn't
> see any cases where the caller incorrectly checks the returned
> *state_page value after an error, so the current code isn't broken.
> 
Sure, I can add it.

>> +
>> +	return ret;
>> +}
>> +
>> +static int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>> +				       union hv_input_vtl input_vtl)
>>  {
>>  	unsigned long flags;
>>  	u64 status;
>> @@ -590,6 +628,17 @@ int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>>  	return hv_result_to_errno(status);
>>  }
>>
>> +int hv_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>> +			   struct page *state_page, union hv_input_vtl input_vtl)
>> +{
>> +	int ret = hv_call_unmap_vp_state_page(partition_id, vp_index, type, input_vtl);
>> +
>> +	if (mshv_use_overlay_gpfn() && state_page)
>> +		__free_page(state_page);
>> +
>> +	return ret;
>> +}
>> +
>>  int hv_call_get_partition_property_ex(u64 partition_id, u64 property_code,
>>  				      u64 arg, void *property_value,
>>  				      size_t property_value_sz)
>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>> index e199770ecdfa..2d0ad17acde6 100644
>> --- a/drivers/hv/mshv_root_main.c
>> +++ b/drivers/hv/mshv_root_main.c
>> @@ -890,7 +890,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition
>> *partition,
>>  {
>>  	struct mshv_create_vp args;
>>  	struct mshv_vp *vp;
>> -	struct page *intercept_message_page, *register_page, *ghcb_page;
>> +	struct page *intercept_msg_page, *register_page, *ghcb_page;
>>  	void *stats_pages[2];
>>  	long ret;
>>
>> @@ -908,28 +908,25 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
>>  	if (ret)
>>  		return ret;
>>
>> -	ret = hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
>> -					HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
>> -					input_vtl_zero,
>> -					&intercept_message_page);
>> +	ret = hv_map_vp_state_page(partition->pt_id, args.vp_index,
>> +				   HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
>> +				   input_vtl_zero, &intercept_msg_page);
>>  	if (ret)
>>  		goto destroy_vp;
>>
>>  	if (!mshv_partition_encrypted(partition)) {
>> -		ret = hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
>> -						HV_VP_STATE_PAGE_REGISTERS,
>> -						input_vtl_zero,
>> -						&register_page);
>> +		ret = hv_map_vp_state_page(partition->pt_id, args.vp_index,
>> +					   HV_VP_STATE_PAGE_REGISTERS,
>> +					   input_vtl_zero, &register_page);
>>  		if (ret)
>>  			goto unmap_intercept_message_page;
>>  	}
>>
>>  	if (mshv_partition_encrypted(partition) &&
>>  	    is_ghcb_mapping_available()) {
>> -		ret = hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
>> -						HV_VP_STATE_PAGE_GHCB,
>> -						input_vtl_normal,
>> -						&ghcb_page);
>> +		ret = hv_map_vp_state_page(partition->pt_id, args.vp_index,
>> +					   HV_VP_STATE_PAGE_GHCB,
>> +					   input_vtl_normal, &ghcb_page);
>>  		if (ret)
>>  			goto unmap_register_page;
>>  	}
>> @@ -960,7 +957,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
>>  	atomic64_set(&vp->run.vp_signaled_count, 0);
>>
>>  	vp->vp_index = args.vp_index;
>> -	vp->vp_intercept_msg_page = page_to_virt(intercept_message_page);
>> +	vp->vp_intercept_msg_page = page_to_virt(intercept_msg_page);
>>  	if (!mshv_partition_encrypted(partition))
>>  		vp->vp_register_page = page_to_virt(register_page);
>>
>> @@ -993,21 +990,19 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
>>  	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
>>  		mshv_vp_stats_unmap(partition->pt_id, args.vp_index);
>>  unmap_ghcb_page:
>> -	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available()) {
>> -		hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
>> -					    HV_VP_STATE_PAGE_GHCB,
>> -					    input_vtl_normal);
>> -	}
>> +	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
>> +		hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
>> +				       HV_VP_STATE_PAGE_GHCB, ghcb_page,
>> +				       input_vtl_normal);
>>  unmap_register_page:
>> -	if (!mshv_partition_encrypted(partition)) {
>> -		hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
>> -					    HV_VP_STATE_PAGE_REGISTERS,
>> -					    input_vtl_zero);
>> -	}
>> +	if (!mshv_partition_encrypted(partition))
>> +		hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
>> +				       HV_VP_STATE_PAGE_REGISTERS,
>> +				       register_page, input_vtl_zero);
>>  unmap_intercept_message_page:
>> -	hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
>> -				    HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
>> -				    input_vtl_zero);
>> +	hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
>> +			       HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
>> +			       intercept_msg_page, input_vtl_zero);
>>  destroy_vp:
>>  	hv_call_delete_vp(partition->pt_id, args.vp_index);
>>  	return ret;
>> @@ -1748,24 +1743,27 @@ static void destroy_partition(struct mshv_partition *partition)
>>  				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index);
>>
>>  			if (vp->vp_register_page) {
>> -				(void)hv_call_unmap_vp_state_page(partition->pt_id,
>> -								  vp->vp_index,
>> - 								  HV_VP_STATE_PAGE_REGISTERS,
>> -								  input_vtl_zero);
>> +				(void)hv_unmap_vp_state_page(partition->pt_id,
>> +							     vp->vp_index,
>> +							     HV_VP_STATE_PAGE_REGISTERS,
>> +							     virt_to_page(vp->vp_register_page),
>> +							     input_vtl_zero);
>>  				vp->vp_register_page = NULL;
>>  			}
>>
>> -			(void)hv_call_unmap_vp_state_page(partition->pt_id,
>> -							  vp->vp_index,
>> -							  HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
>> -							  input_vtl_zero);
>> +			(void)hv_unmap_vp_state_page(partition->pt_id,
>> +						     vp->vp_index,
>> +						     HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
>> +						     virt_to_page(vp->vp_intercept_msg_page),
>> +						     input_vtl_zero);
>>  			vp->vp_intercept_msg_page = NULL;
>>
>>  			if (vp->vp_ghcb_page) {
>> -				(void)hv_call_unmap_vp_state_page(partition->pt_id,
>> -								  vp->vp_index,
>> -								  HV_VP_STATE_PAGE_GHCB,
>> -								  input_vtl_normal);
>> +				(void)hv_unmap_vp_state_page(partition->pt_id,
>> +							     vp->vp_index,
>> +							     HV_VP_STATE_PAGE_GHCB,
>> +							     virt_to_page(vp->vp_ghcb_page),
>> +							     input_vtl_normal);
>>  				vp->vp_ghcb_page = NULL;
>>  			}
>>
>> --
>> 2.34.1
>>


