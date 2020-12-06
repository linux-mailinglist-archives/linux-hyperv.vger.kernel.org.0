Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5592D0636
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Dec 2020 18:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgLFRLQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 6 Dec 2020 12:11:16 -0500
Received: from mail-dm6nam12on2118.outbound.protection.outlook.com ([40.107.243.118]:49537
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726981AbgLFRLP (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 6 Dec 2020 12:11:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bB8mELZlAeSDAI1N6fXnPy8v0bZomFHCrcMoblKYfQWyOjNvPFljAnSUdZh9cjcvN2vFKf3b6YrzPD2xOU9atr7B4fzWsZDtMUCDGk51/AA00Cjm/PYpl4Bd8RZHA6AO0HD3gjkhPYf3YJgOtuLHd12YoLWOcBmXUP3b8yDIQUoA8B3hXrxPYI0YUZWvmAPX8HnMQxWGJpE3akTCWK0BKuZGv5gt9QKqns1BntAaXLWMuQQ/WGgUvnwNCR8Ig7/WDTZ9M1upODnpKXYzUPekuBjUZrOG2k9e1v+rEQXF9DhNmQoU4wBMOK378dGPdtMSH8O0AKoNBX58mCzbztsLnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKqxYIvXGfvwETkxIZdkqahQ8YnCSepbbxG5kjH4EMQ=;
 b=XeETmBeuevk1pJsxtMp0lIbdvlwhspDRhe5pEe2ExOwLsiepzBbK+N+Vv7c5CMtJrxlosBaVCbbnfd/cbIQ1pxeFw14GR3MdTYWv/jQu1Va1epsaX6qvtMKKP/nkyNN04AS+mL+bEmx16kZUux93HnKsAsn8cuD79leZ3KrCdVRIsI+SvaG1m/vnVOMWMxuwRNgmEaPashdZ7Ow8lOH9LXapUvUIBTIHbfC+7gSPSq5bxh92OJ161/ojvx8R8mW20G1v74ecQ6Ogcj+BxgpD5dSXRi6lIhz9BSney7BGkJD6UuV42U+uNHzaxh2ZQ9b1mty3BXa/vvMfR2s85h4LDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKqxYIvXGfvwETkxIZdkqahQ8YnCSepbbxG5kjH4EMQ=;
 b=S3phlnfRu6sVNog2I5jUPhRltPmpTTwQ/lVWUpRcQLbTGso0I/S03rdj1JLsKUJK/m82S4ujlnhhbwSbnp0iYOxHsPWh4EQeblHBQqTaFP6ka6yIxOOl4eieT5G1Zn2x1u4ZZ76hoWzWCP7Sabxumdbk8HZ6Cm8ybEVVLYmV5+Q=
Received: from (2603:10b6:302:a::16) by
 MW2PR2101MB0889.namprd21.prod.outlook.com (2603:10b6:302:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.2; Sun, 6 Dec
 2020 17:10:26 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%8]) with mapi id 15.20.3654.005; Sun, 6 Dec 2020
 17:10:26 +0000
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
Subject: RE: [PATCH 2/6] Drivers: hv: vmbus: Avoid double fetch of msgtype in
 vmbus_on_msg_dpc()
Thread-Topic: [PATCH 2/6] Drivers: hv: vmbus: Avoid double fetch of msgtype in
 vmbus_on_msg_dpc()
Thread-Index: AQHWvbhgSbPBeytrDUOjzGJMSABUrqnqZ9JA
Date:   Sun, 6 Dec 2020 17:10:26 +0000
Message-ID: <MW2PR2101MB10528F278B1BD5FA060D7F5AD7CF1@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201118143649.108465-1-parri.andrea@gmail.com>
 <20201118143649.108465-3-parri.andrea@gmail.com>
In-Reply-To: <20201118143649.108465-3-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-06T17:10:24Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e74902a5-dfbd-4c74-81f6-1680dba05525;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e82df24b-150a-4d2c-83cc-08d89a09d3a0
x-ms-traffictypediagnostic: MW2PR2101MB0889:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB0889E787CEAF1C0764E19430D7CF1@MW2PR2101MB0889.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wd/mBJaRuY3zTrhipmbStrkz1eVHDQRJAoV3YzVmUsXpQTZ/xtsG7uHubC5bW+Cyp5+vmPhm/aHfpEbwj7I2PuC+GumaT8QOpv22NN4SwBQfSJiqP31Ok3+YRWpdcvmvA33IGcuslyLYwHdVt37HtXI80Cc6wN6/4wKihSl6joJS8cUzBR6Vj4l96Rwjq2Nx3utNTdPxjYiN3m6mhdBLd6RcD5gqZN/rkZR3EYmwq+4rYvPkzQIvDqiUNzMWaeX3xiUdOXSBRHBWnn9eS5GXl84OwC5RZyJ2VoAHD88CvFulHdi9DeUU/dcYScowyMYdk3oDHr1/pF/pK9S3g43Now==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(86362001)(26005)(71200400001)(10290500003)(9686003)(66446008)(66556008)(33656002)(66476007)(64756008)(66946007)(186003)(7696005)(54906003)(8936002)(316002)(8676002)(83380400001)(110136005)(6506007)(4326008)(2906002)(8990500004)(82950400001)(55016002)(52536014)(76116006)(5660300002)(107886003)(478600001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CvkVFeESDdmf2cBllnQK9E0VHOcJTmg2PKuSDY2DJ8Y2bI03LFngMRGxPmJI?=
 =?us-ascii?Q?a2pLB+bLVcCBvDeJB8OYbiZeSqtp1rUJL41cQ6B3SInWwsKGUEZ+b+OYBZWJ?=
 =?us-ascii?Q?uvswc+tTtXn9/w/eAvcrvMGz+spSV0xRmdM3M7ae/DL1yknpqtMtycrmWJNN?=
 =?us-ascii?Q?fiZfo1XiAF25PRcHyLtYCwQvOFfzrv3iPYAh4td9sRNddG9i/n/f6UUl2ow8?=
 =?us-ascii?Q?w37Hh/dOS2zQW2UWXONTeHerWQDAvrrhz1xODtMt1YTcYfnRoR7uGFTQJy/S?=
 =?us-ascii?Q?vkdphJ0lBfK2huZVftXkzigNSdyol6ywJu0wUJAEyBvl3l1ub49KAWZF+WpB?=
 =?us-ascii?Q?yErOH2xIx+LFzZreF+gZgeqsPPsy46az22Bxt6kQOLR62Lk368UfNRHhUmQH?=
 =?us-ascii?Q?3lP9yJ/GQyRzMlPwKi2BEZ2ZwQleIvC54NlZgZPFA6LzE/sWqkhAIgFvS6gj?=
 =?us-ascii?Q?2VWo2omwEgIQ7RCV40YjGDlYISYnaqmKGAoDLJXy/hqBydQEq0V+m7HwWryB?=
 =?us-ascii?Q?zPnZx5i2ESC1sih1/+5Ftu/1YDIxIFx5mo3vhxI8/5IWKoUr+g8lYsuAGxKo?=
 =?us-ascii?Q?0TSMPFQKexAWP3UUNvzak6RUWCsuI99gIkq2ixrotKOFadjmloNDQ7dW7qmN?=
 =?us-ascii?Q?xWw7YRK92qcSufUYvBAumSep3BlsKxh/GrW5mGttCyI6spkrplWaA1XBV8hz?=
 =?us-ascii?Q?sb1EUQL2YoJegVP7UNvAtUJMxXyKbjsen2PlCoEJmTmcDafZK/uhzyhlXzEY?=
 =?us-ascii?Q?jCKbnVqCQlj+Ipb2AHEk/THjo3kAtqZXicAGo1+sn6sXqveLMT34WSbB3JqQ?=
 =?us-ascii?Q?GJ6XI66FAQXozoOF8itoBPSTqcyG6OS20A+adfgDbByCC+hfLG93D7wa/imE?=
 =?us-ascii?Q?1ocTDGpQh4RVYOTZxM2MkC4BTKQaegamNIxhFdZT0LdQnGqqa6Xh4tB8TlDh?=
 =?us-ascii?Q?Ay9GOlp3FCC1wOnktl0+ZmJIzs6tR28borXLFYxTv7k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82df24b-150a-4d2c-83cc-08d89a09d3a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2020 17:10:26.6921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: euvG2R03ceZA4xRcWH7zGXyiDQZYPhZ1YHqu8/W0GFJJo7MyMRhILGxyWPJRXBqXxHgnD1mbyI8TUKClC8juUtqM2rz/JxqYa82th7FJwck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0889
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, No=
vember 18, 2020 6:37 AM
>=20
> vmbus_on_msg_dpc() double fetches from msgtype.  The double fetch can
> lead to an out-of-bound access when accessing the channel_message_table
> array.  In turn, the use of the out-of-bound entry could lead to code
> execution primitive (entry->message_handler()).  Avoid the double fetch
> by saving the value of msgtype into a local variable.

The commit message is missing some context.  Why is a double fetch a
problem?  The comments below in the code explain why, but the why
should also be briefly explained in the commit message.

>=20
> Reported-by: Juan Vazquez <juvazq@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/vmbus_drv.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 0a2711aa63a15..82b23baa446d7 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1057,6 +1057,7 @@ void vmbus_on_msg_dpc(unsigned long data)
>  	struct hv_message *msg =3D (struct hv_message *)page_addr +
>  				  VMBUS_MESSAGE_SINT;
>  	struct vmbus_channel_message_header *hdr;
> +	enum vmbus_channel_message_type msgtype;
>  	const struct vmbus_channel_message_table_entry *entry;
>  	struct onmessage_work_context *ctx;
>  	u32 message_type =3D msg->header.message_type;
> @@ -1072,12 +1073,19 @@ void vmbus_on_msg_dpc(unsigned long data)
>  		/* no msg */
>  		return;
>=20
> +	/*
> +	 * The hv_message object is in memory shared with the host.  The host
> +	 * could erroneously or maliciously modify such object.  Make sure to
> +	 * validate its fields and avoid double fetches whenever feasible.

The "when feasible" phrase sounds like not doing double fetches is optional=
 in
some circumstances.  But I think we always have to protect against modifica=
tion
of memory shared with the host.  So perhaps the comment should be more
precise.

> +	 */
> +
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
> @@ -1087,14 +1095,14 @@ void vmbus_on_msg_dpc(unsigned long data)
>  		goto msg_handled;
>  	}
>=20
> -	entry =3D &channel_message_table[hdr->msgtype];
> +	entry =3D &channel_message_table[msgtype];
>=20
>  	if (!entry->message_handler)
>  		goto msg_handled;
>=20
>  	if (msg->header.payload_size < entry->min_payload_len) {
>  		WARN_ONCE(1, "message too short: msgtype=3D%d len=3D%d\n",
> -			  hdr->msgtype, msg->header.payload_size);
> +			  msgtype, msg->header.payload_size);
>  		goto msg_handled;
>  	}
>=20
> @@ -1115,7 +1123,7 @@ void vmbus_on_msg_dpc(unsigned long data)
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

