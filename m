Return-Path: <linux-hyperv+bounces-7384-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0667C24284
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 10:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 828114E39E4
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 09:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89633321B3;
	Fri, 31 Oct 2025 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="U1Zopgia"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67801331A6C;
	Fri, 31 Oct 2025 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761902945; cv=none; b=h6zl7Dz7JNeY0XZFBNdrDxFIAhz2S+m2OAwcht7Qk7fAeN9TzyDgvD8oCjSg6A4CIRyIiHsoxUV/Hgh4qTjC33YTogFqAgiv29ztyoqnSE+Qii4342F0jnTM7Zip8QZK4nNq94DebWhojqI0/yhVxComFkDqsOn9+uJAsUxdT/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761902945; c=relaxed/simple;
	bh=fD0vDuTH2JpapIZqdRNnGSAwgq1FL6qHYO5dXSi3d+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SP862cL+wOzMuLlab+NdYD6yyNrJHGKltNft/1w+Af8Nq+11vQS1ILwXIZy6GQISq1M+/bFmIWayWVsE3Wso9B1skxLDnF/RgNEY2kV4pfDFPXcw8qdfTdIw1/hb0WOgeTBY5M0tsaZ3a2h/NwT0FcDpOfXk7YgJ+EsgPXT9nK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=U1Zopgia; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.76.239] (unknown [167.220.238.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id D5B02201DADF;
	Fri, 31 Oct 2025 02:28:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D5B02201DADF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761902942;
	bh=z60NM7qs0T1vkJ2sob5qVgjUXL3lwSCJ4dipne80m0Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U1ZopgiaF1TfsxrbupgV5OEI8b8r2qpPPhtyHheYAXx9Fw5I0TGqxq5SCY7XrK5g0
	 jLIbK3v+eHt8AOkp0+TGZn9KZTfXtfm72Z9wdhMcnnp8I14XU15CeR1yiVAjbRNmOT
	 xRmgpb0dyfIBzK6Z4bxKzK7ppkak++RP/Yx4M6qc=
Message-ID: <cea9d987-0231-4131-82ac-9ba8c852f963@linux.microsoft.com>
Date: Fri, 31 Oct 2025 14:58:56 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/hyperv: Use pointer from memcpy() call for assignment
 in hv_crash_setup_trampdata()
To: Markus Elfring <Markus.Elfring@web.de>, linux-hyperv@vger.kernel.org,
 x86@kernel.org, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Dexuan Cui <decui@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Long Li <longli@microsoft.com>, Mukesh Rathor <mrathor@linux.microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
References: <d209991b-5aee-4222-aec3-cb662ccb7433@web.de>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <d209991b-5aee-4222-aec3-cb662ccb7433@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/31/2025 2:03 PM, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 31 Oct 2025 09:24:31 +0100
> 
> A pointer was assigned to a variable. The same pointer was used for
> the destination parameter of a memcpy() call.
> This function is documented in the way that the same value is returned.
> Thus convert two separate statements into a direct variable assignment for
> the return value from a memory copy action.
> 
> The source code was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   arch/x86/hyperv/hv_crash.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
> index c0e22921ace1..745d02066308 100644
> --- a/arch/x86/hyperv/hv_crash.c
> +++ b/arch/x86/hyperv/hv_crash.c
> @@ -464,9 +464,7 @@ static int hv_crash_setup_trampdata(u64 trampoline_va)
>   		return -1;
>   	}
>   
> -	dest = (void *)trampoline_va;
> -	memcpy(dest, &hv_crash_asm32, size);
> -
> +	dest = memcpy((void *)trampoline_va, &hv_crash_asm32, size);
>   	dest += size;
>   	dest = (void *)round_up((ulong)dest, 16);
>   	tramp = (struct hv_crash_tramp_data *)dest;


I tried running spatch Coccinelle checks on this file, but could not get 
it to flag this improvement. Do you mind sharing more details on the 
issue reproduction please.

I am OK with this change, though it may cost code readability a little 
bit. But if this is a result of some known standard rule, added as part 
of these Coccinelle rules, we should be good.

Regards,
Naman


