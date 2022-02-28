Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3860A4C689F
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Feb 2022 11:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbiB1Ky6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Feb 2022 05:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbiB1Kyh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Feb 2022 05:54:37 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50089.outbound.protection.outlook.com [40.107.5.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1376E56D;
        Mon, 28 Feb 2022 02:52:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxHH1DS+T8wJ8qh6aeTrcPQibGVnY0G977MuoOSSSjzTWM938aaJX5vDBqcymI+GMSHEMLAv1LaA4Hy9f/h5Hs1sV2sEEqw+Uof0/QXkiyG110KOKm1neBIWhMNKwwppySkjbtr9bRCrwLX1h7k3K5Uc8Hp5nSarMPCuV2A+yTjNGN3G9IbzvRG7IflFEcm2hX/KCTf5N+ZcL8OsvZdGX/fYC/2DFl9g0ZnoNPCElmd79DfD82IksZ4LOZtpwas20cAMyGV+O4cdttjH5DvWLAMeNrmjz2tJaFuIJd1lhoJO3h99d0kdUnOfhhlQWiQWhuBNCx/913lgfb+rz0xTzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBPr8WEifrBJFiauY4ybsJ556N5UvNvNfBmPDdzg1Y8=;
 b=AS6ogbVOjyljmp8UYXS7E2UdEYMwN2i1bLXILIjCioWw0LUiVhbkb2CP5J7eqWVSlb8T2U7APoBd44AJAh9t4msEUM5uvVbWGo7iVoaR/f9NZoiN3VLuYkyRSNR3dV/z0kBb4yebd3mmAx1J0WWHUsG5SNKEKuhDj10GdYu2rN4/fn/H4dwzdXGOkZygihAA54TKxMGQGHPMLwKMSH87pqKFRvJHN4p4ivmKq2AEtt/W9aF0fKDGGTUI+8g9BZRTu6Z/6Y9UjFYHnY2uk6oZyaV/0WgSTGd/4oEta4O7ZqgNCes+HfImLVLnKiJKZ2uHGdO7r0uF95RFL665j+XT0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBPr8WEifrBJFiauY4ybsJ556N5UvNvNfBmPDdzg1Y8=;
 b=RtUrsowNF3mMboXFsO1epqXl+gDr7DlIKsO46KAc2ksn4+UhLnMndiK6QUgHyxrDRcSbGOpuivfRLbnIhxJdSLdiirlk92kxTqUUb0j7ZkZ+IVXkotyMVrjq0+BfbqsJCNgiBo7qcwcjChRcvrqCFXIbTl90ly/JvECAX8hAn6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR0401MB2496.eurprd04.prod.outlook.com (2603:10a6:800:56::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 10:52:02 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 10:52:01 +0000
Date:   Mon, 28 Feb 2022 12:51:58 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
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
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 01/11] driver: platform: Add helper for safer setting
 of driver_override
Message-ID: <YhypTr5754yK9WGi@abelvesa>
References: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
 <20220227135214.145599-2-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227135214.145599-2-krzysztof.kozlowski@canonical.com>
X-ClientProxiedBy: VI1PR08CA0172.eurprd08.prod.outlook.com
 (2603:10a6:800:d1::26) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3122d3f-ec07-4a24-d4b0-08d9faa85978
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2496:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0401MB24965216C5D9C611B4CA133BF6019@VI1PR0401MB2496.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mG+Zf2OvGgKwpyI/8I8qiziwlVMDs3xJ3dalNm7Se+CGXhaS7CugC2q7hucvXl7MxsUUgWx/hbQpg5gKRBxIQmtwnPlqn4QQaOUao5Wb8CPspfy86gSIyk1mbKeeXJNhTDdofRY1Snkq9sQZROl2+OOZcorsmgsFZvWhrJWoDbyCEZLEHRJZV4dNw2yy6Fb37V41BG2DmBBb3UDJpVbPGiHByBnZAz/P3wQQ3Ak5O8BSWa8g7c84isRO+4EqEIJ/reDyVhn9TyTmQ+ThGK9JI1UV83NbzAzCP4NLJi/zUFwvyqQNlWPlL7cqTjWJQxtoH5i33P+PMBUjDqU2owVYh3WLAxADQhgkmTe4/d3805zxEWm8//lzBnKQt4Ogdb7oWOptV0XoeoKXyt1OHEk0CZqnig/GEp1y4kOJej6D7WIMQZHKzQKtfQe/mhn/RhKWU8zYlyMXmPvKwL7xuQ+h+he2XrbXmYWy1RDOkQ+pYszxPGaNRr/e7HSE8jlQP90yDR18KAiDpYMIa7Vmw1md8CyH4Gp9EX4CxyvwC8ZjjCqpRidL1quLKJbn9kZEtqZGmNAQx5sApJDxPNLEKVTAd3zeRxCy/oQswOYmg75K7HC25DgKzqnOHFqFwdUvmOi/Ik50bWdL41LBSplJH0Tn+dHkvOxRHIg1RFvKXXyeBwmPlbYH5QDyWc3NBUId1NTDbpC0+7HeQrAECu1FUlf+7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(9686003)(33716001)(2906002)(6512007)(38100700002)(83380400001)(44832011)(186003)(26005)(38350700002)(53546011)(508600001)(7406005)(66946007)(7416002)(66556008)(66476007)(8676002)(4326008)(8936002)(6666004)(5660300002)(6916009)(54906003)(316002)(6506007)(86362001)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vwsULYGzYdv85DwjHAKuYdGOp3Vdvdr/TFI58zj2Zn8k8IEVoBP7At4kFVQr?=
 =?us-ascii?Q?8sEmHLlUYqjkl0vZUIvtCIoLth2qhkGQCCZDlOJ+7KjXU27XoI1A7o4pqtTG?=
 =?us-ascii?Q?dFc4yOHeF3Nndc+pbWT2b/iwkzUbhWcW4R/GsijGS8Gcg+TmNJAAM6ZS+FZt?=
 =?us-ascii?Q?loKBr9yHEyeG64byLTor8Kh5sSJdtLENiwNzsmfa75x8WKMD6m37X03/OPwk?=
 =?us-ascii?Q?LUJVwtT5yaIiu9lRsa7VbTjUfqLL+5TFfLXGuskj4pIeDzbOEMJllItC4RTD?=
 =?us-ascii?Q?G64b86u2dH1BgPuLeAnsVOqh+WM9WydPyYBBoUpVcvVj/tjqRqP0Z18KlLro?=
 =?us-ascii?Q?yVgVQ+vhWFo5SGL3l9dYSLTkLiMRk6bH6gnIwrk+Q74qEiZ73tkvZNBMPc02?=
 =?us-ascii?Q?6SkQRNDkGMSxID+isF+uzUptoA7yROTtO4kiKQPGGrsKFzj2zAdFOytcV5q2?=
 =?us-ascii?Q?QkgzIYTdxuZDtgkcBCVDwdjiuwaFTz3yfJ2516qjDNwTrAXlttEvK3QTIyml?=
 =?us-ascii?Q?XX93g/M9+XrOnKUkTUY4YJcJZFwjykRIeMvIee3KeIpTnU6WhaHV4Rj5PL3j?=
 =?us-ascii?Q?HHjh1vj/5WpaQS5UqOvu3IO+qi3eKhrNVRHSKbCC4Sfh+FB7ytsDoqndJsBS?=
 =?us-ascii?Q?/xte/3bTQSMSEchOa9gnMrrlpNiww8go912bjSW50aufKFBh8MrzlQXC4Kwa?=
 =?us-ascii?Q?49MN5jZi4Ebpr3BhQu8ygvEVI02dLpFtajI6eWNFYUPxl2ZWm6KJb14YqveV?=
 =?us-ascii?Q?nFTEifQfKk70gxQYqPQ8Qzqe2zxo80LFXUrgFACBUUIX+ork9AIBTBaWYPrl?=
 =?us-ascii?Q?K0+GOO5imJNuwtwARjigjEqYO1MrCMTKy81y0ETHKVyyB7ZuPj8yo1/C7h4Q?=
 =?us-ascii?Q?pfEhfCCLj6WaEjFSo/9kVmdXhkSLsNAFfGx6fJ0EabbTCIaRLjzc5NGH5j9s?=
 =?us-ascii?Q?hNv+uo2Y9rE/+CUjtbLoO5jboYInro2XeKFEIVLmqY4iPD+Y5gEacKUiV/KT?=
 =?us-ascii?Q?HW/Dd/OLWo27b4gQ1xexNMRKnY5jArNAiLb6bWVSHtUC6VMKRpvbXE3kAnlz?=
 =?us-ascii?Q?Fjz6gLamh+N78MxINPI/ZqiCjU2xfgQTZ2XAd7D68zhMDaNAuW9nH20MBBr7?=
 =?us-ascii?Q?BsbyDmCjCFmCQ2F8SNoUr3qUyfSxsuEF+dBMzhzFFsz0/UOxSHbim45o+h4N?=
 =?us-ascii?Q?/GBpX2f2HAFJgH4tp/+FZumlrTi0+G6XpBx5Agw6CuPlW9QtcX4DX9p6SZd7?=
 =?us-ascii?Q?I6Un5RQiBCjsPoDc6mIgDupsUFfu8RYCF8DP809ratrBQE/EMDrCZAcjclgr?=
 =?us-ascii?Q?5OVs7OJuncadv9c5w+ozOBbGu1g+6a6Gd1uicC4kxeLTVg2Vh+t9VAN3m6SN?=
 =?us-ascii?Q?HBtk20nYdq4pyfdR2Z58OiYUm92dGj84/DPy72ZGhmf8t1UGr/eRsMI0191t?=
 =?us-ascii?Q?7j90RZCORPttcolCX10O6QhgBGxUp/s1r9Al7M/Mo6qjWmuslDwA3dNEYZcx?=
 =?us-ascii?Q?WvpiV1cMdR/QOmRkJX7asz7B54KQ14Y9Mu/JOTiyQf8+WnXTr5zYsWXrP30g?=
 =?us-ascii?Q?67G/aX6Wu2alPHyATxmQVjYvTmdqdmPDV6jr2IPzUTsdeor/9zJ7/i8VSUsu?=
 =?us-ascii?Q?9nBowi4grdl7d54l5d2ARHE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3122d3f-ec07-4a24-d4b0-08d9faa85978
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 10:52:01.7644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8oYAF7NbVtZMXDenpDx9BTJZcZiG7EIJ3H99HYQCn7llKIugJQRwJSPk7rgVkQFej2uCfe2lHSy2wKXidvC+sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2496
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 22-02-27 14:52:04, Krzysztof Kozlowski wrote:
> Several core drivers and buses expect that driver_override is a
> dynamically allocated memory thus later they can kfree() it.
> 
> However such assumption is not documented, there were in the past and
> there are already users setting it to a string literal. This leads to
> kfree() of static memory during device release (e.g. in error paths or
> during unbind):
> 
>     kernel BUG at ../mm/slub.c:3960!
>     Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
>     ...
>     (kfree) from [<c058da50>] (platform_device_release+0x88/0xb4)
>     (platform_device_release) from [<c0585be0>] (device_release+0x2c/0x90)
>     (device_release) from [<c0a69050>] (kobject_put+0xec/0x20c)
>     (kobject_put) from [<c0f2f120>] (exynos5_clk_probe+0x154/0x18c)
>     (exynos5_clk_probe) from [<c058de70>] (platform_drv_probe+0x6c/0xa4)
>     (platform_drv_probe) from [<c058b7ac>] (really_probe+0x280/0x414)
>     (really_probe) from [<c058baf4>] (driver_probe_device+0x78/0x1c4)
>     (driver_probe_device) from [<c0589854>] (bus_for_each_drv+0x74/0xb8)
>     (bus_for_each_drv) from [<c058b48c>] (__device_attach+0xd4/0x16c)
>     (__device_attach) from [<c058a638>] (bus_probe_device+0x88/0x90)
>     (bus_probe_device) from [<c05871fc>] (device_add+0x3dc/0x62c)
>     (device_add) from [<c075ff10>] (of_platform_device_create_pdata+0x94/0xbc)
>     (of_platform_device_create_pdata) from [<c07600ec>] (of_platform_bus_create+0x1a8/0x4fc)
>     (of_platform_bus_create) from [<c0760150>] (of_platform_bus_create+0x20c/0x4fc)
>     (of_platform_bus_create) from [<c07605f0>] (of_platform_populate+0x84/0x118)
>     (of_platform_populate) from [<c0f3c964>] (of_platform_default_populate_init+0xa0/0xb8)
>     (of_platform_default_populate_init) from [<c01031f8>] (do_one_initcall+0x8c/0x404)
>     (do_one_initcall) from [<c0f012c0>] (kernel_init_freeable+0x3d0/0x4d8)
>     (kernel_init_freeable) from [<c0a7def0>] (kernel_init+0x8/0x114)
>     (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> 
> Provide a helper which clearly documents the usage of driver_override.
> This will allow later to reuse the helper and reduce amount of
> duplicated code.
> 
> Convert the platform driver to use new helper and make the
> driver_override field const char (it is not modified by the core).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/base/driver.c           | 51 +++++++++++++++++++++++++++++++++
>  drivers/base/platform.c         | 28 +++---------------
>  include/linux/device/driver.h   |  2 ++
>  include/linux/platform_device.h |  7 ++++-
>  4 files changed, 63 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> index 8c0d33e182fd..353750b0bbc5 100644
> --- a/drivers/base/driver.c
> +++ b/drivers/base/driver.c
> @@ -30,6 +30,57 @@ static struct device *next_device(struct klist_iter *i)
>  	return dev;
>  }
>  
> +/**
> + * driver_set_override() - Helper to set or clear driver override.
> + * @dev: Device to change
> + * @override: Address of string to change (e.g. &device->driver_override);
> + *            The contents will be freed and hold newly allocated override.
> + * @s: NUL terminated string, new driver name to force a match, pass empty
> + *     string to clear it
> + * @len: length of @s
> + *
> + * Helper to set or clear driver override in a device, intended for the cases
> + * when the driver_override field is allocated by driver/bus code.
> + *
> + * Returns: 0 on success or a negative error code on failure.
> + */
> +int driver_set_override(struct device *dev, const char **override,
> +			const char *s, size_t len)

TBH, I think it would make more sense to have this generic
driver_set_override receive only the dev and the string. And then,
each bus type will have their own implementation that handle things
their own way. This would allow all the drivers that will use this to
do something like this:

	ret = driver_set_override(&pdev->dev, "override_string");

I think it would look more cleaner.

> +{
> +	const char *new, *old;
> +	char *cp;
> +
> +	if (!dev || !override || !s)
> +		return -EINVAL;
> +
> +	/* We need to keep extra room for a newline */
> +	if (len >= (PAGE_SIZE - 1))
> +		return -EINVAL;
> +
> +	new = kstrndup(s, len, GFP_KERNEL);
> +	if (!new)
> +		return -ENOMEM;
> +
> +	cp = strchr(new, '\n');
> +	if (cp)
> +		*cp = '\0';
> +
> +	device_lock(dev);
> +	old = *override;
> +	if (cp != new) {
> +		*override = new;
> +	} else {
> +		kfree(new);
> +		*override = NULL;
> +	}
> +	device_unlock(dev);
> +
> +	kfree(old);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(driver_set_override);
> +
>  /**
>   * driver_for_each_device - Iterator for devices bound to a driver.
>   * @drv: Driver we're iterating.
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 6cb04ac48bf0..8dd87f44bd74 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1275,31 +1275,11 @@ static ssize_t driver_override_store(struct device *dev,
>  				     const char *buf, size_t count)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> -	char *driver_override, *old, *cp;
> -
> -	/* We need to keep extra room for a newline */
> -	if (count >= (PAGE_SIZE - 1))
> -		return -EINVAL;
> -
> -	driver_override = kstrndup(buf, count, GFP_KERNEL);
> -	if (!driver_override)
> -		return -ENOMEM;
> -
> -	cp = strchr(driver_override, '\n');
> -	if (cp)
> -		*cp = '\0';
> -
> -	device_lock(dev);
> -	old = pdev->driver_override;
> -	if (strlen(driver_override)) {
> -		pdev->driver_override = driver_override;
> -	} else {
> -		kfree(driver_override);
> -		pdev->driver_override = NULL;
> -	}
> -	device_unlock(dev);
> +	int ret;
>  
> -	kfree(old);
> +	ret = driver_set_override(dev, &pdev->driver_override, buf, count);
> +	if (ret)
> +		return ret;
>  
>  	return count;
>  }
> diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
> index 15e7c5e15d62..700453017e1c 100644
> --- a/include/linux/device/driver.h
> +++ b/include/linux/device/driver.h
> @@ -151,6 +151,8 @@ extern int __must_check driver_create_file(struct device_driver *driver,
>  extern void driver_remove_file(struct device_driver *driver,
>  			       const struct driver_attribute *attr);
>  
> +int driver_set_override(struct device *dev, const char **override,
> +			const char *s, size_t len);
>  extern int __must_check driver_for_each_device(struct device_driver *drv,
>  					       struct device *start,
>  					       void *data,
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 7c96f169d274..e39963889aa3 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -31,7 +31,12 @@ struct platform_device {
>  	struct resource	*resource;
>  
>  	const struct platform_device_id	*id_entry;
> -	char *driver_override; /* Driver name to force a match */
> +	/*
> +	 * Driver name to force a match.
> +	 * Do not set directly, because core frees it.
> +	 * Use driver_set_override() to set or clear it.
> +	 */
> +	const char *driver_override;
>  
>  	/* MFD cell pointer */
>  	struct mfd_cell *mfd_cell;
> -- 
> 2.32.0
>
