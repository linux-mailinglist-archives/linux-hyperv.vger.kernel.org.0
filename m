Return-Path: <linux-hyperv+bounces-8710-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JbfBAT3gmlVfwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8710-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 08:36:36 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A0FE2BA2
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 08:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3B8E3006933
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Feb 2026 07:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4C938E5CD;
	Wed,  4 Feb 2026 07:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZtP3s0g"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B794927E04C;
	Wed,  4 Feb 2026 07:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770190591; cv=none; b=PSz8ceUBPgkSR3JgIYs35VeZ1mbG5DuMuxmoiQ0NvRAzIsj4kZ9AEA0+WLGNbL8m8Gqs09fZvI+d4T8iZqlsee4KKZ2jrkkF4sVkEEu2gDBbN+yjP5Xr6sbaBUxDZtk5QJ2w15T06zK6Qf5kcdFzcum/wUy2v3ZkTv+4iRDc1as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770190591; c=relaxed/simple;
	bh=bX3onthKScPrxRK4ABd9NTFl99skFwe8obSmyy4jqvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrxY2gmL/Wyehcz9/2vgEmITOGtYx/hzkQd25uzLUNPlxeQmOtbNJgYo7Wpv4LkNpzRWOq5tjNvI2KhM+QLpcIUirWJVkBvbickzbbSereurBsRCDCb86RBNyn6jyqqWNL49H7X+z8AzI8HQmaEvm5RFW/J74yMJO234yNL3pGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZtP3s0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FEDC116C6;
	Wed,  4 Feb 2026 07:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770190591;
	bh=bX3onthKScPrxRK4ABd9NTFl99skFwe8obSmyy4jqvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZtP3s0grVu57CNhsWeiY2/8I1kf8fY9mjQ3L7Zsz7QJfKGnSgAqp9aiuhkUEOCd5
	 abkGj5PMB2Gf0oW8qii2C58X3uDxyh5BFforJvkbTmVKpyBqNbQTHikabBse0/zQlg
	 cCQq6vJfi4S/sIP/SxqZDL8ff+L6DqabNQmusU8XisxUYJ4fn7jT2LXSbWAInntb7i
	 wA1yfdR0eufe9pSduZCfyp5eYl63/o2R1lbskSMfjlCCGoflZ1rmzGbWVqqrSfu7xe
	 8tSBb+01nhqRrntl1lXLNqTlcCuL7VkNJ0gPS2Z5zVWGW2qL4AxVwC8n//p4mQ+n+F
	 xtEeGELi1Y+Sg==
Date: Wed, 4 Feb 2026 07:36:29 +0000
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
	Mitchell Levy <levymitchell0@gmail.com>,
	skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
	anirudh@anirudhrb.com, schakrabarti@linux.microsoft.com,
	ssengar@linux.microsoft.com
Subject: Re: [PATCH] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
Message-ID: <20260204073629.GP79272@liuwe-devbox-debian-v2.local>
References: <133a95d9-8148-40ea-9acc-edfd8e3ceef4@siemens.com>
 <20260204070004.GM79272@liuwe-devbox-debian-v2.local>
 <c377fab9-54f1-4eb9-8810-013a8bfb340e@siemens.com>
 <10ec70f2-27a5-477f-b6e9-164f7b7545d9@siemens.com>
 <20260204072930.GO79272@liuwe-devbox-debian-v2.local>
 <d1dded05-a47f-4be2-94c4-913104c758e2@siemens.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1dded05-a47f-4be2-94c4-913104c758e2@siemens.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8710-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.microsoft.com,microsoft.com,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,siemens.com,gmail.com,anirudhrb.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,liuwe-devbox-debian-v2.local:mid,siemens.com:email]
X-Rspamd-Queue-Id: 33A0FE2BA2
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 08:32:04AM +0100, Jan Kiszka wrote:
> On 04.02.26 08:29, Wei Liu wrote:
> > On Wed, Feb 04, 2026 at 08:26:48AM +0100, Jan Kiszka wrote:
> >> On 04.02.26 08:19, Jan Kiszka wrote:
> >>> On 04.02.26 08:00, Wei Liu wrote:
> >>>> On Tue, Feb 03, 2026 at 05:01:30PM +0100, Jan Kiszka wrote:
> >>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>>>>
> >>>>> Resolves the following lockdep report when booting PREEMPT_RT on Hyper-V
> >>>>> with related guest support enabled:
> >>>>
> >>>> So all it takes to reproduce this is to enabled PREEMPT_RT?
> >>>>
> >>>
> >>> ...and enable CONFIG_PROVE_LOCKING so that you do not have to wait for
> >>> your system to actually run into the bug. Lockdep already triggers
> >>> during bootup.
> >>>
> >>>> Asking because ...
> >>>>
> >>>>>  	struct pt_regs *old_regs = set_irq_regs(regs);
> >>>>> @@ -158,8 +196,12 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
> >>>>>  	if (mshv_handler)
> >>>>>  		mshv_handler();
> >>>>
> >>>> ... to err on the safe side we should probably do the same for
> >>>> mshv_handler as well.
> >>>>
> >>>
> >>> Valid question. We so far worked based on lockdep reports, and the
> >>> mshv_handler didn't trigger yet. Either it is not run in our setup, or
> >>> it is actually already fine. But I have a code review on my agenda
> >>> regarding potential remaining issues in mshv.
> >>>
> >>> Is there something needed to trigger the mshv_handler so that we can
> >>> test it?
> >>>
> >>
> >> Ah, that depends on CONFIG_MSHV_ROOT. Is that related to the accelerator
> >> mode that Magnus presented in [1]? We briefly chatted about it and also
> >> my problems with the drivers after his talk on Saturday.
> > 
> > Yes. That is the driver. If PROVE_LOCKING triggers the warning without
> > running the code, perhaps turning on MSHV_ROOT is enough.
> > 
> 
> But if my VM is not a root partition, I wouldn't use that driver, would I?

No, you wouldn't.  You cannot do that until later this year. If you
cannot test that, so be it. I'm fine with applying your patch and then
move the mshv_handler logic later ourselves.

I've CC'ed a few folks from Microsoft.

Saurabh, Long, and Dexuan, can you review and test this patch for VMBus?

Thanks,
Wei

> 
> Jan
> 
> -- 
> Siemens AG, Foundational Technologies
> Linux Expert Center
> 

