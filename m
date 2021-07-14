Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790AD3C9116
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jul 2021 22:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241039AbhGNT5s (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jul 2021 15:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240312AbhGNTw3 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jul 2021 15:52:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22C986100A;
        Wed, 14 Jul 2021 19:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626292177;
        bh=WfMWrkHvJ44P3JTRAzMBFhBHH9ErA8FDl5XjQ3/gaXk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VVa6aI500N7TcMemN2ST4LsAKUV1CDY1wp4O5LPgrfRmoiT7Z9uxVB1tGNmIDYKKw
         bYaYwfAEm5ou82Vv9P/nBJyi1Ea3wK3D6hVRLHUjRhqSk4v+GOVWtulEGMiPY98RHl
         xCuny/vdiZLZTL5H0CbvwGuEdO4CBSl8Z2yepo86yBpct9Q4K7PQtBVrry3pIk3+cB
         hAyON+FBCynK+gRdzhQCQWclkPr4/fxPj9Fkr69p2uwozduMLUmxmZ5YZ/bjjYFZSu
         1TWdY02T43e8nLic+h8QMNUQjawJkOFeZ9rumpaXQiVyL7vSnrNNBAXYIoKEg1CY/T
         QwmXD5E0+g6Iw==
Date:   Wed, 14 Jul 2021 14:49:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [RFC v4 4/7] PCI: hv: Generify PCI probing
Message-ID: <20210714194935.GA1870211@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714102737.198432-5-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jul 14, 2021 at 06:27:34PM +0800, Boqun Feng wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> In order to support ARM64 Hyper-V PCI, we need to set up the bridge at
> probing time because ARM64 is a PCI_DOMAIN_GENERIC arch and we don't
> have pci_config_window (ARM64 sysdata) for a PCI root bus on Hyper-V, so
> it's impossible to retrieve the information (e.g. PCI domains, irq
> domains) from bus sysdata on ARM64 after creation.
> 
> Originally in create_root_hv_pci_bus(), pci_create_root_bus() is used to
> create the root bus and the corresponding bridge based on x86 sysdata.
> Now we create a bridge first and then call pci_scan_root_bus_bridge(),
> which allows us to do the necessary set-ups for the bridge.

Also here and other patches in this series:

  s/irq/IRQ/
  s/msi/MSI/

in subject lines, commit logs, comments.
