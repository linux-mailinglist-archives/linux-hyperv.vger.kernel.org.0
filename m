Return-Path: <linux-hyperv+bounces-3498-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD159F72E8
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 03:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B99166BC5
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 02:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F2319B5A9;
	Thu, 19 Dec 2024 02:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oT0c729u"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E01719AD5C;
	Thu, 19 Dec 2024 02:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734576307; cv=none; b=gr5Vshf4tmuDOtmG8g86jx0iQfZatTaW3O1I7JSprvUC5gaeGIvcZuLp7wKSQi5xiuVGbjkgct5I7eCCsBgp5t9aPX+7qJnaZNhKLiZ2iUJPokK6JGWV+jLyEXyeK9PGRLF9z4hGnsLzC4KU3UFZ/lVVqxObsGp2lYSSD2pgaIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734576307; c=relaxed/simple;
	bh=W4UCwb9K/A1RQwKmI67peXh5XJoF5HgV95T0F28Be7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEsEiPmhOQVczQEIV1A6XcaVSxXPNPfnwBhrr80ronG6EEdVpOA8q1baFMM2Bhr7XIvGDwyoyr1JHk4vTwRxtWsINbl9ZDejcE6ky+xN0i4qYTAhoDjj25E4cvHxO3B5nIwe3bq4gyQo2Plw8e+ZdltMSBI/7YzOQPcyrb6VVUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oT0c729u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A325C4CECD;
	Thu, 19 Dec 2024 02:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734576305;
	bh=W4UCwb9K/A1RQwKmI67peXh5XJoF5HgV95T0F28Be7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oT0c729uAp9H5yXJ0seNFvUjs/LJoOBp4FM0aEwH5VseIJWPlZisVuNY39cRQKh18
	 +6kis513WD9wBSg4UPAMycL49gNzOYTV9Hf8Zvtg1f7tsBcz2NYeohCKKXBRdvTFQM
	 cC0U8QWKzcowUhg8CY9ah226rA3CdzzDzePy5UtLAylhLJzvFq9Awm4IxM7K4fKgbj
	 3RXwZZAORKTXmyQwsWYTh4DUCgTO1kQUifZ3VaLTU5rONaIpE8Xu3CXvAxrCAMHvDi
	 jEOgEVLxkjk3+POOhNSmh6QGqgF1itWsiWSiRSoBKLGe2dqfm1Fr0i67hHsUJeIFg9
	 K8us7+c56L9oA==
Date: Thu, 19 Dec 2024 02:45:04 +0000
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
Subject: Re: [PATCH 1/2] hyperv: Fix pointer type for the output of the
 hypercall in get_vtl(void)
Message-ID: <Z2OIsFUXcjVXpqtw@liuwe-devbox-debian-v2>
References: <20241218205421.319969-1-romank@linux.microsoft.com>
 <20241218205421.319969-2-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218205421.319969-2-romank@linux.microsoft.com>

On Wed, Dec 18, 2024 at 12:54:20PM -0800, Roman Kisel wrote:
> Commit bc905fa8b633 ("hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h")
> changed the type of the output pointer to `struct hv_register_assoc` from
> `struct hv_get_vp_registers_output`. That leads to an incorrect computation,
> and leaves the system broken.
> 
> Use the correct pointer type for the output of the GetVpRegisters hypercall.
> 
> Fixes: bc905fa8b633 ("hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h")

This commit is not in the mainline kernel yet, so this tag is not
needed.

It will most likely to be wrong since I will need to rebase the
hyperv-next branch.

I can fold this patch into the original patch and leave your
Signed-off-by there.

Thanks,
Wei.

> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c   | 6 +++---
>  include/hyperv/hvgdk_mini.h | 3 ---
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 3cf2a227d666..c7185c6a290b 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -416,13 +416,13 @@ static u8 __init get_vtl(void)
>  {
>  	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
>  	struct hv_input_get_vp_registers *input;
> -	struct hv_register_assoc *output;
> +	struct hv_get_vp_registers_output *output;
>  	unsigned long flags;
>  	u64 ret;
>  
>  	local_irq_save(flags);
>  	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> -	output = (struct hv_register_assoc *)input;
> +	output = (struct hv_get_vp_registers_output *)input;
>  
>  	memset(input, 0, struct_size(input, names, 1));
>  	input->partition_id = HV_PARTITION_ID_SELF;
> @@ -432,7 +432,7 @@ static u8 __init get_vtl(void)
>  
>  	ret = hv_do_hypercall(control, input, output);
>  	if (hv_result_success(ret)) {
> -		ret = output->value.reg8 & HV_X64_VTL_MASK;
> +		ret = output->as64.low & HV_X64_VTL_MASK;
>  	} else {
>  		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
>  		BUG();
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index db3d1aaf7330..0b1a10828f33 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -1107,7 +1107,6 @@ union hv_register_value {
>  	union hv_x64_pending_interruption_register pending_interruption;
>  };
>  
> -#if defined(CONFIG_ARM64)
>  /* HvGetVpRegisters returns an array of these output elements */
>  struct hv_get_vp_registers_output {
>  	union {
> @@ -1124,8 +1123,6 @@ struct hv_get_vp_registers_output {
>  	};
>  };
>  
> -#endif /* CONFIG_ARM64 */
> -
>  struct hv_register_assoc {
>  	u32 name;			/* enum hv_register_name */
>  	u32 reserved1;
> -- 
> 2.34.1
> 

