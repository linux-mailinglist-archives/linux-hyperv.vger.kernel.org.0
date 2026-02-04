Return-Path: <linux-hyperv+bounces-8708-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEwkL1/1gmn6fgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8708-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 08:29:35 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26389E2B43
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 08:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD291302EEBA
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Feb 2026 07:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29CB38BF90;
	Wed,  4 Feb 2026 07:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="De7bxztN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7932BE630;
	Wed,  4 Feb 2026 07:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770190172; cv=none; b=h+vPU37uWUTTp2WDAhUMXj2pK6N1uq7njGuq535xiGN6lptNcSh4Q3Pws/Xrk1O6btED6f67323lP0OX1b/r9FhyQ7dpPHIH4PvbQrduMrYrE4cZSSD/+ILnT7V6YF3GcnOJWJ6sqpnIyELasZAjqy7Yh0X2L6SQR5YhUONWF2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770190172; c=relaxed/simple;
	bh=xxWg4NATlQnnRZAA+H5DGTM81NA/jsuCbJ86jsJjATg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SppXaoixEID/zSTJF1ub5KtJXqIvcZTTdL/Gc4WGGNzSD3UTed05gfr9BAOjFYYHe8dcidqCcutT73HIYyRdlwCJW4iI71w7ymB3WM2l3ypSH1SMmBAvL7thLsc8q5uUIxqTOPHZaOtV/Ts6weRwY/6y9BZiI5tTRHE92M7jNKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=De7bxztN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31133C4CEF7;
	Wed,  4 Feb 2026 07:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770190172;
	bh=xxWg4NATlQnnRZAA+H5DGTM81NA/jsuCbJ86jsJjATg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=De7bxztNz1Fbm5dYJ3hK2UXPimHWoB6gko1bYrjdJiRsU/OlNqEXzpKIHB1GVxqqf
	 LoeCXd4Fmbr963NxB9UUBX1xvDuq56l043/y2ubbyzGBc8rsNRBbUHIfBn4ihbQUj7
	 k0TZpv9uNVHxrQCVGfX5pDG5DVi1kggLnIIklCaof1VJplsH12UmEPlDe41nqYdskC
	 vmxS6BbwnTtweWlE/6nMtOmJmBMbHhKFpY/JhCEcpPeHublGS1WUm92RnP6s1X9bdG
	 IC7zUweon+kRzfmLOwNB07HNCEc4MEG4igH5jhdC6/rn8K8T4cfjvZaTjC2bCwU0WU
	 byFpTjOKbXONw==
Date: Wed, 4 Feb 2026 07:29:30 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Wei Liu <wei.liu@kernel.org>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>
Subject: Re: [PATCH] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
Message-ID: <20260204072930.GO79272@liuwe-devbox-debian-v2.local>
References: <133a95d9-8148-40ea-9acc-edfd8e3ceef4@siemens.com>
 <20260204070004.GM79272@liuwe-devbox-debian-v2.local>
 <c377fab9-54f1-4eb9-8810-013a8bfb340e@siemens.com>
 <10ec70f2-27a5-477f-b6e9-164f7b7545d9@siemens.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10ec70f2-27a5-477f-b6e9-164f7b7545d9@siemens.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8708-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.microsoft.com,microsoft.com,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,siemens.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,siemens.com:email,fosdem.org:url,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: 26389E2B43
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 08:26:48AM +0100, Jan Kiszka wrote:
> On 04.02.26 08:19, Jan Kiszka wrote:
> > On 04.02.26 08:00, Wei Liu wrote:
> >> On Tue, Feb 03, 2026 at 05:01:30PM +0100, Jan Kiszka wrote:
> >>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>>
> >>> Resolves the following lockdep report when booting PREEMPT_RT on Hyper-V
> >>> with related guest support enabled:
> >>
> >> So all it takes to reproduce this is to enabled PREEMPT_RT?
> >>
> > 
> > ...and enable CONFIG_PROVE_LOCKING so that you do not have to wait for
> > your system to actually run into the bug. Lockdep already triggers
> > during bootup.
> > 
> >> Asking because ...
> >>
> >>>  	struct pt_regs *old_regs = set_irq_regs(regs);
> >>> @@ -158,8 +196,12 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
> >>>  	if (mshv_handler)
> >>>  		mshv_handler();
> >>
> >> ... to err on the safe side we should probably do the same for
> >> mshv_handler as well.
> >>
> > 
> > Valid question. We so far worked based on lockdep reports, and the
> > mshv_handler didn't trigger yet. Either it is not run in our setup, or
> > it is actually already fine. But I have a code review on my agenda
> > regarding potential remaining issues in mshv.
> > 
> > Is there something needed to trigger the mshv_handler so that we can
> > test it?
> > 
> 
> Ah, that depends on CONFIG_MSHV_ROOT. Is that related to the accelerator
> mode that Magnus presented in [1]? We briefly chatted about it and also
> my problems with the drivers after his talk on Saturday.

Yes. That is the driver. If PROVE_LOCKING triggers the warning without
running the code, perhaps turning on MSHV_ROOT is enough.

Wei

> 
> Jan
> 
> [1]
> https://fosdem.org/2026/schedule/event/BFQ8XA-introducing-mshv-accelerator-in-qemu/
> 
> -- 
> Siemens AG, Foundational Technologies
> Linux Expert Center
> 

