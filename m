Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD82738D3E
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jun 2023 19:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjFURhW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Jun 2023 13:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjFURhS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Jun 2023 13:37:18 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2101.outbound.protection.outlook.com [40.107.102.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD00919AB;
        Wed, 21 Jun 2023 10:37:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jc91xi3dCjryq11e/mA+Fz85d7LQBextYXBqQZfxIZaSzVAb8/EH/Avenj6EFwlnCSDBxXnGJNE3N+AbJ1IutzPkOlXpWrP2P2A3dAWHuKHYAZNcAnCZ6xDhBcYBqScjfiLdJ0Esw4VTAp4weVgxq+spgFp3kLE13UXt66LE7d28twKbbWvqnzDjIhPH4PnkpWb/1yycqEIk0vQA0Sk2SLlJ2vtyWXvYtqRAUg1He/KwHnQgXilO23ar+YBrpl6F57Q35vWd8QU3f5bc4e478GCcsJCID3lNjtxPE6oXWR1yr5IhspoiLicfyqFfgT/94AzuzGNv9DHjjhO43PGSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZICNO9UgoYynMg6diZAkp+guVZ57QU3v1aBgTSS80iQ=;
 b=g3j8Jz9EAEbNi5CjCm2LnCnjveQoWc4ren+UMgVjlp2hthfte+jqdUAAphNYizYYNXhpaqFHdtV7tMlf0G6aDtttlfk0YPETSlN7k7L0Qt4TWJRLeeogyUJhitpOd36X7QGh0iA6BxrTwCpwq4yM40ro4Beur6DULpFFvw39kgxiKuv0AIGbykWwqgOKVjoOyNTO5s2Ni1ZXEfhIPKctJ8kYtjrgjojxf6mg7ED1kaZduUHasoRVERyI0IeeiwKl4dkAEUw6w//vc3brOoysnv6wpEh262v6AOix4SUjc6cUG6RTMB6xrMzNGUKXdrhxo8gbfAvrCz+IGCMjm75TLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZICNO9UgoYynMg6diZAkp+guVZ57QU3v1aBgTSS80iQ=;
 b=WzomL7cnlzwSRN3SbsJaPDvhz09p7FYrvslCMKMYMA9TmhmUvDq2UnBI6IKKesTQa3oyrjTDRscyGXIJ7BijISmlmLHVQtgpoYpRS9SuAGEvr23YC1aoLKq/fFcDBiXQYRQWvCaCVm4joaTUh3c0lrQHvcz5o8e8qm/ICg+5kUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MN2PR13MB3663.namprd13.prod.outlook.com (2603:10b6:208:1ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 17:37:13 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 17:37:12 +0000
Date:   Wed, 21 Jun 2023 19:37:05 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     souradeep chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] net: mana: Fix MANA VF unload when host is unresponsive
Message-ID: <ZJM1QcJmUSAiH2q2@corigine.com>
References: <1687343341-10898-1-git-send-email-schakrabarti@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687343341-10898-1-git-send-email-schakrabarti@linux.microsoft.com>
X-ClientProxiedBy: AS4PR09CA0007.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::8) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MN2PR13MB3663:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b799e56-e37b-4422-9ac7-08db727e25a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u0YU5KAKo8L/POSSSEAPPooz6XGFsWB8HLM3vMCF3+hmVNNQcuZ8z2cVPDK40371lII8BTJKbaFZ1DbtKQMCiF0smVUd5ucr6FOdm0CTdtf3/c5gA24Q5ddHRxgfUjGTDw1WHCLs9626pmgrxMJ+BLYmRq15RgmZq7k34cw2ptRuBWqCjk8idqA8Itj1sBkDCLpWBuaIfgJg2UsmWve/DlbIoBf859Y0ppzywCHQPYt8djbB8t1Zwn4NEFYs7r7P4OUKA573hCA+4vdkHUEx+oV1gAcNVGLrknAxYJT5QxvYjr5GrOpXCs5gP26/JTH25RQVkzY+db16Z6Apg2gG+w1Tk+qKYmObMexe1Fq4Af0CaGciHIZu6463TRNX0Z+orbwOSd+Q8jUY1W90PTE4BleRuODk1jYKH9e+BWWa5sDK+BKcvOGrTrG0zd7qX8xtxv0zGKVFQZ5beubfPUDg+Mttg40aQR5Z67h9rjBRkBuE9XMjAi7vRQg4RGYIcIln9lRUsZC0ZsCRA9SuD4WEc3dEi/gEGQOXOxqnSPJOEuPMrW8uwyKAPoUTAycrkVhEUXlBEraC6PodRxT7WPLBKgzuyzvm3z5B8oCtX0V2TE18IAo16YDnBFRENyB1cSqjb5CrBRJdR4Jjh2IGTKLZMeDK74KdXb0xVvvOYBghMdo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(366004)(396003)(136003)(376002)(346002)(451199021)(38100700002)(6486002)(83380400001)(6506007)(186003)(2616005)(44832011)(7416002)(8936002)(8676002)(41300700001)(5660300002)(2906002)(6512007)(6666004)(36756003)(45080400002)(478600001)(66556008)(6916009)(66476007)(4326008)(66946007)(316002)(86362001)(66899021)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RFBKsXA2WuDpFTtZgJHVmSi/V2JZ3F8m3cp+X+MXkq6oZaI5Yg82QYpZjp1n?=
 =?us-ascii?Q?7GNdsH3Tj5XuAbYeFr161bz3P9HmBKSc/9uVM9NpbAmXTNWNz9o7u35v5YVv?=
 =?us-ascii?Q?jSgAmlxGbJY/2E5is6z+MidRQQJHIMTfXF4JaTYsju2+3bN8r/8/EaFyFLf2?=
 =?us-ascii?Q?I660kQDrRj5NLV8lqsL9EPBx5YlOzb0vejwBhvv14gr2FGHWQQytbupJ875H?=
 =?us-ascii?Q?1mUc+RsCfsBGFSjJZU5MOplddo0BgCd2Vbtx2v4xjKBbJnUPQv+EA83C/ShM?=
 =?us-ascii?Q?AdJFdkAiMuTAlUz2Unly62WlgqPZyUfrE7qQmohpGf7vklxFdmMqBJsRUFzI?=
 =?us-ascii?Q?oHX70G/N2E8gSKFJy+hhAlUTOs/Oq5KEktBn3+fhSm79gaCuj5eouW15Ytjk?=
 =?us-ascii?Q?R6cEKXMuHzGKlvI4DT1W9NVVB/4O9R5bfqsQLiu+0UNQlEUY1Vtf7N59N+ad?=
 =?us-ascii?Q?DYzbVa3VWODyZ4A7kApJHypCTJ2MGm28xV++163TD8aX1e0EKge9n7D0uelm?=
 =?us-ascii?Q?1Rzm5N7qg6SuxEecYVvjy76KpxyitompdZcVJe0MKehpUF2B7F+VS+0kGl14?=
 =?us-ascii?Q?2u0ui61WfIDisa5wzB7o/NPbxRmJOE7hglwk8pYRmbsyjHummztuUg69as1C?=
 =?us-ascii?Q?NsIQNms5dEdu/toDNgCWTVUxstpP/eXyBu1zNMYPv83IXTUxW9z2hs4+Px9f?=
 =?us-ascii?Q?Iusg5Ywn2gWFehZCaa26C9VzhOUDWsb+kqV+O6+qFSFCxtR2/IVUuzHAYdO2?=
 =?us-ascii?Q?Zl5TvwDGRAjUF6rt4IvDU4E4QcmxBHBa0yEZEiHmbkcjL/JXgn2DYM4GAb1x?=
 =?us-ascii?Q?KlwCpT0pli4DMVC4rg4pi32VwEXlW773wSUQS1lf89FF8r8U3iPyYuEn5U35?=
 =?us-ascii?Q?mYMBdpyI474exIBO2ncwBzoVNYA5ub7DIfRTAcNn/qEUUJM+ZLF06Ro3Ff6I?=
 =?us-ascii?Q?+EUuBrM1WbkQJZ4XvKaKpTM+wbqfI6N8qbXsgLGfwpw2NFBzT0bINekBlABE?=
 =?us-ascii?Q?e0FFkE4GAfgb03YWZn7odLzsS5gxmV9A2givtBU1q94I/pS8ceSDdr6UyOxz?=
 =?us-ascii?Q?7ZQmG6x5lWspL6BQng9V5ffkLJeTFf4DKm/aaprk4FD1Kc5vo46BOkk9B74T?=
 =?us-ascii?Q?egrhFGpI9yx0LyGoyPn09FhloinEghzA6ZqTkeYqx9u9AUgZ11dqaT+b7v0S?=
 =?us-ascii?Q?TtdS2D2NaER3yUuFZJw5fRyNqkxuux6V2ptBdCrgy2h95S6yCnRn1sOEXPBI?=
 =?us-ascii?Q?4GAyZqU9EoUDWevDJ9qNG9F//HjYjDhweqiraS7IT/KLmPscJ/jjQ2jLpCvv?=
 =?us-ascii?Q?811nSGCmqxI67cvTHi8tdAaphoNSLGvJeV4QMoS86dkOQYRb4lcBBfCnEV9g?=
 =?us-ascii?Q?mxS107VnyvlDSgzFmHPPSwZAKOZgJEEEBy6S9b5bAJKLEql1jgCPdUxPqzAF?=
 =?us-ascii?Q?KmBjpYUMNA5E5UDIyZMYIM0QPCj7+aAEeWWCIxldH5sWtOwlSzBLrLk4PQCZ?=
 =?us-ascii?Q?Q+6GXc7kb/5aaDBsxLO2zzaYwy9FJMBnuJGVjJfNRm8TdRuMK5cvsLnzHiCj?=
 =?us-ascii?Q?SCxd2ldFBpxpTxU+cvYWVFE5hXSypwO5ZbkJLHI/6gBdtP3Z9IVPhS4GG645?=
 =?us-ascii?Q?WLiq9xTrVoU1ESG0GBrI1fV+Y9HsQxzj0ukSq6fpNIrTSAQFqkgeK/SxbYA2?=
 =?us-ascii?Q?V5jbOw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b799e56-e37b-4422-9ac7-08db727e25a1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 17:37:12.8096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 823aSiMC0zMS4pVQ/UOCoulY4mN/uwXXYQy5LcT6gIGDVq/5LmzXGLQVQesPSmxkly6FP4jTqW3BFKW+nzVe3PSdHryZBtHTcRo2v97LrJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3663
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 21, 2023 at 03:29:01AM -0700, souradeep chakrabarti wrote:
> From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> 
> This patch addresses  the VF unload issue, where mana_dealloc_queues()
> gets stuck in infinite while loop, because of host unresponsiveness.
> It adds a timeout in the while loop, to fix it.
> 
> Also this patch adds a new attribute in mana_context, which gets set when
> mana_hwc_send_request() hits a timeout because of host unresponsiveness.
> This flag then helps to avoid the timeouts in successive calls.
> 
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>

Hi Souradeep,

thanks for your patch.
Some minor feedback from my aide.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 8f3f78b68592..5cc43ae78334 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -946,10 +946,12 @@ int mana_gd_deregister_device(struct gdma_dev *gd)
>  	struct gdma_context *gc = gd->gdma_context;
>  	struct gdma_general_resp resp = {};
>  	struct gdma_general_req req = {};
> +	struct mana_context *ac;
>  	int err;
>  
>  	if (gd->pdid == INVALID_PDID)
>  		return -EINVAL;
> +	ac = (struct mana_context *)gd->driver_data;

drive_data is a void *.
There is no need to cast it to another type of pointer.

...

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> index 9d1507eba5b9..557b890ad0ae 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c

...

> @@ -786,12 +788,19 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
>  	struct hwc_wq *txq = hwc->txq;
>  	struct gdma_req_hdr *req_msg;
>  	struct hwc_caller_ctx *ctx;
> +	struct mana_context *ac;
>  	u32 dest_vrcq = 0;
>  	u32 dest_vrq = 0;
>  	u16 msg_id;
>  	int err;
>  
>  	mana_hwc_get_msg_index(hwc, &msg_id);
> +	ac = (struct mana_context *)hwc->gdma_dev->driver_data;

Ditto.

...

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index d907727c7b7a..24f5508d2979 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2330,7 +2330,10 @@ static int mana_dealloc_queues(struct net_device *ndev)
>  	struct mana_port_context *apc = netdev_priv(ndev);
>  	struct gdma_dev *gd = apc->ac->gdma_dev;
>  	struct mana_txq *txq;
> +	struct sk_buff *skb;
> +	struct mana_cq *cq;
>  	int i, err;
> +	unsigned long timeout;

Please use reverse xmas tree - longest line to shortest - for
local variable declarations in Networking code.

...

> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 9eef19972845..34f5d8e06ede 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -361,6 +361,8 @@ struct mana_context {
>  	struct mana_eq *eqs;
>  
>  	struct net_device *ports[MAX_PORTS_IN_MANA_DEV];
> +
> +	bool vf_unload_timeout;

Perhaps it is not important, but on x86_54 there is a 6 byte hole in the first
cacheline after num_ports where this could go.

pahole reports:

struct mana_context {
	struct gdma_dev *          gdma_dev;             /*     0     8 */
	u16                        num_ports;            /*     8     2 */

	/* XXX 6 bytes hole, try to pack */

	struct mana_eq *           eqs;                  /*    16     8 */
	struct net_device *        ports[256];           /*    24  2048 */
	/* --- cacheline 32 boundary (2048 bytes) was 24 bytes ago --- */
	bool                       vf_unload_timeout;    /*  2072     1 */

	/* size: 2080, cachelines: 33, members: 5 */
	/* sum members: 2067, holes: 1, sum holes: 6 */
	/* padding: 7 */
	/* last cacheline: 32 bytes */
};

-- 
pw-bot: changes-requested

