Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2093A3080
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jun 2021 18:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhFJQZt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Jun 2021 12:25:49 -0400
Received: from disco-boy.misterjones.org ([51.254.78.96]:45986 "EHLO
        disco-boy.misterjones.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhFJQZt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Jun 2021 12:25:49 -0400
X-Greylist: delayed 2464 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jun 2021 12:25:49 EDT
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <maz@misterjones.org>)
        id 1lrMpR-006lZz-3S; Thu, 10 Jun 2021 16:42:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Jun 2021 16:42:45 +0100
From:   Marc Zyngier <maz@misterjones.org>
To:     Ard Biesheuvel <ardb@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [RFC v3 0/7] PCI: hv: Support host bridge probing on ARM64
In-Reply-To: <CAMj1kXGwa28T5Cr_64OC4rqE3qhwWQz+BJPwjdr54G-pVf9+pA@mail.gmail.com>
References: <20210609163211.3467449-1-boqun.feng@gmail.com>
 <CAMj1kXGwa28T5Cr_64OC4rqE3qhwWQz+BJPwjdr54G-pVf9+pA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <2283b22ae7832db348bd9b3eff3aab16@misterjones.org>
X-Sender: maz@misterjones.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: ardb@kernel.org, boqun.feng@gmail.com, arnd@arndb.de, bhelgaas@google.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org, csbisa@amazon.com, sunilmut@microsoft.com
X-SA-Exim-Mail-From: maz@misterjones.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2021-06-10 16:01, Ard Biesheuvel wrote:
> On Wed, 9 Jun 2021 at 18:32, Boqun Feng <boqun.feng@gmail.com> wrote:
>> 
>> Hi Bjorn, Arnd and Marc,
>> 
> 
> Instead of cc'ing Arnd, you cc'ed me (Ard)

And I don't know if you intended to Cc me, but you definitely didn't.

Thanks,

         M.

> 
>> This is the v3 for the preparation of virtual PCI support on Hyper-V
>> ARM64. Previous versions:
>> 
>> v1:     
>> https://lore.kernel.org/lkml/20210319161956.2838291-1-boqun.feng@gmail.com/
>> v2:     
>> https://lore.kernel.org/lkml/20210503144635.2297386-1-boqun.feng@gmail.com/
>> 
>> Changes since last version:
>> 
>> *       Use a sentinel value approach instead of calling
>>         pci_bus_find_domain_nr() for every CONFIG_PCI_DOMAIN_GENERIC=y
>>         arch as per suggestion from
>> 
>> *       Improve the commit log and comments for patch #6.
>> 
>> *       Rebase to the latest mainline.
>> 
>> The basic problem we need to resolve is that ARM64 is an arch with
>> PCI_DOMAINS_GENERIC=y, so the bus sysdata is pci_config_window. 
>> However,
>> Hyper-V PCI provides a paravirtualized PCI interface, so there is no
>> actual pci_config_window for a PCI host bridge, so no information can 
>> be
>> retrieve from the pci_config_window of a Hyper-V virtual PCI bus. Also
>> there is no corresponding ACPI device for the Hyper-V PCI root bridge.
>> 
>> With this patchset, we could enable the virtual PCI on Hyper-V ARM64
>> guest with other code under development.
>> 
>> Comments and suggestions are welcome.
>> 
>> Regards,
>> Boqun
>> 
>> Arnd Bergmann (1):
>>   PCI: hv: Generify PCI probing
>> 
>> Boqun Feng (6):
>>   PCI: Introduce domain_nr in pci_host_bridge
>>   PCI: Allow msi domain set-up at host probing time
>>   PCI: hv: Use pci_host_bridge::domain_nr for PCI domain
>>   PCI: hv: Set up msi domain at bridge probing time
>>   arm64: PCI: Support root bridge preparation for Hyper-V PCI
>>   PCI: hv: Turn on the host bridge probing on ARM64
>> 
>>  arch/arm64/kernel/pci.c             |  7 ++-
>>  drivers/pci/controller/pci-hyperv.c | 87 
>> +++++++++++++++++------------
>>  drivers/pci/probe.c                 |  9 ++-
>>  include/linux/pci.h                 | 10 ++++
>>  4 files changed, 73 insertions(+), 40 deletions(-)
>> 
>> --
>> 2.30.2
>> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Who you jivin' with that Cosmik Debris?
