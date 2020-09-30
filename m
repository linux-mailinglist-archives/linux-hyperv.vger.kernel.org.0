Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D0D27F07A
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Sep 2020 19:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgI3RZi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 30 Sep 2020 13:25:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:38694 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI3RZi (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 30 Sep 2020 13:25:38 -0400
IronPort-SDR: 7PxRitwFbX+8mNPFj14EOLf6TlCjZkO+jnW3uSQD7yYurwkz7EN8d61XkS/1x6hLV3ZPA4uc1y
 lYTg2KBi2Egg==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="150158533"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="150158533"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 10:25:37 -0700
IronPort-SDR: FK7/wIJBisXTMuj6iqUnpiUpF0sHZmEXgWujctvoBj/uFfZp+PCakKD8gDd4Smm5TFBZfQyr6i
 CR1IGgnmqLIQ==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="308240091"
Received: from meghadey-mobl1.amr.corp.intel.com (HELO [10.255.88.197]) ([10.255.88.197])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 10:25:34 -0700
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device
 MSI
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>
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
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        ravi.v.shankar@intel.com
References: <20200826111628.794979401@linutronix.de>
 <10b5d933-f104-7699-341a-0afb16640d54@intel.com>
 <87v9fvix5f.fsf@nanos.tec.linutronix.de> <20200930114301.GD816047@nvidia.com>
 <87k0wbi94b.fsf@nanos.tec.linutronix.de>
From:   "Dey, Megha" <megha.dey@intel.com>
Message-ID: <e07aa723-12cd-7eb7-392a-642f96b98f79@intel.com>
Date:   Wed, 30 Sep 2020 10:25:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <87k0wbi94b.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Thomas/Jason,

On 9/30/2020 8:20 AM, Thomas Gleixner wrote:
> On Wed, Sep 30 2020 at 08:43, Jason Gunthorpe wrote:
>> On Wed, Sep 30, 2020 at 08:41:48AM +0200, Thomas Gleixner wrote:
>>> On Tue, Sep 29 2020 at 16:03, Megha Dey wrote:
>>>> On 8/26/2020 4:16 AM, Thomas Gleixner wrote:
>>>>> #9	is obviously just for the folks interested in IMS
>>>>>
>>>> I see that the tip tree (as of 9/29) has most of these patches but
>>>> notice that the DEV_MSI related patches
>>>>
>>>> haven't made it. I have tested the tip tree(x86/irq branch) with your
>>>> DEV_MSI infra patches and our IMS patches with the IDXD driver and was
>>> Your IMS patches? Why do you need something special again?

By IMS patches, I meant your IMS driver patch that was updated (as it 
was untested, it had some compile

errors and we removed the IMS_QUEUE parts) :

https://lore.kernel.org/lkml/160021246221.67751.16280230469654363209.stgit@djiang5-desk3.ch.intel.com/

and some iommu related changes required by IMS.

https://lore.kernel.org/lkml/160021246905.67751.1674517279122764758.stgit@djiang5-desk3.ch.intel.com/

The whole patchset can be found here:

https://lore.kernel.org/lkml/f4a085f1-f6de-2539-12fe-c7308d243a4a@intel.com/

It would be great if you could review the IMS patches :)

>>>
>>>> wondering if we should push out those patches as part of our patchset?
>>> As I don't have any hardware to test that, I was waiting for you and
>>> Jason to confirm that this actually works for the two different IMS
>>> implementations.
>> How urgently do you need this? The code looked good from what I
>> understood. It will be a while before we have all the parts to send an
>> actual patch though.
> I personally do not need it at all :) Megha might have different
> thoughts...

I have tested these patches and it works fine (I had to add a couple of 
EXPORT_SYMBOLS).

We were hoping to get IMS in the 5.10 merge window :)

>
>> We might be able to put together a mockup just to prove it
> If that makes Megha's stuff going that would of course be appreciated,
> but we can defer the IMS_QUEUE part for later. It's orthogonal to the
> IMS_ARRAY stuff.

In our patch series, we have removed the IMS_QUEUE stuff and retained 
only the IMS_ARRAY parts

as that was sufficient for us.

>
> Thanks,
>
>          tglx
