Return-Path: <linux-hyperv+bounces-8013-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 174A4CB427A
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Dec 2025 23:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1864D3008D66
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Dec 2025 22:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261222FB0BC;
	Wed, 10 Dec 2025 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzDUb6cU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B8F3B8D67;
	Wed, 10 Dec 2025 22:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765406588; cv=none; b=RWgWul7Wz7B6GZ7u76SBN8wnLCoe0bpBGGH7eAs3HDNrlQmxu+TRVh8K8L4Byhnu6jfP1LQbk/wnP8wdOyuC8TKW2EPpdhpOlhpPWir2CKhzEMAsKQpZP03z09VJa3g4Ih4NxTbPVTtmfFlOkj+Ku4V/N6NIb5L03GlImi5NyX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765406588; c=relaxed/simple;
	bh=SNdQ18RmyyLBIHEjS8qskwZl4FbeCVKhHyl+owHJKVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ma7bHsaewY2+bbS6UE8oHzmn3fGJly89Gonl8tUx0xPVGDhYC1YP+g6vtcxr+LQNoCP6iYde6ANvvesHk5chhYh4NehGPgazTj6vKq3OKwSSIk/xDA0POQwJd3f9YqKM4lZhwl0HIGZiy0qglliSlWsiV8Dxm1VUYTt6ZkuMmbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzDUb6cU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A06C4CEF1;
	Wed, 10 Dec 2025 22:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765406587;
	bh=SNdQ18RmyyLBIHEjS8qskwZl4FbeCVKhHyl+owHJKVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzDUb6cUCl1qTjM59QBCHjkbEySLpKmxUHYpVbwcAxSuJZTQs4jtgQrM+QZtApw22
	 Q8yFIIork5xh0DCLZj8ZBakGrzYA0rrn26Z/TqJMYyU9y6FwCUUsmXK995OizQhXSB
	 f+g2IboUMpCXhXKNpVHHu/I74AQsOvPFy5dZS9a0vrOgGH7UX3iv6yByd7clt+KcBW
	 zcWGCXe0vQpz3j6H/GiP9gJZHyeOT+MqNaynCuy0qMk4W88MoB/8wb/KW4DPHIsMsU
	 6oJqCLZovLfa4tjNNg68s+Y0/cH+HS0cLvynFrw+0SzjZV803MbAcCvKjJu2a4xVUK
	 eI94nCErbrYew==
Date: Wed, 10 Dec 2025 22:43:06 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Use PMD_ORDER instead of HPAGE_PMD_ORDER when
 processing regions
Message-ID: <20251210224306.GA3121622@liuwe-devbox-debian-v2.local>
References: <176529822862.17729.14849117117197568731.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176529822862.17729.14849117117197568731.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>

On Tue, Dec 09, 2025 at 04:37:20PM +0000, Stanislav Kinsburskii wrote:
> Fix page order determination logic when CONFIG_PGTABLE_HAS_HUGE_LEAVES
> is undefined, as HPAGE_PMD_SHIFT is defined as BUILD_BUG in that case.
> 
> Fixes: abceb4297bf8 ("mshv: Fix huge page handling in memory region
> traversal")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

Queued.

> ---
>  drivers/hv/mshv_regions.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index 202b9d551e39..dc2d7044fb91 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c
> @@ -58,7 +58,7 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
>  
>  	page_order = folio_order(page_folio(page));
>  	/* The hypervisor only supports 4K and 2M page sizes */
> -	if (page_order && page_order != HPAGE_PMD_ORDER)
> +	if (page_order && page_order != PMD_ORDER)
>  		return -EINVAL;
>  
>  	stride = 1 << page_order;
> 
> 

