Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5CBCD7F2E
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 20:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389192AbfJOSmC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Oct 2019 14:42:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfJOSmC (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Oct 2019 14:42:02 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9620E2086A;
        Tue, 15 Oct 2019 18:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571164921;
        bh=UfbMo4srtplXckwhdvkQ1pijpD6lZtwmuZ5zBKMFFKw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nJ9DD3sUsyARGvqPq1H2cPbcDGJHZ7alSYJwFlR3EEF0BOMEFY5WUnx2gWM5+guO5
         dVPuLUppTj4aOI7zl5QnGZLJt//Vlq2Y/G4pNywqeSV78YSzzjJVTOjdYlHWujkYDf
         tNhi/odRrJqWcoAI9LsWa1RDXDXk1bo0DDIxE0Nw=
Date:   Tue, 15 Oct 2019 13:42:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
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
        driverdev-devel@linuxdriverproject.org
Subject: Re: [PATCH v3 0/7] PCI: PM: Move to D0 before calling
 pci_legacy_resume_early()
Message-ID: <20191015184200.GA114979@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014230016.240912-1-helgaas@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Oct 14, 2019 at 06:00:09PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Dexuan, the important thing here is the first patch, which is your [1],
> which I modified by doing pci_restore_state() as well as setting to D0:
> 
>   pci_set_power_state(pci_dev, PCI_D0);
>   pci_restore_state(pci_dev);
> 
> I'm proposing some more patches on top.  None are relevant to the problem
> you're solving; they're just minor doc and other updates in the same area.
> 
> Rafael, if you have a chance to look at these, I'd appreciate it.  I tried
> to make the doc match the code, but I'm no PM expert.
> 
> [1] https://lore.kernel.org/r/KU1P153MB016637CAEAD346F0AA8E3801BFAD0@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM
> 
> 
> Dexuan Cui (1):
>   PCI/PM: Always return devices to D0 when thawing
> 
> Bjorn Helgaas (6):
>   PCI/PM: Correct pci_pm_thaw_noirq() documentation
>   PCI/PM: Clear PCIe PME Status even for legacy power management
>   PCI/PM: Run resume fixups before disabling wakeup events
>   PCI/PM: Make power management op coding style consistent
>   PCI/PM: Wrap long lines in documentation
>   PCI/MSI: Move power state check out of pci_msi_supported()
> 
>  Documentation/power/pci.rst | 38 +++++++-------
>  drivers/pci/msi.c           |  6 +--
>  drivers/pci/pci-driver.c    | 99 ++++++++++++++++++-------------------
>  3 files changed, 71 insertions(+), 72 deletions(-)

Thanks Dexuan and Rafael for taking a look at these!

I applied the first six to pci/pm and the last to pci/msi, all for
v5.5.
