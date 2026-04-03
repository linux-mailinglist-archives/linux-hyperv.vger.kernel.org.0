Return-Path: <linux-hyperv+bounces-9955-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBCUOmhrz2lPwAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9955-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 09:25:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4B8391B70
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 09:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA4D530160C0
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 07:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CDE30B502;
	Fri,  3 Apr 2026 07:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="q8VxJzh/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318292628D;
	Fri,  3 Apr 2026 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775201126; cv=none; b=RP6/jshANoKTl0gSLHE45e1jkeY2gAvuaixtno9gajwidmKvX7Y0JngToNf6teRXnvR4Tn2M42h5+l7FKZWWWlhB3Ck3TDHAg+dHCd470wRBxUAltXINJR3jSjA2XXhqObfQkYpSQxvzxeJdGH20bZ+v7e6rg/O2edFOaqqe+hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775201126; c=relaxed/simple;
	bh=2dq8NIfyYtFh6+S4qvM7z7GD1ol5P1akLBCt+eSAAhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6PorVCC35z+x+yoK9WcM0lvEM4bOZ1vARzgk1sDqY6S6MgbgmVHh5doch0sStkHFRGB9Q0O0uv2/U6zge63/oB8WZE0GD3PV0WbLikRuEl05pCp6Aa6R2KgWHtCWmH9ckp5l4rHLWBs4DWPiWqzo9ZICZam5eC3CFr5M/MVSZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=q8VxJzh/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.208.130] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 02D9720B710C;
	Fri,  3 Apr 2026 00:25:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 02D9720B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775201122;
	bh=hJKtuq0tWNQm462P/0EEtw3XAo9bQfaHEq/zxB5utMw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q8VxJzh/VNvsWQMp95FPzocB9FmXbSm8KHWceTSFXYWK8y4D06dL0uBb9Mh7AqfHe
	 a6GY26XDIK62NdAQCUT8Wl17K+E2tA8Us+BNuO/+NXDUEBlXWp288KmsUBhTqshjOl
	 CaTR9wgOXo0xu53b0Y5s8jFOgeVR7aZFnVXdb0SU=
Message-ID: <9f0e27ac-099b-4b7d-b082-f43245331bbc@linux.microsoft.com>
Date: Fri, 3 Apr 2026 12:55:16 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: mshv_vtl: Fix vmemmap_shift exceeding
 MAX_FOLIO_ORDER
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260401054005.1532381-1-namjain@linux.microsoft.com>
 <SN6PR02MB415797828F8DC5C9AC7E9131D45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415797828F8DC5C9AC7E9131D45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9955-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 4E4B8391B70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/3/2026 9:05 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, March 31, 2026 10:40 PM
>>
>> When registering VTL0 memory via MSHV_ADD_VTL0_MEMORY, the kernel
>> computes pgmap->vmemmap_shift as the number of trailing zeros in the
>> OR of start_pfn and last_pfn, intending to use the largest compound
>> page order both endpoints are aligned to.
>>
>> However, this value is not clamped to MAX_FOLIO_ORDER, so a
>> sufficiently aligned range (e.g. physical range 0x800000000000-
>> 0x800080000000, corresponding to start_pfn=0x800000000 with 35
>> trailing zeros) can produce a shift larger than what
>> memremap_pages() accepts, triggering a WARN and returning -EINVAL:
>>
>>    WARNING: ... memremap_pages+0x512/0x650
>>    requested folio size unsupported
>>
>> The MAX_FOLIO_ORDER check was added by
>> commit 646b67d57589 ("mm/memremap: reject unreasonable folio/compound
>> page sizes in memremap_pages()").
>> When CONFIG_HAVE_GIGANTIC_FOLIOS=y, CONFIG_SPARSEMEM_VMEMMAP=y, and
>> CONFIG_HUGETLB_PAGE is not set, MAX_FOLIO_ORDER resolves to
>> (PUD_SHIFT - PAGE_SHIFT) = 18. Any range whose PFN alignment exceeds
>> order 18 hits this path.
> 
> I'm not clear on what point you are making with this specific
> configuration that results in MAX_FOLIO_ORDER being 18. Is it just
> an example? Is 18 the largest expected value for MAX_FOLIO_ORDER?
> And note that PUD_SHIFT and PAGE_SHIFT might have different values
> on arm64 with a page size other than 4K.
> 

Yes, this was just an example. It is not generalized enough, I will 
remove it.
MAX_FOLIO_ORDER could go beyond 18.

>>
>> Fix this by clamping vmemmap_shift to MAX_FOLIO_ORDER so we always
>> request the largest order the kernel supports, rather than an
>> out-of-range value.
>>
>> Also fix the error path to propagate the actual error code from
>> devm_memremap_pages() instead of hard-coding -EFAULT, which was
>> masking the real -EINVAL return.
>>
>> Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   drivers/hv/mshv_vtl_main.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
>> index 5856975f32e12..255fed3a740c1 100644
>> --- a/drivers/hv/mshv_vtl_main.c
>> +++ b/drivers/hv/mshv_vtl_main.c
>> @@ -405,8 +405,12 @@ static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vtl *vtl, void __user *arg)
>>   	/*
>>   	 * Determine the highest page order that can be used for the given memory range.
>>   	 * This works best when the range is aligned; i.e. both the start and the length.
>> +	 * Clamp to MAX_FOLIO_ORDER to avoid a WARN in memremap_pages() when the range
>> +	 * alignment exceeds the maximum supported folio order for this kernel config.
>>   	 */
>> -	pgmap->vmemmap_shift = count_trailing_zeros(vtl0_mem.start_pfn | vtl0_mem.last_pfn);
>> +	pgmap->vmemmap_shift = min_t(unsigned long,
>> +				     count_trailing_zeros(vtl0_mem.start_pfn | vtl0_mem.last_pfn),
>> +				     MAX_FOLIO_ORDER);
> 
> Is it necessary to use min_t() here, or would min() work?  Neither count_trailing_zeros()
> nor MAX_FOLIO_ORDER is ever negative, so it seems like just min() would work with
> no potential for doing a bogus comparison or assignment.
>

min could work, yes. I just felt min_t is more safer for comparing these 
two different types of values -
count_trailing_zeroes being 'int'
MAX_FOLIO_ORDER being a macro, calculated by applying bit operations.

and destination being unsigned int.


include/linux/mmzone.h:#define MAX_FOLIO_ORDER          MAX_PAGE_ORDER
include/linux/mmzone.h:#define MAX_FOLIO_ORDER          PFN_SECTION_SHIFT
include/linux/mmzone.h:#define MAX_FOLIO_ORDER          (ilog2(SZ_16G) - 
PAGE_SHIFT)
include/linux/mmzone.h:#define MAX_FOLIO_ORDER          (ilog2(SZ_1G) - 
PAGE_SHIFT)
include/linux/mmzone.h:#define MAX_FOLIO_ORDER          (PUD_SHIFT - 
PAGE_SHIFT)

I am fine with anything you suggest here.

> The shift is calculated using the originally passed in start_pfn and last_pfn, while the
> "range" struct in pgmap has an "end" value that is one page less. So is the idea to
> go ahead and create the mapping with folios of a size that includes that last page,
> and then just waste the last page of the last folio?

No, waste does not occur. The vmemmap_shift determines the folio order, 
and memmap_init_zone_device() walks the range [start_pfn, last_pfn) in 
steps of (1 << vmemmap_shift) pages, creating one folio per step. The OR 
operation ensures both boundaries are aligned to multiples of (1 << 
vmemmap_shift), guaranteeing the range divides evenly into folios with 
no partial folio at the end.
The intention is to find the highest folio order possible here, and if 
it reaches the MAX_FOLIO_ORDER, restrict vmemmap_shift to it.

> 
>>   	dev_dbg(vtl->module_dev,
>>   		"Add VTL0 memory: start: 0x%llx, end_pfn: 0x%llx, page order: %lu\n",
>>   		vtl0_mem.start_pfn, vtl0_mem.last_pfn, pgmap->vmemmap_shift);
>> @@ -415,7 +419,7 @@ static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vtl *vtl, void __user *arg)
>>   	if (IS_ERR(addr)) {
>>   		dev_err(vtl->module_dev, "devm_memremap_pages error: %ld\n", PTR_ERR(addr));
>>   		kfree(pgmap);
>> -		return -EFAULT;
>> +		return PTR_ERR(addr);
>>   	}
>>
>>   	/* Don't free pgmap, since it has to stick around until the memory
>>
>> base-commit: 36ece9697e89016181e5ae87510e40fb31d86f2b
>> --
>> 2.43.0
>>

Thanks for reviewing.

Regards,
Naman


