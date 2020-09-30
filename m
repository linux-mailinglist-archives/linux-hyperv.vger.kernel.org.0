Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D6227EC49
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Sep 2020 17:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgI3PVC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 30 Sep 2020 11:21:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57490 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgI3PUy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 30 Sep 2020 11:20:54 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601479252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8oFwCHrN/W6WTNQvqTZiyA5hlMY4vck+KbQYcROkbgY=;
        b=tYCl/2l9R4E995Qh3NpKoAyGCVWL3mDAoINqMv/wNuGX6S4HLY1wMVi/opGNyehAjnBuMJ
        J/mFnxqGJi9y1lrDtU8LnMFno2uyNWDnp52TihMLBsugausO/YZBw9cbDzave2vbIBXeT8
        c9XBrJIFqei726uvASaVWHUY0kaV6FfyTCQHpLR8sEmrbwtoP4kxIIsZD7IACBeeRFwZRn
        7ON7hpLw5Uvl1DVWD6PmixAFdMiv1ob39g6MMUQOdgyjsZ5EuJng24RutTqLc8w0qmwBjO
        sK7GXvZRJiyMy6q4MjQkl7MaHjpAFd5Jhp3xPljWJGbGpYvLtX3WFJdeM0y38A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601479252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8oFwCHrN/W6WTNQvqTZiyA5hlMY4vck+KbQYcROkbgY=;
        b=rv9d/q3MBb3+XU/aNA8ggIe1jaJhGhyVmeVzqZNtV+VXBu3CX7H3vdb/c69eCm+ZLdQNzU
        yUPJ6t5/jmsl7jBg==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Dey\, Megha" <megha.dey@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        ravi.v.shankar@intel.com
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device MSI
In-Reply-To: <20200930114301.GD816047@nvidia.com>
References: <20200826111628.794979401@linutronix.de> <10b5d933-f104-7699-341a-0afb16640d54@intel.com> <87v9fvix5f.fsf@nanos.tec.linutronix.de> <20200930114301.GD816047@nvidia.com>
Date:   Wed, 30 Sep 2020 17:20:52 +0200
Message-ID: <87k0wbi94b.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 30 2020 at 08:43, Jason Gunthorpe wrote:
> On Wed, Sep 30, 2020 at 08:41:48AM +0200, Thomas Gleixner wrote:
>> On Tue, Sep 29 2020 at 16:03, Megha Dey wrote:
>> > On 8/26/2020 4:16 AM, Thomas Gleixner wrote:
>> >> #9	is obviously just for the folks interested in IMS
>> >>
>> >
>> > I see that the tip tree (as of 9/29) has most of these patches but 
>> > notice that the DEV_MSI related patches
>> >
>> > haven't made it. I have tested the tip tree(x86/irq branch) with your
>> > DEV_MSI infra patches and our IMS patches with the IDXD driver and was
>> 
>> Your IMS patches? Why do you need something special again?
>> 
>> > wondering if we should push out those patches as part of our patchset?
>> 
>> As I don't have any hardware to test that, I was waiting for you and
>> Jason to confirm that this actually works for the two different IMS
>> implementations.
>
> How urgently do you need this? The code looked good from what I
> understood. It will be a while before we have all the parts to send an
> actual patch though.

I personally do not need it at all :) Megha might have different
thoughts... 

> We might be able to put together a mockup just to prove it

If that makes Megha's stuff going that would of course be appreciated,
but we can defer the IMS_QUEUE part for later. It's orthogonal to the
IMS_ARRAY stuff.

Thanks,

        tglx
