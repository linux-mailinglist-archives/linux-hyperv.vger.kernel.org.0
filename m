Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7354B252343
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 00:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHYWDc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Aug 2020 18:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHYWDb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Aug 2020 18:03:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6DDC061755;
        Tue, 25 Aug 2020 15:03:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598393009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0OqxJ3l66kPTHUwReqWXl4aiQwAYOml1CtAOOFtsv/I=;
        b=rJTu5uXpTB1P7KT9UkG/8QM9fLrXGorXoC87ldkXgjkRXx5UAas5uFTUMerUTXL9JlFfzV
        rN3mZfoDNBV8AFB4vRFBpqUVtR9nGugXHxgcJlZA9lyZ5d2iRKFgP2+zfzE6U60bVSUFwq
        JoLhqfRIwLjtW2QJXOy7XsedElokgWXmgQLvMAipf+uoAXx8CCMOl+k9j0g1QoHUmXG34r
        mtlyReJy8es+Aozjv5DjFb2Cq+iiM4U59lGIjrG1/fFCYms18my92/EJtXX6kAE+PpZd7v
        7ConNiKl15unKahtr/RvxdhuwT8O3LvR9FUpV5Q5QAqhgXFDbooECvOu9qLmBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598393009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0OqxJ3l66kPTHUwReqWXl4aiQwAYOml1CtAOOFtsv/I=;
        b=ZiNuzZqVhtmi5VokOZzEDE7yq2WAukGXdvrPoJKZHc1CKcyDYknuCTC8rLaX/mB0MFG9sG
        hpgpBFzac0BPrGDw==
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
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
        Russ Anderson <rja@hpe.com>,
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
Subject: Re: [patch RFC 30/38] PCI/MSI: Allow to disable arch fallbacks
In-Reply-To: <871rjuxv45.fsf@nanos.tec.linutronix.de>
References: <20200825213501.GA1931388@bjorn-Precision-5520> <871rjuxv45.fsf@nanos.tec.linutronix.de>
Date:   Wed, 26 Aug 2020 00:03:29 +0200
Message-ID: <87y2m2wfgu.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 25 2020 at 23:40, Thomas Gleixner wrote:
> On Tue, Aug 25 2020 at 16:35, Bjorn Helgaas wrote:
>> On Tue, Aug 25, 2020 at 11:28:30PM +0200, Thomas Gleixner wrote:
>>> 
>>> Or did you just mean that those architectures should select
>>> CONFIG_I_WANT_THE CRUFT instead of opting out on the fully irq domain
>>> based ones?
>>
>> Yes, that was my real question -- can we confine the cruft in the
>> crufty arches?  If not, no big deal.
>
> Should be doable. Let me try.

Bah. There is more cruft.

The weak implementation has another way to go sideways via
msi_controller::setup_irq[s] and msi_controller::teardown_irq

drivers/pci/controller/pci-tegra.c
drivers/pci/controller/pcie-rcar-host.c
drivers/pci/controller/pcie-xilinx.c

Groan....

