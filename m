Return-Path: <linux-hyperv+bounces-11296-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J4mCfucF2rXLAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11296-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 03:40:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCD05EB940
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 03:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8206030315C1
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 01:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9322D0C9D;
	Thu, 28 May 2026 01:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PetnnsxA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01F327E076
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779932407; cv=none; b=szxucFxjZHFXGp0OuV6wPJaou1pwlmAOJvs2sghUB/51yqFUB8iPF8YZYud5+RTKHBq4qwwxQWy2z7/BeFnAVcCC1rgc4VCM1lY4nLQPhNRJcvdTkeTAGr9cKlkjEV6OAN3zaPMDq3vEQ2CNBjRxK43EfrwwWAQEBaSI7OzfAzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779932407; c=relaxed/simple;
	bh=o0UVCwa/KpZpZMIAhcZErOTQ6WrTghbKJFsdoDSdrFQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dBIKjka26ZRGBqeFQbhYVODYRaZ1Lv081F/8Nn6nFrAsjXXavvCMgAz3ILltcAxx91JxU2DV7Dp1pDgPpjy4NLhmFQbWSU/aEMYGVPVHhP9RUZGnyANDCWFt6cqMvPXZ5xvsHXhF8OPSDVrIbhuxIXiKqokC6MICo+YyMiAHvw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PetnnsxA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F651F000E9;
	Thu, 28 May 2026 01:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779932406;
	bh=fc2gFLpZfGZef32ZD18Df99hywrKB4SsFpGGaiGUPhM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PetnnsxAlc/tbWBWZ9ct1g861mhT3BXuO7taaFp3bfEcYRMyojTiMSF74xGpoRiPe
	 tplO9NYcY1EUmuHzVtQJmKpJ9d3CAmrjfnYR9UiRQZ5TSUlSasihNAIibRnx8AXhIx
	 Rx67MblAWhKcxA0JbYXpwy8wYHi4CYGUYFaiCVlUkw/bd2EwazSYo/I2IVqNBF1nF6
	 c0AWYF7EmQ/BOPP94NQtJjnma9ej5IlgQdbdMDB8PnUvy6HEIqNUKzJPKe8+d6rn4b
	 E8v9OMt+idBQEDQ95kav9l+fU2pLb2v5A64ejcMscpXJYs0/wGpzUQtkrp0za4P7Z2
	 WFgpBVe8W6NLA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 06/20] kho: allow early-boot usage of the KHO radix
 tree
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jork Loeser" <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260528004204.1484584-7-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-7-jloeser@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 01:40:05 +0000
Message-Id: <20260528014006.43F651F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11296-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Queue-Id: 7DCD05EB940
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kho_radix_alloc_node() incorrectly uses slab_is_available() to det=
ermine if the buddy allocator can be used, leading to double-allocation and=
 memory corruption during boot.
- [High] kho_radix_free_node() conditionally frees memory based on the curr=
ent global boot state rather than how the memory was originally allocated, =
leading to page state corruption or crashes.
--

commit 470d80274c16904cd71b8b9c878c7272d6b58647
Author: Pratyush Yadav (Google) <pratyush@kernel.org>

kho: allow early-boot usage of the KHO radix tree

This commit updates the KHO radix tree to support allocations during early =
boot
when the buddy allocator is not yet available. It introduces
kho_radix_alloc_node() and kho_radix_free_node() which use slab_is_availabl=
e()
to toggle between memblock and buddy allocators.

> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index f6de6bf632261..5c201e605b969 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
[ ... ]
> @@ -143,6 +143,26 @@ static unsigned long kho_radix_get_table_index(unsig=
ned long key,
>  	return (key >> s) % (1 << KHO_TABLE_SIZE_LOG2);
>  }
> =20
> +static void __ref *kho_radix_alloc_node(void)
> +{
> +	struct kho_radix_node *node;
> +
> +	if (slab_is_available())
> +		node =3D (struct kho_radix_node *)get_zeroed_page(GFP_KERNEL);
> +	else
> +		node =3D memblock_alloc(PAGE_SIZE, PAGE_SIZE);

[Severity: High]
Will this check cause memory corruption during the window between buddy
initialization and slab initialization?

During boot, memblock_free_all() hands over all unreserved pages to the bud=
dy
allocator. However, slab_is_available() remains false until kmem_cache_init=
()
finishes later in mm_core_init().=20

If kho_radix_alloc_node() is called in this window, it evaluates
slab_is_available() as false and falls back to memblock_alloc(). This means
it will reserve physical memory that the buddy allocator is already actively
managing, potentially leading to a silent double-allocation where KHO radix
tree nodes alias with other kernel allocations.

> +
> +	return node;
> +}
> +
> +static void __ref kho_radix_free_node(struct kho_radix_node *node)
> +{
> +	if (slab_is_available())
> +		free_page((unsigned long)node);
> +	else
> +		memblock_free(node, PAGE_SIZE);
> +}

[Severity: High]
Could checking slab_is_available() at the time of freeing cause crashes or
memory leaks for nodes allocated during early boot?

If a node is allocated early via memblock_alloc(), it is backed by a
PageReserved physical page. If this same node is later freed after the
slab allocator has been initialized, slab_is_available() will be true,
causing the free path to incorrectly call free_page() on the reserved page.

Calling free_page() on a memblock-reserved page fails in __free_pages_prepa=
re()
because PAGE_FLAGS_CHECK_AT_FREE includes PG_reserved. This triggers a
bad_page() warning, dumps the stack, and leaks the memory.

Should this code determine the deallocation method based on the node's
actual allocation origin, such as checking PageReserved(virt_to_page(node)),
rather than checking the current global boot state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528004204.1484=
584-1-jloeser@linux.microsoft.com?part=3D6

