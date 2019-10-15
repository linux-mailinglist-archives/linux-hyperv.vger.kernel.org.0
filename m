Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF02D7D8F
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 19:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfJORYW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Oct 2019 13:24:22 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51917 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfJORYW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Oct 2019 13:24:22 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 01cfd58c3730d6c7; Tue, 15 Oct 2019 19:24:19 +0200
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
Subject: Re: [PATCH 7/7] PCI/MSI: Move power state check out of pci_msi_supported()
Date:   Tue, 15 Oct 2019 19:24:19 +0200
Message-ID: <12092576.0PD7RdXzXY@kreacher>
In-Reply-To: <20191014230016.240912-8-helgaas@kernel.org>
References: <20191014230016.240912-1-helgaas@kernel.org> <20191014230016.240912-8-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tuesday, October 15, 2019 1:00:16 AM CEST Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 27e20603c54b ("PCI/MSI: Move D0 check into pci_msi_check_device()")
> moved the power state check into pci_msi_check_device(), which was
> subsequently renamed to pci_msi_supported().  This didn't change the
> behavior, since both callers checked the power state.
> 
> However, it doesn't fit the current "pci_msi_supported()" name, which
> should return what the device is capable of, independent of the power
> state.
> 
> Move the power state check back into the callers for readability.  No
> functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

No issues found, so

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/msi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 0884bedcfc7a..20e9c729617c 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -861,7 +861,7 @@ static int pci_msi_supported(struct pci_dev *dev, int nvec)
>  	if (!pci_msi_enable)
>  		return 0;
>  
> -	if (!dev || dev->no_msi || dev->current_state != PCI_D0)
> +	if (!dev || dev->no_msi)
>  		return 0;
>  
>  	/*
> @@ -972,7 +972,7 @@ static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
>  	int nr_entries;
>  	int i, j;
>  
> -	if (!pci_msi_supported(dev, nvec))
> +	if (!pci_msi_supported(dev, nvec) || dev->current_state != PCI_D0)
>  		return -EINVAL;
>  
>  	nr_entries = pci_msix_vec_count(dev);
> @@ -1058,7 +1058,7 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
>  	int nvec;
>  	int rc;
>  
> -	if (!pci_msi_supported(dev, minvec))
> +	if (!pci_msi_supported(dev, minvec) || dev->current_state != PCI_D0)
>  		return -EINVAL;
>  
>  	/* Check whether driver already requested MSI-X IRQs */
> 




