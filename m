Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FA02522FF
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Aug 2020 23:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHYVkN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Aug 2020 17:40:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52654 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgHYVkN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Aug 2020 17:40:13 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598391611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xevxgk/koQBpWDveP6OSc84vgcr5kfA4Zdl3bp5EVM4=;
        b=4xeToqQJtFdDP336L/z/rJTPtiaEMQCwoWm7ZO3Dg80xwJI6LJbbyPem9IgDDH4c55kFW8
        efqvvncv7tcn3qZRe1acTT+kpdjKgMt9wBNwOWKpIu8I/uajoL15iwyI1xdSxrTpkklftN
        qSOF96Uua9BwCriI1UaH4colhyY+dU/jTNfAqa0OFWsv2NiYjXrj2a+s3Ori4UXHG1ddJa
        SA25EuwSuC9jCrd07R3Jsye+YPfQwEl1Ep3+ek2m/tcneuMb2osfUQOvMB9hVnwV5yHYK2
        m18kpfK5PCTA749jQbnkT3Om2+aFbVSlYN71Sn1ixrGPB3rBhJD9Y7h2fYYcZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598391611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xevxgk/koQBpWDveP6OSc84vgcr5kfA4Zdl3bp5EVM4=;
        b=JuIC3Wa21psedQKJydMn/nuPaxSXUZxPFQxtgBHwdGz1Ag7Nv0IARkCrU78WZB/vmrNKK/
        V7gDLpNFS4jDbzDw==
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
In-Reply-To: <20200825213501.GA1931388@bjorn-Precision-5520>
References: <20200825213501.GA1931388@bjorn-Precision-5520>
Date:   Tue, 25 Aug 2020 23:40:10 +0200
Message-ID: <871rjuxv45.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 25 2020 at 16:35, Bjorn Helgaas wrote:
> On Tue, Aug 25, 2020 at 11:28:30PM +0200, Thomas Gleixner wrote:
>> 
>> Or did you just mean that those architectures should select
>> CONFIG_I_WANT_THE CRUFT instead of opting out on the fully irq domain
>> based ones?
>
> Yes, that was my real question -- can we confine the cruft in the
> crufty arches?  If not, no big deal.

Should be doable. Let me try.

Thanks,

        tglx
