Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608EF46C52C
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Dec 2021 21:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhLGU7w (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Dec 2021 15:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhLGU7t (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Dec 2021 15:59:49 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF97C061574;
        Tue,  7 Dec 2021 12:56:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 35129CE1E70;
        Tue,  7 Dec 2021 20:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B8EC341C1;
        Tue,  7 Dec 2021 20:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638910575;
        bh=qLik4JFtyxqmSptBayqaCn1r8IHM9yMTUp4uNVorfnk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZuIbLGLfYV/nvLepPIU/oJgGVLR/cUv4fN1TB9jN6qxiqhzWiZXhZIRCqViFXsXX2
         BupHwnNmoV668bTXaUoUD++cCPB+blzebEwefTUII/C/6Vy7O3vnv9NoEGA/Ji6Owv
         oPt6EPc+oZmfGxvR4m833Yz/aYsVS5bGsuqgu5ZEDfAHynE853rfjGlPDeDpFGEt3Z
         R8MZc2PJgawqhxAfrRf/p8uWcDY0ETOixepI3ae+2tW6W36bm3938Zs5e4gyXwU3uL
         Xg3/BGlYj1tkxDl4i0Ek1cNEw8YRkCMuc4qXgDYFJwb6ISeYQABlWAEk0RIe7vI2Hq
         f6aHj3PLOAFog==
Date:   Tue, 7 Dec 2021 14:56:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        Juergen Gross <jgross@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparclinux@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org, ath11k@lists.infradead.org,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [patch V2 08/23] PCI/sysfs: Use pci_irq_vector()
Message-ID: <20211207205613.GA76623@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210224.265589103@linutronix.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Dec 06, 2021 at 11:27:36PM +0100, Thomas Gleixner wrote:
> instead of fiddling with msi descriptors.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

s/msi/MSI/ above if you have a chance.  Nice cleanup, thanks!

> ---
>  drivers/pci/pci-sysfs.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -62,11 +62,8 @@ static ssize_t irq_show(struct device *d
>  	 * For MSI, show the first MSI IRQ; for all other cases including
>  	 * MSI-X, show the legacy INTx IRQ.
>  	 */
> -	if (pdev->msi_enabled) {
> -		struct msi_desc *desc = first_pci_msi_entry(pdev);
> -
> -		return sysfs_emit(buf, "%u\n", desc->irq);
> -	}
> +	if (pdev->msi_enabled)
> +		return sysfs_emit(buf, "%u\n", pci_irq_vector(pdev, 0));
>  #endif
>  
>  	return sysfs_emit(buf, "%u\n", pdev->irq);
> 
