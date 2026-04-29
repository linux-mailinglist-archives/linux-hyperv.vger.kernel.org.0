Return-Path: <linux-hyperv+bounces-10475-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANmtLYoE8mlYmgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10475-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 15:15:54 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 503914949C6
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 15:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF7663052E9B
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 13:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311873F65E7;
	Wed, 29 Apr 2026 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="n0nrNO1t"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B000E2C21F7;
	Wed, 29 Apr 2026 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468300; cv=pass; b=ZM9sL3RjihdkZXm12Quh126HoNtyxP8VJIeG94U3xbJhsxWQX0rmiGqmg/Ie3k5law2559e3O6vwdc/nY3oUakksghmN5k4Fjk+hveXL3NyQa0mlVe5EY5bXxW0MJc3H7dFmmSTpVhMl0egYFWoG8Ucb6Y+MMR6y7I/iSmvGqYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468300; c=relaxed/simple;
	bh=5rfbduflbvrlxwEIfJ2WsjFlaEXTJrqOPGQMXDhDnlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuEyWWsJaxmHOfYbstNm8BodP2EDiz8ipAvKcP2wRO4oKd5LQIb/prvZi7R57fR3hjn1wEKfcMD2KxvC3BUv/Y567jzu3r1xklagLDZwEtDwVGiC3h1nuQEf53oM716Uh0MbEqALFr0eWUtHg+xxWKhfI1U05ZAjAG8fdI0NSq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=n0nrNO1t; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1777468285; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XcvN5+mA13YT5DEQWDb+EfanaMmpYDbmW/a9vE6s6p2oNitviF6fJEDewnY92i+/7OdaFpXTOJ6gMiTy35DH4vry8m+jYPfZXMa0PapdGb6KqKlFm1fA+SfvRfU7uxQSRC6nHLpzRfLEWWaqdQlvcU8V164yq9B1ZGwvlMBWS+4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777468285; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Q9Sd/frvw2kj6fOPaf5w4+MiV4s8hZzoZcEutTRL9Z0=; 
	b=EMH2pDewW+VCHV5L7HOHWrRF7obx3INARmhU1Hw5MoGZfcnlt/ggSr/oQFgYAmSIJ3xry+nfY2p/xe9113wYGKj9WErlIoVs0rt6fW/acGZbg8z4hVq2c2zL56D18Yvob06UW/rIJtPymYkWj1HYFpP2isgT8chzUNcxN3B1uC4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777468285;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=Q9Sd/frvw2kj6fOPaf5w4+MiV4s8hZzoZcEutTRL9Z0=;
	b=n0nrNO1tumee8o+h+ZzLu0B3NRFCK37urztIuSOrEFQ3KJ6jeJDG8/Cq+JMHwv44
	8Gpr5uEF82M5//NCNmnwaXtYWFLILE1CcPDQ3Kw9jufH0minOOoKbd0TnXgQYh4V+7I
	PDG1PGij9K486pWxkpeeJBDJQIODE7BGtQ2aj2Co=
Received: by mx.zohomail.com with SMTPS id 1777468275110972.5897263291558;
	Wed, 29 Apr 2026 06:11:15 -0700 (PDT)
Date: Wed, 29 Apr 2026 13:11:10 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Add dedicated ioctl for GVA to GPA translation
Message-ID: <20260429-vociferous-certain-dragon-cd6255@anirudhrb>
References: <177741648871.626779.11067281081219290277.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177741648871.626779.11067281081219290277.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 503914949C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10475-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 10:48:24PM +0000, Stanislav Kinsburskii wrote:
> Add an MSHV_TRANSLATE_GVA ioctl on the VP fd that wraps
> HVCALL_TRANSLATE_VIRTUAL_ADDRESS_EX with transparent fault-in handling for
> movable memory regions. The passthrough path for this hypercall is retained
> for backward compatibility.
> 
> When guest-backing pages reside in movable memory regions, the mmu_notifier
> invalidation path remaps them to NO_ACCESS in the hypervisor's second-level
> address translation tables. If the VMM issues a GVA translation (e.g.
> during MMIO emulation) while a page-table page is invalidated, the
> hypervisor returns HV_TRANSLATE_GVA_GPA_NO_READ_ACCESS. The VMM cannot
> resolve this on its own.
> 
> The new ioctl detects this transient GPA access failure, faults the page
> back in via mshv_region_handle_gfn_fault(), and retries the translation
> until it succeeds or an unrecoverable error occurs.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h         |    3 ++
>  drivers/hv/mshv_root_hv_call.c |   37 +++++++++++++++++++++
>  drivers/hv/mshv_root_main.c    |   69 ++++++++++++++++++++++++++++++++++++++++
>  include/hyperv/hvgdk_mini.h    |    1 +
>  include/hyperv/hvhdk.h         |   41 ++++++++++++++++++++++++
>  include/uapi/linux/mshv.h      |   10 ++++++
>  6 files changed, 161 insertions(+)
> 
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 1f086dcb7aa1a..2e6c4414740cc 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -290,6 +290,9 @@ int hv_call_delete_vp(u64 partition_id, u32 vp_index);
>  int hv_call_assert_virtual_interrupt(u64 partition_id, u32 vector,
>  				     u64 dest_addr,
>  				     union hv_interrupt_control control);
> +int hv_call_translate_virtual_address_ex(u32 vp_index, u64 partition_id,
> +					 u64 flags, u64 gva, u64 *gfn,
> +					 struct hv_translate_gva_result_ex *result);
>  int hv_call_clear_virtual_interrupt(u64 partition_id);
>  int hv_call_get_gpa_access_states(u64 partition_id, u32 count, u64 gpa_base_pfn,
>  				  union hv_gpa_page_access_state_flags state_flags,
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index e5992c324904a..9ff4ba5373f59 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -692,6 +692,43 @@ int hv_call_get_partition_property_ex(u64 partition_id, u64 property_code,
>  	return 0;
>  }
>  
> +int hv_call_translate_virtual_address_ex(u32 vp_index, u64 partition_id,
> +					 u64 flags, u64 gva, u64 *gfn,
> +					 struct hv_translate_gva_result_ex *result)
> +{
> +	struct hv_input_translate_virtual_address *input;
> +	struct hv_output_translate_virtual_address_ex *output;
> +	unsigned long irq_flags;
> +	u64 status;
> +
> +	local_irq_save(irq_flags);
> +
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id = partition_id;
> +	input->vp_index = vp_index;
> +	input->control_flags = flags;
> +	input->gva_page = gva >> HV_HYP_PAGE_SHIFT;
> +
> +	status = hv_do_hypercall(HVCALL_TRANSLATE_VIRTUAL_ADDRESS_EX,
> +				 input, output);
> +
> +	if (!hv_result_success(status)) {
> +		local_irq_restore(irq_flags);
> +		pr_err("%s: %s\n", __func__, hv_result_to_string(status));
> +		return hv_result_to_errno(status);
> +	}
> +
> +	*result = output->translation_result;
> +	*gfn = output->gpa_page;
> +
> +	local_irq_restore(irq_flags);
> +
> +	return 0;
> +}
> +
>  int
>  hv_call_clear_virtual_interrupt(u64 partition_id)
>  {
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index bd1359eb58dd4..2d7b6923415a8 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -898,6 +898,72 @@ mshv_vp_ioctl_get_set_state(struct mshv_vp *vp,
>  	return 0;
>  }
>  
> +static bool mshv_gpa_fault_retryable(u32 result_code)
> +{
> +	/*
> +	 * Note: HV_TRANSLATE_GVA_GPA_UNMAPPED is intentionally not handled
> +	 * here. The guest page table cannot be unmapped under normal
> +	 * operation. It may be mapped with no access during page moves,
> +	 * but a truly unmapped state indicates a kernel driver bug.
> +	 * Retrying in this case would only mask the underlying problem of
> +	 * an unmapped guest page table.
> +	 */
> +	return result_code == HV_TRANSLATE_GVA_GPA_NO_READ_ACCESS;
> +}
> +
> +static long
> +mshv_vp_ioctl_translate_gva(struct mshv_vp *vp, void __user *user_args)
> +{
> +	struct mshv_partition *partition = vp->vp_partition;
> +	struct mshv_translate_gva args;
> +	struct hv_translate_gva_result_ex result;
> +	u64 gfn, gpa;
> +	int ret;
> +
> +	if (copy_from_user(&args, user_args, sizeof(args)))
> +		return -EFAULT;
> +
> +	do {
> +		ret = hv_call_translate_virtual_address_ex(vp->vp_index,
> +							   partition->pt_id,
> +							   args.flags, args.gva,
> +							   &gfn, &result);
> +		if (ret)
> +			return ret;
> +
> +		if (mshv_gpa_fault_retryable(result.result_code)) {
> +			struct mshv_mem_region *region;
> +			bool faulted;
> +
> +			region = mshv_partition_region_by_gfn_get(partition,
> +								  gfn);
> +			if (!region)
> +				return -EFAULT;
> +
> +			faulted = false;
> +			if (region->mreg_type == MSHV_REGION_TYPE_MEM_MOVABLE)
> +				faulted = mshv_region_handle_gfn_fault(region,
> +								       gfn);
> +			mshv_region_put(region);
> +
> +			if (!faulted)
> +				return -EFAULT;
> +
> +			cond_resched();
> +		}
> +	} while (mshv_gpa_fault_retryable(result.result_code));
> +
> +	gpa = (gfn << PAGE_SHIFT) | (args.gva & ~PAGE_MASK);
> +
> +        if (copy_to_user(args.result, &result, sizeof(*args.result)))

Indentation is a bit off here.

With that fixed:

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


