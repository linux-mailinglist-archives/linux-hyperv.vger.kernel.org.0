Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2233DB967C
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Sep 2019 19:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388763AbfITR0i (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Sep 2019 13:26:38 -0400
Received: from mail-eopbgr810107.outbound.protection.outlook.com ([40.107.81.107]:44480
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729493AbfITR0i (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Sep 2019 13:26:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlkolfShCnEQzKoxQfF8GKSaeAX13I69OhudIeKg8grvopULB7zCNyszh4sMs2dwVHaKRFQssjqApY/1mF1ajjbW0IuNaReOYWTrtBjDOmyofmFdptQNcaaEMYeG4rMwnDlc8tfD+tmDpUMXI9tGaBzultRCLhRriw6ZDCk+B5WjIKQdf5zS06Ui9FJCZg2u/9/BU4u5Jx+W6aPuLzA0a2Ndr1/bqeV/AO8rCUUlmwZd5KWtJl/oa7j0iLwRWkYhfvWfuSffNwftEoSTY3T65ThI7QNeiAk4PCDT1V+WGGABbwf2btaZCFqbJms1/9g1kRK/N0mryb+f9wMvK3Wx7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFcmQ8IUBybKR5hnXw4zUD4HdvGEBJTLEnWdGcE3P+8=;
 b=alJotAfZMxJUyGu5oYwwQuv7Q9uWzld7i+x4KESQYWdjpIW/v5oiGasKqzj2ThpCehey4BkyJ5UfbGOTPv9NYOvZ7Islkef0+oZLWoobGGPfFjaPvkO11RUJYrCwfVC8XYUqQP2sMVj3zaKUlXWBMtUsWJCKqBiW28C4DyWezkX1U9sbJtdDFJ+o0YGQDlxkWdXQsMPZexyX3Cp1B9W4Lu+8/aERx7+P3TF1y/+uMJw+pBDEfVwCbqJYILizY+ty4JAv1kpCcZPJJbx/1W6juVCrJcHSCRe0Z9w+0of/oXFX2OgvCqT3+NGZn+AXKlPweJ+QLhGe2xLMyr/UJRik5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFcmQ8IUBybKR5hnXw4zUD4HdvGEBJTLEnWdGcE3P+8=;
 b=Kzs9Ikh9tElb6lXc5ttvUP4j78tn/CivZcOZ/GfSIXT1Y0qP8W5aQWx+kklgH23YG5SEuoIGvkTyt6wiGOPT7GqhCPINwW1B2J+chOWD+OiSio3sj/R95bbZVMjpOSvR7G3UxrQNd4W8rr7XS+lC0tE3pPBTtRWyYIwtK8NhNOM=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0858.namprd21.prod.outlook.com (10.173.172.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.3; Fri, 20 Sep 2019 17:26:34 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::7d6d:e809:21df:d028]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::7d6d:e809:21df:d028%9]) with mapi id 15.20.2284.023; Fri, 20 Sep 2019
 17:26:34 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "shc_work@mail.ru" <shc_work@mail.ru>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>,
        "info@metux.net" <info@metux.net>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATHC v6] video: hyperv: hyperv_fb: Support deferred IO for
 Hyper-V frame buffer driver
Thread-Topic: [PATHC v6] video: hyperv: hyperv_fb: Support deferred IO for
 Hyper-V frame buffer driver
Thread-Index: AQHVbebF21J2EyXx3k2x6FCXKaeI5qcx+W9wgALZkLA=
Date:   Fri, 20 Sep 2019 17:26:34 +0000
Message-ID: <DM5PR21MB01375E8543451D4550D622CDD7880@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20190918060227.6834-1-weh@microsoft.com>
 <DM5PR21MB0137DA408FE59E8C1171CFFCD78E0@DM5PR21MB0137.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR21MB0137DA408FE59E8C1171CFFCD78E0@DM5PR21MB0137.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-18T21:48:02.5575555Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=30212914-bdb7-4059-a1ca-460e579deda0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e5ece68-03e5-4a04-ea33-08d73defaf91
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM5PR21MB0858:|DM5PR21MB0858:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB08582D5883C8DE1609469383D7880@DM5PR21MB0858.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(199004)(189003)(256004)(81156014)(8990500004)(10090500001)(476003)(5660300002)(11346002)(76176011)(102836004)(86362001)(229853002)(446003)(76116006)(486006)(1250700005)(9686003)(2201001)(14444005)(7696005)(55016002)(6116002)(8936002)(3846002)(26005)(316002)(6506007)(7736002)(2501003)(1511001)(22452003)(81166006)(110136005)(66476007)(71200400001)(186003)(66946007)(6436002)(10290500003)(33656002)(66066001)(305945005)(99286004)(66556008)(64756008)(66446008)(6246003)(52536014)(74316002)(8676002)(6636002)(14454004)(2906002)(478600001)(7416002)(71190400001)(25786009)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0858;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JcdFOBpnXBl93NcNr7qhAjfDrgDbNq/i6Fs9LGr+twOrJPzWW++YMSjjdty6Rwpd4zaHx41HIu8DktNMFyu2o+y2/kLA7g92OJxuEYl1KdiQIUVk7FgOs2B7Z4T4yKBQOjHkV0L1RgDhb0vvQX8xHXkXiB5wSZDSQj+kgP5aJKVA8OR2I1B7MCpmElENsAg5/LXFuart30SE0JWSEGqL7zzHu0ZSQLxUraXnuXTDYW9Px3Rrxwt0LL6aYGoj5hpJtcaxtYX3cY4QkN0Qy2z2veTiHzZ7DA4D/PFN2yhEvUlOk2EZXIHwMTQ0W2ryg6ednsJrckS9e/WPwns3y/Bp5MOsaGSPayfwgKkNhAS1uSsCRCVwhPxyelAYgJTdmYV/eIboEELXVi/G3JXtEC3ph7FqOF06o8ACDxGVk6wjmWQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5ece68-03e5-4a04-ea33-08d73defaf91
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 17:26:34.7308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uwzcxjS8E4opD86Gkr7v5C5Yc18zXPffXsXwdZuv8E5gLJcYKljJG268Q7i5aAXByViKkGxPn8XQSYwWoNob4FVoJmkhNQoKtbAv/wCfMsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0858
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>  Sent: Wednesday, September 1=
8, 2019 2:48 PM
> >
> > Without deferred IO support, hyperv_fb driver informs the host to refre=
sh
> > the entire guest frame buffer at fixed rate, e.g. at 20Hz, no matter th=
ere
> > is screen update or not. This patch supports deferred IO for screens in
> > graphics mode and also enables the frame buffer on-demand refresh. The
> > highest refresh rate is still set at 20Hz.
> >
> > Currently Hyper-V only takes a physical address from guest as the start=
ing
> > address of frame buffer. This implies the guest must allocate contiguou=
s
> > physical memory for frame buffer. In addition, Hyper-V Gen 2 VMs only
> > accept address from MMIO region as frame buffer address. Due to these
> > limitations on Hyper-V host, we keep a shadow copy of frame buffer
> > in the guest. This means one more copy of the dirty rectangle inside
> > guest when doing the on-demand refresh. This can be optimized in the
> > future with help from host. For now the host performance gain from defe=
rred
> > IO outweighs the shadow copy impact in the guest.
> >
> > Signed-off-by: Wei Hu <weh@microsoft.com>

Sasha -- this patch and one other from Wei Hu for the Hyper-V frame buffer
driver should be ready.  Both patches affect only the Hyper-V frame buffer
driver so can go through the Hyper-V tree.  Can you pick these up?  Thx.

Michael
