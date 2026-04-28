Return-Path: <linux-hyperv+bounces-10419-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE2VOe7V8GkSZQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10419-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 17:44:46 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E03648822D
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 17:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 302BF30097F1
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 15:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3CB2FFDCC;
	Tue, 28 Apr 2026 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="ThQvtcOG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AB63947B0;
	Tue, 28 Apr 2026 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391031; cv=pass; b=L8odgXUtCwd8q0rIfuK4yTpoow6rcnUPWyVlxVy/hu8ztw8WoEm4xV/GgmCtV40wdwXpkc970gXwwmuqTrOr0BSWEenyQkOs7AA/NJ8hzWAFK/wQGDpkZj1WCrv15nYzuw4f5ASC53SCevgwL33TYubmFokxAdD4nBxQyOKBJH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391031; c=relaxed/simple;
	bh=8+sTHi9tP+5Y+v2nKB2k69SuNDPBLVJAEgkmJi3uYV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7oXJhz5DUWDIwjg9G6c0nOq7zd8uKJQh8XFAFnlVjDu7iVwKPJJ9v6zi4H6jN5E5AaAzyunta1EMx+qViZKgI3qpotLiVVF2dlRx0ubqwkMXumLZKbWU7+/FApHA9ucIDGr6IggPhelbCV4EDotYpqr+iYUd+APxiZj2dsLQe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=ThQvtcOG; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1777391018; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jCixJ8Mx9XtI1AFaJ80kJ4X0uuEJI8vHJ8hgeLTWRL9V6+GqC2mie0eEw0D1p+MsWP+tsLxtgZ1WLZ81CjY+zfJ8fh07T3OxTNfr04idkG2zA+MX3/ZISvHz++8GP+WG38Ec9CtWLHE6/C51hH5mSwgCbE3/qpj+bId3GNKQe3k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777391018; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=T6Hkb/THFfULUVJJaagpsJPs8CFkG+ZVDzN7CE/bgQw=; 
	b=ng1nioPYOtBv4GQs/aKD4Ag0Zf3Pzf9MJ1NYE9VRfICtl7WetKHOvmPguEa7Yj/f3hDhcfPhaYjOL5fxQ1hrzDQG6D4uqzXXq4opeynLxVsSLYE654+j1rUpcIhXy7vIBapAt2DEHqMSi04hmtJ/eRAyLraQ5AdjZaKtmOeu2LE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777391018;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=T6Hkb/THFfULUVJJaagpsJPs8CFkG+ZVDzN7CE/bgQw=;
	b=ThQvtcOGTDjakqjYqTYhHbTl0yKvnpfrqaqqYzbVhJvSLyF+vHb502ViUKBGc/O0
	l0uJHfI/hoAIghQWupfHEoFWtIj3SHx9Wohc/cmLD6p+h0M9bAVwOqXvtleBCoze1jX
	D6/bk+j1fxCpvwTXleMTQdO0T9Nxv+9E3XzYUCKc=
Received: by mx.zohomail.com with SMTPS id 1777391016097499.68069608417375;
	Tue, 28 Apr 2026 08:43:36 -0700 (PDT)
Date: Tue, 28 Apr 2026 15:43:30 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: remove page order restriction to enable 1G
 hugepage support
Message-ID: <20260428-peacock-of-great-performance-3bbeb1@anirudhrb>
References: <20260416-huge_1g-v1-1-e066738cddfb@anirudhrb.com>
 <aeZavL_GaMyv_NWR@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeZavL_GaMyv_NWR@skinsburskii.localdomain>
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 3E03648822D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10419-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 20, 2026 at 09:56:28AM -0700, Stanislav Kinsburskii wrote:
> On Thu, Apr 16, 2026 at 01:37:15PM +0000, Anirudh Rayabharam (Microsoft) wrote:
> > The hypervisor's map GPA hypercall handles large pages intelligently,
> > combining 2M pages into 1G mappings when alignment allows.
> > 
> > Remove the PMD_ORDER check in mshv_chunk_stride() so that 1G hugepages
> > and other large page orders are passed through as 2M-aligned chunks,
> > letting the hypervisor promote them to 1G mappings automatically.
> > 
> > Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > ---
> >  drivers/hv/mshv_regions.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> > index fdffd4f002f6..5f617a96d97a 100644
> > --- a/drivers/hv/mshv_regions.c
> > +++ b/drivers/hv/mshv_regions.c
> > @@ -29,7 +29,7 @@
> >   * Uses huge page stride if the backing page is huge and the guest mapping
> >   * is properly aligned; otherwise falls back to single page stride.
> >   *
> > - * Return: Stride in pages, or -EINVAL if page order is unsupported.
> > + * Return: Stride in pages.
> >   */
> >  static int mshv_chunk_stride(struct page *page,
> >  			     u64 gfn, u64 page_count)
> 
> Nit: the return type of the function should now become unsigned.

Thanks I'll prepare a v2 with this and also look into Sashiko's comments
on this patch.

Thanks,
Anirudh.


