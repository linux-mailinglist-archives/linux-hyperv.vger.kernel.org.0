Return-Path: <linux-hyperv+bounces-970-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1861D7EDAA5
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Nov 2023 05:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914B51F2351D
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Nov 2023 04:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BE5C2EB;
	Thu, 16 Nov 2023 04:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dKTqvM2Z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E1C19B;
	Wed, 15 Nov 2023 20:17:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCh4ghWpoxxDpfXH/OXoTQm1wuOkCU4n+xSS3+bRkGF/d8HYOGBYv3whN5qvHq/iG2COGknXg+TAT3bFkYu6+uqe0EboASZ9bN88k4/kXmfAOs94p2sJaDIddXWyHFsh5ZZDaF0H7Dx7CUSyPpJDR9Q7Au3ZSj8nJE05D6jfpwh+/uZiUmclNhK0bqmpdOXdBHd4Q7MBuAsXZO/ZwHutC65b7lM0XCgSMD2m9LaBKJL4x4xLW7UVnMHYAfN9LLASoNT58vqoDe0EOlbmZAHNy9McsbPp44PQjsMCcANNbIus3xKnKEm2CnhN5HjCvQWyOiFrBv3JeUU6sIxB6+LHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwk6v4yjIcM6+g74WhFxW5FlxoElibgLQqeTLgQpX3c=;
 b=C9l1bRfaG93f9A9t8Uu61fTMPdoDtvxSYU7PJr89SQfTdDqTJ3DbwGhaIxZpaVj7jQJ92LC6xo0UqnU05VZnOC6QfZzY3Xo6wiQEHS0PoQQ96f4kfj6qyZD6j3ii/1+SbFBgSOYzfzZ0gbsL1CPEoEas0G7+Pby+T8RN1svot24u6C928Nsq49eALID4/RTlF1FW4bRreuamXJNt/GZeLLMMG2yJkp7DmGexoL8MztzoXD+eAuj1vP77JeGYlOg6/Wbz85cQbKvMHDNpLJC5c+M4yqcqdstwCdOHNfI1uoP53YdYRXRPtCwforsjWPUbQyZyld+kmt7cMKmgdPfQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwk6v4yjIcM6+g74WhFxW5FlxoElibgLQqeTLgQpX3c=;
 b=dKTqvM2Z34r4stLFgHge6Enn1oM6RqoAZlKjyuUVl9AtqoGp6jHpkzRQWVOM8vR66Y4o/pqXOtp1nv7aFqa6lJHCe4c/IJTpXO3tsDLi4dlnjOM7WapvkkfQ6H8Efa/S5wy6Oz79ZRINXj81QSl9oC5J6G+045BsfBQYJy4VB/YrOkCQM6HzfKlEUlM2glI1UgSlhNBW2wbkqADc6q046n/wY/TAxhaxe7edPEbTWZ/sMHVBm9Zr5oOuXaMHOLWXqhsptHiVVe+1wYBv52ZivrRMtA5qbAMSgH9P3eZBC7Sb2T3E4ZdCK00ekRP8l6ZzXvZ28x+4OrLQctDg6A5I0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB8037.namprd12.prod.outlook.com (2603:10b6:510:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Thu, 16 Nov
 2023 04:17:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 04:17:14 +0000
Date: Thu, 16 Nov 2023 00:17:02 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: acpica-devel@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, iommu@lists.linux.dev,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org,
	linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Hector Martin <marcan@marcan.st>,
	Palmer Dabbelt <palmer@dabbelt.com>, patches@lists.linux.dev,
	Paul Walmsley <paul.walmsley@sifive.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Rob Herring <robh+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Sven Peter <sven@svenpeter.dev>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Krishna Reddy <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>,
	virtualization@lists.linux.dev, Wei Liu <wei.liu@kernel.org>,
	Will Deacon <will@kernel.org>,
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Christoph Hellwig <hch@lst.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 00/17] Solve iommu probe races around iommu_fwspec
Message-ID: <ZVWXvqQbZrwyEgrL@nvidia.com>
References: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
 <1316b55e-8074-4b2f-99df-585df2f3dd06@arm.com>
 <ZVTlYqnnHQUKG6T8@nvidia.com>
 <6442d24b-6352-46e9-89e0-72d4a493f77c@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6442d24b-6352-46e9-89e0-72d4a493f77c@arm.com>
X-ClientProxiedBy: MN2PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:c0::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1db023-ccf9-45b3-d00c-08dbe65ae978
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lVQAaSJxOa9Y+wxq+iGs9/ynNibtC1KERYDcBASi4CJa0a3U/Jaly+Dq16viQM1kpJsOgVyqIbWCFXqb60Usx6ALJkuS3vJp4g9Qh6F/ifEDVvuutjkwest0V7a7IhZBvrjFqn/Ft1xy2K3VXfzbCVVcP3xZGJqVfGGOYsgsOunrcjMC+zOcMri0NeeP2Oi8T2KPyndivn5/z1ccw506552I/UpCk8uJtA0nHokZDKEHYdtCjo3s09MGYuJ0AKwiNwClGejMChS8HiJ5LmC5qO8Xavvvtx0Hhh1ble0gV5sRKMcONxxRHGjvVp/K7VMsIPopCs+3hx+gQLrhm1gtNLNc44A4cgifP9K1RkBMZ4qt+bFrNOR4s7JozWvK7Y0/zsxcNayhfIbEAju2FYmMsJMgzzfsqpOna8zhVT/I9vsoFlHrwyfhB1NgMa7LCzU8iFY3ToEl0LXzll54ATSngIiKBCFlc7tN6slgaQqt28cvGtX+e1ZnmFilymBPnZVwmvP42SG+UtMLDiVvIwKgOyR0/2b+xwerZIZgjK6PiS6Oe6tRptAXoYGoTEHCA7cN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(6666004)(53546011)(38100700002)(83380400001)(7416002)(2616005)(6512007)(86362001)(5660300002)(41300700001)(36756003)(4326008)(66556008)(66476007)(54906003)(66946007)(7406005)(8936002)(6916009)(8676002)(316002)(7366002)(478600001)(26005)(2906002)(4001150100001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r/ZJoDxml7DIZUuduUgXv0i/oD8wLR3nOMvRjSmsIQcymphXKc2kV4DhjXGA?=
 =?us-ascii?Q?hIuao+lg+LsZ+noMgu6bn26H7Ha+setr74BPYkIlfsimiziYqeKuiXo4E9jp?=
 =?us-ascii?Q?ho1ruQ6vESwtVr7y+CoVhujCP7AS4JXvGgyuqrnW2YrIX/cXbHfIty8UXrn9?=
 =?us-ascii?Q?SBieqIILJSkUIGEOTK9mweUGASSA3dWEM03rbhUKjxfa1c+jrV+HPAP4C+/z?=
 =?us-ascii?Q?gwgVumE6beeNe7rLVAy5Xzgmw29oF50POtBRLI7dPwvTsxO5+xCb7tz86c2U?=
 =?us-ascii?Q?e5jHgymHLJgg/gMAKH/d1xUkFQ/IZICASFn485ywSw6L7c1qj1ak/OEAetX3?=
 =?us-ascii?Q?s7Oe2DKvd5TSTk4QGJXWfV7FE1gW9Y35BKkawyE+YcP32PQbKKXhj0DY+wGw?=
 =?us-ascii?Q?9qR10Pctkwu8qqC5XZK85VbUiGrZruwMzIiBcn/cJ432BupTEbmEuf9RwBE2?=
 =?us-ascii?Q?cqsE0iCHmrz//zRkeHSC8MOAQy6Ew+danafZr2YP2Oa8jtN3CssRM0ZOae2z?=
 =?us-ascii?Q?UrKvho3ibpS6YK6Iu6J4oCwdYv6nqfCk7YFOLDg7gpyc9vZBk/OHFQAfJHmU?=
 =?us-ascii?Q?yGnLrYPhnWpE5GbRdBchV6gQmN2ZSnitP/5fzoD2SJROMcpx5DE2YC9ChMRz?=
 =?us-ascii?Q?hZPx8L9pnmiwJvJxFARnyDm8/k/cfx0Q5APHM6ilWZCMI9lX0lcfe6isUOh1?=
 =?us-ascii?Q?JMmDK3oDuSoXGjGDs1CC4wzel9+QN89msXvpDRLauoACPKeGOAW7tX7KAEOr?=
 =?us-ascii?Q?ZJVulbr4Q4ehJJHAMpXKf+8K72ptAGAwsLKwhW60x9Lf4HaPSpPwSxHltAI+?=
 =?us-ascii?Q?j3cX9ttk5FcOvsJqXwaDkyhfwx/3pXStPyuu8Z6R6JuSuw14BsUzGYE9YqOX?=
 =?us-ascii?Q?FUjcU6qjFVQjkGuJxepPBPFVC3gUDswPllVcj9hNLYQX51pJhyQsvE3iv1zZ?=
 =?us-ascii?Q?9eME7tFfnpezTw/jxOvN9DStu/TCpgImyjEMLt67qnmSXF7nvg9b+ALtOMMg?=
 =?us-ascii?Q?FELFCHJQzUPFnSOejup36nzm1Ld4iLcTDanL1pd5GGxsBTqoQGMGePWCKMbo?=
 =?us-ascii?Q?/T/RcdKhL+XjnCGbHx+rv/Ikckn10Mi1A/WgdzukLldxWUc/EAN9zFdugHOo?=
 =?us-ascii?Q?CI1d8YVajqnWzPXuCoxlajWXEEQQlJdG2ZsPObywt94AGMYiUdSw17RmQfFx?=
 =?us-ascii?Q?+2QF/M4ozvWV0nHr+yMo9uch6eYpyIFpWXdWXCRQECIHakkkUg8e69OGxChR?=
 =?us-ascii?Q?2EQ8QWeo+yzOL1TqfHJKQnCnHXh6i/92DCGo4qLMyKwC5tY+nsCUGNHvWDSA?=
 =?us-ascii?Q?v3bkT51EykKCMmL+Tb1raDJh4jqvYFLixvNlaopucuPabQ3C+9itLrGVSbtD?=
 =?us-ascii?Q?vsf6wTEdkGFcFNcQtjmHfK5yPkNZj7agYCZJ3r8kbH6NRXAbSYhEwLTmosEQ?=
 =?us-ascii?Q?QQrZ6/CTbrwv2jYrlIRFy6ihjhnUQrYZ3ScgIWYtEFHs+blPGchv1ZKGhD1Q?=
 =?us-ascii?Q?tv+LZzhqliMOWeW7GMv5hCpxdSeRKgDSSpBBtfwl6XP0IRkrnpHRG1MlO0Iu?=
 =?us-ascii?Q?JHBDdxUB3oevGVjRhlQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1db023-ccf9-45b3-d00c-08dbe65ae978
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 04:17:14.2805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EI8cXB2pwsxwUqpWpH1zeVzza+PtP0Q/ZJx2dIH55DhIyNBLhmPFtd+SA8cHiks6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8037

On Wed, Nov 15, 2023 at 08:23:54PM +0000, Robin Murphy wrote:
> On 2023-11-15 3:36 pm, Jason Gunthorpe wrote:
> > On Wed, Nov 15, 2023 at 03:22:09PM +0000, Robin Murphy wrote:
> > > On 2023-11-15 2:05 pm, Jason Gunthorpe wrote:
> > > > [Several people have tested this now, so it is something that should sit in
> > > > linux-next for a while]
> > > 
> > > What's the aim here? This is obviously far, far too much for a
> > > stable fix,
> > 
> > To fix the locking bug and ugly abuse of dev->iommu?
> 
> Fixing the locking can be achieved by fixing the locking, as I have now
> demonstrated.

Obviously. I rejected that right away because of how incredibly
wrongly layered and hacky it is to do something like that.

> > I haven't seen patches or an outline on what you have in mind though?
> > 
> > In my view I would like to get rid of of_xlate(), at a minimum. It is
> > a micro-optimization I don't think we need. I see a pretty
> > straightforward path to get there from here.
> 
> Micro-optimisation!? OK, I think I have to say it. Please stop trying to
> rewrite code you don't understand.

I understand it fine. The list of (fwnode_handle, of_phandle_args)
tuples doesn't change between when of_xlate is callled and when probe
is called. Probe can have the same list. As best I can tell the extra
ops avoids maybe some memory allocation, maybe an extra iteration.

What it does do is screw up alot of the drivers that seem to want to
allocate the per-device data in of_xlate and make it convoluted and
memory leaking buggy on error paths.

So, I would move toward having the driver's probe invoke a helper like:

   iommu_of_xlate(dev, fwspec, &per_fwnode_function, &args);

Which generates the same list of (fwnode_handle, of_phandle_args) that
was passed to of_xlate today, but is ordered sensibly within the
sequence of probe for what many drivers seem to want to do.

So, it is not so much that that the idea of of_xlate goes away, but
the specific op->of_xlate does, it gets shifted into a helper that
invokes the same function in a more logical spot.

The per-device data can be allocated at the top of probe and passed
through args to fix the lifetime bugs.

It is pretty simple to do.

> Most of this series constitutes a giant sweeping redesign of a whole bunch
> of internal machinery to permit it to be used concurrently, where that
> concurrency should still not exist in the first place because the thing that
> allows it to happen also causes other problems like groups being broken.
> Once the real problem is fixed there will be no need for any of this, and at
> worst some of it will then actually get in the way.

Not quite. This decouples two unrelated things into seperate
concerns. It is not so much about the concurrency but removing the
abuse of dev->iommu by code that has no need to touch it at all.

Decoupling makes moving code around easier since the relationships are
easier to reason about.

You can still allocated a fwnode, populate it, and do the rest of the
flow under a probe function just fine.
 
> I feel like I've explained it many times already, but what needs to happen
> is for the firmware parsing and of_xlate stage to be initiated by
> __iommu_probe_device() itself.

Yes, OK I see. I don't see a problem, I think this still a good
improvement even in that world it is undesirable to use dev->iommu as
a temporary, even if the locking can work.

> ever allowed to get it landed...) which gets to the state of
> expecting to

Repost it? Rc1 is out and you need to add one hunk to the new user
domain creation in iommufd.

> start from a fwspec. Then it's a case of shuffling around what's currently
> in the bus_type dma_configure methods such that point is where the fwspec is
> created as well, and the driver-probe-time work is almost removed except for
> still deferring if a device is waiting for its IOMMU instance (since that
> instance turning up and registering will retrigger the rest itself). And
> there at last, a trivial lifecycle and access pattern for dev->iommu (with
> the overlapping bits of iommu_fwspec finally able to be squashed as well),
> and finally an end to 8 long and unfortunate years of calling things in the
> wrong order in ways they were never supposed to be.

Having just gone through this all in detail I don't think it is as
entirely straightforward as this, the open coded callers to
of_dma_configure() are not going to be so nice to unravel.

Regardless, I don't see any worrying incompatibility with that
direction.

Cheers,
Jason

