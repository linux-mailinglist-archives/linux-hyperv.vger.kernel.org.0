Return-Path: <linux-hyperv+bounces-8053-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1CFCCD6D4
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Dec 2025 20:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD1C230566B4
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Dec 2025 19:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BC230FF2B;
	Thu, 18 Dec 2025 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsbFCVHr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C3C221FBA;
	Thu, 18 Dec 2025 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766086953; cv=none; b=Km7O9IhhWehHOuU2xH7VGpmly30/eLgUw0d6i9fPfrCTJ0nC1j3NQLLILNxmobTPAkoj34Ng49Vpntu5XyT60nFbn/9ECl5MCvrsANUNpRmT3vQpArTAcdkgs73Wdnruqvfpn8oB/wueYeWrIdlFgwLGKQoCBjUg/7F2wHZEfe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766086953; c=relaxed/simple;
	bh=Q+MRclBGFMwxUpU9evUqOewKe5CVGGDK/sd4p6ct9YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTtLN1BnW7nbW9eswhUvBww8r0jqZswRqQdETHWPwm9EGQtWohtscbsD23C6CawdxKkiZm6P39zOT07rO2WEYTK4x0OwKZAN9jWfXX9xn5zbSBQ+qEr4KgZjVuehioyaD5ob2cWoWsJQwPcDA2qHH7jkJFwnX/6JXv1aQ22w+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsbFCVHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B24C19421;
	Thu, 18 Dec 2025 19:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766086952;
	bh=Q+MRclBGFMwxUpU9evUqOewKe5CVGGDK/sd4p6ct9YM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UsbFCVHr1HmajwGkQWEJB0+RiJKLmeT46tVo4pqtpZt84q0m3BusxrJAPS7zvVrq/
	 y/1trThpzgN7NxPKisRS7j9MtZS0o7mk4mBkzmv49QIgscAo92FoRvb81JC2n4VWEd
	 cvSuY5uFK/YVk8i/aCYv8/7su18GSsUp/CKHMcspAfeEBjcZFXssdcN4QIrs4K5/jX
	 IcZHC37JdHzWWnSjLrhotyafBz9byNmaufw3DcSkzIxnZmmCx/5d5Q60zd/ahpNhbV
	 OBLLcQHuTFnvzYPJRX2/oaEN7aAp+yc3Uv+bO7iabK4oREMOgnNMRyMnxdS+5wNFas
	 YiWeCx/lzpdNw==
Date: Thu, 18 Dec 2025 19:42:31 +0000
From: Wei Liu <wei.liu@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] hyperv: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <20251218194231.GC1749918@liuwe-devbox-debian-v2.local>
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

Applied. I fixed a typo in the commit message ("inmediately" ->
"immediately").

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

