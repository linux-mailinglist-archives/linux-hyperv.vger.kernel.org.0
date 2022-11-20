Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667EE6312A0
	for <lists+linux-hyperv@lfdr.de>; Sun, 20 Nov 2022 06:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiKTFu6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 20 Nov 2022 00:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKTFu5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 20 Nov 2022 00:50:57 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11022014.outbound.protection.outlook.com [52.101.63.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BC7A4167
        for <linux-hyperv@vger.kernel.org>; Sat, 19 Nov 2022 21:50:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tp9Z3U1C7lHetGMl9PnEt0nAII+QXbghKtV/PRvaEMMYA1QC/r9WyRylzRNf22Bw9PxDEQVEeIOFlpHP6aYT1ddl3mgRr8zagzvbXh4qbXOUNPnAMLVZccSDthI1jpLPbdYGKhv9sMD+izKsJvvesWbYXd2B1Icsyc9SUY0Gs6fhAXtwww843afhP76w8dnN6LZjV6/v6iDjO7TZCd+dV2YF/Xg2uKTTiDVJ2jcdqE7pNe5qQdDgQFU3nmvhfsFpQAfGsJv4ka0D+3npOlukHcyABLNXoZxyxhWIAMWpuAHWwMPu5xXOKwMXXX9G5xmH3AcR4PTmgqULfDs7dMs0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQ2i6PD2eULMQ6PQxHWBOH/2k9x/w/M+qUlvYy1tUrw=;
 b=kS6f1zlpNzajqHJfTwWuxcOe5yXlftHnGA9Uh/7f4ZnHj6SgutyolBWo/9yTMCCj7mtHR4jSSoKrvNMaPximnD5QNUAQ3/oq1uFMjN7Ph26Wfbkr8agY6/augd3gObpFYcGytPcWnzMNIsz4mERVH3Ec5+dISGc1LTOCL01Gcn9vS0aEgrcYp5H+1DF3LBfc0UULGBs05IWXl1LC6FoDFfrpzq/JOT3X0qZPhP/gj0JpPERmdW56yCeyfhuWWeVo7tgSMMm/he80ukAWtU+owhpfth+1n7ru44cqdpOgUeUUjZLu3jb6zG3sbCUdDf2fodwQYOulZ/31xeEpGFWFJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQ2i6PD2eULMQ6PQxHWBOH/2k9x/w/M+qUlvYy1tUrw=;
 b=CREs32AccYcqXFFJuOR3gtNAGcVeNDTfe1US9k7dKPhworFq6urzp44AbERCYFmDiRchh1HTgcc33mUl8Oy6FczJhTknI/sjL+xkfygKH2lmE1PIi/IETIX1GPC+5zqHF6BS7xxvLGcGx/Mxd19VJHS7IoMMh3hopty/SsWtADU=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by LV2PR21MB3060.namprd21.prod.outlook.com (2603:10b6:408:17f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.0; Sun, 20 Nov
 2022 05:50:54 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%4]) with mapi id 15.20.5880.000; Sun, 20 Nov 2022
 05:50:54 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v3 2/2] Drivers: hv: vmbus: fix possible memory leak in
 vmbus_device_register()
Thread-Topic: [PATCH v3 2/2] Drivers: hv: vmbus: fix possible memory leak in
 vmbus_device_register()
Thread-Index: AQHY++7OFe4+Gm6NcEie9idZpq8aaq5HUBOg
Date:   Sun, 20 Nov 2022 05:50:54 +0000
Message-ID: <BYAPR21MB1688A1AA2771EED71A0A09CAD70B9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221119081135.1564691-1-yangyingliang@huawei.com>
 <20221119081135.1564691-3-yangyingliang@huawei.com>
In-Reply-To: <20221119081135.1564691-3-yangyingliang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=655889ca-a35e-4918-ac6b-00a2bbd0cf60;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-20T05:50:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|LV2PR21MB3060:EE_
x-ms-office365-filtering-correlation-id: 87456769-8b7a-48bc-7b9d-08dacabb3027
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cUZxit+qQpP+tYg6SPNu64eaSyQpNwQAiY6GPT0tj75TdyvUygFOEhL6EqYtgiFeDdDfmlQICAQP5hsambSBr22ijw6xdwAkm3llEkI1iVouTK0FagBrgPR41760Z5Vi7jR1VETmqL8oUT7rzrs3h6aPeYvLiSbHMHW3xD5G/RdPnmudtVoHTWnLFLctsQeGJct/rZqBzt0cN9hJT0sOrYdzZdDAED2kNBuCsLnjki2nTetAhacmX0YA35WxoN2ypVIUxYm+6kiJmL1cXcvb7FQGIoGR9zL6VHMtCCamLtCNQ58b/aPPiEdVSePhnwregIencVVcfOYVwTF51cd1QLDSnUMd6gN24v/rvtjrSp5kJ05JKbdC+itEakj3eQ2yDdFrqtzehbP1si9y+kebcziR5A6DRBoJFnlVJ9L7qkjEgBs2rZOqlN4etxXSrS+CUd6/1LyINyl2JDeO53ifym0lZSa1wDaZnGxD8UKMV/w5KCADEm8LHgPmvDtWsBOozLumkb6vNKUwKb+Q/Hd5qVoQdFZowybCzwZyAERnpobnnd9GnU9pudMdmLyxDx9yd29D0pUJSpXTIjSqD4Q0DdAuoPxWoLgeSL6Mnj1qK+baftwdHN5EXHSk67cacKbT3GXDiNsKgL6QolOMlAPoivZM+rRDVyRPHppHmXHhqpBGgQQaxVv6MYwobBnlBhDkCUf+ezDAnJ8wcb6HT67Y+gEnBg1SGsnBq2M8pHAZuLN/ibWJ60+X+fTN0WIg7OHI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199015)(55016003)(110136005)(54906003)(316002)(2906002)(186003)(52536014)(5660300002)(8936002)(26005)(9686003)(76116006)(66946007)(66476007)(66446008)(64756008)(8676002)(66556008)(41300700001)(4326008)(8990500004)(33656002)(38070700005)(478600001)(86362001)(82960400001)(82950400001)(122000001)(38100700002)(107886003)(7696005)(6506007)(10290500003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MdrcXSx0lnBdlbG4RwIhncGLc+eluf8/9wEW0iBnU6atP0Qb3oKvnUTVrHuf?=
 =?us-ascii?Q?I+zIT0WjMBqaeG/i2VGbDJ5qXkhpSk81iDQyOQ/yw4QDCLHLmIGuo0rzbsQZ?=
 =?us-ascii?Q?EWth9i7A9lB28OHYzhTGI1PjHYjA7LYWvo4ereGNqdqXROcUW+eT3uEyuRcQ?=
 =?us-ascii?Q?nPfyD41+v3+aql/PYrBcaJD0YPkPorA3FCmBOYhVRPgxrnbJ/pQK8/r86W2E?=
 =?us-ascii?Q?3c+lXAhGuIaDpt9MoRhC4+Uvno/nHIbIppRGbBm5/qxnl27FxOCp4DvBXuLc?=
 =?us-ascii?Q?AR4PlCn+N97XH58Q2NND1ZGmQmHqnbJD9ULpu701IOq0I07r/dMyc8x1X3Wj?=
 =?us-ascii?Q?uFVBg2OMDzmO4toMZvgJh1l3oCzUz4vZft9fce+UVZSX+VufAPznUf8X/KNj?=
 =?us-ascii?Q?fxEJKibQC5dL/4Mo77LFDOoUNUMCddmPgawAToL5TAlDIlhMqaTSVauKH0o4?=
 =?us-ascii?Q?SXuvjm8Mu8/gYnyteeSW2ZbZB8znZpRd7FM9mD3yPbZi7Pepf77QiPBHkBHG?=
 =?us-ascii?Q?YMg7aBN1fo+8yZEItByndGQ3c+UoV4TwI7UR3sqKRGapKSgId+rSBxf5zuXc?=
 =?us-ascii?Q?aElo8l9GrbJ+L3dRNJ4JK35LuNbq+sRabNjcgq8ZfRH9uIqqZIGf9sM7OeMn?=
 =?us-ascii?Q?M/bwPkUwcrxUcvz5b5hgp2ABfUwM0qcQ8GHLS6dNE8vbx7hRVqfMqCaE4sQ/?=
 =?us-ascii?Q?y6E9jaJvgUlro/MYvqDj5RlNHxr+Fgh7qE3PuAb+o0ELwAOxRR9S1LTzJrPP?=
 =?us-ascii?Q?RgvM9tIgHxToZBAfr7X8oMuSkgi2QNNkti1rG2Q4tsDnaVGW5HX7qMsqMDfn?=
 =?us-ascii?Q?JFohPk87TfnI/YqjE0A6tgruMdfG1699Z/sOzOqCOBGe8b/cAnloduyu9qGM?=
 =?us-ascii?Q?N17tVeVZZiQoU0gHR9j+Q8QEJxq8vsEXMbqmb8SewxfX7Oz/KmNm/N8utPis?=
 =?us-ascii?Q?cmGu4ULz0nhWg2HbA/wY5k3xQN/b/mCLDCWRnoWDJ8nh/TtHHvTBIFY8UC2v?=
 =?us-ascii?Q?x8SX3xBWDme9EbQ4GDo6/gWjpIskhkE6KKBDwFPnwRQ30lkJJGvTd570PnbJ?=
 =?us-ascii?Q?Myf4jRw/iWAptF1wOw0eF4VpEo9fbosZE339G3cE+iDl8zdXkEPVtWeyVg6A?=
 =?us-ascii?Q?XqBXn1otP4C1cN4DALZeA/+AgzNkFYAq0wyh/razeoLL1Z//TxHWyxtPNmCR?=
 =?us-ascii?Q?yPH0Z8YCNg6bAkMaY5jFogSFzC7X+Rln64hAvAfVMb6ydEPRGstU5DT7QBDr?=
 =?us-ascii?Q?SwOm+2gqkkPxszXBmO6n8mveIvnjKhICZCZI2Z+AnAp/xdJX9FBSwlrAu/JJ?=
 =?us-ascii?Q?TWN/kxnakZw75wDzACq3YXeHoebhZhytLI6q5Se4IjY2Wr4Y7m4V7NC5WrYh?=
 =?us-ascii?Q?yOvmBSjGBLauMFfImdXa6YP/2CVm2IJ2fUhkE/Pol9ox8bFlYBhydatO1SeZ?=
 =?us-ascii?Q?sMrXfUFhwmzyzdvDovNuG1az+cxTaUqt2NLZBxmWqNUZv3NWyWBxmfDKi6Qw?=
 =?us-ascii?Q?qVtmo2TUMEZ0t+MH++qg4/seCZuFsNtOQJtYIj84nA5ldLGx+0UapQMS1V+g?=
 =?us-ascii?Q?MAlWwnV7jN690fR9wBisAMeA16BVlkjTKVpN3aT/PHFIaFcagQHmQKdRmnte?=
 =?us-ascii?Q?Sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87456769-8b7a-48bc-7b9d-08dacabb3027
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2022 05:50:54.1466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vw82q2PrlSoRlulO1n6iNAjk8OjNJ4Mam2fThbbxB7S2TGg6lYOPntijracTMSCq0afSNGO3DxGBuucpihRW0iyviGsd191nKUOLKi6n874=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3060
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com> Sent: Saturday, November 19=
, 2022 12:12 AM
>=20
> If device_register() returns error in vmbus_device_register(),
> the name allocated by dev_set_name() must be freed. As comment
> of device_register() says, it should use put_device() to give
> up the reference in the error path. So fix this by calling
> put_device(), then the name can be freed in kobject_cleanup().
>=20
> Fixes: 09d50ff8a233 ("Staging: hv: make the Hyper-V virtual bus code buil=
d")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/hv/vmbus_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 8b2e413bf19c..e592c481f7ae 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2082,6 +2082,7 @@ int vmbus_device_register(struct hv_device
> *child_device_obj)
>  	ret =3D device_register(&child_device_obj->device);
>  	if (ret) {
>  		pr_err("Unable to register child device\n");
> +		put_device(&child_device_obj->device);
>  		return ret;
>  	}
>=20
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

