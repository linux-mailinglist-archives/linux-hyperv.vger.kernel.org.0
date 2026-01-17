Return-Path: <linux-hyperv+bounces-8356-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A83D38DE9
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Jan 2026 11:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 19DAD3007F3A
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Jan 2026 10:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6A126F288;
	Sat, 17 Jan 2026 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="ebzIzbEd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134043128DF
	for <linux-hyperv@vger.kernel.org>; Sat, 17 Jan 2026 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768647275; cv=pass; b=U0P4Vt3DZfOwm6iUFuW+oTQBpwpU7vtvbyq90qfN12bcTvb0lO91CGk0kGreSpLwMKCSdr6fUQ8bYgwjHY0fSoonfGR2xgYHm+IeMQoOPKvUiuMDrGVS/H4G3U52nxv7C32w7/03LRWbaYA4AyY960bF0FgNUleN+5ylW/zCpss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768647275; c=relaxed/simple;
	bh=5xkFo8jp+YHwtzc4gOyWxIvV2GX6M1rMxKk3p7qmyso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gk5doUW9C9uU65jWHyYpF62/LZxCkrXFVFB4izr52JdHVgIIqRO4b8pQgd3i30fHvpdoNFQlD4fnCMSDHc6W5S5PnP3uatS0jSvnMvdR2IdLbS9K5VB4andG/P3vHkpBIxP9dGyZNRmz2o0+ViXx2D+oEcmQP4djqy9otPSK1Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=ebzIzbEd; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1768647266; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Rvs6S3Jw2YPWyRo//cm9c7Zt/XugfBa9rYtgkDN3tW0DswRWKH8+K1fY39EiQ7IwW3k96xVfA+OAkY1QQ6DqX2bQ73soT8lksncxObupE4f9YpVi7iM9TybKFeOPCpAq8Ev0YWOYrZH1KrdDV+PcobzbztoSPMJGHF3AEUB+GfU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768647266; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=T+Daky6QOHX3h/rQ2yNh6A6kmoyo58sgiEDys407nng=; 
	b=TMw0MImJfJ+wi2ZXQhS1qRiJgsgQOprMt81Bytm1tpPG8eszC5MdSH08SxBoajBOUotuu5F3R3NQOV+pA6Ad8cCyfTLtEF1cp2vXYoxsSutgiRaVfUdow82HqeIhto8RnST3wsIjxz4vxV1jK+V1OLwmNdxOOcV+3aaSy7UdfIU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768647266;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=T+Daky6QOHX3h/rQ2yNh6A6kmoyo58sgiEDys407nng=;
	b=ebzIzbEdNK+aNyTfdUzyZqm/m26qqXsiscjgjHq+icuYkm+miJ11WTA/TOKGcT/K
	sDxOj70lQUyJNr020EwVeIHMC0CqB3QCqM2gn8ZyIg9dny0v/ObK82e+ZfROC9GSIv5
	eMuKMFy3+Xc82K9oDpKB+7JmIOXgBVruDyDGkQVU=
Received: by mx.zohomail.com with SMTPS id 1768647263283562.526183981335;
	Sat, 17 Jan 2026 02:54:23 -0800 (PST)
Date: Sat, 17 Jan 2026 16:24:14 +0530
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, wei.liu@kernel.org, 
	nunodasneves@linux.microsoft.com
Subject: Re: [PATCH v1] mshv: make certain field names descriptive in a
 header struct
Message-ID: <gmcxew57ivvbswtkihzsefts5ipjmmu3vvdkanck5h6bc6rnew@5baafke7brir>
References: <20260112194943.1701785-1-mrathor@linux.microsoft.com>
 <d4iddlkzjapad2xck7oualffcncyyue2hcqa6u7cf7w62llejk@cgjt2fjvbaz6>
 <1ac21e5b-5ff9-0ff9-c886-33997ad3f7da@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ac21e5b-5ff9-0ff9-c886-33997ad3f7da@linux.microsoft.com>
X-ZohoMailClient: External

On Thu, Jan 15, 2026 at 11:03:36AM -0800, Mukesh R wrote:
> On 1/15/26 10:51, Anirudh Rayabharam wrote:
> > On Mon, Jan 12, 2026 at 11:49:43AM -0800, Mukesh Rathor wrote:
> > > When header struct fields use very common names like "pages" or "type",
> > > it makes it difficult to find uses of these fields with tools like grep
> > > and cscope.  Add the prefix mreg_ to some fields in struct
> > > mshv_mem_region to make it easier to find them.
> > > 
> > > There is no functional change.
> > > 
> > > Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> > > ---
> > >   drivers/hv/mshv_regions.c   | 44 ++++++++++++++++++-------------------
> > >   drivers/hv/mshv_root.h      |  6 ++---
> > >   drivers/hv/mshv_root_main.c | 10 ++++-----
> > >   3 files changed, 30 insertions(+), 30 deletions(-)
> > > 
> > > diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> > > index 202b9d551e39..af81405f859b 100644
> > > --- a/drivers/hv/mshv_regions.c
> > > +++ b/drivers/hv/mshv_regions.c
> > > @@ -52,7 +52,7 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
> > >   	struct page *page;
> > >   	int ret;
> > > -	page = region->pages[page_offset];
> > > +	page = region->mreg_pages[page_offset];
> > >   	if (!page)
> > >   		return -EINVAL;
> > > @@ -65,7 +65,7 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
> > >   	/* Start at stride since the first page is validated */
> > >   	for (count = stride; count < page_count; count += stride) {
> > > -		page = region->pages[page_offset + count];
> > > +		page = region->mreg_pages[page_offset + count];
> > >   		/* Break if current page is not present */
> > >   		if (!page)
> > > @@ -117,7 +117,7 @@ static int mshv_region_process_range(struct mshv_mem_region *region,
> > >   	while (page_count) {
> > >   		/* Skip non-present pages */
> > > -		if (!region->pages[page_offset]) {
> > > +		if (!region->mreg_pages[page_offset]) {
> > >   			page_offset++;
> > >   			page_count--;
> > >   			continue;
> > > @@ -164,13 +164,13 @@ static int mshv_region_chunk_share(struct mshv_mem_region *region,
> > >   				   u32 flags,
> > >   				   u64 page_offset, u64 page_count)
> > >   {
> > > -	struct page *page = region->pages[page_offset];
> > > +	struct page *page = region->mreg_pages[page_offset];
> > >   	if (PageHuge(page) || PageTransCompound(page))
> > >   		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
> > >   	return hv_call_modify_spa_host_access(region->partition->pt_id,
> > > -					      region->pages + page_offset,
> > > +					      region->mreg_pages + page_offset,
> > >   					      page_count,
> > >   					      HV_MAP_GPA_READABLE |
> > >   					      HV_MAP_GPA_WRITABLE,
> > > @@ -190,13 +190,13 @@ static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
> > >   				     u32 flags,
> > >   				     u64 page_offset, u64 page_count)
> > >   {
> > > -	struct page *page = region->pages[page_offset];
> > > +	struct page *page = region->mreg_pages[page_offset];
> > >   	if (PageHuge(page) || PageTransCompound(page))
> > >   		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
> > >   	return hv_call_modify_spa_host_access(region->partition->pt_id,
> > > -					      region->pages + page_offset,
> > > +					      region->mreg_pages + page_offset,
> > >   					      page_count, 0,
> > >   					      flags, false);
> > >   }
> > > @@ -214,7 +214,7 @@ static int mshv_region_chunk_remap(struct mshv_mem_region *region,
> > >   				   u32 flags,
> > >   				   u64 page_offset, u64 page_count)
> > >   {
> > > -	struct page *page = region->pages[page_offset];
> > > +	struct page *page = region->mreg_pages[page_offset];
> > >   	if (PageHuge(page) || PageTransCompound(page))
> > >   		flags |= HV_MAP_GPA_LARGE_PAGE;
> > > @@ -222,7 +222,7 @@ static int mshv_region_chunk_remap(struct mshv_mem_region *region,
> > >   	return hv_call_map_gpa_pages(region->partition->pt_id,
> > >   				     region->start_gfn + page_offset,
> > >   				     page_count, flags,
> > > -				     region->pages + page_offset);
> > > +				     region->mreg_pages + page_offset);
> > >   }
> > >   static int mshv_region_remap_pages(struct mshv_mem_region *region,
> > > @@ -245,10 +245,10 @@ int mshv_region_map(struct mshv_mem_region *region)
> > >   static void mshv_region_invalidate_pages(struct mshv_mem_region *region,
> > >   					 u64 page_offset, u64 page_count)
> > >   {
> > > -	if (region->type == MSHV_REGION_TYPE_MEM_PINNED)
> > > -		unpin_user_pages(region->pages + page_offset, page_count);
> > > +	if (region->mreg_type == MSHV_REGION_TYPE_MEM_PINNED)
> > > +		unpin_user_pages(region->mreg_pages + page_offset, page_count);
> > > -	memset(region->pages + page_offset, 0,
> > > +	memset(region->mreg_pages + page_offset, 0,
> > >   	       page_count * sizeof(struct page *));
> > >   }
> > > @@ -265,7 +265,7 @@ int mshv_region_pin(struct mshv_mem_region *region)
> > >   	int ret;
> > >   	for (done_count = 0; done_count < region->nr_pages; done_count += ret) {
> > > -		pages = region->pages + done_count;
> > > +		pages = region->mreg_pages + done_count;
> > >   		userspace_addr = region->start_uaddr +
> > >   				 done_count * HV_HYP_PAGE_SIZE;
> > >   		nr_pages = min(region->nr_pages - done_count,
> > > @@ -297,7 +297,7 @@ static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
> > >   				   u32 flags,
> > >   				   u64 page_offset, u64 page_count)
> > >   {
> > > -	struct page *page = region->pages[page_offset];
> > > +	struct page *page = region->mreg_pages[page_offset];
> > >   	if (PageHuge(page) || PageTransCompound(page))
> > >   		flags |= HV_UNMAP_GPA_LARGE_PAGE;
> > > @@ -321,7 +321,7 @@ static void mshv_region_destroy(struct kref *ref)
> > >   	struct mshv_partition *partition = region->partition;
> > >   	int ret;
> > > -	if (region->type == MSHV_REGION_TYPE_MEM_MOVABLE)
> > > +	if (region->mreg_type == MSHV_REGION_TYPE_MEM_MOVABLE)
> > >   		mshv_region_movable_fini(region);
> > >   	if (mshv_partition_encrypted(partition)) {
> > > @@ -374,9 +374,9 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
> > >   	int ret;
> > >   	range->notifier_seq = mmu_interval_read_begin(range->notifier);
> > > -	mmap_read_lock(region->mni.mm);
> > > +	mmap_read_lock(region->mreg_mni.mm);
> > >   	ret = hmm_range_fault(range);
> > > -	mmap_read_unlock(region->mni.mm);
> > > +	mmap_read_unlock(region->mreg_mni.mm);
> > >   	if (ret)
> > >   		return ret;
> > > @@ -407,7 +407,7 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
> > >   				   u64 page_offset, u64 page_count)
> > >   {
> > >   	struct hmm_range range = {
> > > -		.notifier = &region->mni,
> > > +		.notifier = &region->mreg_mni,
> > >   		.default_flags = HMM_PFN_REQ_FAULT | HMM_PFN_REQ_WRITE,
> > >   	};
> > >   	unsigned long *pfns;
> > > @@ -430,7 +430,7 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
> > >   		goto out;
> > >   	for (i = 0; i < page_count; i++)
> > > -		region->pages[page_offset + i] = hmm_pfn_to_page(pfns[i]);
> > > +		region->mreg_pages[page_offset + i] = hmm_pfn_to_page(pfns[i]);
> > >   	ret = mshv_region_remap_pages(region, region->hv_map_flags,
> > >   				      page_offset, page_count);
> > > @@ -489,7 +489,7 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
> > >   {
> > >   	struct mshv_mem_region *region = container_of(mni,
> > >   						      struct mshv_mem_region,
> > > -						      mni);
> > > +						      mreg_mni);
> > >   	u64 page_offset, page_count;
> > >   	unsigned long mstart, mend;
> > >   	int ret = -EPERM;
> > > @@ -535,14 +535,14 @@ static const struct mmu_interval_notifier_ops mshv_region_mni_ops = {
> > >   void mshv_region_movable_fini(struct mshv_mem_region *region)
> > >   {
> > > -	mmu_interval_notifier_remove(&region->mni);
> > > +	mmu_interval_notifier_remove(&region->mreg_mni);
> > >   }
> > >   bool mshv_region_movable_init(struct mshv_mem_region *region)
> > >   {
> > >   	int ret;
> > > -	ret = mmu_interval_notifier_insert(&region->mni, current->mm,
> > > +	ret = mmu_interval_notifier_insert(&region->mreg_mni, current->mm,
> > >   					   region->start_uaddr,
> > >   					   region->nr_pages << HV_HYP_PAGE_SHIFT,
> > >   					   &mshv_region_mni_ops);
> > > diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> > > index 3c1d88b36741..f5b6d3979e5a 100644
> > > --- a/drivers/hv/mshv_root.h
> > > +++ b/drivers/hv/mshv_root.h
> > > @@ -85,10 +85,10 @@ struct mshv_mem_region {
> > >   	u64 start_uaddr;
> > >   	u32 hv_map_flags;
> > >   	struct mshv_partition *partition;
> > > -	enum mshv_region_type type;
> > > -	struct mmu_interval_notifier mni;
> > > +	enum mshv_region_type mreg_type;
> > > +	struct mmu_interval_notifier mreg_mni;
> > >   	struct mutex mutex;	/* protects region pages remapping */
> > > -	struct page *pages[];
> > > +	struct page *mreg_pages[];
> > >   };
> > >   struct mshv_irq_ack_notifier {
> > > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > > index 1134a82c7881..eff1b21461dc 100644
> > > --- a/drivers/hv/mshv_root_main.c
> > > +++ b/drivers/hv/mshv_root_main.c
> > > @@ -657,7 +657,7 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
> > >   		return false;
> > >   	/* Only movable memory ranges are supported for GPA intercepts */
> > > -	if (region->type == MSHV_REGION_TYPE_MEM_MOVABLE)
> > > +	if (region->mreg_type == MSHV_REGION_TYPE_MEM_MOVABLE)
> > >   		ret = mshv_region_handle_gfn_fault(region, gfn);
> > >   	else
> > >   		ret = false;
> > > @@ -1175,12 +1175,12 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
> > >   		return PTR_ERR(rg);
> > >   	if (is_mmio)
> > > -		rg->type = MSHV_REGION_TYPE_MMIO;
> > > +		rg->mreg_type = MSHV_REGION_TYPE_MMIO;
> > >   	else if (mshv_partition_encrypted(partition) ||
> > >   		 !mshv_region_movable_init(rg))
> > > -		rg->type = MSHV_REGION_TYPE_MEM_PINNED;
> > > +		rg->mreg_type = MSHV_REGION_TYPE_MEM_PINNED;
> > >   	else
> > > -		rg->type = MSHV_REGION_TYPE_MEM_MOVABLE;
> > > +		rg->mreg_type = MSHV_REGION_TYPE_MEM_MOVABLE;
> > >   	rg->partition = partition;
> > > @@ -1297,7 +1297,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
> > >   	if (ret)
> > >   		return ret;
> > > -	switch (region->type) {
> > > +	switch (region->mreg_type) {
> > >   	case MSHV_REGION_TYPE_MEM_PINNED:
> > >   		ret = mshv_prepare_pinned_region(region);
> > >   		break;
> > > -- 
> > > 2.51.2.vfs.0.1
> > > 
> > 
> > TBH, all these new names look ugly to me. Moreover, they are redundant.
> > For example, region->type makes it clear that we're talking about the
> > type *of a region*. Calling it mreg_type adds no additional semantic
> > information; it's just visual noise.
> > 
> > Coming to the part about finding it via grep/cscope. You could have
> > easily found these reference by searching for "region->type",
> > "region->mni" etc. Perhaps we can change the variable naming convention
> > i.e. call a struct mshv_mem_region "mreg" everywhere and then one could
> > grep for "mreg->mni" and so on. Also, using more powerful tools such as
> > LSPs (clangd) can help find references more easily without tripping up
> > on common terms like "type", "pages" etc.
> 
> Huh! There is no way to enforce that one use ptrs with only certain names,
> and that is unreasonable requirement. What if the field is accessed by
> struct.field reference? Are you suggesting that struct naming be enforced?
> Ability to read code is far far more important to make sure bug free code
> is written, it is a very small price for a large benefit. One gets used to
> it so easily. Why do we prefix function names with mshv_ or hv_, should

We prefix function names with mshv_ or hv_ for namespacing. It indicates
that those functions belong to the respective subsystem/module. There is
no need for such prefixes for these struct fields because they are
already namespaced inside struct mshv_mem_region.

> we get rid of that also? And it's not just cscope or grep, sometimes
> you're dealing with corrupt binary or coredump and you use "strings"

Dealing with currupt binaries/coredumps sounds like a far-fetched
usecase. Does it really makes sense to gear our code towards that?

> to get some meaning out of it. So I totally disagree with you. If you
> don't like mreg_, please suggest alternates that are easy to find.

My point was that there is no need for a prefix in the first place.

Thanks,
Anirudh.

