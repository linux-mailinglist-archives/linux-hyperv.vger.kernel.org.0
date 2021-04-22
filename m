Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B824D367BB9
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Apr 2021 10:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhDVIHP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Apr 2021 04:07:15 -0400
Received: from mail-bn8nam12on2137.outbound.protection.outlook.com ([40.107.237.137]:43489
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229655AbhDVIHN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Apr 2021 04:07:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfBaJsiyKvMqFpG6MWk7zUUZoA5lIKl61qBdeWaoofUsmEW4E/uYnty7lHkM29930mMuKP5WAJ7OtEam1oRIZMC3AzLfTWZDLZ9kw5BRNSKyQrERN3wgBizz5D5Gl/9kDtyAGT2kGEOSt4OM4wtw8z20wRXZKUSxeoC38xo04xy3CXA8dStij2Bt253ao/VrbAE9P1G+yvCGqCI4tOUSr+35yzen15jsounJ2mpqFpj2JW2l85LSkxZE3eKOTDUjYvxFtqkpfhf4WmdaUypU+K7BjLoXfuEN/OuuTiw2c4ch/5OndwLfO5M1YyvgA9LgRAUC+oUKjX7UZp0v2XJDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKJm+7pvOWvkJb2JRERegvT9h/fAU2O5VcTGblZhU6s=;
 b=g9O2U6kzsZ9/yFlt1Qx/0/sYKcsQ5Yp6Vw+jBW2BwCqBkkECJts9uF9VqnlwdMPhKMTqp1W7h107BUcAPA2YX0su9oDs/pISQS4NQtJZSmUB6i2fr9M6v1IL0hvpd4T2mXMv+2PITjry5xHjUrJQo3VZGwE2Pl/ahSb0dnQr85DwgwAk9ej5OZSia/59zSFWSsFzNL1ceAfyxWLjc5Vd3YH878exR2t127Bf5L1jneX4rgW8zRZ3E7jAhgcA72YIjcXUZUuilsMbz5CTTPFW0pPmMl0qk1Tf0g3fU5VtyA6pm6LmBLC8vAfaJXm2QzxxPQLT2MWNlJ4Q7OGuMJ3a0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKJm+7pvOWvkJb2JRERegvT9h/fAU2O5VcTGblZhU6s=;
 b=gMN0xEW8CkCieSDb9RXDQh6XkXv3/rTmnySvkMCBQxOAuxN75DWI35phWFy1lGJOb2bqCNDkeNwFmerozk7X4Avzp5vVMXY4iJr/qWLT8lzI5s9bEUPnbDhQzIWYrW71ohV6Rt+mjaZwx42IBlkW+ihvYBFNZLyEYiBEO7kw+ZM=
Received: from MW2PR2101MB0892.namprd21.prod.outlook.com
 (2603:10b6:302:10::24) by MWHPR2101MB0812.namprd21.prod.outlook.com
 (2603:10b6:301:7c::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.4; Thu, 22 Apr
 2021 08:06:36 +0000
Received: from MW2PR2101MB0892.namprd21.prod.outlook.com
 ([fe80::5548:cbd8:43cd:aa3d]) by MW2PR2101MB0892.namprd21.prod.outlook.com
 ([fe80::5548:cbd8:43cd:aa3d%6]) with mapi id 15.20.4065.008; Thu, 22 Apr 2021
 08:06:36 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [bug report] net: mana: Add a driver for Microsoft Azure Network
 Adapter (MANA)
Thread-Topic: [bug report] net: mana: Add a driver for Microsoft Azure Network
 Adapter (MANA)
Thread-Index: AQHXNpYRVr1fgwher0qVI6N1Jpmc/qrALsKg
Date:   Thu, 22 Apr 2021 08:06:36 +0000
Message-ID: <MW2PR2101MB089292B02804E3521B31219EBF469@MW2PR2101MB0892.namprd21.prod.outlook.com>
References: <YH/5OQSEbCBvH9ju@mwanda>
In-Reply-To: <YH/5OQSEbCBvH9ju@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=328653a3-0740-456f-aa51-e8dec3578be2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-22T08:03:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:8b00:6b90:688b:1c6e:a2b1:f6c7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae34e400-8abf-4761-5392-08d905658d36
x-ms-traffictypediagnostic: MWHPR2101MB0812:
x-microsoft-antispam-prvs: <MWHPR2101MB0812716E24F93E27F37C70F9BF469@MWHPR2101MB0812.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P5EgpmDzKbau/3RLAbiUhLrn3nFLHOZ5A3aXRSwUTcE5i1/476w0Bq3XSPvjwJs5eze689fDYbxqyxJ4TYWwkuwRpYGOU7dgx1cDFHzJNqdM0oy+JbY2wgO2s9hfFdmOmBu4mYI1H6rICZR9R5lnJ4jh6o35zvxlMKE94Dp2Uyl2vtFUcGJH7fgHyNxdvFLfU14MZV42GjIKDfQmxKSVV6zuuMpMTTVj9mfqIrbLDpZGc//sxlISmERPtTdycR1N3yPACxtgNC/BM4Ts065c2swa8FHlrCqs5W1XD5+j4ISjLdG7Dg8PRvdAaJxtOA14pilfZ5dDQ6gWO9Bzy5RAS61aAJr5aThKIhQ7G2ZQs2q/GGnUFaqpfdEhVa3XOaU+fWqLPYel9lVO2qoBn8JyHHRn23nJQjN8n7ARLxkf+fnL4quB8r0feq0Pf+DjQ/Zs9bA0+zKydyrR1ZB8jDPPoXqXGVTTGfINtHBMJxtF5MM1RIazZyEqnNuCed5w88QrJCMbwonUlMG5XDoEhT88RrT2brP4LizrvO6YWmMaFOR8vAsBGQhs2r9CNh3NpdKOLiDmUqXPoHDPgVQhUhFoN2v/xtUuqjYY34rdIAFCLS4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB0892.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(47530400004)(8936002)(66556008)(6916009)(66446008)(122000001)(71200400001)(4326008)(55016002)(66476007)(2906002)(52536014)(86362001)(64756008)(8676002)(8990500004)(66946007)(38100700002)(76116006)(316002)(82950400001)(7696005)(10290500003)(9686003)(83380400001)(82960400001)(186003)(478600001)(6506007)(53546011)(5660300002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?y5AVjxWm8iU/k3ScCcKXrKd2eMi+OTx/o+txMqcSMpiWD/USrtFnKjULm1Wr?=
 =?us-ascii?Q?nkdUtftR/zhYdhEhdkP6lbHJp3dRTDeS/8zO+VS8JMtcgzMxpePh+KRwqFMn?=
 =?us-ascii?Q?+zC5vmimZdPCrdaLlP1aE15O/xg9igZQV54NOugJebk5RHwozISjNtjjJ1gC?=
 =?us-ascii?Q?vgSIMut5/+EcOdS/bZA85JMx/k3pKRjDTtQbBj2RP9DaGK23GCaT5OYb2l58?=
 =?us-ascii?Q?zZWqD9b9UFP6Z/5/g2l1AgKQwDJsY1OnxL/saflro83YYOFpH10BCGYVHPqf?=
 =?us-ascii?Q?3Bq86nMIOYs4RsoGxqLHMFTxUjjC3eoU6Iflr4SSChii4l+Y3XfkG+Nd3ZFx?=
 =?us-ascii?Q?j6+Wn0crryRaZD+Kn0+2henaNEv19j2bSXYCNUbLs7GP6a+PLSWj5OJtFSLC?=
 =?us-ascii?Q?gE9E3Vq5zLFGsOFOfS1ODtJu9Oy1S/y+bJBud7QxIl5ZYPBEu6h+nD9I4MkT?=
 =?us-ascii?Q?8gh+wWaBrCHtEFipo0TfcwSl9q+G51P9Cswpp/YyBIoCNCJht2xMx33v8/cU?=
 =?us-ascii?Q?v3w1RipuESvy1WzdHD4Hx0RfUjo9xrW4PLCeW2fRw2RugMXB4CvH4qQGyBuY?=
 =?us-ascii?Q?mY898nokAwbewo/cq/3Ga7wxqq4GLN8uflISO7mseagl2PqEV4+fIO9nE4LR?=
 =?us-ascii?Q?dG14CywHg8nz/+/7fKqpSfSTF4W9qpFiS+vIQmADe+kbjkxKb6jo8XjhSjqw?=
 =?us-ascii?Q?YH3ohGUsNJYUypd0l7pWRvWh/7GAFclgiEedmH58G+OvnCvAJX+TYbEh+Vzz?=
 =?us-ascii?Q?MlLROY+ZvP77p7t1jCfv5a4/sqX4bXg62BTZKw17uXBY98GMrLXK04iafGxN?=
 =?us-ascii?Q?IG/uD+G2nZowVPgq9u/Ieoohy2Nmd36e4s5A9JBtGCtNfM/ZWJ10KjgUyjli?=
 =?us-ascii?Q?K2vWoeQO12uyyBuVFGeoGFscGrleeDl6XDNQg1MKLHxZwpk5IZSTAkaQwewp?=
 =?us-ascii?Q?E2/JRk5P2UyA0Muhd4JZUk36jATDa/E6t0GqaemRNARCEUe3GwUBcyGu/UMp?=
 =?us-ascii?Q?fAZvTQG8Z4sEWQbXxs7jETv9TFq9TfMmGnDkBVo9BDiPKktEJJ4+sUCsMxEg?=
 =?us-ascii?Q?1fQJITZzXyOM37b3o9D96kox53UZuOB7xSUHpLtAQ16lF4R1W7lTrHC5mIYp?=
 =?us-ascii?Q?Ra5nAwaW+499TnP9PO79RczcqOwj/1zUAM1MwPKpqysvG23NeL8BO0RQup3O?=
 =?us-ascii?Q?T5l20XvNs+vhX8cBwR+Ag9jydSlStI8ZEvNDeSzI5HtNWTT9O9j9wAEo1N/e?=
 =?us-ascii?Q?7LPZRib8dpIWkafHc36OO4S7Kh3/cbSeubjGflOtf2pXN4XpEtvu06kfOYAP?=
 =?us-ascii?Q?PouT1doa0afzBwEIN4LEfu89hY6TKGw3iaiqXb+RdtDhOcZdu6HNFq3xDlEo?=
 =?us-ascii?Q?QbuwFYdzdBCT3Nu6ft3p+p2IO/Vs?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB0892.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae34e400-8abf-4761-5392-08d905658d36
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 08:06:36.7849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v1bKYjs5YDlSj4Pt/qSim6nAzASlF5fvQ3/5tZLqdqvqYp6Oj1ekOxKBgrSWRmPW6FpNeUX/JUKJSAmc8ORx1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0812
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Wednesday, April 21, 2021 3:07 AM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> Subject: [bug report] net: mana: Add a driver for Microsoft Azure Network
> Adapter (MANA)
>=20
> Hello Dexuan Cui,
>=20
> The patch ca9c54d2d6a5: "net: mana: Add a driver for Microsoft Azure
> Network Adapter (MANA)" from Apr 16, 2021, leads to the following
> static checker warning:
>=20
> 	drivers/net/ethernet/microsoft/mana/hw_channel.c:292
> mana_hwc_comp_event()
> 	warn: 'comp_read' unsigned <=3D 0
>=20
> drivers/net/ethernet/microsoft/mana/hw_channel.c
>    281  static void mana_hwc_comp_event(void *ctx, struct gdma_queue
> *q_self)
>    282  {
>    283          struct hwc_rx_oob comp_data =3D {};
>    284          struct gdma_comp *completions;
>    285          struct hwc_cq *hwc_cq =3D ctx;
>    286          u32 comp_read, i;
>                 ^^^^^^^^^^^^^^^^^
> These should be int.  I think GCC is encouraging everyone to use u32 but
> the u32 type is really a terrible default type to use.  It causes a lot
> of bugs.  This is my second or third signedness bug to deal with today.
>=20
> Normally int is the best type to use.  In the kernel we're mostly using
> small numbers where int is fine.  In filesystems etc then we're dealing
> with huge numbers so u64 is the right type.  But it's a very narrow band
> between 2 and 4 million where u32 is appropriate.
>=20
>    287
>    288          WARN_ON_ONCE(hwc_cq->gdma_cq !=3D q_self);
>    289
>    290          completions =3D hwc_cq->comp_buf;
>    291          comp_read =3D mana_gd_poll_cq(q_self, completions,
> hwc_cq->queue_depth);
>=20
> mana_gd_poll_cq() returns int.  It returns -1 on error.
>=20
>    292          WARN_ON_ONCE(comp_read <=3D 0 || comp_read >
> hwc_cq->queue_depth);
>=20
> comp_read can't be less than zero because it's unsigned but the warning
> for "comp_read > hwc_cq->queue_depth" will trigger.
>=20
>    293
>    294          for (i =3D 0; i < comp_read; ++i) {
>                             ^^^^^^^^^^^^^
> If "comp_read" was declared as an int then this loop would be a harmless
> no-op but because it's UINT_MAX on error then this will crash the system.
>=20
>    295                  comp_data =3D *(struct hwc_rx_oob
> *)completions[i].cqe_data;
>    296
>    297                  if (completions[i].is_sq)
>    298
> hwc_cq->tx_event_handler(hwc_cq->tx_event_ctx,
>    299
> completions[i].wq_num,
>    300
> &comp_data);
>    301                  else
>    302
> hwc_cq->rx_event_handler(hwc_cq->rx_event_ctx,
>    303
> completions[i].wq_num,
>    304
> &comp_data);
>    305          }
>    306
>    307          mana_gd_arm_cq(q_self);
>    308  }
>=20
> regards,
> dan carpenter

Hi Dan,
Thanks for reporting the bug! I'll learn how to use a static tool to avoid
this kind of bugs in future. :-)

I'll post the below patch with your Reported-by:

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net=
/ethernet/microsoft/mana/hw_channel.c
index 462bc577692a..70bdb9e13fb2 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -283,7 +283,7 @@ static void mana_hwc_comp_event(void *ctx, struct gdma_=
queue *q_self)
        struct hwc_rx_oob comp_data =3D {};
        struct gdma_comp *completions;
        struct hwc_cq *hwc_cq =3D ctx;
-       u32 comp_read, i;
+       int comp_read, i;

        WARN_ON_ONCE(hwc_cq->gdma_cq !=3D q_self);

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/et=
hernet/microsoft/mana/mana_en.c
index a744ca0b6c19..04d067243457 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1061,7 +1061,7 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq,=
 struct mana_cq *cq,
 static void mana_poll_rx_cq(struct mana_cq *cq)
 {
        struct gdma_comp *comp =3D cq->gdma_comp_buf;
-       u32 comp_read, i;
+       int comp_read, i;

        comp_read =3D mana_gd_poll_cq(cq->gdma_cq, comp, CQE_P

Thanks,
-- Dexuan
