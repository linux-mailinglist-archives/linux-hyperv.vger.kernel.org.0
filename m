Return-Path: <linux-hyperv+bounces-3620-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C22A066EE
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 22:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17561188A644
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 21:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4482046B6;
	Wed,  8 Jan 2025 21:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="p0B2Zcmt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70922040BF;
	Wed,  8 Jan 2025 21:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736370512; cv=none; b=Kl5tV0cWf9rZz+AJ1GBA9gwUXlfYSmH1HQtngVvd1fYqytk04KFrJvYB97Dl3YhXeL0GHBaDZAKKHDdH+/hrtKihZdgDQufPNcoxbXMjv9NRm7ExNs14uliaJ0r5M5TtYlSsIm6gutvtMadV6PVbsdSyTtBSGjCyiHiT1/ha3UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736370512; c=relaxed/simple;
	bh=3idNFp0M18fhYpF3njgOHxwjXGfHrEZ+74yH8SRDwoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GpPl/rqCUotL+BlbDIz2u1J2NulDKcCDIHlfHRDdbBsOaqaJ0JWy/iwUz78jjx0bJ889/cmhXaEfDOjnLZI3r11pXrVGFwY9+AyC4fxvqJAyh+LO7F1HZBUCFxhHS0TD52xYnWr6xSUyOCqJ0WeUnsrObpqfgjlMSIpQk0Bx4bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=p0B2Zcmt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.202.96] (67-134-35-98.dia.static.qwest.net [67.134.35.98])
	by linux.microsoft.com (Postfix) with ESMTPSA id F187B203E3AA;
	Wed,  8 Jan 2025 13:08:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F187B203E3AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736370510;
	bh=uu/38tijnAmy2yk4A5kUCLaeNitrE5Px3Z8YERAROLo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p0B2Zcmtd+EjYe8DiQBrAB8XzreH143dAvc+gtLXqsBnduOEmMEiQWMRanIHebczM
	 suvGLLfp5Y2xLXiy84xpfKGP5l6pyCqFRaQ+DdSlPu959sTQQ8TA7TaTAnIzLMxcWH
	 0P64hwbdVgxbB8TjoYY8KuwBHwyGaMiNv99kGcpQ=
Message-ID: <b4a27944-7622-429c-9e59-602f727363b2@linux.microsoft.com>
Date: Wed, 8 Jan 2025 13:08:29 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
To: Roman Kisel <romank@linux.microsoft.com>, hpa@zytor.com,
 kys@microsoft.com, bp@alien8.de, dave.hansen@linux.intel.com,
 decui@microsoft.com, eahariha@linux.microsoft.com, haiyangz@microsoft.com,
 mingo@redhat.com, mhklinux@outlook.com, tglx@linutronix.de,
 tiala@microsoft.com, wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-4-romank@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20241230180941.244418-4-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/30/2024 10:09 AM, Roman Kisel wrote:
> Due to the hypercall page not being allocated in the VTL mode,
> the code resorts to using a part of the input page.
> 
> Allocate the hypercall output page in the VTL mode thus enabling
> it to use it for output and share code with dom0.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/hv_common.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index c6ed3ba4bf61..c983cfd4d6c0 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -340,7 +340,7 @@ int __init hv_common_init(void)
>  	BUG_ON(!hyperv_pcpu_input_arg);
>  
>  	/* Allocate the per-CPU state for output arg for root */
> -	if (hv_root_partition) {
> +	if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
>  		hyperv_pcpu_output_arg = alloc_percpu(void *);
>  		BUG_ON(!hyperv_pcpu_output_arg);
>  	}
> @@ -435,7 +435,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  	void **inputarg, **outputarg;
>  	u64 msr_vp_index;
>  	gfp_t flags;
> -	int pgcount = hv_root_partition ? 2 : 1;
> +	const int pgcount = (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) ? 2 : 1;
>  	void *mem;
>  	int ret;
>  
> @@ -453,7 +453,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  		if (!mem)
>  			return -ENOMEM;
>  
> -		if (hv_root_partition) {
> +		if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
>  			outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
>  			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
>  		}

Replying in a new thread since I don't have all the context about the different
VTL code paths that may need to converge. To my perspective, the approach in this
patch seems perfectly reasonable to fix the current issue.

One small improvement might be to put this check into a helper function. That would
make it easier to amend later when/if a clearly better solution is proposed.

Something like:

static inline bool hv_output_page_exists()
{
	return hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
}

Thanks
Nuno

