Return-Path: <linux-hyperv+bounces-7792-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D3AC81757
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Nov 2025 17:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CE014E53AF
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Nov 2025 16:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E8F3148AC;
	Mon, 24 Nov 2025 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAA428Cq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711D5283CBF
	for <linux-hyperv@vger.kernel.org>; Mon, 24 Nov 2025 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764000083; cv=none; b=LlgMpAEa+ymEDYVujM/GR6RDl1UTKT9odGPeTLLmtIleTJ8z4DqVFFQvQK/qwNJ2tW2yTdnaz3GqYw0HfcpwCZUnJ6n7etZHYqJe5GxwbPXeOPO63UrvMrrgYVgQndsb+c24vVela0sthZJPSzCnD3aB+pzOO/P7yD0eJ7DJfyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764000083; c=relaxed/simple;
	bh=BxNg8gs7WNaoKvLGFRKTqLXUTtsfWM5hG3yIT0h6Ccc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vtqvxhzvk8HQToMVJZ4agNxiJS0wCDP5HPm5gmOSLQi1o7lQQvYUA9gSbIL3v+oI135hQPKxbzNgPjftxgq+5iNlwR61Pvko9lyEK+2LgCYthSRkmFYexXxlKQYLtUHLKCFFMAYEPz+hfhCx17mnkpn5Dq5fRipLyCqF/gF5Y9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAA428Cq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F024C2BC86
	for <linux-hyperv@vger.kernel.org>; Mon, 24 Nov 2025 16:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764000083;
	bh=BxNg8gs7WNaoKvLGFRKTqLXUTtsfWM5hG3yIT0h6Ccc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fAA428Cq8fABOVJq0VpMm0c57ytXlW/e61UozuRE0IDDII4Bn/sWmrozVTyYHTXFX
	 KMFtCzOgkqNQ1OEL4lY2p1W23MqolBBCazFWioabUybV4ZafndUEHy3ErjpjZ2uc7c
	 idpMExGQnv9P9LDbby2sRcoVRpNRLKJaJBAQjrekgofMRMY84Mo9WGhvzSQW5vV3XH
	 vX33KkrJ6mS2LhIwGweTtefxUMLUm66AdUn4lFhOU3IrtCOO0iDJ9Vg/u4S9nx/oST
	 Fe1/yvkMObmdTYHzVVaVfvNADOuUP17JdHOPIpGdwG7iB0glTojIgG/oCBaZKD6X9n
	 spLTvIRKb7w7w==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-65760bbd866so621657eaf.3
        for <linux-hyperv@vger.kernel.org>; Mon, 24 Nov 2025 08:01:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1Y371S5DWwNRt4zyOQXIBTX1pS9EagWH7rRG2v1y4W3Ko8iLxEEL0QAl921oVQW2kMHStXkw3mK64asQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+QEeW7EcElc+O62QPwCR1SZDNwd8PQZB/TOaA7UPEMiib6GOs
	iiw2S5L5PcWMolo9wjdNZ+uPNQjpH8f5g+BxtA/qZ/lgeBWMoNuX2gLBfrnEefB+C8Jvf/4q4u+
	S5GInod+D5+rIKbIL/JEYOYA7Dnv4jlM=
X-Google-Smtp-Source: AGHT+IEvm2FWxa2fcKAG3q3fnxyGT9utxHEMot9Bx/M+VGHVwX7ZA+SGpfVh77Zi4cGoL8rb3JZFFIMv0u2FP8+7mDY=
X-Received: by 2002:a05:6820:4cc7:b0:657:5723:76c8 with SMTP id
 006d021491bc7-657925458ecmr4757740eaf.6.1764000082175; Mon, 24 Nov 2025
 08:01:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117-rneri-wakeup-mailbox-v7-0-4a8b82ab7c2c@linux.intel.com> <20251117-rneri-wakeup-mailbox-v7-1-4a8b82ab7c2c@linux.intel.com>
In-Reply-To: <20251117-rneri-wakeup-mailbox-v7-1-4a8b82ab7c2c@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 24 Nov 2025 17:01:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gd_6b6s4aEpSvdfb4-+AULTWkqQqM3OE1eg5XzYaxQFQ@mail.gmail.com>
X-Gm-Features: AWmQ_bm4sOABo--PUFLL3Fnx287B9QjmRWcdT31tXqkGzNeqhEPx9y0Ws0-iwLc
Message-ID: <CAJZ5v0gd_6b6s4aEpSvdfb4-+AULTWkqQqM3OE1eg5XzYaxQFQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] x86/acpi: Add functions to setup and access the
 wakeup mailbox
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Saurabh Sengar <ssengar@linux.microsoft.com>, 
	Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kas@kernel.org>, linux-hyperv@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 6:04=E2=80=AFPM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> Systems that describe hardware using DeviceTree graphs may enumerate and
> implement the wakeup mailbox as defined in the ACPI specification but do
> not otherwise depend on ACPI. Expose functions to setup and access the
> location of the wakeup mailbox from outside ACPI code.
>
> The function acpi_setup_mp_wakeup_mailbox() stores the physical address o=
f
> the mailbox and updates the wakeup_secondary_cpu_64() APIC callback.
>
> The function acpi_madt_multiproc_wakeup_mailbox() returns a pointer to th=
e
> mailbox.
>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
> Changes in v7:
>  - Moved function declarations to arch/x86/include/asm/acpi.h
>  - Added stubs for !CONFIG_ACPI.
>  - Do not use these new functions in madt_wakeup.c.
>  - Dropped Acked-by and Reviewed-by tags from Rafael and Dexuan as this
>    patch changed.
>
> Changes in v6:
>  - Fixed grammar error in the subject of the patch. (Rafael)
>  - Added Acked-by tag from Rafael. Thanks!
>  - Added Reviewed-by tag from Dexuan. Thanks!
>
> Changes in v5:
>  - None
>
> Changes in v4:
>  - Squashed the two first patches of the series into one, both introduce
>    helper functions. (Rafael)
>  - Renamed setup_mp_wakeup_mailbox() as acpi_setup_mp_wakeup_mailbox().
>    (Rafael)
>  - Dropped the function prototype for !CONFIG_X86_64. (Rafael)
>
> Changes in v3:
>  - Introduced this patch.
>
> Changes in v2:
>  - N/A
> ---
>  arch/x86/include/asm/acpi.h        | 10 ++++++++++
>  arch/x86/kernel/acpi/madt_wakeup.c | 11 +++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> index a03aa6f999d1..820df375df79 100644
> --- a/arch/x86/include/asm/acpi.h
> +++ b/arch/x86/include/asm/acpi.h
> @@ -182,6 +182,9 @@ void __iomem *x86_acpi_os_ioremap(acpi_physical_addre=
ss phys, acpi_size size);
>  #define acpi_os_ioremap acpi_os_ioremap
>  #endif
>
> +void acpi_setup_mp_wakeup_mailbox(u64 addr);
> +struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(vo=
id);
> +
>  #else /* !CONFIG_ACPI */
>
>  #define acpi_lapic 0
> @@ -200,6 +203,13 @@ static inline u64 x86_default_get_root_pointer(void)
>         return 0;
>  }
>
> +static inline void acpi_setup_mp_wakeup_mailbox(u64 addr) { }
> +
> +static inline struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wak=
eup_mailbox(void)
> +{
> +       return NULL;
> +}
> +
>  #endif /* !CONFIG_ACPI */
>
>  #define ARCH_HAS_POWER_INIT    1
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/ma=
dt_wakeup.c
> index 6d7603511f52..82caf44b45e3 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -247,3 +247,14 @@ int __init acpi_parse_mp_wake(union acpi_subtable_he=
aders *header,
>
>         return 0;
>  }
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

