Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD0F532CDA
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 May 2022 17:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238432AbiEXPE4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 May 2022 11:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236693AbiEXPEz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 May 2022 11:04:55 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2124.outbound.protection.outlook.com [40.107.101.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964958AE7B;
        Tue, 24 May 2022 08:04:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtTVee8Rj2mE+9GdP7v0sLU5vdXZheVA03u/X//L8nFUn95BxJ2QN8yhffLAn41HRjNUt3qmFUq56WRVWiYWteORYirC9uB9Nnm6CYHqhpv3ErfbPJImp1Nhg2Nvegh2EhZQR8lZD+N44ysaFdep29+q8c79GLs7xQbJUbnjiehdpX5MbqSXVwnB9iQIVT5aB1s5eR2uuLoCBkDJn0OJjrr4joheO7ixsT+sN3GM9mSc4yuCMbP3dnYdIhZlfnL96bIkwKmy+aPYgayaqEQtsOhscpeRwt64PoEcx7M+vy9iqR5VTrmCtN1+1uzkyHWVcfMr0VEJylDhjC4wauaZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SZYgNqqdQvVSNjHBEUIyCtMKQZOpppGIFZquiDHPkM=;
 b=cJ70ouTT54nE/8iqYfh6Did79id5jnqklNaycikODgeJxbOdfRm0sR11w792HywPU/1e3onlsGaPBz/91N38+a5oJVucFRuQmKam3NztWptYfeZKBhKTDCKuiTIGFPSuazDhXEeBGsKUtF/4puLxc+BMhbF5CK3D0/3jjAkTazH4Du8LCqMtOygkCshRuX5O06uU+ICBHGanJhlqPuqFGV3MMyOlafzLaa3Q3/esMTsStfs36QUCl5oxEsxI4nDj4MM4+gYlAzl9P6pyj8eghvXg7Zvjg1s8+SPWGzQpu1L4k1+phdRHxOMszAQXXgQBhfZVxk/fFgGROf2qJ6ykmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SZYgNqqdQvVSNjHBEUIyCtMKQZOpppGIFZquiDHPkM=;
 b=Sdjtc98Vhnc/HrfNjgYU1k8MedeStVerNcl/Y0ndh2BTcBcwrB+4vWxhJkYVu9ZLQH0zjydkBbMqOScCV9kjZltbH4sW9bjQOuvY7LGKoCiwJyuzIYdBNmvF2jBq2y5UkuheaSRgxLYoCjhQLTXFw1AoTVIzw7E4YdMTdhD9Xbc=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by CY5PR21MB3543.namprd21.prod.outlook.com (2603:10b6:930:c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.3; Tue, 24 May
 2022 15:04:50 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::3506:defe:c88a:8580]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::3506:defe:c88a:8580%9]) with mapi id 15.20.5314.003; Tue, 24 May 2022
 15:04:50 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Long Li <longli@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] scsi: storvsc: Removing Pre Win8 related logic
Thread-Topic: [PATCH v3] scsi: storvsc: Removing Pre Win8 related logic
Thread-Index: AQHYb2NKSPgcfsaNXUi8pAA/IfaoNq0uH7nw
Date:   Tue, 24 May 2022 15:04:50 +0000
Message-ID: <PH0PR21MB30251F55B1617F48E11EE65DD7D79@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1653392516-9233-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1653392516-9233-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e19787be-1b02-46e8-a38f-e6d3cb4b0328;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-24T15:02:13Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5261e08b-f27e-4bfb-e757-08da3d96c01e
x-ms-traffictypediagnostic: CY5PR21MB3543:EE_
x-microsoft-antispam-prvs: <CY5PR21MB3543E089B712722C9B3172D4D7D79@CY5PR21MB3543.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PbHwz5HOXDdgqJNn6sEFcxi3UfHZWZE7SHJyqHAXoEMEN06eF3urgUTVDhPDBVftAqwZbAOgcuse8sR9bXkw4XqE8NKUOURSbaTQrDd+0ngzSX6u5Sd5PrqqxzwCKb9rztGel2WifZILrH2DLi6n1WzThBY6m64Im99tPS299+IWH2JYU9aX5DvPyEOzs+EeIRiMN90OtbkuYLphSq+EpaWQ28H4AEcefvPn8TPiPc8KyZRr4EiG6EvQqBbK36g18bAM8KYrivlQ0J6tEon4okbNJ/9ltGJ72Fpyq/o687A4dCGOXtv0jDRF3tQJUiBGrjJOd9muHonmlWPi3Y2pNbUZ9mENfAI9ujTEyAdK+Zuut1t8RvvwwNcHzp0YdPjaXkD1pkJ8OIBOfIEG2BcuePOXJxeFSz/NiHuNkRARhiQpKwSe1mLhzqRA1D21DgnbnpJgIZg+rsSbN083/XIBvTlNEZqCmKADAq4Jzg3j6RWToY3eE2+oUxX1o1Q4YA6LYYnw4pItwL/s/ZgUm6RHfWMdFYB9rb/c1UvWZyjcMqP1mK8wvcvBWs6Q5hSN+xye2RcyC54qa9O8NX5jCvVUntQ1RCKLjUFUAoROzpwWoUK1Fw84/mzPfBM+RogA2tWDevYf92RtSYn/SJ3yEOt8w+pzoM9FUCYJlyo066N1HKx/DWwWrU3kEI89n6pdsPxHEBggWLl5hc+BKROg+TbnR0Ll5d99tqba8dSvxT1UeF6jSz/sll1FHNHL+XNqA/OhByd/ztahoMkn01UGPJjxAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(6506007)(8990500004)(26005)(9686003)(38100700002)(83380400001)(76116006)(316002)(38070700005)(7696005)(52536014)(33656002)(66946007)(86362001)(5660300002)(186003)(921005)(64756008)(8676002)(66446008)(55016003)(508600001)(8936002)(66556008)(110136005)(82950400001)(82960400001)(122000001)(10290500003)(66476007)(30864003)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z87ulJDoAMKTlOxGEXi5YcizMiOk0rU2AzDRC2hnXBB0n8jvPxUIW4thfzCD?=
 =?us-ascii?Q?miOH/Xq5titEWO5ThBlC9aA7crIR1KGbqgt3ImFXPlwDv4QVydEeUWxTdeHk?=
 =?us-ascii?Q?jUSQT+fz+DWcJHvQnUfbCox5uyc7adnlJf9r7brYoONnflvK1e2hC+3WsaKJ?=
 =?us-ascii?Q?5g1/+qbbRmHyxW4sB9u41DmmeTokLICd/RQZ5L6tEdFvYgVTaSrfRknbveK4?=
 =?us-ascii?Q?EM3VLLWIhDyv/gRrFzYRI8ngfCyA8xkt/yWnncnzSFqp/9/7iFT/bt9HCRp3?=
 =?us-ascii?Q?7g12j84hzotfmU73odaqcvoXrYN5fzn2BM4h9Qlny4gwUNYZRRBW40vOMz7J?=
 =?us-ascii?Q?xGeTe5VTCBs7fxHD6kHe051xGcaMmo54FVtHgjJgsGW0pEYED8eNAqYBHwec?=
 =?us-ascii?Q?sRXHnKpNNdI+3rI0uqvblC+iFYBmTKyqSoRaGJ1QrxyzufVFryDnxPJfEieu?=
 =?us-ascii?Q?rLp1Lhes0wFN6gI9yACVz4j+ug6jzrKg4vbTGwDUygZWIa/A9jFIT6Dgl5fb?=
 =?us-ascii?Q?cy6Hv7XIdfuM4W6UEhqRRK9uWTSxu67cQHljxutheCuduorXWF4JW0D3H50h?=
 =?us-ascii?Q?AfFD0TjEVylkLMLFUDgJjibPQp2sEwbnh0XYlEuHe//skYABVuHRC+MbsbIa?=
 =?us-ascii?Q?2wlgWFQB6C/pUdK2flkXvZ/COeEgRf60jSc+hsXVTKNQ9IxwlN143PdxbFbY?=
 =?us-ascii?Q?NQNiHsAIyva1xCFA8f1npH8woXa8kHhlu4YirbEQpa3c+9/RmnIjL2rBICzk?=
 =?us-ascii?Q?YHdV8d0LKuzf+JuRMTQdXL6s+zU2TfeTv6Y56tKD4YbK18MYeEhMfg3msgxu?=
 =?us-ascii?Q?Et6WkUagvg9SecGqmgyPXD8175uO7PdBnUbVOHHk7qtHippLhN0NDDIQC+l4?=
 =?us-ascii?Q?aAu4lDU8fYoyNTNbds6lDKX9JHTxnNQuOVHpMCF7yVrVwoS1/HZW7m6nQoOR?=
 =?us-ascii?Q?KlL+4AFmGQxjNbcFAJjEov9LvqxhiuAxZwRgZ9CCcR89KEs3URQeUxr+j1/Y?=
 =?us-ascii?Q?DRPsKhbXWyQpfjCOcSBOsU8XrLNiszmn5FAdee20G5pEp0KM2Xyjxre41AI7?=
 =?us-ascii?Q?RdhekNA85pl+MpvbyNbT+5JT2VpdRoApjzi+aI460arxiO8jYF5mUNhzXvP3?=
 =?us-ascii?Q?eYK+103S8XNxsWyLkn/W+tXQyjJsxPZQipw6LRI1F1YG38OhgnBe3ogtVVAi?=
 =?us-ascii?Q?ncvPBTkrRK8u6Ey9ZobKjDzb21CT7pCXAzX2R2f4RIP1SutESMsrVzMmC8Eo?=
 =?us-ascii?Q?BHmEc3SmeO5y27eclAKomfPRx2O1MeoMFNuo1fOvz7w24L/n6FVrVYRHiZHc?=
 =?us-ascii?Q?BZ72vVltdoplJCRzspIXftHGcjfZZTjqgjG6VK5wusPMqwP1EW2WdYBpcbdM?=
 =?us-ascii?Q?j5gtL9//UQ8NdUp9zRUxjrDha5vs1Y0lmI02G5JA0xhIScA4XPOoxPZ1UoB6?=
 =?us-ascii?Q?N30JJEIv0EWLlw4GdYbo4yISxMPGOwL7K3itH4LNgDlOJOEc0oa6efo9G1m2?=
 =?us-ascii?Q?Y97MY/+CJF4uDvNeqs+vs3ZAaLUNBrlz1FsYu332y9J5A70SQrpynyF2PNjp?=
 =?us-ascii?Q?D30zGSIYWY0dGG+NGus2Vv56mVYRI4id7iZ7DOh5lqQSYKJXplCHBdhQEQBP?=
 =?us-ascii?Q?SKuhDMdQlU8iKyArEKL3THYruQJ5yz2UqeP9gfRx52gwrn1dVu7UWtJ4RRny?=
 =?us-ascii?Q?t5Nyb3IMOijHxqUKZiA4R3a0AmbUfep8Dm5e6/kCxif4HAg4Li6EI3waX7DV?=
 =?us-ascii?Q?iJfRsug5AHYz/xi/U3d9CpG8+peREkY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5261e08b-f27e-4bfb-e757-08da3d96c01e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 15:04:50.3360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UcVSIFoeHTL+TMGRtm49nHPmQ7hc232aBs0fXz56XnljPEKha0VhTnXhYVFb1VRFjIbIJdzUXg271QHx29yW10eMvRoyQ7tPFtAECnzXAU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3543
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com>
>
> The latest storvsc code has already removed the support for windows 7 and
> earlier. There is still some code logic reamining which is there to suppo=
rt
> pre Windows 8 OS. This patch removes these stale logic.
> This patch majorly does three things :
>=20
> 1. Removes vmscsi_size_delta and its logic, as the vmscsi_request struct =
is
> same for all the OS post windows 8 there is no need of delta.
> 2. Simplify sense_buffer_size logic, as there is single buffer size for
> all the post windows 8 OS.
> 3. Embed the vmscsi_win8_extension structure inside the vmscsi_request,
> as there is no separate handling required for different OS.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> v3 : Removed pre win8 macros:
> 	- POST_WIN7_STORVSC_SENSE_BUFFER_SIZE
> 	- VMSTOR_PROTO_VERSION_WIN6
> 	- VMSTOR_PROTO_VERSION_WIN7
>=20
>  drivers/scsi/storvsc_drv.c | 152 ++++++++++---------------------------
>  1 file changed, 40 insertions(+), 112 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 5585e9d30bbf..66d9adb5487f 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -55,8 +55,6 @@
>  #define VMSTOR_PROTO_VERSION(MAJOR_, MINOR_)	((((MAJOR_) & 0xff) <<
> 8) | \
>  						(((MINOR_) & 0xff)))
>=20
> -#define VMSTOR_PROTO_VERSION_WIN6	VMSTOR_PROTO_VERSION(2, 0)
> -#define VMSTOR_PROTO_VERSION_WIN7	VMSTOR_PROTO_VERSION(4, 2)
>  #define VMSTOR_PROTO_VERSION_WIN8	VMSTOR_PROTO_VERSION(5, 1)
>  #define VMSTOR_PROTO_VERSION_WIN8_1	VMSTOR_PROTO_VERSION(6, 0)
>  #define VMSTOR_PROTO_VERSION_WIN10	VMSTOR_PROTO_VERSION(6, 2)
> @@ -136,19 +134,15 @@ struct hv_fc_wwn_packet {
>   */
>  #define STORVSC_MAX_CMD_LEN			0x10
>=20
> -#define POST_WIN7_STORVSC_SENSE_BUFFER_SIZE	0x14
> -#define PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE	0x12
> -
>  #define STORVSC_SENSE_BUFFER_SIZE		0x14
>  #define STORVSC_MAX_BUF_LEN_WITH_PADDING	0x14
>=20
>  /*
> - * Sense buffer size changed in win8; have a run-time
> - * variable to track the size we should use.  This value will
> - * likely change during protocol negotiation but it is valid
> - * to start by assuming pre-Win8.
> + * Sense buffer size was differnt pre win8 but those OS are not supporte=
d any
> + * more starting 5.19 kernel. This results in to supporting a single val=
ue from
> + * win8 onwards.
>   */
> -static int sense_buffer_size =3D PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE;
> +static int sense_buffer_size =3D STORVSC_SENSE_BUFFER_SIZE;

Can't the variable be eliminated entirely?  The value doesn't ever change.
The variable is referenced in two places, and those two places could just
use the constant STORVSC_SENSE_BUFFER_SIZE.

Michael

>=20
>  /*
>   * The storage protocol version is determined during the
> @@ -177,18 +171,6 @@ do {
> 	\
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
> @@ -214,46 +196,23 @@ struct vmscsi_request {
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
> -
>=20
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
> @@ -409,9 +368,7 @@ static void storvsc_on_channel_callback(void *context=
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
> @@ -452,17 +409,6 @@ struct storvsc_device {
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
> @@ -795,8 +741,7 @@ static void  handle_multichannel_storage(struct hv_de=
vice
> *device, int max_chns)
>  	vstor_packet->sub_channel_count =3D num_sc;
>=20
>  	ret =3D vmbus_sendpacket(device->channel, vstor_packet,
> -			       (sizeof(struct vstor_packet) -
> -			       stor_device->vmscsi_size_delta),
> +			       sizeof(struct vstor_packet),
>  			       VMBUS_RQST_INIT,
>  			       VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> @@ -864,8 +809,7 @@ static int storvsc_execute_vstor_op(struct hv_device =
*device,
>  	vstor_packet->flags =3D REQUEST_COMPLETION_FLAG;
>=20
>  	ret =3D vmbus_sendpacket(device->channel, vstor_packet,
> -			       (sizeof(struct vstor_packet) -
> -			       stor_device->vmscsi_size_delta),
> +			       sizeof(struct vstor_packet),
>  			       VMBUS_RQST_INIT,
>  			       VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> @@ -915,14 +859,13 @@ static int storvsc_channel_init(struct hv_device *d=
evice, bool
> is_fc)
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
> @@ -936,21 +879,16 @@ static int storvsc_channel_init(struct hv_device *d=
evice, bool
> is_fc)
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
>  	}
>=20
> -	if (vstor_packet->status !=3D 0)
> +	if (vstor_packet->status !=3D 0) {
> +		dev_err(&device->device, "Obsolete Hyper-V version\n");
>  		return -EINVAL;
> +	}
>=20
>=20
>  	memset(vstor_packet, 0, sizeof(struct vstor_packet));
> @@ -986,11 +924,10 @@ static int storvsc_channel_init(struct hv_device *d=
evice, bool
> is_fc)
>  	cpumask_set_cpu(device->channel->target_cpu,
>  			&stor_device->alloced_cpus);
>=20
> -	if (vmstor_proto_version >=3D VMSTOR_PROTO_VERSION_WIN8) {
> -		if (vstor_packet->storage_channel_properties.flags &
> -		    STORAGE_CHANNEL_SUPPORTS_MULTI_CHANNEL)
> -			process_sub_channels =3D true;
> -	}
> +	if (vstor_packet->storage_channel_properties.flags &
> +	    STORAGE_CHANNEL_SUPPORTS_MULTI_CHANNEL)
> +		process_sub_channels =3D true;
> +
>  	stor_device->max_transfer_bytes =3D
>  		vstor_packet->storage_channel_properties.max_transfer_bytes;
>=20
> @@ -1289,8 +1226,8 @@ static void storvsc_on_channel_callback(void *conte=
xt)
>  		struct storvsc_cmd_request *request =3D NULL;
>  		u32 pktlen =3D hv_pkt_datalen(desc);
>  		u64 rqst_id =3D desc->trans_id;
> -		u32 minlen =3D rqst_id ? sizeof(struct vstor_packet) -
> -			stor_device->vmscsi_size_delta : sizeof(enum
> vstor_packet_operation);
> +		u32 minlen =3D rqst_id ? sizeof(struct vstor_packet) :
> +			sizeof(enum vstor_packet_operation);
>=20
>  		if (pktlen < minlen) {
>  			dev_err(&device->device,
> @@ -1346,7 +1283,7 @@ static void storvsc_on_channel_callback(void *conte=
xt)
>  		}
>=20
>  		memcpy(&request->vstor_packet, packet,
> -		       (sizeof(struct vstor_packet) - stor_device->vmscsi_size_delta))=
;
> +		       sizeof(struct vstor_packet));
>  		complete(&request->wait_event);
>  	}
>  }
> @@ -1557,8 +1494,7 @@ static int storvsc_do_io(struct hv_device *device,
>  found_channel:
>  	vstor_packet->flags |=3D REQUEST_COMPLETION_FLAG;
>=20
> -	vstor_packet->vm_srb.length =3D (sizeof(struct vmscsi_request) -
> -					stor_device->vmscsi_size_delta);
> +	vstor_packet->vm_srb.length =3D sizeof(struct vmscsi_request);
>=20
>=20
>  	vstor_packet->vm_srb.sense_info_length =3D sense_buffer_size;
> @@ -1574,13 +1510,11 @@ static int storvsc_do_io(struct hv_device *device=
,
>  		ret =3D vmbus_sendpacket_mpb_desc(outgoing_channel,
>  				request->payload, request->payload_sz,
>  				vstor_packet,
> -				(sizeof(struct vstor_packet) -
> -				stor_device->vmscsi_size_delta),
> +				sizeof(struct vstor_packet),
>  				(unsigned long)request);
>  	} else {
>  		ret =3D vmbus_sendpacket(outgoing_channel, vstor_packet,
> -			       (sizeof(struct vstor_packet) -
> -				stor_device->vmscsi_size_delta),
> +			       sizeof(struct vstor_packet),
>  			       (unsigned long)request,
>  			       VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> @@ -1684,8 +1618,7 @@ static int storvsc_host_reset_handler(struct scsi_c=
mnd
> *scmnd)
>  	vstor_packet->vm_srb.path_id =3D stor_device->path_id;
>=20
>  	ret =3D vmbus_sendpacket(device->channel, vstor_packet,
> -			       (sizeof(struct vstor_packet) -
> -				stor_device->vmscsi_size_delta),
> +			       sizeof(struct vstor_packet),
>  			       VMBUS_RQST_RESET,
>  			       VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> @@ -1778,31 +1711,31 @@ static int storvsc_queuecommand(struct Scsi_Host =
*host,
> struct scsi_cmnd *scmnd)
>=20
>  	memset(&cmd_request->vstor_packet, 0, sizeof(struct vstor_packet));
>  	vm_srb =3D &cmd_request->vstor_packet.vm_srb;
> -	vm_srb->win8_extension.time_out_value =3D 60;
> +	vm_srb->time_out_value =3D 60;
>=20
> -	vm_srb->win8_extension.srb_flags |=3D
> +	vm_srb->srb_flags |=3D
>  		SRB_FLAGS_DISABLE_SYNCH_TRANSFER;
>=20
>  	if (scmnd->device->tagged_supported) {
> -		vm_srb->win8_extension.srb_flags |=3D
> +		vm_srb->srb_flags |=3D
>  		(SRB_FLAGS_QUEUE_ACTION_ENABLE |
> SRB_FLAGS_NO_QUEUE_FREEZE);
> -		vm_srb->win8_extension.queue_tag =3D SP_UNTAGGED;
> -		vm_srb->win8_extension.queue_action =3D SRB_SIMPLE_TAG_REQUEST;
> +		vm_srb->queue_tag =3D SP_UNTAGGED;
> +		vm_srb->queue_action =3D SRB_SIMPLE_TAG_REQUEST;
>  	}
>=20
>  	/* Build the SRB */
>  	switch (scmnd->sc_data_direction) {
>  	case DMA_TO_DEVICE:
>  		vm_srb->data_in =3D WRITE_TYPE;
> -		vm_srb->win8_extension.srb_flags |=3D SRB_FLAGS_DATA_OUT;
> +		vm_srb->srb_flags |=3D SRB_FLAGS_DATA_OUT;
>  		break;
>  	case DMA_FROM_DEVICE:
>  		vm_srb->data_in =3D READ_TYPE;
> -		vm_srb->win8_extension.srb_flags |=3D SRB_FLAGS_DATA_IN;
> +		vm_srb->srb_flags |=3D SRB_FLAGS_DATA_IN;
>  		break;
>  	case DMA_NONE:
>  		vm_srb->data_in =3D UNKNOWN_TYPE;
> -		vm_srb->win8_extension.srb_flags |=3D
> SRB_FLAGS_NO_DATA_TRANSFER;
> +		vm_srb->srb_flags |=3D SRB_FLAGS_NO_DATA_TRANSFER;
>  		break;
>  	default:
>  		/*
> @@ -2004,7 +1937,6 @@ static int storvsc_probe(struct hv_device *device,
>  	init_waitqueue_head(&stor_device->waiting_to_drain);
>  	stor_device->device =3D device;
>  	stor_device->host =3D host;
> -	stor_device->vmscsi_size_delta =3D sizeof(struct vmscsi_win8_extension)=
;
>  	spin_lock_init(&stor_device->lock);
>  	hv_set_drvdata(device, stor_device);
>  	dma_set_min_align_mask(&device->device, HV_HYP_PAGE_SIZE - 1);
> @@ -2217,10 +2149,6 @@ static int __init storvsc_drv_init(void)
>  	 * than the ring buffer size since that page is reserved for
>  	 * the ring buffer indices) by the max request size (which is
>  	 * vmbus_channel_packet_multipage_buffer + struct vstor_packet + u64)
> -	 *
> -	 * The computation underestimates max_outstanding_req_per_channel
> -	 * for Win7 and older hosts because it does not take into account
> -	 * the vmscsi_size_delta correction to the max request size.
>  	 */
>  	max_outstanding_req_per_channel =3D
>  		((storvsc_ringbuffer_size - PAGE_SIZE) /
> --
> 2.25.1

