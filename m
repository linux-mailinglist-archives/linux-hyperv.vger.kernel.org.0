Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB47224EA32
	for <lists+linux-hyperv@lfdr.de>; Sun, 23 Aug 2020 01:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgHVXFf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 22 Aug 2020 19:05:35 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4177 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgHVXFd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 22 Aug 2020 19:05:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f41a4460000>; Sat, 22 Aug 2020 16:03:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 22 Aug 2020 16:05:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 22 Aug 2020 16:05:31 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 22 Aug
 2020 23:05:16 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 22 Aug 2020 23:05:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzINHS2lB5VMQo1z+V0vLZnWz2fUT2nfYWoAcgxBOf816fMUUdhlAI568xjHHKsEUYr5C0/WApdt8erU1vwik2cVoiMxnbq1Xt58VSA6ZSlMy52b5MESsEWz/j5YB6z/VZlMcjOP6iy5yqK9vUtQtr7ZXIVxhpvUZTdwZZfj0lz6KxIsxTf51vjZRmMJuVH4SmiBEVtd+Dq78f2LVBbuBvst+iO7masCRlyVlMmILm8stncnjp5xEaJYzZrCavECSpaVyXxTtMhE8cLztEs5BOEP58FUNvQKv+zwp60rRDAPycNDQjWWb3kwpE+upTUwWOPX3M+Lsfy6nECLPr39Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUU7i885Q6+sCrSRdJX4f1HK+ORpbXNg4XTyZno15Gc=;
 b=E/47vkxo8RsRwavW/QoHsdQNqv6jU+IlMJL8A3gdjs/NA8iptaVcf5V8urp8pWlVeHo3PguCTs2CbFp1PeJ4GeYwp0ydGdRVw/3tiBnXadMpx59EBWIY2v+YBmBZvMTtpbQiY7D8leNU6/SnNV9wtylhB1HWMFdmMUf1UuqWxLC/Tz0nc0xlbhv6gYQWhrCcLQmaiGYqoE+2/4ONfX6tDDeWG2yoYYJ5MyzG5bsuQxJnancpIWF2ggMYlwjEm4ugBYIOqvV8BSDU4zKS7d2WZXcXYZyw20hnoIc0c4M7LmXNl2QNOaBlFFQbPA+HFh8+D9EUHzdfOPj5L1ZSShMvUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3209.namprd12.prod.outlook.com (2603:10b6:5:184::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Sat, 22 Aug
 2020 23:05:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.025; Sat, 22 Aug 2020
 23:05:13 +0000
Date:   Sat, 22 Aug 2020 20:05:11 -0300
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
Message-ID: <20200822230511.GD1152540@nvidia.com>
References: <20200821002424.119492231@linutronix.de>
 <20200821002949.049867339@linutronix.de>
 <20200821124547.GY1152540@nvidia.com>
 <874kovsrvk.fsf@nanos.tec.linutronix.de>
 <20200821201705.GA2811871@nvidia.com>
 <87pn7jr27z.fsf@nanos.tec.linutronix.de>
 <20200822005125.GB1152540@nvidia.com>
 <874kovqx8q.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <874kovqx8q.fsf@nanos.tec.linutronix.de>
X-ClientProxiedBy: MN2PR19CA0026.namprd19.prod.outlook.com
 (2603:10b6:208:178::39) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR19CA0026.namprd19.prod.outlook.com (2603:10b6:208:178::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Sat, 22 Aug 2020 23:05:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k9cZT-00CHyg-1B; Sat, 22 Aug 2020 20:05:11 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4eb8662e-4148-46c3-2467-08d846efd2c5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3209:
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR12MB32092F6117C81D2DF59165FAC2580@DM6PR12MB3209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AjV8yxqty3rsW8NWUaLx8IbeTDv3k5w3Wv/EZJ5hk7ElVaVq9LLJld7WJhfKFrBxBcKtAGl+XuPIlyA1TyiDPOR/0XmZkS1onG6Th9oIeN0LHLAoyNKTAmlnpfNj9+rX82ic247YTNFkxKHDiXU3/dOlE9Rkt5aRw9A1tM6PEpu4FWLT75psGooHk+kPj6UUAv28CSPGKNgMp9e2KWEdq4qoa4kylJQv2QWxMj267iSNhYzWsvGPbVoZ1xl4/8JdBP4QMSkiRDvhb2k7L7oBSDKrb8s4jo/wj/1+tzQbTs66kmbjueYet4/OnOhuK+Au0S/EFyGehRzeVOvSVIOJ8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39850400004)(366004)(396003)(1076003)(478600001)(36756003)(5660300002)(54906003)(8676002)(8936002)(316002)(2906002)(186003)(26005)(9746002)(9786002)(7406005)(7416002)(2616005)(4326008)(83380400001)(426003)(66556008)(66476007)(66946007)(86362001)(6916009)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: FtuYeEFCAY1e9xhPDY8977O+plfZWclp5v1ybdJXcX5rwoIdZLXuYgfw+hHPc0lxvCNXnsO9jTuVAavIJQgjalGGn+nUwsYE7bRKBDxicoHhZQue5SNzzgYNRHcniUxkAs4BZavHdQyrt40JSTHXqBj5H+SvGJjqYRn2i7MBcaa3h8HbvQSfWqjx6XjaCvE7E+U1bvoJF7kXnKs0M6YbnAWZ8Ho3MfkPshBedXfMMLbCBeUCLxkWGA8Vwcn3AXsP7vb4BYmnOzgJOBJspvBL5rDPyepvFXf3JmxjioR01BGin2fdpCgsUdiSDV1E6nyZCbpn5zhipJA1TSeh24yV3Lsm1lm87AkIvB987r6lbDWFa0wtEjCDmN4dPOCfmzhxlG7+4r+Ld75Uk6RAi9wXZ2bQAE4J9SvSxc6bZW1AZDjTHuYhK7kR5z77xNpsWIihEfHgYYxoFlB6jFqls4X3R/T6usTjXQ2DO20hLQ5yiYyPgfNy64yhW1ipSlOyKd/Rax1csBZlRepQ5ExdXz5Z8RfvLRkXbIXGN2tuNntgJPwPQVCuCKM99qfa60r2Z+APlnwwocJgSVQsJBb6suJF4aXftitKgPXsf7QUQjY3U5ybVtfOFAQI1QSc4t/lnpx2VF4SpX/1vF6XDW5mlRXuug==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb8662e-4148-46c3-2467-08d846efd2c5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2020 23:05:13.7138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NORN6ASWCk+71Ok3Hqa96b1B/xj8faAUeVYznBOI6PKv/slsVCviurbfpSdfUEVW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3209
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598137415; bh=WUU7i885Q6+sCrSRdJX4f1HK+ORpbXNg4XTyZno15Gc=;
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
        b=Y94EU2S4jeRtrpmTUhyNtkuVBxTovfAoqlGA+Fs/99cdGCK8Fe3KU3STgXL66lcvs
         UVoSoqgc9MdZxF7Flv58RJAG7dJ9MT5CLHa1qccBoF+0U+O6mXwxUUzD8nejxkAZnX
         tp6etExJ6qtMZcatI0L1HWfYTOiAnpUmgYqnVIzmvAAT63NziAC9Q5zimuShHN28+x
         gnEpP/OrSkMsXtJS/ymuZm9vfnXGdl0fiFOzGkbeTv/W3kAXyD/UDfFXebZGpu86zW
         Vodu75IC1SkYbIwOfqp/f2c4Cb0QfL/W0wYE+vkRohhLG+/V17+GGptPPb4lMIItSV
         MPGc3wVCdwoEg==
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Aug 22, 2020 at 03:34:45AM +0200, Thomas Gleixner wrote:
> >> One question is whether the device can see partial updates to that
> >> memory due to the async 'swap' of context from the device CPU.
> >
> > It is worse than just partial updates.. The device operation is much
> > more like you'd imagine a CPU cache. There could be copies of the RAM
> > in the device for long periods of time, dirty data in the device that
> > will flush back to CPU RAM overwriting CPU changes, etc.
> 
> TBH, that's insane. You clearly want to think about this some
> more. If

I think this general design is around 15 years old, across a healthy
number of silicon generations, and rather a lager number of shipped
devices. People have thought about it :)

> you swap out device state and device control state then you definitly
> want to have regions which are read only from the device POV and never
> written back. 

It is not as useful as you'd think - the issue with atomicity of
update still largely prevents doing much useful from the CPU, and to
make any CPU side changes visible a device command would still be
needed to synchronize the internal state to that modified memory.

So, CPU centric updates would cover a very limited number of
operations, and a device command is required anyhow. Little is
actually gained.

> The MSI msg store clearly belongs into that category.
> But that's not restricted to the MSI msg store, there is certainly other
> stuff which never wants to be written back by the device.

To get a design where you'd be able to run everything from a CPU
atomic context that can't trigger a WQ..

New silicon would have to implement some MSI-only 'cache' that can
invalidate entries based on a simple MemWr TLP.

Then the affinity update would write to the host memory, then send a
MemWr to the device to trigger invalidate.

As a silicon design it might work, but it means existing devices can't
be used with this dev_msi. It is also the sort of thing that would
need a standard document to have any hope of multiple vendors fitting
into it. Eg at PCI-SIG or something.

> If you don't do that then you simply can't write to that space from the
> CPU and you have to transport this kind information always via command
> queues.

Yes, exactly. This is part of the architectural design of the device,
has been for a long time. Has positives and negatives.

> > I suppose the core code could provide this as a service? Sort of a
> > varient of the other lazy things above?
> 
> Kinda. That needs a lot of thought for the affinity setting stuff
> because it can be called from contexts which do not allow that. It's
> solvable though, but I clearly need to stare at the corner cases for a
> while.

If possible, this would be ideal, as we could use the dev_msi on a big
installed base of existing HW.

I suspect other HW can probably fit into this too as the basic
ingredients should be fairly widespread.

Even a restricted version for situations where affinity does not need
a device update would possibly be interesting (eg x86 IOMMU remap, ARM
GIC, etc)

> OTOH, in normal operation for MSI interrupts (edge type) masking is not
> used at all and just restricted to the startup teardown.

Yeah, at least this device doesn't need masking at runtime, just
startup/teardown and affinity update.

Thanks,
Jason
