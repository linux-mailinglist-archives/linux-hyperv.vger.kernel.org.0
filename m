Return-Path: <linux-hyperv+bounces-5343-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92B5AA9015
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 May 2025 11:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399783A774B
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 May 2025 09:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953351FDA6A;
	Mon,  5 May 2025 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdqKkyld"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629C51FC104;
	Mon,  5 May 2025 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746438624; cv=none; b=jCwPd3lVQmN7Tg5w6A2OSdgSrK0Z8V8q+CEY5lg0guH/NCpiPPazFXk9MU77jLzp6MSzEhRZRAoqtM8alM2zPgkGTFpGEcwWyJd19odN0/3aIZiJNmPrqnkbrZu+FsRL1mY8bloGkykapj1Oy3JPxNhTE1Q32t9FJTpTVeekDNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746438624; c=relaxed/simple;
	bh=xyNkvtslKHGj6JJUlrcFQwYQudHJaqcW3/RXrny9o0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfQv8BUJ2vhqfuMbLtN3yacUvnS6MhNLdKs3i5MRrWywuIBrS2rbQBMDPTtkChAsW/Rmbav2ke0/pSZYrzPZqQ5i242eZGCTMImou5sq4LGTy9n/hytU27H6gKYW2Bhojz2Xy5AX75co1Mr8enXdGmAyDwvRtDfvCYfZZj1Ff7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdqKkyld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE61C4CEF0;
	Mon,  5 May 2025 09:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746438623;
	bh=xyNkvtslKHGj6JJUlrcFQwYQudHJaqcW3/RXrny9o0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VdqKkyldwr6C0AjZBEWX0c4a5iCB/FtV5oWWZOPhFiCZvkrPReHgLynFOse6P7RgK
	 xB0gl+zHJDOjXhHeTixnOw8Xq1RTXsYuwTDQ5IOYEMlPPDsDOi/Gk14ec2fXfUddf3
	 /xkwcpv7egkXU4AgYvKMRYmvzauzJefn7h/aWGRHHR7plsLG+Z2gFLKier2zFKh+BN
	 DDqlaIlyTkvCp7H6H/qvh2Q/eBpJ5HhRN1v+4xRaPyoABD+Ky+cWbMadxTzomm/byA
	 eFXa7M5xSzHxv26OaFMqhjPnTpK+2bzkOLhfX7Wm1QJKR6RjJMqrI2zXKaAdyr07eO
	 mH8V1LsqXgbgg==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2d4e91512b4so2518919fac.1;
        Mon, 05 May 2025 02:50:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6haZDk7J0CnYJBCsEGnAg+bZS31Az01HQ6hBVkoz/v7Gt9lEOP9RFN9c23z7kVezkEOFZeMofHmhUMA==@vger.kernel.org, AJvYcCW8WAlNsSpQ8jvstnvtHBls7J5xquf7b3IA3q9T6/KJFNuW+cgQdFCfQSKLCQX4I+uQ1QCYjw9qn4ZXrF/i@vger.kernel.org, AJvYcCXNYZey0Js8+DP1i9vkNO4CCy6YmF/io1pBHlmtwHMzyW+cQG0zlbL6BgTlwEz4lhLQ+uSMcJ6Tw7qT@vger.kernel.org, AJvYcCXfrkMwT8zQ1++5+lHtq/y+bgvsvSzXhxrxodkn+Lu205upAtXIrEdOg8h6DKgO/XL8IHYni4YCiCiy65Xi@vger.kernel.org
X-Gm-Message-State: AOJu0YxpUHDe2lSpvwHikbqg9z4kEBDBIfiSaHsn5nAasOhSbGY+ToPC
	lJptTKo3H+U3CHj3b1EpHQjKBySR4zTpeSxHD3vpUdJ1p7Tf3WfulW2MmzbPv5NtKgoSGkHHThb
	orFvrjLnx2PAwC7CJ81UP1HiXmpI=
X-Google-Smtp-Source: AGHT+IEbp+k5+o2JOgK5gAOvr06vFjcOrkxIY+uU1aZ/s1RgB369NC8JEtjjJebp1ckQu/uB3ghNe8BjSnyzBcwjw1c=
X-Received: by 2002:a05:6871:78e:b0:2c1:6663:f603 with SMTP id
 586e51a60fabf-2dae83f34fcmr3628380fac.19.1746438623034; Mon, 05 May 2025
 02:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com> <20250503191515.24041-2-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20250503191515.24041-2-ricardo.neri-calderon@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 May 2025 11:50:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0grwGDrwFSbtXzia6ijd4DTOpU3b6RWR4JPfJmXqz78xQ@mail.gmail.com>
X-Gm-Features: ATxdqUEBtlssjD1hWqURJ8uHShyMtKDEe5MJtTBEVToiuOdPd7lxfnsRPlG8Ons
Message-ID: <CAJZ5v0grwGDrwFSbtXzia6ijd4DTOpU3b6RWR4JPfJmXqz78xQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/13] x86/acpi: Add a helper function to setup the
 wakeup mailbox
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
> In preparation to move the functionality to wake secondary CPUs up out of
> the ACPI code, add a helper function that stores the physical address of
> the mailbox and updates the wakeup_secondary_cpu_64() APIC callback.
>
> There is a slight change in behavior: now the APIC callback is updated
> before configuring CPU hotplug offline behavior. This is fine as the APIC
> callback continues to be updated unconditionally, regardless of the
> restriction on CPU offlining.
>
> The wakeup mailbox is only supported for CONFIG_X86_64 and needed only wi=
th
> CONFIG_SMP=3Dy.
>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v2:
>  - Introduced this patch.
>
> Changes since v1:
>  - N/A
> ---
>  arch/x86/include/asm/smp.h         |  4 ++++
>  arch/x86/kernel/acpi/madt_wakeup.c | 10 +++++++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index 0c1c68039d6f..3622951d2ee0 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -146,6 +146,10 @@ static inline struct cpumask *cpu_l2c_shared_mask(in=
t cpu)
>         return per_cpu(cpu_l2c_shared_map, cpu);
>  }
>
> +#ifdef CONFIG_X86_64
> +void setup_mp_wakeup_mailbox(u64 addr);
> +#endif

The #ifdef is only necessary if you are going to provide an
alternative for builds in which the symbol is unset.

> +
>  #else /* !CONFIG_SMP */
>  #define wbinvd_on_cpu(cpu)     wbinvd()
>  static inline int wbinvd_on_all_cpus(void)
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/ma=
dt_wakeup.c
> index f36f28405dcc..04de3db307de 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -227,7 +227,7 @@ int __init acpi_parse_mp_wake(union acpi_subtable_hea=
ders *header,
>
>         acpi_table_print_madt_entry(&header->common);
>
> -       acpi_mp_wake_mailbox_paddr =3D mp_wake->mailbox_address;
> +       setup_mp_wakeup_mailbox(mp_wake->mailbox_address);

I'd prefer acpi_setup_mp_wakeup_mailbox().

>
>         if (mp_wake->version >=3D ACPI_MADT_MP_WAKEUP_VERSION_V1 &&
>             mp_wake->header.length >=3D ACPI_MADT_MP_WAKEUP_SIZE_V1) {
> @@ -243,7 +243,11 @@ int __init acpi_parse_mp_wake(union acpi_subtable_he=
aders *header,
>                 acpi_mp_disable_offlining(mp_wake);
>         }
>
> -       apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
> -
>         return 0;
>  }
> +
> +void __init setup_mp_wakeup_mailbox(u64 mailbox_paddr)
> +{
> +       acpi_mp_wake_mailbox_paddr =3D mailbox_paddr;
> +       apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
> +}
> --
> 2.43.0
>
>

