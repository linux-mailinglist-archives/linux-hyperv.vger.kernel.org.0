Return-Path: <linux-hyperv+bounces-8049-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A282CC6183
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Dec 2025 06:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B209301D9C7
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Dec 2025 05:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DE526F28D;
	Wed, 17 Dec 2025 05:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Li0wqpSk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB0825D1E6;
	Wed, 17 Dec 2025 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765950421; cv=none; b=KxklE+TdgDmjcOA2bwvv56MP3kh4lD/ChVoQ2t0JSITdLMDgAbQkaYDMyzlYjRVrArECbun0HycmdXEo8NFZeZvyoze15v54xNyLocVdPxgQRiEf5d78eEJMLrCR7k6+i5YdcU6n8GHtFLQzR0vKA+rc0S4HM1OMi/nj6WDluas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765950421; c=relaxed/simple;
	bh=lFajYfOjE3Vmskc4D/5y/15zOH6ZoqutLU0ilEB8tPI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=bNua/4WLGdllHC6bZ8MjyMk7EJJdgttHHn0ii9gBUyWuaQBykqdAxkJftyBzfPa9vYhvTAt7cBBRRRh3eJY8NHxzMHUWNH4OfGvPtgQS4OB2sBbcArGZBHWdkyQyDO7rCWT42DFC2puN8jEgw4ItW6RzBv4kwmFpaJOgvcOQZ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Li0wqpSk; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dWN8n4qyxz9v8V;
	Wed, 17 Dec 2025 06:46:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1765950409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XlC9z316sUmT6TwSLTdHinkuee3+qPAl97FbIS3atCE=;
	b=Li0wqpSk3YV1DILIQzfQ3JQTvej0ApMN9zszbNkr+cOvYMd/rfShXryJvnsduNXSs+sbVK
	7avO+rqCCIMw446f74itTGrv0YP/nsYwzkZejeVfugp4oMFFwYUpJ5fL/wtIjoApylRc1L
	u/qRCIpzMnVOLCJufCyxOl2gfWEkaPt1nd+ZPET9+xBa0a9QBUqtHRDW/18JNWZ9/ziv9B
	UQ5smnkv1nJXT2tPLyTwtwoV6wQL2QHzTHT2U0uFFsN8miiV3b6rBdKJD6Wn9I22yjePoW
	6UjN1ewrYcKnWAHATft1CFhkK8tnAo9K+LJ1i9XrAuH+1CAIlhv27cZJ9414Ww==
Date: Tue, 16 Dec 2025 21:46:48 -0800 (PST)
From: vdso@mailbox.org
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, decui@microsoft.com, haiyangz@microsoft.com,
	linux-kernel@vger.kernel.org, longli@microsoft.com,
	wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Message-ID: <549411914.201492.1765950408211@app.mailbox.org>
In-Reply-To: <jhyqp7vlqsmnps52cgzzuyon3aihcxizog4bknnofuibhud5ry@3nix3cwzwapw>
References: <20251216142030.4095527-1-anirudh@anirudhrb.com>
 <20251216142030.4095527-2-anirudh@anirudhrb.com>
 <1801063954.177813.1765897665357@app.mailbox.org>
 <jhyqp7vlqsmnps52cgzzuyon3aihcxizog4bknnofuibhud5ry@3nix3cwzwapw>
Subject: Re: [PATCH 1/3] hyperv: add definitions for arm64 gpa intercepts
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-ID: 0cdaf22a4858ef887df
X-MBO-RS-META: u5fu5tboqb4jpee3mpwnuw43au1mstky


> On 12/16/2025 9:08 PM  Anirudh Rayabharam <anirudh@anirudhrb.com> wrote:
> 
>  
> On Tue, Dec 16, 2025 at 07:07:45AM -0800, vdso@mailbox.org wrote:
> > 
> > > On 12/16/2025 6:20 AM  Anirudh Rayabharam <anirudh@anirudhrb.com> wrote:
> > 
> > [...]
> > 
> > > +#if IS_ENABLED(CONFIG_ARM64)
> > > +union hv_arm64_vp_execution_state {
> > > +	u16 as_uint16;
> > > +	struct {
> > > +		u16 cpl:2;
> > 
> > That looks oddly x86(-64)-specific (Current Priviledge Level).
> > 
> > Unless I'm mistaken, CPL doesn't belong here, and the bitfield isn't
> > used on ARM64. Provided the layout of the struct is correct, the
> > bitfield can have a better name of `reserved0` or something like that.
> 
> Hmmm... this is how it is defined in the hypervisor headers though.

The questions would be why the hypervisor has got that there (e.g., the
definitions of that struct for x86 and ARM64 are merged), and if Linux needs
to care about the reason valid in the hv's codebase. Perhaps the definitions
are merged there to write less arch-specific code, similar to what Stas suggested
for the patch 2.

I haven't been able to find anything called CPL in the ARM64 arch docs, and
that field really sticks out as the x86-64's CPL. Naming it like that in an
ARM64-specific structure doesn't look justified.

