Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD1346DD55
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Dec 2021 21:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbhLHVA1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Dec 2021 16:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235864AbhLHVA1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Dec 2021 16:00:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6293C0617A1;
        Wed,  8 Dec 2021 12:56:54 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638997011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RI9goYiyaxxlyowVIy50GRXpRhCNUYZrM4r3seD1bKI=;
        b=NIPhL0sgn8M0aJUIi890pmZGlk891yoUSSDMnC4hnbyawxG2Kyh7G1sHH/xsmtSWUM8FfZ
        FyiBCPJVbWpXpFfMUl77mb1l8QqDIF5HigALgdn/RYqTMPCpOHMr0KIFCokDN7aLnrEdks
        8rrnfZKCxcaetGnTQyHUg4mAfEc2N1sxXiIWn5IbWqnhikYmOYt6fknKqXzV7CdqL4P4H4
        8ZS0DFKNdnSGea2HezKm7Hkc6llGKcBl9S+VI9FjnibvCSYHAcSlNTnETtfGbCxdf3f6N4
        HjxoAKj0UnKj8JjZlpBFr0/NMCZQnVLvInv7aT9TCLkwNt6S0nNqOl/aBjfedw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638997011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RI9goYiyaxxlyowVIy50GRXpRhCNUYZrM4r3seD1bKI=;
        b=KF19qqsUtSG+rWG9NpEYyzGIEvbq/ti9eoiMayWfd1iK3FYz9roP5HeWY227THj1hSYyZu
        bO4E+0TC1Z5Br/AA==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
Subject: Re: [patch V2 20/23] PCI/MSI: Move msi_lock to struct pci_dev
In-Reply-To: <20211208152925.GU6385@nvidia.com>
References: <20211206210147.872865823@linutronix.de>
 <20211206210224.925241961@linutronix.de>
 <20211208152925.GU6385@nvidia.com>
Date:   Wed, 08 Dec 2021 21:56:50 +0100
Message-ID: <871r2m24tp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Dec 08 2021 at 11:29, Jason Gunthorpe wrote:
> On Mon, Dec 06, 2021 at 11:27:56PM +0100, Thomas Gleixner wrote:
>>  	if (!desc->pci.msi_attrib.can_mask)
>
> It looks like most of the time this is called by an irq_chip, except
> for a few special cases list pci_msi_shutdown()
>
> Is this something that should ideally go away someday and use some
> lock in the irq_chip - not unlike what we've thought is needed for
> IMS?

Some day we'll have that yes.
