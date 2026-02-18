Return-Path: <linux-hyperv+bounces-8883-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKV2Hp1nlWk/QgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8883-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 08:17:49 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0770C153983
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 08:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C60E3007497
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 07:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA17301485;
	Wed, 18 Feb 2026 07:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nouSERTa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C98230BD9;
	Wed, 18 Feb 2026 07:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771399063; cv=none; b=J1w5siSdeXRs46VOsSKTqkN2SfsQ5wZNZ0aMLIs+pAUlOdr0llXYRoYY8oVdCZuFGAiKHPshydbUciJLPGj+cz0Ao4gfaXDpoun5K/yU13VXkKoB2eLTy3p+KtPTIaJsOhpAHNdxee/a3AWRE/AAHP3AmV0IVs5IsojeNRjsjcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771399063; c=relaxed/simple;
	bh=gq4kKh19nvaT8ucOYavrwynXCs8Z/9LceQkjd7TEXAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXnwM/y56gN8wit+Cb3z5Q4LAX1r1af4vq7uWk3KP0798BZiIFyV4l1VWN1KuSO8ZyQ91aINkW62JD4fxndVMoIz+/Xhax6IzPxvcWaWKrUUo9AsfeK6yW77QlgWW3+uB9AvQrNn/T/7sU35OKvNLq272P/4m9CBrB04ZjAo0io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nouSERTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7817C19421;
	Wed, 18 Feb 2026 07:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771399062;
	bh=gq4kKh19nvaT8ucOYavrwynXCs8Z/9LceQkjd7TEXAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nouSERTa2cR4HbrTdi52zkQUoSn35G7tARn842qkXAh/QzifxerFaQmST2qm0xfwz
	 Xo6TaHLyvKjrgw66nBsw1xscriUYxoFA3Xy6dQt/1qdy1ZccrxG98Vi9vYOWS+3VuT
	 R1KgK9rTWzHkfGh95cfDbim2pSGtKzAeAsDKIJpgWhVGewKOGdAFf2xHN7X0Zp8BWs
	 lNWBlVo1hMJQIJMDgN5Y8cJdsi1Na8AxuBq+riP56uhESo03MLEiW412QH7GJWXm2i
	 aZFE1eEMjaGvz3ZjgO/dH0OH/yQJeBvFO2w39P6zWOs4m+JAujAG4PsE8YIQgh0ZMN
	 sSz+8yfdN/88Q==
Date: Wed, 18 Feb 2026 07:17:41 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com
Subject: Re: [PATCH v2] x86/hyperv: Reserve 3 interrupt vectors used
 exclusively by mshv
Message-ID: <20260218071741.GG2236050@liuwe-devbox-debian-v2.local>
References: <20260217231158.1184736-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217231158.1184736-1-mrathor@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8883-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: 0770C153983
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 03:11:58PM -0800, Mukesh R wrote:
> From: Mukesh Rathor <mrathor@linux.microsoft.com>
> 
> MSVC compiler, used to compile the Microsoft Hyper-V hypervisor currently,
> has an assert intrinsic that uses interrupt vector 0x29 to create an
> exception. This will cause hypervisor to then crash and collect core. As
> such, if this interrupt number is assigned to a device by Linux and the
> device generates it, hypervisor will crash. There are two other such
> vectors hard coded in the hypervisor, 0x2C and 0x2D for debug purposes.
> Fortunately, the three vectors are part of the kernel driver space and
> that makes it feasible to reserve them early so they are not assigned
> later.
> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
> 
> v1: Add ifndef CONFIG_X86_FRED (thanks hpa)
> v2: replace ifndef with cpu_feature_enabled() (thanks hpa and tglx)
> 
>  arch/x86/kernel/cpu/mshyperv.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 579fb2c64cfd..88ca127dc6d4 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -478,6 +478,28 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>  }
>  EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
>  
> +/*
> + * Reserve vectors hard coded in the hypervisor. If used outside, the hypervisor
> + * will either crash or hang or attempt to break into debugger.
> + */
> +static void hv_reserve_irq_vectors(void)
> +{
> +	#define HYPERV_DBG_FASTFAIL_VECTOR	0x29
> +	#define HYPERV_DBG_ASSERT_VECTOR	0x2C
> +	#define HYPERV_DBG_SERVICE_VECTOR	0x2D
> +
> +	if (cpu_feature_enabled(X86_FEATURE_FRED))
> +		return;
> +
> +	if (test_and_set_bit(HYPERV_DBG_ASSERT_VECTOR, system_vectors) ||
> +	    test_and_set_bit(HYPERV_DBG_SERVICE_VECTOR, system_vectors) ||
> +	    test_and_set_bit(HYPERV_DBG_FASTFAIL_VECTOR, system_vectors))
> +		BUG();
> +
> +	pr_info("Hyper-V:reserve vectors: %d %d %d\n", HYPERV_DBG_ASSERT_VECTOR,
> +		HYPERV_DBG_SERVICE_VECTOR, HYPERV_DBG_FASTFAIL_VECTOR);
> +}
> +
>  static void __init ms_hyperv_init_platform(void)
>  {
>  	int hv_max_functions_eax, eax;
> @@ -510,6 +532,11 @@ static void __init ms_hyperv_init_platform(void)
>  
>  	hv_identify_partition_type();
>  
> +#ifndef CONFIG_X86_FRED
> +	if (hv_root_partition())
> +		hv_reserve_irq_vectors();
> +#endif	/* CONFIG_X86_FRED */
> +

On a CONFIG_X86_FRED=y system, this call is skipped. However, the kernel
may not have FRED active, so the vectors should still be reserved.

I think the function should always be called.

Wei

>  	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
>  		ms_hyperv.hints |= HV_DEPRECATING_AEOI_RECOMMENDED;
>  
> -- 
> 2.51.2.vfs.0.1
> 
> 

