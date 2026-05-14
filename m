Return-Path: <linux-hyperv+bounces-10883-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DZLCONhBWrsVgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10883-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 07:47:15 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FB353E187
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 07:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 981CE302F439
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 05:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22652BEFEE;
	Thu, 14 May 2026 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRo5chRH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA8E224FA
	for <linux-hyperv@vger.kernel.org>; Thu, 14 May 2026 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778737631; cv=none; b=ONhGNslb8eAvnXaaHisdSWyHk4xkfO3ISwGLLv8VODW3XP1t+8JVChACyKjP1laU9/QuA4ovzU2DA9SKBSyGYuQZkmE3tZN4yAN8OqstKhkNYQTLjtEyoN0fy9sbkC8HwC+P5aP65yfMDHeLUYzTklLVrAHZCq2OvngrDxF7hU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778737631; c=relaxed/simple;
	bh=4etiduDXSyxDHHVWXY3MSm/CeQtF4kTpPu3zOVsYA30=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m1giv6NkxA2leVRd+cRXiLGZKf2V/ssGJImz2Gqmqbz8LJsYiDTwTiupr84pWXhcFjj3l1cx0O5XT7PABcR9/iTf1YiyYs3qVHKw/B2uLlaEoEq8fZ/FQpH7k2mMsL5hz/50lhTnQFURerHRQqmyJ+ecrsg5SQgZX/DNMMEVeMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRo5chRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0963CC2BCB7
	for <linux-hyperv@vger.kernel.org>; Thu, 14 May 2026 05:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778737631;
	bh=4etiduDXSyxDHHVWXY3MSm/CeQtF4kTpPu3zOVsYA30=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date:From;
	b=QRo5chRH+14NnxczYB6TyX6+LsZRLj/X4g6QaSyGnEXPbwHcVHwephKvVKa+Ib/MJ
	 y4m+bzxgSxKc14kfVzM6RIJ8TQvCOSlHM1Mlb5PC8L5y10CdGZyqrJXUKl33K4t7sh
	 NU6uA4fnPCr3aps5Jxlhyc69uqqRhUzcUyooBDTZUCJOoXzxOzX+3CDB6t60RMem44
	 aqY3PiYsnVlO+28B8ZKv96DxmTAJlgAutPBI+B6i03F2kaqKT8QUeXKI+Ei1Miyr/6
	 isQtQVSCMVHE/9rgYvn8a4JbQ5hvqvtcI5Yu6IZN3xRBUL0u/N39BajWbLOBlWK9f6
	 TAl+mWFtcHdnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] mshv: support 1G hugepages by passing them as
 2M-aligned chunks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260513-huge_1g-v4-1-33cda59e4a70@anirudhrb.com>
References: <20260513-huge_1g-v4-1-33cda59e4a70@anirudhrb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 05:47:10 +0000
Message-Id: <20260514054711.0963CC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 96FB353E187
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	MISSING_TO(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10883-lists,linux-hyperv=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing physical contiguity validation in large folio chunking lea=
ds to guest memory corruption and host-guest VMA inconsistencies.
--

commit 8234ab081cfc742915853b13b8eaeeb12adcc021
Author: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

mshv: support 1G hugepages by passing them as 2M-aligned chunks

This commit modifies the mshv driver to support 1G hugepages by treating
them as a sequence of 2M chunks, since the hypervisor map GPA hypercall
coalesces contiguous 2M-aligned chunks. It uses a 2M stride for folios
of at least PMD_ORDER.

> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index fdffd4f002f6f..6d65e5b421529 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c

[ ... ]

> @@ -86,15 +84,14 @@ static long mshv_region_process_chunk(struct mshv_mem=
_region *region,
>  	u64 gfn =3D region->start_gfn + page_offset;
>  	u64 count;
>  	struct page *page;
> -	int stride, ret;
> +	unsigned int stride;
> +	int ret;
> =20
>  	page =3D region->mreg_pages[page_offset];
>  	if (!page)
>  		return -EINVAL;
> =20
>  	stride =3D mshv_chunk_stride(page, gfn, page_count);
> -	if (stride < 0)
> -		return stride;
> =20
>  	/* Start at stride since the first stride is validated */
>  	for (count =3D stride; count < page_count; count +=3D stride) {

Does this code assume that all intermediate pages within the stride are
physically contiguous simply because the first page belongs to a large foli=
o?

If a VMM constructs a fragmented VMA, for example by using MADV_DONTNEED
on a shmem folio for guest memory ballooning, or MAP_FIXED to remap
specific pages, get_user_pages() could populate mreg_pages with a mix of
different pages.

Since the loop advances by the stride without inspecting the intermediate
pages between the stride boundaries, could this instruct the hypervisor to
map the contiguous physical block of the large folio into the guest,
ignoring the actual VMA mappings?

Would this cause the guest to read and write the host large folio's tail
pages instead of the VMM's intended pages?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513-huge_1g-v4=
-1-33cda59e4a70@anirudhrb.com?part=3D1

