Return-Path: <linux-hyperv+bounces-8735-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CwcB1/ahGna5wMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8735-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 18:58:55 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40636F63F1
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 18:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C0C9302A53B
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Feb 2026 17:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EE73033EA;
	Thu,  5 Feb 2026 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="zMVrIj7F"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043023033D9;
	Thu,  5 Feb 2026 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770314300; cv=pass; b=gNR2XtdYT+d3XKn3Et9abfDyix+SGnsMhFE8xf0ld36ZMJfRw//QiICTZnL+7zip5ZLtpU8aNJoMyxDrDClTTZQ7N37RJxapD8pYLfFe9VpOzB3uKGSwwKjkGbAgXc0FpEp/gyOJPMTzDtz3ZvBubXx6huPN8R8Q6kOQSfuQEgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770314300; c=relaxed/simple;
	bh=UqxZJVafj94689L5PqLx7NukNRQy25DSQdVcC3WWV1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQp6x/TDbBliIwxmFVFA5MOHKqJ3IahIuWlVK6BzckzDLt1OZZVGCPS/idMUXzXgTVxqr2MlZdvNWOZboGbBqgdzK1Wfxus5gYGgDvzw+x1ZUwQlnwounhVUbIr9inxfbL8yTuV5UFio+i1bHJWalNODCRjNmfKQcXvHMunxuMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=zMVrIj7F; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1770314291; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NUD0Xa6WBnASvBgwjrpw6Y7F1r1Zh24/FUyy+9slPrwGqe3M0SL6A3VTQeNHM1yxCGsSZQMoTIaL+MiyL7BBjwslE80N7Xco259BKUwMr+wVa3Zm9UcXs+N5InvzCI2UJCP86XRbOlKWbNVCGtfBicPwe3xKR5XzkiGLM2S+wX8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770314291; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uv41ekEE/7R/QQocu7Xw9Xoph3GGGf2zfDpqxCx77SU=; 
	b=DMMvCTTl82FVHRA2IfC5LnpEtpk74cAke15b9HkuWcVzIC8n8C4h14JVEzDYRSLHthnBm/ADtFtaPBDvRvgSPjKyzqmzLhueZackHwR7JmWC4bnj6yNi5R7Qm2xwr+0D288kGayXVHclI0auBV91Nq3F7q9zn8mdPEqXmq/f9iQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770314291;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=uv41ekEE/7R/QQocu7Xw9Xoph3GGGf2zfDpqxCx77SU=;
	b=zMVrIj7FRCNoZkaTc2P7FVLi4vBUqQ+WAt+zPWt0XFVCwA5H1owt+rnx74gpi8n6
	WZ19Kb6ZSLFOeVMerkTAGgKsr4L665Rm/xQewJccFzLFvjNNRi4Fz4SX7XCazm1jxA/
	Omx9sfV+j8kw38iLZxNNar+QS4drBEeKeMsjJfMk=
Received: by mx.zohomail.com with SMTPS id 1770314290076571.945248334108;
	Thu, 5 Feb 2026 09:58:10 -0800 (PST)
Date: Thu, 5 Feb 2026 23:28:03 +0530
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mshv: Introduce hv_result_needs_memory() helper
 function
Message-ID: <tc2av6i3kccwo37zykj4zs4nsrcdmc3xs72hnpnn6vwxk67chi@njto2c3ahbu5>
References: <177005499596.120041.5908089206606113719.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177005513775.120041.4894134857240187839.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177005513775.120041.4894134857240187839.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[anirudhrb.com];
	TAGGED_FROM(0.00)[bounces-8735-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:email,anirudhrb.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40636F63F1
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 05:58:57PM +0000, Stanislav Kinsburskii wrote:
> Replace direct comparisons of hv_result(status) against
> HV_STATUS_INSUFFICIENT_MEMORY with a new hv_result_needs_memory() helper
> function.
> This improves code readability and provides a consistent and extendable
> interface for checking out-of-memory conditions in hypercall results.
> 
> No functional changes intended.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/hv_proc.c           |   14 ++++++++++++--
>  drivers/hv/mshv_root_hv_call.c |   20 ++++++++++----------
>  drivers/hv/mshv_root_main.c    |    2 +-
>  include/asm-generic/mshyperv.h |    3 +++
>  4 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index fbb4eb3901bb..e53204b9e05d 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -110,6 +110,16 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>  }
>  EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
>  
> +bool hv_result_needs_memory(u64 status)
> +{
> +	switch (hv_result(status)) {
> +	case HV_STATUS_INSUFFICIENT_MEMORY:
> +		return true;
> +	}
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(hv_result_needs_memory);
> +
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
>  {
>  	struct hv_input_add_logical_processor *input;
> @@ -137,7 +147,7 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
>  					 input, output);
>  		local_irq_restore(flags);
>  
> -		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
> +		if (!hv_result_needs_memory(status)) {
>  			if (!hv_result_success(status)) {
>  				hv_status_err(status, "cpu %u apic ID: %u\n",
>  					      lp_index, apic_id);
> @@ -179,7 +189,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
>  		status = hv_do_hypercall(HVCALL_CREATE_VP, input, NULL);
>  		local_irq_restore(irq_flags);
>  
> -		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
> +		if (!hv_result_needs_memory(status)) {
>  			if (!hv_result_success(status)) {
>  				hv_status_err(status, "vcpu: %u, lp: %u\n",
>  					      vp_index, flags);
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index 598eaff4ff29..89afeeda21dd 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -115,7 +115,7 @@ int hv_call_create_partition(u64 flags,
>  		status = hv_do_hypercall(HVCALL_CREATE_PARTITION,
>  					 input, output);
>  
> -		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
> +		if (!hv_result_needs_memory(status)) {
>  			if (hv_result_success(status))
>  				*partition_id = output->partition_id;
>  			local_irq_restore(irq_flags);
> @@ -147,7 +147,7 @@ int hv_call_initialize_partition(u64 partition_id)
>  		status = hv_do_fast_hypercall8(HVCALL_INITIALIZE_PARTITION,
>  					       *(u64 *)&input);
>  
> -		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
> +		if (!hv_result_needs_memory(status)) {
>  			ret = hv_result_to_errno(status);
>  			break;
>  		}
> @@ -239,7 +239,7 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
>  
>  		completed = hv_repcomp(status);
>  
> -		if (hv_result(status) == HV_STATUS_INSUFFICIENT_MEMORY) {
> +		if (hv_result_needs_memory(status)) {
>  			ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
>  						    HV_MAP_GPA_DEPOSIT_PAGES);
>  			if (ret)
> @@ -455,7 +455,7 @@ int hv_call_get_vp_state(u32 vp_index, u64 partition_id,
>  
>  		status = hv_do_hypercall(control, input, output);
>  
> -		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
> +		if (!hv_result_needs_memory(status)) {
>  			if (hv_result_success(status) && ret_output)
>  				memcpy(ret_output, output, sizeof(*output));
>  
> @@ -518,7 +518,7 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
>  
>  		status = hv_do_hypercall(control, input, NULL);
>  
> -		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
> +		if (!hv_result_needs_memory(status)) {
>  			local_irq_restore(flags);
>  			ret = hv_result_to_errno(status);
>  			break;
> @@ -563,7 +563,7 @@ static int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>  		status = hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE, input,
>  					 output);
>  
> -		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
> +		if (!hv_result_needs_memory(status)) {
>  			if (hv_result_success(status))
>  				*state_page = pfn_to_page(output->map_location);
>  			local_irq_restore(flags);
> @@ -718,7 +718,7 @@ hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
>  		if (hv_result_success(status))
>  			break;
>  
> -		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
> +		if (!hv_result_needs_memory(status)) {
>  			ret = hv_result_to_errno(status);
>  			break;
>  		}
> @@ -772,7 +772,7 @@ hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
>  		if (hv_result_success(status))
>  			break;
>  
> -		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
> +		if (!hv_result_needs_memory(status)) {
>  			ret = hv_result_to_errno(status);
>  			break;
>  		}
> @@ -843,7 +843,7 @@ static int hv_call_map_stats_page2(enum hv_stats_object_type type,
>  		if (!ret)
>  			break;
>  
> -		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
> +		if (!hv_result_needs_memory(status)) {
>  			hv_status_debug(status, "\n");
>  			break;
>  		}
> @@ -878,7 +878,7 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
>  		pfn = output->map_location;
>  
>  		local_irq_restore(flags);
> -		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
> +		if (!hv_result_needs_memory(status)) {
>  			ret = hv_result_to_errno(status);
>  			if (hv_result_success(status))
>  				break;
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 6a6bf641b352..ee30bfa6bb2e 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -261,7 +261,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
>  		if (hv_result_success(status))
>  			break;
>  
> -		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY)
> +		if (!hv_result_needs_memory(status))
>  			ret = hv_result_to_errno(status);
>  		else
>  			ret = hv_call_deposit_pages(NUMA_NO_NODE,
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index ecedab554c80..452426d5b2ab 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -342,6 +342,8 @@ static inline bool hv_parent_partition(void)
>  {
>  	return hv_root_partition() || hv_l1vh_partition();
>  }
> +
> +bool hv_result_needs_memory(u64 status);
>  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>  int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
> @@ -350,6 +352,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
>  static inline bool hv_root_partition(void) { return false; }
>  static inline bool hv_l1vh_partition(void) { return false; }
>  static inline bool hv_parent_partition(void) { return false; }
> +static inline bool hv_result_needs_memory(u64 status) { return false; }
>  static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>  {
>  	return -EOPNOTSUPP;
> 
> 

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


