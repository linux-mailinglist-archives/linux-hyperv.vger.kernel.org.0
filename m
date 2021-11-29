Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F9A461102
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Nov 2021 10:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbhK2J1x (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 29 Nov 2021 04:27:53 -0500
Received: from 5.mo548.mail-out.ovh.net ([188.165.49.213]:42217 "EHLO
        5.mo548.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhK2JZx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 29 Nov 2021 04:25:53 -0500
X-Greylist: delayed 5115 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Nov 2021 04:25:52 EST
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.148])
        by mo548.mail-out.ovh.net (Postfix) with ESMTPS id BB56A20523;
        Mon, 29 Nov 2021 07:47:59 +0000 (UTC)
Received: from kaod.org (37.59.142.103) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 29 Nov
 2021 08:47:58 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-103G00595d4a801-821e-4892-b50b-80a730e95f26,
                    3279756C2EB34864E332BB908A933B747C53BE44) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <7e3022e0-2183-288b-a4ae-e2e1e0551b38@kaod.org>
Date:   Mon, 29 Nov 2021 08:47:55 +0100
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
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 0f0123d7-fbb1-4bc8-86c7-5f8c7875e9d6
X-Ovh-Tracer-Id: 9632918131166251932
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrheekgdehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgihesthejredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpefhhfelgeeukedtteffvdffueeiuefgkeekleehleetfedtgfetffefheeugeelheenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhg
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 11/27/21 02:19, Thomas Gleixner wrote:
> Split out the non irqdomain code into its own file.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   drivers/pci/msi/Makefile |    5 ++--
>   drivers/pci/msi/legacy.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/pci/msi/msi.c    |   46 ------------------------------------------
>   3 files changed, 54 insertions(+), 48 deletions(-)
> 
> --- a/drivers/pci/msi/Makefile
> +++ b/drivers/pci/msi/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   #
>   # Makefile for the PCI/MSI
> -obj-$(CONFIG_PCI)		+= pcidev_msi.o
> -obj-$(CONFIG_PCI_MSI)		+= msi.o
> +obj-$(CONFIG_PCI)			+= pcidev_msi.o
> +obj-$(CONFIG_PCI_MSI)			+= msi.o
> +obj-$(CONFIG_PCI_MSI_ARCH_FALLBACKS)	+= legacy.o
> --- /dev/null
> +++ b/drivers/pci/msi/legacy.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCI Message Signaled Interrupt (MSI).
> + *
> + * Legacy architecture specific setup and teardown mechanism.
> + */
> +#include "msi.h"


I am getting a :

../drivers/pci/msi/legacy.c:7:10: fatal error: msi.h: No such file or directory
     7 | #include "msi.h"

which seems to be fixed later.

C.

> +
> +/* Arch hooks */
> +int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> +{
> +	return -EINVAL;
> +}
> +
> +void __weak arch_teardown_msi_irq(unsigned int irq)
> +{
> +}
> +
> +int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> +{
> +	struct msi_desc *desc;
> +	int ret;
> +
> +	/*
> +	 * If an architecture wants to support multiple MSI, it needs to
> +	 * override arch_setup_msi_irqs()
> +	 */
> +	if (type == PCI_CAP_ID_MSI && nvec > 1)
> +		return 1;
> +
> +	for_each_pci_msi_entry(desc, dev) {
> +		ret = arch_setup_msi_irq(dev, desc);
> +		if (ret)
> +			return ret < 0 ? ret : -ENOSPC;
> +	}
> +
> +	return 0;
> +}
> +
> +void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
> +{
> +	struct msi_desc *desc;
> +	int i;
> +
> +	for_each_pci_msi_entry(desc, dev) {
> +		if (desc->irq) {
> +			for (i = 0; i < entry->nvec_used; i++)
> +				arch_teardown_msi_irq(desc->irq + i);
> +		}
> +	}
> +}
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -50,52 +50,6 @@ static void pci_msi_teardown_msi_irqs(st
>   #define pci_msi_teardown_msi_irqs	arch_teardown_msi_irqs
>   #endif
>   
> -#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
> -/* Arch hooks */
> -int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> -{
> -	return -EINVAL;
> -}
> -
> -void __weak arch_teardown_msi_irq(unsigned int irq)
> -{
> -}
> -
> -int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> -{
> -	struct msi_desc *entry;
> -	int ret;
> -
> -	/*
> -	 * If an architecture wants to support multiple MSI, it needs to
> -	 * override arch_setup_msi_irqs()
> -	 */
> -	if (type == PCI_CAP_ID_MSI && nvec > 1)
> -		return 1;
> -
> -	for_each_pci_msi_entry(entry, dev) {
> -		ret = arch_setup_msi_irq(dev, entry);
> -		if (ret < 0)
> -			return ret;
> -		if (ret > 0)
> -			return -ENOSPC;
> -	}
> -
> -	return 0;
> -}
> -
> -void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
> -{
> -	int i;
> -	struct msi_desc *entry;
> -
> -	for_each_pci_msi_entry(entry, dev)
> -		if (entry->irq)
> -			for (i = 0; i < entry->nvec_used; i++)
> -				arch_teardown_msi_irq(entry->irq + i);
> -}
> -#endif /* CONFIG_PCI_MSI_ARCH_FALLBACKS */
> -
>   /*
>    * PCI 2.3 does not specify mask bits for each MSI interrupt.  Attempting to
>    * mask all MSI interrupts by clearing the MSI enable bit does not work
> 

