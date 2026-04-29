Return-Path: <linux-hyperv+bounces-10471-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP6pJsjl8WlZlAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10471-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 13:04:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E0C49351A
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 13:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B116930783BC
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 11:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ABD37B41E;
	Wed, 29 Apr 2026 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="J3PA+4rA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D615337CD2E;
	Wed, 29 Apr 2026 11:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777460582; cv=pass; b=lIuW27Xq/D0yAnqBfBQYjTVeK7sN5b3QrOmesE/hVRvWObUO0dy+dvFJDLPuyfVLLmNbqJjqxDsksA9U1CjcR+rFe9lOlQA6Gvxa5cRJlgtmSoqIFumdh6UkJJRYe+RDpKwzQwVBvrxbauZjzI0X8rv/lYFwCqF43LPyliMgumw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777460582; c=relaxed/simple;
	bh=XyJ4362LHKSQCZxXlFJl8LTIallOpoM/TDLGymxICCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jrn7aNEb++yJFGo5/ldhFHtXEmnIitzZ6HLk1xFicbA1QJhcwbAoQc1nvFNN+mqTirGM8JmyRuuxyuyutSCX2EZJFD9WFKEJjf88bKUP3jsceSZUvx5kw+AmW3qobdhMaR75kbxoPCarqP0+/IMHgFojq2pn7gdD9My10lEKmR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=J3PA+4rA; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1777460565; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RJDzNlikOMAn/jLXORA0txc0HToyoKcMQbESyJUg2ORUmLOJedPOCwQt3A+YiGlJSxv6SmuAmYnLDfbPS83Rzq3V+hawbBWMgWlDQoaRvDNnNi4aI37NI3ov2sSZn8lWY53dEbsjcFSGRDEgtJw+LjRsKr9BYnSV51rGgxv6ugo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777460565; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qz5qqbIXLFw3xCU3JV5y7he+8XHJJ1HydFEu5/aOL4s=; 
	b=Kf2OssHsTHrHykWFdNoAFkHz7+oDJEaCC9uLw3h9cIewZ5OncCBpXxG0cdFYSpp4kXlH/4BA/4uUhillhXTBCahRVQD0IVCcaJxNLg1T1NkDoRAJE85qWKOCxhzSBO8YhWititlViobE3/3D/rH2xXUQMUr4C1wsKqxORYcqzQs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777460565;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=qz5qqbIXLFw3xCU3JV5y7he+8XHJJ1HydFEu5/aOL4s=;
	b=J3PA+4rAkZl8TTMlVmjx4FIoUsqqNSqq20Q9jsOFrQsCSnaIeAHo23lPpcouyiaZ
	yFxDzDX0OqvzYeFG1JDSYSdtrWx4s//bf6uI2U5Mo5UXd82HQ1MQr4GP6pUWibPdodN
	q1C1qEw3ZPwJVR8mCH/t/Jck5gsimLH2SwYYy+sI=
Received: by mx.zohomail.com with SMTPS id 1777460562216571.0145193690054;
	Wed, 29 Apr 2026 04:02:42 -0700 (PDT)
Date: Wed, 29 Apr 2026 11:02:37 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Simplify GPA map/unmap hypercall helpers
Message-ID: <20260429-orca-of-legal-symmetry-3c72bc@anirudhrb>
References: <177741845948.632922.14128507833980339307.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177741845948.632922.14128507833980339307.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 28E0C49351A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10471-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anirudhrb.com:dkim]

On Tue, Apr 28, 2026 at 11:21:12PM +0000, Stanislav Kinsburskii wrote:
> Clean up hv_do_map_gpa_hcall() and hv_call_unmap_gpa_pages() after the
> preceding bug-fix patches:
> 
> Move "done += completed" before the status checks so that pages mapped
> by a partially-successful batch are included in the error cleanup unmap.
> Previously these mappings were leaked on failure.
> 
> While here, improve type safety and readability:
>  - Change "int done" to "u64 done" to match the u64 page_count it is
>    compared against, avoiding signed/unsigned comparison hazards.
>  - Use u64 for loop iteration and batch size variables consistently.
>  - Add proper braces to the for-loop body in hv_do_map_gpa_hcall().
>  - Remove unnecessary "ret" variable from hv_call_unmap_gpa_pages().
>  - Simplify the error-path unmap to use "done << large_shift" directly
>    instead of mutating done in place.
> 
> Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_hv_call.c |   55 +++++++++++++++-------------------------
>  1 file changed, 20 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index e5992c324904a..f5f205a397834 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -195,8 +195,8 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
>  	struct hv_input_map_gpa_pages *input_page;
>  	u64 status, *pfnlist;
>  	unsigned long irq_flags, large_shift = 0;
> -	int ret = 0, done = 0;
> -	u64 page_count = page_struct_count;
> +	u64 done = 0, page_count = page_struct_count;
> +	int ret = 0;
>  
>  	if (page_count == 0 || (pages && mmio_spa))
>  		return -EINVAL;
> @@ -213,8 +213,8 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
>  	}
>  
>  	while (done < page_count) {
> -		ulong i, completed, remain = page_count - done;
> -		int rep_count = min(remain, HV_MAP_GPA_BATCH_SIZE);
> +		u64 i, completed, remain = page_count - done;
> +		u64 rep_count = min(remain, (u64)HV_MAP_GPA_BATCH_SIZE);
>  
>  		local_irq_save(irq_flags);
>  		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
> @@ -224,23 +224,13 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
>  		input_page->map_flags = flags;
>  		pfnlist = input_page->source_gpa_page_list;
>  
> -		for (i = 0; i < rep_count; i++)
> -			if (flags & HV_MAP_GPA_NO_ACCESS) {
> +		for (i = 0; i < rep_count; i++) {
> +			if (flags & HV_MAP_GPA_NO_ACCESS)
>  				pfnlist[i] = 0;
> -			} else if (pages) {
> -				u64 index = (done + i) << large_shift;
> -
> -				if (index >= page_struct_count) {
> -					ret = -EINVAL;
> -					break;
> -				}
> -				pfnlist[i] = page_to_pfn(pages[index]);
> -			} else {
> +			else if (pages)
> +				pfnlist[i] = page_to_pfn(pages[(done + i) << large_shift]);
> +			else
>  				pfnlist[i] = mmio_spa + done + i;
> -			}
> -		if (ret) {
> -			local_irq_restore(irq_flags);
> -			break;
>  		}
>  
>  		status = hv_do_rep_hypercall(HVCALL_MAP_GPA_PAGES, rep_count, 0,
> @@ -248,29 +238,26 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
>  		local_irq_restore(irq_flags);
>  
>  		completed = hv_repcomp(status);
> +		done += completed;
>  
>  		if (hv_result_needs_memory(status)) {
>  			ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
>  						    HV_MAP_GPA_DEPOSIT_PAGES);
>  			if (ret)
>  				break;
> -
>  		} else if (!hv_result_success(status)) {
>  			ret = hv_result_to_errno(status);
>  			break;
>  		}
> -
> -		done += completed;
>  	}
>  
>  	if (ret && done) {
>  		u32 unmap_flags = 0;
>  
> -		if (flags & HV_MAP_GPA_LARGE_PAGE) {
> +		if (flags & HV_MAP_GPA_LARGE_PAGE)
>  			unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
> -			done <<= large_shift;
> -		}
> -		hv_call_unmap_gpa_pages(partition_id, gfn, done, unmap_flags);
> +		hv_call_unmap_gpa_pages(partition_id, gfn,
> +					done << large_shift, unmap_flags);

How does this work? Earlier we were doing "done << large_shift" only if
HV_MAP_GPA_LARGE_PAGE is set but now we always do it.

Thanks,
Anirudh.


