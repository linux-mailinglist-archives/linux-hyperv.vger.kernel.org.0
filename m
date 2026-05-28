Return-Path: <linux-hyperv+bounces-11290-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL38LPKYF2rZKggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11290-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 03:22:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 104935EB8BA
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 03:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 253AE303FDEA
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 01:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE13233923;
	Thu, 28 May 2026 01:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCICs0go"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157AF18DB26
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 01:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779931375; cv=none; b=qbIoeO2Jwq9UpDvipuf8ZolAIa63QvBwYb4VStnMQd1TEbyauBlh0F8cwc2VwkKp95KaKmUcJojW7NAElv4grVPpi88oB/RTMVttGRg9AUDNeJc61v4luFA0gF0jK4smBkBINu4NO5PD9c/0yyrwjGT+6JDHm+LxnkpWehTLoxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779931375; c=relaxed/simple;
	bh=IgM4Lco3GPKlxn0aJQgMPI/S1WBqlk46NH0GlPvYcKk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WuLyCR7uPR50VFAx+4wIRYreyEZ4qL9pNhXQyO6TL7xY9Akvi5n0GzzgMRxUuwQoKuwSMckVtLL7HUlL5uyK7zjLR35h1NvYZtc66c0w1pgxQKgdvAdFVCbB6Y+6Z/xDk7nlS+WmPSPEzDatIvpP2c5lt6veoUwU9QrTncvzKBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCICs0go; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489281F000E9;
	Thu, 28 May 2026 01:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779931373;
	bh=QIB3FmLC4GJwDLNqKg+NKKmx1gqh1vWSAiX4s01/vT0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gCICs0goZ/CZTYD9UGnq2L02pnwBl45H6j5pz58egH6QqA3FncatvX+0pHtXUkpuF
	 AJ8aF08WIQwCpjxXXswZjDuC9vYYiQjITOyt5w3XM4KdpchcFAHMqrXwuej0vb+yIM
	 7A6s3l7za6h0Gf40+fXUBPKhITcLb7PRPrSA7zgiQ09gkp//cGUZlIKotysgg5DGx2
	 4NY987yU3PXVWhXg4onHpQGGy45cm5FvLrZs9hknSnSv0UVdHROjm0H4qC5iV9Rv1n
	 rvuiMd2rtInNgThVTQ73YnkXJT4z/qJ6Qq/vOLi2lhYeHgc8F5b+vAhir5+UjLHZ2M
	 GRKEaAzqsB7fg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 01/20] kho: generalize radix tree APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jork Loeser" <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260528004204.1484584-2-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-2-jloeser@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 01:22:52 +0000
Message-Id: <20260528012253.489281F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11290-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 104935EB8BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [High] Refactoring of scratch_size_update() skips CMA alignment for fixed=
 scratch sizes.
- [High] Unsigned integer underflow when calculating scratch_size_global fo=
r unaligned lowmem sizes.
- [High] The generalized radix tree API silently truncates bits from generi=
c 64-bit keys.
- [Low] Unnecessary duplication of __kho_preserve_pages_order() logic in kh=
o_preserve_pages().

Pre-existing issues:
- [Critical] Heap buffer overflow in radix tree node allocation on 32-bit p=
latforms with 4-byte phys_addr_t.
- [High] Sleeping memory allocation (GFP_KERNEL) is performed while holding=
 a mutex required in reclaim paths.
- [High] Bitwise shift operations using a 32-bit signed integer literal '1'=
 overflow for large memory preservations.
- [High] Lack of bounds checking on reconstructed radix tree keys causes an=
 underflow of 'order', leading to severe memory corruption.
--

commit 8b45214cacd5b180aa13f584e115cd95e44f26d2
Author: Pratyush Yadav (Google) <pratyush@kernel.org>

kho: generalize radix tree APIs

This patch generalizes the KHO radix tree APIs to track arbitrary keys dire=
ctly
instead of hardcoding page tracking operations (PFN and order). It renames =
the
functions to kho_radix_add_key() and kho_radix_del_key() and adjusts the
callback structures accordingly.

> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index 4834a809985ab..05a6eb56e1766 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
[ ... ]
> @@ -106,17 +106,17 @@ static unsigned long kho_radix_encode_key(phys_addr=
_t phys, unsigned int order)
>  }
> =20
>  /**
> - * kho_radix_decode_key - Decodes a radix key back into a physical addre=
ss and order.
> + * kho_decode_radix_key - Decodes a radix key back into a physical addre=
ss and order.
>   * @key: The unsigned long key to decode.
>   * @order: An output parameter, a pointer to an unsigned int where the d=
ecoded
>   *         page order will be stored.
>   *
> - * This function reverses the encoding performed by kho_radix_encode_key=
(),
> + * This function reverses the encoding performed by kho_encode_radix_key=
(),
>   * extracting the original physical address and page order from a given =
key.
>   *
>   * Return: The decoded physical address.
>   */
> -static phys_addr_t kho_radix_decode_key(unsigned long key, unsigned int =
*order)
> +static phys_addr_t kho_decode_radix_key(unsigned long key, unsigned int =
*order)
>  {
>  	unsigned int order_bit =3D fls64(key);
>  	phys_addr_t phys;
> =20
>  	/* order_bit is numbered starting at 1 from fls64 */
>  	*order =3D KHO_ORDER_0_LOG2 - order_bit + 1;

[Severity: High]
This isn't a bug introduced by this patch, but does this calculation risk an
unsigned integer underflow?

If a corrupted tree (for instance, an FDT from a crashing kernel) provides
entries at inappropriately high indices, the reconstructed key in
__kho_radix_walk_tree() might have bits set above KHO_ORDER_0_LOG2.

If fls64(key) returns an order_bit greater than KHO_ORDER_0_LOG2 + 1, this
calculation will underflow and produce an enormous order. This value is lat=
er
used in loops bounded by (1UL << order), which could lead to out-of-bounds
iteration.

[ ... ]
> @@ -144,24 +144,21 @@ static unsigned long kho_radix_get_table_index(unsi=
gned long key,
>  }
> =20
>  /**
> - * kho_radix_add_page - Marks a page as preserved in the radix tree.
> + * kho_radix_add_key - Add a key to the radix tree.
>   * @tree: The KHO radix tree.
> - * @pfn: The page frame number of the page to preserve.
> - * @order: The order of the page.
> + * @key: The key to add.
>   *
> - * This function traverses the radix tree based on the key derived from =
@pfn
> - * and @order. It sets the corresponding bit in the leaf bitmap to mark =
the
> - * page for preservation. If intermediate nodes do not exist along the p=
ath,
> - * they are allocated and added to the tree.
> + * This function traverses the radix tree based on the key provided. It =
sets the
> + * corresponding bit in the leaf bitmap to mark the key as present. If
> + * intermediate nodes do not exist along the path, they are allocated an=
d added
> + * to the tree.
>   *
>   * Return: 0 on success, or a negative error code on failure.
>   */
> -int kho_radix_add_page(struct kho_radix_tree *tree,
> -		       unsigned long pfn, unsigned int order)
> +int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key)

[Severity: High]
Does this new arbitrary key API truncate bits from generic 64-bit keys?

The KHO radix tree depth and shifting logic appear to be statically sized
based on physical address and order bounds. When an arbitrary 64-bit key
is passed here, any bits that exceed the maximum addressable depth might
be silently ignored (e.g., bits shifted out or lost in the modulo operations
inside kho_radix_get_table_index()).

Could this cause distinct large 64-bit keys to silently alias to the same
path and overwrite each other?

>  {
>  	/* Newly allocated nodes for error cleanup */
>  	struct kho_radix_node *intermediate_nodes[KHO_TREE_MAX_DEPTH] =3D { 0 };
> -	unsigned long key =3D kho_radix_encode_key(PFN_PHYS(pfn), order);
>  	struct kho_radix_node *anchor_node =3D NULL;

[Severity: Critical]
This is a pre-existing issue, but can the node allocation later in this
function cause an out-of-bounds heap access on 32-bit platforms where
sizeof(phys_addr_t) is 4?

The struct kho_radix_node array size is based on KHO_TABLE_SIZE_LOG2,
which is calculated as ilog2(PAGE_SIZE / sizeof(phys_addr_t)).
On 32-bit systems, this evaluates to 1024 elements of u64, requiring
8192 bytes. However, the allocation relies on get_zeroed_page():

	new_node =3D (struct kho_radix_node *)get_zeroed_page(GFP_KERNEL);

This only allocates a single 4096-byte page. Could writes to indices >=3D 5=
12,
or walking the tree via __kho_radix_walk_tree(), overflow this allocation?

[Severity: High]
This is also a pre-existing issue, but can using GFP_KERNEL for the node
allocation lead to an ABBA deadlock?

This allocation happens while holding tree->lock:

kho_radix_add_key()
    mutex_lock(&tree->lock)
    ...
    get_zeroed_page(GFP_KERNEL)

Since GFP_KERNEL can sleep and trigger direct memory reclaim, if a page cac=
he
folio preserved for KHO is evicted, the filesystem's eviction path could ca=
ll
kho_unpreserve_folio().

That function would attempt to acquire the exact same tree->lock, resulting
in a deadlock. Should this allocation be moved outside the lock or downgrad=
ed
to GFP_NOWAIT?

[ ... ]
> @@ -484,13 +474,16 @@ static struct page *__init kho_get_preserved_page(p=
hys_addr_t phys,
>  	return pfn_to_page(pfn);
>  }
> =20
> -static int __init kho_preserved_memory_reserve(phys_addr_t phys,
> -					       unsigned int order)
> +static int __init kho_preserved_memory_reserve(unsigned long key)
>  {
>  	union kho_page_info info;
>  	struct page *page;
> +	unsigned int order;
> +	phys_addr_t phys;
>  	u64 sz;
> =20
> +	phys =3D kho_decode_radix_key(key, &order);
> +
>  	sz =3D 1 << (order + PAGE_SHIFT);

[Severity: High]
This is a pre-existing issue, but will this bitwise shift overflow for large
memory preservations?

Since the literal 1 is a 32-bit signed integer, a shift amount of 31 or
greater (which can happen for contiguous preservations of 2GB or more, like
hugepages or CMA areas) results in a signed integer overflow.

This would produce a negative 32-bit value that is sign-extended into the
64-bit sz variable, leading to incorrect memblock reservations.
Does this need to use 1UL or 1ULL?

[ ... ]
> @@ -618,30 +611,20 @@ early_param("kho_scratch", kho_parse_scratch_size);
> =20
>  static void __init scratch_size_update(void)
>  {
> -	/*
> -	 * If fixed sizes are not provided via command line, calculate them
> -	 * now.
> -	 */
> -	if (scratch_scale) {
> -		phys_addr_t size;
> +	phys_addr_t size;
> =20
> -		size =3D memblock_reserved_kern_size(ARCH_LOW_ADDRESS_LIMIT,
> -						   NUMA_NO_NODE);
> -		size =3D size * scratch_scale / 100;
> -		scratch_size_lowmem =3D size;
> +	if (!scratch_scale)
> +		return;

[Severity: High]
Does this early return skip CMA alignment for fixed scratch sizes?

In the previous implementation, scratch_size_lowmem and scratch_size_global
were unconditionally aligned using round_up(..., CMA_MIN_ALIGNMENT_BYTES)
at the end of the function, regardless of whether scratch_scale was set.

By returning early when scratch_scale is 0 (which occurs when fixed sizes
are provided via the command line), the alignment step is bypassed.
Will this cause CMA initialization to fail when iterating over partial
pageblocks?

> =20
> -		size =3D memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
> -						   NUMA_NO_NODE);
> -		size =3D size * scratch_scale / 100 - scratch_size_lowmem;
> -		scratch_size_global =3D size;
> -	}
> +	size =3D memblock_reserved_kern_size(ARCH_LOW_ADDRESS_LIMIT,
> +					   NUMA_NO_NODE);
> +	size =3D size * scratch_scale / 100;
> +	scratch_size_lowmem =3D round_up(size, CMA_MIN_ALIGNMENT_BYTES);
> =20
> -	/*
> -	 * Scratch areas are released as MIGRATE_CMA. Round them up to the right
> -	 * size.
> -	 */
> -	scratch_size_lowmem =3D round_up(scratch_size_lowmem, CMA_MIN_ALIGNMENT=
_BYTES);
> -	scratch_size_global =3D round_up(scratch_size_global, CMA_MIN_ALIGNMENT=
_BYTES);
> +	size =3D memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
> +					   NUMA_NO_NODE);
> +	size =3D size * scratch_scale / 100 - scratch_size_lowmem;

[Severity: High]
Can this subtraction result in an unsigned integer underflow?

Because the round_up() for scratch_size_lowmem now occurs before the
calculation of scratch_size_global, scratch_size_lowmem may be larger
than the unaligned size (size * scratch_scale / 100).

On a system where all memory is below ARCH_LOW_ADDRESS_LIMIT, both calls to
memblock_reserved_kern_size() return the same value. The subtraction will
then subtract the rounded-up value from the unaligned value, resulting in
a negative number.

Since size is a phys_addr_t (unsigned), this will underflow to an enormous
positive value and likely lead to an unfulfillable CMA reservation attempt.

[ ... ]
> @@ -937,9 +922,19 @@ int kho_preserve_pages(struct page *page, unsigned l=
ong nr_pages)
>  	}
> =20
>  	while (pfn < end_pfn) {
> -		unsigned int order =3D __kho_preserve_pages_order(pfn, end_pfn);
> +		unsigned int order =3D
> +			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
> +
> +		/*
> +		 * Make sure all the pages in a single preservation are in the
> +		 * same NUMA node. The restore machinery can not cope with a
> +		 * preservation spanning multiple NUMA nodes.
> +		 */
> +		while (pfn_to_nid(pfn) !=3D pfn_to_nid(pfn + (1UL << order) - 1))
> +			order--;

[Severity: Low]
Is there a specific reason to inline and duplicate the logic from
__kho_preserve_pages_order() here?

The helper function __kho_preserve_pages_order() remains in the file and
is still actively used by __kho_unpreserve(). Duplicating this complex
order calculation and NUMA node alignment logic increases the risk of the
two implementations diverging in the future.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528004204.1484=
584-1-jloeser@linux.microsoft.com?part=3D1

