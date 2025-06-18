Return-Path: <linux-hyperv+bounces-5944-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E987ADEBF9
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Jun 2025 14:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B381BC28D8
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Jun 2025 12:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9352E8E01;
	Wed, 18 Jun 2025 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="FFRv1Qtn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863762E54B8;
	Wed, 18 Jun 2025 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249288; cv=pass; b=Ot3DShAPhOoUwPk0gC/EXmlAe2jkYuaCNtJE/TsIB+WV2adQePjX4/CdDzzfQdvFJPmIV6hKTWDj7JDSen8c4WrC6mDQaMZTQZivPK4PNFHP3Ek+EnxnsryBDRiDNPPNI1Snn0CHmdHg60rbBg1dYE714g4QuCI4TpgBxDTFhRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249288; c=relaxed/simple;
	bh=8+YJ5wwUQkeJeSuQmxo6hbCCFR20pS60lV14OP2GMKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlSqYmgN4bLPjzieZ541HlsQUkLnG3W7jroow/pRsijY0PK5VOOW/lN2+kPEEgm8ovM6IsWZV1iVQn9h/GfFIAgdFzGa20qNFoCSZVg8hpBeX/q9lm/EHwU/1ojhEjZSqV4P3T9o+uorB4tiU343IgnCG0h5XtAZXBJGCLS3kvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=FFRv1Qtn; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1750249277; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LwTyltZLvFLcU/04Th+T9Kkk5eGUpsjs+w95iD+lahK1CtbqtZNTO2E4WzxMbCgMutsym+AfRQtmcdmJtYeoPvAe6k6jL6Y+dV12WrwzOPS2ZDZdaEuY2U3wgCygw28+Dgy1nMsyIiaYhLTOy/7mz6YWYO/+Yz2f4UDyNfptreA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750249277; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+gU1SNTj2Uw5CPwEJB/aCInEX5ywExrTmgIA0Ro+WzY=; 
	b=C9I9o0o+fPla+K9uBwJf2Je8gsVj/EwBskSumylYp0XVYHv8BZsJDQ1T8rEmdU5eJU+FxPdonSoVDhbnJp1/99GPOYTj1MnyvVplXbEVMg14i4N41GERKGBZnKulqi4dEvBI2qZiuL1eLH4Preb+3WUJDH/Pue2+haSxbMiMBgg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750249277;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=+gU1SNTj2Uw5CPwEJB/aCInEX5ywExrTmgIA0Ro+WzY=;
	b=FFRv1QtnnHHmCRJY8qHb1/CxJZdBlKgxKrfTStV52YoEHgB5tgFYJ4F31zI3sV1Y
	73Whw2o5OYKd8BYf4QttZrN4M65Ko3ONFlZapq/rwlISZ1ThWD3mV62J6O4+ihPnvRZ
	0E2UaR6tRyZKkvsho5QWKzamh0dlCdX9kwgHNc5I=
Received: by mx.zohomail.com with SMTPS id 1750249250132973.3344122035301;
	Wed, 18 Jun 2025 05:20:50 -0700 (PDT)
Date: Wed, 18 Jun 2025 12:20:43 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
	linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, lpieralisi@kernel.org,
	mark.rutland@arm.com
Subject: Re: [PATCH] firmware: smccc: support both conduits for getting hyp
 UUID
Message-ID: <aFKvG69DVhHcI5Mn@anirudh-surface.localdomain>
References: <20250605-kickass-cerulean-honeybee-aa0cba@sudeepholla>
 <20250610160656.11984-1-romank@linux.microsoft.com>
 <20250611-wandering-juicy-magpie-ed7f46@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250611-wandering-juicy-magpie-ed7f46@sudeepholla>
X-ZohoMailClient: External

On Wed, Jun 11, 2025 at 01:52:32PM +0100, Sudeep Holla wrote:
> On Tue, Jun 10, 2025 at 09:06:48AM -0700, Roman Kisel wrote:
> > > (sorry for the delay, found the patch in the spam 🙁)
> > 
> > "b4" shows the the mail server used for the patch submission
> > doesn't pass the DKIM check, so finding the patch in the spam seems
> > expected :) Thanks for your help!
> > 
> 
> Thought so looking at the header but I just have very basic knowledge
> there, so couldn't comment.
> 
> > >
> > > On Wed, May 21, 2025 at 09:40:48AM +0000, Anirudh Rayabharam wrote:
> > >> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > >>
> > >> When Linux is running as the root partition under Microsoft Hypervisor
> > >> (MSHV) a.k.a Hyper-V, smc is used as the conduit for smc calls.
> > >>
> > >> Extend arm_smccc_hypervisor_has_uuid() to support this usecase. Use
> > >> arm_smccc_1_1_invoke to retrieve and use the appropriate conduit instead
> > >> of supporting only hvc.
> > >>
> > >> Boot tested on MSHV guest, MSHV root & KVM guest.
> > >>
> > >
> > > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > >
> > > Are they any dependent patches or series using this ? Do you plan to
> > > route it via KVM tree if there are any dependency. Or else I can push
> > > it through (arm-)soc tree. Let me know.
> > 
> > Anirudh had been OOF for some time and would be for another
> > week iiuc so I thought I'd reply.
> > 
> > The patch this depends on is 13423063c7cb
> > ("arm64: kvm, smccc: Introduce and use API for getting hypervisor UUID"),
> > and this patch has already been pulled into the Linus'es tree.
> > 
> 
> Had a quick look at the commit to refresh my memory and as you mentioned
> it is new feature. I was checking to see if this is a fix.
> 
> > As for routing, (arm-)soc should be good it appears as the change
> > is contained within the firmware drivers path. Although I'd trust more to your,
> > Arnd's or Wei's opinion than mine!
> > 
> 
> I will queue this once I start collecting patches for v6.17 in 1/2 weeks'
> time, so expect silence until then 😄.

Sounds good, thanks!

Regards,
Anirudh.

> 
> -- 
> Regards,
> Sudeep

