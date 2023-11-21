Return-Path: <linux-hyperv+bounces-1005-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77867F355F
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 18:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E2EBB21973
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 17:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA51F5B1F0;
	Tue, 21 Nov 2023 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="otZ9MAoZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1327018C;
	Tue, 21 Nov 2023 09:56:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHS+d/5garJjA9tycGGRo2iUwW7y1IkKjLv/2w7yvlpl6dx7KRibD2CXrtTLh8xb/730JdBSIbSBmKauuW0EAHrkV1tkKpvQU/jtQhYWwxyam0jnyXJ/8OCH7zM3OFXB5g7laPiIE1hFrMBfXDjbQyK3xl9lMCKAICRaB4YZKKXtKPYITjyOym6frnSXNebZ9QGh7r1Kf4FMOwujdqZJtvYEoUbkY0nesrP56asp/EZOeLsTw5np2TEdszDdBM+iqO5kAqww7jsxWSQo/KY41bk30ZaUlqAmth5LOeVehEZHxeWsjoO3PNFXeMRq+ivDkphUf5lwxNt9TsncQbEk/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FEqS05tcKSETAesiKydF2A0kCrLobMr7WLHhkTnqGc=;
 b=S5zvtbc+UZ8fcsQvSlk0wzA5E0DVIl1klQsfr5Saw7UrOSUuNfb6j2VVdzdTO/U1kt0bmjZhWy2acVy82vUWWz8oUDcUfeoGm9C6gk715Keao3R9Nw2tzRw3izCJhvCNkvLUhvtMRsAbzW1Zvyrx+4UmpDUnDNpazq+vFXXPM19SYBYQSv/uCdOoAuoryH5qyd4gyet+dzajEyhdEYA8BfaRsrSxH5wSKSAxozBi/I93ZRfkIkv91sOY/oGFhHhzGHg2B3pakRrsKZHXAR2ZQm78hCEcwlklB4WFTy+4VZICPFS28Kh92FYnKc3mYHaYLOKIFr2S/VeseQZIDhJhsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FEqS05tcKSETAesiKydF2A0kCrLobMr7WLHhkTnqGc=;
 b=otZ9MAoZ+wGR10wOcYTIVyod1ifnN2qeRlLnI39njmrJaPll7Wc/84kwLDzovqsfpjlzlxcpop3fWcy4GD4f2B8+7GzFYLtGQva1X6AZ/pe0eoKMO9ZkQTvYQ16/X+0I1OzPFtAMi7jJXQkRAqooOUsV2ERr8uEefzVWE6VW5AP3sZB03ASvyCFgp0OR1416Jf25rqCFdSWKQzu5CNOltAN6iall4tFDKWBLP0OeQAZvy/jcAzHuRmbhWILURFMDDeWo+LsFJ5zgHkS1cl1TPuukRg6IkJB22Ehhei6jijllEGOqCdyy8o6RVe3A1PHP1OAG8Xrpa3FoFV8x3Z0m9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8234.namprd12.prod.outlook.com (2603:10b6:610:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 21 Nov
 2023 17:55:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 17:55:59 +0000
Date: Tue, 21 Nov 2023 13:55:57 -0400
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
Message-ID: <20231121175557.GH6083@nvidia.com>
References: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
 <1316b55e-8074-4b2f-99df-585df2f3dd06@arm.com>
 <ZVTlYqnnHQUKG6T8@nvidia.com>
 <6442d24b-6352-46e9-89e0-72d4a493f77c@arm.com>
 <ZVWXvqQbZrwyEgrL@nvidia.com>
 <e926d2d8-8209-4c0f-a0cb-dcea4edf839e@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e926d2d8-8209-4c0f-a0cb-dcea4edf839e@arm.com>
X-ClientProxiedBy: SN6PR2101CA0024.namprd21.prod.outlook.com
 (2603:10b6:805:106::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9ac0aa-7b6a-4554-1b82-08dbeabb1e2c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4516iVBTk9XTO4g7K4YkX/NJ4oz1l1XpLiMOsTVMAJUtQttgcf4AXXRY2y8q6HPE9bt1vJZx0Xk7HE3Dy5zvAeRa/lqn8lT73ZMDLp8RzWQsGIzIOCBe1IWRqpkhPSwzkya1LC8jl+A0o3bFbDd1pEXUV9Gz2UE12k6i3VaoGGiP8b2aR2xugtXIpEiiJ5mKqmR/6tkLl6aV9HvNv/+W0ezwGrOIKS41eU79yjoXHQZEW5+ZJUE/2X9rOQ3snGm5Na3AuZ87m5ygoIQ+Y0e2T/pk8CvjouffqJ85Gy3qfeMSo0hc4/PyYF/u/+1csB2hKNTNByHYG8r50FFmhmk/oxZSplnFP5KqX+16bOlx91Y0X+8EvZ5LHoDAkeFGia6m6qBNC5Z1g/eLb4FrrCxfq7CAu4yT7bjDU2+vuUz/esFLbqbTSQZWLCxpxWqP2Yu/L8ily09T16CU2AtvbB/fiotKecm93cNuqSEkJoxHZaZEqyxJ4d5MA07NLZeuS8D4TM2xjepPvE7aC8G3Jh5diU4TLJiGSSoT8gRT7+Gx2lrLDzTh3a7hDkps5EeY0wXx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(86362001)(36756003)(5660300002)(2906002)(7416002)(7406005)(7366002)(33656002)(2616005)(6512007)(6506007)(6486002)(83380400001)(1076003)(478600001)(26005)(38100700002)(8676002)(66556008)(66476007)(66946007)(316002)(6916009)(54906003)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jwuf2Eyhp2WrtTAshCZC2a8eir4ughoneR/XNOWt5XEvtdpjQ7k9yoIj7Y/j?=
 =?us-ascii?Q?Xfsx3NBKhZKhryiZvhAra0VoQPPrnbXgdq2D1NMlwP41IHivAkqQAPH/kRFn?=
 =?us-ascii?Q?//FCn/Z6WFtv0uQm7i0Qf4u+3QJELznhXjzCFp5n/fWrxxL/K2ftFbrqgz9j?=
 =?us-ascii?Q?A9uU1Poy0xbIU8Q2PdN1QDcsFJi3m2TmS7flwiyw1ic9THIz69wPwe/aWBo4?=
 =?us-ascii?Q?Js4olT+BPdLGwLfmb915z4BdLapmon22t/PqoyzB/4kNy6e0Cs9WAl+C5TR4?=
 =?us-ascii?Q?uTq3D0PEhwyuUgk1EYBCp2U7O18H8SB26uDYb1S4UAWQu375x3GMYTfejuMW?=
 =?us-ascii?Q?tYOF4lo7T51CtjilAG9iUf2DQfqDMfta0tyTtdA2xCxmrHFFm+VaECmoufA1?=
 =?us-ascii?Q?cg9eLl9GYR7cYPdICGulscy5azbVgo76IxJozZLg5rnWV/WyArYpZhi7842Z?=
 =?us-ascii?Q?49O+c5xJAJfeZnZiIH0X854jt5n0c45ss9WU4EJYr9BC8oPK88aDWJTgcBGv?=
 =?us-ascii?Q?pbFRTe7YxPXEelhPKs5Ej7YW22vJHbdDPLgAABXt5Z7AO/RdpsenqNFasF0p?=
 =?us-ascii?Q?+UrsqRzlRn5+jzM2VWemV7MA1myHq7a9k2Kf11+14+1jfY8P99cIMEpXvqVn?=
 =?us-ascii?Q?0Gp2+WTbDtoIx0YuTI+gokb42C9GcwHYirFtm/ihl+gEb0AgJJ08Ylzv48sl?=
 =?us-ascii?Q?wfevvjjuJTFhDzJEx3NDZFjhZEQNz2BT7n393M2xL+PSoO9NzxEJpsUswdV8?=
 =?us-ascii?Q?hBhqBvqiYVt05pk1orf626grTfcsgEg9fL2waAKwhzLdMSMBbNH0h27/lATR?=
 =?us-ascii?Q?VFUtd7YfDw1m/thE9AOK/cI+wDv0BPSBOHB7WMFvceXDvdOsZZPJk4ekmU+z?=
 =?us-ascii?Q?u2AikokyNCEXRc/e2fhb0spyLaTWBiuljhwCKEw/a/TZ3Yh0xJtXQS24UgnU?=
 =?us-ascii?Q?RiSszFaVN6duAVOD99YhE+pX81cdEou7LDWQwqdtSKm/9Fdf3U3/rcdK3sTW?=
 =?us-ascii?Q?vaGZuPYahaHu4ss9U4FvjdgVK8dZfaLmYTj+Eu3mmKbDvlhYHngeKIdsB3UH?=
 =?us-ascii?Q?lOiuQXAFC4CvvMpz+fT9cgNXFnY/rP+VYDWVgOaOKbmaD4lCTL1JEnytBcXH?=
 =?us-ascii?Q?fJ7SQ2WjGPG2BTyQ5ysyATGRizZCTMSjnSABy/QQqHEhwodWxUyNCS85xA1z?=
 =?us-ascii?Q?mgKgMSk9MJFb23IlzX99IOIR/8laI6T9gbzxlAtaqAvCB+nU2V+TSjb59/GH?=
 =?us-ascii?Q?puH+kvWGqqbDoH1JpRgpAK0sHpepZiIjnAtaaOLFuZLniDbX3BuDnRFaeHjD?=
 =?us-ascii?Q?qFkt4ng8IbN2paG1Mi5tahsJxrtC2mWynqwaQY1G+3xhV0nJfrbbSQwrJfp+?=
 =?us-ascii?Q?hrCK8LRO7BFs3eyKvd808vhVyevS1y89mLfDUS5ugTjuOKoRI7Sa4NesGLbA?=
 =?us-ascii?Q?1pNUowStYpUCS68VOJwMgaiGogqYKQW2zZAWFGLOVQdZ7hpGLestSwfoti7E?=
 =?us-ascii?Q?/lyDy6Xi4iC0fXnso1w7+B2/F6lJCkdvFrPCSSMEBu4vxuOxp7LhXCQJfXNX?=
 =?us-ascii?Q?279dfWQaddSSPrWNtiyC5OTtxpKbYZfoCb2qyrp7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9ac0aa-7b6a-4554-1b82-08dbeabb1e2c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 17:55:59.1618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eL/+EzQy8lfOrtxymobKXKkbh6sigqfxv/CuHPdLYUZA6DYEqK/D55rFWL7PA2Hf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8234

On Tue, Nov 21, 2023 at 04:06:15PM +0000, Robin Murphy wrote:

> > Obviously. I rejected that right away because of how incredibly
> > wrongly layered and hacky it is to do something like that.
> 
> What, and dressing up the fundamental layering violation by baking it even
> further into the API flow, while still not actually fixing it or any of its
> *other* symptoms, is somehow better?

It puts the locks and the controlled data in the right place, in the
right layer.

> Ultimately, this series is still basically doing the same thing my patch
> does - extending the scope of the existing iommu_probe_device_lock hack to
> cover fwspec creation. A hack is a hack, so frankly I'd rather it be simple
> and obvious and look like one, and being easy to remove again is an obvious
> bonus too.

Not entirely, as I've said this series removes the use of the dev->iommu
during fwspec creation. This is different than just extending the lock.

> > So, I would move toward having the driver's probe invoke a helper like:
> > 
> >     iommu_of_xlate(dev, fwspec, &per_fwnode_function, &args);
> > 
> > Which generates the same list of (fwnode_handle, of_phandle_args) that
> > was passed to of_xlate today, but is ordered sensibly within the
> > sequence of probe for what many drivers seem to want to do.
> 
> Grep for of_xlate. It is a standard and well-understood callback pattern for
> a subsystem to parse a common DT binding and pass a driver-specific
> specifier to a driver to interpret. Or maybe you just have a peculiar
> definition of what you think "micro-optimisation" means? :/

Don't know about other subsystems, here is making a mess. Look at what
the drivers are doing. The two SMMU drivers are sort of sane, but
everything else has coded half their pobe into of_xlate. It doesn't
make alot of sense.

> > So, it is not so much that that the idea of of_xlate goes away, but
> > the specific op->of_xlate does, it gets shifted into a helper that
> > invokes the same function in a more logical spot.
> 
> I'm curious how you imagine an IOMMU driver's ->probe function could be
> called *before* parsing the firmware to work out what, if any, IOMMU, and
> thus driver, a device is associated with.

You've jumped ahead here, I'm talking about removing ops->of_xlate.

With everything kept the same as today this means we'd scan the FW
description twice. Once to find the ops and once inside the driver to
parse it.

When I say micro-optimization this is what I mean - structuring the
code to try to avoid multiple-scans of the FW table.

Once the drivers are self-parsing I see there are two paths to keep it
at one FW parse:

 1) Have the core code parse and cache common cases in the iommu_fwspec.
    Driver then pulls out the common cases from the iommu_fwspec and
    reparsed in uncommon cases.

 2) Accept we have only a single ops in all real systems and just
    invoke the driver to parse it. That parse will cache enough
    information to decide if EPROBE_DEFER is needed.

In either case the drivers would call the same APIs and have the same
logic. The choice is just infrastructure-side stuff.

It is a different view than trying to do everything up front, but I'm
not seeing that it is so differently efficient as to be a performance
problem.

On the plus side it looks to make the drivers alot simpler and more
logical.

> And then every driver has to have
> identical boilerplate to go off and parse the generic "iommus" binding...
> which is the whole damn reason for *not* going down that route and instead
> using an of_xlate mechanism in the first place.

Let's not guess. I've attached below a sketch conversion for
apple-dart.

Diffstat says it *saves* 1 line. But also we fix several bugs!

 - iommu_of_xlate() will check for NULL fwspec and reject the bus
   probe path

 - iommu_of_xlate() can match the iommu's from the iommu list and
   check that the OF actually points only to iommus with this driver's
   ops (missed sanity check)

 - The of parsing machinery already computes the iommu_driver but throws
   it out. This forces all of the drivers to do their own thing. Pass
   it in and thus apple_dart_of_xlate() doesn't need to mess around
   with of_find_device_by_node() and we fix the bug where it leaks the
   reference on the struct device (woops!)

 - We don't leak the cfg allocation that apple_dart_of_xlate() did on
   various error paths. All error paths logically free in probe. We
   don't have to think about what happens if of_xlate is called twice
   for the same args on error/reprobe paths.

Many drivers follow this pattern of apple-dart and would end up like this.

Drivers that just need the u32 array would be simpler, more like:

   struct iommu_driver *instance;
   unsigned int num_ids;

   instance = iommu_of_get_iommu(..., &num_ids);
   if (IS_ERR(instance))
      return ERR_CAST(instance);
   cfg = kzalloc(struct_size(cfg, sids, num_ids), GFP_KERNEL);
   if (!cfg)
      return -ENOMEM;
   iommu_of_read_u32_ids(..., &cfg->sids);
   [..]
   return instance;

I haven't sketched *every* driver yet, but I've sketched enough to be
confident.

Robin, I know it is not what you have in your head, but you should
stop with the insults and be more open to other perspectives.

> > The per-device data can be allocated at the top of probe and passed
> > through args to fix the lifetime bugs.
> > 
> > It is pretty simple to do.
> 
> I believe the kids these days would say "Say you don't understand the code
> without saying you don't understand the code."

I think you are too fixated on what you have in your mind. It will
take me a bit but I will come with a series to move all the FW parsing
into probe along this model. Once done it is trivial to make bus probe
work like it should.

Regarding this series, I don't really see a problem. There is no
"concrete" or anything like that.

> > Not quite. This decouples two unrelated things into seperate
> > concerns. It is not so much about the concurrency but removing the
> > abuse of dev->iommu by code that has no need to touch it at all.
> 
> Sorry, the "abuse" of storing IOMMU-API-specific data in the place we
> intentionally created to consolidate all the IOMMU-API-specific data
> into?

The global state should not be filled until the driver is probed. It
is an abuse to use a global instead of an on-stack variable when
building it. Publishing only fully initialized data to global
visibility is concurrency 101. :(

Jason

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index ee05f4824bfad1..476938722460b8 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -721,19 +721,29 @@ static struct iommu_domain apple_dart_blocked_domain = {
 
 static struct iommu_device *apple_dart_probe_device(struct device *dev)
 {
-	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
+	struct apple_dart_master_cfg *cfg;
 	struct apple_dart_stream_map *stream_map;
+	int ret;
 	int i;
 
+	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
 	if (!cfg)
-		return ERR_PTR(-ENODEV);
+		return ERR_PTR(-ENOMEM);
+	ret = iommu_of_xlate(dev_iommu_fwspec_get(dev), &apple_dart_iommu_ops,
+			     1, &apple_dart_of_xlate, cfg);
+	if (ret)
+		goto err_free;
 
 	for_each_stream_map(i, cfg, stream_map)
 		device_link_add(
 			dev, stream_map->dart->dev,
 			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
 
+	dev_iommu_priv_set(dev, cfg);
 	return &cfg->stream_maps[0].dart->iommu;
+err_free:
+	kfree(cfg);
+	return ret;
 }
 
 static void apple_dart_release_device(struct device *dev)
@@ -777,25 +787,15 @@ static void apple_dart_domain_free(struct iommu_domain *domain)
 	kfree(dart_domain);
 }
 
-static int apple_dart_of_xlate(struct device *dev, struct of_phandle_args *args)
+static int apple_dart_of_xlate(struct iommu_device *iommu,
+			       struct of_phandle_args *args, void *priv)
 {
-	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
-	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
-	struct apple_dart *dart = platform_get_drvdata(iommu_pdev);
-	struct apple_dart *cfg_dart;
-	int i, sid;
+	struct apple_dart *dart = container_of(iommu, struct apple_dart, iommu);
+	struct apple_dart_master_cfg *cfg = priv;
+	struct apple_dart *cfg_dart = cfg->stream_maps[0].dart;
+	int sid = args->args[0];
+	int i;
 
-	if (args->args_count != 1)
-		return -EINVAL;
-	sid = args->args[0];
-
-	if (!cfg)
-		cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
-	if (!cfg)
-		return -ENOMEM;
-	dev_iommu_priv_set(dev, cfg);
-
-	cfg_dart = cfg->stream_maps[0].dart;
 	if (cfg_dart) {
 		if (cfg_dart->supports_bypass != dart->supports_bypass)
 			return -EINVAL;
@@ -980,7 +980,6 @@ static const struct iommu_ops apple_dart_iommu_ops = {
 	.probe_device = apple_dart_probe_device,
 	.release_device = apple_dart_release_device,
 	.device_group = apple_dart_device_group,
-	.of_xlate = apple_dart_of_xlate,
 	.def_domain_type = apple_dart_def_domain_type,
 	.get_resv_regions = apple_dart_get_resv_regions,
 	.pgsize_bitmap = -1UL, /* Restricted during dart probe */

