Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37A165E36E
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Jan 2023 04:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjAED1N (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 Jan 2023 22:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjAED1L (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 Jan 2023 22:27:11 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11022022.outbound.protection.outlook.com [52.101.63.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC662F793;
        Wed,  4 Jan 2023 19:27:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+eNdVpf9fd0sLnCNxUAkRluWM1hwq4likmbEYgK0VbzeIfbA/gl32TfuooR65jy9WWRJ1vnjyXYxztZ/yfGR9kbjpIGmEw4TIQF/bfsnzgB1/WyiO2geabf+BbS3b4sPmzf/YoA43pvaoJWXXtKvBw9dDm3/I4TBu8gMer2aNJ75lnRvth8zN8K8fO6wLwkurt2EXkXi4Sx96LCmNP+p81Ubgxb9AzMt73mMGABRywj8ECdydIJXmmNd+UNrvwlTdmQ9KTp9UxBx19pouZTlHmHm3+sHtn+pitggaEPco2leura9JlRR4Kw0rlwKSuvt8FYwjTEIoonwLCkp33hbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xMVEj35jMI0D+HZmFdkF+S6qK2ck41kyb3M9i/VRuM=;
 b=gCTRC0YSGyDySyBqfcdpxXaMI4svUF+lI576qrcz1fKPc79RhftUQACw3gTbvV2MwZSMe5t9sDBxPuhIWnVh48RiC8E5BvewzotrfebjCRSCfHV12MHEIvcWMFDPm4GNA1HrU2oyd1RYGHxUMTpEMUvUImsdEnANtCxlzogp4k6hC2NbgAb2LequA+exrMNl14z4cWSK0VOTPQEMlrVIZHbvmSzEwCHi54HKsEOMf25+GvH/JzUb/D/1HKAylIRrYhCvGMi4949gKqO0/QQMZXJ7d5dQmGXu/ynykxnkGOKPqGlTuf31tcZYcrfuMqP2Z1K4K563UUFqByv6tNszzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xMVEj35jMI0D+HZmFdkF+S6qK2ck41kyb3M9i/VRuM=;
 b=D3E4bVhBJakfkwinAhT3Id68UdJQ8DHrCLWYrsR3gBtYJ9gdZdQ8Fyl3blqExmBTBMA2MCybtbaY9tyAsCwYLlL217a5+timATw8PVXjPN1wTD46rmWiYPZv8sQHN8g1zntvBNLqumfq2CvmVOUzHdmtNPsv04UBvOXO8edM6Vo=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SA1PR21MB1319.namprd21.prod.outlook.com (2603:10b6:806:1f2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.4; Thu, 5 Jan
 2023 03:27:07 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::db1a:4e71:c688:b7b1]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::db1a:4e71:c688:b7b1%4]) with mapi id 15.20.6002.005; Thu, 5 Jan 2023
 03:27:07 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dawei Li <set_pte_at@outlook.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] hyperv: Make remove callback of hyperv driver void
 returned
Thread-Topic: [PATCH v2] hyperv: Make remove callback of hyperv driver void
 returned
Thread-Index: AQHZHme3WYFa66k0DkuVM/zbEjEOuq6PKa+Q
Date:   Thu, 5 Jan 2023 03:27:07 +0000
Message-ID: <BYAPR21MB1688F058773F0D0746E1E3FED7FA9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <TYCP286MB2323ABFF6E0E47B7E07C95EDCAF79@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYCP286MB2323ABFF6E0E47B7E07C95EDCAF79@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f98684d5-61d5-47ac-8161-f69685ca464c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-05T03:10:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SA1PR21MB1319:EE_
x-ms-office365-filtering-correlation-id: f86f68f6-4901-49ad-ea12-08daeeccb915
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mo/8HoO4Fu1B0W+SVKD931W69lpPhc5aXhqGlyg52JdjzeJBl+6vUg8+z6pETOwoxcmm8y/aQCaVl3vwG4fBB7lrGOHu9pSh5S844eru0UKs9DSdz5/s8YsrdTqY+LkUQRiHfsc+Tdl+fpz7RNNvWYsKedRZcUBBgOyIjKmgZRyq9T3iKvOy5dLerRz5kyFU0smuZ18VAmzaVNR2GPeqLd7eoF2nsw20glPZw1cTnS+J+hIG4u+1GO2FtBloGI8bKjgO91UM/CUXIC37PInao9bL1yaya7cNjXS+bG6BBrqG60/6+WY5VV/S7HSgw6J0FmZrOgj0tAJ7+PoaMAZRGj+jqLDPKqbj78EZH/vItY2tb2mVajJ3mhYD/uMJ1FTYPioWnMZsZGlh/oH1DqbSmqLWKvVYXdth9pgV8taHjXr5s94qqNgDZpXZSlKJlSN5W7EVZ4umy57bqYeS9F6NrL6khEKt0gbNKf4wfnRkObvnJ/4lVjZOY1Wtv55a8BaoojmqzbPflX/A6bW/XSCi296bjS7FzyLVKXrfE8UdC1PQql5Jci6/pyz/25CXKkRLq5ktGC3uYtJ6y0CoCV7urhvlIESMy0MVEkOZnbM1b8uGtUuZ167D9x4kuSlcMM2G0nKQWrBmjqTCQADvEJXSauGsL8XOWVK7JA4oddbkzu5Z/M/VyEcCCNfsNt/SR6W/o5yTJTErZK+YlJKq2QGyPdA4TxSShamBuYoBwqF9GV050o/qi/roi1EvXCrrRgXxTTyewPLj6GLlCqB8DaDIBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199015)(55016003)(33656002)(41300700001)(186003)(66476007)(76116006)(4326008)(8676002)(30864003)(66946007)(66446008)(966005)(66556008)(64756008)(83380400001)(5660300002)(52536014)(26005)(478600001)(71200400001)(8936002)(7696005)(54906003)(6506007)(316002)(110136005)(9686003)(10290500003)(86362001)(6636002)(82960400001)(38070700005)(2906002)(38100700002)(122000001)(8990500004)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ud7jS6BUleQf/L9KtjrjqGNMSTiJa4+y6hfGQqdm241bC0AnKlHfE84lf7Ue?=
 =?us-ascii?Q?mfuNtWFEjurAo7QZtuH2e64zx+1AWrHUC+FDelWCDONhM8wNngR2w3Sdwnvc?=
 =?us-ascii?Q?YxdN3tMwq3b08iG9cDPyVYGrmBrWbTDWzt6XOBLptIrUxAfsjCoCBoex6vvG?=
 =?us-ascii?Q?8DKZCIt2Q4wdF6ZwxIgppHvydecz/PZArXienj08MS+hpHR9tX69gEkO+mhP?=
 =?us-ascii?Q?fqiXUrNpgzK23ifH7GKLL+J4x1iYgiqsg+Up93w/VpOPNN64jYmxbmvDfvdz?=
 =?us-ascii?Q?adQl8W989s5O2AQRK5+y5CDVxlCPKgKIT4f2pm6mfvkMHeWUe8JSXXkateHQ?=
 =?us-ascii?Q?xv8CpRC+/GYab8x6YzBiJyLp81dwkK9cF/CsjJmhZqDCof8bJHtZ08x8ME8z?=
 =?us-ascii?Q?KXW+MFba++zcW274rWh0xMlkW2IRvhKKRnAdQ/Y5fLq8eCcRm/tXarhvNhZu?=
 =?us-ascii?Q?/r7SVpBl9rYdupILkSGxKcw+klzbTT7zIHOpq0NdQip9ujH232ixjEec/QNa?=
 =?us-ascii?Q?X5PgtssbtoslWE3fPnehP8xGtA2a0qudjOyzvNv3HVWuJ/vplx3KtjbIzhDz?=
 =?us-ascii?Q?QzPDZ5nvcxUqC9s7ISA303mEwjmJSneDLWB/iGNO+e0mTVyPyLQT/KVqpXPw?=
 =?us-ascii?Q?vSvIAgaZ9kLb7IR9GFYqfP/HrfbDw3dGGVDHyDzWEvSntwm2ihUZyB9w/YCW?=
 =?us-ascii?Q?KsZ+7AMxYBKaT4gQ9T/s0jie9QUHI0S1TirmSrj65lnkC8MbSNeZJxdelofZ?=
 =?us-ascii?Q?8tbNeKtRb7fxR1iRVzousdlzw0SKma5DSzrJGjnNKCb9p9TkX0p/BQrY71aN?=
 =?us-ascii?Q?x1omTkyBz9369Ypz+9XIpHS9IkiDJl56f+UpIrjegYfxq7pgJ9Rp18mWP4fF?=
 =?us-ascii?Q?x0Ai8wN+qkKpdNglk6l2mLArtWaPmKqyLVkv//d5H5Nuq1wN/xOlodWj9hqT?=
 =?us-ascii?Q?puoZ+MG7LmwtlKHLvUZwlqZJoalQdc6kyFLuxBKTWO9uHof5HYIrtj1pFgYN?=
 =?us-ascii?Q?KkbHapLiCLJ8InNasVnry2AXVXn66zYlYU9kUZ9Q8aWd79tm2moJTPo4pn8f?=
 =?us-ascii?Q?+3kHIW6dJdjlJDTU20WazA3bwGrF0yyCLLMLGRcSC4BNNFuEDTHs7tMRBPSE?=
 =?us-ascii?Q?X6632N3KV3ZdFJQ7GzNEBAWPyW6VyFg01J3ocH4IO/O+3Rvq/OEHSWJsDNQH?=
 =?us-ascii?Q?fFtPf7EYi5i1Eh7RKhOIDoAsKygX7cSayuy1h/NEUDYuMD+Pb9rjWgCAKstD?=
 =?us-ascii?Q?NN3otUhnZtj/K0zpBFOnSSsV2DC2U7l+tfBFHrgoUBXMZhBzIgVxsAnhN06z?=
 =?us-ascii?Q?C5MPdYVbiDFk96Lo8O62k0vOOKAAptMNfmOnzFtoGvUTtZwYZkcrQ+q7IZP2?=
 =?us-ascii?Q?Ht+t09CLDVq/tFbg9WUGiVj6Arps04Pa6L5H9pXElwiNW/drhObzMEBMUtks?=
 =?us-ascii?Q?rfy5uIgjsZGD+JQAXvRjX7EE3EYaVEZP9KK8g1JTPt3Ny+eWZePa4VRzfPJF?=
 =?us-ascii?Q?2McbAzLOYJASVena98CmC5Dts6i+HtnM/9Vz+FHtesft56gVzb7abo+CrseY?=
 =?us-ascii?Q?JzY/zksNztQBP38N4su7fg/1UAubtcy3c+4JjY7igrvVgpLlvzYSyJzrodUC?=
 =?us-ascii?Q?YQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86f68f6-4901-49ad-ea12-08daeeccb915
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 03:27:07.1837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CIIcCnD5KgwqyMISVWNJdk7kIhDQBHiumSxBPjMvWX4WO/5n2fgpXmc6f9HFc9+RSoVViML5xzQHjAEcj5DPP1NfZPxaTp5OztqzaySCeus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB1319
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dawei Li <set_pte_at@outlook.com> Sent: Sunday, January 1, 2023 9:04 =
PM
>=20

Historically, patches for the VMBus drivers in the drivers/hv directory
have a subject prefix of "Drivers: hv:", not "hyperv".  These changes touch
VMBus drivers that are scattered in other source tree directories as well,
but let's still use the "Drivers: hv:" prefix as the best historical preced=
ent.

> Since commit fc7a6209d571 ("bus: Make remove callback return void") force=
s
> bus_type::remove be void-returned, it doesn't make much sense for any bus
> based driver implementing remove callbalk to return non-void to its calle=
r.
>=20
> This change is for hyperv bus based drivers.

VMBus is the name of the bus, so let's reference that instead of just
Hyper-V.  Note the spelling and capitalization of "Hyper-V" and "VMBus".
We're trying to be more consistent going forward. :-)  And following
documented guidance to avoid language like "this patch" or "this
change" in a commit message, I'd suggest this wording:

As such, change the remove function for Hyper-V VMBus based drivers to
return void.

>=20
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
> v1 -> v2
> - Fixed null dereference issue and deprecated comments, based on comments
>   by Liu Wei.
> - Fixed building issue.
> - Rebased on latest hyperv-next.
>=20
> v1
> - https://lore.kernel.org/all/TYCP286MB232373567792ED1AC5E0849FCA189@TYCP=
286MB2323.JPNP286.PROD.OUTLOOK.COM/
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 4 +---
>  drivers/hid/hid-hyperv.c                | 4 +---
>  drivers/hv/hv_balloon.c                 | 5 +----
>  drivers/hv/hv_util.c                    | 4 +---
>  drivers/input/serio/hyperv-keyboard.c   | 4 +---
>  drivers/net/hyperv/netvsc_drv.c         | 5 ++---
>  drivers/pci/controller/pci-hyperv.c     | 8 ++------
>  drivers/scsi/storvsc_drv.c              | 4 +---
>  drivers/uio/uio_hv_generic.c            | 5 ++---
>  drivers/video/fbdev/hyperv_fb.c         | 5 +----
>  include/linux/hyperv.h                  | 2 +-
>  net/vmw_vsock/hyperv_transport.c        | 4 +---
>  12 files changed, 15 insertions(+), 39 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> index ca127ff797f7..d117fff26d99 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> @@ -165,7 +165,7 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
>  	return ret;
>  }
>=20
> -static int hyperv_vmbus_remove(struct hv_device *hdev)
> +static void hyperv_vmbus_remove(struct hv_device *hdev)
>  {
>  	struct drm_device *dev =3D hv_get_drvdata(hdev);
>  	struct hyperv_drm_device *hv =3D to_hv(dev);
> @@ -176,8 +176,6 @@ static int hyperv_vmbus_remove(struct hv_device *hdev=
)
>  	hv_set_drvdata(hdev, NULL);
>=20
>  	vmbus_free_mmio(hv->mem->start, hv->fb_size);
> -
> -	return 0;
>  }
>=20
>  static int hyperv_vmbus_suspend(struct hv_device *hdev)
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index ab57b49a44ed..ef16c2a54362 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -535,7 +535,7 @@ static int mousevsc_probe(struct hv_device *device,
>  }
>=20
>=20
> -static int mousevsc_remove(struct hv_device *dev)
> +static void mousevsc_remove(struct hv_device *dev)
>  {
>  	struct mousevsc_dev *input_dev =3D hv_get_drvdata(dev);
>=20
> @@ -544,8 +544,6 @@ static int mousevsc_remove(struct hv_device *dev)
>  	hid_hw_stop(input_dev->hid_device);
>  	hid_destroy_device(input_dev->hid_device);
>  	mousevsc_free_device(input_dev);
> -
> -	return 0;
>  }
>=20
>  static int mousevsc_suspend(struct hv_device *dev)
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index cbe43e2567a7..3eece5e5b0a1 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -2042,7 +2042,7 @@ static int balloon_probe(struct hv_device *dev,
>  	return ret;
>  }
>=20
> -static int balloon_remove(struct hv_device *dev)
> +static void balloon_remove(struct hv_device *dev)
>  {
>  	struct hv_dynmem_device *dm =3D hv_get_drvdata(dev);
>  	struct hv_hotadd_state *has, *tmp;
> @@ -2083,8 +2083,6 @@ static int balloon_remove(struct hv_device *dev)
>  		kfree(has);
>  	}
>  	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> -
> -	return 0;
>  }
>=20
>  static int balloon_suspend(struct hv_device *hv_dev)
> @@ -2164,7 +2162,6 @@ static  struct hv_driver balloon_drv =3D {
>=20
>  static int __init init_balloon_drv(void)
>  {
> -

Nit:  This is a gratuitous whitespace change.  By itself it doesn't
warrant re-spinning the patch, but if you respin to update the
Subject and commit message, it would be good to remove
this as well.

>  	return vmbus_driver_register(&balloon_drv);
>  }
>=20
> diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
> index 835e6039c186..24995ac41c86 100644
> --- a/drivers/hv/hv_util.c
> +++ b/drivers/hv/hv_util.c
> @@ -602,7 +602,7 @@ static int util_probe(struct hv_device *dev,
>  	return ret;
>  }
>=20
> -static int util_remove(struct hv_device *dev)
> +static void util_remove(struct hv_device *dev)
>  {
>  	struct hv_util_service *srv =3D hv_get_drvdata(dev);
>=20
> @@ -610,8 +610,6 @@ static int util_remove(struct hv_device *dev)
>  		srv->util_deinit();
>  	vmbus_close(dev->channel);
>  	kfree(srv->recv_buffer);
> -
> -	return 0;
>  }
>=20
>  /*
> diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/=
hyperv-
> keyboard.c
> index d62aefb2e245..31def6ce5157 100644
> --- a/drivers/input/serio/hyperv-keyboard.c
> +++ b/drivers/input/serio/hyperv-keyboard.c
> @@ -369,7 +369,7 @@ static int hv_kbd_probe(struct hv_device *hv_dev,
>  	return error;
>  }
>=20
> -static int hv_kbd_remove(struct hv_device *hv_dev)
> +static void hv_kbd_remove(struct hv_device *hv_dev)
>  {
>  	struct hv_kbd_dev *kbd_dev =3D hv_get_drvdata(hv_dev);
>=20
> @@ -378,8 +378,6 @@ static int hv_kbd_remove(struct hv_device *hv_dev)
>  	kfree(kbd_dev);
>=20
>  	hv_set_drvdata(hv_dev, NULL);
> -
> -	return 0;
>  }
>=20
>  static int hv_kbd_suspend(struct hv_device *hv_dev)
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_=
drv.c
> index 89eb4f179a3c..025f805e1ed9 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2594,7 +2594,7 @@ static int netvsc_probe(struct hv_device *dev,
>  	return ret;
>  }
>=20
> -static int netvsc_remove(struct hv_device *dev)
> +static void netvsc_remove(struct hv_device *dev)
>  {
>  	struct net_device_context *ndev_ctx;
>  	struct net_device *vf_netdev, *net;
> @@ -2603,7 +2603,7 @@ static int netvsc_remove(struct hv_device *dev)
>  	net =3D hv_get_drvdata(dev);
>  	if (net =3D=3D NULL) {
>  		dev_err(&dev->device, "No net device to remove\n");
> -		return 0;
> +		return;
>  	}
>=20
>  	ndev_ctx =3D netdev_priv(net);
> @@ -2637,7 +2637,6 @@ static int netvsc_remove(struct hv_device *dev)
>=20
>  	free_percpu(ndev_ctx->vf_stats);
>  	free_netdev(net);
> -	return 0;
>  }
>=20
>  static int netvsc_suspend(struct hv_device *dev)
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 583d3aad6908..e46d9a14053f 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3813,13 +3813,10 @@ static int hv_pci_bus_exit(struct hv_device *hdev=
, bool
> keep_devs)
>  /**
>   * hv_pci_remove() - Remove routine for this VMBus channel
>   * @hdev:	VMBus's tracking struct for this root PCI bus
> - *
> - * Return: 0 on success, -errno on failure
>   */
> -static int hv_pci_remove(struct hv_device *hdev)
> +static void hv_pci_remove(struct hv_device *hdev)
>  {
>  	struct hv_pcibus_device *hbus;
> -	int ret;
>=20
>  	hbus =3D hv_get_drvdata(hdev);
>  	if (hbus->state =3D=3D hv_pcibus_installed) {
> @@ -3842,7 +3839,7 @@ static int hv_pci_remove(struct hv_device *hdev)
>  		pci_unlock_rescan_remove();
>  	}
>=20
> -	ret =3D hv_pci_bus_exit(hdev, false);
> +	hv_pci_bus_exit(hdev, false);
>=20
>  	vmbus_close(hdev->channel);
>=20
> @@ -3855,7 +3852,6 @@ static int hv_pci_remove(struct hv_device *hdev)
>  	hv_put_dom_num(hbus->bridge->domain_nr);
>=20
>  	kfree(hbus);
> -	return ret;
>  }
>=20
>  static int hv_pci_suspend(struct hv_device *hdev)
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 3c5b7e4227b2..02f9d1a6f4ac 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -2092,7 +2092,7 @@ static int storvsc_change_queue_depth(struct scsi_d=
evice *sdev, int queue_depth)
>  	return scsi_change_queue_depth(sdev, queue_depth);
>  }
>=20
> -static int storvsc_remove(struct hv_device *dev)
> +static void storvsc_remove(struct hv_device *dev)
>  {
>  	struct storvsc_device *stor_device =3D hv_get_drvdata(dev);
>  	struct Scsi_Host *host =3D stor_device->host;
> @@ -2108,8 +2108,6 @@ static int storvsc_remove(struct hv_device *dev)
>  	scsi_remove_host(host);
>  	storvsc_dev_remove(dev);
>  	scsi_host_put(host);
> -
> -	return 0;
>  }
>=20
>  static int storvsc_suspend(struct hv_device *hv_dev)
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index c08a6cfd119f..20d9762331bd 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -355,20 +355,19 @@ hv_uio_probe(struct hv_device *dev,
>  	return ret;
>  }
>=20
> -static int
> +static void
>  hv_uio_remove(struct hv_device *dev)
>  {
>  	struct hv_uio_private_data *pdata =3D hv_get_drvdata(dev);
>=20
>  	if (!pdata)
> -		return 0;
> +		return;
>=20
>  	sysfs_remove_bin_file(&dev->channel->kobj, &ring_buffer_bin_attr);
>  	uio_unregister_device(&pdata->info);
>  	hv_uio_cleanup(dev, pdata);
>=20
>  	vmbus_free_ring(dev->channel);
> -	return 0;
>  }
>=20
>  static struct hv_driver hv_uio_drv =3D {
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv=
_fb.c
> index 3ce746a46179..cfa6a7c1eeb3 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -1240,8 +1240,7 @@ static int hvfb_probe(struct hv_device *hdev,
>  	return ret;
>  }
>=20
> -
> -static int hvfb_remove(struct hv_device *hdev)
> +static void hvfb_remove(struct hv_device *hdev)
>  {
>  	struct fb_info *info =3D hv_get_drvdata(hdev);
>  	struct hvfb_par *par =3D info->par;
> @@ -1262,8 +1261,6 @@ static int hvfb_remove(struct hv_device *hdev)
>=20
>  	hvfb_putmem(hdev, info);
>  	framebuffer_release(info);
> -
> -	return 0;
>  }
>=20
>  static int hvfb_suspend(struct hv_device *hdev)
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 85f7c5a63aa6..cd5cb9f6fae0 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1273,7 +1273,7 @@ struct hv_driver {
>  	} dynids;
>=20
>  	int (*probe)(struct hv_device *, const struct hv_vmbus_device_id *);
> -	int (*remove)(struct hv_device *);
> +	void (*remove)(struct hv_device *dev);
>  	void (*shutdown)(struct hv_device *);
>=20
>  	int (*suspend)(struct hv_device *);
> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_tran=
sport.c
> index 59c3e2697069..7cb1a9d2cdb4 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -879,13 +879,11 @@ static int hvs_probe(struct hv_device *hdev,
>  	return 0;
>  }
>=20
> -static int hvs_remove(struct hv_device *hdev)
> +static void hvs_remove(struct hv_device *hdev)
>  {
>  	struct vmbus_channel *chan =3D hdev->channel;
>=20
>  	vmbus_close(chan);
> -
> -	return 0;
>  }
>=20
>  /* hv_sock connections can not persist across hibernation, and all the h=
v_sock
> --
> 2.25.1

