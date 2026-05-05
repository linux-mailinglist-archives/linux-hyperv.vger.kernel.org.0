Return-Path: <linux-hyperv+bounces-10636-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAoKCf4G+mkEIgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-10636-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 17:04:30 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2014CFE6D
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 17:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CA693012E80
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 May 2026 15:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877503624C0;
	Tue,  5 May 2026 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kY695IEZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2B82356C6;
	Tue,  5 May 2026 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993246; cv=none; b=s/TPqmozRYeV12T87rbZWpsl0L2A7POE9G7tjpjgTMAojqAg+/54q8tf5e3bBOCjebADJPR5NIBqIPg7A2Ue/1ckSlkrE5PJ0bSgQCmL3stNQpiOzr9Rkh5THqxN+ckUJc1AO2LjUzgoUAuWnQ1ZVyqWjywspw8nN8wPNYLRfnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993246; c=relaxed/simple;
	bh=E+LD1y+VHXga9tV+XLjn5CQIiuLgSiQta+bz7nH/XZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0aEAXU5GJM8LRC+Wp/JFO2uMzfKoSEStMhRajViyycju9z1Og2X9TGTe4jrDC2vQsvdkNLQmVpHqj3IUeAtL4TKKQPJ7xM5vM3fpxcKd6xWT/hbPt/exgr4Qky9QNuZNCC3fiM2BS1gKT0xO44VxittyfS4v9E9w22TOjwRRaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kY695IEZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id B80C220B7168;
	Tue,  5 May 2026 08:00:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B80C220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777993242;
	bh=ORIqHXvhMsJ3LGwIn8WeO1WB4bGjEu3oov09MqSL6OQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kY695IEZu4WXTpvKwj0XNrQS5/XQ7wHi9bPq7MWIfEWsklKDK7QTp44j8IZCMxCIu
	 oIm9iCrU6vZKitFlhRUABTNVE+2s5//M0Co6sDWD/6FB+5TlCTbp4TcBPMS2IlKN7M
	 l/BKFEVCk1tgObCfTRWKkHS/QX/3MI37A2jEPPpo=
Date: Tue, 5 May 2026 08:00:42 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mshv: Simplify GPA map/unmap hypercall helpers
Message-ID: <afoGGj1dCKDpVcy_@skinsburskii.localdomain>
References: <177756065245.17889.140699174692055235.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260505-efficient-victorious-degu-d5ec2e@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505-efficient-victorious-degu-d5ec2e@anirudhrb>
X-Rspamd-Queue-Id: 6E2014CFE6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10636-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,skinsburskii.localdomain:mid]

On Tue, May 05, 2026 at 06:13:01AM +0000, Anirudh Rayabharam wrote:
> On Thu, Apr 30, 2026 at 02:52:17PM +0000, Stanislav Kinsburskii wrote:
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
> 
> This part describing the changes in various version should be placed
> after the "---" line below. This way it won't appear in the final commit
> log.
> 
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#commentary

Thanks for the geidance, will do next time.

Thanks,
Stanislav

> 
> Thanks,
> Anirudh.
> 
> > 
> > Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_root_hv_call.c |   56 +++++++++++++++-------------------------
> >  1 file changed, 21 insertions(+), 35 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> > index e5992c324904a..e1f9e28d5a19b 100644
> > --- a/drivers/hv/mshv_root_hv_call.c
> > +++ b/drivers/hv/mshv_root_hv_call.c
> > @@ -195,8 +195,8 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
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
> > @@ -213,8 +213,8 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
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
> > @@ -224,23 +224,14 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
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
> > @@ -248,29 +239,26 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
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
> > @@ -305,7 +293,7 @@ int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k,
> >  	struct hv_input_unmap_gpa_pages *input_page;
> >  	u64 status, page_count = page_count_4k;
> >  	unsigned long irq_flags, large_shift = 0;
> > -	int ret = 0, done = 0;
> > +	u64 done = 0;
> >  
> >  	if (page_count == 0)
> >  		return -EINVAL;
> > @@ -319,8 +307,8 @@ int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k,
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
> > @@ -333,15 +321,13 @@ int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k,
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

