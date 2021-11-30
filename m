Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFC04640C0
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Nov 2021 22:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbhK3Vxm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Nov 2021 16:53:42 -0500
Received: from 8.mo552.mail-out.ovh.net ([46.105.37.156]:51719 "EHLO
        8.mo552.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344759AbhK3Vv4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Nov 2021 16:51:56 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.123])
        by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 0AD47216DE;
        Tue, 30 Nov 2021 21:48:24 +0000 (UTC)
Received: from kaod.org (37.59.142.99) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 30 Nov
 2021 22:48:23 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-99G00338e8fa02-b36d-46a2-a9ce-03d85f7b4222,
                    1FE831E2BDC1BE20692CF32662DF656E64B35270) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.11.56.15
Message-ID: <524d9b84-caa8-dd6f-bb5e-9fc906d279c0@kaod.org>
Date:   Tue, 30 Nov 2021 22:48:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [patch 05/22] genirq/msi: Fixup includes
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     <linux-hyperv@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
        <sparclinux@vger.kernel.org>, Wei Liu <wei.liu@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>, Marc Zygnier <maz@kernel.org>,
        <x86@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>, <linux-pci@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <ath11k@lists.infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Megha Dey <megha.dey@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-mips@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
References: <20211126222700.862407977@linutronix.de>
 <20211126223824.382273262@linutronix.de>
 <b1a6d267-c7b4-c4b9-ab0e-f5cc32bfe9bf@kaod.org> <87tufud4m3.ffs@tglx>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <87tufud4m3.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 16c7449c-9f55-435d-bf3c-7f66bf2ab8fd
X-Ovh-Tracer-Id: 11252243670229552028
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddriedugdduheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepjeekvdfgudevkeefkeeltdejteekvdegffegudetgeettdffjeefheekfeelffdtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrgh
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 11/29/21 22:38, Thomas Gleixner wrote:
> Cedric,
> 
> On Mon, Nov 29 2021 at 08:33, Cédric Le Goater wrote:
>> On 11/27/21 02:18, Thomas Gleixner wrote:
>>> Remove the kobject.h include from msi.h as it's not required and add a
>>> sysfs.h include to the core code instead.
>>>
>>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>
>>
>> This patch breaks compile on powerpc :
>>
>>     CC      arch/powerpc/kernel/msi.o
>> In file included from ../arch/powerpc/kernel/msi.c:7:
>> ../include/linux/msi.h:410:65: error: ‘struct cpumask’ declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>>     410 | int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
>>         |                                                                 ^~~~~~~
>> cc1: all warnings being treated as errors
>>
>> Below is fix you can merge in patch 5.
> 
> thanks for having a look. I fixed up this and other fallout and pushed out an
> updated series (all 4 parts) to:
> 
>          git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel msi

pSeries fails to allocate MSIs starting with this patch :

  [PATCH 049/101] powerpc/pseries/msi: Let core code check for contiguous ...

I will dig in later on.

C.
