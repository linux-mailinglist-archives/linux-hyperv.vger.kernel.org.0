Return-Path: <linux-hyperv+bounces-3576-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6C2A00E65
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Jan 2025 20:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C6F164809
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Jan 2025 19:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D491F1FC111;
	Fri,  3 Jan 2025 19:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Fcc8MV25"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEB51B983E;
	Fri,  3 Jan 2025 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735932012; cv=none; b=DxyFo3waZVMNe+uR7y2HlLDhWpRT3tjXNAZ1VjI7Ehhxn5b87en2jK/aQNk+EIhRvazyIghwdUXagFiheNnfco/3r/eebWY5a8CJX8WHMo1M+96qE/wzL49/Hpzso1vBZJ9p7CS5CEdQkr/8WzDMsmocXA8EOuetAuvwPeZ2YCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735932012; c=relaxed/simple;
	bh=EKWM9WbWK0DXyXu4knFIIYSA3Blg/EezB+ylnmr+kqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/lSFUv83Lo5V4FMevgjKz26UFwZ1pEUSFbRqnghMqlHVTxe97y7uFvcBsjGQ0Noekxu2rfSNoXy/nhzJh1/7r924nJojWtN035Sn8KcJIItDW1JU55czvZ+c46NLVAsyf3gAejEw4wVVx/9LJ94G0dKPjqvJv5bIogrQspd4Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Fcc8MV25; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (c-98-225-44-166.hsd1.wa.comcast.net [98.225.44.166])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7BEA62041AA7;
	Fri,  3 Jan 2025 11:20:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7BEA62041AA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735932004;
	bh=+VxuvZPHgEQQSeMmqXS1hZjXl9UHqcI8mrB3H3EuHnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fcc8MV25hoI77k3fIsN7njvw1S6lhGnsPGVWwqpM3VMAC0Uwat2Hl7MXIm9EUVlQ7
	 9wNRxysYZ3/FeAugKaQWJrm3z5d6OhlJfQfpVg2ndCJlUDVF76dGdvLSjSvpdJ1k95
	 3qV7KiUA7PkP47gkr9ken2vYO6drgtCbNiDIbtiA=
Date: Fri, 3 Jan 2025 11:20:02 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	eahariha@linux.microsoft.com, haiyangz@microsoft.com,
	mingo@redhat.com, mhklinux@outlook.com,
	nunodasneves@linux.microsoft.com, tglx@linutronix.de,
	tiala@microsoft.com, wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
Message-ID: <20250103192002.GA22059@skinsburskii.>
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-4-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230180941.244418-4-romank@linux.microsoft.com>

On Mon, Dec 30, 2024 at 10:09:39AM -0800, Roman Kisel wrote:
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

This check doesn't look nice.
First of all, IS_ENABLED(CONFIG_HYPERV_VTL_MODE) doesn't mean that this
particular kernel is being booted in VTL other that VTL0.

Second, current approach is that a VTL1+ kernel is a different build from VTL0
kernel and thus relying on the config option looks reasonable. However,
this is not true in general case.

I'd suggest one of the following three options:

1. Always allocate per-cpu output pages. This is wasteful for the VTL0
guest case, but it might worth it for overall simplification.

2. Don't touch this code and keep the cnage in the Underhill tree.

3. Introduce a configuration option (command line or device tree or
both) and use it instead of the kernel config option.

Thanks,
Stas

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
> -- 
> 2.34.1
> 

