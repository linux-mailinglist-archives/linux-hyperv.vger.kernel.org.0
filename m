Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BF4589DE4
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Aug 2022 16:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239837AbiHDOwF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Aug 2022 10:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbiHDOwE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Aug 2022 10:52:04 -0400
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.56.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DEB2A253;
        Thu,  4 Aug 2022 07:52:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zq2JWailuv3Ia+A7vpefhy2SrxCUuFBjLT1IRuLAxy6Eqou0DJCsihroPX4+U75YRfqQUlMbSfm5j/Byrwc3e392XwbeXu3KO5haQkF1axNVl52RCTJD18QtEeXYQhwoj9d7qtRaCFBmvllWNd8AvKHqv//r9KkML0vFvkge0pFYlynHy4XZCOXoJj6YWyUegBLu1M4nYIL5Mmxsr6VG75cyej7RQgC6eXNMv9m7yQYy9hb3bDMFYLVGosO/FLqblhgYMwLPCl/ZK/Mf3p2biQ0L+DRAYfYbp1Kb+9sEO6vWIqfBKP7e4pGLFQ0+EgF0YRrFkWMAg2ljLuOtadyoGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07n5JxT8vxSTRjtD8fVRsvcWg6Hp6qsZpwoyCPbbmSI=;
 b=mZnkf9Z9nhJ1g2B2KAYIiCzamR2/lchUYhZR66isnbuUz2EDvjr3SwpJv5geNnIkFqJJKeh9Nnr+siw8L6fMQ9qxy5iT5EzArxy+0pzv/5zFmGOV3vGwdtUKdjT93jw8fYkyqqq54cIDAp5VQdzPXLs7LUaVKTTWOVPlv3i69Zkde77+PVdk0mnOGPZ6nwZ8tPuwLIx4PiEXUTIv/YHOUDVs8dlwIe/l5fbe/MNysw74CISaY/T91uba5S4dXOJSGEg2PLvr5NHu8wYt1rCBmXoBGjIOaiFBHLuXqSVBEkT96SwF1xYS8n82wyY+LPR3DpVJJacZuE+vZE35CahtDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07n5JxT8vxSTRjtD8fVRsvcWg6Hp6qsZpwoyCPbbmSI=;
 b=UZ3/1hDqDfVPLTl9nklzK8dJNfKmFqQUA1aEqFYh+6UJzBSZ+0pOVmCdbVTefNYWD/s98zZgSMpWocxkD88C2s6w72LJPUZ8K71hTii936kxF9/g3k4DRRVUPAI0qtfH5FzOmlkPUok7sDMIcSvECO6c3wp/P51Bch0mVGGEmPY=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by PH7PR21MB3356.namprd21.prod.outlook.com (2603:10b6:510:1dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.12; Thu, 4 Aug
 2022 14:52:00 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::29af:3ad1:b654:63b8]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::29af:3ad1:b654:63b8%6]) with mapi id 15.20.5525.005; Thu, 4 Aug 2022
 14:52:00 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH] scsi: storvsc: Remove WQ_MEM_RECLAIM from
 storvsc_error_wq
Thread-Topic: [PATCH] scsi: storvsc: Remove WQ_MEM_RECLAIM from
 storvsc_error_wq
Thread-Index: AQHYpYCi7mFrpB9jL0m3yqafwIHdQa2e1quQ
Date:   Thu, 4 Aug 2022 14:52:00 +0000
Message-ID: <PH0PR21MB302574B34EA43A39ED45AF0AD79F9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1659342483-4857-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1659342483-4857-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=00edeadd-38b4-4353-aa6d-b4e2c96f3f7d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-08-04T14:45:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58dec0e9-0fbb-4f67-621d-08da7628e323
x-ms-traffictypediagnostic: PH7PR21MB3356:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EMkEVvd+Qx6SDYXKYQCzgnDRfdVxSZbIPZ0fNxt8fej6zFjTlDUohL8YxVU/UTizlpfQAJC2dp3g5ccL7hKnr6ICA6R91oKiCIpa8WFx+roO4JTA7FX5DAo0CTkBpG68SX+e+iJjIhioFWTNC3XnpZMD0hLFVcx4hlEjRmZ2XgQgxb70babMv86tkABSSFJHS55htTZMHNvYpT9B92rtk+pvJ7X0EYCthpWbmYFyplRLHJp9B/vq53HWuDoP/YvRxGB0ngovavh9iqOMuf2xY8La9YzkAbEY/xLz6s59PzY4Gf9/62m5/GzNKOAz3/k/lumeHUaNjniqTuryp9Mp1mAZW/XyLHam5qeZkFb4M0/J6/7CPjLCigqYHJqw2O8kB/LIRns0LoRjC07jEQY4CBCSjuZW9v1Jb+nmotdq8fcbi+jPY+Eh8v7BhdF/indD4diHreiG3GokVZJr/LMN2kaE+dunP8ewH6nKEUCJIQzxIb0WDg1CPhtbARx/CxzlMgaI1iTqYr5jyCmQ46Tdff9+88dCTVxFZm8Dl+nkQS2jTjuvNwLXCLt5stNZRC0X595+qKUBlgKG9lZpRIb5VYFz9rkeJkkDgnvU9joEFb7gIUZEfLOTbnwwOYXHNGw1f+KCEbnT1eJUFGZZcu8mgqmCxwwn47saVfPp/jQJkJqfkuyOGOzXhJMmr+/JILvIDV6qCBEsKum38wli10lC0T6Il58Yh2JuX9rNQ3oGE6uSWGPpCwix8zLLrZRVrvd0gwJ2nfwp8MOnWKGzWzv//CSkZ7ys3JA0kF79/Sw/89ataF2aWuxR5W3NlQ2zIPsafDV4OOF2OMgaXVhmmB42PJdHYl1gIQPcDxVXbzb1VysihNPN7gvwS6lkgNYcaBeH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199009)(82960400001)(921005)(82950400001)(8990500004)(26005)(5660300002)(52536014)(86362001)(316002)(66446008)(71200400001)(64756008)(8676002)(9686003)(33656002)(66476007)(83380400001)(66556008)(41300700001)(76116006)(66946007)(55016003)(38100700002)(38070700005)(122000001)(186003)(10290500003)(2906002)(478600001)(6636002)(110136005)(8936002)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YbBKGzkL1wSI+YrnGDlQuDQj9Zl0GhYpK3RJMSW39KSK6G5S5DOKt5bi6C+W?=
 =?us-ascii?Q?azGIPtyzwPdprcRJUr8ZYaCVZn7JTyBvLMSIYyPsZy8E3orcFqxczsFqd+lq?=
 =?us-ascii?Q?HugCZYkYs5yj6lTdrhhhVjh9B4duw6JXeKD7Sze642OJApRnRFNR+Uk6yksr?=
 =?us-ascii?Q?gO46ub8CEjqYnr/08Q/K4IZScv5FWAofUR1aq4eqBQNw3ngIee4SWlGSteKL?=
 =?us-ascii?Q?XHVY/W5N6gXmM7NP3UEKBHZRTDco1ufl+OcGKKqJdreY8ZrnJOJVClwmT79V?=
 =?us-ascii?Q?4eqgVHpMZsw8xFiLqO0phb0KyoljSqJ6KZ4LfI4l/nOmCkF620kA4kX0ir7N?=
 =?us-ascii?Q?ea9Gyzu6umvS5YiHyE/Ogc1LbYZHlITzyPYIIQR4pRaInidza7wFQ9fQfzVx?=
 =?us-ascii?Q?9A7Ttmaf9/G3etADjrFXNuvWGwHxtFDe6VbIZr3n1x/JMeJas9WhlMOL2Heu?=
 =?us-ascii?Q?k4Jm0rurjdkILT7SgU1xGewwnv21SihRvxpTQl5S4GUDfqTEOLULnaveWJ9w?=
 =?us-ascii?Q?X5aMYBuMvZX4C/ZTnWSMqwpR0jXx+F1PsxbjsxH+D/F4HynD+QFzHw7VjSaX?=
 =?us-ascii?Q?8hrYFCixmb+oYpH2AYh/OEhE3uD1nasDPd/DYKBA7+rEGgtcXNkjlctsafUM?=
 =?us-ascii?Q?VEgLipDyaeyucm02Ba3mnPFN7TfjJgLO4ffWEhlkmg7/m7uPnTNm48I9RwEH?=
 =?us-ascii?Q?ev0kx/auUngz8Q1nII7G9Am6m7+M3qRjL2lgc6GxQjD8m5NoBhY5bOftyWb0?=
 =?us-ascii?Q?2qH3OyTEw2P/d+4k4FQgFWViSe9dM9yc094ZeL94liEr/jovH71gxt487rl+?=
 =?us-ascii?Q?61JseL1MeC9B73gNA0phJkBisDNaWZ/N7yuGSPNJR81s5lyhUtlcPcG9WM54?=
 =?us-ascii?Q?YYmGxS2/Y9lwcbA7qgmRGWvjBVLaVIfbwpYbxfhtjiXSEPVn0ZOQ8W13rX9/?=
 =?us-ascii?Q?D+UyYLkssLHkKoueXpXd4EotqMVCQutx1T4G3qwlfvVewqzhnV1JUlw2dK7X?=
 =?us-ascii?Q?Ju09RhELQtMtV/vfH6AjJzVZdCeRGhbRVObhbcMZ2wda5T9PfChseZwXOZ0h?=
 =?us-ascii?Q?d8CiPjlQKVuu/N5AZtSqaM/S6bCzo9xt/Dphllw8F0DOqW6geKAknref3Uuj?=
 =?us-ascii?Q?e0Ed7r0A79MxksiWOsDtJUfM4SwgP3wlc1LxbR1uJaWDUbWsm5VJwZvWsJDJ?=
 =?us-ascii?Q?ZgRxUrSKrxEAm6EbP3sghbF26DBlh8c8VuW45OHivAMXaUwM0X0uX6lc3Ka+?=
 =?us-ascii?Q?FaYk1+lgT62V8Pk0kwrSqjyFxsYixKeq++i7DgvthmIKAZeV90+QT4dPqTmm?=
 =?us-ascii?Q?izIpCgdalA+IkpyoinjKo6GzyTLy68tmq2bPEO9GXcMHYTl/qOVIcioYiUNV?=
 =?us-ascii?Q?wZ8NCsiOvMbuGXUy88oGvnW79tYlTXPheFYPsL3o7HBxyqBxH/ek+sSTkPdh?=
 =?us-ascii?Q?Clk52fIaSilLMgmj3qkd6LY6KphXJlZzt1+EiUuIisZ9zrkWDxaf1EW1/gH2?=
 =?us-ascii?Q?jgXEuBayO9cOPIOmaSM0tsbggj6VDUqVi0Yl7Sias60x3xtcaos+Uk+7GX+2?=
 =?us-ascii?Q?YZKlnuceFrU1LPrLPu3A6YdHz+e+ZXCChe8yOOXe2xrLG/pUF46rnZyIkQUP?=
 =?us-ascii?Q?PA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3356
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Monday, August 1, =
2022 1:28 AM
>=20
> storvsc_error_wq workqueue should not be marked as WQ_MEM_RECLAIM
> as it's doesn't need to make forward progress under memory pressure.

s/it's/it/

> Marking this workqueue as WQ_MEM_RECLAIM may cause deadlock while
> flushing a non-WQ_MEM_RECLAIM workqueue.
> In the current state it causes the following warning:
>=20
> [   14.506347] ------------[ cut here ]------------
> [   14.506354] workqueue: WQ_MEM_RECLAIM storvsc_error_wq_0:storvsc_remov=
e_lun is flushing !WQ_MEM_RECLAIM events_freezable_power_:disk_events_workf=
n
> [   14.506360] WARNING: CPU: 0 PID: 8 at <-snip->kernel/workqueue.c:2623 =
check_flush_dependency+0xb5/0x130
> [   14.506390] CPU: 0 PID: 8 Comm: kworker/u4:0 Not tainted 5.4.0-1086-az=
ure #91~18.04.1-Ubuntu
> [   14.506391] Hardware name: Microsoft Corporation Virtual Machine/Virtu=
al Machine, BIOS Hyper-V UEFI Release v4.1 05/09/2022
> [   14.506393] Workqueue: storvsc_error_wq_0 storvsc_remove_lun
> [   14.506395] RIP: 0010:check_flush_dependency+0xb5/0x130
> 		<-snip->
> [   14.506408] Call Trace:
> [   14.506412]  __flush_work+0xf1/0x1c0
> [   14.506414]  __cancel_work_timer+0x12f/0x1b0
> [   14.506417]  ? kernfs_put+0xf0/0x190
> [   14.506418]  cancel_delayed_work_sync+0x13/0x20
> [   14.506420]  disk_block_events+0x78/0x80
> [   14.506421]  del_gendisk+0x3d/0x2f0
> [   14.506423]  sr_remove+0x28/0x70
> [   14.506427]  device_release_driver_internal+0xef/0x1c0
> [   14.506428]  device_release_driver+0x12/0x20
> [   14.506429]  bus_remove_device+0xe1/0x150
> [   14.506431]  device_del+0x167/0x380
> [   14.506432]  __scsi_remove_device+0x11d/0x150
> [   14.506433]  scsi_remove_device+0x26/0x40
> [   14.506434]  storvsc_remove_lun+0x40/0x60
> [   14.506436]  process_one_work+0x209/0x400
> [   14.506437]  worker_thread+0x34/0x400
> [   14.506439]  kthread+0x121/0x140
> [   14.506440]  ? process_one_work+0x400/0x400
> [   14.506441]  ? kthread_park+0x90/0x90
> [   14.506443]  ret_from_fork+0x35/0x40
> [   14.506445] ---[ end trace 2d9633159fdc6ee7 ]---
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

This should have a "Fixes:" tag for commit 436ad9413353 where
this workqueue was introduced.

Michael

> ---
>  drivers/scsi/storvsc_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index fe000da..8ced292 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -2012,7 +2012,7 @@ static int storvsc_probe(struct hv_device *device,
>  	 */
>  	host_dev->handle_error_wq =3D
>  			alloc_ordered_workqueue("storvsc_error_wq_%d",
> -						WQ_MEM_RECLAIM,
> +						0,
>  						host->host_no);
>  	if (!host_dev->handle_error_wq) {
>  		ret =3D -ENOMEM;
> --
> 1.8.3.1

