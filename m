Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 634DA8BB73
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Aug 2019 16:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfHMOZr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Aug 2019 10:25:47 -0400
Received: from foss.arm.com ([217.140.110.172]:37942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729344AbfHMOZr (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Aug 2019 10:25:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 088F8344;
        Tue, 13 Aug 2019 07:25:46 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A971F3F706;
        Tue, 13 Aug 2019 07:25:44 -0700 (PDT)
Date:   Tue, 13 Aug 2019 15:25:40 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "sashal@kernel.org" <sashal@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Message-ID: <20190813142540.GA5070@e121166-lin.cambridge.arm.com>
References: <1565634013-19404-1-git-send-email-haiyangz@microsoft.com>
 <20190813101417.GA14977@e121166-lin.cambridge.arm.com>
 <DM6PR21MB1337D4F34CAA49BE369FB793CAD20@DM6PR21MB1337.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR21MB1337D4F34CAA49BE369FB793CAD20@DM6PR21MB1337.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 13, 2019 at 12:55:59PM +0000, Haiyang Zhang wrote:
> 
> 
> > -----Original Message-----
> > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Sent: Tuesday, August 13, 2019 6:14 AM
> > To: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: sashal@kernel.org; bhelgaas@google.com; linux-
> > hyperv@vger.kernel.org; linux-pci@vger.kernel.org; KY Srinivasan
> > <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> > olaf@aepfle.de; vkuznets <vkuznets@redhat.com>; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH v3] PCI: hv: Detect and fix Hyper-V PCI domain number
> > collision
> > 
> > On Mon, Aug 12, 2019 at 06:20:53PM +0000, Haiyang Zhang wrote:
> > > Currently in Azure cloud, for passthrough devices including GPU, the host
> > > sets the device instance ID's bytes 8 - 15 to a value derived from the host
> > > HWID, which is the same on all devices in a VM. So, the device instance
> > > ID's bytes 8 and 9 provided by the host are no longer unique. This can
> > > cause device passthrough to VMs to fail because the bytes 8 and 9 are used
> > > as PCI domain number. Collision of domain numbers will cause the second
> > > device with the same domain number fail to load.
> > >
> > > As recommended by Azure host team, the bytes 4, 5 have more uniqueness
> > > (info entropy) than bytes 8, 9. So now we use bytes 4, 5 as the PCI domain
> > > numbers. On older hosts, bytes 4, 5 can also be used -- no backward
> > > compatibility issues here. The chance of collision is greatly reduced. In
> > > the rare cases of collision, we will detect and find another number that is
> > > not in use.
> > 
> > I have not explained what I meant correctly. This patch fixes an
> > issue and the "find another number" fallback can be also applied
> > to the current kernel without changing the bytes you use for
> > domain numbers.
> > 
> > This patch would leave old kernels susceptible to breakage.
> > 
> > Again, I have no Azure knowledge but it seems better to me to
> > add a fallback "find another number" allocation on top of mainline
> > and send it to stable kernels. Then we can add another patch to
> > change the bytes you use to reduce the number of collision.
> > 
> > Please let me know what you think, thanks.
> 
> Thanks for your clarification.
> Actually, I hope the stable kernel will be patched to use bytes 4,5 too,
> because host provided numbers are persistent across reboots, we like
> to use them if possible.
> 
> I think we can either --
> 1) Apply this patch for mainline and stable kernels as well.
> 2) Or, break this patch into two patches, and apply both of them for 
> Mainline and stable kernels.

(2) since one patch is a fix and the other one an (optional - however
important it is) change.

This way if the optional change needs reverting we still have a working
kernel.

In the end it is up to you - I am just expressing what I think is the
most sensible way forward.

Lorenzo
