Return-Path: <linux-hyperv+bounces-10524-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEKLFcxq82lf2gEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10524-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 16:44:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD60E4A432E
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 16:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6083630515E5
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 14:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B21D42EEA6;
	Thu, 30 Apr 2026 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Iv84x6cp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D60B42E013;
	Thu, 30 Apr 2026 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560189; cv=none; b=ZiMrqcnEmVO5vdD0MLgaqIcWJTbfrKNcMJgiyGtAHfLfnjlpfPZc+XRD51JcqyY61PAa3htbGDDmHXsVBiHHuwv6xSEou/aYcBcOCuYBoDtEKkTE1K2dqgGozXzgMrE8magdQSz17IDPwnaO3OTkbkccu0golKpv8NXDJBVpkuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560189; c=relaxed/simple;
	bh=TgQ+8B0EQItchvW3mww44hNv34hBdvXfyuGMdfZPV1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPdKvFI5O6Q/3CqmSAESbBnaKqepTh5IftE42m/g3898ZLG4xB1NuVvGU7BybJol5I5veYSNjrcoaGICzwySb48ukS5dMtQI3aQ6WRIZdhVwZaCzxiky5n3/smABv3LB3ngK9flSXrrHJt5+4cGkFZBRwGrW1S6cDd5z2D+qWGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Iv84x6cp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3BFA020B7175;
	Thu, 30 Apr 2026 07:43:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3BFA020B7175
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777560187;
	bh=sRa5PAsDpja/M7JrLAVV6AOmTtwR2FeCnccsrJc5s2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iv84x6cpaQigON5OukTX4vt/5pDuLJ8CCC5U5gLK0XNgOyaeYCTC00QEb3tLjbh6i
	 1I5lFFhJ7VWmYrXMfhMNDLQwzYXssXs8iF1N8ulERi1juEg/VyjtgqCq1++8/bTsVt
	 +1z5lXYtZs4X0ED+sezumh1NQCDgApzND61gb7NI=
Date: Thu, 30 Apr 2026 07:43:05 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mshv: Simplify GPA map/unmap hypercall helpers
Message-ID: <afNqeSpaN9ME9llk@skinsburskii.localdomain>
References: <177748126383.33250.14844440376241852870.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <61e5d806-b5d5-ab2c-0e09-6def449d5582@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61e5d806-b5d5-ab2c-0e09-6def449d5582@linux.microsoft.com>
X-Rspamd-Queue-Id: AD60E4A432E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10524-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii.localdomain:mid,linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 07:06:08PM -0700, Mukesh R wrote:
> 
> On 4/29/26 09:48, Stanislav Kinsburskii wrote:
> > Clean up hv_do_map_gpa_hcall() and hv_call_unmap_gpa_pages() after the
> > preceding bug-fix patches:
> > 
> > Move "done += completed" before the status checks so that pages mapped
> > by a partially-successful batch are included in the error cleanup unmap.
> > Previously these mappings were leaked on failure.
> > 
> > While here, improve type safety and readability:
> >   - Change "int done" to "u64 done" to match the u64 page_count it is
> >     compared against, avoiding signed/unsigned comparison hazards.
> >   - Use u64 for loop iteration and batch size variables consistently.
> >   - Add proper braces to the for-loop body in hv_do_map_gpa_hcall().
> >   - Remove unnecessary "ret" variable from hv_call_unmap_gpa_pages().
> >   - Simplify the error-path unmap to use "done << large_shift" directly
> >     instead of mutating done in place.
> > 
> 
> what changed in V2?
> 

No functional changes: "min" was replaced with "min_t" (reported by
checkpatch.pl).

> > Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >   drivers/hv/mshv_root_hv_call.c |   55 +++++++++++++++-------------------------
> >   1 file changed, 20 insertions(+), 35 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> > index e5992c324904a..1f19a4ca824f0 100644
> > --- a/drivers/hv/mshv_root_hv_call.c
> > +++ b/drivers/hv/mshv_root_hv_call.c
> > @@ -195,8 +195,8 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
> >   	struct hv_input_map_gpa_pages *input_page;
> >   	u64 status, *pfnlist;
> >   	unsigned long irq_flags, large_shift = 0;
> > -	int ret = 0, done = 0;
> > -	u64 page_count = page_struct_count;
> > +	u64 done = 0, page_count = page_struct_count;
> > +	int ret = 0;
> >   	if (page_count == 0 || (pages && mmio_spa))
> >   		return -EINVAL;
> > @@ -213,8 +213,8 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
> >   	}
> >   	while (done < page_count) {
> > -		ulong i, completed, remain = page_count - done;
> > -		int rep_count = min(remain, HV_MAP_GPA_BATCH_SIZE);
> > +		u64 i, completed, remain = page_count - done;
> > +		u64 rep_count = min_t(u64, remain, HV_MAP_GPA_BATCH_SIZE);
> >   		local_irq_save(irq_flags);
> >   		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > @@ -224,23 +224,13 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
> >   		input_page->map_flags = flags;
> >   		pfnlist = input_page->source_gpa_page_list;
> > -		for (i = 0; i < rep_count; i++)
> > -			if (flags & HV_MAP_GPA_NO_ACCESS) {
> > +		for (i = 0; i < rep_count; i++) {
> > +			if (flags & HV_MAP_GPA_NO_ACCESS)
> >   				pfnlist[i] = 0;
> > -			} else if (pages) {
> > -				u64 index = (done + i) << large_shift;
> > -
> > -				if (index >= page_struct_count) {
> > -					ret = -EINVAL;
> > -					break;
> > -				}
> > -				pfnlist[i] = page_to_pfn(pages[index]);
> > -			} else {
> > +			else if (pages)
> > +				pfnlist[i] = page_to_pfn(pages[(done + i) << large_shift]);
> 
> Entire file is 80 cols, please don't cause this one overflow.
> 

Sure. I'll update.

Thanks,
Stanislav

> Thanks,
> -Mukesh
> 
> 
> > +			else
> >   				pfnlist[i] = mmio_spa + done + i;
> > -			}
> > -		if (ret) {
> > -			local_irq_restore(irq_flags);
> > -			break;
> >   		}
> >   		status = hv_do_rep_hypercall(HVCALL_MAP_GPA_PAGES, rep_count, 0,
> > @@ -248,29 +238,26 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
> >   		local_irq_restore(irq_flags);
> >   		completed = hv_repcomp(status);
> > +		done += completed;
> >   		if (hv_result_needs_memory(status)) {
> >   			ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
> >   						    HV_MAP_GPA_DEPOSIT_PAGES);
> >   			if (ret)
> >   				break;
> > -
> >   		} else if (!hv_result_success(status)) {
> >   			ret = hv_result_to_errno(status);
> >   			break;
> >   		}
> > -
> > -		done += completed;
> >   	}
> >   	if (ret && done) {
> >   		u32 unmap_flags = 0;
> > -		if (flags & HV_MAP_GPA_LARGE_PAGE) {
> > +		if (flags & HV_MAP_GPA_LARGE_PAGE)
> >   			unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
> > -			done <<= large_shift;
> > -		}
> > -		hv_call_unmap_gpa_pages(partition_id, gfn, done, unmap_flags);
> > +		hv_call_unmap_gpa_pages(partition_id, gfn,
> > +					done << large_shift, unmap_flags);
> >   	}
> >   	return ret;
> > @@ -305,7 +292,7 @@ int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k,
> >   	struct hv_input_unmap_gpa_pages *input_page;
> >   	u64 status, page_count = page_count_4k;
> >   	unsigned long irq_flags, large_shift = 0;
> > -	int ret = 0, done = 0;
> > +	u64 done = 0;
> >   	if (page_count == 0)
> >   		return -EINVAL;
> > @@ -319,8 +306,8 @@ int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k,
> >   	}
> >   	while (done < page_count) {
> > -		ulong completed, remain = page_count - done;
> > -		int rep_count = min(remain, HV_UMAP_GPA_PAGES);
> > +		u64 completed, remain = page_count - done;
> > +		u64 rep_count = min_t(u64, remain, HV_UMAP_GPA_PAGES);
> >   		local_irq_save(irq_flags);
> >   		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > @@ -333,15 +320,13 @@ int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k,
> >   		local_irq_restore(irq_flags);
> >   		completed = hv_repcomp(status);
> > -		if (!hv_result_success(status)) {
> > -			ret = hv_result_to_errno(status);
> > -			break;
> > -		}
> > -
> >   		done += completed;
> > +
> > +		if (!hv_result_success(status))
> > +			return hv_result_to_errno(status);
> >   	}
> > -	return ret;
> > +	return 0;
> >   }
> >   int hv_call_get_gpa_access_states(u64 partition_id, u32 count, u64 gpa_base_pfn,
> > 
> > 
> 

