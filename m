Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3DC4647DB
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Dec 2021 08:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbhLAHZ1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Dec 2021 02:25:27 -0500
Received: from 3.mo552.mail-out.ovh.net ([178.33.254.192]:40793 "EHLO
        3.mo552.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhLAHZ1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Dec 2021 02:25:27 -0500
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Dec 2021 02:25:26 EST
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.125])
        by mo552.mail-out.ovh.net (Postfix) with ESMTPS id B6B2D217F7;
        Wed,  1 Dec 2021 07:14:07 +0000 (UTC)
Received: from kaod.org (37.59.142.105) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 1 Dec
 2021 08:14:05 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-105G00686e3cafe-0521-4f42-aedc-fcaeb2775d24,
                    A214034E9EDAB49BEA2160BF49F8C38F118F2259) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.11.56.15
Message-ID: <39556bdc-f48c-68b2-6bec-5975b92e02e2@kaod.org>
Date:   Wed, 1 Dec 2021 08:14:05 +0100
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
 <524d9b84-caa8-dd6f-bb5e-9fc906d279c0@kaod.org> <87czmhb8gq.ffs@tglx>
 <875ys9b71j.ffs@tglx>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <875ys9b71j.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: e52f034b-6a74-4e80-b1cd-9a54c9a992a9
X-Ovh-Tracer-Id: 2359604732828158876
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddriedvgddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepjeekvdfgudevkeefkeeltdejteekvdegffegudetgeettdffjeefheekfeelffdtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhg
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 11/30/21 23:41, Thomas Gleixner wrote:
> On Tue, Nov 30 2021 at 23:10, Thomas Gleixner wrote:
> 
>> On Tue, Nov 30 2021 at 22:48, Cédric Le Goater wrote:
>>> On 11/29/21 22:38, Thomas Gleixner wrote:
>>>> On Mon, Nov 29 2021 at 08:33, Cédric Le Goater wrote:
>>>> thanks for having a look. I fixed up this and other fallout and pushed out an
>>>> updated series (all 4 parts) to:
>>>>
>>>>           git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel msi
>>>
>>> pSeries fails to allocate MSIs starting with this patch :
>>>
>>>    [PATCH 049/101] powerpc/pseries/msi: Let core code check for contiguous ...
>>>
>>> I will dig in later on.
>>
>> Let me stare at the core function..
> 
> It's not the core function. It's the patch above and I'm a moron.

All good now. Ship it !

Thanks,

C.




