Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1878146C4CF
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Dec 2021 21:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241420AbhLGUp4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Dec 2021 15:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241414AbhLGUpz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Dec 2021 15:45:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D545FC061574;
        Tue,  7 Dec 2021 12:42:24 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638909743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8kdDUloupcZ7zsHm8ipSzMG1KhDz+bCCecRfNXSnpkg=;
        b=myOlC5dgE3khI7L8VZJuvb0AqNwW72GyeFELcD1PBbXUtZ68+3HHkLJ6B3AHqyMzsf2WT8
        +ujqWMGHpaY4rsmjld2a82Vj5AIv9LECzrGlZmnD/32El3mdYogpJBXD830FzxpM64lfFA
        4umcD+gxjhc1TVxDz7X7+HSKF/BzRb/G2QPcgdTOuekTL5TVuB7tk2FDJgZvBY12rIApXt
        6/cKg45LVQbCHkJ50Jh/VwMaNydeam+MMtnO87aLsvswM8Dg0b8u1s2wEbGXeG0S5d8b8M
        gpLncVriJOZxdr/S+hNQBS9u1GXShwEAVsplRx5hkczW+cMOAp/ZAeGaDzJRnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638909743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8kdDUloupcZ7zsHm8ipSzMG1KhDz+bCCecRfNXSnpkg=;
        b=0V4XVUsOsvnU+9Fv3Fb95pdvdCgo/+dE0Mo+fVtsflMeNE/VXjrD4Tr1l/AitQqcrCl0wJ
        KhJ9aDeINWrmG3AA==
To:     =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
In-Reply-To: <27f22e0e-8f84-a6d7-704b-d9eddc642d74@kaod.org>
References: <20211206210147.872865823@linutronix.de>
 <20211206210223.872249537@linutronix.de>
 <8d1e9d2b-fbe9-2e15-6df6-03028902791a@kaod.org>
 <87ilw0odel.fsf@mpe.ellerman.id.au>
 <27f22e0e-8f84-a6d7-704b-d9eddc642d74@kaod.org>
Date:   Tue, 07 Dec 2021 21:42:22 +0100
Message-ID: <8735n42lld.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Cedric,

On Tue, Dec 07 2021 at 16:50, C=C3=A9dric Le Goater wrote:
> On 12/7/21 12:36, Michael Ellerman wrote:
>>=20
>> This patch should drop those selects I guess. Can you send an
>> incremental diff for Thomas to squash in?
>
> Sure.
>
>> Removing all the tendrils in various device tree files will probably
>> require some archaeology, and it should be perfectly safe to leave those
>> in the tree with the driver gone. So I think we can do that as a
>> subsequent patch, rather than in this series.
>
> Here are the changes. Compiled tested with ppc40x and ppc44x defconfigs.

< Lots of patch skipped />
> @@ -141,7 +138,6 @@ config REDWOOD
>   	select FORCE_PCI
>   	select PPC4xx_PCI_EXPRESS
>   	select PCI_MSI
> -	select PPC4xx_MSI
>   	help
>   	  This option enables support for the AMCC PPC460SX Redwood board.

While that is incremental it certainly is worth a patch on it's
own. Could you add a proper changelog and an SOB please?

Thanks,

        tglx
