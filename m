Return-Path: <linux-hyperv+bounces-3632-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 590F4A06989
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 00:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F501678A2
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 23:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DAB204F93;
	Wed,  8 Jan 2025 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WkocsOlK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6B5204F6C;
	Wed,  8 Jan 2025 23:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736379293; cv=none; b=DWQVvamkOpMz7jvMRKEF3eIokFDdYcFiGENhHkcwNmOnF6GJz9QNvS8Qho2EW1h9cygpOb/D0wIFKx045zk1pf7dfGYMB8Nd4U7AErkPBzcmdC/g9v+0naG/ocuKYwfB+PwvXLgeKzQGh/M8AIu6ZPLH9t/KHx879BbaEUb8X5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736379293; c=relaxed/simple;
	bh=5Zan0Qoj097fxEc2FrBY88lzEEaXu4ayeOrNUDYEFtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3Qy+KLbyNKT8crCjAf/twPwKEp4vWr/c3UbIciRY2kkZ8gGyvaePnekcWq/Zm5RJtS7iB55mjrS5G6AEiR6bKT3h6iXtm/JhLPYEPTmpaDrshO7njQb7Gfe3t1kqF94Hfy7vpwPZYw8ZrjsJfBOfOGRgc0NWESN0gisMCLDJ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WkocsOlK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.116] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id DD887203E3AA;
	Wed,  8 Jan 2025 15:34:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DD887203E3AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736379291;
	bh=d8+Nj+c5D9yAl7DlCWU2cDcpM828FcqNelyvtvl/3qg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WkocsOlK7RPki18yyznvnLFWJat6XPU2FhWVw6wG8lkN2nubovP87ZeSlgjT/2is8
	 EtRj+Fo+xKWKQ0bh0v4UduCRmdiMb7bGnckuTkVmaLBAV6TgNClw+HfMMCFLAzL1/9
	 /LRtfOH28DkKQ26SSAFXICZIesDmdCJR2pMvAxq4=
Message-ID: <63865d43-1d26-48aa-a033-3f9b464fbc66@linux.microsoft.com>
Date: Wed, 8 Jan 2025 15:34:50 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] hyperv: Do not overlap the hvcall IO areas in
 hv_vtl_apicid_to_vp_id()
To: Roman Kisel <romank@linux.microsoft.com>, hpa@zytor.com,
 kys@microsoft.com, bp@alien8.de, dave.hansen@linux.intel.com,
 decui@microsoft.com, eahariha@linux.microsoft.com, haiyangz@microsoft.com,
 mingo@redhat.com, mhklinux@outlook.com, tglx@linutronix.de,
 tiala@microsoft.com, wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20250108222138.1623703-1-romank@linux.microsoft.com>
 <20250108222138.1623703-6-romank@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20250108222138.1623703-6-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/2025 2:21 PM, Roman Kisel wrote:
> The Top-Level Functional Specification for Hyper-V, Section 3.6 [1, 2],
> disallows overlapping of the input and output hypercall areas, and
> hv_vtl_apicid_to_vp_id() overlaps them.
> 
> Use the output hypercall page of the current vCPU for the hypercall.
> 
> [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
> [2] https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/tlfs
> 
> Reported-by: Michael Kelley <mhklinux@outlook.com>
> Closes: https://lore.kernel.org/lkml/SN6PR02MB4157B98CD34781CC87A9D921D40D2@SN6PR02MB4157.namprd02.prod.outlook.com/
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_vtl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 04775346369c..4e1b1e3b5658 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -189,7 +189,7 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
>  	input->partition_id = HV_PARTITION_ID_SELF;
>  	input->apic_ids[0] = apic_id;
>  
> -	output = (u32 *)input;
> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
>  
>  	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
>  	status = hv_do_hypercall(control, input, output);

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

