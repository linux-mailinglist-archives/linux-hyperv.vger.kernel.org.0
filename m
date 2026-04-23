Return-Path: <linux-hyperv+bounces-10356-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KTBIqB26mnTzgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10356-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 21:44:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B387B456E0D
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 21:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA4C530143C9
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 19:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A28E3491C7;
	Thu, 23 Apr 2026 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tORt1L2A"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032823EA9B;
	Thu, 23 Apr 2026 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776973463; cv=none; b=YwxIZCen6s5EsaIgiu1/lEFpyHr07n8qNM/04ffCwxFcBQ5PlwcKxuczdVzWMfgZrxWIJ6mTHo182HKvTxV+L44oP/uH62KnDWQdsp2rxTvUoFl+MtlEc1VOU8VoSLJJJ45SSJpbWU7GNJo3YM/shQP8deA7iI04vOdhtyo9i5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776973463; c=relaxed/simple;
	bh=KIdTnfrWhCm/3mkmY5XjowjHj5ElWmemc028AWda6Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWPXJAT422fTTaCualCOdFclGIDxfZkboZrGvAUQtJ+KOtyy/wNDlrzQaW582NP93ttmUFXiHN20vbzes7Jc2e7QyUcQbwdp5LxRS2uD5gKk7VYb/bHYEKzr8ZB0v4M+FBFaNIt0gbbJtgCuD/CT7wo+RpUNWb8ejYgV3OgfS3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tORt1L2A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RWJKOVoVRUNQb0LLzbgupq9gvwUJ+hzw26Jr6hGDu0U=; b=tORt1L2ASrxqUTjUb22wy+f77S
	oKvaZdk1LgqqMCgZE0eRYQM/XdATVaA7NPKIacxjGSGbmCfuP4PftCe1JiP4yi2U22vHZ3fZZalEq
	Ggz/wgjHto5ddWSk/gRv7FdmR1R0/Rw3OhlsaSGBnMXNjNtESdfD+cyTg1JZDj9uc3wc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFzy0-00HI3w-KA; Thu, 23 Apr 2026 21:44:04 +0200
Date: Thu, 23 Apr 2026 21:44:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	leon@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
	horms@kernel.org, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, stephen@networkplumber.org,
	jacob.e.keller@intel.com, dipayanroy@microsoft.com,
	leitao@debian.org, kees@kernel.org, john.fastabend@gmail.com,
	hawk@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	ast@kernel.org, sdf@fomichev.me, yury.norov@gmail.com
Subject: Re: [PATCH net] net: mana: hardening: Validate SHM offset from BAR0
 register to prevent crash due to alignment fault
Message-ID: <7c4dbe89-9b51-45d6-ae89-39d4183e66b1@lunn.ch>
References: <aepF3NwyANeklkfD@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <edccaafd-73f3-421d-a48e-a6cb704d39e6@lunn.ch>
 <aepviNMszMBtiB/H@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aepviNMszMBtiB/H@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10356-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B387B456E0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 12:14:16PM -0700, Dipayaan Roy wrote:
> On Thu, Apr 23, 2026 at 06:37:04PM +0200, Andrew Lunn wrote:
> > > The root cause is in mana_gd_init_vf_regs(), which computes:
> > > 
> > >   gc->shm_base = gc->bar0_va + mana_gd_r64(gc, GDMA_REG_SHM_OFFSET);
> > > 
> > > without validating the offset read from hardware. If the register
> > > returns a garbage value that is neither within bar 0 bounds nor aligned
> > > to the 4-byte granularity, thus causing the alignment fault.
> > 
> > Is GDMA_REG_SHM_OFFSET special?
> Hi Andrew,
> GDMA_REG_SHM_OFFSET is not special. It was simply the only register
> read that had no validation at all. The other two registers
> (GDMA_REG_DB_PAGE_SIZE, GDMA_REG_DB_PAGE_OFFSET) already have checks
> in place.

I must be missing something:

grep page_size *

gdma_main.c:	gc->db_page_size = mana_gd_r32(gc, GDMA_PF_REG_DB_PAGE_SIZE) & 0xFFFF;
gdma_main.c:	gc->db_page_size = mana_gd_r32(gc, GDMA_REG_DB_PAGE_SIZE) & 0xFFFF;
gdma_main.c:	void __iomem *addr = gc->db_page_base + gc->db_page_size * db_index;

So if GDMA_REG_DB_PAGE_SIZE returns garbage, it is at least masked,
but it is still a random number.

mana_gd_ring_doorbell() takes this random number, multiples by
db_index, adds, gc->db_page_base and then does:

writeq(e.as_uint64, addr);

So you write to a random address. 

I don't see any sanity checks here. Cannot you check that db_page_size
is at least one of the expected page sizes?

   Andrew

