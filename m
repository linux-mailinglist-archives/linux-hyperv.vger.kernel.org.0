Return-Path: <linux-hyperv+bounces-8368-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C9279D3B117
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Jan 2026 17:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE9A4305D901
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Jan 2026 16:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894B93033D3;
	Mon, 19 Jan 2026 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Dh5zP/kg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3288E3043A2;
	Mon, 19 Jan 2026 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768839863; cv=none; b=V/hRQ5X1f7JrYi/NY+BNtNw43VOpnmzcpmBrB5xdYVQvDX2xFy5t6j9wxlxOpwCnK46CRFyK4TYC1mvJyOQh4MOFId+eJmuWfNcxtmFB0Vc6BktDxEpTef80+2UEwp167QNIwMlQCoG38n7uTAfdpNmyEAN9zMzC2dIa5QtWky8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768839863; c=relaxed/simple;
	bh=rvRTS0qO+jO8uTFN2bIExSp7rSoAERIHlIym73YFp9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvNeZgAOFT+hZRw3fBKuhrPK4pMvlLh+X5UfA0rvfsSwMR5BDSUDMZVfETowLSnjJHsrA3V1tkEiqswitCTJIiogNguXWI9Nw6aToxdu5I4E7Nwh3posp8tgdrgd3satxjBV3ojC7ZAFR+/cP1L7jYTr1bDk2cDRRKW/RQPO77s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Dh5zP/kg; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9483:13a:c452:d5de:4aa7] ([IPv6:2601:646:8081:9483:13a:c452:d5de:4aa7])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60JGNmSu3000758
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 19 Jan 2026 08:23:54 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60JGNmSu3000758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1768839837;
	bh=B6EBCcb/A+jpCTV7wUZd9ozCdOaEJiKaLAhpQvY32/w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dh5zP/kgU7cp3//sw9pZpkZMWqheNy2V2d8Fwn6ZaXGpuFEkFpqPpsUmVviF4amWD
	 jf4NyOuG4oUVezfXUwS4A4ezntRl4jI6x1xhNdaDYR63e9xXu0PaNHlhGn/TG/gMM9
	 lmdwTBoCO7f7yNRHHcWU2LANjyyCe97IFJY/WU5XpL4huhe6OcENbvDizvzLPkj3Wx
	 PWWOR4PFVP1n5UIqYjGAc6utr/cx+OR83eYj+A3bmowqXOnWt03I4cK5JcNeKueiHx
	 4wULyH7u5B1n9uesePTkKPKk7T4Z5VcTnevqpHvzLgDEKbCHYqJwed4GIvnaRkADIv
	 7tM7HZ4EWuFrQ==
Message-ID: <7a4fa7ce-3590-4ece-931c-17ee928595e8@zytor.com>
Date: Mon, 19 Jan 2026 08:23:42 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 3/3] x86/hyperv: Remove ASM_CALL_CONSTRAINT with
 VMMCALL insn
To: Uros Bizjak <ubizjak@gmail.com>, linux-hyperv@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Michael Kelley <mhklinux@outlook.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20260105090422.6243-1-ubizjak@gmail.com>
 <20260105090422.6243-3-ubizjak@gmail.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260105090422.6243-3-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-01-05 01:02, Uros Bizjak wrote:
> Unlike CALL instruction, VMMCALL does not push to the stack, so it's
> OK to allow the compiler to insert it before the frame pointer gets
> set up by the containing function. ASM_CALL_CONSTRAINT is for CALLs
> that must be inserted after the frame pointer is set up, so it is
> over-constraining here and can be removed.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
> v2: Expand commit message and include ASM_CALL_CONSTRAINT explanation
> ---
>  arch/x86/hyperv/ivm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 7365d8f43181..be7fad43a88d 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -392,7 +392,7 @@ u64 hv_snp_hypercall(u64 control, u64 param1, u64 param2)
>  
>  	register u64 __r8 asm("r8") = param2;
>  	asm volatile("vmmcall"
> -		     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
> +		     : "=a" (hv_status),
>  		       "+c" (control), "+d" (param1), "+r" (__r8)
>  		     : : "cc", "memory", "r9", "r10", "r11");
>  

Looks good to me; I'm not familiar directly with HyperV, but vmmcall is a
system call-type instruction which doesn't use the stack.

Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>


