Return-Path: <linux-hyperv+bounces-3615-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7B5A063E2
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 19:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08028188752D
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 18:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E93E201016;
	Wed,  8 Jan 2025 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XxvV0sxk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6C3200138;
	Wed,  8 Jan 2025 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736359202; cv=none; b=IlOZ/W/xXB+R3JQsh9XM2xZQJXRmG/oesa7FePW5rnm+n54sdClJil2LRn23XU5Bz2ES53qZhazwrSemufW4jg+cfmoLl080V7WAKHk5YzLUyhcQpK9ICWGCT/C4OBc2SxNr2vi2XlDvICoMAGFicIdHxLcJcqhetCMo1L4P5GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736359202; c=relaxed/simple;
	bh=rPN0x3XcTK0VRl1ZjydPcGkBFDOh7lV+wet28T4hC/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0ThQ3nYBwouNqBRXMq5Qd1FV+0yATJAPhy13WHX/gc8oOq2ZSWUTMGS2ppSjhVTi5w7gYh1WfkGmkJm1z3JjbSqrkjFxho95hOn592FQiEQAQ21lBi8nvLOKV+XIjYyfkAM41Uitc03jYz39d83ZcDs9g4I/E7usyJfUyeErD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XxvV0sxk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.116] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 45033203E3A4;
	Wed,  8 Jan 2025 10:00:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 45033203E3A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736359200;
	bh=b7BDP4q1NNXrzOftg/i/5hXL+6fPGERmxXlT+yGp0Yk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XxvV0sxkDn8vBGRzd/32BRqkYU2DMAaqHCyD3PeJBtO0evqlhNJrAZROy9ouIiaHd
	 tcgoYbutDayxs4qYPyecQaWE3EIOTD/JCB0a4FJZCKGriOmt3TCa6RvlsGC3yPSRlX
	 MCx5zV4fJD1tY92sdtX7aGWM85HuNi9qf70La7Uo=
Message-ID: <9cfadcb4-3822-4bab-a702-8e64dfa935af@linux.microsoft.com>
Date: Wed, 8 Jan 2025 09:59:59 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] hyperv: Fix pointer type in get_vtl(void)
To: Roman Kisel <romank@linux.microsoft.com>, hpa@zytor.com,
 kys@microsoft.com, bp@alien8.de, dave.hansen@linux.intel.com,
 decui@microsoft.com, eahariha@linux.microsoft.com, haiyangz@microsoft.com,
 mingo@redhat.com, mhklinux@outlook.com, tglx@linutronix.de,
 tiala@microsoft.com, wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-3-romank@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20241230180941.244418-3-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/30/2024 10:09 AM, Roman Kisel wrote:
> Commit bc905fa8b633 ("hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h")
> changed the type of the output pointer to `struct hv_register_assoc` from
> `struct hv_get_vp_registers_output`. That leads to an incorrect computation,
> and leaves the system broken.
> 
> Use the correct pointer type for the output of the GetVpRegisters hypercall.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 9e5e8328df6b..f82d1aefaa8a 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -416,13 +416,13 @@ static u8 __init get_vtl(void)
>  {
>  	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
>  	struct hv_input_get_vp_registers *input;
> -	struct hv_register_assoc *output;
> +	struct hv_output_get_vp_registers *output;
>  	unsigned long flags;
>  	u64 ret;
>  
>  	local_irq_save(flags);
>  	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> -	output = (struct hv_register_assoc *)input;
> +	output = (struct hv_output_get_vp_registers *)input;
>  
>  	memset(input, 0, struct_size(input, names, 1));
>  	input->partition_id = HV_PARTITION_ID_SELF;
> @@ -432,7 +432,7 @@ static u8 __init get_vtl(void)
>  
>  	ret = hv_do_hypercall(control, input, output);
>  	if (hv_result_success(ret)) {
> -		ret = output->value.reg8 & HV_X64_VTL_MASK;
> +		ret = output->values[0].reg8 & HV_X64_VTL_MASK;
>  	} else {
>  		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
>  		BUG();

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

