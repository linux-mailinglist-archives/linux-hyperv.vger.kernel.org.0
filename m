Return-Path: <linux-hyperv+bounces-5420-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CB0AAECB0
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 22:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27BD9C5C49
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 20:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E11F207A2A;
	Wed,  7 May 2025 20:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOjhVBkM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB8A1F9A89;
	Wed,  7 May 2025 20:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746648599; cv=none; b=aQ/3De7MPdUY+OIJA+DmGNNsxYc7a7pGX5SMFDAmMLr8uw2CLGO7Fuj6Xiks8iujWoQ+3Xsgw/f6hDlnloC1DgzlrKtxmmmlK08rKW2eOY24pZ06+YIKiuibT7mGeEfYSBAjTBli0RjRMdOjfoddGAo4+kd+w/qVDaZccNmwDqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746648599; c=relaxed/simple;
	bh=atHxCy8Py55JYindKN9/Qjx98L55hRysBAeMnjUssrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bs8Xq9qd3onE9dAyCM5Xxyip/a1uSBbqAD/ct6TMiJ83tGBVeyiJo7e3OvhyQs+Nu4ELGEa66QsBXONiLYi3oJTr1xE09UWVUYSbDsa5GKJ+kT+70/rZMWRiWEjnWfJ1ZH6FNxdCEf50OKOFt0p1r7Y7QyOIqS6O069m8rPMso0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOjhVBkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA44C4CEF9;
	Wed,  7 May 2025 20:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746648599;
	bh=atHxCy8Py55JYindKN9/Qjx98L55hRysBAeMnjUssrg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OOjhVBkMvJ3f8wFjHTROonpE3dCngMo4oRd5kNd+aRD0u9x2WqBCD6LAiLf46l7go
	 qa5xZXQkkY0Bff0NIqrt6b91rl+TdF84O8UOoJd4DhcNpBAMzYwf3n00OtJcn46crq
	 HU5zLXM9uKtIYIialOH7Cle1qgYFw4Ilo2ZwYbSKmGXHj1Q7Am0kO8JCWcXd6YyE3E
	 joO9HsEzGZUDyUTdRk7MgkAAXnXeAS061DIm3cxLSE0YjYm/qmpBUcCOCwp1T/Be2t
	 M7CoBwfxuwB75xGaD3KI3mjG3irCy13FYV+YEUWRVCYj6pmLcNYsC3BH3uT+mQB19/
	 93K3zUZyS/o/w==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-605f7d3216bso108883eaf.1;
        Wed, 07 May 2025 13:09:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2pZUfLZm+zVJVBal8P4dkbXi83LDiFH4wlbSq9/xTJDrX+FKdqJXBBFa+emDapE5FV/LEFY1uFQAHoeUr@vger.kernel.org, AJvYcCVaHa1Xb703pT034M7vDrsLpI6wK/6VOlsDGdn877IcUnY3Ha8Mt3tOCY5kKUX6nxdNQeg/sqfHqnRo@vger.kernel.org, AJvYcCXCgDn47WnviZeoBq/mbYb7Xv5G39w6Cau81I0azqezPsvtx5v6fmgoC8X7xpkXwCTcUoiOgWHejUK1BbSr@vger.kernel.org
X-Gm-Message-State: AOJu0YxpCRgHh1PPVVgnAyJsziR2+jbTqKFhpeDf2iAlMJJOup4lKFUA
	lDMQfmUjoG87FJUBjeNz8pgkj+390RTseu7OYUww8CPq7SEMiARqH9Dl0NTd6RbhPuRsnSPTBmK
	4X7IYhSNM4hZg9yB4q3jEU4KW0eY=
X-Google-Smtp-Source: AGHT+IH14wetZ3g0a8hDzjHUUplkprwYJnUrRmH+dON27nja/4sR7NNCWxTdoR/JdykIwxDFaBnn04WRAPPf+fmHKfI=
X-Received: by 2002:a05:6870:7191:b0:2d5:1894:8c29 with SMTP id
 586e51a60fabf-2db5bec1f69mr2635432fac.23.1746648598111; Wed, 07 May 2025
 13:09:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507182227.7421-1-romank@linux.microsoft.com> <20250507182227.7421-3-romank@linux.microsoft.com>
In-Reply-To: <20250507182227.7421-3-romank@linux.microsoft.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 22:09:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jXJtVgEPg7+3-YRkntLzk0kVPkXxKkL_kQpDU_RSsZtg@mail.gmail.com>
X-Gm-Features: ATxdqUEKejmIetuD7KJo-zoIqSWjU6TYZY0ArL1AtLkg4qAmEtwl0FTPT26WiNk
Message-ID: <CAJZ5v0jXJtVgEPg7+3-YRkntLzk0kVPkXxKkL_kQpDU_RSsZtg@mail.gmail.com>
Subject: Re: [PATCH hyperv-next 2/2] arch/x86: Provide the CPU number in the
 wakeup AP callback
To: Roman Kisel <romank@linux.microsoft.com>
Cc: ardb@kernel.org, bp@alien8.de, brgerst@gmail.com, 
	dave.hansen@linux.intel.com, decui@microsoft.com, dimitri.sivanich@hpe.com, 
	gautham.shenoy@amd.com, haiyangz@microsoft.com, hpa@zytor.com, 
	imran.f.khan@oracle.com, jacob.jun.pan@linux.intel.com, jpoimboe@kernel.org, 
	justin.ernst@hpe.com, kprateek.nayak@amd.com, kyle.meyer@hpe.com, 
	kys@microsoft.com, lenb@kernel.org, mhklinux@outlook.com, mingo@redhat.com, 
	nikunj@amd.com, papaluri@amd.com, patryk.wlazlyn@linux.intel.com, 
	peterz@infradead.org, rafael@kernel.org, russ.anderson@hpe.com, 
	sohil.mehta@intel.com, steve.wahl@hpe.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, tiala@microsoft.com, wei.liu@kernel.org, 
	yuehaibing@huawei.com, linux-acpi@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com, 
	sunilmut@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 8:22=E2=80=AFPM Roman Kisel <romank@linux.microsoft.=
com> wrote:
>
> When starting APs, confidential guests and paravisor guests
> need to know the CPU number, and the pattern of using the linear
> search has emerged in several places. With N processors that leads
> to the O(N^2) time complexity.
>
> Provide the CPU number in the AP wake up callback so that one can
> get the CPU number in constant time.
>
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

For the ACPI bits

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and I'm assuming that the x86 folks will take care of this.

Thanks!

> ---
>  arch/x86/coco/sev/core.c             | 13 ++-----------
>  arch/x86/hyperv/hv_vtl.c             | 12 ++----------
>  arch/x86/hyperv/ivm.c                | 15 ++-------------
>  arch/x86/include/asm/apic.h          |  8 ++++----
>  arch/x86/include/asm/mshyperv.h      |  5 +++--
>  arch/x86/kernel/acpi/madt_wakeup.c   |  2 +-
>  arch/x86/kernel/apic/apic_noop.c     |  8 +++++++-
>  arch/x86/kernel/apic/apic_numachip.c |  2 +-
>  arch/x86/kernel/apic/x2apic_uv_x.c   |  2 +-
>  arch/x86/kernel/smpboot.c            | 10 +++++-----
>  10 files changed, 28 insertions(+), 49 deletions(-)
>
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index b0c1a7a57497..7780d55d1833 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -1177,7 +1177,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_are=
a *vmsa, int apic_id)
>                 free_page((unsigned long)vmsa);
>  }
>
> -static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
> +static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip, u=
nsigned int cpu)
>  {
>         struct sev_es_save_area *cur_vmsa, *vmsa;
>         struct ghcb_state state;
> @@ -1185,7 +1185,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsi=
gned long start_ip)
>         unsigned long flags;
>         struct ghcb *ghcb;
>         u8 sipi_vector;
> -       int cpu, ret;
> +       int ret;
>         u64 cr4;
>
>         /*
> @@ -1206,15 +1206,6 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, uns=
igned long start_ip)
>
>         /* Override start_ip with known protected guest start IP */
>         start_ip =3D real_mode_header->sev_es_trampoline_start;
> -
> -       /* Find the logical CPU for the APIC ID */
> -       for_each_present_cpu(cpu) {
> -               if (arch_match_cpu_phys_id(cpu, apic_id))
> -                       break;
> -       }
> -       if (cpu >=3D nr_cpu_ids)
> -               return -EINVAL;
> -
>         cur_vmsa =3D per_cpu(sev_vmsa, cpu);
>
>         /*
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 2f32ac1ae40e..3d149a2ca4c8 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -211,17 +211,9 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, =
int cpu, u64 eip_ignored)
>         return ret;
>  }
>
> -static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_e=
ip)
> +static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_e=
ip, unsigned int cpu)
>  {
> -       int vp_index, cpu;
> -
> -       /* Find the logical CPU for the APIC ID */
> -       for_each_present_cpu(cpu) {
> -               if (arch_match_cpu_phys_id(cpu, apicid))
> -                       break;
> -       }
> -       if (cpu >=3D nr_cpu_ids)
> -               return -EINVAL;
> +       int vp_index;
>
>         pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
>         vp_index =3D hv_apicid_to_vp_index(apicid);
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 0cc239cdb4da..e21557b24d19 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -289,7 +289,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area =
*vmsa)
>                 free_page((unsigned long)vmsa);
>  }
>
> -int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip)
> +int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, unsigned int cpu=
)
>  {
>         struct sev_es_save_area *vmsa =3D (struct sev_es_save_area *)
>                 __get_free_page(GFP_KERNEL | __GFP_ZERO);
> @@ -298,7 +298,7 @@ int hv_snp_boot_ap(u32 apic_id, unsigned long start_i=
p)
>         u64 ret, retry =3D 5;
>         struct hv_enable_vp_vtl *start_vp_input;
>         unsigned long flags;
> -       int cpu, vp_index;
> +       int vp_index;
>
>         if (!vmsa)
>                 return -ENOMEM;
> @@ -308,17 +308,6 @@ int hv_snp_boot_ap(u32 apic_id, unsigned long start_=
ip)
>         if (vp_index < 0 || vp_index > ms_hyperv.max_vp_index)
>                 return -EINVAL;
>
> -       /*
> -        * Find the Linux CPU number for addressing the per-CPU data, and=
 it
> -        * might not be the same as APIC ID.
> -        */
> -       for_each_present_cpu(cpu) {
> -               if (arch_match_cpu_phys_id(cpu, apic_id))
> -                       break;
> -       }
> -       if (cpu >=3D nr_cpu_ids)
> -               return -EINVAL;
> -
>         native_store_gdt(&gdtr);
>
>         vmsa->gdtr.base =3D gdtr.address;
> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> index c903d358405d..eaf43d446203 100644
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -313,9 +313,9 @@ struct apic {
>         u32     (*get_apic_id)(u32 id);
>
>         /* wakeup_secondary_cpu */
> -       int     (*wakeup_secondary_cpu)(u32 apicid, unsigned long start_e=
ip);
> +       int     (*wakeup_secondary_cpu)(u32 apicid, unsigned long start_e=
ip, unsigned int cpu);
>         /* wakeup secondary CPU using 64-bit wakeup point */
> -       int     (*wakeup_secondary_cpu_64)(u32 apicid, unsigned long star=
t_eip);
> +       int     (*wakeup_secondary_cpu_64)(u32 apicid, unsigned long star=
t_eip, unsigned int cpu);
>
>         char    *name;
>  };
> @@ -333,8 +333,8 @@ struct apic_override {
>         void    (*send_IPI_self)(int vector);
>         u64     (*icr_read)(void);
>         void    (*icr_write)(u32 low, u32 high);
> -       int     (*wakeup_secondary_cpu)(u32 apicid, unsigned long start_e=
ip);
> -       int     (*wakeup_secondary_cpu_64)(u32 apicid, unsigned long star=
t_eip);
> +       int     (*wakeup_secondary_cpu)(u32 apicid, unsigned long start_e=
ip, unsigned int cpu);
> +       int     (*wakeup_secondary_cpu_64)(u32 apicid, unsigned long star=
t_eip, unsigned int cpu);
>  };
>
>  /*
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 0b9a3a307d06..5ec92e3e2e37 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -268,11 +268,12 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct=
 hv_interrupt_entry *entry);
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  bool hv_ghcb_negotiate_protocol(void);
>  void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason)=
;
> -int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip);
> +int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, unsigned int cpu=
);
>  #else
>  static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
>  static inline void hv_ghcb_terminate(unsigned int set, unsigned int reas=
on) {}
> -static inline int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip) { =
return 0; }
> +static inline int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip,
> +               unsigned int cpu) { return 0; }
>  #endif
>
>  #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/ma=
dt_wakeup.c
> index f36f28405dcc..6d7603511f52 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -126,7 +126,7 @@ static int __init acpi_mp_setup_reset(u64 reset_vecto=
r)
>         return 0;
>  }
>
> -static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
> +static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip, unsigned =
int cpu)
>  {
>         if (!acpi_mp_wake_mailbox_paddr) {
>                 pr_warn_once("No MADT mailbox: cannot bringup secondary C=
PUs. Booting with kexec?\n");
> diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic=
_noop.c
> index b5bb7a2e8340..58abb941c45b 100644
> --- a/arch/x86/kernel/apic/apic_noop.c
> +++ b/arch/x86/kernel/apic/apic_noop.c
> @@ -27,7 +27,13 @@ static void noop_send_IPI_allbutself(int vector) { }
>  static void noop_send_IPI_all(int vector) { }
>  static void noop_send_IPI_self(int vector) { }
>  static void noop_apic_icr_write(u32 low, u32 id) { }
> -static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip=
) { return -1; }
> +
> +static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip=
,
> +       unsigned int cpu)
> +{
> +       return -1;
> +}
> +
>  static u64 noop_apic_icr_read(void) { return 0; }
>  static u32 noop_get_apic_id(u32 apicid) { return 0; }
>  static void noop_apic_eoi(void) { }
> diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/=
apic_numachip.c
> index 16410f087b7a..333536b89bde 100644
> --- a/arch/x86/kernel/apic/apic_numachip.c
> +++ b/arch/x86/kernel/apic/apic_numachip.c
> @@ -56,7 +56,7 @@ static void numachip2_apic_icr_write(int apicid, unsign=
ed int val)
>         numachip2_write32_lcsr(NUMACHIP2_APIC_ICR, (apicid << 12) | val);
>  }
>
> -static int numachip_wakeup_secondary(u32 phys_apicid, unsigned long star=
t_rip)
> +static int numachip_wakeup_secondary(u32 phys_apicid, unsigned long star=
t_rip, unsigned int cpu)
>  {
>         numachip_apic_icr_write(phys_apicid, APIC_DM_INIT);
>         numachip_apic_icr_write(phys_apicid, APIC_DM_STARTUP |
> diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2=
apic_uv_x.c
> index 7fef504ca508..15209f220e1f 100644
> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
> @@ -667,7 +667,7 @@ static __init void build_uv_gr_table(void)
>         }
>  }
>
> -static int uv_wakeup_secondary(u32 phys_apicid, unsigned long start_rip)
> +static int uv_wakeup_secondary(u32 phys_apicid, unsigned long start_rip,=
 unsigned int cpu)
>  {
>         unsigned long val;
>         int pnode;
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index d6cf1e23c2a3..d52e9238e9fd 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -695,7 +695,7 @@ static void send_init_sequence(u32 phys_apicid)
>  /*
>   * Wake up AP by INIT, INIT, STARTUP sequence.
>   */
> -static int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long =
start_eip)
> +static int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long =
start_eip, unsigned int cpu)
>  {
>         unsigned long send_status =3D 0, accept_status =3D 0;
>         int num_starts, j, maxlvt;
> @@ -842,7 +842,7 @@ int common_cpu_up(unsigned int cpu, struct task_struc=
t *idle)
>   * Returns zero if startup was successfully sent, else error code from
>   * ->wakeup_secondary_cpu.
>   */
> -static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
> +static int do_boot_cpu(u32 apicid, unsigned int cpu, struct task_struct =
*idle)
>  {
>         unsigned long start_ip =3D real_mode_header->trampoline_start;
>         int ret;
> @@ -896,11 +896,11 @@ static int do_boot_cpu(u32 apicid, int cpu, struct =
task_struct *idle)
>          * - Use an INIT boot APIC message
>          */
>         if (apic->wakeup_secondary_cpu_64)
> -               ret =3D apic->wakeup_secondary_cpu_64(apicid, start_ip);
> +               ret =3D apic->wakeup_secondary_cpu_64(apicid, start_ip, c=
pu);
>         else if (apic->wakeup_secondary_cpu)
> -               ret =3D apic->wakeup_secondary_cpu(apicid, start_ip);
> +               ret =3D apic->wakeup_secondary_cpu(apicid, start_ip, cpu)=
;
>         else
> -               ret =3D wakeup_secondary_cpu_via_init(apicid, start_ip);
> +               ret =3D wakeup_secondary_cpu_via_init(apicid, start_ip, c=
pu);
>
>         /* If the wakeup mechanism failed, cleanup the warm reset vector =
*/
>         if (ret)
> --
> 2.43.0
>

