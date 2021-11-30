Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A3C4641A9
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Nov 2021 23:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344845AbhK3WpQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Nov 2021 17:45:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36276 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345079AbhK3Wov (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Nov 2021 17:44:51 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638312089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1bOw8HEe7jHxyt1BTzbWx6wvk9iJpbF5Gn0Kg7y1Blo=;
        b=2IrmNv3Iea3b/0P87xEGqZAZmwL1onSUMGqd0zxtDIRJLTynmNSC7uxIH8L/l5dtLj/5OD
        JagFWx3aJMiS1LFIeYftEfo0Ur2kNjTtrOTkBnBmsBzvAxM9ucbFfqPVN5bViblbdfTyHh
        DmsunGG30VGceQJj3KLRF3KIyBTUwjdi6+cIFEZFOGwVLxR6/Qv+GDEs3kZsbO3Sb5vEY4
        CGDmi02z+2/4fP0CRSLAGmUXhnn/6DLG04oqIJtIelaVlS8RIp1r9e2Sxk09e7hCcOFzEs
        b9sVLSs/CWxPIfpw834x9ILDVWh3TWdsOj5JuMEeZ6q+sN/NVCvFkfOxPIzp8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638312089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1bOw8HEe7jHxyt1BTzbWx6wvk9iJpbF5Gn0Kg7y1Blo=;
        b=wP+0RlPVEZMaKpggmpseYFDjn/awmzpDeY9BMit0WIgaUAvSVTefpWgNK6fro3P2SJv3Ar
        0+sa+FEk57SExTAA==
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
In-Reply-To: <87czmhb8gq.ffs@tglx>
References: <20211126222700.862407977@linutronix.de>
 <20211126223824.382273262@linutronix.de>
 <b1a6d267-c7b4-c4b9-ab0e-f5cc32bfe9bf@kaod.org> <87tufud4m3.ffs@tglx>
 <524d9b84-caa8-dd6f-bb5e-9fc906d279c0@kaod.org> <87czmhb8gq.ffs@tglx>
Date:   Tue, 30 Nov 2021 23:41:28 +0100
Message-ID: <875ys9b71j.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Nov 30 2021 at 23:10, Thomas Gleixner wrote:

> On Tue, Nov 30 2021 at 22:48, C=C3=A9dric Le Goater wrote:
>> On 11/29/21 22:38, Thomas Gleixner wrote:
>>> On Mon, Nov 29 2021 at 08:33, C=C3=A9dric Le Goater wrote:
>>> thanks for having a look. I fixed up this and other fallout and pushed =
out an
>>> updated series (all 4 parts) to:
>>>=20
>>>          git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel msi
>>
>> pSeries fails to allocate MSIs starting with this patch :
>>
>>   [PATCH 049/101] powerpc/pseries/msi: Let core code check for contiguou=
s ...
>>
>> I will dig in later on.
>
> Let me stare at the core function..

It's not the core function. It's the patch above and I'm a moron.

--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -359,9 +359,6 @@ static int rtas_prepare_msi_irqs(struct
 	if (quota && quota < nvec)
 		return quota;
=20
-	if (type =3D=3D PCI_CAP_ID_MSIX)
-		return -EINVAL;
-
 	/*
 	 * Firmware currently refuse any non power of two allocation
 	 * so we round up if the quota will allow it.
