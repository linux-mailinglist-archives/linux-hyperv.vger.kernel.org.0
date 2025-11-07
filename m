Return-Path: <linux-hyperv+bounces-7456-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F63C3EA77
	for <lists+linux-hyperv@lfdr.de>; Fri, 07 Nov 2025 07:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6C384E3B43
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Nov 2025 06:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7329B303C9D;
	Fri,  7 Nov 2025 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGQ+Qigu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B99303A35;
	Fri,  7 Nov 2025 06:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762498351; cv=none; b=dJkKEGAJqOjKOHQTFiw/oiHXIXdeelokbdnI2nzhJ6rw9KCracMrd1qnk8OaGBQHFYnTKy8+UIwHQ7xQr7o8BkWW/PYXe958RAa960x42JeGNdEizn4eSFkgMRcAYEi2wDXSZVeM4ngD24Wls8rrYVNpcqF2+aXxbIEIHgyIgew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762498351; c=relaxed/simple;
	bh=GSGVZjGHbZqJQkcMPBLuFDL10W5J4yRC8mHSoKHhB04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxbamJTR7QaS2nxhv1ei9icu/LaJX7mygzvgQjsBiEdxGq34FFJ4xttFBoHOHdTcIkeA7gv3x3laIs9PplPESil/mZtviKYaiN7lkDBlz73ixWj0NAzyIqVAwL0A/iL5YrlkE6YrzAAUd9Pjar8M8udG3ZNbKT6finSyG+0xcI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGQ+Qigu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EB7C4CEF5;
	Fri,  7 Nov 2025 06:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762498350;
	bh=GSGVZjGHbZqJQkcMPBLuFDL10W5J4yRC8mHSoKHhB04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kGQ+QiguLBTJbg2UCneyBwFRFBMrdjgxTONaH2PCwc+T6GrztfpvBiTI7KHjl9poq
	 o0sVnejbnSFa6ipjb1HOB3fSCBr9vs8hEV8NeARxghLwlNfOERMpFA9Dl5t8dL1jpQ
	 0b/OKUE0dYS4gy60FfEMa+4MHByG50QJZhlxjC6lVOyyWRYBpoCKVh3GKS3+SJjSi6
	 GK+BDwqF3XZ0B4g0Uo0SaYqlmLmrOPWOATjrJ/LLxf3YCYSiEocNvM0NZzPSSq+EBB
	 8xHsz0cEb82W6r1B9Y43gp6ZmuCw7WxIBqkTjYfBci/iSeMePS1bgwEShYRdDiOZcX
	 kYH/uuFXQclNg==
Date: Fri, 7 Nov 2025 06:52:29 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Rahul Kumar <rk0006818@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] drivers/hv: Use kmalloc_array() instead of kmalloc()
Message-ID: <20251107065229.GA3932045@liuwe-devbox-debian-v2.local>
References: <20251104121618.1396291-1-rk0006818@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104121618.1396291-1-rk0006818@gmail.com>

On Tue, Nov 04, 2025 at 05:46:18PM +0530, Rahul Kumar wrote:
> Documentation/process/deprecated.rst recommends against the use of
> kmalloc with dynamic size calculations due to the risk of overflow and
> smaller allocation being made than the caller was expecting.
> 
> Replace kmalloc() with kmalloc_array() in hv_common.c to make the
> intended allocation size clearer and avoid potential overflow issues.
> 
> The number of pages (pgcount) is bounded, so overflow is not a
> practical concern here. However, using kmalloc_array() better reflects
> the intent to allocate an array and improves consistency with other
> allocations.
> 
> No functional change intended.
> 
> Signed-off-by: Rahul Kumar <rk0006818@gmail.com>

Applied to hyperv-next. Thanks.

> ---
>  drivers/hv/hv_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index e109a620c83f..68689beb383c 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -487,7 +487,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  	 * online and then taken offline
>  	 */
>  	if (!*inputarg) {
> -		mem = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
> +		mem = kmalloc_array(pgcount, HV_HYP_PAGE_SIZE, flags);
>  		if (!mem)
>  			return -ENOMEM;
>  
> -- 
> 2.43.0
> 

