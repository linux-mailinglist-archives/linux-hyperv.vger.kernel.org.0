Return-Path: <linux-hyperv+bounces-695-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBA57E139D
	for <lists+linux-hyperv@lfdr.de>; Sun,  5 Nov 2023 14:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B37E9B20D42
	for <lists+linux-hyperv@lfdr.de>; Sun,  5 Nov 2023 13:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC4EBE68;
	Sun,  5 Nov 2023 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b4xrEyCr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDB33C27;
	Sun,  5 Nov 2023 13:24:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6ADBB;
	Sun,  5 Nov 2023 05:24:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dO8n/KFdEeSWGWrNsU+XKASoPB0CHHX+oWCvXYVz2Fw94HIHNTBfru3tQJKTACXSZyGZOK1Z6+CAic6I3D1WBwb6bzrLymx5BepejYAahyL1PtB1nsujNOtr1ro51Vk65SaCQglVyfKnEJV2Y4PKI4WbSEIzU7iYbJg80moi71dVMwg8bOL64RiY05U89eCNlH1iV8vC6iM75BE5PpBTfFCgUgcgifPua0SbdlDyEXvzjYqtZ4tf+yu6xq89hdrPzoPPx5ZaQ+SW9VC0qqYMA09kw7swNIN9d49F52DAJd++Tah3mW1HYeVP1znbh/RrVC4FXI8LPiZlG87369HRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJGcIVHL4bL8SzYqo1X4zLKcEwTvMdnL/1kA9Gi+Z+s=;
 b=dfTWPDc18yVJlLasQ+w1mmL3UYQvyTZctPqsqLpD7cPTPs9LOY6v/Du/RhbG6x+CbVJnKVAqtMYPbUZ+rLjKd+WIwYqa7HdokBov2Y57yKNAbJHf4g78CeAvdCnQWmaBwBSytvKxEjpKni574igkTiWFG8x6Dx6VnqoxYZtJcB2dbeY5qDwRF0eALVzeK5XZ8z2CS+YPEdtXcMeI1aIyKbG7kCjBhBfDAIWmUdmJfWh9q4RI0bVe+r7WXEWIEq/ss/wF6XIl+P0EHeilgAtgCsVmpnZ6qrgeTazmUd/LAutd7bp5KcakaE2ehKSf7qcFVcfvStwPQmZhInLPuGoz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJGcIVHL4bL8SzYqo1X4zLKcEwTvMdnL/1kA9Gi+Z+s=;
 b=b4xrEyCraUgRPgixMA7hYyeEOiun6AJB7uTmw1tSi5sIsTCmBgSNO2BT1+UBPWoZfJ+mcvjWOdg107FVElfekTxo6BJFzJrZhiWiWUjlz26acUM1o2CcrL6scBi1NVYwxOanH+ncAYFgrz5sB07IWObxKqojrmRmhWvKzn+z70FC9DrVK4Iqx2rmvEp+uAWwEmVH9m+FcyqFHnq8AyUe7m6V+QgNTL7LB1JlR2/vItIOusdFMP9iDkIPrRlo1WNHVXMSgvfFQaIzqPLA25wMPuHyOqF6H+GNIhS+jNcxiDgJxK6OI9PV/6DM9Dr+V4Pg6/JLNUhhkD1SafL/UJsFNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Sun, 5 Nov
 2023 13:24:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%5]) with mapi id 15.20.6954.027; Sun, 5 Nov 2023
 13:24:09 +0000
Date: Sun, 5 Nov 2023 09:24:09 -0400
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
Subject: Re: [PATCH RFC 04/17] acpi: Do not return struct iommu_ops from
 acpi_iommu_configure_id()
Message-ID: <20231105132409.GA258408@nvidia.com>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <4-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <xvgdxrlcpvafst6qypgwehtleaihsedgoiat6akv6au2j4xrjw@rk4dl4xbnq6o>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xvgdxrlcpvafst6qypgwehtleaihsedgoiat6akv6au2j4xrjw@rk4dl4xbnq6o>
X-ClientProxiedBy: MN2PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:208:c0::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d544610-48a5-4e21-4f60-08dbde027e8b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OA5zLbuDMR7GEVYsSdVdBzUObO0soht4nGiXOagg4upmNJX87q1nmscQG1D+q8EuVvU2dEZW2qndG+jsl0zoD1dAtglFd4yUli8Mghh/vFNIyI7kZR7LdzXm9AFPZzsBS4aksDhL9EKTVjFagzqA31IpzyzA7nTz5b9QgoJ5G9jX0/Ohh/VPzGteQ1Qh3RVTww4gcEe1MMnU5AO6wQ+rqn8MIgv9rNSJ/BxKeAm5XsBL+UuibUBQCcnaR7VG+fvV3g7gZEYDQsXqct+Vy547WLgpa0usIB3SjxE3Pnq1Mwsa8is45rp68or9XKznrfKtVqLIcmpLpTqfUaHO/U2q9GMtDPbqavIwrC5vyn38InvsjHgSdhBCsd7enesRZVA2DUKoK8ZjWal+HtaIVwXeI3e4EYpQrn+8kXsxJy550EToEC+tAl5OB69bPjqHOU6UHR2dhgYOvDcLnGU2sLtg9XrfVVtjAPsrHdIcWmaZGGQGVig1Tdzdj8csOiyDr1yn35MJkljdkYaa90Xp6/ndUICSYn9gg65QnXJuOcjCfuzVHWQvi55tQInu5rh+pSEmmufehDQ/B6j35W6cazRGXLmuTkJ0YgTG57jzyKjsaoQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39850400004)(376002)(366004)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(1076003)(2616005)(6512007)(26005)(33656002)(86362001)(36756003)(38100700002)(8676002)(2906002)(7416002)(4744005)(5660300002)(7406005)(6506007)(478600001)(54906003)(8936002)(66556008)(66476007)(4326008)(66946007)(316002)(6916009)(41300700001)(6486002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cKCmRmh8DlYfv8jlZuEzz4zBpBeMKc83w0N+FaeS4VN59dMOdW3o5MMaMgLM?=
 =?us-ascii?Q?FudtMLkbY6tJomLw8YAUVqhtR6sHJduow9au+EIOkXfRBXSpvMl99hTORKz9?=
 =?us-ascii?Q?RY6wKk4JDnfV+lX2YmEYCTtTiecfw7KRK3uj98l6dH1Qnhn2GgLFcKvBSmRz?=
 =?us-ascii?Q?aG2I8UN4ouPSD+kbUvRIXbBCFpjqSfNBjULcSkvqc6xroy/4bzMQ6vGeqSE2?=
 =?us-ascii?Q?aZ5U/2VEI3jVlC8JX2qDo3dn7xJwUsxen/ohZtsHYnBZ8e6uXiOdDAVp5BWL?=
 =?us-ascii?Q?o7CLRRIxNOOc1ca2PiGpuoZZB8NuuiJqd2QQRwLdWyrZbmsBPjTjpiERZrB5?=
 =?us-ascii?Q?CV50gHdLkKg1gYl6yNdMV9pBnqHwfYLDCNiz4ODUqi6YEedJe85/WzODMfw2?=
 =?us-ascii?Q?B20nCzVQIdTXI68mJeOdFjbl+oUr6NjP0KxnRG7b/p0KuveUTXQb7BixwxIT?=
 =?us-ascii?Q?BixtGEF0peZb7TFh6RRriEpf0kANgEhf/2LZx8UYSbFwpGOH55spXRffnZ7z?=
 =?us-ascii?Q?GTkLu3llmueIHHsWzaMXjRHvBmL268avbktkI3yTpRkVWD+TQdzxzxLBuyzF?=
 =?us-ascii?Q?CD7bx77QwUHUVpMPBs3IoqMMIAs/KSu2JzbqKRnqP6iFknDY854tK2xelVfO?=
 =?us-ascii?Q?ijq+3MWJjg/4F1Z0zbUmmd75qEMRXQm42MLbVgC4qkniO/3upHgprPQm+l7u?=
 =?us-ascii?Q?PWCj2dAD0rlbjKNq6RoVnfxhYTbo05s7Kg1+uCPRPpV9pbEH/AXzkWwzqpIW?=
 =?us-ascii?Q?vNiRiUYCEaskZ2ANJw2K6ZctAQVLJItGlGEpIVVbocc/L3X3GcgsLEJpgLH7?=
 =?us-ascii?Q?SXRElSclnaWlEPMw5U5TpGxpROSO2Q9+KG8e/CMYsmfRNmzs3yNSWLyCnGHX?=
 =?us-ascii?Q?oTahBJqIu7y8lzfVYwav6e2fAramdTjgxA3gE9amqqoE4KMWrmJqg83vh9lD?=
 =?us-ascii?Q?AQYGvCIXSTvQpCoAAIN109haZ6ZpgzFBKmudOiqihfPXtPmS2W5S0lhoF5zy?=
 =?us-ascii?Q?gPAzIf8sZRTepQ36vAzZoZNPocT34cKoIwszpjw2YV/SX9eo60MDXZlqjhw9?=
 =?us-ascii?Q?9IV6a6jNOtCDcUWiDWLoAql9MG45Hi9eaG2bbc4ZkktAtDrV1oQlSjuUqC/7?=
 =?us-ascii?Q?+Cx/o2Dcl6bf0Z/cGqfTxmPVmR4g8Bzr4dN+iW2jso4/uvKHBez/CC+3KaO6?=
 =?us-ascii?Q?MThp1+H9ZaDiCr3twnDKH+/unTutoIIydrbWQ29bvULievbOnFL0SJVgmwDH?=
 =?us-ascii?Q?LJsE0hlJf3G7CNOYxfTcWOPm9cYIYMl7oZgWwHCPAVdqq4tEPOY6OmCGBv5l?=
 =?us-ascii?Q?1QlrnmoUf6M5fqA+BM9e7fPhm33xk+JKUivbuCQ0lVmImv1t8pxu1OIN500x?=
 =?us-ascii?Q?RlkWk5iI8+DU5JOPoUxF5bo1frWV87HxHq0TVpEk7UegG6puMvkQJs9derl2?=
 =?us-ascii?Q?vruaRI/ciJHMaepjg3MqTxRzaCXh4icjZ/NMHeGYEP0i/ttjyfWsUqdHb9TE?=
 =?us-ascii?Q?aqjrKY8ZR0pihUN61Ogg9t5Gs3fS0oKFE19COzOl1fsmDJ3hUKr53Jtbn2sK?=
 =?us-ascii?Q?beIhil/k7OU5xhh9g1U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d544610-48a5-4e21-4f60-08dbde027e8b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2023 13:24:09.9055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3acQt56HK1M8G96tzZpcmrgB7ASIa6w82k54v+IkYC+ECinQC1vdYIqsgPLWaSb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718

On Fri, Nov 03, 2023 at 05:48:01PM -0700, Jerry Snitselaar wrote:
> > @@ -1632,10 +1633,15 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
> >  
> >  	acpi_arch_dma_setup(dev);
> >  
> > -	iommu = acpi_iommu_configure_id(dev, input_id);
> > -	if (PTR_ERR(iommu) == -EPROBE_DEFER)
> > +	ret = acpi_iommu_configure_id(dev, input_id);
> > +	if (ret == -EPROBE_DEFER)
> >  		return -EPROBE_DEFER;
> >  
>                 return ret; ?

Maybe? Like this seemed to be a pattern in this code so I left it

> > +	/*
> > +	 * Historically this routine doesn't fail driver probing due to errors
> > +	 * in acpi_iommu_configure()
> 
>               acpi_iommu_configure_id()

Thanks

Jason

