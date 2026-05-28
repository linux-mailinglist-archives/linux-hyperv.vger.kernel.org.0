Return-Path: <linux-hyperv+bounces-11293-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEUhNXGbF2ohLAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11293-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 03:33:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9D65EB91C
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 03:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A162305D854
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 01:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEA72D060C;
	Thu, 28 May 2026 01:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7pqm1kt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDD41D5170
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 01:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779931987; cv=none; b=vEJZEdq1pkCae5iRM0eGTE175Ir3eXLqRP8lLYAznfvlYz0jU92LV0sASNGlwTX1I7HM6m3rN05hCB6QHX98w4wZ2XfRwdUotcNnIRVK6lsuazhq40zx7CntiYGme0vhHHAFgl4L/CC+b2vT8gAz1ORL0QBy+D7MzquTBl/2en4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779931987; c=relaxed/simple;
	bh=vEOLgHWhzRsZA4grzJY0iJGaO04G372/MsgxZi7fXvE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZEGKlyLGR7UQyzq+T7J0RadWMudC8/N8un4/J71eh0ZFnzk0PFZ12HZbOAXO1QHJ3hl73u/AMLf7CV6syiuYt1X0g0+MOTnK4fTluWA7UkxzjVntKox3BnmwZCwIycW3FTpHT6bx5Qm6TsSPi0EgDiD2nC7ai+/l90p9nEpOHng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7pqm1kt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A8D1F00A3A;
	Thu, 28 May 2026 01:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779931985;
	bh=B9SCI4JCibcPU2/kPdXkLskU7+p67DDvU7ZaHaSchhQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S7pqm1ktAK49qvSuCRRKjErsovrGK9h1wNvYFeq0EMvpI1xTV71X1gVO3cvbCMi4h
	 Z5EB0y9DTHXzObHxiNzz0MVXPRHcE5LX/p2VNej9VSWVH0zzmK/YNIPdFhHSJf20cL
	 MDSG46ojsZTAHJ+VDW8zPivhHWtyRJt98DjpPwnClSktKH1sPobCdiHkS2ds+ImfXB
	 hsX9xPlNPdZwCBzEeDr/dv2yNioejyaRt7Y7jjNWIibNQvmYpBRWMj26Fx28s46SWD
	 OhEsWd61GoTSP9ZMkj6abCNd3X/E9BLw8qi6uNSZaDRC84Yoj3usqahU4k83Ncnd5c
	 RRgEpyDcn0LOA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 04/20] kho: add callback for table pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jork Loeser" <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260528004204.1484584-5-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-5-jloeser@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 01:33:04 +0000
Message-Id: <20260528013305.63A8D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11293-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 3E9D65EB91C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Severe out-of-bounds memory accesses and ABI incompatibility d=
ue to incorrect node sizing on 32-bit platforms.
- [High] Pre-existing memory corruption risk due to `kzalloc` crossing page=
 boundaries for KHO radix root node.
- [High] Undefined behavior and logic failure due to 64-bit shift assumptio=
ns on 32-bit platforms.
--

commit a4a688bed2326d7eaaf8a3a47636fe600e228c89
Author: Pratyush Yadav (Google) <pratyush@kernel.org>

kho: add callback for table pages

The KHO memory preservation radix tree does not mark the table pages
themselves as scratch. This means any walker looking for free ranges of
memory outside of scratch areas will ignore the table. This patch adds a
table callback that is invoked for each table page to address this.

> diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tre=
e.h
> index 030da6399d288..fe7151d89361d 100644
> --- a/include/linux/kho_radix_tree.h
> +++ b/include/linux/kho_radix_tree.h
> @@ -37,12 +37,15 @@ struct kho_radix_tree {
>  /**
>   * struct kho_radix_walk_cb - Callbacks for KHO radix tree walk.
>   * @key:      Called on each present key in the radix tree.
> + * @table:    Called on each table of the radix tree itself. Receives the
> + *            physical address of the page containing the table.
>   *
>   * For each callback, a return value of 0 continues the walk and a non-z=
ero
>   * return value is directly returned to the caller.
>   */
>  struct kho_radix_walk_cb {
>  	int (*key)(unsigned long key);

[Severity: High]
This isn't a bug introduced by this patch, but does the key encoding work
correctly on 32-bit platforms?

Looking at kho_encode_radix_key(), the code performs
1UL << (KHO_ORDER_0_LOG2 - order). With KHO_ORDER_0_LOG2 defined as
64 - PAGE_SHIFT (52 for 4KB pages), doesn't shifting a 32-bit 1UL by
52 bits invoke undefined behavior?

Additionally, since the radix key is typed as unsigned long (which is 32 bi=
ts
on these platforms), is it structurally possible to encode and decode the
52-bit shifted physical address and order bit as designed?

> +	int (*table)(phys_addr_t phys);
>  };
> =20

[ ... ]

> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index b22b3cec251ee..0f8d058f1a272 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c

[ ... ]

> @@ -295,6 +301,12 @@ static int __kho_radix_walk_tree(struct kho_radix_no=
de *root,
>  	unsigned int shift;
>  	int err;
> =20
> +	if (cb->table) {
> +		err =3D cb->table(virt_to_phys(root));

[Severity: High]
This isn't a bug introduced by this patch, but does the KHO radix tree root
node get allocated via kzalloc(PAGE_SIZE, GFP_KERNEL) in kho_init()?

The SLUB allocator does not guarantee page alignment for PAGE_SIZE objects
when debugging features (like redzones) are enabled. If the root node cross=
es
a physical page boundary, won't this table callback only receive the physic=
al
address of the start of the object?

If a walker treats this address as a single page, could it fail to mark the
second page as in-use? During kexec, couldn't this unmarked page be treated
as free scratch memory and overwritten, corrupting the KHO radix tree for t=
he
incoming kernel?

Note: I see this is fixed later in the series in commit
d207a159c7c112b64706fe2fb64399a65932fdb6 ("kho: add kho_radix_init_tree()").

> +		if (err)
> +			return err;
> +	}
> +
>  	for (i =3D 0; i < PAGE_SIZE / sizeof(phys_addr_t); i++) {

[Severity: Critical]
This is a pre-existing issue, but does this loop correctly bound memory
accesses on 32-bit platforms?

Since sizeof(phys_addr_t) is 4 bytes on 32-bit platforms,
PAGE_SIZE / sizeof(phys_addr_t) evaluates to 1024 for 4KB pages.
KHO_TABLE_SIZE_LOG2 evaluates to 10, meaning the table array in
struct kho_radix_node has 1024 elements of type u64 (8 bytes each).
This makes the structure 8192 bytes large.

If node allocations only allocate a single PAGE_SIZE (4096 bytes), won't
accessing root->table[i] in this loop up to 1024 read and write well past
the bounds of the allocated page?

Also, by relying on sizeof(phys_addr_t), doesn't the FDT format vary by
platform and break ABI cross-compatibility?

>  		if (!root->table[i])
>  			continue;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528004204.1484=
584-1-jloeser@linux.microsoft.com?part=3D4

