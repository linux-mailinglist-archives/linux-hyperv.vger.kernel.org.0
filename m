Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B13C25395A
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 22:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgHZUuR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 16:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgHZUuQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 16:50:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C164C061574;
        Wed, 26 Aug 2020 13:50:16 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598475014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JG/TkMq9NWC6OfHgPC/IbFpW4xr9Kt9L0ix/14aZbxc=;
        b=s4YbUFCtbJEMrLqgKd7OwtYh18vHyM4HfQLj0mVtwmVQVO9mPe+rbcu9/9RQcu7BDqxIXq
        4SC8x5F55ReokeL0LN8UUQFD5m3BjRCcVnOHVA++cJ3n9iGLghzLvQHLb6sr4Opghelyw7
        wtiHRsopz/7aQ7mxdNa4ubr9zMjw6kUfb9G723x0mquWT/8sbYu95BnkyTknE0X6c2XJfj
        G2IbL55VnbnoeT093T8n8BdlC4i9HNmIpjyrPxF0OWHJtvkDyBhZ80We7p7G5tVUd/JFYJ
        lndw1zv+U67ElbvOK78N7X9qxyNKvPXDl0P5nwVk071fVAGS++QK4AuCw0xoVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598475014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JG/TkMq9NWC6OfHgPC/IbFpW4xr9Kt9L0ix/14aZbxc=;
        b=aS6JntODH9ZvZZJHE2vQuw6G8LnzzNi8bSa6D1XA+HMxu+eOePiLVi0SGkTN8Uz37jCbMJ
        TOeuyIqSX/IO5mCA==
To:     "Dey\, Megha" <megha.dey@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
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
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch V2 15/46] x86/irq: Consolidate DMAR irq allocation
In-Reply-To: <878se1uulb.fsf@nanos.tec.linutronix.de>
References: <20200826111628.794979401@linutronix.de> <20200826112332.163462706@linutronix.de> <812d9647-ad2e-95e9-aa99-b54ff7ebc52d@intel.com> <878se1uulb.fsf@nanos.tec.linutronix.de>
Date:   Wed, 26 Aug 2020 22:50:13 +0200
Message-ID: <87r1rtt9mi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 26 2020 at 20:32, Thomas Gleixner wrote:
> On Wed, Aug 26 2020 at 09:50, Megha Dey wrote:
>>> @@ -329,15 +329,15 @@ static struct irq_chip dmar_msi_controll
>>>   static irq_hw_number_t dmar_msi_get_hwirq(struct msi_domain_info *info,
>>>   					  msi_alloc_info_t *arg)
>>>   {
>>> -	return arg->dmar_id;
>>> +	return arg->hwirq;
>>
>> Shouldn't this return the arg->devid which gets set in dmar_alloc_hwirq?
>
> Indeed.

But for simplicity we can set arg->hwirq to the dmar id right in the
alloc function and then once the generic ops are enabled remove the dmar
callback completely.
