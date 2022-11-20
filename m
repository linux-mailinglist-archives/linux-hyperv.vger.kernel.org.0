Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED3363129E
	for <lists+linux-hyperv@lfdr.de>; Sun, 20 Nov 2022 06:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiKTFuS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 20 Nov 2022 00:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKTFuR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 20 Nov 2022 00:50:17 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11022018.outbound.protection.outlook.com [52.101.63.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D130DA4167
        for <linux-hyperv@vger.kernel.org>; Sat, 19 Nov 2022 21:50:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dO7WvtlPDqbFqEWESpe+cshIp2bypP5L2Wh/d1EjgUxZAbjAmeytd0aWLCn+JuIf1ahtFm/S39Gv6SI39OZaRgwz/ZKGHgEO9inU1eglIj0wLjurUmVt5it9mlnLq7+hX+ScwobLyXkL0U6uLBnarjIyMFQbSNcnDwjNGoZRirjKh2Tr8jOnWl6J/O0/r/HIOrWpJ0u51RqaRnF7VbhoRcJtkhA4bJjJlBxdKcKEkDBycqnu7zynybT9rE00Sx7tU1Sv7hoT3A/U4GSvmHykJTMDZKrp/B/E3hgfSsNLSuiSCVTOa05YYRV0i7OHo3SLTEZYJS1GP8+QD7QQg6UNrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4WzOnmH0lbbgBXsDXwKgn+8qyl+RQvUCi1Rhc/7rZY=;
 b=IcX6knTDiybPZAwIO8AieoltRIqhLz6rlJZSQOACa2otkhNe747WgyiOUQ12k+A9E66CriK3xmTBlXqSN5aPtFJb2AUUMwpxEJSqqD/5s1meZgU7WGTEjy0Wl7W88LlpgE67+tW1q2uEHc3WOKYoa4H1EnXf/R80VOXaxOaJmNaE4LEj+webB2mu2OVXzu61qLINLpCkyQi5XrMudN940tEps5IX6SxYWedFJdtoGz+ETRmHkIBmAk15090LnnpJ3K1D80RFLmISv2JeL6cW3Qno+7MwSiYKo1oDQ8is792ZXugq8Pjuu3TRxTz1WtYdI7qmuDizbDLuzMq/bd+szA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4WzOnmH0lbbgBXsDXwKgn+8qyl+RQvUCi1Rhc/7rZY=;
 b=bS16Hyi+EHjw9KzKK0K+wIPgSTHiQVRKqrJx3xzM8a9na5nSRD/RY9DU202jK9TpeKnitZXehG2LLV1KsMQ/1Z6cs1mXVCiKg15A8zqUHQ+tx5cXXL+LKw1K/XqepyrveE34I2uAHMtmSnc3xFAKtUHa1F47EAPB4/QBNSc6gkQ=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by LV2PR21MB3060.namprd21.prod.outlook.com (2603:10b6:408:17f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.0; Sun, 20 Nov
 2022 05:50:12 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%4]) with mapi id 15.20.5880.000; Sun, 20 Nov 2022
 05:50:12 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v3 1/2] Drivers: hv: vmbus: fix double free in the error
 path of vmbus_add_channel_work()
Thread-Topic: [PATCH v3 1/2] Drivers: hv: vmbus: fix double free in the error
 path of vmbus_add_channel_work()
Thread-Index: AQHY++7OsagpHwqbGU6m8bwEhTG+Zq5HT8jA
Date:   Sun, 20 Nov 2022 05:50:11 +0000
Message-ID: <BYAPR21MB1688DDD59E95258D3AF963A2D70B9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221119081135.1564691-1-yangyingliang@huawei.com>
 <20221119081135.1564691-2-yangyingliang@huawei.com>
In-Reply-To: <20221119081135.1564691-2-yangyingliang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c637a071-ae2a-4ea6-8edd-3b11a56d5d73;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-20T05:49:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|LV2PR21MB3060:EE_
x-ms-office365-filtering-correlation-id: 4c0722d3-518f-4987-33ea-08dacabb1709
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RWscqpSk/P3twzEOmDRsM1ODjRgoEaEMSr9wEG3Xpfn8M6sa6Sh+613aKJsdQj3zciegm6zpkJeKk7eQnU7gl0fx9CEXZM8L6n/HUkQ75PPY1EhtDhyZ8P+Myr+hEUMM2ytOuCLmjWkFoxQDCg7Fp8Hq3q+DMeptGT6If2QRe5ewSIOcqIQ3q6CcU3BT0/TrvZngTdVjfCqYtUMrMwDKYqlmQERBtK9eu9tNVehOKzDhcQ7qwJvFJpONADJbgh59yUL9XX7AFQSXOWFV/FVlp10z/v8pBGqXpK2lVBhoH8G2VfPSuvSkcfPFyseGgLDobJJ+MyCPaqEhGvPUMwfNj6y1CUlD7Wgw27g5SQOljZWmXMKrdoZuvdPSCIu/x0ifsbeXkhNrkubDCEcI3BHGlQF0+3KYQ5/aenbTQOXsyMAdeDwXGigg5eXXKzGBNGIKDLgthmHXCi/MUYWFIhit0DfVxWPYh6NBA7j74NOy32w8OzRi5pibihbX0T0htXN5QNGgwDDeUpHZPFHJ+E63qHHPIqkQ12XYcTmopRIlmIYfVuXhLFQeIPZGZeBpyadpCuza4tiFTnOm8+LgNTr5xo0Uf+ZBckBdqxfojHPl46/Oac/zjlU9EW0xvX0ARuf0/3sWxT78PhdE6+WirlPk+MRYd1t3IJ/UAiLP225/YxLm5v/WRCeHsQsnttLEUhMjfSwTct1xPV/c2atSY8oOvHj2t05hF4LTu5+hI+hq7gY2tmZBAe469XCmy7VQpfFU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199015)(55016003)(110136005)(54906003)(316002)(2906002)(83380400001)(186003)(52536014)(5660300002)(8936002)(26005)(9686003)(76116006)(66946007)(66476007)(66446008)(64756008)(8676002)(66556008)(41300700001)(4326008)(8990500004)(33656002)(38070700005)(66899015)(478600001)(86362001)(82960400001)(82950400001)(122000001)(38100700002)(107886003)(7696005)(6506007)(10290500003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S8V0+KYc0FWXGx4gyZ1R99KqH70bplEmTrZ/xlWTxW9ssxJCKf6Um3tIYQph?=
 =?us-ascii?Q?KqGiaSWssgaEdhGw4uSyV0M4KJkZeSQtNGe9idUPUADV8bu2X7LDTrcQdz0I?=
 =?us-ascii?Q?06tVt+wQzNOADc0wbiuHcdQTaiFHkcm0omPGfeU15jWT1P8Qq7RcZhbSauy+?=
 =?us-ascii?Q?PX0DFK+id0MzfkH8bo/yOPwLjdRkX9Q26dpznjn2rrllO+KvvIZTUxkd6Ymq?=
 =?us-ascii?Q?kv+VAsgVVkSRCnvZi8ftC6rlNobm1N4kgpMmg6F6BaSJRkQAI2of3KP5oioo?=
 =?us-ascii?Q?/DfopDvlLWfl3pwl7/s9xY86q+5Emml48GaoqInyT3i9LzRaqr/ZBGIR6cTS?=
 =?us-ascii?Q?/IaG4P5xYA6A3bc7btCbOO9c/UunalEt6O3qbJ5mn59OBGkMT0vzbMVTIZxR?=
 =?us-ascii?Q?sCqqzOh73atWQAMz9Yi77GydkIADlNdRUKuYsHS4gL8OXCfFdYXP5yCV7HAF?=
 =?us-ascii?Q?CZAheiktVltp2o8awUio9bcsFlitImQ/gCEbhBo9cdh53JKSja+uC+mpnQKR?=
 =?us-ascii?Q?Dv0GEDb1FvSKi60aUNQpZC6jxL3LquzdtEQNrr3oDV+YzgCWbdM3UlK8ti9+?=
 =?us-ascii?Q?k61IaEzZEdNHnWy4+1ClTC3JzCpkwDxL0WDu6libawY1pGAWIQl2Zqr93kJc?=
 =?us-ascii?Q?CBSOqtGXV8giP7Ym1PW32pTh9RBmtgjUyn5dqwtKZGQjbLLDntTsXktF+Z/w?=
 =?us-ascii?Q?4lfe/JMQxha6P0I0shlTVl00dHO9iMIGXRkk9iXKKTWSbTHsx8jow7x4U3oC?=
 =?us-ascii?Q?wGCjNUdNKMmQ9kXaVy2rRocT40RaLA8EGk607TAALT5guKyo5IWkv5xjy6zW?=
 =?us-ascii?Q?ISC0K+idfSW/vElpNsiM6dVpUpkDvLRcqnmCffh1nJhrbF+aiEyoM3RGVKdv?=
 =?us-ascii?Q?RFWzkqRiveduz31BW2OkPHgPhu0lSw/XUp3yJ9+F9PzoPD6XctFzp9Q3cy3k?=
 =?us-ascii?Q?JLF3hMZaYnMXFN8kJQ3+l8p04hCIaOrouVmdyrhB3j7frotgSHKGuNz/G/Cl?=
 =?us-ascii?Q?kLZNVstieNFlN/5HmtJ7iFRA8NBo1Vxzc3bd9x9khzxLhnNfK0peDa+I5A1k?=
 =?us-ascii?Q?etrSU/oAKc75N5lYPrDn0EfUqAqZJG2f4/yyZH+kts2di1NZEdZ8Or8GKY+/?=
 =?us-ascii?Q?53LGeS/rSwLnJ/6ZFAuqmuyMHYXsjxKGhvtC0tiUZn2GhIkpx3AqvvyyGFKr?=
 =?us-ascii?Q?psqxDhoQrArBkmy/u2LgP1eeihSV2Ev67JpYETiIW4SGMa3PuU+YLbFSP4Xk?=
 =?us-ascii?Q?pSYMEOQNxQJ5rRAJO7qkURj3nIT2JpIV+KxfmynMMiKAqJvH5lKPwdqZtU9V?=
 =?us-ascii?Q?lZxbaAjFzVPhJwQsHndN+CtnwWZCwTo2SOLJepxhrusocwIaPuM4gya2PnRe?=
 =?us-ascii?Q?7wPmXDXnZDVYkk83jjGqjIhs73oXxNHb/4ByIeMs6bt2jvWywDxnbR8oXsy4?=
 =?us-ascii?Q?1GmFl90FCzuoPFHLjnyZ/u2lYiXShUd/wotgOBZ6TFRG/k6iooUhM8Z2+chb?=
 =?us-ascii?Q?p9Zy20o0layOoDtmoPdqiS+rFEwUYW0Q/6q6LKOywaKwfgrJQRQdzL3WXvbL?=
 =?us-ascii?Q?UAymB9dQZcZ2PtcdDUfTdyaR8Js6qLmnHbf4fZ9LVFb6VeOy8JJb/K12/rY3?=
 =?us-ascii?Q?2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0722d3-518f-4987-33ea-08dacabb1709
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2022 05:50:12.0208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 420/GBSru6LuMiBiN+z2qoF/aBOKng2o1eqtXI9e/K98ZSghOq7gwirtlPM6H1X6iiWRZ0ZX50hvnDSYXiiRsbRItwLU+PVZmaTdbDTbNUo=
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

From: Yang Yingliang <yangyingliang@huawei.com>
>=20
> In the error path of vmbus_device_register(), device_unregister()
> is called, which calls vmbus_device_release().  The latter frees
> the struct hv_device that was passed in to vmbus_device_register().
> So remove the kfree() in vmbus_add_channel_work() to avoid a double
> free.
>=20
> Fixes: c2e5df616e1a ("vmbus: add per-channel sysfs info")
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/hv/channel_mgmt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 5b120402d405..0ebd73d571bc 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -533,13 +533,16 @@ static void vmbus_add_channel_work(struct work_stru=
ct *work)
>  	 * Add the new device to the bus. This will kick off device-driver
>  	 * binding which eventually invokes the device driver's AddDevice()
>  	 * method.
> +	 * If vmbus_device_register() fails, the 'device_obj' is freed in
> +	 * vmbus_device_release() as called by device_unregister() in the
> +	 * error path of vmbus_device_register(). In the outside error
> +	 * path, there's no need to free it.
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

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

