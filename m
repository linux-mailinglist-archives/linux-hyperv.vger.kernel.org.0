Return-Path: <linux-hyperv+bounces-961-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D65657EC76B
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 16:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E2C1C20972
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 15:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47B639FDF;
	Wed, 15 Nov 2023 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tg/7Jvcr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F7433095;
	Wed, 15 Nov 2023 15:36:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25369C2;
	Wed, 15 Nov 2023 07:36:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+jyNXs2KVEbhrO+ad8UyOLn0iGJzwU+3MIoJumvP+SeoFpspd+CKWx01POprbKNkW2lW+iZwH8vy5ZMWNg5qK0qHb8OmHbkWvjrMARa6LkV81tpj16RJpQ+MbxEvUCp1lpdpVCHjacdeOMhZ0qu8MmCMblAWrGHbGQF0Xa6INkQdatIw5OeNkC9mlWqALx9CalqAJq4tHTsqgEgv4euO26UqVOgBRMg+aFtnXCZ/XAJ+zywr+/tbAEcD2iHvNlH9Ovcq0VLfdgY6mlfyLHLiblsoCqwzvr6bWuXQmio1G+lO2sw0Ynoqft8DMT1mNYolaqnJW4CZzXMHLPH3l1RVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNdEynjYlj699bnc292naIDTMR9TOq3rH4L/DuV5nF0=;
 b=K3imG2kkXEw8k5GHM6WOIZdFw/gU2DSFBbR96k/EndEY4+wWZZ6FWHndcf74I1SXFqM/yHm+EpPCWkEJuauZZNLFvkuITFvjjLkY0nMtgmp1zcYuHCxFn/KYednM6v0+8Zjvu9MbNstzFqtWFHE6M0CL742T3EbYxoUbrg2Np+veMjNdMhFzbnPdiFrAcwNZRFun4Vjn3+U6TITs+mFLTuasS1m+hHnwRcfCjBw0u8ta7jMcL1HpJDXBnomEIuJ0teJc/74xi/Vss41xTheCsdEaqAeP53WOms2Y1UbFJ5ObhT4WEdyeePNlXiEXmA6SewkmW6Ifn9P1Q+LSButmNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNdEynjYlj699bnc292naIDTMR9TOq3rH4L/DuV5nF0=;
 b=tg/7JvcrCdLadHSq4Qn6LFEUP9nSWlscqWB2IBbSu0EmRLMPstI9O9nR2plS5FcOpA8BEo+bypaRMspxqhETAllxZFdl8qAdX+2efG4aZiXjcqWePAvChDxFSkOkGPv4r4etULzUXnLJau+KQAUeYsb+dNTa305gQ5/pAHscFDh1RavEvL4hs8ZYVXjHpO0iNa4a0C4gQqkAUwiu2Yfisc7zCmCK6filnMozpeJ/b4f0oiB7VApwMlAWv8tC0ByLirpyFoxP1b5QpbPPzYv7dRmZR/2/3NZ4L8Gbk4CP0Hgm63o/3mcHJKMrErNqZPA0bYjcObmafT0lIUobDXgUiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 15:36:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 15:36:05 +0000
Date: Wed, 15 Nov 2023 11:36:02 -0400
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
Message-ID: <ZVTlYqnnHQUKG6T8@nvidia.com>
References: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
 <1316b55e-8074-4b2f-99df-585df2f3dd06@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1316b55e-8074-4b2f-99df-585df2f3dd06@arm.com>
X-ClientProxiedBy: BL6PEPF00013E0A.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 3957cc99-c86c-4656-7282-08dbe5f0946e
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lZel8eABbpGPYA6IhmUTpRIgIjypJ4szOW1sT9rBavcYeorkiQnyiJQ3IVJqnXkdYUe06F2UI7NhJz62EGitYHDEgXiRMY3OkTFR3c7ykJ+6sjilaKzWRCY0hH8zsMo19kaJ7c98zf8HarrME5As4pUzRwOJWThXG3wdFtoOEhh0rGPTgCbPViEReJoxmzscJ8xUplvKn9RLoBWeTkIMJy4vPvgEAI+BrcW6JAY3rebAyem5274z51q80n3kSalsvlwRGBOlycOI0T38cFiMyibs0f9hNH2A0slVtgov5Xc+YdS6204+sW3hTYODMhERCX0X1QDLxGndTap+MzE5f3w2YEhSNsmPHgqVcWqKNq2jdLrbl3zJ65KDz3zopz5VKqahB2ZrmPQPVaXuU27dGsx59Xx4a098Ewr0j5QBzIjfkh+IaaocUk5utZXv22HhiNXutFA9+iIO3MI7R8jtMH9L49ovTPKms7q6EwAvgfAPDQrB/bBgTtHy9CIrWkVZeh5ZhaYUExeBC6cNRWUWjmRShwKrTGST/Zn1CAFqw3TqW3AYo7sfI08zbrKoDgU9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(136003)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(8676002)(8936002)(4001150100001)(26005)(6512007)(2906002)(4326008)(6666004)(53546011)(6506007)(83380400001)(38100700002)(41300700001)(7416002)(7366002)(5660300002)(7406005)(2616005)(6486002)(54906003)(316002)(66946007)(66556008)(66476007)(86362001)(478600001)(6916009)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xQ7WcmH+2JjyjAQy5Dd/SaszgKmm2ydPZS+UYOt/lWAa5N1TXS6+BXuafCfa?=
 =?us-ascii?Q?W0NGhI9r2trDzzpU1CBjYD0VBn/nMNMyw3MsSPw+nRGOZSEYTKEtWwtVv1YQ?=
 =?us-ascii?Q?/427KQsdyEDwi8NWGoABGqp6WiS1P0G2mmRgYuyys+TIbODuKeUC4nSlyJAQ?=
 =?us-ascii?Q?EpO7MCj2bPhdT00ZE5o0e9nvqPpU0JXYVF1idGMO1ICegmy78a0yRPNvt82Q?=
 =?us-ascii?Q?9EvHW49tpNlhZDZiIgGbDxXiWjk5RhM6vzVFuuqn6O2OjP2/pSr4Ycw9ienC?=
 =?us-ascii?Q?pg8QgmJI1+Sqs5LfN3g24d+25HgTaTOWtNX4Mp/Ml8ft6QlVvEfsX+F08R2L?=
 =?us-ascii?Q?COjuSMC7ZE5h9KUBVgeTiExkUdPXhI6ZKff8eVKd0w5i0P/xyUqs0j32WNE+?=
 =?us-ascii?Q?wfQIJ5qa/xROHonMP1f/do7ApdeST7rSygdVH6X3oJGJ8XcLHaLYz+JGpH0V?=
 =?us-ascii?Q?a3wow588VtP1+TlYyRkKPr8efPIKaTypvA/g0ZReinoq0KxPpJpPwklyCwuk?=
 =?us-ascii?Q?vcvT5rG5vT16PBr69WgHhgrbMTaDXamBl+MuTBFzRo0lqxEhjikgkqloCOP8?=
 =?us-ascii?Q?WUqNiwHVELFSQ0SCSB28abssTVsNCsqp2XP4DHOdNiI5N4vuhRmo4fjl9zu7?=
 =?us-ascii?Q?MXxDNUv9npe8cP/hzRLmyunDP8ZDh7X9W/GhEquoFtWox4YqZTYAHMPXR8y5?=
 =?us-ascii?Q?qmw8kJwVCFc/iKFjYkB0lLhl++3x0oHizRYKB64u3Wfsfh/D0W32sa9Y93T7?=
 =?us-ascii?Q?pcvLQfefbyJh6WVwxejGL+xCOrS48B2fKjjiOyfBi3dwG4LFJM+I+scdbQcJ?=
 =?us-ascii?Q?bU8DOrZgozSnMe24AVWQ5HkIPaei9jSLtHL+SLdugcteC+W2in5TKhVfZLAp?=
 =?us-ascii?Q?sTi8lW+/tzjYVNkYIfN0X2OajOeYKagv4NDrLNTaQIGvxnqmx7s+oRXWoRT4?=
 =?us-ascii?Q?XCz/7QySWsloWOFq82ct7mxXvcIE2G8ETJvboECchzwJRNCjRXrSDcHG9jKc?=
 =?us-ascii?Q?Hw0kDn6htfTBzbDdwa4Ctuw4oh2+vBp31h1SHTII7YKbjsyfuKQkxfeumXvR?=
 =?us-ascii?Q?eh5NJ83eIA7JX3qog88Kx+rADMe8pHxMQqhO5j+yNoRKtwRnXGl86Vfg9n6A?=
 =?us-ascii?Q?UdwtE2h5Rg8nIkvC4iDTzCHdLwvlplPw2orxywefC/7YZqpXM3p5wrEH45RS?=
 =?us-ascii?Q?Wjz/5cuunoTR9NLfgmN601QL7LxttODSyw5YFgp+aJdHF/advmvx7R3uXc28?=
 =?us-ascii?Q?f4IyBEHfpy0XJgDv0CYZifhZ6AES+Vn5nbonjA7S6A9laUdnhGMAonl2ChFO?=
 =?us-ascii?Q?m+2kbJCiHfZgsuIeBoziqjsVghYtAZJ9oQFMauAYob6IgLNJHJmdsRykhGI1?=
 =?us-ascii?Q?V/xK/hjEL6WpogHivoaOg4/q9ZjVnL/N760eoQAu4rKIn3Xv7j5U3uRDTtG0?=
 =?us-ascii?Q?+VIcGi9lzuGs1HRBbt4xughNIiiAnroAaUVc6iIfIU61+oft2e3CemGG7JAx?=
 =?us-ascii?Q?lnbnRLF26WTFuTMYVQ3M2I/xol2//cva+lNJ+V8FDaqYlG1IItLZNtpsuEzK?=
 =?us-ascii?Q?kr8BYVdtQcJc/KCeKMc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3957cc99-c86c-4656-7282-08dbe5f0946e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 15:36:04.9421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unWruElbHsCpXAlLTcHSHUBRjm0fbejZjo3lk/WLM+HLtY2J8roqGxQxVEwFhZM+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185

On Wed, Nov 15, 2023 at 03:22:09PM +0000, Robin Murphy wrote:
> On 2023-11-15 2:05 pm, Jason Gunthorpe wrote:
> > [Several people have tested this now, so it is something that should sit in
> > linux-next for a while]
> 
> What's the aim here? This is obviously far, far too much for a
> stable fix,

To fix the locking bug and ugly abuse of dev->iommu?

I wouldn't say that, it is up to the people who care about this to
decide. It seems alot of people are hitting it so maybe it should be
backported in some situations. Regardless, we should not continue to
have this locking bug in v6.8.

> but then it's also not the refactoring we want for the future either, since
> it's moving in the wrong direction of cementing the fundamental brokenness
> further in place rather than getting any closer to removing it.

I haven't seen patches or an outline on what you have in mind though?

In my view I would like to get rid of of_xlate(), at a minimum. It is
a micro-optimization I don't think we need. I see a pretty
straightforward path to get there from here.

Do you also want to get rid of iommu_fwspec, or at least thin it out?
That seems reasonable too, I think that becomes within reach once
of_xlate is gone.

What do you see as "cemeting"?

Jason

