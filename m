Return-Path: <linux-hyperv+bounces-6052-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2F3AEE702
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jun 2025 20:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12A7189B1C4
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jun 2025 18:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4FA2E54D7;
	Mon, 30 Jun 2025 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdhGKmzR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B6479D2;
	Mon, 30 Jun 2025 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751309738; cv=none; b=axO2ut0FV6g7AZlhxPAEd8m7UECYsRHFULVazYiliH6vJGStUM/XUomC/hhVMIO/ZRMaz0besWBfisznDq8h0N4OFhrnHsxBDUwULNbRrPcLBrqqSSA+DgtGeXdOAuPkbAioy1EQhu2thejgzZrFcF7azJBTxkp/LredW2dSDSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751309738; c=relaxed/simple;
	bh=p7WnF9DWkiE2Gdzjr0y3QZ/hVpLdgQL++uU/dzCSfFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOkenrwqxQHM5CawltVQTYPRAKQabqghsW1K6iTJmZlwsrIHRNmbCzwq4dOTIyk0jf2aHniS0MoMOg1YZjpX+wn9GeKNp00XjrPvsVs3mr9KGNXjIzj/F0eATwC92Taaufu7l6w36a6PtbloKkqd+i5Qtvj1/0eL6HCFHrrkCdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdhGKmzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B855AC4CEF1;
	Mon, 30 Jun 2025 18:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751309737;
	bh=p7WnF9DWkiE2Gdzjr0y3QZ/hVpLdgQL++uU/dzCSfFQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DdhGKmzRL19+3kQBx3yMJKSK8lxEnyv+onbYxR8wot8l6poEsYSR3bQfJ7BUAdVlL
	 8Tx6Nho9Q8axXkSGHc748vrKzrJ7aS4x8ZMpdDEfQhMV6bi3q2R/J15h8gTdpV16rZ
	 SUGXRs5yDkjbiXfGNWYunhp+hPcbf9HrpffAE189Bj2P3JsbDtRmNjZleqFezGvOAg
	 rdyUbE8wuujIiFsbOLydHimuaLkU5fhoD1P99S7bsZmGRK4Qg27cTinOCc63FvuAll
	 gVEDgzalDO9mi3Vm8FAdvgw+25mapTche0a2GbeH3JUJ7vp5qGNAZwyEaxsZYkXpbR
	 TfiwQ8drVNUpQ==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-735b9d558f9so1071526a34.2;
        Mon, 30 Jun 2025 11:55:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9E/uV2WV4bWV/wnv2P79UPJ3yYGq6Z1s3qW0h1nY28vb279O1sOLAa8OkE01gRWfPOJ2xptRM+4jPMHSd@vger.kernel.org, AJvYcCVN0pDnAHRbjy/x5GaN6eFvntY+v6Vic088RASn5avb1jtBhUN+WRzC4BPDpuyqZ1CnxRoKPY+Zjz9q@vger.kernel.org, AJvYcCWj0pK53S82Z1De6E0OGDOqubY/aO61fAU37nExLaMfQg8AAeFIngyg6SFIcLa56zBvJ9CYv84iHkSrBg+q@vger.kernel.org, AJvYcCXiQl2fJiRsK1WMdQQ9pK4Op73OIlwOYH1f0Jr2R/xo5skJv431Zi+ujRIBu0poSV+N3cq+xst8Cynn2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnHAwRxHMBanv2YlBgVrPg4njIP+6YxM4f1N3mNV46QnsYQzZO
	Kbx6YDtT4+R7zmRVOno/kaEM8TmsTT4vWwG10i4xeu4oYuoi0nY96S5uJl+uJHeBOIkxGWGrOaC
	nLwT6MABW1pm1zNkH3RtYXxFO467iPxA=
X-Google-Smtp-Source: AGHT+IHVLwd4OxwkvCyDp30OFrkyLqV3hiaG0N2GiR3mAT+Kfajnad7UwexjbjLRZFMzoLdL5pTxDqLLSFRMc73q24U=
X-Received: by 2002:a05:6808:1646:b0:40a:f48f:2c10 with SMTP id
 5614622812f47-40b33c464e2mr11382918b6e.10.1751309737019; Mon, 30 Jun 2025
 11:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com> <20250627-rneri-wakeup-mailbox-v5-1-df547b1d196e@linux.intel.com>
In-Reply-To: <20250627-rneri-wakeup-mailbox-v5-1-df547b1d196e@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 30 Jun 2025 20:55:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i+EOthnNexMs7hm1iX+PY0rCNCHjRgB5r5pJ3tz2aw+w@mail.gmail.com>
X-Gm-Features: Ac12FXxLJjcnuW3nUc_r1s6Rsa0T03g4e7iaJ1R43QcOYsgg7pHNf2V9xIGOH0g
Message-ID: <CAJZ5v0i+EOthnNexMs7hm1iX+PY0rCNCHjRgB5r5pJ3tz2aw+w@mail.gmail.com>
Subject: Re: [PATCH v5 01/10] x86/acpi: Add a helper functions to setup and
 access the wakeup mailbox
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Saurabh Sengar <ssengar@linux.microsoft.com>, 
	Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ricardo Neri <ricardo.neri@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

s/a helper/helper/ in the subject.

On Sat, Jun 28, 2025 at 5:35=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> In preparation to move the functionality to wake secondary CPUs up out of
> the ACPI code, add two helper functions.
>
> The function acpi_setup_mp_wakeup_mailbox() stores the physical address o=
f
> the mailbox and updates the wakeup_secondary_cpu_64() APIC callback.
>
> There is a slight change in behavior: now the APIC callback is updated
> before configuring CPU hotplug offline behavior. This is fine as the APIC
> callback continues to be updated unconditionally, regardless of the
> restriction on CPU offlining.
>
> The function acpi_madt_multiproc_wakeup_mailbox() returns a pointer to th=
e
> mailbox. Use this helper function only in the portions of the code for
> which the variable acpi_mp_wake_mailbox will be out of scope once it is
> relocated out of the ACPI directory.
>
> The wakeup mailbox is only supported for CONFIG_X86_64 and needed only wi=
th
> CONFIG_SMP=3Dy.
>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

With the above nit addressed

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Changes since v4:
>  - None
>
> Changes since v3:
>  - Squashed the two first patches of the series into one, both introduce
>    helper functions. (Rafael)
>  - Renamed setup_mp_wakeup_mailbox() as acpi_setup_mp_wakeup_mailbox().
>    (Rafael)
>  - Dropped the function prototype for !CONFIG_X86_64. (Rafael)
>
> Changes since v2:
>  - Introduced this patch.
>
> Changes since v1:
>  - N/A
> ---
>  arch/x86/include/asm/smp.h         |  3 +++
>  arch/x86/kernel/acpi/madt_wakeup.c | 20 +++++++++++++++-----
>  2 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index 0c1c68039d6f..77dce560a70a 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -146,6 +146,9 @@ static inline struct cpumask *cpu_l2c_shared_mask(int=
 cpu)
>         return per_cpu(cpu_l2c_shared_map, cpu);
>  }
>
> +void acpi_setup_mp_wakeup_mailbox(u64 addr);
> +struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(vo=
id);
> +
>  #else /* !CONFIG_SMP */
>  #define wbinvd_on_cpu(cpu)     wbinvd()
>  static inline int wbinvd_on_all_cpus(void)
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/ma=
dt_wakeup.c
> index 6d7603511f52..c3ac5ecf3e7d 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -37,6 +37,7 @@ static void acpi_mp_play_dead(void)
>
>  static void acpi_mp_cpu_die(unsigned int cpu)
>  {
> +       struct acpi_madt_multiproc_wakeup_mailbox *mailbox =3D acpi_get_m=
p_wakeup_mailbox();
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
> @@ -227,7 +228,7 @@ int __init acpi_parse_mp_wake(union acpi_subtable_hea=
ders *header,
>
>         acpi_table_print_madt_entry(&header->common);
>
> -       acpi_mp_wake_mailbox_paddr =3D mp_wake->mailbox_address;
> +       acpi_setup_mp_wakeup_mailbox(mp_wake->mailbox_address);
>
>         if (mp_wake->version >=3D ACPI_MADT_MP_WAKEUP_VERSION_V1 &&
>             mp_wake->header.length >=3D ACPI_MADT_MP_WAKEUP_SIZE_V1) {
> @@ -243,7 +244,16 @@ int __init acpi_parse_mp_wake(union acpi_subtable_he=
aders *header,
>                 acpi_mp_disable_offlining(mp_wake);
>         }
>
> +       return 0;
> +}
> +
> +void __init acpi_setup_mp_wakeup_mailbox(u64 mailbox_paddr)
> +{
> +       acpi_mp_wake_mailbox_paddr =3D mailbox_paddr;
>         apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
> +}
>
> -       return 0;
> +struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(vo=
id)
> +{
> +       return acpi_mp_wake_mailbox;
>  }
>
> --
> 2.43.0
>

