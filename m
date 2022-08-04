Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C387589F96
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Aug 2022 18:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbiHDQ5F (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Aug 2022 12:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiHDQ5E (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Aug 2022 12:57:04 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020020.outbound.protection.outlook.com [52.101.61.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD691D31C;
        Thu,  4 Aug 2022 09:57:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfAp2OX11a33ooWnwVkr+Qshd+rE3e8mFcM1uwnhAE3EInjTcNc/ueTtTHLT6sT7TMyaGNfdZoeyefuznPws6mZR+uNLrjzBSLBLLe1Q/sPcFJbwdX2orDtpBm77vPZbrrmf0iCy9S7STN4RFIsZIo+oOdX3YEfDgdg9182cMjxoMVrXEcuZUvzPwhJa12j6LTi59gfhrMfkotYtefXon0M43e0EvEsGTe6L/qIo/OThmSs4qGkQLLOuCqbVZYBRAhoEVqu/ZCEE7NC6ELQ9jcDkCcLNwg3ah6TIGbZ5R4/RtzHDL5Ms/aHTI984uWw7A08COFVDw0L+lcjwWiVCZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fgeSQtEyjd8M5ROiyaDQWBRhU8RPytIGwut89CPcag=;
 b=OugAvYlBF5WKu/hxxc/kuLSYi0jitj1hozu+ADAN7vCiuzA3tsx3rZqJYkCn4Rik5xnyd5nCGGTxGEi20rqIVVYI8iBPjNQlK9emyzWzLPQP5vbyuiWXrYH0dedlX48SiM9EtQ074TvStmAkuwnQIdsSNHcsZ8V8JSo8XkH7h3PWfDOcYEMWjU6WapAY9nPppzp+Izpwf/xbgE1qdJp0JYBw+bARcz7S7xWJ31+dly4FFXoFzoOHoohjqGe0CjtOmg7tHDy6EDAsw45JV8Z9dVHsp/L2kxoBk3b0tiG/8SQGrT8GwbvPP6C1QkdIEGmmH4j2VRXxzHXYvSvMaUdhfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fgeSQtEyjd8M5ROiyaDQWBRhU8RPytIGwut89CPcag=;
 b=Mju5mbPB33yGQiLLf3uaFiPeeYvfhuJ2MeqeTRhhocqthwV8R/A6kUj6LCoSUVEexZDYGP0FZxePhgF8v3WEA5pyUeMUid556z00WeZOmjL4YvwKWlA9LTJ4FD7V7Wfi8PTaT56qP3e/r1G/JAE70NaEUjUkIQv05p+nlDYVBvU=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by LV2PR21MB3158.namprd21.prod.outlook.com (2603:10b6:408:174::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 16:56:57 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::29af:3ad1:b654:63b8]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::29af:3ad1:b654:63b8%6]) with mapi id 15.20.5525.005; Thu, 4 Aug 2022
 16:56:57 +0000
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
Subject: RE: [PATCH v2] scsi: storvsc: Remove WQ_MEM_RECLAIM from
 storvsc_error_wq
Thread-Topic: [PATCH v2] scsi: storvsc: Remove WQ_MEM_RECLAIM from
 storvsc_error_wq
Thread-Index: AQHYqBqlPfN3cSbliEK7XzLFKc/zIa2e9bEw
Date:   Thu, 4 Aug 2022 16:56:57 +0000
Message-ID: <PH0PR21MB30256870A5E6DED4BEE30C04D79F9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1659628534-17539-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1659628534-17539-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=89c5634b-76cd-4100-bfc8-d233021ab35e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-08-04T16:55:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d66c14ac-34f5-4917-cee8-08da763a5785
x-ms-traffictypediagnostic: LV2PR21MB3158:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dSq/60x8XGdNIZNHFlDSfTKqdwo/XR+6ypf+QmNJf2Wtw2KXbLRR+yTe7aL8v/taCtGxNvtYW0RCSqDsJGpad/980zaoz5qZSR+j6TQH1YPteusfK9wqJqG8DJ7THW5Jk2rZIxpDgoxmTqUHNrZRr39Bkr6duAD5heZ92TGYDG5hZfefMd5zCbSmEP9PFlG+AHuM4q3yo+7rCf+1YAXGLNwnjLqsYyafg+9OzvUtTJ436CWRtV261NHWfnxwC9uiZg9XhA0q26vCw5/D4BfQbPRXJyINooWgrb+6NXiT6l/yA893EQlIumxj0HPdfE2IZ44nQn1j3GXvEfzK6qsO+4DPe6By/EhIkVteyBMVhpIKBlQ9vtfnQVHj1qQf1SKMqd7SfF18xcMKemvmYyFhYIOxagJJYclpBlbe4kHveLO7Zj4JWTnZHJpq7yurah++hyrqLmCCh9TjhDyso6n4Yb2/9GTcfshh/z3NW6rsUoFNuq7uAGdOMA35tL+cyyLGoNjy78wdt/xN1jjBPqkJSxxB4IkZTn7BFupXnMnmey6s2Ao2btTVg4CFleC17r5HtCWM8+mzTxMtj2tuIRlHus/+R/ph+/K/oCj4O0GzAN16J4gGXK/BQbnu30200V8+BIEaBYQdMFhol7SlJaUhDUbXrGkx3yPLt9GAAIl9NXouUxkMEp8wEbZXnx5OzXOM7Xo9+TV/gwJRmrOWX8yfn7U+NGFANUIDrDNeXNmzn7k4mO/rHch1OwibU5ixkUksovXmMkFtp3WTQpDVxFLGzpROMO3Qx2UMYqepS8YpmmUwry0VFgEkqSnqOAlQRPbJDmD1yOk2rZ9ruBsWsYBJ17oCvoMLa1mn/I7vXPuV7TwGyq17M1FFoxYfbL0FTacf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199009)(122000001)(478600001)(2906002)(38070700005)(83380400001)(921005)(82950400001)(55016003)(41300700001)(8676002)(76116006)(66556008)(8990500004)(66946007)(82960400001)(71200400001)(186003)(64756008)(66446008)(66476007)(7696005)(6506007)(26005)(10290500003)(33656002)(5660300002)(86362001)(38100700002)(52536014)(9686003)(6636002)(110136005)(8936002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wm/vyjCphr22fYsSzd+mFetM0FwPL5W1f1GXqb5HpxORkTswSLlnSefN9w3T?=
 =?us-ascii?Q?aJRlOEjzgOvvVgvah3RrKUjM0sB/8jXCWUBhWyaFLcbGJqPSI6A9QhaE4vPB?=
 =?us-ascii?Q?8CNuc+4+qmU5uGmsEL4rrukggAmS4CSBh9zm8Dze5qwwB8RXR+yFl3VIsTyG?=
 =?us-ascii?Q?Sdyk+GMl5gcL9hek4QkKPhFzw4R42C4mrMbXjiLyN4H+/FDrhXHEwmWSJYd+?=
 =?us-ascii?Q?n7VAqMxP9OZOTh82+vzo9TIZid5ulVm9JOlkrht0YLVjzb5Lss1rUn20sZoV?=
 =?us-ascii?Q?mWwXHvC4uOHg5P8nQ4GPvBaewXwpsj7htGIRi3Ydl9CUZnF0BLCRvB1yhYT6?=
 =?us-ascii?Q?OMpWKHHG6kUsyUu9xKlv+EMBol7cb3DLfrTvxFDtuHnFETY07x3zGNQlzfjq?=
 =?us-ascii?Q?p0zMU5Ny4jELknwi85jQDbIe49RwUZ4FS95x9Kwz1pwAdC9h0Gpz3XKCGEdd?=
 =?us-ascii?Q?XPKx9pfQJjLsEXG17g5LKYkq/FvbGEtiRtbnS2Lni8y/pJ3UZ5Xyke5fbt+j?=
 =?us-ascii?Q?Z5qmLAI83TYVPtQfiHzo/W/fuG4DzYsPsOxStIOxCjcQXD/UXDMvh9AifOs3?=
 =?us-ascii?Q?S5jwSxQXduj4kzsbEujOh3yi3XMybVP4Cx5uNhWwdNwaV2oOnV2UtKqWKQwf?=
 =?us-ascii?Q?6Emi9eQhvO1QBzHdjbdkVAsmUSoYAuTwxWsXb8qSnwmFeH6Yr4Tdci8BGq8j?=
 =?us-ascii?Q?sEPbhOB4HK2w3hFrCnvQ5IUO6q6R9Sq5M8r3WpAYnTTvjnxRF66s5IMXUfvX?=
 =?us-ascii?Q?tOzTdCxXQ0Ew61lf1VdKZms7maJSdmYjYTOXb1M/+PE3QcoHcrTVgZi3pwD5?=
 =?us-ascii?Q?Ye8y6P/4mUVLSevcOp8Jj5yvdy/OJyJELC+68++vCU6JwyfM7rSZNA9DtAre?=
 =?us-ascii?Q?A396sASaCmnqkik8sjAjw1eznmE03yUGQ6M5RYsKdrLTxJ22Dq6UJMksHBu8?=
 =?us-ascii?Q?iZ8sZx/3vhkgUPCVw3dxx1lbcdUFu57AaOuUVonGeEjj44Rw49DChLt4/sKU?=
 =?us-ascii?Q?w75tOK93zDA4ENcHcyES7uzYzJ49x3mdXlFPbb9u9sMkzDno0/6EApU1ZX6U?=
 =?us-ascii?Q?L20WOVzbsXYZbutoSUZ7rzADHikd/1VvkJYVN0JoIuqVIAdWhSCXM4ZIPyij?=
 =?us-ascii?Q?K1y0rVl6AWCjilKccQ9cnH12IiUUt+AlxEdCGjiwZKcLQiqxEr51j74cckR/?=
 =?us-ascii?Q?IbHmpogf1+Jxx9/Y/QLYLpG6R3rXSc2PautRXrQrsm3+hmetQGaEgiFZWeJ7?=
 =?us-ascii?Q?88CNQlplfQRLHYvN7maro/kMrThma9FoF5HIKpUZkOKKq/UBXS201a1B9enR?=
 =?us-ascii?Q?QxQ9CzDp6L9g+SLgQDLAbJRmbgw7ZYt3x10MX+wxksSwLD+ynJme8JUxz78a?=
 =?us-ascii?Q?X1nqc6kaPnkDgCF3aogHwRrKSHw0iGF8+mzHvwkRPkvH0VBGup++Glfhr5tr?=
 =?us-ascii?Q?fvjuE7LZCtBD1dtKZR2CY8gAZvIx+92zcLyFu9Ynsut5+K6v9O7UvRpsBekM?=
 =?us-ascii?Q?o2VBTLCypySneSNhlIvK/6acU+obZ/zjaxY2hHgfmhtSQq2ZFLUQCTRBJLWu?=
 =?us-ascii?Q?VxCxlPAZ5e6Wn6sRblGM8PQ8lxghZAQnvbRdDHoOP3CXdj2aiuY2DoW5fNgl?=
 =?us-ascii?Q?8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3158
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Thursday, August 4=
, 2022 8:56 AM
>=20
> storvsc_error_wq workqueue should not be marked as WQ_MEM_RECLAIM
> as it doesn't need to make forward progress under memory pressure.
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
> Fixes: 436ad9413353 ("scsi: storvsc: Allow only one remove lun work item =
to be issued per lun")
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> [v2]
>   - s/it's/it/
>   - Added Fixes commit
>=20
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

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

