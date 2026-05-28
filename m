Return-Path: <linux-hyperv+bounces-11291-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZT36Ig2aF2qcKwgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11291-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 03:27:41 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8485EB8C5
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 03:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BCE7301F9B7
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 01:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4117C2594BD;
	Thu, 28 May 2026 01:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYPJtplk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B4C233923
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 01:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779931657; cv=none; b=l/Um1oPJk+F0D/tjpvsYP1jZzW9Bw0Co9fyUwWGQ0IZgJSRvm+PzFRzJjL2cy/y/4K7ks61N1CKnGnEjPjY8nwIOmUgt3Z+YmD/Ee0b6o7vrHaQtzwKiVI4fQ38cvT3ALGWCxFJoshdPyZT/ZLVoni9xhklFSgH0gAaW5DkyXa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779931657; c=relaxed/simple;
	bh=84OKbLyNF0efiwwgPQ79Y1rGc0PIoSwdl7FmBxBlE1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YoYc/Ml0TpuWH6gAZhDTD5ThP68FXPDqifOyo+jVGHO96FPB2Z6zdSycJIAPutgUA5l7OP9TRkkj5iQrWIX///e/NoQl4h3KW0QZy0/fStJEFiHjmu5ypBLXhYpg9wp7m+AL6yTFx21SKE1PpqaFb/v+gBf/xjnMTMk5dN8/xp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYPJtplk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09101F000E9;
	Thu, 28 May 2026 01:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779931655;
	bh=eHKxctrURw8JCH3d5by0ScMPMJsrESmiAc64TzWfBJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nYPJtplkog27B8GOd0FJUcfw0ueCnVQgvh2n1cHvsRZlvbC6plrlx+w9ipOSBCeYa
	 06dlsWOlZHzxW7I0/E5lPAqxjM4MOdEDlj7xVh2FarLGC3CyeH6Gi7TeSOXzV5kyYa
	 E6Z5EMIMinisYJPM8qEpeyxv0H6+k2HDDmiRkNE5vCTNSpsfEVluoabD7DyZ6ufsSs
	 9TnFLjFQd9WjWV880+a8HllWIu33qZdWRV3TiT5kZe3/6hoRkMmeX0OeK2PMXsY8P0
	 jnMgFPOJe9qAWGorm+H0wCvf/dRrCNDM5aDuH4gVPAFxZyV9ewnffZm8rogY1nzLkf
	 H0Vfw8Rp6yadw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 11/20] kho: return virtual address of mem_map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jork Loeser" <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260528004204.1484584-12-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-12-jloeser@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 01:27:34 +0000
Message-Id: <20260528012735.A09101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11291-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: CC8485EB8C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The local variable `radix` in `kho_extend_scratch` is uninitia=
lized, leading to skipped initialization and a subsequent kernel panic when=
 walking the radix tree.
- [Low] kho_get_mem_map returns an integer 0 instead of a NULL pointer on a=
n error path.
--

commit 80928d5942267d8e8edcbc91a1c5643fdd5aecee
Author: Pratyush Yadav (Google) <pratyush@kernel.org>

kho: return virtual address of mem_map

Changes kho_get_mem_map_phys() to kho_get_mem_map() and makes it return a
virtual address instead of a physical address to simplify its callers.

> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index a006a883ee94a..797ec285b698c 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -610,10 +610,11 @@ static int __init kho_preserved_memory_reserve(unsi=
gned long key, void *data)
>  	return 0;
>  }
> =20
> -/* Returns physical address of the preserved memory map from FDT */
> -static phys_addr_t __init kho_get_mem_map_phys(const void *fdt)
> +/* Returns virtual address of the preserved memory map from FDT */
> +static __init void *kho_get_mem_map(const void *fdt)
>  {
>  	const void *mem_ptr;
> +	phys_addr_t mem_map_phys;
>  	int len;
> =20
>  	mem_ptr =3D fdt_getprop(fdt, 0, KHO_FDT_MEMORY_MAP_PROP_NAME, &len);
> @@ -622,7 +623,11 @@ static phys_addr_t __init kho_get_mem_map_phys(const=
 void *fdt)
>  		return 0;
>  	}

[Severity: Low]
Since the return type has been changed to a pointer, should this return NULL
instead of the integer 0 to avoid a sparse warning?

> -	return get_unaligned((const u64 *)mem_ptr);
> +	mem_map_phys =3D get_unaligned((const u64 *)mem_ptr);
> +	if (!mem_map_phys)
> +		return NULL;
> +
> +	return phys_to_virt(mem_map_phys);
>  }
> =20
[ ... ]
> @@ -917,15 +922,15 @@ void __init kho_extend_scratch(void)
>  		.key =3D kho_ext_mark_scratch,
>  	};
>  	struct kho_radix_tree radix;
> -	phys_addr_t prev_end =3D 0, mem_map_phys;
> +	phys_addr_t prev_end =3D 0;
>  	int err =3D 0;

[Severity: Critical]
Because radix is declared on the stack without being zeroed, it is
uninitialized. When kho_radix_init_tree() is called later, it checks if
tree->root is already set:

kernel/liveupdate/kexec_handover.c:kho_radix_init_tree() {
    ...
    if (tree->root)
        return 0;
    ...
}

Since radix.root contains uninitialized stack garbage, it is highly likely
to be non-zero. Could this cause kho_radix_init_tree() to return without
initializing the lock and setting up the root node, leading to a panic when
the tree is walked?

> =20
>  	if (!is_kho_boot())
>  		return;
> =20
>  	/* Make sure the KHO radix tree is initialized. */
> -	mem_map_phys =3D kho_get_mem_map_phys(kho_get_fdt());
> -	err =3D kho_radix_init_tree(&kho_in.radix_tree, phys_to_virt(mem_map_ph=
ys));
> +	err =3D kho_radix_init_tree(&kho_in.radix_tree,
> +				  kho_get_mem_map(kho_get_fdt()));
>  	if (err)
>  		goto print;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528004204.1484=
584-1-jloeser@linux.microsoft.com?part=3D11

