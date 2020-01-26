Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F10DC149971
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Jan 2020 07:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgAZGIZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 26 Jan 2020 01:08:25 -0500
Received: from mail-eopbgr700106.outbound.protection.outlook.com ([40.107.70.106]:52545
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726098AbgAZGIZ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 26 Jan 2020 01:08:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=km3csyVh+myiMcrz/Kmq93v4gJ6IImK4pgbFvu5+WRDqh5kWIo2b6bM1dR+KBcLa/p6VanSeY9qfxE4pm+0Md4BVFUWn+CDc/waqbhHHSdjHu6HMxINEayCeKDmlhn+IvdQdFnW1I6HyQUltpytCwofQoRnr5amcRnHRXts9IFwmE8Fq0aE1fdqUN3h5F/iXw3Mm0F4GrE0p5Yb8iu5Qa0eJzpjIlGDjOKtAtWvOf3my4Fm+tvSB0W7MlOmyakNTRGnL0/u2itO4EbYhmgBJcM63i9v4ZgwpZng0jZZFCUaxmtn1z2gWy0ZkU6Gy9bhWZfZeZT3WI754VYTFkWyP4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJxZBMQaWQae0QhqmRFxRBn0qTquFusV+aDyyXtn9eA=;
 b=JDO1GBz/TKoay/fs+kDAgFbPgqTPRkaMougWDDjZdq9bHg7rGonOIK4+qhDUhAH+tcLXUGvkZMpImX5dGGs3ZC3rduqnnQZQpDrZNS1d09zyrDk+qN9IohfQ27wIjuktgXVPwIYBEkWKF5PMM/NL7Dk8FJLdgsO3cIaPs/59O5NwQ6JtI0FGSw3zaX0loCyP7tmHkbU6LT6dNwbyw2YDpTttGXsGnBEuj96W5newAs9ZkkkkhqmMYC61xNBYX1rUIAeayMNt7FcUwW7jYgUDk6WjT2TpNM8V3pbMKuPOfclB0dv5wmBAC0xE7V6sHDf2aywlT34QLVciGprnU0Wo7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJxZBMQaWQae0QhqmRFxRBn0qTquFusV+aDyyXtn9eA=;
 b=ibI06EPUXK9QJNvmTziHz7XO21p7T7CA3zFFzEmxoIT472wFhzwyR5OFzq0Mnr2zI/avyph9Kt0yhMr4tbKN+hajbzDtlSVPLJv/o4fVmIVgFn6sk+f7EAzUFUklC4tzR2BfhjUJb1ZZzyr9evc35ciBhx5nkOcaOGUeNzPvxfY=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (52.132.149.16) by
 MW2PR2101MB0939.namprd21.prod.outlook.com (52.132.146.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.9; Sun, 26 Jan 2020 06:08:22 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d561:cbc4:f1a:e5fe]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d561:cbc4:f1a:e5fe%9]) with mapi id 15.20.2686.013; Sun, 26 Jan 2020
 06:08:22 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH v4 3/4] hv_utils: Support host-initiated hibernation
 request
Thread-Topic: [PATCH v4 3/4] hv_utils: Support host-initiated hibernation
 request
Thread-Index: AQHV1AyDwjF9aAP+4Ei3wIUnKPBAtaf8dTxw
Date:   Sun, 26 Jan 2020 06:08:21 +0000
Message-ID: <MW2PR2101MB10520551E6D09AC561E512AAD7080@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1580017784-103557-1-git-send-email-decui@microsoft.com>
 <1580017784-103557-4-git-send-email-decui@microsoft.com>
In-Reply-To: <1580017784-103557-4-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-26T06:08:19.7036202Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7948e975-f316-4816-8a85-570329dcc8df;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c6220db-5010-4b91-6f3c-08d7a22625ae
x-ms-traffictypediagnostic: MW2PR2101MB0939:|MW2PR2101MB0939:|MW2PR2101MB0939:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB0939B2DDDD4AA3A9D619B275D7080@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02945962BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(189003)(199004)(9686003)(7696005)(55016002)(316002)(10290500003)(110136005)(81156014)(81166006)(186003)(52536014)(5660300002)(26005)(66556008)(8990500004)(66946007)(8676002)(66476007)(64756008)(66446008)(71200400001)(76116006)(6506007)(8936002)(478600001)(86362001)(33656002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0939;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fv1HQRUaXnAO4VrB5WBB3+2hnfXNtmQt31IirGRv+rx2hNpZD7TEjcCtLCszykaicTGcAzCpHnJnedW40ZJUI4iCOwtUNLsMzyVx5ORbtfq/WWGNGDL8BKUqh49upk0Ost2DNIa8A0IN9FJT0Il9qu9UfEO6MUPHj5hexwjtVoi6Wocx41ZsfFjlFgXmLmTmNMplkazL3NJIlGDkRWXADJLgl3YCz51s6Z94W8ESp+NbLd+SOOYX4GajPj17HwD/FyyHE9tRXmgkRnGeC7+IIDLeVENY48VybQTpdZm0KPDAtbXamymuc56X+a2mf9SpjSgCos2sxH4y3t/vxjNcwmVDFIDTEvboOg4mvQWLKlbZR040ZZG3Z4DCTACNAvPSgzRYLef8zeR9AGRY5KTOnc74xrMSLaQTaDqrtxX6QeUSEj8J51sLqPlwUvsq6wVJ
x-ms-exchange-antispam-messagedata: ECiColrdU6h5nDzIxaDGHdZ3HWxXtXqoc+/bX6wa84YYCb198ImxRJukMFL44N6QJZxLk9j0TKrlEWU8HQzfWfTWwbV2BWDzwPK+Wa9aRix6I7kmug9iHd66ZZqxUjGZ2GH6ZItTrNK67XmkcSc4xA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6220db-5010-4b91-6f3c-08d7a22625ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2020 06:08:21.9880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6H2kATRNg7YF0qgHst32Xjgb1wSsXNDnlZS7g7cic3ujNUexJ0ckyZDA5mQiJKQ6TEB/7/UnmHwOzaeX5p6E2UMEXrCN9ZKrRq0xA2eIbSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Saturday, January 25, 2020 9:5=
0 PM
>=20
> Update the Shutdown IC version to 3.2, which is required for the host to
> send the hibernation request.
>=20
> The user is expected to create the below udev rule file, which is applied
> upon the host-initiated hibernation request:
>=20
> root@localhost:~# cat /usr/lib/udev/rules.d/40-vm-hibernation.rules
> SUBSYSTEM=3D=3D"vmbus", ACTION=3D=3D"change", DRIVER=3D=3D"hv_utils",
> ENV{EVENT}=3D=3D"hibernate", RUN+=3D"/usr/bin/systemctl hibernate"
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>=20
> ---
> Changes in v2:
>     Send the host-initiated hibernation request to the user space via ude=
v.
>     (v1 used call_usermodehelper() and "/sbin/hyperv-hibernate".)
>=20
> Changes in v3 (I addressed Michael's comoments):
>     Fixed the order issue in sd_versions[].
>     Moved schedule_work() to a later place for consistency.
>=20
> Changes in v4 (Thanks to Michael!):
>     Used a compact way to handle the work item.
>=20
>  drivers/hv/hv_util.c | 49 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
