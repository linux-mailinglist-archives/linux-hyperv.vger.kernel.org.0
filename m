Return-Path: <linux-hyperv+bounces-8367-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F79D3B073
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Jan 2026 17:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C614730049D5
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Jan 2026 16:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA77723EA8D;
	Mon, 19 Jan 2026 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HVruW9LL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C55A29AAEA;
	Mon, 19 Jan 2026 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768839805; cv=none; b=jn0HcdWOoEJ/CouQzANrBb/B/0bMdqDATnv/VemTkoXwKSSVXXd9N9t0fJbiWgFnXGEcL/A7o5VdHmayqK58Zd0jrAbUgmAhzIm9dwb5X6cQcA4RhjE0890Z1/5sqA4cSSVU3pPD8/GaWmI0QfGz1aFJc1u9akxmKAbSCXTaorQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768839805; c=relaxed/simple;
	bh=psabB770lI6tUftMOfcD9fltajqW+XbemM4AeA+nmf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwYZRKAxOA2szAa6bNvHJ53in6mJbzhE+doC5Dj6MqdEW7evl3q46ToVxSI8kkcZ1zyyopmfyjabTtzLQ+lbkRT0D5Ut29G/+9RXBEVvyaoMf5UCzVqf04Q6NJdPgjlfHNJL8S5dXPfWVwjVKUqT6/eOVifbiwlOaFNUDsVkbMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=HVruW9LL; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9483:13a:c452:d5de:4aa7] ([IPv6:2601:646:8081:9483:13a:c452:d5de:4aa7])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60JGMc783000483
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 19 Jan 2026 08:23:03 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60JGMc783000483
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1768839787;
	bh=mbn/95jI7B+OCYH6g45e8eMRy2dr5hqZh0RpE97oo1k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HVruW9LLlpCkAaHxj9nBSBzOVo6Clo1E6snhkWBTd+KrDxpaZ22+TFL3nvgCZGFtN
	 FQH+FlSi7hEvjiHRRHIW1R1z4dpTGd+KLEKz1mq6u5LUZWT11hKy3T/ib585I66wh5
	 LuR9oS3PNiF18U5lpwJDFeD9jh/Gel4U+zeduMgEqnc3EFqbLTmI8uXe2vTMQ9l/3h
	 m46J0TA4RrTau/kWTci+vTI9zKKjhtoY3ooKw9q6P+bPNsgmzZIFoJbi67ztIZo4ax
	 hGh6Z9IoohhyrI/7EvvphAZymTca2Xxeduzv9giq+/olX2+MdVTpYsb1lT1r+tejfS
	 SSM5KoppmUdag==
Message-ID: <9f05741d-584c-48a3-a09a-b8d78b230de4@zytor.com>
Date: Mon, 19 Jan 2026 08:22:33 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 1/3] x86: Use MOVL when reading segment
 registers
To: Uros Bizjak <ubizjak@gmail.com>, linux-hyperv@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Michael Kelley <mhklinux@outlook.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20260105090422.6243-1-ubizjak@gmail.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260105090422.6243-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-01-05 01:02, Uros Bizjak wrote:
> Use MOVL when reading segment registers to avoid 0x66 operand-size
> override insn prefix. The segment value is always 16-bit and gets
> zero-extended to the full 32-bit size.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>  arch/x86/include/asm/segment.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
> index f59ae7186940..9f5be2bbd291 100644
> --- a/arch/x86/include/asm/segment.h
> +++ b/arch/x86/include/asm/segment.h
> @@ -348,7 +348,7 @@ static inline void __loadsegment_fs(unsigned short value)
>   * Save a segment register away:
>   */
>  #define savesegment(seg, value)				\
> -	asm("mov %%" #seg ",%0":"=r" (value) : : "memory")
> +	asm("movl %%" #seg ",%k0" : "=r" (value) : : "memory")
>  
>  #endif /* !__ASSEMBLER__ */
>  #endif /* __KERNEL__ */

Looks good to me.

Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>


