Return-Path: <linux-hyperv+bounces-10161-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PLxNopi3mldDgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10161-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 17:51:38 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E72363FC25D
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 17:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B3EF301F68C
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 15:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84953E5EE4;
	Tue, 14 Apr 2026 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="JLCt8Z8C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7456B3ECBE7;
	Tue, 14 Apr 2026 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181835; cv=pass; b=EXg8/NAqtoUPqLtlbGSPPt/QwfFxCBxE5UZidORCHvsQN6x9IBXIfjsiLHXQw8gVj4bWO6TmK4nhKUwJh5pScklYMWNm4MFUDz56PfWe7i2Llf0cKadZha1pI7J5JlVWAq2uwmoE9zjFHGaoB4YlnRxIqYyX2jmQC/Afpw20R4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181835; c=relaxed/simple;
	bh=a6HwiN7EbCb5RurcFkbTu1AC4n/19AzaRKtFUBRK8mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yoh0nM4Q2kZ2Jo5bsapqqG69kDO1+Dwz5AotuxA/fq+NhiOJSOprs6JqID0yjkq8p8oOAt03zBBsDheeEiPxAgFFIpFvXCrdCW6JtcziQnbGvfCeaBh0mcUTm0KttZxwYRSFrwA8OpcXxNgVNkseis49JyvRBSWRo7KY5hyLu20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=JLCt8Z8C; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1776181809; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dlRTS8uKWJr5DTbFn9UbdlBcb4QGMxL0gjeFBXn1HUrime2N2TvHfl4pmNJrqhldkGtnJBBmE2EkPaRHa2RAJ0jaeIXRc9o3+O4j/uWm/jjbx8Kia9kOivGNJh3sdoEU2eSbA+xMCwvNii4/f8yieiR2dkguCJ9hHrYex0QxdcA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776181809; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jJrfml2+rvezhfi8tp+sj8diOv1rzYhJyDy8YHxnqck=; 
	b=PiXbKnT6nLC8VSAVayUuFO7GfXyuu4x0WGeo9cCILDrQzjosPCYgjlkrKjo/6MKoAA3+oxkddvlD0mIr0PNOULSxuOYRNb0AFSYpdhUMiBHjroe8pzqFjVoVQ90Ulb6jMPXowM8vnkkuZ6wyw5yV0Y1dSaCogth1mwwnp616DzE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776181809;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=jJrfml2+rvezhfi8tp+sj8diOv1rzYhJyDy8YHxnqck=;
	b=JLCt8Z8CXb6XmauGOUbWxS0y/1DRhp9/u9+I5IjDRZF52GD6Iu4E/96ilc9PucrG
	sbC0kG+5iH28Rr3yemYZQfKK9hHd8j9Lwp+5KSex2JH37OMCZjNx3kRGnFLRAnK6eEB
	OxuOO2l3lDLCsNkOoLLai9OGGxnEIpKjMpvu0Izk=
Received: by mx.zohomail.com with SMTPS id 1776181805093538.7624210507041;
	Tue, 14 Apr 2026 08:50:05 -0700 (PDT)
Date: Tue, 14 Apr 2026 15:49:53 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Jork Loeser <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
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
Message-ID: <20260414-successful-loyal-magpie-9b7faf@anirudhrb>
References: <20260403190613.47026-1-jloeser@linux.microsoft.com>
 <20260403190613.47026-5-jloeser@linux.microsoft.com>
 <20260406-ninja-civet-of-tornado-67ff54@anirudhrb>
 <134ce833-544-24eb-883-b190a888b31c@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <134ce833-544-24eb-883-b190a888b31c@linux.microsoft.com>
X-ZohoMailClient: External
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10161-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E72363FC25D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 02:27:52PM -0700, Jork Loeser wrote:
> On Mon, 6 Apr 2026, Anirudh Rayabharam wrote:
> 
> > On Fri, Apr 03, 2026 at 12:06:10PM -0700, Jork Loeser wrote:
> > > The SynIC is shared between VMBus and MSHV. VMBus owns the message
> > > page (SIMP), event flags page (SIEFP), global enable (SCONTROL),
> > > and SINT2. MSHV adds SINT0, SINT5, and the event ring page (SIRBP).
> > > 
> > > Currently mshv_synic_init() redundantly enables SIMP, SIEFP, and
> > 
> > The redundant enable is probably a no-op from the hypervisor side so it
> > probably doesn't hurt us. The main problem is with the tear down.
> 
> It's an MSR intercept. If we can replace this by an "if()" we shave a few
> cycles.
> 
> > An alternative approach could be: check if SIMP/SIEFP/SCONTROL is
> > already enabled. If so, don't enable it again. If not enabled, enable it
> > and keep track of what all stuf we have enabled. Then disable all of
> > them during cleanup. This approach makes less assumptions about the
> > behavior of the VMBUS driver and what stuff it does or doesn't use.
> 
> It would, yes. Then again, we drag yet more state and make debugging more
> complicated / less clear to reason what happens dynamically. I had been
> debating this briefly myself, and ultimately decided against it for that
> very reason.

Ultimately, both approaches are fragile in their own ways because the
contract that "VMBus owns SIMP, SIEFP, SCONTROL, SINT2 and MSHV owns
SIRBP and SINT0 and SINT5" are not enforced anywhere in code and are
just assumptions that everyone will play nice. To do that, we'll need to
refactor the code such that there is a common component that sort of
facilitates access to SynIC for both VMBus and MSHV.

I would say that checking the state dynamically and then deciding
whether or not to enable SIMP/SIEFP/SCONTROL would be less fragile
because we make lesser assumptions about what VMBus does or doesn't do.

Also, do you know of any cases where the VMBus stuff can get initialized
after MSHV? Maybe if VMBus is a module (if that is even possible)? That
would really mess up our logic here.

Thanks,
Anirudh.

> 
> Best,
> Jork

