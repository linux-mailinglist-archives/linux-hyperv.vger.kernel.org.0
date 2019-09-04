Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74CF5A8D4E
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2019 21:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbfIDQof (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 Sep 2019 12:44:35 -0400
Received: from mail-eopbgr750121.outbound.protection.outlook.com ([40.107.75.121]:5957
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731642AbfIDQof (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 Sep 2019 12:44:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CClYvW2vrLmsdtZnBvLywMHUL+E1KS9B6nHESStBt4ToCrPrHo4cKDMtnEuNt+zHzqOxLIUX4uY2bD8pm1Sj69+lG4fTvujejKa7qAQgSUilqzdUNUJbOhexUYxsYc2QahHs2ug+RuNx/+lTtz59OicHawuPgUnpI14cPD7J9PAUZy1m4KLYoH0V6JbAeHEF7lKqyZZVPV0nw2RM3kb+SJRGoEYwSVXY4YCdl8BsAz8cjrK+UcuZY835MmdThtvmyEgXjaGQxoHY6g9bx+th9BbDAFm+KEGr+jAAl1X2u/vT2r2rIizT7yiB6lkNDsayXHuKZOP6ACekKL3tuShKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/lRtZ0WRJmXfOYtgYd5cDS8hZCjUaPVLBXIoWvFs34=;
 b=cmaEUJxWE41GTXJzt4Ip1Ozr8+U4JxB+FngWlIHA/Ggp2WMLaUqhKHrHTKYwmHLmu7SO+81cUwfmmD0iPSXCs03qGGpMmAtcZ8hDMmaFR/I+TpCCUT7+IxnrXAtrk7BPQ4liPxWeu3VAVOsdyvMaV3JEdlYwXZQZvYzEz753fgIg5x7+MXwOfFxmp4uF0hZqPzdnahDhj7sougzTKajUrR/lNJ/XNge4MAsCyg0AuXtiyJB49p/J+eBaH9Q2+Jqk5Sg5ShHahsOE+mgTrvvJmtCukHAqpe6NNVgNeisrPKJfDNo2YLDZ6oGcv8aMY2J6hrYK5QyFTyCrtmU+x5QBuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/lRtZ0WRJmXfOYtgYd5cDS8hZCjUaPVLBXIoWvFs34=;
 b=AIvMNXRDJvVuqCqOM7ODrap/ZXrq9fDGHrTbquKsEAUCP82DBAw1gcDfo+hznmPFHFqKmH/HbjI3dFynJXrYBRUhj67j64PBrOftO873EYt54z3M9m6iScDF56XJ/bQKdzoDxytzWJ/l2xR4UOrvWIWPyHfYORy1i8BFEOLBHAA=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0794.namprd21.prod.outlook.com (10.175.112.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.6; Wed, 4 Sep 2019 16:44:33 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%7]) with mapi id 15.20.2263.004; Wed, 4 Sep 2019
 16:44:33 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 11/12] Drivers: hv: vmbus: Suspend after cleaning up
 hv_sock and sub channels
Thread-Topic: [PATCH v4 11/12] Drivers: hv: vmbus: Suspend after cleaning up
 hv_sock and sub channels
Thread-Index: AQHVYe3NBrwwea7z/UmohpfmVS/kFKcbvApQ
Date:   Wed, 4 Sep 2019 16:44:32 +0000
Message-ID: <DM5PR21MB01371AC44D9A0393EA0E3858D7B80@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <1567470139-119355-1-git-send-email-decui@microsoft.com>
 <1567470139-119355-12-git-send-email-decui@microsoft.com>
In-Reply-To: <1567470139-119355-12-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-04T16:44:31.2462891Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7fecb46f-ad01-45bb-8d9e-eb1f7da136f0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [2001:4898:80e8:a:c9a6:edf8:bca3:c905]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91f2123b-cf4c-4e75-764a-08d7315729d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0794;
x-ms-traffictypediagnostic: DM5PR21MB0794:|DM5PR21MB0794:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB07940B9DA7AEA4FA5D27F11AD7B80@DM5PR21MB0794.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(199004)(189003)(10090500001)(6506007)(2906002)(33656002)(1511001)(66446008)(64756008)(66556008)(66476007)(66946007)(186003)(7696005)(76116006)(76176011)(102836004)(110136005)(22452003)(316002)(86362001)(81156014)(6116002)(478600001)(81166006)(5660300002)(2501003)(2201001)(8936002)(10290500003)(8676002)(14454004)(14444005)(256004)(71190400001)(71200400001)(52536014)(486006)(25786009)(476003)(6246003)(53936002)(4326008)(46003)(15650500001)(11346002)(229853002)(446003)(8990500004)(74316002)(55016002)(7736002)(9686003)(305945005)(99286004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0794;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cCxR4lACMdkgtwA/Zh6dpHbE3Se/DB7MIDvi6RmnmdVlzynzDHZIuuty7dOWsturGbOxt9fFj/aGR1VDjyNSuFmttZfi2qBX7JbOLmk+wuNapUSycT5F2tjqRyEqtGfqPKgUKDBENHsCpTZtJXuynpoDh+6crx+s7hmePn8bts8czPXBweiH7OHFRISBVvnQ1cIDytIdQH5j0cUe5l6tNEQX77MgWskrKUhFppMutzISqnjR+jTHVHKXLCc3MMs7bFDnwqov2Y5SHT5aYJkU/w/i+Tw8ai8GnUnNd9q4VQazkKb7ily506YHVTQ0CF/YYNjxM4LqEkWbPOoxztBIjp9548nCowhnHl+8A7nSsGlNEWMiQFgEjZ4KVgWzWiq+yjv9KrnZKDTvCWNZ7KCSK6Lir+RvikLJFt1IBznrYLw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f2123b-cf4c-4e75-764a-08d7315729d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 16:44:32.8278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w43eYmApdfNQlHAwlClBZPJ4MrpJa+GA/LONRT9STIOrC7bP2dVs3uhZWVhAFRQvPRYmUg90Hus2bGuDA1sAj0n6K5dIEWbM2tfspNrWHf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0794
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Monday, September 2, 2019 5:23=
 PM
>=20
> Before suspend, Linux must make sure all the hv_sock channels have been
> properly cleaned up, because a hv_sock connection can not persist across
> hibernation, and the user-space app must be properly notified of the
> state change of the connection.
>=20
> Before suspend, Linux also must make sure all the sub-channels have been
> destroyed, i.e. the related channel structs of the sub-channels must be
> properly removed, otherwise they would cause a conflict when the
> sub-channels are recreated upon resume.
>=20
> Add a counter to track such channels, and vmbus_bus_suspend() should wait
> for the counter to drop to zero.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 26 ++++++++++++++++++++++++++
>  drivers/hv/connection.c   |  3 +++
>  drivers/hv/hyperv_vmbus.h | 12 ++++++++++++
>  drivers/hv/vmbus_drv.c    | 44 +++++++++++++++++++++++++++++++++++++++++=
++-
>  4 files changed, 84 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
