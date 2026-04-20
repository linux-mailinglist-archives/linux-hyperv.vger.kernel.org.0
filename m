Return-Path: <linux-hyperv+bounces-10228-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF9oIGNv5mmBwAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10228-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 20:24:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B7E432CAE
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 20:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C93E3103ABE
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 16:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE170379EF6;
	Mon, 20 Apr 2026 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CGDMVWVr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA1733F58D;
	Mon, 20 Apr 2026 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776704193; cv=none; b=br3co0nKKKf7sNjuIpfANgWFSrdb8KurMvNiVyFMEmkDHB2zdVoiojSGkrE0SsvQAkQQKMMdsLSfT7eUujOzv2X7sgP8/S277GJNpzK6ugTEw9KW9v3CzYsfFkb5NbDeFE/yxHt11eZzVfvGGeowFulvZHT3ecHfLaaBaG7XClI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776704193; c=relaxed/simple;
	bh=sROT+AGOpErHfZBdsUlfDGPWuj4oUQH4bNwzZMyv10Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOJLEizdMWGWfasbamSe2qu9rdzAZCeMtLJuCV0PT2gE/yh6l/44R2cCsbNetE4b+vjT/CVQt3LLBXVUY3RZKztbNGqIGBUz+hJhkqk0Isrv7JtZbtVtZAa073bChJuqxnHzegXSTUkUPHLS1ZKfrlqRDon7nRMdb7lK8+LwL6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CGDMVWVr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3459620B6F01;
	Mon, 20 Apr 2026 09:56:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3459620B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776704192;
	bh=GGqB6pe0KFtVr8QNvFgmh/7Cs9XtT2B2iYy1cnbU7E0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CGDMVWVrHL/w/YB5ST6zosBjJWYRl556sVgJgz6SWCRluS0gcGn1VgSPM1JmkeDhx
	 +DOS6s5igI6oyHhrZ65MsWRXHZfrVueMTkRgirwrpZt4Zwc7nXMyP9GquKZGZDiK4I
	 4PoiriZMfnjCO9vB6JAfPyRdWO1H0rQ4maLxtHyo=
Date: Mon, 20 Apr 2026 09:56:28 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: remove page order restriction to enable 1G
 hugepage support
Message-ID: <aeZavL_GaMyv_NWR@skinsburskii.localdomain>
References: <20260416-huge_1g-v1-1-e066738cddfb@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416-huge_1g-v1-1-e066738cddfb@anirudhrb.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10228-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii.localdomain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anirudhrb.com:email]
X-Rspamd-Queue-Id: D9B7E432CAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 01:37:15PM +0000, Anirudh Rayabharam (Microsoft) wrote:
> The hypervisor's map GPA hypercall handles large pages intelligently,
> combining 2M pages into 1G mappings when alignment allows.
> 
> Remove the PMD_ORDER check in mshv_chunk_stride() so that 1G hugepages
> and other large page orders are passed through as 2M-aligned chunks,
> letting the hypervisor promote them to 1G mappings automatically.
> 
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  drivers/hv/mshv_regions.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index fdffd4f002f6..5f617a96d97a 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c
> @@ -29,7 +29,7 @@
>   * Uses huge page stride if the backing page is huge and the guest mapping
>   * is properly aligned; otherwise falls back to single page stride.
>   *
> - * Return: Stride in pages, or -EINVAL if page order is unsupported.
> + * Return: Stride in pages.
>   */
>  static int mshv_chunk_stride(struct page *page,
>  			     u64 gfn, u64 page_count)

Nit: the return type of the function should now become unsigned.

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

> @@ -47,9 +47,6 @@ static int mshv_chunk_stride(struct page *page,
>  		return 1;
>  
>  	page_order = folio_order(page_folio(page));
> -	/* The hypervisor only supports 2M huge page */
> -	if (page_order != PMD_ORDER)
> -		return -EINVAL;
>  
>  	return 1 << page_order;
>  }
> 
> ---
> base-commit: cd9f2e7d6e5b1837ef40b96e300fa28b73ab5a77
> change-id: 20260416-huge_1g-e44461393c8f
> 
> Best regards,
> -- 
> Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 

