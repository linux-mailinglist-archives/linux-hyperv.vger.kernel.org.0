Return-Path: <linux-hyperv+bounces-9848-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAuUKZbwymkkBQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9848-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 23:52:22 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 471373619E2
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 23:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80116301E31D
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 21:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907963A75B7;
	Mon, 30 Mar 2026 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pa3Ho+c9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468473A75A1;
	Mon, 30 Mar 2026 21:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907539; cv=none; b=NelEJAiocmGlHJ1J4Qa8EeRyH8RBk7FO4H4iqRwcs1WaqNh8PkPqdPhOoBvEZ2eLp8zG2UG3YAb0BXF9UZRZ+pjR2uyU7kqFZDiHQkb3M/u2V27jd+Lk0mM0GNimAPIMegDKAIm+rzOjj3VpFLsP5xXZsQ93/rdNE1hUaTFzgGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907539; c=relaxed/simple;
	bh=BCjewrZTIaDWoTZ5QhLyzSUKzFxhfaGmghJXfAyINj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfUTIc5PNSqaf76MGOaicCEOSb/uNpzHdhKlqzqJGMYJAWmOobAxF3xjwzpQjei5+YcFX4T0uhnlUb7FbhNZe3qnvJIrK6DEX3HJpNKjJ3Oe2aKWXYijKMHKoTZbm3wkzgKYF1upLLpNDXcoCt7esx8ML9wU+XufEvc1fXD6A50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pa3Ho+c9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 480FB20B6F01;
	Mon, 30 Mar 2026 14:52:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 480FB20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774907537;
	bh=N++eca/16xf4MrBSGchRprBfAERSB8YTi5GziquOX1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pa3Ho+c9ev2z5WowdHag+uJSFyqmJbi21eKkkDhZkWFBKRF3DvzMADtKnmuKnFH1y
	 MHLebNmkcWyNYnY89StDjxkZnCwRetEa1LMm7iTiTRZvuxpu/pwySSzYmPC9ZgiIfB
	 +Lbm3h9o/2tTlSsStDaydqmGDQQDA3UrBBuQkTR8=
Date: Mon, 30 Mar 2026 14:52:15 -0700
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
	Roman Kisel <romank@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 5/6] mshv: clean up SynIC state on kexec for L1VH
Message-ID: <acrwj1pqyp70cia-@skinsburskii.localdomain>
References: <20260327201920.2100427-1-jloeser@linux.microsoft.com>
 <20260327201920.2100427-6-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327201920.2100427-6-jloeser@linux.microsoft.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9848-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linux.microsoft.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,skinsburskii.localdomain:mid]
X-Rspamd-Queue-Id: 471373619E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 01:19:16PM -0700, Jork Loeser wrote:
> Register the mshv reboot notifier for all parent partitions, not just
> root. Previously the notifier was gated on hv_root_partition(), so on
> L1VH (where hv_root_partition() is false) SINT0, SINT5, and SIRBP were
> never cleaned up before kexec. The kexec'd kernel then inherited stale
> unmasked SINTs and an enabled SIRBP pointing to freed memory.
> 
> The L1VH SIRBP also needs special handling: unlike the root partition
> where the hypervisor provides the SIRBP page, L1VH must allocate its
> own page and program the GPA into the MSR. Add this allocation to
> mshv_synic_init() and the corresponding free to mshv_synic_cleanup().
> 
> Remove the unnecessary mshv_root_partition_init/exit wrappers and
> register the reboot notifier directly in mshv_parent_partition_init().
> Make mshv_reboot_nb static since it no longer needs external linkage.
> 

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

> Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c | 21 ++++-----------------
>  drivers/hv/mshv_synic.c     | 37 ++++++++++++++++++++++++++++++-------
>  2 files changed, 34 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index e6509c980763..281f530b68a9 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2256,20 +2256,10 @@ static int mshv_reboot_notify(struct notifier_block *nb,
>  	return 0;
>  }
>  
> -struct notifier_block mshv_reboot_nb = {
> +static struct notifier_block mshv_reboot_nb = {
>  	.notifier_call = mshv_reboot_notify,
>  };
>  
> -static void mshv_root_partition_exit(void)
> -{
> -	unregister_reboot_notifier(&mshv_reboot_nb);
> -}
> -
> -static int __init mshv_root_partition_init(struct device *dev)
> -{
> -	return register_reboot_notifier(&mshv_reboot_nb);
> -}
> -
>  static int __init mshv_init_vmm_caps(struct device *dev)
>  {
>  	int ret;
> @@ -2339,8 +2329,7 @@ static int __init mshv_parent_partition_init(void)
>  	if (ret)
>  		goto remove_cpu_state;
>  
> -	if (hv_root_partition())
> -		ret = mshv_root_partition_init(dev);
> +	ret = register_reboot_notifier(&mshv_reboot_nb);
>  	if (ret)
>  		goto remove_cpu_state;
>  
> @@ -2368,8 +2357,7 @@ static int __init mshv_parent_partition_init(void)
>  deinit_root_scheduler:
>  	root_scheduler_deinit();
>  exit_partition:
> -	if (hv_root_partition())
> -		mshv_root_partition_exit();
> +	unregister_reboot_notifier(&mshv_reboot_nb);
>  remove_cpu_state:
>  	cpuhp_remove_state(mshv_cpuhp_online);
>  free_synic_pages:
> @@ -2387,8 +2375,7 @@ static void __exit mshv_parent_partition_exit(void)
>  	misc_deregister(&mshv_dev);
>  	mshv_irqfd_wq_cleanup();
>  	root_scheduler_deinit();
> -	if (hv_root_partition())
> -		mshv_root_partition_exit();
> +	unregister_reboot_notifier(&mshv_reboot_nb);
>  	cpuhp_remove_state(mshv_cpuhp_online);
>  	free_percpu(mshv_root.synic_pages);
>  }
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index 8a7d76a10dc3..32f91a714c97 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
> @@ -495,13 +495,29 @@ int mshv_synic_init(unsigned int cpu)
>  
>  	/* Setup the Synic's event ring page */
>  	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
> -	sirbp.sirbp_enabled = true;
> -	*event_ring_page = memremap(sirbp.base_sirbp_gpa << PAGE_SHIFT,
> -				    PAGE_SIZE, MEMREMAP_WB);
>  
> -	if (!(*event_ring_page))
> -		goto cleanup_siefp;
> +	if (hv_root_partition()) {
> +		*event_ring_page = memremap(sirbp.base_sirbp_gpa << PAGE_SHIFT,
> +					    PAGE_SIZE, MEMREMAP_WB);
> +
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
>  
> +		sirbp.base_sirbp_gpa = virt_to_phys(*event_ring_page)
> +				>> PAGE_SHIFT;
> +	}
> +
> +	sirbp.sirbp_enabled = true;
>  	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
>  
>  #ifdef HYPERVISOR_CALLBACK_VECTOR
> @@ -581,8 +597,15 @@ int mshv_synic_cleanup(unsigned int cpu)
>  	/* Disable SYNIC event ring page owned by MSHV */
>  	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
>  	sirbp.sirbp_enabled = false;
> -	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
> -	memunmap(*event_ring_page);
> +
> +	if (hv_root_partition()) {
> +		hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
> +		memunmap(*event_ring_page);
> +	} else {
> +		sirbp.base_sirbp_gpa = 0;
> +		hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
> +		free_page((unsigned long)*event_ring_page);
> +	}
>  
>  	/*
>  	 * Release our mappings of the message and event flags pages.
> -- 
> 2.43.0
> 

