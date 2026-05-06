Return-Path: <linux-hyperv+bounces-10651-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPTtNaxs+2miawMAu9opvQ
	(envelope-from <linux-hyperv+bounces-10651-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 06 May 2026 18:30:36 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDD14DE1F7
	for <lists+linux-hyperv@lfdr.de>; Wed, 06 May 2026 18:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D57213002767
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 May 2026 16:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7B647798D;
	Wed,  6 May 2026 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qEYfZeof"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7373EF0B7;
	Wed,  6 May 2026 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084795; cv=none; b=NVkcfa/1yxX2XtjiP9gC5gOgJyTE3poGhKUiJGVq472KFQ/sGdM4Un5DF9zX9SXWggBVtKk5+gA2wfBvt5eH1ItlvQkwDERAN9ns5hlENhymnVWu6PYjdKgpgincXX3m7vnZFVuTuwQ2azPvw7M0hTICEu8ybbRfh8P3+6C6Mck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084795; c=relaxed/simple;
	bh=zhRflRn79KF66/5eIsQCA2AmZ9VFHLALXQkxie961oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOvItjovwmZbS7LHrkt1ZHu/sBc8yg/HAG64LCdrnLJDfWGoMfPEzxJGMIvhTT0NjHwCBop7TnPziMRok5T9m4Zs3t8I4QLgJAwHfvVyPZjmWajAe29s36O394N0rB/r30p2c9D75G3kRSBd3c3es+6m8h2124u9MtbxLPSTI7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qEYfZeof; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id DC61120B7165;
	Wed,  6 May 2026 09:26:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC61120B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778084790;
	bh=4luj/qid6j+QUgzAmkeKmrX41N2R/ImmmcjpyIIcuJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qEYfZeof+zX7doFUsgIHNmgwnFiU77pLFC9WfUdQuKpEjzdEvu2eRM/KOhJcHsSUs
	 4ruqTTGc2YbGxMVPZISChalHEPgxYLjsUz5Op9e8kdUlIpVV0mCIZ82MggD931UuUE
	 f4Jr24nD5B3j333NkF+Xmp5S0HxeVQObp3Wy4TDQ=
Date: Wed, 6 May 2026 09:26:31 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mshv: support 1G hugepages by passing them as
 2M-aligned chunks
Message-ID: <aftrt1Gq3YeNIQbB@skinsburskii.localdomain>
References: <20260506-huge_1g-v3-1-26e1e4c439e4@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506-huge_1g-v3-1-26e1e4c439e4@anirudhrb.com>
X-Rspamd-Queue-Id: 3BDD14DE1F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10651-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, May 06, 2026 at 01:44:53PM +0000, Anirudh Rayabharam (Microsoft) wrote:
> The hypervisor's map GPA hypercall coalesces contiguous 2M-aligned
> chunks into 1G mappings when alignment permits, so the driver can
> support 1G hugepages by feeding them in as 2M chunks. Note that this
> is the only way to make 1G mappings; there is no way to directly map
> a 1G hugepage using the hypercall.
> 
> Update mshv_chunk_stride() to:
> 
>   - Accept 2M-aligned tail pages of a larger folio. The previous
>     PageHead() check rejected every page after the head of a 1G
>     hugepage and fell back to 4K mappings for the remaining 1022 MB.
>     Replace it with a PFN alignment check so any 2M-aligned page of a
>     sufficiently large folio is acceptable.
> 
>   - Always emit a 2M (PMD_ORDER) stride for the huge-page case. The
>     hypercall has no 1G stride, so 1G folios are processed as a
>     sequence of 2M chunks. Folios whose order is neither PMD_ORDER nor
>     PUD_ORDER (e.g. mTHP) fall back to single-page stride; mapping
>     them as 2M would fail in the hypervisor anyway.
> 
> Assisted-by: Copilot-CLI:claude-opus-4.7
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
> Changes in v3:
> - Fixed various corner cases reported by Sashiko.
> - Link to v2: https://lore.kernel.org/r/20260505-huge_1g-v2-1-b6a91327a88d@anirudhrb.com
> 
> Changes in v2:

LGTM, thanks.

Acked-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>


> - Handled the case where we can have 2M aligned pages in the middle of a
>   1G page
> - Brought back the page order check but expanded it to include 1G
> - Clamp stride to requested page count in mshv_region_process_chunk
> - Link to v1: https://lore.kernel.org/r/20260416-huge_1g-v1-1-e066738cddfb@anirudhrb.com
> ---
>  drivers/hv/mshv_regions.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index fdffd4f002f6..1756b733968c 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c
> @@ -29,29 +29,28 @@
>   * Uses huge page stride if the backing page is huge and the guest mapping
>   * is properly aligned; otherwise falls back to single page stride.
>   *
> - * Return: Stride in pages, or -EINVAL if page order is unsupported.
> + * Return: Stride in pages.
>   */
> -static int mshv_chunk_stride(struct page *page,
> -			     u64 gfn, u64 page_count)
> +static unsigned int mshv_chunk_stride(struct page *page, u64 gfn,
> +				      u64 page_count)
>  {
> -	unsigned int page_order;
> +	unsigned int page_order = folio_order(page_folio(page));
>  
>  	/*
>  	 * Use single page stride by default. For huge page stride, the
> -	 * page must be compound and point to the head of the compound
> -	 * page, and both gfn and page_count must be huge-page aligned.
> +	 * page must be compound, the page's PFN must itself be 2M-aligned
> +	 * (so that a 2M-aligned tail page of a larger folio is acceptable),
> +	 * and both gfn and page_count must be huge-page aligned.
>  	 */
> -	if (!PageCompound(page) || !PageHead(page) ||
> +	if (!PageCompound(page) ||
> +	    !IS_ALIGNED(page_to_pfn(page), PTRS_PER_PMD) ||
>  	    !IS_ALIGNED(gfn, PTRS_PER_PMD) ||
> -	    !IS_ALIGNED(page_count, PTRS_PER_PMD))
> +	    !IS_ALIGNED(page_count, PTRS_PER_PMD) ||
> +	    (page_order != PMD_ORDER && page_order != PUD_ORDER))
>  		return 1;
>  
> -	page_order = folio_order(page_folio(page));
> -	/* The hypervisor only supports 2M huge page */
> -	if (page_order != PMD_ORDER)
> -		return -EINVAL;
> -
> -	return 1 << page_order;
> +	/* Use 2M stride always i.e. process 1G folios as 2M chunks */
> +	return 1 << PMD_ORDER;
>  }
>  
>  /**
> @@ -86,15 +85,14 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
>  	u64 gfn = region->start_gfn + page_offset;
>  	u64 count;
>  	struct page *page;
> -	int stride, ret;
> +	unsigned int stride;
> +	int ret;
>  
>  	page = region->mreg_pages[page_offset];
>  	if (!page)
>  		return -EINVAL;
>  
>  	stride = mshv_chunk_stride(page, gfn, page_count);
> -	if (stride < 0)
> -		return stride;
>  
>  	/* Start at stride since the first stride is validated */
>  	for (count = stride; count < page_count; count += stride) {
> 
> ---
> base-commit: cd9f2e7d6e5b1837ef40b96e300fa28b73ab5a77
> change-id: 20260416-huge_1g-e44461393c8f
> 
> Best regards,
> -- 
> Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 

