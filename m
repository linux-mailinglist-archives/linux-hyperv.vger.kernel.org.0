Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3294149966
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Jan 2020 07:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgAZGFr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 26 Jan 2020 01:05:47 -0500
Received: from mail-eopbgr700138.outbound.protection.outlook.com ([40.107.70.138]:37729
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbgAZGFr (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 26 Jan 2020 01:05:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0639ia8y0Ij5BiEsH107RfMXnDNQFoNwtEl1iJ9FBrarGylsz7jZlmb6QJ/z1XycSXHh1IbmvDqgnphPEz9FAD0kJLzBW77ouG/Uk++KBLIXHtjJ4Ic2kB713BfebS3Z8+ajufv1kLkfpcQRzeHfvpMLpSJSV1ZZHlxf78gNz6giPSYFq5oAG/RGfILfKtKBun98rgsmMxJQ7UF5sGx4owOV+nGcMMj39GRTIu3bNb2M5ftGO2m/htIM3yyIZmpjXyUOAhsK+JIZcUWSzqqty89gO8VqtpOH51NOIeg3rimhfpwx1C4rnwxTGWu623gNPgAEXN11CiA/BNs/N0rZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjiVJ0fWwn3ZgDgDz81DsHC54N5NdsxsFpda2bwYVs4=;
 b=ipqcmKxRFSqHvTd0W3w0A1mesI96i2NZDs6J2VgXkDq/FgOKTw7f44jfJFPtuMP0KWtk49WrE6fCfJu15oVKE69DeSOQcKmghDB74etk6/E72S6a37CwJtLyZjjjKQbElgnkUUVtN4ZPlq243FzdDIebHKksbreQtcO2tRMcVk/MV7bKIoXw5Vp+rR/D+E5lCI3aIsbPKYKq0k5ohpDjMXHNMglWUls7MKo/NLzIuV4rjLIDx2VUnd8laR3vLjbekX2NMcJhwlQ5B+/e5qMzSN003gFnECBRZLU831GdFX6G6NiwuG8Rp4pivE/Wlr5tQMs/LAKnfUwxxVtWrMtiDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjiVJ0fWwn3ZgDgDz81DsHC54N5NdsxsFpda2bwYVs4=;
 b=dFW7pSaJI9LL2SqE4IgMV5EELS0tD2xk+GJjtQl1xEQo7CCEizJP456OyvzWCuYj9ff5Ci7E6lX1Sdbg6wJqG/5h0BcmgtmGjCUsiKW+an/7Ld8a4wUV1lXnTSfaoQzCkK96zzUA8HZl93Q9IMyGBOtdbHlhIKxQbTarPqJCbr0=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (52.132.149.16) by
 MW2PR2101MB0939.namprd21.prod.outlook.com (52.132.146.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.9; Sun, 26 Jan 2020 06:05:44 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d561:cbc4:f1a:e5fe]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d561:cbc4:f1a:e5fe%9]) with mapi id 15.20.2686.013; Sun, 26 Jan 2020
 06:05:44 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH v4 2/4] hv_utils: Support host-initiated restart request
Thread-Topic: [PATCH v4 2/4] hv_utils: Support host-initiated restart request
Thread-Index: AQHV1AyCkmMSuVt8DUeFB1B6MNsKeaf8dH2A
Date:   Sun, 26 Jan 2020 06:05:44 +0000
Message-ID: <MW2PR2101MB1052C5D5BD40F86DE4E3621BD7080@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1580017784-103557-1-git-send-email-decui@microsoft.com>
 <1580017784-103557-3-git-send-email-decui@microsoft.com>
In-Reply-To: <1580017784-103557-3-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-26T06:05:42.6105379Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e774f026-37df-4985-b1e9-0a7c552dd409;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3103631c-a496-4df3-0ece-08d7a225c7f8
x-ms-traffictypediagnostic: MW2PR2101MB0939:|MW2PR2101MB0939:|MW2PR2101MB0939:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB0939E6042EFEB9AF37C9A821D7080@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02945962BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(199004)(189003)(6506007)(8990500004)(66946007)(8676002)(66476007)(66556008)(76116006)(64756008)(66446008)(71200400001)(33656002)(2906002)(8936002)(478600001)(86362001)(10290500003)(316002)(81166006)(81156014)(110136005)(7696005)(55016002)(9686003)(26005)(5660300002)(52536014)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0939;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t5EhYAjRGBlm9mg75helUvGRinXKJ8ReV9D6pHFLWHIrTQc9GGLoPwyZm+5ykWKmNC5I1Dp4/hXfo/Ga2jmAODtnJZYnumktfcjuTEkVRuIWFwI6+w02T/ixML2UkOIm/h+1+mxeaBmAlzp4JyVpRCGoa0cactMsEUywNjpx9l1r6XQCj0nvCXOsIOp0Tx7H3r2EwqbT5b26BdVpiVObzDJejeonbMTjn9XSr38B7WgUYgjZ7HvalvA8T1q3Sd5qSi7Nb/sC9vcazf3gOpUchniLy77ftB6+ErUJMCXBt6vgIwznSAm4Co8HSGpSS/Fd++TqoJwaN/28X9sgOhnTPueTwcicaVbSqeoeK+hiwGg+IFzQvuRDWje5C9Nf+3nB20gXLaXAiWNLQBKIAJdJUTW+cFndP80twv4ATJYoP2n9yhaHkfC71fBSjhXx0tv0
x-ms-exchange-antispam-messagedata: adh36pw9vHpWONYPVB1h6ytcJt/cHZhXc6oeNQyU2hE6v66VMe0scClnZNMXv2QEVBRNHJ+sRJ01XbyHiiqcQnT12X9LsbYcb5HEba3Q10V0W/vnTlTEW5q2T4u9qOTxa9aS6tpHfmceKnRwnKP2qw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3103631c-a496-4df3-0ece-08d7a225c7f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2020 06:05:44.7607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+q8ZyESXPeCzQQPxhvoagx2domgT5LdhgI6Rdbite4qFm84311/PqqaZJMWVF+LBkTiIdPaviiXz/WEayT6QRC1Kt6YGJ6zN69n9I8G9RY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Saturday, January 25, 2020 9:5=
0 PM
>=20
> The hv_utils driver currently supports a "shutdown" operation initiated
> from the Hyper-V host. Newer versions of Hyper-V also support a "restart"
> operation. So add support for the updated protocol version that has
> "restart" support, and perform a clean reboot when such a message is
> received from Hyper-V.
>=20
> To test the restart functionality, run this PowerShell command on the
> Hyper-V host:
>=20
> Restart-VM  <vmname>  -Type Reboot
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>=20
> ---
> Changes in v2:
>    It's the same as v1.
>=20
> Changes in v3 (I addressed Michael's comments):
>     Used a better version of changelog from  Michael.
>     Added a comment about the meaning of shutdown_msg->flags.
>     Call schedule_work() at the end of the function for consistency.
>=20
> Changes in v4 (Thanks to Michael!):
>     Used a compact way to handle the work items.
>=20
>  drivers/hv/hv_util.c | 39 +++++++++++++++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
