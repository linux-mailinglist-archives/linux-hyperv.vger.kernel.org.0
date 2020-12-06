Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B032D0638
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Dec 2020 18:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgLFRPH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 6 Dec 2020 12:15:07 -0500
Received: from mail-dm6nam10on2119.outbound.protection.outlook.com ([40.107.93.119]:8192
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbgLFRPH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 6 Dec 2020 12:15:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAaKg8zFaAuq50/RBN+P2MXVsVrGrZlWHfG8x1Kq8CXA0bMiW3qH1/SC1l1JAi+GdBzT0vBdOCY3ztucZHhpTtF/dpech7lNnbHUS/VqLr11PiXhcDhHBxAfoXxkk11zgh/lnHBg+gnZogVFn+bFgRBx71STxS61VIrQvhiSHYg4x+9tMbCgIUcd1sDLTQEjh7OCgljBdm/T7Kl/k5nHvYXnML7NYsfiareL6lPqx+4+smDCPkP8m6Nx85hIT3eNAU3TndP6xCLiqWyAwYPBFLBB/IkaJNtKlB+4ZSI3WnYK5+wyq3Bq6TTP0zVhSVfcgnk7KTJXxRp+FiQunc6w2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9r9BnEKga8I/xIR8Tg93xX39b8ryfvESxF2BwO9xoM=;
 b=el5ezAjs+oNhteVTxczQpSI3oFMELVBR7BcDK4Y0ots0cY8qwMeN6kMQsdjND+S9E8Xaqcw7Dncs/4d+0mC+UF5nffMLaXDT42Vwq95g+tYLCK2CQGX9hH/vujqgshPdYngrwV9aR/yDmFS87BtpbDDRcncSRI3oXUqK13bojkZZK8LOmUBiNl5Vx+ieu8W1TMGjmHQCkbfC4TARIkn8zwCWLEevZLq6E9IQq1Od28w2CtEe9/j5nUcunfqiW7Nhsr0YLgCZOmuArW1Om77P+UPgp+zypj+iEYBjp81+2xjFpWVb2uCCoWGHbAAwF3BVum0Tam5gmZpvZw5zVe8dKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9r9BnEKga8I/xIR8Tg93xX39b8ryfvESxF2BwO9xoM=;
 b=IEinIRZY8yteZKlWJw11hDxNxnllcQgQNBGPdH02IHbxRjxjwrfMTjnFvD/779Zb1L9eqpUjU9z3dIMTCJSGnZJdz7vdkJYd6rfEaZT097rOfA9KW9TAiDStXuwWuppXWhPJUsCTPS01jRS1sU6aBCKzy0fX5Fnyy2i6BOtFY2c=
Received: from (2603:10b6:302:a::16) by
 MW2PR2101MB0889.namprd21.prod.outlook.com (2603:10b6:302:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.2; Sun, 6 Dec
 2020 17:14:19 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%8]) with mapi id 15.20.3654.005; Sun, 6 Dec 2020
 17:14:19 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>
Subject: RE: [PATCH 3/6] Drivers: hv: vmbus: Avoid double fetch of
 payload_size in vmbus_on_msg_dpc()
Thread-Topic: [PATCH 3/6] Drivers: hv: vmbus: Avoid double fetch of
 payload_size in vmbus_on_msg_dpc()
Thread-Index: AQHWvbhihoUWRx7T3UynAPxee94daanqak7w
Date:   Sun, 6 Dec 2020 17:14:18 +0000
Message-ID: <MW2PR2101MB1052C82219AB1CEDA949B4EAD7CF1@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201118143649.108465-1-parri.andrea@gmail.com>
 <20201118143649.108465-4-parri.andrea@gmail.com>
In-Reply-To: <20201118143649.108465-4-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-06T17:14:16Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ad9e405e-a518-47c9-9967-fa3e3a2e1a25;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d209bb85-fe4d-43c6-5ec6-08d89a0a5e0a
x-ms-traffictypediagnostic: MW2PR2101MB0889:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB0889BC1D353E59BFEFB84883D7CF1@MW2PR2101MB0889.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:510;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VlqRTTj8S+Vis9ziq91n7CuiFi1oKi0EtKq4HxzD/3ZdP7bBew4gesSpyeLr7BM6VatV9MvrMg6saA2uTXLMUEyMuVEqzKTAxqbneyNpq6mTVqiozpmCnQTkGxC8dK+F8mU1R+x3Vyyx0e84xCcHmKU8oFR0UYTs2+aeV5vlNkH4S2ekl4YVL5qXmcczBnOMHQBx9HSMJykJRuDtoh6bExsl8+ok4BQQ/Po5kx+Phuth10OnrJH3rz16PMBzyKfDpLEOCJCC0ob4s7+T567vkcn0xWkddCdCSnECreczm3oVynu844837NGziBOoXoHhdXy9IQUwr9swDfdMY1BDOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(86362001)(26005)(71200400001)(10290500003)(9686003)(66446008)(66556008)(33656002)(66476007)(64756008)(66946007)(186003)(7696005)(54906003)(8936002)(316002)(8676002)(83380400001)(110136005)(6506007)(4326008)(2906002)(8990500004)(82950400001)(55016002)(52536014)(76116006)(5660300002)(107886003)(478600001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FPo/NPlp1AwGJvNeUaknyYSenkEt/3do2Df9FTkcZ1bq/xHzJ6tjLhnP5SYU?=
 =?us-ascii?Q?xUhA+4Y2Lpj7yUY5rfXZCfvGMUgBAsW7wiOkz7fO01TXBn1tFP3Qo7vDB5Fy?=
 =?us-ascii?Q?NCLRP3y38SfGWJFHBzqIZ9vQVjqtQtPjwVCNi2sYCL0sF17Jvqux8eIMmctl?=
 =?us-ascii?Q?t+5SwutZvwHZ1rfaGIP1jqrJTa/nONvovwAcPLs8uUBXjmt15LlOUFii6mDw?=
 =?us-ascii?Q?CZt8ep7rNsyxhey5XppZ2CRiZkH6yseUBGwKIQxHnv+cq1QszSsa53rXzTjn?=
 =?us-ascii?Q?PPbhDkseThYXY2+Wl/aGYUpyK1d7rCWoGsHgXa/KFVpR1qNYphCgRBDlejhu?=
 =?us-ascii?Q?srj22g8SGnrM1zwosAa469BSQkpOp682ibbh69bzu7vnPk1cHjD78JNaXwqz?=
 =?us-ascii?Q?xQP3GRiOAiD0Q4R1x6D9ySLGcyGg+AJifyo4wx5AcqRJ2Mj5gcPYBhujwYJZ?=
 =?us-ascii?Q?9Ix/zCKQVxeW52sFyH/+BO4b8Pt7HzVITFXaYRELKc9xEYlTeS3AecH+1+Qo?=
 =?us-ascii?Q?VqRusv/PcrvD9/oAMyX2fz4Y1vEK3VFXeSX8Lb6f7hdlIkS42CKzd3iMtY+L?=
 =?us-ascii?Q?TrO4VbgGK+BzC1ARRPZau3Hvb2Pg4GogvsxYx395lj0RnSR7q+voJow4403q?=
 =?us-ascii?Q?goVeDY5JOj2MiVsXt2YwkQIudTUucFHlmOk/umVJzpnTjk0uBWMuNDRW1bEf?=
 =?us-ascii?Q?X9gxonp6lhXB3A0ZE18U+t9XrVBw7toOTm83nbHTA3wabspT9k4NsVxQCabm?=
 =?us-ascii?Q?FJPi6kcZ5HefGolMaW2Rx+P16REGSh0mvU5Q9hG76p07QpobrJJE4eJjLcr5?=
 =?us-ascii?Q?fkRULBj+Ho3LoVcMSImMxi1GihQJLUO3VFL0B2C/2ollWk3mR4g5ErjZ2eXN?=
 =?us-ascii?Q?LZIA5eJnm1O0bxSif/zB5i3nNdQ4HJUfHCOBvvSEVaixZdNuslmichJMFmzz?=
 =?us-ascii?Q?rTTY3w3PgDqFPUG6i347joUXiuMOep4d2I6DKIshJts=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d209bb85-fe4d-43c6-5ec6-08d89a0a5e0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2020 17:14:18.9834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNDjodI4ZkimvA5oaI7GvDBwVXADMhAXoD5RsEHmxdKXy55Y5nbfAJHBUCCSc53SZQrp5+r4Lwco/NdAw3/+MDQ9a/heVIZzX8h0dousyTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0889
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, No=
vember 18, 2020 6:37 AM
>=20
> vmbus_on_msg_dpc() double fetches from payload_size.  The double fetch
> can lead to a buffer overflow when (mem)copying the hv_message object.
> Avoid the double fetch by saving the value of payload_size into a local
> variable.

Similar comment here about providing some brief context in the commit
message on the problem that we are guarding against by removing the
double fetch.

I could see combining this patch with the previous one since the
motivation and pattern of the changes are exactly the same, just for
two different fields.

Michael

>=20
> Reported-by: Juan Vazquez <juvazq@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/vmbus_drv.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 82b23baa446d7..0e39f1d6182e9 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1056,6 +1056,7 @@ void vmbus_on_msg_dpc(unsigned long data)
>  	void *page_addr =3D hv_cpu->synic_message_page;
>  	struct hv_message *msg =3D (struct hv_message *)page_addr +
>  				  VMBUS_MESSAGE_SINT;
> +	__u8 payload_size =3D msg->header.payload_size;
>  	struct vmbus_channel_message_header *hdr;
>  	enum vmbus_channel_message_type msgtype;
>  	const struct vmbus_channel_message_table_entry *entry;
> @@ -1089,9 +1090,8 @@ void vmbus_on_msg_dpc(unsigned long data)
>  		goto msg_handled;
>  	}
>=20
> -	if (msg->header.payload_size > HV_MESSAGE_PAYLOAD_BYTE_COUNT) {
> -		WARN_ONCE(1, "payload size is too large (%d)\n",
> -			  msg->header.payload_size);
> +	if (payload_size > HV_MESSAGE_PAYLOAD_BYTE_COUNT) {
> +		WARN_ONCE(1, "payload size is too large (%d)\n", payload_size);
>  		goto msg_handled;
>  	}
>=20
> @@ -1100,21 +1100,18 @@ void vmbus_on_msg_dpc(unsigned long data)
>  	if (!entry->message_handler)
>  		goto msg_handled;
>=20
> -	if (msg->header.payload_size < entry->min_payload_len) {
> -		WARN_ONCE(1, "message too short: msgtype=3D%d len=3D%d\n",
> -			  msgtype, msg->header.payload_size);
> +	if (payload_size < entry->min_payload_len) {
> +		WARN_ONCE(1, "message too short: msgtype=3D%d len=3D%d\n", msgtype,
> payload_size);
>  		goto msg_handled;
>  	}
>=20
>  	if (entry->handler_type	=3D=3D VMHT_BLOCKING) {
> -		ctx =3D kmalloc(sizeof(*ctx) + msg->header.payload_size,
> -			      GFP_ATOMIC);
> +		ctx =3D kmalloc(sizeof(*ctx) + payload_size, GFP_ATOMIC);
>  		if (ctx =3D=3D NULL)
>  			return;
>=20
>  		INIT_WORK(&ctx->work, vmbus_onmessage_work);
> -		memcpy(&ctx->msg, msg, sizeof(msg->header) +
> -		       msg->header.payload_size);
> +		memcpy(&ctx->msg, msg, sizeof(msg->header) + payload_size);
>=20
>  		/*
>  		 * The host can generate a rescind message while we
> --
> 2.25.1

