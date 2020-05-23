Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506E61DF38D
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2020 02:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731182AbgEWAk3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 22 May 2020 20:40:29 -0400
Received: from mail-mw2nam10on2106.outbound.protection.outlook.com ([40.107.94.106]:34369
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731169AbgEWAk1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 May 2020 20:40:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e277MVzmDYhd7n5hg6EzHQlqMFtDjuXXfloa1jsHLE64CmIwS6vvqTl/1w82/+KUoFAz8R0SecN0avyC/NpQr6tax9yrpYOLNnU+SOAfJ5/CYvRxYHKJgNCE5z8sU7H0Df08ahDsF/NXV6kysR7Eguivk+8cQU6DUroolA4FjZCXZXfcWc5iGc6rlxAnIruMZu78GGoQRt+gsSPUK3ZknIuS1kWOT4gOmWcX/0guiHjkfYzt+fzfZ8Qb9oQ3AbpwU3Z/PPdyZ/WSV52i2HFJlMdvp9UnYESSb6/nicRdksJZYv7eMK4KWEm13u3Pi3xtgj3QV6MlAEeYFVhcdMDo2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5PO86VUE+NSHBz/pHSPCSf8mUGqliYygM5IvSwvZYc=;
 b=JF1NYCj/tvjpfv4QahOJCUmHVMC2ZQBGTyf8sqR9nZnB6XQlxzJnZ2HWOKbNTURLRK3BN7DZEnDnpDCCNdczEUV493n72mNCM0jzESkt8OO5Hm7azgi7pLNqVz+Lw5uzBlhBLxOY7/VsPi6Szp7YHxWVutCasVsQRG5Pp0Ht6xVUr2j8aHkiRCVaJGaGxzGZA5LCYy79mVApLkZvo2imc1JsGCT7SlwQwPHCI3cE4PmS4RkPBdzIEGspOXDBM0ABy15zz60zDEKCfNd/GTCwyxZfxjj/h47EUkrOXiUbls3hV9YJWs9I5DtoiYGCopqBOSqOQSiZl+CVY+Y8menTkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5PO86VUE+NSHBz/pHSPCSf8mUGqliYygM5IvSwvZYc=;
 b=InaJ5J7GX7yXfwwrQ7pBfHCDIkgava5NEeHm6zz4691hXpw24HrfqQDvSpmG8z/8wl5uiY0oK81WSLgSLOU48UgicH+SBISkubZ0NRPBcMG8DvrDYSlWC89NMnYpU5CsbdMm1Qh+Kktmp7vKqb/kEbjNluuyQRV1q+20hdwsjyw=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1114.namprd21.prod.outlook.com (2603:10b6:302:a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.2; Sat, 23 May
 2020 00:40:25 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::5a3:a5e0:1e3c:e950]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::5a3:a5e0:1e3c:e950%7]) with mapi id 15.20.3021.002; Sat, 23 May 2020
 00:40:24 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH] x86/Hyper-V: Support for free page
 reporting
Thread-Topic: [EXTERNAL] Re: [PATCH] x86/Hyper-V: Support for free page
 reporting
Thread-Index: AdYuDAEiPLOc+vnoR1KnBaBInLPPAQAeU/0AAHOA1cAAEXefwA==
Date:   Sat, 23 May 2020 00:40:24 +0000
Message-ID: <MW2PR2101MB10520A323E708F71A9944758D7B50@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <SN4PR2101MB0880BB5C9780A854B2609992C0B90@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <20200520090158.4x4lkbssm7ncirn7@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
 <SN4PR2101MB08804F99992085C64982C821C0B40@SN4PR2101MB0880.namprd21.prod.outlook.com>
In-Reply-To: <SN4PR2101MB08804F99992085C64982C821C0B40@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-05-23T00:40:22Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5b38e9df-0b9a-46b6-abb2-ceb198f3ad26;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c919ed7-c4b8-4510-72c0-08d7feb1e1f5
x-ms-traffictypediagnostic: MW2PR2101MB1114:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1114C7FC83E2DEF3694A00D6D7B50@MW2PR2101MB1114.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0412A98A59
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mDqJGbj63VOWNOT2AdPeu8lwYnxH/4wrFnoixM8TZe6q0jMJZKTpJrg13A+HgAqf0SWwHTjRsk6bSeUyy7EasRpSbNX05zlaf/fmBuOGTL5vrSWBdrAO8idtuuHcygxKGQyF5yGYKYEvYHL75xP+bjYRWtB46xWAb+LTmTjVoM9oI1rQGdLD2nGIzqUs7Sgx8+BHUiMHZI1RXQCiq6mwtExB0oLmGoAAC+UN7btJfgGHe2mO0J/RboO9BrnglkdSOeL83aTZFU/ctptzG4cezz+ywqxzIrJXGD2EyTOEo5flthSTFZ4Edm28tJBDLkwfvc8+ViqqmfL3ySsH2NxAqbDMUJMPMvL0z3g3bW4QSAT3muIb62/uBXtiSOhyogTf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(66446008)(2906002)(5660300002)(82950400001)(82960400001)(66946007)(76116006)(8676002)(66476007)(8936002)(478600001)(10290500003)(33656002)(64756008)(54906003)(7696005)(4326008)(316002)(110136005)(8990500004)(26005)(186003)(66556008)(71200400001)(6506007)(9686003)(55016002)(86362001)(52536014)(4533004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: TRMIg8g+J/RNu9n76x6OZDel5v3FuOqy5n/PbUzt3w0eTnBhBAxFGpuoZkoksNwBTvgw0Lr5mStQwOI/AK1PZVggy5+bv6Jjr38inS/FYrXucgjEyjlcdaZe/jIbB3caBcr8u7L6iV3T0jD79Dfp2s2FvPvaUBpSW2Pis2wnYDi5qTgDnwV8jiM03Z0/H0quCyAAPLlTL6TwIvmzLbcXPhNwNzlxQokY22sAu6iKwT5Hj0hRq1CTld3jPzfPobR5GFgb6G4TROtH8AAzFEMBRCvAIT1uuQ4LDx0a4FtpMM/wQVrSUwYsp02zIovsZiBkJnbDBdf2OWSOICOq7hHB+BKMV2IFE5XFfXyLk55ywvLcTE/TruM+P4u3/V1zJCeZQY6Nca1BFHeph+5ePpG8EK1PJb/c0jdhDbWSru0tm/c2y7RxhDjMkNwXx6JCI6yyOLIcLc3PO7Mf54QnN6tMgBQQWbVSDnEvshaFleuSElRkbaDlHVphddX68XSxlkxq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c919ed7-c4b8-4510-72c0-08d7feb1e1f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2020 00:40:24.7531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jVYJ5GG8SRhfkZa/ckyct+Xw9huq/0OTKK4f5z1uCL4jqM1S40XfHcy1asl8DUeyxFhdjoGlgaYup0UTIl729RS02ztKFRlzjN2QeZ/KvdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1114
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com> Sent: Friday, May 22, 2020 =
9:40 AM
>=20
> > > +	if (hv_do_hypercall(HV_EXT_CALL_QUERY_CAPABILITIES, NULL, cap) =3D=
=3D
> > > +	    HV_STATUS_SUCCESS)
> >
> > You're using the input page as the output parameter. Ideally we should
> > introduce hyperv_pcpu_output_arg page, but that would waste one page pe=
r
> > cpu just for this one call.
> >
> > So for now I think this setup is fine, but I would like to add the
> > following comment.
> >
> >     /*
> >      * Repurpose the input_arg page to accept output from Hyper-V for
> >      * now because this is the only call that needs output from the
> >      * hypervisor. It should be fixed properly by introducing an
> >      * output_arg page once we have more places that require output.
> >      */
>=20
> Sounds good. Will add it in v2.
>=20

Note that the only real requirement for the output parameter to hypercalls
is that it not cross a page boundary.  Since '*cap' is only 64-bits, you ca=
n
declare it as a static variable or even as a local on the stack.  It will
naturally be aligned  (or can add __aligned(8) to be explicit??), so it won=
't
cross a page boundary.  Then you can skip using the per-cpu input arg
altogether, along with the associated local_irq_save()/restore().

Michael
