Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82E53F4727
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Aug 2021 11:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbhHWJNF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Aug 2021 05:13:05 -0400
Received: from foss.arm.com ([217.140.110.172]:50178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229726AbhHWJNF (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Aug 2021 05:13:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9987C1FB;
        Mon, 23 Aug 2021 02:12:22 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C95B3F66F;
        Mon, 23 Aug 2021 02:12:20 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:12:14 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v6 4/8] arm64: PCI: Support root bridge preparation for
 Hyper-V
Message-ID: <20210823091214.GA1193@lpieralisi>
References: <20210726180657.142727-1-boqun.feng@gmail.com>
 <20210726180657.142727-5-boqun.feng@gmail.com>
 <YR6DIkdkblL8NUP2@boqun-archlinux>
 <20210820174947.GB23080@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820174947.GB23080@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 20, 2021 at 06:49:47PM +0100, Catalin Marinas wrote:
> Hi Boqun,
> 
> Sorry, I just got back from holiday and I'm still in the deleting emails
> mode.
> 
> On Fri, Aug 20, 2021 at 12:13:22AM +0800, Boqun Feng wrote:
> > Appreciate it that you can have a look at this one and patch #4, note
> > that there exists an alternative solution at[1].
> > 
> > The difference is the way used to pass the corresponding ACPI device
> > pointers for PCI host bridges: currently pci_config_window->parent is
> > used, and this patch and patch #4 allow the field to be NULL, because
> > Hyper-V's PCI host bridges don't have ACPI devices, while [1] changes to
> > use pci_host_bridge->private. And I'm OK with either way, I don't have a
> > strong opinion here ;-)
> [...]
> > [1]: https://lore.kernel.org/lkml/20210811153619.88922-1-boqun.feng@gmail.com/
> 
> I'm ok with the arm64 bits in this series and the one you linked above.
> It's up to Lorenzo if he's happy with how pci-hyperv.c ends up looking,
> I'm not a PCIe expert. My preference would be for a combined series
> (this and [1] above).
> 
> Happy to ack the arm64 patches in a combined series (if you are going to
> post one), the changes would look even simpler.

I believe [1] above is an experiment - therefore it is best to stick to
this series as it is for the time being, pending refactoring that
requires more time, I would not rush it.

If you can ACK the arm64 patches (3,4) please I will pull the series
into the PCI tree asap.

Thanks,
Lorenzo
