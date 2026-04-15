Return-Path: <linux-hyperv+bounces-10170-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD4tIBko32nmPQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10170-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 07:54:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0081B400A11
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 07:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4285230440B4
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 05:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78CB36DA1A;
	Wed, 15 Apr 2026 05:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nly8mcQl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0282346ACE;
	Wed, 15 Apr 2026 05:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232466; cv=none; b=nUkwfKvy6HhM1Hu2zHsTsjz8ZBzVUTkfRaYnxiAGl1a+zdeHXDEnPFkGg1mRoDDAlnQeNKZfnmyAX7hAa8uYXz3Uy7lX1FnTCNCgr9hwMQLWqILanqiH2SW2BizT3jYDGnZYyMQtm3nAlBUtUPgFUmHLb6CBpQFFFqB3OFA0wWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232466; c=relaxed/simple;
	bh=krkPgIDXxYfHWT+4LVdBGwvnMdjxV2cofvgk8BCq050=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKyCawQoifOGfOGzw4d6zNgC4Bt9+PGEnVhqJC4IeP3fv7pAs/XVwPMVN/7ACOZD+Zh0SPaBsrD+cC6xiyM7L40vpQvWkuyohodUBisian7ROfWxfKexv40WbYATt/QPYOnHCl+gmf5oivJcUeBCmtEElW2ZuYUgNpZwwHT8GAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nly8mcQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A63C19424;
	Wed, 15 Apr 2026 05:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776232466;
	bh=krkPgIDXxYfHWT+4LVdBGwvnMdjxV2cofvgk8BCq050=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nly8mcQlRKWi2EcTLtt7DynZUapEeyuFwPOrBoAj6ULbeiZ+3t84O+YWoUphRP6Kp
	 fVC/ecS2iAT7522uu5P8sx2nOY90XW0Eokn/1PXaDcwjQQOV11yx8kGrUPzEZ8J6DK
	 Dn5UiSMb4ZdxKrkgRNRLR4HasVBkUCIdEnCUuD0oBficNVhKo69KEHFCGD5EYJXoRY
	 M0befqPK/TqUhTr+9yajT0n9fSU7vJr0VIq86uO0dqeiXvBp6JBHeIoyBpW+Yr9eCd
	 /PWqvBKXXzIigAMnQ+C9SQmwV2M4NPLs+PBjtvDw6eoVsdjY4uTcsYLie3Gu1KbAip
	 6f1P4Xb7vgS0A==
Date: Wed, 15 Apr 2026 05:54:24 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: Jork Loeser <jloeser@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
	x86@kernel.org, "K . Y . Srinivasan" <kys@microsoft.com>,
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
Message-ID: <20260415055424.GA3381607@liuwe-devbox-debian-v2.local>
References: <20260403190613.47026-1-jloeser@linux.microsoft.com>
 <20260403190613.47026-5-jloeser@linux.microsoft.com>
 <20260406-ninja-civet-of-tornado-67ff54@anirudhrb>
 <134ce833-544-24eb-883-b190a888b31c@linux.microsoft.com>
 <20260414-successful-loyal-magpie-9b7faf@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-successful-loyal-magpie-9b7faf@anirudhrb>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10170-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.microsoft.com,vger.kernel.org,kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: 0081B400A11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 03:49:53PM +0000, Anirudh Rayabharam wrote:
> On Tue, Apr 07, 2026 at 02:27:52PM -0700, Jork Loeser wrote:
> > On Mon, 6 Apr 2026, Anirudh Rayabharam wrote:
> > 
> > > On Fri, Apr 03, 2026 at 12:06:10PM -0700, Jork Loeser wrote:
> > > > The SynIC is shared between VMBus and MSHV. VMBus owns the message
> > > > page (SIMP), event flags page (SIEFP), global enable (SCONTROL),
> > > > and SINT2. MSHV adds SINT0, SINT5, and the event ring page (SIRBP).
> > > > 
> > > > Currently mshv_synic_init() redundantly enables SIMP, SIEFP, and
> > > 
> > > The redundant enable is probably a no-op from the hypervisor side so it
> > > probably doesn't hurt us. The main problem is with the tear down.
> > 
> > It's an MSR intercept. If we can replace this by an "if()" we shave a few
> > cycles.
> > 
> > > An alternative approach could be: check if SIMP/SIEFP/SCONTROL is
> > > already enabled. If so, don't enable it again. If not enabled, enable it
> > > and keep track of what all stuf we have enabled. Then disable all of
> > > them during cleanup. This approach makes less assumptions about the
> > > behavior of the VMBUS driver and what stuff it does or doesn't use.
> > 
> > It would, yes. Then again, we drag yet more state and make debugging more
> > complicated / less clear to reason what happens dynamically. I had been
> > debating this briefly myself, and ultimately decided against it for that
> > very reason.
> 
> Ultimately, both approaches are fragile in their own ways because the
> contract that "VMBus owns SIMP, SIEFP, SCONTROL, SINT2 and MSHV owns
> SIRBP and SINT0 and SINT5" are not enforced anywhere in code and are
> just assumptions that everyone will play nice. To do that, we'll need to
> refactor the code such that there is a common component that sort of
> facilitates access to SynIC for both VMBus and MSHV.
> 
> I would say that checking the state dynamically and then deciding
> whether or not to enable SIMP/SIEFP/SCONTROL would be less fragile
> because we make lesser assumptions about what VMBus does or doesn't do.
> 

I think it is important to keep the changes as small as possible for
ease of backporting.

> Also, do you know of any cases where the VMBus stuff can get initialized
> after MSHV? Maybe if VMBus is a module (if that is even possible)? That
> would really mess up our logic here.
> 

It is possible to configure Vmbus as a module today. We should think of
a way to resolve what you say. Designing a new component is one way. The
other way is to find a working build configuration and enforce it via
Kconfig.

Wei

> Thanks,
> Anirudh.
> 
> > 
> > Best,
> > Jork

