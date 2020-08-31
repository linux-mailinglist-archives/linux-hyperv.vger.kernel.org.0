Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DC525744A
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Aug 2020 09:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgHaHaH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 31 Aug 2020 03:30:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:22647 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgHaHaG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 31 Aug 2020 03:30:06 -0400
IronPort-SDR: X7Nmi2i2EiRqmwnc0UajamPmS4dDNsg8AHLrLIXB3STHo+rgmkVY35FZWjqSNYKLMemlvaBYBe
 uHVrdOAtkk8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="218473000"
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; 
   d="scan'208";a="218473000"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 00:30:04 -0700
IronPort-SDR: RhGSL7wyVsjh+qsvOh480VVPNj2zqANcLsAm0u5fLr0CbkyXraU3/CQPTHJpjckYsGMnAcC/x1
 3SMjo64MzSQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; 
   d="scan'208";a="501762398"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.84]) ([10.254.212.84])
  by fmsmga005.fm.intel.com with ESMTP; 31 Aug 2020 00:29:57 -0700
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
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device
 MSI
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200826111628.794979401@linutronix.de>
 <02e30654-714b-520a-0d20-fca20794df93@linux.intel.com>
 <87pn77i93c.fsf@nanos.tec.linutronix.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b41eb9d7-0438-8a3a-d708-0173b4b25fea@linux.intel.com>
Date:   Mon, 31 Aug 2020 15:29:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <87pn77i93c.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Thomas,

On 2020/8/31 15:10, Thomas Gleixner wrote:
> On Mon, Aug 31 2020 at 08:51, Lu Baolu wrote:
>> On 8/26/20 7:16 PM, Thomas Gleixner wrote:
>>> This is the second version of providing a base to support device MSI (non
>>> PCI based) and on top of that support for IMS (Interrupt Message Storm)
>>> based devices in a halfways architecture independent way.
>>
>> After applying this patch series, the dmar_alloc_hwirq() helper doesn't
>> work anymore during boot. This causes the IOMMU driver to fail to
>> register the DMA fault handler and abort the IOMMU probe processing.
>> Is this a known issue?
> 
> See replies to patch 15/46 or pull the git tree. It has the issue fixed.

Ah! Yes. Sorry for the noise.

Beset regards,
baolu
