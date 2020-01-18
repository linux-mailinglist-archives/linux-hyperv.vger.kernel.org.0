Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 081461418BB
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Jan 2020 18:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgARR3d (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 18 Jan 2020 12:29:33 -0500
Received: from mail-dm6nam12on2127.outbound.protection.outlook.com ([40.107.243.127]:39008
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726502AbgARR3d (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 18 Jan 2020 12:29:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htVcCx5oZio6pOv2An706/kF4L4viyz27QMC6iOXNbrVr5ZSEKOaeIKo6brQzvCuWycPopDW88+gxQjBIqhqYnL8d4xrD0HHfd+3IZ9PRNMXoXHzeb7nfm9BqllIklIezMyYMAAXGDh3TGdIxIFwZjVeGz2PZ41Qyec1VDDjzQYoL8PfvPBj+reT/OZJpVosukS4qi75XFKRzi/GGhKhZSCD+asYNNRN0Z38NsIxYsPoQ2XUHJxca+/Ix5wK0uLkAAvSO1rVfxXVMIz5gHAf7KtZDZYDeAvNoqTn1ZIm6RWQo+8Ok83HYi77CY/Ty4o2QVPQJuN3qwYAljoqLSwl5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOor5TVECSRAOFbN9I+LEx08LQy6VJqsyxw0EnsKtKQ=;
 b=SSDTGzBrX1Qpd5n1M6Qe1mofVlWq9iQozzucogIkrHaChRY59sz5yjSNZummmKAGCpNcwrgd5emiYHkYKpbVEgLq4gnP57XXmU37+AB4Zijv/DUjOLboCLT4GdQSfZPhD63xWoeh/OjIX71cet0soNi9maLeasruCWsmOGnNphoKoAg8xI+nhGF7Q/ncUMYkwgwE0ub677gHFdpznPrfDu9fvbGQWFQm6edAh/PLvxz2V3otP5glzCIkNyJTxZzIWgpDHOnyZ1ezN7X7fyeCCnOF9hrIXhwMUW9bxToyshI+ChQjYk5SksCSMnBwpsdS6TAa8hbv2ZWASXcwvohCcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOor5TVECSRAOFbN9I+LEx08LQy6VJqsyxw0EnsKtKQ=;
 b=Nlk0PKEFJssIEECZ2vhoymjAvm77uWw1YVMnVly46cedul4Ps/UXjkcvNaNlwIbjDN0jUN8LGvFcvwz1POlPJYyc24Zi1D7FwzE3kLZqYgbYbBz4VHX8Xrh1XheSsq1rahKuqknVlIIZzjhPnf0JYwJRDDMJWBUBlW047fCoJ+o=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (52.132.149.16) by
 MW2PR2101MB0891.namprd21.prod.outlook.com (52.132.152.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.6; Sat, 18 Jan 2020 17:29:18 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::f1bb:c094:cb30:ba1f]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::f1bb:c094:cb30:ba1f%6]) with mapi id 15.20.2644.015; Sat, 18 Jan 2020
 17:29:17 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
CC:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        Andrea Parri <Andrea.Parri@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Ignore
 CHANNELMSG_TL_CONNECT_RESULT(23)
Thread-Topic: [PATCH] Drivers: hv: vmbus: Ignore
 CHANNELMSG_TL_CONNECT_RESULT(23)
Thread-Index: AQHVx1Tg1xlBNcTrJ0KLEKFR1w6qoqfwtceA
Date:   Sat, 18 Jan 2020 17:29:17 +0000
Message-ID: <MW2PR2101MB10524758141F09806D8677FCD7300@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1578619515-115811-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1578619515-115811-1-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-18T17:29:15.8714183Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c22cbd7b-5961-4cb1-a220-690f9063ebe2;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4099c9d1-e944-44f5-f1bd-08d79c3bf24b
x-ms-traffictypediagnostic: MW2PR2101MB0891:|MW2PR2101MB0891:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB08910E83E63D30B2C9750073D7300@MW2PR2101MB0891.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0286D7B531
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(199004)(189003)(7696005)(2906002)(5660300002)(107886003)(55016002)(6636002)(4326008)(10290500003)(33656002)(478600001)(9686003)(52536014)(66446008)(316002)(86362001)(76116006)(81166006)(64756008)(8676002)(66556008)(54906003)(81156014)(186003)(110136005)(8936002)(66946007)(26005)(71200400001)(8990500004)(6506007)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0891;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PSUHx9epW9FgYSL+RhL7erpC/23EtfcxpN7085N0I0duQ10NeN5fV4nIsHFIb2JLixlqwjdknVzNYDRKobfqihiG6VsqZ5kjWTG+aQ6VR8QrAavDW9ngqkn6UmkVoHnymccOZJBvJtHvm1pXdMUoq2fkmoqFa2+tPf4vD/H+WHeM52RP4OOf0ATNNK76Uow2iLUAGQI4ZYlJSglp4dB+6EgqaUP902/WXJ0de+GZE7AJEjlfPEOKCNfQPQUFCdD/G1iJrhs2a9xx1spvLI+VYteoxQ+yGdNKBfe0wNCFrI2VI1NVd3WtInAi6jrbOrfZ2uq1po2b5CxaGqrOEMtqsjkfIUMid6IYoMB/FrxJyV7YWpWMz5G+vuoW3PTkrMrf+HCupP+dFvCT08rN80rGSUjcSt+jI2KLyis3Yt49g6+gCss6s+lvnYiAzUhvbEfR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4099c9d1-e944-44f5-f1bd-08d79c3bf24b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2020 17:29:17.6332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EJiI6lzd36b4sRiDoLF7b3K8R47zETcq3MHguSpyfurzn0nQOVr/feGVBmYmQ8Ls/HXWUkvVLwsbX19dmJIXzPtbnRvDJI39FX3fDdK/bxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0891
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Thursday, January 9, 2020 5:25=
 PM
>=20
> When a Linux hv_sock app tries to connect to a Service GUID on which no
> host app is listening, a recent host (RS3+) sends a
> CHANNELMSG_TL_CONNECT_RESULT (23) message to Linux and this triggers such
> a warning:
>=20
> unknown msgtype=3D23
> WARNING: CPU: 2 PID: 0 at drivers/hv/vmbus_drv.c:1031 vmbus_on_msg_dpc
>=20
> Actually Linux can safely ignore the message because the Linux app's
> connect() will time out in 2 seconds: see VSOCK_DEFAULT_CONNECT_TIMEOUT
> and vsock_stream_connect(). We don't bother to make use of the message
> because: 1) it's only supported on recent hosts; 2) a non-trivial effort
> is required to use the message in Linux, but the benefit is small.
>=20
> So, let's not see the warning by silently ignoring the message.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 5 +++++
>  include/linux/hyperv.h | 2 ++
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 4ef5a66df680..c838b6f5f726 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1033,6 +1033,11 @@ void vmbus_on_msg_dpc(unsigned long data)
>  	}
>=20
>  	entry =3D &channel_message_table[hdr->msgtype];
> +
> +	/* Linux ignores some messages, e.g. CHANNELMSG_TL_CONNECT_RESULT. */
> +	if (!entry->message_handler)
> +		goto msg_handled;
> +

FWIW, with this new check, all of the validity checks in vmbus_onmessage() =
are
redundant and could be removed.  There's already a check here that ensures
msgtype won't be too big, and this new check ensures that message_handler i=
s
not NULL.

>  	if (entry->handler_type	=3D=3D VMHT_BLOCKING) {
>  		ctx =3D kmalloc(sizeof(*ctx), GFP_ATOMIC);
>  		if (ctx =3D=3D NULL)
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 26f3aeeae1ca..41c58011431e 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -425,6 +425,8 @@ enum vmbus_channel_message_type {
>  	CHANNELMSG_19				=3D 19,
>  	CHANNELMSG_20				=3D 20,
>  	CHANNELMSG_TL_CONNECT_REQUEST		=3D 21,
> +	CHANNELMSG_22				=3D 22,
> +	CHANNELMSG_TL_CONNECT_RESULT		=3D 23,
>  	CHANNELMSG_COUNT
>  };

For completeness, I'd like to see the channel_message_table also updated
with these new entries so that everything stays in sync and is explicitly
defined.

Michael

>=20
> --
> 2.19.1

