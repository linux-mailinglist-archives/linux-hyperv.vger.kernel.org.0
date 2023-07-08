Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AE074BD9E
	for <lists+linux-hyperv@lfdr.de>; Sat,  8 Jul 2023 15:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjGHNbL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 8 Jul 2023 09:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGHNbK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 8 Jul 2023 09:31:10 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2131.outbound.protection.outlook.com [40.107.237.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C377102;
        Sat,  8 Jul 2023 06:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCNVXJ2KGxA/mM9KlbS5vFF+9wQbCaj+uZxryNN/9QJ6XdGLtRY2TyShy3Q0URBdYhdSzcGnZhlOeSMp7pkFX62LvpTeXqXG32t3rajLixSVkpGZzSRqxabz8bUV7S4sdR/4aUruBINFQprVVv0egsE5khtY9tYcV+pKfac6zcqJgkNjAO8mQGk3LQJKGpaz6t+cefYVVvATXAA63gohmmLLsKtVPlbRgti+WQpIKg4ggG0SmhHVDE7F81iujPQ41c7edsNaFZv2JD77Ikxjbxs1XwjBnedkOer4t4RKPgKNr2jXJNYXoftgfN495HEEiWo6msvEa6/6txZ4SGBFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mU0xSFHxoU3hix1B2fhewV8JVnzD/rFvILzxWUbbsbY=;
 b=MTZlAS7S/Uy79KmcPP1+KsskWodatEJjtzn0oCZN8Wa+wvrD29ACyJy7anAMxjsPlcgSmxQY0tg8otMf5peRMeR04T3MqFVzZi0Z/wmrzG2jyBP1J5TtBQ468YKCF/+C4Vgf3YxzYUSpZxBC/NOa9bmJ+txe+6ffbAokrde2K8bW58LS4ZG/mvVIfDWafm2ZWJZoLurnbu/xhEPrh24ZhD8dd9cneyRLZo+bTRIwwkOEmF/rdA8I+Qs54jl8oltUzRm7w2udQsQHs/NqoS/fcylnA5f8ZHCPp5UB308Ko8XEVSM/3d4QYLjJjsT51tpJm4CA9quHQiSUeZYMAY5S0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU0xSFHxoU3hix1B2fhewV8JVnzD/rFvILzxWUbbsbY=;
 b=MSLGqfOWOL5FeCBOlzye6+EXLkyVo069n4cmn03MFGi3+88ynpjvv2yLDVQ7HPkwhkZf8LTKvjmuRR8wzDRAd0Hl4rsmPuM7NDWJ4CyRtI1piWq+5pySvwlUPdPSsae34iJKGH1Dtg17pW+8WVv316Q/d1S/lYdmryScQSXyDZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH7PR13MB6266.namprd13.prod.outlook.com (2603:10b6:510:24d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 8 Jul
 2023 13:31:05 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6565.026; Sat, 8 Jul 2023
 13:31:05 +0000
Date:   Sat, 8 Jul 2023 14:30:55 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, stable@vger.kernel.org,
        schakrabarti@microsoft.com
Subject: Re: [PATCH V2 net] net: mana: Configure hwc timeout from hardware
Message-ID: <ZKllD71/JLDreFKI@corigine.com>
References: <1688723128-14878-1-git-send-email-schakrabarti@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688723128-14878-1-git-send-email-schakrabarti@linux.microsoft.com>
X-ClientProxiedBy: LO2P265CA0257.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::29) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH7PR13MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: a13eb260-8780-4988-33a6-08db7fb793ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NilZaf2ZYxB7aMUgagh3dnwGFJMWNmnNEm7frv4wNHZ/KuN6HfNlT6lx7R7XrIAEma5p1qj8lyRaP6Fdp6j2R+jXpOttGRdMUh5APYNjSkXfMZbHrzQIUptyrayFYVYrGb43tQiTupnJW46yo7e+f5Q/PEm+HvscpjxY7DzTFlrhDs09Jh4zXwDk+7mKtbM3xMwqjz9nFdg4sqKtqVPgO8vcDS0RJyBqtMQFAnGiNjgdQ8vptRptPSnuFj+XWv/7xad6Mzihe7tKs1UAMmRPlMVBnmz9luCGgOvhlMUB/5ACv9UyIRAeF3DjYJb1rnMl2qb45aVH9Ixis4sT9m9uXMCdtlCfy1ISO8c640KetVRX2wrsG9elkcC6X26Cc11iINERu5YGqLe6Pn9XbMLL+wiUc/gKT70FVSFez5RbmYsQMpuw1wQyTWPzPRENrMY9wF/Mbij+06EeUSRxaGAkFZi+1uxAbFLZFm+Km/EX0H1Mc54saG52ygN7w2/szft0a0PNK0xFeQJB716+paFuRUCQBlD/4F2Cc6OAGoXH0yxOTOg5X3RKI5IPGwVH8CwW0v7NMGBCgDyRRYmE5YWZnxBWUeqDjkowSmSl5UdYtr4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39830400003)(376002)(346002)(451199021)(4326008)(44832011)(7416002)(66476007)(2906002)(66556008)(478600001)(36756003)(316002)(66946007)(6916009)(8676002)(8936002)(5660300002)(41300700001)(6512007)(86362001)(38100700002)(186003)(45080400002)(6666004)(83380400001)(6506007)(26005)(6486002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NWweubc046I03eOd7w1TVYwefxtmpAm7N80eOC8whx9KT9OyI8JaijvnmZyM?=
 =?us-ascii?Q?Ks/lhFaavb+oFPsOHNb5GT1aRv8gbw/jnD6aIku7G/hTltpHqbMTrCcxQpWd?=
 =?us-ascii?Q?JhHuDmKOOfyBTzEL+BAGzMpukd1WHvi9G70QNsQ5ESMomckiHtaUGT5JiDCq?=
 =?us-ascii?Q?KS+TZPAXb1/igPkc7FL3+zgFTH9SIva6Lnm5SrvbPW24qD6kjgfjC66HbQL4?=
 =?us-ascii?Q?V7xGUr6PuKJnxvXx3a7NDFTI4Sv+YZslpjQK9X0ADewKChaQrTsjcNlr1sO3?=
 =?us-ascii?Q?+qtWyQvOVqizKdGj+GRllKgGF7RWR5MT6/a1OV170Vr+bDgAebQgam6hWKua?=
 =?us-ascii?Q?JXSD+soU6D5edAnlyXkIfgw2uI1zbkAaGAR0BNa116nEdyqv7RU1eDKwI4Ri?=
 =?us-ascii?Q?VG1rINGoIJTQuZqclW6q0p2CrhACe2921h8+CT7vxlzpBJRULEKKYG1sqoIy?=
 =?us-ascii?Q?iVWc9twxDs5GsvM5jHUDTgTRSH937Vpl85YY+baO+vFgW1kUWrjfhpSzTZlD?=
 =?us-ascii?Q?nIi7tAkwjwBsCbetXaqlQXtSr1KixAlxcIhqUa+ITAP0KmpBbd1AYXyLPPtY?=
 =?us-ascii?Q?ofBcbeTs2TVTJVpalHlqimAsnRBLjTGvFYrFSi1llo8GHB8m5XkiyCLTiXEY?=
 =?us-ascii?Q?qDRUUJrPh3HiW4oviIFL8hJaOInzDbbDiHGVw5hY2k6vvq1bDnLI4IdPMlBy?=
 =?us-ascii?Q?cpJ8CrhuU5Me1BDRmlrqcwIaIHg4lcZVxymsfA6vOoFr6Wm5aoJ3KFNpyRx1?=
 =?us-ascii?Q?VQxnPrX2pXPo6fZIor6aR5YTem2NUPVb4Ljht3nCNoHKVSiOKsD2lY53kaq9?=
 =?us-ascii?Q?G3oax6a/CK3w1EkCyFUnubXX3ro6ILEgpG2MrY/jC4WeCiDZJ4RcqsduL8Qq?=
 =?us-ascii?Q?LvWCltV1Rz9tJU712umlTGPGZYlSRhvxFQMkNs6o54EES4ZO8NqDx4frdtSI?=
 =?us-ascii?Q?BdWK1Kbrj4IVCA3t+4ISJNqjJDweY3+oVmJ2daYIWQ8Fqjc9h6g2RhwhRcN/?=
 =?us-ascii?Q?ITmIcjFvtI1eG8y8CwTj08uJ/5s7lmxgsiSxIvwUHwIzGmwrbGProP4LVPNz?=
 =?us-ascii?Q?pKHWkVFneE/Su3kfpkKU8FEU8MHcFRNfKfZppX8k2g6WVD/ywIoiOGq6Pvjo?=
 =?us-ascii?Q?Hb8rrbYk7vvjFWeXnoh0zn1daWhWPKU/EWOdLqFp4SnPVCRZrmZW5gzhVwWl?=
 =?us-ascii?Q?5lAWhw0FrfCVplUtCURl8fT26dv/6ff992/i4esBrEkCrgDlRu1I67Q1eAZa?=
 =?us-ascii?Q?TxAyQ1hLTnEyF0PFPZB4mByYN1xmSiuCb1yJDyShL3HR8MKBZ+YVJ2qc+bkO?=
 =?us-ascii?Q?hgy7f8yTQD6qAmLeeyciFa3OAdBssKpmB0vtw3ERgT48X3fTiEbZQN3wB720?=
 =?us-ascii?Q?PHMeQq2r662qOHX6L0r2jIw5swOgf9QOX8fiIfY9JLItHaRVhRglavFDjmsr?=
 =?us-ascii?Q?nE453as+jjBH0OTae3O7lcFAG/aWonBj781VJC0KcO7uUkpJt1YGftg6w8ZP?=
 =?us-ascii?Q?F/PHD0FO4VJ3ETTiouLW5Z65lVwzL3sjDZ39NN3jDgooKnWZZ1XVJzeODCcD?=
 =?us-ascii?Q?QRRmxU1UESVEZYppl+PtW/HfLXqn9SiFX857K0gzcj/5zm+DcyoxbfJ1O763?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13eb260-8780-4988-33a6-08db7fb793ea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 13:31:04.6686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tl/4BAaZT5B23IkhJx38JxfVfdYm+ijcPDcAsxwNhwqyjKURXHcyS357ffkcUGT+Cacg5xGA1OkLKXGb/bc8VRzNbNP/7z97BZ8MV6FeItM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6266
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 07, 2023 at 02:45:28AM -0700, Souradeep Chakrabarti wrote:
> At present hwc timeout value is a fixed value.
> This patch sets the hwc timeout from the hardware.
> 
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
> V1 -> V2:
> * Added return check for mana_gd_query_hwc_timeout
> * Removed dev_err from mana_gd_query_hwc_timeout
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 30 ++++++++++++++++++-
>  .../net/ethernet/microsoft/mana/hw_channel.c  | 25 +++++++++++++++-
>  include/net/mana/gdma.h                       | 20 ++++++++++++-
>  include/net/mana/hw_channel.h                 |  5 ++++
>  4 files changed, 77 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 8f3f78b68592..949c927c3a7e 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -106,6 +106,27 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
>  	return 0;
>  }
>  
> +static int mana_gd_query_hwc_timeout(struct pci_dev *pdev, u32 *timeout_val)
> +{
> +	struct gdma_context *gc = pci_get_drvdata(pdev);
> +	struct gdma_query_hwc_timeout_req req = {};
> +	struct gdma_query_hwc_timeout_resp resp = {};

Please use reverse xmas tree - longest line to shortest - for local
variables in Networking code.

...

> @@ -879,6 +900,7 @@ int mana_gd_verify_vf_version(struct pci_dev *pdev)
>  	struct gdma_context *gc = pci_get_drvdata(pdev);
>  	struct gdma_verify_ver_resp resp = {};
>  	struct gdma_verify_ver_req req = {};
> +	struct hw_channel_context *hwc = gc->hwc.driver_data;
>  	int err;

Ditto.
