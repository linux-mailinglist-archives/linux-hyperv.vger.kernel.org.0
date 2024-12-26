Return-Path: <linux-hyperv+bounces-3535-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4D89FCE58
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 23:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE0D188303D
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 22:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1549F139E;
	Thu, 26 Dec 2024 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HmLWTM8y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FC4450F2;
	Thu, 26 Dec 2024 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735250491; cv=none; b=I+dfH/jNK1Kl0bzStjyiFSRTlwFwoc2z6fHcopX6MhBDVGYbHVTIq/j23Al+OzjryChFiC6Iq1jGKBRJTNHLhBOyr0YBZg4UMf35qZCFLgPwbqRRVfN2jJfwEM/srSsNsuE7hpf3UdjJ0Il+MXWfX3mZGtu2PS0wR4CDQkYL37s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735250491; c=relaxed/simple;
	bh=nK/hYpZ5v1CIAfWymlHPH7uZqsI9tILBP+Zd41bYU8U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Mquc7DZ97WAdZc/sa0tTUyHCpxHvf9nvrFZteuhKaC79Dwnjt4qXUpTUQu9bqMu/kZHDRJRwRYQ3KZHyJ3TOlVDwBCxJ4cpJF92euWIb2eByX+NwXwaQCtIOjjFr2H0S2BnNM7lKELKcoKio+zs0XP1986H6TrxYg9FL3h6lvn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HmLWTM8y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.224.184] (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7049D203EC24;
	Thu, 26 Dec 2024 14:01:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7049D203EC24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735250489;
	bh=QRjtAab2j659x7+JDCM24/4dYbDfoi3gyyyT6xAWl48=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=HmLWTM8ywoF9gOVqVt5q1zYx80sbZ0LokSUvqTb1MBXsdBG/oaQRXW0J0pghCujYG
	 rzXA/lG+K+XXF2rG1lG0OfWgUFQdKPHoqNptBccKgm1YP16k1Z7FNyPwa5DmzMrA5Y
	 bQV2Uf474inChymNrPu4o/I0ieajy/meHwjBOsHQ=
Message-ID: <8c564cfc-2794-45f2-a1cf-2d6b5d0d78e6@linux.microsoft.com>
Date: Thu, 26 Dec 2024 14:01:30 -0800
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
Subject: Re: [PATCH v3 5/5] hyperv: Do not overlap the hvcall IO areas in
 hv_vtl_apicid_to_vp_id()
To: Roman Kisel <romank@linux.microsoft.com>
References: <20241226213110.899497-1-romank@linux.microsoft.com>
 <20241226213110.899497-6-romank@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20241226213110.899497-6-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/26/2024 1:31 PM, Roman Kisel wrote:
> The Top-Level Functional Specification for Hyper-V, Section 3.6 [1, 2],
> disallows overlapping of the input and output hypercall areas, and
> hv_vtl_apicid_to_vp_id() overlaps them.
> 
> Use the output hypercall page of the current vCPU for the hypercall.
> 
> [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
> [2] https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/tlfs
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_vtl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 04775346369c..ec5716960162 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -189,7 +189,7 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
>  	input->partition_id = HV_PARTITION_ID_SELF;
>  	input->apic_ids[0] = apic_id;
>  
> -	output = (u32 *)input;
> +	output = (u32*)*this_cpu_ptr(hyperv_pcpu_output_arg);
                     ^
Nit: I believe the space is preferred, but I won't insist on respinning
it for that.

It's a good idea to give credit to Michael with a Reported-by tag, and
maybe a Closes: tag with a link to his email.

As with the Fixes tag for patch 2, you don't need to respin the series
and can just reply to this thread.

Otherwise, looks good to me.

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

