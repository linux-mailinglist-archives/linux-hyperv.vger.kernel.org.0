Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F155B328053
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Mar 2021 15:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbhCAOJe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 Mar 2021 09:09:34 -0500
Received: from mout.gmx.net ([212.227.17.22]:42215 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236125AbhCAOJS (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Mar 2021 09:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614607598;
        bh=den9Zg5WTYMa1+hk6yVW+XcXT5cE1vgzQ1fj1l8Xzmg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lK/QKL4Nn4oxvF+p3HJkfH+axulgw5KgJHU7z7PeqrC4umD8DhqfZ4Q4MPxPJOg3o
         3IwlkSopZVnHvn70fElJhcy1jpJr0izdHinuh7ZZqG2ZXsKzTpb97W3V8OgUnp/rgO
         H0Gmt2CC5RJ2+91u6nMKL7AoJvy8LZtrZTM57l20=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.155.40] ([217.61.155.40]) by web-mail.gmx.net
 (3c-app-gmx-bap67.server.lan [172.19.172.67]) (via HTTP); Mon, 1 Mar 2021
 15:06:38 +0100
MIME-Version: 1.0
Message-ID: <trinity-e6593a34-3e03-4154-a03c-f3aed01e33bf-1614607598428@3c-app-gmx-bap67>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Marc Zyngier <maz@kernel.org>,
        Chuanjia Liu <chuanjia.liu@mediatek.com>
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
Subject: Aw: Re:  Re:  [PATCH 09/13] PCI: mediatek: Advertise lack of MSI
 handling
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 1 Mar 2021 15:06:38 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <5afd1d656299d87c43bdf31b8ced2d5f@kernel.org>
References: <20210225151023.3642391-1-maz@kernel.org>
 <20210225151023.3642391-10-maz@kernel.org>
 <trinity-b7e2cf18-f0e6-4d88-8a80-de6758b5a91f-1614595396771@3c-app-gmx-bap67>
 <b7721e2ff751cc9565a662cb713819e3@kernel.org>
 <trinity-9fa6d24e-f9de-4741-bf44-86f6197b174d-1614600961297@3c-app-gmx-bap67>
 <5afd1d656299d87c43bdf31b8ced2d5f@kernel.org>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:ZQRRsjs6c1f84vfCoFTlATSpGq7/GPSSqcOXpNHZnIPBxXdGKhnluVmsRPL7cvd5TixfO
 rd++Gy3YXyTot3JK+rRMPXe91y4N7z8P1CbSHrdHSLRLID8kPxErKuGOmXrleO0Bfb/FSYLVD7I1
 exjG1WwZLNf5mVqZAzqoqU+D2jXRNkmHYRdopomO4GdIOot/isQJAVevQ9dFLx9eAKpi1FqR7jLw
 E4devkrLQdn73q338vzExSxYVbRc4wqcWru7hdZXCfLQogz/sYe3GUE2V0pDJ2F9Bx0nnqfifZU4
 tU=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KytOOKdXDHg=:nIlbptdfbifxSWJxa1OENK
 vqWu+JcL+p7AVrxyhTxBs9N3lu1OZ6alc2D+z8+8P5aBLH/tR6sFTAxujDL0D39bhvvgTkPQA
 1C+xGfcWpNc3o341HgE8sVMz4/zXiUbpHh5khZM9fiOPl7M7LHWvyVeMveOXcbiui0sLfNRjt
 4/V/EmQ/QPR9S1OMHVLlx+pYYoDrNXVXDHx8g2jUllJQeFIA7+gJJJ++GLkKDsUl3mEjezfHH
 hk7KB2wWc2KfU68qPtxNstL3cDRbTn6nFavqAnIKeGWOxIBaVbLfEZMRJrmLczqEZOiUani21
 +flCSu7xfQpJU0Rhz+vjORbcGFGIT4zyr2UUM8bFjDV2DwQTUFIvlixb+tZx6g4LJkL+87eW/
 qgt9DIwUT4WlUIxqGqBCZI30vs/P8eiyGhxIVLz9BrjOYH5AsEatn6KFiv89MzaVjvNxDy6QU
 b4u1/eKsLbnLqRPKfZHQCL8gZ7+ZYzRD+yZ3L0WBEb8UiUTx8TOKpTLCTuNNvFKXrfr+/QFYl
 HgK6+96WGuPk9VEq2c3gIY37/zs3+lLh6w7g5FekMLDvpTi1NUgCiiXsw3V7L01UuZqA99QDO
 YFzWVW5oOYmGY=
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Gesendet: Montag, 01=2E M=C3=A4rz 2021 um 14:31 Uhr
> Von: "Marc Zyngier" <maz@kernel=2Eorg>
>
> Frank,
>=20
> >> > i guess it's a bug in ath10k driver or my r64 board (it is a v1=2E1
> >> > which has missing capacitors on tx lines)=2E
> >>=20
> >> No, this definitely looks like a bug in the MTK PCIe driver,
> >> where the mutex is either not properly initialised, corrupted,
> >> or the wrong pointer is passed=2E
> >=20
> > but why does it happen only with the ath10k-card and not the mt7612 in
> > same slot?
>=20
> Does mt7612 use MSI? What we have here is a bogus mutex in the
> MTK PCIe driver, and the only way not to get there would be
> to avoid using MSIs=2E

i guess this card/its driver does not use MSI=2E Did not found anything in=
 "datasheet" [1] or driver [2] about msi

> >=20
> >> This r64 machine is supposed to have working MSIs, right?
> >=20
> > imho mt7622 have working MSI
> >=20
> >> Do you get the same issue without this series?
> >=20
> > tested 5=2E11=2E0 [1] without this series (but with your/thomas' patch
> > from discussion about my old patch) and got same trace=2E so this seri=
es
> > does not break anything here=2E
>=20
> Can you retest without any additional patch on top of 5=2E11?
> These two patches only affect platforms that do *not* have MSIs at all=
=2E

i can revert these 2, but still need patches for mt7622 pcie-support [3]=
=2E=2E=2Ebtw=2E i see that i miss these in 5=2E11-main=2E=2E=2Edo not see t=
raceback with them (have firmware not installed=2E=2E=2E)

root@bpi-r64:~# dmesg | grep ath                                          =
     =20
[    6=2E450765] ath10k_pci 0000:01:00=2E0: assign IRQ: got 146           =
         =20
[    6=2E661752] ath10k_pci 0000:01:00=2E0: enabling device (0000 -> 0002)=
         =20
[    6=2E697811] ath10k_pci 0000:01:00=2E0: enabling bus mastering        =
         =20
[    6=2E721293] ath10k_pci 0000:01:00=2E0: pci irq msi oper_irq_mode 2 ir=
q_mode 0 r
eset_mode 0                                                               =
     =20
[    6=2E921030] ath10k_pci 0000:01:00=2E0: Failed to find firmware-N=2Ebi=
n (N between
 2 and 6) from ath10k/QCA988X/hw2=2E0: -2                                 =
       =20
[    6=2E931698] ath10k_pci 0000:01:00=2E0: could not fetch firmware files=
 (-2)    =20
[    6=2E940417] ath10k_pci 0000:01:00=2E0: could not probe fw (-2)

so traceback was caused by missing changes in mtk pcie-driver not yet upst=
ream, added Chuanjia Liu

> >=20
> >> > Tried with an mt7612e, this seems to work without any errors=2E
> >> >
> >> > so for mt7622/mt7623
> >> >
> >> > Tested-by: Frank Wunderlich <frank-w@public-files=2Ede>
> >>=20
> >> We definitely need to understand the above=2E
> >=20
> > there is a hardware-bug which may cause this=2E=2E=2Eafair i saw this =
with
> > the card in r64 with earlier Kernel-versions where other cards work
> > (like the mt7612e)=2E
>=20
> I don't think a HW bug affecting PCI would cause what we are seeing
> here, unless it results in memory corruption=2E


[1] https://www=2Easiarf=2Ecom/shop/wifi-wlan/wifi_mini_pcie/ws2433-wifi-1=
1ac-mini-pcie-module-manufacturer/
[2] grep -Rni 'msi' drivers/net/wireless/mediatek/mt76/mt76x2/
[3] https://patchwork=2Ekernel=2Eorg/project/linux-mediatek/list/?series=
=3D372885
