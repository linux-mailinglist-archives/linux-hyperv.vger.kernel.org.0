Return-Path: <linux-hyperv+bounces-8154-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF5ECF4E34
	for <lists+linux-hyperv@lfdr.de>; Mon, 05 Jan 2026 18:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 574BD30268C6
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Jan 2026 17:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DC32D23A5;
	Mon,  5 Jan 2026 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YuB7mTqY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B320129B789;
	Mon,  5 Jan 2026 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767632647; cv=none; b=naYoDSe5UELpk0jHVYJCSjovmkRjdOLLwmNiFF2Q6v4IZ7tl391CkbvcaHfmBmdTS6U7GnyQ8f9ah3GBTUaI1aFznx6V/PdirSWQtZnlQQj09YDdkFeMmN3jXK9jWxrJF+r/wft0T0pgkL53sFNzjs7Ir8l8ZbHT8re1jQxie8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767632647; c=relaxed/simple;
	bh=pOcBmUNbXNQUzpWfZRWczmEdHG6Pvi9kxxf5S5ovgdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhiaAjL38K6Yq6QC5RLif3qGFqzQOm3bGkhv+lqdI7M+E0wQ5Sa91rEYlXpch/DmAyt5ZBL7rjaoQEGn7H0T18ib68xnrwQUvTS53w2svOQnW0IpqZSQsMEaitmVjcKwdoNcFwZneFJN4Wdybimv7MKb2iWM67TOIFXj/n9O76A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YuB7mTqY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id C0DAC211CFB4;
	Mon,  5 Jan 2026 09:04:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C0DAC211CFB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767632644;
	bh=flEvQMBhc15mVs7IMVPVXKCnrs+CWAn9YxBSzXshjIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YuB7mTqY6f5STDDarP7XBOXb6FMfDozZbXQplfPda4BNFPu3uF6fLWWsHAO6Nxgyl
	 L9yKAJPxEp4VCOTHOlqZy819Bpjfbz+0BhYL+7aVc49ceKiDy+DU59SeLVUWMMFZ8F
	 CzdZVf2R8Im0dx4gelfcSs6D88BzRzznvtJLcgfs=
Date: Mon, 5 Jan 2026 09:04:02 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mshv: handle gpa intercepts for arm64
Message-ID: <aVvvAlsohGEdC6Wv@skinsburskii.localdomain>
References: <20260105122837.1083896-1-anirudh@anirudhrb.com>
 <20260105122837.1083896-3-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105122837.1083896-3-anirudh@anirudhrb.com>

On Mon, Jan 05, 2026 at 12:28:37PM +0000, Anirudh Rayabharam wrote:
> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 
> The mshv driver now uses movable pages for guests. For arm64 guests
> to be functional, handle gpa intercepts for arm64 too (the current
> code implements handling only for x86).
> 
> Move some arch-agnostic functions out of #ifdefs so that they can be
> re-used.
> 
> Fixes: b9a66cd5ccbb ("mshv: Add support for movable memory regions")

I'm not sure that this patch needs "Fixes" tag as it introduced new
functionality rather than fixing a bug.

Thanks,
Stanislav

> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  drivers/hv/mshv_root_main.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 9cf28a3f12fe..f8c4c2ae2cc9 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -608,7 +608,6 @@ mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
>  	return NULL;
>  }
>  
> -#ifdef CONFIG_X86_64
>  static struct mshv_mem_region *
>  mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
>  {
> @@ -640,12 +639,17 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
>  {
>  	struct mshv_partition *p = vp->vp_partition;
>  	struct mshv_mem_region *region;
> -	struct hv_x64_memory_intercept_message *msg;
>  	bool ret;
>  	u64 gfn;
> -
> -	msg = (struct hv_x64_memory_intercept_message *)
> +#if defined(CONFIG_X86_64)
> +	struct hv_x64_memory_intercept_message *msg =
> +		(struct hv_x64_memory_intercept_message *)
> +		vp->vp_intercept_msg_page->u.payload;
> +#elif defined(CONFIG_ARM64)
> +	struct hv_arm64_memory_intercept_message *msg =
> +		(struct hv_arm64_memory_intercept_message *)
>  		vp->vp_intercept_msg_page->u.payload;
> +#endif
>  
>  	gfn = HVPFN_DOWN(msg->guest_physical_address);
>  
> @@ -663,9 +667,6 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
>  
>  	return ret;
>  }
> -#else  /* CONFIG_X86_64 */
> -static bool mshv_handle_gpa_intercept(struct mshv_vp *vp) { return false; }
> -#endif /* CONFIG_X86_64 */
>  
>  static bool mshv_vp_handle_intercept(struct mshv_vp *vp)
>  {
> -- 
> 2.34.1
> 

