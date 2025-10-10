Return-Path: <linux-hyperv+bounces-7179-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72C5BCE552
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Oct 2025 21:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E6454257C
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Oct 2025 19:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E67621771C;
	Fri, 10 Oct 2025 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qZeSRbs/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DA71C5D44;
	Fri, 10 Oct 2025 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760123315; cv=none; b=RpnzeaaR2GQzo9MXy7trqJx3+Nr6HXRpx8ni93dEzoi3EUrBLTM4i0CRYvRQX1Lzkkgs+ZQl3Yet4slXPZtO+kB2x+VfjkcHdfdkIMXldLFEi5NirZJqE3RBTVjiOyH/vzRKtQHgUE7ByoxGzuGn6NNSYo43lsPvvWmcArCaQQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760123315; c=relaxed/simple;
	bh=wg8/Nn59H2Wch/sMzb5laHvL4xdfsGmkqU++TZ/IRSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXQEuqlMjB5T8e8cUEDXt5cY3AZwC1zYw5kMW7javfm3seADKnK8ZCZTAuJknqtSFnBU89w7ukjBBWhVHiWOoNrXiwd2Hy2jyMixWZDJQM+gwxGTiYQnJrcDE82eyRO3GX8gO1Pil7z2SzmGtHpgUhZCPBDG9Y2/JXsW7YrljKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qZeSRbs/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.32.230] (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0F74A201600F;
	Fri, 10 Oct 2025 12:08:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0F74A201600F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760123304;
	bh=slmJgrI2kxwa6hhT9XnqLp7YeOloZmuKi0x8H6s/yjg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qZeSRbs/bbtXfdp3HHotNj/oyB7iEvMvfhUMO2krRdoQsNDtC88FYCKUODTn5OvTy
	 uF0ptaCIm0d1LCpbsxTOBoRFtOmxIlhb6kSZrGiwY4c1wkRmqY3VlDb6nhOSYz28XQ
	 Ak4xBzU0UbGEvVdBdWAJcA2DeM9/tm6D9HWAMHzI=
Message-ID: <c4a94ef3-d531-4291-a5ff-0ef68f8e0862@linux.microsoft.com>
Date: Fri, 10 Oct 2025 12:08:23 -0700
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
 <8bacde85-6406-4b47-b11d-ed5054b270f2@linux.microsoft.com>
 <SN6PR02MB4157BB0D3B4B8A616C8B2E29D4E7A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB4157F9804CC7F22A22E01682D4E5A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157F9804CC7F22A22E01682D4E5A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/2025 8:25 AM, Michael Kelley wrote:
> From: Michael Kelley <mhklinux@outlook.com> Sent: Wednesday, October 1, 2025 5:03 PM
>>
>> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, October 1, 2025 3:56 PM
>>>
>>> On 9/29/2025 10:56 AM, Michael Kelley wrote:
>>>> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, September 26, 2025 9:23 AM
>>>>>
>>>>> From: Jinank Jain <jinankjain@linux.microsoft.com>
>>>>>
>>>>> Introduce mshv_use_overlay_gpfn() to check if a page needs to be
>>>>> allocated and passed to the hypervisor to map VP state pages. This is
>>>>> only needed on L1VH, and only on some (newer) versions of the
>>>>> hypervisor, hence the need to check vmm_capabilities.
>>>>>
>>>>> Introduce functions hv_map/unmap_vp_state_page() to handle the
>>>>> allocation and freeing.
>>>>>
>>>>> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
>>>>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>>>>> Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
>>>>> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
>>>>> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>>>>> Reviewed-by: Anirudh Rayabharam <anirudh@anirudhrb.com>
>>>>> ---
>>>>>  drivers/hv/mshv_root.h         | 11 ++---
>>>>>  drivers/hv/mshv_root_hv_call.c | 61 ++++++++++++++++++++++++---
>>>>>  drivers/hv/mshv_root_main.c    | 76 +++++++++++++++++-----------------
>>>>>  3 files changed, 98 insertions(+), 50 deletions(-)
>>>>>
>>>>> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
>>>>> index 0cb1e2589fe1..dbe2d1d0b22f 100644
>>>>> --- a/drivers/hv/mshv_root.h
>>>>> +++ b/drivers/hv/mshv_root.h
>>>>> @@ -279,11 +279,12 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
>>>>>  			 /* Choose between pages and bytes */
>>>>>  			 struct hv_vp_state_data state_data, u64 page_count,
>>>>>  			 struct page **pages, u32 num_bytes, u8 *bytes);
>>>>> -int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>>>>> -			      union hv_input_vtl input_vtl,
>>>>> -			      struct page **state_page);
>>>>> -int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>>>>> -				union hv_input_vtl input_vtl);
>>>>> +int hv_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>>>>> +			 union hv_input_vtl input_vtl,
>>>>> +			 struct page **state_page);
>>>>> +int hv_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>>>>> +			   struct page *state_page,
>>>>> +			   union hv_input_vtl input_vtl);
>>>>>  int hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
>>>>>  			u64 connection_partition_id, struct hv_port_info *port_info,
>>>>>  			u8 port_vtl, u8 min_connection_vtl, int node);
>>>>> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
>>>>> index 3fd3cce23f69..98c6278ff151 100644
>>>>> --- a/drivers/hv/mshv_root_hv_call.c
>>>>> +++ b/drivers/hv/mshv_root_hv_call.c
>>>>> @@ -526,9 +526,9 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
>>>>>  	return ret;
>>>>>  }
>>>>>
>>>>> -int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>>>>> -			      union hv_input_vtl input_vtl,
>>>>> -			      struct page **state_page)
>>>>> +static int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>>>>> +				     union hv_input_vtl input_vtl,
>>>>> +				     struct page **state_page)
>>>>>  {
>>>>>  	struct hv_input_map_vp_state_page *input;
>>>>>  	struct hv_output_map_vp_state_page *output;
>>>>> @@ -547,7 +547,14 @@ int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>>>>>  		input->type = type;
>>>>>  		input->input_vtl = input_vtl;
>>>>>
>>>>> -		status = hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE, input, output);
>>>>
>>>> This function must zero the input area before using it. Otherwise,
>>>> flags.map_location_provided is uninitialized when *state_page is NULL. It will
>>>> have whatever value was left by the previous user of hyperv_pcpu_input_arg,
>>>> potentially producing bizarre results. And there's a reserved field that won't be
>>>> set to zero.
>>>>
>>> Good catch, will add a memset().
>>>
>>>>> +		if (*state_page) {
>>>>> +			input->flags.map_location_provided = 1;
>>>>> +			input->requested_map_location =
>>>>> +				page_to_pfn(*state_page);
>>>>
>>>> Technically, this should be page_to_hvpfn() since the PFN value is being sent to
>>>> Hyper-V. I know root (and L1VH?) partitions must run with the same page size
>>>> as the Hyper-V host, but it's better to not leave code buried here that will blow
>>>> up if the "same page size requirement" should ever change.
>>>>
>>> Good point...I could change these calls, but the other way doesn't work, see below.
>>>
>>>> And after making the hypercall, there's an invocation of pfn_to_page(), which
>>>> should account for the same. Unfortunately, there's not an existing hvpfn_to_page()
>>>> function.
>>>>
>>> This seems like a tricky scenario to get right. In the root partition case, the
>>> hypervisor allocates the page. That pfn could be some page within a larger Linux page.
>>> Converting that to a Linux pfn (naively) means losing the original hvpfn since it gets
>>> truncated, which is no good if we want to unmap it later. Also page_address() would
>>> give the wrong virtual address.
>>>
>>> In other words, we'd have to completely change how we track these pages in order to
>>> support this scenario, and the same goes for various other hypervisor APIs where the
>>> hypervisor does the allocating. I think it's out of scope to try and address that
>>> here, even in part, especially since we will be making assumptions about something
>>> that may never happen.
>>
>> OK, yes the hypervisor allocating the page is a problem when Linux tracks it
>> as a struct page. I'll agree it's out of current scope to change this.
>>
>> It makes me think about hv_synic_enable_regs() where the paravisor or hypervisor
>> allocates the synic_message_page and synic_event_page. But that case should work
>> OK with a regular guest with page size greater than 4K because the pages are tracked
>> based on the guest kernel virtual address, not the PFN. So hv_synic_enable_regs()
>> should work on ARM64 Linux guests with 64K page size and a paravisor, as well as
>> for my postulated root partition with page size greater than 4K.
>>
>> When it matters, cases where the hypervisor or paravisor allocate pages to give
>> to the guest will require careful handling to ensure they work for guest page sizes
>> greater than 4K. That's useful information for future consideration. Thanks for the
>> discussion.
>>
> 
> Upon further reflection, I think there's a subtle bug in the case where the
> hypervisor supplies the state page. This bug is present in the existing code, and
> persists after these patches.
> 
> I'm assuming that the hypervisor supplied page is *not* part of the memory
> assigned to the root partition when it was created. I.e., the supplied page is part
> of the hypervisor's private memory.  Or does the root partition Linux "give"
> the hypervisor some memory for it to later return as one of these state pages?
> 

It is a regular page that Linux deposits to that particular guest partition so it
can be used for this or other purposes (bookkeeping, page tables, stats pages,
etc...). It would have been deposited earlier, e.g. one of the pages deposited
just before HVCALL_INITIALIZE_PARTITION.

The hypervisor's pre-reserved pages which Linux doesn't touch are only used for a
few things, and never for guests as far as I know.

> Assuming the page did *not* originate in Linux, then the page provided by the
> hypervisor doesn't actually have a "struct page" entry in the root partition Linux
> instance. Doing pfn_to_page() works because it just does some address
> arithmetic, but the resulting "struct page *" value points somewhere off the
> end of the root partition's "struct page" array.
> 
> Then page_to_virt() is done on this somewhat bogus "struct page *" value.
> page_to_virt() also just does some address arithmetic, so it "works". But it
> assumes that the "struct page *" input value is good, and that Linux has a valid
> virtual-to-physical direct mapping for the physical memory represented by
> that input value. Unfortunately, that assumption might not always be true. I
> think it works most of the time because Linux uses huge page mappings for
> the direct map, and they may extend far enough beyond the root partition's
> actual memory to cover this hypervisor page. Or maybe there's something
> else going on that I'm not aware of and that allows the current code to work.
> So please check my thinking.
> 
> The robust fix is to do like hv_synic_enable_regs(), where a page returned
> by the hypervisor/paravisor is explicitly mapped in order to have a valid
> virtual address in the root partition Linux.
> 
> Note that on ARM64, when CONFIG_DEBUG_VIRTUAL is set to catch errors
> like this, page_to_virt() does additional checks on its input value, and would
> generate a WARN_ON() in this case. x86/x64 does not do the additional checks.
> 
> Michael
> 
>>
>>>
>>>>> +		}
>>>>> +
>>>>> +		status = hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE, input,
>>>>> +					 output);
>>>>>
>>>>>  		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
>>>>>  			if (hv_result_success(status))


