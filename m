Return-Path: <linux-hyperv+bounces-10017-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B/JBf/l02n/ngcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10017-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 18:57:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B993A57DB
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 18:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59BD53012BF0
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 16:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A028E38B7D7;
	Mon,  6 Apr 2026 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="gWbRno4x"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CC43876BD;
	Mon,  6 Apr 2026 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775494652; cv=pass; b=W5+tH2XEy0x08QzNVg24LeMbxqAzuZGwcU9AwvnT+WQg4XsNy/HMd9Yvk9GXDhtkl6SmegSYEbiSsj5b8t9+hDYBJQydB+p9FchSljUtsxYBayHzhhg6hElMV3PfpN3FYzaCFpHCgBlNtJPZGy6+2aA3gK2U+elO682iUPaQFlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775494652; c=relaxed/simple;
	bh=ZGQhVxFlnXHZk3UTOP0Dn6w4dK6knSqoqq/D6Q3knVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LV9SpRK5uzaf/MlKatdK6kb6/NHMyLMI2GHErWekuabaL8ObcGr01OPVaLL4rISDmXfBOlNl/1qdBIPv/Sbkt90SGsxV3F0abQxUgNL+0rvO4d7mGeU+Dkvy0jY9aoDSBVDxgEMKl0S3Uo7iaAH+VdxeJjuaC2uhU9n99Kn237Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=gWbRno4x; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1775494640; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=I+dopuVyI3/8295zzy0hJlyTzADG6U3KlteHqtSJtFI5Jge6Rwge9/1LDD0R09c3mYbSU4Y7Nt1gtMou798kP0VXaaXKcxyFRQ1DTGYkyRXed7zM/9H+Zvoe6Pl8oPEb/aTrROWtn7cD5t13cZprwDMHbRjeSaTjByA2Oi0LmR4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775494640; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/Gel76pWqsq/NUbyRpcht1hkNM1xwmcjKrhYFg3i8+M=; 
	b=bmDp+JEdbjoEgpHNLuFCFt/kJqxpXCdQvl1hL5HAFjT2uoYWvq/jWQo1fLOnXh4Ap1oOZdlw4NopYEWcLISd7HU5hBWanknixVu4ywtiM5mqXoO2pRRAXPnubesOSWvSvngifFmG+X2iUgC7lJxP+eNg74b0G4WHhaleQBak48A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775494640;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=/Gel76pWqsq/NUbyRpcht1hkNM1xwmcjKrhYFg3i8+M=;
	b=gWbRno4xjs/3qtGIPa+v83L+PyXKXRnEg/SzRT5uHE/ismgVyQVB4GcNMPWNfQ0P
	evakozDzBUEMghtRuOFCdcY4g06HeE16aTXbaAZjRPww4IrQ02bg0i6tF9QSNOTGg0N
	/3tjpoll+/CbHmGW2KHhuBE3/Wb/d8aa4E+QHoFE=
Received: by mx.zohomail.com with SMTPS id 1775494637108912.8575493032064;
	Mon, 6 Apr 2026 09:57:17 -0700 (PDT)
Date: Mon, 6 Apr 2026 16:57:12 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] mshv: Optimize memory region mapping operations
Message-ID: <20260406-expert-pelican-of-weather-75fda2@anirudhrb>
References: <177508151446.215674.7844504277869257435.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177508156646.215674.2229578835484145880.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177508156646.215674.2229578835484145880.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10017-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,anirudhrb.com:dkim]
X-Rspamd-Queue-Id: 88B993A57DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 10:12:46PM +0000, Stanislav Kinsburskii wrote:
> Two specific operations don't require PFN iteration: region unmapping
> and region remapping with no access. For unmapping, all frames in MSHV
> memory regions are guaranteed to be mapped with page access, so we can
> unmap them all without checking individual PFNs. For remapping with no
> access, all frames are already mapped with page access, allowing us to
> unmap them all in one pass.
> 
> Since neither operation needs PFN validation, iterating over PFNs is
> redundant. Batch operations into large page-aligned chunks followed by
> remaining pages. This eliminates PFN traversal for these operations,
> requires no additional hypercalls compared to the PFN-checking approach,
> and provides the simplest possible sequential execution path.
> 
> The optimization utilizes HV_MAP_GPA_LARGE_PAGE and
> HV_UNMAP_GPA_LARGE_PAGE flags for aligned portions, processing only the
> remainder with base page granularity. This removes mshv_region_chunk_unmap()
> and mshv_region_process_range() helper functions, reducing code complexity.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_regions.c |   65 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 46 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index 2c4215381e0b..a92381219758 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c
> @@ -449,27 +449,27 @@ static int mshv_region_pin(struct mshv_region *region)
>  	return ret < 0 ? ret : -ENOMEM;
>  }
>  
> -static int mshv_region_chunk_unmap(struct mshv_region *region,
> -				   u32 flags,
> -				   u64 pfn_offset, u64 pfn_count,
> -				   bool huge_page)
> +static int mshv_region_unmap(struct mshv_region *region)
>  {
> -	if (!pfn_valid(region->mreg_pfns[pfn_offset]))
> -		return 0;
> +	u64 aligned_pages, remaining_pages;
> +	int ret = 0;
>  
> -	if (huge_page)
> -		flags |= HV_UNMAP_GPA_LARGE_PAGE;
> +	aligned_pages = ALIGN_DOWN(region->nr_pfns, PTRS_PER_PMD);

Why is it sufficient to check just the number of pages to determine
whether we need to use the HV_UNMAP_GPA_LARGE_PAGE? Don't we need to
check the alignment of the start address as well?

Thanks,
Anirudh.

