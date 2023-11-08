Return-Path: <linux-hyperv+bounces-812-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CC97E5E7A
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 20:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6ED1C209E3
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 19:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6091C36B1F;
	Wed,  8 Nov 2023 19:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Okr8wsay"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD6C36B06;
	Wed,  8 Nov 2023 19:22:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4792110;
	Wed,  8 Nov 2023 11:22:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCzV3zqGRwGfZRRYn40OKH7OcmXqx4emEQwQ2uAHHvKkb9MBFPFICSCAYNYRZk9vvgYG3quVjeG15W6HIwkCcbkc3tlqBTLEdGrkQnRdBeX1T2ukOhTnkhhOZuMZoVNMgqfaO7uJyHCeNokVQBo+EYOMylmo62wY1YBhRDklwcJP5YjLcPU2/yDBRCO9fYRORVulYIdhQQh0qQ6Wuvrnoe9cFlC0iLRkcPbcttfKf48F9OKftIUd+/VnbsVXqE34gABql0KnhTnBJRx5t4NqtlEnS0DRqCaVUH1HH1UIz+TArbyiXW6st7i8F9mhE9TVKK8b9Kgkt/nhE991BTKtGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhI/syNnnLZfO82lXNasbC8mRMqQloP0BGi253z0Ies=;
 b=Y9P7O19asJZsOrnEEJloKFDwEKQxw44gol70UA8BPAQoz5OmlqO75SSNK0/lGac/Yp4L1VSu3YHH/jJcqruxUQfxhfpeSeMKurYVoSombdEeBLRxwLGlAn4vVjLU5N1ArOsz9tmPMspo/ALscNSr54rXNgkOid89UDU9tFQEN/kRor0UVNsqvgv991xLuZGi1dU2AD+9GME4R1vnXZM8vvRb3mru1wGJURNNcrB8YgO/zJm3tNBNGGFnBkQ9tcls2jnIQQ/zmzh2yqa7y6XtKZ0vMpXMGvvlWkem4xybKKM5QPD44WTjPvu5exUxKbNYzPRCVjAIkhr90g3iJXReYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhI/syNnnLZfO82lXNasbC8mRMqQloP0BGi253z0Ies=;
 b=Okr8wsayB1BTwoC/SF8LFsrGPbL2sn/TgLmSDf1XLrQXoWuVvAbiDrhv3/0II1b0aUFZ2T/DGplFdb+8FoIIgLhcRwoA5Q2kQqWQCfGCljy+CLJXONAVlW1TghPoVnIYn14/Y0NBU4rM1OgVhOzfMPahd0kqABB2/eEr0lLF4oiyuy5xjjQDMAT72iYYR1mtOdbny05S7ON81a/U52+y4xiEroHdo8QUi9oa4tWJGjEMxIKCrc4dTB1kJeE5CDU1t9D0RK8PNi9tO6fEEc5JWUicL9UwSARTE32UZGYDUr4NV1gvcCZLItwhb8lUOEerw8G8waxu6ECbYlm8BehWrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB4884.namprd12.prod.outlook.com (2603:10b6:208:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 19:22:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 19:22:09 +0000
Date: Wed, 8 Nov 2023 15:22:07 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>,
	acpica-devel@lists.linuxfoundation.org,
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
	Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH RFC 00/17] Solve iommu probe races around iommu_fwspec
Message-ID: <20231108192207.GV4488@nvidia.com>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <d6664edcccd81edc5caa54e8da43b5c571a3ea76.camel@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6664edcccd81edc5caa54e8da43b5c571a3ea76.camel@linaro.org>
X-ClientProxiedBy: SN7PR04CA0181.namprd04.prod.outlook.com
 (2603:10b6:806:126::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB4884:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ab60bf-adcf-42c9-ccac-08dbe0900060
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gJjK4yfFfRd8HivVDOWysBZIAEQFz8CLebpcVIMK017+pIGgezWjN4pBfT/LD1Dt8NWCw6RptD4sooCyaGgDZbLpq+6Fnrsq/ClAJEr4ZrVUHFDyvw9ESIMycoSpzTNng29sFmnF8wsfe5Hu/nqyW5APwUr1RlE7I6VuDV54DkAxyJIXbAsJzx/PyD6UkRe5NTxzI5HTMOsTGNNVg3CbnSZQ8YxAQkLGl4ZZLF9I3dn4qWdTUCvciwU/iOn09XI+BOssVZ6pTb0y0HzjePtohaohNajphWAxS/FgW+Orv1XZ2Vv+bh+UjBVWUnT/8OCB79dj217hhwpeimkjXDa1+SfqgPOS1V0N9vFtTPuuq6op5wtMDfE0KXNvrJ/cUHu+WmD+to+roCCATBntstZ0pymT3ath995pCRmThrbXcdHM7H91XCRR1/22BzTMottlISO+Uee3bpjhqAnnSMrpqEfknkvkKYQFP7a+CP1++nF1zfC/07lpVdmxHU/YHlKXYTV8gnX4a9EF4E6MznSHZkFcWBwRftDCRKzVP3CwFV709ysRDK5bMAWa7HfQOt2Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(33656002)(36756003)(6506007)(5660300002)(8676002)(4326008)(8936002)(6486002)(6512007)(41300700001)(2906002)(7416002)(2616005)(4744005)(7406005)(316002)(54906003)(6916009)(26005)(1076003)(66556008)(66946007)(478600001)(66476007)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnNQSVppNVIrM2RsSGtkSkFaRmNwZ1lJSTBwSlJoRjdYZTBLbW14UjJFdHA4?=
 =?utf-8?B?NzRlVVZaM1U5Q21BZWc3bURrVTZKU09CTXhibVZNemJsS1lLTllnT245WnpI?=
 =?utf-8?B?SUNmT1BSK04zd0tJMEhiOWRBRDRDNk9WOXBYMk5TcEY5RG5lNlJtWWNweDRB?=
 =?utf-8?B?YlQ1VHhVK1ROQ1Rib0xsVEJ0TTB4WFYxYW1sSmU2aW5WYm4yNTRhdmh1TW54?=
 =?utf-8?B?Z3pDbGlsSWhISmRHVnlsSTNoTjczNnRIeWVqaGFERG9ZT1NJaXpEWTF6Ti9q?=
 =?utf-8?B?dXJKdTZYU1RXTWdtVy8xbGVVWnMwSU50YkI3TFZjb0NhWGp0Z1ZnUm1Geitt?=
 =?utf-8?B?dzF1VTU3QkNGR3FkSytYN0hQb3N0ZU93c1Bta3F6ZmZoWkRkZUl2dTFUWk5X?=
 =?utf-8?B?cWluQ2o0SDhYUCtDU1pPUUlCVTV4OC9YQmttbEFEcUVmdzFXcHhOUzJFemZU?=
 =?utf-8?B?SVB5Z0djYnY1OTFaTXg0QU1WS2I3TEp6cDFncmNyOTBtQkxuQUxDYXNVRDRr?=
 =?utf-8?B?Q2tqdG9ISXRmVDZNOS91YzhmRjRsbS8wdnBXQXhHd1NxNnRha1FGYXI5Y0VP?=
 =?utf-8?B?WkR5b2djbkp2eVJIZVdlZklacGZXQ3g0aC92ZVBpSzR1SnU4eW5zMDdBa01R?=
 =?utf-8?B?aXNTZTVrTjFaeUR6cDQrWElEUkw0cjdDREc2ejJtVjNzRlArRDhEZGJOcXZG?=
 =?utf-8?B?K2Zvc1Mva3NkZU1oeFNuME5BYWhDYUpscmhOSGVSYmdBVlVVQnQ2ajJhLzZP?=
 =?utf-8?B?RkVrUWpZY1RXbXo5cmtaQ2tRRFczUlltM2ZURVVoalg5TWJmVDM4YmZrVXUx?=
 =?utf-8?B?cUpFL2ZDeHZVR1NNbXZrMFpZcmlWSnA4SDkzcW5xendPcEQ1Q2NOYkRMS2ZU?=
 =?utf-8?B?Z2tsM2tXS2k3QW4zUDhhUTdzOFlGQXVxazlTZVM3bXRoTVQvUlZOSm1qNTZu?=
 =?utf-8?B?WXlEaXVoZm9zS2lXMTJtYUF2SjdoTkVYZW1DN1B6VWlPd3oweS9kYjl5cy9q?=
 =?utf-8?B?bWxlTForOWdTbnk2VDZjOXQwK2FXbEYycTJBS09xRHF1cjQ5ZFNjL3A0OVE4?=
 =?utf-8?B?eXFvR3pjYmFJWFByWjVYZlFocVIxQTZaelI3d3h6ZHJ4NWFzcGxWTlJ1THEz?=
 =?utf-8?B?ZzdoZXdGanFLZHpjMmxsNjkxelFWRi9nRmVuRkRrYkp0TlhkUWlkQk5DNEVL?=
 =?utf-8?B?ZXVUVWpCZWZOTXpBNmlJMzlqUFJ3YlZac3lwTVFJNHpiQ3BwZUtmdFFSVjA3?=
 =?utf-8?B?djdhSXNmUVk0TjdxM2FLR3ZoSlU4Vi9pOXdHeVI1NXAvdTBybkxNaEtZem55?=
 =?utf-8?B?Sm5NWnFXeFNTSm9RSjg4bjkzYzljcGpKQnNJSGFhUkVZWlMrenpLMlZla2pH?=
 =?utf-8?B?UVQwVXBKM3JjQkt0REFrOXhJZ0RPQ2x2WmVaY3poeHo2T2dmenZKYUljMUp5?=
 =?utf-8?B?OGF0S1psSDRHZUIweFZRYUFac2JydGMvVkk3K3ZJSnFhSlVTNUhaL3lnVDlU?=
 =?utf-8?B?Z1RvMkNQNVFCMHh1QW1YZFpUeERJblZSaFNOQ3ZxMHloNVMvTVpRMmRrOHpu?=
 =?utf-8?B?L0gwQjU0SmdvWXErdlN4QUxua0NwdWZ5bzcva2R6SC9rbVFsN2dyMVI0VVB2?=
 =?utf-8?B?Y3poSDlHeUxtQkdLYlQ4bE95d1FXSGphdHlKbXdmOWE1L21XUzFNYjB4bHlH?=
 =?utf-8?B?UEU2WE5ESHBIM3RyWmlKaStnWE1iZUdKK0NqanZXeHpWcE4xUUpCNTVLOURK?=
 =?utf-8?B?bDdWZFQ1NCtWbmdLOGo0enIzTFByTloxbmlTam04QXMyNWtaaENnaUdZV1JY?=
 =?utf-8?B?a2NaMVd3aHplak1pYU81K1VBbWVzWStyOFFZQVpFK3hqRjY2eXVEZ1NKdFFj?=
 =?utf-8?B?cHFPbEdZNGlxNUtBL1A2Mll1R0VrdGJoS251bE1qQTI3SzBuRE80a3poRHRJ?=
 =?utf-8?B?WWpNbkppK2tzdDlIM2xTMjc1U0kzZlY3TnJBNEg0ZE9JSDh3d01MaUN4ZkZU?=
 =?utf-8?B?a1YzTGM4ZjJuM3Z6OTVTUm95Rk54ekIveXlCaVMwZTZpMzlFQlIxK0lzRktv?=
 =?utf-8?B?RXNTU1dNWXNZTE5oVUdwL3pWQlE4cEFyUS95YXVxUXZOTVptakRHN1hsOUVk?=
 =?utf-8?Q?OZhk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ab60bf-adcf-42c9-ccac-08dbe0900060
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:22:09.1244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHLey/g4iVAxmaibMCMXp0RFpBSIvC1cJKJHiXUfEsdys9J/0xAEAfbfwVg+yc8w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4884

On Wed, Nov 08, 2023 at 06:34:58PM +0000, André Draszik wrote:

> For me, it's working fine so far on master, and I've also done my own back port
> to 6.1 and am currently testing both. An official back port once finalised
> could be useful, though :-)

Great, I'll post a non-RFC version next week (LPC permitting)

BTW, kbuild 0-day caught your note in the other email and a bunch of
other wonky stuff I've fixed on the github version.

Thanks,
Jason

