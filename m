Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058AB46411E
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Nov 2021 23:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbhK3WOr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Nov 2021 17:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344731AbhK3WOJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Nov 2021 17:14:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E07C06174A;
        Tue, 30 Nov 2021 14:10:47 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638310245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iQwNm3evMDmCqqNj6SOBSL2raZeNEDMRyVYLWo7plsQ=;
        b=cfCUOIaPomiZCO9d79k8QaTA54iAEZbQY4lmYzVXbCZ99fBBPE+xqpOo1m4nSfa3KPq6+6
        pI8jqClQqAQ6e9xEzGMdMDMlM7PO3wO+IzFhUB7wl4w2H81v2euyyU8OpSzUxgKY+0HqOn
        tbRxYHYo0OtQnM7fMd/Q2RflLcOK0WEbJRcLaARC9aG5kGkie13cZuSuCFIva1m+TA616i
        dV35DJLlXGyNBE5vTnPj0hgLjo4pBUrYZ1WEUXNY8Y4DNEBT5I7kTI7Vt9Tc5Lg2J+Di+B
        X84UlqMbc2Q4lC6o9mfXgbNv2vVK1HCIjDj9nJ/ptp3y+rYMnW5ZpEnm9xcPOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638310245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iQwNm3evMDmCqqNj6SOBSL2raZeNEDMRyVYLWo7plsQ=;
        b=OS4mhIe7yFZLurVEyelXc9LbdOQ2hxFAIJTEo5kZyIy2QO7wrWZZMF3x6KmDym+n1S953w
        D2cPy3zCOhdCl9Bg==
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
In-Reply-To: <524d9b84-caa8-dd6f-bb5e-9fc906d279c0@kaod.org>
References: <20211126222700.862407977@linutronix.de>
 <20211126223824.382273262@linutronix.de>
 <b1a6d267-c7b4-c4b9-ab0e-f5cc32bfe9bf@kaod.org> <87tufud4m3.ffs@tglx>
 <524d9b84-caa8-dd6f-bb5e-9fc906d279c0@kaod.org>
Date:   Tue, 30 Nov 2021 23:10:45 +0100
Message-ID: <87czmhb8gq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Nov 30 2021 at 22:48, C=C3=A9dric Le Goater wrote:
> On 11/29/21 22:38, Thomas Gleixner wrote:
>> On Mon, Nov 29 2021 at 08:33, C=C3=A9dric Le Goater wrote:
>> thanks for having a look. I fixed up this and other fallout and pushed o=
ut an
>> updated series (all 4 parts) to:
>>=20
>>          git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel msi
>
> pSeries fails to allocate MSIs starting with this patch :
>
>   [PATCH 049/101] powerpc/pseries/msi: Let core code check for contiguous=
 ...
>
> I will dig in later on.

Let me stare at the core function..
