Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7853324EC13
	for <lists+linux-hyperv@lfdr.de>; Sun, 23 Aug 2020 10:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgHWIDM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 23 Aug 2020 04:03:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36746 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbgHWIDL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 23 Aug 2020 04:03:11 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598169788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1r81LXAzLVDLyLks6MQQbnmtJ0OK+dyyaovYHtczdF8=;
        b=OSUGo4PT4Ot+VGZW7JgEcWsC8MLwYCCnwHNCt3TYiEzvYBVXe45Rvl3FX/Y0isC1ShdQQ3
        RIh/bv3QSwwzvd8iYJBo7gkkwrPBgPqWBWG0qyIj42/W8ULqyGPqdtcmY9SWXIe6qo1A1Q
        G8rQ4XqyV5X9tf+kKzjK0R1QN5bjpdFSWtGLnHuCi+FXplbjlm/gIBBAoZuWJKD4qsyf1+
        E4sJhAD2xn/VQyYp3NoK60i70Z16VK3CVNEGe2YhdqoIM5dCPu+czaZXI3Of9hT7hNOiiq
        KycdvEqCmdiPmuLVuylio+jeqSn+LdOfVq0686G5ly9H6MwoSrM+c5IPwwJFcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598169788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1r81LXAzLVDLyLks6MQQbnmtJ0OK+dyyaovYHtczdF8=;
        b=tMc6ZKpqYdgSdwXa7ZmkDUuCxCEpdWuXt4VgP89zL1RSX0c8gVXVItieBv1Rh/DCd8vqw0
        Q7nUMe69k9VLtDAQ==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Marc Zyngier <maz@kernel.org>, Megha Dey <megha.dey@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [patch RFC 38/38] irqchip: Add IMS array driver - NOT FOR MERGING
In-Reply-To: <20200822230511.GD1152540@nvidia.com>
References: <20200821002424.119492231@linutronix.de> <20200821002949.049867339@linutronix.de> <20200821124547.GY1152540@nvidia.com> <874kovsrvk.fsf@nanos.tec.linutronix.de> <20200821201705.GA2811871@nvidia.com> <87pn7jr27z.fsf@nanos.tec.linutronix.de> <20200822005125.GB1152540@nvidia.com> <874kovqx8q.fsf@nanos.tec.linutronix.de> <20200822230511.GD1152540@nvidia.com>
Date:   Sun, 23 Aug 2020 10:03:07 +0200
Message-ID: <875z99ssas.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Aug 22 2020 at 20:05, Jason Gunthorpe wrote:
> On Sat, Aug 22, 2020 at 03:34:45AM +0200, Thomas Gleixner wrote:
> As a silicon design it might work, but it means existing devices can't
> be used with this dev_msi. It is also the sort of thing that would
> need a standard document to have any hope of multiple vendors fitting
> into it. Eg at PCI-SIG or something.

Fair enough.

>> If you don't do that then you simply can't write to that space from the
>> CPU and you have to transport this kind information always via command
>> queues.
>
> Yes, exactly. This is part of the architectural design of the device,
> has been for a long time. Has positives and negatives.

As always and it clearly follows the general HW design rule "we can fix
that in software".

>> > I suppose the core code could provide this as a service? Sort of a
>> > varient of the other lazy things above?
>> 
>> Kinda. That needs a lot of thought for the affinity setting stuff
>> because it can be called from contexts which do not allow that. It's
>> solvable though, but I clearly need to stare at the corner cases for a
>> while.
>
> If possible, this would be ideal, as we could use the dev_msi on a big
> installed base of existing HW.

I'll have a look, but I'm surely not going to like the outcome.

Thanks,

        tglx
