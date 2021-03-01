Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12D8327C82
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Mar 2021 11:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbhCAKqN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 Mar 2021 05:46:13 -0500
Received: from mout.gmx.net ([212.227.17.20]:35973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234671AbhCAKpr (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Mar 2021 05:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614595396;
        bh=3U6ft/tFjPbajRTHpMtsxkyeln1GHUnFs9tKVCL4wn4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lounEzaf4QP8hgD1g60pVYkIjry+whG5YO/kWMh6MJ3mYF1Gp5cfSrmCcg29h2yvG
         BvJn/lwIf3vMmj/pgxm4Ob+zHU2OkNc8SLLPgLb1KQL5XOd6g+Tll+mnwFHMcSKvPg
         fysr8OBqUFW7k6gdhUj5VPAxKKP+ZDi3SHtpL2zI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.155.40] ([217.61.155.40]) by web-mail.gmx.net
 (3c-app-gmx-bap67.server.lan [172.19.172.67]) (via HTTP); Mon, 1 Mar 2021
 11:43:16 +0100
MIME-Version: 1.0
Message-ID: <trinity-b7e2cf18-f0e6-4d88-8a80-de6758b5a91f-1614595396771@3c-app-gmx-bap67>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Marc Zyngier <maz@kernel.org>
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
Subject: Aw: [PATCH 09/13] PCI: mediatek: Advertise lack of MSI handling
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 1 Mar 2021 11:43:16 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20210225151023.3642391-10-maz@kernel.org>
References: <20210225151023.3642391-1-maz@kernel.org>
 <20210225151023.3642391-10-maz@kernel.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:j861k7kpUL0MUYZFFLW+xzpYTQvAFo+nVqIutJIlj6BO2OJFcQg7P/7gkl57sGk667CmF
 3gFxH+9xglC2hdYPkVuGvoyIwX7NK7Z/Q5IeEPJrjGrpj2L+YtCTX5SpRHy1RFeX+3nfuAnmJQa0
 PKNHGo6hq+lUF1JEU08QHR+yXp/G0CXOcvA+yTOZnw682knlZRcLMti0XyKEckoMrAVeKF+9EyDd
 hG7/izq22IvB6GUosWtOFIlxC3QJE1+bBATvZPb7xaGFceQzf6CnZgBCzDxeQI7O28PtObeD7gB8
 6I=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fSST4jC/Cuk=:rxBU1F/iol8XJ4ZzaI9eUc
 /lUcepYYMTrwe0+SLaefhq+Q/f88wOXrKXiIo7tVepjzDjjBtbgbeFSi3Hi76E0Jqa3HazlrF
 27/OPneFO9NS+r9zIir/41mEfgXsvHvEGciCp8mlaArYHK7kyBwphu/SKmmheZr28JdkKkIw7
 67YZrzBjwbd8YqiwAdoPBBULXmAkL4PGYyrHAZvWLImEPcO0YF8/fSikZ5xMT1zIEmDYEpXaN
 MnS6eKDDb27yIQiMy2GfxsbkOibK0LX2LkelPgwHL7UKIefHvIEP6Nr9BwrVxifRtkqLS6NWG
 4RA0IYjIxL50KIgamQGJHGyQyzu2XeLntYjVZd5ygwdanobTxQLqn+tRt9UqQLPelrAcTWiiq
 3fUOwVOIweT/PxXH04QIGTx3v8uDXhzpeYTdnhZhF10Jl8kG7T45milbh3nZl/z0Ly+ywGDh6
 WZScu0ybzrotMdWe3q1eAGkbC11WLLEhtHAre6KD0/n0ziNFJ+ZKiJ31rjmakraLx0L86sx5I
 fWGVh/dXztZ74u4z2sGbnWA47jX5Cldbgwe8+xMKoJj0XlzYVDTuAve9FnXYXcJemOqVLcbll
 h9R2jJZ0+zvKE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

tested full series on bananapi-r2 and r64

r2 (with mt7615) looks good.

on r64 (with atheros card WLE900VX) i see this while loading ath10k driver=
:

[    6.525981] ath10k_pci 0000:01:00.0: enabling device (0000 -> 0002)
[    6.537810] ath10k_pci 0000:01:00.0: enabling bus mastering
[    6.543831] Unable to handle kernel paging request at virtual address f=
fffff4
013be2a80
[    6.551890] Mem abort info:
[    6.554744]   ESR =3D 0x96000044
[    6.557870]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    6.563267]   SET =3D 0, FnV =3D 0
[    6.566396]   EA =3D 0, S1PTW =3D 0
[    6.569611] Data abort info:
[    6.572501]   ISV =3D 0, ISS =3D 0x00000044
[    6.576411]   CM =3D 0, WnR =3D 1
[    6.579450] [ffffff4013be2a80] address between user and kernel address =
ranges
[    6.586659] Internal error: Oops: 96000044 [#1] PREEMPT SMP
[    6.592248] Modules linked in: ath10k_pci(+) ath10k_core ath mac80211 l=
ibarc4
 btmtkuart cfg80211 bluetooth ecdh_generic ecc rfkill libaes ip_tables x_t=
ables
[    6.606329] CPU: 1 PID: 114 Comm: systemd-udevd Not tainted 5.11.0-bpi-=
r64-pc
i #3
[    6.613819] Hardware name: Bananapi BPI-R64 (DT)
[    6.618439] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=3D--)
[    6.624452] pc : queued_spin_lock_slowpath+0x1e8/0x31c
[    6.629608] lr : queued_spin_lock_slowpath+0xac/0x31c
[    6.634666] sp : ffffffc010f63550
[    6.637982] x29: ffffffc010f63550 x28: 000000000000fc7e
[    6.643306] x27: ffffffc010c67410 x26: 0000000000080000
[    6.648629] x25: ffffffc010c67880 x24: ffffffc010f63810
[    6.653950] x23: 0000000000000000 x22: ffffffc010ba8860
[    6.659270] x21: ffffff803fdcc540 x20: ffffffc010a1c540
[    6.664591] x19: ffffff80016a1708 x18: 0000000000000000
[    6.669914] x17: 0000000000000000 x16: 0000000000000000
[    6.675236] x15: 000000000000000a x14: 0000000000000092
[    6.680560] x13: ffffff8006671004 x12: 0000000000000000
[    6.685883] x11: 0101010101010101 x10: ffffff8001635568
[    6.691206] x9 : 0000000000080000 x8 : ffffff8001635560
[    6.696529] x7 : 0000000000000000 x6 : ffffff803fdcc540
[    6.701849] x5 : 0000000000000002 x4 : 0000000000080000
[    6.707170] x3 : ffffff80016a170a x2 : 000000000000016a
[    6.712493] x1 : ffffff80031c6520 x0 : ffffffc010a1c560
[    6.717818] Call trace:
[    6.720276]  queued_spin_lock_slowpath+0x1e8/0x31c
[    6.725086]  do_raw_spin_lock+0x2c/0x38
[    6.728931]  _raw_spin_lock+0x24/0x34
[    6.732606]  __mutex_lock.isra.0+0xc4/0x29c
[    6.736799]  __mutex_lock_slowpath+0x14/0x20
[    6.741078]  mutex_lock+0x28/0x34
[    6.744402]  mtk_pcie_irq_domain_alloc+0x3c/0xd0
[    6.749037]  irq_domain_alloc_irqs_hierarchy+0x50/0x54
[    6.754187]  irq_domain_alloc_irqs_parent+0x18/0x2c
[    6.759073]  msi_domain_alloc+0x8c/0x12c
[    6.763007]  irq_domain_alloc_irqs_hierarchy+0x50/0x54
[    6.768154]  __irq_domain_alloc_irqs+0x114/0x344
[    6.772780]  __msi_domain_alloc_irqs+0x110/0x318
[    6.777408]  msi_domain_alloc_irqs+0x1c/0x28
[    6.781685]  pci_msi_setup_msi_irqs.isra.0+0x2c/0x44
[    6.786662]  __pci_enable_msi_range+0x230/0x320
[    6.791202]  pci_enable_msi+0x1c/0x30
[    6.794874]  ath10k_pci_probe+0x480/0x748 [ath10k_pci]
[    6.800058]  pci_device_probe+0xbc/0x14c
[    6.804014]  really_probe+0x2a0/0x470
[    6.807701]  driver_probe_device+0x12c/0x13c
[    6.811981]  device_driver_attach+0x44/0x70
[    6.816181]  __driver_attach+0x13c/0x140
[    6.820126]  bus_for_each_dev+0x70/0xc0
[    6.823971]  driver_attach+0x24/0x30
[    6.827556]  bus_add_driver+0x1a4/0x1ec
[    6.831401]  driver_register+0xb4/0xec
[    6.835168]  __pci_register_driver+0x44/0x50
[    6.839465]  ath10k_pci_init+0x28/0x1000 [ath10k_pci]
[    6.844563]  do_one_initcall+0x6c/0x188
[    6.848431]  do_init_module+0x5c/0x1e8
[    6.852205]  load_module+0x1124/0x11c8
[    6.855967]  __do_sys_finit_module+0xdc/0x100
[    6.860335]  __arm64_sys_finit_module+0x1c/0x28
[    6.864877]  el0_svc_common.constprop.0+0x124/0x198
[    6.869766]  do_el0_svc+0x48/0x78
[    6.873089]  el0_svc+0x14/0x20
[    6.876158]  el0_sync_handler+0xcc/0x154
[    6.880091]  el0_sync+0x174/0x180
[    6.883425] Code: d37c0400 51000421 8b000280 f861dac1 (f8216806)
[    6.889525] ---[ end trace 62498e1f489ea3ab ]---

i guess it's a bug in ath10k driver or my r64 board (it is a v1.1 which ha=
s missing capacitors on tx lines).
Tried with an mt7612e, this seems to work without any errors.

so for mt7622/mt7623

Tested-by: Frank Wunderlich <frank-w@public-files.de>

regards Frank
