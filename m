Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F10B25C888
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Sep 2020 20:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgICSMM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Sep 2020 14:12:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55392 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICSMM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Sep 2020 14:12:12 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599156730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kNaEs04RarZatwvnCZYp8Xyjij0m0qzMj73pUrlORw4=;
        b=yn1ERvJRi3Ap+fUwpE6YE6QEJw75JqHwztjGLfuIu5Vhx3ylMcPaeZMvt5r7IvXcWh2dAh
        7+z/aBykT9nJNYFo4QDegWd1mhgggaPOZ01qE8hyd4uY+QT0PBl3pkiYuzKw4KK3iGrXUr
        14y2LCk2YypciaSpx/mGkXvE0yiU5PSMcNx6TYqrk1t9NAuNFM6JknEl8Xbx7SEbi8u2zu
        ThkvHpDONagjoyMhBYJuQeMvMbIjXzsUhAvsaYpyYEJPejQesbQQGHFRQP2bHdcIklQKao
        rCqIVG7cJWCK1a7UyFdTjAaJOvn/BS6CkMvwnJ9pnqFjjru6qQ8dggQ04IJkjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599156730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kNaEs04RarZatwvnCZYp8Xyjij0m0qzMj73pUrlORw4=;
        b=dsVN9RWDW8rGNqnULQccYNxG7P4DgVJRNir2mvhT2bTe8IjmmCK2zcbya02NGrTVlYkNdL
        1dML9FSRvccDMDDw==
To:     "Raj\, Ashok" <ashok.raj@intel.com>
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
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device MSI
In-Reply-To: <20200903163516.GA23129@araj-mobl1.jf.intel.com>
References: <20200826111628.794979401@linutronix.de> <20200903163516.GA23129@araj-mobl1.jf.intel.com>
Date:   Thu, 03 Sep 2020 20:12:09 +0200
Message-ID: <87eeniybk6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Ashok,

On Thu, Sep 03 2020 at 09:35, Ashok Raj wrote:
> On Wed, Aug 26, 2020 at 01:16:28PM +0200, Thomas Gleixner wrote:
>> This is the second version of providing a base to support device MSI (non
>> PCI based) and on top of that support for IMS (Interrupt Message Storm)
>
> s/Storm/Store
>
> maybe pun intended :-)

Maybe? :)

>> based devices in a halfways architecture independent way.
>
> You mean "halfways" because the message addr and data follow guidelines
> per arch (x86 or such), but the location of the storage isn't dictated
> by architecture? or did you have something else in mind?

Yes, the actual message adress and data format are architecture
specific, but we also have x86 specific allocation info format which
needs an arch callback unfortunately.

>>    - Ensure that the necessary flags are set for device SMI
>
> is that supposed to be MSI? 

Of course, but SMI is a better match for Message Storm :)

Thanks,

        tglx
