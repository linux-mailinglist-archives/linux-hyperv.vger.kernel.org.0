Return-Path: <linux-hyperv+bounces-3793-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FB6A2137F
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jan 2025 22:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCC8164754
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jan 2025 21:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085AD1ACECE;
	Tue, 28 Jan 2025 21:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WxSWhrwi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8457A3C14;
	Tue, 28 Jan 2025 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738098944; cv=none; b=CvsD8dftclwMq5wqVXao9zOGYMIQ3dm77SEn8ZtqBRsp2GYzghnVhJjkpZNZ3lcBXHdMLDeENC9uHQWwKfEAW2kyqKWrHEnK/ufmDkjOuA6LZceXvshIB8oBvSBie/xJ/TvsbDILT4QtwdTufqK69Y7ymGhZZMpzzi+t1LXmOK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738098944; c=relaxed/simple;
	bh=UEvLk/uh7TKxUr2pFE+gRqreDGzbw4BPWhRCqU3VKOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RkTUISr1D6F3n6FdF9PQwzUHeaOzZyg18bliEc3VgQ/EFca6q23GJ79oMhQm1zRiikfxlyoOT2usd0dK3UVe2wDL7u2ZCwob3hlVIh4zYhZOufSorbp3P9adz6f5PLOrOUjIjXr66DAroxd0lefM/ZjNhEgS0VdMH1KPtTPxJgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WxSWhrwi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id E26E2203718A;
	Tue, 28 Jan 2025 13:15:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E26E2203718A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738098943;
	bh=/RmO98xeDMMsl1UmOBAPa9d6T82u+QmX8i/YdJeK+uA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WxSWhrwikpH/vJCIPFqAhiSBnzMuInlftBmKlOPE/HkHsuDKZw380FW+aHW0/nFl2
	 UpjK/paXrOyG4XwwiV3BNNp9ZeUn0mV4l4ulp3Du1g5LSSw5DjjtIU2DdMz7TDaIrI
	 30GjNcQwoi2X3qVDgypWhgXbQJ/ejvfoSygmfYkk=
Message-ID: <4d7bcc3a-4c8e-4757-adae-66be1c5fe921@linux.microsoft.com>
Date: Tue, 28 Jan 2025 13:15:42 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.13 11/15] hyperv: Do not overlap the hvcall IO
 areas in hv_vtl_apicid_to_vp_id()
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Michael Kelley <mhklinux@outlook.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, linux-hyperv@vger.kernel.org
References: <20250128175346.1197097-1-sashal@kernel.org>
 <20250128175346.1197097-11-sashal@kernel.org>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20250128175346.1197097-11-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sasha,

The patch picked up for the stable tree will need this bit
"[PATCH v6 3/5] hyperv: Enable the hypercall output page for the VTL  mode"

https://lore.kernel.org/linux-hyperv/20250108222138.1623703-4-romank@linux.microsoft.com/

On 1/28/2025 9:53 AM, Sasha Levin wrote:
> From: Roman Kisel <romank@linux.microsoft.com>
> 
> [ Upstream commit f285d995743269aa9f893e5e9a1065604137c1f6 ]
> 
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
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20250108222138.1623703-6-romank@linux.microsoft.com
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Message-ID: <20250108222138.1623703-6-romank@linux.microsoft.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/hyperv/hv_vtl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 04775346369c5..4e1b1e3b56584 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -189,7 +189,7 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
>   	input->partition_id = HV_PARTITION_ID_SELF;
>   	input->apic_ids[0] = apic_id;
>   
> -	output = (u32 *)input;
> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
>   
>   	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
>   	status = hv_do_hypercall(control, input, output);

-- 
Thank you,
Roman


