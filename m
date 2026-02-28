Return-Path: <linux-hyperv+bounces-9062-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id j7RMAqS3omnD5AQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9062-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 10:38:44 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C8B1C1C59
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 10:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C5DB303EFD2
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 09:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581F23D6497;
	Sat, 28 Feb 2026 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbQnCbgH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6208184524
	for <linux-hyperv@vger.kernel.org>; Sat, 28 Feb 2026 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772271520; cv=pass; b=olLM7wEZCxr53KgqicWzbZgQH6C3SWuA7chbV3v3qsMW5//2YphoSCPmRybqVpJYiP2cslet6h6AD2GtKuDxHmFuRbjjkZaWhayuoUMi/gNAQZq9zjL82IJcCbF+pfL4Kiei7ngHjQm0xU4ysgO35/HVnMoN617IcuKtQj0CoJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772271520; c=relaxed/simple;
	bh=MmlZWErpRuwiFfltAZpswt98axqnS0yrVaC3QKMHFvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taVQ3y11cy4bTk1MWK17XSAhCyQ2D5GpWq3na+N8lKGlWEmVqJCVCjXeJJ/hsxzaHxfQNlrL+5FovnU/KPxBWRo5oJ884cht0T1fNFZ0ZQBrkG39mYA1+wxXQGZ28T6wXi9QrxDD8DqR7Qf2qQ3N+Bc1jzsPOY+HJ7MBvZ0q5YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbQnCbgH; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-389fac627c9so36195541fa.0
        for <linux-hyperv@vger.kernel.org>; Sat, 28 Feb 2026 01:38:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772271517; cv=none;
        d=google.com; s=arc-20240605;
        b=dmjhM/hlbuXuQKf0DkzRUBz5DJzN7+wolazOWHOVAr7uV8j98J75o5XCK1j+GwZfr9
         KSa4cWIHO4+91aG7dbcTmp+Sz1BNGGvBzr2r9axOUcXzOZRQIxO9f4uxKG9lziN+xOX/
         pLK5AdnEHZUKBEvD9BJZ/mVriO6Wxwi8cc2ATfsjqxR+aFbLUVmiltK+SoCtShKIyxVC
         G1VHVebSCQZkLWGKs3B8LwIlTVsmattGUjnyXbv4s4Oq9VWDs2PIqYG+FksSe4bYK0PG
         70iYXPBAb5IcOs6JtXuq5rqNz8SQJLsOZwIMr1enh7f/sX6a6zBH7Dwx7IYHam2lbzrF
         VJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ajlrrrrtkTikLP4/66BBf6nLX/fQEzco8taOtRBsOs4=;
        fh=LGhH/XBV6mfdqIK9OK2GQ1EeAVThQ4EAtk7Cv4Gke44=;
        b=UxnSKf/UZZeQZP7VinqDgt9Pb+vmtft5UmcMzssyeVKG/EgjBQjAjsuKtT3/UxoGzr
         8GIpmffUoQ75B5sh2PtKpk5wUJ160HJ0Ybngb5Of1tatutbEtdX2Eowg6zgvPCn9UK+V
         Mqo/Sf7hxjVPi70FMEJnTRJK0ToY2oXajFR+qJDzByfK49wm3AFZHoCM9xZrn5p7+ANe
         HgN8t2wBuleq3DwzstSCvalyAYBQON9u1oOlkriOMvYlH6am1Kbvy5C242MJG4eiooYN
         uv/YQpYNOYgR4TufCt90hAlZjQrhQv2qS8kadzsqfcaW9K/f52f15L2sXe1ZaJeHAzUo
         HEJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772271517; x=1772876317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajlrrrrtkTikLP4/66BBf6nLX/fQEzco8taOtRBsOs4=;
        b=NbQnCbgHwcwiorPn7hthZqGLnnF+TBODXCFUDgwsC6nNzcIMxsrPWDegjHVMrjBKLr
         LWKz0CLyG6yECN5Qr0GI9UwdqR6TIrMpe+RXwo0QO/YRH7grpWOljID8+ERJUxDoAe6S
         nr/Xr8LZMHytAGLZv1fjf7vPTGqpr8VNpDI3j58eyJdl1TWUqYbSJsa8q0zaRjv8uf2S
         GzSOTrebajUPCucUg8u3ds+7WeWlKhBGChIYs931hVXm70hsnqr5y+UAtyGJQoUkkgLh
         nEQKSg1YDJ18ZLMVvdMt4StAgfGTTS73q8dcN+19apWZmSM57Ztjz3pMM9FUJlJfH9mB
         OxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772271517; x=1772876317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ajlrrrrtkTikLP4/66BBf6nLX/fQEzco8taOtRBsOs4=;
        b=ALbmDfNgdYjCtXuaGPa3d9z1km2D1I4lJMxEIu5zP1ogEw6pGGm1DE9a/EGF4ScduY
         O5aJfjvIwycGTBuPPJ+m49+gqF70w6pyvQS2tH5nzZlvVxN5F9/0EU3ma4JSqIPvfkfN
         Q3jzx2UH61+yLV4Fxs4RmW/DU8uhnIcHrT+a2PZ1Tba88lamuQIvIPpPpIHTvXYdo9Tm
         sWmnliMAv+TyJFBcbSIgd1mjVlJpIILg6TNDENK2dC8WsWUOVVjmcLCE/H99J/+hAyRH
         1b/HbCnHAUk1qCkz/L8pi6pigoWdC9BS7VLc+dxbLJuuUqPxOFl87Cgrw05saB9/5Dsw
         H2CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlE7J/sitt1Ls3J+eWhyut0mg7hjdrF7IWfHY+Y89EKx3qjfvv6F72LeADmVW7cUxHx3CAnSQDfN3PH5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk99pUyBom3b0dOp538P9ZIur8YBTNTCQJBZxXSZZQiV6aIWEM
	a7OLWftUia39hOLOW9GsPeIlymJCBKOCltBFULvCU36YU22TJNrS62l20UMhCZyBdbd4s035nwE
	E8pt2T+caXcPI4g+5doqKEChN15pD7LQ=
X-Gm-Gg: ATEYQzxiEYO3mfeDBowytZKcR4ZtBm9djBf/bNmj2P2d/xZFvxXnQVIKfKXbBRkD8/E
	bPJCjV0Px/JS1ID/2B4aX2K55LDl9C5bX/i8rmbtn5NndcTzQg2C0OlGzKkng1314ByGL9dHExO
	AcIa4gH0TZNBuFgzNXbCWVpVXQEHA3HjollrXRlWqEsYjZ8LYyrjO+g9yePwWASBFyu2tV3mbiV
	mFhWts7KEySvTY/SKzkahuqJW755G/YujU2O4xqnFNmXQbLfJLNnnVJkzxtdy2M/I1Xk5SsX1ei
	/KHaQQEYbgVKT2lqabRnuMx7Wyarkiju3ddQMTp/zvra00tcK8lxP4iNZWuvG4M4RVlyBIEfXGb
	xrgxy3+S2IWKlscc2RK1tsgcRkORcr5s9
X-Received: by 2002:a2e:8415:0:b0:389:fc65:afd1 with SMTP id
 38308e7fff4ca-389ff350c65mr29295801fa.24.1772271516737; Sat, 28 Feb 2026
 01:38:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227224030.299993-2-ardb@kernel.org>
In-Reply-To: <20260227224030.299993-2-ardb@kernel.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 28 Feb 2026 10:38:26 +0100
X-Gm-Features: AaiRm50zCyMW_GMzGe96ARN7wDZ6GNvBfujN7gjhkglo9qIlEZ2QA4nWwiu4BUo
Message-ID: <CAFULd4ZYiSWciqo94yaLvB43z_+jqgXa2gy8DOEQQp1W8yFF0w@mail.gmail.com>
Subject: Re: [PATCH v2] x86/hyperv: Use __naked attribute to fix stackless C function
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Mukesh Rathor <mrathor@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9062-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ubizjak@gmail.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 57C8B1C1C59
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 11:40=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> hv_crash_c_entry() is a C function that is entered without a stack,
> and this is only allowed for functions that have the __naked attribute,
> which informs the compiler that it must not emit the usual prologue and
> epilogue or emit any other kind of instrumentation that relies on a
> stack frame.
>
> So split up the function, and set the __naked attribute on the initial
> part that sets up the stack, GDT, IDT and other pieces that are needed
> for ordinary C execution. Given that function calls are not permitted
> either, use the existing long return coded in an asm() block to call the
> second part of the function, which is an ordinary function that is
> permitted to call other functions as usual.
>
> Cc: Mukesh Rathor <mrathor@linux.microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Uros Bizjak <ubizjak@gmail.com>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: linux-hyperv@vger.kernel.org
> Fixes: 94212d34618c ("x86/hyperv: Implement hypervisor RAM collection int=
o vmcore")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> v2: apply some asm tweaks suggested by Uros and Andrew
>
>  arch/x86/hyperv/hv_crash.c | 79 ++++++++++----------
>  1 file changed, 41 insertions(+), 38 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
> index 92da1b4f2e73..1c0965eb346e 100644
> --- a/arch/x86/hyperv/hv_crash.c
> +++ b/arch/x86/hyperv/hv_crash.c
> @@ -107,14 +107,12 @@ static void __noreturn hv_panic_timeout_reboot(void=
)
>                 cpu_relax();
>  }
>
> -/* This cannot be inlined as it needs stack */
> -static noinline __noclone void hv_crash_restore_tss(void)
> +static void hv_crash_restore_tss(void)
>  {
>         load_TR_desc();
>  }
>
> -/* This cannot be inlined as it needs stack */
> -static noinline void hv_crash_clear_kernpt(void)
> +static void hv_crash_clear_kernpt(void)
>  {
>         pgd_t *pgd;
>         p4d_t *p4d;
> @@ -125,6 +123,25 @@ static noinline void hv_crash_clear_kernpt(void)
>         native_p4d_clear(p4d);
>  }
>
> +
> +static void __noreturn hv_crash_handle(void)
> +{
> +       hv_crash_restore_tss();
> +       hv_crash_clear_kernpt();
> +
> +       /* we are now fully in devirtualized normal kernel mode */
> +       __crash_kexec(NULL);
> +
> +       hv_panic_timeout_reboot();
> +}
> +
> +/*
> + * __naked functions do not permit function calls, not even to __always_=
inline
> + * functions that only contain asm() blocks themselves. So use a macro i=
nstead.
> + */
> +#define hv_wrmsr(msr, val) \
> +       asm("wrmsr" :: "c"(msr), "a"((u32)val), "d"((u32)(val >> 32)) : "=
memory")
> +
>  /*
>   * This is the C entry point from the asm glue code after the disable hy=
percall.
>   * We enter here in IA32-e long mode, ie, full 64bit mode running on ker=
nel
> @@ -133,49 +150,35 @@ static noinline void hv_crash_clear_kernpt(void)
>   * available. We restore kernel GDT, and rest of the context, and contin=
ue
>   * to kexec.
>   */
> -static asmlinkage void __noreturn hv_crash_c_entry(void)
> +static void __naked hv_crash_c_entry(void)
>  {
> -       struct hv_crash_ctxt *ctxt =3D &hv_crash_ctxt;
> -
>         /* first thing, restore kernel gdt */
> -       native_load_gdt(&ctxt->gdtr);
> +       asm volatile("lgdt %0" : : "m" (hv_crash_ctxt.gdtr));
>
> -       asm volatile("movw %%ax, %%ss" : : "a"(ctxt->ss));
> -       asm volatile("movq %0, %%rsp" : : "m"(ctxt->rsp));
> +       asm volatile("movw %0, %%ss" : : "m"(hv_crash_ctxt.ss));
> +       asm volatile("movq %0, %%rsp" : : "m"(hv_crash_ctxt.rsp));

Maybe this part should be written together as:

      asm volatile("movw %0, %%ss\n\t"
                    "movq %1, %%rsp"
                    :: "m"(hv_crash_ctxt.ss), "m"(hv_crash_ctxt,rsp));

This way, the stack register update is guaranteed to execute in the
stack segment shadow. Otherwise, the compiler is free to insert some
unrelated instruction in between. It probably won't happen in practice
in this case, but the compiler can be quite creative with moving asm
arguments around.

Uros.

