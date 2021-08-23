Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE9A3F47DE
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Aug 2021 11:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbhHWJoc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Aug 2021 05:44:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230265AbhHWJob (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Aug 2021 05:44:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADF8661372;
        Mon, 23 Aug 2021 09:43:46 +0000 (UTC)
Date:   Mon, 23 Aug 2021 10:43:44 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v6 4/8] arm64: PCI: Support root bridge preparation for
 Hyper-V
Message-ID: <20210823094343.GB8603@arm.com>
References: <20210726180657.142727-1-boqun.feng@gmail.com>
 <20210726180657.142727-5-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726180657.142727-5-boqun.feng@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 27, 2021 at 02:06:53AM +0800, Boqun Feng wrote:
> Currently at root bridge preparation, the corresponding ACPI device will
> be set as the companion, however for a Hyper-V virtual PCI root bridge,
> there is no corresponding ACPI device, because a Hyper-V virtual PCI
> root bridge is discovered via VMBus rather than ACPI table. In order to
> support this, we need to make pcibios_root_bridge_prepare() work with
> cfg->parent being NULL.
> 
> Use a NULL pointer as the ACPI device if there is no corresponding ACPI
> device, and this is fine because: 1) ACPI_COMPANION_SET() can work with
> the second parameter being NULL, 2) semantically, if a NULL pointer is
> set via ACPI_COMPANION_SET(), ACPI_COMPANION() (the read API for this
> field) will return NULL, and since ACPI_COMPANION() may return NULL, so
> users must have handled the cases where it returns NULL, and 3) since
> there is no corresponding ACPI device, it would be wrong to use any
> other value here.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
