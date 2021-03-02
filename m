Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9EB32A661
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Mar 2021 17:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382123AbhCBOoa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Mar 2021 09:44:30 -0500
Received: from foss.arm.com ([217.140.110.172]:49078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1838377AbhCBKgK (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Mar 2021 05:36:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8851AED1;
        Tue,  2 Mar 2021 02:35:24 -0800 (PST)
Received: from [10.57.48.219] (unknown [10.57.48.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25EFF3F73C;
        Tue,  2 Mar 2021 02:35:20 -0800 (PST)
Subject: Re: Aw: Re: Re: [PATCH 09/13] PCI: mediatek: Advertise lack of MSI
 handling
To:     Frank Wunderlich <frank-w@public-files.de>,
        Marc Zyngier <maz@kernel.org>,
        Chuanjia Liu <chuanjia.liu@mediatek.com>
Cc:     linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Will Deacon <will@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Rob Herring <robh@kernel.org>, Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-tegra@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20210225151023.3642391-1-maz@kernel.org>
 <20210225151023.3642391-10-maz@kernel.org>
 <trinity-b7e2cf18-f0e6-4d88-8a80-de6758b5a91f-1614595396771@3c-app-gmx-bap67>
 <b7721e2ff751cc9565a662cb713819e3@kernel.org>
 <trinity-9fa6d24e-f9de-4741-bf44-86f6197b174d-1614600961297@3c-app-gmx-bap67>
 <5afd1d656299d87c43bdf31b8ced2d5f@kernel.org>
 <trinity-e6593a34-3e03-4154-a03c-f3aed01e33bf-1614607598428@3c-app-gmx-bap67>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8b9c013a-b5d5-9b19-f28a-4af543e47fff@arm.com>
Date:   Tue, 2 Mar 2021 10:35:14 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <trinity-e6593a34-3e03-4154-a03c-f3aed01e33bf-1614607598428@3c-app-gmx-bap67>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2021-03-01 14:06, Frank Wunderlich wrote:
>> Gesendet: Montag, 01. März 2021 um 14:31 Uhr
>> Von: "Marc Zyngier" <maz@kernel.org>
>>
>> Frank,
>>
>>>>> i guess it's a bug in ath10k driver or my r64 board (it is a v1.1
>>>>> which has missing capacitors on tx lines).
>>>>
>>>> No, this definitely looks like a bug in the MTK PCIe driver,
>>>> where the mutex is either not properly initialised, corrupted,
>>>> or the wrong pointer is passed.
>>>
>>> but why does it happen only with the ath10k-card and not the mt7612 in
>>> same slot?
>>
>> Does mt7612 use MSI? What we have here is a bogus mutex in the
>> MTK PCIe driver, and the only way not to get there would be
>> to avoid using MSIs.
> 
> i guess this card/its driver does not use MSI. Did not found anything in "datasheet" [1] or driver [2] about msi

FWIW, no need to guess - `lspci -v` (as root) should tell you whether 
the card has MSI (and/or MSI-X) capability, and whether it is enabled if so.

Robin.

>>>
>>>> This r64 machine is supposed to have working MSIs, right?
>>>
>>> imho mt7622 have working MSI
>>>
>>>> Do you get the same issue without this series?
>>>
>>> tested 5.11.0 [1] without this series (but with your/thomas' patch
>>> from discussion about my old patch) and got same trace. so this series
>>> does not break anything here.
>>
>> Can you retest without any additional patch on top of 5.11?
>> These two patches only affect platforms that do *not* have MSIs at all.
> 
> i can revert these 2, but still need patches for mt7622 pcie-support [3]...btw. i see that i miss these in 5.11-main...do not see traceback with them (have firmware not installed...)
> 
> root@bpi-r64:~# dmesg | grep ath
> [    6.450765] ath10k_pci 0000:01:00.0: assign IRQ: got 146
> [    6.661752] ath10k_pci 0000:01:00.0: enabling device (0000 -> 0002)
> [    6.697811] ath10k_pci 0000:01:00.0: enabling bus mastering
> [    6.721293] ath10k_pci 0000:01:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 r
> eset_mode 0
> [    6.921030] ath10k_pci 0000:01:00.0: Failed to find firmware-N.bin (N between
>   2 and 6) from ath10k/QCA988X/hw2.0: -2
> [    6.931698] ath10k_pci 0000:01:00.0: could not fetch firmware files (-2)
> [    6.940417] ath10k_pci 0000:01:00.0: could not probe fw (-2)
> 
> so traceback was caused by missing changes in mtk pcie-driver not yet upstream, added Chuanjia Liu
> 
>>>
>>>>> Tried with an mt7612e, this seems to work without any errors.
>>>>>
>>>>> so for mt7622/mt7623
>>>>>
>>>>> Tested-by: Frank Wunderlich <frank-w@public-files.de>
>>>>
>>>> We definitely need to understand the above.
>>>
>>> there is a hardware-bug which may cause this...afair i saw this with
>>> the card in r64 with earlier Kernel-versions where other cards work
>>> (like the mt7612e).
>>
>> I don't think a HW bug affecting PCI would cause what we are seeing
>> here, unless it results in memory corruption.
> 
> 
> [1] https://www.asiarf.com/shop/wifi-wlan/wifi_mini_pcie/ws2433-wifi-11ac-mini-pcie-module-manufacturer/
> [2] grep -Rni 'msi' drivers/net/wireless/mediatek/mt76/mt76x2/
> [3] https://patchwork.kernel.org/project/linux-mediatek/list/?series=372885
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
