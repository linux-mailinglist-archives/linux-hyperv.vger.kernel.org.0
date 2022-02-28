Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9CB4C6B5C
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Feb 2022 12:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbiB1L5j (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Feb 2022 06:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbiB1L5g (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Feb 2022 06:57:36 -0500
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-eopbgr40083.outbound.protection.outlook.com [40.107.4.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207AD5B3FC;
        Mon, 28 Feb 2022 03:56:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rtj0aDEycb/8xgW9KcqwiX4jTqJ2JzVWFUAss9J/B0p/+MPHuIVujSeK1dN9MW9P/MnxEqRIJG6wrLnHyNHbCqveqC6ZLFV9VrtqN5vGSZQS8FGPAg3KWeUnsFmD6JFiR7MwniXG+P7nVECm2DUGL6ZkYbebOdUDQlveuh0ME2pB8rLL8FxgpKlk4MkAxwmj5CwMVleh4EofFmYjzmtDhONoUJPUzG0F2oLl0HDEvv4vOFwQmml9OvivcIg7bfkzM06R6WJ4ocWyhk9U+hJOgfforANCJyjM7LDd/GP8gGAK4ast7rvT+EUP5h1coW9bPs4GVQY42C0k6fIdDKnL9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSyFEdGA9KH368bAZi9rkCJ9G5dWGrL0FHKYyk/U5YQ=;
 b=eU09jqDRs837WZ3J/TNvTlaHntwJOiDq0bSu9o1fKOCaIXBt6HeBLT/n7CEvcYUU61HePFA0IcR0Hcvkz45vCVPzFoPeoRxCUi/m3tW2NUF5IofCblt55huoJ0GzQVhYn93OJp4sypFI3gTJzlCSg1fU4O6CsqKVtOk8XSS+NJnK62tIT0mlZg8jQWT+RpJRqQsaWFverIS+k5GAShDORnXtambbwfX1ieY8pW6ESpINVrDmCu9A7dWwM9oSqUX5HuL6SqMOHGzl6FQ0zUxgpDMe9RKmFjLHxiDIW/+N/xxy7oj6zRmB+10J+9qsZAS4hXp/yxUuTXhIpHhkMOLDUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSyFEdGA9KH368bAZi9rkCJ9G5dWGrL0FHKYyk/U5YQ=;
 b=rIWLkYKqcIRj54JMpj6k7OlNrc9jFgp5lw6mEMyW72QIj/Aj6fN74IZvWdpc5kXJZr7xQ2Xdm04rnS1jdPr6BGrzs5XBJU/Th7F51D8Z92DNf8k5HntC766oJNB+tAKnKaEmjShHYvUymxoWLYCgP6LQ14qN/Gv/dxfkjE8l5U4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM6PR04MB3989.eurprd04.prod.outlook.com (2603:10a6:209:40::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 11:56:53 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 11:56:52 +0000
Date:   Mon, 28 Feb 2022 13:56:50 +0200
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
Message-ID: <Yhy4gvuYszZG3+e+@abelvesa>
References: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
 <20220227135214.145599-2-krzysztof.kozlowski@canonical.com>
 <YhypTr5754yK9WGi@abelvesa>
 <b428f7b0-9f3e-466c-9386-9f72f13ebbd0@canonical.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b428f7b0-9f3e-466c-9386-9f72f13ebbd0@canonical.com>
X-ClientProxiedBy: VI1PR04CA0130.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::28) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dba41eaa-2ff8-4ec8-0698-08d9fab168c4
X-MS-TrafficTypeDiagnostic: AM6PR04MB3989:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB39894FAE42B00255AC3B00C3F6019@AM6PR04MB3989.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGu+Z8FJ4PSHFM7AFUlzp5zb4pyPvlaXGUuk6RD/eTF9qvHdeoC/sBvSB0YmEqqUrYcOeknwb+zFUVOyeNRgbJhFlfJ1b/u+qlHrQuZJYrFjYk1o7+hUKBsleOGSWHI4qFc5DtyVOYgEI61UhOFOw0U482eAG7ma92LzIDkgi88AnBP02zi+YtALMEEK4xgwkz3BHvVywEdehz1m69Nc2JrjFpUXIVUywgkTSpDp6Zr3QZ+Pabnu0DrEtJAQPsURmAfL6tAgJhs9m3qhRM5MhcfDJqQIeaXwo1t4/l/gxxN8i2HoK3S4akxTwo09Hjs9wnCgV+24abQoRRIi2B1CLrlXda07HWcn7z1CGHdwy7VwYgpeMC/LiXCrc4r/lp0rQ4+GVuC6mR5w9sOt9P1FLKNqbl9gdAZJfjD8yc1ybuZ4p7fRpxBe8g7iYapeqTn/85nVBCuQYgboZrYBRQULUBioGT+oo3rEhtdokQzGPm6ZCcMfMGSk4wUePJpiXhzZB2rq13XcJDeki7IIVDwu4ZfXKG3i0SJdnrgvOxOLCAE1ex/TpZNyXIuepZuxI4T5GjcPqcstiuV3tof0FbE1OTYqgpO2GggYtrmxI79fKZ2YQDVCogpyXKRESkAUeMx1BE6uKpBSio0Y3vuuwARFtsd+VKp45yYZnBjfhTGwS4ODUrneMCyspZhMs/En6ZGXRozyx/WmwPcrEVwvcbkr1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(66476007)(38100700002)(66946007)(6916009)(38350700002)(66556008)(83380400001)(86362001)(316002)(4326008)(54906003)(8676002)(6512007)(6506007)(5660300002)(9686003)(8936002)(52116002)(53546011)(186003)(6486002)(7406005)(33716001)(44832011)(26005)(7416002)(508600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UsAvURBr7pxysvpUzBkgAvY7xYr+luemhQo2LnFPG0jWVHvd1ljH7HVC6gBD?=
 =?us-ascii?Q?8ryt2WsrkRdiTVHvQz3n3zt/FnfMP7PFQSaMdzP5UxDkiplwz3a3DpryQ4c7?=
 =?us-ascii?Q?itqIXRcjQuD2riiM9bIW+Qwxh8a+S/UgEHrSLZm/ir+Eu+ygMIHjtE5WO/PU?=
 =?us-ascii?Q?mehxulCyfVla/MZQ4Nso1jVUZrwn+mHrx7rOPXWCs4nFEf+zadz/GSunv+O8?=
 =?us-ascii?Q?Kpztfw9LrytcF24G5qqT9sVJKaGVnHg8UXX+g4IWLAUXNsnNPfvV1Oyf0GuH?=
 =?us-ascii?Q?C5IiuDxrtr8Ivv+bGz1Y/vfG7n1bywuLI+mCKyWTmEcA9WlyIKTOiy54CIh/?=
 =?us-ascii?Q?kZtOtmIPPKw9gFHm/6UazNwdUWw04HBz9goN6foPl84Ol/Nb86XsCRfhs/jK?=
 =?us-ascii?Q?pFggAvhYEL0HUbx/Ag8kb0EpJUoUMAiK/VOzeGetuyOvZ5sR2zzXNgyv/OUg?=
 =?us-ascii?Q?Xi1HN2LatMFLnPWR3NjvTJPlNM/SAJJ2g1wTclZbZV1fVSYfMkqk/fnKXo9u?=
 =?us-ascii?Q?UKghCLCLMiDHzbMwynqSiw22yvADaujjiXU37wEM/vDKfXS73jNi1vfBAOed?=
 =?us-ascii?Q?EEnL7zmXUuNrzcZgeRmgICqqKCxcEx919ziRru/QuBGt3d4t7Wx6k5wfKXKz?=
 =?us-ascii?Q?T1wL1rsUecfv4BOkdMgMTHJe3wAMRymqq3QJv/TZVY3LHy2f0Zr300UvmTGz?=
 =?us-ascii?Q?0M4z4ZmTprU4jioa1uQBQtKrWJPju5htPnR9KEg7QbSmXy/oum2it7Yr+lP/?=
 =?us-ascii?Q?nd3d4GdXd1jIUrH2whbUxAV6ZjL1Niwj/XaLn1emZdkIN91W4EBDpWyXUMPx?=
 =?us-ascii?Q?SX40GbHl6B/UuFRlASBZ1+NGbK0c1vPDH0xdiDdbdyCTDXuU0KI94zvkQc1V?=
 =?us-ascii?Q?YMcxhtDZtLAh8hhOMsFegKvkCFloChqMd6u4Dqeu1m6bK3WD6KihWvAHNpC2?=
 =?us-ascii?Q?PiJoQb/aWIp68cMp7lymc7+OFLrL8HtugBEwUeMaMPG3OG4AP3Wkt5awofs8?=
 =?us-ascii?Q?7DA3DHBfu7z7WpW4W/Jxesf0TxLCYuF/+GN+2ntm8GYvZC5u7aXYBlMaPBaq?=
 =?us-ascii?Q?GoTQ3vA3jVYQt20OAO//SW9PYGi3LhR7f+SzUoH7ikkEOHPvvVysYRVqUSI2?=
 =?us-ascii?Q?qCsh3DmljKf9wXi9H5rfn+JJW0Hucn+xwcKZQn5havKc3ePMIsEzpRv+Dm7h?=
 =?us-ascii?Q?saZt8t6cVOKIhscl3LqHI0twrdpKJRrR9aqTDICxCzeU2/ULxgpy6PxHgpXm?=
 =?us-ascii?Q?cYqoj4RzZY8QHvTr4pE6vzFbODgBYTl6GfgM3eesItsop9V99w5bN6UdZHQv?=
 =?us-ascii?Q?t2yvg+OnYosuU3coZ4FskxPROc2h0m4OVnJY4WDXf5VRl5SbeQmL0ETgujjV?=
 =?us-ascii?Q?aynoNsl6Y6ujBVRfHvxP4pXSo4UgSD9cERVtqWqE3ZP6ZDwzQ6858XvIRxrf?=
 =?us-ascii?Q?klRjIa1gwha3VzG38UPMOs4J/qU9/RAQuRcVzW/jn03wIZQQyWCL0VUR5tDq?=
 =?us-ascii?Q?qrrzjqMdyVJyWYhilpLnyfZJ3k9q42AqNCiVh3o/Pl6EQSw7YFMo/K7VqyF2?=
 =?us-ascii?Q?kwGkEgG+pTxfxse7aGQOYeD+E2DH8/BCcNoPQ1JFY5nNLsda2XD2I8hN6fEC?=
 =?us-ascii?Q?gtaYgKtFcaFf2sTUckUN5Pg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba41eaa-2ff8-4ec8-0698-08d9fab168c4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 11:56:52.6749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ByJgk9nAUJS3365y4Bei+SI2ydKCaL5FpsLdcHK7+SnaNFtnw8Zfil6vjFvrb8iNjCHtIAD2mGCUEk+eFTuoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3989
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 22-02-28 12:30:45, Krzysztof Kozlowski wrote:
> On 28/02/2022 11:51, Abel Vesa wrote:
> > On 22-02-27 14:52:04, Krzysztof Kozlowski wrote:
> >> Several core drivers and buses expect that driver_override is a
> >> dynamically allocated memory thus later they can kfree() it.
> >>
> >> However such assumption is not documented, there were in the past and
> >> there are already users setting it to a string literal. This leads to
> >> kfree() of static memory during device release (e.g. in error paths or
> >> during unbind):
> >>
> >>     kernel BUG at ../mm/slub.c:3960!
> >>     Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> >>     ...
> >>     (kfree) from [<c058da50>] (platform_device_release+0x88/0xb4)
> >>     (platform_device_release) from [<c0585be0>] (device_release+0x2c/0x90)
> >>     (device_release) from [<c0a69050>] (kobject_put+0xec/0x20c)
> >>     (kobject_put) from [<c0f2f120>] (exynos5_clk_probe+0x154/0x18c)
> >>     (exynos5_clk_probe) from [<c058de70>] (platform_drv_probe+0x6c/0xa4)
> >>     (platform_drv_probe) from [<c058b7ac>] (really_probe+0x280/0x414)
> >>     (really_probe) from [<c058baf4>] (driver_probe_device+0x78/0x1c4)
> >>     (driver_probe_device) from [<c0589854>] (bus_for_each_drv+0x74/0xb8)
> >>     (bus_for_each_drv) from [<c058b48c>] (__device_attach+0xd4/0x16c)
> >>     (__device_attach) from [<c058a638>] (bus_probe_device+0x88/0x90)
> >>     (bus_probe_device) from [<c05871fc>] (device_add+0x3dc/0x62c)
> >>     (device_add) from [<c075ff10>] (of_platform_device_create_pdata+0x94/0xbc)
> >>     (of_platform_device_create_pdata) from [<c07600ec>] (of_platform_bus_create+0x1a8/0x4fc)
> >>     (of_platform_bus_create) from [<c0760150>] (of_platform_bus_create+0x20c/0x4fc)
> >>     (of_platform_bus_create) from [<c07605f0>] (of_platform_populate+0x84/0x118)
> >>     (of_platform_populate) from [<c0f3c964>] (of_platform_default_populate_init+0xa0/0xb8)
> >>     (of_platform_default_populate_init) from [<c01031f8>] (do_one_initcall+0x8c/0x404)
> >>     (do_one_initcall) from [<c0f012c0>] (kernel_init_freeable+0x3d0/0x4d8)
> >>     (kernel_init_freeable) from [<c0a7def0>] (kernel_init+0x8/0x114)
> >>     (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> >>
> >> Provide a helper which clearly documents the usage of driver_override.
> >> This will allow later to reuse the helper and reduce amount of
> >> duplicated code.
> >>
> >> Convert the platform driver to use new helper and make the
> >> driver_override field const char (it is not modified by the core).
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> >> ---
> >>  drivers/base/driver.c           | 51 +++++++++++++++++++++++++++++++++
> >>  drivers/base/platform.c         | 28 +++---------------
> >>  include/linux/device/driver.h   |  2 ++
> >>  include/linux/platform_device.h |  7 ++++-
> >>  4 files changed, 63 insertions(+), 25 deletions(-)
> >>
> >> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> >> index 8c0d33e182fd..353750b0bbc5 100644
> >> --- a/drivers/base/driver.c
> >> +++ b/drivers/base/driver.c
> >> @@ -30,6 +30,57 @@ static struct device *next_device(struct klist_iter *i)
> >>  	return dev;
> >>  }
> >>  
> >> +/**
> >> + * driver_set_override() - Helper to set or clear driver override.
> >> + * @dev: Device to change
> >> + * @override: Address of string to change (e.g. &device->driver_override);
> >> + *            The contents will be freed and hold newly allocated override.
> >> + * @s: NUL terminated string, new driver name to force a match, pass empty
> >> + *     string to clear it
> >> + * @len: length of @s
> >> + *
> >> + * Helper to set or clear driver override in a device, intended for the cases
> >> + * when the driver_override field is allocated by driver/bus code.
> >> + *
> >> + * Returns: 0 on success or a negative error code on failure.
> >> + */
> >> +int driver_set_override(struct device *dev, const char **override,
> >> +			const char *s, size_t len)
> > 
> > TBH, I think it would make more sense to have this generic
> > driver_set_override receive only the dev and the string. And then,
> > each bus type will have their own implementation that handle things
> > their own way. This would allow all the drivers that will use this to
> > do something like this:
> > 
> > 	ret = driver_set_override(&pdev->dev, "override_string");
> > 
> > I think it would look more cleaner.
> > 
> 
> The interface in general is not for the drivers. Drivers use it in
> exceptions (few cases in entire kernel) but many times they actually do
> not need to.
> 
> Adding a dedicated driver_set_override() brings intention that such
> usage is welcomed... but it's not. :)

I understand that. Anyway, I was more focused on this looking cleaner.
But I'll let the others weigh in on this before applying the imx clk
patch.

Thanks.

> 
> 
> Best regards,
> Krzysztof
