Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21B650CC32
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Apr 2022 18:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbiDWQNC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 23 Apr 2022 12:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbiDWQNB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 23 Apr 2022 12:13:01 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5AE10A4;
        Sat, 23 Apr 2022 09:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POqKmcSxjOTBRJF0yUi2TbfOrsAywy5kcGpZioN66CkAISirDEofXs0wztwj0pWah9PWo/5Xhv59YbVRMF9saYFSkoPcVj6v0QXwCSgl1CqlQCr7B9j1u2zpO4ck3IV6PeciErwWbY5h9+FBz7KGImzy3Iw04TsTUxSHsBZoVFoORQhK+lw9WHLQA5oBaU4OTsKInmyRBsRsqyaCwAEmJFMqgh3Vp6ZW/ElvPOgV7Zb+IsYBkz+zOB3PeXr2Q9d5H29sFvdeqmCWPOoexY+7mkX01jWFgD1zan/8Cfjhhb38DeGMkP6U1zrl0Fo29krpeqZVvRb6/DHypzSmTioKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIOzQC//5Lg61psNuU3beGROQ/OGo6KgFewBNuoLHus=;
 b=RSn0axi15uc76q/oHt5GrPElcFpqESN1r+hoL+BN2cka0MC4dd6MLynZpvb4Vc6Y0fy4bvh3AQuxmv1b588cbhPNLTn50h2Yh/fkUwjNEd84kwrkmnpyKPSAp3shlpkzPmMqJHXgKXQeIehaZCON+Y4K672GNjonve6FP6OorSY9cjI6EEoUM+AYp2M+ab2xNa/HaE6ZVqiT/Jyw+Dff+7HUTEVSBFMGYPGcc9NMxjNQRSduYSrrDGWj1ZeLsiFasvA4ALJYRC/JUf39iEKVv7WH7908ELNVLGIsrJY0AYKKjGSKCcaWGglc8Fy4NhR7OiYT2fAsBVQS+ltF0+Dluw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIOzQC//5Lg61psNuU3beGROQ/OGo6KgFewBNuoLHus=;
 b=nLXMYMvq7eOz9ZHls91XIL+rDvYZJucwHSS75nrAI0qv43EC+fzYNGtXTyOxEMugmQGOYZ1uxnC3S0QC4ikcJcEF7KDwiEg9fQW3Zu0DBYwcr3e3yKZdeBWq6bXhh1UYWCfM7A04m2Hq90H/jIE0iXF3Zw8XWOgvLz/1FkhbhGg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4679.eurprd04.prod.outlook.com (2603:10a6:20b:15::32)
 by DB7PR04MB4044.eurprd04.prod.outlook.com (2603:10a6:5:1b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Sat, 23 Apr
 2022 16:10:00 +0000
Received: from AM6PR04MB4679.eurprd04.prod.outlook.com
 ([fe80::489c:22ea:f02d:ce42]) by AM6PR04MB4679.eurprd04.prod.outlook.com
 ([fe80::489c:22ea:f02d:ce42%7]) with mapi id 15.20.5186.018; Sat, 23 Apr 2022
 16:10:00 +0000
Date:   Sat, 23 Apr 2022 19:09:56 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v7 09/12] clk: imx: scu: Fix kfree() of static memory on
 setting driver_override
Message-ID: <YmQk1ORliYWEgjKx@abelvesa>
References: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org>
 <20220419113435.246203-10-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419113435.246203-10-krzysztof.kozlowski@linaro.org>
X-ClientProxiedBy: VI1PR04CA0112.eurprd04.prod.outlook.com
 (2603:10a6:803:64::47) To AM6PR04MB4679.eurprd04.prod.outlook.com
 (2603:10a6:20b:15::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b16d65d-000e-41d6-e96a-08da2543b7db
X-MS-TrafficTypeDiagnostic: DB7PR04MB4044:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB40449FB3F631788A58438417F6F69@DB7PR04MB4044.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RlLgeVF9AMUytFCchnksBsFX8Q1ZmMXyIeprQYuxvRGr0eTEzeGAO8NfZ35byTbSlwtAAX+DmmpOBbQ7u7moEt9UPUO08CyjIrqHD0UmvcgY1JcxNhC/muje84Nlg/sD7jBRvXGJ2YA7Bhq5CEgTPeThIDLo4Z7blvu8C35wHFeFbAWOe/TdoSzplohxdbaK/DtokSPfGJZDq5Pof7rZ1cvnsal9JxdAtiJ2YUDQVmJeXMXVxgm6rPoE4HVvjC86sJXDXDazw7Gh1DBWw6WHByqg/mMeEfjxSmmsq/TZQgBrf7P1est53ZzSkHsQMKB7/enLILjDHazaa8+w4hyWZAl2srhCm0eDPesfUBLUtDsi3qh2kObdHmLl13LWLMZRqlODzvVWZ37X6hww8/bLBib2jm0WoE4GBAgMe7dLRQHpGeAavSugky5ypcyCPgG6MU7zIzFRIPNuiXX5lcUQ1OJ3pxEqT+tUgGj+UC5VFmgb/dQhtp2EPIekrNQJPeysDjB9rw2Nr3HZS+Y7Kh77Wf0aVgz3dbn+wr52fi8q4/8jbusNvmlBzBA8Lc9B/dNczbpAdnDyGClUlmTWbn6zfoRt0XQb/U0CRn2eTMxVhvI1YMbcHtTnBWouORHyzeIo6Ibsc5ms/ezLBMplvhrawUMafw7WmNk2giAnJ17sktlEur8v9vjAovDVvNXxn//XIeQWfkBVgIQU0AnPrD3IBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4679.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6916009)(83380400001)(54906003)(7416002)(7406005)(86362001)(2906002)(44832011)(6486002)(508600001)(53546011)(6506007)(186003)(38350700002)(38100700002)(33716001)(26005)(9686003)(6512007)(66476007)(8676002)(66556008)(4326008)(8936002)(5660300002)(66946007)(52116002)(316002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BCz2QCshCOi4ZeSXE8b1I7cS8K7UHTXw9xrI7CG5yggrvzxgQ3o7NXilCBqx?=
 =?us-ascii?Q?MBdGJlOQ9c7LEvVyAfDxfRS+GDst17FojVkVlGMCHfZQFDHFyfXjuAWAdQbY?=
 =?us-ascii?Q?vvlpU1gCdRAiaaYwD3M6CCTzw23w+OD2LvyBQXG2/7wEzrpwdnmLE4UKFcmQ?=
 =?us-ascii?Q?hY/oJj3Spo4I4CtkFzzSCbG0Yp+Hwbws94S8gCb0Hc/8sa4P7ekdseYv+VW5?=
 =?us-ascii?Q?wGNHsLSSVJG6TnlBBh/oPDtI1Lp9qe5ZzTUk5yYvhOtini0iIKyq0D5vijoI?=
 =?us-ascii?Q?qPzUnmm5+8NCiEjz3z+gbv2AxMyD7j0pjeV8/ZTN5EuyZmrLdBE/M/2wCb41?=
 =?us-ascii?Q?0bYECZ2WSddeOl7xdq9wRTkfV0cnaAo2pq8zm0KNQJDcwMBdItXw7pxR5xaK?=
 =?us-ascii?Q?TG1epSG+8guETItU6vuJbjaprICuyvF4CZampGdsn2UL43IAQKjxFn2Bg6ZB?=
 =?us-ascii?Q?qTAsWVgo2WSqEDLsijHPA/wirAQB/jsj9pLm9rpFBVOIXUJTO+EJwrfdswuH?=
 =?us-ascii?Q?mbOMWmT4+O1gUb3T5VE2lG8QGcYa7EfnI3eTCStF9v4cQZNvuuS9QWAxhyhd?=
 =?us-ascii?Q?QKAcrt1M6RNT41CfXcTZaKNLPb/USpuELSs0FOkUa41wKdOOzYbPLQXUO0ZO?=
 =?us-ascii?Q?AOLez2x7Se7wHJZemJ+CXzWykzNqDXXr0yR7WgFhI0+/tPq37DtXCzWS7zHZ?=
 =?us-ascii?Q?Efqd8fFNEMO3EywH+eGv36rLa9kQmte3Vx6bG9OKI4TS0xczUzclenwhnjYT?=
 =?us-ascii?Q?hivsa68pK7/0dIaBpJfs4MfF0R/xIR3eOFduyiXQr8aZomhDs4R8AIILIBy3?=
 =?us-ascii?Q?HJjS4Ft2svtcYCc35wm0TzrJCBbKhWHl0JYg5pofZJZ/b2ADFk82olcH2gB6?=
 =?us-ascii?Q?sOYY7R6zQPHssGqQAxfvQyVg9WebvoycEVPkmKGJ+z6/o4+rtVrMP/zE454B?=
 =?us-ascii?Q?Xz/uHAgiZD3OSo5pFcvay4BlXBfsM7x2YJM3lUUSBMmwHXJktSbk2at+r73K?=
 =?us-ascii?Q?ramqvXtrGEUoeb+0/L9fyKnfseh0Dxof3HvWmO6U9q3eq2QuQ7POf8cBEu+x?=
 =?us-ascii?Q?lKXgCdiWGGFRNgTpj+Af52ayaEu2gVQNunqMzPrvmP6F1l8ZxliWrk8okGGh?=
 =?us-ascii?Q?oRzE9Jnfo0qyK4YxK+VLM+hHPJZ1FI/Oq3Gx0vVlQ/yGdxLtIoQz5veeAhjg?=
 =?us-ascii?Q?FcP9K1bV6VYEDwWfaGACC8tKhP3+zdJ5wOlO8okvxQmfq2Jh2iRRO/CS8bqk?=
 =?us-ascii?Q?wJoIJBEEK4CHvD56FE7w2Qk5xNd8QVr//nphvgmhD2aUt7qbTMPQpAjt2fTJ?=
 =?us-ascii?Q?R+cBC/EtyU06/7BSGrz+ieUnEJS1LMELcwIrjJGVVpSmv3rtUPCsKJYgv6Me?=
 =?us-ascii?Q?FSvblUTXsNWmb8ZlGoUwz+cC7rIMMkFSeB73RCqpTafIGCjtPtVPSdwVygg3?=
 =?us-ascii?Q?QRohEzFnfonDXNGk8hke7bzDc6N/9BjMyY5Nufd94YqeE6vzNnOJWLYTMgK9?=
 =?us-ascii?Q?C78KTCV5d1g4u5wjtxljpXnDWGijL6pa3VT7ztbaSuwhuTNhDPW04bbCKrpD?=
 =?us-ascii?Q?oNR+G56+YV9c1+XUIzNHaXcU4YGSRswFvr+tP0SAJ4qjtv5lXMtzDr76/Ndb?=
 =?us-ascii?Q?MvjCQ9amgiD3CKe5vFvdpHvIvJg93jvIgqjuPW4c+GNyZtVM9yKo2ehm8xAT?=
 =?us-ascii?Q?rVFIqCvydWedqN9TZjbjmIajR7eSmwmiLt2zjQWAF/4tFiH2yIMUExZ6RaAJ?=
 =?us-ascii?Q?qTyyklbGTg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b16d65d-000e-41d6-e96a-08da2543b7db
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4679.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 16:10:00.5900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3HnGcuBHLfKFmDVj6eiPp6VrPLDLwF51A8skzBje5u2zZVyyN42KSAwrCF01fRtEB+vjCcKSBifUsAvfL/BYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 22-04-19 13:34:32, Krzysztof Kozlowski wrote:
> The driver_override field from platform driver should not be initialized
> from static memory (string literal) because the core later kfree() it,
> for example when driver_override is set via sysfs.
>
> Use dedicated helper to set driver_override properly.
>
> Fixes: 77d8f3068c63 ("clk: imx: scu: add two cells binding support")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>  drivers/clk/imx/clk-scu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
> index ed3c01d2e8ae..4996f1d94657 100644
> --- a/drivers/clk/imx/clk-scu.c
> +++ b/drivers/clk/imx/clk-scu.c
> @@ -683,7 +683,12 @@ struct clk_hw *imx_clk_scu_alloc_dev(const char *name,
>  		return ERR_PTR(ret);
>  	}
>
> -	pdev->driver_override = "imx-scu-clk";
> +	ret = driver_set_override(&pdev->dev, &pdev->driver_override,
> +				  "imx-scu-clk", strlen("imx-scu-clk"));
> +	if (ret) {
> +		platform_device_put(pdev);
> +		return ERR_PTR(ret);
> +	}
>
>  	ret = imx_clk_scu_attach_pd(&pdev->dev, rsrc_id);
>  	if (ret)
> --
> 2.32.0
>
