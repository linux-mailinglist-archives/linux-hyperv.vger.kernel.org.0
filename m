Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935334FE368
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Apr 2022 16:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356308AbiDLOMg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Apr 2022 10:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350319AbiDLOM2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Apr 2022 10:12:28 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2106.outbound.protection.outlook.com [40.107.114.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9FC23E;
        Tue, 12 Apr 2022 07:10:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3qpcnI7xWUPqyyuHjzLXTkn1us+WFONzXaI2EN+ttN6HAlliokiS0FaT7YDrqtlfymVl1gaL+pDpaJ2LURfuuuIpcKno0Fgy6ToTa+dqoeiFfAierwPwEkYH/3pKt0Q4Wu2AjrTM6fpf7tB+2+DbqrEul27FvbRFQ9qGeOE71ypnEguQpMpd2CHjG6A66iWORw7seBKytQu6C8UctfmqwsicddYCnqHDDnsIj2PbZeS75YyiShC7EsIW4Uo9lU/lw+7vcZfgo2iWHRhMnY4JU1QgGNBpY2LmSgVOLt4AAplod4r81DWyxpQOgKpynhCzMnmp+gBvOkRX7qRoE7SEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYA9LIGGC8faHr6AqXOHKlZ151ZpV7JNd9NSOV1aTJM=;
 b=PeUKii0FAuuzBc7wlszlJtsGr6kzVyLTYEzZaew9qrX5Dl5yV9Ae5KSBEQi6SpvuCcHThQ/PPh0BErODLYCQQ/5vFDRx6Q1kBUoFYjgqbNlGOiJYAV29n4EWDLSv7A8yJZJc6tqd7LZQ5pd/KpB64hRRjekbkgsfIJXtV8Xj1AksJdyqIo/Dp2bf4Oe03rJ/PKM9vnFuC4SByt44ZvwxLel+vd3tJhrv9dKDFvxVvSCVjSwWLwz9Z0IRbPJ8GEpONsHKUMsY7A7NdTrJJCrQCFrHuGE7YXot1vsnlhMRflVL0oDwwhtgSPooPig2/nMVBnIDen1Ezr3rDK1iq0cHuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYA9LIGGC8faHr6AqXOHKlZ151ZpV7JNd9NSOV1aTJM=;
 b=OduNuckqCdv/yRUYIGVGcLrxD8ZY5PyTkH6Ngt2VI02JCTFH8bEoYFL3ZWqP232nyYP9/cM8oQUj6K+94HdH11Zc3GIqUoQr2UpxJ+OnOfwHh2whbp++acuzCYHCnsDXzLOG9rzuzJtPyq9HFRdf14yOLpbxmlhjS9RyseJhRZk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB3278.jpnprd01.prod.outlook.com (2603:1096:404:8e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 14:10:07 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b129:a6f3:c39e:98db]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b129:a6f3:c39e:98db%4]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 14:10:07 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Stuart Yoder <stuyoder@gmail.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: RE: [PATCH v6 12/12] rpmsg: Fix kfree() of static memory on setting
 driver_override
Thread-Topic: [PATCH v6 12/12] rpmsg: Fix kfree() of static memory on setting
 driver_override
Thread-Index: AQHYR4usqrdzUSvyPkWDhxjfW2t+CqzsXZDQ
Date:   Tue, 12 Apr 2022 14:10:06 +0000
Message-ID: <OS0PR01MB59226666C2C6805C86304BE586ED9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220403183758.192236-1-krzysztof.kozlowski@linaro.org>
 <20220403183758.192236-13-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220403183758.192236-13-krzysztof.kozlowski@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8802f44-eace-4f82-502c-08da1c8e25c0
x-ms-traffictypediagnostic: TYAPR01MB3278:EE_
x-microsoft-antispam-prvs: <TYAPR01MB3278C5C34FEFA4862B36686786ED9@TYAPR01MB3278.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l7yyihSdqh18KGDInynfQ3GmUNqp4rlMGc/6lPs1su9XSd59TFMpdz+aEqyBz/HGgXNB58mXTaxTS+Al2sDniXao0ybOuKN44fnMzOd15x5NXtctiqv6bQ7Kh9jTBt0NhgCE6ooEGgRiWUP2rzHYppFnh9Gf163SJyQaWZXh+Oc53L1eftqEkrSXy9TKkd8PByglE/4s9e0vOVX9vRQEk6T+LdqWIMNVhqg2t8HQBMClin+dj7E/+Mlx+e53qnxYFB262OmzNnobhCWjNJH5Ue2452puV23B8aONv+ou5A1CZ51xgFINeWav3sdSya5/JdZbXiIuNHqVv9Ok4+U5knqKe6NplYfZrGdP55Z4M3/5MnfOlBZaNf5Cc17UWOyXbJxF6i/IfRZzBYXv9RliArSNc5hw5l+PcbzCxBieO8aF64AEDRr/sEtGg0Hhcli2tcT/oh3xGl2zhxRntQwPv6t6zdcsAG8Z++nD134CLwJjzUd9klbeANdUmjj2veBQ2M+JgRygjLL23el4ACQFU/cufrAnQT1V77oCqZVkttvgaG6Kldoj2dPuGsykzY1pFJO3zH0lzlUeU1qX5GDDN7cD18UiYurbliN2NlFiC8kFf2bZmKQP9skfg5HzZvMQhKAijhvlzFRbHk2PQyl0B8YOhe3GDgTOh1k3wXbeRN45uFE5EsuZ7CQTeohwx74CaSoSXSipSye8+PG3W9+E6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(4326008)(54906003)(52536014)(7696005)(26005)(38070700005)(110136005)(5660300002)(66556008)(66476007)(76116006)(64756008)(66946007)(8936002)(86362001)(8676002)(66446008)(7406005)(7416002)(6506007)(508600001)(316002)(71200400001)(83380400001)(186003)(2906002)(55016003)(33656002)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kS/7Mw8c8d89Eps3nGW8n7fxISKtLhs8AcelqC0l8dgFf/5GoTV5IVMOAC6T?=
 =?us-ascii?Q?L55En4uigCnV+ktV1aEfRlNnuQ2n33RnLo05ZJqRDzFKBkptDMVRWJCRMk2A?=
 =?us-ascii?Q?tdB4WDkfe85meoZzOFFbCvy/R6JixdryxGhzkUi6i3nc2qeXE2yO/rF6QfAF?=
 =?us-ascii?Q?l4RMu0lc9WLLjm6/jDiUUmgadQH9oc//4PzwOkywomQjI0j4CzKbpT/7kK8e?=
 =?us-ascii?Q?P7Sj8yaalPWn5oqogOAzM2pf2GPlo+IWl58h7APuBuFsw1vf2FGC9W8ncE26?=
 =?us-ascii?Q?uhssJGeBh6oQdIP6NSh9Rln3E7LRdZ+xILafGUxQpVuYBa8xYbUM3UaL5R3j?=
 =?us-ascii?Q?lN3yxOuVQVVLsB85JI99KwkAkIGyT0599VvsFlO3/A4e5L4hmSTJfmJ676EM?=
 =?us-ascii?Q?pLtFFwCf/1u5qAFILuUeqC8Lea1eFDYyGW8oJHLAXo5drUC3LJ22GPZ401To?=
 =?us-ascii?Q?z7Z/KfEqX92eS1E5dzhcSnGWQ674I2xJeAxgiy2bwWeXUv/0CXTw1pxPSVMZ?=
 =?us-ascii?Q?Yd2kAczEPPStZotJzldm3Tb467z6t2uSg8jqC3nP8QXU2AB10X6vqwXWgyhM?=
 =?us-ascii?Q?6ISFhXmBxxd6lQY3O9CFtgqXGaWRziFAZHzOR3J2RYnwa6qz4yHEYF2balf+?=
 =?us-ascii?Q?ewIqaYIJJsCPnsvVwjC31VQ5brSkRjJQmwRTEc294lkFdQujCZoB6XQ/l0Gn?=
 =?us-ascii?Q?MfXPwI/RP9F+hEUN5hoqnWEojNWJwaZHSjgSEyy0Ho3lSM8CNoiGwzZSK8Rh?=
 =?us-ascii?Q?fQdYPm5Ft97UzUCiLUzt9xC4kUFLR+tJ9Sq8A1thJpnP3awmVBUz/ginGdf3?=
 =?us-ascii?Q?tlFFpoboU9vsp8mLVs/qQh+NbUw2jz4i9KyeBwSIGCwnt5YPB10neLejfWNT?=
 =?us-ascii?Q?rYMuUWnR+ax5CK3N9tsD/kBWLC8YZm4oHwUK6ZPg5W7Qr8d7evmyxYkvaXbh?=
 =?us-ascii?Q?xhVkfo7VVr4OVlFttkcOODewACkpVaZGYlziy09flYPMMft8IiNzigW36FUc?=
 =?us-ascii?Q?d3oDaK1DI/ctvVSCCbW1WWarBDcWxp23xaOcvMnbUBPagAdSQZzE7T6HFvM5?=
 =?us-ascii?Q?2NTk4SP5B/cua8WvQVoTCBxv7YP1LmRDkN+SRM3EYAWj+5NChVQYgfpBvXsh?=
 =?us-ascii?Q?y0ST1csHh2gYYz7TkmCK33TG3axvJ7D4vxIBgl9XRYwKRvjhtohN9zhBltcV?=
 =?us-ascii?Q?CWF0HccWMmg+xG5iRi0WW4CZGwiJZG7nF8JpF0Dhd3YDalCcnHEaK8KkDEhZ?=
 =?us-ascii?Q?ozgRHMJdwaLUTM2OEYuF80Uc9aJL4W8JG6ZgH1nyfUItS5p+q1J1SsFO9gH4?=
 =?us-ascii?Q?lPF3raWze9YKNs7Gv8s2G/WlmIHIsNP8Xyla7s9avoz51VB63JGkrbqZ2wWX?=
 =?us-ascii?Q?WSsh0vc59nPkavP0B1U+s+2fPwx90FRXWdiWvkCOWgEpKl/aYEBb6f2BU+i+?=
 =?us-ascii?Q?G+MxIxlefjaJ2dqrVnIQubKG8rxR9xBEgtC3DCXesTZLj+N7DoeDwNhbtFVg?=
 =?us-ascii?Q?Noj6A3Nw783dzlWBqDHxTiglq4+m9vLXX+owPCdU1ohSgpRR4AJdNHJP7SeX?=
 =?us-ascii?Q?nN4qQV4oVTYy5t+l/GSO6ac+SMpFanhHfXn09v+Y2353rrM2bUb/z0kY71kb?=
 =?us-ascii?Q?gkSeynhb1ynWHb2mcLZFfEYihzq6T7BEcvHVxQIHUpmrAsYJ9GcMegO6I2lM?=
 =?us-ascii?Q?LZ623MX42M2h8DzckW0ADhHR5VCfmrmnxIjSnVs7jwopP2t+WoXc+J8aAqRh?=
 =?us-ascii?Q?SKuqPClZx2arh2d7BHyzmBHfDHmwID8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8802f44-eace-4f82-502c-08da1c8e25c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 14:10:06.9859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E0guRv2xTjNIkZnwnA4TaHrqwRSu9/HKZjRQWLmjRIGpNThTUm6aXvrfH1C+BrrIdvjGrlGM/m2CKuwOYyW94pTDKf8I2G/duHSnGdjryVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3278
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Krzysztof Kozlowski,

Thanks for the patch.

> Subject: [PATCH v6 12/12] rpmsg: Fix kfree() of static memory on setting
> driver_override
>=20
> The driver_override field from platform driver should not be initialized
> from static memory (string literal) because the core later kfree() it, fo=
r
> example when driver_override is set via sysfs.
>=20
> Use dedicated helper to set driver_override properly.
>=20
> Fixes: 950a7388f02b ("rpmsg: Turn name service into a stand alone driver"=
)
> Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/rpmsg/rpmsg_internal.h | 13 +++++++++++--
>  drivers/rpmsg/rpmsg_ns.c       | 14 ++++++++++++--
>  include/linux/rpmsg.h          |  6 ++++--
>  3 files changed, 27 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/rpmsg/rpmsg_internal.h
> b/drivers/rpmsg/rpmsg_internal.h index d4b23fd019a8..1a2fb8edf5d3 100644
> --- a/drivers/rpmsg/rpmsg_internal.h
> +++ b/drivers/rpmsg/rpmsg_internal.h
> @@ -94,10 +94,19 @@ int rpmsg_release_channel(struct rpmsg_device *rpdev,
>   */
>  static inline int rpmsg_ctrldev_register_device(struct rpmsg_device
> *rpdev)  {
> +	int ret;
> +
>  	strcpy(rpdev->id.name, "rpmsg_ctrl");
> -	rpdev->driver_override =3D "rpmsg_ctrl";
> +	ret =3D driver_set_override(&rpdev->dev, &rpdev->driver_override,
> +				  "rpmsg_ctrl", strlen("rpmsg_ctrl"));

Is it not possible to use rpdev->id.name instead of "rpmsg_ctrl" ?
rpdev->id.name has "rpmsg_ctrl" from strcpy(rpdev->id.name, "rpmsg_ctrl");

Same for "rpmsg_ns" as well

Cheers,
Biju


> +	if (ret)
> +		return ret;
> +
> +	ret =3D rpmsg_register_device(rpdev);
> +	if (ret)
> +		kfree(rpdev->driver_override);
>=20
> -	return rpmsg_register_device(rpdev);
> +	return ret;
>  }
>=20
>  #endif
> diff --git a/drivers/rpmsg/rpmsg_ns.c b/drivers/rpmsg/rpmsg_ns.c index
> 762ff1ae279f..95a51543f5ad 100644
> --- a/drivers/rpmsg/rpmsg_ns.c
> +++ b/drivers/rpmsg/rpmsg_ns.c
> @@ -20,12 +20,22 @@
>   */
>  int rpmsg_ns_register_device(struct rpmsg_device *rpdev)  {
> +	int ret;
> +
>  	strcpy(rpdev->id.name, "rpmsg_ns");
> -	rpdev->driver_override =3D "rpmsg_ns";
> +	ret =3D driver_set_override(&rpdev->dev, &rpdev->driver_override,
> +				  "rpmsg_ns", strlen("rpmsg_ns"));
> +	if (ret)
> +		return ret;
> +
>  	rpdev->src =3D RPMSG_NS_ADDR;
>  	rpdev->dst =3D RPMSG_NS_ADDR;
>=20
> -	return rpmsg_register_device(rpdev);
> +	ret =3D rpmsg_register_device(rpdev);
> +	if (ret)
> +		kfree(rpdev->driver_override);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(rpmsg_ns_register_device);
>=20
> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h index
> 02fa9116cd60..20c8cd1cde21 100644
> --- a/include/linux/rpmsg.h
> +++ b/include/linux/rpmsg.h
> @@ -41,7 +41,9 @@ struct rpmsg_channel_info {
>   * rpmsg_device - device that belong to the rpmsg bus
>   * @dev: the device struct
>   * @id: device id (used to match between rpmsg drivers and devices)
> - * @driver_override: driver name to force a match
> + * @driver_override: driver name to force a match; do not set directly,
> + *                   because core frees it; use driver_set_override() to
> + *                   set or clear it.
>   * @src: local address
>   * @dst: destination address
>   * @ept: the rpmsg endpoint of this channel @@ -51,7 +53,7 @@ struct
> rpmsg_channel_info {  struct rpmsg_device {
>  	struct device dev;
>  	struct rpmsg_device_id id;
> -	char *driver_override;
> +	const char *driver_override;
>  	u32 src;
>  	u32 dst;
>  	struct rpmsg_endpoint *ept;
> --
> 2.32.0
>=20
>=20
> _______________________________________________
