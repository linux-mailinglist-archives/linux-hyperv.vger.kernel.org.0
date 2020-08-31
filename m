Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F136F25740E
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Aug 2020 09:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbgHaHKu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 31 Aug 2020 03:10:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59352 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgHaHKu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 31 Aug 2020 03:10:50 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598857848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FARkIRHO1KDuZXY7+kAUc27scL3+jsSFrhOHhYco6Ck=;
        b=pVbGWHzCvbWtavZwE6dhNWXXFxRvilaTtx/laCggTx6McaidMopyu70dd6qN+DpOrvAnEC
        NWQgdTQEqPmTBErfzcv7KTN6E0s/wQHPlfGpQ6LHCLL7knvkvL+Z5EcRMLvdnnyIAZvOc7
        84eFvvaBgqdRh7b6uzJquG6SPUe/5E+2ILpbUF8XQOPYlIKERkhRt0JaVx8y2wLuw/UPVO
        kEYld38+pX8ynofoU0FC9wqE9Xmm4dgEmq8kJrFYuRUPGhZyPmASXHI3qXoTZox/n6FuHy
        WCA7m+B+DJitbQdaThrzVyKrqpDiD0aKyw6+VhHkpAd2LQiXdvrgCHi8IimDMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598857848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FARkIRHO1KDuZXY7+kAUc27scL3+jsSFrhOHhYco6Ck=;
        b=OmZcAy4Z777Iii/2G+bD5e+zVYJ16Fc1fbiIYma87KnA7XicfNHL1pplQOk/GUXLOURqWN
        xldvJovtQWy7NhBg==
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     baolu.lu@linux.intel.com, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
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
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device MSI
In-Reply-To: <02e30654-714b-520a-0d20-fca20794df93@linux.intel.com>
References: <20200826111628.794979401@linutronix.de> <02e30654-714b-520a-0d20-fca20794df93@linux.intel.com>
Date:   Mon, 31 Aug 2020 09:10:47 +0200
Message-ID: <87pn77i93c.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 31 2020 at 08:51, Lu Baolu wrote:
> On 8/26/20 7:16 PM, Thomas Gleixner wrote:
>> This is the second version of providing a base to support device MSI (non
>> PCI based) and on top of that support for IMS (Interrupt Message Storm)
>> based devices in a halfways architecture independent way.
>
> After applying this patch series, the dmar_alloc_hwirq() helper doesn't
> work anymore during boot. This causes the IOMMU driver to fail to
> register the DMA fault handler and abort the IOMMU probe processing.
> Is this a known issue?

See replies to patch 15/46 or pull the git tree. It has the issue fixed.

Thanks,

        tglx
