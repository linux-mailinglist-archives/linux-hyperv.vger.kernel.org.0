Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7438E73CBB2
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jun 2023 17:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjFXPtD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 24 Jun 2023 11:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjFXPtB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 24 Jun 2023 11:49:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2115.outbound.protection.outlook.com [40.107.94.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233451BE7;
        Sat, 24 Jun 2023 08:48:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ichZ2Bgz5mA5E/4YnKiF1hMkcDy1v7mDodxR/T3TWRlBJddL3XteA0zUjYNkq6jD6LrKVcST2NnvhC6PHRUsBVKmHygci14d7ldmWR2MbuOsC/bXdxEo1GtKolOXLikCssbF+7kwm4EDTnJg863WRZnKeYlzuqG4rn1sOqUeKVNDcH0c6H2aHQIdWkCSdjt+d4jtqOiDK+D1wAYvDiiLILQfrcw0Vz9erckWBLveIniRfo2ztkPGK5J/p639SLoDMXXkPl0g7ox3301LeadFwdQ5BefJ6APfVFG60qI3J4h6rd6Eo7D+Bx5wVCo5L/aUUEbrYZ+LpZJKIuCIKn/xoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBjTc5QsatARqQrPxSzd81NbGM+8JpLVJ6k/nLpDd9w=;
 b=WRRYfJNVXJkEGWzYmUqhioweUWkmwMlgsdoOrqvW+gicLU6+99KHGoNrRJNrmk1qU6PJ/iu/YadcB00Wq0cLHTzpqnlsLQFfQcD69sX73nZeRwSWaJz40jwtKR1GLHsMRgnimV/Pd387PUO9ymatxtgICuX4zm2IR859qYp2MjhaIrgUU9my6+KT+O7RIP6DIgxDn86S8lqihXaqM+B4xj4NvEZ2x7ChQwjr6ZfwcJQHst3f/3HMrcBrcSRMXk5nVbJGYTk7CYShUNF53xllkIZwdIJtDNCBhJguxNtAeDu24zke98aotPx0gFmg43s+5vnbb6DjW49yFh4g1yjPXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBjTc5QsatARqQrPxSzd81NbGM+8JpLVJ6k/nLpDd9w=;
 b=ci67b+OR2emKChvjHs3gDf8Lxt3hbnvJ0E3+EqxaW3fdiHKf8civsbnQwWQvrSQaZu0gRKqT3H7jeflZr/yW8j9Lad16Zv4a6K7h+L3j/c3P88ziOiVaOrWUgOV4gGIl68KzGm/m5vmFh5RZPMFRGYbnejtdZs+DNnbxhPSkPL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA1PR13MB4895.namprd13.prod.outlook.com (2603:10b6:806:188::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sat, 24 Jun
 2023 15:48:45 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Sat, 24 Jun 2023
 15:48:45 +0000
Date:   Sat, 24 Jun 2023 17:48:38 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>, keescook@chromium.org,
        kernel-janitors@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/26] net: mana: use array_size
Message-ID: <ZJcQVj/ZUABoNlKk@corigine.com>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-23-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623211457.102544-23-Julia.Lawall@inria.fr>
X-ClientProxiedBy: AS4PR10CA0027.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::17) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA1PR13MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c4116a0-edf3-47a3-0e16-08db74ca7e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQxfGGcawbbKqmrRCQR8wTBasKrPMhKtwsysFksWjahZm+8NXIGurQEmCXkeVuT6ojBUOV9Hfdfl2W/BwoCNHBVtUe26MwPrGDPbvSCL9QmDS86MQnpQqCvpWWdz/xcoAoBCM3fDO692JefNQk6Eo6Z171NgUgnRDDjkO/pw5epti3jhD05WBXXTA7uNP+/Q0Bqnj0O7ZvwM3ElVwuEfRN6lD/iDXGinv9Om5ZaqEOQh0/z8vwJ+plIR1tIz/Bp+MledU2XwyD9gb9MHzLDzk+PR6qD8wW8IDS5YQQLsDrBfGU8HIC5zRxlbvlbpy8fOoMrOxlnkULr4eVuQnLFf5wyQ4pfiUQQogzr2mTXC5QAw1Eu8/XsU8g2YiiUS3nJa5o44fNB2jFPvGIRSmGq1FkqQCz0VTzrUY8D7MBs8g6CdqZWVmCyxp/9HLuBoycsBPFNqy0cIaU+S9eigBWu22s6Exh8mjwXg9uNs7FBkpArQQIE5Rsu8ewHWKyjBylIKWeHQyp4Y34vp2gOtvlRZi2n7dpUJz/bN8PjDVwKK4QYi76Zvpt2gsd/zQHr/JF6+jYF57QmbFxcHOAMSQ1YMxZsWeF1qtFryTuGRv72OU0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39830400003)(136003)(451199021)(36756003)(5660300002)(44832011)(7416002)(41300700001)(316002)(86362001)(66476007)(6916009)(8936002)(8676002)(66556008)(4326008)(38100700002)(66946007)(6486002)(6512007)(6506007)(4744005)(2906002)(186003)(478600001)(54906003)(6666004)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xNt0t71DEzKPBslV993ZAaEARLUh0hL6Rb8U5q7jc6RBc5E91y2BEPyzBuei?=
 =?us-ascii?Q?Xdzi2S8pMFBLGj9IZvq1rfCehLbpQnPG/jiCl/4OqcG803C3UNXQUjYG7FvE?=
 =?us-ascii?Q?R4uPcFGjpygkS3d1oUBvH/yatsxY3tzqeK5Qj9xx/AD4r+MtXUeUMPvu6Isv?=
 =?us-ascii?Q?GLSL8li/wyhnAey42XaXpOReQBQ/8WprD9MUQ91vNBsiu0zq/OSb9ppIkEIt?=
 =?us-ascii?Q?wgcvZ+1qP2K5k+mls7P07S9oY5Qndte5yUHSYG9tg44hYAjeGinWqhUxwgSM?=
 =?us-ascii?Q?rJ4V418SZ43Z7i1+yDpUIKEPu2U9k7/Rx7qr9PSDRCUmwJ8lWPq2U11Po9hA?=
 =?us-ascii?Q?hgl+H9wz+0z3SizyUML1v2JCJrrTI4NXdCQZq7FRT4g/123gDptq6w1BiEJH?=
 =?us-ascii?Q?lgpN6vnyGFHM1F4stjfqP2VWociL5z/wyxERZT+qREr2ni2ocqazIahrr8sb?=
 =?us-ascii?Q?X9MWBmOMSGh6KnvhuMiHFvG/jnzWJCqApivSSlgoomKVdIuf8F1h8w2fvknq?=
 =?us-ascii?Q?QtDL8YlmZV5500j8LnlzzS/jRVP+hTDmZYtUVg1AItWw/ND+UnE+8Lqxjxhj?=
 =?us-ascii?Q?FtFsTe1Rx27+3lWrbstlitzPgAeGEIUh76YJV/tcTGQ/h7PyFf1ux7oNSLZy?=
 =?us-ascii?Q?//IGUNl+wAe0DqaqL4gm7MhCy/V1eqTUmfD9YNcyPN764JXojFDUhCbQkpn/?=
 =?us-ascii?Q?P6YKEry9JEW6dD3RUVt9vT1L644xvSn6PnslcmnZUPt0pCAQZnl7xaXzuRhR?=
 =?us-ascii?Q?bX9+KG36mH9aJv6tF+Tk3QR3D7Eg/aPBmuOuD3PwZsT+F4GMvgJQ6Namt8fU?=
 =?us-ascii?Q?NlEc86PE/8lDOjA2xt6WVexj1vL2swvLp7t4rsspG69YfG+ZhDtSJ8wv5kPS?=
 =?us-ascii?Q?0z0Y6XPM3Exn9QBfe+H/qPHA9q7iGAVVIHiVPwGMitsW1CNCqBxss/iof6Wj?=
 =?us-ascii?Q?fNGa4E3sVypa/KZH4jsCYJZuCxciMOsrQZATIJwxvV8yDqew56239NOeeiYw?=
 =?us-ascii?Q?fHBBcbHhLsNUEoGPlcLeppgz7QbZK+IRR2j0DPpgbEfcjcW8VAPOAxTkMsCf?=
 =?us-ascii?Q?3a4kZBKggKfOpfaEkY/ejDSSrBEzcYJWiJApM0Dfihu8qauv15oKXcx3sRZL?=
 =?us-ascii?Q?WsAixy2CnqtneLkCeXvnm2RfWPxaANbfDeJzQZVf73Dbv4j2OOubOSQdkHmq?=
 =?us-ascii?Q?4eacPwIfpYl1Ig6Sl53DMfozDkBK6+pTGloWPO7V4Hre+8IyYFMnzwx69pj5?=
 =?us-ascii?Q?5OcuoiyVH5KAg5AZLC4ZGZEYFdUfVai7gDmmV3U88slvaH8Zs3FCSO9N8Vpg?=
 =?us-ascii?Q?Ty1+7RrE5rcz+MMVV74gREvH10AkrMrNV/1dwWlT7lH7jQy2vfJYTRNSVloF?=
 =?us-ascii?Q?hWmSMYe7b876sz4bXG5AVzSRzK9PAFzy9a5xta/MFiIGzvs+CcqfkFQ+K8De?=
 =?us-ascii?Q?7x7UJ5nE0YZU+Rx4zz1vdQcJmrxjZNuCIt0MDYcy8wCq4Og/HwLTrShCqR2w?=
 =?us-ascii?Q?tsQuvosjqORVCEBEDmIRVBid8BQvnMV4+AVvi0ifFvu9/XCJOPpg95nCXfJm?=
 =?us-ascii?Q?qxuiZCeXq+8bIZ0vqvrzrI1YhtAUJ7NIKiT43dRjZIJQCzPJISWaxEk7WRc5?=
 =?us-ascii?Q?tYNPfQK+oiLPEG+1a2c7lLni3i9P+Qrslr17s/i6rZmN2d1qabdgxZwMz1ic?=
 =?us-ascii?Q?CJDY5A=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4116a0-edf3-47a3-0e16-08db74ca7e25
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 15:48:45.3497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWBz5dTUafkeGv12YzP+k5SfhfyrJaAzFvpEuhMuf+DImuo/CfzoSIZAgZcqCYdxFAnmxaJR5JIyTtikppqIc1ufEuUud/VqHf2JRM9NV08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4895
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jun 23, 2023 at 11:14:53PM +0200, Julia Lawall wrote:
> Use array_size to protect against multiplication overflows.
> 
> The changes were done using the following Coccinelle semantic patch:
> 
> // <smpl>
> @@
>     expression E1, E2;
>     constant C1, C2;
>     identifier alloc = {vmalloc,vzalloc};
> @@
>     
> (
>       alloc(C1 * C2,...)
> |
>       alloc(
> -           (E1) * (E2)
> +           array_size(E1, E2)
>       ,...)
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

