Return-Path: <linux-hyperv+bounces-5345-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8E8AA908A
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 May 2025 12:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDACE3B4F45
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 May 2025 10:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154B81F9F70;
	Mon,  5 May 2025 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubWJHlr5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D553A1D63C6;
	Mon,  5 May 2025 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746439409; cv=none; b=QiGXRdPDhxDvajtX3rv0Bssq7D64I9aBkX6R7qpJUxbFbNn7/EWtpM/oXa881aEZqPSpiB0iYqpEdstMXio6NT5vxyWTIOAhTFCPZ/0Y+N/tUvrcuiYzmWWKNfbFSAm4wBboeohj/FAk4dAYSDaItEmesoHgI5hdi0gOnQyTK9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746439409; c=relaxed/simple;
	bh=4HJtqOubp6J7X3p5gjKy2XK5fTkEo1G19dQ4FqCbxHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLhzUSJHeC+EYRjkwZo2ohuMONe9O2/ZS2k3pWkBktrH/rv35/XJQcPeGAmiOX1uJQc+yYBjXk5CShJifXzgx1y0yxiQI7Z2nezBnELNk9qRLBN5mEzFPiK45q8sjvh/Y/iXPc1RQZzNoZMsaVWYsavXyg2OUf8DzQlvgibQdTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubWJHlr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41558C4CEE4;
	Mon,  5 May 2025 10:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746439408;
	bh=4HJtqOubp6J7X3p5gjKy2XK5fTkEo1G19dQ4FqCbxHk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ubWJHlr5ftCHXJM64WYFzAcldV8Y8y2aIiTN3lq5Cyp27xm/Pgw8SSQKvYmzs3ew6
	 Lq9PwPKK/gG/BW3WWl03Lns5GLMJGXsJzINY0ft/ylVvpxQJ/ZQVJe1m8YUVQEcKPG
	 bodoMW2R0dWZJfitahpp4Z42MdRKxlNO1C+W7dGQUxdhGFpn9lJbnf7lkQhAYr5XTH
	 +izxyYGYPEL43bCcrgcxea+E+OI1thFclCNZ/EiMVHiVkC/0t0JDKMdY0HwderNUZr
	 A3+GSTCEgu5ckZg1QlNa/QGyf/rbCx86UvcupUFHDHHdQkh+gWlaNFyR7xRLQkeubr
	 KMtJcjIlVi7xQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-601b6146b9cso2095803eaf.0;
        Mon, 05 May 2025 03:03:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVc5r2mtw483ZEfZUrQAnS6KLy1B4wztnto5GlRYQ7yj4VqxtVonnmiYfVZT2kWSJlHVNj+Cy2Pzec/@vger.kernel.org, AJvYcCVfK/zquOqLd51hxpQtC2A91rn2lHfRP0eWgv5pyjwP658Yg2s4fXQY6g+vJK4+6doxPoWLXgkIDInnk7OI@vger.kernel.org, AJvYcCWYQBg0njXEX5VUmKJ9yZfGoHNBsIgVK5WvCkYVRT4I/4BeepqL2/T5vPJwmBocl/aucUTLkkA2g1LqrXCg@vger.kernel.org, AJvYcCXKZcEOf7WP3agdRU1y3oD6FJCPDrMxH81pob1wI9Y3CJ8Aatr3eNDE5rnDMyknLgY3LETpAQXQ07jxhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBoJeoTzn+xxTaBhCIKGPyBLrgeTLFtn5qgd0Id00rTkKgr+M0
	cTYMefVh1MvheVkeP9vH+xTfiQlAB7yc7tFBEa8I/zqkN2fhaLboy6PxNcFQDZyN36joQ3rxb5q
	EGADk9XXJNO8VQRw+oLns/UaP46k=
X-Google-Smtp-Source: AGHT+IEUgUpkzkZmp1T+q3tYIuiFtr7XFytDLpdBFReTQ3vKnlzzARsKdHp8qeISrwvr07TngSQWOmuNvFwXU6XJFfs=
X-Received: by 2002:a05:6870:95a0:b0:296:e698:3227 with SMTP id
 586e51a60fabf-2dae869e0ccmr3429543fac.36.1746439407490; Mon, 05 May 2025
 03:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com> <20250503191515.24041-4-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20250503191515.24041-4-ricardo.neri-calderon@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 May 2025 12:03:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h_QcH72COEU-cnHUMfXj2grHv1EoLuBJnxm7_AeRteWw@mail.gmail.com>
X-Gm-Features: ATxdqUFaV1XZyMlqiWWcZYxOO4eBRMR9Ncb3AcYIqYeAhjsJy0O1nZ15ZhLQHp4
Message-ID: <CAJZ5v0h_QcH72COEU-cnHUMfXj2grHv1EoLuBJnxm7_AeRteWw@mail.gmail.com>
Subject: Re: [PATCH v3 03/13] x86/acpi: Move acpi_wakeup_cpu() and helpers to smpboot.c
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
> The bootstrap processor uses acpi_wakeup_cpu() to indicate to firmware th=
at
> it wants to boot a secondary CPU using a mailbox as described in the
> Multiprocessor Wakeup Structure of the ACPI specification.
>
> The wakeup mailbox does not strictly require support from ACPI.

Well, except that it is defined by the ACPI specification.

> The platform firmware can implement a mailbox compatible in structure and
> operation and enumerate it using other mechanisms such a DeviceTree graph=
.

So is there a specification defining this mechanism?

It is generally not sufficient to put the code and DT bindings
unilaterally into the OS and expect the firmware to follow suit.

> Move the code used to setup and use the mailbox out of the ACPI
> directory to use it when support for ACPI is not available or needed.

I think that the code implementing interfaces defined by the ACPI
specification is not generic and so it should not be built when the
kernel is configured without ACPI support.

> No functional changes are intended.
>
> Originally-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v2:
>  - Only move to smpboot.c the portions of the code that configure and
>    use the mailbox. This also resolved the compile warnings about unused
>    functions that Michael Kelley reported.
>  - Edited the commit message for clarity.
>
> Changes since v1:
>  - None.
> ---
>  arch/x86/kernel/acpi/madt_wakeup.c | 75 ----------------------------
>  arch/x86/kernel/smpboot.c          | 78 ++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+), 75 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/ma=
dt_wakeup.c
> index 6b9e41a24574..15627f63f9f5 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -2,7 +2,6 @@
>  #include <linux/acpi.h>
>  #include <linux/cpu.h>
>  #include <linux/delay.h>
> -#include <linux/io.h>
>  #include <linux/kexec.h>
>  #include <linux/memblock.h>
>  #include <linux/pgtable.h>
> @@ -15,12 +14,6 @@
>  #include <asm/processor.h>
>  #include <asm/reboot.h>
>
> -/* Physical address of the Multiprocessor Wakeup Structure mailbox */
> -static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
> -
> -/* Virtual address of the Multiprocessor Wakeup Structure mailbox */
> -static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> -
>  static u64 acpi_mp_pgd __ro_after_init;
>  static u64 acpi_mp_reset_vector_paddr __ro_after_init;
>
> @@ -127,63 +120,6 @@ static int __init acpi_mp_setup_reset(u64 reset_vect=
or)
>         return 0;
>  }
>
> -static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
> -{
> -       if (!acpi_mp_wake_mailbox_paddr) {
> -               pr_warn_once("No MADT mailbox: cannot bringup secondary C=
PUs. Booting with kexec?\n");
> -               return -EOPNOTSUPP;
> -       }
> -
> -       /*
> -        * Remap mailbox memory only for the first call to acpi_wakeup_cp=
u().
> -        *
> -        * Wakeup of secondary CPUs is fully serialized in the core code.
> -        * No need to protect acpi_mp_wake_mailbox from concurrent access=
es.
> -        */
> -       if (!acpi_mp_wake_mailbox) {
> -               acpi_mp_wake_mailbox =3D memremap(acpi_mp_wake_mailbox_pa=
ddr,
> -                                               sizeof(*acpi_mp_wake_mail=
box),
> -                                               MEMREMAP_WB);
> -       }
> -
> -       /*
> -        * Mailbox memory is shared between the firmware and OS. Firmware=
 will
> -        * listen on mailbox command address, and once it receives the wa=
keup
> -        * command, the CPU associated with the given apicid will be boot=
ed.
> -        *
> -        * The value of 'apic_id' and 'wakeup_vector' must be visible to =
the
> -        * firmware before the wakeup command is visible.  smp_store_rele=
ase()
> -        * ensures ordering and visibility.
> -        */
> -       acpi_mp_wake_mailbox->apic_id       =3D apicid;
> -       acpi_mp_wake_mailbox->wakeup_vector =3D start_ip;
> -       smp_store_release(&acpi_mp_wake_mailbox->command,
> -                         ACPI_MP_WAKE_COMMAND_WAKEUP);
> -
> -       /*
> -        * Wait for the CPU to wake up.
> -        *
> -        * The CPU being woken up is essentially in a spin loop waiting t=
o be
> -        * woken up. It should not take long for it wake up and acknowled=
ge by
> -        * zeroing out ->command.
> -        *
> -        * ACPI specification doesn't provide any guidance on how long ke=
rnel
> -        * has to wait for a wake up acknowledgment. It also doesn't prov=
ide
> -        * a way to cancel a wake up request if it takes too long.
> -        *
> -        * In TDX environment, the VMM has control over how long it takes=
 to
> -        * wake up secondary. It can postpone scheduling secondary vCPU
> -        * indefinitely. Giving up on wake up request and reporting error=
 opens
> -        * possible attack vector for VMM: it can wake up a secondary CPU=
 when
> -        * kernel doesn't expect it. Wait until positive result of the wa=
ke up
> -        * request.
> -        */
> -       while (READ_ONCE(acpi_mp_wake_mailbox->command))
> -               cpu_relax();
> -
> -       return 0;
> -}
> -
>  static void acpi_mp_disable_offlining(struct acpi_madt_multiproc_wakeup =
*mp_wake)
>  {
>         cpu_hotplug_disable_offlining();
> @@ -246,14 +182,3 @@ int __init acpi_parse_mp_wake(union acpi_subtable_he=
aders *header,
>
>         return 0;
>  }
> -
> -void __init setup_mp_wakeup_mailbox(u64 mailbox_paddr)
> -{
> -       acpi_mp_wake_mailbox_paddr =3D mailbox_paddr;
> -       apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
> -}
> -
> -struct acpi_madt_multiproc_wakeup_mailbox *get_mp_wakeup_mailbox(void)
> -{
> -       return acpi_mp_wake_mailbox;
> -}
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index d6cf1e23c2a3..6f39ebe4d192 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -61,7 +61,9 @@
>  #include <linux/cpuhotplug.h>
>  #include <linux/mc146818rtc.h>
>  #include <linux/acpi.h>
> +#include <linux/io.h>
>
> +#include <asm/barrier.h>
>  #include <asm/acpi.h>
>  #include <asm/cacheinfo.h>
>  #include <asm/cpuid.h>
> @@ -1354,3 +1356,79 @@ void native_play_dead(void)
>  }
>
>  #endif
> +
> +#ifdef CONFIG_X86_64
> +/* Physical address of the Multiprocessor Wakeup Structure mailbox */
> +static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
> +
> +/* Virtual address of the Multiprocessor Wakeup Structure mailbox */
> +static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> +
> +static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
> +{
> +       if (!acpi_mp_wake_mailbox_paddr) {
> +               pr_warn_once("No MADT mailbox: cannot bringup secondary C=
PUs. Booting with kexec?\n");
> +               return -EOPNOTSUPP;
> +       }
> +
> +       /*
> +        * Remap mailbox memory only for the first call to acpi_wakeup_cp=
u().
> +        *
> +        * Wakeup of secondary CPUs is fully serialized in the core code.
> +        * No need to protect acpi_mp_wake_mailbox from concurrent access=
es.
> +        */
> +       if (!acpi_mp_wake_mailbox) {
> +               acpi_mp_wake_mailbox =3D memremap(acpi_mp_wake_mailbox_pa=
ddr,
> +                                               sizeof(*acpi_mp_wake_mail=
box),
> +                                               MEMREMAP_WB);
> +       }
> +
> +       /*
> +        * Mailbox memory is shared between the firmware and OS. Firmware=
 will
> +        * listen on mailbox command address, and once it receives the wa=
keup
> +        * command, the CPU associated with the given apicid will be boot=
ed.
> +        *
> +        * The value of 'apic_id' and 'wakeup_vector' must be visible to =
the
> +        * firmware before the wakeup command is visible.  smp_store_rele=
ase()
> +        * ensures ordering and visibility.
> +        */
> +       acpi_mp_wake_mailbox->apic_id       =3D apicid;
> +       acpi_mp_wake_mailbox->wakeup_vector =3D start_ip;
> +       smp_store_release(&acpi_mp_wake_mailbox->command,
> +                         ACPI_MP_WAKE_COMMAND_WAKEUP);
> +
> +       /*
> +        * Wait for the CPU to wake up.
> +        *
> +        * The CPU being woken up is essentially in a spin loop waiting t=
o be
> +        * woken up. It should not take long for it wake up and acknowled=
ge by
> +        * zeroing out ->command.
> +        *
> +        * ACPI specification doesn't provide any guidance on how long ke=
rnel
> +        * has to wait for a wake up acknowledgment. It also doesn't prov=
ide
> +        * a way to cancel a wake up request if it takes too long.
> +        *
> +        * In TDX environment, the VMM has control over how long it takes=
 to
> +        * wake up secondary. It can postpone scheduling secondary vCPU
> +        * indefinitely. Giving up on wake up request and reporting error=
 opens
> +        * possible attack vector for VMM: it can wake up a secondary CPU=
 when
> +        * kernel doesn't expect it. Wait until positive result of the wa=
ke up
> +        * request.
> +        */
> +       while (READ_ONCE(acpi_mp_wake_mailbox->command))
> +               cpu_relax();
> +
> +       return 0;
> +}
> +
> +void __init setup_mp_wakeup_mailbox(u64 mailbox_paddr)
> +{
> +       acpi_mp_wake_mailbox_paddr =3D mailbox_paddr;
> +       apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
> +}
> +
> +struct acpi_madt_multiproc_wakeup_mailbox *get_mp_wakeup_mailbox(void)
> +{
> +       return acpi_mp_wake_mailbox;
> +}
> +#endif
> --
> 2.43.0
>
>

