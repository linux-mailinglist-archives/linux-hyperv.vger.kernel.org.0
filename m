Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AC92D48F3
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Dec 2020 19:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgLIS1G (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Dec 2020 13:27:06 -0500
Received: from mail-dm6nam12on2100.outbound.protection.outlook.com ([40.107.243.100]:35681
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726471AbgLIS1G (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Dec 2020 13:27:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8+UML+GMVYcy1g6dz70UtrI4Dc6XfPjd2mZ/CbIVzLz/C8PFO9FF4DFLqNpKegSsDA+v0hiDqI6ojmqk2ZifIYJRQDbZvOGtTKQc1IVJmuFSXks+ChnzQ4RWnmrROMoenpG+9du9itOtjDmKVQwRUlsIIVBNVtjt7vCKz34UuHZGnZ3F5nUaR6AOASHPeOtB+3MTnkjIisAtn4tISGHQfyYCsuj0g1il9SLpA1FBp08BIZu7D7aUFTIqvOujObhljpC75d6ghJdHvWr/qbd0SWSPkyiJ+EbQUMui7DLAwbm6j5BVjWwAebj6CUNZjrBZQ41Pu94dnAXYEFZrzuetg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gy0lTWkfiqqNdLRiUGm3OUk12KvgmdIaHLBw5dBubCs=;
 b=NfTZUPn6yzIO5yWj8tio+lDVtp09rPGc1gN9L+VSwkxW4Sa6d113VJXtjCbUFEDDk4TQx4284HfElSh4GEUUe2NU7q94RocS08u0hcjKPvhs4fIGv6GDPtYohjn4wa7nHvUhsQjIqaAn/b2lDqbEdUwI5nJwRpUu9DMcjOV+oa8LKKVtqgBFh/qJwk9Ml3GXRfhS71WAoXYPY5mmLApozMHEbClODaJYyX0tHAW7PmHoR4ScQ6waVNIUOwjYRggMGJd6LvkSnlDK5avyvBnWPuGQsyck6BNUMJ/tiZK7/CY4pVN20P2Py+wqguNsyDu2km/2/+rfO3gLc5OY15MbZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gy0lTWkfiqqNdLRiUGm3OUk12KvgmdIaHLBw5dBubCs=;
 b=CPLUSoN5+Rn4G6B+OEyy1BW4A2r785/o+RRc7XztSrcQ76LlCPSri/Q1kBscdSqtNDHQiP4EyMJP1Wt0ftrHod1Xyp3q6KH0ERngLc7Miey1vrmZiuZEYHHw27wL/YsAIgvyc9sz5SBEm2m2rtl/snQwXzEY/8BTaiwVC2RunsU=
Received: from (2603:10b6:805:6::17) by
 SN6PR2101MB1344.namprd21.prod.outlook.com (2603:10b6:805:107::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.2; Wed, 9 Dec
 2020 18:26:18 +0000
Received: from SN6PR2101MB1056.namprd21.prod.outlook.com
 ([fe80::901:94fd:4c64:2ccf]) by SN6PR2101MB1056.namprd21.prod.outlook.com
 ([fe80::901:94fd:4c64:2ccf%9]) with mapi id 15.20.3654.012; Wed, 9 Dec 2020
 18:26:17 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>
Subject: RE: [PATCH v3 2/6] Drivers: hv: vmbus: Reduce number of references to
 message in vmbus_on_msg_dpc()
Thread-Topic: [PATCH v3 2/6] Drivers: hv: vmbus: Reduce number of references
 to message in vmbus_on_msg_dpc()
Thread-Index: AQHWzfo4sGGPq6PipkCLT/j3XX4tuanvFXgw
Date:   Wed, 9 Dec 2020 18:26:17 +0000
Message-ID: <SN6PR2101MB1056FAB4DDB8DC976D014BDAD7CC1@SN6PR2101MB1056.namprd21.prod.outlook.com>
References: <20201209070827.29335-1-parri.andrea@gmail.com>
 <20201209070827.29335-3-parri.andrea@gmail.com>
In-Reply-To: <20201209070827.29335-3-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-09T18:26:15Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9119c6ad-2bc3-42b2-80fd-571441cfe373;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 271721af-542c-4d88-cbc1-08d89c6feb6a
x-ms-traffictypediagnostic: SN6PR2101MB1344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB13447351CB635C8D94C12AC0D7CC1@SN6PR2101MB1344.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oC7v2gv3xfP3ZvVaVHCwVwdYlaUbtViavdj4iCXCwtextmWrvhSMvuPE1mqi4oKSl9781AZcMDwR05sSlXWIJb+JE7SZG6qMhysnzeUO9ltDv9QofwcDd3dIOaI0aHahm6HKOBbxpnX9diXZ6mQ6HwNV7n/fMbnzFF2s76JCTdEmb0r7xb9yGuNpfd+X9ZMlK3R+xijM4c0cCZ8EUIIZmrQAIG2Vamo+CdMST4VoXkLclzlWJXLpzxGKP76JsLEsqWx0ldCcpOxV2xg4CVNnxGTtt8EVzURVFozU6YNX3PS8+/RsD7tz8gxWki5RX12e15o/9OYjBMpU/cHPquoT9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1056.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(2906002)(8990500004)(15650500001)(107886003)(4326008)(8676002)(8936002)(33656002)(82960400001)(83380400001)(86362001)(82950400001)(9686003)(508600001)(186003)(110136005)(54906003)(55016002)(7696005)(6506007)(66946007)(10290500003)(76116006)(26005)(5660300002)(66476007)(52536014)(66556008)(64756008)(66446008)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?c6WwEIppx70SJ0agaTOA9tN9wx0jOCynhATGpFshT1i6aFj+MLXn3thBWq2c?=
 =?us-ascii?Q?5ACZPGulvAdGxGcfh9eihuOOUxccuVav9hfSU2LsivEtYqePnahxZx2V2em4?=
 =?us-ascii?Q?xvFUGd5X1VmT49nzZS9/U1osAhn8wVuRzQXjKFO2cgracLELGyPXfFUzd9yy?=
 =?us-ascii?Q?CqyWCSeI10ynaajNGeh+2x3/xue1d7Gp6zmOXdBn+Du3oIyeOcftdMp1jIR5?=
 =?us-ascii?Q?qTRERZ6+tbxfPPA98ovaXbadJHeMVyQHNFndx0JpJ4F9Z6kH0W1bj40ndiBu?=
 =?us-ascii?Q?f9FUpyfE6zbU+aJmVX36aFVSHrJ8kp3avE5mQ0JjYW4QRlSvMtGJj7tBG0Us?=
 =?us-ascii?Q?nSAizNkq2cxDRGBdWaEMxdvNKcPR7qeqH7y+nFCbR9TEdEqNFyhbC1fPoCyo?=
 =?us-ascii?Q?pajEYfDy23eWFICJBoYoDJGBzVGqZRceAja3rExw4xyjcVA3pvBBzFykuPvv?=
 =?us-ascii?Q?z094E0ht/UOZuV8QyDCp6aXwO6QNSwlbGqc/95limtU8daVmeDogcV/M3wrd?=
 =?us-ascii?Q?S7HYfo797ZV+xcwAUJ0bOpKF9vLS0ufEDjyM46I1AOAx4gyAWLcQpNJpcPI4?=
 =?us-ascii?Q?kGiyFME9TMU+4kXlhTeBovJeO2aPBPRakEw1kLgdVaTPhXN6BguhXt6zxQfM?=
 =?us-ascii?Q?yYNBTKg7MHaQW+xuCb54OiBbJI0RA3bkU8nyRHV1co3vSqIObTH0EKJ4XDXA?=
 =?us-ascii?Q?1uWzdiRmzvspIcV2FlCmmrd3SRQlyoh+cOAMLzoeXGkYSLLOuDwhi6Ahc0LK?=
 =?us-ascii?Q?gzyBMvO6MteilLQMCiFZd7JwIy3W6vMmWabrLVCf3SoWQRq27e4+z0x2f2OP?=
 =?us-ascii?Q?DH7s59ibXjBfr7d+fCiplgYzayLh1CB6dzc7MVv8hvw/UWGncyojS1widKKS?=
 =?us-ascii?Q?ghwJyEOjxrex7e1D1o0nTAM5Uc9dufIuArmXCwUCNa4Xb8/a/Za776Vj9Uaz?=
 =?us-ascii?Q?QTzBS9ysmHIyq6ZKnLZVSepzYxKthouOcY5olK1D9jo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1056.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271721af-542c-4d88-cbc1-08d89c6feb6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 18:26:17.6163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1gExAnuhWDnOba1w1g0BnqknuvJjHOcDAPpTJ0MzolR4/Z/nzUzx0GLZjLF/OqiaIDjnLHiolCtU2GlWxsGzVCIqL0q7P0MBHvls+LwFiIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1344
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Tuesday, Dece=
mber 8, 2020 11:08 PM
>=20
> Simplify the function by removing various references to the hv_message
> 'msg', introduce local variables 'msgtype' and 'payload_size'.
>=20
> Suggested-by: Juan Vazquez <juvazq@microsoft.com>
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
> Changes since v2:
>   - Squash patches #2 and #3
>   - Revisit commit message
>=20
>  drivers/hv/vmbus_drv.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 502f8cd95f6d4..44bcf9ccdaf5f 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1057,9 +1057,11 @@ void vmbus_on_msg_dpc(unsigned long data)
>  	struct hv_message *msg =3D (struct hv_message *)page_addr +
>  				  VMBUS_MESSAGE_SINT;
>  	struct vmbus_channel_message_header *hdr;
> +	enum vmbus_channel_message_type msgtype;
>  	const struct vmbus_channel_message_table_entry *entry;
>  	struct onmessage_work_context *ctx;
>  	u32 message_type =3D msg->header.message_type;
> +	__u8 payload_size;
>=20
>  	/*
>  	 * 'enum vmbus_channel_message_type' is supposed to always be 'u32' as
> @@ -1073,40 +1075,38 @@ void vmbus_on_msg_dpc(unsigned long data)
>  		return;
>=20
>  	hdr =3D (struct vmbus_channel_message_header *)msg->u.payload;
> +	msgtype =3D hdr->msgtype;
>=20
>  	trace_vmbus_on_msg_dpc(hdr);
>=20
> -	if (hdr->msgtype >=3D CHANNELMSG_COUNT) {
> -		WARN_ONCE(1, "unknown msgtype=3D%d\n", hdr->msgtype);
> +	if (msgtype >=3D CHANNELMSG_COUNT) {
> +		WARN_ONCE(1, "unknown msgtype=3D%d\n", msgtype);
>  		goto msg_handled;
>  	}
>=20
> -	if (msg->header.payload_size > HV_MESSAGE_PAYLOAD_BYTE_COUNT) {
> -		WARN_ONCE(1, "payload size is too large (%d)\n",
> -			  msg->header.payload_size);
> +	payload_size =3D msg->header.payload_size;
> +	if (payload_size > HV_MESSAGE_PAYLOAD_BYTE_COUNT) {
> +		WARN_ONCE(1, "payload size is too large (%d)\n", payload_size);
>  		goto msg_handled;
>  	}
>=20
> -	entry =3D &channel_message_table[hdr->msgtype];
> +	entry =3D &channel_message_table[msgtype];
>=20
>  	if (!entry->message_handler)
>  		goto msg_handled;
>=20
> -	if (msg->header.payload_size < entry->min_payload_len) {
> -		WARN_ONCE(1, "message too short: msgtype=3D%d len=3D%d\n",
> -			  hdr->msgtype, msg->header.payload_size);
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
> @@ -1115,7 +1115,7 @@ void vmbus_on_msg_dpc(unsigned long data)
>  		 * by offer_in_progress and by channel_mutex.  See also the
>  		 * inline comments in vmbus_onoffer_rescind().
>  		 */
> -		switch (hdr->msgtype) {
> +		switch (msgtype) {
>  		case CHANNELMSG_RESCIND_CHANNELOFFER:
>  			/*
>  			 * If we are handling the rescind message;
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

