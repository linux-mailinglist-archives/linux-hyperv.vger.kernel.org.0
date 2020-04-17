Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DDA1AE85E
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Apr 2020 00:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgDQWpE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Apr 2020 18:45:04 -0400
Received: from mail-eopbgr1300101.outbound.protection.outlook.com ([40.107.130.101]:42570
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728482AbgDQWpD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Apr 2020 18:45:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acxgRq0dahnOQuhHBXeAsFRUrjOZfTG7+KVaGsetEFQ1emJajlyw8Dhar57fl3bydfR85dmp9ImKiIIfolZKvUc344am3r8msMWyyiFqf2WWhAWWHiwdruo8zPVmmnyknVuwjbvSa4Cne3q3F+lB/IHGYQlU9x4KqUpVDz+ONEuyvM3glSp6arGhYbeYUM4DPcp9jtwpkzOnofIvPfAR0hiKm6FmxgFhCdMPDEaHPyVOc/FzXP1WyE6l+UflQ8fLGBQf1WdKTe9t0j08nDe6nKXnTTIeZ0ci6/BaMbvBubas9Jw/XkBsWCWkjeSvYqCl2IlLzWfi0HeV4YyFEelhGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRo9cNd8X0MZrxBtPbVzGf0xk7XSRaNn2De4naZ6UGs=;
 b=U7XP+/tgb72C3ffj0ztMHYJKtCmaSh5tZHRPXn9g5IFBBCvH4TfxXkQiXRzaYZPLftLFTxgNAbhbNcZZNsM/Wd1igsfqvCK7ekxno1FguKObgljW2WrniXrXL0/jmrWjjGhY4tRiZiX9oOf4ng5ZE8JhB4vot8iHEudjNAHz0SLzJRwj9JA+Ivky9AparWSUD6lC15pKuaaie/4v27xcvWudPo2HHFn3/NYDZ/55cqTRD1o7t4/Wpb+ZsjT2dD23IER0UCBXmJmdYbXU9L/NlPQxDI+VwrpbwrRs2JubZdgAjUR0RWzcrLjMya9gMShkJ7eGKzQwF/3/Q3k1y96mfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRo9cNd8X0MZrxBtPbVzGf0xk7XSRaNn2De4naZ6UGs=;
 b=UfUOU6dsJ8imR+JQEVLkw80FCeckafQdB5GEShfWaA0ht8y7OdZXBOum1kNLMjPSzqP5S9v6APP/v8xhkwIKKExOikfwJDYHaM4L/GFoKETjGXdf0JWdUAi6cguk3jCE3QINNL0iWoyLylhTmlsAD0kFS2kEqgI88wMxvGvQsMU=
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM (2603:1096:203:b2::12)
 by HK0P153MB0257.APCP153.PROD.OUTLOOK.COM (2603:1096:203:b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.4; Fri, 17 Apr
 2020 22:44:39 +0000
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a]) by HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a%2]) with mapi id 15.20.2937.007; Fri, 17 Apr 2020
 22:44:39 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
CC:     "bp@alien8.de" <bp@alien8.de>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH] x86/hyperv: Suspend/resume the VP assist page for
 hibernation
Thread-Topic: [PATCH] x86/hyperv: Suspend/resume the VP assist page for
 hibernation
Thread-Index: AQHWFJewaoKQdpfmdUy/nWpslHqeNah96V2g
Date:   Fri, 17 Apr 2020 22:44:39 +0000
Message-ID: <HK0P153MB0273F49C7C59012A6BE0B304BFD90@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
References: <1587104999-28927-1-git-send-email-decui@microsoft.com>
 <20200417090748.r2c45se5paqz5766@debian>
In-Reply-To: <20200417090748.r2c45se5paqz5766@debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-17T22:44:35.1962023Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7d610e83-46e3-4c5e-8879-6a54a0f3001c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:6de6:6792:4d71:47c3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3de2226e-a329-41df-4ce1-08d7e320e9ae
x-ms-traffictypediagnostic: HK0P153MB0257:|HK0P153MB0257:|HK0P153MB0257:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0257DA691D4C98CD34DFABF3BFD90@HK0P153MB0257.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0273.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(478600001)(186003)(76116006)(66476007)(10290500003)(64756008)(71200400001)(66556008)(66446008)(66946007)(8936002)(81156014)(8676002)(2906002)(52536014)(82960400001)(82950400001)(86362001)(6506007)(7696005)(9686003)(8990500004)(55016002)(4326008)(4744005)(5660300002)(316002)(6916009)(54906003)(33656002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dmaSLNJRERY0Bzy6zMxLbdU49kmO8HC9f8wGe0h2kAiV+O1yt/aLZgZeYbu5jwIltanaXSHYWTKDboFdoSg2XXPAGn35sSXN4K+gMtMCLUxWgjYx7dRl+cHpEgC2lfGboPFsIpB0CFrX42GGzOSTPuhMkXePPuvp0R1WNyj3Q1VHSIcm1WHBjgQjbzUURGMUFWyw0JGL+OPCkBBm6IpRr0VxPO0y25joL9NSQ7oUSK6AN6v/rlqNffWb++8qPSEjjyIhUiWaQ0pHgLdABIJPStGmrc4GJGb5K47bUiDPSye/MBEeIyScSMe0Zt53j4BNbWiNjTHa6lD2z4XwQr5kcTf0jNspMk8LVpXV0fItBqdztSlaJSSZmAVGy5sMbXwoywIAwKqbog6qt4C6+NSUzWeqWsHOMvx+kMVr/FDBP2A74Cg2aYLLDys3zai6bNj/
x-ms-exchange-antispam-messagedata: xP2nc1AT9/8eNdL54t48ruYxL+2faTSYtOkM/17zEay5T5t5QNist7apPCLfm7xdYaXZZwR1OWIsxlyGc6rH4Aad1Q7OIEX8iBQe82FjnGP49ona0qpkpA73j9FkZsXOT4et2XbvUb8ww/eStAFFlvUd3Vn//7jvK/bAfQ1FCMJl8DqqTwQZp2e27OOxmyA4cneHt8YmGlHgjp1Ro5T4KkyexYdQV/KCl5gXAY1oKLRPYIdeWrsK8/ZudurmKBsjnVjtsyuStZ2Tco3X+zMo7XUWKj2wjN4FXX3D5nXH0EzxhlQHeq9a0KGqEDeO+3XZfSyeIaHVs7aE7mHxcq8ld4RHuJbfq8fUt9yfheRbItckTZWpW5tAmDhI50E74MdBN0NPlBVYkoTkRLwVtQfOVTdb65YZiJ/CJQ8px78C013ZCys1RHcelaxLyQVsJWYmET2lcVSnpMSQ6Qf6+Lj0hZQnRS07qRU8fyl6d2q/yIuDs638HixRpZFoEY3iMEAA61NtKabArESxuHBQrUuJn/+XMbw5PST2V7rxJl0/ME9TxgzBdfLYtfPRu7KcizhqsjB2WB20VWzM05T+XCH9ldmhf1v/Aerafjbm0RxZ90cwUYcataKhsIt4SPs+MBREsHbfRP6TBQDmCtSv2EJ0HSm0X48qmTFks818vPsAtgT7bjwBsN8yrfZqgqNGEHamSL6erThbwb/rdsY16EjtKqnvJzP+jxUruki0VLBevCTPV0l2Prt9SwkTbecknKIwEiWmTveb3xjzvowQ+Gx02KkAR71C/eqst5dmeaOzFhnHdJMXuGtFuzA28cWA/NK0VQCENpJwReykI2PXJ5CjQJhbZ328bKnR4XT695mPsng=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de2226e-a329-41df-4ce1-08d7e320e9ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 22:44:39.1159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oWt0d/8R1cuQ6QVyomB8s7gbAwKaM3s2ggODSa0iC6m3sAsvW1tBraePWr9iOcgfWJavFALCoBhnYgbA4UmDYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0257
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Wei Liu <wei.liu@kernel.org>
> Sent: Friday, April 17, 2020 2:08 AM
> > @@ -72,7 +72,8 @@ static int hv_cpu_init(unsigned int cpu)
> >  	struct page *pg;
> >
> >  	input_arg =3D (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> > -	pg =3D alloc_page(GFP_KERNEL);
> > +	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
> > +	pg =3D alloc_page(GFP_ATOMIC);
>=20
> IMHO it would be better to  only tap into the reserve pool if so
> required, e.g.
>=20
>         pg =3D alloc_page(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
>=20
> Wei.

Ok, I'll follow the suggestion.

BTW, there are indeed some usages like this, but not a lot:
grep irqs_disabled drivers/acpi include/acpi drivers/trace -nr |grep GFP_AT=
OMIC | grep GFP_KERNEL

Thanks,
-- Dexuan
