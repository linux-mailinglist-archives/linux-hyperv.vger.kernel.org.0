Return-Path: <linux-hyperv+bounces-10258-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id K7mOF1UB52nc2gEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10258-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 06:47:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF7B4364A4
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 06:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55595300DE3A
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 04:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16E51D416C;
	Tue, 21 Apr 2026 04:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="cKIaADfx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7F726ACC;
	Tue, 21 Apr 2026 04:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776746834; cv=pass; b=L6ASV0Gt9fwEdPULB9Bpz1QaTq0ODgATT3QNJwCo4wJiHwUtb2eaYn7udZlk1BH36odFG3sE4SveVFd5U5YUVAr29ATjSgOMdpiPOQL3wZj2uQ/2MKkYytoREn8HCJKTL7fA8XccziHeVEDyq2YNPfSCFJKc6XtSbPgBn1XJ+G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776746834; c=relaxed/simple;
	bh=p9RBbFMTzaXcg9rK0CtW5c42yW2NKD/dS7j1G0QpiwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtwHATI0v4z/rOMN+4SXgAk9mMz5m4bVkDQy9g7BpzjkXCfYp1DnEdyH+oEHW3OaIe6nHRZkiN+SuYc2dNI6f4VI7Ux+F3Ifkslnz9AkjbYMoy1yCTSJqmRpps4NTKbpoyQ8kmo/qKcB6cccw1vav9i67nT3Cp7qFMfBC0TdY2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=cKIaADfx; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1776746803; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c5WCMdkZwOMXPuE1NxdIgE9EA0xkdvWnls4ef9pNxE8kMZwtRbN3PW6/vwliw/ZWpF+bfHYiiYsd0SJSGGITplYuc/liRf38ePyFUKGjgsJ/HI02z9N/FvuOvc9w282W4l5PWadZ71TUvzADo3fE+xXv1Q5BUVfWOJUz38q9IFc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776746803; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/djBBtb2HaSg8FvjLVolXZi5iSv4/i3fK5V6rpSOK6A=; 
	b=TjIN3xWzZR4rQhqbEyIArxO9pFPEPKEcvOFvZBPuTDH1Bm6zak6i4tVoj1e7sMXwEIpu/WzdvslgbOXEz17MPkFNYJOp7oGFbsrCaBCpitoPrUavgHnkSm7XSPzfs7Nn9UERni6x28L5AuQH65DM1trdjMp8iOwJQAAW89LLhWQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776746803;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=/djBBtb2HaSg8FvjLVolXZi5iSv4/i3fK5V6rpSOK6A=;
	b=cKIaADfxlnKk/kSQjzkVpbk1ze8Jf8OJwhBxg3XUiPWlSmVM1FVz+4Ch4zYEcXhA
	TzWowhF4OXXY7LNCqS7SgkWGSb4kzHjSUUjJ1AwBrkcEWeP5QJP4CFDTeVdJy0r4PBF
	6YpRAZCdtF6tEZ7Zl09hHBSdiXyRI0GOdp+tPYKo=
Received: by mx.zohomail.com with SMTPS id 1776746800604277.72434512080144;
	Mon, 20 Apr 2026 21:46:40 -0700 (PDT)
Date: Tue, 21 Apr 2026 04:46:32 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Jork Loeser <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Michael Kelley <mhklinux@outlook.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 4/6] mshv: limit SynIC management to MSHV-owned
 resources
Message-ID: <20260421-unnatural-snail-of-excitement-94a77b@anirudhrb>
References: <20260403190613.47026-1-jloeser@linux.microsoft.com>
 <20260403190613.47026-5-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260403190613.47026-5-jloeser@linux.microsoft.com>
X-ZohoMailClient: External
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10258-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anirudhrb.com:dkim]
X-Rspamd-Queue-Id: AAF7B4364A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 12:06:10PM -0700, Jork Loeser wrote:
> The SynIC is shared between VMBus and MSHV. VMBus owns the message
> page (SIMP), event flags page (SIEFP), global enable (SCONTROL),
> and SINT2. MSHV adds SINT0, SINT5, and the event ring page (SIRBP).
> 
> Currently mshv_synic_init() redundantly enables SIMP, SIEFP, and
> SCONTROL that VMBus already configured, and mshv_synic_cleanup()
> disables all of them. This is wrong because MSHV can be torn down
> while VMBus is still active. In particular, a kexec reboot notifier
> tears down MSHV first. Disabling SCONTROL, SIMP, and SIEFP out
> from under VMBus causes its later cleanup to write SynIC MSRs while
> SynIC is disabled, which the hypervisor does not tolerate.
> 
> Restrict MSHV to managing only the resources it owns:
> - SINT0, SINT5: mask on cleanup, unmask on init
> - SIRBP: enable/disable as before
> - SIMP, SIEFP, SCONTROL: leave to VMBus when it is active (L1VH
>   and nested root partition); on a non-nested root partition VMBus
>   doesn't run, so MSHV must enable/disable them
> 
> Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
> ---
>  drivers/hv/mshv_synic.c | 142 ++++++++++++++++++++++++++--------------
>  1 file changed, 94 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index f8b0337cdc82..7d273766bdb5 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
> @@ -454,46 +454,72 @@ int mshv_synic_init(unsigned int cpu)
>  #ifdef HYPERVISOR_CALLBACK_VECTOR
>  	union hv_synic_sint sint;
>  #endif
> -	union hv_synic_scontrol sctrl;
>  	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
>  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
>  	struct hv_synic_event_flags_page **event_flags_page =
>  			&spages->synic_event_flags_page;
>  	struct hv_synic_event_ring_page **event_ring_page =
>  			&spages->synic_event_ring_page;
> +	/* VMBus runs on L1VH and nested root; it owns SIMP/SIEFP/SCONTROL */
> +	bool vmbus_active = !hv_root_partition() || hv_nested;
>  
> -	/* Setup the Synic's message page */
> +	/*
> +	 * Map the SYNIC message page. When VMBus is not active the
> +	 * hypervisor pre-provisions the SIMP GPA but may not set
> +	 * simp_enabled — enable it here.
> +	 */
>  	simp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIMP);
> -	simp.simp_enabled = true;
> +	if (!vmbus_active) {
> +		simp.simp_enabled = true;
> +		hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
> +	}
>  	*msg_page = memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
>  			     HV_HYP_PAGE_SIZE,
>  			     MEMREMAP_WB);
>  
>  	if (!(*msg_page))
> -		return -EFAULT;
> +		goto cleanup_simp;
>  
> -	hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
> -
> -	/* Setup the Synic's event flags page */
> +	/*
> +	 * Map the event flags page. Same as SIMP: enable when
> +	 * VMBus is not active, already enabled by VMBus otherwise.
> +	 */
>  	siefp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIEFP);
> -	siefp.siefp_enabled = true;
> +	if (!vmbus_active) {
> +		siefp.siefp_enabled = true;
> +		hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
> +	}
>  	*event_flags_page = memremap(siefp.base_siefp_gpa << PAGE_SHIFT,
>  				     PAGE_SIZE, MEMREMAP_WB);
>  
>  	if (!(*event_flags_page))
> -		goto cleanup;
> -
> -	hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
> +		goto cleanup_siefp;
>  
>  	/* Setup the Synic's event ring page */
>  	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
> -	sirbp.sirbp_enabled = true;
> -	*event_ring_page = memremap(sirbp.base_sirbp_gpa << PAGE_SHIFT,
> -				    PAGE_SIZE, MEMREMAP_WB);
>  
> -	if (!(*event_ring_page))
> -		goto cleanup;
> +	if (hv_root_partition()) {
> +		*event_ring_page = memremap(sirbp.base_sirbp_gpa << PAGE_SHIFT,
> +					    PAGE_SIZE, MEMREMAP_WB);
>  
> +		if (!(*event_ring_page))
> +			goto cleanup_siefp;
> +	} else {
> +		/*
> +		 * On L1VH the hypervisor does not provide a SIRBP page.
> +		 * Allocate one and program its GPA into the MSR.
> +		 */

How were things working before this?

Thanks,
Anirudh.

> +		*event_ring_page = (struct hv_synic_event_ring_page *)
> +			get_zeroed_page(GFP_KERNEL);
> +
> +		if (!(*event_ring_page))
> +			goto cleanup_siefp;
> +
> +		sirbp.base_sirbp_gpa = virt_to_phys(*event_ring_page)
> +				>> PAGE_SHIFT;
> +	}
> +
> +	sirbp.sirbp_enabled = true;
>  	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
>  
>  #ifdef HYPERVISOR_CALLBACK_VECTOR
> @@ -515,28 +541,30 @@ int mshv_synic_init(unsigned int cpu)
>  			      sint.as_uint64);
>  #endif
>  
> -	/* Enable global synic bit */
> -	sctrl.as_uint64 = hv_get_non_nested_msr(HV_MSR_SCONTROL);
> -	sctrl.enable = 1;
> -	hv_set_non_nested_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
> +	/* When VMBus is active it already enabled SCONTROL. */
> +	if (!vmbus_active) {
> +		union hv_synic_scontrol sctrl;
> +
> +		sctrl.as_uint64 = hv_get_non_nested_msr(HV_MSR_SCONTROL);
> +		sctrl.enable = 1;
> +		hv_set_non_nested_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
> +	}
>  
>  	return 0;
>  
> -cleanup:
> -	if (*event_ring_page) {
> -		sirbp.sirbp_enabled = false;
> -		hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
> -		memunmap(*event_ring_page);
> -	}
> -	if (*event_flags_page) {
> +cleanup_siefp:
> +	if (*event_flags_page)
> +		memunmap(*event_flags_page);
> +	if (!vmbus_active) {
>  		siefp.siefp_enabled = false;
>  		hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
> -		memunmap(*event_flags_page);
>  	}
> -	if (*msg_page) {
> +cleanup_simp:
> +	if (*msg_page)
> +		memunmap(*msg_page);
> +	if (!vmbus_active) {
>  		simp.simp_enabled = false;
>  		hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
> -		memunmap(*msg_page);
>  	}
>  
>  	return -EFAULT;
> @@ -545,16 +573,15 @@ int mshv_synic_init(unsigned int cpu)
>  int mshv_synic_cleanup(unsigned int cpu)
>  {
>  	union hv_synic_sint sint;
> -	union hv_synic_simp simp;
> -	union hv_synic_siefp siefp;
>  	union hv_synic_sirbp sirbp;
> -	union hv_synic_scontrol sctrl;
>  	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
>  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
>  	struct hv_synic_event_flags_page **event_flags_page =
>  		&spages->synic_event_flags_page;
>  	struct hv_synic_event_ring_page **event_ring_page =
>  		&spages->synic_event_ring_page;
> +	/* VMBus runs on L1VH and nested root; it owns SIMP/SIEFP/SCONTROL */
> +	bool vmbus_active = !hv_root_partition() || hv_nested;
>  
>  	/* Disable the interrupt */
>  	sint.as_uint64 = hv_get_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX);
> @@ -568,28 +595,47 @@ int mshv_synic_cleanup(unsigned int cpu)
>  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
>  			      sint.as_uint64);
>  
> -	/* Disable Synic's event ring page */
> +	/* Disable SYNIC event ring page owned by MSHV */
>  	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
>  	sirbp.sirbp_enabled = false;
> -	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
> -	memunmap(*event_ring_page);
>  
> -	/* Disable Synic's event flags page */
> -	siefp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIEFP);
> -	siefp.siefp_enabled = false;
> -	hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
> +	if (hv_root_partition()) {
> +		hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
> +		memunmap(*event_ring_page);
> +	} else {
> +		sirbp.base_sirbp_gpa = 0;
> +		hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
> +		free_page((unsigned long)*event_ring_page);
> +	}
> +
> +	/*
> +	 * Release our mappings of the message and event flags pages.
> +	 * When VMBus is not active, we enabled SIMP/SIEFP — disable
> +	 * them. Otherwise VMBus owns the MSRs — leave them.
> +	 */
>  	memunmap(*event_flags_page);
> +	if (!vmbus_active) {
> +		union hv_synic_simp simp;
> +		union hv_synic_siefp siefp;
>  
> -	/* Disable Synic's message page */
> -	simp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIMP);
> -	simp.simp_enabled = false;
> -	hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
> +		siefp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIEFP);
> +		siefp.siefp_enabled = false;
> +		hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
> +
> +		simp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIMP);
> +		simp.simp_enabled = false;
> +		hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
> +	}
>  	memunmap(*msg_page);
>  
> -	/* Disable global synic bit */
> -	sctrl.as_uint64 = hv_get_non_nested_msr(HV_MSR_SCONTROL);
> -	sctrl.enable = 0;
> -	hv_set_non_nested_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
> +	/* When VMBus is active it owns SCONTROL — leave it. */
> +	if (!vmbus_active) {
> +		union hv_synic_scontrol sctrl;
> +
> +		sctrl.as_uint64 = hv_get_non_nested_msr(HV_MSR_SCONTROL);
> +		sctrl.enable = 0;
> +		hv_set_non_nested_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.43.0
> 

