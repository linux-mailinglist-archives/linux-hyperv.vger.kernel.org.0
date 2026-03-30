Return-Path: <linux-hyperv+bounces-9845-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBFHAojqymkkBQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9845-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 23:26:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A467D36170F
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 23:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0667E30117E0
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 21:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181A4374E4B;
	Mon, 30 Mar 2026 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="E2l4jyTY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA60C393DC0;
	Mon, 30 Mar 2026 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905980; cv=none; b=nd17is8FHMyFKPWlsPHvZ4SUO3aybttT7m5rp1O4bz+zoNNOePMDbekc6c0MVup827vIWumfVjhEQYovvkd+44+EzaBUtHEvdq7aTK1pnqhyxQ/Hpv+oDR8yUjzniwk5gHTxInRrg6PpdEvQHL0jMkrrrrDKKzZyg5QcXK3tYXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905980; c=relaxed/simple;
	bh=WnWt+zkYpOa/7ZKykkqroK8i3DQizKaUKfKyA6SCZU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+ifU8Yn4jwOD7sO3YIFfOyHjBf+H5DHz8xxgmX7Ufl7QC0n/TJUR7yK/mSBs7r3QPewZIuMPkYOYQKWNUmQF5hjzUfmE2HAg0ZWmw7sAhXag7z9jgDigTHVUqrEeFydeIr4+SdBFkbbbKpg+k931IRRFn/1xbphZGgAaYBcT0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=E2l4jyTY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5FA2A20B6F08;
	Mon, 30 Mar 2026 14:26:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5FA2A20B6F08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774905978;
	bh=iwexl/VTXrdqzvcb7sa2C/2scP40y3uvZwANwtHP7rA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E2l4jyTYG0UmNHKa9Q+Z2Y23ogjsYJ2Y0LBe4YhQdVtkfeKfY6yRVqPsLzZr1sdni
	 kZ/rRT/84P0akZYTK4OYpm4OE5DK6391MvY7kj99iL/tgudUda9HFQaGCrGy8IOKKc
	 7LU+VfoQ66NusTlMThOKLX3aXfzn2+hUsfBk7/MA=
Date: Mon, 30 Mar 2026 14:26:16 -0700
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
	linux-arch@vger.kernel.org,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>
Subject: Re: [PATCH 2/6] x86/hyperv: move stimer cleanup to
 hv_machine_shutdown()
Message-ID: <acrqeFYDfIJ3uFis@skinsburskii.localdomain>
References: <20260327201920.2100427-1-jloeser@linux.microsoft.com>
 <20260327201920.2100427-3-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327201920.2100427-3-jloeser@linux.microsoft.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9845-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linux.microsoft.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,skinsburskii.localdomain:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: A467D36170F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 01:19:13PM -0700, Jork Loeser wrote:
> Move hv_stimer_global_cleanup() from vmbus's hv_kexec_handler() to
> hv_machine_shutdown() in the platform code. This ensures stimer cleanup
> happens before the vmbus unload, which is required for root partition
> kexec to work correctly.
> 

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

> Co-developed-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
> Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
> Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 8 ++++++--
>  drivers/hv/vmbus_drv.c         | 1 -
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 89a2eb8a0722..235087456bdf 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -235,8 +235,12 @@ void hv_remove_crash_handler(void)
>  #ifdef CONFIG_KEXEC_CORE
>  static void hv_machine_shutdown(void)
>  {
> -	if (kexec_in_progress && hv_kexec_handler)
> -		hv_kexec_handler();
> +	if (kexec_in_progress) {
> +		hv_stimer_global_cleanup();
> +
> +		if (hv_kexec_handler)
> +			hv_kexec_handler();
> +	}
>  
>  	/*
>  	 * Call hv_cpu_die() on all the CPUs, otherwise later the hypervisor
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 301273d61892..5d1449f8c6ea 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2892,7 +2892,6 @@ static struct platform_driver vmbus_platform_driver = {
>  
>  static void hv_kexec_handler(void)
>  {
> -	hv_stimer_global_cleanup();
>  	vmbus_initiate_unload(false);
>  	/* Make sure conn_state is set as hv_synic_cleanup checks for it */
>  	mb();
> -- 
> 2.43.0
> 

