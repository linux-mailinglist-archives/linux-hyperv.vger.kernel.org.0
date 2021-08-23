Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E673F481F
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Aug 2021 12:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbhHWKDM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Aug 2021 06:03:12 -0400
Received: from foss.arm.com ([217.140.110.172]:50872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235872AbhHWKDL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Aug 2021 06:03:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 145966D;
        Mon, 23 Aug 2021 03:02:29 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.42.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AC783F66F;
        Mon, 23 Aug 2021 03:02:24 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Boqun Feng <boqun.feng@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: Re: [PATCH v6 0/8] PCI: hv: Support host bridge probing on ARM64
Date:   Mon, 23 Aug 2021 11:02:16 +0100
Message-Id: <162971291667.27395.14375494235091415545.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210726180657.142727-1-boqun.feng@gmail.com>
References: <20210726180657.142727-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 27 Jul 2021 02:06:49 +0800, Boqun Feng wrote:
> This is the v6 for the preparation of virtual PCI support on Hyper-V
> ARM64, Previous versions:
> 
> v1:	https://lore.kernel.org/lkml/20210319161956.2838291-1-boqun.feng@gmail.com/
> v2:	https://lore.kernel.org/lkml/20210503144635.2297386-1-boqun.feng@gmail.com/
> v3:	https://lore.kernel.org/lkml/20210609163211.3467449-1-boqun.feng@gmail.com/
> v4:	https://lore.kernel.org/lkml/20210714102737.198432-1-boqun.feng@gmail.com/
> v5:	https://lore.kernel.org/lkml/20210720134429.511541-1-boqun.feng@gmail.com/
> 
> [...]

Applied to pci/hyper-v, thanks!

[1/8] PCI: Introduce domain_nr in pci_host_bridge
      https://git.kernel.org/lpieralisi/pci/c/15d82ca23c
[2/8] PCI: Support populating MSI domains of root buses via bridges
      https://git.kernel.org/lpieralisi/pci/c/41dd40fd71
[3/8] arm64: PCI: Restructure pcibios_root_bridge_prepare()
      https://git.kernel.org/lpieralisi/pci/c/b424d4d426
[4/8] arm64: PCI: Support root bridge preparation for Hyper-V
      https://git.kernel.org/lpieralisi/pci/c/7d40c0f70d
[5/8] PCI: hv: Generify PCI probing
      https://git.kernel.org/lpieralisi/pci/c/418cb6c8e0
[6/8] PCI: hv: Set ->domain_nr of pci_host_bridge at probing time
      https://git.kernel.org/lpieralisi/pci/c/38c0d266dc
[7/8] PCI: hv: Set up MSI domain at bridge probing time
      https://git.kernel.org/lpieralisi/pci/c/9e7f9178ab
[8/8] PCI: hv: Turn on the host bridge probing on ARM64
      https://git.kernel.org/lpieralisi/pci/c/88f94c7f8f

Thanks,
Lorenzo
