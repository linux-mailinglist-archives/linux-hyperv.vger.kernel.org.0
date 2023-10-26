Return-Path: <linux-hyperv+bounces-598-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3D77D8681
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 18:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB030282037
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 16:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63876381A9;
	Thu, 26 Oct 2023 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="an0Gmfr9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328EB35882;
	Thu, 26 Oct 2023 16:10:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083151B4;
	Thu, 26 Oct 2023 09:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXkjDBkVcRMjgvot+DsjIJn+Lvv/NixOOVphYqp5QVB7dGQT7e+dwcMyllKCVc6E4+VKuq3jdOxVk7tYObcSveqlv/73T2b7ztKYhyOYUQYklhZsdDwmQtvPeRmtV9z3KCxcpZ9tFiE0cXcqBf9jKSabBdaebiu13TVew5rn+kexx6wwc0SttO9Ln0MgWO6gdDz46RJPbZEZ5ofOHKi4zmyyMCQQm2GGiv3f6gKmxnt5Zxe6gOeqNXN20txzC3iHa6+se9RDxYVVVwn/07h1lDLfgS/HjgUD27Ggt1txanL2vDGGKTPCSUSWsOOU96gYoKNcRCRGsLFZ1CJ66dCNUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thMezfOBBeDepm/CN5f52shz+FxucWX1jt+SBaSzv5Q=;
 b=BKa/OCgLaHSsmMEXBeOi4fN469JZc1kgD6ldOIuZz3D9Cyku4TBfc5J0mOEjY0g860UOgcTxExEXKziGS5tINf/LIk5I6nUE0IcMiDMTeusUIxBIgSQ4Gn8yaU1X4xRgpgJNKc8Zw/P5xNxT0qWDzO8SR/oDZcebEv4NT08pVVMLITsiU4olcQ88mt/NF5r66iPhjvuzcZ2q6FV0i0m9dRt6/B5006JginaZj6AQR3rH3JFYbj8vPNQvSnW8csBthT0kLT+88nRWW7aZELLt5O6acGdK8LnYbvmkeWIdhq0lFE5voOPD2JHjWZ/tj9V6/1FerkQj3kLv+aXAPWUa7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thMezfOBBeDepm/CN5f52shz+FxucWX1jt+SBaSzv5Q=;
 b=an0Gmfr9ZdqvPPtUFUKXWcGuc/6n2k66Fy9wdoD6xMGMGpKaves2B9E8fO4FS1XFH5Ek6fu6eflhjrVTYKX1xlOMacD4WLLf97sVJQMQYkkfKkmgTyTrnD1j+WvjK7nQjY/59cV1M3aafPRPgZzKpPGUBABvXoR6wfblOPLKpXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 16:10:20 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c%2]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 16:10:20 +0000
Message-ID: <24d96a47-bd0c-4110-be64-e0d3a3dc8a24@amd.com>
Date: Thu, 26 Oct 2023 09:10:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] treewide: Convert some ethtool_sprintf() to
 ethtool_puts()
To: Justin Stitt <justinstitt@google.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shay Agroskin <shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>,
 David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>,
 Saeed Bishara <saeedb@amazon.com>, Rasesh Mody <rmody@marvell.com>,
 Sudarsana Kalluru <skalluru@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
 Dimitris Michailidis <dmichail@fungible.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Louis Peens <louis.peens@corigine.com>, Brett Creeley
 <brett.creeley@amd.com>, drivers@pensando.io,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Ronak Doshi <doshir@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Kees Cook <keescook@chromium.org>,
 intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com,
 linux-hyperv@vger.kernel.org
References: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
 <20231025-ethtool_puts_impl-v1-2-6a53a93d3b72@google.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20231025-ethtool_puts_impl-v1-2-6a53a93d3b72@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::13) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: c89489e1-b7e3-4467-ac2f-08dbd63e0d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cnQjBFS+sXQoiRmSWxeon4lstP/Jv2H9ndi+GHIovkgSkQOLTVoCMg2WLASiNBZIL6OnQjCpRXENIymu7hT4H+fEuiANLsjc7bQGfFZ1MU9NeB4g7QeiSIoqHRMLGxCscJBIqZ0xDP1OOIi46e4mXRI8hCgwj8Ho5j81b4+pgPAl6Es0z+m6+hiraag/CdbGzjHp4HSC/fB7Ag/rOBZsGu/122lcMF92scdWdQVXW9IXgYHFRyJklz1FetV4Ha3L7667e3XUqRAT/fo5ys7nek2/IWQuGxEgkoGLXS6k99swtwUcwfFtfwfLTp9fIjVLc1p82wz3z4O4T5nI8s0W7Vad9nKCSGMwhWVGnM4gapSuV5K1uT8cLtHERzSZ0r/Is+GZcHVNPACLf/V0PXNGfNMIK/YHUKd+CpTNWqEQ4dh2NcnKkukV96N0yoLvDBuE7pujTtoLiEQLDFDO+r1eAenMWfEMmhwfJ2F4tEy1ZLL9hgm8zD3TC3E09eJTDnCXIwX3FiNsMSGI5ScPp1EUH9wRby2r5UaBgnODU5NliaRfxyKF+Mb/h72DUtpK7rnxk3iz8o1JlIW0qZ5OZlvmlP5wRYmjz2OZdfYJ5xMnYIEwLcbPxVl2+Fdlm36/TjLejO0JKovqepLZMKFFMuBHMA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(478600001)(2906002)(53546011)(6512007)(2616005)(66556008)(31696002)(6666004)(6506007)(26005)(54906003)(110136005)(966005)(86362001)(316002)(66946007)(4326008)(38100700002)(5660300002)(7416002)(41300700001)(66476007)(8936002)(36756003)(7406005)(8676002)(6486002)(31686004)(921008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzROZndFZjNia3hRMS9kNFdCbCsxN29aRmU2ZkZnNzlRRXJkbFhma0xJWjFM?=
 =?utf-8?B?UjQyRiswblFkS0xxOStNczN1RURybWNrczhLQndmNjN1eTlMOUVJRzhKclB6?=
 =?utf-8?B?Zk1KbjhRYnlIN1c5ekxnbHJVbDBQTEt5cTFjZnB0cmtZYlI0Tzcrd0tDbDhV?=
 =?utf-8?B?WXpOL216REx6b3dyREtkYk1NQi9ONVhsVUJObGNXS2RBTHIyNzlONFZTdWFH?=
 =?utf-8?B?emxkdW9tK1ArWFp0VTFYVGs4bDRFeXVuU3hRMm0vQ1F5MHpCakgrTk9FMmNn?=
 =?utf-8?B?UFdwQnY0VjR3em5adVFPQ3hBVEQrb2o1RjBlWCs3SDhDR1gzWFVhbEQwWXJJ?=
 =?utf-8?B?cDV2aGdOL3ZEUzVxRU13RWVpdEs5WHZlVmdhWkdtWDRCQXVjMzFLZXFmcmw4?=
 =?utf-8?B?Um52TG5Od0duVWJvWjVHa29XMnNyb2o0YmdCc1NuMm1sVmQ1ait4RmQ4Y0Zo?=
 =?utf-8?B?QTU3WEtaR3RYelpFQURBYVR0eTdKS0dZUzk2UG5RUmdwOG9LZlJTbm5PYWFs?=
 =?utf-8?B?Q3BYU0REejZ6UEN4aWVUZ1JXYzd4d0cyZmI3RDlBR3lJVy9jTjViWktuTHVZ?=
 =?utf-8?B?UmJBbU00aEVNT1R5L1BtTjVpNVl4UFJEeDdyZzViWjd1TG1tVEEzb0hKalM4?=
 =?utf-8?B?VGFRaVFWSGlVNnJmRDI0a2dkTm5oVitScFkwai80T3lQdnlIaFVja2N0MEk3?=
 =?utf-8?B?VytOTVlxMkxKZkFUdGczTnFtUHZOenhpR2toMzZjamFOU2hJdUR1MUh1VFBo?=
 =?utf-8?B?cjFuUUNRckVBQ1lqUjJ1MUlOek53S1R0VXZOQ0FwWXRub1pQL21TbzhIY0Uz?=
 =?utf-8?B?OXVDZ1U3MzhFdTVnRnIyMW5jUEgvM1FsRjQ1SHNvSmpNVTVuKzViZkZvaEQx?=
 =?utf-8?B?b2o5b3QwbHdLS1Npd2lVM2tMcUc4cDByR0VXc01veEpXVHhZUHBiV1lhVGdv?=
 =?utf-8?B?MTVXYUlxdXdQeWNvS2gwS0UyNUxOR1Zod2ZPQUFGd0lnQm1QY1cvVjNYSHZi?=
 =?utf-8?B?eU9jU2xyUUgwVUlEbEExR1VhdUtwZzBuZkphOXBlNnJoUFM1UE5LQjc3R3Ux?=
 =?utf-8?B?ekQwVjdiYzZBK2N5V2JiejRNUUl0ZjhYRFFySEVpbk1oY2pPeFMvOGY3b1lI?=
 =?utf-8?B?S0NjMlh3d2JaazlPQ3JYcFhXS1hMSElyRld4L1VOUmlQbEtyMzROeitRU0VI?=
 =?utf-8?B?WDJtWEZXd3NQdHZNYjkwWFU1WmZkaFU4OGwrWmtpS2FkMUV2UVkycUh2MFNQ?=
 =?utf-8?B?QmF3NjQybThIQzRsWFBsMVpySUJ0dEYzWXVPVjZLVjYzVmN3N1BLemdzMnpt?=
 =?utf-8?B?cThONU1SSVNvV0VmcWdiajRBQ09EY01oSGF2b0wvN1JIdzJTN1BTREd4Y2da?=
 =?utf-8?B?eXJ5alFIdW93QVB0M0VFd1VHVlQ2NHZlVXR3TVZ6T2xRUm5FQ2ZXSzVlUlpW?=
 =?utf-8?B?OHJFb3UzdHdBMFJmeGFVY2I0UHdYdGd2TitpRGJJTlFFbmFkYjI1S0p5M3M2?=
 =?utf-8?B?TG9jLzFNclJ3RktHK0pSWXhWODZremtHZitrcFBpZFhtMHdaYmloV3FVUDY3?=
 =?utf-8?B?Mm1iVjVkdXFXWTdmMTV2aXJpaTF4TExuMkJDWU50TGlsNXA0V1U3QU9iRkN5?=
 =?utf-8?B?ZEhiWE1VbWdSYS9Sc2syVldBS1poWHVMa1Z0ZHoxMFhSRzE2a2V2RHRDMVZk?=
 =?utf-8?B?RGNMdkdZcmdiUHp0T1VhN0pVZTJKYlloc3JmcWhaUElqRVpGUWZhaXlNcWhR?=
 =?utf-8?B?Z3RVUVRBL210dHliT3E0TWw2QytZaXdaempZd2hoUk5MMTl1Snl6a1dWdFpU?=
 =?utf-8?B?UWJ2WmFlWS9UZXFReXVycnFIdVBQTEhkWk9MbE5RbmV2eGxUbjdPTmduZElX?=
 =?utf-8?B?SzJxSkFSdjM1YmJwQkN4LzlZZzZseU52d0N3aVNuelo3SGFIMjlyNWZvQzMx?=
 =?utf-8?B?WVFMZWlqc3BuMGNzMmZEODRZSVhqdWlNNm9UbFBZNS9aTmZjT3pvd2pjZVIx?=
 =?utf-8?B?ajBRQjY2dEZzL01ZVExSZE5UWXFMVy9uemZMS042V0RjQUFaOFhhTXhFYVQ0?=
 =?utf-8?B?Q3kvWDhUa0VaS2NpUlFFWk9aWTVMZHNmU2gzSUZydVl6dTRNVmU1b1hZWFdw?=
 =?utf-8?Q?1UxtXHwkRT/oYCbTRGcOb9iOa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89489e1-b7e3-4467-ac2f-08dbd63e0d01
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 16:10:19.9493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84IwVK12b/PxGHjuVupLnbpX+gP3YWk3J3O1DtwOxkB2/syu3SPiepDeajD7GgIC+5P9p2jHKGMGfXkzbyhGlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650

On 10/25/2023 4:40 PM, Justin Stitt wrote:
> 
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

[...]

> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_stats.c b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
> index 9859a4432985..1f6022fb7679 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_stats.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
> @@ -258,10 +258,10 @@ static void ionic_sw_stats_get_strings(struct ionic_lif *lif, u8 **buf)
>          int i, q_num;
> 
>          for (i = 0; i < IONIC_NUM_LIF_STATS; i++)
> -               ethtool_sprintf(buf, ionic_lif_stats_desc[i].name);
> +               ethtool_puts(buf, ionic_lif_stats_desc[i].name);
> 
>          for (i = 0; i < IONIC_NUM_PORT_STATS; i++)
> -               ethtool_sprintf(buf, ionic_port_stats_desc[i].name);
> +               ethtool_puts(buf, ionic_port_stats_desc[i].name);
> 
>          for (q_num = 0; q_num < MAX_Q(lif); q_num++)
>                  ionic_sw_stats_get_tx_strings(lif, buf, q_num);

This works for me for the ionic driver

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

