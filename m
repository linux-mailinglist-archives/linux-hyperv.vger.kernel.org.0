Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502843F47DB
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Aug 2021 11:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhHWJoP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Aug 2021 05:44:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230265AbhHWJoP (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Aug 2021 05:44:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBF8061186;
        Mon, 23 Aug 2021 09:43:29 +0000 (UTC)
Date:   Mon, 23 Aug 2021 10:43:27 +0100
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
Subject: Re: [PATCH v6 3/8] arm64: PCI: Restructure
 pcibios_root_bridge_prepare()
Message-ID: <20210823094326.GA8603@arm.com>
References: <20210726180657.142727-1-boqun.feng@gmail.com>
 <20210726180657.142727-4-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726180657.142727-4-boqun.feng@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 27, 2021 at 02:06:52AM +0800, Boqun Feng wrote:
> Restructure the pcibios_root_bridge_prepare() as the preparation for
> supporting cases when no real ACPI device is related to the PCI host
> bridge.
> 
> No functional change.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
