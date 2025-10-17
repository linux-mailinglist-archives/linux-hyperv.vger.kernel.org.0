Return-Path: <linux-hyperv+bounces-7246-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F7CBE7E11
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 11:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F08D420CC2
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 09:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F9A2D94A4;
	Fri, 17 Oct 2025 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdMMJD97"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3E02D239B
	for <linux-hyperv@vger.kernel.org>; Fri, 17 Oct 2025 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694433; cv=none; b=dd4iSg6yxWpteUeGK9PwGm8b7/p2zq/3DHTR2zh53R5862HYPhdy2p3Q6O5aNCsU14ExVbpExifMVntY/jkLdKxqrxjahjhOZyXKg29YMH00EgvdqAtu0m04dDXBmqOxkPLC/BCLsLJv85uxupTekw4RgSSFADG89usQHitzTQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694433; c=relaxed/simple;
	bh=HDU1FACluX6LCqIfLVToKdMVxXgddwHgsUQEywEtEwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bttkETjpBHZVx7jNPRHtNFNqoUrH4RH9i4mYUYb6vXkBdDVLS7MDiJXnhpLwCERqcqXYIOKoVedScPp2MhPMBViT2xbyjIP7GQFiWXFwEEvSI3liraEuYcQdaCmMT5GOJv7wHMDe9KMkqQSeSL/CdSkstxYkpu2nMuaciHQwoXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdMMJD97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D2BC4CEFE
	for <linux-hyperv@vger.kernel.org>; Fri, 17 Oct 2025 09:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760694432;
	bh=HDU1FACluX6LCqIfLVToKdMVxXgddwHgsUQEywEtEwU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HdMMJD97cDtRto4/3Mqp8A2yH0kXg+5O2LNBRHNYXRmv1HC0hf0fYXHfddi7IvYEJ
	 h7r0j5nV2evBXGB0OsrwVK9mOaJAIT/z+iPQe+qxrqOhSWWV3yHO5GNGlORAXdUPoV
	 ZEsYNIZxLz0MPnhNiPPfPRlSH5RuMTJCtwgNvqsa/8TxcL85FiG+SDILptCYHMYMBn
	 uCGAG8dTvTg20Qff1lNXlOAZuquXgauTWFSYR4OE20+dOBmTFDQf08buNmXvfOrjdj
	 /NLdrAYtKr9S6W109qBvrvJ91JiUbe+8EEaQbvdQLhEsxPMwsbjKwCcwfAAKr5/lON
	 sb8A2R9dE6Big==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-651ca0146deso286751eaf.2
        for <linux-hyperv@vger.kernel.org>; Fri, 17 Oct 2025 02:47:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3n+mNYuHcxCI2R0kpWigc/WRvJZ5rEnZk72mGCwIdKVxKItSOSfuHS3iqSsxsr/9c90oQ77oKD0+es9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCdL1d7WCbWDALmA+4w3fwJXWlSFu9qp46GPs5POF7OEVzldnQ
	EWjcTQzOgYbZ3F1WYuk5lLroKBL1RuovtLVSQeLXuc4N3q1Zf9Wjs8KvUD2F+QiIhU6AB5TdmM7
	w32SXmyEt8vu5j5djvmEV98pE/OzSC18=
X-Google-Smtp-Source: AGHT+IF6Zim4KFjK/5YwE9BLg4NQGMqj3sOP2xD9ENA7fnIjMq+2fpDogmWr3naNZ7Jjzb62XZWXqD1zoRl37XI46rs=
X-Received: by 2002:a05:6808:1383:b0:439:b9b3:af48 with SMTP id
 5614622812f47-443a3144e71mr1265508b6e.51.1760694432040; Fri, 17 Oct 2025
 02:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com> <20251016-rneri-wakeup-mailbox-v6-1-40435fb9305e@linux.intel.com>
In-Reply-To: <20251016-rneri-wakeup-mailbox-v6-1-40435fb9305e@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 17 Oct 2025 11:46:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iB4iZFs8C6EZayLVPbLz50MJ9GEniSHfbP31-yHRg1Bw@mail.gmail.com>
X-Gm-Features: AS18NWCpLzOnPH0RKu6aTn1sl9Pr7sXnawYuZXgmcYTVDY3oZ6tv4PUbka5tAd4
Message-ID: <CAJZ5v0iB4iZFs8C6EZayLVPbLz50MJ9GEniSHfbP31-yHRg1Bw@mail.gmail.com>
Subject: Re: [PATCH v6 01/10] x86/acpi: Add helper functions to setup and
 access the wakeup mailbox
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Saurabh Sengar <ssengar@linux.microsoft.com>, 
	Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kas@kernel.org>, linux-hyperv@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 4:48=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> In preparation to move the functionality to wake secondary CPUs up from t=
he
> ACPI code, add two helper functions.
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
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

This should have been

Acked-by: Rafael J. Wysocki (Intel) <rafael.j.wysocki@intel.com>

The "(Intel)" part is missing and I omitted it when I sent the tag.
Sorry for the confusion.

> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v5:
>  - Fixed grammar error in the subject of the patch. (Rafael)
>  - Added Acked-by tag from Rafael. Thanks!
>  - Added Reviewed-by tag from Dexuan. Thanks!
>
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
> index 22bfebe6776d..47ac4381a805 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -149,6 +149,9 @@ static inline struct cpumask *cpu_l2c_shared_mask(int=
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
>  static inline void wbinvd_on_all_cpus(void)
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

