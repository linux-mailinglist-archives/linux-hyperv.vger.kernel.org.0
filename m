Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2695672E2
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Jul 2022 17:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiGEPmI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jul 2022 11:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiGEPmE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jul 2022 11:42:04 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021021.outbound.protection.outlook.com [52.101.57.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D061A817;
        Tue,  5 Jul 2022 08:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fK24jvcM81DZLwCmNLbVxQZCdJlvGOtLnA0Oz4O9bd2wI5UtsZC5j3h5tUD4wpRqoNmfm4e3Av+age8WxaclUzmQjy5zUxEIH7zt0ig3ref4nOpdqot9lX2ZfogQd3lp50uB7koIe5WHUV+doSbv/lM7nRGv1tlTbZRO8q9f913Xa7tOnFMddG1FwiYIai+40yhyWaFEeQHm0XuSt0S6gjYM2GfxCkS3qQ4Q1DmujdhWCQoATzMd0n0ad1edfrQjMtfbZqRgg4QMto7SuksNy1hoz9b9wNi4XIE3b1IK+qEV9+jy3cA+pufqWFXBNbfvJF/ERy7Cbc8JhnwRReL4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkU0s/vpKd390JnnGfhIL03duUUk2YtFkcds0wIn5/k=;
 b=ewpHSTwPGMD02fceF2Ty7nhZ80WGkghk07ve4e27wZlzpwA4DqGXpoCF34+8wWoUBL2vc3UQMK2URDHWdoAMmdJE1RGTlK/xQ+xlLLTpYm7zFEJFGJJUDDjizPK+5l6YZvCNrOiplfmULMtlOzsoK5F/xqsYcKvdhu5c8J+1LW7VCsDzhAmCnLffjwbHFnNBrZIu3WxqIMViJbZHa33xo8ZHJkt4GwKV+FARyLWKAvNdzVKdyvIZKK0BYAVikrQMTIiLNhhiF1Xxn18x/BMIWS3w8KDlDSLHdOhw4wKDVLRIATYaSN4OIR+uLxaY/zdguwR1LRIdYh1KvmFa7bKaOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkU0s/vpKd390JnnGfhIL03duUUk2YtFkcds0wIn5/k=;
 b=ZtQydNGmD0343k2BCHNci27DlxuvSVwRE0wS9w21dKhI5dLcv2MKx2HlW07nf2Gkiij5+q34bApcKrSc0j4NPZmczic16jFZzsHyj4i7WKT+wrxDiGdLewkkGcQZfhoNdKD11PaNBczDpVI1DgXgerxjJu+YEIEB3cGB7E0jans=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by PH0PR21MB1944.namprd21.prod.outlook.com (2603:10b6:510:1d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.3; Tue, 5 Jul
 2022 15:41:58 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::7838:dcbf:513b:d992]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::7838:dcbf:513b:d992%5]) with mapi id 15.20.5438.000; Tue, 5 Jul 2022
 15:41:58 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Shradha Gupta <shradhagupta@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: vm_bus: Handle vmbus rescind calls after
 vmbus is suspended
Thread-Topic: [PATCH] Drivers: hv: vm_bus: Handle vmbus rescind calls after
 vmbus is suspended
Thread-Index: AQHYjqmgSQ9pYMypP0yL6mm4JZXl+q1v5kKA
Date:   Tue, 5 Jul 2022 15:41:58 +0000
Message-ID: <PH0PR21MB302570F52D0CC90B3EC9D066D7819@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220703065332.GA23943@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20220703065332.GA23943@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4a478d4f-6942-47f0-b937-c3029aff6652;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-07-05T15:13:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b6b0f26-543e-40ab-3040-08da5e9ce54b
x-ms-traffictypediagnostic: PH0PR21MB1944:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zCKTe7Jht8SmdFBCrz9AUBenIiGgRKxm1guxLuFMN50ymjIxNGqnks9pGmaYBxOzSHcPiQ8BqgVdbv2XVSCc3Ey0nNXaNipI7h/8tMv7NGDN1FDD8U58EMWumZkePkYEM3ytUwC8TBJs+QIWGlioNYnHaX+Vwgl6bvxIJHfYQBwp8GnCylqohXJr5gncDqC7L/iHDnBr2MkKc7TzZmlJcIIxmAL3OIgryA2TAVlpZnKchB6z4BXlJUjFYMBZWLuqom9pVsOMjS4Ei6uHH5/mk+lAmGiAK0aVnKKtWVFLXSeajN0Z2/eoy7TGKvGtKTR6yZgFwwpqCnOPTJeX0MdxRQvTtp5wsxcPCHrN/HnDWq6MEX1uEG//XjhokzqYTYWj/OyDCfIJATq2/IzZ3YTzk+Z5ZoCvtd7ivdjUxheT+fprDxPCOG3eCLK3UyBeA9rmlny0Ak3Qsxsdbk1b3+ls5yVoq/+PjhReDBaT2xmbZvoMou0YnBDlrsti9bF6oJurD5lzJiF0p1TKZwxNszxy9WOmmpHGQN5BXzUkCvD+lsT70bXpBo0kakFBz7I4q9cu0jygdBQVWf2rEbE80lrqFcVALWLgmmA12DMfZsYe8Lgu9gzGD5RmTEoEWWgcpuo+ZnBTTyyfAAlKmbdNrcN8UhDq1xdmLTSAz3LxyBhxDkp+ffyKOiYebnLnULZ9gItvXad68VmN94JiZokmy2LxGctjZaS+tGx9pv8KBoLnXAsZ2tn01x6Iu/KDN9uPhstvNwPyIHfvxmF3yD9nq+jPgjefc0jzyPh5KUT3DypBhYHdnYSquC8KPR031eOL60Gc82DOe/B01EFmxEnZEEz9nrl9BVYnTzuujXEksuhze5E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199009)(38100700002)(82950400001)(7696005)(33656002)(6506007)(82960400001)(2906002)(9686003)(15650500001)(86362001)(8990500004)(71200400001)(478600001)(26005)(54906003)(122000001)(38070700005)(41300700001)(10290500003)(66556008)(66446008)(64756008)(4326008)(66476007)(76116006)(186003)(107886003)(66946007)(8676002)(52536014)(8936002)(83380400001)(316002)(110136005)(55016003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FeUBXEAavhxYxk6H48sxlT23G6yMYRhsyHGThFmOp/4HFQgNJVOzhTZLh0E7?=
 =?us-ascii?Q?xe5a1XyRFd1Dkx7Jj2RDPDitlDlGvantDTht/mJ+jtmwzSUGP86Zrh0GyVBr?=
 =?us-ascii?Q?C5zfYepUsSfNj72Fpl9QkRphCpxZ8zHB8iJUZe4aCfMpSIz/oZI23583Dhp8?=
 =?us-ascii?Q?Yn0pc2ciZwlK4ZmGrvDPRj4WDN+AQ980HD+DXoX84BapPTuoa1kcE6Qtf75C?=
 =?us-ascii?Q?OKnz3P7tShyXOW8yfUJqkaojE7BA4elhvEZLT3lcA704etEgPMAnoSH02NfH?=
 =?us-ascii?Q?6/AKx3cCI3aKqg710jJa8I2cUOLDRqpoHZuPYT9bLnw9huZhj/F3S3cnQXbD?=
 =?us-ascii?Q?sRWHIM6gneFTvwiw0b6X16z7PcuZ5CpFTUV0e5d7dQNAw+b7YB63AVuRihpZ?=
 =?us-ascii?Q?lwqfZ7fr/s+FvalN9PMlMJRTSssveYn1UhGGSBQdca8TBZ+PvFG3TA1iQ4Gg?=
 =?us-ascii?Q?7OpzGA7AXLDN/Ip1Y2/1ibwUr6QPBZjAIplO0PzFFQy+waXWW7Gbo8tklt3O?=
 =?us-ascii?Q?tZe3RcBk583t3Fa7kITUBozZt7L9oip8H6U/SwyGBnMWf4guCeYnl/Er6UZ2?=
 =?us-ascii?Q?ZvCUermjPzalLBToqYTG0M8Qh+o2oBf3QPehYcbGSPPLsf0Xy1PWe21D3GIC?=
 =?us-ascii?Q?5MFG8LjJR/TUoD4E4D3+v9h5IKZvIJ4njDSDkr4+be6r9WpEMgiSZsQkWmXK?=
 =?us-ascii?Q?yTBA79tAXAxeidSCZDa7qHCJJ35mBmV0y3fCGe3DsJvoB0n/CxgMavA+9b76?=
 =?us-ascii?Q?iyMn5GXjDVRYgsQ7lE1tgxCNOjswvfDcAKNexEmLWmsq75DFvSU4EngwrUDR?=
 =?us-ascii?Q?QUSmPVX6p12BYFIMJshHXlUIgKKDpEDpl+xjfKvTFRKlms/INt1HHgCG8x2A?=
 =?us-ascii?Q?clYg2LR6/lau85KUQ1B2Vk5YhQfXf8UL6wgCZ61lOcCxXxfZg03H2DtoyZc1?=
 =?us-ascii?Q?gmoJ2ao5YKtE6x3htHfkyjDuQVericn3ri12y0NyQDr93ikkLIwgXUSztj5X?=
 =?us-ascii?Q?raVdA1o/WHeVSIXqdyvOMadOzVwK+bfcJixQ7S0w+ynsUiz898uQHuKxMpuJ?=
 =?us-ascii?Q?Xn0mr/IPa4pTvJgoib1QWUnjNs4XzrIyp9+/HQkVNX1WjhdcKTwkRkk+PKzK?=
 =?us-ascii?Q?tSGfYkSLSKh0EZIKzFxBa7l8iNnOdyP+Pzg7ncQlgJNPEZPmqSeABO7ro9Q0?=
 =?us-ascii?Q?ckhvnbiZOFkT1X7rlG1vMrXBoTQdudLBNLNlSw0pPWkC2OkXV34M50JjU5Nl?=
 =?us-ascii?Q?/zCpY7I+4nwUIikO2D9oHELFxDbXou0Gog7JmaiFTKsIn3TDtlDJKqDOOZly?=
 =?us-ascii?Q?7d65+J6fpjexSThXNZTFT7SGrNEZDhdgxLtjSWcQ1c10ZgqskVAG53ep2DHf?=
 =?us-ascii?Q?69rDQs+PQ9+diT4Rd//2QbVLpSZwzbAqaFHpb1QRl7EqajbPyD6bhF5cvToT?=
 =?us-ascii?Q?3h5Numiavh1MkUYMWE+twf2gUrqHJ26wKR1dTR3W6Bt9b9L2Q486sDVHJU/2?=
 =?us-ascii?Q?IimifS1yrIaeH2MuRcboXLzmNrqk4eFZs0owvlIqL0EavWLTQww5KxYYxDWb?=
 =?us-ascii?Q?qRfu3W6g3l6x4GwRvIPaLIBJ8dVe058/6wzc+Gh1D13K2UiwdCKOy5rII21q?=
 =?us-ascii?Q?Ug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6b0f26-543e-40ab-3040-08da5e9ce54b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 15:41:58.0540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dTNcaemX9KcVADyww3rubacvn48OQuxQ2KPGibJov6wdIJkzI7HabHwXycgjiQkZKOU4e7TCuB2nUTr9iPNWV6qwyEVvkquTwIxHlqBy0ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1944
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Shradha Gupta <shradhagupta@linux.microsoft.com> Sent: Saturday, July=
 2, 2022 11:54 PM
>=20
> Add a flag to indicate that the vmbus is suspended so we should ignore th=
e
> rescind offer message.=20

From the code, it appears that the flag causes both offer and rescind offer
messages to be ignored.

> Add a new work_queue for rescind msg, so we could
> drain it in vmbus_suspend processing. This should help avoid any rescind
> offer msg processing if ignore_offer_rescind_msg flag is set to true.
> It was observed in some hibernation related scenario testing that after
> KVP_vmbus suspend, we get another rescind offer message for the vmbus. Th=
is

I'm not clear on what "KVP_vmbus suspend" is. =20

> led to rescind message processing after vm_suspend and we would end up wi=
th
> a warning and stack dumps

And what is "vm_suspend"?  There is a function vmbus_bus_suspend() -- is th=
at
perhaps the intention here?

But I think the core issue you observed is that after vmbus_bus_suspend() r=
uns,
we might still process a rescind message for a channel that has already
been closed as part of the suspend operation.

>=20
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>  drivers/hv/connection.c   | 11 +++++++++++
>  drivers/hv/hyperv_vmbus.h |  7 +++++++
>  drivers/hv/vmbus_drv.c    | 24 +++++++++++++++++++++++-
>  3 files changed, 41 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 6218bbf6863a..88a0fd8e80c0 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -171,6 +171,14 @@ int vmbus_connect(void)
>  		goto cleanup;
>  	}
>=20
> +	vmbus_connection.rescind_work_queue =3D
> +		create_workqueue("hv_vmbus_rescind");
> +	if (!vmbus_connection.rescind_work_queue) {
> +		ret =3D -ENOMEM;
> +		goto cleanup;
> +	}
> +	vmbus_connection.ignore_offer_rescind_msg =3D false;
> +
>  	vmbus_connection.handle_primary_chan_wq =3D
>  		create_workqueue("hv_pri_chan");
>  	if (!vmbus_connection.handle_primary_chan_wq) {
> @@ -357,6 +365,9 @@ void vmbus_disconnect(void)
>  	if (vmbus_connection.handle_primary_chan_wq)
>  		destroy_workqueue(vmbus_connection.handle_primary_chan_wq);
>=20
> +	if (vmbus_connection.rescind_work_queue)
> +		destroy_workqueue(vmbus_connection.rescind_work_queue);
> +
>  	if (vmbus_connection.work_queue)
>  		destroy_workqueue(vmbus_connection.work_queue);
>=20
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 4f5b824b16cf..ff8707284554 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -262,6 +262,13 @@ struct vmbus_connection {
>  	struct workqueue_struct *handle_primary_chan_wq;
>  	struct workqueue_struct *handle_sub_chan_wq;
>=20
> +	/*
> +	 * On suspension of the vmbus, the accumulated rescind message
> +	 * must be dropped.

As noted regarding the commit message, the flag causes both offer
messages and rescind offer messages to be dropped.  Maybe the flag
should be renamed so that it is clear both message types are
dropped?

> +	 */
> +	bool ignore_offer_rescind_msg;
> +	struct workqueue_struct *rescind_work_queue;
> +
>  	/*
>  	 * The number of sub-channels and hv_sock channels that should be
>  	 * cleaned up upon suspend: sub-channels will be re-created upon
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 547ae334e5cd..46bd867f11ba 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1160,7 +1160,9 @@ void vmbus_on_msg_dpc(unsigned long data)
>  			 * work queue: the RESCIND handler can not start to
>  			 * run before the OFFER handler finishes.
>  			 */
> -			schedule_work(&ctx->work);
> +			if (vmbus_connection.ignore_offer_rescind_msg)
> +				break;
> +			queue_work(vmbus_connection.rescind_work_queue, &ctx->work);
>  			break;
>=20
>  		case CHANNELMSG_OFFERCHANNEL:
> @@ -1186,6 +1188,8 @@ void vmbus_on_msg_dpc(unsigned long data)
>  			 * to the CPUs which will execute the offer & rescind
>  			 * works by the time these works will start execution.
>  			 */
> +			if (vmbus_connection.ignore_offer_rescind_msg)
> +				break;
>  			atomic_inc(&vmbus_connection.offer_in_progress);
>  			fallthrough;
>=20
> @@ -2446,8 +2450,20 @@ static int vmbus_acpi_add(struct acpi_device *devi=
ce)
>  #ifdef CONFIG_PM_SLEEP
>  static int vmbus_bus_suspend(struct device *dev)
>  {
> +	struct hv_per_cpu_context *hv_cpu =3D per_cpu_ptr(
> +			hv_context.cpu_context, VMBUS_CONNECT_CPU);
>  	struct vmbus_channel *channel, *sc;
>=20
> +	tasklet_disable(&hv_cpu->msg_dpc);
> +	vmbus_connection.ignore_offer_rescind_msg =3D true;
> +	tasklet_enable(&hv_cpu->msg_dpc);
> +
> +	/* Drain all the workqueues as we are in suspend */
> +	drain_workqueue(vmbus_connection.rescind_work_queue);
> +	drain_workqueue(vmbus_connection.work_queue);
> +	drain_workqueue(vmbus_connection.handle_primary_chan_wq);
> +	drain_workqueue(vmbus_connection.handle_sub_chan_wq);
> +

The above looks good to me.  The ordering is very important, and you have
the order correct.   Once the tasklet is re-enabled, there may be messages
queued up that will be processed.  But the flag is now set, so those messag=
es
will not result in any work being queued to work_queue or rescind_work_queu=
e.
Note that a memory barrier should be used after setting the flag to true, b=
ut
tasklet_enable() provides that memory barrier, which might be worth a comme=
nt.
Then the work_queue and rescind_work_queues are drained.  The process
of draining these work queues could put entries into the handle_primary_cha=
n_wq
or handle_sub_chan_wq, so then those two queues are drained.

>  	while (atomic_read(&vmbus_connection.offer_in_progress) !=3D 0) {

With your above changes in place, I think the test here for offer_in_progre=
ss is
redundant.  There can't be any offers in progress since the workqueues
have been drained, and new entries to the workqueues are prevented.

>  		/*
>  		 * We wait here until the completion of any channel
> @@ -2527,10 +2543,16 @@ static int vmbus_bus_suspend(struct device *dev)
>=20
>  static int vmbus_bus_resume(struct device *dev)
>  {
> +	struct hv_per_cpu_context *hv_cpu =3D per_cpu_ptr(
> +			hv_context.cpu_context, VMBUS_CONNECT_CPU);
>  	struct vmbus_channel_msginfo *msginfo;
>  	size_t msgsize;
>  	int ret;
>=20
> +	tasklet_disable(&hv_cpu->msg_dpc);
> +	vmbus_connection.ignore_offer_rescind_msg =3D false;
> +	tasklet_enable(&hv_cpu->msg_dpc);
> +

Is there a reason for the tasklet_disable()/enable() calls?  I can see that=
 they
are needed when the flag transitions from false to true, but it's not clear=
 to
me why they would be needed for the transition from true to false.

>  	/*
>  	 * We only use the 'vmbus_proto_version', which was in use before
>  	 * hibernation, to re-negotiate with the host.
> --
> 2.17.1
