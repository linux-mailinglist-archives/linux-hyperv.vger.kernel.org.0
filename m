Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AB1327E20
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Mar 2021 13:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhCAMSX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 Mar 2021 07:18:23 -0500
Received: from mout.gmx.net ([212.227.17.22]:44197 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232733AbhCAMSU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Mar 2021 07:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614600961;
        bh=IugOcQwF7kZOdBy0dRHTD1u48P9vwTmyHJA5VWLAxnU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ATiwrXBlzuoW1eFkyOgBd3duYWT+ZZyZk+rQQUfyQKt/Gljgo+4+MtGpNRXz1Besa
         qy39/CBrMy4ufKY1utr3+5rorKTlCqWRhjhax/Z4S/5pbjBIf7TF1i9jRz98GP5rFl
         tS3BLkBD6KCnw+RO4CDyNNtmXiIWjhCtysEw7Bos=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.155.40] ([217.61.155.40]) by web-mail.gmx.net
 (3c-app-gmx-bap67.server.lan [172.19.172.67]) (via HTTP); Mon, 1 Mar 2021
 13:16:01 +0100
MIME-Version: 1.0
Message-ID: <trinity-9fa6d24e-f9de-4741-bf44-86f6197b174d-1614600961297@3c-app-gmx-bap67>
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
Subject: Aw: Re:  [PATCH 09/13] PCI: mediatek: Advertise lack of MSI
 handling
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 1 Mar 2021 13:16:01 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <b7721e2ff751cc9565a662cb713819e3@kernel.org>
References: <20210225151023.3642391-1-maz@kernel.org>
 <20210225151023.3642391-10-maz@kernel.org>
 <trinity-b7e2cf18-f0e6-4d88-8a80-de6758b5a91f-1614595396771@3c-app-gmx-bap67>
 <b7721e2ff751cc9565a662cb713819e3@kernel.org>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:55JouWD1/jomSFHxvmr5CxCsHBcwihxkhhuXcrnwZ18dNoZ2fmwIwamT8sX0YxOooKDfm
 gctUt9mbRXADbjpO2UbJBBz57NROGN/AgETMJkC3gVRBiQ1Mmqm9LRRI5Ea46BGt/RQy+pQuJGav
 CJnBpTnT3hjry16daU6wy0QSOHIDyH21RUACXOTTHU9Cz/aIQLsnra7LuYuZm538N3WDkGdnroeG
 Bz7W8tAE2TrKR/QwrXTSQXt7WrTVw/EodJ8qvW5Rm5Ucsk9Fy67w1PiFmAvzRONAcQBfeRJvlUwu
 mQ=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5GHm5CDvrMw=:y/Kh6y9LRC64Dtwlb4BK64
 fG2tRFEA7yFiaeEuK+Bygk+HhWGwVa0HuEpF6E7j/TcGYyq68gcDR+nK88uiTqrA/WIPbzrGy
 0jpAOGQG2+qWR36lW6s03ugghSeu38hBYodebPkLbg6HoYbk1NAkKvb7KTikqr5JsOrOX1O7V
 cFYq875jKt9fVlPl+cgwSXY/NMrUetKmnsmLFUbC72n98x4oNebDcJAwHh3RzFOnSzIfsZjEx
 jqiBQqjhy6PFHNdPbj8eGArY/sRdp1AOBLaRrSOEZ3z+DPa9AVkSEn9BgFoyaZTAg3rCzgy+t
 vlLRz/sOhI4YfJs8D35ILLl7ZPkT3wWqMa5+LsWvrDSdBKLLfdIwvyHG1ifJ8eMB+f8ZaTn8F
 7SsTx+QFvmD2Y2mtyYoW2TyO1fFZuthGTlBjlxwMMtWWHv5UKWzbGoJECd/7/3UV2uz10zd/n
 9iaQaNiXYrsCxWHGy29OQOz8o8UMRIssSeAuWh24i+59Ly6Em6cFTt8dzU19aVujBH8Udvmn4
 FYkM6BYF9ZQDEGKkwovScKVA2IsTYTOlKuJ3M/6i9PazzKKHdWGibVfGdbTsbUGhEMb+JGpYf
 krB/BpDXhkY4Q=
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



regards Frank


> Gesendet: Montag, 01=2E M=C3=A4rz 2021 um 12:49 Uhr
> Von: "Marc Zyngier" <maz@kernel=2Eorg>
> Frank,
>=20
> On 2021-03-01 10:43, Frank Wunderlich wrote:
> > tested full series on bananapi-r2 and r64
> >=20
> > r2 (with mt7615) looks good=2E
> >=20
> > on r64 (with atheros card WLE900VX) i see this while loading ath10k=20
> > driver:
> >=20
> > [    6=2E525981] ath10k_pci 0000:01:00=2E0: enabling device (0000 -> 0=
002)
> > [    6=2E537810] ath10k_pci 0000:01:00=2E0: enabling bus mastering
> > [    6=2E543831] Unable to handle kernel paging request at virtual=20
> > address ffffff4
> > 013be2a80
> > [    6=2E551890] Mem abort info:
> > [    6=2E554744]   ESR =3D 0x96000044
> > [    6=2E557870]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > [    6=2E563267]   SET =3D 0, FnV =3D 0
> > [    6=2E566396]   EA =3D 0, S1PTW =3D 0
> > [    6=2E569611] Data abort info:
> > [    6=2E572501]   ISV =3D 0, ISS =3D 0x00000044
> > [    6=2E576411]   CM =3D 0, WnR =3D 1
> > [    6=2E579450] [ffffff4013be2a80] address between user and kernel=20
> > address ranges
> > [    6=2E586659] Internal error: Oops: 96000044 [#1] PREEMPT SMP
> > [    6=2E592248] Modules linked in: ath10k_pci(+) ath10k_core ath=20
> > mac80211 libarc4
> >  btmtkuart cfg80211 bluetooth ecdh_generic ecc rfkill libaes ip_tables=
=20
> > x_tables
> > [    6=2E606329] CPU: 1 PID: 114 Comm: systemd-udevd Not tainted=20
> > 5=2E11=2E0-bpi-r64-pc
> > i #3
> > [    6=2E613819] Hardware name: Bananapi BPI-R64 (DT)
> > [    6=2E618439] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=3D--=
)
> > [    6=2E624452] pc : queued_spin_lock_slowpath+0x1e8/0x31c
> > [    6=2E629608] lr : queued_spin_lock_slowpath+0xac/0x31c
> > [    6=2E634666] sp : ffffffc010f63550
> > [    6=2E637982] x29: ffffffc010f63550 x28: 000000000000fc7e
> > [    6=2E643306] x27: ffffffc010c67410 x26: 0000000000080000
> > [    6=2E648629] x25: ffffffc010c67880 x24: ffffffc010f63810
> > [    6=2E653950] x23: 0000000000000000 x22: ffffffc010ba8860
> > [    6=2E659270] x21: ffffff803fdcc540 x20: ffffffc010a1c540
> > [    6=2E664591] x19: ffffff80016a1708 x18: 0000000000000000
> > [    6=2E669914] x17: 0000000000000000 x16: 0000000000000000
> > [    6=2E675236] x15: 000000000000000a x14: 0000000000000092
> > [    6=2E680560] x13: ffffff8006671004 x12: 0000000000000000
> > [    6=2E685883] x11: 0101010101010101 x10: ffffff8001635568
> > [    6=2E691206] x9 : 0000000000080000 x8 : ffffff8001635560
> > [    6=2E696529] x7 : 0000000000000000 x6 : ffffff803fdcc540
> > [    6=2E701849] x5 : 0000000000000002 x4 : 0000000000080000
> > [    6=2E707170] x3 : ffffff80016a170a x2 : 000000000000016a
> > [    6=2E712493] x1 : ffffff80031c6520 x0 : ffffffc010a1c560
> > [    6=2E717818] Call trace:
> > [    6=2E720276]  queued_spin_lock_slowpath+0x1e8/0x31c
> > [    6=2E725086]  do_raw_spin_lock+0x2c/0x38
> > [    6=2E728931]  _raw_spin_lock+0x24/0x34
> > [    6=2E732606]  __mutex_lock=2Eisra=2E0+0xc4/0x29c
> > [    6=2E736799]  __mutex_lock_slowpath+0x14/0x20
> > [    6=2E741078]  mutex_lock+0x28/0x34
> > [    6=2E744402]  mtk_pcie_irq_domain_alloc+0x3c/0xd0
> > [    6=2E749037]  irq_domain_alloc_irqs_hierarchy+0x50/0x54
> > [    6=2E754187]  irq_domain_alloc_irqs_parent+0x18/0x2c
> > [    6=2E759073]  msi_domain_alloc+0x8c/0x12c
> > [    6=2E763007]  irq_domain_alloc_irqs_hierarchy+0x50/0x54
> > [    6=2E768154]  __irq_domain_alloc_irqs+0x114/0x344
> > [    6=2E772780]  __msi_domain_alloc_irqs+0x110/0x318
> > [    6=2E777408]  msi_domain_alloc_irqs+0x1c/0x28
> > [    6=2E781685]  pci_msi_setup_msi_irqs=2Eisra=2E0+0x2c/0x44
> > [    6=2E786662]  __pci_enable_msi_range+0x230/0x320
> > [    6=2E791202]  pci_enable_msi+0x1c/0x30
> > [    6=2E794874]  ath10k_pci_probe+0x480/0x748 [ath10k_pci]
> > [    6=2E800058]  pci_device_probe+0xbc/0x14c
> > [    6=2E804014]  really_probe+0x2a0/0x470
> > [    6=2E807701]  driver_probe_device+0x12c/0x13c
> > [    6=2E811981]  device_driver_attach+0x44/0x70
> > [    6=2E816181]  __driver_attach+0x13c/0x140
> > [    6=2E820126]  bus_for_each_dev+0x70/0xc0
> > [    6=2E823971]  driver_attach+0x24/0x30
> > [    6=2E827556]  bus_add_driver+0x1a4/0x1ec
> > [    6=2E831401]  driver_register+0xb4/0xec
> > [    6=2E835168]  __pci_register_driver+0x44/0x50
> > [    6=2E839465]  ath10k_pci_init+0x28/0x1000 [ath10k_pci]
> > [    6=2E844563]  do_one_initcall+0x6c/0x188
> > [    6=2E848431]  do_init_module+0x5c/0x1e8
> > [    6=2E852205]  load_module+0x1124/0x11c8
> > [    6=2E855967]  __do_sys_finit_module+0xdc/0x100
> > [    6=2E860335]  __arm64_sys_finit_module+0x1c/0x28
> > [    6=2E864877]  el0_svc_common=2Econstprop=2E0+0x124/0x198
> > [    6=2E869766]  do_el0_svc+0x48/0x78
> > [    6=2E873089]  el0_svc+0x14/0x20
> > [    6=2E876158]  el0_sync_handler+0xcc/0x154
> > [    6=2E880091]  el0_sync+0x174/0x180
> > [    6=2E883425] Code: d37c0400 51000421 8b000280 f861dac1 (f8216806)
> > [    6=2E889525] ---[ end trace 62498e1f489ea3ab ]---
> >=20
> > i guess it's a bug in ath10k driver or my r64 board (it is a v1=2E1
> > which has missing capacitors on tx lines)=2E
>=20
> No, this definitely looks like a bug in the MTK PCIe driver,
> where the mutex is either not properly initialised, corrupted,
> or the wrong pointer is passed=2E

but why does it happen only with the ath10k-card and not the mt7612 in sam=
e slot?

> This r64 machine is supposed to have working MSIs, right?

imho mt7622 have working MSI

> Do you get the same issue without this series?

tested 5=2E11=2E0 [1] without this series (but with your/thomas' patch fro=
m discussion about my old patch) and got same trace=2E so this series does =
not break anything here=2E

> > Tried with an mt7612e, this seems to work without any errors=2E
> >=20
> > so for mt7622/mt7623
> >=20
> > Tested-by: Frank Wunderlich <frank-w@public-files=2Ede>
>=20
> We definitely need to understand the above=2E

there is a hardware-bug which may cause this=2E=2E=2Eafair i saw this with=
 the card in r64 with earlier Kernel-versions where other cards work (like =
the mt7612e)=2E

regards Frank

[1] https://github=2Ecom/frank-w/BPI-R2-4=2E14/commits/5=2E11-main (pci: f=
ix MSI issue part X)
