Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635883CB8BF
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jul 2021 16:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239786AbhGPOgu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Jul 2021 10:36:50 -0400
Received: from mail-bn8nam12on2123.outbound.protection.outlook.com ([40.107.237.123]:34657
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232988AbhGPOgu (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Jul 2021 10:36:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsLGKsDtbRE/q3us+z5EDecbuI3cZw16pSInDVxQQSS1Jm0g9f4F0MKylc5fz7ZgEGYcnpaCTvf0eoo9TmpR+ofu/xAGiPMQvptDQ8ZSNHByTYMmJQIsAPAJvTUGDRSFWeCHqKiAbj7/cpG8E0NJYLe9T14+TZ9cqA0b6DkM3VLjSqhJlw9TibtUFe9XE1cK0zW06ZYAv+98jqezHyio+uT102qlKUD014UQ3PlWvb1rncvOWG1Wwxsz17kkPmEkFBTo7YlQY3zvwzu3WmkcA6tAbuQBVQbeV5CRAJ09C9EMv+1PvoRh1uz5nZv4yG2s4wWkO4x88NwV+Qx1eCNAbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEqeeZOAo0pIKmq/sfgXkk/GBKGkd3kbOAKEJ3SbKM8=;
 b=QXYZz7WXGv3/6/QqUDWteMYIE67XLmtHxGt4RS2yZT1zDi7EW8/0nHxshoGbLNfEz1RhkChvQ01f30unE3UtAVz7CGnCsw0y+kuI8GGTzQVrUEj0koWDyXbzEqagUpMPYwKIB6d49k50vN3g6svct2n/ZwAdCq5Iy7erFJLOhzRb1vd60+NW3QXd7A3wQf70Y+b6yh6TKWL5IdIOOjoLlvsOw2r/nsWbPLnh7AD/qdpL/ho7DDSa9lKvB4ub4wjiAx6Uav8ImJpMC/1Hl3DmOJugYOabyhxIDYfDiFiV9KProc6mvHQ9ve4kAvTiyVARimk96PibjBQ1DQnzvDhgRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEqeeZOAo0pIKmq/sfgXkk/GBKGkd3kbOAKEJ3SbKM8=;
 b=HVzyBrICafQk7WWw4yMLfnjw/AKX81IZtb0aAnYLHHv1ODBYWE7DdCriYQgPxyJdDsDk3uTkarAA7UqesUw8siac0bIcv7VTEJ4sRVdcgQQJdUopdG3pxT05AsQXMMsFnB74mfk8O5yWAfSE0tJNrLxDGE3RJGm9qxFRqKbhv1o=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1969.namprd21.prod.outlook.com (2603:10b6:303:7c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.8; Fri, 16 Jul
 2021 14:33:52 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cdf4:efd:7237:3c19]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cdf4:efd:7237:3c19%7]) with mapi id 15.20.4331.021; Fri, 16 Jul 2021
 14:33:52 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Long Li <longli@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: RE: [Patch v3 1/3] Drivers: hv: vmbus: add support to ignore certain
 PCIE devices
Thread-Topic: [Patch v3 1/3] Drivers: hv: vmbus: add support to ignore certain
 PCIE devices
Thread-Index: AQHXeFpV149Wz8Vcek6g9e2IAt7E2qtFrgHg
Date:   Fri, 16 Jul 2021 14:33:52 +0000
Message-ID: <MWHPR21MB15936EB2FA28E5849C0CC55ED7119@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1626230722-1971-1-git-send-email-longli@linuxonhyperv.com>
 <1626230722-1971-2-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1626230722-1971-2-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b90e333e-efa8-44be-9069-d9f6e3ae859f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-16T14:32:08Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d11c9f6-8870-4cdc-097f-08d94866bc15
x-ms-traffictypediagnostic: MW4PR21MB1969:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1969276D20B50FF365803AF2D7119@MW4PR21MB1969.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8oDjQ+gHcNEPx1CCBrqnLInCy3VyFh4lfnEmjmB5DqDkTIno5cUEguMwuLYCdp4Tzayjj0uBqEIqh3EssD4nW1zR0t4ch+dCoGsr2tS9Tc2QYtuZ/mTsXmXCAt1C9RM43A5H7F8QFAzggcyzcQMCIgIxap0ZcgyteLbng7s+cRnIQc8V+27Ws3PnS/oJK/j8RjLnpAP5tW7/VGsD2+RRr0IMfOEG0vxBr5c1uxI4Wc17/dC2JNwewR6WcN4j+m0peWDvOgGTlRdZK7KPr1uTJq8esKRjn+BHmTfUtq3UHo2v63+k8xXg8Cpygo0u7ifL3ViaA3kxvXJe1u/QS63HOpTvUNW2sut4FMjO2wutLHm43u+4evu56kAdOsr8wq5LucnKuPxlLNA8sTntNILxqWYzeaOm/9yL7EwEgV/RodqgLHVsqxFKNNEeXhrSZ6SfxviOq8zeqUmc0KB5ueYNrw0A8xzJ4B3gavs9EVwMHWc4xOSqXMJqsk3K+YRzj0NxO1LbO64jXfm1DdE26YrUfiJfJgcdfMvCMM9iJnoT0HGaChH2q0AVAFw+XJgpK2+0K4V6+69rXJ8YcpOpf+7WgRmQ2U+/6luIgdD7BAOauQwAP31Wsyh6kuwdKDso/VuDXS7Mkg0/MZkH8RWgYhWyeQK8dnuVNvQSMQNpkL3O/mFQD1uWvYu5REBbrsCbqrSyTcgIrcCJZls1BctxkY4YPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(186003)(4326008)(38100700002)(2906002)(8990500004)(110136005)(10290500003)(316002)(55016002)(26005)(71200400001)(8676002)(33656002)(82950400001)(107886003)(82960400001)(7696005)(66446008)(6506007)(5660300002)(76116006)(9686003)(66946007)(66476007)(54906003)(122000001)(83380400001)(508600001)(86362001)(66556008)(52536014)(64756008)(8936002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eR41fmEDQmA3z6dDMY8azQDVGuyK5ML/D25ulVaqNWeTh3FBUhiqlHfBugwe?=
 =?us-ascii?Q?9wFkmztyng8JsiIEwcezZwfQXWB6ABmoXE3081g5wkg7+onDkYeS3qjmT/kn?=
 =?us-ascii?Q?5YY5u9lxH1zg3ghXpDHDBe6clpr/3k6gyhtSaCHPKhNMbvUmHQAmcdzh5es5?=
 =?us-ascii?Q?iM7VehfAFxG8zmov6WkdGsSTolJiIQsmBodSL+BUwpyBGspGZJGHCMU0+XvH?=
 =?us-ascii?Q?neXOXKjtGdXDDcEJUThyWUzd2x7SBj0h+kU4mJXZ2KalUJdvPUKvEpMAMhme?=
 =?us-ascii?Q?vYw/6ezNvi+YVmLpK/rJgN3njFlANWCJtF0KmenTEYKMshRidDd3On7MReae?=
 =?us-ascii?Q?+EtU6g3esKK0GpPAYlGREcPSvlYAv0m0iM7SDpbV3QkCwukHyby5xnc4Y1/L?=
 =?us-ascii?Q?Jo5FAtlyilrVeQQHiXg27LIpWIEmdg1Sd05VMF2gz7cPGMoCiWqolFY0OOPq?=
 =?us-ascii?Q?hyawLZY77iOEnPgLwPqffoycDITuBLUti7jf6cDxgrJmnR7ys6BvbBYq71JS?=
 =?us-ascii?Q?QuGxO+VlH0XGOmuxLZo2mYg1F1bfCl5VCLC7u6N3kOx1PlBO+FY530/HEKqu?=
 =?us-ascii?Q?HVcyQykD+eBsgGfI7gv3nNXFzHIc/yz5H2XYF+p3eOyphz8Vi6MGYL57U6lj?=
 =?us-ascii?Q?K89ZElSQJCslOU4lJM+Mq8KBdCUBUvpTWtE9eI4tnpgVlTdbUatYuH/pnaQa?=
 =?us-ascii?Q?4L1kpEWTDwDBvJ9xZH6Rd9N8keGSCewgndHGigPBmC+sVYeljW7Bh4xWG0zL?=
 =?us-ascii?Q?r8PwdnZuGzMYkY/bh/d6ebx8AvgSe1kb46gf2LcWrJk5CxoszE1cR/uU5lpZ?=
 =?us-ascii?Q?1P33plB1ztl7G4sB/DtJTImCaNJVy8Qfvp/UmMBPXTQ2Hlt15WoBmuOupyFB?=
 =?us-ascii?Q?kf+gToozw/Dk9f4oVvuO1vOtH9+R4uLOU2m7RE2ARGQs8kiXlUGmoxZ1x+a5?=
 =?us-ascii?Q?umQ6fLCmPXiYAw0m9YjjEkVaCefZKA+z382LD8j5+ZbTATtnKSPQxv3fULE5?=
 =?us-ascii?Q?Jb2dmaNHUJMYl5b5qfDpS4bOEalBIyK/e5SzN0+rRV7BzxBnSEwgJFJmqOGL?=
 =?us-ascii?Q?IlmeNmK9P6rBKncRKNPesLidzL0Hf7kY8g2uw9YaZpf8AFNrDat+OMTgUNIF?=
 =?us-ascii?Q?XqQWxujpixgqdVGSpWscklDNBR5RYr63rh9O1WlTD/1l8hpvf8BaO1ufUy3Y?=
 =?us-ascii?Q?bOk6oOJUgWT1FosTMeGEFv9gIb98Eww58Q/K6qI/W+ECtn0xRaGiT3IDBa0x?=
 =?us-ascii?Q?adUenvL8uS+tzBnlsqO45NgWxbG47nRszX5WpovAX0fAJjyg6v0IRijlUi5i?=
 =?us-ascii?Q?FUWawQ00ptm1xVNyGa/h9hJ2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d11c9f6-8870-4cdc-097f-08d94866bc15
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 14:33:52.7945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dc4MdgjjeHxbdTVRkpVNieCyjv3BK2rBqyTeuR2/1P1r6itMhCRAmcbj4Ul43tavV5W+PopDQzztTljuJ74z1/A1lw6JlwjEFflw5FVFpwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1969
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Tuesday, Ju=
ly 13, 2021 7:45 PM
>=20
> Under certain configurations when Hyper-v presents a device to VMBUS, it
> may have a VMBUS channel and a PCIe channel. The PCIe channel is not used
> in Linux and does not have a backing PCIE device on Hyper-v. For such
> devices, ignore those PCIe channels so they are not getting probed by the
> PCI subsystem.
>=20
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 48 +++++++++++++++++++++++++++++++++++++++++=
------
>  1 file changed, 42 insertions(+), 6 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
