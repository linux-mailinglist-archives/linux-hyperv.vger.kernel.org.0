Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF878D7D7B
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 19:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbfJORWd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Oct 2019 13:22:33 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61072 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfJORWd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Oct 2019 13:22:33 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id b4f25af5462756a4; Tue, 15 Oct 2019 19:22:30 +0200
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
Subject: Re: [PATCH 5/7] PCI/PM: Make power management op coding style consistent
Date:   Tue, 15 Oct 2019 19:22:30 +0200
Message-ID: <8592302.r4xC6RIy69@kreacher>
In-Reply-To: <20191014230016.240912-6-helgaas@kernel.org>
References: <20191014230016.240912-1-helgaas@kernel.org> <20191014230016.240912-6-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tuesday, October 15, 2019 1:00:14 AM CEST Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Some of the power management ops use this style:
> 
>   struct device_driver *drv = dev->driver;
>   if (drv && drv->pm && drv->pm->prepare(dev))
>     drv->pm->prepare(dev);
> 
> while others use this:
> 
>   const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>   if (pm && pm->runtime_resume)
>     pm->runtime_resume(dev);
> 
> Convert the first style to the second so they're all consistent.  Remove
> local "error" variables when unnecessary.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

No issues found, so

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pci-driver.c | 76 +++++++++++++++++++---------------------
>  1 file changed, 36 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 55acb658273f..abbf5c39cb9c 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -679,11 +679,11 @@ static bool pci_has_legacy_pm_support(struct pci_dev *pci_dev)
>  
>  static int pci_pm_prepare(struct device *dev)
>  {
> -	struct device_driver *drv = dev->driver;
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
> -	if (drv && drv->pm && drv->pm->prepare) {
> -		int error = drv->pm->prepare(dev);
> +	if (pm && pm->prepare) {
> +		int error = pm->prepare(dev);
>  		if (error < 0)
>  			return error;
>  
> @@ -917,8 +917,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
>  static int pci_pm_resume_noirq(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
> -	struct device_driver *drv = dev->driver;
> -	int error = 0;
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
>  	if (dev_pm_may_skip_resume(dev))
>  		return 0;
> @@ -946,17 +945,16 @@ static int pci_pm_resume_noirq(struct device *dev)
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_resume_early(dev);
>  
> -	if (drv && drv->pm && drv->pm->resume_noirq)
> -		error = drv->pm->resume_noirq(dev);
> +	if (pm && pm->resume_noirq)
> +		return pm->resume_noirq(dev);
>  
> -	return error;
> +	return 0;
>  }
>  
>  static int pci_pm_resume(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> -	int error = 0;
>  
>  	/*
>  	 * This is necessary for the suspend error path in which resume is
> @@ -972,12 +970,12 @@ static int pci_pm_resume(struct device *dev)
>  
>  	if (pm) {
>  		if (pm->resume)
> -			error = pm->resume(dev);
> +			return pm->resume(dev);
>  	} else {
>  		pci_pm_reenable_device(pci_dev);
>  	}
>  
> -	return error;
> +	return 0;
>  }
>  
>  #else /* !CONFIG_SUSPEND */
> @@ -1038,16 +1036,16 @@ static int pci_pm_freeze(struct device *dev)
>  static int pci_pm_freeze_noirq(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
> -	struct device_driver *drv = dev->driver;
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_suspend_late(dev, PMSG_FREEZE);
>  
> -	if (drv && drv->pm && drv->pm->freeze_noirq) {
> +	if (pm && pm->freeze_noirq) {
>  		int error;
>  
> -		error = drv->pm->freeze_noirq(dev);
> -		suspend_report_result(drv->pm->freeze_noirq, error);
> +		error = pm->freeze_noirq(dev);
> +		suspend_report_result(pm->freeze_noirq, error);
>  		if (error)
>  			return error;
>  	}
> @@ -1066,8 +1064,8 @@ static int pci_pm_freeze_noirq(struct device *dev)
>  static int pci_pm_thaw_noirq(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
> -	struct device_driver *drv = dev->driver;
> -	int error = 0;
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +	int error;
>  
>  	if (pcibios_pm_ops.thaw_noirq) {
>  		error = pcibios_pm_ops.thaw_noirq(dev);
> @@ -1091,10 +1089,10 @@ static int pci_pm_thaw_noirq(struct device *dev)
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_resume_early(dev);
>  
> -	if (drv && drv->pm && drv->pm->thaw_noirq)
> -		error = drv->pm->thaw_noirq(dev);
> +	if (pm && pm->thaw_noirq)
> +		return pm->thaw_noirq(dev);
>  
> -	return error;
> +	return 0;
>  }
>  
>  static int pci_pm_thaw(struct device *dev)
> @@ -1165,24 +1163,24 @@ static int pci_pm_poweroff_late(struct device *dev)
>  static int pci_pm_poweroff_noirq(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
> -	struct device_driver *drv = dev->driver;
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
>  	if (dev_pm_smart_suspend_and_suspended(dev))
>  		return 0;
>  
> -	if (pci_has_legacy_pm_support(to_pci_dev(dev)))
> +	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_suspend_late(dev, PMSG_HIBERNATE);
>  
> -	if (!drv || !drv->pm) {
> +	if (!pm) {
>  		pci_fixup_device(pci_fixup_suspend_late, pci_dev);
>  		return 0;
>  	}
>  
> -	if (drv->pm->poweroff_noirq) {
> +	if (pm->poweroff_noirq) {
>  		int error;
>  
> -		error = drv->pm->poweroff_noirq(dev);
> -		suspend_report_result(drv->pm->poweroff_noirq, error);
> +		error = pm->poweroff_noirq(dev);
> +		suspend_report_result(pm->poweroff_noirq, error);
>  		if (error)
>  			return error;
>  	}
> @@ -1208,8 +1206,8 @@ static int pci_pm_poweroff_noirq(struct device *dev)
>  static int pci_pm_restore_noirq(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
> -	struct device_driver *drv = dev->driver;
> -	int error = 0;
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +	int error;
>  
>  	if (pcibios_pm_ops.restore_noirq) {
>  		error = pcibios_pm_ops.restore_noirq(dev);
> @@ -1223,17 +1221,16 @@ static int pci_pm_restore_noirq(struct device *dev)
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_resume_early(dev);
>  
> -	if (drv && drv->pm && drv->pm->restore_noirq)
> -		error = drv->pm->restore_noirq(dev);
> +	if (pm && pm->restore_noirq)
> +		return pm->restore_noirq(dev);
>  
> -	return error;
> +	return 0;
>  }
>  
>  static int pci_pm_restore(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> -	int error = 0;
>  
>  	/*
>  	 * This is necessary for the hibernation error path in which restore is
> @@ -1249,12 +1246,12 @@ static int pci_pm_restore(struct device *dev)
>  
>  	if (pm) {
>  		if (pm->restore)
> -			error = pm->restore(dev);
> +			return pm->restore(dev);
>  	} else {
>  		pci_pm_reenable_device(pci_dev);
>  	}
>  
> -	return error;
> +	return 0;
>  }
>  
>  #else /* !CONFIG_HIBERNATE_CALLBACKS */
> @@ -1330,9 +1327,9 @@ static int pci_pm_runtime_suspend(struct device *dev)
>  
>  static int pci_pm_runtime_resume(struct device *dev)
>  {
> -	int rc = 0;
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +	int error = 0;
>  
>  	/*
>  	 * Restoring config space is necessary even if the device is not bound
> @@ -1348,18 +1345,17 @@ static int pci_pm_runtime_resume(struct device *dev)
>  	pci_pm_default_resume(pci_dev);
>  
>  	if (pm && pm->runtime_resume)
> -		rc = pm->runtime_resume(dev);
> +		error = pm->runtime_resume(dev);
>  
>  	pci_dev->runtime_d3cold = false;
>  
> -	return rc;
> +	return error;
>  }
>  
>  static int pci_pm_runtime_idle(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> -	int ret = 0;
>  
>  	/*
>  	 * If pci_dev->driver is not set (unbound), the device should
> @@ -1372,9 +1368,9 @@ static int pci_pm_runtime_idle(struct device *dev)
>  		return -ENOSYS;
>  
>  	if (pm->runtime_idle)
> -		ret = pm->runtime_idle(dev);
> +		return pm->runtime_idle(dev);
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static const struct dev_pm_ops pci_dev_pm_ops = {
> 




