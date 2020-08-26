Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320F2253403
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 17:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgHZPxf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 11:53:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59850 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgHZPx1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 11:53:27 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598457201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=goeJdvyvZirwLASPyTOx+y+LUKYx5a0JO0G5JsEt0Cs=;
        b=DAMVIkAqyy4AKY1e6W79Rih9wNEl9PD/FZjnhUNeIIoZ7l7kq/75TfVmu354vBX+/WVqTA
        0YjI/dmCcnmc3U2AuvKkvnJKdt48xoP5IxXuMm27KNP1xsFyVwIRtBfqkgnCIvQXzuV6vO
        yy0UO9WOuwsx5oUqk0Ah2/+CRbxmtC+gkgpofiIg04ycN8dSJq5uqkczQFlAcXU0kXJ5sV
        Vw/U5GyWJhrSz1COrbHuQ71RfkMBq07l75m5ZIuXl47zptJGJwDPvs+R6DQbg7r93KYqfV
        ccMOndh+4GHBiJK7goeyGUBc8gRKvX4CmWiSf1sVfIKxV3RYU7gc8uWD8gpBpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598457201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=goeJdvyvZirwLASPyTOx+y+LUKYx5a0JO0G5JsEt0Cs=;
        b=jmJX9jYrcb8PLSa2rxhC1AqHOM8H5y0zrmuUZbL4nNMTKGQ07p4qkJrjolnc5PiJECMKF1
        ku155QR6nYgU0uDQ==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch V2 34/46] PCI/MSI: Make arch_.*_msi_irq[s] fallbacks selectable
In-Reply-To: <20200826112333.992429909@linutronix.de>
References: <20200826111628.794979401@linutronix.de> <20200826112333.992429909@linutronix.de>
Date:   Wed, 26 Aug 2020 17:53:20 +0200
Message-ID: <87h7spv1xr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 26 2020 at 13:17, Thomas Gleixner wrote:
> + * If CONFIG_PCI_MSI_ARCH_FALLBACKS is not selected they are replaced by
> + * stubs with warnings.
>   */
> +#ifdef CONFIG_PCI_MSI_DISABLE_ARCH_FALLBACKS

Groan, I obviously failed to pull that back from the test box where I
fixed it. That wants to be:

+#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS

Doing five things at once does not work well
