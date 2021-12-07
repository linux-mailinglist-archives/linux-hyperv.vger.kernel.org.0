Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBF446BA24
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Dec 2021 12:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbhLGLjh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Dec 2021 06:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhLGLjg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Dec 2021 06:39:36 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C4EC061574;
        Tue,  7 Dec 2021 03:36:06 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J7dXf3dSsz4xYy;
        Tue,  7 Dec 2021 22:36:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1638876964;
        bh=lTsXMkBa68SdK2mCmwfpSshAWpT0dRMMMq4RDsTmMUc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BMwzDWkPEIYhXynBVAirAw4gLvuuvW+w979j7Yqtpl/UPXPORphUfbt+jK+l0pabP
         GTehyWDzuL/CjvtZ3vJKYoj5rsJPb1bnDWny7P2YlVPjCcML69cHmHBNG0AIDWe7Gz
         7IRiJMIJ4Kb9b5hGDoNDnHaxCTClNUWIJdKvD1WISOHxae57UeEHW0ELnQ3BY1ByPF
         1oPzO4gyeKDsiFe+zukx8HTbH7jtndcbjgt+u2Img9ev7FSfwZJM9PLRYWX7kshjFe
         JBwE+rXxecauzokxEZQ57uU9ynC6VsB3Nd14q1sEiH2ivRH0Hx8EhFL3DwxqA8pymw
         p3ZiZsIoOoIIQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Juergen Gross <jgross@suse.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparclinux@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org, ath11k@lists.infradead.org,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [patch V2 01/23] powerpc/4xx: Remove MSI support which never
 worked
In-Reply-To: <8d1e9d2b-fbe9-2e15-6df6-03028902791a@kaod.org>
References: <20211206210147.872865823@linutronix.de>
 <20211206210223.872249537@linutronix.de>
 <8d1e9d2b-fbe9-2e15-6df6-03028902791a@kaod.org>
Date:   Tue, 07 Dec 2021 22:36:02 +1100
Message-ID: <87ilw0odel.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

C=C3=A9dric Le Goater <clg@kaod.org> writes:
> Hello Thomas,
>
> On 12/6/21 23:27, Thomas Gleixner wrote:
>> This code is broken since day one. ppc4xx_setup_msi_irqs() has the
>> following gems:
>>=20
>>   1) The handling of the result of msi_bitmap_alloc_hwirqs() is complete=
ly
>>      broken:
>>=20=20=20=20=20=20
>>      When the result is greater than or equal 0 (bitmap allocation
>>      successful) then the loop terminates and the function returns 0
>>      (success) despite not having installed an interrupt.
>>=20
>>      When the result is less than 0 (bitmap allocation fails), it prints=
 an
>>      error message and continues to "work" with that error code which wo=
uld
>>      eventually end up in the MSI message data.
>>=20
>>   2) On every invocation the file global pp4xx_msi::msi_virqs bitmap is
>>      allocated thereby leaking the previous one.
>>=20
>> IOW, this has never worked and for more than 10 years nobody cared. Remo=
ve
>> the gunk.
>>=20
>> Fixes: 3fb7933850fa ("powerpc/4xx: Adding PCIe MSI support")
>
> Shouldn't we remove all of it ? including the updates in the device trees
> and the Kconfig changes under :
>
> arch/powerpc/platforms/44x/Kconfig:	select PPC4xx_MSI
> arch/powerpc/platforms/44x/Kconfig:	select PPC4xx_MSI
> arch/powerpc/platforms/44x/Kconfig:	select PPC4xx_MSI
> arch/powerpc/platforms/44x/Kconfig:	select PPC4xx_MSI
> arch/powerpc/platforms/40x/Kconfig:	select PPC4xx_MSI

This patch should drop those selects I guess. Can you send an
incremental diff for Thomas to squash in?

Removing all the tendrils in various device tree files will probably
require some archaeology, and it should be perfectly safe to leave those
in the tree with the driver gone. So I think we can do that as a
subsequent patch, rather than in this series.

cheers
