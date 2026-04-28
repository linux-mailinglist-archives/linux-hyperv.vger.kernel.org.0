Return-Path: <linux-hyperv+bounces-10452-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEvoNZxI8WmBfgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10452-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 01:54:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3275F48D95A
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 01:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB188311CC03
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 23:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AAA3A4F5B;
	Tue, 28 Apr 2026 23:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qtQpI9sc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25A83A257F;
	Tue, 28 Apr 2026 23:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777418882; cv=none; b=eD+4CDN/rnnKkyag3wx+L6LC1vQ9+XFQs0TzyBUCeJTP73hzTW9RniRZ4eVzSrQivRY6M4XZawgiH63wLbW9T9U/DUAQCra8P5lRUssGLMzms91nSsgkRwHZFkLAvjzwHvg8I98HbOFfhkMp4lw+OpjpZycAr1qkXFMwH/KHqBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777418882; c=relaxed/simple;
	bh=fGgQZC2sERJLrk2/nXp7gXzGvJME6YzZN2ymnD6iL6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGGp1O803GfaoDhBEQlMqFYtgcoJ6QjQuSnrEqi5MX/5M6NxG269TVm/+//U40kgWZTpxbKpm2fC39R5Vyx6nInD+P9cBumJAluAYt1Bo/b6Y9DRxTGlruxTgh3gvPaTqhwQw7PnVMzKOJw+dZBQY1u3++R2Vf2z6GLpf1ZNNh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qtQpI9sc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.129])
	by linux.microsoft.com (Postfix) with ESMTPSA id 00B6A20B716D;
	Tue, 28 Apr 2026 16:27:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 00B6A20B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777418879;
	bh=+AJMbTA4hHzjetlZw3P16jgwfQXDPJoISdnfUckSR+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qtQpI9sc6idtF+VaaXibeI9h/1B0YcUfdZoKLlmTRaCTAT+u0tiD0UwAsWtJuuQ5N
	 DoybBoHZyjRneS0ujVMVXyfx89HpTe9YJ1oKLJoACeqRhS8dfct5OlXS8L67uOMx9d
	 RoQOtthyJLcqCaisRHFjoJfOD/h+WLdFl5tj1o5E=
Date: Tue, 28 Apr 2026 16:27:56 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Jork Loeser <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Michael Kelley <mhklinux@outlook.com>,
	Anirudh Rayabharam <anirudh@anirudhrb.com>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mshv: limit SynIC management to MSHV-owned
 resources
Message-ID: <afFCfMmEnqjfg9Pe@skinsburskii.localdomain>
References: <20260427213855.1675044-1-jloeser@linux.microsoft.com>
 <20260427213855.1675044-2-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427213855.1675044-2-jloeser@linux.microsoft.com>
X-Rspamd-Queue-Id: 3275F48D95A
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10452-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com,anirudhrb.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,skinsburskii.localdomain:mid,linux.microsoft.com:dkim]

On Mon, Apr 27, 2026 at 02:38:52PM -0700, Jork Loeser wrote:
> The SynIC is shared between VMBus and MSHV. VMBus owns the message
> page (SIMP), event flags page (SIEFP), global enable (SCONTROL),
> and SINT2. MSHV adds SINT0, SINT5, and the event ring page (SIRBP).
> 
> Currently mshv_synic_cpu_init() redundantly enables SIMP, SIEFP, and
> SCONTROL that VMBus already configured, and mshv_synic_cpu_exit()
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
>   does not run, so MSHV must enable/disable them
> 
> While here, fix the SIEFP and SIRBP memremap() and virt_to_phys()
> calls to use HV_HYP_PAGE_SHIFT/HV_HYP_PAGE_SIZE instead of
> PAGE_SHIFT/PAGE_SIZE. The hypervisor always uses 4K pages for SynIC
> register GPAs regardless of the kernel page size, so using PAGE_SHIFT
> produces wrong addresses on ARM64 with 64K pages.
> 
> Note that initialization order matters - VMBUS first, MSHV second,
> and the reverse on de-init. Ideally, we would want a dedicated SYNIC
> driver that replaces the cross-dependencies with a clear API and
> dynamic tracking. Such refactor should go into its own dedicated
> series, outside of this kexec fix series.
> 
> Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
> ---
>  drivers/hv/hv.c         |   3 +
>  drivers/hv/mshv_synic.c | 150 ++++++++++++++++++++++++++--------------
>  2 files changed, 103 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index ae60fd542292..ef4b1b03395d 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -272,6 +272,9 @@ void hv_synic_free(void)
>  /*
>   * hv_hyp_synic_enable_regs - Initialize the Synthetic Interrupt Controller
>   * with the hypervisor.
> + *
> + * Note: When MSHV is present, mshv_synic_cpu_init() intializes further
> + * registers later.
>   */
>  void hv_hyp_synic_enable_regs(unsigned int cpu)
>  {
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index e2288a726fec..2db3b0192eac 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
> @@ -13,6 +13,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/hyperv.h>
>  #include <linux/reboot.h>
>  #include <asm/mshyperv.h>
>  #include <linux/acpi.h>
> @@ -456,46 +457,75 @@ static int mshv_synic_cpu_init(unsigned int cpu)
>  	union hv_synic_siefp siefp;
>  	union hv_synic_sirbp sirbp;
>  	union hv_synic_sint sint;
> -	union hv_synic_scontrol sctrl;
>  	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
>  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
>  	struct hv_synic_event_flags_page **event_flags_page =
>  			&spages->synic_event_flags_page;
>  	struct hv_synic_event_ring_page **event_ring_page =
>  			&spages->synic_event_ring_page;
> +	/*
> +	 * VMBus owns SIMP/SIEFP/SCONTROL when it is active.
> +	 * See hv_hyp_synic_enable_regs() for that initialization.
> +	 */
> +	bool vmbus_active = hv_vmbus_exists();
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
> -
> -	hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
> +		goto cleanup_simp;

It would be cleaner (and simpler to read), if there would be another
goto label to only unset HV_MSR_SIMP instead of checking *msg_page for
NULL again in the cleanup_simp label.

This applies to all the goto labels in this function.

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

>  
> -	/* Setup the Synic's event flags page */
> +	/*
> +	 * Map the event flags page. Same as SIMP: enable when
> +	 * VMBus is not active, already enabled by VMBus otherwise.
> +	 */
>  	siefp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIEFP);
> -	siefp.siefp_enabled = true;
> -	*event_flags_page = memremap(siefp.base_siefp_gpa << PAGE_SHIFT,
> -				     PAGE_SIZE, MEMREMAP_WB);
> +	if (!vmbus_active) {
> +		siefp.siefp_enabled = true;
> +		hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
> +	}
> +	*event_flags_page = memremap(siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT,
> +				     HV_HYP_PAGE_SIZE, MEMREMAP_WB);
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
> +		*event_ring_page = memremap(sirbp.base_sirbp_gpa << HV_HYP_PAGE_SHIFT,
> +					    HV_HYP_PAGE_SIZE, MEMREMAP_WB);
>  
> +		if (!(*event_ring_page))
> +			goto cleanup_siefp;
> +	} else {
> +		/*
> +		 * On L1VH the hypervisor does not provide a SIRBP page.
> +		 * Allocate one and program its GPA into the MSR.
> +		 */
> +		*event_ring_page = (struct hv_synic_event_ring_page *)
> +			get_zeroed_page(GFP_KERNEL);
> +
> +		if (!(*event_ring_page))
> +			goto cleanup_siefp;
> +
> +		sirbp.base_sirbp_gpa = virt_to_phys(*event_ring_page)
> +				>> HV_HYP_PAGE_SHIFT;
> +	}
> +
> +	sirbp.sirbp_enabled = true;
>  	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
>  
>  	if (mshv_sint_irq != -1)
> @@ -518,28 +548,30 @@ static int mshv_synic_cpu_init(unsigned int cpu)
>  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
>  			      sint.as_uint64);
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
> @@ -548,16 +580,15 @@ static int mshv_synic_cpu_init(unsigned int cpu)
>  static int mshv_synic_cpu_exit(unsigned int cpu)
>  {
>  	union hv_synic_sint sint;
> -	union hv_synic_simp simp;
> -	union hv_synic_siefp siefp;
>  	union hv_synic_sirbp sirbp;
> -	union hv_synic_scontrol sctrl;
>  	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
>  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
>  	struct hv_synic_event_flags_page **event_flags_page =
>  		&spages->synic_event_flags_page;
>  	struct hv_synic_event_ring_page **event_ring_page =
>  		&spages->synic_event_ring_page;
> +	/* VMBus owns SIMP/SIEFP/SCONTROL when it is active */
> +	bool vmbus_active = hv_vmbus_exists();
>  
>  	/* Disable the interrupt */
>  	sint.as_uint64 = hv_get_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX);
> @@ -574,28 +605,47 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
>  	if (mshv_sint_irq != -1)
>  		disable_percpu_irq(mshv_sint_irq);
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

