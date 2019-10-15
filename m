Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13BCBD7D62
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 19:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfJORVm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Oct 2019 13:21:42 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41868 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfJORVm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Oct 2019 13:21:42 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id b5433f87ced3629d; Tue, 15 Oct 2019 19:21:40 +0200
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
Subject: Re: [PATCH 4/7] PCI/PM: Run resume fixups before disabling wakeup events
Date:   Tue, 15 Oct 2019 19:21:39 +0200
Message-ID: <6808286.qxd3Zai2y5@kreacher>
In-Reply-To: <20191014230016.240912-5-helgaas@kernel.org>
References: <20191014230016.240912-1-helgaas@kernel.org> <20191014230016.240912-5-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tuesday, October 15, 2019 1:00:13 AM CEST Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> pci_pm_resume() and pci_pm_restore() call pci_pm_default_resume(), which
> runs resume fixups before disabling wakeup events:
> 
>   static void pci_pm_default_resume(struct pci_dev *pci_dev)
>   {
>     pci_fixup_device(pci_fixup_resume, pci_dev);
>     pci_enable_wake(pci_dev, PCI_D0, false);
>   }
> 
> pci_pm_runtime_resume() does both of these, but in the opposite order:
> 
>   pci_enable_wake(pci_dev, PCI_D0, false);
>   pci_fixup_device(pci_fixup_resume, pci_dev);
> 
> We should always use the same ordering unless there's a reason to do
> otherwise.

Right.

> Change pci_pm_runtime_resume() to call pci_pm_default_resume()
> instead of open-coding this, so the fixups are always done before disabling
> wakeup events.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

No concerns about this change, so

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pci-driver.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 0c3086793e4e..55acb658273f 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1345,8 +1345,7 @@ static int pci_pm_runtime_resume(struct device *dev)
>  		return 0;
>  
>  	pci_fixup_device(pci_fixup_resume_early, pci_dev);
> -	pci_enable_wake(pci_dev, PCI_D0, false);
> -	pci_fixup_device(pci_fixup_resume, pci_dev);
> +	pci_pm_default_resume(pci_dev);
>  
>  	if (pm && pm->runtime_resume)
>  		rc = pm->runtime_resume(dev);
> 




