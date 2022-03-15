Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA754DA05F
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Mar 2022 17:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbiCOQrv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Mar 2022 12:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236348AbiCOQru (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Mar 2022 12:47:50 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11020022.outbound.protection.outlook.com [52.101.56.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2143257494;
        Tue, 15 Mar 2022 09:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFjIqry0EM5Y43/R19HyvVPVn5b1igIpYN6qWyZWNfEqY8STOtJENg3FtsVV8jXQ1rgm01RnYaONI+mfUWp4H4NSE9zccFbjLX6AlbL0OPA/3w200UqHiGnascPRk/tM7T9QuXUTBcQKEnD4Ze8HIH4fdDVfIesE4tp2Vl4H+jnbsX4iMQJElvBLSWyLhXfSYPOUGkJ+P6DDc3QYx0g6esYKfTi/4aHZHEpvaTe0QBFKom1zHkoRui2EvkCQ9WryCSR0LEaA2wq7gCKx+lAGpehhRE6+BN7LU7agSkBvayhS3wmYw4pOSfIeQ1Bp3O2d+kk6w+4bs0nFNrq8bMpnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOdWx87ILUoTbw7Bd/co43Wx+AJrfzAm4710Fq512E4=;
 b=Vjw9oD/jLKHiiqbFcBjH3C6EiVG2dvjssh1TaA2meVZOfgDRsj9eS18Rusbj96d6Av2jg4MiX/7l+A+BuovI56urGbyuLG/ZZlBCeZwTRQHzRni9YRPMsi2DROCu7fkbnf/rXiskjijWRJkf7BAcUvjAo0aN+GcEsyX5ccuGpVEiHw2WCuPc5WtelgwxXhvO/k5xxFht2ui+GYwdbLlxe3I39gvbD5Iq0RDabGFtUDcD4cm+6rSMmZMjyPGoNN/mthZt+K1kpOtfA5QII3lL3T6NsPgP+tpzMwrp2MaQc9931cs8EHcMgMZSMxbFs4RL0C2DeUm2Fgea9nLefmv6SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOdWx87ILUoTbw7Bd/co43Wx+AJrfzAm4710Fq512E4=;
 b=TNGtjYHwq6p11GLshrCBzmwJKeAYcFGYuAKdKZmVSeO5DZCli0QuOz5pqZaYd1wq9GnSPLEkvs7k2s8U1hJ1Nzun2jeaIrR6P3W2v9MXYzWjklLB1VCl/1tLg0uVvLE8GGbwsgbndK7cg3K2dAgccA6/Hoz5tlqK5XlEnU7kJ/E=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by SJ0PR21MB2055.namprd21.prod.outlook.com (2603:10b6:a03:399::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 16:46:35 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::44a2:4767:f55:7f2b]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::44a2:4767:f55:7f2b%5]) with mapi id 15.20.5081.013; Tue, 15 Mar 2022
 16:46:34 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Long Li <longli@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] Drivers: hv: vmbus: Fix initialization of device
 object in vmbus_device_register()
Thread-Topic: [PATCH v2] Drivers: hv: vmbus: Fix initialization of device
 object in vmbus_device_register()
Thread-Index: AQHYOHaEEH92NYUC6kW38teo7E3ZEKzApwfQ
Date:   Tue, 15 Mar 2022 16:46:34 +0000
Message-ID: <PH0PR21MB3025C408C7355EE552E81137D7109@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220315141053.3223-1-parri.andrea@gmail.com>
In-Reply-To: <20220315141053.3223-1-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cafd79a8-79fb-4588-bf76-d812e56835ff;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-15T16:44:46Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9a8481a-c07e-4a36-4098-08da06a35dce
x-ms-traffictypediagnostic: SJ0PR21MB2055:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <SJ0PR21MB2055231B20051538E0E91869D7109@SJ0PR21MB2055.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mWWJILIQyzIyuH9rVleHsFABQkqzkPohPT7DlCKSOa6ctk3q5M6w/HGaAc5lq1Sq81O1BLmw6Dg85Yq9zRzhO6IO7wbDy4lvFyPQ37LKP/OJMYlTi17xUzwdAouEr2r87AYWGwXFw7phtpPnkOm7BaiX/mfYJbH5Q9UcVPua6Hrg+2wDKTnn1YEnoauaCq0H4LY64Eiia3yG1qXYLOtGstN80SJ884CfIctD97rfK7+Rxa7jMfjJF403TVo6oo25XYcil0J2V0UUVYoulnl+dWnxl3WSkosjJ0HyVspdssWn6ZHiRIy3Tq7zLlNedCSBY5BamM8COQ8Z4AQOafsRktQzeEjFyA9VagV0Zx9SNMrWsg/D62D+nldRMEP3NMeVA6rn5/pAnvH5lILsqdrDyo4do9YhlP2TSJ/bnQYNKo+xoF0gJZ2BVYcZ1ZEURfIOWCGR34VjEunDZ8t1KYuRr/29+GXgalNdoMV10UJ4WdmZlwFBeg64iRF0/eXULcdYyFKwMlw65wZgd3Uph1PlI4UFNDAkXa3gwz1+SBahjgVOXKVy2o/zBxc/GUUayW2a30oTaPIl26s322t+PuFdiC0treZHMQc2Jl2JlDG+8lkn7ZzCqzrgCaaudNbngB/hCPWI36KcpEWfdMliMP45SrwFbOZNmm/cZ35+vbKoyp2NwRvuDF7gZhnUK5pTHVTIr2S1XG8KUqQmhoUikrfaWCylqznjkkb6lbXhGC6YYJmlI4kOtH5vcx9nM/G4sendJ90Hz6SqP1pgx/wvnQn9fpeWijgXkfAmb7BhpgFJjktoZVpjKwXgq+P58cHii71tMP6ECwoY3iwlCTk54AS+fQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(8936002)(55016003)(52536014)(2906002)(110136005)(54906003)(8990500004)(6636002)(508600001)(10290500003)(316002)(26005)(186003)(71200400001)(966005)(6506007)(33656002)(9686003)(7696005)(82960400001)(82950400001)(38100700002)(38070700005)(66946007)(66556008)(66476007)(64756008)(66446008)(76116006)(4326008)(5660300002)(86362001)(122000001)(8676002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S84WUSXQJfqoPzsKSCCYt5QbHDzi9EFwVrKF5RrZ82nULT9A2hItUQs/TXi1?=
 =?us-ascii?Q?2ejkyrlB41nhpA6i1/eGncMBj5GteoE3hMhW/RSACGSiAVDcqHKXuqkTqngb?=
 =?us-ascii?Q?oSMTFHl5BeS0gAnha/ovnOopH3gdAAgKDypuJAi4cuM5RPywzH23QKW7TBi9?=
 =?us-ascii?Q?V9h45tCqRgc/kjoxhbuTqJK8FS07TB0sS1zqQCrt1Q0b8MevSwQJ6h2muLUU?=
 =?us-ascii?Q?I7XIteJMvyAfAUcY6Ga5pjv8/+mgpHgFCB1cugksXc9cJt+FCCRFbkhQ+MZU?=
 =?us-ascii?Q?FiJkH7pjFGAJ2h0+9fIkmhMwv889WtDP/+qoYkQ7nJdb6yQHGu50VQ9e1OUt?=
 =?us-ascii?Q?c59HpSZ0d2JxaZ1i/Y/V/G1jJ3LZ8odBNE6rS/IwoYk8//xV1DaOc+w04Vs4?=
 =?us-ascii?Q?GADYX9gKgaDyrHvk6r2DhCYLj58/K8blLSoRfpkXkiPVKlLdUYwr6irhPQen?=
 =?us-ascii?Q?IWR4JXz9rukzdJgisbAXdW9SwUwKK9928Z0J+fOXAjNtYPajxYAs9yOnFvTy?=
 =?us-ascii?Q?JahcpswWDUxnspBcwsR0gclEqUlbrMN+jx7ub3L6ZgjLcP7SQYXEGleasr6X?=
 =?us-ascii?Q?IX1Rankz6KEhhPejq6eOhq8IIX+Ai6BoVWd4BxgKA9qCaiMk1mYZ5hTwYvsB?=
 =?us-ascii?Q?SPc6mGltnaWv7WMyyyhvhEstnq7XNSVrw6PJ6x3DrZYPTFLB+AGLZ2/BHoq3?=
 =?us-ascii?Q?qZxydUGIVaTE8OBH+0rSB+Pep0JZF85n+SFXM76F7/5zQh/WNMLwojth8b5K?=
 =?us-ascii?Q?HczUoaua/TKRclUdeRal2kP9W4cSYIYZMhNPF9b93Jpd1Vz7RYMikmy5ZOxh?=
 =?us-ascii?Q?KmbcFqM3ZY6wfGQ+ciPZVw9CMuCeDplhfDVmC13QWVpe4kpuB42XZWD+2Yyg?=
 =?us-ascii?Q?ngksNsyGEFoanHu8j57EybqjNJhWcA+I1Q7pEJmtpshdRrjHz1wxkM48Pg7L?=
 =?us-ascii?Q?CMqkvZZ9h7UNpgI29gEs/oj4Ow0s5UBUNpzjTWRgkeXiUyeMPHjTkDBNIlZ2?=
 =?us-ascii?Q?DaoN2Xlqku1YwcpB42w5sK+St5w7ynQkFSmL0ODvVdVcKAI++nt2tgx4Awco?=
 =?us-ascii?Q?neneGbdp9V4WLHN7dYjYwCy/NipxuM4JUZXPKyUWgPVOu5M55h9kegiACDcn?=
 =?us-ascii?Q?uebZcMCAWanA6r79MIH6nPhdS4Q8dq+PEJJ18jYDA0F9phAcl9BQOsLzv6z0?=
 =?us-ascii?Q?ijygqEFPJBPGeP/iqam1O0vb5x+0MuERi2Lb+Eno90k4zz01/kHKhcAeE0NT?=
 =?us-ascii?Q?xiPavN9jy1v1uB8S3YfinDqS6Y1sW2Ri9xTXharEGDwdh11gUvrfbxFoX2m/?=
 =?us-ascii?Q?fLlZ1hAuQaw+/YQKrhWr4oZKkUF37HDXLiuxlfc1d+2MYDZPRDxuxEEnT3xI?=
 =?us-ascii?Q?VdWBUb8K524MVTdYahgWkHu9ZtqzpxFxtnAHdLd+9Tbv0SGaQe9HiGTWMAWS?=
 =?us-ascii?Q?7EuHZ5G/DwalttPM0mi1Q/iDT1y7uQfKh4xicQM369h+cGPjv0BcOQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a8481a-c07e-4a36-4098-08da06a35dce
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 16:46:34.7280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2yEYfmqRqqTwMXvfgSeQhpiS359kIXQL/Qow9tJqCA09mjny1oh0cA3PbkrGgNl3dgzof/ugbmcLR4jo7NprRF6ow/N6tu6navw7ZgX8at4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2055
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Tuesday, Marc=
h 15, 2022 7:11 AM
>=20
> Initialize the device's dma_{mask,parms} pointers and the device's
> dma_mask value before invoking device_register().  Address the
> following trace with 5.17-rc7:
>=20
> [   49.646839] WARNING: CPU: 0 PID: 189 at include/linux/dma-mapping.h:54=
3
> 	netvsc_probe+0x37a/0x3a0 [hv_netvsc]
> [   49.646928] Call Trace:
> [   49.646930]  <TASK>
> [   49.646935]  vmbus_probe+0x40/0x60 [hv_vmbus]
> [   49.646942]  really_probe+0x1ce/0x3b0
> [   49.646948]  __driver_probe_device+0x109/0x180
> [   49.646952]  driver_probe_device+0x23/0xa0
> [   49.646955]  __device_attach_driver+0x76/0xe0
> [   49.646958]  ? driver_allows_async_probing+0x50/0x50
> [   49.646961]  bus_for_each_drv+0x84/0xd0
> [   49.646964]  __device_attach+0xed/0x170
> [   49.646967]  device_initial_probe+0x13/0x20
> [   49.646970]  bus_probe_device+0x8f/0xa0
> [   49.646973]  device_add+0x41a/0x8e0
> [   49.646975]  ? hrtimer_init+0x28/0x80
> [   49.646981]  device_register+0x1b/0x20
> [   49.646983]  vmbus_device_register+0x5e/0xf0 [hv_vmbus]
> [   49.646991]  vmbus_add_channel_work+0x12d/0x190 [hv_vmbus]
> [   49.646999]  process_one_work+0x21d/0x3f0
> [   49.647002]  worker_thread+0x4a/0x3b0
> [   49.647005]  ? process_one_work+0x3f0/0x3f0
> [   49.647007]  kthread+0xff/0x130
> [   49.647011]  ? kthread_complete_and_exit+0x20/0x20
> [   49.647015]  ret_from_fork+0x22/0x30
> [   49.647020]  </TASK>
> [   49.647021] ---[ end trace 0000000000000000 ]---
>=20
> Fixes: 743b237c3a7b0 ("scsi: storvsc: Add Isolation VM support for storvs=
c driver")
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
> Changes since v1[1]:
>   - Move dma_set_mask() as well (Michael)
>=20
> [1] https://lore.kernel.org/all/20220311133738.38649-1-parri.andrea@gmail=
.com/T/#u
>=20
>  drivers/hv/vmbus_drv.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 12a2b37e87f30..0a05e10ab36c7 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2097,6 +2097,10 @@ int vmbus_device_register(struct hv_device
> *child_device_obj)
>  	child_device_obj->device.parent =3D &hv_acpi_dev->dev;
>  	child_device_obj->device.release =3D vmbus_device_release;
>=20
> +	child_device_obj->device.dma_parms =3D &child_device_obj->dma_parms;
> +	child_device_obj->device.dma_mask =3D &child_device_obj->dma_mask;
> +	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
> +
>  	/*
>  	 * Register with the LDM. This will kick off the driver/device
>  	 * binding...which will eventually call vmbus_match() and vmbus_probe()
> @@ -2122,9 +2126,6 @@ int vmbus_device_register(struct hv_device
> *child_device_obj)
>  	}
>  	hv_debug_add_dev_dir(child_device_obj);
>=20
> -	child_device_obj->device.dma_parms =3D &child_device_obj->dma_parms;
> -	child_device_obj->device.dma_mask =3D &child_device_obj->dma_mask;
> -	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
>  	return 0;
>=20
>  err_kset_unregister:
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

