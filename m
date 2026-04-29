Return-Path: <linux-hyperv+bounces-10476-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sM7OEdsh8mm/oAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10476-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 17:20:59 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB88496BAB
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 17:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1292303E239
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 15:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA88D37755C;
	Wed, 29 Apr 2026 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Dn43PbTW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6116837754B;
	Wed, 29 Apr 2026 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475713; cv=none; b=Ji9XgNELl4FV9LYrYsLXd2l8F2mVVcdLZbnCf7662/4XqXPdmyOk9p5HQGZrBG8c9kuLHMUrnpJDxDK3uzpnXRa+pMLuwT+toJqpIRVE9/Ko/b3PW49nQad8DWiElNztxCINmyqlWhc+TR7YSnl2g08pdiLihqtttv5fl7MUcUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475713; c=relaxed/simple;
	bh=+uSr6evrvo/0MKAoWSJk9I0mBzxiElHhhKzbH370t5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVypNOpsKjqxISuOfOiCap5eBC2y6m9A9Rqa65E0QyhA63iEJ67UaunMBLMOvCtghm0bbFm/GdbGjDbSMQCBbNtyR2SV0WSEmEVIQZlfJIn8ijlnCkfCKLp4JR2iH5kvw33WjQmIYhwRCAcoGT3YXLfHNoCPd4l6x4BAa3SffSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Dn43PbTW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5F78A20B716C;
	Wed, 29 Apr 2026 08:15:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5F78A20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777475706;
	bh=O1sXzqauNNKBh7pLIfyX7KtSEs3PGvO8vq9EnvQ8CEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dn43PbTW77TaPrWx0EXMbAew5Lx4Hn9kxUDOhQ/EUBXQYXd+nmKTzTPLcnbaACFUu
	 SmAbtVtR/Qo39MRmRH5NrK1LSrR98irfQXXVxPbYbpURWkYfO2HC/xyDuFYHIa9o4M
	 DP51k7pZGvsC911rOE4JjSIRbtMPxaLvnasWxm7M=
Date: Wed, 29 Apr 2026 08:15:05 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Simplify GPA map/unmap hypercall helpers
Message-ID: <afIgeaLSiCG4f8lW@skinsburskii.localdomain>
References: <177741845948.632922.14128507833980339307.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260429-orca-of-legal-symmetry-3c72bc@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-orca-of-legal-symmetry-3c72bc@anirudhrb>
X-Rspamd-Queue-Id: DBB88496BAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10476-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim]

On Wed, Apr 29, 2026 at 11:02:37AM +0000, Anirudh Rayabharam wrote:
> On Tue, Apr 28, 2026 at 11:21:12PM +0000, Stanislav Kinsburskii wrote:
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
> > Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_root_hv_call.c |   55 +++++++++++++++-------------------------
> >  1 file changed, 20 insertions(+), 35 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> > index e5992c324904a..f5f205a397834 100644
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
> > +		u64 rep_count = min(remain, (u64)HV_MAP_GPA_BATCH_SIZE);
> >  
> >  		local_irq_save(irq_flags);
> >  		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > @@ -224,23 +224,13 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
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
> > +				pfnlist[i] = page_to_pfn(pages[(done + i) << large_shift]);
> > +			else
> >  				pfnlist[i] = mmio_spa + done + i;
> > -			}
> > -		if (ret) {
> > -			local_irq_restore(irq_flags);
> > -			break;
> >  		}
> >  
> >  		status = hv_do_rep_hypercall(HVCALL_MAP_GPA_PAGES, rep_count, 0,
> > @@ -248,29 +238,26 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
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
> 
> How does this work? Earlier we were doing "done << large_shift" only if
> HV_MAP_GPA_LARGE_PAGE is set but now we always do it.
> 

It works becuase large_shift in initialized to 0 when
HV_MAP_GPA_LARGE_PAGE is not set.

Thanks,
Stanislav

> Thanks,
> Anirudh.

