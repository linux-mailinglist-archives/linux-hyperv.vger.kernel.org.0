Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC5576363D
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jul 2023 14:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjGZMZ4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Jul 2023 08:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjGZMZz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Jul 2023 08:25:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2137.outbound.protection.outlook.com [40.107.220.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C47DDD;
        Wed, 26 Jul 2023 05:25:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C35e/GNVYEyDHrtZdJgijlzGIkZKap72zpSNEW6puP3Jj+XWjEuySseqxtzCRR5YpYLryBIPwn755Q4FxJNqnWA7qE0DjROEdhuWYtUdq/kMc5zqeOa7Ax0yok6wEXD2S7k4DKeqiS6TLTrvqswiX3bmsCrdL81C7WVpwx8IsH5M3wUOhatH8TKiOVMPq1xqBJ0skuoIQL63i/BK++r/mDLGVecsjJRiiaCzsEZFjK3ke1X2OXGy8p81nr/OqmlyF3Ayd7ubxEy/V1fgf8mF9KZON3YRnbieDXN/Ye6AsGz/8otv4jb14SpE++ORk3ddQXpSztxbq7zfRMG+I2xm2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cETBaOoT1vRCQEN8MqUKCJimP81Q/rprK2aFr3cmtuw=;
 b=QQdbCfoJhJc2vXKA0caVh2IEiJbT9Z1bJ7sOWqAcJ81VwMcMJ9LPrtTiH7igsRqzV/ZOCkxCoUWu7OcA3C3KVK7pcnlKOh1BqeoFDyZz61DQ9dbYLUd7akHqAQmgYs2yiWZIwpOyIXH+409LZeA9YEIG7GbmEZa5BWuTMfBhTyY1VVgaC3+Lcv1eOtGb1bqVb0SGgmV+l/lSWMQ0iyV5BuCLFe9TYGabERm3U9PyA2Qte1aQkwi60XKBYCB1Lw0GqNpH8Oj0pfL8OMWt35nnj9va8Nu/O8D55EL9S8UCZXX28U8iA38kLqsF8XaEgMpHeJYCzq05rs4joA6r9czJnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cETBaOoT1vRCQEN8MqUKCJimP81Q/rprK2aFr3cmtuw=;
 b=XSJDjbZxqGMY+6F+4p/TRY88KYaAoOSplj496boErwrJor9v0Z6bImBwkIEvFnnG0Z+GXeX+BZCBin16BN4LPvWyA3g8hDOBugLLflPVkKH2dK2ACpG2Bm4QEi/sbYi7kkaN5nTW5QDD7P81EZgZfMDkEa9r0RgFDCmHC1aJXsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW3PR13MB4057.namprd13.prod.outlook.com (2603:10b6:303:5a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 12:25:50 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 12:25:50 +0000
Date:   Wed, 26 Jul 2023 14:25:43 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     sharmaajay@linuxonhyperv.com
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-rdma@vger.kernel.org,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajay Sharma <sharmaajay@microsoft.com>
Subject: Re: [Patch v2 3/5] RDMA/mana_ib : Add error eq and notification from
 SoC
Message-ID: <ZMEQxzqhdbNRxAfE@corigine.com>
References: <1690343820-20188-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1690343820-20188-4-git-send-email-sharmaajay@linuxonhyperv.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690343820-20188-4-git-send-email-sharmaajay@linuxonhyperv.com>
X-ClientProxiedBy: AM9P193CA0022.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::27) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW3PR13MB4057:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e22f62-3ee6-443d-b807-08db8dd372c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BKbYxR6GklynoXLSaVTM8/mh3qoUIIMYIvetXAP9eoiXlfdQqkSShYI+F6+HTCprjAz+F6sbMkbru20pjuS+/6wOm2kG1xcLVe9KEbUrCRViDDV+aBT/ybmjNWu9CpRlBtHNb6EhkFRg8Escy7SDppGrUeTzN54brpOPgNSttPgYmA3+icREPUHse8Vq9aRqyYmO3oGXa+f0VBk/0fgFb8NH34Xanp52EWIym751iw5ybcLy48WrSIjZySd+rE+Kum9XLXxz4i9X0tNpvYzgPjjHNkbTwLx7p/fJecQCwSAzNegCEkrptzxsBll+hkkShgl5CHF6YlsKV4j5JDt1rpkhURUS9qR5x+3/eq2Zcbj7yFuq/k7BEOB0Oud1FQq6dMoGxINF8EipbLC2VllW5olSMpNp8cUy/Sp4qwozVVv97wbLGrQZZ3h6zcFhcvPxl39hudiQYqRUAXJ4i0RvyIuvZX2Dl4KefwRApEASSsRkCtaFNAWC/cQzPSFpYsaYewWBeuV4e2Ad3eGDaZy1R+HJm/u9oqgPN1WP6984prItCQc+kdU9ZJJaI1uAmeUZZOGhoRVteHbeptBsdZ3cEsrLFBB6X4DhBrP7QXATRWo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(366004)(39850400004)(451199021)(2906002)(41300700001)(316002)(44832011)(7416002)(5660300002)(8676002)(8936002)(36756003)(86362001)(6512007)(6506007)(45080400002)(478600001)(6666004)(6486002)(83380400001)(186003)(2616005)(38100700002)(6916009)(66476007)(66556008)(66946007)(4326008)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4UDdjnS6q7+O/PsDvoR4HSN5OogJuoZGoON6VHvydybgmD7R3uIPBICpNHSi?=
 =?us-ascii?Q?WD3t8SU7e+twdyUdsnLZ1+2nMf/wOKmJgjSJr0TwXECOXdIzJYAqrhBss335?=
 =?us-ascii?Q?1X8oenAA0SLgvYyaXpPw45KnqKNs0EkND2X/LP24Su279iA/dy0vfYVCHBr9?=
 =?us-ascii?Q?7bf9Y59ouZopzXhxZ08QFO2V4FUd3FGIdLCcodiy0Acj2v85ywG8XdSQH6Jc?=
 =?us-ascii?Q?JnMjv/qyFKuQgwjeFqCQKGW0Zr2Sg8BX6JLmTKfb0nuDVOmxYoaSK4T6E/ub?=
 =?us-ascii?Q?qnW/UzqtNZl8lAHG+iypC1ghDeQBZmtOlJNYn3Z9sg2DR1ixozWPhu+uK6M3?=
 =?us-ascii?Q?r86hWlUYvDHz6aIoTRODWot3TZoGoGY2a4ygUOzrs7dtqdipZrGVPMRGiILz?=
 =?us-ascii?Q?AaNlsftxGwcE9C1zmRCCixSfjSCMW5EhQPxf/kpSquiLobSzcrEldRFA27bt?=
 =?us-ascii?Q?2behwYMp12h04OE7I2uA51oAEBffY44p8O6ocpsIfVMfpJen8unkOWbcSPSY?=
 =?us-ascii?Q?4QOawUP77mBp+IUDNXhR6x+DFu/4GseWFsqJJLVAfjBpcAvSyE1UqSALBKeR?=
 =?us-ascii?Q?6pcd/q6Wbcalh3MBeXDGwbh97t6zsNDL3JHtRnN1BFLwIq1LTXI853gxpX9+?=
 =?us-ascii?Q?U8yjvf+euSqdVFfxGCUC2C1RJfHxKyvzG6yhlxZRnaG8vQd9FrV96sroE5B6?=
 =?us-ascii?Q?Z84wDw0DrqnqPCMrkg1HJD2CRz0XzcxymGCkYZh67iC2P3jVYiXoJRRlQYYU?=
 =?us-ascii?Q?/xCg6TNVNhxI3BJ7Z0nPG2BHY/ienuvS9yR6FVVFtixCXHtOFZLmMClS0rtZ?=
 =?us-ascii?Q?P830CLEuvYoNlyl6OX8KL6b0be/ICJwDT13blakiz45s6JCWNmtmepMQMiIc?=
 =?us-ascii?Q?8C8XLgBnahCy9UQ3vqAbeGCFsTe8JGsRLqDlYOHfSqmSgQyCEhMg6Ltm76cf?=
 =?us-ascii?Q?Knnn6gAVNfpi1V891Rzt5Fiuvc+KAqd/IbI98mAOHxXAtS1khgSt86SY5j21?=
 =?us-ascii?Q?DnQ0aeDBkObQF+KfI1GZ4M9i3CsHmcftg5PEm0KTU+/r80xYxsSmSraPqN+l?=
 =?us-ascii?Q?OR5jIuLQF/dRtuu2e8AgGf1vJEpjhplkRPP6CrF7kd1EoWFMz3jX3jAU1RXe?=
 =?us-ascii?Q?/be0+zwhIeLSkSZO62GQonhl8km9ccih//hQnMi6KxkGqQ+MkxNn0GGqVd1c?=
 =?us-ascii?Q?HMrbMnRVfaFJCXHGXfMFHd+JW+8Iu/rDm7VDIm3SQ48NLnebbfgBcBGqwhSb?=
 =?us-ascii?Q?m9gaDhtrig2MYSJ51xRK1i1KTI12a9xWknSeYCCkmXhNiR0nzuGqsIDUyXxd?=
 =?us-ascii?Q?dUL4HCPdUPOIrBlXEa61YGcscbENVeGBX9zT20bUIMdxKHxaSUW7Ac1HVNbz?=
 =?us-ascii?Q?UNfCraWyTMRWEr4x1e/8VDBm8ixuCzFg67Moe2J8EApCbA/gcD9EkuENbWsr?=
 =?us-ascii?Q?+EOnkChXdBtDVytlUllWA3h+O1CZG7b1JK3l1RZHHMEc/dzHTzWfoDNW5f0q?=
 =?us-ascii?Q?L/kYYME0BAku8AeNTx0wai3UT+lrIZAklv2Xdd/1sRBmRZ6N86fg0/zg1WFZ?=
 =?us-ascii?Q?tber0dZwYvOmNyK+rSNFLkE2bYjw8+lWHxkZR+tGOC/xVnQ3GQbTRO9JDg3a?=
 =?us-ascii?Q?/jloeRoZhRkJtduuvpRWiwbSwGZG6CFURsaZ9cWyCIxJ6OJ4k6e/CpN6wouY?=
 =?us-ascii?Q?ZoEdWw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e22f62-3ee6-443d-b807-08db8dd372c9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 12:25:50.8622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QscXQxXLv+acUCBK656wdWtqH1v3UYFdCImf57QegOvPcxu0sxN/C4ZA6jkOJV4kQJsGn3V9hc15wDMOJ6I/NvltmEGB2YNMTtEds1Rt2G4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB4057
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 25, 2023 at 08:56:58PM -0700, sharmaajay@linuxonhyperv.com wrote:

...

> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
> index 2c4e3c496644..2ea24ba3065f 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -504,3 +504,47 @@ int mana_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
>  void mana_ib_disassociate_ucontext(struct ib_ucontext *ibcontext)
>  {
>  }
> +
> +void mana_ib_soc_event_handler(void *ctx, struct gdma_queue *queue,
> +				struct gdma_event *event)

Hi Ajay,

I wonder if this function should be static.
It seems to only be used in this file.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c

...

> @@ -435,44 +434,47 @@ static int mana_gd_register_irq(struct gdma_queue *queue,
>  	gc = gd->gdma_context;
>  	r = &gc->msix_resource;
>  	dev = gc->dev;
> +	msi_index = spec->eq.msix_index;
>  
>  	spin_lock_irqsave(&r->lock, flags);
>  
> -	msi_index = find_first_zero_bit(r->map, r->size);
> -	if (msi_index >= r->size || msi_index >= gc->num_msix_usable) {
> -		err = -ENOSPC;
> -	} else {
> -		bitmap_set(r->map, msi_index, 1);
> -		queue->eq.msix_index = msi_index;
> -	}
> -
> -	spin_unlock_irqrestore(&r->lock, flags);
> +	if (!spec->eq.msix_allocated) {
> +		msi_index = find_first_zero_bit(r->map, r->size);
>  
> -	if (err) {
> -		dev_err(dev, "Register IRQ err:%d, msi:%u rsize:%u, nMSI:%u",
> -			err, msi_index, r->size, gc->num_msix_usable);
> +			if (msi_index >= r->size ||
> +			    msi_index >= gc->num_msix_usable)
> +				err = -ENOSPC;
> +			else
> +				bitmap_set(r->map, msi_index, 1);

It looks like the indention of the lines above is off.
There seems to be one tab too many.

>  
> -		return err;
> +		if (err) {
> +			dev_err(dev, "Register IRQ err:%d, msi:%u rsize:%u, nMSI:%u",
> +				err, msi_index, r->size, gc->num_msix_usable);
> +				goto out;
> +		}
>  	}

...
