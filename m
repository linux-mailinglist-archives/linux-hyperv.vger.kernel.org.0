Return-Path: <linux-hyperv+bounces-8399-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCq1L6kxcGkSXAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8399-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 02:53:45 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F83A4F632
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 02:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA93A7E59D7
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 01:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8415320382;
	Wed, 21 Jan 2026 01:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IbluBz1J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F3F321F5E;
	Wed, 21 Jan 2026 01:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768960420; cv=none; b=AK6xRfCWIf+vb3RJvdN5jFWCe3iV+8CQxT5QztvWEVSqi9jSdPxYr9y49ooMHcfFnIKsnTdcVKdl81Hjq+VkKnQecCwbqtsuOVmtx0RkSeYiPSSW4pN3/QluoQdFDO8ie4Ng26bOfJJB6F/U6SbyTmAhA80Pzld72YgrXWk9uTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768960420; c=relaxed/simple;
	bh=GWd3kE5nzbALiYd9w/RRKzSE7RaI32EBz0diWTgONxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7IoqbaMMfech09OTtsoECUmhPMME/dQpHQTKjewK6UXIrR05KXC1oHezrQT38t3iCSM//aMDniag5NRTlccYv9x26RCmIEw/vSm+6G7ZHWHTtZeSkyrxCFMXCs5i9yd3aDueBhu+7uZTSa4GCtb9mfaySEahDH3RWhkLHwFH3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IbluBz1J; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 916ED20B7167;
	Tue, 20 Jan 2026 17:53:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 916ED20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768960411;
	bh=Ymw6zhgGVeFVyXTu0csGpSjrM5/LURY8dThwT1pHr1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IbluBz1JLfnfdfGrhKQDQkff+no9Xt61GmK/MxRcADLiMlxt2AFu4VsDIxwK/r8KE
	 1M36jL8WfIMUbzlGyoMAAOTNsz1rZ2bN/HcHJMHK30JunRpnZLI6AxGsKP7ofA5SNG
	 prJ3EYaLv9L0r0x5imz0gAe5MPs+pN/qtNn09OHE=
Date: Tue, 20 Jan 2026 17:53:29 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, catalin.marinas@arm.com,
	will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	nunodasneves@linux.microsoft.com, mhklinux@outlook.com,
	romank@linux.microsoft.com
Subject: Re: [PATCH v0 15/15] mshv: Populate mmio mappings for PCI passthru
Message-ID: <aXAxmYm4zbOzGztz@skinsburskii.localdomain>
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-16-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120064230.3602565-16-mrathor@linux.microsoft.com>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,linux.microsoft.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-8399-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.microsoft.com,none];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii.localdomain:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 2F83A4F632
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 10:42:30PM -0800, Mukesh R wrote:
> From: Mukesh Rathor <mrathor@linux.microsoft.com>
> 
> Upon guest access, in case of missing mmio mapping, the hypervisor
> generates an unmapped gpa intercept. In this path, lookup the PCI
> resource pfn for the guest gpa, and ask the hypervisor to map it
> via hypercall. The PCI resource pfn is maintained by the VFIO driver,
> and obtained via fixup_user_fault call (similar to KVM).
> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c | 115 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 03f3aa9f5541..4c8bc7cd0888 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -56,6 +56,14 @@ struct hv_stats_page {
>  	};
>  } __packed;
>  
> +bool hv_nofull_mmio;   /* don't map entire mmio region upon fault */
> +static int __init setup_hv_full_mmio(char *str)
> +{
> +	hv_nofull_mmio = true;
> +	return 0;
> +}
> +__setup("hv_nofull_mmio", setup_hv_full_mmio);
> +
>  struct mshv_root mshv_root;
>  
>  enum hv_scheduler_type hv_scheduler_type;
> @@ -612,6 +620,109 @@ mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
>  }
>  
>  #ifdef CONFIG_X86_64
> +
> +/*
> + * Check if uaddr is for mmio range. If yes, return 0 with mmio_pfn filled in
> + * else just return -errno.
> + */
> +static int mshv_chk_get_mmio_start_pfn(struct mshv_partition *pt, u64 gfn,
> +				       u64 *mmio_pfnp)
> +{
> +	struct vm_area_struct *vma;
> +	bool is_mmio;
> +	u64 uaddr;
> +	struct mshv_mem_region *mreg;
> +	struct follow_pfnmap_args pfnmap_args;
> +	int rc = -EINVAL;
> +
> +	/*
> +	 * Do not allow mem region to be deleted beneath us. VFIO uses
> +	 * useraddr vma to lookup pci bar pfn.
> +	 */
> +	spin_lock(&pt->pt_mem_regions_lock);
> +
> +	/* Get the region again under the lock */
> +	mreg = mshv_partition_region_by_gfn(pt, gfn);
> +	if (mreg == NULL || mreg->type != MSHV_REGION_TYPE_MMIO)
> +		goto unlock_pt_out;
> +
> +	uaddr = mreg->start_uaddr +
> +		((gfn - mreg->start_gfn) << HV_HYP_PAGE_SHIFT);
> +
> +	mmap_read_lock(current->mm);

Semaphore can't be taken under spinlock.
Get it instead.

> +	vma = vma_lookup(current->mm, uaddr);
> +	is_mmio = vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;

Why this check is needed again?
The region type is stored on the region itself.
And the type is checked on the caller side.

> +	if (!is_mmio)
> +		goto unlock_mmap_out;
> +
> +	pfnmap_args.vma = vma;
> +	pfnmap_args.address = uaddr;
> +
> +	rc = follow_pfnmap_start(&pfnmap_args);
> +	if (rc) {
> +		rc = fixup_user_fault(current->mm, uaddr, FAULT_FLAG_WRITE,
> +				      NULL);
> +		if (rc)
> +			goto unlock_mmap_out;
> +
> +		rc = follow_pfnmap_start(&pfnmap_args);
> +		if (rc)
> +			goto unlock_mmap_out;
> +	}
> +
> +	*mmio_pfnp = pfnmap_args.pfn;
> +	follow_pfnmap_end(&pfnmap_args);
> +
> +unlock_mmap_out:
> +	mmap_read_unlock(current->mm);
> +unlock_pt_out:
> +	spin_unlock(&pt->pt_mem_regions_lock);
> +	return rc;
> +}
> +
> +/*
> + * At present, the only unmapped gpa is mmio space. Verify if it's mmio
> + * and resolve if possible.
> + * Returns: True if valid mmio intercept and it was handled, else false
> + */
> +static bool mshv_handle_unmapped_gpa(struct mshv_vp *vp)
> +{
> +	struct hv_message *hvmsg = vp->vp_intercept_msg_page;
> +	struct hv_x64_memory_intercept_message *msg;
> +	union hv_x64_memory_access_info accinfo;
> +	u64 gfn, mmio_spa, numpgs;
> +	struct mshv_mem_region *mreg;
> +	int rc;
> +	struct mshv_partition *pt = vp->vp_partition;
> +
> +	msg = (struct hv_x64_memory_intercept_message *)hvmsg->u.payload;
> +	accinfo = msg->memory_access_info;
> +
> +	if (!accinfo.gva_gpa_valid)
> +		return false;
> +
> +	/* Do a fast check and bail if non mmio intercept */
> +	gfn = msg->guest_physical_address >> HV_HYP_PAGE_SHIFT;
> +	mreg = mshv_partition_region_by_gfn(pt, gfn);

This call needs to be protected by the spinlock.

Thanks,
Stanislav 

> +	if (mreg == NULL || mreg->type != MSHV_REGION_TYPE_MMIO)
> +		return false;
> +
> +	rc = mshv_chk_get_mmio_start_pfn(pt, gfn, &mmio_spa);
> +	if (rc)
> +		return false;
> +
> +	if (!hv_nofull_mmio) {		/* default case */
> +		gfn = mreg->start_gfn;
> +		mmio_spa = mmio_spa - (gfn - mreg->start_gfn);
> +		numpgs = mreg->nr_pages;
> +	} else
> +		numpgs = 1;
> +
> +	rc = hv_call_map_mmio_pages(pt->pt_id, gfn, mmio_spa, numpgs);
> +
> +	return rc == 0;
> +}
> +
>  static struct mshv_mem_region *
>  mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
>  {
> @@ -666,13 +777,17 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
>  
>  	return ret;
>  }
> +
>  #else  /* CONFIG_X86_64 */
> +static bool mshv_handle_unmapped_gpa(struct mshv_vp *vp) { return false; }
>  static bool mshv_handle_gpa_intercept(struct mshv_vp *vp) { return false; }
>  #endif /* CONFIG_X86_64 */
>  
>  static bool mshv_vp_handle_intercept(struct mshv_vp *vp)
>  {
>  	switch (vp->vp_intercept_msg_page->header.message_type) {
> +	case HVMSG_UNMAPPED_GPA:
> +		return mshv_handle_unmapped_gpa(vp);
>  	case HVMSG_GPA_INTERCEPT:
>  		return mshv_handle_gpa_intercept(vp);
>  	}
> -- 
> 2.51.2.vfs.0.1
> 

