Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7E4601292
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Oct 2022 17:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiJQPPP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Oct 2022 11:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiJQPPN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Oct 2022 11:15:13 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11021015.outbound.protection.outlook.com [52.101.52.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7CA326E9;
        Mon, 17 Oct 2022 08:15:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkpT5g4tbtJvnU84J4iAhqREf+j6A+Il8JKn9cuE7LXuWKMkV0kbN2AkhrHyFxf+B6uwAE+TzAOKG6GI6yUdHoxd3Q9Fh9G8JyaYSc1MANdFp0TrcFsDjBadhriMaVPzUWStXchWUsz8RsKnv2Y8tLNr4mF3teTdW4xeJwQsEE5s6wNmaK91zFx0Wbz8Tunr/OBS3Empt95WvJfraxHsTeEjMJrzYXFdMRs+uaoSnY487ot73oQEISxNkKFTjl4EmGJNLvJL6VLVoF/OTj1SufFIrMTkisRxH+Or6le1h/1PKrlV6/HWaH0ULjEJ0J0EWpzVa2H3KBUPRUB5iR8SNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTBkmVGrMchqZDylxhibw/0J2m1TXOoXcWjfe4uzI88=;
 b=e4Ttxw/crOaDvrZzmFPked/+jiN8YxCFA+2VeqeYx4QXF/pt2eX/+GzJy+jnuiU0Dz2GQP/YUow3tzmAQM2L45Zlov/VMkciGEVge2pmOvyloyFNnpiUJBGtNnywKijVnhQJ5bV3nNWIbmzD8YGyKe/GJ8Wzlb9sH2VEQ+bev7hETr6t61eylJRg+pFal6LugzR+iZXQ3ZQoNky53IKZ0rpMQ9zgnhuI94GrFjm+k8yHthF8Epvw+AdxjomOcd2qVYMRsHnImNtq5Ymxa+KGBvWGzcTlUWUywdpCPF29UIVe6hef5KFDL1PmCJ4+fSC54LZPILHNG7SurG0WCjpVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTBkmVGrMchqZDylxhibw/0J2m1TXOoXcWjfe4uzI88=;
 b=BgOf82X21AOzzzocTaRe7h3ylN/kDzGzqvDFyL39eeGrfYDs/GxabmRRqwkaoGGyNcxmuofYrdd0u1GUEuJ16N21GgsXot2kI3cVGy5pBz6XOBUUUvuVt1jkaolZgvm2KvuHGBfwSBkddun0chCzJrw/akglQgQH+hk+W9KCEYU=
Received: from SN6PR2101MB1693.namprd21.prod.outlook.com
 (2603:10b6:805:55::19) by CH2PR21MB1430.namprd21.prod.outlook.com
 (2603:10b6:610:80::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.15; Mon, 17 Oct
 2022 15:15:04 +0000
Received: from SN6PR2101MB1693.namprd21.prod.outlook.com
 ([fe80::af9b:5444:77eb:448d]) by SN6PR2101MB1693.namprd21.prod.outlook.com
 ([fe80::af9b:5444:77eb:448d%7]) with mapi id 15.20.5746.009; Mon, 17 Oct 2022
 15:15:04 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] [next] HID: hyperv: Replace one-element array with
 flexible-array member
Thread-Topic: [PATCH] [next] HID: hyperv: Replace one-element array with
 flexible-array member
Thread-Index: AQHY4f1NVEkUfmHplUioVuVVmpSZoa4SsbJA
Date:   Mon, 17 Oct 2022 15:15:04 +0000
Message-ID: <SN6PR2101MB1693AFDA151C35DE148FECAAD7299@SN6PR2101MB1693.namprd21.prod.outlook.com>
References: <Y00JenqCzKRrcTiF@mail.google.com>
In-Reply-To: <Y00JenqCzKRrcTiF@mail.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c1252ce6-ae16-4fdf-a7f5-e362a779f3f0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-17T15:12:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR2101MB1693:EE_|CH2PR21MB1430:EE_
x-ms-office365-filtering-correlation-id: 87a4d2e1-81bb-48bc-c663-08dab0525e3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b0oc1hvSPC2ZLesto2Y6A9l9SVm6/izP0ClsGPTpSxnAe2d+XA4YXVFu5ky07sHOk1lcTZtr8HSmaRrEvD7Mt5eU8qnweBbMOGKHgD922NfMAgqHxnJ8GSO98EjZjqyZwE9gsQGQNqw3EI64PBhnV8u/bCrVAkCLKz+eUPAeDp/P2HjQXuLoJBq5+BDfBuGIl/oy1WlsGJeI2ctdx+9oo2Z+V68tg/yUkKocYOpoqt9OBN6qU16veXwsf5oRmebEn7D3NqSBXOkFt3SZiRO+Ow+3hxGvajjdeXLf/ZZhH/zn1CQq612wKjnSoxcd/cxUqlkooxTwOxdvq2x+f2NAP2CjqDzZ0PjMxOWBYyA1dlJDV6ip8zY1UNnMyN3ZtaeWFN21jytmGt5Rml97bzMLns124Zbc/9ttV5X60N4F4TRpPWLBNo2OPUecZLorrYZwOxJEEhteWBDevjugrFQ5hbKUUwsto1vP/zLl2sTcOB8dNZELB0bfc/6bcyUddWWTsl//GYZaBsyJ/GhrqeVt5v+ap3VuZWNEW7R+aFAfIiQ2EyJMqMj0EHIIjgeU/kLff3Y6HNUMkMjkxuJkT1eIIrrEHTAZd6BRknxDsboOgutwfdTDy/pcEwf+osmcGKNztMzV/WkN0620VF8iWsFd+xiQza++ae26cx01uWjSnCrEmXY4N3MnTszLE92r7N1+I7TBJ2HjH5/WuksZkbhiqk2iDho3kHj3hy9lEGJuQlhbtXJhM60RuJAKkhgLtQd594rhZ4BvbIGCwvtvovq6Bq8QPqXgs8sI8ynx+eyGHgo9ObOo1T6wsKPqIgyOsiI3j6eTp/if6BnCK0KjKWpN0iK/Ew2SOaTmIhEihtc36U3nDGD/21i+kvNE46lDguoFHvzH2PBidY7G7LFICDZwDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1693.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199015)(186003)(2906002)(7696005)(6506007)(9686003)(122000001)(5660300002)(54906003)(10290500003)(316002)(86362001)(38100700002)(26005)(41300700001)(82950400001)(82960400001)(66446008)(66476007)(64756008)(8676002)(921005)(8990500004)(66556008)(66946007)(76116006)(33656002)(83380400001)(4326008)(966005)(55016003)(52536014)(8936002)(110136005)(38070700005)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1XbBqUyI8YEyzn0P/CJBniGThOoVkrBwzUz+1EcFHfDZ1Gg7Nd2c0XkCYimN?=
 =?us-ascii?Q?LQQiCgw6lpnFFVdXCNcrCtz+nPQgO7u8eqWolvljGV0PGAm2iKt4M/If7BkX?=
 =?us-ascii?Q?M9HMIHUrZYcAkgCoOOZBUtKCmKqsKqVmOkUkdzAk0gZ8bgAR9d61g9nMWZeG?=
 =?us-ascii?Q?l0o525Eow/ioKE28Qsb3OlRekAWygl55NrjpxTodTSAs8wk5mYgLHIfDa1vO?=
 =?us-ascii?Q?84GPPgiq7zy8VzKh2iMllTFNPWAz7esd5KwqlniPfrP6y0a62REXnu1fyZRF?=
 =?us-ascii?Q?gtvsCA5LBdye8mlbTxx0v+Nl0hg7M19s/Y2dewhE0gl0f/qNZ3JbaecEK6pM?=
 =?us-ascii?Q?RqU0Q4mBqvPq6RgDEr4VU+3NKPEG9DnUmmzaf3AhEPVKFXLOPLOwlI7YJR9d?=
 =?us-ascii?Q?pt1PSWdaG/LFA/h8pGM80J+49rWbp0wR0bSeohHsXYTpe9Hq0JUsQyTNXt1l?=
 =?us-ascii?Q?r+eSXKYMrrGi4R53SBi9FhmBoECDlM6cJH5KuutgnfFTy0f6mbZ3QREx5GFv?=
 =?us-ascii?Q?JDetfO3Hyj9MYtHfo9pENoN4DyQFOzd9Nkrva8DcqH+gW175IGlK5aGLOfmn?=
 =?us-ascii?Q?U2Pks0A85WWRVewlzHIVrVbNa+H8MWtPXrxPlSitUuJzFjggyaXX2YDf8z2p?=
 =?us-ascii?Q?OeOEJOxVjmmIB9mS/EZYuMyFRRPHqlzw0gHv2LOpfR9dnHR4m7TWcZKoFLDz?=
 =?us-ascii?Q?s5r+apv9SCSa/TazgU1lWYHOTIlJDttTewH0XrlPjE9p1pnfnA97UCOkGmIf?=
 =?us-ascii?Q?/TbNTb9PNOajmafPSo/Zk+PRBNIS7O7qSOBKY2vEYi78uzWg/C3dB+S6nnMV?=
 =?us-ascii?Q?OhC19N39Z8ZyPVCDa7Egk4aq232hA/jJZb+Z/hEA4a47zF/zo+j+StfV/ax6?=
 =?us-ascii?Q?ca3Qf82y0Q31fWT/AVU5zWIKio0APSRjDZDbcQWfsPH8FoMvRN9JOhk9+2AY?=
 =?us-ascii?Q?UhJr2s5NecQ31l1azkQKIPfUfXtgdNz68mAUabngnHWDt/RCerXVPX2+g++z?=
 =?us-ascii?Q?BrxZG/gqx/iJZAK911MhoYD880ujxhRtbHIsmyoZnP2FZkrhwm/YqBVmmmdS?=
 =?us-ascii?Q?726qb9UemzkgoknFM4RMga/zuYg07ta4iyhjIBuO5o567JQ3sBL+xhepQvNC?=
 =?us-ascii?Q?GDxB2b/MBUlwEzXRAcTZEXFUqly2BiEtoYLr7L8DddGnZ6htDnhCWxKxNNpp?=
 =?us-ascii?Q?puPXqFuQTvktl65w59X5D5YddATIrw/IiRMRqJKuEqTQ79DOelyNyGJvjFaV?=
 =?us-ascii?Q?92f6S4xGZOq99avNSltjDXELywkg7eTdObVHDpCce0s9skSh41L80BDGuAdP?=
 =?us-ascii?Q?TbRvx/+P5r8cnisDACPiOhSVYfSQZYo8RsQMictbcqehemCb7tSZDZkCZLLd?=
 =?us-ascii?Q?P6lZ0kDUwH1+HeD7JiLdo7ktRVLk/doDLGRc1bYattXtm81XeksR9x0z6UBg?=
 =?us-ascii?Q?RFaNP39AV2P0XmZmTJQBVY8XDa3qaa68V4nKHjbP1FQgQzAIIWO/rmEF4VhC?=
 =?us-ascii?Q?sLqoPp2b4TLOhrQssMe9b+2S8oNkx/AwMHpM604Q8P8MDf9xg3M3xXFemB0L?=
 =?us-ascii?Q?D2cTSAEUWkUjqorq1uwewuz/E24+4JmEOatEqAYCIKuChT+VAp7TPP7s0vjZ?=
 =?us-ascii?Q?tw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1693.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a4d2e1-81bb-48bc-c663-08dab0525e3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 15:15:04.0438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zzYWGET2glSnTPcSYS4AO9CaJebxHimqw5nKvQLMukbqigTUvRjS/iPUJqMZTEIsxmw181y7Ie43d22GJs2TFxh2z17P9SDTkye+0j8ntqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1430
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com> Sent: M=
onday, October 17, 2022 12:51 AM
>=20
> One-element arrays are deprecated, and we are replacing them with
> flexible array members instead. So, replace one-element array with
> flexible-array member in structs synthhid_msg, synthhid_input_report,
> pipe_prt_msg and refactor the rest of the code accordingly.
>=20
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3D3 [1].
>=20
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/210
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D101836 [1]
>=20
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.c=
om>
> ---
>  drivers/hid/hid-hyperv.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index e0bc73124196..208cf8d981a5 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -61,7 +61,7 @@ struct synthhid_msg_hdr {
>=20
>  struct synthhid_msg {
>  	struct synthhid_msg_hdr header;
> -	char data[1]; /* Enclosed message */
> +	char data[]; /* Enclosed message */
>  };
>=20
>  union synthhid_version {
> @@ -99,7 +99,7 @@ struct synthhid_device_info_ack {
>=20
>  struct synthhid_input_report {
>  	struct synthhid_msg_hdr header;
> -	char buffer[1];
> +	char buffer[];
>  };
>=20
>  #pragma pack(pop)
> @@ -118,7 +118,7 @@ enum pipe_prot_msg_type {
>  struct pipe_prt_msg {
>  	enum pipe_prot_msg_type type;
>  	u32 size;
> -	char data[1];
> +	char data[];
>  };
>=20
>  struct  mousevsc_prt_msg {
> @@ -232,7 +232,7 @@ static void mousevsc_on_receive_device_info(struct
> mousevsc_dev *input_device,
>=20
>  	ret =3D vmbus_sendpacket(input_device->device->channel,
>  			&ack,
> -			sizeof(struct pipe_prt_msg) - sizeof(unsigned char) +
> +			sizeof(struct pipe_prt_msg) +
>  			sizeof(struct synthhid_device_info_ack),
>  			(unsigned long)&ack,
>  			VM_PKT_DATA_INBAND,
> @@ -271,16 +271,14 @@ static void mousevsc_on_receive(struct hv_device *d=
evice,
>  		 * malicious/buggy hypervisor/host, add a check here to
>  		 * ensure we don't corrupt memory.
>  		 */
> -		if ((pipe_msg->size + sizeof(struct pipe_prt_msg)
> -			- sizeof(unsigned char))
> +		if (struct_size(pipe_msg, data, pipe_msg->size)
>  			> sizeof(struct mousevsc_prt_msg)) {
>  			WARN_ON(1);
>  			break;
>  		}
>=20
>  		memcpy(&input_dev->protocol_resp, pipe_msg,
> -		       pipe_msg->size + sizeof(struct pipe_prt_msg) -
> -		       sizeof(unsigned char));
> +				struct_size(pipe_msg, data, pipe_msg->size));
>  		complete(&input_dev->wait_event);
>  		break;
>=20
> @@ -359,8 +357,7 @@ static int mousevsc_connect_to_vsp(struct hv_device *=
device)
>  	request->request.version_requested.version =3D SYNTHHID_INPUT_VERSION;
>=20
>  	ret =3D vmbus_sendpacket(device->channel, request,
> -				sizeof(struct pipe_prt_msg) -
> -				sizeof(unsigned char) +
> +				sizeof(struct pipe_prt_msg) +
>  				sizeof(struct synthhid_protocol_request),
>  				(unsigned long)request,
>  				VM_PKT_DATA_INBAND,
> --
> 2.37.3

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

