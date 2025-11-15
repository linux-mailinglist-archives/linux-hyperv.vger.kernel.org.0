Return-Path: <linux-hyperv+bounces-7606-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86066C6008E
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Nov 2025 07:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DD024E5B5B
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Nov 2025 06:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0026A1C5D6A;
	Sat, 15 Nov 2025 06:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZipnyDf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C907C15746E;
	Sat, 15 Nov 2025 06:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763187762; cv=none; b=XND9Yi+nOZXOnNUL+9H69Z/QKtsyl4cixIPzytzIAPoVFc61neasRl4UfZirkegLYRweRhijtESnRP7u9APk9EcIuPOJXUZ0tYSZ3whZsSOkZexD635BfH9imbqJC8Ht7Dpb7sMb/9uu5ZB/RTr6D74Cbpiai1eIENKWTieA+t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763187762; c=relaxed/simple;
	bh=kqxPP4YF5FdjtlCqAHBxAazNBVmTdTzi9eZ1OFqRWaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDdu6pXZ/ulHub4S+ff5Sj/S0nqiqjtRZiGrZDbiVi6YnyFPeS6xAJfOYVwzuZbTAwyk/Gy62ttU8pvOTOClAAQ4wWe7a4z+FfXbxEQgjM7F4iUR5+0y18DDTHyDsQp6NNqtDlPGRHLDM0vW0SaP3QaXJmdkicDaKYiUKJEtqqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZipnyDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36341C4CEF7;
	Sat, 15 Nov 2025 06:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763187762;
	bh=kqxPP4YF5FdjtlCqAHBxAazNBVmTdTzi9eZ1OFqRWaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fZipnyDfayyq0RjHn5c1Pab8EW35eg0t/8RtFUpf4O+LRMHHkiRpRf0oLDgAoY/SJ
	 5yRBbNA48tJ2ugPoPaDli+h/MNKHt+HsQdAOSqzIbdLT5lolMnXsz98/Pmlxmzlke0
	 d4AHGRZVa+GpCk+xiyRwX8YXv22VR3joQ1VZYJRQrnXeIKM6sQGlaA/ij9cPt6106S
	 YWOvaGC/boqPneuBioekLjGE5Fn0lFQJZM+wu12DZ43MIGmEQegk/LQ1rFTydeRosE
	 0kKvCVse1AWjAblOSX3ifzHm28c3RddRRUW8+OPycndHlmNwYjAi/4R0ubdClWEvO/
	 v5Y0sRU+w+Qwg==
Date: Sat, 15 Nov 2025 06:22:40 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: ioctl for self targeted passthrough hvcalls
Message-ID: <20251115062240.GA1794663@liuwe-devbox-debian-v2.local>
References: <20251114095853.3482596-1-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114095853.3482596-1-anirudh@anirudhrb.com>

On Fri, Nov 14, 2025 at 09:58:52AM +0000, Anirudh Rayabharam wrote:
> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 
> Allow MSHV_ROOT_HVCALL IOCTL on the /dev/mshv fd. This IOCTL would
> execute a passthrough hypercall targeting the root/parent partition
> i.e. HV_PARTITION_ID_SELF.
> 
> This will be useful for the VMM to query things like supported
> synthetic processor features, supported VMM capabiliites etc.
> 
> While at it, add HVCALL_GET_PARTITION_PROPERTY_EX to the allowed list of
> passthrough hypercalls.
> 
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

This doesn't apply to hyperv-next. What's its base?

Wei

> ---
>  drivers/hv/mshv_root_main.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 20eda00a1b5a..98f56322cd19 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -122,6 +122,7 @@ static struct miscdevice mshv_dev = {
>   */
>  static u16 mshv_passthru_hvcalls[] = {
>  	HVCALL_GET_PARTITION_PROPERTY,
> +	HVCALL_GET_PARTITION_PROPERTY_EX,
>  	HVCALL_SET_PARTITION_PROPERTY,
>  	HVCALL_INSTALL_INTERCEPT,
>  	HVCALL_GET_VP_REGISTERS,
> @@ -159,6 +160,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
>  	unsigned int pages_order;
>  	void *input_pg = NULL;
>  	void *output_pg = NULL;
> +	u64 pt_id = partition ? partition->pt_id : HV_PARTITION_ID_SELF;
>  
>  	if (copy_from_user(&args, user_args, sizeof(args)))
>  		return -EFAULT;
> @@ -180,7 +182,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
>  	is_async = mshv_hvcall_is_async(args.code);
>  	if (is_async) {
>  		/* async hypercalls can only be called from partition fd */
> -		if (!partition_locked)
> +		if (!partition || !partition_locked)
>  			return -EINVAL;
>  		ret = mshv_init_async_handler(partition);
>  		if (ret)
> @@ -208,7 +210,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
>  	 * NOTE: This only works because all the allowed hypercalls' input
>  	 * structs begin with a u64 partition_id field.
>  	 */
> -	*(u64 *)input_pg = partition->pt_id;
> +	*(u64 *)input_pg = pt_id;
>  
>  	if (args.reps)
>  		status = hv_do_rep_hypercall(args.code, args.reps, 0,
> @@ -226,7 +228,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
>  	}
>  
>  	if (hv_result(status) == HV_STATUS_INSUFFICIENT_MEMORY) {
> -		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition->pt_id, 1);
> +		ret = hv_call_deposit_pages(NUMA_NO_NODE, pt_id, 1);
>  		if (!ret)
>  			ret = -EAGAIN;
>  	} else if (!hv_result_success(status)) {
> @@ -2048,6 +2050,9 @@ static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl,
>  	case MSHV_CREATE_PARTITION:
>  		return mshv_ioctl_create_partition((void __user *)arg,
>  						misc->this_device);
> +	case MSHV_ROOT_HVCALL:
> +		return mshv_ioctl_passthru_hvcall(NULL, false,
> +					(void __user *)arg);
>  	}
>  
>  	return -ENOTTY;
> -- 
> 2.34.1
> 

