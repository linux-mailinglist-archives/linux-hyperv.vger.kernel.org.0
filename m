Return-Path: <linux-hyperv+bounces-8623-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAvZFv0tfWmrQgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8623-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 23:17:33 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A4EBF12F
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 23:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C2653013689
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 22:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F409938737A;
	Fri, 30 Jan 2026 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YM1stAjb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F94B2D9EC2;
	Fri, 30 Jan 2026 22:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769811449; cv=none; b=EldokfGSLhg6QLGPF0MeVXoCofcOIX2H4LoS4i+wXQPnSO0s88h48vUQq13YnPjr3TxpY/b9NvPb3yssEKoDMTQY2XMWUgeLj+4zKIueW+rXoP0DYCxozCQvo4jswDnlMlxNy7OGxtmmM0Zz/v3L4uwCO83mL3Gt7SUiuiFnUzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769811449; c=relaxed/simple;
	bh=EGRQ5jajlj0epRMwEiJS9LMrTJFqRTqZp/2YmMY4DXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eu/A+bU85c4fHyveUJ/Q7Sl32c6oDBEDIxJUK3yJ8d71eR1p29Hc5GCENFIf9frUETA1f4idMsAc61apOjSUNRgVJw5/i8LNX0mK76JaacmcBNK2H8+37Bl3NXpYzMGKzY9jAfnYA0AT7SRzd2FYbrbKsnFSkgMZxyY0obFcvbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YM1stAjb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.32.91] (unknown [40.78.12.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id B137B20B7167;
	Fri, 30 Jan 2026 14:17:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B137B20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769811446;
	bh=IxiREUpDwvUYfp+KmMQtO36xVZJRsu4DstzrrIFxWnI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YM1stAjbD6EE/TDEHMcHCEHktBOgZPLPc8A67mOGl1lDZiHcUfAX+m9cBdkoEb+VG
	 1mZyAwY6yBtfUZ2PfijoYzSldsSSy2FNtsQnPPNc5cfhRMGnHKjrcL9jaSwMYIsl4X
	 X7hHyr9HrZ1hE0SVNeZg02D09kd7wKLEaShmA0bY=
Message-ID: <8d798da6-1720-ceea-f1b0-62ca675085c8@linux.microsoft.com>
Date: Fri, 30 Jan 2026 14:17:24 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v0 15/15] mshv: Populate mmio mappings for PCI passthru
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
 nunodasneves@linux.microsoft.com, mhklinux@outlook.com
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-16-mrathor@linux.microsoft.com>
 <aXAxmYm4zbOzGztz@skinsburskii.localdomain>
 <45e7a4c0-f1d8-b8b4-8c03-56d06845323b@linux.microsoft.com>
 <aXevWXolgNrrLltF@skinsburskii.localdomain>
 <f39a501e-478f-66ff-26c8-229ca3991f4f@linux.microsoft.com>
 <aXkKhGvpaHUGclI-@skinsburskii.localdomain>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <aXkKhGvpaHUGclI-@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8623-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,linux.microsoft.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 01A4EBF12F
X-Rspamd-Action: no action

On 1/27/26 10:57, Stanislav Kinsburskii wrote:
> On Mon, Jan 26, 2026 at 07:07:22PM -0800, Mukesh R wrote:
>> On 1/26/26 10:15, Stanislav Kinsburskii wrote:
>>> On Fri, Jan 23, 2026 at 06:19:15PM -0800, Mukesh R wrote:
>>>> On 1/20/26 17:53, Stanislav Kinsburskii wrote:
>>>>> On Mon, Jan 19, 2026 at 10:42:30PM -0800, Mukesh R wrote:
>>>>>> From: Mukesh Rathor <mrathor@linux.microsoft.com>
>>>>>>
>>>>>> Upon guest access, in case of missing mmio mapping, the hypervisor
>>>>>> generates an unmapped gpa intercept. In this path, lookup the PCI
>>>>>> resource pfn for the guest gpa, and ask the hypervisor to map it
>>>>>> via hypercall. The PCI resource pfn is maintained by the VFIO driver,
>>>>>> and obtained via fixup_user_fault call (similar to KVM).
>>>>>>
>>>>>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>>>>>> ---
>>>>>>     drivers/hv/mshv_root_main.c | 115 ++++++++++++++++++++++++++++++++++++
>>>>>>     1 file changed, 115 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>>>>>> index 03f3aa9f5541..4c8bc7cd0888 100644
>>>>>> --- a/drivers/hv/mshv_root_main.c
>>>>>> +++ b/drivers/hv/mshv_root_main.c
>>>>>> @@ -56,6 +56,14 @@ struct hv_stats_page {
>>>>>>     	};
>>>>>>     } __packed;
>>>>>> +bool hv_nofull_mmio;   /* don't map entire mmio region upon fault */
>>>>>> +static int __init setup_hv_full_mmio(char *str)
>>>>>> +{
>>>>>> +	hv_nofull_mmio = true;
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +__setup("hv_nofull_mmio", setup_hv_full_mmio);
>>>>>> +
>>>>>>     struct mshv_root mshv_root;
>>>>>>     enum hv_scheduler_type hv_scheduler_type;
>>>>>> @@ -612,6 +620,109 @@ mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
>>>>>>     }
>>>>>>     #ifdef CONFIG_X86_64
>>>>>> +
>>>>>> +/*
>>>>>> + * Check if uaddr is for mmio range. If yes, return 0 with mmio_pfn filled in
>>>>>> + * else just return -errno.
>>>>>> + */
>>>>>> +static int mshv_chk_get_mmio_start_pfn(struct mshv_partition *pt, u64 gfn,
>>>>>> +				       u64 *mmio_pfnp)
>>>>>> +{
>>>>>> +	struct vm_area_struct *vma;
>>>>>> +	bool is_mmio;
>>>>>> +	u64 uaddr;
>>>>>> +	struct mshv_mem_region *mreg;
>>>>>> +	struct follow_pfnmap_args pfnmap_args;
>>>>>> +	int rc = -EINVAL;
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * Do not allow mem region to be deleted beneath us. VFIO uses
>>>>>> +	 * useraddr vma to lookup pci bar pfn.
>>>>>> +	 */
>>>>>> +	spin_lock(&pt->pt_mem_regions_lock);
>>>>>> +
>>>>>> +	/* Get the region again under the lock */
>>>>>> +	mreg = mshv_partition_region_by_gfn(pt, gfn);
>>>>>> +	if (mreg == NULL || mreg->type != MSHV_REGION_TYPE_MMIO)
>>>>>> +		goto unlock_pt_out;
>>>>>> +
>>>>>> +	uaddr = mreg->start_uaddr +
>>>>>> +		((gfn - mreg->start_gfn) << HV_HYP_PAGE_SHIFT);
>>>>>> +
>>>>>> +	mmap_read_lock(current->mm);
>>>>>
>>>>> Semaphore can't be taken under spinlock.
>>>
>>>>
>>>> Yeah, something didn't feel right here and I meant to recheck, now regret
>>>> rushing to submit the patch.
>>>>
>>>> Rethinking, I think the pt_mem_regions_lock is not needed to protect
>>>> the uaddr because unmap will properly serialize via the mm lock.
>>>>
>>>>
>>>>>> +	vma = vma_lookup(current->mm, uaddr);
>>>>>> +	is_mmio = vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
>>>>>
>>>>> Why this check is needed again?
>>>>
>>>> To make sure region did not change. This check is under lock.
>>>>
>>>
>>> How can this happen? One can't change VMA type without unmapping it
>>> first. And unmapping it leads to a kernel MMIO region state dangling
>>> around without corresponding user space mapping.
>>
>> Right, and vm_flags would not be mmio expected then.
>>
>>> This is similar to dangling pinned regions and should likely be
>>> addressed the same way by utilizing MMU notifiers to destpoy memoty
>>> regions is VMA is detached.
>>
>> I don't think we need that. Either it succeeds if the region did not
>> change at all, or just fails.
>>
> 
> I'm afraid we do, as if the driver mapped a page with the previous
> memory region, and then the region is unmapped, the page will stay
> mapped in the hypervisor, but will be considered free by kernel, which
> in turn will lead to GPF upn next allocation.

There are no ram pages for mmio regions. Also, we don't do much with
mmio regions other than tell the hyp about it.

Thanks,
-Mukesh


> With pinned regions we issue is similar but less impacting: pages can't
> be released by user space unmapping and thus will be simply leaked, but
> the system stays intact.
> 
> MMIO regions are simila to movable region in this regard: they don't
> reference the user pages, and thus this guest region replaement is a
> stright wat to kernel panic.
> 
>>
>>>>> The region type is stored on the region itself.
>>>>> And the type is checked on the caller side.
>>>>>
>>>>>> +	if (!is_mmio)
>>>>>> +		goto unlock_mmap_out;
>>>>>> +
>>>>>> +	pfnmap_args.vma = vma;
>>>>>> +	pfnmap_args.address = uaddr;
>>>>>> +
>>>>>> +	rc = follow_pfnmap_start(&pfnmap_args);
>>>>>> +	if (rc) {
>>>>>> +		rc = fixup_user_fault(current->mm, uaddr, FAULT_FLAG_WRITE,
>>>>>> +				      NULL);
>>>>>> +		if (rc)
>>>>>> +			goto unlock_mmap_out;
>>>>>> +
>>>>>> +		rc = follow_pfnmap_start(&pfnmap_args);
>>>>>> +		if (rc)
>>>>>> +			goto unlock_mmap_out;
>>>>>> +	}
>>>>>> +
>>>>>> +	*mmio_pfnp = pfnmap_args.pfn;
>>>>>> +	follow_pfnmap_end(&pfnmap_args);
>>>>>> +d
>>>>>> +unlock_mmap_out:
>>>>>> +	mmap_read_unlock(current->mm);
>>>>>> +unlock_pt_out:
>>>>>> +	spin_unlock(&pt->pt_mem_regions_lock);
>>>>>> +	return rc;
>>>>>> +}
>>>>>> +
>>>>>> +/*
>>>>>> + * At present, the only unmapped gpa is mmio space. Verify if it's mmio
>>>>>> + * and resolve if possible.
>>>>>> + * Returns: True if valid mmio intercept and it was handled, else false
>>>>>> + */
>>>>>> +static bool mshv_handle_unmapped_gpa(struct mshv_vp *vp)
>>>>>> +{
>>>>>> +	struct hv_message *hvmsg = vp->vp_intercept_msg_page;
>>>>>> +	struct hv_x64_memory_intercept_message *msg;
>>>>>> +	union hv_x64_memory_access_info accinfo;
>>>>>> +	u64 gfn, mmio_spa, numpgs;
>>>>>> +	struct mshv_mem_region *mreg;
>>>>>> +	int rc;
>>>>>> +	struct mshv_partition *pt = vp->vp_partition;
>>>>>> +
>>>>>> +	msg = (struct hv_x64_memory_intercept_message *)hvmsg->u.payload;
>>>>>> +	accinfo = msg->memory_access_info;
>>>>>> +
>>>>>> +	if (!accinfo.gva_gpa_valid)
>>>>>> +		return false;
>>>>>> +
>>>>>> +	/* Do a fast check and bail if non mmio intercept */
>>>>>> +	gfn = msg->guest_physical_address >> HV_HYP_PAGE_SHIFT;
>>>>>> +	mreg = mshv_partition_region_by_gfn(pt, gfn);
>>>>>
>>>>> This call needs to be protected by the spinlock.
>>>>
>>>> This is sorta fast path to bail. We recheck under partition lock above.
>>>>
>>>
>>> Accessing the list of regions without lock is unsafe.
>>
>> I am not sure why? This check is done by a vcpu thread, so regions
>> will not have just gone away.
>>
> 
> This is shared resources. Multiple VP thread get into this function
> simultaneously, so there is a race already. But this one we can live
> with without locking as they don't mutate the list of the regions.
> 
> The issue happens when VMM adds or removed another region as it mutates
> the list and races with VP threads doing this lookup.
> 
> Thanks,
> Stanislav
> 
> 
>> Thanks,
>> -Mukesh
>>
>>
>>> Thanks,
>>> Stanislav
>>>
>>>> Thanks,
>>>> -Mukesh
>>>>
>>>>
>>>>> Thanks,
>>>>> Stanislav
>>>>>
>>>>>> +	if (mreg == NULL || mreg->type != MSHV_REGION_TYPE_MMIO)
>>>>>> +		return false;
>>>>>> +
>>>>>> +	rc = mshv_chk_get_mmio_start_pfn(pt, gfn, &mmio_spa);
>>>>>> +	if (rc)
>>>>>> +		return false;
>>>>>> +
>>>>>> +	if (!hv_nofull_mmio) {		/* default case */
>>>>>> +		gfn = mreg->start_gfn;
>>>>>> +		mmio_spa = mmio_spa - (gfn - mreg->start_gfn);
>>>>>> +		numpgs = mreg->nr_pages;
>>>>>> +	} else
>>>>>> +		numpgs = 1;
>>>>>> +
>>>>>> +	rc = hv_call_map_mmio_pages(pt->pt_id, gfn, mmio_spa, numpgs);
>>>>>> +
>>>>>> +	return rc == 0;
>>>>>> +}
>>>>>> +
>>>>>>     static struct mshv_mem_region *
>>>>>>     mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
>>>>>>     {
>>>>>> @@ -666,13 +777,17 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
>>>>>>     	return ret;
>>>>>>     }
>>>>>> +
>>>>>>     #else  /* CONFIG_X86_64 */
>>>>>> +static bool mshv_handle_unmapped_gpa(struct mshv_vp *vp) { return false; }
>>>>>>     static bool mshv_handle_gpa_intercept(struct mshv_vp *vp) { return false; }
>>>>>>     #endif /* CONFIG_X86_64 */
>>>>>>     static bool mshv_vp_handle_intercept(struct mshv_vp *vp)
>>>>>>     {
>>>>>>     	switch (vp->vp_intercept_msg_page->header.message_type) {
>>>>>> +	case HVMSG_UNMAPPED_GPA:
>>>>>> +		return mshv_handle_unmapped_gpa(vp);
>>>>>>     	case HVMSG_GPA_INTERCEPT:
>>>>>>     		return mshv_handle_gpa_intercept(vp);
>>>>>>     	}
>>>>>> -- 
>>>>>> 2.51.2.vfs.0.1
>>>>>>


