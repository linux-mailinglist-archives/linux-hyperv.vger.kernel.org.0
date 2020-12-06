Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271E62D0687
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Dec 2020 19:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgLFSlL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 6 Dec 2020 13:41:11 -0500
Received: from mail-dm6nam10on2122.outbound.protection.outlook.com ([40.107.93.122]:36000
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726641AbgLFSlK (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 6 Dec 2020 13:41:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dohrLoSAsynPpbaZfWsAVExwid2rLNeF9QHyXB0ChFZTSXb5PaLtfug0m/aIG27aUSJvdHXaZh3VTDgF/76TiRisnxSCvKrHAfVyh8+pYJg3bIXw03rYk3XIPAsbfZaSYXTWrlKJwNIKxgygxRJmlfllOpq/8LSmXR8U0uk3bSYcY6mAPKVhCHr4x2hqghxPH6WgmxOzWoE65aeeNpceolHHn69Lyvh8eL7zV8GiiCixh+alAvq4dQEV5Bv1H7FsQdA6fQpAq/0Tgkasvf7X0bjmTkmjEYqet1SJBP0vsCvo2WVlfPomXRhfO3EBw+cfd5jSsvv9/IbD58OtEfUbGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpvWnmYboq1+6Xfs/i03LgiWa5CJaZCNVHDLSdvMlXI=;
 b=c+U3sg4LOd5SWrHQ0NkSQBQxnTU7b1YOY4Qwp8KQhsNUvet09X9un4ypT5lT1PGYZRG9FBY20eCkI+XCCwmA92z0qdGl6CYFuGyZjGH8n8SLMPKc5Hne6iNeWj7XEk0mUz5d3aTNpPemvjDVWsZYUxvjrCFD0F1eo7jDi1E51zNsZ9Vj9TdcwTm6X+fzqPEvoDowwIuhuP2P4XdUKuu/96XQ4ZX6dSCnvAlkKrlUqUz34iGITM3B6nAjAhbY6Xk4ngwIpaQC0hBnnSJr7f9kt/EdVFR/BStrSjsviekzJKbWuaeqnlw4nGKwrUleOfoARR/i+aCSr4BhhIc2mnghqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpvWnmYboq1+6Xfs/i03LgiWa5CJaZCNVHDLSdvMlXI=;
 b=L0snOXXENqsDrMuLFEXLcqmQL2l4Ti0zeANluMKRmqtHgtL6atBBF3Ix3UW4gwWj/GLt/jEulioqnNE7rZvIDiz2JYeKDAfj/NMjCuZK52mHdHLZKrrjEo13WporDTIOdQRlF6AEoIPGZV98mQQnARfr/BSQA6faMpr3HmzKc6I=
Received: from (2603:10b6:302:a::16) by
 MW2PR2101MB1836.namprd21.prod.outlook.com (2603:10b6:302:f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.2; Sun, 6 Dec
 2020 18:39:39 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%8]) with mapi id 15.20.3654.005; Sun, 6 Dec 2020
 18:39:39 +0000
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
Subject: RE: [PATCH v2 4/7] Drivers: hv: vmbus: Copy the hv_message object in
 vmbus_on_msg_dpc()
Thread-Topic: [PATCH v2 4/7] Drivers: hv: vmbus: Copy the hv_message object in
 vmbus_on_msg_dpc()
Thread-Index: AQHWyIyzBp8WUnf7xU2QwOpMCK6++6nqZmDQ
Date:   Sun, 6 Dec 2020 18:39:39 +0000
Message-ID: <MW2PR2101MB105225FDDE123AE3A852C665D7CF1@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201202092214.13520-1-parri.andrea@gmail.com>
 <20201202092214.13520-5-parri.andrea@gmail.com>
In-Reply-To: <20201202092214.13520-5-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-06T18:39:37Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=faab947e-5274-4130-917e-9ca658f28973;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 89c65d83-1234-49ad-9657-08d89a164a27
x-ms-traffictypediagnostic: MW2PR2101MB1836:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1836BFCF468CB3028FDFFD54D7CF1@MW2PR2101MB1836.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fVqYV3TUG+IFKimrGKqZBzGqzQhqFqlNxDR8jRdQ3aBwCcQfu8QF9aB5+WZczQ3/avTJ0Q4iRhLwIDXVmQRTxvq+ILvWd2iVpRabkoQoKykKY7uHT+P+OAYeYJ6zaV0spMe6QJkdwOPHgFV26Zd4yhWS+hx3RZ53bfK72ASphT0dOsUN7iX10NsQ5RePMZVhnLb3cLRNWH5yo2ezk2841aqhg3nO8JrJOdjOCP320o8WF/7ibqW8ID9UjnzgpMipBo0GK5Q/P+uefZaRClEdV5U1TMgywsYkAlo9zpRE3z12b0QsYNQa1YsSOzU/J9AZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(86362001)(26005)(71200400001)(10290500003)(9686003)(66476007)(64756008)(66446008)(66556008)(33656002)(186003)(54906003)(8676002)(8936002)(316002)(110136005)(66946007)(83380400001)(6506007)(7696005)(2906002)(4326008)(8990500004)(55016002)(52536014)(76116006)(107886003)(5660300002)(82960400001)(478600001)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?N5FxJaOk8h/zU7oCxbmAYllRHonrU3Pvo3qoIFZzTDyyB0qOoVX51bC58ko7?=
 =?us-ascii?Q?n1HHDamvHzOncXK4cwRAW9w7NaniR1OasIVAt9u/966ChqRL5/aNSK4Jzcj2?=
 =?us-ascii?Q?Q9JnxkrCSYq2kKN7U9JPhliD9QtmlKoqzR/wlk+Jegay3BaYC7HdyIEkcySz?=
 =?us-ascii?Q?b2IYDgGVI37cLly9hfM4V70Mw27dFBYlb1CBMPpPAFEELESaF+JLPQ6Wm10m?=
 =?us-ascii?Q?giCdZ1LKi2STejAZh9y8AQu30zGYUOoslzbitjkMLrcIsuPAjcRhvab/MacN?=
 =?us-ascii?Q?cMHzbNs82Egs61f4TIeLaHxkNs2P8fXFEm/LBjNjrfDT05SrVTFwVoTd/S04?=
 =?us-ascii?Q?uYMsHD/PcixPZ8XGdpnO8r/tT8VrCxRnGojn93Vab8bhA1/Wer+wA/QW5iSG?=
 =?us-ascii?Q?1vUFAEV9oiV/L8YgM0wdShZOq/zWSwjq4VXqycH+5K5YIsLfSO5DsCYrcx/8?=
 =?us-ascii?Q?TILrGWyKJEoOJuG/jvtPOIIGGsVsbXYz6nK7ES540TbWsva/cZ62fFR+iGUE?=
 =?us-ascii?Q?/ZO/Jsip8XD9UHoLmqJtiOYXCIgLSxmn16cUwT1BVPPc1ZUuCcSilbL1H2JP?=
 =?us-ascii?Q?qwzTPfcsFQZpZ3HmjcKy2IpcBkK2dnamNOBqCGpvJ2KZ6sy0djejvsjMPCcp?=
 =?us-ascii?Q?xeaIvraayCXaQNoCiR2sqKdsFVybnLS+o9ja8QoPRrsTiE1ZpUrOvmRqIfrX?=
 =?us-ascii?Q?0y8lYvtzfcQGvyrUtIO/NvSZRmpQfgY1kbnb3PezZQLkeekh4UrtKOseK8bo?=
 =?us-ascii?Q?BmqvC+p4X3weWKDi62kwY2+/iXKOabJ848O9ENAHxo9FAAkeq1sDDe4XUeQH?=
 =?us-ascii?Q?7xrGQjT149ZtnvO8rTEwinlTfcQ1MceB0byQyL+rUtkXouLqejUZ/OmvTs6v?=
 =?us-ascii?Q?ZRLcmS4CtpulZt4ZzPr0ue8S1frvQEUhg5LURsQ0ZQNFe1+je9M2ra7Cbzyb?=
 =?us-ascii?Q?OYmZVBviS9VKAcjx4LtKwLW6PmhFd2yTI2h/ao+MhvQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c65d83-1234-49ad-9657-08d89a164a27
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2020 18:39:39.5832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /NrC7ZOHwAax9fos3zbRKGZtw5XvfC9FI73PwmipbMxtZngL8sP+vqknxCdk2VPkIFXFiKUCbr5bPEm7ymKhgdclOOW0XEYw4jHsVsYB7eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1836
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, De=
cember 2, 2020 1:22 AM
>=20
> The hv_message object is in memory shared with the host.  To prevent
> an erroneous or a malicious host from 'corrupting' such object, copy
> the object into private memory.

Sorry for reviewing the older version of this patch series. :-(

To me, adding this patch to the series introduces some motivational
inconsistencies.  The top level problem is that Hyper-V could change the
message while it is sitting in memory shared between the guest and host.
Patches 2 and 3 of this series guard against that problem, at least for=20
the msgtype in the payload (Patch 2) and the payload_size in the header
(Patch 3).  While a copy of the message is made for the VMHT_BLOCKING
case, in the other cases where the message_handler is invoked directly,
the message handler may have its own double-fetch problems.  Rather than
try to fix all double-fetch problems scattered throughout the message_handl=
ers,
it's easier to make a local copy of the entire messages here at the start
of vmbus_on_msg_dpc.  This code is not performance sensitive, so
making the copy is a lot safer in the long run.  Hence I'm good with adding
this Patch 4 as the best solution.  Perhaps the commit message should
reflect that the copy is being made not just to ensure vmbus_on_msg_dpc()
is correct, but also to ensure that individual message_handlers don't have
to deal with the problem.

But if we're going to just make a copy at the start and use the copy for
everything, then the motivation for the changes in Patches 2 and 3 goes
away.  The double-fetch problem is solved entirely by Patch 4.  The
changes in Patches 2 and 3 *are* nice for simplifying the code, but
that's all.  The code simplification is still useful as prep to reduce the
number of references to "msg" that have to be changed to "msg_copy",
but the commit message should be changed to reflect that, rather than
to eliminate double fetches.

Having to make a second copy for the VMHT_BLOCKING case is a bit
distasteful, but I don't have a clever solution, and again, this code is
not performance sensitive.

Finally, I'll note that the call to vmbus_signal_eom() at the end of
vmbus_on_msg_dpc() cannot use the copy.  It has to update the
original message that is shared with Hyper-V.  Your patch is already
correct on that point.

Michael

>=20
> Suggested-by: Juan Vazquez <juvazq@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/vmbus_drv.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 0e39f1d6182e9..796202aa7f9b4 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1054,14 +1054,24 @@ void vmbus_on_msg_dpc(unsigned long data)
>  {
>  	struct hv_per_cpu_context *hv_cpu =3D (void *)data;
>  	void *page_addr =3D hv_cpu->synic_message_page;
> -	struct hv_message *msg =3D (struct hv_message *)page_addr +
> +	struct hv_message msg_copy, *msg =3D (struct hv_message *)page_addr +
>  				  VMBUS_MESSAGE_SINT;
> -	__u8 payload_size =3D msg->header.payload_size;
>  	struct vmbus_channel_message_header *hdr;
>  	enum vmbus_channel_message_type msgtype;
>  	const struct vmbus_channel_message_table_entry *entry;
>  	struct onmessage_work_context *ctx;
> -	u32 message_type =3D msg->header.message_type;
> +	__u8 payload_size;
> +	u32 message_type;
> +
> +	/*
> +	 * The hv_message object is in memory shared with the host.  Prevent an
> +	 * erroneous or malicious host from 'corrupting' such object by copying
> +	 * the object to private memory.
> +	 */
> +	memcpy(&msg_copy, msg, sizeof(struct hv_message));
> +
> +	payload_size =3D msg_copy.header.payload_size;
> +	message_type =3D msg_copy.header.message_type;
>=20
>  	/*
>  	 * 'enum vmbus_channel_message_type' is supposed to always be 'u32' as
> @@ -1074,13 +1084,7 @@ void vmbus_on_msg_dpc(unsigned long data)
>  		/* no msg */
>  		return;
>=20
> -	/*
> -	 * The hv_message object is in memory shared with the host.  The host
> -	 * could erroneously or maliciously modify such object.  Make sure to
> -	 * validate its fields and avoid double fetches whenever feasible.
> -	 */
> -
> -	hdr =3D (struct vmbus_channel_message_header *)msg->u.payload;
> +	hdr =3D (struct vmbus_channel_message_header *)msg_copy.u.payload;
>  	msgtype =3D hdr->msgtype;
>=20
>  	trace_vmbus_on_msg_dpc(hdr);
> @@ -1111,7 +1115,7 @@ void vmbus_on_msg_dpc(unsigned long data)
>  			return;
>=20
>  		INIT_WORK(&ctx->work, vmbus_onmessage_work);
> -		memcpy(&ctx->msg, msg, sizeof(msg->header) + payload_size);
> +		memcpy(&ctx->msg, &msg_copy, sizeof(msg_copy.header) +
> payload_size);
>=20
>  		/*
>  		 * The host can generate a rescind message while we
> --
> 2.25.1

