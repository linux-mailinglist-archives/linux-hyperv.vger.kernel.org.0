Return-Path: <linux-hyperv+bounces-11294-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL72ApubF2ohLAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11294-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 03:34:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F99B5EB925
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 03:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D288C3047249
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 01:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FED1D5170;
	Thu, 28 May 2026 01:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bO+XLTro"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213C1A6823
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779932056; cv=none; b=EDp70htyWIDfNur5ulH0rEMwlxtQYQGPL1fAtVw7jA38lqygDUFc6euwIGNHowv5ai0nXT12sNcAQ3egGPAkNmlRSuo25gYwUHiT828LvYBwlbRvirL0sVL2AvrSMYubamIDuLZxhZYn9ErXyM6zHycbj62t1w2jGOPLBe9qZ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779932056; c=relaxed/simple;
	bh=j28TkOVEQQqvZX5JOg37Ze7pnqyoU5R/rvjk8FElFts=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UG/y30Zzj+HxEz1s+hzl+0L9uqChuZAlkktxBoPb3kcw8bXIwcOcn9io6IyuKKdNe5ZKEaipWS4eLR1acQ6P9GKZ0085CxPzm7GZSGLnMkxzyxmXkbVK6rmDYncM7EBlB2OErFfwLAyCyfrBJ9F5p3gjRBqh3YVdQAHLTnKQb1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bO+XLTro; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CF91F000E9;
	Thu, 28 May 2026 01:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779932054;
	bh=4oqEntpKdE60W6o8aL/ICRuH/Z9UEGKRGpLiTlDUZ14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bO+XLTrocTvTzz9rRe0pwpDVqkbeCkcZNTKDdB/8WI9lo7qGHNbsMegaDUJlBrw7I
	 CTRIi9uOZIwgsYHuqTk1423u9m/UDKDTQM161qVCAfOe+w9GVuD+FSEWiU1D0Y/Slg
	 g10adLtuWGGajFiCQCXdGaqmZj49gPQ24bdN257Mv2tR/lb8/kGFX1yTM3/HJcHvUB
	 GxGW/IzvEvzlE7Y76ZhiD0XpdyZEJ3T5FQpo5D3kAYomIaTS3wLDexx0d5GRiPjIrC
	 X+Lb0OQIoXdQqpLPlNUC7GeHL01TIpXC+JT4b3kvZ+N8rcAdFgCScqCrRGB7PIIF+a
	 IXLcuh7Efe6rQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 13/20] kho: add radix tree freeze and del_key()
 error reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jork Loeser" <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260528004204.1484584-14-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-14-jloeser@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 01:34:14 +0000
Message-Id: <20260528013414.67CF91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11294-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 5F99B5EB925
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] `kho_radix_tree_freeze()` locks the tree mutex without verifying i=
f the tree has been initialized.
- [Medium] `kho_radix_del_key()` does not accurately report `-ENOENT` if th=
e key is missing but its leaf node exists.
- [Low] The docstring for `kho_radix_tree` instructs developers to pass a p=
hysical address to initialize the tree, which will lead to a crash.
- [Low] The error path in `kho_init()` frees the radix tree root using `fre=
e_page()`, breaking the allocator abstraction.
--

commit da7ab3d5519dc40884c4213f1650e1238149beb0
Author: Jork Loeser <jloeser@linux.microsoft.com>

kho: add radix tree freeze and del_key() error reporting

This commit adds kho_radix_tree_freeze() to prevent modifications to a KHO
radix tree. It also updates kho_radix_del_key() to return an integer so it
can report errors like -EBUSY and -ENOENT.

> diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tre=
e.h
> index c0840ecb230c8..4fe2238e1e30a 100644
> --- a/include/linux/kho_radix_tree.h
> +++ b/include/linux/kho_radix_tree.h
> @@ -21,10 +21,10 @@
>   * scheme. Each key is an unsigned long that combines a page's physical
>   * address and its order.
>   *
> - * Client code is responsible for allocating the root node of the tree,
> - * initializing the mutex lock, and managing its lifecycle. It must use =
the
> - * tree data structures defined in the KHO ABI,
> - * `include/linux/kho/abi/kexec_handover.h`.
> + * Client code must initialize the tree using kho_radix_tree_init(). Pass
> + * a physical address to restore a tree preserved across kexec, or 0 to

[Severity: Low]
Is this documentation accurate? The tree traversal functions treat
tree->root as a virtual address pointer. If a caller passes a raw physical
address without using phys_to_virt(), would it cause a page fault upon the
first dereference?

> + * allocate a fresh empty tree. The tree uses data structures defined in
> + * the KHO ABI, `include/linux/kho/abi/kexec_handover.h`.
>   */

[ ... ]

> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index 797ec285b698c..2e2b4e73f00d3 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -79,9 +79,6 @@ struct kho_out {
> =20
>  static struct kho_out kho_out =3D {
>  	.lock =3D __MUTEX_INITIALIZER(kho_out.lock),
> -	.radix_tree =3D {
> -		.lock =3D __MUTEX_INITIALIZER(kho_out.radix_tree.lock),
> -	},
>  };

[ ... ]

> @@ -180,6 +177,28 @@ static void __ref kho_radix_free_node(struct kho_rad=
ix_node *node)
>  		memblock_free(node, PAGE_SIZE);
>  }
> =20
> +/**
> + * kho_radix_tree_freeze - Freeze the tree, preventing further modificat=
ions.
> + * @tree: The KHO radix tree to freeze.
> + *
> + * After freezing, kho_radix_add_key() and kho_radix_del_key() will retu=
rn
> + * -EBUSY. The check is performed under the tree's mutex, so there is no
> + * race between a concurrent add/del and the freeze.
> + *
> + * Return: 0 on success, -EBUSY if the tree is already frozen.
> + */
> +int kho_radix_tree_freeze(struct kho_radix_tree *tree)
> +{
> +	guard(mutex)(&tree->lock);

[Severity: High]
Could this cause a crash if called on an uninitialized tree?

Because the static __MUTEX_INITIALIZER was removed from
kho_out.radix_tree.lock in this patch, the mutex is zero-initialized before
kho_radix_init_tree() is called.

Unlike kho_radix_add_key() and kho_radix_del_key(), which safely check
if (WARN_ON_ONCE(!tree->root)) before taking the mutex, this function
directly attempts to lock it.

> +
> +	if (tree->frozen)
> +		return -EBUSY;
> +
> +	tree->frozen =3D true;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(kho_radix_tree_freeze);

[ ... ]

> @@ -300,6 +328,8 @@ void kho_radix_del_key(struct kho_radix_tree *tree, u=
nsigned long key)
>  	leaf =3D (struct kho_radix_leaf *)node;
>  	idx =3D kho_radix_get_bitmap_index(key);
>  	__clear_bit(idx, leaf->bitmap);
> +
> +	return 0;
>  }

[Severity: Medium]
Will this correctly report -ENOENT if the key is missing but the leaf
node exists?

The commit message states kho_radix_del_key() was updated to report -ENOENT
when a key is not present. However, if other keys share the same leaf node
and the target key's bit is already 0, __clear_bit() does nothing and this
silently returns 0.

Should this use test_and_clear_bit() and return -ENOENT if the bit was not
previously set?

>  EXPORT_SYMBOL_GPL(kho_radix_del_key);

[ ... ]

> @@ -1807,7 +1836,7 @@ static __init int kho_init(void)
>  err_free_fdt:
>  	kho_unpreserve_free(kho_out.fdt);
>  err_free_kho_radix_tree_root:
> -	kfree(tree->root);
> +	free_page((unsigned long)tree->root);

[Severity: Low]
Is it safe to use free_page() directly here instead of calling
kho_radix_free_node()?

Since kho_radix_init_tree() allocates the node internally via
kho_radix_alloc_node(), calling free_page() directly bypasses the fallback
safety checks in kho_radix_free_node(), which handles memblock_free() when
the slab is unavailable.

>  	tree->root =3D NULL;
>  err_free_scratch:
>  	kho_out.fdt =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528004204.1484=
584-1-jloeser@linux.microsoft.com?part=3D13

