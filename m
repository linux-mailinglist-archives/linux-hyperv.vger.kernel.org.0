Return-Path: <linux-hyperv+bounces-9394-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODdNDERSs2l8UwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9394-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 00:54:44 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A22C627B5F1
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 00:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 922B73041D49
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 23:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FA1264A86;
	Thu, 12 Mar 2026 23:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fk+HrQFz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GjeLT5PO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nK3FApym";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6EDt9gxw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411BB40825B
	for <linux-hyperv@vger.kernel.org>; Thu, 12 Mar 2026 23:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773359681; cv=none; b=GpxzyuzCpQ6RMt4dFMUwXdCpdIvYqMdsYjhg0U7WGAdS7quFwYhOiAGhgOQuWGU9qmbFZIpthsl/1E7+tK9q+qlsofpi184hf/pmjGJ8E/pUd8yjrviK75PGiBZS1aEMABwNVWDBMwmOaJIhd3ONnIdGmEamT0Fb2XKPKE5Q9AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773359681; c=relaxed/simple;
	bh=DlEs47g+0P4QzsWSD4V/FyGf/EgdMLa8LqEPSZOP0wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUWCQZNOvs/iP9jHd+RLALSubhZPz5NSgvH6/nLMeqJeBK6ew5sxy83xwfjXfSx2w+ff7boMzh6jcmVGncwNi0/6e7HT2pZORWthSnhbkOEQS3KmAV0QcrfCXoiP9fpKcqMZ09si6rk1ECdOHHLUA9S8hLTP5LqqMWZ5nFttcpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fk+HrQFz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GjeLT5PO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nK3FApym; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6EDt9gxw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DBF7F4DE48;
	Thu, 12 Mar 2026 23:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773359673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bwmhrK1mTh+MLga869G8X7ffK5a55BOcYDLNgMLau3w=;
	b=fk+HrQFzF538OaZee5zKteZcA0YzllQN4x1inGCAbXjNlo6QUNFUqNbGrCH5EeTJbbl1jk
	FTvU17qIJfkQDV+ln6qt+1UPpVopM6PIvAMUtTOjZZJ3/a+RYpvPc0tmmUajk0tARslnmX
	EHrtJDNB0KVkLkU4HiHWqk3laOWGWpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773359673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bwmhrK1mTh+MLga869G8X7ffK5a55BOcYDLNgMLau3w=;
	b=GjeLT5POJ2ppQv2V8UcAch81RQWi73SsE94ZqWuISHtXbtVGKO30Qb71oigY1fJWtdCROD
	hJQD5w9T4bPhNBAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nK3FApym;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6EDt9gxw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773359672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bwmhrK1mTh+MLga869G8X7ffK5a55BOcYDLNgMLau3w=;
	b=nK3FApym7tfNn1DYJAjxANwZrZkOi+7diHoNWII3ULI7GL59N/yI/X6ge92tRZaTNO+iDP
	rbkiSLfVzTovlXnwx+sm2XdjW+milZHXwHV3OFqONrs/aDXtvH33MrKfrw0c8b1brwsruE
	f+oOYH59XwjN26di3wGpoeV3fGBkJnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773359672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bwmhrK1mTh+MLga869G8X7ffK5a55BOcYDLNgMLau3w=;
	b=6EDt9gxwjTnn8WVNa/iDDOJbUxG4c6IPQDPESQ58T74caGcpdtTs0tWldMb3C2Klzv+2cX
	aUwaMbUSyMcQ9xBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A3794022C;
	Thu, 12 Mar 2026 23:54:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QCh3CDhSs2lNPAAAD6G6ig
	(envelope-from <ematsumiya@suse.de>); Thu, 12 Mar 2026 23:54:32 +0000
Date: Thu, 12 Mar 2026 20:54:29 -0300
From: Enzo Matsumiya <ematsumiya@suse.de>
To: Yury Norov <ynorov@nvidia.com>
Cc: Yury Norov <yury.norov@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
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
Message-ID: <atnytehtvt6h6kp2ndxsa3x257usezp3bk5hp4ch7gf5w2zake@omihp5zbio3l>
References: <20260312230817.372878-1-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260312230817.372878-1-ynorov@nvidia.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,rasmusvillemoes.dk,kernel.org,zx2c4.com,vger.kernel.org,lists.infradead.org,microsoft.com,ziepe.ca,samba.org,amazon.com,soleen.com];
	TAGGED_FROM(0.00)[bounces-9394-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ematsumiya@suse.de,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A22C627B5F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Yury,

On 03/12, Yury Norov wrote:
>Based on 'sizeof(x) == 4' condition, in 32-bit case the function is wired
>to ffs(), while in 64-bit case to __ffs(). The difference is substantial:
>ffs(x) == __ffs(x) + 1. Also, ffs(0) == 0, while __ffs(0) is undefined.
>
>The 32-bit behaviour is inconsistent with the function description, so it
>needs to get fixed.
>
>There are 9 individual users for the function in 6 different subsystems.
>Some arches and drivers are 64-bit only:
> - arch/loongarch/kvm/intc/eiointc.c;
> - drivers/hv/mshv_vtl_main.c;
> - kernel/liveupdate/kexec_handover.c;
>
>The others are:
> - ib_umem_find_best_pgsz(): as per comment, __ffs() should be correct;
> - rzv2m_csi_reg_write_bit(): ARCH_RENESAS only, unclear;
> - lz77_match_len(): CIFS_COMPRESSION only, unclear, experimental;
>
>None of them explicitly tweak their code for a word length, or x == 0.

Context for lz77_match_len() case:

	const u64 diff = lz77_read64(cur) ^ lz77_read64(wnd);

	if (!diff) {
	...
	}

	cur += count_trailing_zeros(diff) >> 3;

So x == 0 is checked, however it does assume that
sizeof(unsigned long) == sizeof(u64).  I'll have to fix it for when
that's not the case (even with your patch in, as __ffs() casts x to
unsigned long down the line).  Thanks for the heads up.


Cheers,

Enzo

>Requesting comments from the corresponding maintainers on how to proceed
>with this.
>
>The attached patch gets rid of 32-bit explicit support, so that both
>32- and 64-bit versions rely on __ffs().
>
>CC: "K. Y. Srinivasan" <kys@microsoft.com> (hyperv)
>CC: Haiyang Zhang <haiyangz@microsoft.com> (hyperv)
>CC: Jason Gunthorpe <jgg@ziepe.ca> (infiniband)
>CC: Leon Romanovsky <leon@kernel.org> (infiniband)
>CC: Mark Brown <broonie@kernel.org> (spi)
>CC: Steve French <sfrench@samba.org> (smb)
>CC: Alexander Graf <graf@amazon.com> (kexec)
>CC: Mike Rapoport <rppt@kernel.org> (kexec)
>CC: Pasha Tatashin <pasha.tatashin@soleen.com> (kexec)
>Signed-off-by: Yury Norov <ynorov@nvidia.com>
>---
> include/linux/count_zeros.h | 9 +++------
> 1 file changed, 3 insertions(+), 6 deletions(-)
>
>diff --git a/include/linux/count_zeros.h b/include/linux/count_zeros.h
>index 4e5680327ece..5034a30b5c7c 100644
>--- a/include/linux/count_zeros.h
>+++ b/include/linux/count_zeros.h
>@@ -10,6 +10,8 @@
>
> #include <asm/bitops.h>
>
>+#define COUNT_TRAILING_ZEROS_0 (-1)
>+
> /**
>  * count_leading_zeros - Count the number of zeros from the MSB back
>  * @x: The value
>@@ -40,12 +42,7 @@ static inline int count_leading_zeros(unsigned long x)
>  */
> static inline int count_trailing_zeros(unsigned long x)
> {
>-#define COUNT_TRAILING_ZEROS_0 (-1)
>-
>-	if (sizeof(x) == 4)
>-		return ffs(x);
>-	else
>-		return (x != 0) ? __ffs(x) : COUNT_TRAILING_ZEROS_0;
>+	return (x != 0) ? __ffs(x) : COUNT_TRAILING_ZEROS_0;
> }
>
> #endif /* _LINUX_BITOPS_COUNT_ZEROS_H_ */
>-- 
>2.43.0
>
>

