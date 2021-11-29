Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E7E46102D
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Nov 2021 09:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243376AbhK2Icl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 29 Nov 2021 03:32:41 -0500
Received: from 4.mo548.mail-out.ovh.net ([188.165.42.229]:38523 "EHLO
        4.mo548.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345661AbhK2Iak (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 29 Nov 2021 03:30:40 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.7])
        by mo548.mail-out.ovh.net (Postfix) with ESMTPS id D10AB2064C;
        Mon, 29 Nov 2021 07:33:34 +0000 (UTC)
Received: from kaod.org (37.59.142.103) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 29 Nov
 2021 08:33:33 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-103G0058ffb0110-7673-40ee-a51a-c9a65a45fa89,
                    3279756C2EB34864E332BB908A933B747C53BE44) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <b1a6d267-c7b4-c4b9-ab0e-f5cc32bfe9bf@kaod.org>
Date:   Mon, 29 Nov 2021 08:33:33 +0100
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
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20211126223824.382273262@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 67cb6c92-6833-4394-901b-34c8b386eb6d
X-Ovh-Tracer-Id: 9389442276353674140
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrheekgdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeigedvffekgeeftedutddttdevudeihfegudffkeeitdekkeetkefhffelveelleenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhg
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 11/27/21 02:18, Thomas Gleixner wrote:
> Remove the kobject.h include from msi.h as it's not required and add a
> sysfs.h include to the core code instead.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


This patch breaks compile on powerpc :

   CC      arch/powerpc/kernel/msi.o
In file included from ../arch/powerpc/kernel/msi.c:7:
../include/linux/msi.h:410:65: error: ‘struct cpumask’ declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
   410 | int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
       |                                                                 ^~~~~~~
cc1: all warnings being treated as errors

Below is fix you can merge in patch 5.

Thanks,

C.

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -2,6 +2,7 @@
  #ifndef LINUX_MSI_H
  #define LINUX_MSI_H
  
+#include <linux/cpumask.h>
  #include <linux/list.h>
  #include <asm/msi.h>

> ---
>   include/linux/msi.h |    1 -
>   kernel/irq/msi.c    |    1 +
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -2,7 +2,6 @@
>   #ifndef LINUX_MSI_H
>   #define LINUX_MSI_H
>   
> -#include <linux/kobject.h>
>   #include <linux/list.h>
>   #include <asm/msi.h>
>   
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -14,6 +14,7 @@
>   #include <linux/irqdomain.h>
>   #include <linux/msi.h>
>   #include <linux/slab.h>
> +#include <linux/sysfs.h>
>   #include <linux/pci.h>
>   
>   #include "internals.h"
> 

