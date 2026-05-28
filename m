Return-Path: <linux-hyperv+bounces-11292-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFw0IyOaF2qcKwgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11292-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 03:28:03 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCE95EB8CD
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 03:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FE06301F9D2
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 01:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AC22594BD;
	Thu, 28 May 2026 01:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uefu3v49"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B77233923
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 01:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779931681; cv=none; b=NIVuq3RHq8v27r/HPKq4KeqgCkAouKpk5EwVHOhBMPqFBPAITj9F907FmJMPMm02Axl/jZf+2LXzeH6WjPG4TwhNwlPytyvG/bViQdb3m5HLncwcnAChNDeOnbkU8NgS4qbbIJZXnSVfod5+2ph6H5aoPySpS7thwotGryDOxnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779931681; c=relaxed/simple;
	bh=lAWfNc0k7QbToOaimyf8uhKR4Lv8NkiPnIRoC8cjmJc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=REPvjUyLmc2MItPZjHLhUXsGLESGNbzvcAFAXiNwwIx+y5R3k5k/PvB1pFvd826D+yN1JsiqFS2Qf9DZ5mkCwNaM2Z214UcVHUlKO8HBPBzn6nUjMUlDRPDzH+vumRHeCUWmMiLS1C/wR339xa1112apwXVy/GKzZvhzMahF5g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uefu3v49; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B511F000E9;
	Thu, 28 May 2026 01:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779931679;
	bh=VWs4JJVwc0O4bWR/u5pE28P+EpayJ9gwXmRrMhH9Etw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uefu3v49QiYO4rWgMkHQY52RfAw+Lq6zszYniLg4/H+dlq30gQ7E265egKRGR3C2D
	 2c0HmqVKAq9Tvw7Hoel2hlbkFPUFF1G+hTAEQqn8Q3/dW0F+Q4uIYzWFsqFGRtnnG2
	 xloq9OYtXwE/p9TeyzxYgH+/HCYbqgwI0IqWfvbuHETGPLhtbhVzQJG0jTiuYuV6K4
	 E0fCZFZ5xATICN0FxTxSffrBktOZdQxj/dENcVO1E1GeWTuKQBgNB54jkdrfJKi9bj
	 IQc4VgNz5epvArOX4A175yC3oTFlinbc2yKenV7IjIqDHm55m92p9N6ej4s6BAGaJe
	 UW70bFwVlMfLg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 14/20] kho: Add crash-kernel-safe radix tree
 presence check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jork Loeser" <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260528004204.1484584-15-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-15-jloeser@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 01:27:58 +0000
Message-Id: <20260528012759.60B511F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11292-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: DFCE95EB8CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] In-place conversion destructively modifies the old kernel's memory=
, corrupting the crash dump.
- [High] Unbounded per-node `memremap()` calls can quickly exhaust the cras=
h kernel's limited memory resources.
- [High] Lack of physical address validation before `memremap()` risks trig=
gering Machine Check Exceptions (MCE).
- [Medium] `kho_radix_crash_contains_page()` fails to identify subpages of =
higher-order folios.
- [Medium] The exported API lacks a teardown function, resulting in permane=
nt vmap memory leaks.
--

commit c1bba78846e7698e1b8a124f8432407d41f69b0c
Author: Jork Loeser <jloeser@linux.microsoft.com>
Subject: kho: Add crash-kernel-safe radix tree presence check

In the crash kernel, the old kernel's memory is outside the direct map.
This patch adds a read-only radix tree variant that memremaps nodes during
init so that subsequent page presence checks can traverse the tree with
plain pointer dereferencing.

> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index 2e2b4e73f00d3..0dfdf0f9781ef 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
[ ... ]
> @@ -396,6 +397,129 @@ void kho_radix_destroy_tree(struct kho_radix_tree *=
tree)
>  }
>  EXPORT_SYMBOL_GPL(kho_radix_destroy_tree);
> =20
> +/*
> + * Convert a crash tree node's children from PA to VA in-place via memre=
map().
> + * On failure, already-remapped pages are not cleaned up -- the crash ke=
rnel
> + * is short-lived and will reboot after dump collection, so the leak is
> + * inconsequential.
> + */
> +static int kho_radix_crash_convert_node(struct kho_radix_node *node,
> +					unsigned int level)
> +{
> +	struct kho_radix_node *child;
> +	unsigned int i;
> +	int err;
> +
> +	for (i =3D 0; i < (1 << KHO_TABLE_SIZE_LOG2); i++) {
> +		if (!node->table[i])
> +			continue;
> +
> +		/* Validate: PA must have bit 63 clear and be page-aligned */
> +		if ((node->table[i] & BIT_ULL(63)) ||
> +		    (node->table[i] & (PAGE_SIZE - 1)))
> +			return -EINVAL;
> +
> +		child =3D memremap(node->table[i], PAGE_SIZE, MEMREMAP_WB);

[Severity: High]
Since this recursively calls memremap() for every populated node in the tre=
e,
could this exhaust the crash kernel's limited memory resources? A fully
populated tree might create thousands of individual virtual mappings, consu=
ming
significant memory for tracking structures like vm_struct and page tables.

Also, the untrusted physical addresses read from the crashed kernel's memory
are passed blindly to memremap(). If the old kernel crashed due to memory
corruption, could these pointers contain garbage values pointing to non-RAM
regions like MMIO, potentially triggering a Machine Check Exception (MCE) w=
hen
accessed?

> +		if (!child)
> +			return -ENOMEM;
> +
> +		/* Overwrite PA with VA in-place */
> +		node->table[i] =3D (u64)(uintptr_t)child;

[Severity: High]
Because memremap() creates a direct mapping to the underlying physical memo=
ry,
does assigning the virtual address here destructively modify the old kernel=
's
physical memory? This seems like it would corrupt the crash dump, causing
offline analysis tools like crash or makedumpfile to encounter meaningless
virtual addresses instead of the original physical addresses.

> +
> +		/* Recurse for intermediate levels; level 1 children are leaves */
> +		if (level > 1) {
> +			err =3D kho_radix_crash_convert_node(child, level - 1);
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * kho_radix_crash_init - Initialize a crash-kernel view of a KHO radix =
tree.
[ ... ]
> + */
> +int kho_radix_crash_init(struct kho_radix_crash_tree *tree, phys_addr_t =
root_pa)
> +{
> +	struct kho_radix_node *root;
> +	int err;
> +
> +	tree->root =3D NULL;
> +
> +	if (!root_pa || (root_pa & (PAGE_SIZE - 1)))
> +		return -EINVAL;
> +
> +	root =3D memremap(root_pa, PAGE_SIZE, MEMREMAP_WB);
> +	if (!root)
> +		return -ENOMEM;
> +
> +	err =3D kho_radix_crash_convert_node(root, KHO_TREE_MAX_DEPTH - 1);
> +	if (err)
> +		return err;
> +
> +	tree->root =3D root;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(kho_radix_crash_init);

[Severity: Medium]
This API is exported to modules and allocates mappings via memremap(), but
there is no corresponding kho_radix_crash_destroy() provided. Even if the
crash kernel is short-lived, should kernel APIs exported to modules enforce
symmetrical resource lifecycle management to avoid permanent vmap memory
leaks if a module is unloaded or fails initialization?

> +
> +/**
> + * kho_radix_crash_contains_page - Check if a page is in a crash-kernel =
radix tree.
[ ... ]
> + * Note: This function checks specifically for the presence of the page =
at the
> + * given order. If a larger order page that encompasses this page is pre=
served,
> + * this function will return false.
> + *
> + * Return: true if the page is present in the tree, false otherwise.
> + */
> +bool kho_radix_crash_contains_page(struct kho_radix_crash_tree *tree,
> +				   unsigned long pfn, unsigned int order)
> +{
> +	unsigned long key =3D kho_encode_radix_key(PFN_PHYS(pfn), order);

[Severity: Medium]
Since this searches for an exact match of the provided pfn and order, doesn=
't
this fail to identify subpages of higher-order folios? If a page was
preserved as part of a higher-order folio, an order-0 query for a PFN within
that folio will fail to find the key and incorrectly return false.=20

Would callers like pfn_is_ram() be forced to manually iterate through all
possible orders up to MAX_PAGE_ORDER to reliably determine if a page is
preserved?

> +	struct kho_radix_node *node =3D tree->root;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528004204.1484=
584-1-jloeser@linux.microsoft.com?part=3D14

