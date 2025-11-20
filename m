Return-Path: <linux-hyperv+bounces-7718-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C43C756B5
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 17:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9D6973525D6
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00DD36B053;
	Thu, 20 Nov 2025 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdExhGcO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE9036A03E;
	Thu, 20 Nov 2025 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656283; cv=none; b=RpcKec9g/VYTrY+KXiiLi1Gyxb/ojB3oLC7u9kwsW3KwFRgxXoGA2o72kHCtavW3052PX0Ubol9GR0A4ZnYKfxfZC0yyUZ3HIATFhoksNsjUWYkz8Hqvf/WuKozYqq3WP2aNivCgAU0kztBIG2wAmMK/ls3nGxdg8XQkcm5S7T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656283; c=relaxed/simple;
	bh=2CrS2gfWoeZnSOtpz16jbbv3L/NoFagwPWv505wSGw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAaElE6XeQGAgJSXMWJB1XM20iDYSK0eRnoV56+NV3zD1MK1gW4jnhitOut+/sIQKyq3KFQW1HDIQR3xKZ7sivHHY0rV+mW+6WIs814IcQ21+fAPfLJuC3mY55lKkS/3Ujujx8rmbehgyh2MinXbndeaiDN++T4aw7SGQfNK9lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdExhGcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B58C116C6;
	Thu, 20 Nov 2025 16:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763656283;
	bh=2CrS2gfWoeZnSOtpz16jbbv3L/NoFagwPWv505wSGw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IdExhGcOvHiczH3NH7mnsOZjEIF5Nj4C9u5AZyooJgsjAFcDDEIfYcRBi6CaBgYDn
	 Frg7HdSSk2/GTffiS4yu3eILH89vJk9tEGTxWwoU/TPq1WvNGn+FZA5y3NshMNVCLv
	 piVhEidPsV+pe9umrZoW+xKw8uyXGDqLiHzkiFpVw/OTpKnFVP+jylNrNa3OIKFKcd
	 D+NJWVkWI1yCBGXo3WJZFxthmrPV8o6I3/oaiWVNIz8oJo0+TY4HMgQeQ25ZyVcrk4
	 gvvQi8tA0Fvog7N+29vqDjAQBB5QUfboxtBuZnqe8ysBlagi4QqLfu9gTpRlwAF8gu
	 9n2fnbY7ZucRQ==
Date: Thu, 20 Nov 2025 16:31:21 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 3/3] x86/hyperv: Remove ASM_CALL_CONSTRAINT with VMMCALL
 insn
Message-ID: <20251120163121.GB3330456@liuwe-devbox-debian-v2.local>
References: <20251120134105.189753-1-ubizjak@gmail.com>
 <20251120134105.189753-3-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120134105.189753-3-ubizjak@gmail.com>

On Thu, Nov 20, 2025 at 02:40:24PM +0100, Uros Bizjak wrote:
> Unlike CALL instruction, VMMCALL does not push to the stack, and may be
> inserted before the frame pointer gets set up by the containing function.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>

Dexuan and Tianyu are more qualified than I do to review CVM changes.
I will defer this to them.

Wei

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
> -- 
> 2.51.1
> 

