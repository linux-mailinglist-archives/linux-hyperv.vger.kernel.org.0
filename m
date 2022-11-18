Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C0162FBFB
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Nov 2022 18:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbiKRRsr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 18 Nov 2022 12:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbiKRRsq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Nov 2022 12:48:46 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11021025.outbound.protection.outlook.com [52.101.52.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324B113FA1
        for <linux-hyperv@vger.kernel.org>; Fri, 18 Nov 2022 09:48:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOIf7wYQsghyyaJfzu42SaCLV2TUUFu2Iq3WTfuB76OT31GiKcp1DsfevqgHdun8Qqfb8w7LJLDQYXg4Z8cryGDNx1geVrwHWtozqwSkRgi1X2GWQ950sUGM3s4YDjeGIIeFyG6LjlNlciGqd6WVERnanvzTXSiXa8NgFnmRkPakTIp/rzsnRUPQvtctviPSJxi2C2zPoFZTB3ed5SKehH7QqH+GOTgqtl/LxnfZvvyV6IMbyTKglO7a0n+fmL20Og+EdL9nrbGJdT5MR/H7FRAV46awv3DPP4YLbCJs1sSJI2k27sYWuPNCfCMEy6MlUsiKaeXchkJORDLJ53Cceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mylJd7aGr0ZkYy3qBW0kkMHk3WHM02paGz9b2yKuUI=;
 b=R4IYNREWltNSdSwcd8359PzK3Xzp/MbTFHTZbnIjZiWGa75nQUaNRvfsuExquwxL6tbwZ5kAeSdDTzUs0n2Q6+A+bXIOaFy16DuJyh+neMSXebddcv9iybyDwQpFSGZyHlfyfnSS1uIIQDkvqeCHdAAZi6aMNcwwOcOkHsE3s0FgC8f8gbUOxDVl0looe9CEIMVakNx6E8jDabKKRBI4Q1ox0V/IovbqJ61eOFKfrO5HyuoiGfCai00Bt2xnoJ/Pg+yREQhPMEclycQfBbVXdrr3g/qRPhYiYlGMRm88r2kw1MmxGHQMG2jOgLQ3GIKlutdEKgHXVtv2rCzI01UwBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mylJd7aGr0ZkYy3qBW0kkMHk3WHM02paGz9b2yKuUI=;
 b=W7XAaJius+lAFcFvv5sHxHdTmvAha6N8NzsjlIVXwJ1FjZvyq6YI46R5yXMI9GdEyYtUT/NPuUCiPxtSPOL3OdfzAFw9QqmbYYoGF4nqY+IrHAPekbyTA+7RFF95oewl5zXBUUTHw/DI0ig/W00gIg+BbYWzpgFOuIJiYyQkHWE=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SN6PR2101MB1342.namprd21.prod.outlook.com (2603:10b6:805:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.8; Fri, 18 Nov
 2022 17:48:43 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%4]) with mapi id 15.20.5857.008; Fri, 18 Nov 2022
 17:48:43 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v2 2/2] Drivers: hv: vmbus: fix possible memory leak in
 vmbus_device_register()
Thread-Topic: [PATCH v2 2/2] Drivers: hv: vmbus: fix possible memory leak in
 vmbus_device_register()
Thread-Index: AQHY9W/9wfQpwnHb/Ue/mjHXe3ge6K5FAO7Q
Date:   Fri, 18 Nov 2022 17:48:42 +0000
Message-ID: <BYAPR21MB1688B3BF9FD8D094A463178DD7099@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221111014847.673576-1-yangyingliang@huawei.com>
 <20221111014847.673576-3-yangyingliang@huawei.com>
In-Reply-To: <20221111014847.673576-3-yangyingliang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1f0e3c5c-def1-4732-97c7-c9da8439e906;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-18T17:48:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SN6PR2101MB1342:EE_
x-ms-office365-filtering-correlation-id: b08994ed-0997-4e53-3cb2-08dac98d2257
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W5PCH3M272eyd3bBg5cbOFb4wijRfmkBmIdzTlPtL4CPAaTOq0+CEDjsaliBV/qYk18NUg7Z6oRQmQb2EmRZ5zMYrwZ+3tBr8bjjnOrRlezrnmj4lQBd2gim0kvWGptCcr/us3BHQ8sfIh7mXUbgoCCI7iLUCuAQIGA7mM4WjGkd49AH0skmgCIyTdhPOe/QpSwZBATeIB8QtjUaPd6NlkZvg+thlP7ylfuUjSJ35SFJllIdU9lXU2K+bBxrWpXu85P8+mD3ny2YdL4nWHGe/U86F//eBz6FfbD8q8PnSYUx56kZ2y9rDJ1+JohNIR25nyQQLv/7gvQE4VkJLP1xFetaOmzy6X+UHyCvOu3+aF9RmJSJe3fUxioJrygPOVnDOLcX0TpXO1s/GgbgCR5JAKHJYSKd7OYiZdHuyUxe/GHio1L73YXEZlVvev89JuVkdXVgCi1m/Hu0jRvFGvnMG/unSQ96nWMIS6NcZizBi7cqCNvQYXC+YWBsSEJ6rLThmrSaYVOdeur2WweszlaEA3T/aqgDQG0xYSRbvKmNs4JodYyJI9v/11pHsPjZ6lv/+xtH4SZKe7tP56Ny77iz1hjPdSV3o3/c0tSsjJ7YKJDBm96jTEHkoDH2EZw7woIzcS2ner5daxq8nPEvNw73VCuItGm+Zvs1pLfnFRw6XqLgSGFUbCf2PgIB1psYZkp/N66WRvszLNIgKWJaHJnO+N4AW4ADnHV50RdIrv/h4r32uncbJbZCtpF5VV39n9ys
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199015)(478600001)(71200400001)(38070700005)(110136005)(10290500003)(7696005)(54906003)(6506007)(107886003)(82950400001)(26005)(33656002)(86362001)(316002)(2906002)(66556008)(122000001)(64756008)(66946007)(66476007)(4326008)(76116006)(38100700002)(8676002)(66446008)(41300700001)(5660300002)(52536014)(82960400001)(55016003)(8990500004)(186003)(9686003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GAeaLqFA3XAYHhl5jqu4MvCdRWFOLBzovSJdL9j1R60XeE+Sb38ysZBevJVU?=
 =?us-ascii?Q?SprJdoLbSTaZpcOKiaVvADRhUIsk270gj/fEEYqDGKbXAegWQgzq7jCNxPOR?=
 =?us-ascii?Q?9H5Xw06ifms1itBebByy9T+l4N3NLJW+wHrEj9bjfq0H9Z1BY0k5Bmttw/Xv?=
 =?us-ascii?Q?bOHro3t1BcHS8UTt+Vc3Cc9W4P6A/u8Pw1wTNVnb8Dp/rIcYD+npgVDxpbuY?=
 =?us-ascii?Q?CF1ugThplmUbTZtTbJQ/v8pOOvWxi/044kHQc3GzNxYT4XhML1U9yn1vPmdL?=
 =?us-ascii?Q?emdF7snktUWRIjlJxIwhojCCnEO3RQJseJ4jyojYeX7ab4xV6MhCNx5m5oM+?=
 =?us-ascii?Q?BYfYQD3jsac5HUw4ZDKUlJGPaSCHgUm5yQMLTLOUcgxyspQU81BVcJ/kNhm9?=
 =?us-ascii?Q?X+pY3rM5Evqo5XatCgQk/ue1EMNk0RzmllnDdXMV/uO9/uKbQzoqJYS644Mi?=
 =?us-ascii?Q?z2jQVuegcKhL4RDCzCCzkWv5AM+SMTdsrNj9F+7rgd68xvf7jrpLanuUUVWm?=
 =?us-ascii?Q?RQh92yiRxUuUqit2mGzfl41YYEF+78xu3eLwjlsi/C5FxtB246d0XsHvwhJs?=
 =?us-ascii?Q?ytYdwIEi+BXFrGfz9jrl1EkX/pvuN/zbDlpLB2ZiX+qjw8W8tlgvtgm70UOI?=
 =?us-ascii?Q?kWZhO8aDKTuYPKSNbx7LH6ezUlPBQlfL6OiH1+DRgOn8IGIrpg5jECg7V8Wv?=
 =?us-ascii?Q?XzdSn10jjHsM1rOvGKitTOfmQF82peZHOpF7EmK88teB6C3QoiT6LTZbqAJQ?=
 =?us-ascii?Q?nKI5U7gdl0lVAVzIHM1vHT+c/CaazNpu28kp2ICj9is5w6frLIVxBEJxGWBJ?=
 =?us-ascii?Q?h9sOiZXkwSFhS3CXQIdjD4KWRUSdhfTv7gBXD5qra8K3xhzFseZ18xCrMbB1?=
 =?us-ascii?Q?g3ln3wVfcZiERzoe8vnURH3V/kHKdJUlG3DFc2CvpxDumxiQ+u/ZQqGXSLKi?=
 =?us-ascii?Q?og9PP9TKUk9uluZvD9WiuMrRr2beLtxERWJlCAaZlC0CbFq6FPOvuvaHej23?=
 =?us-ascii?Q?rL7tMLd5bP2/UCgNHbFlSqaN+SvYmTw9yWat+wpXbDVlzo31KCMtcVS3rMb8?=
 =?us-ascii?Q?7UfFEV01s50zabxBQ9or5kT9yC0VAwr4DHzxRT2CVgGv/GuAo7vuo4W9fK6J?=
 =?us-ascii?Q?7v/Q/aejcf5fEofE9zRH8e/Hm8hw1qcxGfiTyzFfT9M9JTI9mGMpKLXK4+J6?=
 =?us-ascii?Q?2Iq+p6TDxK04Z3NPDO1D+dHafxZU46GbQRi+PEkL9XG8hfaQdu/0+Cht4UF1?=
 =?us-ascii?Q?UwBcNvdjUyhdtsuI1pEcW48SxR91dYdnOemEvLA5xXT2eR+bglbdi/1B4cXm?=
 =?us-ascii?Q?UvNrWOP7HhHM686MFFfgqjix8e1svfeIa+OTEBjcXc6M5OkQvOaMmomX/07i?=
 =?us-ascii?Q?8dklACC1t8fjb5zys3ofuR4iaJ6SBCoysbHdm2PcOk/i/eZIVPkny9Vukdrl?=
 =?us-ascii?Q?H4YMHivUX7q1CgWnn0/bf1GDOK6fEYetgPcdiMawtvJWLubl7ZnL0C9e2ncm?=
 =?us-ascii?Q?FKddzi0YlZbRras2UPYUejvctBb10RmaiOVa+CoCp2AUJ6meRqmepAwHeflD?=
 =?us-ascii?Q?FRgF2BzIkZlgtDV0DasekkM4ws0lviNKsCOCDXm+hGJzdgCpzrz6hJog5m4Y?=
 =?us-ascii?Q?jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08994ed-0997-4e53-3cb2-08dac98d2257
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 17:48:42.9904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZHP52DtN8NvitgIBW5RqinZnjjEfB1qVhALgWeEg3JgbvUt6lS/gqBrxhaDhNSho1UuzFV/lnGJM/hi/04mFWDIJ5rUtNW1FRP3p+L/XqPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1342
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com> Sent: Thursday, November 10=
, 2022 5:49 PM
>=20
> If device_register() returns error in vmbus_device_register(),
> the name allocated by dev_set_name() need be freed. As comment

s/need be freed/must be freed/

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

