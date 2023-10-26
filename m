Return-Path: <linux-hyperv+bounces-594-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF8B7D8532
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 16:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11C11C20E85
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 14:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3397A2EAFC;
	Thu, 26 Oct 2023 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="LBeE4Ka2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E212EB03;
	Thu, 26 Oct 2023 14:49:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2094.outbound.protection.outlook.com [40.107.244.94])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEA210E9;
	Thu, 26 Oct 2023 07:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXluWVmjMppv0eWGfM+BOA4wosZllEy2r1ZpEoEudNpnJSi395extAJcfPlPOPb6xtlfOa8W29rOGheEZYNLgCwqVbU+YwQaEzeDBKpJkodf5lYzopdAOcX0ZV6PS3DqLYk4M386+tIfiQ6NPwOshnI1zFZsbM6UXQiNvFnrpaej/n9QEGzBIRsIf9TRN4qNgWH9TaTPZ51qiJ90wCtXwGY8iOKyh9sU3xeQIYpZPMcqz+aqy8kJ9uA9v+1qOt2cn0rFU535xKmO22oMcRtEaSVQii2E9PQAcYLYbLwAftYhCFchQfg3ZzoRY1nE2Tn06I5REEJOBrfTqMK4L6tNgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cC/Pp5nbFlWVDN/paWtA6PviGeqZCeZmnW/sGtMmTYM=;
 b=glWV8V3MtD0oX2JNXIMAGjOVtZjj/apV3wWyamfXmxpgdkkE0BMmwjp5uTNk9LVepxzS5DAHeOn/wZmp9gK5y1dWQhFRmu6Fks/+2nDt+Qz8DlCymY7rH/9Flrc8SPQveSdOMabnb0C7oBroqgEGQxN1vG+Iyfl83PPfdXTKreAwuQxAsjeoO3F2NvJPztozyfLs2zcBJGXPgue6pkSJohBolvcZYQiwlNcn0LvyuGqUFIcxWfk2IoZwqn1LSVN9t7aOoP7G3bTlrmy8WLCaUTnthmoPGsE/F7yB3GDiKMgfLH7XqJufpnEy7i9hGlAbYYCiYPffcUhQiEyHBYpDsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cC/Pp5nbFlWVDN/paWtA6PviGeqZCeZmnW/sGtMmTYM=;
 b=LBeE4Ka2ng13V+eSNl3U4YENxGeaR5gGudfLIL8s70Ln1BVXgSt3bKe3UFdlqecnMIK9NJr0USU17drhV5m7L3IDS+L0G2sbb3ZA+mGynp0K5K9AH0rSMUiVb4u8aYVcFOLVcIGsqoSCAYE2GUeZ8ryKmnZWXN5fbyUUAj5Tkms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH0PR13MB5446.namprd13.prod.outlook.com (2603:10b6:510:128::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.22; Thu, 26 Oct 2023 14:49:14 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::b6f:482f:9890:acec]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::b6f:482f:9890:acec%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 14:49:14 +0000
Date: Thu, 26 Oct 2023 16:48:54 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Justin Stitt <justinstitt@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>, Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Dimitris Michailidis <dmichail@fungible.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Ronak Doshi <doshir@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <keescook@chromium.org>, intel-wired-lan@lists.osuosl.org,
	oss-drivers@corigine.com, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 2/3] treewide: Convert some ethtool_sprintf() to
 ethtool_puts()
Message-ID: <ZTp8VgdC5yVkrFeA@LouisNoVo>
References: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
 <20231025-ethtool_puts_impl-v1-2-6a53a93d3b72@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025-ethtool_puts_impl-v1-2-6a53a93d3b72@google.com>
X-ClientProxiedBy: JNAP275CA0037.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::7)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|PH0PR13MB5446:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb6e22f-0271-4f10-ffcf-08dbd632b8f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d20ns4yMeZNx8+huibaAZ7eNBD/0v/R7709RjWhwUnNfuR3Y79cHuEB8dIkibpDdo2wPG59fcYVvVaOsDgc+bYtZx6QFymhDD2RwkDonVTCLgfSesYTXiC/CHB5K24vZNHP2nX7z9/eGrQF0Q+kcTiMce0QYoHKC6WZzrHlaDk/+WCzJYHrX9i8fOGNe5LTXJ/NM25zlyZTQ5uHtDWVZa76b9pNMh2aowSIkgFmqxwSnblilQyzxlO/z9sgKK0Q0spWQj+KcBXJ6f0LwU23YID2C67tVSGd99fthsWnPQdc4G0Wqd0B4/ZgB4rIJYHzaMpFgY7L3m8dXFLAE2j8mMiKk82kOJSZSHl4F5arL/LVavcQutgGnTYlBBNGSP05CwhNualq6AT2Gn4ZsGcadt3GAuATe6MpvR4SsPOiHgh5CR8TaduK2k5QjRFhDTac4cveVX401EVHI1XXLRzWdhMi3A07DrLLMigdxR6uVKa0sD7h9+OFnuL3jDhDG0eUsJbvPhXyqIdkJIeP3q8VJGrbts2X/CzGu9bGy1mW5nUKV1X/vCkJ6tBdjTkbIyRr6SRZnINWijGtaBI8Clw+N10zkCCoG4WuF5nMZxNAta3Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(396003)(39830400003)(136003)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6506007)(6666004)(38100700002)(33716001)(86362001)(83380400001)(9686003)(6512007)(26005)(7406005)(7416002)(54906003)(66946007)(66476007)(6916009)(316002)(66556008)(44832011)(41300700001)(5660300002)(6486002)(966005)(2906002)(478600001)(30864003)(8676002)(4326008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s/Mkh+ACWm/CiLVqLA1N3q3587i9HfpqVVJy4s2/vvHR9pfqJ/OuCTYRwyfv?=
 =?us-ascii?Q?twxZH0rGUozipP8aSwUgQ0/veLqpBOoEfAMJ5s+JlCB0Yi62CGZRn1XI5m26?=
 =?us-ascii?Q?JWpkdLaKHQIcJp5vr2+EQ6DfrwK2ShLG1r31OXWvirAgYdr1um3w3lgudBbE?=
 =?us-ascii?Q?2aA6MIynszi6BSHdfOfOFEhn9SbNwb/s+wqs/DdYWGJQPP1+qv7FFFwHs1lp?=
 =?us-ascii?Q?EDha34QlTZjkN5dZwWBZV4ts5NQqORN/0/u4ewVuxpiDxN3baL6co3Vr9GwX?=
 =?us-ascii?Q?+LdFucpU/t/VnxVN2zhJRScpoNrrmookeoOv2q+PyKzpeX9nzqeGD3MdjUCp?=
 =?us-ascii?Q?g1+dlt1nyDcHTf+6JxCQJTssNmXAkSAVmkaad7QDS1T7pOzCeYxN8w+DmQ5q?=
 =?us-ascii?Q?R0iPtUFlr701M9qu9Ma2YK+B0672wRV1Wl02P5WzYAZtCMpsu5yjZ3x2gvt8?=
 =?us-ascii?Q?KmW0Z1U5vT2iYyDyYB2hQNN8Q5u2a8mEdU8qYM+PoaNL1hMFU1v35Qqbe9gY?=
 =?us-ascii?Q?HLof/pUeOaBE+JtDxrfJPDjfS0kqId0D1ZOvjyZI8oP8RHvM1rOIMKOH/BJO?=
 =?us-ascii?Q?Cq/5BtncbPggcQOHgML26U1T3ver9i1Ub0QTSLC2hLv8NJs1+A/k2kspQGF0?=
 =?us-ascii?Q?iTjZG4cZynJQJ91LiGkQzVBrt9vOakdnt4sK4DVN7vOKuHvsa3tVEP73bhX8?=
 =?us-ascii?Q?4j386QysjGninQbsrdoz9OVQGZRxm2LsonjKEQARzJCtciHaoSUBiHItHQPU?=
 =?us-ascii?Q?QbuBJ/pUgYo3hT2Uy+SzPh17VFOBIfa9ydPs8k7jVBfNKtUBofUCKxw/wmUG?=
 =?us-ascii?Q?tIrVBdKDoR4vdVZb7UQPFbaETid9AdxSRBueBnFYBHfwLgG6QYr/+VuI+j1m?=
 =?us-ascii?Q?4uJlzOuLXp9lIEaIZ01Aa29/8ACQbH+Ef0wGkdnx6qEq97H3A4ckUT/PzrD6?=
 =?us-ascii?Q?uYq+AVtKZKBTL5I+wnQR1G6b1yrPL5UJ1xPTPAvqP3HYHnPUOhUas55tz4ch?=
 =?us-ascii?Q?jpZn9ZG/bzOqogqOqmciyEdnKRWvpiu1bapBk296D7aGHFjO/Rw2RG88VTq+?=
 =?us-ascii?Q?/aQuSdPQ0PQv4AyqCKbzWRkyogNtlRfineV8LnD33rowi92/GeQjEvRGiH7L?=
 =?us-ascii?Q?w2NMtEZkd9egbwWj1apGFI68Ue9oVXtGn9LR8Hy+sEL1G7F6HLhHV6HlPa+Z?=
 =?us-ascii?Q?r5K39fpqswcvEhEQZZepGf+Vdxh+aXuioHEMMSJctmUdOQ6QQY/oAPVLfAQo?=
 =?us-ascii?Q?2JpOlpTBznn9xekpGIWEaGH1rPW66dZWIGm3MGlwQAA8PaNesRDWylMUi+T1?=
 =?us-ascii?Q?Xl40Z7nfH5p0622hVa15abo20Sf80joWH502wH+QkClDk9UE5Vkua6X1n72s?=
 =?us-ascii?Q?WuWVeKwyIh4hIkMNpGbExq0HNvtLfQkyf8vDfJeeQA5llf4tu/CPw98gxa3A?=
 =?us-ascii?Q?AtaAvBnaYMI3ioE/cZ+LMFG4PFIgo8EGYYJwgdY6MxsYUW6Kixr21BAPX1ou?=
 =?us-ascii?Q?0yEU7cuZDrC+nQcfIcBh1hE9vjkkbMln/d2JiiX3I1EyNYeE1+twiXPkXe1u?=
 =?us-ascii?Q?kpxM/aeJfbuXtz5Ck71EmDiCSlxGK+Ia7TGHIkAl0kYY6UNZC7M1BIMXqdvu?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb6e22f-0271-4f10-ffcf-08dbd632b8f8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:49:14.5102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nu2Nhi955aDa+K8sSbPtaoDErxVRFwTeQ67hDqlQ6dgDrDj5uV5JwMqY1EA9dW0L/qCuiADlfrcD1JYHmWzP9WBbY39KTTelZ7TQ+NE8Jdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5446

On Wed, Oct 25, 2023 at 11:40:33PM +0000, Justin Stitt wrote:
> This patch converts some basic cases of ethtool_sprintf() to
> ethtool_puts().
> 
> The conversions are used in cases where ethtool_sprintf() was being used
> with just two arguments:
> |       ethtool_sprintf(&data, buffer[i].name);
> or when it's used with format string: "%s"
> |       ethtool_sprintf(&data, "%s", buffer[i].name);
> which both now become:
> |       ethtool_puts(&data, buffer[i].name);
> 
> There are some outstanding patches [1] that I've sent using plain "%s"
> with ethtool_sprintf() that should be ethtool_puts() now. Some have been
> picked up as-is but I will send new versions for the others.
> 
> [1]: https://lore.kernel.org/all/?q=dfb%3Aethtool_sprintf+AND+f%3Ajustinstitt
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_ethtool.c      |  4 +-
>  drivers/net/ethernet/brocade/bna/bnad_ethtool.c    |  2 +-
>  .../net/ethernet/fungible/funeth/funeth_ethtool.c  |  8 +--
>  drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |  2 +-
>  .../net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c    |  2 +-
>  drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   | 66 +++++++++++-----------
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  4 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c       | 10 ++--
>  drivers/net/ethernet/intel/igb/igb_ethtool.c       |  6 +-
>  drivers/net/ethernet/intel/igc/igc_ethtool.c       |  6 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |  5 +-
>  .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   | 44 +++++++--------
>  drivers/net/ethernet/pensando/ionic/ionic_stats.c  |  4 +-
>  drivers/net/hyperv/netvsc_drv.c                    |  4 +-
>  drivers/net/vmxnet3/vmxnet3_ethtool.c              | 10 ++--
>  15 files changed, 87 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
> index d671df4b76bc..e3ef081aa42b 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
> @@ -299,13 +299,13 @@ static void ena_get_strings(struct ena_adapter *adapter,
>  
>  	for (i = 0; i < ENA_STATS_ARRAY_GLOBAL; i++) {
>  		ena_stats = &ena_stats_global_strings[i];
> -		ethtool_sprintf(&data, ena_stats->name);
> +		ethtool_puts(&data, ena_stats->name);
>  	}
>  
>  	if (eni_stats_needed) {
>  		for (i = 0; i < ENA_STATS_ARRAY_ENI(adapter); i++) {
>  			ena_stats = &ena_stats_eni_strings[i];
> -			ethtool_sprintf(&data, ena_stats->name);
> +			ethtool_puts(&data, ena_stats->name);
>  		}
>  	}
>  
> diff --git a/drivers/net/ethernet/brocade/bna/bnad_ethtool.c b/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
> index df10edff5603..d1ad6c9f8140 100644
> --- a/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
> +++ b/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
> @@ -608,7 +608,7 @@ bnad_get_strings(struct net_device *netdev, u32 stringset, u8 *string)
>  
>  	for (i = 0; i < BNAD_ETHTOOL_STATS_NUM; i++) {
>  		BUG_ON(!(strlen(bnad_net_stats_strings[i]) < ETH_GSTRING_LEN));
> -		ethtool_sprintf(&string, bnad_net_stats_strings[i]);
> +		ethtool_puts(&string, bnad_net_stats_strings[i]);
>  	}
>  
>  	bmap = bna_tx_rid_mask(&bnad->bna);
> diff --git a/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c b/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
> index 31aa185f4d17..091c93bd7587 100644
> --- a/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
> +++ b/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
> @@ -655,7 +655,7 @@ static void fun_get_strings(struct net_device *netdev, u32 sset, u8 *data)
>  						i);
>  		}
>  		for (j = 0; j < ARRAY_SIZE(txq_stat_names); j++)
> -			ethtool_sprintf(&p, txq_stat_names[j]);
> +			ethtool_puts(&p, txq_stat_names[j]);
>  
>  		for (i = 0; i < fp->num_xdpqs; i++) {
>  			for (j = 0; j < ARRAY_SIZE(xdpq_stat_names); j++)
> @@ -663,7 +663,7 @@ static void fun_get_strings(struct net_device *netdev, u32 sset, u8 *data)
>  						xdpq_stat_names[j], i);
>  		}
>  		for (j = 0; j < ARRAY_SIZE(xdpq_stat_names); j++)
> -			ethtool_sprintf(&p, xdpq_stat_names[j]);
> +			ethtool_puts(&p, xdpq_stat_names[j]);
>  
>  		for (i = 0; i < netdev->real_num_rx_queues; i++) {
>  			for (j = 0; j < ARRAY_SIZE(rxq_stat_names); j++)
> @@ -671,10 +671,10 @@ static void fun_get_strings(struct net_device *netdev, u32 sset, u8 *data)
>  						i);
>  		}
>  		for (j = 0; j < ARRAY_SIZE(rxq_stat_names); j++)
> -			ethtool_sprintf(&p, rxq_stat_names[j]);
> +			ethtool_puts(&p, rxq_stat_names[j]);
>  
>  		for (j = 0; j < ARRAY_SIZE(tls_stat_names); j++)
> -			ethtool_sprintf(&p, tls_stat_names[j]);
> +			ethtool_puts(&p, tls_stat_names[j]);
>  		break;
>  	default:
>  		break;
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
> index 8f391e2adcc0..bdb7afaabdd0 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
> @@ -678,7 +678,7 @@ static void hns_gmac_get_strings(u32 stringset, u8 *data)
>  		return;
>  
>  	for (i = 0; i < ARRAY_SIZE(g_gmac_stats_string); i++)
> -		ethtool_sprintf(&buff, g_gmac_stats_string[i].desc);
> +		ethtool_puts(&buff, g_gmac_stats_string[i].desc);
>  }
>  
>  static int hns_gmac_get_sset_count(int stringset)
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
> index fc26ffaae620..c58833eb4830 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
> @@ -752,7 +752,7 @@ static void hns_xgmac_get_strings(u32 stringset, u8 *data)
>  		return;
>  
>  	for (i = 0; i < ARRAY_SIZE(g_xgmac_stats_string); i++)
> -		ethtool_sprintf(&buff, g_xgmac_stats_string[i].desc);
> +		ethtool_puts(&buff, g_xgmac_stats_string[i].desc);
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
> index b54f3706fb97..b40415910e57 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
> @@ -912,42 +912,42 @@ static void hns_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
>  
>  	if (stringset == ETH_SS_TEST) {
>  		if (priv->ae_handle->phy_if != PHY_INTERFACE_MODE_XGMII)
> -			ethtool_sprintf(&buff,
> -					hns_nic_test_strs[MAC_INTERNALLOOP_MAC]);
> -		ethtool_sprintf(&buff,
> -				hns_nic_test_strs[MAC_INTERNALLOOP_SERDES]);
> +			ethtool_puts(&buff,
> +				     hns_nic_test_strs[MAC_INTERNALLOOP_MAC]);
> +		ethtool_puts(&buff,
> +			     hns_nic_test_strs[MAC_INTERNALLOOP_SERDES]);
>  		if ((netdev->phydev) && (!netdev->phydev->is_c45))
> -			ethtool_sprintf(&buff,
> -					hns_nic_test_strs[MAC_INTERNALLOOP_PHY]);
> +			ethtool_puts(&buff,
> +				     hns_nic_test_strs[MAC_INTERNALLOOP_PHY]);
>  
>  	} else {
> -		ethtool_sprintf(&buff, "rx_packets");
> -		ethtool_sprintf(&buff, "tx_packets");
> -		ethtool_sprintf(&buff, "rx_bytes");
> -		ethtool_sprintf(&buff, "tx_bytes");
> -		ethtool_sprintf(&buff, "rx_errors");
> -		ethtool_sprintf(&buff, "tx_errors");
> -		ethtool_sprintf(&buff, "rx_dropped");
> -		ethtool_sprintf(&buff, "tx_dropped");
> -		ethtool_sprintf(&buff, "multicast");
> -		ethtool_sprintf(&buff, "collisions");
> -		ethtool_sprintf(&buff, "rx_over_errors");
> -		ethtool_sprintf(&buff, "rx_crc_errors");
> -		ethtool_sprintf(&buff, "rx_frame_errors");
> -		ethtool_sprintf(&buff, "rx_fifo_errors");
> -		ethtool_sprintf(&buff, "rx_missed_errors");
> -		ethtool_sprintf(&buff, "tx_aborted_errors");
> -		ethtool_sprintf(&buff, "tx_carrier_errors");
> -		ethtool_sprintf(&buff, "tx_fifo_errors");
> -		ethtool_sprintf(&buff, "tx_heartbeat_errors");
> -		ethtool_sprintf(&buff, "rx_length_errors");
> -		ethtool_sprintf(&buff, "tx_window_errors");
> -		ethtool_sprintf(&buff, "rx_compressed");
> -		ethtool_sprintf(&buff, "tx_compressed");
> -		ethtool_sprintf(&buff, "netdev_rx_dropped");
> -		ethtool_sprintf(&buff, "netdev_tx_dropped");
> -
> -		ethtool_sprintf(&buff, "netdev_tx_timeout");
> +		ethtool_puts(&buff, "rx_packets");
> +		ethtool_puts(&buff, "tx_packets");
> +		ethtool_puts(&buff, "rx_bytes");
> +		ethtool_puts(&buff, "tx_bytes");
> +		ethtool_puts(&buff, "rx_errors");
> +		ethtool_puts(&buff, "tx_errors");
> +		ethtool_puts(&buff, "rx_dropped");
> +		ethtool_puts(&buff, "tx_dropped");
> +		ethtool_puts(&buff, "multicast");
> +		ethtool_puts(&buff, "collisions");
> +		ethtool_puts(&buff, "rx_over_errors");
> +		ethtool_puts(&buff, "rx_crc_errors");
> +		ethtool_puts(&buff, "rx_frame_errors");
> +		ethtool_puts(&buff, "rx_fifo_errors");
> +		ethtool_puts(&buff, "rx_missed_errors");
> +		ethtool_puts(&buff, "tx_aborted_errors");
> +		ethtool_puts(&buff, "tx_carrier_errors");
> +		ethtool_puts(&buff, "tx_fifo_errors");
> +		ethtool_puts(&buff, "tx_heartbeat_errors");
> +		ethtool_puts(&buff, "rx_length_errors");
> +		ethtool_puts(&buff, "tx_window_errors");
> +		ethtool_puts(&buff, "rx_compressed");
> +		ethtool_puts(&buff, "tx_compressed");
> +		ethtool_puts(&buff, "netdev_rx_dropped");
> +		ethtool_puts(&buff, "netdev_tx_dropped");
> +
> +		ethtool_puts(&buff, "netdev_tx_timeout");
>  
>  		h->dev->ops->get_strings(h, stringset, buff);
>  	}
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index bd1321bf7e26..2641b2a4fcb0 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -2512,11 +2512,11 @@ static void i40e_get_priv_flag_strings(struct net_device *netdev, u8 *data)
>  	u8 *p = data;
>  
>  	for (i = 0; i < I40E_PRIV_FLAGS_STR_LEN; i++)
> -		ethtool_sprintf(&p, i40e_gstrings_priv_flags[i].flag_string);
> +		ethtool_puts(&p, i40e_gstrings_priv_flags[i].flag_string);
>  	if (pf->hw.pf_id != 0)
>  		return;
>  	for (i = 0; i < I40E_GL_PRIV_FLAGS_STR_LEN; i++)
> -		ethtool_sprintf(&p, i40e_gl_gstrings_priv_flags[i].flag_string);
> +		ethtool_puts(&p, i40e_gl_gstrings_priv_flags[i].flag_string);
>  }
>  
>  static void i40e_get_strings(struct net_device *netdev, u32 stringset,
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index ad4d4702129f..7871bba4b099 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -1060,8 +1060,8 @@ __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
>  	switch (stringset) {
>  	case ETH_SS_STATS:
>  		for (i = 0; i < ICE_VSI_STATS_LEN; i++)
> -			ethtool_sprintf(&p,
> -					ice_gstrings_vsi_stats[i].stat_string);
> +			ethtool_puts(&p,
> +				     ice_gstrings_vsi_stats[i].stat_string);
>  
>  		if (ice_is_port_repr_netdev(netdev))
>  			return;
> @@ -1080,8 +1080,8 @@ __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
>  			return;
>  
>  		for (i = 0; i < ICE_PF_STATS_LEN; i++)
> -			ethtool_sprintf(&p,
> -					ice_gstrings_pf_stats[i].stat_string);
> +			ethtool_puts(&p,
> +				     ice_gstrings_pf_stats[i].stat_string);
>  
>  		for (i = 0; i < ICE_MAX_USER_PRIORITY; i++) {
>  			ethtool_sprintf(&p, "tx_priority_%u_xon.nic", i);
> @@ -1097,7 +1097,7 @@ __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
>  		break;
>  	case ETH_SS_PRIV_FLAGS:
>  		for (i = 0; i < ICE_PRIV_FLAG_ARRAY_SIZE; i++)
> -			ethtool_sprintf(&p, ice_gstrings_priv_flags[i].name);
> +			ethtool_puts(&p, ice_gstrings_priv_flags[i].name);
>  		break;
>  	default:
>  		break;
> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> index 319ed601eaa1..e0a24c7c37f9 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> @@ -2356,11 +2356,9 @@ static void igb_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
>  		break;
>  	case ETH_SS_STATS:
>  		for (i = 0; i < IGB_GLOBAL_STATS_LEN; i++)
> -			ethtool_sprintf(&p,
> -					igb_gstrings_stats[i].stat_string);
> +			ethtool_puts(&p, igb_gstrings_stats[i].stat_string);
>  		for (i = 0; i < IGB_NETDEV_STATS_LEN; i++)
> -			ethtool_sprintf(&p,
> -					igb_gstrings_net_stats[i].stat_string);
> +			ethtool_puts(&p, igb_gstrings_net_stats[i].stat_string);
>  		for (i = 0; i < adapter->num_tx_queues; i++) {
>  			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
>  			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index 7ab6dd58e400..2aac55ebdf5a 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> @@ -773,10 +773,10 @@ static void igc_ethtool_get_strings(struct net_device *netdev, u32 stringset,
>  		break;
>  	case ETH_SS_STATS:
>  		for (i = 0; i < IGC_GLOBAL_STATS_LEN; i++)
> -			ethtool_sprintf(&p, igc_gstrings_stats[i].stat_string);
> +			ethtool_puts(&p, igc_gstrings_stats[i].stat_string);
>  		for (i = 0; i < IGC_NETDEV_STATS_LEN; i++)
> -			ethtool_sprintf(&p,
> -					igc_gstrings_net_stats[i].stat_string);
> +			ethtool_puts(&p,
> +				     igc_gstrings_net_stats[i].stat_string);
>  		for (i = 0; i < adapter->num_tx_queues; i++) {
>  			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
>  			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index 0bbad4a5cc2f..dd722b0381e0 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -1413,12 +1413,11 @@ static void ixgbe_get_strings(struct net_device *netdev, u32 stringset,
>  	switch (stringset) {
>  	case ETH_SS_TEST:
>  		for (i = 0; i < IXGBE_TEST_LEN; i++)
> -			ethtool_sprintf(&p, ixgbe_gstrings_test[i]);
> +			ethtool_puts(&p, ixgbe_gstrings_test[i]);
>  		break;
>  	case ETH_SS_STATS:
>  		for (i = 0; i < IXGBE_GLOBAL_STATS_LEN; i++)
> -			ethtool_sprintf(&p,
> -					ixgbe_gstrings_stats[i].stat_string);
> +			ethtool_puts(&p, ixgbe_gstrings_stats[i].stat_string);
>  		for (i = 0; i < netdev->num_tx_queues; i++) {
>  			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
>  			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
> index e75cbb287625..1636ce61a3c0 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
> @@ -800,7 +800,7 @@ static void nfp_get_self_test_strings(struct net_device *netdev, u8 *data)
>  
>  	for (i = 0; i < NFP_TEST_TOTAL_NUM; i++)
>  		if (nfp_self_test[i].is_supported(netdev))
> -			ethtool_sprintf(&data, nfp_self_test[i].name);
> +			ethtool_puts(&data, nfp_self_test[i].name);
>  }
>  
>  static int nfp_get_self_test_count(struct net_device *netdev)
> @@ -852,24 +852,24 @@ static u8 *nfp_vnic_get_sw_stats_strings(struct net_device *netdev, u8 *data)
>  		ethtool_sprintf(&data, "rvec_%u_tx_busy", i);
>  	}
>  
> -	ethtool_sprintf(&data, "hw_rx_csum_ok");
> -	ethtool_sprintf(&data, "hw_rx_csum_inner_ok");
> -	ethtool_sprintf(&data, "hw_rx_csum_complete");
> -	ethtool_sprintf(&data, "hw_rx_csum_err");
> -	ethtool_sprintf(&data, "rx_replace_buf_alloc_fail");
> -	ethtool_sprintf(&data, "rx_tls_decrypted_packets");
> -	ethtool_sprintf(&data, "hw_tx_csum");
> -	ethtool_sprintf(&data, "hw_tx_inner_csum");
> -	ethtool_sprintf(&data, "tx_gather");
> -	ethtool_sprintf(&data, "tx_lso");
> -	ethtool_sprintf(&data, "tx_tls_encrypted_packets");
> -	ethtool_sprintf(&data, "tx_tls_ooo");
> -	ethtool_sprintf(&data, "tx_tls_drop_no_sync_data");
> -
> -	ethtool_sprintf(&data, "hw_tls_no_space");
> -	ethtool_sprintf(&data, "rx_tls_resync_req_ok");
> -	ethtool_sprintf(&data, "rx_tls_resync_req_ign");
> -	ethtool_sprintf(&data, "rx_tls_resync_sent");
> +	ethtool_puts(&data, "hw_rx_csum_ok");
> +	ethtool_puts(&data, "hw_rx_csum_inner_ok");
> +	ethtool_puts(&data, "hw_rx_csum_complete");
> +	ethtool_puts(&data, "hw_rx_csum_err");
> +	ethtool_puts(&data, "rx_replace_buf_alloc_fail");
> +	ethtool_puts(&data, "rx_tls_decrypted_packets");
> +	ethtool_puts(&data, "hw_tx_csum");
> +	ethtool_puts(&data, "hw_tx_inner_csum");
> +	ethtool_puts(&data, "tx_gather");
> +	ethtool_puts(&data, "tx_lso");
> +	ethtool_puts(&data, "tx_tls_encrypted_packets");
> +	ethtool_puts(&data, "tx_tls_ooo");
> +	ethtool_puts(&data, "tx_tls_drop_no_sync_data");
> +
> +	ethtool_puts(&data, "hw_tls_no_space");
> +	ethtool_puts(&data, "rx_tls_resync_req_ok");
> +	ethtool_puts(&data, "rx_tls_resync_req_ign");
> +	ethtool_puts(&data, "rx_tls_resync_sent");
>  
>  	return data;
>  }
> @@ -943,13 +943,13 @@ nfp_vnic_get_hw_stats_strings(u8 *data, unsigned int num_vecs, bool repr)
>  	swap_off = repr * NN_ET_SWITCH_STATS_LEN;
>  
>  	for (i = 0; i < NN_ET_SWITCH_STATS_LEN; i++)
> -		ethtool_sprintf(&data, nfp_net_et_stats[i + swap_off].name);
> +		ethtool_puts(&data, nfp_net_et_stats[i + swap_off].name);
>  
>  	for (i = NN_ET_SWITCH_STATS_LEN; i < NN_ET_SWITCH_STATS_LEN * 2; i++)
> -		ethtool_sprintf(&data, nfp_net_et_stats[i - swap_off].name);
> +		ethtool_puts(&data, nfp_net_et_stats[i - swap_off].name);
>  
>  	for (i = NN_ET_SWITCH_STATS_LEN * 2; i < NN_ET_GLOBAL_STATS_LEN; i++)
> -		ethtool_sprintf(&data, nfp_net_et_stats[i].name);
> +		ethtool_puts(&data, nfp_net_et_stats[i].name);
>  
>  	for (i = 0; i < num_vecs; i++) {
>  		ethtool_sprintf(&data, "rxq_%u_pkts", i);
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_stats.c b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
> index 9859a4432985..1f6022fb7679 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_stats.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
> @@ -258,10 +258,10 @@ static void ionic_sw_stats_get_strings(struct ionic_lif *lif, u8 **buf)
>  	int i, q_num;
>  
>  	for (i = 0; i < IONIC_NUM_LIF_STATS; i++)
> -		ethtool_sprintf(buf, ionic_lif_stats_desc[i].name);
> +		ethtool_puts(buf, ionic_lif_stats_desc[i].name);
>  
>  	for (i = 0; i < IONIC_NUM_PORT_STATS; i++)
> -		ethtool_sprintf(buf, ionic_port_stats_desc[i].name);
> +		ethtool_puts(buf, ionic_port_stats_desc[i].name);
>  
>  	for (q_num = 0; q_num < MAX_Q(lif); q_num++)
>  		ionic_sw_stats_get_tx_strings(lif, buf, q_num);
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 3ba3c8fb28a5..cbd9405fc2f3 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -1582,10 +1582,10 @@ static void netvsc_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>  	switch (stringset) {
>  	case ETH_SS_STATS:
>  		for (i = 0; i < ARRAY_SIZE(netvsc_stats); i++)
> -			ethtool_sprintf(&p, netvsc_stats[i].name);
> +			ethtool_puts(&p, netvsc_stats[i].name);
>  
>  		for (i = 0; i < ARRAY_SIZE(vf_stats); i++)
> -			ethtool_sprintf(&p, vf_stats[i].name);
> +			ethtool_puts(&p, vf_stats[i].name);
>  
>  		for (i = 0; i < nvdev->num_chn; i++) {
>  			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
> diff --git a/drivers/net/vmxnet3/vmxnet3_ethtool.c b/drivers/net/vmxnet3/vmxnet3_ethtool.c
> index 98c22d7d87a2..8f5f202cde39 100644
> --- a/drivers/net/vmxnet3/vmxnet3_ethtool.c
> +++ b/drivers/net/vmxnet3/vmxnet3_ethtool.c
> @@ -245,20 +245,20 @@ vmxnet3_get_strings(struct net_device *netdev, u32 stringset, u8 *buf)
>  
>  	for (j = 0; j < adapter->num_tx_queues; j++) {
>  		for (i = 0; i < ARRAY_SIZE(vmxnet3_tq_dev_stats); i++)
> -			ethtool_sprintf(&buf, vmxnet3_tq_dev_stats[i].desc);
> +			ethtool_puts(&buf, vmxnet3_tq_dev_stats[i].desc);
>  		for (i = 0; i < ARRAY_SIZE(vmxnet3_tq_driver_stats); i++)
> -			ethtool_sprintf(&buf, vmxnet3_tq_driver_stats[i].desc);
> +			ethtool_puts(&buf, vmxnet3_tq_driver_stats[i].desc);
>  	}
>  
>  	for (j = 0; j < adapter->num_rx_queues; j++) {
>  		for (i = 0; i < ARRAY_SIZE(vmxnet3_rq_dev_stats); i++)
> -			ethtool_sprintf(&buf, vmxnet3_rq_dev_stats[i].desc);
> +			ethtool_puts(&buf, vmxnet3_rq_dev_stats[i].desc);
>  		for (i = 0; i < ARRAY_SIZE(vmxnet3_rq_driver_stats); i++)
> -			ethtool_sprintf(&buf, vmxnet3_rq_driver_stats[i].desc);
> +			ethtool_puts(&buf, vmxnet3_rq_driver_stats[i].desc);
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(vmxnet3_global_stats); i++)
> -		ethtool_sprintf(&buf, vmxnet3_global_stats[i].desc);
> +		ethtool_puts(&buf, vmxnet3_global_stats[i].desc);
>  }
>  
>  netdev_features_t vmxnet3_fix_features(struct net_device *netdev,
> 

Thanks Justin. From my perspective the series looks good, though I've
not spent very long on it. For the nfp parts:

Acked-by: Louis Peens <louis.peens@corigine.com>

