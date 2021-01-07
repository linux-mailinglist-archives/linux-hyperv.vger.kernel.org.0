Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BFF2ED32E
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jan 2021 16:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbhAGPDA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jan 2021 10:03:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:55014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbhAGPC7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jan 2021 10:02:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFC3B224D3;
        Thu,  7 Jan 2021 15:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610031739;
        bh=C/0ntKQkdPNZnm9r9k+uBHqpkoJHu0igxr4uHyjebhU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qobnh4uZ61nKfrB4EFp96Aj+I0k8pbsjsnnVgPQ+KOuL2SmiaClRWlHIUC3RR25LD
         o5/+TJiEHwF4kBz9Hxy4kmnIEhA5haQAEJ6ZjTnP1dr1tXZ6wsQP23PyNVFmfL23nY
         AzgFL7QsettAIyJdIiMXUUe43aPxstTHYJ1zwQDw+MfZ5/AZ2H0i+5pZDeVwbv9xNH
         L/2oCziCPGu1r9Z1NI0vGOjiccr8gh+XPRTLcw3NUcFcMo7BUpFPYIRjGds4PnbBdn
         RbZZojIrQRmj7dsnipVKMRyS/MmgCoSwRd2ddXhVFscncEyPY7NQhmiVcy+cpNnaOR
         /7F/9Zr4QvxIA==
Date:   Thu, 7 Jan 2021 09:02:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "\"H. Peter Anvin\"" <hpa@zytor.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] Hyper-V: pci: x64: Generalize irq/msi set-up and handling
Message-ID: <20210107150216.GA1365474@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR2101MB08808404302E2E1AB6A27DD6C0AF9@SN4PR2101MB0880.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There seems to be a long tradition of dreaming up random formats for
the subject lines of Hyper-V-related patches.  Look at all the
different ways these are spelled, hyphenated, and capitalized:

  $ git log --oneline arch/x86/include/asm/mshyperv.h
  626b901f6044 ("Drivers: hv: vmbus: Add parsing of VMbus interrupt in ACPI DSDT")
  b9d8cf2eb3ce ("x86/hyperv: Make hv_setup_sched_clock inline")
  a16be368dd3f ("x86/entry: Convert various hypervisor vectors to IDTENTRY_SYSVEC")
  2ddddd0b4e89 ("Drivers: hv: Move AEOI determination to architecture dependent code")
  1cf106d93245 ("PCI: hv: Introduce hv_msi_entry")
  b95a8a27c300 ("x86/vdso: Use generic VDSO clock mode storage")
  eec399dd8627 ("x86/vdso: Move VDSO clocksource state tracking to callback")
  fa36dcdf8b20 ("x86: hv: Add function to allocate zeroed page for Hyper-V")
  8c3e44bde7fd ("x86/hyperv: Add functions to allocate/deallocate page for Hyper-V")
  765e33f5211a ("Drivers: hv: vmbus: Break out ISA independent parts of mshyperv.h")
  dd2cb348613b ("clocksource/drivers: Continue making Hyper-V clocksource ISA agnostic")
  cc4edae4b924 ("x86/hyper-v: Add HvFlushGuestAddressList hypercall support")
  b42967dcac1d ("x86/hyper-v: Fix indentation in hv_do_fast_hypercall16()")
  3a025de64bf8 ("x86/hyperv: Enable PV qspinlock for Hyper-V")
  eb914cfe72f4 ("X86/Hyper-V: Add flush HvFlushGuestPhysicalAddressSpace hypercall support")
  ...

On Thu, Jan 07, 2021 at 05:05:36AM +0000, Sunil Muthuswamy wrote:
> Currently, operations related to irq/msi in Hyper-V vPCI are

In comments in the patch, you use "IRQ" and "MSI".  I don't know
whether "vPCI" means something or is a typo.  I suppose it probably
means "virtual PCI" as below.

> x86-specific code. In order to support virtual PCI on Hyper-V for
> other architectures, introduce generic interfaces to replace the
> x86-specific ones. There are no functional changes in this patch.
>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
> ...
