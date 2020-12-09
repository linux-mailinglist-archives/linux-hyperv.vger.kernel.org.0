Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9101F2D48F6
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Dec 2020 19:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgLIS1Z (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Dec 2020 13:27:25 -0500
Received: from mail-dm6nam12on2100.outbound.protection.outlook.com ([40.107.243.100]:35681
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732914AbgLIS1X (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Dec 2020 13:27:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEUKWtC02/rCYUXD3SKJt8ToeiMCEv1YRe9CA/p7N51RnRaAPX1pU5PxQaCwgAlmkZvIXMfK9rI/EbMSEqca49wtwxb43FporA0i/LRSs5Wkz3fItH2TSywfZrVc1Z93bDNwxpdz8epl0bOMWx48JAKQ8MkB3bdfCp0TuOtMljNYLTpdv9F1LPoMuQWS1cgGYnakXUDPRubSc6qjUmBpcN/Q70WYC0X4sTOcDqddJ7FRYfXYUue098LEOzX+WsgEv0Q8J3JI2iSOdqmQF2TNiOrE9/1h4mS/9j4aCf6iBFpzDh9izZ0N4Nv8M4vRnWPJLTsES5awUf5gGRdq2alJFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OI3zSIclEUyOq2Tu0lD7E7xedrR84ZGQSoLWTvxVjWQ=;
 b=YxTrdWDw0Qv7mdZVF6Ddqxd+0IR4s2nx22hDhCTRuBDbTfvgNCwmEPWFo28vVtyRdj8R0W7VzsAnbuYxiyMLd+ozd9LLvzBMRJt4K9KlpoETrXj2bx/H9iFYajV2UBuF7dgXqVou0WIXj5E1Rj6J3ckZ0N4Zv4qBBhdfmVdd9JlmxgQczmFNUdAGlJYBiwD/5OJr5vUN3HpUWRe0c1xOomg3HbrgSTKWdQl2xRnrC7IHkXfR/yjE3BbngMeRyN6b2hOLjz8Ebb72zhin/Ow5mwN7mUllP9jcomWgLX8KTtb0IvjR8ybddnSx6kA+K/lTe5ZhEnXUVqI+5v8Ha+o1dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OI3zSIclEUyOq2Tu0lD7E7xedrR84ZGQSoLWTvxVjWQ=;
 b=S8PfSsoOUkfjiPhjIxPOcRu9DOcagQvEOVcd84hzum5YVF0YrP7xc9gxRUSFX2NFd1PdQ4jf0SxXxEZm78wuRbHpoY4iwrF8UzDGeFo+hrWFqu1XmAYIWu4vKt/UCM5rnBCCfNKKWFin7XcwVDuUg37nJ5xU0otjmHFw/HoekSg=
Received: from (2603:10b6:805:6::17) by
 SN6PR2101MB1344.namprd21.prod.outlook.com (2603:10b6:805:107::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.2; Wed, 9 Dec
 2020 18:26:53 +0000
Received: from SN6PR2101MB1056.namprd21.prod.outlook.com
 ([fe80::901:94fd:4c64:2ccf]) by SN6PR2101MB1056.namprd21.prod.outlook.com
 ([fe80::901:94fd:4c64:2ccf%9]) with mapi id 15.20.3654.012; Wed, 9 Dec 2020
 18:26:52 +0000
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
Subject: RE: [PATCH v3 3/6] Drivers: hv: vmbus: Copy the hv_message in
 vmbus_on_msg_dpc()
Thread-Topic: [PATCH v3 3/6] Drivers: hv: vmbus: Copy the hv_message in
 vmbus_on_msg_dpc()
Thread-Index: AQHWzfo7XYcvIEgiAUq2bY/ygsWxmanvFaBg
Date:   Wed, 9 Dec 2020 18:26:52 +0000
Message-ID: <SN6PR2101MB105650A9F99114255998FB3BD7CC1@SN6PR2101MB1056.namprd21.prod.outlook.com>
References: <20201209070827.29335-1-parri.andrea@gmail.com>
 <20201209070827.29335-4-parri.andrea@gmail.com>
In-Reply-To: <20201209070827.29335-4-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-09T18:26:51Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e6ca392b-d0b4-4c30-9891-82419cce7d7d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d7295be-cc2e-4a91-555d-08d89c700065
x-ms-traffictypediagnostic: SN6PR2101MB1344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB1344CF21786E5878B4FD7E25D7CC1@SN6PR2101MB1344.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mfcb1/zBZCAPxNNuM5fnilkTbA42S663B55QNe2SG1n+OuK6GvOrRV3SypXLqIeSvq/5zTfzj4o/+r88BdurZDDJlU9MTe4bM+JWkbBgLRpqZwb18erQju/hh7bF3llGZb5gK0weldUWpSepbwN2L0FmIkSXWwlx6S7CxFGCboR+BC8JWLGVGuY8+XFTNchYwBD71nApWVklhwM4Gk/L2PvfglhUyPHDBn4R+X+e1KhkOIuzkHAjIJktbSw6tH3Wlrbu5gGiL3K6yaZX49kjhSk4Mjv3rTUfQbXXAv9Ol1hZ0Vzh+GCN7mWCcrLy7NJuEEa49Xqm53irFDS+e7iVwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1056.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(2906002)(8990500004)(107886003)(4326008)(8676002)(8936002)(33656002)(82960400001)(83380400001)(86362001)(82950400001)(9686003)(508600001)(186003)(110136005)(54906003)(55016002)(7696005)(6506007)(66946007)(10290500003)(76116006)(26005)(5660300002)(66476007)(52536014)(66556008)(64756008)(66446008)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IQ/gwn99SjAcnDARr5uDnZM3K2HMf9RqRYw0RviUgW5eytLitjnjjxonjdOL?=
 =?us-ascii?Q?5DKe30hk2udEmii9VNvzAeXLyH3RTWrsTwctWmv6yJgR4fjTjIzjA4q4Jwp3?=
 =?us-ascii?Q?4zifcYVWQ2ootULw3gtrm8zHyYphnJgfYrgNZjqc8f2MBotQmP5pc2V2YWm5?=
 =?us-ascii?Q?IYzG5iW3DJ09achlYj/Yn0JpLghYWqxhs+CzdvBz5IYpnT9uCBkdw0DvLhT7?=
 =?us-ascii?Q?vFUG4wz67Wd0boZFykCK+K9oKaj2MTVY92DhlkIF2M4ce2hwFVmRDOH7X5Ih?=
 =?us-ascii?Q?KlPArL3CL6ktGGvcySAbVd9oeNfqdx6Da56RhuOgxnJeaGNdbzK9dOqatjsf?=
 =?us-ascii?Q?Y9zorIHT2dPclsXAHetPFAorEtQyseNOk4nNl1BeZGLfi0X31VBMtyaGApR7?=
 =?us-ascii?Q?5q9GzJdX9qOllNd6IAqeJH6yMJZWlP5P6KxccYyEjFLvGjIdOx6g8543whWn?=
 =?us-ascii?Q?loCOT2GzTYDDmJ02GdAKcOR3FZqKJlr/Pvv52ArSTNm8DPU0YKbc16uQ0CxI?=
 =?us-ascii?Q?yIbw9MRLj7g0BzeVarHQVg3ZiZK2J8eGnBlt1s2WzmkDWvnUA7dWQBRNe6qU?=
 =?us-ascii?Q?0tEaqJ7n+CfChisUdbKxKdP5OQksgnhukNCFdUAPkucGpO90+vDJl46cZ+Ho?=
 =?us-ascii?Q?hl+Q/uvMce5QPILr7fMegeGDG07fKbmToG/T5myIATwr17W3JjLbP5NiIvbt?=
 =?us-ascii?Q?q16YxLDavBD5OenGsytFUNVyczzy1P8Ey7xNY8jFaQ8tiTX3JL3I06xF+gxD?=
 =?us-ascii?Q?AIQjQLjQS8N+1cs0faCw2/ddeP5E2WYpRPi7mzGwnk3U4GI+tg0wOemoytCi?=
 =?us-ascii?Q?EbAXd+XIUh8KxjIXMGufR25q+EftSMd55eH8oBTV1BH5pw8JhJ9h2G+jkYg4?=
 =?us-ascii?Q?0LuyZXheY0tC82woMq8ZGeB7TKoDi3UHJvc5WX28DO0MsfKhC/IAQ1s4h2Ai?=
 =?us-ascii?Q?O2IgcOcm5IfyheZcpifVGdAmlX6jEBO0sPrH+dBmfEQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1056.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7295be-cc2e-4a91-555d-08d89c700065
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 18:26:52.7917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v79I4WWuzyvRDs88xUTKD6xXnhRZ4sth2fOrT962HVuBgkJCkCOc9NxYAZehqMV9FKJO2sKRi3jRz25GYuRyBj82ykAjxIJQuSRRxJzZY8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1344
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Tuesday, Dece=
mber 8, 2020 11:08 PM
>=20
> Since the message is in memory shared with the host, an erroneous or a
> malicious Hyper-V could 'corrupt' the message while vmbus_on_msg_dpc()
> or individual message handlers are executing.  To prevent it, copy the
> message into private memory.
>=20
> Reported-by: Juan Vazquez <juvazq@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
> Changes since v2:
>   - Revisit commit message and inline comment
>=20
>  drivers/hv/vmbus_drv.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 44bcf9ccdaf5f..b1c5a89d75f9d 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1054,14 +1054,14 @@ void vmbus_on_msg_dpc(unsigned long data)
>  {
>  	struct hv_per_cpu_context *hv_cpu =3D (void *)data;
>  	void *page_addr =3D hv_cpu->synic_message_page;
> -	struct hv_message *msg =3D (struct hv_message *)page_addr +
> +	struct hv_message msg_copy, *msg =3D (struct hv_message *)page_addr +
>  				  VMBUS_MESSAGE_SINT;
>  	struct vmbus_channel_message_header *hdr;
>  	enum vmbus_channel_message_type msgtype;
>  	const struct vmbus_channel_message_table_entry *entry;
>  	struct onmessage_work_context *ctx;
> -	u32 message_type =3D msg->header.message_type;
>  	__u8 payload_size;
> +	u32 message_type;
>=20
>  	/*
>  	 * 'enum vmbus_channel_message_type' is supposed to always be 'u32' as
> @@ -1070,11 +1070,20 @@ void vmbus_on_msg_dpc(unsigned long data)
>  	 */
>  	BUILD_BUG_ON(sizeof(enum vmbus_channel_message_type) !=3D sizeof(u32));
>=20
> +	/*
> +	 * Since the message is in memory shared with the host, an erroneous or
> +	 * malicious Hyper-V could modify the message while vmbus_on_msg_dpc()
> +	 * or individual message handlers are executing; to prevent this, copy
> +	 * the message into private memory.
> +	 */
> +	memcpy(&msg_copy, msg, sizeof(struct hv_message));
> +
> +	message_type =3D msg_copy.header.message_type;
>  	if (message_type =3D=3D HVMSG_NONE)
>  		/* no msg */
>  		return;
>=20
> -	hdr =3D (struct vmbus_channel_message_header *)msg->u.payload;
> +	hdr =3D (struct vmbus_channel_message_header *)msg_copy.u.payload;
>  	msgtype =3D hdr->msgtype;
>=20
>  	trace_vmbus_on_msg_dpc(hdr);
> @@ -1084,7 +1093,7 @@ void vmbus_on_msg_dpc(unsigned long data)
>  		goto msg_handled;
>  	}
>=20
> -	payload_size =3D msg->header.payload_size;
> +	payload_size =3D msg_copy.header.payload_size;
>  	if (payload_size > HV_MESSAGE_PAYLOAD_BYTE_COUNT) {
>  		WARN_ONCE(1, "payload size is too large (%d)\n", payload_size);
>  		goto msg_handled;
> @@ -1106,7 +1115,7 @@ void vmbus_on_msg_dpc(unsigned long data)
>  			return;
>=20
>  		INIT_WORK(&ctx->work, vmbus_onmessage_work);
> -		memcpy(&ctx->msg, msg, sizeof(msg->header) + payload_size);
> +		memcpy(&ctx->msg, &msg_copy, sizeof(msg->header) + payload_size);
>=20
>  		/*
>  		 * The host can generate a rescind message while we
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

