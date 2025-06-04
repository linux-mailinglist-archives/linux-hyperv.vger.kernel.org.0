Return-Path: <linux-hyperv+bounces-5762-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72902ACDAA6
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 11:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3332116D5AF
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 09:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E3A28C843;
	Wed,  4 Jun 2025 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+RHsfe+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76A728C5C0;
	Wed,  4 Jun 2025 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028388; cv=none; b=FDx02G+SxbI5Muw7erqymaMpe3CWHjHKj/vbflMgBxFHPb53M5cwdgjvNnQbnQhot+7Ars8plTJAEp/0npDkD+YwXdxD7vvlSxmNhTV03pBd3y+XDC080j3wWCyRrLABhZo3P3EHkz4iQk2pa6SNMrM1COuHrTbz6rNAyPh+I8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028388; c=relaxed/simple;
	bh=jOlUvjiUZ6Qp7SBB71J457pTPV06zNA+KwXta7F1JT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rskUtrgNEFTYofQNw87cCW+YkSXUk7wRVrfI7ESplwUJ/g3ARkCIjV5m+EZ6yw8HW/lgUdnJ2cARDb6l2CH1VTsZZarCITRYwaZJRR7N1oUqu11lRN0/3R+Gmpez6V5PHpu5st6vLfHqj1tRfawmMbDkl8s1yxpyeff0UAl7u/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+RHsfe+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA8EC4CEE7;
	Wed,  4 Jun 2025 09:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749028386;
	bh=jOlUvjiUZ6Qp7SBB71J457pTPV06zNA+KwXta7F1JT4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e+RHsfe+HhDnVHzof5uuvv1xO898sGvxPXbSu1RwOlFW1xaa577IAvcnzazwsitle
	 5594IGDwlW0XnYpk74yrrthH7lT7KfY8plU9MvimoNzJrwQSWHAaRO/LsTdCd54fSL
	 DXvfaQ9FWJOLxO3MgqikyxcdaJU0/uzeWQgfCMvANY+ivbQLLAgaxqeRGyW+mM3tQ3
	 lCvm9tz9A0z57tWwJvFchmyMFDxATfvPvub8vVhreOahUzY+xwLzPYIYWTQGWUCe2+
	 wKvVAaNjxfcdpGBH+HTcRkuQTWV8Flp4SknIMzAjFqo9KxBMbzBESpFwcHklxGjIhT
	 zOXdJt/4Dt24w==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6021e3daeabso3187025eaf.3;
        Wed, 04 Jun 2025 02:13:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdCBmwrCr9Ht+E3HqxFHQc1iPg7c+UdA4q5OP1l/pgT53jUZX0+Uqe+y6P2yxpmoxI/bIKcC7hKgsXU4JS@vger.kernel.org, AJvYcCUuaMa93YI30UVWEFdvaWzyxtJ9eKF4vPLiF69B5clEQDiQHF0RQeCTh80jbNDTCwOTuvChfHH/QEsI6Vks@vger.kernel.org, AJvYcCVGdpPGYWSGD2knttzEwhCkW96G2c2X1LaPjDLMsEl/rPYxC1J9cKL/8H21hf+8eleg8wYd6unlpLW8@vger.kernel.org, AJvYcCXcfGdTLYUNiyPBYFAy+pVguXyivm9xq7s2n/X25dkRUT55VJHBvVZo0cEA0WV8NGuuwvIbjZGFRCOLHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcJAZt69qeosgvA+TLrQIOJN8my740VPhhyyZH44X/2ibK9+TO
	d6OXBQDB8VYsYm1Yml6kRzpbycZQnXGfZuLksagsqxe0n7dzHSe/Km55qNVzbNaeQK+5c/7jKGe
	e8ht61pLoxe0tNqOcCkiiFxypfTLhdeY=
X-Google-Smtp-Source: AGHT+IHWDMNiqpKa4YBUr7paa4XPPKHTiCCyQucMUft8ByRknx//SSgHEhOGHFnFc61mVzchJpTMOOrdj+kGJmt9zP0=
X-Received: by 2002:a05:6820:991:b0:60e:d4e3:da3e with SMTP id
 006d021491bc7-60f0c5b958amr935497eaf.0.1749028385643; Wed, 04 Jun 2025
 02:13:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603-rneri-wakeup-mailbox-v4-0-d533272b7232@linux.intel.com> <20250603-rneri-wakeup-mailbox-v4-2-d533272b7232@linux.intel.com>
In-Reply-To: <20250603-rneri-wakeup-mailbox-v4-2-d533272b7232@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Jun 2025 11:12:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0geZAnLRkeunW06JKE1gyDcd15EGzqJ_A-cZHO_koJVAw@mail.gmail.com>
X-Gm-Features: AX0GCFtzw8yWInMnx9TjamQXx8dhh5wnfF2kqpxjQE7DIB_tehmbdmWq4jT-oac
Message-ID: <CAJZ5v0geZAnLRkeunW06JKE1gyDcd15EGzqJ_A-cZHO_koJVAw@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] x86/acpi: Move acpi_wakeup_cpu() and helpers to smpwakeup.c
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Saurabh Sengar <ssengar@linux.microsoft.com>, 
	Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>, Ricardo Neri <ricardo.neri@intel.com>, 
	Yunhong Jiang <yunhong.jiang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 2:18=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> The bootstrap processor uses acpi_wakeup_cpu() to indicate to firmware th=
at
> it wants to boot a secondary CPU using a mailbox as described in the
> Multiprocessor Wakeup Structure of the ACPI specification.
>
> The platform firmware may implement the mailbox as described in the ACPI
> specification but enumerate it using a DeviceTree graph. An example of
> this is OpenHCL paravisor.
>
> Move the code used to setup and use the mailbox for CPU wakeup out of the
> ACPI directory into a new smpwakeup.c file that both ACPI and DeviceTree
> can use.
>
> No functional changes are intended.
>
> Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v3:
>  - Create a new file smpwakeup.c instead of relocating it to smpboot.c.
>    (Rafael)
>
> Changes since v2:
>  - Only move to smpboot.c the portions of the code that configure and
>    use the mailbox. This also resolved the compile warnings about unused
>    functions that Michael Kelley reported.
>  - Edited the commit message for clarity.
>
> Changes since v1:
>  - None.
> ---
>  arch/x86/Kconfig                   |  7 ++++
>  arch/x86/kernel/Makefile           |  1 +
>  arch/x86/kernel/acpi/madt_wakeup.c | 76 --------------------------------=
--
>  arch/x86/kernel/smpwakeup.c        | 83 ++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 91 insertions(+), 76 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index cb0f4af31789..82147edb355a 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1113,6 +1113,13 @@ config X86_LOCAL_APIC
>         depends on X86_64 || SMP || X86_UP_APIC || PCI_MSI
>         select IRQ_DOMAIN_HIERARCHY
>
> +config X86_MAILBOX_WAKEUP
> +       def_bool y
> +       depends on OF || ACPI_MADT_WAKEUP

At this point the dependency on OF is premature.  IMV it should be
added in a later patch.

> +       depends on X86_64
> +       depends on SMP
> +       depends on X86_LOCAL_APIC
> +
>  config ACPI_MADT_WAKEUP
>         def_bool y
>         depends on X86_64
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 99a783fd4691..8f078af42a71 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -94,6 +94,7 @@ apm-y                         :=3D apm_32.o
>  obj-$(CONFIG_APM)              +=3D apm.o
>  obj-$(CONFIG_SMP)              +=3D smp.o
>  obj-$(CONFIG_SMP)              +=3D smpboot.o
> +obj-$(CONFIG_X86_MAILBOX_WAKEUP) +=3D smpwakeup.o
>  obj-$(CONFIG_X86_TSC)          +=3D tsc_sync.o
>  obj-$(CONFIG_SMP)              +=3D setup_percpu.o
>  obj-$(CONFIG_X86_MPPARSE)      +=3D mpparse.o
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/ma=
dt_wakeup.c
> index 4033c804307a..a7e0158269b0 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -2,12 +2,10 @@
>  #include <linux/acpi.h>
>  #include <linux/cpu.h>
>  #include <linux/delay.h>
> -#include <linux/io.h>
>  #include <linux/kexec.h>
>  #include <linux/memblock.h>
>  #include <linux/pgtable.h>
>  #include <linux/sched/hotplug.h>
> -#include <asm/apic.h>
>  #include <asm/barrier.h>
>  #include <asm/init.h>
>  #include <asm/intel_pt.h>
> @@ -15,12 +13,6 @@
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
> @@ -127,63 +119,6 @@ static int __init acpi_mp_setup_reset(u64 reset_vect=
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
> @@ -246,14 +181,3 @@ int __init acpi_parse_mp_wake(union acpi_subtable_he=
aders *header,
>
>         return 0;
>  }
> -
> -void __init acpi_setup_mp_wakeup_mailbox(u64 mailbox_paddr)
> -{
> -       acpi_mp_wake_mailbox_paddr =3D mailbox_paddr;
> -       apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
> -}
> -
> -struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(vo=
id)
> -{
> -       return acpi_mp_wake_mailbox;
> -}
> diff --git a/arch/x86/kernel/smpwakeup.c b/arch/x86/kernel/smpwakeup.c
> new file mode 100644
> index 000000000000..e34ffbfffaf5
> --- /dev/null
> +++ b/arch/x86/kernel/smpwakeup.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/acpi.h>
> +#include <linux/io.h>
> +#include <linux/printk.h>
> +#include <linux/types.h>
> +#include <asm/apic.h>
> +#include <asm/barrier.h>
> +#include <asm/processor.h>
> +
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
> +void __init acpi_setup_mp_wakeup_mailbox(u64 mailbox_paddr)
> +{
> +       acpi_mp_wake_mailbox_paddr =3D mailbox_paddr;
> +       apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
> +}
> +
> +struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(vo=
id)
> +{
> +       return acpi_mp_wake_mailbox;
> +}
>
> --
> 2.43.0
>

