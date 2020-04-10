Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 858F31A4A5E
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2020 21:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDJT06 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Apr 2020 15:26:58 -0400
Received: from mail-dm6nam11on2124.outbound.protection.outlook.com ([40.107.223.124]:46048
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbgDJT06 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Apr 2020 15:26:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fc3od/tdvGP4VOuPygimI0oMN6y1pfZpCewvWs0iI1Ko1QRLQ4LeGQ9zHtMuIGDOyvn1Q2i8kmo//L3g7RHOtqHLnC9/qajzqlyOy+c48qfCeww/4y+PQQSrVcxr3QkbJM23BQn5scKQwEJbEOUUVKv8NZ7l0zz2Kc95oeCik9ahn/IpAVjHSyS3QniOZHVmN5/Ei5akWpcT7XIbsjpvzZWM/oCjCcQetHDFZNeKiXo30yTd2e9g+F98Y8N4Zq7oQANpOMnRalPXhslnxYokU1GOladDkk+lXEn6H644bqxsoXjMrQrjG8OfYyfB9fIbTOjmVLQFnd76O/sFaseakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJcgEn0REiFZVNFgvcSgHA4YW4w0QlVkWqq01f4P0sY=;
 b=I8HloxA6/kltaEMxj7uN0Q6Yve7xwyiL0c3TFAhjqffvHW9yWrjziCaOxHAuMpN7HpiDsHTpXVR7XC3aZKw8QlrECsd3EQzjrUuhkH5mxwagF5bKd8heYELOuUItZ1oSjAioddJj1UGRWZ48QAZt7DELyJbpKdhygAZBqjt9jWTyW8PdCwA+voLEsZwcFFaF+OnmlbM3GcSrHCoAMEHW88qKdXSBnwy0SvDplmecOaQK9GH6zgiorfIbteOYhUpM8NuLlTw0OYAgSQxiXiby1mePqg7x+WpSQQM/2ZNeI92DbU+XRqedEMrK5HBV9HrqvRmEZPuMeva1aKOh/kWmaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJcgEn0REiFZVNFgvcSgHA4YW4w0QlVkWqq01f4P0sY=;
 b=fwF0VLA1ti7t3g3u8DnCfvo64OBMbl+c+N+9/mCT3cF9ZagC5n5+0BmuGHk7FVQASSChnRUNTK/IJvnSayoavRkBN43CvSgq47ea7p3ZNvwuvxpXi9U7Dku3vjcDHf5LZlf+4GYErLmZMQnSChphrhL1LWHoXZcP5j7UA5VTThI=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (2603:10b6:4:9e::16)
 by DM5PR2101MB0903.namprd21.prod.outlook.com (2603:10b6:4:a7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.19; Fri, 10 Apr
 2020 19:26:56 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::f54c:68f0:35cd:d3a2]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::f54c:68f0:35cd:d3a2%9]) with mapi id 15.20.2921.009; Fri, 10 Apr 2020
 19:26:56 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH 05/11] hv_utils: Always execute the fcopy and vss
 callbacks in a tasklet
Thread-Topic: [PATCH 05/11] hv_utils: Always execute the fcopy and vss
 callbacks in a tasklet
Thread-Index: AQHWC6irB8fFAbLJ/0KQru+QGYYm6qhywuPA
Date:   Fri, 10 Apr 2020 19:26:56 +0000
Message-ID: <DM5PR2101MB1047D0C511D26C877D7719FAD7DE0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
 <20200406001514.19876-6-parri.andrea@gmail.com>
In-Reply-To: <20200406001514.19876-6-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-10T19:26:52.8463778Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=333bcd63-94ed-4847-af89-576d5b3c4a35;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3177622e-254e-4863-a006-08d7dd8521e5
x-ms-traffictypediagnostic: DM5PR2101MB0903:|DM5PR2101MB0903:|DM5PR2101MB0903:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB09031DB11F316DA9CEFBEC58D7DE0@DM5PR2101MB0903.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2101MB1047.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(6506007)(7696005)(316002)(8990500004)(2906002)(54906003)(478600001)(86362001)(186003)(110136005)(10290500003)(66556008)(82950400001)(82960400001)(71200400001)(55016002)(66946007)(26005)(66446008)(76116006)(64756008)(66476007)(81156014)(8936002)(5660300002)(8676002)(52536014)(33656002)(9686003)(4326008);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L/zqUIbr5H8ti0CXgPLpg0b5IfPgqoJ/Ea7DeDXiy2DxP9RcxR5+/8x+VmxAuXk0Ug+YplsvVy8m5jO3Ywq03paV1ezMlcCb+sdHVSngpIkK3jSns3lM2sM2JhfAci2poBT+rSV6hCBryg1Ui1rjInEx6TwsCWsk9qFUzvx8r1LudkOKz3SzVN6x+AB58Kcfs7F5SU8V05r0oB2qGLYzjhLSIuWbM/n1bO6+mPnjFjkmdWdla230khn2fPFf99uG29XQTf6u+146V8SFVgLC3mjqGn9j8FmYikEAOUKPR5DkDjOhdEBzk5oBOKjJVFWIK+Xk1W9810l7n+fGQoeEhr2/Kev7rOX9mZU76FqOaA2nFJDcsG0a4isuP8RWO8E8MaloQHxPmXDX9eYghjMWitHSFzxMu4uofZaDY9QReNIQGUMystqLmEa3i6ZVM6eA
x-ms-exchange-antispam-messagedata: e+9oUuYxi95MW6I04rJe1QLfxHkMxP1WvmaNRaUnD3PkDAfsGVsx0NvumiVWyfKLCYTlCSt/frVrj2bnwYjktV8Dg5gD9840+xfQiaSoIKiB294ybpdaX84vPrNHPMkYqStUjh0Gfbh6xt1t5l4gjw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3177622e-254e-4863-a006-08d7dd8521e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 19:26:56.4060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OV9CW46XfPeKPB7yHnbc2daS9IyEHgv1oUMabfnS1S2edW8f2/VAS+9HKpeA5VATApmdtKWTn/FYoghzw5H3Nql6nlNtRbYBpfCwLhMaMqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0903
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Sunday, April=
 5, 2020 5:15 PM
>=20
> The fcopy and vss callback functions could be running in a tasklet
> at the same time they are called in hv_poll_channel().  Current code
> serializes the invocations of these functions, and their accesses to
> the channel ring buffer, by sending an IPI to the CPU that is allowed
> to access the ring buffer, cf. hv_poll_channel().  This IPI mechanism
> becomes infeasible if we allow changing the CPU that a channel will
> interrupt.  Instead modify the callback wrappers to always execute
> the fcopy and vss callbacks in a tasklet, thus mirroring the solution
> for the kvp callback functions adopted since commit a3ade8cc474d8
> ("HV: properly delay KVP packets when negotiation is in progress").
> This will ensure that the callback function can't run on two CPUs at
> the same time.
>=20
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/hv_fcopy.c     | 2 +-
>  drivers/hv/hv_snapshot.c  | 2 +-
>  drivers/hv/hyperv_vmbus.h | 7 +------
>  3 files changed, 3 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
