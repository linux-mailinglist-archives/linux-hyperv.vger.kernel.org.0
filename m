Return-Path: <linux-hyperv+bounces-7217-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C9ABDBB74
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Oct 2025 00:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB5BE4E02CF
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Oct 2025 22:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16257231827;
	Tue, 14 Oct 2025 22:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFqxCiBk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E108C1DE3B5;
	Tue, 14 Oct 2025 22:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760482698; cv=none; b=RV+2+NGtxhM4RUKuBIQRg04WwYyp5RR/QFY5CsY7Fflu7zPW+CrjfDuoWOOcTbQn+78ns9qS7rA5e3FYBMucjemw48hUsEC8+dWDWQ0UFu5/abl5uUNDLZx/IbAcNCTGph1dUEQqGQJBKEK/tAQjdSKQa8HrJHNxbwgqYrxhS0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760482698; c=relaxed/simple;
	bh=33F0bDG7ISN7W9huX5zRom7Ga+5tslmdfNG35yo5h4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DL/KT8IuUVCQDZjAxWXwDvlT/MrrumSX9GA0beBC2Mj7pzP4G64w/BwNRdVga1DNJ+AfknFQqzXwMyEPKS/ZHuBa3w/u54rY2qEI90pkGoBba6GIMVF3Mjzb97Ew3B3gzx9Sska2GH0V098LP1EOcziusc85vdkAgirRLJh7DQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFqxCiBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593F6C4CEE7;
	Tue, 14 Oct 2025 22:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760482697;
	bh=33F0bDG7ISN7W9huX5zRom7Ga+5tslmdfNG35yo5h4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFqxCiBk1kYnfEDiJ5+/ypN6Y2LBRHWltJyrPK1gBGKGGF/98r6oPx/3fAk20hZzQ
	 786zriNz2sUzzO9NknANvkHze+JSFh7dHI8unTYGPSrZ5BwY+6+0T1mC4QOWEZ/DHV
	 JdgiYRIBgLwZedAu3A8pVfqjIe65FYQCooHqrGxxd+ACfF+5uYJVliU0uAXTY7GgcN
	 MuUTMzyoQsBS+qbWKQvy7ysfrOzQhhkUcXcl3uvIXOKOBJoyiGYFoIIt0HuOKR5rjJ
	 mubQLT/GyJAi3ZEoTs6XNHzutiSkMkO5gxsSMdeWn9dUCTWslkliXRyf58hdgDxJRD
	 QxJ0GiDCFiz3Q==
Date: Tue, 14 Oct 2025 22:58:16 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, skinsburskii@linux.microsoft.com,
	mhklinux@outlook.com
Subject: Re: [PATCH] mshv: Fix VpRootDispatchThreadBlocked value
Message-ID: <20251014225816.GA4136543@liuwe-devbox-debian-v2.local>
References: <1760466017-29523-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1760466017-29523-1-git-send-email-nunodasneves@linux.microsoft.com>

On Tue, Oct 14, 2025 at 11:20:17AM -0700, Nuno Das Neves wrote:
> This value in the VP stats page is used to track if the VP can be
> dispatched for execution when there are no fast interrupts injected.
> 
> The original value of 201 was used in a version of the hypervisor
> which did not ship. It was subsequently changed to 202 so that is the
> correct value.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Applied to hyperv-fixes. Thanks.

> ---
>  drivers/hv/mshv_root_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index e3b2bd417c46..8a42d9961466 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -41,7 +41,7 @@ MODULE_DESCRIPTION("Microsoft Hyper-V root partition VMM interface /dev/mshv");
>  /* TODO move this to another file when debugfs code is added */
>  enum hv_stats_vp_counters {			/* HV_THREAD_COUNTER */
>  #if defined(CONFIG_X86)
> -	VpRootDispatchThreadBlocked			= 201,
> +	VpRootDispatchThreadBlocked			= 202,
>  #elif defined(CONFIG_ARM64)
>  	VpRootDispatchThreadBlocked			= 94,
>  #endif
> -- 
> 2.34.1
> 

