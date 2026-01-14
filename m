Return-Path: <linux-hyperv+bounces-8293-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C07D20DCB
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 19:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B31F3001BC1
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 18:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EDC3358A6;
	Wed, 14 Jan 2026 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="d+1c5eVF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25419155C82;
	Wed, 14 Jan 2026 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416007; cv=none; b=IhffuSvPo44sBiwjqj5gBECSJqlne1FAW45w0meFC+N7SXy8DBzK8kUdPERRn9w4N87bRaFqvi4Cy6evPbzjPnk8LU7KBXkokzUH8GVJ3+XHHHhDz9nouPmHAKtmMIuE/CIjswgtlLrpI3vy8wb5Nqo4oEHWE6jf7tva6NIhwLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416007; c=relaxed/simple;
	bh=3BirbJMWCsvtq7uO00dspxg/f/DWRxZYj6NobTJm2OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OO8QJx67hFT0+K670zPpjyk2kDdd61XB9+RtJQz+QwtVFY8SAYAQytx2oxy+00cfz1JCEJIe0dg/LHySb0xuTQqIutJZTfQhLn+Pvv9qXU6bzkjAwz537I4UFF5//e65BckvoxKAqbNRukSYyv1Qmx2iYACNrRbmU7EPEMfQLOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=d+1c5eVF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.97.88] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7A22420B7165;
	Wed, 14 Jan 2026 10:40:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A22420B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768416005;
	bh=JCdg2Ye8wm9lJpceKYdnZ2V1nIKJY/T1NdPY/KJnYZo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d+1c5eVFE7MfwZvIzVHFnomQ+ODJW1iyK8FIfN2GNd7jV4KZ9Zb1Fc/rHM2nroaxk
	 AzD25qwduP27BBaxA1MJTaSxXxlOw5BnYH6PSWhe89b5gMLbWC7wriXcJ/6KwrnYFk
	 no8/Baw0TFRjCSIIQgLDFw29NgFqb1eoSJ8KAWI8=
Message-ID: <49fd5523-f558-4ac0-b1a5-d0ead75bd9f3@linux.microsoft.com>
Date: Wed, 14 Jan 2026 10:40:04 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mshv: Store the result of vfs_poll in a variable of
 type __poll_t
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
 linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20260114170112.102673-1-mhklinux@outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20260114170112.102673-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/2026 9:01 AM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> vfs_poll() returns a result of type __poll_t, but current code is using
> an "unsigned int" local variable. The difference is that __poll_t carries
> the "bitwise" attribute. This attribute is not interpreted by the C
> compiler; it is only used by 'sparse' to flag incorrect usage of the
> return value. The return value is used correctly here, so there's no
> bug, but sparse complains about the type mismatch.
> 
> In the interest of general correctness and to avoid noise from sparse,
> change the local variable to type __poll_t. No functional change.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512141339.791TCKnB-lkp@intel.com/
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> This change is not marked with a Fixes: tag as there's no value in
> backporting to older stable releases.
> 
>  drivers/hv/mshv_eventfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
> index d93a18f09c76..0b75ff1edb73 100644
> --- a/drivers/hv/mshv_eventfd.c
> +++ b/drivers/hv/mshv_eventfd.c
> @@ -388,7 +388,7 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
>  {
>  	struct eventfd_ctx *eventfd = NULL, *resamplefd = NULL;
>  	struct mshv_irqfd *irqfd, *tmp;
> -	unsigned int events;
> +	__poll_t events;
>  	int ret;
>  	int idx;
>  

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

