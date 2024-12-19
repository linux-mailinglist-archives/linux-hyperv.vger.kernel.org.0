Return-Path: <linux-hyperv+bounces-3497-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1009F72D7
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 03:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D34D77A3220
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 02:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC63155335;
	Thu, 19 Dec 2024 02:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOGFsGlu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10CC198A02;
	Thu, 19 Dec 2024 02:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734576159; cv=none; b=azpRSZNCJM8JLT9UGEMapx3ZK9g8w2eqRXTEuQO/YbDbwIT3PTeVQoCFnabWHk7xtIaDAswtE0OwyknTkC3zslTkIusVirDxASs4Hf48o59qf/Pg8AfDhdhnUnxXjZofoqcJApoavyfSyzsWF+2YAM6h/K/JV4myE+cMCxXrbJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734576159; c=relaxed/simple;
	bh=OxcPq2Wy/CC1+R6akSChOhlo7/+WUxcrYENc7TGbMfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msaSsFxWDsYsyAzQOy+MtlGQdwh42u5IoVwCgk+pywjEhRK20F3Z0QNAIoVcd5sDTJQoxXP4GRbwOTGVOhIvz74e0zh8OgYpndWYlxrc2kEjKWjuZlYExepAHZFt9kH1xxM5FMzjZOxxrgxQcmOqwo95yG2QGlBDFmG5dPYw4hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOGFsGlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2513C4CEDD;
	Thu, 19 Dec 2024 02:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734576159;
	bh=OxcPq2Wy/CC1+R6akSChOhlo7/+WUxcrYENc7TGbMfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TOGFsGlugrvh5OKlFweUTYseLcRgQrTRk9dFTMJqtWtIiBlwAyP1sPwZMiyv4gHzu
	 IeGpl1yhqSshiQuOSDpCJCSsmuwDG1ziHV6+CgpfnmwWSl5/Qyj0C7scgRTqmWyQCc
	 3OxB306F6Z0NT/N0VFCdOQYfr1R6aFxzmyeqzUaJFWyno86iHbdt8Y1+yxmxPlnbXv
	 rkjBZBOeEulTcARzaz9FYBilHdTd0G8bO1ZDVphZUqIXoaAt/dVVehjQpYazYjkyKP
	 HLp6beGSKJ5h5vacqCpjjVx2UkWSUw6yqhuFSJlZTfsaF1owhY2VreEmoorNi2Ykbq
	 aOsaavv8QkzhA==
Date: Thu, 19 Dec 2024 02:42:37 +0000
From: Wei Liu <wei.liu@kernel.org>
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
Subject: Re: [PATCH 2/2] hyperv: Do not overlap the input and output
 hypercall areas in get_vtl(void)
Message-ID: <Z2OIHRF-cJ92IBv2@liuwe-devbox-debian-v2>
References: <20241218205421.319969-1-romank@linux.microsoft.com>
 <20241218205421.319969-3-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218205421.319969-3-romank@linux.microsoft.com>

On Wed, Dec 18, 2024 at 12:54:21PM -0800, Roman Kisel wrote:
> The Top-Level Functional Specification for Hyper-V, Section 3.6 [1, 2], disallows
> overlapping of the input and output hypercall areas, and get_vtl(void) does
> overlap them.
> 
> To fix this, enable allocation of the output hypercall pages when running in
> the VTL mode and use the output hypercall page of the current vCPU for the
> hypercall.
> 
> [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
> [2] https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/tlfs
> 
> Fixes: 8387ce06d70b ("x86/hyperv: Set Virtual Trust Level in VMBus init message")
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 2 +-
>  drivers/hv/hv_common.c    | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index c7185c6a290b..90c9ea00273e 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -422,7 +422,7 @@ static u8 __init get_vtl(void)
>  
>  	local_irq_save(flags);
>  	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> -	output = (struct hv_get_vp_registers_output *)input;
> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);

You can do

	output = (char *)input + HV_HYP_PAGE_SIZE / 2;

to avoid the extra allocation.

The input and output structures surely won't take up half of the page.

Thanks,
Wei.

>  
>  	memset(input, 0, struct_size(input, names, 1));
>  	input->partition_id = HV_PARTITION_ID_SELF;
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

