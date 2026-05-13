Return-Path: <linux-hyperv+bounces-10814-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDVNBTflA2oRAAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10814-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 04:43:03 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AE11752C52B
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 04:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E27D304297A
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 02:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD4538E8B4;
	Wed, 13 May 2026 02:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UMFVeOs7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A919535DA55;
	Wed, 13 May 2026 02:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640180; cv=none; b=RYJsDYINwyapTZhyhJbSt0aJQB747HsNEtGKiaq0zbCF5Iq94RtamwpSFLpedplRWhW/o9tlnZPFWH4V6GnaqCv5rRcshfRI8GgYp6wOpJp9ejxC6GP986OlGr6jd1+d/IuGgamtoHm96xt+YKrTF9/XgtNTZuwNGs0z2OdhQVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640180; c=relaxed/simple;
	bh=ed+O/pR5mC2MCbGf9lHYynglGGitK0qWZf14W3ovHvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9OKG4zIjo3H9s0RC/2s/V7+iLKR71HhTFjvsm3s3vUAKZX4Hy1lO6/OH4x/Zbm2/UO5Cxwo7C3laFEa84/A7lpBe1rL0BIhc7AgoNRHVr003Cq+fZXVLlRDUJijvu7+7DXzv9rsdP1I0uZcDCNL1YSD67h0aOE3h12VqHgLxqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UMFVeOs7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0EBE420B7166;
	Tue, 12 May 2026 19:42:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0EBE420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778640176;
	bh=HDotFo7yQkt3tGus6/l1hCvSHXQW8pdq+LRsiO9XGls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UMFVeOs7jhHizUoZTF3rLV2fW2H7+kCxsG+j5RVqvZRaYJO8AXfta9wqL4aMgODOg
	 J3qPV4D2PtHGW6IjCCwtKABwk4UA468vwFN9VGwCfbgXSjEomN1K9YREsOaurc60cL
	 8SMTLGI1FKlt5aHKMDLY/c6dwmfueyb1aeDwXOKs=
Date: Tue, 12 May 2026 19:42:57 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: kys@microsoft.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	decui@microsoft.com, haiyangz@microsoft.com, jgg@ziepe.ca,
	corbet@lwn.net, leon@kernel.org, longli@microsoft.com,
	ljs@kernel.org, mhocko@suse.com, rppt@kernel.org, shuah@kernel.org,
	skhan@linuxfoundation.org, surenb@google.com, vbabka@kernel.org,
	wei.liu@kernel.org, linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm/hmm: Add hmm_range_fault_unlockable() for mmap
 lock-drop support
Message-ID: <agPlMYFCrdD2WKYZ@skinsburskii.localdomain>
References: <177759835313.221039.2807391868456411507.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177759840859.221039.13065406062747296947.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <563bb216-c270-4711-adda-b91484af40dc@kernel.org>
 <agNS4llNtAHBkMA2@skinsburskii.localdomain>
 <f073a8d7-5761-4f7b-a5e5-c6aeae5fdc72@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f073a8d7-5761-4f7b-a5e5-c6aeae5fdc72@kernel.org>
X-Rspamd-Queue-Id: AE11752C52B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10814-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.microsoft.com:dkim,skinsburskii.localdomain:mid]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 09:18:11PM +0200, David Hildenbrand (Arm) wrote:
> On 5/12/26 18:18, Stanislav Kinsburskii wrote:
> > On Tue, May 12, 2026 at 10:42:14AM +0200, David Hildenbrand (Arm) wrote:
> >>
> >>> +	for (; addr < end; addr += PAGE_SIZE) {
> >>> +		vm_fault_t ret;
> >>> +
> >>> +		ret = handle_mm_fault(vma, addr, fault_flags, NULL);
> >>> +
> >>> +		if (ret & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)) {
> >>> +			/*
> >>> +			 * The mmap lock has been dropped by the fault handler.
> >>> +			 * Record the failing address and signal lock-drop to
> >>> +			 * the caller.
> >>> +			 */
> >>> +			*hmm_vma_walk->locked = 0;
> >>> +			hmm_vma_walk->last = addr;
> >>> +			return -EAGAIN;
> >>
> >>
> >> Okay, so we'll return straight from hmm_vma_fault() to
> >> hmm_vma_handle_pte()/hmm_vma_walk_pmd() -> walk_page_range() machinery.
> >>
> >> Hopefully we don't refer to the MM/VMA on any path there? It would be nicer if
> >> the hmm_vma_fault() could be called by the caller of walk_page_range(), but
> >> that's tricky I guess, as hmm_vma_fault() consumes the walk structure and
> >> requires the vma in there.
> >>
> > 
> > It looks like a caller can provide a post_vma callback in mm_walk_ops. I
> > missed that case here. This callback cannot be supported by this change.
> > I will update the patch.
> > 
> >>
> >> Note: am I wrong, or is hmm_vma_fault() really always called with
> >> required_fault=true?
> >>
> > 
> > No, hmm_pte_need_fault can return false.
> 
> That's not what I mean. Looks like all paths leading to hmm_vma_fault() have
> required_fault = true;
> 
> IOW, there is always a "if (required_fault)" before it one way or the other.
> 
> Ah, and there even is a "WARN_ON_ONCE(!required_fault)" in the function. What an
> odd thing to do :)
> 
> > 
> >>> +		}
> >>> +
> >>> +		if (ret & VM_FAULT_ERROR)
> >>>  			return -EFAULT;
> >>> +	}
> >>>  	return -EBUSY;
> >>>  }
> >>>  
> >>> @@ -566,6 +585,17 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
> >>>  	if (required_fault) {
> >>>  		int ret;
> >>>  
> >>> +		/*
> >>> +		 * Faulting hugetlb pages on the unlockable path is not
> >>> +		 * supported. The walk framework holds hugetlb_vma_lock_read
> >>> +		 * which must be dropped before handle_mm_fault, but if the
> >>> +		 * mmap lock is also dropped (VM_FAULT_RETRY), the vma may
> >>> +		 * be freed and the walk framework's unconditional unlock
> >>> +		 * becomes a use-after-free.
> >>> +		 */
> >>> +		if (hmm_vma_walk->locked)
> >>> +			return -EFAULT;
> >>
> >> Just because it's unlockable doesn't mean that you must unlock. Can't this be
> >> kept working as is, just simulating here as if it would not be unlockable?
> >>
> > 
> > I’m not sure how to implement this. The walk_page_range code expects the
> > hugetlb VMA to still be read-locked when we return from
> > hmm_vma_walk_hugetlb_entry. How can we guarantee that if the VMA might
> > be gone?
> > 
> > I added a note in the docs. Whoever tackles this will likely need to
> > either rework `walk_page_range` to handle the case where the VMA is
> > gone, or use a different approach.
> > 
> > Do you have any other suggestions on how to implement it?
> 
> You just want hmm_vma_fault() to not set
> "FAULT_FLAG_ALLOW_RETRY·|·FAULT_FLAG_KILLABLE".
> 
> The hacky way could be:
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 5955f2f0c83d..83dba990e10a 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -564,6 +564,7 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned
> long hmask,
>         required_fault =
>                 hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, cpu_flags);
>         if (required_fault) {
> +               int *saved_locked = hmm_vma_walk->locked;
>                 int ret;
> 
>                 spin_unlock(ptl);
> @@ -576,7 +577,9 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned
> long hmask,
>                  * use here of either pte or ptl after dropping the vma
>                  * lock.
>                  */
> +               hmm_vma_walk->locked = NULL;
>                 ret = hmm_vma_fault(addr, end, required_fault, walk);
> +               hmm_vma_walk->locked = saved_locked;
>                 hugetlb_vma_lock_read(vma);
>                 return ret;
>         }
> 

I see. AFAIU the outcome would be the same.

> But really, I think we should just try to get uffd support working properly, not
> excluding hugetlb.
> 
> GUP achieves it properly by performing the fault handling outside of page table
> walking context ... essentially what I described in my first comment above:
> return the information to the caller and let it just trigger the fault.
> 
> The issue here is that we trigger a fault out of walk_hugetlb_range() where we
> still hold locks, resulting in this questionable hugetlb_vma_unlock_read +
> hugetlb_vma_lock_read pattern.
> 

Fair enough.

> The fault should just be triggered from a place where we don't have to play with
> hugetlb vma locks or be afraid that dropping the mmap lock causes other problems.
> 

I reworked this part. Please take a look at v2.

Thanks,
Stanislav

> 
> -- 
> Cheers,
> 
> David

