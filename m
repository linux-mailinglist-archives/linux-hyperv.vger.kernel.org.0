Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A31CE35A
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Oct 2019 15:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfJGNY2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Oct 2019 09:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfJGNY2 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Oct 2019 09:24:28 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57A5B2084D;
        Mon,  7 Oct 2019 13:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570454656;
        bh=VihV6dbAFqYapoc2NQzCD6WaB/LSQjIdFqbcjmbSvH4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=zqA6UiTXH1B2jUHHJ7cyZ2HETPfjBI5GZ7X74v1prqwaIHNu2sNw+CCVDmfs4r24i
         dCWhA5QhGg7SpBELP4QjMEZc5I3exypt1HpSigICcpmCJLgE1fUwojjrefSUxT5SA9
         2sj0tITXpHw7U4pvJFajGOQh2FmfyD1XXetT6BZo=
Date:   Mon, 7 Oct 2019 08:24:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "jackm@mellanox.com" <jackm@mellanox.com>
Subject: Re: [PATCH v2] PCI: PM: Move to D0 before calling
 pci_legacy_resume_early()
Message-ID: <20191007132414.GA19294@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KU1P153MB016637CAEAD346F0AA8E3801BFAD0@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 14, 2019 at 01:06:55AM +0000, Dexuan Cui wrote:
> 
> In pci_legacy_suspend_late(), the device state is moved to PCI_UNKNOWN.
> 
> In pci_pm_thaw_noirq(), the state is supposed to be moved back to PCI_D0,
> but the current code misses the pci_legacy_resume_early() path, so the
> state remains in PCI_UNKNOWN in that path. As a result, in the resume
> phase of hibernation, this causes an error for the Mellanox VF driver,
> which fails to enable MSI-X because pci_msi_supported() is false due
> to dev->current_state != PCI_D0:
> 
> mlx4_core a6d1:00:02.0: Detected virtual function - running in slave mode
> mlx4_core a6d1:00:02.0: Sending reset
> mlx4_core a6d1:00:02.0: Sending vhcr0
> mlx4_core a6d1:00:02.0: HCA minimum page size:512
> mlx4_core a6d1:00:02.0: Timestamping is not supported in slave mode
> mlx4_core a6d1:00:02.0: INTx is not supported in multi-function mode, aborting
> PM: dpm_run_callback(): pci_pm_thaw+0x0/0xd7 returns -95
> PM: Device a6d1:00:02.0 failed to thaw: error -95
> 
> To be more accurate, the "resume" phase means the "thaw" callbacks which
> run before the system enters hibernation: when the user runs the command
> "echo disk > /sys/power/state" for hibernation, first the kernel "freezes"
> all the devices and creates a hibernation image, then the kernel "thaws"
> the devices including the disk/NIC, writes the memory to the disk, and
> powers down. This patch fixes the error message for the Mellanox VF driver
> in this phase.
> 
> When the system starts again, a fresh kernel starts to run, and when the
> kernel detects that a hibernation image was saved, the kernel "quiesces"
> the devices, and then "restores" the devices from the saved image. In this
> path:
> device_resume_noirq() -> ... ->
>   pci_pm_restore_noirq() ->
>     pci_pm_default_resume_early() ->
>       pci_power_up() moves the device states back to PCI_D0. This path is
> not broken and doesn't need my patch.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

This looks like a bugfix for 5839ee7389e8 ("PCI / PM: Force devices to
D0 in pci_pm_thaw_noirq()") so maybe it should be marked for stable as
5839ee7389e8 was?

Rafael, could you confirm?

> ---
> 
> changes in v2:
> 	Updated the changelog with more details.
> 
>  drivers/pci/pci-driver.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 36dbe960306b..27dfc68db9e7 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1074,15 +1074,16 @@ static int pci_pm_thaw_noirq(struct device *dev)
>  			return error;
>  	}
>  
> -	if (pci_has_legacy_pm_support(pci_dev))
> -		return pci_legacy_resume_early(dev);
> -
>  	/*
>  	 * pci_restore_state() requires the device to be in D0 (because of MSI
>  	 * restoration among other things), so force it into D0 in case the
>  	 * driver's "freeze" callbacks put it into a low-power state directly.
>  	 */
>  	pci_set_power_state(pci_dev, PCI_D0);
> +
> +	if (pci_has_legacy_pm_support(pci_dev))
> +		return pci_legacy_resume_early(dev);
> +
>  	pci_restore_state(pci_dev);
>  
>  	if (drv && drv->pm && drv->pm->thaw_noirq)
> -- 
> 2.19.1
> 
