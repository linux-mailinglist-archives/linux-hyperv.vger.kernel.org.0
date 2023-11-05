Return-Path: <linux-hyperv+bounces-697-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B9E7E13A8
	for <lists+linux-hyperv@lfdr.de>; Sun,  5 Nov 2023 14:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0ADD1C208FF
	for <lists+linux-hyperv@lfdr.de>; Sun,  5 Nov 2023 13:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8C4C2D0;
	Sun,  5 Nov 2023 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PptQ9B95"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA6DBE7D;
	Sun,  5 Nov 2023 13:31:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F2697;
	Sun,  5 Nov 2023 05:31:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTfmiT+HR9ArAIjFypMl1lIvulPShkcW96J1lrZyEZj3v4GfIAydoQNYBxu2HaKAQspYwYAPBgOOW+B/kH9Wvp7iOGJoakR2g6DZT7AY6Am2lToONw2Fy4zxB6KvQ9rJebw8QecTp7Vs5p50TtSEdZhaf6VQvkGvjagH5L4OV0xRBSxl+Q3yWl/GKtSbMzl1AxsfrhLMT9mZS8d46cHlbkj6B6iLprr/a+htXUOE36mQaCJymC/zsRpCKCgd0dNsMZQZgD+Ll7RqhC7BuMmPWUYlPSn9fyZXUyjkpM+lAq4H28JtoOHwWseE562g2IfTP5lWsJtAt0CTrjh6yZBSWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dp+FnsJJrOjK849PCE5uLLgfJITErwrqeRz1niyYBCU=;
 b=Zv6S2LXE0RafqT6ECAxqTkyrerbt+Thfy8kwv9GjeA1wFdQjnH5qwfxcNLrLvhvYQdXW/JRMkxdD94PP7hIXibBuaiEo52wkhD/YFOf0EXpsHdE4+eHtgW7uR3oeO/N9b3TapSglyLtq/FY2fcVMM74ZX1GW8j5SzM0azrcgwiVYm1zQ1f2n9NJeRTl7JD4KGgqmrgQvaCcLzH0dvV6kjF0xQC/SFemMnva5XBQrYJl7fMQWzWbvemAJkn0gwpa2HgrJ8uxJgq5vILGHP+XAKQg8gQeFOSfGICAK9MwKll2Ymv+UnyUL09eBR1Wuma2VyySZPtbVtAw7equdk3h3NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dp+FnsJJrOjK849PCE5uLLgfJITErwrqeRz1niyYBCU=;
 b=PptQ9B9581LU72Kq5yGuiCuZnmIYSWfp4IiWvhUS2XloGTzWol227+Q+eVjlThy4PzSstkgayp52pGlzW+pvQnrWNNBiB0kbYmhs8Xo6QWYJ5Mxt6OzmIz3KMwrimqEh9q3XvpfEgkpI7mCtKOwUFh3hZWsVvPaPsjLpO5TLCgDGPoYIHpMxn2W1ehyJEHOTJYmLwu6GXtu5r90hOT8o8NoXa7KX+A4u/RCuFBFYYGOs4VYyxHO+jGzdIFwyfSOID/5JFYNOoKSfXjhIsRTegwSjy7n4Y15676I++Z12ATm8/pYpn20Qu9zevbNTC4Uq+1DP+I/MDsdm6CJaE1DymQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Sun, 5 Nov
 2023 13:31:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%5]) with mapi id 15.20.6954.027; Sun, 5 Nov 2023
 13:31:03 +0000
Date: Sun, 5 Nov 2023 09:31:02 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: acpica-devel@lists.linuxfoundation.org,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
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
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Rob Herring <robh+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Sven Peter <sven@svenpeter.dev>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Krishna Reddy <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>,
	virtualization@lists.linux-foundation.org,
	Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH RFC 02/17] of: Do not return struct iommu_ops from
 of_iommu_configure()
Message-ID: <20231105133102.GC258408@nvidia.com>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <2-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <ld3rrnpix5x5kirfjlk6oafhoikkge4fgvcljhmiljuqge5266@asdcw5cfp53e>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ld3rrnpix5x5kirfjlk6oafhoikkge4fgvcljhmiljuqge5266@asdcw5cfp53e>
X-ClientProxiedBy: BLAP220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: c05f7684-66f1-478f-d69d-08dbde037505
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OuEPQROz0Z3a9JlVjP6o0aQyZJ0UTthOCFlATFyT68iZzrSYqcog7QtwRt/L6LMEbkwWYYJ/mVM0m13JiE8wNpLfv+Zl2WbCmkMHl5P7KnhwhMFC0tACGQ58TlNl77OMPIKyGK7m9pt+zLNz/v+BOVHoKPBCu9FB7rVxIXV5PT8+39UptIfpjm0nKQdRt7NHYsaA87RtU4vAtbG/s4EzBGtwNKu0j/k6qdtY5QNB34xS4bXvaJZwMJMOwZX0HwrvG/TmXGTTwipdtdgyas7lSWj6/sSR/Qi5oImsBX0XvJ0NcDnpoik6OMXJHcHuu5+RrYK9pzaRbfdIScZLuGzpT8T8I1JKSWoagu/jxbjbhSQCHs8WczZl4rutW5CJkdm+FNyCg7Pyu/ZOLJZ81/D77wq22R87827rN/WJiTsXBYyylUkdoTOjvdjxufOs62thHwkbiurp4MDhiiDzj8WmVPIF5Vaynl6n3uGuSzFTgWjbzLVvu837ThENl7qUSpfnNYgnBoGcRGx5IdSM7bFdQdN/WXMXoQDySJhJJsAk52OkI5qQyUY5xmBWvn9Nb/EAodN6BUqlW1aPbLcyEHhAnwJznWNdRtGTSbjxY9V1gynzHTa/QaMLIwoh1pLhonGA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39850400004)(376002)(366004)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(1076003)(2616005)(6512007)(26005)(33656002)(86362001)(36756003)(38100700002)(8676002)(83380400001)(2906002)(7416002)(5660300002)(7406005)(6506007)(478600001)(54906003)(8936002)(66556008)(66476007)(4326008)(66946007)(316002)(6916009)(41300700001)(6486002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yRGUuR7FEKAKJTl9s8LcF1luO6RqbhDiYDlzfm1EbGwXVV7TsAAay1tNlWCu?=
 =?us-ascii?Q?t3iXm5kEkvi56YK0DHBJlELvCp1xWxSgweOO/ysKjt0hV10A7EeM2B4jJVo/?=
 =?us-ascii?Q?CBHoL9BEbSVQuEchTOpPwNuZ0Q6Clr0Q7M+EIhML6bVI3u1vsKkaljDUj8+q?=
 =?us-ascii?Q?9sHO801y0rxJL5EQqryjMydmmhy73Flw9QI7udcZUIfZ8CpJdbL8rgeFQazh?=
 =?us-ascii?Q?10VZAM62Qoo9UZRysyPxuv4TYygL92fCEnTZn3rmnWRw5ak0VO3XgIO8QitY?=
 =?us-ascii?Q?L8fCh45D4PfZIMYSeACU46kIJjX/yJklpK7fnWMgKCWBIcvHTcINyVl7ESL2?=
 =?us-ascii?Q?AioNkQLn3QRCtAQaHPlZWoU9Tb+hRlSGxeFhzlJH04lh9ih6UH+0n4cFWdk5?=
 =?us-ascii?Q?WiAZOVk8xXa4372EURn3GuexEXPaYYCqO6ZsNvXjMcVuHMFkIBg0zjtdXtJB?=
 =?us-ascii?Q?7rFtbSb+s24q8zblq9OndnIPi/HzcbeTmP+C0WdKcMVgWZQ4jrVKD3kKikYw?=
 =?us-ascii?Q?WlLY1h1JSxejZNJOzz6KPzldHbXI0Oy1A8hDWs67MEF/9ZbVZ0KSho391N/n?=
 =?us-ascii?Q?Vsi9cScutRi0tcMe98fODsWvJomiWm1LxMMH9W2iZtANJ/GEqRd3IeY6wLSm?=
 =?us-ascii?Q?oO83+Fpv0sG6sNNTJe3/MJRsNF+3yxOlL9MrbtBAx3ZTx5P2N8R5SaYWgR75?=
 =?us-ascii?Q?B7p7JrhpSTRNJQ6dxxNjw8MZ2Pg8HgpLaFfuppb30mW4B8qEn2Lx8K9Ty6Rw?=
 =?us-ascii?Q?mQJU8+vKLG2dtj1LPsdMUQfG/uVole6BMeYmsjMyEQ1ZlhFLKy0MnMRYTuSa?=
 =?us-ascii?Q?aEmKxXzp6o9rioBAxURFNKnQCtYGJbFs8THF/RQq9RCGTzwr58FArTgqfLHD?=
 =?us-ascii?Q?sY5mlBlRAjFEyE9a+qnj/aWb1g4YM1V3w5mP6xnXTAEDn3AX3ZI+4f7Vfvu3?=
 =?us-ascii?Q?XqVUJXofDEZ7L9I/g3jm9zJN6R/16BcTZZwCfUVLvQKEEB3g04hour6FKHGG?=
 =?us-ascii?Q?kCKEW+ZksTOOeWkepVFGvRXKzOybOrpF7XYA8ClWKxwTLMQOqyV4uaKTXXCX?=
 =?us-ascii?Q?PAICe4CGTeY6qaQAdQN+ckYyZpir6BfM6+b4EoA58ZXf+qpvA9UIbc4iMSIC?=
 =?us-ascii?Q?rqjuP1M5SsFsGGKJgKm/yRH4dmh7OoGcOPyQ5B7JPhMFaa6KyDq2pMuPSIhy?=
 =?us-ascii?Q?vMFhijkzHvXMtCVQ8Iuxmk9ll8lolFJSzGW7zL5KdDuI5PbpvloPKZyG3A5/?=
 =?us-ascii?Q?2KiGcUpD9Cc8CzkarmpAS/v0AF0hjoxsRKbpkq5Papym8I32GPkdA/owShDv?=
 =?us-ascii?Q?WQhK2wXjar5J0GRlaRcHdhBZHEbYYNZYjvNPrs8tSMDfB4d73scCmK+XV3wl?=
 =?us-ascii?Q?dJK2IeCztNRFiVza4SltivXjvfRuZqYE8+U9X/cfNKo2PcyoY6NRnuOTZX3I?=
 =?us-ascii?Q?crA0fOjW5fsJqgkjP1uMDH48lT7VFX2YXBx71IlwQ79sY2/ABMwRJR9RMTPL?=
 =?us-ascii?Q?+5Jr43z5LM3pDTBe9d1w+1sz7NPGFzxInficMFk0+QxbNu6JVYSqOQuvap9L?=
 =?us-ascii?Q?0przfFmMZUQS90o0UlE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05f7684-66f1-478f-d69d-08dbde037505
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2023 13:31:03.4305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLDiGsJmvsw7vJM2HaJimMYV6Os66Hx1Zf7Y4P2RRv79HQgOwMFkhOwoyDzysOF7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718

On Fri, Nov 03, 2023 at 02:42:01PM -0700, Jerry Snitselaar wrote:
> On Fri, Nov 03, 2023 at 01:44:47PM -0300, Jason Gunthorpe wrote:
> > Nothing needs this pointer. Return a normal error code with the usual
> > IOMMU semantic that ENODEV means 'there is no IOMMU driver'.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  drivers/iommu/of_iommu.c | 29 ++++++++++++++++++-----------
> >  drivers/of/device.c      | 22 +++++++++++++++-------
> >  include/linux/of_iommu.h | 13 ++++++-------
> >  3 files changed, 39 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> > index 157b286e36bf3a..e2fa29c16dd758 100644
> > --- a/drivers/iommu/of_iommu.c
> > +++ b/drivers/iommu/of_iommu.c
> > @@ -107,20 +107,26 @@ static int of_iommu_configure_device(struct device_node *master_np,
> >  		      of_iommu_configure_dev(master_np, dev);
> >  }
> >  
> > -const struct iommu_ops *of_iommu_configure(struct device *dev,
> > -					   struct device_node *master_np,
> > -					   const u32 *id)
> > +/*
> > + * Returns:
> > + *  0 on success, an iommu was configured
> > + *  -ENODEV if the device does not have any IOMMU
> > + *  -EPROBEDEFER if probing should be tried again
> > + *  -errno fatal errors
> 
> It looks to me like it will only return 0, -ENODEV, or -EPROBEDEFER
> with other -errno getting boiled down to -ENODEV.

Yeah, that next patch sorts it out, it is sort of a typo here:

@@ -173,7 +173,7 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
                if (err == -EPROBE_DEFER)
                        return err;
                dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
-               return -ENODEV;
+               return err;
        }
        if (!ops)
                return -ENODEV;

> > @@ -163,14 +169,15 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
> >  		err = iommu_probe_device(dev);
> >  
> >  	/* Ignore all other errors apart from EPROBE_DEFER */
> > -	if (err == -EPROBE_DEFER) {
> > -		ops = ERR_PTR(err);
> > -	} else if (err < 0) {
> > +	if (err < 0) {
> > +		if (err == -EPROBE_DEFER)
> > +			return err;
> >  		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
> 
> minor thing, but should this use %pe and ERR_PTR(err) like is done
> in of_dma_configure_id?

Sure

Thanks,
Jason

