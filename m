Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FE5327F8C
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Mar 2021 14:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbhCANca (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 Mar 2021 08:32:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235730AbhCANcR (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Mar 2021 08:32:17 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF77864D9F;
        Mon,  1 Mar 2021 13:31:36 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lGie6-00GPaX-Od; Mon, 01 Mar 2021 13:31:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Mar 2021 13:31:34 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <treding@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: Aw: Re:  [PATCH 09/13] PCI: mediatek: Advertise lack of MSI
 handling
In-Reply-To: <trinity-9fa6d24e-f9de-4741-bf44-86f6197b174d-1614600961297@3c-app-gmx-bap67>
References: <20210225151023.3642391-1-maz@kernel.org>
 <20210225151023.3642391-10-maz@kernel.org>
 <trinity-b7e2cf18-f0e6-4d88-8a80-de6758b5a91f-1614595396771@3c-app-gmx-bap67>
 <b7721e2ff751cc9565a662cb713819e3@kernel.org>
 <trinity-9fa6d24e-f9de-4741-bf44-86f6197b174d-1614600961297@3c-app-gmx-bap67>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <5afd1d656299d87c43bdf31b8ced2d5f@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: frank-w@public-files.de, lorenzo.pieralisi@arm.com, bhelgaas@google.com, treding@nvidia.com, tglx@linutronix.de, robh@kernel.org, will@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com, ryder.lee@mediatek.com, marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com, michal.simek@xilinx.com, paul.walmsley@sifive.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Frank,

>> > i guess it's a bug in ath10k driver or my r64 board (it is a v1.1
>> > which has missing capacitors on tx lines).
>> 
>> No, this definitely looks like a bug in the MTK PCIe driver,
>> where the mutex is either not properly initialised, corrupted,
>> or the wrong pointer is passed.
> 
> but why does it happen only with the ath10k-card and not the mt7612 in
> same slot?

Does mt7612 use MSI? What we have here is a bogus mutex in the
MTK PCIe driver, and the only way not to get there would be
to avoid using MSIs.

> 
>> This r64 machine is supposed to have working MSIs, right?
> 
> imho mt7622 have working MSI
> 
>> Do you get the same issue without this series?
> 
> tested 5.11.0 [1] without this series (but with your/thomas' patch
> from discussion about my old patch) and got same trace. so this series
> does not break anything here.

Can you retest without any additional patch on top of 5.11?
These two patches only affect platforms that do *not* have MSIs at all.

> 
>> > Tried with an mt7612e, this seems to work without any errors.
>> >
>> > so for mt7622/mt7623
>> >
>> > Tested-by: Frank Wunderlich <frank-w@public-files.de>
>> 
>> We definitely need to understand the above.
> 
> there is a hardware-bug which may cause this...afair i saw this with
> the card in r64 with earlier Kernel-versions where other cards work
> (like the mt7612e).

I don't think a HW bug affecting PCI would cause what we are seeing
here, unless it results in memory corruption.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
