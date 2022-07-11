Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DA2570979
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Jul 2022 19:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiGKRus (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Jul 2022 13:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKRur (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Jul 2022 13:50:47 -0400
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.56.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C0B7749A;
        Mon, 11 Jul 2022 10:50:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZaWbb8p4tIyVYkA2aX5GPKIfH1fEg/9wqT1NLTKJsXKGEBJiQuxz92bT2C59FG00XKDzYhGn5JqInBhxVOvKh/Hzw0tjbeJn0F2EQjhZ9vgpVgfn6ddzsZZWsavZhuZfKWu3+0vc9sET29tmvrfPYXiSITL+Shz7IKr6pNdft/yImrVa9x7XPdM3O0nnIEg7sP6LsOpC7C7tjtwkAPP+tIUoBKK3B6IT0OTlLKutF7X+5GUciTI0BKquGdo6jUU/Fgfv0C0zkkN3BACB6GczebR7O0BWfZB8HaVNCs0srUSsIRC3fW0AHxhHom6r9gIS8vlHyQBx17vWzOJIOAv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLTeJEWO4RTkpg84ea16Dz//7CVMtw5jPglp/NIhsIE=;
 b=fXEszrgcM0GePt8Ol/tkz0vMygfH11yaSgTk8LH/FkbohudIDAwONHAbIgE/mph+gQgrUbSUfZpXqpdVKUgBx73ZMbjMJoLcPE3GS8vWUDi9L/Ity8mooB6+BwTF+3SGesh1fgN4QuIR514r8hbaSKNAzUghMEf/70TnZratTc3bI1e+4iYywkRwXfPIhmGHHbiFoo0dhX7D5G8CcEyc4QUDB+cihP5wLhRyDndcGVgavAQLMpHk+IM+QATEGgWYR7MM5+TUqfvoaGp2fqICm/OGTbMjutJITTw0dN9S9v3wBzWdn3X6vPMuX2jHaSzFnueNICblzt+R21FiBv8qlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLTeJEWO4RTkpg84ea16Dz//7CVMtw5jPglp/NIhsIE=;
 b=UdCIUGpvFB3JVNOz6XXn3lhxqkUfjOHM3MmGR7IrqouHCLRbRM6cLZCHKULK+mfoYoJ96JrDV91Q2lzHyb997uESdr8p2Yppxs7fOCDeCP4P1/ymUrldEGw0UvFVJLJsl14fopfQVXc1p994SIgwPGFEKklMLrx+kINPYi9atFU=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by IA1PR21MB3544.namprd21.prod.outlook.com (2603:10b6:208:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.4; Mon, 11 Jul
 2022 17:50:44 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::3dca:41a6:b47f:15f8]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::3dca:41a6:b47f:15f8%5]) with mapi id 15.20.5458.003; Mon, 11 Jul 2022
 17:50:44 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Shradha Gupta <shradhagupta@microsoft.com>,
        Praveen Kumar <kumarpraveen@microsoft.com>
Subject: RE: [PATCH v3] Drivers: hv: vm_bus: Handle vmbus rescind calls after
 vmbus is suspended
Thread-Topic: [PATCH v3] Drivers: hv: vm_bus: Handle vmbus rescind calls after
 vmbus is suspended
Thread-Index: AQHYlNxab8YrKFdxe02s5L7O/5XspK15c4RQ
Date:   Mon, 11 Jul 2022 17:50:43 +0000
Message-ID: <PH0PR21MB3025AC6A419A5BB7B408DD20D7879@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220711041147.GA5569@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20220711041147.GA5569@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c19b6a6d-f0ed-4e40-95f9-7fcb0dc48090;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-07-11T17:49:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56c3fdb9-05c6-41f2-ba1f-08da6365e0ba
x-ms-traffictypediagnostic: IA1PR21MB3544:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ctSlEqtyfu21fbLz5LaKnKLPxR5GJ9IWTwl7MlsHjjkC1yE9sYeT8gRwJJIW8Zy5nzMQoE0k0rdHKG+Wn8GcS+cNOYPX3BgB25RqpbXO1c2Cy/SY0t7alLBO6zR8/k6X0g4fHv42kyd2MdC7sDL+f7/1gpvdsDz/ltMAPM5tfrRdEMujA3x5GCmdpdDOZMJiHoXmZO7CgD3SLIwjRayT/bojEakPL/mo/5xOsHKGTbPmzcpsmX3gNxQ/xMcu8UAgLSprP/3n9QOfqXR4aSZKferXCOAKt5B3HNUn9l3IKZAwZ97kmeH6yKo3KxyC58HS1hinA1gCapRFPzXltRIOVbwwuS7Dt8Ro8tZzp2Ov9+JodIYYqYyDt/WLlCQWtxW1/SXTTKBJiQSNmBuwoNB5NuLLtGNK4+RDaPUKttV0HgmFpjWVSjGO25NFZuPH6siSjk8OqqNniaDV8aXQzmYdmMtAnuwW3LAIbbiu6pn2txEyXwmFnJLMrMFkcMd7yYx8vJLt5881UwOYSBc1cYzOXeAXczYTrcxcp63P6J/mWphdarMK9yqX1fSPCrHQ+bkBLbzYITuz0J3amXy7dvTN/AYW/gZNX35mEnYKvgWuqeEWhc+EtVHfEiYpung4z+pG7jWzkbIPmSIjoLlj0XPufDmBXnAMG5DjJnEVLiiUJas09DW5OSJdWZbuWEi/MHvTpgXgvWju/DaiBHSbgBVtcohrj+l3Q5aK5CLieuOomT1wzOc3C0/WHhPt2nn+dQI3hgi9cQ6EunySkKY3j49PqFeQ/OWkbOUV5b861JZJ+1avt9L/CI+iPLKgR69sBhiy4VayRFRsyn4pOkrTWWmKnl9aMNSLvzFFIl57LR6Ot3U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199009)(38070700005)(71200400001)(82950400001)(82960400001)(76116006)(122000001)(478600001)(66476007)(66446008)(64756008)(8676002)(66556008)(4326008)(66946007)(83380400001)(110136005)(54906003)(10290500003)(316002)(186003)(86362001)(107886003)(41300700001)(38100700002)(9686003)(26005)(5660300002)(33656002)(8936002)(52536014)(8990500004)(55016003)(2906002)(15650500001)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xKoHFtinAvIvsdLqs5lDfyVxf7hnsZXA+/i6dy9HuMGbHKt3ltIfEymUTqqX?=
 =?us-ascii?Q?RAHENFOhz+phhYNP2nOdnloi+pIk9GBvkq93+JMcGKavhkKFl9pyL07wlLsR?=
 =?us-ascii?Q?1pvGkoqGEigqc/zQhyk2pRgqeMar5XP6ocUGoTWFJf1r7KdoGJGRG49XgN21?=
 =?us-ascii?Q?Vd8paIotabNekYeYJIoo/F3ls4+5NH7NTMpjJVxd48q0YWORG3nCWqM3wqW9?=
 =?us-ascii?Q?P7NIQed0YbUndus1GDTbwQet8PnkcEkMC3F8iQTF+Jq+rRFt7rx6dYb+wIce?=
 =?us-ascii?Q?ewQWk6qEPfDIL6BVizCqvnue273dfzGEy+khCKFPIkqeD1UlezNuT171/fa9?=
 =?us-ascii?Q?PPbScmPn/+dk7cU8pQKlMjKVyYH7cZdDNoyPcHb02bVLWy7a4nlsISbVkFKm?=
 =?us-ascii?Q?h4OdS5WTEgEZGt4XHYUlK26jWDTOlZWOD7PsfuBxb+72LvzS6wJ4341tmTIB?=
 =?us-ascii?Q?AmcXsoB5vedtJTzMjnY4bie3ggYaDgwxCsBwuVBdS/1F2T6MNGLSaanWKQqZ?=
 =?us-ascii?Q?L93Ns5WYmylrdA6Ngsp3AjW1+4Di53FFKHaTavLEsRhF44xj0hbOxK72k+J3?=
 =?us-ascii?Q?0PI4IT8PywEghx3bY9NxrKtR1L/52WS2p0IAWpU8iZASCMY0O4dokmQE8q2I?=
 =?us-ascii?Q?pqsSRnWLpnceT51Y1BIDFI9z1FClkBRc2QrklmvxtKfqJvCRVFuKmo9XBPXY?=
 =?us-ascii?Q?d5hjjYejibrhaV3GUHlTpzfSCPYX8b0TH2YOqD96QcPHG9O5warV29KndJo3?=
 =?us-ascii?Q?IQdvDAxzlG7942wLVASdVphYCN6i2z3yhehXUqZZkQx0w61Rw2v98Io2oJUW?=
 =?us-ascii?Q?hO9wYcs28nirlLBnBr9sSVbtq7jeB1d+qrKPhrYnD2trwKWfsiBGufu2OuK4?=
 =?us-ascii?Q?iEcxE86kiuRCQ9O8aaTPv7ioIqOMQHh7OvXzKPG6xIb+jmOe4XezNZ1KqFdk?=
 =?us-ascii?Q?/5XF5C9RITkAEQdmLHSCzVqMRZhChBNAo4m9Y4IOViJcn5w8K0S60K23hY0k?=
 =?us-ascii?Q?zPrhnM0cuO3mjpzNz/ISTl2nQE0lSwOuNMrqnHoZbEdGc7R9A5pTHytgm/8i?=
 =?us-ascii?Q?MSTPtNrm6lPKhD1MPiFoy9a8kbNtCiWqis7jd58/LcunqSRjY1aQ0/zxa503?=
 =?us-ascii?Q?WCdt/1itxS4MOnANO94kYUl7z7LBRjb4F/2qQd90DJ3jLfLgRKUZLUFqNdUt?=
 =?us-ascii?Q?kgopAqGxcRi6e5p5zJ7fZgHZD+CMySmEEV2xYaJvkP3XCMS75139x8OVA/+u?=
 =?us-ascii?Q?H8v8pAOy7Zcj8HpA30CCdlzey3Pma/Izxj1IA/t1wueEgn1WNrLCEo5woz5r?=
 =?us-ascii?Q?zpKnfiYKN4f2WX4afNWRhc82t69r5Vkm+lFmRIbmGnoMgOzXaBsnec/ZF8pI?=
 =?us-ascii?Q?CGA1b/CGoVtONAN5uXi8C7xlW0mSy1pNLfeQShqLKvX+HTkxCC+HsoTJFp8D?=
 =?us-ascii?Q?dCEz+A3qw9MWlRBG1zl0P3EcGaYfuxHM6Sw0KeaFCGMrZrmqG0FNIwEdfntl?=
 =?us-ascii?Q?hwLdPNwVYpEjYCQzV6rjYC7+26tNlNcjBm9IWpenJzy5YphOMaI6aWT6en5/?=
 =?us-ascii?Q?LMZlfUBADE3Vty/+Xz44OpZRp400j5//h8rF5tJYzPbU95tsdbXU0JT/DeaA?=
 =?us-ascii?Q?dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c3fdb9-05c6-41f2-ba1f-08da6365e0ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 17:50:43.9214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tYHno6tqyzYNXjUaFQX2yaARPrqaSdrVM7HzTCrGLysyT+Pi4ruI1WFPnzNChiyLM2jU8nNd/1KEdIPWZ9Lg0+TFgpzHfmfk7BrjhvgFuG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3544
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Shradha Gupta <shradhagupta@linux.microsoft.com> Sent: Sunday, July 1=
0, 2022 9:12 PM
>=20
> Add a flag to indicate that the vmbus is suspended so we should ignore
> any offer message. Add a new work_queue for rescind msg, so we could drai=
n
> it along with other offer work_queues upon suspension.
> It was observed that in some hibernation related scenario testing, after
> vmbus_bus_suspend() we get rescind offer message for the vmbus. This woul=
d
> lead to processing of a rescind message for a channel that has already be=
en
> suspended.
>=20
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>=20
> Changes in v3:
> * Remove unused variable hv_cpu from vmbus_bus_resume() call
>=20
> ---
>  drivers/hv/connection.c   | 11 +++++++++++
>  drivers/hv/hyperv_vmbus.h |  7 +++++++
>  drivers/hv/vmbus_drv.c    | 27 +++++++++++++++++++--------
>  3 files changed, 37 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 6218bbf6863a..eca7afd366d6 100644
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
> +	vmbus_connection.ignore_any_offer_msg =3D false;
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
> index 4f5b824b16cf..dc673edf053c 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -261,6 +261,13 @@ struct vmbus_connection {
>  	struct workqueue_struct *work_queue;
>  	struct workqueue_struct *handle_primary_chan_wq;
>  	struct workqueue_struct *handle_sub_chan_wq;
> +	struct workqueue_struct *rescind_work_queue;
> +
> +	/*
> +	 * On suspension of the vmbus, the accumulated offer messages
> +	 * must be dropped.
> +	 */
> +	bool ignore_any_offer_msg;
>=20
>  	/*
>  	 * The number of sub-channels and hv_sock channels that should be
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 547ae334e5cd..23c680d1a0f5 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1160,7 +1160,9 @@ void vmbus_on_msg_dpc(unsigned long data)
>  			 * work queue: the RESCIND handler can not start to
>  			 * run before the OFFER handler finishes.
>  			 */
> -			schedule_work(&ctx->work);
> +			if (vmbus_connection.ignore_any_offer_msg)
> +				break;
> +			queue_work(vmbus_connection.rescind_work_queue, &ctx->work);
>  			break;
>=20
>  		case CHANNELMSG_OFFERCHANNEL:
> @@ -1186,6 +1188,8 @@ void vmbus_on_msg_dpc(unsigned long data)
>  			 * to the CPUs which will execute the offer & rescind
>  			 * works by the time these works will start execution.
>  			 */
> +			if (vmbus_connection.ignore_any_offer_msg)
> +				break;
>  			atomic_inc(&vmbus_connection.offer_in_progress);
>  			fallthrough;
>=20
> @@ -2446,15 +2450,20 @@ static int vmbus_acpi_add(struct acpi_device *dev=
ice)
>  #ifdef CONFIG_PM_SLEEP
>  static int vmbus_bus_suspend(struct device *dev)
>  {
> +	struct hv_per_cpu_context *hv_cpu =3D per_cpu_ptr(
> +			hv_context.cpu_context, VMBUS_CONNECT_CPU);
>  	struct vmbus_channel *channel, *sc;
>=20
> -	while (atomic_read(&vmbus_connection.offer_in_progress) !=3D 0) {
> -		/*
> -		 * We wait here until the completion of any channel
> -		 * offers that are currently in progress.
> -		 */
> -		usleep_range(1000, 2000);
> -	}
> +	tasklet_disable(&hv_cpu->msg_dpc);
> +	vmbus_connection.ignore_any_offer_msg =3D true;
> +	/* The tasklet_enable() takes care of providing a memory barrier */
> +	tasklet_enable(&hv_cpu->msg_dpc);
> +
> +	/* Drain all the workqueues as we are in suspend */
> +	drain_workqueue(vmbus_connection.rescind_work_queue);
> +	drain_workqueue(vmbus_connection.work_queue);
> +	drain_workqueue(vmbus_connection.handle_primary_chan_wq);
> +	drain_workqueue(vmbus_connection.handle_sub_chan_wq);
>=20
>  	mutex_lock(&vmbus_connection.channel_mutex);
>  	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
> @@ -2531,6 +2540,8 @@ static int vmbus_bus_resume(struct device *dev)
>  	size_t msgsize;
>  	int ret;
>=20
> +	vmbus_connection.ignore_any_offer_msg =3D false;
> +
>  	/*
>  	 * We only use the 'vmbus_proto_version', which was in use before
>  	 * hibernation, to re-negotiate with the host.
> --
> 2.17.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

