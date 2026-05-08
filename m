Return-Path: <linux-hyperv+bounces-10711-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBL4InSs/WlOhgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10711-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 08 May 2026 11:27:16 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C02784F43C3
	for <lists+linux-hyperv@lfdr.de>; Fri, 08 May 2026 11:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B113D3030B1C
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 May 2026 09:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1533A3833;
	Fri,  8 May 2026 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogWfq3Zc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6943438F945;
	Fri,  8 May 2026 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232336; cv=none; b=UtNz6b/2IWju0ymbEnbAI/VFmDJ25VB6Qxq9MlkzgN5e6RENegOMXVkgoaqlh4PAVUEyZt4tMvzwYCDj/P+trJL7c1r5ETMCn0skbhCPJyd2nCCjIlrSi9KKDZm97MupSbbu42UFc67/QTqxVn7GHsq64roC+HnbO/UjlCA6YDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232336; c=relaxed/simple;
	bh=eXP0oMTZAYd//JjTRl4w7nF1MEv2B4XDSDUlXIvROs8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qM/+NYRJpABYM9iY2wbn962CA+FFaJzL3Dr13m2PXS9qqkAjeF/j6cBglUJcmLxySOZMcEDUDv4n80Va2JfKOZTVpPRPrm071drJxzC4SGg7PK14WK3IgHCNFX/qCvV6oMvItxMWzERMOAN+KxZ1AgzZMP4GBEXAPRdFVnFu1Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogWfq3Zc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59F7C2BCB0;
	Fri,  8 May 2026 09:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778232336;
	bh=eXP0oMTZAYd//JjTRl4w7nF1MEv2B4XDSDUlXIvROs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ogWfq3ZcnhE2rqKxT1vCgd4yENO8ZYiD5dns210a3Vrra4P5WBxPcSD6//cB9jijc
	 hzQme7ttEn9uwpAmEEHcfKDLBRvUSk/TA1LWcGJybqiWgRm+Ea19wgnpZhBTTe8Bi/
	 BbbKH1nC4pKpduK2HnleCXarp6HKwrsamC7TDZOms8JYHxOJoY9aGDDRulc46LErEJ
	 0QS9PLUKncr4AHWMVAcBTNuyCHfOHIAgNkNthUirODdYQ4FMQ+IzA2fnsH1n4pBHee
	 0XN7ETfCS+ur3akfTuS/lx09FAfm7SxzS8qe6VkzjVU6DfuchNzUVVWcCu6PSruZih
	 v1JULYOzLHELQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wLHSf-00000000H25-175L;
	Fri, 08 May 2026 09:25:33 +0000
Date: Fri, 08 May 2026 10:25:32 +0100
Message-ID: <86mryaxng3.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Michael Kelley <mhklinux@outlook.com>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	vdso@mailbox.org,
	ssengar@linux.microsoft.com
Subject: Re: [PATCH v2 07/15] arm64: hyperv: Add support for mshv_vtl_return_call
In-Reply-To: <f4059f5d-a82b-40c2-942e-3e24cefab94f@linux.microsoft.com>
References: <20260423124206.2410879-1-namjain@linux.microsoft.com>
	<20260423124206.2410879-8-namjain@linux.microsoft.com>
	<aeolHwXHFH4AnX_n@J2N7QTR9R3.cambridge.arm.com>
	<f4059f5d-a82b-40c2-942e-3e24cefab94f@linux.microsoft.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: namjain@linux.microsoft.com, mark.rutland@arm.com, kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com, catalin.marinas@arm.com, will@kernel.org, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, mhklinux@outlook.com, timothy.hayes@arm.com, lpieralisi@kernel.org, sascha.bischoff@arm.com, mrigendra.chaubey@gmail.com, linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, vdso@mailbox.org, ssengar@linux.microsoft.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Rspamd-Queue-Id: C02784F43C3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[arm.com,microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,outlook.com,gmail.com,vger.kernel.org,lists.infradead.org,mailbox.org,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10711-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maz@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 29 Apr 2026 10:56:11 +0100,
Naman Jain <namjain@linux.microsoft.com> wrote:
> 

[...]

> Merging threads for addressing comments from Mark Rutland and Marc
> Zyngier on this patch.
> 
> Thanks for reviewing the changes. Please allow me to briefly explain
> the use case here and then address your comments.
> 
> Hyper-V's Virtual Trust Levels (VTLs) provide hardware-enforced
> isolation within a single VM, analogous to ARM TrustZone. The kernel
> runs in VTL2 (higher privilege) as a "paravisor", a security monitor
> that handles intercepts for the primary OS in VTL0 (lower
> privilege). The VTL switch (mshv_vtl_return_call) is functionally
> equivalent to KVM's guest enter/exit. It saves VTL2 state, loads
> VTL0's GPRs other registers from a shared context structure, issues
> hvc #3 to let VTL0 run, and on return saves VTL0's updated state back.

No, this is fundamentally different. KVM is purely architectural,
doesn't try to "sanitise" anything, and context switches *all* of the
guest state. No ifs, no buts, no "reserved registers".

[...]

> Regarding Non-SMCCC "hvc #3" call, I have a limitation here owing to
> the ABI that is defined by the Hyper-V hypervisor. Fixing this
> requires a hypervisor-side change to support SMCCC-style dispatch for
> VTL return. Until then, hvc #3 is the only working interface. Moreover
> there would be backward compatibility issues with this new ABI
> interface, if at all it is added.

Left hand, please talk to right hand. This is not the first time we
push back on this, and we already had this annoying discussion back
when arm64 as a Hyper-V guest was first proposed (6, 7 years ago?).

What has changed since? Absolutely nothing.

If the Hyper-V folks decide to ignore the standard and go their own
way, that's fine. They only get to keep the pieces.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

