Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFC573BE02
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jun 2023 19:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjFWRoc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Jun 2023 13:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjFWRob (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Jun 2023 13:44:31 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2125.outbound.protection.outlook.com [40.107.92.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8071FE1;
        Fri, 23 Jun 2023 10:44:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DH+z5k4cmr3gry1CIG9uwPSdJLlyb5xwud947AfROrV8S+gCKrcrdcBCVwjWYiDfA3UfaXJWHufed8aUdwl2jvXkLHvxijIv/cem+NYwNeSHH/IJN6auIjlTaa3Vdog1ZvCz+IADjyaE++xTHegh2t6Q+rCtgPeRBf0bEhVnEezrSHcsFQqGeQscFpqruNDwbx31CRXge16Vq51B+0R/XhXivikaaK5R4XVtb+sG+WL5mvCPzNSMevhv6/EVf1M+k0Avz+xI28Cl6L/v3OJsjwLQ/PhZyPjIhHoGrBwPA4i/zAdYA2FCeeOf/z3Fzdfl1C3LBD9qGhYWSqvLvAN3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GJagJq78RrQqsLRBsc/j88/H8Y45YItuFU2NiLio7s=;
 b=A6lNU694Nxtz3taqvUWo4BvftoRl001Ib81Vhb0zO41m0Ixlro2XMyC3+65eVQXj7lazJvH6W6cbocYeijSh5EgQtq0zCwLbHpq/Q47aVkgXwdr8Al/z1TvKVsTtXRW3MczWPr2b8KTG5z/90iCN5MigZvOw8S0gf11JiWf9PX1Th+T35TiXvHY3JVhY/2Y/ED3HX+0b0xvPH5oNy1cnjTXXxIXju0WJtc+KrzPYb92tPo7N27arBQGMaybXn5Gwixl0srQduUA+7YgzlLPQ44CQ78vDc4WI9zznBS4Y2hvkEJIGgEjFpPh3HE6FDBaIOM7IBHpOEe+wbzGf3erhww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GJagJq78RrQqsLRBsc/j88/H8Y45YItuFU2NiLio7s=;
 b=fYRgcpStELyyii7RWyks1yHe1++F70SovucYUo/qFsyBpspJ9dVHVHyhrIeJrA2I2Hv0xwIYUGAyNhVzBw+gbMwmEW/RkJhjzJjztwCx2vzUgvWrAPlx/aYoSd5+yrFaFEvFURvhBYnBUcYQHcc6v2jPnl4fcvfAy6qQToYk2Rg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO1PR13MB5013.namprd13.prod.outlook.com (2603:10b6:303:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 17:44:26 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 17:44:26 +0000
Date:   Fri, 23 Jun 2023 19:44:18 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     souradeep chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, stable@vger.kernel.org,
        schakrabarti@microsoft.com
Subject: Re: [PATCH V2 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Message-ID: <ZJXZ8mg5uw8MaKuP@corigine.com>
References: <1687505355-29212-1-git-send-email-schakrabarti@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687505355-29212-1-git-send-email-schakrabarti@linux.microsoft.com>
X-ClientProxiedBy: AS4P189CA0039.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::16) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO1PR13MB5013:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc1bacd-5dbd-42e0-5744-08db74117cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xiUp09CUUMRe6yAoLTuRFmJZH6iZLOG2Aq85b5nlNy64jb3CC0/fy+W2rX/0VxsF1IheAWdXdjnm+1mkqC9OnGc6A+fI/aSTIEb9zgKaJTNrm68RDNXFPvw42DXLEXVnLrKWTFnwpbK9LvTv39fc/lnCIEdp4zu5T65RlnVjWRqkOif9R/83UOPzClh3jXmi1dtl1UXvQVkAeWRJQuu89REbrIQdDESBs4t7MCw+HPmp+5057N4UwWFkzDeiSLr5ecL51x13OmjkFzPu2eTmvF1Be4CtkxgaGotlJXfuloAyO31eg2PsRVmiMR4sIZxmVlLl41wzottkOIZC7E+O67uZ9yYCiZnbrusT/3if0VQCkqdC+OaxL3pIU6TmFRHNeZOP5H/7WVIvn81n586ivpfPey6hBlatEL6Wef5M653+HTT8AgqMJpHjtj8bdc4iw03giO823uAwCm3VQgQiS345S0TcXAstmDY6lT9REFD6lXAt8R2gMvghTf0ZTs1nTtPmxmFl4zJw5K5qQyRvY3WlzF/VZ3zxNmIfibHJwnN/s1ffzHPAtWklyxLpWFqT0Xfx4YHY1AshFFtVjIrfFE5uilgCrr6g7XdpOGWGNcs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39840400004)(136003)(366004)(451199021)(7416002)(5660300002)(36756003)(66946007)(66556008)(66476007)(6916009)(4326008)(478600001)(316002)(44832011)(66899021)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(45080400002)(6512007)(6506007)(186003)(83380400001)(6666004)(38100700002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lumf5ZQc+KzZ4W7cZXTIGACiV/EPRTiJFdnYVTTtEAyuLXnUoD7ziaZX7fva?=
 =?us-ascii?Q?GO/TLzcINvCWjBwp7RKfQ9ZoXICfR/ZjHGjR1xbMxnG9v+g9vx696JU+2WCh?=
 =?us-ascii?Q?P+u/LKY//VCwnUEykLsOFMHv2ZiPJcA3pFSTrCFlq/bhsje9BsNXsoxE7Uta?=
 =?us-ascii?Q?dDBeF1Wt7ADR956Cxdzd1srkaGPkO/c81nGmYkn9te114OK3PlXnjK9AcMuc?=
 =?us-ascii?Q?NCIalFwwKvy1GL43mF6C/nrqutg94JFWmyjxSARPgDq3TSbrvfZqep8PG3vY?=
 =?us-ascii?Q?13tA6zX/TJ9E+T9WnnTiWxpgwn9Pu0tO/rLl4XMILKHYffB7m24t6q2JnOgt?=
 =?us-ascii?Q?/+fSXcCY44PsDuKE2L6d6MG7yL5lg211YX5IrdV0/UkBx+zXR249jVRzK40z?=
 =?us-ascii?Q?Pbzwlf8Yr8jAYr9Pg/9dp+QbDbeo5QCYebRJQN2hwigaGgnGzwyyiPKpKhQq?=
 =?us-ascii?Q?x4SgrMmWqDLkORZYZV1ySv4k4V1XcaXRnlj2blHNP6ouTrKRVGnY5pwpougb?=
 =?us-ascii?Q?6M5YBS0BOxUlJa2e+Z0/tbpbeG87W6LHRXolp4tt9v0nIFrtDyRcYFJRuVwQ?=
 =?us-ascii?Q?/GMZgz9vwTpO5q2Rg2RmQD35oHi+kEz/ntgugcDb9hkUVQNnKE8T1g/IsNM5?=
 =?us-ascii?Q?8mxlOMPOebPCjgMSkXckFRW5gfgIfnkLDDStOBPuIcTVE39LyLW1IiLPxHOa?=
 =?us-ascii?Q?HyH67qjdHGR6aZFEDWiqKO4ZAaw+vjaLp1kbO1VMKx/wqgjPpKFKb1xkOS4e?=
 =?us-ascii?Q?lXQQ4DQnLbM8Tt6B4HZYlw6pHi+ywvrUOS/VYmKclm8faG3+irktLXNFbX4J?=
 =?us-ascii?Q?fSQ9bbXkEbNefJldtKOROD173ssH7oAH0XZWtbObVjp76lg8d8aJZIvw6Ua3?=
 =?us-ascii?Q?z6qFmOA+3Asgax3gWmG8W/bgTxDXHHBLv1iy+VOsxf4CbgQfXEBZ0d25Ww/N?=
 =?us-ascii?Q?uXTJWizjjOJTZxr83nvYDqAH1BtLYW/4cmoq29lUYwmE/5t6P9kkDsUW3t+w?=
 =?us-ascii?Q?lDjoI+umn6U2dgIwRH5Ys1xnziJ1O5AtFN1Br7N8nUf+ZLKTGqoMCFAYtkHd?=
 =?us-ascii?Q?jTeTIiioy6QudHBNkqcUvWjf9ThXGM0EK4eUnzeRHkyX3zZnp4dkDslTlati?=
 =?us-ascii?Q?GoUWtZYk/ur8LBaeTIt8wQe6F+bxehOFNVSp6NI8Kjvv607xKlFMPTqtZCSL?=
 =?us-ascii?Q?X2Oc+TLE5yEEmwPq+e0KQbxlGGxw8dbJMvDW+bZHwvMd193+T5Ft1TDVe0gP?=
 =?us-ascii?Q?ZGHLBJ8sh12uWAEPWMc8zBBZcueVOowyqiKEMuCwdTJNupI+i5P5iVG8j/t2?=
 =?us-ascii?Q?u2APvuOpJiQOkeBgjbKH7zx7inXoLHFin3w3oku5c5+2XnWGfflj4V6NddEt?=
 =?us-ascii?Q?dqUgyCrEBPQ4XbHndjH14zNiD2fc/Gt0CFY77iPnic9OmOoZhbsH6J9rXxUn?=
 =?us-ascii?Q?02L6uY77/mwxoZ2goekDwaxf4jQ9ul2wuUoHc8+CrSVXQoHswm8IurOljIwm?=
 =?us-ascii?Q?n7EmNddVYeLooixGHRGs1FaQOf0br5gFnveIBGa0N09wYVu+Y4up2NDhnbgd?=
 =?us-ascii?Q?Pr5GR8piE9QmRAKSccnw5QOyOV8vCA5zyB6QfXifZIEuGR23LOhaEdY/lpmF?=
 =?us-ascii?Q?81i6jzUl92nHTdV7PVUotBDVpZo1o5W7MDKpClM0yULMp4IM85nbWI5l6epF?=
 =?us-ascii?Q?VLQ0SQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc1bacd-5dbd-42e0-5744-08db74117cc8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 17:44:26.1875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGH84QP8Q1Ha4XezUYHmAfKXxouYIc4kCGe4ONg2RInGgeTEgQrll+vFKzvBNu3UIiycJ08Oqu1rEjv8vaTToOiWzT77/zrdCJeYFFFi9BE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB5013
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jun 23, 2023 at 12:29:15AM -0700, souradeep chakrabarti wrote:
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

...

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index d907727c7b7a..cb2080b3a00c 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c

...

> @@ -2348,13 +2351,26 @@ static int mana_dealloc_queues(struct net_device *ndev)
>  	 *
>  	 * Drain all the in-flight TX packets
>  	 */
> +
> +	timeout = jiffies + 120 * HZ;
>  	for (i = 0; i < apc->num_queues; i++) {
>  		txq = &apc->tx_qp[i].txq;
> -
> -		while (atomic_read(&txq->pending_sends) > 0)
> +		while (atomic_read(&txq->pending_sends) > 0 &&
> +		       time_before(jiffies, timeout)) {
>  			usleep_range(1000, 2000);
> +		}

Hi Souradeep,

minor feedback from my side, as it seems there will be a new version anyway:
I think the braces - '{' '}' - are unnecessary above.

...

-- 
pw-bot: cr

