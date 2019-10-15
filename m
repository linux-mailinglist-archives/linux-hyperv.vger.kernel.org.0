Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A79ED7D82
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 19:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfJORXb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Oct 2019 13:23:31 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64981 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfJORXb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Oct 2019 13:23:31 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id dfec6fccedf7956f; Tue, 15 Oct 2019 19:23:29 +0200
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
Subject: Re: [PATCH 6/7] PCI/PM: Wrap long lines in documentation
Date:   Tue, 15 Oct 2019 19:23:28 +0200
Message-ID: <2150193.0kpVmk06vr@kreacher>
In-Reply-To: <20191014230016.240912-7-helgaas@kernel.org>
References: <20191014230016.240912-1-helgaas@kernel.org> <20191014230016.240912-7-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tuesday, October 15, 2019 1:00:15 AM CEST Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Documentation/power/pci.rst is wrapped to fit in 80 columns, but directory
> structure changes made a few lines longer.  Wrap them so they all fit in 80
> columns again.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Well, looks better this way. :-)

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  Documentation/power/pci.rst | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
> index 1525c594d631..db41a770a2f5 100644
> --- a/Documentation/power/pci.rst
> +++ b/Documentation/power/pci.rst
> @@ -426,12 +426,12 @@ pm->runtime_idle() callback.
>  2.4. System-Wide Power Transitions
>  ----------------------------------
>  There are a few different types of system-wide power transitions, described in
> -Documentation/driver-api/pm/devices.rst.  Each of them requires devices to be handled
> -in a specific way and the PM core executes subsystem-level power management
> -callbacks for this purpose.  They are executed in phases such that each phase
> -involves executing the same subsystem-level callback for every device belonging
> -to the given subsystem before the next phase begins.  These phases always run
> -after tasks have been frozen.
> +Documentation/driver-api/pm/devices.rst.  Each of them requires devices to be
> +handled in a specific way and the PM core executes subsystem-level power
> +management callbacks for this purpose.  They are executed in phases such that
> +each phase involves executing the same subsystem-level callback for every device
> +belonging to the given subsystem before the next phase begins.  These phases
> +always run after tasks have been frozen.
>  
>  2.4.1. System Suspend
>  ^^^^^^^^^^^^^^^^^^^^^
> @@ -636,12 +636,12 @@ System restore requires a hibernation image to be loaded into memory and the
>  pre-hibernation memory contents to be restored before the pre-hibernation system
>  activity can be resumed.
>  
> -As described in Documentation/driver-api/pm/devices.rst, the hibernation image is loaded
> -into memory by a fresh instance of the kernel, called the boot kernel, which in
> -turn is loaded and run by a boot loader in the usual way.  After the boot kernel
> -has loaded the image, it needs to replace its own code and data with the code
> -and data of the "hibernated" kernel stored within the image, called the image
> -kernel.  For this purpose all devices are frozen just like before creating
> +As described in Documentation/driver-api/pm/devices.rst, the hibernation image
> +is loaded into memory by a fresh instance of the kernel, called the boot kernel,
> +which in turn is loaded and run by a boot loader in the usual way.  After the
> +boot kernel has loaded the image, it needs to replace its own code and data with
> +the code and data of the "hibernated" kernel stored within the image, called the
> +image kernel.  For this purpose all devices are frozen just like before creating
>  the image during hibernation, in the
>  
>  	prepare, freeze, freeze_noirq
> @@ -691,8 +691,8 @@ controlling the runtime power management of their devices.
>  
>  At the time of this writing there are two ways to define power management
>  callbacks for a PCI device driver, the recommended one, based on using a
> -dev_pm_ops structure described in Documentation/driver-api/pm/devices.rst, and the
> -"legacy" one, in which the .suspend(), .suspend_late(), .resume_early(), and
> +dev_pm_ops structure described in Documentation/driver-api/pm/devices.rst, and
> +the "legacy" one, in which the .suspend(), .suspend_late(), .resume_early(), and
>  .resume() callbacks from struct pci_driver are used.  The legacy approach,
>  however, doesn't allow one to define runtime power management callbacks and is
>  not really suitable for any new drivers.  Therefore it is not covered by this
> 




