Return-Path: <linux-hyperv+bounces-2652-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FA59452F4
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 20:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18BED1F24026
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 18:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D0D143890;
	Thu,  1 Aug 2024 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T/C0X9lw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56708143881
	for <linux-hyperv@vger.kernel.org>; Thu,  1 Aug 2024 18:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722537722; cv=none; b=CYAYDhU4vXBzSOV9aV+j1Nl2mq4D1W726t4vMyipOMV7hSL4SqCBzyRMYtNsqJ3o0kObFbvpgkwYm6uJEjdOjDBXusQGuyq0cSmnmdHiTqigqMJT44A5Vc+20U83C3KwbVgQan1b64GFjZsG2nx3eiHVwQ1AFB7l3y0tDG1cMtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722537722; c=relaxed/simple;
	bh=F6QdRkOl5AWI8fGo8VS4KcvJrqS6q0UPIRQhYRHjBfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9JLwf4LZZd2feJZU93y5RYLJmX/MeYVFbK7UwVmDsDKxeZ05VsSuj6OaYDNRj9at2E5kfwAz3z+JM8Mrb/FLJbPJaVyq7pe56yZlMcT1WpXTD+q9YLX28M3qH5VxNmFYt6zBFYwmwvPqYaBOV0d1YJMv7ROTTOUnVeDM/sY5UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T/C0X9lw; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so987000366b.2
        for <linux-hyperv@vger.kernel.org>; Thu, 01 Aug 2024 11:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722537720; x=1723142520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0zloXG4c1DuZ73aaeymRnYQY+WBO9Q0AgaFbjPg6Tc=;
        b=T/C0X9lwGLdhip9xUpAS6P8fQHv3jnurSGwLhJ2Txd4qX8c73q6wHDeny11VZNUvgd
         nAPAMoJOB8Lxc2ff3fwel72uN/mHzWGVfb4AyFNQBb7096lC+DV9ghs93sunOGVnP+vY
         6Stuk1awsE6wBopCI4eQJf1aZyl9FyFgowqsTO5kgnshpHCOflUmJgNB0sgCld0Gh8iN
         wlpIRYUzgoVday/KrnLxs8kTUaTPOz+xXoIy5UmZzcPPms+sdWYSLzYrIgQwZEvsUxdI
         sFde9eNeTvQgY3zZLpgLxhmUcK7wt40etPs2ppRscazO5gs7pA77ZG/VPaNHo2cYbW8/
         gCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722537720; x=1723142520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0zloXG4c1DuZ73aaeymRnYQY+WBO9Q0AgaFbjPg6Tc=;
        b=wSM/p72KL1xxfyMF6OpX6Rm+YsY0UDzI4ZqlaQWdzCfIYhHjhS4TTMms+lWqaSKVFx
         Isk9SkG/ZJEtkeyOd6jLKMqfxt3pdyl3WpqOBEYGVR/nBJQOv5MaZ24KtBQm0SnBG/gQ
         2DOq4rfEmMJ8TXqGiEl5DOT27TbhlmgYT1i1SGj+DmA9VrBUVPeHySJ8f5GJBlwkZLAi
         rZ0IFDiW9T7dh1215Vn8g3BDMCdz/PaKEaGLnpaOOlyiGFppyNjHnNvKX7JTuvfWmjDg
         P7G0yELjJHdW3Zsgvvl4oT6590l985TrzU6e8bRb0LZd2QAvyxMx6YmQ8cGtwYc/fOlm
         yxCg==
X-Forwarded-Encrypted: i=1; AJvYcCXSIKRm+UtE0yp8iP1EFjyQEX/JUK6BoQHLThTHFecPVOoAGMdycGrq12ctanR6+Ixg5NkA8UVye1+cMCGLbVJgaAYZZQ5TyCQRptrT
X-Gm-Message-State: AOJu0Yw38MDyzBazci49mh0b3Z4RMmt+01rvvV8h0GrTM310O7xo+Er9
	tCae00gcYhnNZXcLP/Xl2TyDrRMD7AuShKaqWTC9dvzTHN38dxfQp8FcEnjZG50mPyWykD2/6ob
	jSrBHV7kNGnjZWQEN00F/eJPXVm+tuR/22U8u
X-Google-Smtp-Source: AGHT+IGPifr5Mhm6dV9PXMUjGQq4gKMxF44WTMfRvoFqEls+6CjXe1wvoMQaKet1wGioGpuGkHoRSrjkvlZ2B5uneq0=
X-Received: by 2002:a17:907:9801:b0:a7a:c083:857b with SMTP id
 a640c23a62f3a-a7dc5070469mr79656166b.42.1722537718951; Thu, 01 Aug 2024
 11:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801183958.2030252-1-yosryahmed@google.com>
In-Reply-To: <20240801183958.2030252-1-yosryahmed@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 1 Aug 2024 11:41:23 -0700
Message-ID: <CAJD7tkbkayNvptAR8fNwd-p7bLcxhV40TfkEUGQYYK1N=_VFww@mail.gmail.com>
Subject: Re: [PATCH] x86/hyperv: use helpers to read control registers in hv_snp_boot_ap()
To: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 11:40=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Use native_read_cr*() helpers to read control registers into vmsa->cr*
> instead of open-coded assembly.
>
> No functional change intended, unless there was a purpose to specifying
> rax.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  arch/x86/hyperv/ivm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index b4a851d27c7cb..434507dd135c5 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -321,9 +321,9 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
>
>         vmsa->efer =3D native_read_msr(MSR_EFER);
>
> -       asm volatile("movq %%cr4, %%rax;" : "=3Da" (vmsa->cr4));
> -       asm volatile("movq %%cr3, %%rax;" : "=3Da" (vmsa->cr3));
> -       asm volatile("movq %%cr0, %%rax;" : "=3Da" (vmsa->cr0));
> +       vmsa->cr4 =3D native_read_cr4();
> +       vmsa->cr3 =3D __native_read_cr3();
> +       vmsa->cr3 =3D native_read_cr0();

..and obviously this should be vmsa->cr0, forgot to regenerate the
patch after amending, apologies.

>
>         vmsa->xcr0 =3D 1;
>         vmsa->g_pat =3D HV_AP_INIT_GPAT_DEFAULT;
> --
> 2.46.0.rc2.264.g509ed76dc8-goog
>

