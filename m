Return-Path: <linux-hyperv+bounces-7966-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EEECA5754
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Dec 2025 22:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A938307ECD8
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Dec 2025 21:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21562D8DB9;
	Thu,  4 Dec 2025 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EGDjRyqm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF681B78F3;
	Thu,  4 Dec 2025 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764883395; cv=none; b=ZuRH0urGSe71cH1KUPEEIoOKy8pcz78JcY0uMKIJAbTXo9lZylCtQFuw9SUX6llTmNNNxMdJzXLmp8HX4tHFluqIsJRlEF3WKJ2BuqV8AX5IABlnGzGfqWjKco5Knui1osd4iAlq6wW3S7DCW5+B0tfggw0pfPxaNa0HIPJWUW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764883395; c=relaxed/simple;
	bh=w6+65Ppeing911flzoZaMW7YfUC2dL/8vZQo7QQOIqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLA9PAit44Y7L9b+mg6spL72JPQ0PPvkuuZGw8ALowLmC6qpLPaV7jFqE46Iq2X4e1LnY4Ctdiv1XBKUcqT6Ih86JjgMJXz1ClcLHjBRvURtXN06TXjbk3x5KgYewjh4fl24gSOYDkMcP6faaABEuLxaxjC+nudR/VlQarvtwRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EGDjRyqm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id 085532120EBE;
	Thu,  4 Dec 2025 13:23:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 085532120EBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764883393;
	bh=G/fkHsg2s4C2BTjb5jweCQFCBIzcnjCtp6oWkXTp/zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EGDjRyqmVX+t+9ghpc27+MdhDgujvzQgxsPrfXnPyir68apg52cxBSP+tqflNxPpH
	 87MOuRjDMHuUSvVHpe5jyFAm9FU8TgZ7fNY+PH+PBSfg5N2OeJyEEvYG/2N4QMHFmR
	 fFrn7LsEt98kGuvnRhPH7JtHiE8Rl9zAyW7Mc9lo=
Date: Thu, 4 Dec 2025 13:23:11 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 6/7] Drivers: hv: Add refcount and locking to mem
 regions
Message-ID: <aTH7v2XbEpps68WH@skinsburskii.localdomain>
References: <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176412296278.447063.4767524278636692490.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157553798D947A4B205AEF7D4A6A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB4157553798D947A4B205AEF7D4A6A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Thu, Dec 04, 2025 at 04:48:01PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tuesday, November 25, 2025 6:09 PM
> > 
> > Introduce kref-based reference counting and spinlock protection for
> > memory regions in Hyper-V partition management. This change improves
> > memory region lifecycle management and ensures thread-safe access to the
> > region list.
> > 
> > Also improves the check for overlapped memory regions during region
> > creation, preventing duplicate or conflicting mappings.
> 
> This paragraph seems spurious. I think it applies to what's in Patch 5 of this
> series.
> 

Indeed,this chunk escaped cleanup after refactoring.

> > 
> > Previously, the regions list was protected by the partition mutex.
> > However, this approach is too heavy for frequent fault and invalidation
> > operations. Finer grained locking is now used to improve efficiency and
> > concurrency.
> > 
> > This is a precursor to supporting movable memory regions. Fault and
> > invalidation handling for movable regions will require safe traversal of
> > the region list and holding a region reference while performing
> > invalidation or fault operations.
> 
> The commit message discussion about the need for the refcounting and
> locking seemed a bit vague to me. It wasn't entirely clear whether these
> changes are bug fixing existing race conditions, or whether they are new
> functionality to support movable regions.
> 
> In looking at the existing code, it seems that the main serialization mechanisms
> are that partition ioctls are serialized on pt_mutex, and VP ioctls are serialized
> on vp_mutex (though multiple VP ioctls can be in progress simultaneously
> against different VPs). The serialization of partition ioctls ensures that region
> manipulation is serialized, and that, for example, two region creations can't
> both verify that there's no overlap, but then overlap with each other. And
> region creation and deletion are serialized. In current code, the VP ioctls don't
> look at the region data structures, so there can't be any races between
> partition and VP ioctls (which are not serialized with each other). The only
> question I had about existing code is the mshv_partition_release() function,
> which proceeds without serializing against any partition ioctls, but maybe
> higher-level file system code ensures that no ioctls are in progress before
> the .release callback is made.
> 
> The new requirement is movable regions, where the VP ioctl MSHV_RUN_VP
> needs to look at region data structures. You've said that in the last paragraph
> of your commit message. So I'm reading this as that the new locking is
> needed specifically because multiple MSHV_RUN_VP ioctls will likely be
> in flight simultaneously, and they are not currently serialized with the
> region operations initiated by partition ioctls. And then there are the
> "invalidate" callbacks that are running on some other kernel thread and
> which also needs synchronization to do region manipulation.
> 
> Maybe I'm just looking for a little bit of a written "road map" somewhere
> that describes the intended locking scheme at a high level. :-)
> 
> Michael
> 

You understand this correctly.

In short, there were only two concurrent operations on regions before
movable pages were introduced: addition and removal. Both could happen
only via the partition ioctl, which is serialized by the partition
mutex, so everything was simple.

With the introduction of movable pages, regions — both the list of
regions and the region contents themselves — are accessed by partition
VP threads, which do not hold the partition mutex. While access to
region contents is protected by a per-region mutex, nothing prevents the
VMM from removing and destroying a region from underneath a VP thread
that is currently servicing a page fault or invalidation. This, in turn,
leads to a general protection fault.

This commit solves the issue by making the region a reference-counted
object so it persists while being serviced, and by adding a spinlock to
protect list traversal.

Thanks, Stanislav

> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_regions.c   |   19 ++++++++++++++++---
> >  drivers/hv/mshv_root.h      |    6 +++++-
> >  drivers/hv/mshv_root_main.c |   34 ++++++++++++++++++++++++++--------
> >  3 files changed, 47 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> > index d535d2e3e811..6450a7ed8493 100644
> > --- a/drivers/hv/mshv_regions.c
> > +++ b/drivers/hv/mshv_regions.c
> > @@ -7,6 +7,7 @@
> >   * Authors: Microsoft Linux virtualization team
> >   */
> > 
> > +#include <linux/kref.h>
> >  #include <linux/mm.h>
> >  #include <linux/vmalloc.h>
> > 
> > @@ -154,6 +155,8 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
> >  	if (!is_mmio)
> >  		region->flags.range_pinned = true;
> > 
> > +	kref_init(&region->refcount);
> > +
> >  	return region;
> >  }
> > 
> > @@ -303,13 +306,13 @@ static int mshv_region_unmap(struct mshv_mem_region *region)
> >  					 mshv_region_chunk_unmap);
> >  }
> > 
> > -void mshv_region_destroy(struct mshv_mem_region *region)
> > +static void mshv_region_destroy(struct kref *ref)
> >  {
> > +	struct mshv_mem_region *region =
> > +		container_of(ref, struct mshv_mem_region, refcount);
> >  	struct mshv_partition *partition = region->partition;
> >  	int ret;
> > 
> > -	hlist_del(&region->hnode);
> > -
> >  	if (mshv_partition_encrypted(partition)) {
> >  		ret = mshv_region_share(region);
> >  		if (ret) {
> > @@ -326,3 +329,13 @@ void mshv_region_destroy(struct mshv_mem_region *region)
> > 
> >  	vfree(region);
> >  }
> > +
> > +void mshv_region_put(struct mshv_mem_region *region)
> > +{
> > +	kref_put(&region->refcount, mshv_region_destroy);
> > +}
> > +
> > +int mshv_region_get(struct mshv_mem_region *region)
> > +{
> > +	return kref_get_unless_zero(&region->refcount);
> > +}
> > diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> > index ff3374f13691..4249534ba900 100644
> > --- a/drivers/hv/mshv_root.h
> > +++ b/drivers/hv/mshv_root.h
> > @@ -72,6 +72,7 @@ do { \
> > 
> >  struct mshv_mem_region {
> >  	struct hlist_node hnode;
> > +	struct kref refcount;
> >  	u64 nr_pages;
> >  	u64 start_gfn;
> >  	u64 start_uaddr;
> > @@ -97,6 +98,8 @@ struct mshv_partition {
> >  	u64 pt_id;
> >  	refcount_t pt_ref_count;
> >  	struct mutex pt_mutex;
> > +
> > +	spinlock_t pt_mem_regions_lock;
> >  	struct hlist_head pt_mem_regions; // not ordered
> > 
> >  	u32 pt_vp_count;
> > @@ -319,6 +322,7 @@ int mshv_region_unshare(struct mshv_mem_region *region);
> >  int mshv_region_map(struct mshv_mem_region *region);
> >  void mshv_region_invalidate(struct mshv_mem_region *region);
> >  int mshv_region_pin(struct mshv_mem_region *region);
> > -void mshv_region_destroy(struct mshv_mem_region *region);
> > +void mshv_region_put(struct mshv_mem_region *region);
> > +int mshv_region_get(struct mshv_mem_region *region);
> > 
> >  #endif /* _MSHV_ROOT_H_ */
> > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > index ae600b927f49..1ef2a28beb17 100644
> > --- a/drivers/hv/mshv_root_main.c
> > +++ b/drivers/hv/mshv_root_main.c
> > @@ -1086,9 +1086,13 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
> >  	u64 nr_pages = HVPFN_DOWN(mem->size);
> > 
> >  	/* Reject overlapping regions */
> > +	spin_lock(&partition->pt_mem_regions_lock);
> >  	if (mshv_partition_region_by_gfn(partition, mem->guest_pfn) ||
> > -	    mshv_partition_region_by_gfn(partition, mem->guest_pfn + nr_pages - 1))
> > +	    mshv_partition_region_by_gfn(partition, mem->guest_pfn + nr_pages - 1)) {
> > +		spin_unlock(&partition->pt_mem_regions_lock);
> >  		return -EEXIST;
> > +	}
> > +	spin_unlock(&partition->pt_mem_regions_lock);
> > 
> >  	rg = mshv_region_create(mem->guest_pfn, nr_pages,
> >  				mem->userspace_addr, mem->flags,
> > @@ -1220,8 +1224,9 @@ mshv_map_user_memory(struct mshv_partition *partition,
> >  	if (ret)
> >  		goto errout;
> > 
> > -	/* Install the new region */
> > +	spin_lock(&partition->pt_mem_regions_lock);
> >  	hlist_add_head(&region->hnode, &partition->pt_mem_regions);
> > +	spin_unlock(&partition->pt_mem_regions_lock);
> > 
> >  	return 0;
> > 
> > @@ -1240,17 +1245,27 @@ mshv_unmap_user_memory(struct mshv_partition *partition,
> >  	if (!(mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP)))
> >  		return -EINVAL;
> > 
> > +	spin_lock(&partition->pt_mem_regions_lock);
> > +
> >  	region = mshv_partition_region_by_gfn(partition, mem.guest_pfn);
> > -	if (!region)
> > -		return -EINVAL;
> > +	if (!region) {
> > +		spin_unlock(&partition->pt_mem_regions_lock);
> > +		return -ENOENT;
> > +	}
> > 
> >  	/* Paranoia check */
> >  	if (region->start_uaddr != mem.userspace_addr ||
> >  	    region->start_gfn != mem.guest_pfn ||
> > -	    region->nr_pages != HVPFN_DOWN(mem.size))
> > +	    region->nr_pages != HVPFN_DOWN(mem.size)) {
> > +		spin_unlock(&partition->pt_mem_regions_lock);
> >  		return -EINVAL;
> > +	}
> > +
> > +	hlist_del(&region->hnode);
> > 
> > -	mshv_region_destroy(region);
> > +	spin_unlock(&partition->pt_mem_regions_lock);
> > +
> > +	mshv_region_put(region);
> > 
> >  	return 0;
> >  }
> > @@ -1653,8 +1668,10 @@ static void destroy_partition(struct mshv_partition *partition)
> >  	remove_partition(partition);
> > 
> >  	hlist_for_each_entry_safe(region, n, &partition->pt_mem_regions,
> > -				  hnode)
> > -		mshv_region_destroy(region);
> > +				  hnode) {
> > +		hlist_del(&region->hnode);
> > +		mshv_region_put(region);
> > +	}
> > 
> >  	/* Withdraw and free all pages we deposited */
> >  	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->pt_id);
> > @@ -1852,6 +1869,7 @@ mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
> > 
> >  	INIT_HLIST_HEAD(&partition->pt_devices);
> > 
> > +	spin_lock_init(&partition->pt_mem_regions_lock);
> >  	INIT_HLIST_HEAD(&partition->pt_mem_regions);
> > 
> >  	mshv_eventfd_init(partition);
> > 
> > 
> 

