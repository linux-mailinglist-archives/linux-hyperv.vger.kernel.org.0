Return-Path: <linux-hyperv+bounces-8022-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A57BCBF77F
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Dec 2025 19:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94C3330019D6
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Dec 2025 18:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854BA32142B;
	Mon, 15 Dec 2025 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzasYwoA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BAE2D063E;
	Mon, 15 Dec 2025 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765824481; cv=none; b=fOf0ODQnpFbr/y3pVkuNJmAg3p2EpXEy8pJ+2w5uSHD/0vmJgkotQJ/AjbIGBnt1pzJcdn4548RdMK6iwcZWwVUUNjtKA83CmzFsgSmkwHbOz1c0BLKJLvbgsT8PaKhEmqMQ+rf1Ok3BuIOgObXkey3wA01Rk3kEdYoPpRnND2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765824481; c=relaxed/simple;
	bh=iuD/WsSWcl85HIu8JbszOwwiLXHCEcfqcPAnAczZZTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1D5aTmgSaz9EgWw6Zv3dKpO3qS8jz38DKC9RAllKBkmvlgrWt5e6xxNSU0bzkXPd9PvTGDPx14Fb1pNObOpVMJRA+bzjdrMwP5jN0dmHxX+t9eJa4SCALqgdSgH7myVgPIzmr+VyY9j3VCKgnprXGJoXTA/XhqQ5vzgaaS1dEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzasYwoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4545C4CEF5;
	Mon, 15 Dec 2025 18:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765824480;
	bh=iuD/WsSWcl85HIu8JbszOwwiLXHCEcfqcPAnAczZZTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RzasYwoA/ATZKmBGK5p6VpyEauiMbVhFi/4TA9/l/mz8zBEReN/H/AdIBvf4A4/C4
	 hd4WLc2CdM1+oDFs+CWxlUUeYhJmPIFdp0i4udQ4ap5z9++aER/oZApaalR4/bd/Y4
	 1K4ydDGyhGgOYVA2fdwWP/8PbauXkEO3wu7WAM2XtZBmXOXqq8JLD6DzOwZQBl3nJ6
	 4awa2FoGs5wrVAuPG34u6XLfyq6r/8zdpCydVqeb8GYUdWKfuEgJkAgGWwt1Hmer/M
	 HYdZtbmt11/bXOQfJdGbE+ahxkJvOYJUovVxubrJe5DCLcPqWBVLJ45w4H+kMK1nsG
	 ROqJbCCdLXVZw==
Date: Mon, 15 Dec 2025 18:47:59 +0000
From: Wei Liu <wei.liu@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] hyperv: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <20251215184759.GA654575@liuwe-devbox-debian-v2.local>
References: <aTu54qH2iHLKScRW@kspp>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTu54qH2iHLKScRW@kspp>

On Fri, Dec 12, 2025 at 03:44:50PM +0900, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the new __TRAILING_OVERLAP() helper to fix the following warning:
> 
> include/hyperv/hvgdk_mini.h:581:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> This helper creates a union between a flexible-array member (FAM) and a
> set of MEMBERS that would otherwise follow it.
> 
> This overlays the trailing MEMBER u64 gva_list[]; onto the FAM
> struct hv_tlb_flush_ex::hv_vp_set.bank_contents[], while keeping
> the FAM and the start of MEMBER aligned.
> 
> The static_assert() ensures this alignment remains, and it's
> intentionally placed inmediately after the related structure --no
> blank line in between.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Gustavo, what is your build command? I would like to incorporate that
into my own build tests.

Thanks,
Wei

> ---
>  include/hyperv/hvgdk_mini.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 04b18d0e37af..30fbbde81c5c 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -578,9 +578,12 @@ struct hv_tlb_flush {	 /* HV_INPUT_FLUSH_VIRTUAL_ADDRESS_LIST */
>  struct hv_tlb_flush_ex {
>  	u64 address_space;
>  	u64 flags;
> -	struct hv_vpset hv_vp_set;
> -	u64 gva_list[];
> +	__TRAILING_OVERLAP(struct hv_vpset, hv_vp_set, bank_contents, __packed,
> +		u64 gva_list[];
> +	);
>  } __packed;
> +static_assert(offsetof(struct hv_tlb_flush_ex, hv_vp_set.bank_contents) ==
> +	      offsetof(struct hv_tlb_flush_ex, gva_list));
>  
>  struct ms_hyperv_tsc_page {	 /* HV_REFERENCE_TSC_PAGE */
>  	volatile u32 tsc_sequence;
> -- 
> 2.43.0
> 

