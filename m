Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBE12E0626
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Dec 2020 07:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgLVGmK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Dec 2020 01:42:10 -0500
Received: from mail-co1nam11on2128.outbound.protection.outlook.com ([40.107.220.128]:2145
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725924AbgLVGmJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Dec 2020 01:42:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTyhO9lTfB1UUJ+rwuqOD3gIr5SiJEItAFQkDSY0gRZmY9W9e0oNreUD5QNZuaFGQ2R3YxdBDzjA+G87SaAgberx9YtvFIWrim3H6/XKsI/z0X2/vUWOOzmJSXwcEr6flLX0f6qt9PSjKWRf7vQtv9bhIwyhtiVmLTKD5qvTZR4ElIVkzFDtcqhISLBq1NRWOPKFj0dYJhCpRr2yUZPG8oHZ/Wq6qczcvY1XC20Ec5oJ0vtwrGsPmGe2ftpcNum60V8uncDJhEuPsggiEooZm2Z+pgMKpT3/vyqROAknbyLR2Pm+STBeg3wC4yC7OFfuz8knvcbRIJDn8pgtqD8ERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnHkw8YhRIPuQ96fDV9oWrCwmw/7zJGL3qNIBwz0TZ4=;
 b=WKAZkFVjD4KacojF2ufcXHcxtXlNTgZurf3/avTMTJr671ZnNeyqVAadyvwY1q0pRNxOq01Hub7FtAgkt1zfIChiCEzHfdy4ljEuDfcPJvvgWdMy+WOZMnL42/Bk2KaryGShiJRxOonMj7uvmQ83HX1Ih68MQAuJGXu9s/GNnGLG3cBGwCaJmDm4VD0GOewZQ6WxfPjrxro8v5pCk95wqQXJDWx9rrA6/NNPoACDFH9YSeMSKLzHan4/EVtrweA4kvko7k1vcZuVIIdP8+3dxaNuD0xF6uOHFBo5vHkwI7Lwbz6AvHLRlnJvHWFR3WXl9twFSfp5vbQF1etwuqvnlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnHkw8YhRIPuQ96fDV9oWrCwmw/7zJGL3qNIBwz0TZ4=;
 b=A3m+z90QPjWwOinlWmhXcgodpbQF/gYv+1lmOvtmJokXiVxWRxk3sxK4mOjy3pYDzAcvp1DtXx80f1OQrafRgihqCyRQX9dCPZb/hEIiQReWKBz1NOJyemRjxAgMZVRTjoHarKoxHuuRxFZuq3PixEqXFInjwxqCePaTayc3NHQ=
Received: from (2603:10b6:303:74::12) by
 MWHPR21MB0509.namprd21.prod.outlook.com (2603:10b6:300:df::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.7; Tue, 22 Dec 2020 06:41:20 +0000
Received: from MW4PR21MB1857.namprd21.prod.outlook.com
 ([fe80::f133:55b5:4633:c485]) by MW4PR21MB1857.namprd21.prod.outlook.com
 ([fe80::f133:55b5:4633:c485%5]) with mapi id 15.20.3721.008; Tue, 22 Dec 2020
 06:41:20 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "jwiesner@suse.com" <jwiesner@suse.com>,
        "ohering@suse.com" <ohering@suse.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH] x86/hyperv: Fix kexec panic/hang issues
Thread-Topic: [PATCH] x86/hyperv: Fix kexec panic/hang issues
Thread-Index: AQHW1x+4gDeU8wnI6U2zhrRpW1B6M6oCL5eggAAJtpCAAD0rQIAALqDQ
Date:   Tue, 22 Dec 2020 06:41:20 +0000
Message-ID: <MW4PR21MB1857596C4E4097A2EAC9BC80BFDF9@MW4PR21MB1857.namprd21.prod.outlook.com>
References: <20201220223014.14602-1-decui@microsoft.com>
 <MW2PR2101MB1052192A1BC63A1A3DC196C6D7C09@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <MW4PR21MB1857877C13551B1618852F59BFDF9@MW4PR21MB1857.namprd21.prod.outlook.com>
 <MW2PR2101MB1052D798D9D292F6D43F85C4D7DF9@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB1052D798D9D292F6D43F85C4D7DF9@MW2PR2101MB1052.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-21T23:33:11Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a8aad501-3bf8-45a1-8f2a-10c18630a334;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:3591:4820:2a8b:862]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1ec02a3-33d6-4b74-4356-08d8a64497d7
x-ms-traffictypediagnostic: MWHPR21MB0509:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB050929D14D92401CB7911230BFDF9@MWHPR21MB0509.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ja8jE1j3i85qiDhMNaNiT8UiyUH/fzPrx3HfKkTxnAIdQmI7okwTsu4Emky88GuXy8bIm/+IVYmYSUEQ+hz6+QxHKfh8IBxO8u9dBGZyzS2xWedp31hJdjdUmAF3SnuGWU76nS043mYmzdeb4P4v8oT+MW8nDh1C8rn2LYNt72XypSaqQ78Z/OHQ5UinOjm2ZtEY1ldK2t9Gg3JbTMOJblfapclduECZLoCrWxC4NkRuDqEjpFRJS8tLvXp1lFdNMVBEoxGCOgZ0AAssaiG05R19O0x9dq9M/xogk/H+qQf9QiLKjjUMmOdx6aRwmGlibHPXgf9m1+VqGhc4g9o3YhyHZsRHtz5n+njE+PJDZSyKng4yuthLCSDNft/D4ObYZiEYrDcPZGwUx8zI1B1DZygTlGDEaj8XkMFRgfNxyZz3eJUMJZV6Gi35sIwscPzl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB1857.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(10290500003)(82950400001)(66946007)(76116006)(478600001)(66446008)(64756008)(66476007)(82960400001)(7416002)(66556008)(86362001)(558084003)(8676002)(8936002)(71200400001)(316002)(921005)(5660300002)(55016002)(7696005)(4326008)(83380400001)(107886003)(2906002)(54906003)(8990500004)(6506007)(9686003)(33656002)(110136005)(186003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mRdqpYMs5YVrC+ilY21qg0XLAL325go1Z8oc0TICv2KbU05Y04K0yD2qPRo9?=
 =?us-ascii?Q?ZTwH7SKbOjf1NOk/wtomvu828hPPq7W0IdtA4EC4MqksdW7yq3eII6QSnRF3?=
 =?us-ascii?Q?mUqrItMmw1ydofXDc0HmRTypDA6Sapw9yXNH+KtlTKVq2YbGQ0bj9DldjWYr?=
 =?us-ascii?Q?VuJC2zwLBGU6QqJj7JZJ/CaRbPLfAWxLsL4BBldCwS2ZujsSSUeYLRhXR5s+?=
 =?us-ascii?Q?GIZpdpsa5f4iYII0nKiJx1dwU/mVe6Pj+iuAUPi6OOAvjaJ91zIqKExwc31S?=
 =?us-ascii?Q?delVwEf+/U7e7DOWqbvulf2SOt5fZmu66dS0HR0qDOdNd0UkVboopPuDgkc+?=
 =?us-ascii?Q?rc9PZfY8NmiiSCbiKAvmkXdXbly6juvDCMfVt428igwQUztAr3Hzv7pTxO3k?=
 =?us-ascii?Q?G+rk1hQE9YAtop1vm4dOfZ1k/Vfvz0ZxpMor6NmRFhbEZDZ7jdXqk+wxvM72?=
 =?us-ascii?Q?YKbOqVs2DVJ3+I1M8luYH3UzVl4WWViA96oTMU31DfpIBpLSVZSXMeorWZmT?=
 =?us-ascii?Q?DHiEkAS+VxBv5Ccv628Xp0aKKQYzniddIib8Jlbh7Ks0jF8d3PVh1RLd5fTu?=
 =?us-ascii?Q?y/4FDShLKj8WLXZdh0eTLGpM/7TcWHHrUzFJFDgHfwbjjej+cjeQoAcfSDbc?=
 =?us-ascii?Q?byTBkZ+PL57R6Tg/tajnbWb7GVb2H/QH5OaeO7vDAJjsnbgpmQVvfaUHEAPv?=
 =?us-ascii?Q?EFU272a2G55CezW5d5QUDbVQkCahVFOI6xsqiu0m9iTv7iBjYaBnQz8lVXG3?=
 =?us-ascii?Q?RIty1nK53Txgsc4lh9+6uDZCl22BP8zb2i0Eq9wDvsVzMaDE/DWpe3C4k0Fe?=
 =?us-ascii?Q?YOOdyx8ljNwNMIwzFtkextDvVWJY8RxlhBsw5ChP1OnizuZio2FrcrUn6ifv?=
 =?us-ascii?Q?3PaLBVl/1SUMvpdIstVVmeLfmdAnjtMyJs2AmCsgh6JsvQjgkgsl8LEDxsaU?=
 =?us-ascii?Q?QWsZMFLqKYTJNtKXp/6S5VwHg9kGmsG26eSpyykL530jd7SThtVyj9pGkl7i?=
 =?us-ascii?Q?OpooT/HI4b7unwkE3QGlo4FYQw49cDdOF/Cs9ZzLcGD43xo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB1857.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ec02a3-33d6-4b74-4356-08d8a64497d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2020 06:41:20.6905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJLj5mJ91lT10+JYOuMm/lcaeKjkUS7AxP3aJbA6Bn9ym6wTv+KRZmYE00oMeCHGAMvB85RN+iLh0QAIB3cKWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0509
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Monday, December 21, 2020 7:36 PM
> ...
> Since we don't *need* to do this, I think it might be less risky to just =
leave
> the code "as is".   But I'm OK either way.

Ok, then I'll leave it as is in v2.

Thanks,
-- Dexuan
