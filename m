Return-Path: <linux-hyperv+bounces-3501-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC41E9F8372
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 19:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57909188BB40
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 18:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97461A2550;
	Thu, 19 Dec 2024 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PId+tJuR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5283D1A0BDB;
	Thu, 19 Dec 2024 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734633620; cv=none; b=jjOgMgc2MTFLZRoi8apjYkFYb4gP/eXiv2qwbRp0DDF8t7tF7YhUyDNYWS6aH9WmcitMog8ExU/sCnIGpbUvFq0lSszdnWOlwTddgbrZdNQbil9Su/cNYkwH6JBg1BSQI13DyiqloP4stG35Ll8b5jAhwQ3GBvvcnSfkNAqbVi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734633620; c=relaxed/simple;
	bh=+Si6x6ztvSMGB71arj1LeZqLuyfAzAgI+AvG62yjoNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgS7eS22tbe4cIS19Z/0QbGOFFUVe7e85+uJ2n6I9udfPOxNqqHIFSW/R22v56HYqbQF0382JOnfRJzxNq3UJv5vRrHxPVtILvZrYFoM3XL1hQdu3+FKdyJwyJ9v7nXzCr6HCS8jTSphRABLsovkf1hXd5jAy2OT1rxxz5zwdUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PId+tJuR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.115] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7E850203FC91;
	Thu, 19 Dec 2024 10:40:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7E850203FC91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734633617;
	bh=u/lfErLnZ2j/JQZPFX+C9/nIK+Q/0/qBDcYkXn8TS/8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PId+tJuRAEX5WastijXwA0rbfVVlneLhZqmhh8nwJk/lYL8xhhb+t+zdyEIxqChGZ
	 uhNX0oc+Z7xnRJnnwC1lcOEui0h6BwnBz633G+LBNIks4V//gBACjSDTgYykAENPlG
	 TfxwqpKqY7y4fIZjN/UGkEte7Siax8vqlH80+HhI=
Message-ID: <17f81f98-a7ca-45e0-87be-9f1cfa5c5a95@linux.microsoft.com>
Date: Thu, 19 Dec 2024 10:40:16 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hyperv: Fix pointer type for the output of the
 hypercall in get_vtl(void)
To: Roman Kisel <romank@linux.microsoft.com>, hpa@zytor.com,
 kys@microsoft.com, bp@alien8.de, dave.hansen@linux.intel.com,
 decui@microsoft.com, eahariha@linux.microsoft.com, haiyangz@microsoft.com,
 mingo@redhat.com, mhklinux@outlook.com, tglx@linutronix.de,
 tiala@microsoft.com, wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20241218205421.319969-1-romank@linux.microsoft.com>
 <20241218205421.319969-2-romank@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20241218205421.319969-2-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/2024 12:54 PM, Roman Kisel wrote:
> Commit bc905fa8b633 ("hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h")
> changed the type of the output pointer to `struct hv_register_assoc` from
> `struct hv_get_vp_registers_output`. That leads to an incorrect computation,
> and leaves the system broken.
> 
My bad! But, lets not use `struct hv_get_registers_output`. Instead, use
`struct hv_register_value`, since that is the more complete definition of a
register value. The output of the get_vp_registers hypercall is just an array
of these values.

Ideally we remove `struct hv_get_vp_registers_output` at some point, since
it serves the same role as `struct hv_register_value` but in a more limited
capacity.

Thanks
Nuno

> Use the correct pointer type for the output of the GetVpRegisters hypercall.
> 
> Fixes: bc905fa8b633 ("hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h")
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


