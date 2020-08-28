Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535F02551DB
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Aug 2020 02:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgH1ANr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Aug 2020 20:13:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:18591 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgH1ANr (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Aug 2020 20:13:47 -0400
IronPort-SDR: 735/lkOY3dvTnKz6kBbG/Sl4dW1DqCJRvQWLvtYZY4hfO31n9aTWnwkWrMAHZpGdJDvjnLgVsn
 HllVQxdHpRmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="218136614"
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; 
   d="scan'208";a="218136614"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 17:13:46 -0700
IronPort-SDR: uAmGoMAFhGRvD5NPRLnN/ekYEL+Xjxv+g4TWsI9UNYPL5S4ZMqTmCJhNgf7wqckE0S2ryUHTLn
 7aEo94gI807g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; 
   d="scan'208";a="295950071"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga003.jf.intel.com with ESMTP; 27 Aug 2020 17:13:46 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Aug 2020 17:12:49 -0700
Received: from orsmsx101.amr.corp.intel.com (10.22.225.128) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 27 Aug 2020 17:12:49 -0700
Received: from [10.254.177.214] (10.254.177.214) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Aug 2020 17:12:48 -0700
Subject: Re: [patch V2 15/46] x86/irq: Consolidate DMAR irq allocation
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        <iommu@lists.linux-foundation.org>, <linux-hyperv@vger.kernel.org>,
        "Haiyang Zhang" <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        "Russ Anderson" <rja@hpe.com>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        <xen-devel@lists.xenproject.org>, Juergen Gross <jgross@suse.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
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
References: <20200826111628.794979401@linutronix.de>
 <20200826112332.163462706@linutronix.de>
 <812d9647-ad2e-95e9-aa99-b54ff7ebc52d@intel.com>
 <878se1uulb.fsf@nanos.tec.linutronix.de>
 <87r1rtt9mi.fsf@nanos.tec.linutronix.de>
From:   "Dey, Megha" <megha.dey@intel.com>
Message-ID: <f78f0b1f-3c83-2629-405c-7b25875432db@intel.com>
Date:   Thu, 27 Aug 2020 17:12:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87r1rtt9mi.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.254.177.214]
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Thomas,

On 8/26/2020 1:50 PM, Thomas Gleixner wrote:
> On Wed, Aug 26 2020 at 20:32, Thomas Gleixner wrote:
>> On Wed, Aug 26 2020 at 09:50, Megha Dey wrote:
>>>> @@ -329,15 +329,15 @@ static struct irq_chip dmar_msi_controll
>>>>    static irq_hw_number_t dmar_msi_get_hwirq(struct msi_domain_info *info,
>>>>    					  msi_alloc_info_t *arg)
>>>>    {
>>>> -	return arg->dmar_id;
>>>> +	return arg->hwirq;
>>> Shouldn't this return the arg->devid which gets set in dmar_alloc_hwirq?
>> Indeed.
> But for simplicity we can set arg->hwirq to the dmar id right in the
> alloc function and then once the generic ops are enabled remove the dmar
> callback completely
True, can get rid of more code that way.
