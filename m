Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507B13A2EDF
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jun 2021 17:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhFJPDS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Jun 2021 11:03:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230332AbhFJPDR (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Jun 2021 11:03:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D60C61406;
        Thu, 10 Jun 2021 15:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623337281;
        bh=B8YUrdGtvh1GlX9DXPYnLvrAiv1MGNWen6/6xy5xNj0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZOOKAHQiUBk7P4XwofeAx9bYWQKbqO2Y4+luqnSOASsoYUCFy7CkXg/H5OaGC1GyJ
         yzRam3hEWbUK2dAXhmukaB+YzI9AbDvXVYANRTARIvfLKa03eXFEjyYDCtqaQjt2hl
         0IMAjOxWnoWmIhYvh6jl5/ZvEJaMK6SNbvqNWc02vhyjPCcy35jQNSFlUQcZ2dLPqD
         sHFPhNeBHPuo9MDNeYvAt1DziEiU8Vg199tHAZZYCDGOsP5360qwF224ioWL7UTibn
         igH3wAqxExu+RCXjqWJkxZaswAnquByLVHSHqZCLiJ78s+gQROtrgurLGNODv817MY
         MHXDpw4gnFctg==
Received: by mail-oi1-f173.google.com with SMTP id r17so2422692oic.7;
        Thu, 10 Jun 2021 08:01:21 -0700 (PDT)
X-Gm-Message-State: AOAM533RdzuBF9F50uzpSSvex/19/SyV5W3ycw3VTDjlusx5+wR7U6b3
        JXvEElh6h1fyeki+536XpgGBd64wcI/uNuNw3jk=
X-Google-Smtp-Source: ABdhPJxibo6JABGA7bE+zFOtcntl98rQdpSxCh/xGWjytPaZ+l9cdgGdrTsv+YQbvAM2joKHZSGRQzNlq6GWTM6SPeM=
X-Received: by 2002:aca:eb55:: with SMTP id j82mr3640527oih.174.1623337280475;
 Thu, 10 Jun 2021 08:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210609163211.3467449-1-boqun.feng@gmail.com>
In-Reply-To: <20210609163211.3467449-1-boqun.feng@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 10 Jun 2021 17:01:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGwa28T5Cr_64OC4rqE3qhwWQz+BJPwjdr54G-pVf9+pA@mail.gmail.com>
Message-ID: <CAMj1kXGwa28T5Cr_64OC4rqE3qhwWQz+BJPwjdr54G-pVf9+pA@mail.gmail.com>
Subject: Re: [RFC v3 0/7] PCI: hv: Support host bridge probing on ARM64
To:     Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org, PCI <linux-pci@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Clint Sbisa <csbisa@amazon.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 9 Jun 2021 at 18:32, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> Hi Bjorn, Arnd and Marc,
>

Instead of cc'ing Arnd, you cc'ed me (Ard)

> This is the v3 for the preparation of virtual PCI support on Hyper-V
> ARM64. Previous versions:
>
> v1:     https://lore.kernel.org/lkml/20210319161956.2838291-1-boqun.feng@gmail.com/
> v2:     https://lore.kernel.org/lkml/20210503144635.2297386-1-boqun.feng@gmail.com/
>
> Changes since last version:
>
> *       Use a sentinel value approach instead of calling
>         pci_bus_find_domain_nr() for every CONFIG_PCI_DOMAIN_GENERIC=y
>         arch as per suggestion from
>
> *       Improve the commit log and comments for patch #6.
>
> *       Rebase to the latest mainline.
>
> The basic problem we need to resolve is that ARM64 is an arch with
> PCI_DOMAINS_GENERIC=y, so the bus sysdata is pci_config_window. However,
> Hyper-V PCI provides a paravirtualized PCI interface, so there is no
> actual pci_config_window for a PCI host bridge, so no information can be
> retrieve from the pci_config_window of a Hyper-V virtual PCI bus. Also
> there is no corresponding ACPI device for the Hyper-V PCI root bridge.
>
> With this patchset, we could enable the virtual PCI on Hyper-V ARM64
> guest with other code under development.
>
> Comments and suggestions are welcome.
>
> Regards,
> Boqun
>
> Arnd Bergmann (1):
>   PCI: hv: Generify PCI probing
>
> Boqun Feng (6):
>   PCI: Introduce domain_nr in pci_host_bridge
>   PCI: Allow msi domain set-up at host probing time
>   PCI: hv: Use pci_host_bridge::domain_nr for PCI domain
>   PCI: hv: Set up msi domain at bridge probing time
>   arm64: PCI: Support root bridge preparation for Hyper-V PCI
>   PCI: hv: Turn on the host bridge probing on ARM64
>
>  arch/arm64/kernel/pci.c             |  7 ++-
>  drivers/pci/controller/pci-hyperv.c | 87 +++++++++++++++++------------
>  drivers/pci/probe.c                 |  9 ++-
>  include/linux/pci.h                 | 10 ++++
>  4 files changed, 73 insertions(+), 40 deletions(-)
>
> --
> 2.30.2
>
