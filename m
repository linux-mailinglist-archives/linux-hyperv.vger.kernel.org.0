Return-Path: <linux-hyperv+bounces-11393-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGJxOcNUGmpE3AgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11393-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 05:08:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4945460B0CB
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 05:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06E7D3011F24
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 03:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E17A3438B1;
	Sat, 30 May 2026 03:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RlZugvf2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC5A31E82F;
	Sat, 30 May 2026 03:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780110515; cv=none; b=WMt/TaWUpLZz3QkZr3fL14CZXzKhGKNfJovKGLZnqemUNRlIQ1RXM1rzgqZX39RWPwinh5qFCuNl2pwY9mJ5tEK6ick/xZYXn7gkzJ3e22Dt/8BpRt0XbUl6G+pRShc4ZDDIClqXHZnrC8k1ZodzS68n1KAltLmY+6DMgrLSt9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780110515; c=relaxed/simple;
	bh=OeUvWYhtnIcVniNlaEAPf7t6L7no4/+FQ0TEbE0p0E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOshQN89YOoa+YGBy+wPEf3v8aIL1mRZA/3xwwE6/JzWjmCABec41k5u53KvD0F1GXUNYWrUJdaLmIZ7tvClSSAd/oNSmgL/mwEQuY8l5kTKaVvI7NRUs6CW4YVRyrUwqqjspDg//nePky852zL7NkR+ECV48fwZC/KyJ3XK998=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RlZugvf2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A8F6540E015B;
	Sat, 30 May 2026 03:08:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PuzC0Ft-HHGf; Sat, 30 May 2026 03:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1780110500; bh=xvvniitijThI5M/vzeUngJ2o5o2bAFGL6v1h1J/weaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RlZugvf28JewjKobWij+z7qIEzuJleC7UW1AkwP8rIPfgHvDVyKCrVyw/Qymrp83Z
	 oMbgDR2FbH11di++QnPPImwLEX2QWfLIIXSP1ypHOZXuL8uzhRYviGTB6dzv+qnCeb
	 Gpjy/sGySdR+2Du+p++dlzJkZH9f7yDl1Iu2Fre6FT/CcfHszYCqFtrvvnC9mv0qHc
	 VeeoN4BaHXjs2/UWNE6zir9SYUOs75Xg4Of1T4uw5yhGpFM4a3E1cmNVNmJaKIUq6R
	 yPy/Ir3fplxnFBnCyQR1Mih6ew0Q+bN5yquZw+MmRi4V8Lj+CiVHxa20Vu+5eKSmYk
	 giEEXZB1RSLVAV6SsDTp793DrNhxj4wm0EvU2xn+GoJTqXtQ7jCQ/UV7q72yZwrhw6
	 Hr/fzxFzU2n0bEEtOtOgL6M+OPmeiiF9CNlohP/WUUTGr0G7qVWyY3IBL6L60qHrmi
	 G28aB2e/4cv56a+4WyUu0hncXyyo8wJb54Pd1OOsv3eUOm/6ojaoKm4aTJ7E2o38BY
	 +wUXFuMdzDYShBipYVX8+o8FNNEGBfWyPWxpIXqjj6tOadHwHan4leJuqlNl1iFQ/z
	 P8Ic44MZ/AWAUKuhucIKSKuYuKaxZPvVv03zf0laMmYz+Zwgn1PGjB2t4S2+q2afEM
	 hP4TtO4p/8Y97d14SV7L5qrs=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00:b8a3:f58e:8829:9ca6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8255040E015A;
	Sat, 30 May 2026 03:07:41 +0000 (UTC)
Date: Fri, 29 May 2026 20:07:31 -0700
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Kiryl Shutsemau <kas@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juergen Gross <jgross@suse.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	John Stultz <jstultz@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 01/47] x86/tsc: Never re-calibrate TSC frequency if
 its exact timing is known
Message-ID: <20260530030731.GBahpUcwWXdKCf1lJO@fat_crate.local>
References: <20260529144435.704127-1-seanjc@google.com>
 <20260529144435.704127-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529144435.704127-2-seanjc@google.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,linux.intel.com,microsoft.com,broadcom.com,siemens.com,infradead.org,suse.com,google.com,zytor.com,intel.com,oracle.com,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amazon.co.uk,amd.com,outlook.com,linutronix.de];
	TAGGED_FROM(0.00)[bounces-11393-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	DKIM_TRACE(0.00)[alien8.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alien8.de:dkim]
X-Rspamd-Queue-Id: 4945460B0CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 07:43:48AM -0700, Sean Christopherson wrote:
> Don't re-calibrate the TSC frequency if the TSC is known to run at a fixed
> frequency.  In practice, this is likely one big nop, as re-calibration is
> used only for SMP=n kernels, and only for hardware that is 20+ years old,
> i.e. is extremely unlikely to collide with TSC_KNOWN_FREQ.

Why do we care?

So what if it recalibrates once on UP?

Look where it is called - all old rust which no one uses anymore.

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kernel/tsc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index c5110eb554bc..08cf6625d484 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -946,7 +946,8 @@ void recalibrate_cpu_khz(void)
>  		return;
>  
>  	cpu_khz = x86_platform.calibrate_cpu();
> -	tsc_khz = x86_platform.calibrate_tsc();
> +	if (!boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ))

cpu_feature_enabled() everywhere please.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

