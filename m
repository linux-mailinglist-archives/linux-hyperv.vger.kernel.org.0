Return-Path: <linux-hyperv+bounces-7340-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C85C0F307
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 17:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A74A4F9831
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 16:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB7B30FC04;
	Mon, 27 Oct 2025 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VS3cvp/7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B01A30CD9D;
	Mon, 27 Oct 2025 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581362; cv=none; b=L5xXoZVax738u+oK8Uov7XsyHc1Dsgb7DBacPHQ+BR72/8PQsBE1B45BA7g7PKcoAoIEKAqh+NyyPb0uYb7QRspItBoR2gqYwCc0WjX/fxjWUjuT5LK9ge17NdYb4lfvUE1a2qPypeHq0WMW19aqm+sZiRonj1Sl0MvIpJm037Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581362; c=relaxed/simple;
	bh=pBn+q92IZDkAv9d3984ktxAQSLT67r3JrCheqiaGODw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fWkPCDU6iK+Af9+QiM40GWuVaynpB0GS/DAAWfpHvCC/+Nc89E6R4lY0y6jdk9qTPKMEtjBlLorMOWIc13uj0T7Qyqrc5qVNQrYgVfmi+3xr11yptScFgSOuM6RH5B/l5ZYFZ0y1rC8UCkFQ+c5iPev2FqkUHHudV0r7SnK4VmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VS3cvp/7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.201.246] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id A02812116DA3;
	Mon, 27 Oct 2025 09:09:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A02812116DA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761581360;
	bh=jBF8YlPKL1IvssVbBvrt99/2aGB6YAYxa/fwlyWCbK0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=VS3cvp/7qg3NLglkKpeR/KGMtQeJafzQjCNo9Nrmg2daK7WKS8Caj36krOI5RSunX
	 wrFNtO9KyPZ5rPMm/r6ugxCbt3DKm7xXUgYqULLh8KL0/gsQrN7IGJ6DsCUt5mVKo0
	 AEyAIO9BoRGQ3gpZxef2bXmF5DIJF31rXoOuu4Jg=
Message-ID: <23c9d48c-f51c-4898-9870-646bf5e02680@linux.microsoft.com>
Date: Mon, 27 Oct 2025 09:09:13 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com,
 easwar.hariharan@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] hv: fix missing kernel-doc description for 'size' in
 request_arr_init()
To: kriish.sharma2006@gmail.com
References: <20251025120707.686825-1-kriish.sharma2006@gmail.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20251025120707.686825-1-kriish.sharma2006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/2025 5:07 AM, kriish.sharma2006@gmail.com wrote:
> From: Kriish Sharma <kriish.sharma2006@gmail.com>
> 
> Add missing kernel-doc entry for the @size parameter in
> request_arr_init(), fixing the following documentation warning
> reported by the kernel test robot and detected via kernel-doc:
> 
> Warning: drivers/hv/channel.c:595 function parameter 'size' not described in 'request_arr_init'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503021934.wH1BERla-lkp@intel.com
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---
>  drivers/hv/channel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks for the patch!

Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 88485d255a42..6821f225248b 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -590,7 +590,7 @@ EXPORT_SYMBOL_GPL(vmbus_establish_gpadl);
>   * keeps track of the next available slot in the array. Initially, each
>   * slot points to the next one (as in a Linked List). The last slot
>   * does not point to anything, so its value is U64_MAX by default.
> - * @size The size of the array
> + * @size: The size of the array
>   */
>  static u64 *request_arr_init(u32 size)
>  {


