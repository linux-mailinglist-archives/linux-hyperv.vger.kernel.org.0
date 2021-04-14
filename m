Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A442835FAC9
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Apr 2021 20:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhDNS1N (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Apr 2021 14:27:13 -0400
Received: from mail-bn7nam10on2132.outbound.protection.outlook.com ([40.107.92.132]:61098
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232769AbhDNS1M (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Apr 2021 14:27:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0I5fwQkNItUTq6IqX26TvVfBfSchA5HSn4xiY54RYlq6ob+wKVIpFTQVSByO9FqtGCMU1DxS/gOdyMSw/b0J0qz1K4/3FoJwVZFWbZSsDpm2d4vRkem5DA6heCctbL79mrIAMJLLTgT4Qa5gwzhkwBpIbkGco0hBe7muSGk37VJN27Yv22bsTsat5nTEBr0sGkd1VEbdMrsxZi7ugFamoMgW+i+T3/MrUibVpqLo8Tz6uoseHYMfVCXH1wXkHjWJEJlk0XQB69J1QjHiP+LpAGRv9tWdDSTPoxB8frwD9IBBd8KaMbR2O2DBfh1SUCxO9QC9ujxR4NdA+dy2tA0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nm+WBkU+Q00a09veE53fCw3cLZQ8HXcip4mQy7EtR9o=;
 b=esU4VdS0OjFgBwwmsff4mNgeMFn7/n81ZWmg2f7XFwRlaZmjao7rPGtWI66wo1TDDzeyXydVD3KluJ8hfsu0FAOA2oyuhzNWgHeElVU1XwlqpB97QplqfOPxrDX8qbhrYfBchbKxmN+ZQb6ciy1e5l3GBJ4otC+DXw3//7jVOitrQ4CzxstfjmX3bNMW/h7WCUXrfVM0k16yOWFejfZD7FeyQLA6O4KpLimTBMdVrUUMG9I9OHhN8TEZ9TbdZ6o/Al6pUFpypJF4BCbhrI7jNAOgMKtZEuYdER3XDNA+8agB8x0p2Iy9iLral/rOGyNaPR8LXf6n1X1I3+Ff/OcmPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nm+WBkU+Q00a09veE53fCw3cLZQ8HXcip4mQy7EtR9o=;
 b=UiDzliQHchX7fwdjWXYSHl97Nw3+830Me3/TSZcckK7yxJJQ40+oFWk4ZWBLuWzuGDL9oQ8HZ/ijayBtqxQuwyWXadLwBuLHXkaqz5sO66NQ4QS8VACl5xMIeCI0d41LznE7dVEqqoJza+zULLzX693SoZiZy18hLgthqGXazKo=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0479.namprd21.prod.outlook.com (2603:10b6:300:ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.2; Wed, 14 Apr
 2021 18:26:49 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f%4]) with mapi id 15.20.4042.017; Wed, 14 Apr 2021
 18:26:49 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] Drivers: hv: vmbus: Drivers: hv: vmbus: Introduce
 CHANNELMSG_MODIFYCHANNEL_RESPONSE
Thread-Topic: [PATCH v2 2/3] Drivers: hv: vmbus: Drivers: hv: vmbus: Introduce
 CHANNELMSG_MODIFYCHANNEL_RESPONSE
Thread-Index: AQHXMT8R/g7hcDxmoUmFfWHdQk+3W6q0VLog
Date:   Wed, 14 Apr 2021 18:26:49 +0000
Message-ID: <MWHPR21MB15939C511E6669D60311BCDFD74E9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210414150118.2843-1-parri.andrea@gmail.com>
 <20210414150118.2843-3-parri.andrea@gmail.com>
In-Reply-To: <20210414150118.2843-3-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a17882e4-15aa-4f0e-bb4c-dc22d3b4c0d9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-14T18:25:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d0e78ce-053e-4698-c01b-08d8ff72de2f
x-ms-traffictypediagnostic: MWHPR21MB0479:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB0479F7181A24BAC07721A71FD74E9@MWHPR21MB0479.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:323;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: edE/k1JY3mq53gm3CPOF/8SNny0sO8TdpgTmT65KtbKQzeMBGbqpw9XpVhgENv88/fTk2NqrY2fDHHd0b2zPakmOvh5K4KPfIsJ5DJFKw3s3V5xfI1wv8Obgae4wJ8roUqCCjWjM7ieEu4Cnu0S8cVkJCg7tYN3yyRKUtJs0WGfiAz+Pf+Nu8c4LaiLAgDQBzgb1C4nCdP3YnJwODiIlYPNnpE8zs6GpjQQ55XSsKO7tBkuslihifW8Vw9ykcgeFeT41Usr+mnNwqHmYsKP7E2EYtLs1tRbWEipdEU9Trs4a7lvmP2hpqktbireJu2ly37Yf30R7Lo+cwdGppmsITqbJO66lfxz4WDtasw/fwPJSVwYEuAA87p5OG5qAuxbpyoUbe42Xo6VnIQOjbRQshoNeSyMmMs+UbjN9lVCF5d1MFCTFzWApBGtwwyxB60V5AXiWJJPINbeM9u8mtgCJPX9e3rQhH5GrRX1MNc8S5mxgr3iyb+QQPtOqyFauf2WpCiG7nkfd7+UEZy2jAcbiijwhjihsM6wNLcEK+l+oh+8wmUsvgZzDPyLbMo/WvGsFWM0BbGGCZJ9eN+f1j0EC3KFVqUg3TfM5NbsR9SX8aac=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(4744005)(71200400001)(86362001)(122000001)(38100700002)(64756008)(186003)(5660300002)(66446008)(76116006)(66946007)(66556008)(66476007)(4326008)(54906003)(8676002)(110136005)(2906002)(33656002)(316002)(8936002)(9686003)(6506007)(10290500003)(7696005)(52536014)(55016002)(26005)(8990500004)(83380400001)(82950400001)(478600001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?s0p0/1I+tCnCfG+Ux5Emb2H1eZ/zATQe/z7E8EXyUsz2O9dajCGT88CI+abB?=
 =?us-ascii?Q?H1RHZICB7tMWPXa0ncABRXJuC/m5UmA0X7E0LxEk+XGjRfGToOYNWQe663vN?=
 =?us-ascii?Q?/XBID0Mg7OBoP7Fdl6+d64PJvYJoHm5lQ3sC2Nf580YgC5v3e6GrzrDrZ+mn?=
 =?us-ascii?Q?EecxUa8/7mKTf4/82EsrWwBgd6YPMH/J7pLzRPR8ZEXftciv0DgOmjsZP1R9?=
 =?us-ascii?Q?50OAoqr40yFWFUWpICEy8kfYEZKG1IbIGbF5a49Oo9YUQozwZkgrg03NPpQk?=
 =?us-ascii?Q?/QfvchSnicbiFQ/ORpsW0roTWFLsLwuefcRr16gBH7BS8/Aesl/89wH7iqv5?=
 =?us-ascii?Q?yo9UiEMsCtJN8FSPhxYlShy0zwQ/LixXo7+2reNLYyNXedGG0Adf+ea2dwUP?=
 =?us-ascii?Q?zSxzF4y9D4sFCmE3rgjx8OOsx153jGOEwtMlqy6iapKKuUyI9s2YGGRr/ojD?=
 =?us-ascii?Q?2RAiP4A9Jy+UOChbgF1EVYe14xIFWhS/e8Dg1ngqnAEStgX7ShbfwcKd+CKf?=
 =?us-ascii?Q?nBJNY58sDrpxIMHZC7PNISxpxVh2xHAMSXIMH6FljOYwZ4Jc3Fq47KOy/Y4R?=
 =?us-ascii?Q?heeBMba6wq7+GW94eZbjitMgsgYpx3vUzaAdvUuQWONEwL+IFmL8mU7NIecq?=
 =?us-ascii?Q?9NXdb5ijCj/i7DK2ZgAF3vrSQvIc1+MsS7EGPCP9FkkEztUZiyEsOGjP/kEB?=
 =?us-ascii?Q?CDHMJm/tVm/LErW+6L0nllb6D7cPAe3+3mOK81IFhzNj97A5hApzl1nNgvhY?=
 =?us-ascii?Q?k/7omjAzfciFxFvv4aSHVGGJZ9no/fTJqKHy5pYKijq3aMeRCKM4UwRjSrBx?=
 =?us-ascii?Q?3k9f3LX25//fSoCAUvZTR0JtMT8yCJkwKWnz+XNg+y7IVgNu5koOhwamV67A?=
 =?us-ascii?Q?JitYU0aas5AnLqt+2Ngqp0rYoCdN12zUPhpQsH7sQBowSC5O+oQSTxWgzF0m?=
 =?us-ascii?Q?LgVhwvtTzAX1jtgH/o/QLNP+MutPPEkOHecHV+pklQGeShmUsgf5CGescY7A?=
 =?us-ascii?Q?+ldYXABSoPurQH7FiLfwAlJTnLsmUR0bvrIOsdHzIfgI0lCQ3agaVZqApMJ7?=
 =?us-ascii?Q?j91/J+I/NXu7LWTbltonXtbSK866IbQbkF2UYZwqCxe0OfZE6vTxezxNYEe6?=
 =?us-ascii?Q?ZWmif9Jk2RhkY2lYGEOt2+s3hh/ThdZKI2iwswuF7PUeJ6Rd5TRO5uKk3Uh4?=
 =?us-ascii?Q?5z6pX4LkXQusJCaCLW2oaeMNxt/uWdZch+eFezweF6Q9KwYUjE/jC81SVkCe?=
 =?us-ascii?Q?RUTkEwi/eOpt+ubMTv683R92RmEVMJQQVfvwjcSfm3LAWTlawzyz/Ixq0faE?=
 =?us-ascii?Q?wK48Dt9CPRXWCDP+srl4rtyf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0e78ce-053e-4698-c01b-08d8ff72de2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 18:26:49.1041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Xsy624x3S0lmvviT1jTavAjVx12O04LuxUVr+HCXJnsq5mPH+Gpsd10u7i3zD0iIOTHLk8OVMP0UmYeLWugcKXflZtkuMtOqT6tND7eoKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0479
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, Ap=
ril 14, 2021 8:01 AM
>=20
> Introduce the CHANNELMSG_MODIFYCHANNEL_RESPONSE message type, and code
> to receive and process such a message.
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel.c      | 99 ++++++++++++++++++++++++++++++++-------
>  drivers/hv/channel_mgmt.c | 42 +++++++++++++++++
>  drivers/hv/hv_trace.h     | 15 ++++++
>  drivers/hv/vmbus_drv.c    |  4 +-
>  include/linux/hyperv.h    | 11 ++++-
>  5 files changed, 152 insertions(+), 19 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
