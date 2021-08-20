Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5563F3279
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Aug 2021 19:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbhHTRub (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Aug 2021 13:50:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233386AbhHTRub (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Aug 2021 13:50:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36F646115A;
        Fri, 20 Aug 2021 17:49:50 +0000 (UTC)
Date:   Fri, 20 Aug 2021 18:49:47 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
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
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v6 4/8] arm64: PCI: Support root bridge preparation for
 Hyper-V
Message-ID: <20210820174947.GB23080@arm.com>
References: <20210726180657.142727-1-boqun.feng@gmail.com>
 <20210726180657.142727-5-boqun.feng@gmail.com>
 <YR6DIkdkblL8NUP2@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR6DIkdkblL8NUP2@boqun-archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Boqun,

Sorry, I just got back from holiday and I'm still in the deleting emails
mode.

On Fri, Aug 20, 2021 at 12:13:22AM +0800, Boqun Feng wrote:
> Appreciate it that you can have a look at this one and patch #4, note
> that there exists an alternative solution at[1].
> 
> The difference is the way used to pass the corresponding ACPI device
> pointers for PCI host bridges: currently pci_config_window->parent is
> used, and this patch and patch #4 allow the field to be NULL, because
> Hyper-V's PCI host bridges don't have ACPI devices, while [1] changes to
> use pci_host_bridge->private. And I'm OK with either way, I don't have a
> strong opinion here ;-)
[...]
> [1]: https://lore.kernel.org/lkml/20210811153619.88922-1-boqun.feng@gmail.com/

I'm ok with the arm64 bits in this series and the one you linked above.
It's up to Lorenzo if he's happy with how pci-hyperv.c ends up looking,
I'm not a PCIe expert. My preference would be for a combined series
(this and [1] above).

Happy to ack the arm64 patches in a combined series (if you are going to
post one), the changes would look even simpler.

-- 
Catalin
