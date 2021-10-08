Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34DE42714B
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Oct 2021 21:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhJHTSu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Oct 2021 15:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231433AbhJHTSt (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Oct 2021 15:18:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71F0661039;
        Fri,  8 Oct 2021 19:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633720613;
        bh=+RoGhvx5O/crHux5ekNh6pJxtPOkMUA+DRUv/unp3Rg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JBrDlwr6e/AOSVAO0Ya2wbpw9UmGcF1vgoH7m4c1TBmNLX8bjwDd32XeJDnZgREIF
         iKOWKqGRBTwbkWtEHbYmexVQ6fXnfnzexoXnEhQ1M/Dhfs5qIpzjboELWoLlG2IOf1
         muT4xPMWLi4hTNYvdk65V774NMnTbeHn2nLR/KiWceDOQpRbUeN2JUvdCI9tHNAU+y
         +mAPzKXQRb2KFhDL4iPP5FOpQ6T5fF4m0lpCxKOgQOoSK+X4khEKaaGxTSIDIPZC/4
         DKgOt8vUXyT3rUNASpc/kt7vk5l+5hTZx9E0AGp96fEu4BTDN3l7clXEr1F5O3Xy5l
         ulg5jIZd9TYwQ==
Date:   Fri, 8 Oct 2021 14:16:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "\"H. Peter Anvin\"" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: hv: Make the code arch neutral
Message-ID: <20211008191652.GA1364497@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR21MB2002C5BFFD9DCB9C3B2AF9E8C0B29@MW4PR21MB2002.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Can you put some specifics in the subject line, please?  If this patch
does several things, that might be an indication that it should be
split into several patches.

On Fri, Oct 08, 2021 at 05:20:35PM +0000, Sunil Muthuswamy wrote:
> This patch makes the Hyper-V vPCI code architectural neutral by
> introducing an irqchip that takes care of architectural
> dependencies. This allows for the implementation of Hyper-V vPCI
> for other architecture such as ARM64.

No need to include "This patch"; we already know we're talking about
this patch.

Write in "imperative mood", e.g., "Encapsulate arch dependencies in
X ..." instead of "This patch makes the code ...".  See
https://chris.beams.io/posts/git-commit/

Wrap the text to fill 75 columns.

You said this "introduces an irqchip", but I don't see a new
struct irq_chip or similar.

The important part about making this arch-neutral seems to be adding
these interfaces that will encapsulate arch dependencies:

  hv_pci_irqchip_init()
  hv_pci_irqchip_free()
  hv_msi_get_int_vector()
  hv_set_msi_entry_from_desc()
  hv_msi_prepare()

I'm not sure wrapping them in "#ifdef CONFIG_X86_64" is the best
approach, but the IRQ folks will know better.

> +++ b/drivers/pci/controller/pci-hyperv-irqchip.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +

Spurious blank line (follow style of nearby files).

> +/*
> + * Hyper-V vPCI irqchip.

> +++ b/drivers/pci/controller/pci-hyperv-irqchip.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +

Spurious blank line (follow style of nearby files).

> +/*
> + * Architecture specific vector management for the Hyper-V vPCI.
