Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7CC25C6FA
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Sep 2020 18:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgICQfV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Sep 2020 12:35:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:45216 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgICQfV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Sep 2020 12:35:21 -0400
IronPort-SDR: zJ7A4drycomACfX8t+3H0QGwvmbHvmN8ENE1T/eCp1ACLow9IR3Wpqk0LlCk9+wQ5KEsilcL4v
 SDswZI3eDxYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="137134895"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="137134895"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 09:35:21 -0700
IronPort-SDR: fpm2EUkci2oTbjGtopGBquDwwKng+PMe+foZPSI3HK+bv08KmruAxr7wF/55ACFaKSLBoUxQVH
 vLRGOXY9BheA==
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="503124720"
Received: from araj-mobl1.jf.intel.com ([10.254.124.120])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 09:35:18 -0700
Date:   Thu, 3 Sep 2020 09:35:16 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>,
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
        Dan Williams <dan.j.williams@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device
 MSI
Message-ID: <20200903163516.GA23129@araj-mobl1.jf.intel.com>
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200826111628.794979401@linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Thomas,

Thanks a ton for jumping in helping on straightening it for IMS!!!


On Wed, Aug 26, 2020 at 01:16:28PM +0200, Thomas Gleixner wrote:
> This is the second version of providing a base to support device MSI (non
> PCI based) and on top of that support for IMS (Interrupt Message Storm)

s/Storm/Store

maybe pun intended :-)

> based devices in a halfways architecture independent way.

You mean "halfways" because the message addr and data follow guidelines
per arch (x86 or such), but the location of the storage isn't dictated
by architecture? or did you have something else in mind? 

> 
> The first version can be found here:
> 
>     https://lore.kernel.org/r/20200821002424.119492231@linutronix.de
> 

[snip]

> 
> Changes vs. V1:
> 
>    - Addressed various review comments and addressed the 0day fallout.
>      - Corrected the XEN logic (Jürgen)
>      - Make the arch fallback in PCI/MSI opt-in not opt-out (Bjorn)
> 
>    - Fixed the compose MSI message inconsistency
> 
>    - Ensure that the necessary flags are set for device SMI

is that supposed to be MSI? 

Cheers,
Ashok
