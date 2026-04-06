Return-Path: <linux-hyperv+bounces-10002-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKXjFwA902mugAcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10002-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 06:56:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B63C43A182B
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 06:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D3BF3005743
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 04:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387CA30DEA3;
	Mon,  6 Apr 2026 04:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RL3aKg4q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B982C028F;
	Mon,  6 Apr 2026 04:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775451389; cv=none; b=El4FLEy1w6QXHST6y9401p+VZrtUWEg1/p7LpZj3VTGq216v4TtAN/YrlMCbj3ja1gql8tK+/Vn/Hbtfjat6W0P00ozgYlQJv9d58beSVeHxyo9tR2oavXfWM01c5MzjOdQPBz5q09ZDUIhiJ2lWRi37AGZCTinPn/zcDkftarM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775451389; c=relaxed/simple;
	bh=US0YUIfvKyYpmy+ZIYPeTZPeD+D4hv/mQX+OAcusRm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nG8pOcSfNATM2GJ47xzwFVDNnP6yx0VNKjNitzk1+wDGUYERc/MIufyqpLcslIaPZekmaDPSYD2Uly0PqVl9Xf66fQ7JoEx131rQOHuDs42l77yl+E+9JToNGA7mBXetXbs33YFnBniZu58v6d6tI2uPZPgQmZaUJRVS80YfF+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RL3aKg4q; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.65.110] (unknown [167.220.238.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id D47FC20B710C;
	Sun,  5 Apr 2026 21:56:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D47FC20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775451387;
	bh=b4L6SDsrLUvkYdRwOs4OK3+sQ/w7VLyF1zO5/2t+B7g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RL3aKg4qaCcePuRqqxZN2kUJVxEXGlrzCq1YTaDU2liGLOvyxSBVXcf2oI4RxxaUw
	 mQ+QNoPtjrpCvu7hfl/0U8x23d+BuYYBDCtZpJ2mk6x5csojB+MLCOSF1/gRHD/Tpd
	 We+CfSpnh2fKKFw/jVM8zKQWofxQQT/P02EA+8iU=
Message-ID: <a0d271e3-ece8-45cf-9dbb-ced773d6f3f8@linux.microsoft.com>
Date: Mon, 6 Apr 2026 10:26:20 +0530
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
 <9f0e27ac-099b-4b7d-b082-f43245331bbc@linux.microsoft.com>
 <SN6PR02MB4157550DA8F143F4DAFBEEE4D45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157550DA8F143F4DAFBEEE4D45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10002-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: B63C43A182B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/4/2026 12:07 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Friday, April 3, 2026 12:25 AM
>>
> 
> Nit: I wonder what's the best prefix to use in the patch Subject field.
> "Drivers: hv: mshv_vtl:" is rather long.  There was agreement to use
> just "mshv:" for the root partition code, and I probably misused that
> in commit 754cf84504ea. How about just "mshv_vtl:" as the prefix for this
> patch and other VTL patches going forward?
> 

If "mshv:" is OK for the root partition code, "mshv_vtl:" should be good 
for this. I'll change this subject, and for other patches in the future.

>> On 4/3/2026 9:05 AM, Michael Kelley wrote:
>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, March 31, 2026 10:40 PM
>>>>
>>>> When registering VTL0 memory via MSHV_ADD_VTL0_MEMORY, the kernel
>>>> computes pgmap->vmemmap_shift as the number of trailing zeros in the
>>>> OR of start_pfn and last_pfn, intending to use the largest compound
>>>> page order both endpoints are aligned to.
>>>>
>>>> However, this value is not clamped to MAX_FOLIO_ORDER, so a
>>>> sufficiently aligned range (e.g. physical range 0x800000000000-
>>>> 0x800080000000, corresponding to start_pfn=0x800000000 with 35
>>>> trailing zeros) can produce a shift larger than what
>>>> memremap_pages() accepts, triggering a WARN and returning -EINVAL:
>>>>
>>>>     WARNING: ... memremap_pages+0x512/0x650
>>>>     requested folio size unsupported
>>>>
>>>> The MAX_FOLIO_ORDER check was added by
>>>> commit 646b67d57589 ("mm/memremap: reject unreasonable folio/compound
>>>> page sizes in memremap_pages()").
>>>> When CONFIG_HAVE_GIGANTIC_FOLIOS=y, CONFIG_SPARSEMEM_VMEMMAP=y, and
>>>> CONFIG_HUGETLB_PAGE is not set, MAX_FOLIO_ORDER resolves to
>>>> (PUD_SHIFT - PAGE_SHIFT) = 18. Any range whose PFN alignment exceeds
>>>> order 18 hits this path.
>>>
>>> I'm not clear on what point you are making with this specific
>>> configuration that results in MAX_FOLIO_ORDER being 18. Is it just
>>> an example? Is 18 the largest expected value for MAX_FOLIO_ORDER?
>>> And note that PUD_SHIFT and PAGE_SHIFT might have different values
>>> on arm64 with a page size other than 4K.
>>>
>>
>> Yes, this was just an example. It is not generalized enough, I will
>> remove it.
>> MAX_FOLIO_ORDER could go beyond 18.
>>
>>>>
>>>> Fix this by clamping vmemmap_shift to MAX_FOLIO_ORDER so we always
>>>> request the largest order the kernel supports, rather than an
>>>> out-of-range value.
>>>>
>>>> Also fix the error path to propagate the actual error code from
>>>> devm_memremap_pages() instead of hard-coding -EFAULT, which was
>>>> masking the real -EINVAL return.
>>>>
>>>> Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
>>>> Cc: <stable@vger.kernel.org>
>>>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>>>> ---
>>>>    drivers/hv/mshv_vtl_main.c | 8 ++++++--
>>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
>>>> index 5856975f32e12..255fed3a740c1 100644
>>>> --- a/drivers/hv/mshv_vtl_main.c
>>>> +++ b/drivers/hv/mshv_vtl_main.c
>>>> @@ -405,8 +405,12 @@ static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vtl *vtl, void __user *arg)
>>>>    	/*
>>>>    	 * Determine the highest page order that can be used for the given memory range.
>>>>    	 * This works best when the range is aligned; i.e. both the start and the length.
>>>> +	 * Clamp to MAX_FOLIO_ORDER to avoid a WARN in memremap_pages() when the range
>>>> +	 * alignment exceeds the maximum supported folio order for this kernel config.
>>>>    	 */
>>>> -	pgmap->vmemmap_shift = count_trailing_zeros(vtl0_mem.start_pfn | vtl0_mem.last_pfn);
>>>> +	pgmap->vmemmap_shift = min_t(unsigned long,
>>>> +				     count_trailing_zeros(vtl0_mem.start_pfn | vtl0_mem.last_pfn),
>>>> +				     MAX_FOLIO_ORDER);
>>>
>>> Is it necessary to use min_t() here, or would min() work?  Neither count_trailing_zeros()
>>> nor MAX_FOLIO_ORDER is ever negative, so it seems like just min() would work with
>>> no potential for doing a bogus comparison or assignment.
>>>
>>
>> min could work, yes. I just felt min_t is more safer for comparing these
>> two different types of values -
>> count_trailing_zeroes being 'int'
>> MAX_FOLIO_ORDER being a macro, calculated by applying bit operations.
>>
>> and destination being unsigned int.
>>
>>
>> include/linux/mmzone.h:#define MAX_FOLIO_ORDER          MAX_PAGE_ORDER
>> include/linux/mmzone.h:#define MAX_FOLIO_ORDER          PFN_SECTION_SHIFT
>> include/linux/mmzone.h:#define MAX_FOLIO_ORDER          (ilog2(SZ_16G) - PAGE_SHIFT)
>> include/linux/mmzone.h:#define MAX_FOLIO_ORDER          (ilog2(SZ_1G) - PAGE_SHIFT)
>> include/linux/mmzone.h:#define MAX_FOLIO_ORDER          (PUD_SHIFT - PAGE_SHIFT)
>>
>> I am fine with anything you suggest here.
> 
> There's a fair number of patches on LKML that are replacing min_t() with
> min().  At some point in the not-too-distant past, the implementation of
> min() was improved to deal with different but compatible integer types.
> My sense is that min() is the better choice for general integer comparisons,
> particularly when the values are known to be non-negative.
> 
>>
>>> The shift is calculated using the originally passed in start_pfn and last_pfn, while the
>>> "range" struct in pgmap has an "end" value that is one page less. So is the idea to
>>> go ahead and create the mapping with folios of a size that includes that last page,
>>> and then just waste the last page of the last folio?
>>
>> No, waste does not occur. The vmemmap_shift determines the folio order,
>> and memmap_init_zone_device() walks the range [start_pfn, last_pfn) in
>> steps of (1 << vmemmap_shift) pages, creating one folio per step. The OR
>> operation ensures both boundaries are aligned to multiples of (1 <<
>> vmemmap_shift), guaranteeing the range divides evenly into folios with
>> no partial folio at the end.
>> The intention is to find the highest folio order possible here, and if
>> it reaches the MAX_FOLIO_ORDER, restrict vmemmap_shift to it.
> 
> OK, I figured out what is confusing me. I had a misunderstanding
> when I reviewed this code during its original submission, and that
> misunderstanding has influenced my (incorrect) review of this change.
> 
> The struct mshv_vtl_ram_disposition that is passed from user space has
> two fields: start_pfn and last_pfn. But last_pfn is somewhat misnamed
> in my view. For example, an aligned 2 MiB of memory would consist of
> 512 PFNs. If the first PFN is 0x200, the last PFN would be 0x3FF.  But in
> the semantics of the struct, the last_pfn field should be 0x400.
> 
> In response to my comments in the original review, you added the comment
> about last_pfn being excluded in the pagemap range, which is true. But it's
> not because that page is somehow reserved or being wasted. It's because
> the range is being described by specifying the PFN *after* the last PFN.
> 
> With the start_pfn and last_pfn fields used to determine the highest
> page order that can be used, the slightly unorthodox semantics of
> last_pfn make that calculation easy. But then you must subtract 1
> from last_pfn when setting the range start and end for
> devm_memremap_pages() to use. And the code does that, so the code
> is all correct. The comment might be improved to speak about the
> semantics of the last_pfn field, not that a page of memory is
> intentionally being excluded/wasted.  And/or maybe the struct
> mshv_vtl_ram_disposition definition should get a comment to clarify
> the semantics of last_pfn.
> 
> Michael

Right, last_pfn could be interpreted as actual last pfn. I'll add the 
comment to avoid the confusion.

Regards,
Naman


