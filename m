Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D17F253F77
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Aug 2020 09:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgH0Hq1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Aug 2020 03:46:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:49900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgH0Hq1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Aug 2020 03:46:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 49C1EACF2;
        Thu, 27 Aug 2020 07:46:57 +0000 (UTC)
Subject: Re: [patch V2 27/46] x86/xen: Rework MSI teardown
To:     Thomas Gleixner <tglx@linutronix.de>,
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
        xen-devel@lists.xenproject.org,
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
References: <20200826111628.794979401@linutronix.de>
 <20200826112333.326841410@linutronix.de>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <5c18f793-9212-b7f0-583d-896e1957ba1a@suse.com>
Date:   Thu, 27 Aug 2020 09:46:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826112333.326841410@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 26.08.20 13:16, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> X86 cannot store the irq domain pointer in struct device without breaking
> XEN because the irq domain pointer takes precedence over arch_*_msi_irqs()
> fallbacks.
> 
> XENs MSI teardown relies on default_teardown_msi_irqs() which invokes
> arch_teardown_msi_irq(). default_teardown_msi_irqs() is a trivial iterator
> over the msi entries associated to a device.
> 
> Implement this loop in xen_teardown_msi_irqs() to prepare for removal of
> the fallbacks for X86.
> 
> This is a preparatory step to wrap XEN MSI alloc/free into a irq domain
> which in turn allows to store the irq domain pointer in struct device and
> to use the irq domain functions directly.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
