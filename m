Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DF377C177
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Aug 2023 22:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjHNU0k (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Aug 2023 16:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjHNU0d (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Aug 2023 16:26:33 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020016.outbound.protection.outlook.com [52.101.61.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EFEE5B;
        Mon, 14 Aug 2023 13:26:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiSqDzPTyYGWSI8GCyS9xi15mBq4xlLRQuYijZyXAL5yJ7jXRYHDfPQhH5n88bEO+fAcyU19ZoNKHnMOZjr2FBOSkePtFCHPwnXiLg4P0lU7SwUWBn+45R7zC+MJ7d9lY7gRGjqp2uv2H2bR9wokNeeVKfMXffuKvmokWsD4YGCbYjheVF655tGZlsmwjLbOBVcqeUVQlFDUbvM1YdryDYTM9lfBT9dQQAa0iQbwWCRrJUySNJLzN8mmDvCIUxqWcQYWUlIrWaMxt0KstT7FO74rhOPjXcOvJ6tTrjpse+5WDeAm2tpExviMuESZ0lZL5RLl0KPxg4MHFk7MdN7q5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX9Vu/O2ENmcdqyG5ObSl7TlggATcUHhrWyzlUJjExM=;
 b=TSaFVUOCQDLe34NryeUchZheGOFJforF1oVUkeuqkMCV+rsA9n1lmlaaIO+FLjFJHvWWa9zFapq3JZ+hO1yxjtUOISyqrlZQj5yBm9LW23vDYsWUMUiSCYFQKZ2yG3GV+lrfCK7nrJ232sK5Ou/Ecr8aMz7DCAV/kH5PhcCtAsSAr0Vu7SbsVSQ+cNN04N6JCMBq4a3jUFzK0h5Y0XACKEIpzdhc28EYkYeqvek6dqYaSuQA9gMBBN2MwXExef5YuqB9eI3KjcyYljySK39g3IojaQju/8hIIVzZDl33Fcb6MXL2SohI4hDEIBZDfiaVe4cAXzDteXBsLtbQ9uuK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX9Vu/O2ENmcdqyG5ObSl7TlggATcUHhrWyzlUJjExM=;
 b=fSTF4hBQDH4rHp+l06yQ0PjjtG5kvl1li0xeYK8GADrXoJkdZzze/PKDAGXbynvMKSIJ23c+NIHtnia840rPAiNvx6lK3ouDV9ugdZH/H14ZyqL+bsJPTcHgm5krPKLXUyMXXz7tAqe1C1UpYY5EwuUyoYZitqi3JOeHyvlGujo=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN2PR21MB1437.namprd21.prod.outlook.com (2603:10b6:208:208::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.4; Mon, 14 Aug
 2023 20:26:28 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a%4]) with mapi id 15.20.6699.012; Mon, 14 Aug 2023
 20:26:28 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC:     Jake Oshins <jakeo@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: Don't dereference ACPI root object
 handle
Thread-Topic: [PATCH] Drivers: hv: vmbus: Don't dereference ACPI root object
 handle
Thread-Index: AQHZyvQQxR/nPA3SdE6JdYogEZOaxK/qRPuQ
Date:   Mon, 14 Aug 2023 20:26:28 +0000
Message-ID: <BYAPR21MB1688ACCF36131027A665EB06D717A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <fd8e64ceeecfd1d95ff49021080cf699e88dbbde.1691606267.git.maciej.szmigiero@oracle.com>
In-Reply-To: <fd8e64ceeecfd1d95ff49021080cf699e88dbbde.1691606267.git.maciej.szmigiero@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c828fff7-5f02-4ad3-adec-97e2610512ae;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-14T20:25:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN2PR21MB1437:EE_
x-ms-office365-filtering-correlation-id: ec760dbd-cabd-452f-7892-08db9d04bd59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rO4LD0xGqEEHI3mLErkZkBV5fJxzUMAFa1zfBhHpjF25yvHEmAxW7swf/S5Uz8uOFUxeKUrNScswlLh5Rm1hO9cGuxXrNPTfjqE/drMwjaIh9rG39eS3Dur7Tomj/nd7KTmEK7AAyu3QGHogU3tqX6+uT6mR8/yYikt+FMVYV1w5WhPJ2UA7oq1PWmZkJMKZLJFQi5a05Nv6N/4y96PyjFjs/NItHVT51KS6AWjsPVzu2QO3r0OgZdlCp10tQGRBzuPsxwBg0iylV12SuzOonxkJv1AcfzJT5XI23YksSaOqbqW0ZdTroa9B8z0ncxj1ENUcid8Zu9FXpY30RPx3XOGcee8YOMyj6KsHFbe8eJVoVw1qLWhAJq3BULZnADeQ1+rzH3j2VazTNjAwWBMAWlr2Q1l/AN7uc5LkvaXpWZBOcEhdoheRhROPusIt6aNNVLCHJwHcE5qgRT5HY/BSfuQt585PU6GxF781A1pm5MbXJrvQI8JSSc1nHHwLORTudSi3QaWh67OaoTgINeZxwtJ+QweMOQq6BbWfrC+5zAyZwPJnUZMrxuJMeprfAWYNx5+P3TN5TP1Vtymur3KAD9VFBPulQQ+WTtZspdhArzfKNThjbNP1Uk6AvSGi4jd9UKs9YcrH3d7n5KeHhw+1V3I8fOcXml8TsRdXoOivRIBapP8T73rpPNhn42a5yZSAd8FTiyG06oIrQh05qOq1nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199021)(1800799006)(186006)(83380400001)(2906002)(478600001)(38070700005)(82960400001)(82950400001)(12101799016)(122000001)(33656002)(86362001)(38100700002)(8990500004)(55016003)(8676002)(8936002)(4326008)(52536014)(9686003)(5660300002)(41300700001)(6506007)(7696005)(71200400001)(110136005)(76116006)(66946007)(66446008)(54906003)(64756008)(66556008)(316002)(6636002)(66476007)(10290500003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mgdpeEDGTyfJ1eBxY+K9LPmEf2edsG0lPIrerswxwkYwZYbDVOy4NF6oDCeX?=
 =?us-ascii?Q?qwi0wtanSEbfOBWyuhZhZ/Fjwj6ZGyqZjghC8lwm76axq0ApwXDA6V6x6aOx?=
 =?us-ascii?Q?0oWBZAodBvqWL0ZRLN01naXBpXGKV3XuztwsIaqC7FFlZ8Rwhw0BV2MTLAMD?=
 =?us-ascii?Q?B2jrskncxVgl2Cg2Vryn2Ij0fxpxq9v5vuRwHVc7mBlSggkeDR/0KDKCDyBQ?=
 =?us-ascii?Q?uos7IVNecYU0jYUKAz6VGRr1QQBxkT5cSoZuhNq4T4kYW+wAjYNHGvTLenE3?=
 =?us-ascii?Q?HERLp2XhkXROJ1B7eqLfw47sIFfzhuCzUeigQ34tEHeRoWuVSL4vQuXZv2CD?=
 =?us-ascii?Q?w/g7ken6nY2QcwsK44y7YQYpYDljcBhJEtThWghs7l/y0ZhTsgJ6NQPPk/m3?=
 =?us-ascii?Q?TtUCokU0N31QQQlYynqo7YDggQvqB3pTg+H8H2kPIknYWP5QibcvMRQQaevj?=
 =?us-ascii?Q?PZsdBtaVt8JI4w4NvSBA8+CSiwAdts14C/aYO2hIsOag0yAi0q42T2tNe6US?=
 =?us-ascii?Q?NDnTk1k/U7Aa3E08JUHuvAQEuTE81VyoqAM56WKrRL17zOkj+RRY3UEQwKJE?=
 =?us-ascii?Q?DBCjSlAzhHznEZ9ksVl/dwppBL6mgjzQCZB5NEQoI/fP86HILZlZxg9hne1Q?=
 =?us-ascii?Q?J0lG2+MamonfdqgpYawaFOJbYpVCZmpa7Q4Dp4jjSzsssI4777E6mSgBuHm5?=
 =?us-ascii?Q?1jHy2Y8QBgaw/FXeiH10urky/reyTW3uuuzcvVZ4yOmdFZcu79hg1vVMt/gj?=
 =?us-ascii?Q?wHcyqsgrq0mg0IUp7JFSQnNNfIGsQKMuyCs1ti2iUEe7sDe3I5afcAIQG/HH?=
 =?us-ascii?Q?QzdIIr6oqK8wkS/7DlC2vmUd5P/v9uGQtOp95qHDdZA7P8kt9piqCHW/bLww?=
 =?us-ascii?Q?s0iDiU3v77+TxaNVWQfdgQjWSAWRXFVgBrCLx90e7BT+ri1amYxREjxhYLnf?=
 =?us-ascii?Q?YlMYD6U8qJ/p96eLO1LCSxqv0z1KPzdU34FsbYMSl7iKm67yLiL1CNdHf3VA?=
 =?us-ascii?Q?CrMbhRQ8WZZail2TkP0UvNRhNY+blDR0ezylCgXa3FwYC/9NZVl7U8e22oau?=
 =?us-ascii?Q?40uFcswSOgg4dom4ckb9Aq6SHQHfPbnNkaJ1op1vXyKh+ADuKhiBhDh0C8wk?=
 =?us-ascii?Q?UG++0Wk5gaeFLT7hfG5peYrmr50akU7FVUctoIImcm3wRRRv82C0AiSEZbJ9?=
 =?us-ascii?Q?pwLrLUCv1YbDubHeQpoSY08tk/Va/e3XaRVqftZXW9syynaQ8kEVT5MTYcD+?=
 =?us-ascii?Q?ie5Hxqe7+gfvGcMrfvlClKgI+jWlNS01TZvoVtK9ZpMOPTmSTN57KNIizB7b?=
 =?us-ascii?Q?cfceWf+hYe8LBViM4xZmhCoVrxuvFcPVk5ZGTEAgtPMPFA68Ieepc/tPPQwp?=
 =?us-ascii?Q?aMQWJv2vjkCJv5YNOJ5LYcZusG22E22hX2ZV2x28RHrOdkk1yZ9m5YXwA20Q?=
 =?us-ascii?Q?1/K46GlgjwOfwYjh4P8gJ0P1FCLEwi6qLG5IXefrVZQgrcwsK9jgmFiiAtDD?=
 =?us-ascii?Q?U+k4JsujtCIbxchzqHPcCQQ0DV9SaLKdDwygoMOqcEy/SIzr3gDXZyWoeUHx?=
 =?us-ascii?Q?UNhK0kfpxrLjm7SnR/JhLhzy5QLSbIaOxG48JJRRA2Jhy9rZbpKzFcLXC1Ve?=
 =?us-ascii?Q?og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec760dbd-cabd-452f-7892-08db9d04bd59
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 20:26:28.4918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: neCfjvjI7lNByDj/yO/Hr46SlC3wncq4q9Zx1bFRNDpgoDOgpWg19rolHsrSYmW0xXqj2xIXf3yA8ZdYhObEaMO4+6b/dJ0gvMuRJ0n4dVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1437
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Maciej S. Szmigiero <mail@maciej.szmigiero.name> Sent: Wednesday, Aug=
ust 9, 2023 11:40 AM
>=20
> Since the commit referenced in the Fixes: tag below the VMBus client driv=
er
> is walking the ACPI namespace up from the VMBus ACPI device to the ACPI
> namespace root object trying to find Hyper-V MMIO ranges.
>=20
> However, if it is not able to find them it ends trying to walk resources =
of
> the ACPI namespace root object itself.
> This object has all-ones handle, which causes a NULL pointer dereference
> in the ACPI code (from dereferencing this pointer with an offset).
>=20
> This in turn causes an oops on boot with VMBus host implementations that =
do
> not provide Hyper-V MMIO ranges in their VMBus ACPI device or its
> ancestors.
> The QEMU VMBus implementation is an example of such implementation.
>=20
> I guess providing these ranges is optional, since all tested Windows
> versions seem to be able to use VMBus devices without them.
>=20
> Fix this by explicitly terminating the lookup at the ACPI namespace root
> object.
>=20
> Note that Linux guests under KVM/QEMU do not use the Hyper-V PV interface
> by default - they only do so if the KVM PV interface is missing or
> disabled.
>=20
> Example stack trace of such oops:
> [ 3.710827] ? __die+0x1f/0x60
> [ 3.715030] ? page_fault_oops+0x159/0x460
> [ 3.716008] ? exc_page_fault+0x73/0x170
> [ 3.716959] ? asm_exc_page_fault+0x22/0x30
> [ 3.717957] ? acpi_ns_lookup+0x7a/0x4b0
> [ 3.718898] ? acpi_ns_internalize_name+0x79/0xc0
> [ 3.720018] acpi_ns_get_node_unlocked+0xb5/0xe0
> [ 3.721120] ? acpi_ns_check_object_type+0xfe/0x200
> [ 3.722285] ? acpi_rs_convert_aml_to_resource+0x37/0x6e0
> [ 3.723559] ? down_timeout+0x3a/0x60
> [ 3.724455] ? acpi_ns_get_node+0x3a/0x60
> [ 3.725412] acpi_ns_get_node+0x3a/0x60
> [ 3.726335] acpi_ns_evaluate+0x1c3/0x2c0
> [ 3.727295] acpi_ut_evaluate_object+0x64/0x1b0
> [ 3.728400] acpi_rs_get_method_data+0x2b/0x70
> [ 3.729476] ? vmbus_platform_driver_probe+0x1d0/0x1d0 [hv_vmbus]
> [ 3.730940] ? vmbus_platform_driver_probe+0x1d0/0x1d0 [hv_vmbus]
> [ 3.732411] acpi_walk_resources+0x78/0xd0
> [ 3.733398] vmbus_platform_driver_probe+0x9f/0x1d0 [hv_vmbus]
> [ 3.734802] platform_probe+0x3d/0x90
> [ 3.735684] really_probe+0x19b/0x400
> [ 3.736570] ? __device_attach_driver+0x100/0x100
> [ 3.737697] __driver_probe_device+0x78/0x160
> [ 3.738746] driver_probe_device+0x1f/0x90
> [ 3.739743] __driver_attach+0xc2/0x1b0
> [ 3.740671] bus_for_each_dev+0x70/0xc0
> [ 3.741601] bus_add_driver+0x10e/0x210
> [ 3.742527] driver_register+0x55/0xf0
> [ 3.744412] ? 0xffffffffc039a000
> [ 3.745207] hv_acpi_init+0x3c/0x1000 [hv_vmbus]
>=20
> Fixes: 7f163a6fd957 ("drivers:hv: Modify hv_vmbus to search for all MMIO =
ranges available.")
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  drivers/hv/vmbus_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 67f95a29aeca..edbb38f6956b 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2287,7 +2287,8 @@ static int vmbus_acpi_add(struct platform_device *p=
dev)
>  	 * Some ancestor of the vmbus acpi device (Gen1 or Gen2
>  	 * firmware) is the VMOD that has the mmio ranges. Get that.
>  	 */
> -	for (ancestor =3D acpi_dev_parent(device); ancestor;
> +	for (ancestor =3D acpi_dev_parent(device);
> +	     ancestor && ancestor->handle !=3D ACPI_ROOT_OBJECT;
>  	     ancestor =3D acpi_dev_parent(ancestor)) {
>  		result =3D acpi_walk_resources(ancestor->handle, METHOD_NAME__CRS,
>  					     vmbus_walk_resources, NULL);

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
