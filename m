Return-Path: <linux-hyperv+bounces-11489-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xaAnCHqsIWogLAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11489-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 18:48:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE966642081
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 18:48:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EklmzvgY;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11489-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11489-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED39D3009F7E
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jun 2026 16:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4392334F462;
	Thu,  4 Jun 2026 16:39:02 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEAD3793CA
	for <linux-hyperv@vger.kernel.org>; Thu,  4 Jun 2026 16:39:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591142; cv=none; b=QiykqZQnOCYHoY+pZuJCZCt18bGFLdQD+oo49q0770gQpriEyL/kqlC+EkIpS57hdzKtgj2oK7tGEMVkGRh1uFR3y6ZkD02TGxaP/ON90cv3phQxDhRJwjJaT6LZkBCM3a/6Zmvb1i5cm7Am/ejOl0ix+JoDqIYh4vGB45C6Muc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591142; c=relaxed/simple;
	bh=N/n8f5zx63/qgfV9MQSDly+ncWtFofsKvFotapU8gxs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EQhnyD+8V6iKBZ0Q4tyOe6wq8w0N0Nx5Ur0+NWI0UtfVk491sXgRZnDABoFN1Et5XQWOZBFoqED81ZIJPfEJEIiMUQbDq/BYIieMWySngJKpaudFLmD9beVVIgdUTbmmLUuVah1qj1DE4VXrg4y/ALGSZji0vCg59Wl63vyjxqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EklmzvgY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09211F00893;
	Thu,  4 Jun 2026 16:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780591140;
	bh=pauzITUSxH4H713K1gRMfgmzZW3Zmn56Gy1tIV3gCCU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EklmzvgYFnCNAIKSHd4nCwk5D5PxqA5uZqYRMjNbbnojpmaltlvnqES/V8ZXee+cM
	 zZfIoMAuOMYHu+hm9Hj6v+0sVyAKBjvcDwZThGeqK41NT7l0jQEWGeZN1Sq6JM2lKt
	 YTT8u59BmwtPNqGSCEh4U22Ddx48hP6Bba5mJnkJAxJnZ2rftUH2ufv1pGd+zH9UQk
	 vD59hvc9hcYR0VIYqkE7JadN1glOs0T98Zao+zqQxTgZsB6vLlkMyLVa/gbuV3CZZT
	 BXkzbBIrbpSUFvekSqkmEYh+EW5JKP8w+rlWO5xYzyuxG+bdBlY6N+FZ5KVlq1Xbz3
	 g8GQq8fP5oGjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] hv_netvsc: use kmap_local_page in
 netvsc_copy_to_send_buf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anton Leontev" <leontyevantony@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260603163851.18058-1-leontyevantony@gmail.com>
References: <20260603163851.18058-1-leontyevantony@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 16:39:00 +0000
Message-Id: <20260604163900.A09211F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:leontyevantony@gmail.com,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11489-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE966642081

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The patch replaces `phys_to_virt()` with `kmap_local_page()` i=
n `netvsc_copy_to_send_buf()` to support HIGHMEM SKB fragments. However, `k=
map_local_page()` maps exactly one page (e.g., 4096 bytes). SKB fragments (=
such as those from TCP sends using `sk_page_frag()` or NFS) can be backed b=
y compound pages where the fragment size (`len`) exceeds a single page, or =
where `offset + len` crosses a page boundary. The `pb` array populated by `=
init_page_array()` contains exactly one entry per fragment, meaning `pb[i].=
len` can exceed `PAGE_SIZE`. When `memcpy(dest, src + offset, len)` is call=
ed, it will read past the 4KB window mapped by `kmap_local_page()`. On 32-b=
it HIGHMEM systems, this accesses adjacent unmapped or unrelated fixmap slo=
ts, causing a fatal page fault or memory leakage.
--

commit dfe36312b193784583b28a894f895984d7d0ebba
Author: Anton Leontev <leontyevantony@gmail.com>

hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf

This patch replaces phys_to_virt() with kmap_local_page() to support HIGHMEM
SKB fragments that are beyond the LOWMEM boundary on 32-bit systems.

> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 59e95341f9b1e..2038d9f5c9f9a 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
[ ... ]
> @@ -965,11 +966,14 @@ static void netvsc_copy_to_send_buf(struct netvsc_d=
evice *net_device,
>  	}
> =20
>  	for (i =3D 0; i < page_count; i++) {
> -		char *src =3D phys_to_virt(pb[i].pfn << HV_HYP_PAGE_SHIFT);
> -		u32 offset =3D pb[i].offset;
> +		phys_addr_t paddr =3D pb[i].pfn << HV_HYP_PAGE_SHIFT;
> +		struct page *page =3D phys_to_page(paddr);
> +		u32 offset =3D offset_in_page(paddr) + pb[i].offset;
>  		u32 len =3D pb[i].len;
> +		char *src =3D kmap_local_page(page);
> =20
>  		memcpy(dest, (src + offset), len);

[Severity: Critical]
Will this memcpy() read beyond the 1-page mapping established by
kmap_local_page()?

If the fragment size (len) plus offset exceeds PAGE_SIZE, it seems memcpy()
will read past the locally mapped window. SKB fragments can be backed by
compound pages where the fragment size exceeds a single page, and
init_page_array() assigns the full fragment size to pb[i].len:

drivers/net/hyperv/netvsc_drv.c:init_page_array() {
	...
	cur_pb->offset =3D offset_in_hvpage(offset);
	cur_pb->len =3D skb_frag_size(frag);
	cur_pb->pfn =3D pfn + (offset >> HV_HYP_PAGE_SHIFT);
	...
}

Other parts of the subsystem also document that a pb entry can cross page
boundaries:

drivers/net/hyperv/netvsc.c:netvsc_build_mpb_array() {
	...
	/* Each entry in the input "pb" array must describe a contiguous range
	 * of guest physical memory so that the pfns are sequential if the range
	 * crosses a page boundary. */
	...
	for (j =3D 0; j < HVPFN_UP(offset + len); j++)
		mpb_entry->pfnArray[j] =3D pb[i].pfn + j;
	...
}

Could this regression cause a fatal page fault on 32-bit HIGHMEM guests when
an SKB fragment crosses a page boundary, or leak unrelated fixmap memory if
the adjacent slot happens to be mapped?

> +		kunmap_local(src);
>  		dest +=3D len;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603163851.1805=
8-1-leontyevantony@gmail.com?part=3D1

