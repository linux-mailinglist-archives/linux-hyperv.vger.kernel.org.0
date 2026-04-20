Return-Path: <linux-hyperv+bounces-10224-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBXXJt9c5ml6vQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10224-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 19:05:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1356C430869
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 19:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB6BB304A87A
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 16:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB16334C9A6;
	Mon, 20 Apr 2026 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oBRh2ugU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F65346781;
	Mon, 20 Apr 2026 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776702556; cv=none; b=k/Cu//Ug+2e3fG6JNayK2G0PYfIz7jIIzJceNZztTroZo3z7psv1xPrcTUeZIQcaKG32XL02NJvbCRW62POsSYovEs5KiEKO+GBlE6u6gXltzc4ih1/IuWxtyYQcug1DCpSgG+xrPJ50gqGayC+8Kk2lz/dZnsDzz7hE6NQPJOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776702556; c=relaxed/simple;
	bh=e2MHTfcV+fPwUcqia/5xICbMBWX+KRo4PyIzD29bMdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nU7qzZLUMrdYTKGjCNHM4SFkCq5Gwxc3dbmQphIx44/eTORY+Mh5MTeY8vLklXqx4OAVLVR0xD6ESsJo0rocDMTF7paGBrCvn+qLv5SDVwmyCdAouNkwkoQpqkAIDyOfiB5ziiX0vQuYVrT8BDePX0ZRh6pwlezAdht0lqn6glg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oBRh2ugU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.129])
	by linux.microsoft.com (Postfix) with ESMTPSA id B3CB120B6F01;
	Mon, 20 Apr 2026 09:29:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3CB120B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776702554;
	bh=It5ZQ1Ym0Crc24mu5OYW/iqJ4WsOc3REIctNBwEirdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oBRh2ugUhcjQ15Nqp8YE36Pafhly7wutCo09jpzP80jl7Mw1pPfA4iPbkRiyVSMhf
	 JZlVg+kq5rSd4yzlfsdjnXjx80sAfnElcy/IDKnCL4BGVvCFtDFrOBmSEmBc8Ctehh
	 2keSqhNxDAAwDKcaE2DxLT/G7gVWpShsQWKQ2xeQ=
Date: Mon, 20 Apr 2026 09:29:11 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] mshv: Support regions with different VMAs
Message-ID: <aeZUVyrIkYvdAy0q@skinsburskii.localdomain>
References: <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177490106973.81669.17734971204992890360.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157043516DEB3DC5E987AA6D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157043516DEB3DC5E987AA6D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10224-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii.localdomain:mid,linux.microsoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1356C430869
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 09:08:52PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday, March 30, 2026 1:04 PM
> > 
> > Allow HMM fault handling across memory regions that span multiple VMAs
> > with different protection flags. The previous implementation assumed a
> > single VMA per region, which would fail when guest memory crosses VMA
> > boundaries.
> > 
> > Iterate through VMAs within the range and handle each separately with
> > appropriate protection flags, enabling more flexible memory region
> > configurations for partitions.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_regions.c |   72 +++++++++++++++++++++++++++++++++------------
> >  1 file changed, 52 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> > index ed9c55841140..1bb1bfe177e2 100644
> > --- a/drivers/hv/mshv_regions.c
> > +++ b/drivers/hv/mshv_regions.c
> > @@ -492,37 +492,72 @@ int mshv_region_get(struct mshv_mem_region *region)
> >  }
> > 
> >  /**
> > - * mshv_region_hmm_fault_and_lock - Handle HMM faults and lock the memory region
> > + * mshv_region_hmm_fault_and_lock - Handle HMM faults across VMAs and lock
> > + *                                  the memory region
> >   * @region: Pointer to the memory region structure
> > - * @range: Pointer to the HMM range structure
> > + * @start : Starting virtual address of the range to fault
> > + * @end   : Ending virtual address of the range to fault (exclusive)
> > + * @pfns  : Output array for page frame numbers with HMM flags
> >   *
> >   * This function performs the following steps:
> >   * 1. Reads the notifier sequence for the HMM range.
> >   * 2. Acquires a read lock on the memory map.
> > - * 3. Handles HMM faults for the specified range.
> > - * 4. Releases the read lock on the memory map.
> > - * 5. If successful, locks the memory region mutex.
> > - * 6. Verifies if the notifier sequence has changed during the operation.
> > - *    If it has, releases the mutex and returns -EBUSY to match with
> > - *    hmm_range_fault() return code for repeating.
> > + * 3. Iterates through VMAs in the specified range, handling each
> > + *    separately with appropriate protection flags (HMM_PFN_REQ_WRITE set
> > + *    based on VMA flags).
> > + * 4. Handles HMM faults for each VMA segment.
> > + * 5. Releases the read lock on the memory map.
> > + * 6. If successful, locks the memory region mutex.
> > + * 7. Verifies if the notifier sequence has changed during the operation.
> > + *    If it has, releases the mutex and returns -EBUSY to signal retry.
> > + *
> > + * The function expects the range [start, end] is backed by valid VMAs.
> 
> Use "[start, end)" to describe the range since end is exclusive.
> 

Will do

> > + * Returns -EFAULT if any address in the range is not covered by a VMA.
> >   *
> >   * Return: 0 on success, a negative error code otherwise.
> >   */
> >  static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
> > -					  struct hmm_range *range)
> > +					  unsigned long start,
> > +					  unsigned long end,
> > +					  unsigned long *pfns)
> >  {
> > +	struct hmm_range range = {
> > +		.notifier = &region->mreg_mni,
> > +	};
> >  	int ret;
> > 
> > -	range->notifier_seq = mmu_interval_read_begin(range->notifier);
> > +	range.notifier_seq = mmu_interval_read_begin(range.notifier);
> >  	mmap_read_lock(region->mreg_mni.mm);
> > -	ret = hmm_range_fault(range);
> > +	while (start < end) {
> > +		struct vm_area_struct *vma;
> > +
> > +		vma = vma_lookup(current->mm, start);
> 
> The mmap_read_lock() was obtained on region->mreg_mni.mm, but the
> lookup is done against current->mm. Maybe these are the same, but
> it looks wrong.  (Pointed out by a Co-Pilot AI review.)
> 

Yes, they arethe same, but I'll update to use the same mm for clarity.

> > +		if (!vma) {
> > +			ret = -EFAULT;
> > +			break;
> > +		}
> > +
> > +		range.hmm_pfns = pfns;
> > +		range.start = start;
> > +		range.end = min(vma->vm_end, end);
> > +		range.default_flags = HMM_PFN_REQ_FAULT;
> > +		if (vma->vm_flags & VM_WRITE)
> > +			range.default_flags |= HMM_PFN_REQ_WRITE;
> > +
> > +		ret = hmm_range_fault(&range);
> > +		if (ret)
> > +			break;
> > +
> > +		start = range.end + 1;
> 
> Since range.end is exclusive, the +1 should not be done.
> 

Is it always? I'll need to check to make sure the end passed to this
function is page aligned. If it is, then I'll remove the +1.

> > +		pfns += DIV_ROUND_UP(range.end - range.start, PAGE_SIZE);
> 
> Just to confirm, range.end and range.start should always be page aligned,
> right? So the ROUND_UP should never kick in.
> 

Same as above: if the end passed to this function is page aligned, then
I'll remove the DIV_ROUND_UP and just do a simple division.

Thanks,
Stanislav

> > +	}
> >  	mmap_read_unlock(region->mreg_mni.mm);
> >  	if (ret)
> >  		return ret;
> > 
> >  	mutex_lock(&region->mreg_mutex);
> > 
> > -	if (mmu_interval_read_retry(range->notifier, range->notifier_seq)) {
> > +	if (mmu_interval_read_retry(range.notifier, range.notifier_seq)) {
> >  		mutex_unlock(&region->mreg_mutex);
> >  		cond_resched();
> >  		return -EBUSY;
> > @@ -546,10 +581,7 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
> >  static int mshv_region_range_fault(struct mshv_mem_region *region,
> >  				   u64 pfn_offset, u64 pfn_count)
> >  {
> > -	struct hmm_range range = {
> > -		.notifier = &region->mreg_mni,
> > -		.default_flags = HMM_PFN_REQ_FAULT | HMM_PFN_REQ_WRITE,
> > -	};
> > +	unsigned long start, end;
> >  	unsigned long *pfns;
> >  	int ret;
> >  	u64 i;
> > @@ -558,12 +590,12 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
> >  	if (!pfns)
> >  		return -ENOMEM;
> > 
> > -	range.hmm_pfns = pfns;
> > -	range.start = region->start_uaddr + pfn_offset * HV_HYP_PAGE_SIZE;
> > -	range.end = range.start + pfn_count * HV_HYP_PAGE_SIZE;
> > +	start = region->start_uaddr + pfn_offset * PAGE_SIZE;
> > +	end = start + pfn_count * PAGE_SIZE;
> > 
> >  	do {
> > -		ret = mshv_region_hmm_fault_and_lock(region, &range);
> > +		ret = mshv_region_hmm_fault_and_lock(region, start, end,
> > +						     pfns);
> >  	} while (ret == -EBUSY);
> > 
> >  	if (ret)
> > 
> > 
> 

