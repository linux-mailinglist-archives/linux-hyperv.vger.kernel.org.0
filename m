Return-Path: <linux-hyperv+bounces-696-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3635D7E13A4
	for <lists+linux-hyperv@lfdr.de>; Sun,  5 Nov 2023 14:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF35C2812BB
	for <lists+linux-hyperv@lfdr.de>; Sun,  5 Nov 2023 13:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B40C121;
	Sun,  5 Nov 2023 13:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qjsbuoMR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64D0C122;
	Sun,  5 Nov 2023 13:26:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6F6BB;
	Sun,  5 Nov 2023 05:26:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlXJ+jUV4i3QR7QFAc3EGaav0jiIFqBxlnyxeeE73c3HIqBgVcqqSJBOsVINX3i/xIxgn8qr/vsnGwcb/VlVT/N6/V2f9UgEOcXm8/blWg/aAPZhxCPG4a3QyM56o9ItHnR+LxPRoVRHVxz2t5LigQt8vXnAAia+aofXgBcDjurqROWiZb5S9OfgBN5RNI5Kw93ARkcznnYeZCB6Il3dc8vR0EdWDOyOkK0OTjaPj8IIrHzdZC8TiLDrPBM4JE9T9mdaB3xSP2/6k+1fCTBr8WZ7GW/md+qtcFMFu4n+uxxUha9g2e39XgObtpl5q3f94XAR0Pr3KqoS3yGPfzf/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJzt/JlH4kKLeZuyydUtFvuN6kCORZZSEyi3cbMw43g=;
 b=XDDzj//JZHlRqm5ADTnAh9mFpxU2VIHYrpEr2cZaNO7H3Jl/9RQrWxe2G9z/LtGpgZmV1q/tKlu+ZDFzHHMTIV7TmPrYY/BmtQQ8XoPpTBQEV+v3Hwos7tkvMskNaNK2r4IMXg/vuUfiU7O3Q9+Oa9EmsN10i4c2SuuyHEdlwPvpelaIxu0wuNxNqaGdRgxx5+y7DXLwSAl9wcGTbLTkJIf6P8j6G6vsm9tml8WK/qyUSq/SoBBbd5QaxIP9RU5Cmrmv6DG2+zKkJ/uWjc8xi5M//fA2nMf+NHF1x3qYxcfhkq69tFYj9QGeUm2e4nmKK5X7F+aXxzBMGz3ttY2mHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJzt/JlH4kKLeZuyydUtFvuN6kCORZZSEyi3cbMw43g=;
 b=qjsbuoMRBoFkdgyaEUMt1SGaEooJre7hUgc7RJ5hSDcwKQ3USWtzPH35k4ZhEITJToYL1xY0ge85dpLDU/NuCkqlC0VUTsQuxw3bCIcOxFNbjhI29bUWABkk8X4GY+Y/XBAow8uIGbFrxSZbLz/82aLb4yFoGZf9rkwN+zWXHJOpt2rVDmxpuLMLLoSKUvISq1/Y1xKSe4vBhcoBaZLG5Oyb8NHjVnHiQjZk8yvrIwWt7XsPlYCRFEXz1BUKqcpJfgqm6RUb88PWXDtWKyQrq6xssg7DNrVvWWLquBZs87OtOM89/8E0I2i24Sj4irE9wuC7RCfNDYw+/XHhx9rr2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Sun, 5 Nov
 2023 13:26:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%5]) with mapi id 15.20.6954.027; Sun, 5 Nov 2023
 13:26:17 +0000
Date: Sun, 5 Nov 2023 09:26:15 -0400
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
Subject: Re: [PATCH RFC 03/17] of: Use -ENODEV consistently in
 of_iommu_configure()
Message-ID: <20231105132615.GB258408@nvidia.com>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <3-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <4iktbjhxkddukf7vywxquz5ffgik73wdw7p7rdqhsbsumhzhsl@y6u7tjbczafc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4iktbjhxkddukf7vywxquz5ffgik73wdw7p7rdqhsbsumhzhsl@y6u7tjbczafc>
X-ClientProxiedBy: MN2PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:208:160::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b12080b-ae0f-4cf3-e733-08dbde02ca3b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cs++FhOBXmywDl0q4R9BlXSr0K3XzAluKSG0SRjDiQcBBQGPt0DSGlZk0EyDol9TlYQ6z1hSyxqn0O78czAE4vWpjSIGZ1ILDWFInCM+qUolswNkZrSQFiug3he5j6d6nblxYQW+CzYccJJ7rN69WxOUGn3b6dp8PLjioEkfRCc/1vAn39M21JYMcg+AnTHYAzaGP19nJs0MHqEIgHLs9zMnptQdPShaL7+b+c8CJri6IBCZLl0fnVBTMfZKJvRKTQhEHgtm5eSXWrw13pXggx/tnS4UbgT0q1GZgVxLR4Uy8Py235VF+AjC591MbRurQt6/FK989Y89Yt3VB/y3JRQHmtSebsxxTiOQNysKSCVgauc+WI0BMH2pXqtE8DSVsNU8fbhi3YoKPnth510Mp/3u5ryizTqaz01Nnfasjr/MSeE+dj2JtIhn4Usj/hvYEPYhD2GgUsVKyU2X/t65y4KKyKcWqFOFYANtq8NaOMUtKLl02CvBEo5v9kkLfAkbOwHfe4g+R8LYLfcs1PiksVjH0MMFD9tn/tQ1zAgVkoTH3xsqhzDdaLMaA7uBO79PYLi7KM+6Pa1Q5o1RaBBftlfoPRwLsLZyjXz1lSVbvU7hKPLJHH/VVGZwvRyAeuS0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39850400004)(376002)(366004)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(1076003)(2616005)(6512007)(26005)(33656002)(86362001)(36756003)(38100700002)(8676002)(2906002)(7416002)(5660300002)(7406005)(6506007)(478600001)(54906003)(8936002)(66556008)(66476007)(4326008)(66946007)(316002)(6916009)(41300700001)(6486002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oCZLYPkafWNbDpifgGYDSvHmCDywiQka2wmu5ny9MqkCVjS3xPCUha+9Zd+k?=
 =?us-ascii?Q?xkEyuq4Esh3B3WsY5iMfd3uTD5TkscIRrFniStXZqsH/SeUYovydaJQIGjtk?=
 =?us-ascii?Q?h8+TgkA7WxfYC9YmgCBIzPW3mMUaqy7+ou+7uNT1+P2gp9HmYtwQqUWskBxt?=
 =?us-ascii?Q?Omkc8SQi5qx4whwpUZcIg2tF+PKtY69FUgcnCIfK1A/BX0COLA5FADszwQKR?=
 =?us-ascii?Q?MdfutJ/rc7Tvn4hvXY8biqiawSsQlskuZ+b4sXIswA3vvGpJCuES33yMoOHH?=
 =?us-ascii?Q?JVfRqRbSLypcr9Bu9pV7gcDOvR2O32QyUY+nb4MwqlTBJfRiCh+qPEN3eNoF?=
 =?us-ascii?Q?nz3sb+Wj8xEN32w7BRFMURrhO+v+aqJ9cJk57r99HkNaDYk8DPql9kNiezR3?=
 =?us-ascii?Q?0qsj64BrVSVv2gXltLCxau/KZalq5EWy2I2Q6Mx/Uzw28sMi5+QEe+2M34T+?=
 =?us-ascii?Q?yZAGofinxE9V3IakdtJk2MXz8G5kcy1LC9V5DIOaOqIv6q51XvX8q2ypOCcZ?=
 =?us-ascii?Q?XtseGmTz2P0y9m7tS1kVcJ4cfJGgKti3czfAIgTXPCv7DUNWLoHImo6TX8bb?=
 =?us-ascii?Q?59QZcPZQUqnudnjR0EfYV9jcqXFqxxM736ACJPBU80XORYvRqDw74Z5TN3yX?=
 =?us-ascii?Q?tioIwlzMKZw/PgCukV68mYlzF6jrqVjUjSisIX2E0NQBX7yyCQNa4/TVl1CP?=
 =?us-ascii?Q?IL56iU3bumhs+MjbEuiARk+KlxS7tPhhO7SrQsNIr/W8ER3eiAst55YGsSCI?=
 =?us-ascii?Q?LwfZPX79IKAsobjPG3eiKYJGnoUqyJ6PM+jZCwjtJ9qxifWipxmmfDfVrmRl?=
 =?us-ascii?Q?HnrVmpftfQ3jMHGDRgqw/eADyGXdzJTXgf4LH4zxlx2iz5c+SuzuF560xzOj?=
 =?us-ascii?Q?4RumZiabm+ntTHfiUqMK2asT6cg3w1HQg7sg/a++46hJ/r69CMVFBR4pKNmA?=
 =?us-ascii?Q?YfE5SBB11VgZDWGrUVjvg+W3hpk4fMeS2KpsFv5hpTLI3rC+W6vARLq2AnXG?=
 =?us-ascii?Q?JXIak15XlhL/QhnnzIRp4hyNVLhVG+zvNttNJgmTi+3TPA9yd+iYYvj0SVVS?=
 =?us-ascii?Q?6ML6JTqjoZXQAhp/eTH92NV0ifFYxdEfdy9HJMKG/QTs837+cpTYhCYwuhFZ?=
 =?us-ascii?Q?bdiZfRD1ELLIHpQbH2N+pmqGOfvcCn+qkzHbAlHzg5g0V390tqgOKDIgZ+wX?=
 =?us-ascii?Q?zAWS8ltOb+RGwGMIFGC0i/fCy/iuXHYTVQT/Lmod01cSfLOO7WFl/Yr8x5Nu?=
 =?us-ascii?Q?/LHZXuo7H6K14hj3b4cZJiVGINVT55R9yi8/xaakPF4sQncugK07XI9EBlCK?=
 =?us-ascii?Q?yh80VeIzIyfWsNd16L09x1UzjdRpCJZQvKv0YDYlQVY/UXsgWEENTkzLyHVx?=
 =?us-ascii?Q?MI5orCqDrDHxpcR0cWi1Gu+LpSoi/G+dJsOWWTn0tNndncpjvTCzF2Z6y0le?=
 =?us-ascii?Q?xttXpV8KYGWfSQTwAQnwMOUGpJMqOEqF7CeHTjlHXHcisNJVCOylewir39UD?=
 =?us-ascii?Q?cRiRZECnhnzffwG6tbMcp69SwqVHbQYZg7okCEJ2306Tqxe81CcZdyt56OEA?=
 =?us-ascii?Q?u8Sk3hSrQCnvHK06LfU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b12080b-ae0f-4cf3-e733-08dbde02ca3b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2023 13:26:17.0077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRkvWuG1DhKRdVfyae5TXcGosQq+F1X2KGKBJLPUj21PN+W9cEqxTjYwGbdI9fXB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718

On Fri, Nov 03, 2023 at 03:03:53PM -0700, Jerry Snitselaar wrote:
> With this the following can be simplified in of_iommu_configure_dev_id:
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 4f77495a2543..b9b995712029 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -61,7 +61,7 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
>  			 "iommu-map-mask", &iommu_spec.np,
>  			 iommu_spec.args);
>  	if (err)
> -		return err == -ENODEV ? NO_IOMMU : err;
> +		return err;

Yeah, at this point it just makes sense to erase the whole thing:

-#define NO_IOMMU       -ENODEV
-
 static int of_iommu_xlate(struct device *dev,
                          struct of_phandle_args *iommu_spec)
 {
@@ -29,7 +27,7 @@ static int of_iommu_xlate(struct device *dev,
        ops = iommu_ops_from_fwnode(fwnode);
        if ((ops && !ops->of_xlate) ||
            !of_device_is_available(iommu_spec->np))
-               return NO_IOMMU;
+               return -ENODEV;
 
        ret = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
        if (ret)
@@ -61,7 +59,7 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
                         "iommu-map-mask", &iommu_spec.np,
                         iommu_spec.args);
        if (err)
-               return err == -ENODEV ? NO_IOMMU : err;
+               return err;
 
        err = of_iommu_xlate(dev, &iommu_spec);
        of_node_put(iommu_spec.np);
@@ -72,7 +70,7 @@ static int of_iommu_configure_dev(struct device_node *master_np,
                                  struct device *dev)
 {
        struct of_phandle_args iommu_spec;
-       int err = NO_IOMMU, idx = 0;
+       int err = -ENODEV, idx = 0;
 
        while (!of_parse_phandle_with_args(master_np, "iommus",
                                           "#iommu-cells",

Thanks,
Jason

