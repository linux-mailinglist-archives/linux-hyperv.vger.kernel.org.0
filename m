Return-Path: <linux-hyperv+bounces-3533-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 610199FCE13
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 22:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023041882692
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 21:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5988B1494A9;
	Thu, 26 Dec 2024 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ie9hmBHH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081EE18E1F;
	Thu, 26 Dec 2024 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735249355; cv=none; b=pVk1lfkJ0x/IABLWqRUi9Pscezsw4wVR4idEqGFSApwkcHxDyW1wmYaEJExaeHXE2x6SG5jABaHLWwEH6YAcwx5ksAGwFNYvMHDCRdaRVkVaYBbEuV/+a3hFHTJ76vxUNHF4T0H1rciC6+r1oQREaAJOPeOy5zpH2A2bzfb3mUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735249355; c=relaxed/simple;
	bh=nyV+pvlZLDa5It2SpN+yRLQra7S4AObctepdenZsgG4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NqOpttKkGFWZCG3Cuk4Asm1tVxg24AJbs3yagAGAH3B352XenE6hEa3/Enj6rTZF1rBEwPnOeRKA2pxAJ+J/GaFRu8XECSLN8SwmlxGsF2BQtVFvv8kCR0VI8pRSpWHdP7iE3s2UQtp6PcTR8bjREFAJimnmP7dlwr16Y7TJoc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ie9hmBHH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.224.184] (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 21F94203EC22;
	Thu, 26 Dec 2024 13:42:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 21F94203EC22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735249353;
	bh=n/00/p7bhVrngaTNTDwZd0iXTtgu1g3WWoBl6wBl1XE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ie9hmBHHwRhqayedS8oVdR6sBliA+ytqe35nAmWGnA+C1cz6hynS5SedXljStoiKV
	 70uIUNTElPCnNok6GIUvryazo5WT0oIFn/D7lHzEIyU5MnXbyo0SMHy8jHJqCexxOq
	 vHcqbG/r4qLUEbflZKGjXviNsoCbNg6p/3M3ti/U=
Message-ID: <ded7fedc-b420-46c6-ba33-5c2f1cb4831e@linux.microsoft.com>
Date: Thu, 26 Dec 2024 13:42:35 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 mingo@redhat.com, mhklinux@outlook.com, nunodasneves@linux.microsoft.com,
 tglx@linutronix.de, tiala@microsoft.com, wei.liu@kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 eahariha@linux.microsoft.com, apais@microsoft.com, benhill@microsoft.com,
 ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v3 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
To: Roman Kisel <romank@linux.microsoft.com>
References: <20241226213110.899497-1-romank@linux.microsoft.com>
 <20241226213110.899497-4-romank@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20241226213110.899497-4-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/26/2024 1:31 PM, Roman Kisel wrote:
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
> index c4fd07d9bf1a..5178beed6ca8 100644
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

Thanks for the const!

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

