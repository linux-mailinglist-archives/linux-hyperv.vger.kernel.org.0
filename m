Return-Path: <linux-hyperv+bounces-7443-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 267E5C3D171
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 19:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6AD14E1D50
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 18:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D172BE65F;
	Thu,  6 Nov 2025 18:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="M9tVNfMA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB0B1F4CB3;
	Thu,  6 Nov 2025 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762454477; cv=none; b=F5l/hReB6T4LxqxonPJZYnG3pvlVxWs4+Vt+UwfexcU6+suXRBJPrgVZQHcokIiH2TQcamr0yLb8H2TaFmQKEYZwxQ3Kvt5cRTQ79HO/ugzhUHy84ZC2rTKU/DES5Xch+GVzjNXnpNpGWjdO0d3ipg9hWerafuRaj8iKBLCQD40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762454477; c=relaxed/simple;
	bh=vVjIbFYVbF2pWgE63/R68P30jbKSOTUnH4txaahZhCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LpthDa6qR88C4FkoDx2akdyLdus5XrpR9GjiuODXKacia1RXC8ukX1k1SiBDr3gyijyM5LKFAjZJ4QUct2hyF4VU/aKPeYVAgqn50nH6kHmUx7J8UFo3J+MouF4RjsiBR7Y9k7VIGu6zDH8Bwm5ry63W6N9aon/7Rvqe7M8dJ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M9tVNfMA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.65.119] (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2D747201DAC8;
	Thu,  6 Nov 2025 10:41:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2D747201DAC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762454465;
	bh=GyH50YwfVxJTgWJHbgrAffxp5a5tzVQlYeMZ6mwnNNs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M9tVNfMAnmGgkIinKCTKC4nbzHFscXsK2hcpkjfbjaVzqe61d1UqBRu1CGeOHsGnB
	 2WXCcVCOC09CFxcKETRG0Z1ac5RoXgSuFpSWSLReVdOjSLlIsLmZqT2CziZrcon10p
	 byPRpwghSatGHJEK0n134R8eVAZKV4DUid/cldrA=
Message-ID: <6a5f4ed5-63ae-4760-84c9-7290aaff8bd1@linux.microsoft.com>
Date: Thu, 6 Nov 2025 10:40:50 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mshv: Allow mappings that overlap in uaddr
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "magnuskulke@linux.microsoft.com" <magnuskulke@linux.microsoft.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "longli@microsoft.com" <longli@microsoft.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "prapal@linux.microsoft.com" <prapal@linux.microsoft.com>,
 "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
 "muislam@microsoft.com" <muislam@microsoft.com>
References: <1762294728-21721-1-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB41575BE0406D3AB22E1D7DB5D4C2A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41575BE0406D3AB22E1D7DB5D4C2A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/2025 5:38 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, November 4, 2025 2:19 PM
>>
>> Currently the MSHV driver rejects mappings that would overlap in
>> userspace.
>>
>> Some VMMs require the same memory to be mapped to different parts of
>> the guest's address space, and so working around this restriction is
>> difficult.
>>
>> The hypervisor itself doesn't prohibit mappings that overlap in uaddr,
>> (really in SPA: system physical addresses), so supporting this in the
>> driver doesn't require any extra work, only the checks need to be
>> removed.
>>
>> Since no userspace code up until has been able to overlap regions in
>> userspace, relaxing this constraint can't break any existing code.
>>
>> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  drivers/hv/mshv_root_main.c | 19 +------------------
>>  include/uapi/linux/mshv.h   |  2 +-
>>  2 files changed, 2 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>> index 814465a0912d..e5da5f2ab6f7 100644
>> --- a/drivers/hv/mshv_root_main.c
>> +++ b/drivers/hv/mshv_root_main.c
>> @@ -1206,21 +1206,6 @@ mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
>>  	return NULL;
>>  }
>>
>> -static struct mshv_mem_region *
>> -mshv_partition_region_by_uaddr(struct mshv_partition *partition, u64 uaddr)
>> -{
>> -	struct mshv_mem_region *region;
>> -
>> -	hlist_for_each_entry(region, &partition->pt_mem_regions, hnode) {
>> -		if (uaddr >= region->start_uaddr &&
>> -		    uaddr < region->start_uaddr +
>> -			    (region->nr_pages << HV_HYP_PAGE_SHIFT))
>> -			return region;
>> -	}
>> -
>> -	return NULL;
>> -}
>> -
>>  /*
>>   * NB: caller checks and makes sure mem->size is page aligned
>>   * Returns: 0 with regionpp updated on success, or -errno
>> @@ -1235,9 +1220,7 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
>>
>>  	/* Reject overlapping regions */
>>  	if (mshv_partition_region_by_gfn(partition, mem->guest_pfn) ||
>> -	    mshv_partition_region_by_gfn(partition, mem->guest_pfn + nr_pages - 1) ||
>> -	    mshv_partition_region_by_uaddr(partition, mem->userspace_addr) ||
>> -	    mshv_partition_region_by_uaddr(partition, mem->userspace_addr + mem->size - 1))
>> +	    mshv_partition_region_by_gfn(partition, mem->guest_pfn + nr_pages - 1))
>>  		return -EEXIST;
> 
> This existing code (and after this patch) checks for overlap by seeing if the
> requested starting and ending GFNs are already in some existing region. But
> is this really sufficient to detect overlap? Consider this example:
> 
> 1. Three regions exist covering these GFNs respectively:  100 thru 199,
> 300 thru 399, and 500 thru 599.
> 2. A request is made to create a new region for GFNs 250 thru 449.
> 
> This new request would pass the check, but would still overlap. Or is there
> something that prevents this scenario?
> 

The logic appears wrong to me. I will create a patch to fix it, and amend this
patch to work with that new logic since it will look a little different. I'll
post the fix + v2 of this patch as a series.

Thanks
Nuno

>>
>>  	region = vzalloc(sizeof(*region) + sizeof(struct page *) * nr_pages);
>> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
>> index 9091946cba23..b10c8d1cb2ad 100644
>> --- a/include/uapi/linux/mshv.h
>> +++ b/include/uapi/linux/mshv.h
>> @@ -123,7 +123,7 @@ enum {
>>   * @rsvd: MBZ
>>   *
>>   * Map or unmap a region of userspace memory to Guest Physical Addresses (GPA).
>> - * Mappings can't overlap in GPA space or userspace.
>> + * Mappings can't overlap in GPA space.
>>   * To unmap, these fields must match an existing mapping.
>>   */
>>  struct mshv_user_mem_region {
>> --
>> 2.34.1
> 
> I've given my Reviewed-by: narrowly for this patch, since it appears to be
> correct for what it does. But if the approach for detecting overlap really
> is faulty, an additional patch is needed that might supersede this one.
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>


