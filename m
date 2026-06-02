Return-Path: <linux-hyperv+bounces-11449-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id v0zKCQJTHmqDigkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11449-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 02 Jun 2026 05:50:26 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9CA627E19
	for <lists+linux-hyperv@lfdr.de>; Tue, 02 Jun 2026 05:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED6F1301F316
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Jun 2026 03:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15847285CA2;
	Tue,  2 Jun 2026 03:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BRMb1T+l"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB521A01BE;
	Tue,  2 Jun 2026 03:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780372221; cv=none; b=myNaeHUEyHtWVivkAIPWH5jSapnNAkWha7plulu/IbJgdcVTUQctf3ycQlCKuaZYSqAc0A8+3WoiBGOspU7T2z0WmNZd/NbsurU7008bli0inGzxjUKLLSklDPp9CLfNQ8argUZ22CiuBIrwIeWeVUsXnQhPKlfAidB//L0fNh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780372221; c=relaxed/simple;
	bh=9sr2irVxdUl8CzOcLwp+rJ3CtWHA2j/elSxxJH5GLqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgRvSgrzDeqTF0sPAXQI8RsxYt5RG6ZTREYDDs3wTOxKDjigdGazqAazoHd15hwPnp6uScTPCG4uDQ6fu5WX89YQ8+ONUbfB7e+WY8k4Mqs4KUqoWNNDj33cxtfPiMkAn0z3OOWWvVRr2SrX41HhZvR6EWDdsmHgg1Q+hOY73+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BRMb1T+l; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BDD1140E0140;
	Tue,  2 Jun 2026 03:50:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rZ_Ke2IbpmQx; Tue,  2 Jun 2026 03:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1780372206; bh=HH13uV+Z55mhxzoi6FErPEsztGrj9z0uUROqU3Stz7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BRMb1T+l+1IEZY4TOjMQ4w9ReoLidSSyCALG5lXh6uQPdtJJQdXO/YpIwNlbAph4G
	 l/Dh+tFMKmPgVvKipIF2u99KtO2EN4cAREtpsqdKPkOqerozWTYAFwi46Wybtw/fbe
	 +vmegLk87Rbq8vbD1H6DVOK2BrOKVAvWoMdxIbDT51x5lCY8z551GuWp9FhHp5+car
	 VfJLFeyoLUyJO6c15FDGEfyv+Rbc53q3q5OSovUcXOREzvcqEjbwoVe0Y7wIViYOYy
	 dK617hXkXVl9eYOJXWLlMawnI/pzDgQLxVC0VmuhZxwuyaJg1r6HaVHRONeWchNvGu
	 vuUBlnvH9mmhMammOcSRyPnYSNm/ouhxvpjBC/kkh+mImmroEj5FFwKdESFRHD587M
	 WZc+lXnb/l4BjyEVAAGNP2cLctZRPQKFYevllLAVNJtLle0Ashf1Pb13YdcdHN1spM
	 rkF/jhg93VsSnzNK3JT36gNuh51JJh4mRth91IoSXBMOPYx6eLMZftQjrevQIQewk4
	 r73TYm4D6cnm0I9ePqYDRkUs1jK14EW1+rpqzoVUj1phZqDDalP0khp5WsBql7Ff4D
	 DlzFTsjW4cZGQdPzsWOWFWXdC25leop27h508hIBBoyX6ymrK7PIpoEE1rrc0t6G1Y
	 cqjQSDM1OdJJ7XcJilcWD9FQ=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ADDBA40E01B5;
	Tue,  2 Jun 2026 03:49:27 +0000 (UTC)
Date: Mon, 1 Jun 2026 20:49:16 -0700
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
Subject: Re: [PATCH v4 02/47] x86/tsc: Add a standalone helpers for getting
 TSC info from CPUID.0x15
Message-ID: <20260602034916.GGah5SvARd77mkvxe3@fat_crate.local>
References: <20260529144435.704127-1-seanjc@google.com>
 <20260529144435.704127-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529144435.704127-3-seanjc@google.com>
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
	TAGGED_FROM(0.00)[bounces-11449-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alien8.de:dkim]
X-Rspamd-Queue-Id: 6F9CA627E19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 07:43:49AM -0700, Sean Christopherson wrote:
> +static int cpuid_get_tsc_info(struct cpuid_tsc_info *info)
> +{
> +	unsigned int ecx_hz, edx;
> +
> +	memset(info, 0, sizeof(*info));

Let's not clear this unnecessarily...

> +
> +	if (boot_cpu_data.cpuid_level < CPUID_LEAF_TSC)
> +		return -ENOENT;

... just to return here...

> +
> +	/* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
> +	cpuid(CPUID_LEAF_TSC, &info->denominator, &info->numerator, &ecx_hz, &edx);
> +
> +	if (!info->denominator || !info->numerator)
> +		return -ENOENT;

... or here.

We wanna clear it here, when we'll return success.

> +
> +	/*
> +	 * Note, some CPUs provide the multiplier information, but not the core

	Note: some CPUs...

> +	 * crystal frequency.  The multiplier information is still useful for
> +	 * such CPUs, as the crystal frequency can be gleaned from CPUID.0x16.
> +	 */
> +	info->crystal_khz = ecx_hz / 1000;
> +	return 0;
> +}
> +
> +int __init cpuid_get_tsc_freq(struct cpuid_tsc_info *info)
> +{
> +	if (cpuid_get_tsc_info(info) || !info->crystal_khz)
> +		return -ENOENT;
> +
> +	info->tsc_khz = info->crystal_khz * info->numerator / info->denominator;
> +	return 0;
> +}

Unused here. Add it with its first user pls.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

