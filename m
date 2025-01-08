Return-Path: <linux-hyperv+bounces-3631-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF5BA0696B
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 00:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACA7D7A2A5C
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 23:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550E42046B7;
	Wed,  8 Jan 2025 23:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Nz9ukMhg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1A2203717;
	Wed,  8 Jan 2025 23:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736378849; cv=none; b=G8XHDrkB5dlcdyTZ12onyEKp78+LuRo+cKXiotZYsS0K8JjpRqN4UFEGGBRTJo7pfV9DFAtpVeIryulhzciIZkuj7y9u2owlpPK13mb33netYTj8lSWNm/IinHIaiVuCUlRmdNvlGdRth3V6cP9D+kYjvfoRdlgspR5fnjVcoJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736378849; c=relaxed/simple;
	bh=DTv2j0CZ7MXvbK8rAzQQu8XlCpnMXKusyglauqrjN7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4vKSa6aQ7JaexEi4KHDHzGjBz/qlqyqgB/34m//Zuo0ofwl7OadFdVSCqcDWVlOHfAi8nh99dW2tz+6hoBYcqTzAW4YL18JaCpZb9WoS4UPSPBjvhxxkhP7hftn+urjXnvhshArv0HbgnRGUufEamaJeXmahxiJFxMZH+16IUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Nz9ukMhg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.116] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 16EFA203E3AB;
	Wed,  8 Jan 2025 15:27:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 16EFA203E3AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736378847;
	bh=17IsKeYL9l15+e5eiFJlOPZ3pJB/jgl3q9b8KeZ9xEg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nz9ukMhgKbXowoe32CNsVmO8k1A3Kz7sumKwbGbdcM8taEbJyfLKgW9O+TmlYzgob
	 kyL7N4S7OgVBTdz9eGTj8BQGfU5/kquqUc2GZvkloUzVsA9vjqxoZIEsWEaG+D4Usy
	 3SN4QP2G+Q9ll1CQFF4+4eBOvES3X2SBOUAe5kcQ=
Message-ID: <18b86a6d-d743-441f-9494-7d36841be210@linux.microsoft.com>
Date: Wed, 8 Jan 2025 15:27:26 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
To: Roman Kisel <romank@linux.microsoft.com>, hpa@zytor.com,
 kys@microsoft.com, bp@alien8.de, dave.hansen@linux.intel.com,
 decui@microsoft.com, eahariha@linux.microsoft.com, haiyangz@microsoft.com,
 mingo@redhat.com, mhklinux@outlook.com, tglx@linutronix.de,
 tiala@microsoft.com, wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20250108222138.1623703-1-romank@linux.microsoft.com>
 <20250108222138.1623703-4-romank@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20250108222138.1623703-4-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/2025 2:21 PM, Roman Kisel wrote:
> Due to the hypercall page not being allocated in the VTL mode,
> the code resorts to using a part of the input page.
> 
> Allocate the hypercall output page in the VTL mode thus enabling
> it to use it for output and share code with dom0.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/hv_common.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index c6ed3ba4bf61..af5d1dc451f6 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -278,6 +278,11 @@ static void hv_kmsg_dump_register(void)
>  	}
>  }
>  
> +static inline bool hv_output_page_exists(void)
> +{
> +	return hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
> +}
> +
>  int __init hv_common_init(void)
>  {
>  	int i;
> @@ -340,7 +345,7 @@ int __init hv_common_init(void)
>  	BUG_ON(!hyperv_pcpu_input_arg);
>  
>  	/* Allocate the per-CPU state for output arg for root */
> -	if (hv_root_partition) {
> +	if (hv_output_page_exists()) {
>  		hyperv_pcpu_output_arg = alloc_percpu(void *);
>  		BUG_ON(!hyperv_pcpu_output_arg);
>  	}
> @@ -435,7 +440,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  	void **inputarg, **outputarg;
>  	u64 msr_vp_index;
>  	gfp_t flags;
> -	int pgcount = hv_root_partition ? 2 : 1;
> +	const int pgcount = hv_output_page_exists() ? 2 : 1;
>  	void *mem;
>  	int ret;
>  
> @@ -453,7 +458,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  		if (!mem)
>  			return -ENOMEM;
>  
> -		if (hv_root_partition) {
> +		if (hv_output_page_exists()) {
>  			outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
>  			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
>  		}

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

