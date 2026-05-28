Return-Path: <linux-hyperv+bounces-11285-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ACkKTmVF2oiKAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11285-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 03:07:05 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 230165EB7DB
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 03:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80603302588F
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 01:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D32D1427A;
	Thu, 28 May 2026 01:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvenyEkW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491B515746F
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 01:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779930421; cv=none; b=Qgcn7l4EIslTaTX662UEsx3qyOcwMcEBPjiSXW0Plsw10DBrGVfGUaaAlvtDWcObTs8rqsiw2GZvP8s+xIjaBmp7FNZw2Kf9tLC0M/IhCzffX64WJIV34ei0SRXY/Nq5dIJxpnMMsGfyQo5vfTF9MI8b6vydi4esV49qElJ8p+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779930421; c=relaxed/simple;
	bh=Op1iAOgh3tDyfBsHX3DCYLPMHxowOvm7S4aCH2kt12k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SZzP9rCUKUitJHR70m/mOurKSvqv6k2vygVM7+Luzlw1gCe7g1l563mtsSUpdkLST6aKNGJsKD7njTaLkmtvcn1sAys/EL6wU9Kz9690bAVrf4GTJQZbIWs+nG8MyBjzD1IUu1pPrHqLajrFuRI06NZOvAt/f794xu7xZHp8ByM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvenyEkW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A1C1F000E9;
	Thu, 28 May 2026 01:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779930420;
	bh=azyJbVoo46mL4Qa42cKPGMwwGyogxKetRYKa/QFDePA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SvenyEkWPvLA4cPxYs+v00r2nGkxT+aEVrbDGtmU7aEMopTBUIhtkcXklx49rP50t
	 QXsGkfQ0TQRSq6VXPi+gy/1/25e6eyf3a44+uOW5X+0MCUW2z9OhmiatNKiTZKjd2s
	 z876vvlBrIGKsckAS7vTsmAYGvWfLdSfC4dpo8CI9t98AUkYPIuqnlvqhabvdD01wr
	 2CI4ruAFSJqEBk9vHvdaNxHq0IStUOv9YWne29T5PCiYtGn4uBKuy7zzAfBA1959bA
	 lDn4kMu073wxFb10Q05VQk/dny5FSp8ScE9lPFTFmdJRxROVUKqSI/UGFDpqoEDGxM
	 bBKFqhDEzB/UQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 12/20] mm/hugetlb: make bootmem allocation work with
 KHO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jork Loeser" <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260528004204.1484584-13-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-13-jloeser@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 01:06:59 +0000
Message-Id: <20260528010659.E3A1C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11285-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 230165EB7DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect NUMA node extraction for huge page allocation fallback d=
ue to inverted `node_exact` condition, breaking HugeTLB Vmemmap Optimizatio=
n (HVO).
- [Medium] Silent memory leak in `memblock_alloc_nid_user` error path due t=
o inherently failing `memblock_phys_free`.
--

commit 8f512f66429ea3e879e3104adb050f66df1c4fb3
Author: Pratyush Yadav (Google) <pratyush@kernel.org>

mm/hugetlb: make bootmem allocation work with KHO

This patch addresses KHO scratch size accounting issues by introducing
memblock_alloc_nid_user(). It ensures that huge pages are not allocated
from scratch areas and removes the MEMBLOCK_RSRV_KERN flag from these
allocations, preventing them from artificially inflating scratch space
requirements.

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 571212b80835e..46f2b1bd5abe8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3033,26 +3033,19 @@ static __init void *alloc_bootmem(struct hstate *=
h, int nid, bool node_exact)
[ ... ]
> -		if (node_exact)
> -			m =3D memblock_alloc_exact_nid_raw(huge_page_size(h),
> -				huge_page_size(h), 0,
> -				MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> -		else {
> -			m =3D memblock_alloc_try_nid_raw(huge_page_size(h),
> -				huge_page_size(h), 0,
> -				MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> +		m =3D memblock_alloc_nid_user(huge_page_size(h), huge_page_size(h),
> +					    nid, node_exact);
> +		if (m) {
>  			/*
>  			 * For pre-HVO to work correctly, pages need to be on
>  			 * the list for the node they were actually allocated
>  			 * from. That node may be different in the case of
> -			 * fallback by memblock_alloc_try_nid_raw. So,
> -			 * extract the actual node first.
> +			 * fallback by memblock_alloc_try_nid_raw. So, extract
> +			 * the actual node first.
>  			 */
> -			if (m)
> +			if (node_exact)
>  				listnode =3D early_pfn_to_nid(PHYS_PFN(__pa(m)));

[Severity: High]
Does this extract the node under the wrong condition?

The original code extracted the node only in the fallback path (!node_exact=
),
since exact allocations guarantee the requested node is used.=20

With this change, if node_exact is true, we redundantly extract the node,
but if node_exact is false (meaning a fallback could have happened), we skip
extracting the actual node.

Can this place fallback-allocated huge pages onto the wrong node's list,
breaking NUMA locality and pre-HVO assumptions?

[ ... ]
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 6f76a6bb96d61..8cd52d34ad6e4 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
[ ... ]
> @@ -1784,6 +1817,47 @@ void * __init memblock_alloc_try_nid_raw(
> +void * __init memblock_alloc_nid_user(phys_addr_t size, phys_addr_t alig=
n,
> +				      int nid, bool exact_nid)
> +{
[ ... ]
> +	alloc =3D __memblock_alloc_range_nid(size, align, 0, MEMBLOCK_ALLOC_ACC=
ESSIBLE,
> +					   nid, exact_nid, flags);
> +	if (!alloc)
> +		return NULL;
> +
> +	/* User memory should not be marked with RSRV_KERN. */
> +	if (memblock_reserved_clear_kern(alloc, size)) {
> +		memblock_phys_free(alloc, size);
> +		return NULL;
> +	}

[Severity: Medium]
Will this error path silently leak memory?

If memblock_reserved_clear_kern() fails, it is because
memblock_isolate_range() encountered an out-of-memory scenario when trying
to split a region and memblock_double_array() failed.

When we then call memblock_phys_free(), it eventually calls
memblock_remove_range(), which relies on the exact same
memblock_isolate_range() call to split the region before removing it.

Since the array is still full, this isolation will deterministically fail
again, and memblock_phys_free() will return without actually freeing the
memory, leaving it permanently reserved with MEMBLOCK_RSRV_KERN set.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528004204.1484=
584-1-jloeser@linux.microsoft.com?part=3D12

