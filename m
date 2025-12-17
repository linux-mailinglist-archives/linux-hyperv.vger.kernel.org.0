Return-Path: <linux-hyperv+bounces-8046-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFC1CC5FFE
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Dec 2025 06:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6CE13021FB2
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Dec 2025 05:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1B2221710;
	Wed, 17 Dec 2025 05:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="n7JHjA1+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E2C21B9DA;
	Wed, 17 Dec 2025 05:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765947812; cv=pass; b=BFD0Bf0mHpZ64pbJto73uMC4ASdpMAT6aDbZaDt5CE8EXv44xdc/mDaTB4kD5ElYmf2ri9j4fAzbgFu6wagUBaOPrKhtw89ubQOtYqy22lXebe4oL14QmjCnX3pm0nLY2WS2CLgAeNaOsymQZIY14DkJG/VsmjSAUIZfWXDxPHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765947812; c=relaxed/simple;
	bh=F726bWFnRdIUfeCqYrL9weXvCh2N1tbkdgFggthuqcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTFkhJ1Mapgw6q+DegtPwbq5pY5jxzcFSaNrbkYEdRaqjDqALszRSwYtRmK4NAFgPBP++YaflS+Gh9uNYE7ddluf60Am7m52pYpLeN3iBl6QkNf4/A8JJrM2Bp2ZBJkl7/YYfMpZrLSmurdG1urC5nfGgai/L0yzYKtkGn2B8W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=n7JHjA1+; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1765947803; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iRfk7UuvfTH8LS+RwhFXwYNYnnhrCi1TCfQwpSE2s22Ci+inuZnorSyEeBYMPl+4AwEF1W6i3kudl/d4wsYutuIovzt+bUAZ1HhcYY/nhJOja4cKq6Cv7ji/xbL39Rs4icRU0Z59js3zR5jw3SlOQNlRIBDlGibnMQTCGROu3qE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765947803; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XDmGqa3RcQdXEMw1it2akeAdqeI3NF4O2Nb9BVDAOOk=; 
	b=GlcBBfcMXG63tfxDYzPiCRDcFo6NJMfo4uC5P6YtyBJ7h3sKoIO9Aib1SjnZuHnjE0z4Gqf2LyZBjqdzzFpQiFi5SAmhIKmJ0nWSd6YCPnSJyBSleTAb7rGanrpZk2dTV3wiw+Y3habX8Ac0Z/bg0zIlS9c9mnzF0f7WGEsl67c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765947802;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=XDmGqa3RcQdXEMw1it2akeAdqeI3NF4O2Nb9BVDAOOk=;
	b=n7JHjA1+/MqRPHorupwdPgc1DGbBi53wH4NFpWGtwsBi4jfHgYBIEt+vElQBKPoV
	Ow69l4sxvWK8WMjYFBr6UFoZGTX4tw3AHYQoEnJj50P+0Um7LAqD4BbD730v7SpqqHc
	TPGX+VPWEj9Pk35XlQZY9RdOR7SHbI55D30M+QpQ=
Received: by mx.zohomail.com with SMTPS id 176594780122233.91876533300103;
	Tue, 16 Dec 2025 21:03:21 -0800 (PST)
Date: Wed, 17 Dec 2025 10:33:14 +0530
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Use PMD_ORDER instead of HPAGE_PMD_ORDER when
 processing regions
Message-ID: <pgl5c2qr4dawzjssjvs4qd5bzke75hwokgpj65wjy6ry3tl37g@ds3i7u7mzfzm>
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
X-ZohoMailClient: External

On Tue, Dec 09, 2025 at 04:37:20PM +0000, Stanislav Kinsburskii wrote:
> Fix page order determination logic when CONFIG_PGTABLE_HAS_HUGE_LEAVES
> is undefined, as HPAGE_PMD_SHIFT is defined as BUILD_BUG in that case.
> 
> Fixes: abceb4297bf8 ("mshv: Fix huge page handling in memory region
> traversal")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
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

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

