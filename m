Return-Path: <linux-hyperv+bounces-6442-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9391B15869
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Jul 2025 07:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05FB27A9B3A
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Jul 2025 05:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253901E571B;
	Wed, 30 Jul 2025 05:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vg2RwPmn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E481E570D;
	Wed, 30 Jul 2025 05:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753852569; cv=none; b=oGd8Wo0xYUTt9fdy0DKeFrJGm9+kn3yip2mJUlOgl3Ejm7Xodf86h7pVy48L/erkTwsDnTS7GSKVtg877GH8YDwD1iv7eR/TehS39pWmkD/LYN92H37ou+iCYNIDGUbLWw3YU5eOj0VBBQDDIlvSunavgZurxDVsAsEUrtRdUCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753852569; c=relaxed/simple;
	bh=v38Oh17/JGHcivGVKy2sckjh/J/d77DhoOF+ja2ZXG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTx4v/l9KIMo6lqpkOjicf9kvmb9BppPkoQQKQyYmKut8wr7eq8mfuMMNfRGPCekn1mhueoqJ6ao0NhCOXlaGEP+VUgdrTTAOnnSla2KIc9PxjnZHXWIgilxNi0nSCfhtZ7e1caTbitbFQTCvYkp+4Gj2Mt3HuOc4x4qGexmTVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vg2RwPmn; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24003ed822cso20796435ad.1;
        Tue, 29 Jul 2025 22:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753852566; x=1754457366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9Fh26bF3MqXUV2HfzEAs7u0sxYZEa/PtdeN7DPnQSI=;
        b=Vg2RwPmnONaz2MTVjRahVX27UH4l94kv/eFMcIVKmSFF4X1laW6xSWFw6iippxANbk
         +CNRHakUMjWB7YBDJvL2C7PK2e1xMlhs2SVyfOtEQBBxaOL5DLsVvypjdJr4KYDC05hG
         ZOn+O6jtLe1Uc6mgtnDgCtdISGgj2iu4cMy5uB0fAzAuBplPPGnAHHPRHVnyjqZUgyW8
         UnqEpG+rNrZYbD+Gz9woRh6KJW4Y01nwLP28Np9cBEYelVODgOuOK+Dex+8lZhxLuAWO
         +9rhD5UrsY5oJN30MKLCr7XNORNUxRoJGYjqU50/cUexmiDJD4CWfDtj2cTEaQluAprh
         IVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753852566; x=1754457366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9Fh26bF3MqXUV2HfzEAs7u0sxYZEa/PtdeN7DPnQSI=;
        b=WfPuM05fw9Ig6mKN+j9WvcRtfohT5gRUlF246sMF6eI6FzlatN1OvSnpSiSUyeUh5t
         8soL/hYWuJSjk9OG3gEJU2UGnyAEF71OfM9r54piqhmwxcCpGihOED61wuQzo5d/8KYe
         PBgjrM7O8D+MT5eR72MUc2rTLO3zYtbN/1TOcThh940SZwJC95kxXusa9BqctJFI7BJy
         rsJIUJQle92c7f/YhFxpbM7ll5X9nbEOFLU1nd6Rl+leroxODA/CecePD+we/pWFg5I3
         3D/bvKsyTgYk2S4Qu9VbsvbMLCkzojv/5th0FIuyPaFVPoxX2pN7edYjgmOCFr51xyPm
         pmgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxWblbPe4TOvnQqzFbp8h701xUMz9HOi1vUJr7/jKzRpRLmbaA6UcZ0qx1xl26qtc4CrX//vUgKq5DfqjR@vger.kernel.org, AJvYcCWxY9W+qVn9frJMTmXutWFcQiQgtv2u5QJCepInYn0R/Ijv8cFWvzaIIxd1OwWc8zrMLG6HCKCQ22bWf10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOwIJjGU89QiYw9eGlrQPd23JxpFEzi1pZV+OmxWS4iM+vWQQG
	AjZp5Jp/AOr0AlgsNu9XR0nWqE6yOOHZ3U2qeSCu34TxOjWLyKXZ3YWLCmKLeAesZzEcvhN7/h6
	CiaRGn9wFusDRbuiRJebk114fmJe0d9Q=
X-Gm-Gg: ASbGncttzh6lu22KGLZrF9rRMC7YH3AtVmTWTzBkvUwpoiln/1TfeE6hs/uxybS2VgK
	BExahhTrRfDnpYMw9Mi29U3bX3JARPO0X1834vErN2Zc3PjOnJ6BPc64UgPSt5wMUwDFbVVG+oR
	p8BDzGisezUlWYKiQU4INwXDaDKdsAfIUZP/sTOb/xJNs8x5xKN7Iu6evi6EJrukC2vjvDR+zcj
	deCKAntv8f9+ns=
X-Google-Smtp-Source: AGHT+IGKtD4/8mznHqLoyCqAkND0AGIztHq7zkuhlt3Y85XcG+oqruiwYehE/DG8LdT/Ctb2AUwL5+agKkCc0A2Aab4=
X-Received: by 2002:a17:902:ce05:b0:240:763d:e999 with SMTP id
 d9443c01a7336-24096b17733mr35400965ad.29.1753852565757; Tue, 29 Jul 2025
 22:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729051436.190703-1-namjain@linux.microsoft.com> <20250729051436.190703-2-namjain@linux.microsoft.com>
In-Reply-To: <20250729051436.190703-2-namjain@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Wed, 30 Jul 2025 13:15:29 +0800
X-Gm-Features: Ac12FXwqcCF3k3YCTl4GjTuOuP9fWlNaWG8AoRu9t-mwzHkXNhX6Ifft0VxzL_Q
Message-ID: <CAMvTesAzY+x_2_40xji6_g6Uquf4j1HmREb1vH9kT4fNzuLY1Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] Drivers: hv: Export some symbols for mshv_vtl
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Michael Kelley <mhklinux@outlook.com>, Roman Kisel <romank@linux.microsoft.com>, 
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>, Saurabh Sengar <ssengar@linux.microsoft.com>, 
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, 
	Nuno Das Neves <nunodasneves@linux.microsoft.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 1:15=E2=80=AFPM Naman Jain <namjain@linux.microsoft=
.com> wrote:
>
> MSHV_VTL driver is going to be introduced, which is supposed to
> provide interface for Virtual Machine Monitors (VMMs) to control
> Virtual Trust Level (VTL). Export the symbols needed
> to make it work (vmbus_isr, hv_context and hv_post_message).
>
> Co-developed-by: Roman Kisel <romank@linux.microsoft.com>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506110544.q0NDMQVc-lkp@i=
ntel.com/
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/hv/hv.c           | 3 +++
>  drivers/hv/hyperv_vmbus.h | 1 +
>  drivers/hv/vmbus_drv.c    | 4 +++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index b14c5f9e0ef2..b16e94daa270 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -18,6 +18,7 @@
>  #include <linux/clockchips.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> +#include <linux/export.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/mshyperv.h>
>  #include <linux/set_memory.h>
> @@ -25,6 +26,7 @@
>
>  /* The one and only */
>  struct hv_context hv_context;
> +EXPORT_SYMBOL_GPL(hv_context);
>
>  /*
>   * hv_init - Main initialization routine.
> @@ -95,6 +97,7 @@ int hv_post_message(union hv_connection_id connection_i=
d,
>
>         return hv_result(status);
>  }
> +EXPORT_SYMBOL_GPL(hv_post_message);
>
>  int hv_synic_alloc(void)
>  {
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 0b450e53161e..b61f01fc1960 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -32,6 +32,7 @@
>   */
>  #define HV_UTIL_NEGO_TIMEOUT 55
>
> +void vmbus_isr(void);
>
>  /* Definitions for the monitored notification facility */
>  union hv_monitor_trigger_group {
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 2ed5a1e89d69..a366365f2c49 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -36,6 +36,7 @@
>  #include <linux/syscore_ops.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/pci.h>
> +#include <linux/export.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/mshyperv.h>
>  #include "hyperv_vmbus.h"
> @@ -1306,7 +1307,7 @@ static void vmbus_chan_sched(struct hv_per_cpu_cont=
ext *hv_cpu)
>         }
>  }
>
> -static void vmbus_isr(void)
> +void vmbus_isr(void)
>  {
>         struct hv_per_cpu_context *hv_cpu
>                 =3D this_cpu_ptr(hv_context.cpu_context);
> @@ -1329,6 +1330,7 @@ static void vmbus_isr(void)
>
>         add_interrupt_randomness(vmbus_interrupt);
>  }
> +EXPORT_SYMBOL_GPL(vmbus_isr);
>
>  static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
>  {
> --
> 2.34.1
>
>

Reviewed-by: Tianyu Lan <tiala@microsoft.com>
--=20
Thanks
Tianyu Lan

