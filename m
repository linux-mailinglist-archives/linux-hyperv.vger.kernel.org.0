Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37EA8D01CB
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Oct 2019 21:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbfJHT41 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Oct 2019 15:56:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729616AbfJHT41 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Oct 2019 15:56:27 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 396C1218AC;
        Tue,  8 Oct 2019 19:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570564586;
        bh=0nMoZ85ygsNBdXAqiyinbiqycG88Jyb222PyEdKvVZs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=W+XNfzlCwDwF/rOZTOeXFXdurCTiWoV+D11WBIR8XNAeA7u65Uvob10IiWDRcKjgf
         NrAkCOWJ3b+14JRjZSChaUDrEM7Nlgdd1djEPtzdyY7tHjlHYMM2fLQpvMu6M6wu28
         PyFWqx81e8Wea3yueHk+1u/LJXENK2w7kqKN5Nkg=
Date:   Tue, 8 Oct 2019 14:56:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
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
Message-ID: <20191008195624.GA198287@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2d8ad9f-b59d-57e4-f014-645e7b796cc4@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Oct 08, 2019 at 07:32:27PM +0200, Rafael J. Wysocki wrote:
> On 10/7/2019 8:57 PM, Dexuan Cui wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: Monday, October 7, 2019 6:24 AM
> > > To: Dexuan Cui <decui@microsoft.com>
> > > Cc: lorenzo.pieralisi@arm.com; linux-pci@vger.kernel.org; Michael Kelley
> > > <mikelley@microsoft.com>; linux-hyperv@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org; Sasha
> > > Levin <Alexander.Levin@microsoft.com>; Haiyang Zhang
> > > <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> > > olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com; vkuznets
> > > <vkuznets@redhat.com>; marcelo.cerri@canonical.com; Stephen Hemminger
> > > <sthemmin@microsoft.com>; jackm@mellanox.com
> > > Subject: Re: [PATCH v2] PCI: PM: Move to D0 before calling
> > > pci_legacy_resume_early()
> > > 
> > > On Wed, Aug 14, 2019 at 01:06:55AM +0000, Dexuan Cui wrote:
> > > > In pci_legacy_suspend_late(), the device state is moved to PCI_UNKNOWN.
> > > > 
> > > > In pci_pm_thaw_noirq(), the state is supposed to be moved back to PCI_D0,
> > > > but the current code misses the pci_legacy_resume_early() path, so the
> > > > state remains in PCI_UNKNOWN in that path. As a result, in the resume
> > > > phase of hibernation, this causes an error for the Mellanox VF driver,
> > > > which fails to enable MSI-X because pci_msi_supported() is false due
> > > > to dev->current_state != PCI_D0:
> > > > 
> > > > mlx4_core a6d1:00:02.0: Detected virtual function - running in slave mode
> > > > mlx4_core a6d1:00:02.0: Sending reset
> > > > mlx4_core a6d1:00:02.0: Sending vhcr0
> > > > mlx4_core a6d1:00:02.0: HCA minimum page size:512
> > > > mlx4_core a6d1:00:02.0: Timestamping is not supported in slave mode
> > > > mlx4_core a6d1:00:02.0: INTx is not supported in multi-function mode,
> > > aborting
> > > > PM: dpm_run_callback(): pci_pm_thaw+0x0/0xd7 returns -95
> > > > PM: Device a6d1:00:02.0 failed to thaw: error -95
> > > > 
> > > > To be more accurate, the "resume" phase means the "thaw" callbacks which
> > > > run before the system enters hibernation: when the user runs the command
> > > > "echo disk > /sys/power/state" for hibernation, first the kernel "freezes"
> > > > all the devices and creates a hibernation image, then the kernel "thaws"
> > > > the devices including the disk/NIC, writes the memory to the disk, and
> > > > powers down. This patch fixes the error message for the Mellanox VF driver
> > > > in this phase.

Wordsmithing nit: what the patch does is not "fix the error message";
what it does is fix the *problem*, i.e., the fact that we can't
operate the device because we can't enable MSI-X.  The message is only
a symptom.

IIUC the relevant part of the system hibernation sequence is:

  pci_pm_freeze_noirq
  pci_pm_thaw_noirq
  pci_pm_thaw

And the execution flow is:

  pci_pm_freeze_noirq
    if (pci_has_legacy_pm_support(pci_dev)) # true for mlx4
      pci_legacy_suspend_late(dev, PMSG_FREEZE)
	pci_pm_set_unknown_state
	  dev->current_state = PCI_UNKNOWN  # <---
  pci_pm_thaw_noirq
    if (pci_has_legacy_pm_support(pci_dev)) # true
      pci_legacy_resume_early(dev)          # noop; mlx4 doesn't implement
  pci_pm_thaw                               # returns -95 EOPNOTSUPP
    if (pci_has_legacy_pm_support(pci_dev)) # true
      pci_legacy_resume
	drv->resume
	  mlx4_resume                       # mlx4_driver.resume (legacy)
	    mlx4_load_one
	      mlx4_enable_msi_x
		pci_enable_msix_range
		  __pci_enable_msix_range
		    __pci_enable_msix
		      if (!pci_msi_supported())
			if (dev->current_state != PCI_D0)  # <---
			  return 0
			return -EINVAL
		err = -EOPNOTSUPP
		"INTx is not supported ..."

(These are just my notes; you don't need to put them all into the
commit message.  I'm just sharing them in case I'm not understanding
correctly.)

> > > > When the system starts again, a fresh kernel starts to run, and when the
> > > > kernel detects that a hibernation image was saved, the kernel "quiesces"
> > > > the devices, and then "restores" the devices from the saved image. In this
> > > > path:
> > > > device_resume_noirq() -> ... ->
> > > >    pci_pm_restore_noirq() ->
> > > >      pci_pm_default_resume_early() ->
> > > >        pci_power_up() moves the device states back to PCI_D0. This path is
> > > > not broken and doesn't need my patch.
> > > > 

The cc list suggests that this might be a fix for a user-reported
problem.  Is there a launchpad or similar link you could include here?

Should this be marked for stable?

> > > > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > > This looks like a bugfix for 5839ee7389e8 ("PCI / PM: Force devices to
> > > D0 in pci_pm_thaw_noirq()") so maybe it should be marked for stable as
> > > 5839ee7389e8 was?
> > > 
> > > Rafael, could you confirm?
> 
> No, it is not a bug fix for that commit.  The underlying issue would be
> there without that commit too.

Oh, right, I dunno what I was thinking, sorry.

> > > > --- a/drivers/pci/pci-driver.c
> > > > +++ b/drivers/pci/pci-driver.c
> > > > @@ -1074,15 +1074,16 @@ static int pci_pm_thaw_noirq(struct device
> > > *dev)
> > > >   			return error;
> > > >   	}
> > > > 
> > > > -	if (pci_has_legacy_pm_support(pci_dev))
> > > > -		return pci_legacy_resume_early(dev);
> > > > -
> > > >   	/*
> > > >   	 * pci_restore_state() requires the device to be in D0 (because of MSI
> > > >   	 * restoration among other things), so force it into D0 in case the
> > > >   	 * driver's "freeze" callbacks put it into a low-power state directly.
> > > >   	 */
> > > >   	pci_set_power_state(pci_dev, PCI_D0);
> > > > +
> > > > +	if (pci_has_legacy_pm_support(pci_dev))
> > > > +		return pci_legacy_resume_early(dev);
> > > > +
> > > >   	pci_restore_state(pci_dev);
> > > > 
> > > >   	if (drv && drv->pm && drv->pm->thaw_noirq)
> > > > --
> > > > 2.19.1
> > > > 
> The patch looks reasonable to me, but the comment above the
> pci_set_power_state() call needs to be updated too IMO.

Hmm.

1) pci_restore_state() mainly writes config space, which doesn't
require the device to be in D0.  The only thing I see that would
require D0 is the MSI-X MMIO space, so to be more specific, the
comment could say "restoring the MSI-X *MMIO* state requires the
device to be in D0".

But I think you meant some other comment change.  Did you mean
something along the lines of "a legacy drv->resume_early() callback
and pci_restore_state() both require the device to be in D0"?

If something else, maybe you could propose some text?

2) I assume pci_pm_thaw_noirq() should leave the device in a
functionally equivalent state, whether it uses legacy PM or not.  Do
we want something like the patch below instead?  If we *do* want to
skip pci_restore_state() for legacy PM, maybe we should add a comment.

3) Documentation/power/pci.rst says:

  ... devices have to be brought back to the fully functional
  state ...

  pci_pm_thaw_noirq() ... doesn't put the device into the full power
  state and doesn't attempt to restore its standard configuration
  registers.

That doesn't seem consistent, and it looks like pci_pm_thaw_noirq()
actually *does* put the device in full power (D0) state and restore
config registers.


diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index a8124e47bf6e..30c721fd6bcf 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1068,7 +1068,7 @@ static int pci_pm_thaw_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct device_driver *drv = dev->driver;
-	int error = 0;
+	int error;
 
 	if (pcibios_pm_ops.thaw_noirq) {
 		error = pcibios_pm_ops.thaw_noirq(dev);
@@ -1076,9 +1076,6 @@ static int pci_pm_thaw_noirq(struct device *dev)
 			return error;
 	}
 
-	if (pci_has_legacy_pm_support(pci_dev))
-		return pci_legacy_resume_early(dev);
-
 	/*
 	 * pci_restore_state() requires the device to be in D0 (because of MSI
 	 * restoration among other things), so force it into D0 in case the
@@ -1087,10 +1084,13 @@ static int pci_pm_thaw_noirq(struct device *dev)
 	pci_set_power_state(pci_dev, PCI_D0);
 	pci_restore_state(pci_dev);
 
+	if (pci_has_legacy_pm_support(pci_dev))
+		return pci_legacy_resume_early(dev);
+
 	if (drv && drv->pm && drv->pm->thaw_noirq)
-		error = drv->pm->thaw_noirq(dev);
+		return drv->pm->thaw_noirq(dev);
 
-	return error;
+	return 0;
 }
 
 static int pci_pm_thaw(struct device *dev)
