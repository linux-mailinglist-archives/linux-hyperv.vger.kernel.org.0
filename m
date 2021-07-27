Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357C63D7AA3
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jul 2021 18:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhG0QNB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Jul 2021 12:13:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhG0QNB (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Jul 2021 12:13:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF12461B73;
        Tue, 27 Jul 2021 16:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627402381;
        bh=BsgalBQRjr9OM3p/5B+TnVmcmwuTiffeQ0hoAgpA37w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Kg9kn2d/XfVub6+9LSxjDfeaF9gciX+7s07+9Hf9uD3ebG0YGhO3Yjdf1guU+WVpA
         4LTydNtpzlAC/r3SaLAbwTkYqJ7Q4iwjOpwq6QQsYfH96K4tN/2eW9Es1qpTluLMcp
         o/z+7jOEhMMa1qLB5SVnhJyNYsM84/H5ARvPTRPTyMm+ZWj2AkUx+QxfQKBAGtnQQ2
         U+jX3KWLYYDWsAWuwr9kPODXAPFPlGOnT5mmoY6GQmSGTyHo/TIV0pq+PybNHeOwEn
         5z0aNJiz/84RGJQt9aVXIFKjCEmr6ZjyY+XituzebZQ57vgsE1rc4sCkVvbUB3QbfI
         HKmbP1y85Y1nA==
Date:   Tue, 27 Jul 2021 11:12:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH v6 0/8] PCI: hv: Support host bridge probing on ARM64
Message-ID: <20210727161259.GA718226@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726180657.142727-1-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 27, 2021 at 02:06:49AM +0800, Boqun Feng wrote:
> Hi,
> 
> This is the v6 for the preparation of virtual PCI support on Hyper-V
> ARM64, Previous versions:
> 
> v1:	https://lore.kernel.org/lkml/20210319161956.2838291-1-boqun.feng@gmail.com/
> v2:	https://lore.kernel.org/lkml/20210503144635.2297386-1-boqun.feng@gmail.com/
> v3:	https://lore.kernel.org/lkml/20210609163211.3467449-1-boqun.feng@gmail.com/
> v4:	https://lore.kernel.org/lkml/20210714102737.198432-1-boqun.feng@gmail.com/
> v5:	https://lore.kernel.org/lkml/20210720134429.511541-1-boqun.feng@gmail.com/

Thanks for these; they're very handy for archaeology later.

> Changes since last version:
> 
> *	Rebase to 5.14-rc3

Just FYI, it's not a problem that you rebased, but it's not necessary.
These will be applied to a topic branch from v5.14-rc1 anyway.
