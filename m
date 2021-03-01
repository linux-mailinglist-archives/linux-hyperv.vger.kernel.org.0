Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1886C327D91
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Mar 2021 12:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbhCALvG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 Mar 2021 06:51:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234058AbhCALun (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Mar 2021 06:50:43 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB2C764E22;
        Mon,  1 Mar 2021 11:50:01 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lGh3n-00GOS8-Ml; Mon, 01 Mar 2021 11:49:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Mar 2021 11:49:59 +0000
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
Subject: Re: Aw: [PATCH 09/13] PCI: mediatek: Advertise lack of MSI handling
In-Reply-To: <trinity-b7e2cf18-f0e6-4d88-8a80-de6758b5a91f-1614595396771@3c-app-gmx-bap67>
References: <20210225151023.3642391-1-maz@kernel.org>
 <20210225151023.3642391-10-maz@kernel.org>
 <trinity-b7e2cf18-f0e6-4d88-8a80-de6758b5a91f-1614595396771@3c-app-gmx-bap67>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <b7721e2ff751cc9565a662cb713819e3@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: frank-w@public-files.de, lorenzo.pieralisi@arm.com, bhelgaas@google.com, treding@nvidia.com, tglx@linutronix.de, robh@kernel.org, will@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com, ryder.lee@mediatek.com, marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com, michal.simek@xilinx.com, paul.walmsley@sifive.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Frank,

On 2021-03-01 10:43, Frank Wunderlich wrote:
> tested full series on bananapi-r2 and r64
> 
> r2 (with mt7615) looks good.
> 
> on r64 (with atheros card WLE900VX) i see this while loading ath10k 
> driver:
> 
> [    6.525981] ath10k_pci 0000:01:00.0: enabling device (0000 -> 0002)
> [    6.537810] ath10k_pci 0000:01:00.0: enabling bus mastering
> [    6.543831] Unable to handle kernel paging request at virtual 
> address ffffff4
> 013be2a80
> [    6.551890] Mem abort info:
> [    6.554744]   ESR = 0x96000044
> [    6.557870]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    6.563267]   SET = 0, FnV = 0
> [    6.566396]   EA = 0, S1PTW = 0
> [    6.569611] Data abort info:
> [    6.572501]   ISV = 0, ISS = 0x00000044
> [    6.576411]   CM = 0, WnR = 1
> [    6.579450] [ffffff4013be2a80] address between user and kernel 
> address ranges
> [    6.586659] Internal error: Oops: 96000044 [#1] PREEMPT SMP
> [    6.592248] Modules linked in: ath10k_pci(+) ath10k_core ath 
> mac80211 libarc4
>  btmtkuart cfg80211 bluetooth ecdh_generic ecc rfkill libaes ip_tables 
> x_tables
> [    6.606329] CPU: 1 PID: 114 Comm: systemd-udevd Not tainted 
> 5.11.0-bpi-r64-pc
> i #3
> [    6.613819] Hardware name: Bananapi BPI-R64 (DT)
> [    6.618439] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
> [    6.624452] pc : queued_spin_lock_slowpath+0x1e8/0x31c
> [    6.629608] lr : queued_spin_lock_slowpath+0xac/0x31c
> [    6.634666] sp : ffffffc010f63550
> [    6.637982] x29: ffffffc010f63550 x28: 000000000000fc7e
> [    6.643306] x27: ffffffc010c67410 x26: 0000000000080000
> [    6.648629] x25: ffffffc010c67880 x24: ffffffc010f63810
> [    6.653950] x23: 0000000000000000 x22: ffffffc010ba8860
> [    6.659270] x21: ffffff803fdcc540 x20: ffffffc010a1c540
> [    6.664591] x19: ffffff80016a1708 x18: 0000000000000000
> [    6.669914] x17: 0000000000000000 x16: 0000000000000000
> [    6.675236] x15: 000000000000000a x14: 0000000000000092
> [    6.680560] x13: ffffff8006671004 x12: 0000000000000000
> [    6.685883] x11: 0101010101010101 x10: ffffff8001635568
> [    6.691206] x9 : 0000000000080000 x8 : ffffff8001635560
> [    6.696529] x7 : 0000000000000000 x6 : ffffff803fdcc540
> [    6.701849] x5 : 0000000000000002 x4 : 0000000000080000
> [    6.707170] x3 : ffffff80016a170a x2 : 000000000000016a
> [    6.712493] x1 : ffffff80031c6520 x0 : ffffffc010a1c560
> [    6.717818] Call trace:
> [    6.720276]  queued_spin_lock_slowpath+0x1e8/0x31c
> [    6.725086]  do_raw_spin_lock+0x2c/0x38
> [    6.728931]  _raw_spin_lock+0x24/0x34
> [    6.732606]  __mutex_lock.isra.0+0xc4/0x29c
> [    6.736799]  __mutex_lock_slowpath+0x14/0x20
> [    6.741078]  mutex_lock+0x28/0x34
> [    6.744402]  mtk_pcie_irq_domain_alloc+0x3c/0xd0
> [    6.749037]  irq_domain_alloc_irqs_hierarchy+0x50/0x54
> [    6.754187]  irq_domain_alloc_irqs_parent+0x18/0x2c
> [    6.759073]  msi_domain_alloc+0x8c/0x12c
> [    6.763007]  irq_domain_alloc_irqs_hierarchy+0x50/0x54
> [    6.768154]  __irq_domain_alloc_irqs+0x114/0x344
> [    6.772780]  __msi_domain_alloc_irqs+0x110/0x318
> [    6.777408]  msi_domain_alloc_irqs+0x1c/0x28
> [    6.781685]  pci_msi_setup_msi_irqs.isra.0+0x2c/0x44
> [    6.786662]  __pci_enable_msi_range+0x230/0x320
> [    6.791202]  pci_enable_msi+0x1c/0x30
> [    6.794874]  ath10k_pci_probe+0x480/0x748 [ath10k_pci]
> [    6.800058]  pci_device_probe+0xbc/0x14c
> [    6.804014]  really_probe+0x2a0/0x470
> [    6.807701]  driver_probe_device+0x12c/0x13c
> [    6.811981]  device_driver_attach+0x44/0x70
> [    6.816181]  __driver_attach+0x13c/0x140
> [    6.820126]  bus_for_each_dev+0x70/0xc0
> [    6.823971]  driver_attach+0x24/0x30
> [    6.827556]  bus_add_driver+0x1a4/0x1ec
> [    6.831401]  driver_register+0xb4/0xec
> [    6.835168]  __pci_register_driver+0x44/0x50
> [    6.839465]  ath10k_pci_init+0x28/0x1000 [ath10k_pci]
> [    6.844563]  do_one_initcall+0x6c/0x188
> [    6.848431]  do_init_module+0x5c/0x1e8
> [    6.852205]  load_module+0x1124/0x11c8
> [    6.855967]  __do_sys_finit_module+0xdc/0x100
> [    6.860335]  __arm64_sys_finit_module+0x1c/0x28
> [    6.864877]  el0_svc_common.constprop.0+0x124/0x198
> [    6.869766]  do_el0_svc+0x48/0x78
> [    6.873089]  el0_svc+0x14/0x20
> [    6.876158]  el0_sync_handler+0xcc/0x154
> [    6.880091]  el0_sync+0x174/0x180
> [    6.883425] Code: d37c0400 51000421 8b000280 f861dac1 (f8216806)
> [    6.889525] ---[ end trace 62498e1f489ea3ab ]---
> 
> i guess it's a bug in ath10k driver or my r64 board (it is a v1.1
> which has missing capacitors on tx lines).

No, this definitely looks like a bug in the MTK PCIe driver,
where the mutex is either not properly initialised, corrupted,
or the wrong pointer is passed.

This r64 machine is supposed to have working MSIs, right?
Do you get the same issue without this series?

> Tried with an mt7612e, this seems to work without any errors.
> 
> so for mt7622/mt7623
> 
> Tested-by: Frank Wunderlich <frank-w@public-files.de>

We definitely need to understand the above.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
