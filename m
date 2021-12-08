Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DBE46D163
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Dec 2021 11:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhLHK4H (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Dec 2021 05:56:07 -0500
Received: from smtpout4.mo529.mail-out.ovh.net ([217.182.185.173]:55553 "EHLO
        smtpout4.mo529.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhLHK4H (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Dec 2021 05:56:07 -0500
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Dec 2021 05:56:07 EST
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.35])
        by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4A0F4D092F09;
        Wed,  8 Dec 2021 11:44:42 +0100 (CET)
Received: from kaod.org (37.59.142.96) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 8 Dec
 2021 11:44:40 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-96R001f5056120-68a4-4c0a-bc06-f617410d6d7e,
                    EB01F339838E5AA67C986A6C3251B49097B81903) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 86.201.172.254
Message-ID: <e92f2bb3-b5e1-c870-8151-3917a789a640@kaod.org>
Date:   Wed, 8 Dec 2021 11:44:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [patch V2 01/23] powerpc/4xx: Remove MSI support which never
 worked
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, <linux-pci@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linuxppc-dev@lists.ozlabs.org>, Juergen Gross <jgross@suse.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-mips@vger.kernel.org>, Kalle Valo <kvalo@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <sparclinux@vger.kernel.org>, <x86@kernel.org>,
        <xen-devel@lists.xenproject.org>, <ath11k@lists.infradead.org>,
        Wei Liu <wei.liu@kernel.org>, <linux-hyperv@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
References: <20211206210147.872865823@linutronix.de>
 <20211206210223.872249537@linutronix.de>
 <8d1e9d2b-fbe9-2e15-6df6-03028902791a@kaod.org>
 <87ilw0odel.fsf@mpe.ellerman.id.au>
 <27f22e0e-8f84-a6d7-704b-d9eddc642d74@kaod.org> <8735n42lld.ffs@tglx>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <8735n42lld.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: d54a9dd7-eba7-4e7f-a7a0-0dc7c43fc796
X-Ovh-Tracer-Id: 10131410315672259365
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrjeekgddulecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeuveelvdejteegteefieevfeetffefvddvieekteevleefgeelgfeutedvfedvfeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehhtggrsehlihhnuhigrdhisghmrdgtohhm
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 12/7/21 21:42, Thomas Gleixner wrote:
> Cedric,
> 
> On Tue, Dec 07 2021 at 16:50, Cédric Le Goater wrote:
>> On 12/7/21 12:36, Michael Ellerman wrote:
>>>
>>> This patch should drop those selects I guess. Can you send an
>>> incremental diff for Thomas to squash in?
>>
>> Sure.
>>
>>> Removing all the tendrils in various device tree files will probably
>>> require some archaeology, and it should be perfectly safe to leave those
>>> in the tree with the driver gone. So I think we can do that as a
>>> subsequent patch, rather than in this series.
>>
>> Here are the changes. Compiled tested with ppc40x and ppc44x defconfigs.
> 
> < Lots of patch skipped />
>> @@ -141,7 +138,6 @@ config REDWOOD
>>    	select FORCE_PCI
>>    	select PPC4xx_PCI_EXPRESS
>>    	select PCI_MSI
>> -	select PPC4xx_MSI
>>    	help
>>    	  This option enables support for the AMCC PPC460SX Redwood board.
> 
> While that is incremental it certainly is worth a patch on it's
> own. Could you add a proper changelog and an SOB please?

Here you are.

  https://github.com/legoater/linux/commit/75d2764b11fe8f6d8bf50d60a3feb599ce27b16d

Thanks,

C.
