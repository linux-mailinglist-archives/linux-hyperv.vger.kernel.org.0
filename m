Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5B452F3BC
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 May 2022 21:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352127AbiETTWl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 May 2022 15:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347963AbiETTWj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 May 2022 15:22:39 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020023.outbound.protection.outlook.com [52.101.61.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE7865411;
        Fri, 20 May 2022 12:22:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAN8gd66RoGp8bm7njdySRZFLkGzJxAB6pUdIrcbiySR6HAI1EoG3kfPuySAtQSy+WNn6yhn3Nbs0ZI8fbiFBDPdjbRZHn5+1KTBpYLGDfoffbkS4slLYSTOk7oIEBu9MJY4bTmKOycJIdz5s3Vp3wINiPcOFjFomHuGW2+T37EAqTeP8Q2CIJ/vioF+oqKJZ2LjAm83+4Pg2qp+tkdtKfm1Y3FRVS/14UhU89f4prwj7d86MKUx3ssLRcSjhDhlwDe+hexZmECMX8DIjPr6mkHUg/4AQt37sJMPPV0KZd9wVho8+3q8Ru7B2CWX5h/WC9+ihYrxSYDA4mLPDa1wog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8JQSeopD5Vacvn29vbbfJEn+MhqsYFl3TYFdRkallM=;
 b=T9l+X+B8yUdMn6NvrXbWcJAVT74VxNuysGFg/YNB8mGNBABUY2tuxFzWAI1BvyvX34/3t0KHgYMZWMalBPGWmjYKnX7MWFeH+qts7fXaRUg+ZNlui+SpwdyqFUSqYNgcB5L7piLosSC5LtECQ+PQm4P+R15T6YkP5RZmHFfLFVsnSV0dHeMVFqd98br3/RThpRDuEHUcb7IrmEeo8KINBMWz2r1Fl+qGVpsjJ/gjUCc0W7jUT2GkRXUt+GJPdQwqp8WaFe1I0LrycyuhZDLO0kzHq5vy3y4N4VsSjHYA9kwm7RjPiyXf5gWcpHf+sHwbxERAPurdxyEfmhZvLQEA2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8JQSeopD5Vacvn29vbbfJEn+MhqsYFl3TYFdRkallM=;
 b=aQt7K1m5aWRGlPoAIEN2e7Ag2aydu76pDv2PjTUvM5Z+LW+ijI9GfJ2bJCZJiSQDmBzq2GNarySHzB+IhzWqHLgfTpLhbf8GkKMxV7IbcMdqPfqTKjTk/Bx/rZd382B2UlsZv61B00TF3vSI7KzAuaSkQnMCW3O6GkLKtGkUtOs=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by MN2PR21MB1438.namprd21.prod.outlook.com (2603:10b6:208:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.8; Fri, 20 May
 2022 19:22:35 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::bdc5:cad:529a:4cdd]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::bdc5:cad:529a:4cdd%7]) with mapi id 15.20.5293.007; Fri, 20 May 2022
 19:22:35 +0000
From:   Long Li <longli@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: storvsc: Removing Pre Win8 related logic
Thread-Topic: [PATCH] scsi: storvsc: Removing Pre Win8 related logic
Thread-Index: AQHYaVtu6iPdAKkK5kWzN5rtSKpgta0oKY5A
Date:   Fri, 20 May 2022 19:22:35 +0000
Message-ID: <PH7PR21MB3263771C4EA7933604EB66E6CED39@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1652729430-12632-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1652729430-12632-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=76d7f655-1f7a-4f8c-b212-1f5bf1d153ff;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-20T19:16:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7c5eb06-94bd-4844-f0ac-08da3a96186d
x-ms-traffictypediagnostic: MN2PR21MB1438:EE_
x-microsoft-antispam-prvs: <MN2PR21MB143852B74FA0C64333FFDED0CED39@MN2PR21MB1438.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rW6cYpmJQd4+X+l8qJf6sdfySGK2MVdYX3gP3C9gVeYMOjNZc26PdwgTmVb4vMNbHcwOshHZoZVOJhq3eDZc4FSXuqFzwd/0Ds2hXsUu35rQmXOMMjN1aTWLIWoxMEmyVEFiaupUT94VgCjbbybsoSbPYUi2i7Z5yJrVeCJszOlRv/OG5xufE8uIYc0nqRlmSJTQ3y6fqMmE9jTwgmELBWnyWFdvZchPdG2gAUeDpekxkJ8xdalTOt1GNRGshy5bmPBGVWKf0xQ468fxtK/d8b3mmrxYxewGCi9ZKzZuj7HE+JMtoxpmCZ3cLeOI6xXZemGF/5N+6Giv8sJvFA0Iq6sm+C1UsBhE3VE+/r46H7KiJfisjTAJS8gXCluWFxNG8U9UsfdaZeUcCezH+Opg1W3q+9OyI8FOVGf0OIvf7lQpvWxrHVe3FzMwoBjujli8tNlm+2IHL3C8irpn2QvAEs+vDZiYp2FjF/oauZhFQDaDtpDHnpOUnJBBUSVs7SuvvXI4qi7Khg28k4nwzmsdZW1Rby40gT9HsfBrsi6WwKQf2WrvHHMGgIvW5MSKiuKHI776K+xUu/kISsB5Eas85kng3vldvGsepvia73LkKXfNxv80YOo4EH7P/RdoLI7hRRDqsV4vVtnATfcMB1tQ0/toPTaSw4N8+xgbn8+K/gJxbI3tneAp34DzL/OQTPT/orjn4LGvyZf9hckg4gDwr7/R0gDUFw9OSRE8rzKthbuQUhw7gWwACek/zBqKE63+hPQAJtRJSBR4IouhyR7L7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(71200400001)(66946007)(76116006)(122000001)(9686003)(66446008)(66476007)(64756008)(8676002)(66556008)(10290500003)(5660300002)(26005)(38100700002)(52536014)(86362001)(508600001)(7696005)(38070700005)(921005)(82960400001)(6506007)(8936002)(82950400001)(186003)(55016003)(83380400001)(316002)(8990500004)(110136005)(33656002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KXqkaKkVWMmov6FPpOi2t0eegKhnpFUn4p+Hgnftj2vhkOEw6KPofkR+Vtym?=
 =?us-ascii?Q?y/b35vR3MiKCLR6fwL8FYkYgRTNycKIYWXB7ocnAEMUTGO/HMecKkSragIu6?=
 =?us-ascii?Q?x4zQKgx+KtcpB/OQGBUO4GBRjv16OUAtFtnz1zIN17a44WYaeRcctCad9Fdg?=
 =?us-ascii?Q?wEZK6qpxlqu1pWTWbOj6NyZ6e8nfOSXu2tVnpoTyw+twrQx9iKXx3pCl9a5Y?=
 =?us-ascii?Q?DxoTURITr3CeaEyOF843TXC3qjOw4NOAUdv3HtBNIsNNjwxy9BCe+IgUT1oV?=
 =?us-ascii?Q?i81yPeKJlc1o5x1w+W1svVsbG7QUInHzf01ypNkIZyuQ8+kdZDEOwNET/xKv?=
 =?us-ascii?Q?RqprgLnQkLic+4AIr6Md0wYJW//V6vj6sC+8jLdPieXLoawbXitzAfSbv26g?=
 =?us-ascii?Q?/wnm3iQ4P2OGwk5QRpuPh0ntrgYxgoCGVvuWlYer1ymAUk96Q0kHuHthNz7d?=
 =?us-ascii?Q?qufpTebdIda/ccTN19RhxLTRspu1KbV/1KelTSIao8KHEA1j1uomVt+foLkf?=
 =?us-ascii?Q?M77SfH3ASQ+ZBeRSDVXB4P279KD3QJGmJwfsmbQs1tHr2l1tgd7CnSN5Px/4?=
 =?us-ascii?Q?1KErtQRQzURr95BRNyAAtnb4Mn2GmxZKNh9RRlrofSfAzuIKvFOEUlD4peOE?=
 =?us-ascii?Q?12PUVucFO1oiJo7sPXuAn7GF8EIk0uU60trzHnbgo3EnZj++eMZ33l+z74g5?=
 =?us-ascii?Q?9diEpz2/bWCsL+b5TzWH28Zaj3BVoAiLZiiP8VftDsUi9bUNXBwVp/R1Kol6?=
 =?us-ascii?Q?f/3l6JDoyvMHy8Hta9moK/mogDxiRQfne6o6ItP9zpGvx0oE0fRB0o1CY0Mq?=
 =?us-ascii?Q?dlctTMviCPhS0VlnlgTRLxWB4t1c+cNQohT1NxnA646xDBxVQ/ks40AZT/Bz?=
 =?us-ascii?Q?LCayywt9ekpTk+t24N/Yf8zAib+7DpyOjknpQNGTbn7ogy+cT7ulQtAySj5H?=
 =?us-ascii?Q?9/qoVxviWVwNAps+lzBoaC3pA1Fgg79wSneyfWKp6Cf1H6fqwEb8U4IAb+45?=
 =?us-ascii?Q?ZHDQFOlbvghlNcKXlVpqHgmFWdzRLFXvL81fn5fog7JPyQJ7BZ/tqK/SETvB?=
 =?us-ascii?Q?Ily2eKjQ1h/JgaJXd3cY05kNKtTlx2a/DrxCoZMYRtpolW8j025hfqZKpyBb?=
 =?us-ascii?Q?XAVd+FeRsEwcP+enxvK7tNsbuPigLBtCIjm3cYOnFVXnN5dJtJI9jIr+tSh3?=
 =?us-ascii?Q?3gxBo+E3W+i3c8Vpwj2N+KuhA98cR3LpVnoPHO1SJ80szqVaQeIkeKEQWCTB?=
 =?us-ascii?Q?J4d5/MgL87AIaS2isTL9jB5l98iDrPS48y0Ff1Q66Ayv1gKheDUT1PlV+MSJ?=
 =?us-ascii?Q?HejKROWdF+vDVIVaR8R8mtsIp0tZYvMmUJ1P1aCvdIpV4QN+wjHWeMg85K0s?=
 =?us-ascii?Q?D1K4IaV5rREQcwHd+Y5WIkTBajsYob5msBEEJt81STl7RR7yuY4IUo8QDnrR?=
 =?us-ascii?Q?ulfqWbOaw2UNkxXpdCqNtbwQFCcJbddrGX1H4wnrZg5RfayZWd+RVbFXz/zf?=
 =?us-ascii?Q?0/dBO2XIPrbVDBXVMBvUoOBf+OPOj2GJJ+fLmu5B2iSzHVVzLv+Zlp/05uWa?=
 =?us-ascii?Q?EVIzvjGLSLmbRdf6OKMu74ww3uRS7OIPmU8qt0AOa9JMF2ieMAosrBq7vo16?=
 =?us-ascii?Q?cMdDuZhCsS9uBTw17UdMzRz8eQ1rGlZgo5AmC7aBEwHNozsgTBXu/xs/xmQr?=
 =?us-ascii?Q?0iDFDgtF+O/bQw8HaVnq66Ke6lsap7VlWLl5/99v6nXnFAPhWRNu1Nbkn5Cc?=
 =?us-ascii?Q?td3EpnyMHQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c5eb06-94bd-4844-f0ac-08da3a96186d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 19:22:35.5610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vxqshTYGiiI0lA/Cs6jXGNhtz2KdA53zV+PMYe7X8Xx3gKVAZXtQjpFo498aMQlllxpfsSKO6Zbquam4oevlbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1438
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: [PATCH] scsi: storvsc: Removing Pre Win8 related logic
>=20
> The latest storvsc code has already removed the support for windows 7 and
> earlier. There is still some code logic reamining which is there to suppo=
rt pre
> Windows 8 OS. This patch removes these stale logic.
> This patch majorly does three things :
>=20
> 1. Removes vmscsi_size_delta and its logic, as the vmscsi_request struct =
is same
> for all the OS post windows 8 there is no need of delta.
> 2. Simplify sense_buffer_size logic, as there is single buffer size for a=
ll the post
> windows 8 OS.
> 3. Embed the vmscsi_win8_extension structure inside the vmscsi_request, a=
s
> there is no separate handling required for different OS.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 135 +++++++++----------------------------
>  1 file changed, 33 insertions(+), 102 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c inde=
x
> 5585e9d30bbf..1b7808e91f0b 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -137,18 +137,16 @@ struct hv_fc_wwn_packet {
>  #define STORVSC_MAX_CMD_LEN			0x10
>=20
>  #define POST_WIN7_STORVSC_SENSE_BUFFER_SIZE	0x14
> -#define PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE	0x12
>=20
>  #define STORVSC_SENSE_BUFFER_SIZE		0x14
>  #define STORVSC_MAX_BUF_LEN_WITH_PADDING	0x14
>=20
>  /*
> - * Sense buffer size changed in win8; have a run-time
> - * variable to track the size we should use.  This value will
> - * likely change during protocol negotiation but it is valid
> - * to start by assuming pre-Win8.
> + * Sense buffer size was differnt pre win8 but those OS are not
> + supported any
> + * more starting 5.19 kernel. This results in to supporting a single
> + value from
> + * win8 onwards.
>   */
> -static int sense_buffer_size =3D PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE;
> +static int sense_buffer_size =3D POST_WIN7_STORVSC_SENSE_BUFFER_SIZE;
>=20
>  /*
>   * The storage protocol version is determined during the
> @@ -177,18 +175,6 @@ do {
> 		\
>  		dev_warn(&(dev)->device, fmt, ##__VA_ARGS__);	\
>  } while (0)
>=20
> -struct vmscsi_win8_extension {
> -	/*
> -	 * The following were added in Windows 8
> -	 */
> -	u16 reserve;
> -	u8  queue_tag;
> -	u8  queue_action;
> -	u32 srb_flags;
> -	u32 time_out_value;
> -	u32 queue_sort_ey;
> -} __packed;
> -
>  struct vmscsi_request {
>  	u16 length;
>  	u8 srb_status;
> @@ -214,46 +200,23 @@ struct vmscsi_request {
>  	/*
>  	 * The following was added in win8.
>  	 */
> -	struct vmscsi_win8_extension win8_extension;
> +	u16 reserve;
> +	u8  queue_tag;
> +	u8  queue_action;
> +	u32 srb_flags;
> +	u32 time_out_value;
> +	u32 queue_sort_ey;
>=20
>  } __attribute((packed));
>=20
>  /*
> - * The list of storage protocols in order of preference.
> + * The list of windows version in order of preference.
>   */
> -struct vmstor_protocol {
> -	int protocol_version;
> -	int sense_buffer_size;
> -	int vmscsi_size_delta;
> -};
>=20
> -
> -static const struct vmstor_protocol vmstor_protocols[] =3D {
> -	{
> +static const int protocol_version[] =3D {
>  		VMSTOR_PROTO_VERSION_WIN10,
> -		POST_WIN7_STORVSC_SENSE_BUFFER_SIZE,
> -		0
> -	},
> -	{
>  		VMSTOR_PROTO_VERSION_WIN8_1,
> -		POST_WIN7_STORVSC_SENSE_BUFFER_SIZE,
> -		0
> -	},
> -	{
>  		VMSTOR_PROTO_VERSION_WIN8,
> -		POST_WIN7_STORVSC_SENSE_BUFFER_SIZE,
> -		0
> -	},
> -	{
> -		VMSTOR_PROTO_VERSION_WIN7,
> -		PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE,
> -		sizeof(struct vmscsi_win8_extension),
> -	},
> -	{
> -		VMSTOR_PROTO_VERSION_WIN6,
> -		PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE,
> -		sizeof(struct vmscsi_win8_extension),
> -	}
>  };
>=20
>=20
> @@ -409,9 +372,7 @@ static void storvsc_on_channel_callback(void *context=
);
>  #define STORVSC_IDE_MAX_CHANNELS			1
>=20
>  /*
> - * Upper bound on the size of a storvsc packet. vmscsi_size_delta is not
> - * included in the calculation because it is set after STORVSC_MAX_PKT_S=
IZE
> - * is used in storvsc_connect_to_vsp
> + * Upper bound on the size of a storvsc packet.
>   */
>  #define STORVSC_MAX_PKT_SIZE (sizeof(struct vmpacket_descriptor) +\
>  			      sizeof(struct vstor_packet))
> @@ -452,17 +413,6 @@ struct storvsc_device {
>  	unsigned char path_id;
>  	unsigned char target_id;
>=20
> -	/*
> -	 * The size of the vmscsi_request has changed in win8. The
> -	 * additional size is because of new elements added to the
> -	 * structure. These elements are valid only when we are talking
> -	 * to a win8 host.
> -	 * Track the correction to size we need to apply. This value
> -	 * will likely change during protocol negotiation but it is
> -	 * valid to start by assuming pre-Win8.
> -	 */
> -	int vmscsi_size_delta;
> -
>  	/*
>  	 * Max I/O, the device can support.
>  	 */
> @@ -795,8 +745,7 @@ static void  handle_multichannel_storage(struct
> hv_device *device, int max_chns)
>  	vstor_packet->sub_channel_count =3D num_sc;
>=20
>  	ret =3D vmbus_sendpacket(device->channel, vstor_packet,
> -			       (sizeof(struct vstor_packet) -
> -			       stor_device->vmscsi_size_delta),
> +			       sizeof(struct vstor_packet),
>  			       VMBUS_RQST_INIT,
>  			       VM_PKT_DATA_INBAND,
>=20
> VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> @@ -864,8 +813,7 @@ static int storvsc_execute_vstor_op(struct hv_device
> *device,
>  	vstor_packet->flags =3D REQUEST_COMPLETION_FLAG;
>=20
>  	ret =3D vmbus_sendpacket(device->channel, vstor_packet,
> -			       (sizeof(struct vstor_packet) -
> -			       stor_device->vmscsi_size_delta),
> +			       sizeof(struct vstor_packet),
>  			       VMBUS_RQST_INIT,
>  			       VM_PKT_DATA_INBAND,
>=20
> VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> @@ -915,14 +863,13 @@ static int storvsc_channel_init(struct hv_device
> *device, bool is_fc)
>  	 * Query host supported protocol version.
>  	 */
>=20
> -	for (i =3D 0; i < ARRAY_SIZE(vmstor_protocols); i++) {
> +	for (i =3D 0; i < ARRAY_SIZE(protocol_version); i++) {
>  		/* reuse the packet for version range supported */
>  		memset(vstor_packet, 0, sizeof(struct vstor_packet));
>  		vstor_packet->operation =3D
>  			VSTOR_OPERATION_QUERY_PROTOCOL_VERSION;
>=20
> -		vstor_packet->version.major_minor =3D
> -			vmstor_protocols[i].protocol_version;
> +		vstor_packet->version.major_minor =3D protocol_version[i];
>=20
>  		/*
>  		 * The revision number is only used in Windows; set it to 0.
> @@ -936,14 +883,7 @@ static int storvsc_channel_init(struct hv_device *de=
vice,
> bool is_fc)
>  			return -EINVAL;
>=20
>  		if (vstor_packet->status =3D=3D 0) {
> -			vmstor_proto_version =3D
> -				vmstor_protocols[i].protocol_version;
> -
> -			sense_buffer_size =3D
> -				vmstor_protocols[i].sense_buffer_size;
> -
> -			stor_device->vmscsi_size_delta =3D
> -				vmstor_protocols[i].vmscsi_size_delta;
> +			vmstor_proto_version =3D protocol_version[i];
>=20
>  			break;
>  		}

Now the code for querying versions will fail on earlier Hyper-V versions, u=
nlike the pre-patch code it will never fail.

Can you use a dev_err() to indicate this failure? This can help customers r=
unning into this and they will not call support.

Long
