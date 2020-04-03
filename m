Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4294019CE64
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2020 03:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389422AbgDCBzc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 2 Apr 2020 21:55:32 -0400
Received: from mail-mw2nam10on2137.outbound.protection.outlook.com ([40.107.94.137]:1217
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389366AbgDCBzc (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 2 Apr 2020 21:55:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dw29KjGWR+WEr+eBWHnLnSEa84fCxttl4CHFQZy64TXY1HVOyxhQU2ITyyiT/l4dh4an41RFnRDcdztwlPpXsaPKT4JKzIc7ICsCihaBFjDWdvyVvJvX2z9omsbr0ZtpiME9c4dCcaKW4iV6lBfIbzzL1yqe9M16Tm/0wiQ8dq09zZRqse+plgrQWH+AL4LdNUn1kn+MMtdkTsz4C3gfP5KWyTg7kpI4UGaydpPiNF0dSdoWQalijQAJP/skS6XFfVIPJMzADqjKdIHenqqL9tmEV5WvxYwUhcw8he5hzKOJqrr4RUz+4P5b2ivsaR2GQH4ktnBUtxRQlVjBw7zKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYf/L87+E0N5zuIvpP7xw75ESyC7IRnqChwV7OSqnrg=;
 b=eVz1qKriUoxB9uTIaL1Sifi+c1TmJycx8EAYl22iOsF1cFqPi/tPbpJP2yciEFLQptALwpzL4HlT2CHHFKwVe4/Gyp3udWVqlXqwdAPyzImPzKKFjc3uHyhG9AbJ1gbKRbcUAM8YKCxnwo8FRZH5W1WQk7LK4MRHF7dU9GiW8L/oLN2ji649aygpFcQDKjRiwSwAM9Ozyku9H5VptMYVNius1OlxZ2AKL+SeUkJjg8MsYNDcxiQwMo7ydZ0K5PrFx20Xd2/QuBDjPK5g4M4s/IY2CfhBo/+QeMNbjICKv52PJFe7pneiQ1Uh1+4oQnwNn6Mw1l8lAS/jYFYU2r5jkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYf/L87+E0N5zuIvpP7xw75ESyC7IRnqChwV7OSqnrg=;
 b=S6v7X1s5ellILME7I4syylE9b918T8PvvOQ5ySoJXoBde5coQ5z0xHfn/q52ITvx9D/8E3by2Srre9SeUy9Lo/DRWliYu2/a6ue7BGp9SB0xboyh6gxnCwASJM+i7D3qe2Qix7TpF80tunGi4ou8+b7HzDr7/c4SjtLxp2uyKAc=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0938.namprd21.prod.outlook.com (2603:10b6:302:4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.2; Fri, 3 Apr
 2020 01:55:29 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2900.002; Fri, 3 Apr 2020
 01:55:29 +0000
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
Subject: RE: [PATCH 3/5] Drivers: hv: avoid passing opaque pointer to
 vmbus_onmessage()
Thread-Topic: [PATCH 3/5] Drivers: hv: avoid passing opaque pointer to
 vmbus_onmessage()
Thread-Index: AQHWCBF0Npd6U19I9kuORoYBGUToP6hmpYmA
Date:   Fri, 3 Apr 2020 01:55:29 +0000
Message-ID: <MW2PR2101MB1052B1805E931D5A504596AFD7C70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200401103638.1406431-1-vkuznets@redhat.com>
 <20200401103638.1406431-4-vkuznets@redhat.com>
In-Reply-To: <20200401103638.1406431-4-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-03T01:55:27.7254738Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=637db6d4-7b5a-43ba-9a9a-1825b98f3bc3;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 726ab9ff-67c9-4ccd-b090-08d7d7721639
x-ms-traffictypediagnostic: MW2PR2101MB0938:|MW2PR2101MB0938:|MW2PR2101MB0938:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB09382DC9B15CD975B5A9E804D7C70@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(6506007)(10290500003)(110136005)(54906003)(82960400001)(33656002)(7696005)(316002)(478600001)(8936002)(82950400001)(81156014)(55016002)(8676002)(81166006)(66946007)(186003)(9686003)(4326008)(4744005)(66556008)(66476007)(64756008)(71200400001)(8990500004)(76116006)(26005)(86362001)(2906002)(52536014)(5660300002)(66446008);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mkj4M7Eck9OQv6ljRujwVilyyWFV/t1i7TL6Y9vGHdg9/yU6JEMRJqE/Zk+xxZNfgiToj9z+mH4ZJbXtP9yxnx1Ax3M2TSZejzrKIlgboeVuw9DNMr0/56u/8/nWjdcqyuWHKoA4OnBaK+Nvap57edSgaWUA0L+XSb9/jSbVT8zk1qwz0QgUTYKDZvuySQ+OoVH/965x04/Q7EnwRksKNAxOPYGX4VPQWLOxl6AeL3OxC57g6sbefUlTqsVX7oj7cIZ4QUW3crm4dotgezC3a8UPadkaWZ0Ju/095GbjkPmi66SVvtPhlyd5C/bnmtEM+j5rDGQmNVfTZRbIKt/g4aUHUbddmfbf2c5c+l8DPDziVYcGb+zS/Szi5FCa1w6cBBHC8k7S4VNN1UD/W8mUWZ2razOjxXG3C8BlNi5dONkTzP8MDTpMsoVbGOsGEuFS
x-ms-exchange-antispam-messagedata: uicP2R2h7fMXsqqtOLPkS+mXMfs4YHgnFGGJJkQw7+Z5zwViyRwn5INFhduUoBwjgF4bSPL0t1+HJGp07TaiS14GrOpP4oq2/s3ZLgAfSv7BTjhQCQPrK6l1M7ElIHYo8bkDLdZK5/2HhPqiixPepA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726ab9ff-67c9-4ccd-b090-08d7d7721639
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 01:55:29.3268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C6p8qWcI1gk7NDUSrX5hxX3JB0rSL5RHWDElWgUhs3oIT8GFMWVvlexOaF4jxKB6G9HRLGbMlEx8d1pcQmQ9HwWRi/l7/waV9LRlwLbsd8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>  Sent: Wednesday, April 1, 202=
0 3:37 AM
>=20
> vmbus_onmessage() doesn't need the header of the message, it only
> uses it to get to the payload, we can pass the pointer to the
> payload directly.
>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/hv/channel_mgmt.c | 7 +------
>  drivers/hv/vmbus_drv.c    | 3 ++-
>  include/linux/hyperv.h    | 2 +-
>  3 files changed, 4 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
