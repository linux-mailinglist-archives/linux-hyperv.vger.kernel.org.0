Return-Path: <linux-hyperv+bounces-10112-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8UqCEbPW2WmMtggAu9opvQ
	(envelope-from <linux-hyperv+bounces-10112-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Apr 2026 07:05:55 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 867723DE5E0
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Apr 2026 07:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC14430125E4
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Apr 2026 05:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6D6288C96;
	Sat, 11 Apr 2026 05:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Lds80mdC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C2A3C07A;
	Sat, 11 Apr 2026 05:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775883952; cv=none; b=Rlof/JveHbMvLowMDK9yonJ5aYB+6AqBWxW55kYRJTmO7i920yPlsXPbA2PqznQ/8TAftYaHmvPnbJangl48Ijlz1m/tpvatIATPpSbMv+qY836FmcWptpED7R4yyegGIBAG3/F0t4YFKlygi+VkFDf63gv5iIK1f7YE1VD5Qa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775883952; c=relaxed/simple;
	bh=3xBlrWW1Lq+1JLU5uyLWILd/tfY1vZ+spYhRWYOTQ1M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=riW4AEMQnsji+GWtXuXyCybCih8FhxJ9JqCcsofLZro/usyv7bFAJqnl40VZiX7mH2ocNmocPmrfarvEd5RCPPr4OkMKuiDqPy0FbauAe7qDBoggtI8b1KmWLHt107XEz2HxrYbzYByfN8mHyOHJzFrafwmkp8KNZV/xhU/Jp4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Lds80mdC; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ft1pF1jjCz9vGK;
	Sat, 11 Apr 2026 07:05:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775883941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kILLD5rF1kHg4EfRuqtc2c5mXxXjN0v7x+DhGbXINks=;
	b=Lds80mdC2pHCsoOAjXHNgOyIZXEkrw75lXgncBpUmANSg8qxfu2o24L6lKT7XfIRQEo8Qc
	YV7oQGcvOJ3ECWHoaCNFHJXFnIhEA0CkLeKYqwR/ew7pRFe11i7rGNrfNcTzSIjg4ZORcv
	jz3dLQ58ln8PfwCj3FU8y7gXYxhCyUZm0pjMwRkP4IJzsjH6JqzVkAnPwFvvkNhQvftNtP
	Hs5gJLNfu6f7x3qAdAftu3n3Iasp4Qdg3TaUGIwrtquCa/pfcHRd6ANjG1Ntlp/+/0zGQ0
	GRZbCdgj8nPGo++sHcY1bjs8RF9QCznFNnPIR/PQZrxjNNvP0EAmNycdfct+YA==
Date: Fri, 10 Apr 2026 21:05:35 -0800 (PST)
From: vdso@mailbox.org
To: Junrui Luo <moonafterrain@outlook.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Muminul Islam <muislam@microsoft.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Jinank Jain <jinankjain@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Yuhao Jiang <danisjiang@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Message-ID: <319614096.43465.1775883935863@app.mailbox.org>
In-Reply-To: <89730D18-D9A3-4A18-87DD-E7A51625FF69@outlook.com>
References: <SYBPR01MB788138A30BC69B0F5C3316E5AF54A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <ac76zlXjXhPVkA6f@skinsburskii.localdomain>
 <89730D18-D9A3-4A18-87DD-E7A51625FF69@outlook.com>
Subject: Re: [PATCH v2] Drivers: hv: mshv: fix integer overflow in memory
 region overlap check
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
X-MBO-RS-META: g6j1haqcdsq8a43jfbwik5qcifwmg7fo
X-MBO-RS-ID: 142710ee1463bd87b65
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_X_PRIO_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10112-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,linux.microsoft.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdso@mailbox.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,mailbox.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 867723DE5E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> On 04/09/2026 8:06 PM PDT Junrui Luo <moonafterrain@outlook.com> wrote:
> 
>  
> On Thu, Apr 02, 2026 at 04:25:02PM -0700, Stanislav Kinsburskii wrote:
> > nit: both comments are redundant - the meaning is clear from the code
> > itself.
> 
> I will drop them in v3.
> 
> > This maximum value check bugs me a bit.
> > 
> > First of all, why does it matter what is the region end? Potentially, there can be
> > regions not backed by host address space (leave alone host RAM), so why
> > intropducing this limitation?
> > 
> > Second, this check takes a host-specific constant (MAX_PHYSMEM_BITS) and rounds it down
> > to hypervisor-specific units which may not be aligned with the host page
> > size. Should this be host pages instead?
>  
> This check was suggested by Roman in v1 review. Roman, could you
> share your thoughts on Stanislav's concerns? I'd like to align on whether an upper
> bound check is needed here.

Hey Junrui, Stanislav,

The idea was that there is a max PFN/GFN going over which is _architecturally_ impossible.
It might be ((1 << 52) - 1) << 12 or ((1 << 48) - 1) << 12 or similar depending on how
many bits are used for the guest phys. address (52, 48, 36) and page sizes. The gist is
that max is way below 0xFFFF_FFFF_FFFF_FFFF (1<<64 - 1) used for overflow checking in the
original v1 patch. Hence, instead of checking for overflow, one may check for that max
PFN/GFN catching way more bad input. Checking for that max also feels as more
domain-specific compared to the "generic" overflow check.

I went for the trade-off where the "impossible" PFN/GFN is computed simply as
(1 << max_possible_bits_in_the_address)/the_min_possible_page_size. Again, that's simple
and better than the oveflow check as it catches the region with PFNs/GFNs that just cannot
be used. I agree that may overshoot, and an even more specific check would have to fetch the
CPUID for the VM (or its ARM64 MMFR regs), etc. to get more specifics and a lower bound
on the bad GFN (but at the cost of more computation).

All in all, from the three options of (generic check for overflow, simple check
for arch bad PFNs/GFNs, an elaborated check with all specifics) I suggested the simple check.
Fast and still more useful than checking for overflow in my opinion.

Below I go into various details on "why impossible" and these 48 and 52 bits, and I most
likely will be re-iterating things that you know - just for the convenience of other
folks who don't play with MMU/EPT/etc often, and might find the topic interesting.
It may happen that I'll also learn something from your critique, thanks in advance :)

That max PFN/GFN is dictated by the maximum number of bits allowed to be used in
the physical address. Above that, an address would not be mapped or cached by
the machines that run the code in question. The page tables won't work as the number
of bits used for the physical address here is the sum of the bits used to index
into a page table + the offset bits. That also gives the number of bits in the virtual
address which the CPU needs to address the memory (again, in this modern case;
there were many years ago machines with 32 bit virt addresses and 36 bit phys
addresses used via PAE/AWE).

E.g. for the x64_86 and 48 bits in the phys addresses: the VAs have 9+9+9+9 bits per
each page table hierarchy + 12 bits for the page offset in 4KiB (1<<12) pages. That
also can be played as 9+9+9 and 21 bits which gives 3 level paging and 2MiB (1<<21)
pages but still _48_ bits for the VA and the phys. address. Sure can be 9+9 bits for
2-level pages and 30 bits for the page offset (1GiB pages, 1 << 30). Still, _48_
bits. Similar aruphmetic goes for _52_ bit addresses but going to need 5-level pages
this time.

Now, can you have 53 bits in the phys address (to address 1<<53 bytes)? No, you
cannot as that doesn't work with the existing x86_64 MMUs (and ARM64) - no virtual
address can be constructed to address 53 bits - not enough levels in the page table
hierarchy. As no VA can be constructed, the code won't be able to access the data.

Neither the EPT/2nd level set up by the hypervisor, nor for 1st level translation
set up by the guest or the host can go higher than 52 bits, even for MMIO. When MMIO
happens, that's a 2nd level fault/not present page and goes to the hypervisor but
_still_ the hv builds the EPT/2nd level map by the rules of the architecture and
cannot go above the architecturally imposed limits.

--
Cheers,
Roman

> 
> Thanks,
> Junrui Luo

