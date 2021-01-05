Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EC92EB054
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Jan 2021 17:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbhAEQk1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jan 2021 11:40:27 -0500
Received: from mail-mw2nam10on2135.outbound.protection.outlook.com ([40.107.94.135]:7392
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727414AbhAEQk1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jan 2021 11:40:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M00uvumVuPxBZWat5h9X+bs3LGGL9JxX/TwRFBECoRPWn1iX04/S673usSEgsegest/uzij9i1dlokgZLEIcjSN4Dr9+YwDweQrIm3DD3h3WmJjX9dJWlQxceXXca16q6e7NNpQvVvv/7m6jEr1JHo89znfVUagd+1v33e7t4XC92nJyENsJQsSfYzbx4ssgNmSJV7c/woe4L0tdKRc07WngH2WOnCuJ1u1li7jd88JMuIkoKQLobFWqLJBIDIEFqR6g0Qzv61ut96JEmXW5HKJBLv98qvqwRHOKdAxDHOICLIzKMAAMhLTy0uBxmdtWSkWJDVFkK9meykBi6PPUvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Xz5r8Qy7HKc2WMm2YXivc7FGt6q4q6/+ax/gVL03dc=;
 b=QDExyC2FOOLd9kIa56vWapodOwBXkS2o3dRpIQko5M/4wLaAw95aCsorMhKFJ6mmVIsPp0WErH2my1Jgck7TMN9p5frjP6OiCxwaiVm6ecoeSq8venYyLyvIXn5WtLUZeIaxLziUafc2ExsMd8M5VKod4+6JN2Qubnxz3PRZujMSva3clMFeOC+u/+d3Pznd3J7PuCnlFRNXkJx8puQy7WhW9YOeqPPat3Y740o6GuKIYOK1XwVfQydisoWjXIB1dfiSJwRB5bIh7xOg94C+zYtHya3vFeGs17sdDGW3CvLrxdZYpWTH1xQFLSFpRuda9wdB2Fjs4Dyx/aH9/tYuww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Xz5r8Qy7HKc2WMm2YXivc7FGt6q4q6/+ax/gVL03dc=;
 b=WNWNiMJ9KGPqiLdVVUPy+R2mjVCLxCVvjENLXXSfHnSfB0/F/3VMKKDRe4INdGp/jeF+4S/OT4s5QW26vS0RuqTdZ0InVlZpjwAdjUezf7yc1Lf8WpNOFabZ9qhRGatUD9osh8yG+k9plCYusyr+g3bk/AZxpL/p9ZdKXBKuULE=
Received: from (2603:10b6:301:7c::11) by
 MWHPR21MB0286.namprd21.prod.outlook.com (2603:10b6:300:7a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.0; Tue, 5 Jan 2021 16:39:39 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::1c55:439:e94c:be9e]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::1c55:439:e94c:be9e%5]) with mapi id 15.20.3763.002; Tue, 5 Jan 2021
 16:39:39 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "jwiesner@suse.com" <jwiesner@suse.com>,
        "ohering@suse.com" <ohering@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH v2] x86/hyperv: Fix kexec panic/hang issues
Thread-Topic: [PATCH v2] x86/hyperv: Fix kexec panic/hang issues
Thread-Index: AQHW2C+JeK2pk6EyK0KhohVBANde/KoZFjSAgAA6vWA=
Date:   Tue, 5 Jan 2021 16:39:38 +0000
Message-ID: <MWHPR21MB1593C7460B98B88BDA63CB50D7D19@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20201222065541.24312-1-decui@microsoft.com>
 <20210105130423.nvxpsdvgn5zier4v@liuwe-devbox-debian-v2>
In-Reply-To: <20210105130423.nvxpsdvgn5zier4v@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-05T16:39:36Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=30e694d1-fd1e-4987-bd15-e2fecfc68d4f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2e41486f-6b27-4714-9800-08d8b1987e9c
x-ms-traffictypediagnostic: MWHPR21MB0286:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB0286308B571B3536981D132BD7D19@MWHPR21MB0286.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:404;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KD2C9Ux952s5OkFGZRMaz/YOmGQlS66a7Lf39d20tlRgSBBRwkaVf+qjOXRPP4j4koYxBVIKROoXXC/VP2h6ZQn6Ebjm8TXR7UfovsO0gL9UOw0zgx6yDZeS9VpOJiopqllWn4YuQRukchYL6pHS5Vk/4jsukh/naCzGOd+6FiECEBTIjPxXnkJUCNfUDdJRBA8tkOpT2dfOVL+roJz2JFbGxonmXhE+5JJc6ocdZiaE+NF7nE0G8XSqS9sa/ZhOrXdYpVrsFOdkOasNzo+itekKwat8tu2DFF4btPxE5qjoqfGy1CJyU+57PCqQZZX5M41dwaE8dAl17FNLQffLDcL/3kQdJDaFwIRZRlYRFekyW7TblT1IcGxJ/c9F6Q6FH7hGCtkMLBsKBg+ZszMJxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(186003)(33656002)(52536014)(2906002)(7416002)(64756008)(5660300002)(10290500003)(66556008)(8990500004)(7696005)(8936002)(76116006)(66946007)(54906003)(82960400001)(110136005)(82950400001)(8676002)(498600001)(9686003)(107886003)(6636002)(86362001)(4326008)(26005)(66446008)(6506007)(55016002)(66476007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?v521JnIbjKD33DsTHr1Tq+taNzmnPXofzbdcEWsXIqGlTpyLJROTJAaV4T9X?=
 =?us-ascii?Q?il4FN3XES91jTakJ6FiXiyaK3e/xATJtp7pCZgWz7r8lNNrgnc7qjDYjQ9tQ?=
 =?us-ascii?Q?fSxR2W3V8XlUoU9JNWmkNPUz5QIL8EKr+Ds/AmEMOK6iDqkzOaSs9zpQ+kU2?=
 =?us-ascii?Q?+pii8GKb6tdeGvFa+deOX1+Dsma/rkaPjh6nqbwFO9AeJF24ZOSh829xod6S?=
 =?us-ascii?Q?YtZVotTOuZFvD3XHYXVsWvV33ZyvQgfB7kQA+poN4eTgZZUom5m1PTItwvBt?=
 =?us-ascii?Q?keRc6VnreyFryMIkxZG1EGmQWQvHmVkjt3QLGC82NkRy8cNjPPnF3xwWsg9F?=
 =?us-ascii?Q?6hqM27k374juoAmbVDCo0aE1r8aVEzU+a+PsTCGv8BJT/qcy0AhcwMgBfZGk?=
 =?us-ascii?Q?XBU+jDyiusoeR7c6Yc3MTJb2ugPSIjI4yQq85LX5D05VebmH+Ab7nt+xfvad?=
 =?us-ascii?Q?PEqXk3wHzAH2vuSIInSlvaUTH3FPzxfTsfKVgd9tFnELupJEtkv/UfNwP3cA?=
 =?us-ascii?Q?74mW18leh9v10iQhUs85/eCsU2zyo9iK5ygl87ih3ERTUCeS+BEPhLchdTwM?=
 =?us-ascii?Q?Dw/NQOAlPDeAab7H2MjIqZsQwoPphXYuhVNKRYD5gklf7rhnAQKrTWP2bFBr?=
 =?us-ascii?Q?PyG6QiFvJdWpzwQGCEILEpxmDvDci8Khq7YmxiafN5xCNc74al65tjgCzo/k?=
 =?us-ascii?Q?CE8hhWZ7jSD4W3bz84YTecA2GqGJ/k5Z2dEaGED3RN1LgFC+qGT4y7YGPdul?=
 =?us-ascii?Q?+Q49dLUsQW1JhNlFS5gcMmap5AmU6wN2wcRAv+7RsmwQhUqxwI8UbRJHDMRt?=
 =?us-ascii?Q?PipyyU6Nm/PFmKIta4F/rh9v6hFZWR3td6jwLk2wSj+j1lNT00wek9tSf03J?=
 =?us-ascii?Q?i4C/foSU7WJCA+e4ym3OHUcxlAncuiEIp/LrdyWZRlo7SAhFPa9laOljzilT?=
 =?us-ascii?Q?WZokHkK/F9XCM4sAZewx3dL8hSm3Erze9G8y/3rrdHc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e41486f-6b27-4714-9800-08d8b1987e9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 16:39:38.8773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iwJUFdRycqS7cWpyf1bPYS58yPhyDJMk+oBVm/0wI2X39p9CNu6BEy7ozNOnu5TCCfP2d5nu9egGs6/pH7xwBw84DXveyUZLzuYtUj/ruvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0286
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, January 5, 2021 5:04 AM
>=20
> On Mon, Dec 21, 2020 at 10:55:41PM -0800, Dexuan Cui wrote:
> > Currently the kexec kernel can panic or hang due to 2 causes:
> >
> > 1) hv_cpu_die() is not called upon kexec, so the hypervisor corrupts th=
e
> > old VP Assist Pages when the kexec kernel runs. The same issue is fixed
> > for hibernation in commit 421f090c819d ("x86/hyperv: Suspend/resume the
> > VP assist page for hibernation"). Now fix it for kexec.
> >
> > 2) hyperv_cleanup() is called too early. In the kexec path, the other C=
PUs
> > are stopped in hv_machine_shutdown() -> native_machine_shutdown(), so
> > between hv_kexec_handler() and native_machine_shutdown(), the other CPU=
s
> > can still try to access the hypercall page and cause panic. The workaro=
und
> > "hv_hypercall_pg =3D NULL;" in hyperv_cleanup() is unreliabe. Move
> > hyperv_cleanup() to a better place.
> >
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
>=20
> The code looks a bit intrusive. On the other hand, this does sound like
> something needs backporting for older stable kernels.
>=20
> On a more practical note, I need to decide whether to take it via
> hyperv-fixes or hyperv-next. What do you think?
>=20

I'd like to see this in hyperv-fixes and backported to older stable kernels=
.
In its current form, the kexec path in a Hyper-V guest has multiple problem=
s
that make it unreliable, so the downside risk of taking these fixes is mini=
mal
while the upside benefit is considerable.

Michael
