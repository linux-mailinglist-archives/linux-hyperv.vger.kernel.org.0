Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B27257B71
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Aug 2020 16:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHaOpk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 31 Aug 2020 10:45:40 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6793 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgHaOpj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 31 Aug 2020 10:45:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4d0ce50000>; Mon, 31 Aug 2020 07:44:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 07:45:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 31 Aug 2020 07:45:38 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 14:45:25 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 31 Aug 2020 14:45:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8aEz99/KSDTN3nP+QzdPQapQRnBIXBnb8vCGI9M31MXF3uG0WDkad1kAWwm1CmVxHH8HteD6j8FEQOl9ijLktMYnZG0fPPn8lEUVI0+S53w1iFdmndIj7NImb059nzQAsBo3NCc1tGVEwT6hUNpSM+pUZYEnGUGf9pTkvmHhRMtcRhomj52+xwdByrLtq+f80+GE0R8iGCgbuSmsYdocTuc19GHncn3LHWwDDT9vXeFi7N+twW5WhqiRDq5tJRkODm74JhgfbVRhALYAkyK8R7roS/Dm/zpLPKCfxNVQbVtoee41ruRYVdlELnU9N8n96uKOJnEpJFE3fzNSxYCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+p2OQ+w2QhUZpZuQpXKjZgwmQFPfbqx1uP3RMVBpyL0=;
 b=X+9c4RuiTxpBM5hk2MMVLll5zGTdb6clIQrB0PkpfY659OO/BMYbY96QRZGKYQ55teCTx71lIyZVX/B9ajFX5hMyay/uqZLmfvPIZcYHo26Tk4FxlrqTWA2ZilzzSMFlu4Fvob/l+osP+Gx20+VuVTSnot4WRvKeZTcboeeKJR3yPezGDrBtmw1jS7+t7ZULDRYyuLo9kcOJi4OdH8MzcEM32MMHYFQnlFJXmPB/axy1fFPFJzM7O4QI0udRVUUOt6spcqkS2w1276VZfzatK546JNQ2Q79Speun9PiRbZ9YbKEGBkJfVNE5rlsYG7xzdyyMbM4TwC4GWzxSVocyCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Mon, 31 Aug
 2020 14:45:23 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 14:45:23 +0000
Date:   Mon, 31 Aug 2020 11:45:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        <iommu@lists.linux-foundation.org>, <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Jon Derrick" <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        <xen-devel@lists.xenproject.org>, Juergen Gross <jgross@suse.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Megha Dey" <megha.dey@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch V2 46/46] irqchip: Add IMS (Interrupt Message Storm)
 driver - NOT FOR MERGING
Message-ID: <20200831144522.GB1152540@nvidia.com>
References: <20200826111628.794979401@linutronix.de>
 <20200826112335.202234502@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200826112335.202234502@linutronix.de>
X-ClientProxiedBy: MN2PR19CA0007.namprd19.prod.outlook.com
 (2603:10b6:208:178::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR19CA0007.namprd19.prod.outlook.com (2603:10b6:208:178::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 14:45:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kCl3i-002PjF-0q; Mon, 31 Aug 2020 11:45:22 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34d1efa2-a3dc-438a-e1d4-08d84dbc7db6
X-MS-TrafficTypeDiagnostic: DM6PR12MB2604:
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR12MB2604F9D0B465248648069424C2510@DM6PR12MB2604.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zCS6biWS9VderdeY+wH9rdyhIsNx8cPd5mDZyttorDH9HE8IU1t3M3X54HQFRhAxON6uPZxNflD3rIr68MZX3x2onBAnBi86TSnJOmz+UppBW//iLQ50Uw5Qs4ZoDt5YzgPis8+RzhUTILJYW6y7y6+gPzmJuyCQR9e76valPJK+5kpYwXzXsdcWT9q7gLGneVn7mhw07LLmk+yOXiwA8EODEnkOczWGcQa2ZBIqDDcxObUByjzNrPdjwvFan6tArqxqm721H2HQKTkIQnGdU4BeS0xS3nrUtrqvU5bq3F44tDH2q9FJk7e3bU4lajJYAAsGV5sc78f3qShodpuEAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(66476007)(54906003)(478600001)(15650500001)(4326008)(7406005)(7416002)(316002)(2616005)(86362001)(426003)(36756003)(5660300002)(6916009)(2906002)(8676002)(8936002)(1076003)(83380400001)(9746002)(66946007)(26005)(66556008)(186003)(9786002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +qyXgxD1DXXhF03lH7eERw6H2hiqfVqnhGDtV4+HZ+KGkTKvQex1mI0vEvkeK6WWm0ngjcCHER6DlLQuiEhYasba9uuWobwgU2Os52tDWfF1wEKIrZEWPpM9OhUPYb9rQA7Q0VfuNBBgVcA30YlsKbU19A7yW1wiWaZ933p8cPayxevSpK4viSQhEyT5tTlpPPO5weeJVoN3rN80miASm86GurA30fE9n3pRgy2Xpb0HW+dSAWHcp3rCJy5wrvUy0T92NDcu0aIwybEOlhUtIoC3mrUBxvq10Pw//L7+JdnkEdGwl1hReDkdWreJchC5r1oNPDyHPyiRsf/n2PGIUI4pSQX+cB7OxvBEOdp7jRH06m2MHoqBNKr1QeeYAuzwNBRM1oeGLArL2O6ZAR8yjOzWLqRt19F/dXsaoslKcoLAgkNpep4sDt46x+ETHgBBkvUosBojp+F4giLhyNlKHKzXyaB4JNxb8EWYsGRx7f1XtRx4XpqmywoPc8DOvpKabzIIOWBUcEDQaxi48tuVJglGUSDySuQ49yGnw2VkLp1AFLURKYqDZh2eL2TdPRndrjLklq/pRuQ8YvqZjUfvpdTHtdLRccKhX+2j1Jw0uOtbyE5VTiMSWO3LS9voNw8LOaBzld4SA7OftR3UUTtQ4Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d1efa2-a3dc-438a-e1d4-08d84dbc7db6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 14:45:23.5590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNW30hTXDkdTmfm2UvOp/Z0PNtKBr2eZ6W7xuJUX1Zpo+BKR/sIUrXkBjEt7sbhz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2604
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598885093; bh=+p2OQ+w2QhUZpZuQpXKjZgwmQFPfbqx1uP3RMVBpyL0=;
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
        b=J3A7OgaPYJU6BiUW6BeiDJRQBAYMW9TTbtmeff/BGM3gXUSa+334cFooX+4CK1OGV
         sQyE9mMd9FPYBalDnBTKhMTvnW3bdpHf4n4ZusW98fyI8FzzvL0KKTPim2PeTmvpX0
         grwFwwkj4tmlydfpaXYrWQZ6el5SOat3Fg+SLBPEUJu8mcEYgbHuxvaoLfEWdb3d9z
         +ZOByyz9BwOUsmpxQcaynz8T4UHU3CLx/Znd33Vv2Uzfuaev5+D3vINal2JYw/R3d5
         TSt7XIF3vVHsApj0GpGH5Le005XQc5F99xNpYAccUQvREHGDZwx80VlHnS+Rk6bcFu
         Tg8E9rT+0GhkQ==
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 26, 2020 at 01:17:14PM +0200, Thomas Gleixner wrote:
> + * ims_queue_info - Information to create an IMS queue domain
> + * @queue_lock:		Callback which informs the device driver that
> + *			an interrupt management operation starts.
> + * @queue_sync_unlock:	Callback which informs the device driver that an
> + *			interrupt management operation ends.
> +
> + * @queue_get_shadow:   Callback to retrieve te shadow storage for a MSI
> + *			entry associated to a queue. The queue is
> + *			identified by the device struct which is used for
> + *			allocating interrupts and the msi entry index.
> + *
> + * @queue_lock() and @queue_sync_unlock() are only called for management
> + * operations on a particular interrupt: request, free, enable, disable,
> + * affinity setting.  These functions are never called from atomic context,
> + * like low level interrupt handling code. The purpose of these functions
> + * is to signal the device driver the start and end of an operation which
> + * affects the IMS queue shadow state. @queue_lock() allows the driver to
> + * do preperatory work, e.g. locking. Note, that @queue_lock() has to
> + * preserve the sleepable state on return. That means the driver cannot
> + * disable preemption and (soft)interrupts in @queue_lock and then undo
> + * that operation in @queue_sync_unlock() which restricts the lock types
> + * for eventual serialization of these operations to sleepable locks. Of
> + * course the driver can disable preemption and (soft)interrupts
> + * temporarily for internal work.
> + *
> + * On @queue_sync_unlock() the driver has to check whether the shadow state
> + * changed and issue a command to update the hardware state and wait for
> + * the command to complete. If the command fails or times out then the
> + * driver has to take care of the resulting mess as this is called from
> + * functions which have no return value and none of the callers can deal
> + * with the failure. The lock which is used by the driver to protect a
> + * operation sequence must obviously not be released before the command
> + * completes or fails. Otherwise new operations on the same interrupt line
> + * could take place and change the shadow state before the driver was able
> + * to compose the command.

I haven't looked through everything in detail, but this does look like
it is good for the mlx5 devices. Looked like it was only one small
update to the set_affinity, so not very disruptive?

Thanks,
Jason
