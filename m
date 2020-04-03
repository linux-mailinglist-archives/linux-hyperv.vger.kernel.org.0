Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0415319CE62
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2020 03:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389507AbgDCByg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 2 Apr 2020 21:54:36 -0400
Received: from mail-mw2nam10on2092.outbound.protection.outlook.com ([40.107.94.92]:23431
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389422AbgDCByg (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 2 Apr 2020 21:54:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gy2sg4z/gx26D7n3NKSqMvLPBKoPmpc6H5KTOLIwRcqO1MP0BMr8BfkAkNsI42ckeGlX7cr1mI57baDWTKgve1f1086iIK0ZDfKhTSQQ3bhX1Yn7o1D4Tr1tl1Q+khONVHWx952JqNermpL5r95Zf9ie+am4hlOlyB8KxkYYKzJap3+Uv4oc75OUKX4RxuDBGTHV7Bpiz4OQ5QOr0Qn3q8oWaa6R16tH2axVyNIttjXWfnzeslc2iVVWkI9FFbB4PgfQxJD1+ilBm4AKzjMOoUAyb16eMOLR/xGZjnFZwwmxX1g47Q5aysEr/mnEIO7BCkDlRl351qnIkS4JF83fhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztK4imSfL5fxR8ZpYYcRfEDRF/VU685WVXbueYYGrU0=;
 b=cOE9SldoPbXzZ0Sq5SflgSotRW4D0EimebIs5WOJP/3qGj5HhIsZpDFNfyw7R3EIDhitNEQLsxubRAA4sASdrAdy7iGW9a+8vJnsTrvkEwBgVcI+V31G4/j2Y2QxCS96kCRizIsHU/QprelR1mMCzS4paw5+UdZtDij/zjtp8EA/r3ALu2PFJXl4yyMV9gSkod3lRs+ZNEoEf6iBfggFZAYFmw9k0jLiCN07yFc1/9rzHitYptQTN+SwsOxvxquunfI5zfmZkXcA1MahILydDu3n1Pm6H846k4k2BHz3QwGCBEWe72Xn9zAcSunJA3YI25bSGWQ30TDriidiLfThdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztK4imSfL5fxR8ZpYYcRfEDRF/VU685WVXbueYYGrU0=;
 b=jPiqDaosuZI++rYQKD2ZJDOxtnNcmwBnoLFPKhyILv4vhqysuu7JQFiJRbCEFFUC0TJHy7hNLRrVLQ2GoYk69L6A8ch2ZNYLza45mdjvbDu/j69bRyWukfkqymd25gxKbx2wTouVmPeqsaargt396CFcw8Ra8BrUqRaroq64VO0=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0938.namprd21.prod.outlook.com (2603:10b6:302:4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.2; Fri, 3 Apr
 2020 01:54:33 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2900.002; Fri, 3 Apr 2020
 01:54:33 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: RE: [PATCH 2/5] Drivers: hv: allocate the exact needed memory for
 messages
Thread-Topic: [PATCH 2/5] Drivers: hv: allocate the exact needed memory for
 messages
Thread-Index: AQHWCBFysj6RQ5ogm06yjYOd1hNLT6hmpQ8w
Date:   Fri, 3 Apr 2020 01:54:33 +0000
Message-ID: <MW2PR2101MB1052E10419C37D704303D91ED7C70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200401103638.1406431-1-vkuznets@redhat.com>
 <20200401103638.1406431-3-vkuznets@redhat.com>
In-Reply-To: <20200401103638.1406431-3-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-03T01:54:31.6251410Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2d13e951-5255-403e-b64b-6ddc3b3ecf42;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1e653db-dcf5-46ab-7f1f-08d7d771f4b7
x-ms-traffictypediagnostic: MW2PR2101MB0938:|MW2PR2101MB0938:|MW2PR2101MB0938:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB09389B0D7A090C5D3650F76CD7C70@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(4326008)(66946007)(9686003)(186003)(2906002)(52536014)(26005)(86362001)(66446008)(5660300002)(66556008)(4744005)(8990500004)(76116006)(71200400001)(66476007)(64756008)(15650500001)(82960400001)(54906003)(6506007)(10290500003)(110136005)(81156014)(55016002)(8676002)(81166006)(7696005)(33656002)(316002)(82950400001)(478600001)(8936002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S83bWUwpKu7DhR1tEKPq6n5rD9taCG7+OuUSrQzYbFgbvrzRP62zN+rxbSIuT7m/co7w2r4UGVkgfAU6EPxpm8/YxlX3S1Za5+2iu5WEDmeDfZFGg9CNn3oeSYYtK7EkH95Cn+eIVoOh6a4+1kYzVYy3OgOjHf0R+RP42XbD7xOD9ri/FeHnvcrJteuI4rjmTrdvjseHY6Qn4tTrZi51lYTeH24a1DnqntZwbfxnW4nMW7+bfoo3PgA8x7kmiXANx1qtGHuHhSpaNBg2imf+VenpZjj6T0Lb7KxMatj41rKg2OZCNnd6TnNYxLYdtJnKqJ8DlmRoyek/d7zzpQaRtOvYwZw8PQYL7/s3BxHa8/DG0pmyKxpGw2QpgjPMiIgt3Cu/IGd44SyhKw/3d9DfbW8Jy6Nnitl8rEkMPWpvaC96N06eRqxp03cmHR5Z+XUv
x-ms-exchange-antispam-messagedata: ux1PzlPXCdd9qkBVpA0C+q2Xvv6fCpzFgQwW0Ez8Fek4rBSY6UbAWo2jL3aATV8Tp3HJDKghtw4J85u1x/njmr1mLIKlEk5Lz3J6/Nw0gRqwSfLun7sqlFpCjCcfwuK/s9C8wyM1ObCE1hw22mnSeg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e653db-dcf5-46ab-7f1f-08d7d771f4b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 01:54:33.1837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8oyfqZDspGiMXUgO6xvAHQQKN/idnOgznz8e0nFXmgTIIHNoYoQ92HfsD0qlW6nr3XqH5Vq0Hu7I5WUQ38f1y5RjJBKKGM6HfLIuN6S3RU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Wednesday, April 1, 2020=
 3:37 AM
>=20
> When we need to pass a buffer with Hyper-V message we don't need to alway=
s
> allocate 256 bytes for the message: the real message length is known from
> the header. Change 'struct onmessage_work_context' to make it possible to
> not over-allocate.
>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/hv/vmbus_drv.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
