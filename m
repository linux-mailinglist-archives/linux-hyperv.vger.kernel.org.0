Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989FDD7D39
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 19:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbfJORRO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Oct 2019 13:17:14 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42527 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfJORRO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Oct 2019 13:17:14 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id bad9ff34983b6df1; Tue, 15 Oct 2019 19:17:12 +0200
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
Subject: Re: [PATCH 2/7] PCI/PM: Correct pci_pm_thaw_noirq() documentation
Date:   Tue, 15 Oct 2019 19:17:11 +0200
Message-ID: <3964309.Hrl1cB5NHZ@kreacher>
In-Reply-To: <20191014230016.240912-3-helgaas@kernel.org>
References: <20191014230016.240912-1-helgaas@kernel.org> <20191014230016.240912-3-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tuesday, October 15, 2019 1:00:11 AM CEST Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> According to the documentation, pci_pm_thaw_noirq() did not put the device
> into the full-power state and restore its standard configuration registers.
> This is incorrect, so update the documentation to match the code.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Right, the documentation is outdated, so

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  Documentation/power/pci.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
> index 0e2ef7429304..1525c594d631 100644
> --- a/Documentation/power/pci.rst
> +++ b/Documentation/power/pci.rst
> @@ -600,17 +600,17 @@ using the following PCI bus type's callbacks::
>  
>  respectively.
>  
> -The first of them, pci_pm_thaw_noirq(), is analogous to pci_pm_resume_noirq(),
> -but it doesn't put the device into the full power state and doesn't attempt to
> -restore its standard configuration registers.  It also executes the device
> -driver's pm->thaw_noirq() callback, if defined, instead of pm->resume_noirq().
> +The first of them, pci_pm_thaw_noirq(), is analogous to pci_pm_resume_noirq().
> +It puts the device into the full power state and restores its standard
> +configuration registers.  It also executes the device driver's pm->thaw_noirq()
> +callback, if defined, instead of pm->resume_noirq().
>  
>  The pci_pm_thaw() routine is similar to pci_pm_resume(), but it runs the device
>  driver's pm->thaw() callback instead of pm->resume().  It is executed
>  asynchronously for different PCI devices that don't depend on each other in a
>  known way.
>  
> -The complete phase it the same as for system resume.
> +The complete phase is the same as for system resume.
>  
>  After saving the image, devices need to be powered down before the system can
>  enter the target sleep state (ACPI S4 for ACPI-based systems).  This is done in
> 




