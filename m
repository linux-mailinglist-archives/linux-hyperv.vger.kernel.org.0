Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2F262FBF2
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Nov 2022 18:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbiKRRry (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 18 Nov 2022 12:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbiKRRrx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Nov 2022 12:47:53 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11021027.outbound.protection.outlook.com [52.101.52.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477275CD2F
        for <linux-hyperv@vger.kernel.org>; Fri, 18 Nov 2022 09:47:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yk3VKpA96FWGpHo7egP2qQQCZ7GUsjDvT+mfcy1dx8kWNOn67D6TkPLWRgsvPeeIY/2gHPhm0j4FboZBlgkznKAB9OubwUmuM2Pwa8U36iky+CabMI9DpeT2jOhwPwbsAcC0rIbvLmfbx+7LHLHL7LtNjkNbkdqqVUaQE1Y2P07h3FaDkUILBhLk4KFmF5j99UzvEXKOhdc3cS+CRHSrUes4Ohj5fVMnT+RU/D09lmgIABx/Lbo2p5U3yYaJ079f/hjc74dXPRXKyhtAYBN6aXM70HR1teTtps3bdrfvGOfrB9mL/4VK3po4N0RzFqlVDL1OmTxFcDtp8BFIFjIC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlM5osKuqu3eRGGex/xb8fjjVAZ5xRxo2LSLKLOduQw=;
 b=A4QETahdYYJ1Jr8sV332/fID5WTf0UdY1DbEpV9Dq5hgFrJlW2Ff+8QpbySDrN/0c802TgsbxxugC71ASKmOhaHdZRcaGnK1kmHKerLa5n5q//Kq4UcX0CGczU5nDTWPc1VfZi9NPPk4kjzpGaluYPIbiuXhrpcTO6JlTUhRrf3pjYtRe2WptEEw/DzJ76LTSpeccg36v8Zh8jlDuC76mAt2tI5aXKbILboekpKdVFfuc7lp4jb9kxaFq+ZDn1n5LCzt8Em96jNFzZt7uM25TEvdLsZApD6uHhe+OZZ8uGqdgUxVj/KgFM48a9B0Uxwa43BR76ZOq7sGgFRAkUuUjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlM5osKuqu3eRGGex/xb8fjjVAZ5xRxo2LSLKLOduQw=;
 b=iE8QzswH636ag74S9rC2bX0qQQGhVhlGw1h/zkkRk5+WhgmTZAds4qrUK6l4yBGUkItYteKyAuz1m60CQtzhZ1mHRthP8LWXLY0lN3h7vKD63JUB5mz214TLzYXWmApFhBG+9F5HlHQoRgFP8vMNvAUqraULStoVGdGCwSPc6Kg=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SN6PR2101MB1342.namprd21.prod.outlook.com (2603:10b6:805:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.8; Fri, 18 Nov
 2022 17:47:49 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%4]) with mapi id 15.20.5857.008; Fri, 18 Nov 2022
 17:47:49 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v2 1/2] Drivers: hv: vmbus: fix double free in the error
 path of vmbus_add_channel_work()
Thread-Topic: [PATCH v2 1/2] Drivers: hv: vmbus: fix double free in the error
 path of vmbus_add_channel_work()
Thread-Index: AQHY9W/4rf4A+4yDsk2/1t8qjjVOda5E/gag
Date:   Fri, 18 Nov 2022 17:47:49 +0000
Message-ID: <BYAPR21MB1688E806143522E48E1F6027D7099@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221111014847.673576-1-yangyingliang@huawei.com>
 <20221111014847.673576-2-yangyingliang@huawei.com>
In-Reply-To: <20221111014847.673576-2-yangyingliang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=987fa8c1-ef70-4bb8-a5e1-655f27fb705f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-18T17:37:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SN6PR2101MB1342:EE_
x-ms-office365-filtering-correlation-id: 5453cf45-948c-4c19-977e-08dac98d0283
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iZ0XkIlmD0KCC1qLuUo103cS4Pn5ry28aYV+jzJgxCT1egXT1Oi1XbFsfKS9j1S4QO7HXfbtO4Lobw77rctAh7giZErogCPldB/qav1tMHjw97snO00kpBZ2Wl9ycCBgr5BiwNeKT1DFXMoDSzQY/VVbraX9TLBJqM8JJk9mkE2WEAFkDSFNZZgabrIznlCR0fqfulkSLJm0rXkNNel2iaK7PQSZMoQFiDqmdIZJmnAHWShyTCvxWBx309M7aI5ivQ7TN9STtrHGI8CX4FP4gx+afBzdDuiRiCfrwc0Ej+n6GHYVmJIrP4ZP6akJxdqqG9zRvWSFK/pic7r6kI8DbXaEVD632ucoDHXoinVeLH+PQXPxryAHKfm/wy1I2oOvFUmmx3TIFTVTW5TX2Yc7jDL5MVC97/bPpikFiuJLngTGO5tJsK2sHgDoUTb4Va2N8IbGvBPfceb45K7e6isjXmmYrjARqFuxMb76+xKKqA795KnxewCF8K05IhZxN2K+B2HfnlpwyzUvE37wIB7baVszKU0xtIazI0UzqSIOB/N06ghZsM4m/jzp2+MyWzxEm1ToJS+2dVKUBmn++GkU7HtmiuVf0reCGLj2Ip/w3TNZ1EUfuzbnZkZPsmzi9GHHGXnWgMaAGjy4TMG1KCa/bN6rjWzMcGreg2z5TKQKDPmtdHeIhFkavj9r25EUcob7OmLGIcoFQ4TIb1zCZMDmDWwm38qgyDL6MgDe3zDg7FVK1CpAmOqVfoxNez0a0xZ7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199015)(66899015)(478600001)(71200400001)(38070700005)(110136005)(10290500003)(7696005)(54906003)(6506007)(107886003)(82950400001)(26005)(33656002)(86362001)(316002)(2906002)(66556008)(122000001)(64756008)(66946007)(66476007)(4326008)(76116006)(38100700002)(8676002)(66446008)(41300700001)(5660300002)(52536014)(82960400001)(55016003)(8990500004)(186003)(9686003)(83380400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DFQ3yirMzhxIQj/0n19+zDCHUmB4qcWHZU8FVPxYOVe+t7HFRjzPZs1vbViW?=
 =?us-ascii?Q?LulAF5/drdBhPW7FIiuZjy2TQLdnNKMTj8wckPQgO5eTilZ9TJkZbZg4nQMd?=
 =?us-ascii?Q?AKktTDEcCTgTxJ/pOPTxqUqQd8P9dXJIlZwufaVoVo7tJjpOp1uuYoZakp5D?=
 =?us-ascii?Q?Lk2w49VJudBNh/cog5Lg2czdIcI6pjd9F+Rtr13iDLQaHki1aAxeEp9UVTi9?=
 =?us-ascii?Q?tMYX41PvHv5HhvLao8Iqw5c1qprD5VAbOvHI/Rfsg6DkLkXYrZdUJR43KXIS?=
 =?us-ascii?Q?MK5L7+U0AbuQBw4+pfA1bQKMd/pNgcDMEkAcPxhrsmVPLymFqTpgjijZzmL5?=
 =?us-ascii?Q?VY0itjgxmmtcNWc6PyYPG+jGwLr20VmiBN161qcBMcS+dmRFQnrl990KyuHl?=
 =?us-ascii?Q?Wr6jji2OPHOmbnS+D+oZVihlerNA5AKixe2PYaxwa1j4T20uhSOUJ5b3i829?=
 =?us-ascii?Q?2MDpBV94TTTlhsKx+Gf83Zxo9iLbixXhv33pbrveXlI4UxrGX85EkmebdfCU?=
 =?us-ascii?Q?hsCOuXaxCkA4dPW2XGPJGCw8krqzxFjMGmZVggVjk5Lt0EpgJSraT2Vn/J/Q?=
 =?us-ascii?Q?bOuOFnMH3KjZqqAWB88K1CSyOY8hgxojRaqjALxRglcHBYwkd7iYdiarvHac?=
 =?us-ascii?Q?2RWSCYn3nqEtGL1Of70qijp500a8H2tznf9ZtUGSpOEN6W4BA+qHpGM6z5jv?=
 =?us-ascii?Q?eqdSUzIMBuXr0SG44Xee2TBK863ynSTEP66bsQiCjbC67CVDAWu45fLRAJCN?=
 =?us-ascii?Q?B1gR0/NsukFCOwUVSgsAEVt+HjRiup8qlW9T8YJDjYu3yeYnD4lUErLe2Ugd?=
 =?us-ascii?Q?LZjiuFm3k0QQoKZ2H+opkCOdRwY/jNskmCsJFYWt3daWSQgN2Vw17w8SyzMt?=
 =?us-ascii?Q?bH2aOTKdzowk/LPwhJyQpW0SjAHjIaqgW48C8HbPzFvHHhy9UjwRkLa3alhn?=
 =?us-ascii?Q?NafAC7d4t1DbKs1vzyRlvjEUBJLtgH8Pwrt0Q5hYEEjCI2ebaJ4uU+JbYE00?=
 =?us-ascii?Q?SIuFoHMGoWDNFzWHG8yCUBMDUohgUPduXxKDk9E1ose4BXv+QbthztO5GdvJ?=
 =?us-ascii?Q?HXRGEsXjLP1e/ZmqemWCYGfGono4ptf7e8jHAnL6EC438E3JleC5cAMZwOb6?=
 =?us-ascii?Q?UOpwFeIw19aptRsZk+kbyfBSh8a2x9TWTWl56MTVLF30KZ7JuwtW9P3rl8DU?=
 =?us-ascii?Q?t+iUhDI87of7sC44JFjVYOdSeF0LWnfM5QA+mXGRjdXDDmifKrAv7EbM1PP7?=
 =?us-ascii?Q?mFiv8nEdC2U6EEZze0HLEfkuAdNsz8JZNrmsPecr3349s/SOBKMvvYaArGhU?=
 =?us-ascii?Q?/AikB6wFuqwSxVj5Qi7j5SqKgr8qWVp+uc230gGnPvFZnLxntfQhdVXfyfR1?=
 =?us-ascii?Q?/pKq8jDge0wBneMOgfRtlUOKPbat2SVw+cBea9PAvJIOVGvx/V9RqvZe+SGT?=
 =?us-ascii?Q?B4sVKUitsPBxn3UDC6BVUIEXWEf3dCjLQMHeCZ62oP2rPd6+ZYS/FHoCaj6x?=
 =?us-ascii?Q?BLTdeDlGMzjwPkjsAyXk96Bst7tQ0/xSvVA4RiebGbjW1BTZgEwLQ2meYzV/?=
 =?us-ascii?Q?Ymy5CoZESGcX0acaPSUALW2eLjRAuOR/65/PfCjosI+wMNn/DDx+PF0AjeRy?=
 =?us-ascii?Q?eQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5453cf45-948c-4c19-977e-08dac98d0283
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 17:47:49.5784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2CLfvqeblO04NZQGj+2UMv1DPsA8hzAaJBs8oewJ7Z4F51o/klIbIXv9LnUnjiKRINOMnEyczwkq9QCWe0+Pk4MLpB/JotSA/NkEyv7kpjQ=
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
> In the error path of vmbus_device_register(), device_unregister() is
> called, hv_device has already been freed in vmbus_device_release(),
> remove the kfree() in vmbus_add_channel_work() to avoid double free.

Let me suggest some clearer wording in the commit message:

In the error path of vmbus_device_register(), device_unregister() is
called, which calls vmbus_device_release().  The latter frees the
struct hv_device that was passed in to vmbus_device_register().
So remove the kfree() in vmbus_add_channel_work() to avoid a
double free.

>=20
> Fixes: c2e5df616e1a ("vmbus: add per-channel sysfs info")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/hv/channel_mgmt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 5b120402d405..576ebaf729a8 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -533,13 +533,15 @@ static void vmbus_add_channel_work(struct work_stru=
ct
> *work)
>  	 * Add the new device to the bus. This will kick off device-driver
>  	 * binding which eventually invokes the device driver's AddDevice()
>  	 * method.
> +	 * If vmbus_device_register() fails, the 'device_obj' will be freed
> +	 * in vmbus_device_release() in vmbus_device_register(). In the outside
> +	 * error path, it's no need to free it.

Let me suggest clarifying the comment as well:

* If vmbus_device_register() fails, the 'device_obj' is freed in
* vmbus_device_release() as called by device_unregister() in the
* error path of vmbus_device_register().  In the outside error
* path, there's no need to free it.

>  	 */
>  	ret =3D vmbus_device_register(newchannel->device_obj);
>=20
>  	if (ret !=3D 0) {
>  		pr_err("unable to add child device object (relid %d)\n",
>  			newchannel->offermsg.child_relid);
> -		kfree(newchannel->device_obj);
>  		goto err_deq_chan;
>  	}
>=20
> --
> 2.25.1

