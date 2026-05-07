Return-Path: <linux-hyperv+bounces-10705-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMJgFkL8/GmxVwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10705-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 22:55:30 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E7F4EF045
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 22:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31BE3300B9D2
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2026 20:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B8030C37B;
	Thu,  7 May 2026 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oKEiF13L"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34D32F8E83;
	Thu,  7 May 2026 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778186568; cv=none; b=kS+nvGEyjemw4m2mCr2rhfHjYWHrco/Jf88xttA7uQOw0PlhCGAC58JeXk4x+fZlp9G/9MMidX/gQ3p/gNrcm1XvQZYBiTpWTnWDRTlkBblyw9FFLrOwPdgW2TRIS38b/wYDR3/LJYjyj701kqnFROMZoYx36iHP0+MGDhpIl9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778186568; c=relaxed/simple;
	bh=TO7SFBooMW/ssPvigjMdboOgkHTYyxpZ/swZ0vBSP10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dj8sz5jLIEhUhbVt1z5VGJrcBbCukOubbeBIFXUQBYOE0ja7oJ+iOZLkvqohTRhN9/NEwiIszFRTS8477fj9hmH7mJnLAfFQkJnXJX+WCVnmpc6UBMRXA2gawFCqUp7sbmwOaHLP1JUU6XF/0mpPKFWetrzhmwsvIT/kzbM2iVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oKEiF13L; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8C34D20B7165;
	Thu,  7 May 2026 13:42:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C34D20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778186563;
	bh=pt3kYaySbvd/lhn8Q432LKAHrWXdeOYudeOAaAuyIqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oKEiF13LiMJRb3R5TNNw3XqQ4b7NK3XaMOexYjzehJ545OwVgUbMvUL9Yl/mgWQ8G
	 lkCVIcjVvnwDcDpCRIWT1lqIdRuoW90o165/Qov14oewWjtxJvW23FcCLSfl/J0yuc
	 XLK63aDsxX2EPI11OyM2sZOm5EkPbjfTEW8eibjc=
Date: Thu, 7 May 2026 13:42:45 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mshv: Simplify GPA map/unmap hypercall helpers
Message-ID: <afz5RYJfM_22VZhe@skinsburskii.localdomain>
References: <177756065245.17889.140699174692055235.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157F8C28F454788714CFEF2D43C2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157F8C28F454788714CFEF2D43C2@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: C7E7F4EF045
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
	TAGGED_FROM(0.00)[bounces-10705-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 07:09:13PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > 
> > Clean up hv_do_map_gpa_hcall() and hv_call_unmap_gpa_pages() after the
> > preceding bug-fix patches:
> > 
> > Move "done += completed" before the status checks so that pages mapped
> > by a partially-successful batch are included in the error cleanup unmap.
> > Previously these mappings were leaked on failure.
> > 
> > While here, improve type safety and readability:
> >  - Change "int done" to "u64 done" to match the u64 page_count it is
> >    compared against, avoiding signed/unsigned comparison hazards.
> >  - Use u64 for loop iteration and batch size variables consistently.
> >  - Add proper braces to the for-loop body in hv_do_map_gpa_hcall().
> >  - Remove unnecessary "ret" variable from hv_call_unmap_gpa_pages().
> >  - Simplify the error-path unmap to use "done << large_shift" directly
> >    instead of mutating done in place.
> > 
> > v3: aligned changes by 80 colons
> > v2: replaced min with min_t
> > 
> > Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> 
> Question about "packaging" of this patch. To apply cleanly, it
> needs the previous two fixes applied.  As such, shouldn't it be
> the 3rd patch in patch set that includes the other two?
> 
> Also, there are changes in the previous two fixes that get undone
> or changed by this patch (such as applying large_shift in the error
> path of hv_do_map_gpa_hcall(). With a little more coordination
> between the three patches, there could be less code churn and
> the patches would overall be smaller.
> 

Indeed. I should have done it as a series, but I didn't.
So, to avoid any additonal churn we the reset of the patches coming on
top (a series of fixes), I'd rather keep this one individual.

Thanks,
Stanislav

> Michael
> 
> > ---
> >  drivers/hv/mshv_root_hv_call.c |   56 +++++++++++++++-------------------------
> >  1 file changed, 21 insertions(+), 35 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> > index e5992c324904a..e1f9e28d5a19b 100644
> > --- a/drivers/hv/mshv_root_hv_call.c
> > +++ b/drivers/hv/mshv_root_hv_call.c
> > @@ -195,8 +195,8 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64
> > page_struct_count,
> >  	struct hv_input_map_gpa_pages *input_page;
> >  	u64 status, *pfnlist;
> >  	unsigned long irq_flags, large_shift = 0;
> > -	int ret = 0, done = 0;
> > -	u64 page_count = page_struct_count;
> > +	u64 done = 0, page_count = page_struct_count;
> > +	int ret = 0;
> > 
> >  	if (page_count == 0 || (pages && mmio_spa))
> >  		return -EINVAL;
> > @@ -213,8 +213,8 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64
> > page_struct_count,
> >  	}
> > 
> >  	while (done < page_count) {
> > -		ulong i, completed, remain = page_count - done;
> > -		int rep_count = min(remain, HV_MAP_GPA_BATCH_SIZE);
> > +		u64 i, completed, remain = page_count - done;
> > +		u64 rep_count = min_t(u64, remain, HV_MAP_GPA_BATCH_SIZE);
> > 
> >  		local_irq_save(irq_flags);
> >  		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > @@ -224,23 +224,14 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64
> > page_struct_count,
> >  		input_page->map_flags = flags;
> >  		pfnlist = input_page->source_gpa_page_list;
> > 
> > -		for (i = 0; i < rep_count; i++)
> > -			if (flags & HV_MAP_GPA_NO_ACCESS) {
> > +		for (i = 0; i < rep_count; i++) {
> > +			if (flags & HV_MAP_GPA_NO_ACCESS)
> >  				pfnlist[i] = 0;
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
> > +				pfnlist[i] = page_to_pfn(pages[(done + i) <<
> > +							 large_shift]);
> > +			else
> >  				pfnlist[i] = mmio_spa + done + i;
> > -			}
> > -		if (ret) {
> > -			local_irq_restore(irq_flags);
> > -			break;
> >  		}
> > 
> >  		status = hv_do_rep_hypercall(HVCALL_MAP_GPA_PAGES, rep_count, 0,
> > @@ -248,29 +239,26 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64
> > page_struct_count,
> >  		local_irq_restore(irq_flags);
> > 
> >  		completed = hv_repcomp(status);
> > +		done += completed;
> > 
> >  		if (hv_result_needs_memory(status)) {
> >  			ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
> >  						    HV_MAP_GPA_DEPOSIT_PAGES);
> >  			if (ret)
> >  				break;
> > -
> >  		} else if (!hv_result_success(status)) {
> >  			ret = hv_result_to_errno(status);
> >  			break;
> >  		}
> > -
> > -		done += completed;
> >  	}
> > 
> >  	if (ret && done) {
> >  		u32 unmap_flags = 0;
> > 
> > -		if (flags & HV_MAP_GPA_LARGE_PAGE) {
> > +		if (flags & HV_MAP_GPA_LARGE_PAGE)
> >  			unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
> > -			done <<= large_shift;
> > -		}
> > -		hv_call_unmap_gpa_pages(partition_id, gfn, done, unmap_flags);
> > +		hv_call_unmap_gpa_pages(partition_id, gfn,
> > +					done << large_shift, unmap_flags);
> >  	}
> > 
> >  	return ret;
> > @@ -305,7 +293,7 @@ int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64
> > page_count_4k,
> >  	struct hv_input_unmap_gpa_pages *input_page;
> >  	u64 status, page_count = page_count_4k;
> >  	unsigned long irq_flags, large_shift = 0;
> > -	int ret = 0, done = 0;
> > +	u64 done = 0;
> > 
> >  	if (page_count == 0)
> >  		return -EINVAL;
> > @@ -319,8 +307,8 @@ int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64
> > page_count_4k,
> >  	}
> > 
> >  	while (done < page_count) {
> > -		ulong completed, remain = page_count - done;
> > -		int rep_count = min(remain, HV_UMAP_GPA_PAGES);
> > +		u64 completed, remain = page_count - done;
> > +		u64 rep_count = min_t(u64, remain, HV_UMAP_GPA_PAGES);
> > 
> >  		local_irq_save(irq_flags);
> >  		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > @@ -333,15 +321,13 @@ int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64
> > page_count_4k,
> >  		local_irq_restore(irq_flags);
> > 
> >  		completed = hv_repcomp(status);
> > -		if (!hv_result_success(status)) {
> > -			ret = hv_result_to_errno(status);
> > -			break;
> > -		}
> > -
> >  		done += completed;
> > +
> > +		if (!hv_result_success(status))
> > +			return hv_result_to_errno(status);
> >  	}
> > 
> > -	return ret;
> > +	return 0;
> >  }
> > 
> >  int hv_call_get_gpa_access_states(u64 partition_id, u32 count, u64 gpa_base_pfn,
> > 
> > 
> 

