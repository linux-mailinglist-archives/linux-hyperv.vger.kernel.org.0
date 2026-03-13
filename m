Return-Path: <linux-hyperv+bounces-9410-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CBFDFpatGklmQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9410-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 19:41:30 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAB3288D59
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 19:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 997D3300957E
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 18:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FB53C5DDD;
	Fri, 13 Mar 2026 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTk6A1vU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64953CEB8C;
	Fri, 13 Mar 2026 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773427285; cv=none; b=Dks1md2y/8jgtwvwxMUJUfnQTAT/Iwt3ZRVBCbGst+/N1FU4geF6HoZeZenXqwzG7vRZZXLA2tpABc4hKRc7gLVB/3mK4N60AxMsBvgTSMBPfhkM0UX7+zM+af5hCHWxtcDsdh0e8NGSdvHRCfnx5sF4soDdN2Dt/vv1kp1XZFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773427285; c=relaxed/simple;
	bh=50cycpp4ATFd7gtddJcbklbgmFyHqoxs3fVcSu1G/XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKw8us3cyo920yPeNjlHOKdUH81Q52gcH99UfmFzABnXYfER+2BoTFtLLOzjYgJOD3/jGEqmcDRXUq3LfrsTRrAVr2akQthciVB3cC7ijmeNMwQwTJSCk7iyE1lfQ5Oy13VkF1a8pZ3Ja6icAS9RjommuyQpzT3EO3XNtNt1KvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTk6A1vU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECB7C2BC86;
	Fri, 13 Mar 2026 18:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773427284;
	bh=50cycpp4ATFd7gtddJcbklbgmFyHqoxs3fVcSu1G/XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rTk6A1vUmlpvT1mOSDswCtWk+iRf2GWxhSIkKEiPuayrILlZX7Wcm7L6bYquGKq6r
	 7BEyinSpm7S9ypvwf2B2tqzNB81XFz5AMmsngxrtEFdfWA3PY4y/c0H1lwR7R7SDIT
	 9HiwNeU7lmMoy2AhFqImDZ5MR30JpjE7p8j1HTxv+xqvFBRerby2sx0RPlAOuIMk2m
	 T4k/GElJMF0rFiAqjGNcEh8uHVy55fi5D9WI4D+zeJA+CEYLe2Ih6URw0VJyoRYIbm
	 0x+wNLyu1mEN9IngdqACYLrNYuQfiwzgXXcjGND034eEfx3DbBWHLl3dRTPJhH8bzA
	 xyaIQ3XiW2IBQ==
Date: Fri, 13 Mar 2026 14:41:23 -0400
From: Konstantin Ryabitsev <mricon@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Eric Biggers <ebiggers@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-spi@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Steve French <sfrench@samba.org>, 
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] lib: count_zeros: fix 32/64-bit inconsistency in
 count_trailing_zeros()
Message-ID: <20260313-futuristic-steadfast-caribou-2b628a@lemur>
References: <20260312230817.372878-1-ynorov@nvidia.com>
 <abPdItJ152oMzGd6@ashevche-desk.local>
 <abRN59ST3uRDS5-e@yury>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abRN59ST3uRDS5-e@yury>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9410-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.intel.com,gmail.com,rasmusvillemoes.dk,kernel.org,zx2c4.com,vger.kernel.org,lists.infradead.org,microsoft.com,ziepe.ca,samba.org,amazon.com,soleen.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mricon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9DAB3288D59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 01:48:23PM -0400, Yury Norov wrote:
> (Thanks for b4!)

\o/

> Interesting thread.
> 
> So, my workflow is:
> 
>  1. git format-patch --cover-letter
>  2. # Edit cover letter, add To and CC section
>  3. git send-email 000* --to-cover --cc-cover
>  4. b4 am 
>  5. # Address nits/typos in the mbox
>  6. git am 
>  7. # Address substantial comments in git
>  8. git format-patch -v2 --cover-letter
>  9. # Edit cover letter again to restore body, To and CC sections
> 10. git send-email v2-000* --to-cover --cc-cover

This is doing it the classic way.

> So, yes I loose recipients on every iteration, together with the whole
> cover letter. But to me it's not a big deal because I can just pull
> them from my mailbox.
> 
> In the better world, I'd like to have:
> git send-email -v2 000* --to-the-same-people-as-in-v1
> 
> In the perfect world, I'd prefer to keep the cover letter under the
> git control, once it created, together with the recipients, once they
> are added, and be able to edit them just like regular commits.
> 
> There's a 'git am -k', which is seemingly related to the matter, and
> it keeps the [PATCH] prefix. But it's not what can preserve recipients
> for me.
> 
> I'll try b4 prep and trailers as suggested.

Yes, it was created to simplify this process significantly. It's still mostly
git and email, but at least you won't have to do quite so many manual steps.

Regards,
-- 
KR

