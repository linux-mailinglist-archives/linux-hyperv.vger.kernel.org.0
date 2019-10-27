Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D52DEE644F
	for <lists+linux-hyperv@lfdr.de>; Sun, 27 Oct 2019 17:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfJ0Qtg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 27 Oct 2019 12:49:36 -0400
Received: from mail-eopbgr750091.outbound.protection.outlook.com ([40.107.75.91]:38983
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727346AbfJ0Qtf (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 27 Oct 2019 12:49:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xs3/Oqb2JHW/Tz/MPctb/jPNsBQBVl5XIV47MmWg61pkElwZiw/ecOPXzBTzPyU9FhUWtsWt6G7cuONKFlCJG1eFG2nPGFjeDn5xfzpfur9JzSPnC2NUCllTSvTES3USQQD1v3hi+7rprLmuJ9m7RGnNM49vsS9bQthygdMNKDn8tU7dTsAye3sgeq1qA/5kddiQqBOYNpiBXQoUTTNGvGkWvzd2HT6ztyHzpRsx7KoOXUYm0ii4DhB78uGHnqyaXQMYCm8jz5ng/LWE9Tap8M7y87j2wJWm/G9WFJlcJUllSC1mh0KP5CUqAvtI3Sre/RlwSzZrNV3g4UX3Rq+cDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdLYdTjF9PnExFRZWYzGLk8ZT9Ir37TnVqzNOMU//9w=;
 b=IcqPwUVYafnz2kgGr6SFNuIiENEz/rVN32gK6bu3iawYcUh/m9WyHPHCa/nV9fnniHb8LbO0QpQGCYAWY/N8L1B8XRiZ0xf0ujs1Yq9oiocXdINj3HRuWJPLIwgDhzDsRdE7b6iIcjVguW3svs2XDDlD3R2MymKefvBizm8j1PoYICELX0cF5SvMnqUiO5K5UvCxIJSLzwgfVLz9xn6nF4rt6QZzO6O0ML3bmEB8BrwiAUpZcXKAbxZUtqxhJHmHwbhrKm2xC5LqOOsttAEBR4+epU0+S2BxL0uz3SAUx9sjf+TmxbTFKqCyOTkTY/hfVF6Sv6kZaFcUow/p4W03Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdLYdTjF9PnExFRZWYzGLk8ZT9Ir37TnVqzNOMU//9w=;
 b=QVZGVyIsH+GPjizDYMtvILPnWx1ez00yD2z58nyQ/iAcLxmB1XItgZChP9wgepjRRxt64dog9f2q+iD+9X3Lx44eOjIYz/rVqFxbnzumvhPh3EpTSNmn6JfpPpNHsqSkk840xNBlekGNbP4YO3P7euD03+hGqMpEE+4rQBqOMx0=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0763.namprd21.prod.outlook.com (10.173.172.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.2408.15; Sun, 27 Oct 2019 16:49:32 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::9cc3:f167:bb63:799]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::9cc3:f167:bb63:799%5]) with mapi id 15.20.2408.014; Sun, 27 Oct 2019
 16:49:32 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Joe Perches <joe@perches.com>
Subject: RE: [PATCH v3] x86/hyper-v: micro-optimize send_ipi_one case
Thread-Topic: [PATCH v3] x86/hyper-v: micro-optimize send_ipi_one case
Thread-Index: AQHVjNn5fFTFLcbQ9UmGNbPSapBCP6dustcA
Date:   Sun, 27 Oct 2019 16:49:31 +0000
Message-ID: <DM5PR21MB0137360776CEDD19E6FECC75D7670@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20191027151938.7296-1-vkuznets@redhat.com>
In-Reply-To: <20191027151938.7296-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-27T16:49:29.4870378Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b0eada00-22bb-45ef-8407-01aa833ab95c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb3d33ed-2012-421e-fe83-08d75afda426
x-ms-traffictypediagnostic: DM5PR21MB0763:|DM5PR21MB0763:|DM5PR21MB0763:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR21MB07630EA1F29D2FC1988A2607D7670@DM5PR21MB0763.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0203C93D51
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(136003)(376002)(39860400002)(346002)(396003)(366004)(199004)(189003)(8936002)(81166006)(8676002)(81156014)(22452003)(2501003)(74316002)(54906003)(26005)(6116002)(3846002)(110136005)(14454004)(66946007)(76116006)(10290500003)(7416002)(66446008)(2906002)(66476007)(66556008)(64756008)(478600001)(305945005)(7736002)(316002)(25786009)(10090500001)(14444005)(256004)(33656002)(66066001)(55016002)(6436002)(86362001)(8990500004)(99286004)(102836004)(6506007)(6246003)(186003)(4326008)(5660300002)(9686003)(52536014)(71200400001)(11346002)(486006)(71190400001)(4744005)(7696005)(76176011)(446003)(229853002)(476003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0763;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J/xtUPdmLaKyiY+Wq/JraSD+tM5Y6CPT2JVh3zzw0yJnchBTFy0g9NOCXWoTVZAtc6EcfeojD3ckV0o3kIJDc39uX7cSmzZz7Y74L0uDHNLp5NvucS1k86wTlTT5ZGMpnF5qjkHCzRaVpu4kZEoafF46jgROLD5KYp3MA6UBK6e9zLfH/5ziDBNSB+4xtU4y+4mqi6OWvaHghzvYjh6eskQIizodBy+1JBGhrNlXjR81eAowXUwItC4YiCWq3586fcL8uHaEq4wWL6OjW6Rmf3xqYWZvOfff16h7oPHqfCV1IYfR8eFccR30Ko7jwOE+kMuZtRoCKlihwPwoQjqWu6TTgOY/bqWpqx5qJ3dhM6T4f1rd1jjNPSfJWtKPmTlUPlky0bJUVRKikBjmduYsKCezFqFwbB4W4iQHYUiklDYbuVkewwEIO0ZqvwTJbz1D
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3d33ed-2012-421e-fe83-08d75afda426
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2019 16:49:32.0430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oEGVionwR6excCRfiUSx+CAK2Ad2DKmmdqOfS2mI1B2Acl88hYyfSuTmvNpuWD+4Taxnuwz1UuaJ03H9u0HWICDrYNUo9QAtX9hGCIy75+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0763
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Sunday, October 27, 2019=
 8:20 AM
>=20
> When sending an IPI to a single CPU there is no need to deal with cpumask=
s.
> With 2 CPU guest on WS2019 I'm seeing a minor (like 3%, 8043 -> 7761 CPU
> cycles) improvement with smp_call_function_single() loop benchmark. The
> optimization, however, is tiny and straitforward. Also, send_ipi_one() is
> important for PV spinlock kick.
>=20
> I was also wondering if it would make sense to switch to using regular
> APIC IPI send for CPU > 64 case but no, it is twice as expesive (12650 CP=
U
> cycles for __send_ipi_mask_ex() call, 26000 for orig_apic.send_IPI(cpu,
> vector)).
>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> Changes since v2:
>  - Check VP number instead of CPU number against >=3D 64 [Michael]
>  - Check for VP_INVAL
>

Reviewed-by: Michael Kelley <mikelley@microsoft.com>




