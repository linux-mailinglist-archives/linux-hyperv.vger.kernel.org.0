Return-Path: <linux-hyperv+bounces-7793-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D390FC81796
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Nov 2025 17:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 71EE8346BA0
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Nov 2025 16:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD769314B8C;
	Mon, 24 Nov 2025 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWHTmsXP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FD5314B76
	for <linux-hyperv@vger.kernel.org>; Mon, 24 Nov 2025 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764000195; cv=none; b=EHxcHW2AM+phgnOL9tV2ClArkpqx3gCdoBA2p3NsdLOxnTZl9tplCG1x5IUvQx+2xlo+Ped+RpMnph9arqOW5V27WAHgSrD34NXXaby58QlLaUJSP9kOiGo+w0n5CjRu69d/CwfYargYvaFXpX7xX68mDCL8amGG3XQ5eBSxmpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764000195; c=relaxed/simple;
	bh=oMJyE0KcLUl7Eukdpbve8NlhkKZZZYFaHdrHx2+LWZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zq6Hd+o/SVA99hgUFkJcwkiikO7bRoRzhDWW2juheRyH+dKgHOryqTLIpHCKXVcWXed8WvkfPfWvmI/5jMnmU9R8Vrd7I5cwxTHtObS9AAJPRH2/C6pv5Hr/Ht/VKvTxNF9ekLOQB+JA+OOaD18AAfsyZrmm0c0YBWmpI2tTrmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWHTmsXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1DDC4AF0B
	for <linux-hyperv@vger.kernel.org>; Mon, 24 Nov 2025 16:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764000195;
	bh=oMJyE0KcLUl7Eukdpbve8NlhkKZZZYFaHdrHx2+LWZw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TWHTmsXPHasOtUOaf6arLJvl3epuA9wMKzVu5BzOBJmPZJwPZnY0db/hnP1rE+bvM
	 uJkVkM56rh3QZoaQL0bn2QGpeynbiLlqibrXA2jk3zyyQL1mKkbTyHGRaHNgfGg61b
	 CicnUNJkBH0W2i1DLkjzvPeGERDiatgbPFj43yiyQyq8Ai4ScRL9EBUmrMVMd7ICD6
	 DuEY1DG4/UzyrPx+HLkB2sSq0LU4Hg2wtK82JCbfO2icVEHj3OdBEqdcYJBh/sYJQe
	 ZidgJP+3nYdncbeRxshP+TDeASUM0gWP3E0DFMCmAjipoKT440YRUSkuGJUo7pEDW+
	 PI1CK2Na/Pa7w==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c7660192b0so2992735a34.0
        for <linux-hyperv@vger.kernel.org>; Mon, 24 Nov 2025 08:03:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVyu4bVTnn9PDmUgfotDFfL2IoUVMedF8tIRC843d3nCpp0YEamo2vCoBoWxzwFZV02WQcZ6xRJBB2m4Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGX8qAV1X+CgHCVcmDW65leqRFGXYn5oZiTuzo0TQ+ZKjNFh3J
	OU/HY34dNBwVMDiHn/ZoKAd0MD7HaI3wbY0/NyzTjuLkwtfloG6oOA61WHkzUT4sRYurqhM0xFj
	A1AqmIXEBvjOtu3UMsFXvBQXq096GhmQ=
X-Google-Smtp-Source: AGHT+IHrLLq/ft4ajQ0queolI+e2ulUfO34r2cR6VP5opAwL4VX7a8NvkWVIDc6KNSGCNk4PjZteW2X94ao5xDUqwCk=
X-Received: by 2002:a05:6808:2386:b0:450:cc88:ecdf with SMTP id
 5614622812f47-45115b5d282mr4177229b6e.45.1764000194555; Mon, 24 Nov 2025
 08:03:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117-rneri-wakeup-mailbox-v7-0-4a8b82ab7c2c@linux.intel.com> <20251117-rneri-wakeup-mailbox-v7-7-4a8b82ab7c2c@linux.intel.com>
In-Reply-To: <20251117-rneri-wakeup-mailbox-v7-7-4a8b82ab7c2c@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 24 Nov 2025 17:03:03 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0je4h8BMuwW5bCbuqSwMLdH9yQg0AczrO7ccPZXDsX3tA@mail.gmail.com>
X-Gm-Features: AWmQ_blbdry3NZVG0MbjW02V38mj5pGYZLc03ckPmVqmTrDbtRMX22m-MGG_Jlo
Message-ID: <CAJZ5v0je4h8BMuwW5bCbuqSwMLdH9yQg0AczrO7ccPZXDsX3tA@mail.gmail.com>
Subject: Re: [PATCH v7 7/9] x86/acpi: Add a helper get the address of the
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
> A Hyper-V VTL level 2 guest in a TDX environment needs to map the physica=
l
> page of the ACPI Multiprocessor Wakeup Structure as private (encrypted). =
It
> needs to know the physical address of this structure. Add a helper functi=
on
> to retrieve the address.
>
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
> Changes in v7:
>  - Moved the added function to arch/x86/kernel/acpi/madt_wakeup.c
>  - Dropped Reviewed-by tags from Dexuan and Michael as this patch
>    changed.
>
> Changes in v6:
>  - Added Reviewed-by tag from Dexuan. Thanks!
>
> Changes in v5:
>  - None
>
> Changes in v4:
>  - Renamed function to acpi_get_mp_wakeup_mailbox_paddr().
>  - Added Reviewed-by tag from Michael. Thanks!
>
> Changes in v3:
>  - Introduced this patch
>
> Changes in v2:
>  - N/A
> ---
>  arch/x86/include/asm/acpi.h        | 6 ++++++
>  arch/x86/kernel/acpi/madt_wakeup.c | 5 +++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> index 820df375df79..c4e6459bd56b 100644
> --- a/arch/x86/include/asm/acpi.h
> +++ b/arch/x86/include/asm/acpi.h
> @@ -184,6 +184,7 @@ void __iomem *x86_acpi_os_ioremap(acpi_physical_addre=
ss phys, acpi_size size);
>
>  void acpi_setup_mp_wakeup_mailbox(u64 addr);
>  struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(vo=
id);
> +u64 acpi_get_mp_wakeup_mailbox_paddr(void);
>
>  #else /* !CONFIG_ACPI */
>
> @@ -210,6 +211,11 @@ static inline struct acpi_madt_multiproc_wakeup_mail=
box *acpi_get_mp_wakeup_mail
>         return NULL;
>  }
>
> +static inline u64 acpi_get_mp_wakeup_mailbox_paddr(void)
> +{
> +       return 0;
> +}
> +
>  #endif /* !CONFIG_ACPI */
>
>  #define ARCH_HAS_POWER_INIT    1
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/ma=
dt_wakeup.c
> index 82caf44b45e3..48734e4a6e8f 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -258,3 +258,8 @@ struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_m=
p_wakeup_mailbox(void)
>  {
>         return acpi_mp_wake_mailbox;
>  }
> +
> +u64 acpi_get_mp_wakeup_mailbox_paddr(void)
> +{
> +       return acpi_mp_wake_mailbox_paddr;
> +}
>
> --
> 2.43.0
>

