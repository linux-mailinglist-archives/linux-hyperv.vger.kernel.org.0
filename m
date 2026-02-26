Return-Path: <linux-hyperv+bounces-9003-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE0hGWEioGkDfwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9003-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 11:37:21 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 105991A4642
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 11:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1391D3053E08
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 10:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4BB3A7F5F;
	Thu, 26 Feb 2026 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9DU13/U"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF913A4F26
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Feb 2026 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772102165; cv=pass; b=D/Zc0IcEzyUM1Pb5xBgkNZxAPiy2TwDDnCZ7SPPIFvnd97f1XUMH8vSJ03cPfp9PumheBcD+zt6huJNzCPSoGx5VT3WwYoC4J43oD8GV529SFUlzEmlegFinvYQ1gafZJPpnVovOCN9NKIRFoh3gPiV5m7DTwfcidHv+yxWrdJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772102165; c=relaxed/simple;
	bh=pTNa/NZCRar4kGtG1tsu3/hY0gi61rYM+1Yzlyyuu2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIHV+6iUjZz3ZIDFxvq6r/8v9/SNuubUt58NzCaMeFEBte+yieIJXSeP1cxBMjD5WaEFZwd0YZbdC9MP6ylYYZxaa+2ekfM9ISuDkTsYUWkl4nbawm1yiOuK3ibHDBDDPI49Wya2KsxBZpr6g9y5bFTZ+nbdyKoLbuQEp0k0DPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9DU13/U; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59e63b427aaso828628e87.2
        for <linux-hyperv@vger.kernel.org>; Thu, 26 Feb 2026 02:36:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772102161; cv=none;
        d=google.com; s=arc-20240605;
        b=iCgMi0lO2UihwYmnqJKITX81FSasxmQxT+qExhIOsEZuloUKIYHRwb479ltWHrhABS
         CoIkeupbwrjsmXsPcHW48rEM6jJTD7BnonM+aTUOVQWUgchqyAHQ3YKc62xOCDYrOAjy
         5cRsHftFzSbZYFMlxJWsIMSNF9TWt2d1YxrH/nzAFF7eVEOdz3QFvs2UxapObijNRWg8
         3HwVEQbzBecxFjKuXhQhXicEooxDu/KvfNrspu/VFh+B8g/HyGzeO7Unqf3L5Hgwd62x
         3WExWMKN6UJ7lzBRCP00sL2oCIAPXunsBGLjX5+lqM2RjVvBBI99lbvvbRc1samTLeHx
         jMuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D3yMqxnHlvmjhe1KC+ZwUPjfHj2iXeuHDsPStqdArfc=;
        fh=yaJYPNZ3w0WkKb+5rUiX1qJmkPc89AbKsGXmXsWQOoI=;
        b=dwZquKLHkOZkI1NthWJlMXwvJTOURbEz68vwowI9TnDWqvBt9O+uh4xAs5b+nVYujV
         US7JtH8gF64zLP0H0gUlQILzBW61/7vsN9BWHVt3WO2mDXZotKW462N8WtJhM1c98T6d
         BvM0zix+hPO9MrQMCCIuC4xvcYGZV2rEbbIsW06Ac07Yp+edZ6wEDi/z2KYu3jHJjPqJ
         vB10u8ukHcq5Hm3ZIq6DxHuM4ygA70OoZcJhJzH0kYVk5XXeyaPe5mk100ff6l+dto1+
         Oxc7fLoIGGmCfPwjesABKs34zIi2O9w0ScvlNKuHt2SBieGozwM5oyAHaPlLot9Hn5OJ
         b/iA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772102161; x=1772706961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3yMqxnHlvmjhe1KC+ZwUPjfHj2iXeuHDsPStqdArfc=;
        b=j9DU13/U1Tyv+xE1ZHSeMQAKbd8N3t9tnA+jMYeV7ilMAI/V3FdHAqaz7E4tgS5fOL
         ZFSbRPt2/j4agfzkKwJsL59UTarKGV6HZ7EYIMoRK+eQbw9fv7MuBbaDRA2H/YHXGmxg
         UfxTfpKxsaTL+9BKS5HTP3aphlO+e8Y9Xe2KxnVISi26rITqYc1XI3xLIHaun9OrntGf
         +m5FlJs9EsccG3eFlVgzLZ8WTJJ1n8uFlN2lrLfVbw070XLm7roQpsfjxxGW5eqr4XM5
         pGXMnsqVZrVo7pP6EuDCxNJ3QmjUkZs5rnvctvh8zhdvYZDk00dM7zZ2aWxx7/VWoENt
         lMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772102161; x=1772706961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D3yMqxnHlvmjhe1KC+ZwUPjfHj2iXeuHDsPStqdArfc=;
        b=cu4tYNeH4K66gHE4YVy/K2BnPuzR6TbtTX1p23jM6LDDdAygzGE64/aXe+BGiLFp8L
         /MIm1Gxxd1+Atzf+R4+HquvXoPsGGfqHojfmFO7pIBLJAygyo7vDbEphFJph4RD/e36I
         wYuEvdx+EZZKNyz9DIqMa2Kxvuby17xVQwHRVVqSaSJRMpUqGtv5SlC1VyM1xbSFpG3J
         3UNySHt1eGWChzkmecEk2n2YNerH5yecJg+37evSE4ULu94MOxCwaFWrWiuuSCAmrrKQ
         6y8TJ1mo6sETczghWIlMx4EMHUjhtI/rApQKN8kXVyNTdADpMONCSwEtq6GdkNBhajPg
         Vw5A==
X-Forwarded-Encrypted: i=1; AJvYcCWABMsKGaoKNIK6ylh16DgqJk6kdghQN/Cs2SbW10wbN9ekyBkBauqr4xOwZR/hXw+xaTjwdVkYS7612Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrTFEC9pcE//8rTlWDbKk4tLlBWc9luzDa0v0LVwA9IPbaoSIs
	jNc8hxSg3VZvX8cY9lfleSaZUjY2E/lIyDc+D3ly+uDqIbppshXCoo5eglf4M66H5nTgoGjOMmf
	ivazM0sJeL9P3XFY3wnYH4q0xVMNmfU0=
X-Gm-Gg: ATEYQzxcG7y/34vG2yWfaGj52Njmbd4jPhiPxSXuy+Eriq4En2gxgWFteQVaGeYYeJ5
	qGN6Ca296Qq+MTUi+UDcYFGE2MaIFbK69e8Z8gbfCSxjE4DjqiXSoFxhKI+V6c/BT3ccWNh7sRk
	eVDYkF7Z8fplIP9GHxw2wCh1WPUrdRy8oKA+HRijnTNnbp5uouHpdY8Aq3x0QofXczqSrRTghle
	St8DOT7bDRkJ12HfanSEl7mu9rV2+CZtV/TE6xuCY5rod6vMoo6LTQvW8FssBt/2fhioi++QXef
	ssqyOAHWn/Gy8crH99Rozmvnf5BAswWvdSZijLRd5Xj8ZZ67blUmeQ98p5bylHXeKP/ECz/mcKn
	4VlurK0hCMTOcn5X4hpNHdgoZQXBls1SFtKw=
X-Received: by 2002:a05:6512:1151:b0:5a1:d06:56c with SMTP id
 2adb3069b0e04-5a10d060646mr358978e87.46.1772102160741; Thu, 26 Feb 2026
 02:36:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226095056.46410-2-ardb+git@google.com>
In-Reply-To: <20260226095056.46410-2-ardb+git@google.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 26 Feb 2026 11:35:48 +0100
X-Gm-Features: AaiRm53HCz9a7KTrzyViBatn_mko3SNXaPDOiBcQshPmkJDW9Z1yji6dYCW-c_s
Message-ID: <CAFULd4aSAdKV7XtASr_uQz5hA4qBbWeO-nfgKb979HkwZDbQ_w@mail.gmail.com>
Subject: Re: [RFT PATCH] x86/hyperv: Use __naked attribute to fix stackless C function
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Mukesh Rathor <mrathor@linux.microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9003-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ubizjak@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,git];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 105991A4642
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:51=E2=80=AFAM Ard Biesheuvel <ardb+git@google.co=
m> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
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
> Fixes: 94212d34618c ("x86/hyperv: Implement hypervisor RAM collection int=
o vmcore")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> Build tested only.
>
> Cc: Mukesh Rathor <mrathor@linux.microsoft.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Long Li <longli@microsoft.com>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Uros Bizjak <ubizjak@gmail.com>
> Cc: linux-hyperv@vger.kernel.org
>
>  arch/x86/hyperv/hv_crash.c | 80 ++++++++++----------
>  1 file changed, 42 insertions(+), 38 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
> index a78e4fed5720..d77766e8d37e 100644
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
> @@ -133,49 +150,36 @@ static noinline void hv_crash_clear_kernpt(void)
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
> +       asm volatile("movw %%ax, %%ss" : : "a"(hv_crash_ctxt.ss));
> +       asm volatile("movq %0, %%rsp" : : "m"(hv_crash_ctxt.rsp));
>
> -       asm volatile("movw %%ax, %%ds" : : "a"(ctxt->ds));
> -       asm volatile("movw %%ax, %%es" : : "a"(ctxt->es));
> -       asm volatile("movw %%ax, %%fs" : : "a"(ctxt->fs));
> -       asm volatile("movw %%ax, %%gs" : : "a"(ctxt->gs));
> +       asm volatile("movw %%ax, %%ds" : : "a"(hv_crash_ctxt.ds));
> +       asm volatile("movw %%ax, %%es" : : "a"(hv_crash_ctxt.es));
> +       asm volatile("movw %%ax, %%fs" : : "a"(hv_crash_ctxt.fs));
> +       asm volatile("movw %%ax, %%gs" : : "a"(hv_crash_ctxt.gs));
>
> -       native_wrmsrq(MSR_IA32_CR_PAT, ctxt->pat);
> -       asm volatile("movq %0, %%cr0" : : "r"(ctxt->cr0));
> +       hv_wrmsr(MSR_IA32_CR_PAT, hv_crash_ctxt.pat);
> +       asm volatile("movq %0, %%cr0" : : "r"(hv_crash_ctxt.cr0));
>
> -       asm volatile("movq %0, %%cr8" : : "r"(ctxt->cr8));
> -       asm volatile("movq %0, %%cr4" : : "r"(ctxt->cr4));
> -       asm volatile("movq %0, %%cr2" : : "r"(ctxt->cr4));
> +       asm volatile("movq %0, %%cr8" : : "r"(hv_crash_ctxt.cr8));
> +       asm volatile("movq %0, %%cr4" : : "r"(hv_crash_ctxt.cr4));
> +       asm volatile("movq %0, %%cr2" : : "r"(hv_crash_ctxt.cr4));
>
> -       native_load_idt(&ctxt->idtr);
> -       native_wrmsrq(MSR_GS_BASE, ctxt->gsbase);
> -       native_wrmsrq(MSR_EFER, ctxt->efer);
> +       asm volatile("lidt %0" : : "m" (hv_crash_ctxt.idtr));
> +       hv_wrmsr(MSR_GS_BASE, hv_crash_ctxt.gsbase);
> +       hv_wrmsr(MSR_EFER, hv_crash_ctxt.efer);
>
>         /* restore the original kernel CS now via far return */
> -       asm volatile("movzwq %0, %%rax\n\t"
> -                    "pushq %%rax\n\t"
> -                    "pushq $1f\n\t"
> -                    "lretq\n\t"
> -                    "1:nop\n\t" : : "m"(ctxt->cs) : "rax");
> -
> -       /* We are in asmlinkage without stack frame, hence make C functio=
n
> -        * calls which will buy stack frames.
> -        */
> -       hv_crash_restore_tss();
> -       hv_crash_clear_kernpt();
> -
> -       /* we are now fully in devirtualized normal kernel mode */
> -       __crash_kexec(NULL);
> -
> -       hv_panic_timeout_reboot();
> +       asm volatile("pushq     %q0             \n\t"
> +                    "leaq      %c1(%%rip), %q0 \n\t"

You can use %a1 instead of %c1(%%rip).

> +                    "pushq     %q0             \n\t"
> +                    "lretq                     \n\t"

No need for terminating \n\t after the last insn in the asm template.

> +                    :: "a"(hv_crash_ctxt.cs), "i"(hv_crash_handle));

Pedantically, you need ': "+a"(...) : "i"(...)' here.

Uros.

