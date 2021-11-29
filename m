Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC9E460FAC
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Nov 2021 08:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbhK2ICq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 29 Nov 2021 03:02:46 -0500
Received: from 4.mo548.mail-out.ovh.net ([188.165.42.229]:42785 "EHLO
        4.mo548.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241488AbhK2IAp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 29 Nov 2021 03:00:45 -0500
X-Greylist: delayed 567 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Nov 2021 03:00:45 EST
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.121])
        by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 1E69A2045C;
        Mon, 29 Nov 2021 07:51:11 +0000 (UTC)
Received: from kaod.org (37.59.142.95) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 29 Nov
 2021 08:51:10 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-95G0018853b231-08ce-4c1d-9d13-72c8b66df497,
                    3279756C2EB34864E332BB908A933B747C53BE44) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <1ecfbea2-e5f7-b28b-5345-8b2ee82ae861@kaod.org>
Date:   Mon, 29 Nov 2021 08:51:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [patch 17/22] PCI/MSI: Split out !IRQDOMAIN code
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
 <20211126223825.093887718@linutronix.de>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20211126223825.093887718@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 8993720d-da60-4607-9d73-3bc5ffee8fa3
X-Ovh-Tracer-Id: 9686961325338364828
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrheekgdehudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgihesthejredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpefhhfelgeeukedtteffvdffueeiuefgkeekleehleetfedtgfetffefheeugeelheenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrgh
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


> +void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
> +{
> +	struct msi_desc *desc;
> +	int i;
> +
> +	for_each_pci_msi_entry(desc, dev) {
> +		if (desc->irq) {
> +			for (i = 0; i < entry->nvec_used; i++)

I guess this is 'desc' ?

Thanks,

C.

> +				arch_teardown_msi_irq(desc->irq + i);
> +		}
> +	}
> +}
