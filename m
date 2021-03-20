Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A475342CDD
	for <lists+linux-hyperv@lfdr.de>; Sat, 20 Mar 2021 13:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhCTMwj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 20 Mar 2021 08:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhCTMw2 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 20 Mar 2021 08:52:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5E2361975;
        Sat, 20 Mar 2021 12:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616244747;
        bh=FXeHEEFPZu+Z4OujvA8/CNPvD0oljphMbhJMuOs+OXM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K1bCLgGHIESUpuy8gK8SpKrBsiI4KgDJFRhoPxjusuXnUlSivdfgWm4zq4Rod8Oo3
         7Mrm8Tb9XocWRJ587fu3susWkesvhYU7/0pfNilGD+BCA3Di2bc3LlaVYhCjqSWXuo
         VKDsgNE5YShjld+XOx+10Wv27MNwq01zur5FVzqZKwZiARO6NILQmdoOshYy8eTqyF
         aydtyunWmoU/vVTUKfMd57nh/J/0dZbOq4uZ9nYmpb6Z6kyA43uRwZFdR2kl1t4CSu
         lkx8s8QwVetVwRB/O4fDD5TwfbqsRxwjaE+K/x5UxIPaTenvtQC1eWdLWJ3i/evqe8
         P/CqJjQtlrC2A==
Received: by mail-ot1-f53.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so11194869ota.9;
        Sat, 20 Mar 2021 05:52:27 -0700 (PDT)
X-Gm-Message-State: AOAM5307L8ewCbJ/UF8yrcHbol0KjUE1DsDCLtSZUUEshbhX+r7SvMfO
        w5JUMNAT01bvMX3yKWhHEyy1XTlHB9aSgqa5Efc=
X-Google-Smtp-Source: ABdhPJytWWTHbNfc/Z6ZiNhGc5dEtnzbBd5XnL42oX7cqny6BlJyDJiN6PM6uRjOYArjqYeBxwpkoKmLUKXyzx1BzqQ=
X-Received: by 2002:a05:6830:14c1:: with SMTP id t1mr4831024otq.305.1616244747072;
 Sat, 20 Mar 2021 05:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210319161956.2838291-1-boqun.feng@gmail.com> <20210319161956.2838291-2-boqun.feng@gmail.com>
In-Reply-To: <20210319161956.2838291-2-boqun.feng@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 20 Mar 2021 13:52:10 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2HVMiqJWc3kGi9j1CNNzVT5OFaeZaXxpAY42yu8Q-hvQ@mail.gmail.com>
Message-ID: <CAK8P3a2HVMiqJWc3kGi9j1CNNzVT5OFaeZaXxpAY42yu8Q-hvQ@mail.gmail.com>
Subject: Re: [RFC 1/2] arm64: PCI: Allow use arch-specific pci sysdata
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Clint Sbisa <csbisa@amazon.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Mar 19, 2021 at 5:22 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> Currently, if an architecture selects CONFIG_PCI_DOMAINS_GENERIC, the
> ->sysdata in bus and bridge will be treated as struct pci_config_window,
> which is created by generic ECAM using the data from acpi.
>
> However, for a virtualized PCI bus, there might be no enough data in of
> or acpi table to create a pci_config_window. This is similar to the case
> where CONFIG_PCI_DOMAINS_GENERIC=n, IOW, architectures use their own
> structure for sysdata, so no apci table lookup is required.
>
> In order to enable Hyper-V's virtual PCI (which doesn't have acpi table
> entry for PCI) on ARM64 (which selects CONFIG_PCI_DOMAINS_GENERIC), we
> introduce arch-specific pci sysdata (similar to the one for x86) for
> ARM64, and allow the core PCI code to detect the type of sysdata at the
> runtime. The latter is achieved by adding a pci_ops::use_arch_sysdata
> field.
>
> Originally-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>

I think this takes it in the opposite direction of where it should be going.

> ---
>  arch/arm64/include/asm/pci.h | 29 +++++++++++++++++++++++++++++
>  arch/arm64/kernel/pci.c      | 15 ++++++++++++---
>  include/linux/pci.h          |  3 +++
>  3 files changed, 44 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> index b33ca260e3c9..dade061a0658 100644
> --- a/arch/arm64/include/asm/pci.h
> +++ b/arch/arm64/include/asm/pci.h
> @@ -22,6 +22,16 @@
>
>  extern int isa_dma_bridge_buggy;
>
> +struct pci_sysdata {
> +       int domain;     /* PCI domain */
> +       int node;       /* NUMA Node */
> +#ifdef CONFIG_ACPI
> +       struct acpi_device *companion;  /* ACPI companion device */
> +#endif
> +#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> +       void *fwnode;                   /* IRQ domain for MSI assignment */
> +#endif
> +};

I think none of these members belong into sysdata or architecture specific
code. The fact that a pci_host_bridge belongs to a particular NUMA node
or i associated with a firmware description is neither specific to a
host bridge implementation nor a CPU instruction set!

Moreover, you cannot assume that all PCI host bridges on any given
architecture can share the pci_sysdata pointer, it is purely specific to
the bridge driver.

A good start would be to move the members (one at a time) into struct
pci_host_bridge and out of the sysdata of individual host bridge drivers.

> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 1006ed2d7c60..63d420d57e63 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -74,15 +74,24 @@ struct acpi_pci_generic_root_info {
>  int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
>  {
>         struct pci_config_window *cfg = bus->sysdata;
> -       struct acpi_device *adev = to_acpi_device(cfg->parent);
> -       struct acpi_pci_root *root = acpi_driver_data(adev);
> +       struct pci_sysdata *sd = bus->sysdata;
> +       struct acpi_device *adev;
> +       struct acpi_pci_root *root;

There should be no reason to add even most code to this file,
it should in fact become empty as it gets generalized more.

        Arnd
