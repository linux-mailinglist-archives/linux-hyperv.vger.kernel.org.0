Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 635D2D7D54
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 19:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbfJORUE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Oct 2019 13:20:04 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63884 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbfJORUD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Oct 2019 13:20:03 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id dda85748e3f31afb; Tue, 15 Oct 2019 19:20:02 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, olaf@aepfle.de,
        apw@canonical.com, jasowang@redhat.com, vkuznets@redhat.com,
        marcelo.cerri@canonical.com, jackm@mellanox.com,
        linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 3/7] PCI/PM: Clear PCIe PME Status even for legacy power management
Date:   Tue, 15 Oct 2019 19:20:01 +0200
Message-ID: <4241660.MG63sYxJne@kreacher>
In-Reply-To: <20191014230016.240912-4-helgaas@kernel.org>
References: <20191014230016.240912-1-helgaas@kernel.org> <20191014230016.240912-4-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tuesday, October 15, 2019 1:00:12 AM CEST Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Previously, pci_pm_resume_noirq() cleared the PME Status bit in the Root
> Status register only if the device had no driver or the driver did not
> implement legacy power management.  It should clear PME Status regardless
> of what sort of power management the driver supports, so do this before
> checking for legacy power management.
> 
> This affects Root Ports and Root Complex Event Collectors, for which the
> usual driver is the PCIe portdrv, which implements new power management, so
> this change is just on principle, not to fix any actual defects.
> 
> Fixes: a39bd851dccf ("PCI/PM: Clear PCIe PME Status bit in core, not PCIe port driver")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

This is a reasonable change in my view, so

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pci-driver.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index d4ac8ce8c1f9..0c3086793e4e 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -941,12 +941,11 @@ static int pci_pm_resume_noirq(struct device *dev)
>  		pci_pm_default_resume_early(pci_dev);
>  
>  	pci_fixup_device(pci_fixup_resume_early, pci_dev);
> +	pcie_pme_root_status_cleanup(pci_dev);
>  
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_resume_early(dev);
>  
> -	pcie_pme_root_status_cleanup(pci_dev);
> -
>  	if (drv && drv->pm && drv->pm->resume_noirq)
>  		error = drv->pm->resume_noirq(dev);
>  
> 




