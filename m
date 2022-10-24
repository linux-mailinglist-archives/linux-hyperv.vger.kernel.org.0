Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E58860ADC6
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Oct 2022 16:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbiJXOek (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 24 Oct 2022 10:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237206AbiJXOeF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 24 Oct 2022 10:34:05 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304259F360;
        Mon, 24 Oct 2022 06:09:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8mScEK8PWMbrJ/sxIVzrEW60ulSChOzeW3Ny494dtTZDKAtVqCsqSLn3x2y54dgTk8tWSJG+XZjePXtFqUssAwl1G4zjs1ssslJuZ60o8YJxUes+dsYZbzZ/y6/pHali2WrPnRfmJM2KVxE5wAIEmAE+6ECOTo7rRAmfZOdtGlO9l8sffeZ2HQrBiLFh8MkoNSgzfajvJpp6Tb4Nddi9ol/4cVPh5N1YsO6BQozd6Sgaa/dpc+AJD8boSSUbKcfGMneld0bniIEtpfLkhXK2aB4Mho/r6198z2YQm8x5pIoSWfTPeF2O0vmXvq4Y1vAYkeP2ck9zotBsMvYO3Odeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/f/0QnoV9CG+8Vh3zC+Rc/P/kv1BHtT89fYX2qh8pA=;
 b=ij7mjUkNd9g2/IFJyCMdE3blVm4ioZe0JMb3n2EAtMWNw8Is4/mXX//aA4JumeUIVptizAlTiUg0Y2IIbmr6rUqlSoAAdOjZfk0tWtAnunt95L8JCeRKeCh+PZeQ2716fQxBdisIXwsFhrtkHhHFZcNo6wUp0q+kA0ZRRCD4yAW5ucvoyZUIoH2U7cHeGequuC8fpNg2XaBmF5a8gobjZI8hOy9iJa5zC2VDmLbI6/M4Cgg4+azVNIBcJEKM2u151qzoSZf9/vOOQCdQM9y2qyWv6NxHnsT9yjImozu3PpHP3d1cvA8COoWd1uVmsr1oC8ryZbf60Si/FmSByJv/pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/f/0QnoV9CG+8Vh3zC+Rc/P/kv1BHtT89fYX2qh8pA=;
 b=HFKfBhB7TXybgEckhOmOvcCtcUgBF734k58KMIBaIFhaQJBGIcguAgMa5dTFrn1KgBmotuzSCVt34TYlqu3gl7xUBZo/WC+hJNbyilb0jVtiG+TyQH2xdhtmDXchPhQAdqByWOqMIx2dMw8Hbu+LT7He6bOaH0fsP4dy0bJFzaY=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BL1PR21MB3160.namprd21.prod.outlook.com (2603:10b6:208:394::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.11; Mon, 24 Oct
 2022 13:04:37 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%6]) with mapi id 15.20.5791.005; Mon, 24 Oct 2022
 13:04:37 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [next] HID: hyperv: remove unused struct synthhid_msg
Thread-Topic: [PATCH] [next] HID: hyperv: remove unused struct synthhid_msg
Thread-Index: AQHY50Opj4DvWwB85UygYbYyTD2kgq4dguZQ
Date:   Mon, 24 Oct 2022 13:04:36 +0000
Message-ID: <BYAPR21MB168847D621D896906222390ED72E9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <Y1XjBjiE39bPNj1d@mail.google.com>
In-Reply-To: <Y1XjBjiE39bPNj1d@mail.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=44585f42-80bd-408f-91fa-8446addfa354;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-24T13:01:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BL1PR21MB3160:EE_
x-ms-office365-filtering-correlation-id: 41bf8edb-9129-4a22-29f1-08dab5c04dc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 81Zc5ci3x8IKubbhMV4ho/L4oP0mQW5bpI29dXcmqjKnFyJoNbNILhYGxgZnJQle2K8y8uKTA6osil+6whQNujxUQRnPZACkwQX77XvyhqIUzoK7IOUHircM36q/Jksd77pie/b7+89kvndW7T2lr8Jf4g30b9nGYaQUYbUnvyzWUeEkQhX0v0r9kgcLe+BrQNkSwe2x2ExWi5pmYQEpLCrt6080n1Sn5jUoo0/GeBWIkRd5uEgzZb6wCUegMPjO9M7++HOguKUK/D5M098tuXZfosCHXrs/vS5IPdP+EpA4ALbdJ2bZSjKq49C7IU+Lwa42E4x/jWm8IDJBTbigUru3Vm8FhVlb9KZMuVSrGM9yg3FZ4hHda4oE3t9mD8xEnoE9+sE0YKT/xjtg0Q/xSlheVjuxEarcJikk+iw0mXcQSI4oyikFukNFDqgwICDoX3AFPdz3E60X/J/Y1cQ+w5mRAXz6Do8fVp+nH/MaX8WcKoWTQ7o8WII8COpIMcucPpHd7weQqrkpk3qaVoqjIGR0XL7LquBQR8qggIm2TTMxDZdfUJ7euPpGAn4jh4hg5OToCiIFuWWrX7jj7LWImuLtg2fyZT8ElWy3oJwn65SQ+2PSYIxAbGJs6O1o5dGp1J18QNxllbw6uU99cco0fxkMJoR56zZYY6IbPmK7Ai+kKkyUFpq8elslaWT7OaajTVt5WlCupC9iru8NzGfoXnqiJGdVcSnexi5BxFb24F9WVSUkMRHA6p9bxGAdwFVTATrxAxipYAwkUFH3GDeJ7P0TcxI/uPW5Or5o8DiZvShS5yRmzxX6es1P1W8l7Z4g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199015)(8990500004)(2906002)(6506007)(9686003)(8936002)(33656002)(5660300002)(52536014)(4326008)(86362001)(82960400001)(38070700005)(478600001)(186003)(41300700001)(66946007)(26005)(64756008)(66446008)(76116006)(8676002)(71200400001)(66476007)(55016003)(83380400001)(66556008)(38100700002)(316002)(122000001)(82950400001)(10290500003)(7696005)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wOjKqGenB9K4VXPbucZALOOCyvZnAFUTtdEV8tYnjzbqSNG3wYlKwbomNN2a?=
 =?us-ascii?Q?TZSmGCCjGXdAZQkzSJphNUwkwIwnOX2S2JIMyuyqKPqEJfJ5NP0280U0vn0H?=
 =?us-ascii?Q?f/r853cHxbmSwf5Agcy43zD5gDwmbj1/LiBtB/Q+ioqzYCivNCuMii5/z2so?=
 =?us-ascii?Q?haYvOcpaDzFwYXVGLP+WW1JV22XoxTLVG1s0Op8w/adW8kyfs3yPJXmjjnpq?=
 =?us-ascii?Q?rB7mjS9wiTfGVpN6HY/m8CHqaC/yKSgZixhDXR0pkaCLZnkcy0iJUM6Vv1lU?=
 =?us-ascii?Q?ggAB5Zyl7yF6rp9vMWwV6yqX6t23axiEnXh9HVNFDEXSKPNOp1lZER5Z1Qjz?=
 =?us-ascii?Q?qYsYgOf+S/XI8HHpd73Ps5qVx/csTuODVbRKN0j6otDSM+jJuVTR9li0GllK?=
 =?us-ascii?Q?OXjIkzTLSVWQlIONqxELGkX8gWnlE8k+8FXEhSUMGKou8DoJRuOieDHZMY6b?=
 =?us-ascii?Q?ZliHvukRPIJBrzIVV6qrneROQUXiHt/nr2qEMs5/t5RZFbzawoeYTWx6AB/I?=
 =?us-ascii?Q?cw6QWGpHiFwzCngnMAyJ70Uw1gc4xoFc0gSdDnlCQoECU4axoP8+2GAN4Awc?=
 =?us-ascii?Q?9fbcdmeW4BF2XR6ULoLIY/MwGJtr8C5r4zUmGj4NzCCknQ3XIsK5Xlm63wHN?=
 =?us-ascii?Q?gZYDHZkdgw92QSUzgml02fIdGrUyko1hZoJAM7P3IRLHDGMHTC1WveG2KRNT?=
 =?us-ascii?Q?Zv7dYJfVh3Q0jFZJWYJ4Jzk4B7M0/XX9Yq2IN7UBhWNBqiNOUNsDu5CKN5QH?=
 =?us-ascii?Q?MdHBbIigaHN0K7S6W30PRhoKZGhf34ukTS9+8t5QEwORXIniUHFalPgLPOoC?=
 =?us-ascii?Q?kTOHvOD/kCxgBtGu68jpxF3avaz5Lo7Bjw1ku67eTxc4UKtrwQmjRkdgGKZK?=
 =?us-ascii?Q?CJvlBftoX+Qo4r0YVybxUFHw4Y39LPVLOqvWPRXoBIgWecZY3NXtaBz1URrK?=
 =?us-ascii?Q?dd/dfJsg7mHJROh65uN2gskDdX2tjZ80Hy5lFw2rmosplEnUdVZiJZyNDQ7c?=
 =?us-ascii?Q?sa2QFSZ5KB2kZLRduPazFdt/S8Fp5HgJHVbqcjsbIPdE+eYet3jRXA41Ns4e?=
 =?us-ascii?Q?YEvog1va6XzfOEk16WPEMIaX1A5ItG3N+lc0KhX6L8suO1cxVBhYiSj9jx9N?=
 =?us-ascii?Q?fAx4xFx6KliULc/TXCezeVJtCspMCXjBhKeYcQ0LTuvdPvk3Alh3wICitZLH?=
 =?us-ascii?Q?XbzmgFjD96CvpJYscznb9DDgcDrwy+CM4W8FGPA6vtTInh1+0Q6l4SVsUFU1?=
 =?us-ascii?Q?wQrtfUamTgKfNitZOVgRcjz/Gi81hy3yzZSto7V5JT5KaC8CprmE31r+UJGr?=
 =?us-ascii?Q?DqnI6QagAMGhFUQaIJDAM1jCnw6AFNkzi6G/f8KL63zwYV6KqA1Ckxu2kWQM?=
 =?us-ascii?Q?RUcPsH1/2NNPZFzTEyO1+q+kGRS8/Iqwu2CmBxiFDz0MLNEdq/ZqSh/8Drsq?=
 =?us-ascii?Q?zn4cmp8+FHBzKsGuKBPOoegtQM0KmuvtmXF/5B8TwAFKdRNGkz+TVM10jG73?=
 =?us-ascii?Q?yQXim7ES1lfyYxYGCwkkxF4lNuiDXaQ1fD0frlexEi//TAwtf2atxa+2H04n?=
 =?us-ascii?Q?n5Ds/RLdLzExu7ZDD3TeQ/vLXh7GeqbcCBq6mLkNGDUZ6Lnc84OOeoP1sp0f?=
 =?us-ascii?Q?ng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bf8edb-9129-4a22-29f1-08dab5c04dc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 13:04:36.8730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NugRGTEINATNqwNW4jwL/7RIqBUS86qv7wo6vl1qPk2UaaNqPeX1sgFTQyIBmwavw75AID8nwxnyGFopNPoEZ74aybJXYuhT3ie7Qp/Jm/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3160
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com> Sent: S=
unday, October 23, 2022 5:58 PM
>=20
> struct synthhid_msg was meant to be a generic representation of the
> possible protocol messages sent through VMBus. In practice, only the
> header is read and depending on the message type, a cast to the actual
> type is done. Also, SYNTHHID_MAX_INPUT_REPORT_SIZE constant isn't used
> which I suspect is a leftover from the refactoring made while this
> driver was at the staging folder.
>=20
> This patch removes struct synthhid_msg and refactor the code
> accordingly.
>=20
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.c=
om>

I noticed this as well when reviewing your change to use flexible arrays.
Thanks for doing this cleanup!

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

> ---
>  drivers/hid/hid-hyperv.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index 208cf8d981a5..0be717bb09d4 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -22,9 +22,6 @@ struct hv_input_dev_info {
>  	unsigned short reserved[11];
>  };
>=20
> -/* The maximum size of a synthetic input message. */
> -#define SYNTHHID_MAX_INPUT_REPORT_SIZE 16
> -
>  /*
>   * Current version
>   *
> @@ -59,11 +56,6 @@ struct synthhid_msg_hdr {
>  	u32 size;
>  };
>=20
> -struct synthhid_msg {
> -	struct synthhid_msg_hdr header;
> -	char data[]; /* Enclosed message */
> -};
> -
>  union synthhid_version {
>  	struct {
>  		u16 minor_version;
> @@ -251,7 +243,7 @@ static void mousevsc_on_receive(struct hv_device *dev=
ice,
>  				struct vmpacket_descriptor *packet)
>  {
>  	struct pipe_prt_msg *pipe_msg;
> -	struct synthhid_msg *hid_msg;
> +	struct synthhid_msg_hdr *hid_msg_hdr;
>  	struct mousevsc_dev *input_dev =3D hv_get_drvdata(device);
>  	struct synthhid_input_report *input_report;
>  	size_t len;
> @@ -262,9 +254,9 @@ static void mousevsc_on_receive(struct hv_device *dev=
ice,
>  	if (pipe_msg->type !=3D PIPE_MESSAGE_DATA)
>  		return;
>=20
> -	hid_msg =3D (struct synthhid_msg *)pipe_msg->data;
> +	hid_msg_hdr =3D (struct synthhid_msg_hdr *)pipe_msg->data;
>=20
> -	switch (hid_msg->header.type) {
> +	switch (hid_msg_hdr->type) {
>  	case SYNTH_HID_PROTOCOL_RESPONSE:
>  		/*
>  		 * While it will be impossible for us to protect against
> @@ -309,7 +301,7 @@ static void mousevsc_on_receive(struct hv_device *dev=
ice,
>  		break;
>  	default:
>  		pr_err("unsupported hid msg type - type %d len %d\n",
> -		       hid_msg->header.type, hid_msg->header.size);
> +		       hid_msg_hdr->type, hid_msg_hdr->size);
>  		break;
>  	}
>=20
> --
> 2.37.3

