Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C556728368
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Jun 2023 17:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236824AbjFHPQB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 8 Jun 2023 11:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236748AbjFHPQA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 8 Jun 2023 11:16:00 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021015.outbound.protection.outlook.com [52.101.57.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4722D76;
        Thu,  8 Jun 2023 08:15:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/ZW6LSCseU3Tyn0paWll4IpyGrS9hm2/O7wM4Ectk0l1aZ+Fd6OcmCVPqmvUU5/f3AlNUccNQcax9PTF2MrZ7/jCD9jBf8892Ou8EGmGULLYujBF4CLPOyCnUHWUC6aV+NIBm2vGH2RnpZCejBUhJTbZz2KwwShVQdwt5/EjmIJRoCSzSHPQPvsbNdBSw1huS1+RGmiY90+775r+upfXFKoZJzLjMAlC/AkI3yzcb3BEkETMPXpDmJEb2Typxn6lh/E8TAHWHp5l6THCwRMh7tQktaZ5GVdKlnkGK7+Z32c7Kf5/pR0jmagX7Fx9ehgPi0a9nTc/Tsu/tmieH7AEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JF9SSrvtfeHKnCOI//p14wuZLYN1kYmgiK/Jbw+VJbo=;
 b=Z5E9LoM4/xn7Id2ZBye9rLGwuwQkQEXcyorAUVibHOBqX3xJmQj0aNTWMHEwGYgaEftepKY4oEAHb07X0LBWbxC+PJu902Nl9xKzkAKDn8sebpAQSPmGUq1Ovl0edurovP6YQ36T24EXZb9aIj+WjZW+FEvOlyhGVWLAFdlAtzv2SaGF2Blfvt4xZ/GJApEqqyDaIMm4HthaINet6iF5AkW5Mx1+sDZPpNb06E3E8Fe7xp077aiQh2ZK1cQG46AoeGSi1YwqsFKMTbS+2nWp5o/NGzSwAiZaJWgi8PQqBGCXfKLB47Vhw6aL2su863Dxitc4yM1Ae+T7UZP2KsXu1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF9SSrvtfeHKnCOI//p14wuZLYN1kYmgiK/Jbw+VJbo=;
 b=QC683X/5OWygLUfQaX1C7P9IcRRu9PBSHCjlTPDj1LJPDMS15oX2RNf/DJOR3BWSNLspsfM8+qDc6M+RDT/YZ0LZkDBUbvwnO8bZniLNn4594MmiWLtH27hOxsWJezD//U+K+ZeFbQS0Joo7C85caBYQ9Bcvfj8Ns1Iwp02mDC0=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MW4PR21MB1955.namprd21.prod.outlook.com (2603:10b6:303:71::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.14; Thu, 8 Jun
 2023 15:15:53 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b%3]) with mapi id 15.20.6500.004; Thu, 8 Jun 2023
 15:15:53 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "nathan@kernel.org" <nathan@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: Add missing check for dma_set_mask
Thread-Topic: [PATCH] Drivers: hv: vmbus: Add missing check for dma_set_mask
Thread-Index: AQHZmOF2t5CS72Yo7EWOWPcfmSwiDa+BA2Sw
Date:   Thu, 8 Jun 2023 15:15:53 +0000
Message-ID: <BYAPR21MB1688B317E2ECB18E709502D8D750A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230607014310.19850-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20230607014310.19850-1-jiasheng@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9bb7716d-127f-4c28-a6d7-daec35f35311;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-08T15:04:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MW4PR21MB1955:EE_
x-ms-office365-filtering-correlation-id: ace38b94-2bc2-4586-3517-08db6833401a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9GSVtFk5Ze7FYDjfmUc5RtPJnvtRvEspqbJJtvOjrIWrYDJ2hv+oLOEPsCJ0/7p9jmNrHgl6k5h0BLfg0b2C5gW3/YdvJxGAnLMhDFjVk3DHz4K89aOv4OCWCwseTPZpzMGyM853z3vqvI92bK46QruLK8b5MBdtC+g4keqsdtTw0mf1xlBPPeEck+vEKkrwYunNg7kCilMpJYYomm7D1AIQIU9Zzuc5KFZBFUZZdyswB44fs3BJWkI27ZzopO7eqotEWxmq8T26mSIbzCLckXJ61Kj2hWunwNAfFvpLkmqJ+2X/T7hwD35QTUO990uM4SAz45SXPdCGsp8ghXMF7SYJr0EYqFxSGRkKv3uUvEIG6dHEe/+2HBeR/vxb89c54qFJkq5XzdWOx2zf0VZX/Xu8jqUtYhTyKeSn/dkNd1FBy8nNPe1nxD6YphFtjI2WdhFCSPvN/P4FecyCkHTg7DxFt7UFjVkgcQrcHJkK2st9cBaH8ROH6cCl08ScA07JXzLuWkrragpZYj1bqjiKMk7GJfIyvdXELsbC0vQZTLGMpwoY5HnPybUMAwpdFrOUc9rYOQTYuCIwx9HZV7LWTmMrFgo6jvL2aTDenRACHBToi+9PRjhfYSPeZnyMgInMrtnyTTnpgKXhpg92Vm2u7OPtXdyWZj/e3DiffsYDi2c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(8990500004)(38070700005)(2906002)(86362001)(33656002)(5660300002)(52536014)(55016003)(71200400001)(7696005)(83380400001)(186003)(9686003)(6506007)(26005)(122000001)(82950400001)(82960400001)(478600001)(110136005)(54906003)(76116006)(66946007)(66556008)(66446008)(64756008)(316002)(66476007)(4326008)(38100700002)(41300700001)(10290500003)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tvc0l5zus1r0Y3cY9wbaJL2O78m3MoO1hfMHmvtnuZD06pKy3A7jiHNXYndN?=
 =?us-ascii?Q?nLjBT+hjme5BUhTvrJVjhHmLzEjxt6Z+AepArBncwizpoJavfaqM+rHPX2ot?=
 =?us-ascii?Q?zKwq9hFKy+AwYICWtr+t0BND264SZ5YNLVuROVTWUZMEElYFvY7tJ3mH8Z6y?=
 =?us-ascii?Q?kHq3GNskQvwpT0NLF06nrL2Rtd3j9jRdRP0hsGn/ww4UbpEzl+dZuiZASaXx?=
 =?us-ascii?Q?ndidZUuBMv6d2ql0pTwndqOySTB6INxtfk7Ae+CvX6DzVodsNBiSXSXj1CL7?=
 =?us-ascii?Q?sIGLef1dskXS1d7RsiKYibQUqqVxulFM2PHYnFDkIXbvP6Lgwjt3rr88C0ev?=
 =?us-ascii?Q?Yp41hiHyOhjm2rWn2TWqohjF4n4m4twqzw8R4cTWaUt/VbFU/dG8CbNZSirA?=
 =?us-ascii?Q?HyzA6QWvzMVatAgKMhzoe7qq8ElBBiNokCYS2W8VpRTs8lKMrAtfP32tbpFe?=
 =?us-ascii?Q?93Mnz6ZZt3DSkUCRTo4a1za+T3cfbGZlIHgTFZLAKDpKMQzt8ADJNZNMS9Oe?=
 =?us-ascii?Q?FSVWARbEB+sXo8SvqGbmHcZm1rMNsv+uM3kXiROdlRuAs7i1pwTqGPBA/BMm?=
 =?us-ascii?Q?ayFOBeQ+HCq2aH4Y4g0pO9QXV2bi8E7yRkD91tpbqYdRihiA+y0efmpbSe2T?=
 =?us-ascii?Q?kS/a9KvzOsmAZW0fq4Z7X3fYZ+pG61xczaxdkZvgOnX3MTaQpc2UfJ6XbHMF?=
 =?us-ascii?Q?AZVntzLIQF5GRhiw6iBk5gtTicq+bMqHt4ZGdFNA5KoFhxBWhMqAzx0U/u/Y?=
 =?us-ascii?Q?l99nv7uhwfd+jEE79G9XKVBA9zYmYzPCSp0kqqluloQ+Bknfvj0ex3RueN8S?=
 =?us-ascii?Q?oCgP8jzvp41tyI1rY0UPRWMlpG6KI4uNMZiHa3WZlXIQrHCe1iFqpY+yJUwL?=
 =?us-ascii?Q?LoDPFArhMZcTwZzPUYqJah54AX3+G4AIoGtZmx8LRVesAoS8A69t/iyqm8LQ?=
 =?us-ascii?Q?AkSMsWDUSa9wAiQgWXNUDAU6F1sQOo75PKwMhTsSvUn723dHwAu1l6HP7WMf?=
 =?us-ascii?Q?yfcR8XVov1V/ZLLk+VqL/+eCEULtICcs1fIhIiDAVr30ifpAND2aJ352FMsM?=
 =?us-ascii?Q?/jghlcN5cIUgJ+h0C5oM1fjg5UuHKmOF0AJiAe6mNLo7sHmzFHuCj3XdO7nE?=
 =?us-ascii?Q?Ctsxi8mNn/b8d/13jsjAZpQjijj3nw45ZC5MHejIyCakvkEs5EB4pgUvjjqO?=
 =?us-ascii?Q?yvFRMXZM1rk2M5Qg23K5k3dmXdu1qphPTZJwJ4KaLJBkrKWivqlLW1dmNqJB?=
 =?us-ascii?Q?UhWVATeuM9Q1r+Pq+Rtxcum9FwywJ+qiXqgEKq4aFiQ3+iOv6GbzLYXe7xqU?=
 =?us-ascii?Q?Gg9Q4EdQPPSGSMnFzwBejSufUFVoNYw5WKwhIvye+r3QPheMMyyu7KuJObWO?=
 =?us-ascii?Q?ofQ91thFKLeBAOEult5rVaaC+XW7lV3Fd0RAY236cPYbGhhbEZwEsWmcZO4q?=
 =?us-ascii?Q?Qt+mYGBrJk6T2DBGTgappkshDpRRJlhUNSYQS9OgvMXY+/7Flb/uqh6+Pn3J?=
 =?us-ascii?Q?wlOo5R/NBEla/LrZ/M5+4J3uRyMCzkmmTqRFE+vdxyryau7Vjpyy913EVCjx?=
 =?us-ascii?Q?SZKWviI1SjuHJEMolryWm2KvOLE6nJbHmO2cjtvPB6fhi4lqZia1S87Fwgt0?=
 =?us-ascii?Q?SQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace38b94-2bc2-4586-3517-08db6833401a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 15:15:53.0983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: diYyU5Xo0+jJ0+o9TjbWn3JRnrkelUqhwRPAwLVvQ1CBsuVlxDHuxxsa4WmNaywQ5OV8aRRfi1peegZsisJqYtYbMFsczZqjka8T//DYwPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1955
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Jiasheng Jiang <jiasheng@iscas.ac.cn> Sent: Tuesday, June 6, 2023 6:4=
3 PM
>=20
> Add check for dma_set_mask() and return the error if it fails.
>=20
> Fixes: 6bf625a4140f ("Drivers: hv: vmbus: Rework use of DMA_BIT_MASK(64)"=
)
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/hv/vmbus_drv.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 1c65a6dfb9fa..68b7be2762ea 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1908,7 +1908,11 @@ int vmbus_device_register(struct hv_device
> *child_device_obj)
>=20
>  	child_device_obj->device.dma_parms =3D &child_device_obj->dma_parms;
>  	child_device_obj->device.dma_mask =3D &child_device_obj->dma_mask;
> -	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
> +	ret =3D dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
> +	if (ret) {
> +		put_device(&child_device_obj->device);

I don't think the put_device() call is correct here.  The underlying kobj i=
n
child_device_obj->device is not initialized until device_register() calls
device_initialize().  It's after device_initialize() is called that put_dev=
ice()
must be used.

That said, I don't see that the memory for the child_device_obj gets
freed if we just do "return ret", though maybe I'm missing it.  And there's
the matter of the memory allocated by dev_set_name().   Getting this
error path fully correct may be rather awkward. :-(

Michael

> +		return ret;
> +	}
>=20
>  	/*
>  	 * Register with the LDM. This will kick off the driver/device
> --
> 2.25.1

