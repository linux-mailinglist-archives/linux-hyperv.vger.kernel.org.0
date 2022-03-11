Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366314D6449
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Mar 2022 16:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345892AbiCKPII (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Mar 2022 10:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbiCKPIH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Mar 2022 10:08:07 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11020026.outbound.protection.outlook.com [52.101.56.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689791B50D9;
        Fri, 11 Mar 2022 07:07:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6Am1Xp2R4m3u5TxzUSJtUgSnjkBqx5pPTFwtaLZR7vXRoz1Y9XblCzCziyhTUMoCV+1nX1sCqYQE8ulCXSosUDkAghFuIAUQUc9YceFr+anpow+nE/vGZ/qnDwbDUNNaRGDtgb0yUq73jjBIsRPbnBe1mzdTRqmhp3WN9nkK5CNg6kjNHgFMlpDVpCWikZVK6e5Nbh8JYq/his0U5ucvuv1kRLekUBXN771IFc/1C+zkLnWFUVqwCnZSuoFl4CiAny1RBLXRJsdsIsSPrdXG5PiILi2jnQgti/FOEulfQayqk1LZStJ3/EGxmiqDAOohmSvS/u8fAIULL/PXOAhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Zo7ETzZ2eZlRUMqcyXgLiafVyu9JyDTXoTwuU2gZ0M=;
 b=HRGGgTJjqe1JxupRzpJJJIvJHHJymuACch+sNgLkpeLwgWw53xxpTl2/XIwdKS5GNzIq/0Cj8pqMJKseM6DmZcf4DeEa9YuTKs2jEfVhfV1e3KDgMnsyGsh6YIOxOSgEzmKUHkUPwjaknRLrSGSIjtwHInJwdJhE1VC+8+SwHLOqS/HG8OZx1rq7YTFngYXc0ip9q81pzZEWCWE+BaBvdryXJKdxq76WzxxkojH0JlglEEppzUo7RVNeE2MqYOmgEwMt2qI7ZL+0+kVVZHb+OEAQC3Zlncv8d8AGoqwUy4ySdGii3NpdGAsK7gAI8puzQf6ssoDAlSqhE8lfuoxdzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Zo7ETzZ2eZlRUMqcyXgLiafVyu9JyDTXoTwuU2gZ0M=;
 b=UkDskIeeC9g5BBe4GeGppeHUGdalg9ctjcEE4qMt/j/eako5MsFblIWJohdLI9unakLEXIYDQD4YpDEc0sQ8cJTEAhrtxrEtsMTMXzIfjFd3Z99azRLBjJkHofb/qvbd8y++EgvpEVGDaQ4HVH0XX24cXLCHXuJMDWmORdgr5+w=
Received: from BY3PR21MB3033.namprd21.prod.outlook.com (2603:10b6:a03:3b3::5)
 by DM5PR2101MB0725.namprd21.prod.outlook.com (2603:10b6:4:7a::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.10; Fri, 11 Mar
 2022 15:07:00 +0000
Received: from BY3PR21MB3033.namprd21.prod.outlook.com
 ([fe80::ed64:ab10:6089:b736]) by BY3PR21MB3033.namprd21.prod.outlook.com
 ([fe80::ed64:ab10:6089:b736%3]) with mapi id 15.20.5081.008; Fri, 11 Mar 2022
 15:06:59 +0000
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
Subject: RE: [PATCH] Drivers: hv: vmbus: Fix initialization of device object
 in vmbus_device_register()
Thread-Topic: [PATCH] Drivers: hv: vmbus: Fix initialization of device object
 in vmbus_device_register()
Thread-Index: AQHYNU09UDSa83h2lU+ejkXSJv9WG6y6R8PQ
Date:   Fri, 11 Mar 2022 15:06:59 +0000
Message-ID: <BY3PR21MB303347BCA5C489AC8C5ABEF7D70C9@BY3PR21MB3033.namprd21.prod.outlook.com>
References: <20220311133738.38649-1-parri.andrea@gmail.com>
In-Reply-To: <20220311133738.38649-1-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dcba925a-46c4-49c9-a6d9-105b1cc11f01;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-11T15:03:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 521143c3-b43d-4a40-9267-08da0370ca99
x-ms-traffictypediagnostic: DM5PR2101MB0725:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM5PR2101MB0725BA93F7BD8F763F2254A4D70C9@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iDGZV6Ve8h2ckPgVEarPvkl1dUkr7ORDfEM7qNMAn5inuKZE2tWE6Dywf2TrN4UtmxE8gyVAOmH6ZJwJXeBgn8hqL8Km0E8KRH/RQZjGxe9H/hJTc/hQkxJ92h/ZcqKT1O+Itjn3a3noLMwaeldk3Ti1YhAwnC/CUg1Nldp+qeqdV+/gRJEFw7xhCIwEmjog8sckL6anIrAVjJGu47hHz0qKJBQ85QuIATEEQqodGifQvbEunEoegkIHaZ+kxBNrWoUXfj9PKHHtJAIcWkLmkDbHWkkCrEstxgLw0sJH55BpcFM8h5VUxkSd+S2OR4hazhf72Dt3eZ1unXuvQWxpt3bnhhhZ3JEDYMMnGty0bV4aA48JzYoMi4uklSh5jepMSRlIegPUsHmiIg2btw0uvUdQp2+N4S4VCW1oVKM6ku5b7UQh+2JUAxUQG9Je0HuT7CSTyq4ZgE3JS0hyF1MvD1gLG+ALrLQETUOdpI9LvIyeFP3Ovg0DH4CJwxduDAG1qU4D3KXRPQf1aVjsimucTP0GPWRlLqVptng5HpyLey6UZVcYtheSS91/Ba2pLdgkY+YCb0dvc5mcamwljMIuiSnJCwdH+lieCV0eB82kfL5Jjm5MJ+AbOHbgtaSoBSf9cz60uKaPvztBtXl2e1QM16mCMAoFiV/kUm7/bwJILxujvTDySHwL3fQbuinRJGsag/AQJAkBkQq/NItuMOVN9lQ0AEm92K9DUKd4eRSmK+frpMeya+XDCWfqCXJt09wJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR21MB3033.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(122000001)(38100700002)(316002)(8936002)(54906003)(33656002)(86362001)(110136005)(6636002)(6506007)(76116006)(4326008)(66446008)(9686003)(38070700005)(66946007)(64756008)(66556008)(66476007)(8676002)(7696005)(8990500004)(186003)(2906002)(5660300002)(55016003)(83380400001)(508600001)(71200400001)(10290500003)(26005)(82950400001)(52536014)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RYQXNKBoRlOsvys6wN48O/GtKMrxB+rWzW0Bq3gXxI/yIekXFU3GUkMSynci?=
 =?us-ascii?Q?ivsskunYoLZkRRPitkVUDfjhcrX5qze21XeXV5ndJobROWLp/wwE7RJWvArP?=
 =?us-ascii?Q?HerZsDJlGdzW3ccvLXCW2kD3oM+rtH+cCdmv+b1sciCWm+m9cXzRkaqrn3HK?=
 =?us-ascii?Q?4vquT0p/buZu2vigK4QyPde8qR4HkgtBdZIxmrSu+PgLsgZ/76xLanKq3yOm?=
 =?us-ascii?Q?hELO+2ARbW7IBaKRTD+MEtPS3Bva8KiYkLml95dS8+nav//Ufz4YyLtbjrOX?=
 =?us-ascii?Q?ahyAfywdcc+xDRJv+E5S1Q+ug8K3LV3ZDmT2h/QytWl25smcpsI0q33f6UAo?=
 =?us-ascii?Q?T74RjU5BiYt6Q/4J3OboiwFOxnbJyHezEnPM7k4RkBVsJorpXGX86T5ssoH3?=
 =?us-ascii?Q?q0zfuTT914RvEIpkXUN4tbr3ATvKsdrMI2ARTJ7EKRkzkNqvesAKB2sVx3vH?=
 =?us-ascii?Q?I1pGisVbHExU5SwviOYV7/9p6muhJif035ZabULgskzPo64KJ/DsgEitz1UQ?=
 =?us-ascii?Q?+wiUjZ6tIhePYR4Zih3vyaXrCN1Z8SlfuCs4a3y073huuJxy5FuDWLipob5J?=
 =?us-ascii?Q?6ZdD9bJrV6fbQ9aKVLT38cEeyKjainG3011j5xQAhqQ6WEoiOylWrqwhK/Tx?=
 =?us-ascii?Q?eHTOgsIR5lIc94CNGI51kxu/2ERfdB7qqWIP6LcPONjI7EbEwIBYpS37e+Xn?=
 =?us-ascii?Q?FZL5ul6LLQMvPBts8IfJnErhxOMbYWLRMb8wQgw6hQxLXHkqgOBNne6uzIhs?=
 =?us-ascii?Q?4Z6i88QMDfWnY3krKMH2tpJwr5mANFDIo6hBlre305jdAKRwujUcKTU9hkpH?=
 =?us-ascii?Q?JwN4orLC8TR8xO8DdelVZoE+CEpmezgBk/wXebjZNtmgtLdvC7lWFuil7enB?=
 =?us-ascii?Q?ufQYit5x2apdPwNTXWlDk/ENVM+5BHyT0dEr6dQewChMpHgtVWs53oPVgIpe?=
 =?us-ascii?Q?OITEwUkHpTx2m6NFqPyTxqzZRieeo1pNcwFbnLosqW6SdzY0wBhgvpY6Wj7D?=
 =?us-ascii?Q?WG4Q+FAdmpNX4m7q66K2g5k7Qdulv0CkinhPoxCLVZ6O2nNzN1aiH4iY9BS9?=
 =?us-ascii?Q?oto+fpoH6cshiSfk0zQO+sUR9FTykgO26Lh0yGMTT8/ucPjA8GTEWQBZNOH+?=
 =?us-ascii?Q?XLIcVsER+s9mDUQc05ocAsJTUbKICdqBWf0WRkspA8acF13gK1BICoHMxnD+?=
 =?us-ascii?Q?N0i1x3irN5kBDMaPMwG6A8VB5B4xHWIwB2EFvQ7WSnGk/AfFJ8gm6O5QtN04?=
 =?us-ascii?Q?YIuNbjxxrRTAL9t1LW/98TIUskWaQbrDifzFaktlfOhBNhpsay1RWLDkYycf?=
 =?us-ascii?Q?QyTjAfwh09vt/iT2Neka+GeNJTxvOlptd0NYSUKv2+p1WoUJmwj/CJ3XEs75?=
 =?us-ascii?Q?J4bVDovdLUa+ahAWGNXknN/5GqMPVscgGqkhWvJKlGH3GE9wM5dB2ezVZmZH?=
 =?us-ascii?Q?yiJoGBOfoerCWRPL5p8jjc3DkZC16tqOE/0VMVF4UKcjvrAp4HIrYQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR21MB3033.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521143c3-b43d-4a40-9267-08da0370ca99
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 15:06:59.5329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p7tjC2KNXcEqA/3xiKVLjnpDx/LCfaLtXYPa/zkwLnoFG+5/YqjJCykuDUYC/yy11Ax7J51gr5ESKHdEFh4Nzi9adoApYK1XazjuVt4HM9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Friday, March=
 11, 2022 5:38 AM
>=20
> Initialize the device's dma_{mask,parms} pointers before invoking
> device_register().  Address the following trace with 5.17-rc7:
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
>  drivers/hv/vmbus_drv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 12a2b37e87f30..65db5048b1763 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2097,6 +2097,9 @@ int vmbus_device_register(struct hv_device
> *child_device_obj)
>  	child_device_obj->device.parent =3D &hv_acpi_dev->dev;
>  	child_device_obj->device.release =3D vmbus_device_release;
>=20
> +	child_device_obj->device.dma_parms =3D &child_device_obj->dma_parms;
> +	child_device_obj->device.dma_mask =3D &child_device_obj->dma_mask;
> +
>  	/*
>  	 * Register with the LDM. This will kick off the driver/device
>  	 * binding...which will eventually call vmbus_match() and vmbus_probe()
> @@ -2122,8 +2125,6 @@ int vmbus_device_register(struct hv_device
> *child_device_obj)
>  	}
>  	hv_debug_add_dev_dir(child_device_obj);
>=20
> -	child_device_obj->device.dma_parms =3D &child_device_obj->dma_parms;
> -	child_device_obj->device.dma_mask =3D &child_device_obj->dma_mask;
>  	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));

Is there any reason to not move dma_set_mask() as well?  That call is
closely related to the previous two lines, so it is unexpected to have
them separated.

Michael
