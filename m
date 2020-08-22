Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D42724E44D
	for <lists+linux-hyperv@lfdr.de>; Sat, 22 Aug 2020 02:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHVAvt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Aug 2020 20:51:49 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12514 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgHVAvs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Aug 2020 20:51:48 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f406be40000>; Fri, 21 Aug 2020 17:50:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 21 Aug 2020 17:51:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 21 Aug 2020 17:51:44 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 22 Aug
 2020 00:51:30 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 22 Aug 2020 00:51:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMErCBhW3gJRYgPUa+HqLDaC5ktjr61Um7H1mAzpZSuh2x3FXZpb9UM2JbDxfuI5LteKd+8F0q7DMPFza4T9itYqxwg3RX+HiqeZ26NHzgOzbNKx6l+5U+m3OOp8dwOO0pT7WHd4dvxubFjiIULw9sPMQpzfdSd+iLsoeL9LKYI0wR59gEwciZ2gYxbaaE67FRh2L17bt8XDPh2suEaDMh0BTG/QEOTNboxe2k2/94fjiM0xZe8x5HGr91GdlaQedzuHe3H/jlYtdXWD4QyRUcO/Yd3yv4r8L4XJOmt0ZxI/Lu3VfyC9WC9jOrsQUBnZyCs1Dg3tnFydjJ5V/pUaug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmKRgHAjKBTAe1pS7uJzz3jnoc0a8CBoae5U2/hIlCo=;
 b=ONQcdxoeTFM3L59N37DjL1MQYnYqI+OijVfdXBEKhsD1vjMTmoMp7Odoik3MThhpCCUAKgJrdgvKVTMbFfABe0iZ/CyCS6SFsXxYK63nWF5trTho+qx2vWYusVdxpwHkXgnb1nIdEGTIijvTyvFx2Vzm3lc8rYJhRFvThrpVyQrzssRdcbmKeHGKuStbLG7RBWcGZTzDdaFfF/jcKciEMfbCuwKXXrwa3LzDkwcw1eSyqeB+vipPKtZZh2pTegSFI/QzyFWvwSThk//1xIN3BvQ/KqE7RBgPuZ5dL7mTFjF8JifZXCnb7M+mWfCSOzbeXT22bSBJYcBJmw+AZ3OSXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0107.namprd12.prod.outlook.com (2603:10b6:4:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Sat, 22 Aug
 2020 00:51:28 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.025; Sat, 22 Aug 2020
 00:51:28 +0000
Date:   Fri, 21 Aug 2020 21:51:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Megha Dey <megha.dey@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Jacob Pan" <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        <iommu@lists.linux-foundation.org>, <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Jon Derrick" <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        "Dimitri Sivanich" <sivanich@hpe.com>, Russ Anderson <rja@hpe.com>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        <xen-devel@lists.xenproject.org>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [patch RFC 38/38] irqchip: Add IMS array driver - NOT FOR MERGING
Message-ID: <20200822005125.GB1152540@nvidia.com>
References: <20200821002424.119492231@linutronix.de>
 <20200821002949.049867339@linutronix.de>
 <20200821124547.GY1152540@nvidia.com>
 <874kovsrvk.fsf@nanos.tec.linutronix.de>
 <20200821201705.GA2811871@nvidia.com>
 <87pn7jr27z.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87pn7jr27z.fsf@nanos.tec.linutronix.de>
X-ClientProxiedBy: BL0PR02CA0057.namprd02.prod.outlook.com
 (2603:10b6:207:3d::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR02CA0057.namprd02.prod.outlook.com (2603:10b6:207:3d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Sat, 22 Aug 2020 00:51:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k9Hkj-00Bw2P-Hk; Fri, 21 Aug 2020 21:51:25 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c20e2de0-dd18-4c97-eeda-08d846358092
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0107:
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0107B6DE6992C787288F9AFDC2580@DM5PR1201MB0107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cgqe2Tl1HPMmlbcyDG7yJXDCgOoBh7ZNS9a8ukgIId5pwgVD8kUCGJVQJtbR/Pmtr32ZkUvvijKqVWgeGgwXJiKU9rypMZTqY4nUA3MEQLAUZHsN1nn71xNAjozwO0Ma4SFE3Q7ZArLitRC7Zoi76GLA54p7xhbINTx2hrRh67x66UiA/CFYA7sI8m3sIgsirsN+vN9J51NQ2uUHzaW6x5intVqV+Q3vq4xsQg6VZ7TEytnxaz6AqmWGVm2RiyegJWFvdnJqi9jkXJW6b3wQFHdI5vhbVKx9z7QYUQ+rq0FuvUSTlDKn9Tpajn7SOP2bbMhA5K/PH2VNyEQkmvg3Vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(83380400001)(186003)(2616005)(426003)(1076003)(26005)(86362001)(8936002)(2906002)(66946007)(33656002)(66476007)(5660300002)(54906003)(6916009)(9786002)(4326008)(36756003)(7406005)(9746002)(7416002)(316002)(8676002)(478600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wZlvJWtNvEY7PWDU3VfRClQDWOTs61uCq74aNOG2Kp3d+dcSuSfVVZ0/Ps+gdISill3bhTVri+CIQm/S/UG8g+IwtWX+0DvOu1zfGB1Jj/J3RVYpD9KRXRDVUj05NCsWzRSlijWXVcQprJ6sweEuXN9/zwoV6wJhDUGW3zborBQNLmCIP94K7AkujuS/Ss3XnVaKuH7SsLPTzzAFAPnipZa6R1pIBuCy0HQ2qzbg7vLbdGEu3nO0qj0GRghovhQhR1XWacg4h9klQqj/NGr4DgWmheELR0xYKQSCNmAKpyT+FWeIJhg8yVEDfzAxRD/TH9Yyw6ixvMGUXcuGhV3D0F9zJdoh29IXmRiAB5MMbbLpRG7g0fftA9x+olFBLNqL/+enT7D9KSi8+h8aR52xt9YsobnyGiXG16I4Vwss4f9i/6lOkY4JNS71JFWQ0mvEbV0X5ohR6jpMIcRc92Ndpg8bziMyKSvCc0rw2z0FuiwfRKd3mgZRVyPw/JlHnZERdaH5YI2GV4x1zhokP5pSY7L7ypY9tDliKndsuXYfsV3aacwGi0u1XypN13xarhyougip/rUQcbILkjtUPifOSPnq3UAQuFtw2wQQLcX/fVcsIeMG58JrPQbmguTQYGQe57rQiGQbt8K2kswReUtTdg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c20e2de0-dd18-4c97-eeda-08d846358092
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2020 00:51:28.5774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFPn3MZj4mTOY2+hYLVO7I0Vpl/cCkzk07hwFaeaCwPI71leePwQgKBZ42oVEy8i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0107
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598057444; bh=vmKRgHAjKBTAe1pS7uJzz3jnoc0a8CBoae5U2/hIlCo=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-LD-Processed:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=R1awGzlLu/cfIVgbQmF8lRnaucOSen15jQ+WAEr/E9ucr7UCkaGU+k2xEgk6em5q5
         IGYa96JRGuSlh7TZ1KdIRdggWyIDwE9z0urPdjM51V9kJJlDcWaGloLfA2hBYm1Hng
         rnfjwiy1lBbQPmR8pTA7zrn8iHykJbFr30rKFglxiszGBnaCBwWmyGZD5VPmsiOTXG
         KbwkpvIWZNAn70Ly75+aVSzTxcOeYmeKIXFhw34Rajy15EQ1VGoMcTZv8jsQvs60eW
         UKKBvo/S1U+TkLuJZ4vP0rK1UIXRa2bgng2VsM7o3I4MF48BLLfa0yo6hZtKHFn74P
         jzvy9TiBMRz2A==
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Aug 22, 2020 at 01:47:12AM +0200, Thomas Gleixner wrote:
> On Fri, Aug 21 2020 at 17:17, Jason Gunthorpe wrote:
> > On Fri, Aug 21, 2020 at 09:47:43PM +0200, Thomas Gleixner wrote:
> >> So if I understand correctly then the queue memory where the MSI
> >> descriptor sits is in RAM.
> >
> > Yes, IMHO that is the whole point of this 'IMS' stuff. If devices
> > could have enough on-die memory then they could just use really big
> > MSI-X tables. Currently due to on-die memory constraints mlx5 is
> > limited to a few hundred MSI-X vectors.
> 
> Right, that's the limit of a particular device, but nothing prevents you
> to have a larger table on a new device.

Well, physics are a problem.. The SRAM to store the MSI vectors costs
die space and making the chip die larger is not an option. So the
question is what do you throw out of the chip to get a 10-20x increase
in MSI SRAM?

This is why using host memory is so appealing. It is
economically/functionally better.

I'm going to guess other HW is in the same situation, virtualization
is really pushing up the number of required IRQs.

> >> How is that supposed to work if interrupt remapping is disabled?
> >
> > The best we can do is issue a command to the device and spin/sleep
> > until completion. The device will serialize everything internally.
> >
> > If the device has died the driver has code to detect and trigger a
> > PCI function reset which will definitely stop the interrupt.
> 
> If that interrupt is gone into storm mode for some reason then this will
> render your machine unusable before you can do that.

Yes, but in general the HW design is to have one-shot interrupts, it
would have to be well off the rails to storm. The kind of off the
rails where it could also be doing crazy stuff on PCI-E that would be
very harmful.

> > So, the implementation of these functions would be to push any change
> > onto a command queue, trigger the device to DMA the command, spin/sleep
> > until the device returns a response and then continue on. If the
> > device doesn't return a response in a time window then trigger a WQ to
> > do a full device reset.
> 
> I really don't want to do that with the irq descriptor lock held or in
> case of affinity from the interrupt handler as we have to do with PCI
> MSI/MSI-X due to the horrors of the X86 interrupt delivery trainwreck.
> Also you cannot call into command queue code from interrupt disabled and
> interrupt descriptor lock held sections. You can try, but lockdep will
> yell at you immediately.

Yes, I wouldn't want to do this from an IRQ.

> One question is whether the device can see partial updates to that
> memory due to the async 'swap' of context from the device CPU.

It is worse than just partial updates.. The device operation is much
more like you'd imagine a CPU cache. There could be copies of the RAM
in the device for long periods of time, dirty data in the device that
will flush back to CPU RAM overwriting CPU changes, etc.

Without involving the device there is just no way to create data
consistency, and no way to change the data from the CPU. 

This is the down side of having device data in the RAM. It cannot be
so simple as 'just fetch it every time before you use it' as
performance would be horrible.

> irq chips have already a mechanism in place to deal with stuff which
> cannot be handled from within the irq descriptor spinlock held and
> interrupt disabled section.
> 
> The mechanism was invented to deal with interrupt chips which are
> connected to i2c, spi, etc.. The access to an interrupt chip control
> register has to queue stuff on the bus and wait for completion.
> Obviously not what you can do from interrupt disabled, raw spinlock held
> context either.

Ah intersting, sounds like the right parts! I didn't know about this..

> Now coming back to affinity setting. I'd love to avoid adding the bus
> lock magic to those interfaces because until now they can be called and
> are called from atomic contexts. And obviously none of the devices which
> use the buslock magic support affinity setting because they all deliver
> a single interrupt to a demultiplex interrupt and that one is usually
> sitting at the CPU level where interrupt steering works.
> 
> If we really can get away with atomically updating the message as
> outlined above and just let it happen at some point in the future then
> most problems are solved, except for the nastyness of CPU hotplug.

Since we can't avoid a device command, I'm think more along the lines
of having the affinity update trigger an async WQ to issue the command
from a thread context. Since it doesn't need to be synchronous it can
make it out 'eventually'.

I suppose the core code could provide this as a service? Sort of a
varient of the other lazy things above?

> But that's actually a non issue. Nothing prevents us from having an
> early 'migrate interrupts away from the outgoing CPU hotplug state'
> which runs in thread context and can therefore utilize the buslock
> mechanism. Actually I was thinking about that for other reasons already.

That would certainly work well, seems like it fits with the other
lazy/sleeping stuff above as well.

> >> If interrupt remapping is enabled then both are trivial because then the
> >> irq chip can delegate everything to the parent chip, i.e. the remapping
> >> unit.
> >
> > I did like this notion that IRQ remapping could avoid the overhead of
> > spin/spleep. Most of the use cases we have for this will require the
> > IOMMU anyhow.
> 
> You still need to support !remap scenarios I fear.

For x86 I think we could accept linking this to IOMMU, if really
necessary.

But it would have to work with ARM - is remapping a x86 only thing?
Does ARM put the affinity in the GIC tables not in the MSI data?

> Let me summarize what I think would be the sane solution for this:
> 
>   1) Utilize atomic writes for either all 16 bytes or reorder the bytes
>      and update 8 bytes atomically which is sufficient as the wide
>      address is only used with irq remapping and the MSI message in the
>      device is never changed after startup.

Sadly not something the device can manage due to data coherence

>   2) No requirement for issuing a command for regular migration
>      operations as they have no requirements to be synchronous.
> 
>      Eventually store some state to force a reload on the next regular
>      queue operation.

Would the async version above be OK?

>   3) No requirement for issuing a command for mask and unmask operations.
>      The core code uses and handles lazy masking already. So if the
>      hardware causes the lazyness, so be it.

This lazy masking thing sounds good, I'm totally unfamiliar with it
though.

>   4) Issue commands for startup and teardown as they need to be
>      synchronous

Yep

>   5) Have an early migration state for CPU hotunplug which issues a
>      command from appropriate context. That would even allow to handle
>      queue shutdown for managed interrupts when the last CPU in the
>      managed affinity set goes down. Restart of such a managed interrupt
>      when the first CPU in an affinity set comes online again would only
>      need minor modifications of the existing code to make it work.

Yep

> Thoughts?

This email is super helpful, I definately don't know all these corners
of the IRQ subsystem as my past with it has mostly been SOC stuff that
isn't as complicated!

Thanks,
Jason
