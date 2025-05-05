Return-Path: <linux-hyperv+bounces-5344-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60D9AA9050
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 May 2025 11:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230763AC662
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 May 2025 09:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D931DF254;
	Mon,  5 May 2025 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuNxvaWs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64606F4F1;
	Mon,  5 May 2025 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746438920; cv=none; b=KCjCCk0odR+v7R7wLlS2HDFjpEV6GJDWLdYKMpH+S9OYNgugzaEVdgCTFHuH/yD1VL8tTB5nzLEVV3qCCAB1+xkBqXgWrNE1S+WAJZatjEUbqhlXKLD3w2O58Q/L+XVBLTVZexhUPMIR5O6iVOBHy5ZUDAURADhwLeq1hsNWWNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746438920; c=relaxed/simple;
	bh=sDWpdGUOIqHGhZZ57m37Wf3Ww1ODJ1UW8uvuonF+KQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RszwpzxDo9fYaat8M9srEkhcG+khKemFpBFOTzc0JMfWq4RSWDUd/O37XDht8LAmpputB6l4jtUPmbPdzfXPIs9Vm2No+0Utl/sTX/Y59DaquJ6shKAdWbZedsGCeTXJgYlpq97l3eLMFDv2Sc9ro2EM34Fp2NvEFaQf73Ub4fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuNxvaWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB495C4CEEF;
	Mon,  5 May 2025 09:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746438918;
	bh=sDWpdGUOIqHGhZZ57m37Wf3Ww1ODJ1UW8uvuonF+KQ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PuNxvaWsyXrSBVhUFDOkGC5ujU4dsXor1OzIOFx9N3hw+RgmsbS3sMGrFSmJlCXNs
	 KdfXIUod2RuC8lvK+U76HXbERlDJod9tAou3lQ7TqFscR3FV+T0bFF1FI0TBH/XMiK
	 s3C9m/ABUTk++/c4LUxszPbHTIN6X5RdmSb2mlcqHpnCZO/qSFk3eI8SEzXpiqBgxU
	 aGDSi37rBe2rxskAM263qXwRfLYT9qMrPz6d+3yrfk4fqY5gjGHECjGJ9yks1Fhfc8
	 EruBQBP8jA7nx5MSvgYmdehAbNVwdk9mpJNFrildgM6ljG5/UI3Hi4LIcXUrZH17Dq
	 2vEKEHOyN0jEA==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2cc57330163so2613365fac.2;
        Mon, 05 May 2025 02:55:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUehEN0iHaD6O1oPWxoh6AhBvhHsEnPKWC07Sq6LJX9QIDPT0nQCjuPUGhHfbCsYompNXsLgJjws3XaBw==@vger.kernel.org, AJvYcCUgWo7XdqzWLycG7yeNjsSGX2eYlJmx9Abvgyu/i9Ch2SZnGorTiB6JYzDwDAGISI3EEmaGaaq2XdmzH7U3@vger.kernel.org, AJvYcCUxKSsb17dWIwCfVucT57hM62MYih0QlPdujqN7RnyHPpyHNZ9BEn8VyroqE3mB3D/0kuHFuvDnBMId@vger.kernel.org, AJvYcCWtQGQV11PNY8+WKx1fph6CliaBDQdntrfU9nZ3UFu5Lu5zNuJ38sMBueS+fS5dTKiwZDafIKmnA9H5DAB7@vger.kernel.org
X-Gm-Message-State: AOJu0YweljHA5Q5K5v5dvGWrn+w6ZmsIPm37fT0zPcJkMwnW+us+vdER
	ZsWPREnFAv94KD1Qwjz6sRoJK6KrUh8VxhZ+vq0PgFIts42n9YWWTlstI3iqO8XvTShVzZpKEj5
	cZzqlxYAcVld3PifRMJQD109yILs=
X-Google-Smtp-Source: AGHT+IFwti6fb5Gvf5aETPz2aJ9us2m9jSTWO4Ndwxu2x4Ze/sFyZyZByR9p1BU9f8PFfnycQ1QGJf/m/FjjlgAn87Y=
X-Received: by 2002:a05:6870:a691:b0:2d4:dc79:b8b with SMTP id
 586e51a60fabf-2dab2fd124bmr6933312fac.10.1746438918050; Mon, 05 May 2025
 02:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com> <20250503191515.24041-3-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20250503191515.24041-3-ricardo.neri-calderon@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 May 2025 11:55:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g563qdyEdd6v1voyyZM5tpZab72LXTZcO9C0jE6mnRzw@mail.gmail.com>
X-Gm-Features: ATxdqUFWwVhrd7oEM4uYLLng70_k-jXEr1fQ87L1TOt47nAlsGV6FMO7TJja4pc
Message-ID: <CAJZ5v0g563qdyEdd6v1voyyZM5tpZab72LXTZcO9C0jE6mnRzw@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] x86/acpi: Add a helper function to get a pointer
 to the wakeup mailbox
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, devicetree@vger.kernel.org, 
	Saurabh Sengar <ssengar@linux.microsoft.com>, Chris Oo <cho@microsoft.com>, 
	linux-hyperv@vger.kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, 
	Ricardo Neri <ricardo.neri@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 3, 2025 at 9:10=E2=80=AFPM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> In preparation to move the functionality to wake secondary CPUs up out
> of the ACPI code, add a helper function to get a pointer to the mailbox.
>
> Use this helper function only in the portions of the code for which the
> variable acpi_mp_wake_mailbox will be out of scope once it is relocated
> out of the ACPI directory.
>
> The wakeup mailbox is only supported for CONFIG_X86_64 and needed only
> with CONFIG_SMP.
>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v2:
>  - Introduced this patch.

Have you considered merging it with the previous patch?  They both do
analogous things.

> Changes since v1:
>  - N/A
> ---
>  arch/x86/include/asm/smp.h         |  1 +
>  arch/x86/kernel/acpi/madt_wakeup.c | 12 +++++++++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index 3622951d2ee0..97bfbd0d24d4 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -148,6 +148,7 @@ static inline struct cpumask *cpu_l2c_shared_mask(int=
 cpu)
>
>  #ifdef CONFIG_X86_64
>  void setup_mp_wakeup_mailbox(u64 addr);
> +struct acpi_madt_multiproc_wakeup_mailbox *get_mp_wakeup_mailbox(void);
>  #endif
>
>  #else /* !CONFIG_SMP */
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/ma=
dt_wakeup.c
> index 04de3db307de..6b9e41a24574 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -37,6 +37,7 @@ static void acpi_mp_play_dead(void)
>
>  static void acpi_mp_cpu_die(unsigned int cpu)
>  {
> +       struct acpi_madt_multiproc_wakeup_mailbox *mailbox =3D get_mp_wak=
eup_mailbox();

I'd prefer acpi_get_mp_wakeup_mailbox().

>         u32 apicid =3D per_cpu(x86_cpu_to_apicid, cpu);
>         unsigned long timeout;
>
> @@ -46,13 +47,13 @@ static void acpi_mp_cpu_die(unsigned int cpu)
>          *
>          * BIOS has to clear 'command' field of the mailbox.
>          */
> -       acpi_mp_wake_mailbox->apic_id =3D apicid;
> -       smp_store_release(&acpi_mp_wake_mailbox->command,
> +       mailbox->apic_id =3D apicid;
> +       smp_store_release(&mailbox->command,
>                           ACPI_MP_WAKE_COMMAND_TEST);
>
>         /* Don't wait longer than a second. */
>         timeout =3D USEC_PER_SEC;
> -       while (READ_ONCE(acpi_mp_wake_mailbox->command) && --timeout)
> +       while (READ_ONCE(mailbox->command) && --timeout)
>                 udelay(1);
>
>         if (!timeout)
> @@ -251,3 +252,8 @@ void __init setup_mp_wakeup_mailbox(u64 mailbox_paddr=
)
>         acpi_mp_wake_mailbox_paddr =3D mailbox_paddr;
>         apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
>  }
> +
> +struct acpi_madt_multiproc_wakeup_mailbox *get_mp_wakeup_mailbox(void)
> +{
> +       return acpi_mp_wake_mailbox;
> +}
> --

