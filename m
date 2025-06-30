Return-Path: <linux-hyperv+bounces-6053-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F44AEE70F
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jun 2025 20:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848081891F5F
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jun 2025 18:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3C0291C30;
	Mon, 30 Jun 2025 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/BWPyKz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387AE28C853;
	Mon, 30 Jun 2025 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751309949; cv=none; b=rwSMcxdkOdWhgo9S14wqm1wPx1ry2spP7orAwGLGS6l/XsrnDlxuF7KcQyej1kEipd/gH/pJaY96wzDh/nVWr+jSWf4BzFAtL5Uo1M53PnitxWooOZbMHVkK7xPhuq1lC1Sy0kCYNTPT4IvM+Z9bCchAONMhVeHj7vkFIGuRsJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751309949; c=relaxed/simple;
	bh=M1FM4VwEtrNTVg28Bv7xMO2ZMXHTJcEXhSYtxobS5Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiD7x1mUfDRO+ItoDngetz9rXhyBX3Ys5c1sSEvu5an61N6UtHRq6J1CIhPS0IgU9oecRxUIEiyXTFUAqeLOOMq+3AaCfgzT970jl0vbHP7ii3J4ZbTW9zIPrPOWhmQu8V31vLgA39IqH+G6gReJN0ecHKVy4F7807FDJ75QnE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/BWPyKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CF8C4CEF3;
	Mon, 30 Jun 2025 18:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751309948;
	bh=M1FM4VwEtrNTVg28Bv7xMO2ZMXHTJcEXhSYtxobS5Qc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e/BWPyKzKViTZgymKZi7TlX86Bq9iDV0ZrgX7+i4A+r9Lwlb+10UZ7JhDOcVKekYO
	 o9Diychbrie0xoPgSTUhuRotJ7BczGq7vwywlBtec5dULSTPr6eRgPU7S4EqelYx4i
	 NYUgxex8rWgGd8L1XCEwp27+GYyO7n6nPLJM92OPv9vWWHfgo1pZ3zfZgoSjGgptM4
	 FiOgY3pClGHrz9ghrkuElnmktlcfd6RVUAqrFv8y0cUrgZB32+li1Qa5mMH3gr0dhT
	 CkroQWI4rewMk2PdShQSd+raV4kdFxxMbtNmPospwovVotrNOavp32t/VXeYvIUYfc
	 Ribh5PDH7sCHg==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6113f0cafb2so1142484eaf.1;
        Mon, 30 Jun 2025 11:59:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0x1CVvtF8h/0G5S8wFgoVmfwj+6Pwcltfpkpox43LsENz1b1ZBIzf+mjqy5/nfbXcKfXoDDiyEV0Ys9hz@vger.kernel.org, AJvYcCVqvOCwOZj9hnX/A6ae8531VkW3FtazOrcvT03czZO3TOYZo9cQ7YD30bugMT8hlNW4PJI78HZF0f+t@vger.kernel.org, AJvYcCW83ZkddJazHShS1zM8yqZMO3TYRe7acTbfiyHMr8QpuCQH3JulamqUiO1Lc/bW9mYhXw4zxgVt9PqCclvl@vger.kernel.org, AJvYcCX8m/HbgJqwvKBtFBTYA9f2c9BUTNpSQazdvFy4E7P5XLeJcyj3ZIIii+nfxsgJIf6MJDNp2XEvwd3X8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb6bjhUsc1QoG59STDs9l+GwIHcFEcnBARSbz22DBC/D7dk2Jb
	ANDmbWxKq3IorrFZ2vLCzgLSWTglpwyWVJIxgt2HwN/lRENeyYuIjg/eKKuU7Lsal3I7jQigMa/
	IzZ+Tnx9mr56VReEB0hHtHXBQjxqj0pI=
X-Google-Smtp-Source: AGHT+IHEJ9Y+G2jV0lqRzzlxN1lHqmcrhVJmP2S/oDnA8VnrmZH07M+WkfquAq/Ofr98Eg5G/cKMNa+iaMRogkER08Y=
X-Received: by 2002:a05:6820:290f:b0:611:a799:c900 with SMTP id
 006d021491bc7-611b901c5fdmr10076223eaf.2.1751309947946; Mon, 30 Jun 2025
 11:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com> <20250627-rneri-wakeup-mailbox-v5-2-df547b1d196e@linux.intel.com>
In-Reply-To: <20250627-rneri-wakeup-mailbox-v5-2-df547b1d196e@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 30 Jun 2025 20:58:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iw9zi8cZK=2j-fWR4tzYgaSMPYoNHf=F+-51cbkxGYSg@mail.gmail.com>
X-Gm-Features: Ac12FXw1OdI8CIB8KE9tERSq5bMJMJZnNyt0kEwvQnyD939DOR_WjSVE_QixSik
Message-ID: <CAJZ5v0iw9zi8cZK=2j-fWR4tzYgaSMPYoNHf=F+-51cbkxGYSg@mail.gmail.com>
Subject: Re: [PATCH v5 02/10] x86/acpi: Move acpi_wakeup_cpu() and helpers to smpwakeup.c
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Saurabh Sengar <ssengar@linux.microsoft.com>, 
	Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ricardo Neri <ricardo.neri@intel.com>, Yunhong Jiang <yunhong.jiang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 5:35=E2=80=AFAM Ricardo Neri
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

IMV "that can be used by both ACPI and DeviceTree" would sound better.

> No functional changes are intended.
>
> Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

With the above addressed

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Changes since v4:
>  - Removed dependency on CONFIG_OF. It will be added in a later patch.
>    (Rafael)
>  - Rebased on v6.16-rc3.
>
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
> index 71019b3b54ea..e3009cb59928 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1114,6 +1114,13 @@ config X86_LOCAL_APIC
>         depends on X86_64 || SMP || X86_UP_APIC || PCI_MSI
>         select IRQ_DOMAIN_HIERARCHY
>
> +config X86_MAILBOX_WAKEUP
> +       def_bool y
> +       depends on ACPI_MADT_WAKEUP
> +       depends on X86_64
> +       depends on SMP
> +       depends on X86_LOCAL_APIC
> +
>  config ACPI_MADT_WAKEUP
>         def_bool y
>         depends on X86_64
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 0d2a6d953be9..1fce3d20cf2d 100644
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
> index c3ac5ecf3e7d..a7e0158269b0 100644
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
> -static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip, unsigned =
int cpu)
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
> index 000000000000..5089bcda615d
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
> +static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip, unsigned =
int cpu)
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

