Return-Path: <linux-hyperv+bounces-944-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960D47EC479
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 15:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C567E1C20B31
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 14:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719E328DB9;
	Wed, 15 Nov 2023 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PKr6tl4k"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D369286B0;
	Wed, 15 Nov 2023 14:06:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CF3C5;
	Wed, 15 Nov 2023 06:06:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksonttggxnHojAX+LosYvRYxmNH+Tl6UF4nQTbgUyyULX2y/hM9R0KyRWGB43cloBHZZ4DSXuT4gXlpaw2dSXufaLCwFAPxPhj82a99UbT8rLr1GYzBfpxICyfPfopLfIifC1ewCLKrcpeb9Fq4Ifuj9X0dJpukVjHzAIgbkT6xNAwRLZtpl4o2GCOzrYP0ByrCMtWaOUitAUxUb/DoHuJHESN7CtwLaCQc63Gx3To1mAt9Q7LY0nLrG3B1kezbJilieGhtjDmaJN+euhZ+YOrBXTl/4JwYrzcTD7F3pMvO2w9y9HIkvZJyPWstZjqOlQ48A41tQlKSHmiQSL4AvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rkd11CHx72dnTG6Kt9yoJSdWIUwf6gzil7j5xbfzY1s=;
 b=H6iWvy+j+YX/HwZ+b3ssrV8AtvFsMviMt45TU6qtx55Bif1cQUasKS3RNolfsujfx2mBBeiGOnZmVlRcI1cgY5WFmxwEbvKbIP/kwLV9lXE4diVKTtE7+pma2VDcOEOyFAJQkSlBnD7UfkxdimpL7vmfiZR73gbA9bZqlkJ6DLMbt+apOwuTIO6L2tp3I8HF4pI+CjfqcRAEVl0rHrJRuvR6zy72GfwvDVpNZTSMUEFgqgHQPOcRyj1/omBH3IhaTNvXpK52afIh7/ivvrdbt7PZuJ/2cYC54iCl6lmBG4N7N3C0OEwIJ/Sj92+wZNeM93oG23gj8rBWqnX/ytYPhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rkd11CHx72dnTG6Kt9yoJSdWIUwf6gzil7j5xbfzY1s=;
 b=PKr6tl4kWWYU6trhikvcBub1DF41WeDvfqg3xFNyj93eGVNYQOJ3tBy6qNQHshFw6tt8mPOyNSUPtJO8SSxbFCXS/Gqd1znZ7X8oYC4SrtstZQNsccGYKwUB62muA7NeQNcNqhk6fGeP+aXCkbOVcz573dvZQwDBMUShgBKvXT5wbxXszl69iAXSbgHyaEcgMEvwgTPNyMwNGTqFqdciFrTzdX6K4/asuPYJG04Mgu5mCdK7AfNzuwMWf1vD/t2thaHLY9/uczI/n1IHZxDIf8zWu6/Ir4JBpITMwLZLYKmuIjRRftU6mu1+olWcKAfBjjuyewDXtHtiQs7y498RDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 14:06:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 14:06:16 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: acpica-devel@lists.linux.dev,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Albert Ou <aou@eecs.berkeley.edu>,
	asahi@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dexuan Cui <decui@microsoft.com>,
	devicetree@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	iommu@lists.linux.dev,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-snps-arc@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Hector Martin <marcan@marcan.st>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	patches@lists.linux.dev,
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
	Krishna Reddy <vdumpa@nvidia.com>,
	Vineet Gupta <vgupta@kernel.org>,
	virtualization@lists.linux.dev,
	Wei Liu <wei.liu@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 16/17] iommu: Mark dev_iommu_get() with lockdep
Date: Wed, 15 Nov 2023 10:06:07 -0400
Message-ID: <16-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0030.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: cd57df2f-70fa-4365-9035-08dbe5e4054b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5+PCHwyQoTgcnmOhU0+wAdo5BJF9MNJThP2tjYcfTlDLIRfE6+NZFNDhHZ5MLgPyVYyONBOoLyAV1MuagOj6dvFwDmvWvybBwzKbma+IubR/CmGpimfDV4kInJMssRgZ5fKwarqEs+m00IWa+mQuCyqJjq7/sguQDYXTor4LsPV5doaLPU7liKDX5yehsQb3rRrM2fA7dHhCbzVtNXxeFcUiVVVJMIXXYtkEmcMbY5yXtIGPTsmRtD0O+CE9PqMdiw5QHGfHGRbAccHZ6gEu6YEpBN37yp/Ul7g5XSRVhctH8Y5mUn36Xbq7lSrCAs5Sc6xw1r/hm4YxVq0ZdAl5cWrf4AKawUqTiG6oWedoldwvuxqDZxSybt6Uriqv7SzcAAz1IuQSkUHj5/UUJtJHPe9mIyAeaqDCdbSCYJ7OZIeyvikaYjWZbL2jqej7v9vlZ3HLftk0rSZQxwsBYp3tWgnUNXkGlUurxJWLuX5rIsJ0iX0qZV4EKTm91RwdWnu2WXT369LCWCKQBZT/pRjy+hoclCIbhqIxCqr6SBQzWIRGHT9HqAmPy/zcWdJ1+ZYpb+9Qe7DRas9HEhYutmmHGpBZL9nFu2lp5iLSbBqoUf0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(110136005)(316002)(66946007)(54906003)(66476007)(66556008)(6486002)(478600001)(6666004)(7366002)(86362001)(5660300002)(7406005)(7416002)(4744005)(921008)(41300700001)(2906002)(36756003)(8676002)(4326008)(8936002)(2616005)(38100700002)(26005)(83380400001)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ua2aJLcFIbc5+itcPpnHBFBTlyrcf8EJZLPTpR0ouZnfSMAVqcDM5urushXd?=
 =?us-ascii?Q?tM4fFQeqXnOxgbygNVorw3yAXqF1vRXU1ZLhbzBf0IRGQNjCgB3751V0B1BT?=
 =?us-ascii?Q?eNCU5YtpkhyHXoMPCa4iN314wodKSjs55dTx3LMdgovijS+2zVNiSYhcaWYh?=
 =?us-ascii?Q?XPfI7S1n5sa9MznopuU0TOKac4LZLVug2FmeCSSe8cZM6WE6WnBxVM4aXaiC?=
 =?us-ascii?Q?Ch5TVTU3RIA96Gp3HwFRoW/SrFa2qQRijp4hLffit5rmOaBGuzDajX6jM6zl?=
 =?us-ascii?Q?FOCMOREIqiOXjUsfVvnavoPdKxTJymkp5XHxNzqJQ/f/DYRKKSQxqHHWKNdQ?=
 =?us-ascii?Q?pLDwAXLo3lQ81vlkISlkiZ5vA/Q8fePktKFFIHffVFkg7kGV1oKrOwsywfHl?=
 =?us-ascii?Q?Qw7JD93NcsAbRHBUjCB0601qmYqjayjfvyojvTI+on1ZH13TJ+pLDMG6UpoR?=
 =?us-ascii?Q?Qw74ZP4/UmtqM2hIDt9IMK2H+xC2AW1kDts7QRpehkhyiwXdO9puJhSv22sT?=
 =?us-ascii?Q?2sC2gi6Nby7EgVV0tunGZyHIib8ZDdr94rBojMMHZPIfI+WRwyTYmC9cfMZj?=
 =?us-ascii?Q?1o4hbGza38ly2GoQ1xF+uF+rvMWqNPAr1YRtk1mVNPbN+0Ohyqr3LcVIrwkX?=
 =?us-ascii?Q?0RJaw21NtjbQDth7I6mDdIAHYKrXetcFgeOR95rKep4xewWhSb3gSb6mdTK/?=
 =?us-ascii?Q?hXkkHN4nPRB/ymSaO94Z9tnFhWYl9XzcMzttEmv5RKSI15U9IAEPc/84b/s1?=
 =?us-ascii?Q?YsOk6QCkl1fMVaEh1F+n/6uxJfmzc3mB301LKpjOthZpfY17+WpXHiAp7KbM?=
 =?us-ascii?Q?WXK/tC5DdigVRrsYrUveo1TTn0LYQwfwU85f7XB759LVfeZbGOzyTQ4wQ6+e?=
 =?us-ascii?Q?EiDwBdh+hcvlEXnrvdaBGVsxUWFKNf5NDAAz7iodlOWlGYFMbylGTT10l7tn?=
 =?us-ascii?Q?/L0ivb0iWEFRsAi5hj/PAaLgERunztWXDa0u8p8mLAP9bwBz6pTPmVahN44x?=
 =?us-ascii?Q?SPmYcrAONazAds2lbHRtz/kGlLSBWiXHx1RIxbYNcqxK9r94ExnvSpXqrxV3?=
 =?us-ascii?Q?0XxZOGOYx+pxyJ4A8bj9q8pUcqT3cj81BhivsviRa0s6O8VXc8jql435vd4N?=
 =?us-ascii?Q?TAdFlOADzqr1+aKhQlYEIRgoB3IR/oJldgApuX96E1PulMK/CmNwzbJ8xHC/?=
 =?us-ascii?Q?stRQzwTJAWtn8t833ZeKznY6A0yjfOnDD75SEjkXPHH+2EQzAxGi8n+tacxc?=
 =?us-ascii?Q?xMFwwo9cn/jVyAGSIL+kiLbppyKEx+2/BkApgjBDLNaPeJcDWJIDb2ch1yI/?=
 =?us-ascii?Q?Rei9ca7RFjj+D4F3i9PpbWzdoIwh7e8C7MKa3HpNP2f07Uk9cIJyCpmRKq+Q?=
 =?us-ascii?Q?/RDNfGa/sBSkRYmPnSsqlPTAkWfmwppCQKK4jr9VGeqE0d8W7CUakGAjRhfW?=
 =?us-ascii?Q?/Qrbw6PaRMSz/fK8u1jet2BwJKlSpE+mKfr71Siwvxo1TgqSjKCALDobUHKV?=
 =?us-ascii?Q?YOpM1W7pTYgdjwqIK0YpG7CXbIVw/nksIJFTheYhzPl+hpqk8z0FCetxEIuB?=
 =?us-ascii?Q?68Ob4w59P2k4cJInqHk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd57df2f-70fa-4365-9035-08dbe5e4054b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:06:10.9323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfvvkzP18CpfUqZFB3Z1GoS5XhWLYoplp+SyiKUoGPeZB5/IG2hxCOyiQvqFe3qg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916

Allocation of dev->iommu must be done under the
iommu_probe_device_lock. Mark this with lockdep to discourage future
mistakes.

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index de6dcb244bff4a..34c4b07a6aafae 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -345,6 +345,8 @@ static struct dev_iommu *dev_iommu_get(struct device *dev)
 {
 	struct dev_iommu *param = dev->iommu;
 
+	lockdep_assert_held(&iommu_probe_device_lock);
+
 	if (param)
 		return param;
 
-- 
2.42.0


