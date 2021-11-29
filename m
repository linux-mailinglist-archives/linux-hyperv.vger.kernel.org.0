Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CFC462381
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Nov 2021 22:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhK2VoF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 29 Nov 2021 16:44:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56576 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhK2VmF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 29 Nov 2021 16:42:05 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638221925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sTsTXZmVNEttdKActcp/MQ79Sqm2VlTHeENYuk8KrhE=;
        b=ILyfVKGE5UZvmRThsq5XEtpixIVIivrUSBAXm+humQHTDLzWIKEX4H8+4OD+aeIfZ4DV92
        9T+62U6FIpWYIpoyRwMMumiAWctcb/I9yr1yNfsu8sRnZChwXIMAcSaHOA+Rqc6gRrobwk
        VD1hPi2gr2//sF+SQuC4nahdGSaDafaDW7sBy0aS8tR1r1meQJeCOwOOGRC5aIHAc9Xvk4
        /FJzDlJKlE89PcGuwq4SuMSriWZnI0H29jLtYIq6CXQ6TOUli2NIXrPAh97GMsBqbXW+Qh
        eBXpIwFI96/i9Jnc137e9kO89zceLA086wH/JPWoxTfUn5qn3H8Cfws4QVJy/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638221925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sTsTXZmVNEttdKActcp/MQ79Sqm2VlTHeENYuk8KrhE=;
        b=IFrPJPgHlzA5jXpCGMUgcnutoSn2o/emSpKWK3dUIvafMv+/N8+lm8fxoSszjkihxr/hYU
        KzMXez+vjEq3dIDw==
To:     =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-hyperv@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        sparclinux@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>, Marc Zygnier <maz@kernel.org>,
        x86@kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, ath11k@lists.infradead.org,
        Kevin Tian <kevin.tian@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Megha Dey <megha.dey@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch 05/22] genirq/msi: Fixup includes
In-Reply-To: <b1a6d267-c7b4-c4b9-ab0e-f5cc32bfe9bf@kaod.org>
References: <20211126222700.862407977@linutronix.de>
 <20211126223824.382273262@linutronix.de>
 <b1a6d267-c7b4-c4b9-ab0e-f5cc32bfe9bf@kaod.org>
Date:   Mon, 29 Nov 2021 22:38:44 +0100
Message-ID: <87tufud4m3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Cedric,

On Mon, Nov 29 2021 at 08:33, C=C3=A9dric Le Goater wrote:
> On 11/27/21 02:18, Thomas Gleixner wrote:
>> Remove the kobject.h include from msi.h as it's not required and add a
>> sysfs.h include to the core code instead.
>>=20
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
>
> This patch breaks compile on powerpc :
>
>    CC      arch/powerpc/kernel/msi.o
> In file included from ../arch/powerpc/kernel/msi.c:7:
> ../include/linux/msi.h:410:65: error: =E2=80=98struct cpumask=E2=80=99 de=
clared inside parameter list will not be visible outside of this definition=
 or declaration [-Werror]
>    410 | int msi_domain_set_affinity(struct irq_data *data, const struct =
cpumask *mask,
>        |                                                                 =
^~~~~~~
> cc1: all warnings being treated as errors
>
> Below is fix you can merge in patch 5.

thanks for having a look. I fixed up this and other fallout and pushed out =
an
updated series (all 4 parts) to:

        git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel msi

Thanks,

        tglx
