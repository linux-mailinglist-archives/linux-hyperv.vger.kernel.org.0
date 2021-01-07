Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD88A2EE6AC
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jan 2021 21:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbhAGUVB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jan 2021 15:21:01 -0500
Received: from mail-bn8nam12on2119.outbound.protection.outlook.com ([40.107.237.119]:48224
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725974AbhAGUVA (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jan 2021 15:21:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsGTtn9xvCbUux1AY9xj9khTNhEhU5dVp8U/96/TIFf83LfVgDMW2RaSK08KQ1q5WuKFh1fPPJMcJZ2XKtS2AGvEgrwAKBZQ0irnfGphsVsPXR1ep3L9XftgEA3hlMCeFEg5/D2cLrue2LiOgoxpWO+yBQHjUjgK+PxSDcS4cmuS96qrwJ4E8cHxVFQE41ceoX3i98njeHxIrBn4ki0VBoZn/nv7SjMlTvOQiyLPmIcB+Eom8FmE2TYUkR07fMDHssMuzq9B4vgnvbK2S721Uz6mrlXmXj6aPvaCuuNHaFW4AMfbwz5SkCcWhz2W+X970uYNTaqsJRObq/27ju1AuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWm/QOmsTsyiYcl887VMABad2kwCs3ZWsvBE2oCfERI=;
 b=VozUROJTnvGZPMksL2GjYmNZFiSoyrKYQmuuMaX4z/ulMOJ6H9df8Io23J9Kf8G29LbtCtuBmMXrZ9PY/jGbxN/NvgBmPNrBQvsYShhvvVGfO0aEl0eHXYE1ucuWe47NTGoPtJxDm+mW+OPhre2mIZFGpf4lGJUuqNntk4xMaq3jYQdlcCNEQLARrdDTM+WR85Tgt3JEClvW1ZLWxe3J8yk4hIzMJ4nXZMHay2Q2rMAPTfAfrLFGfAPqtwb4Jb+O+c5UMPkk3Tt23CbP9onvAJWjHKqz5/CDM2HWaUrC9KH4nVdKo23dQSh5rmPXrhf99YASXqIf9KZG6ShsK3DQNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWm/QOmsTsyiYcl887VMABad2kwCs3ZWsvBE2oCfERI=;
 b=Y3OSPd821ANqVHQpVtctc5oCD5n0rqBwk47iKpYBBBt3FavFL9swW90kUiW5eI/UrMrhH89dZAji3SffJb1PqZb1z7x9L3nAN6PCvsPC8Vgp6CnwBuj/l8bBOquPKDpJ7uFn60bH31YirKrzkIEp/mAh8ROdkJmUkyZTB7iyBZc=
Received: from (2603:10b6:803:51::33) by
 SA0PR21MB1915.namprd21.prod.outlook.com (2603:10b6:806:e3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.0; Thu, 7 Jan 2021 20:20:12 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::18ca:96d8:8030:e4e8]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::18ca:96d8:8030:e4e8%4]) with mapi id 15.20.3763.002; Thu, 7 Jan 2021
 20:20:12 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "\"H. Peter Anvin\"" <hpa@zytor.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH] Hyper-V: pci: x64: Generalize irq/msi
 set-up and handling
Thread-Topic: [EXTERNAL] Re: [PATCH] Hyper-V: pci: x64: Generalize irq/msi
 set-up and handling
Thread-Index: Adbksm0P1pe4NiY6T8iz9IYs5m9slAAU6kwAAAr5moA=
Date:   Thu, 7 Jan 2021 20:20:12 +0000
Message-ID: <SN4PR2101MB0880293321377F18713F4547C0AF9@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB08808404302E2E1AB6A27DD6C0AF9@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <20210107150216.GA1365474@bjorn-Precision-5520>
In-Reply-To: <20210107150216.GA1365474@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:916:634a:e039:b890]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f98bd86-dba5-42aa-c8bb-08d8b349a344
x-ms-traffictypediagnostic: SA0PR21MB1915:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR21MB19159F4A77BC5F98C7A3219AC0AF9@SA0PR21MB1915.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2q+TdfO+In/93NK5ncSq2unKWre53QIsGxuTTecuPexxz4deq5ASLJgUQyhuNemsRtRgWXcsnaAitar7OgcxZMib756N2bzWgWHEqBdgGbdLY1yBuDy39lZrwuiNt0pX+DEVQLTdt8+dSuNrF06WAIwPVagLOSP7f4BTdE1poQzO5S5oVN6LQi7oD/ZINYWlushYxYEzhH8Xz3LDGizvNj1Yb1mAQiFsSBqm2YpZCayBAaUf5D8SQKI+0Yl+D0QqsYIxha+eMu2opVzszHtwdpvGekaOGxauqmHfieDQSZhd1fX5R/mYYp0udgjt4mOrOipRPi1F3AXHUZjlh2ycxLAk2/usWKmqa9Zi2b+GfFACYhpnMsu2uFCdejzzK2I5wLYVZNNlIxdSNatLqenAYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(2906002)(10290500003)(33656002)(82950400001)(186003)(82960400001)(8676002)(66556008)(64756008)(66446008)(66476007)(86362001)(66946007)(52536014)(8990500004)(478600001)(6506007)(76116006)(8936002)(7416002)(71200400001)(6916009)(83380400001)(7696005)(4326008)(316002)(4744005)(54906003)(55016002)(5660300002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TKjcz6ISxxRr7VA827mj2yinbwI7aJLcGjzQ8sAxEzOi8+39BfXsm51RqiqV?=
 =?us-ascii?Q?43e18XndLjyTCMZC8kINXs6Tr/PGR2mrg+32OOBmoNOCZwp8vh7GuS81P1wo?=
 =?us-ascii?Q?NNliFif7s2d9BUY+qKIsHGpHynDJ7X6PXTGBOQ17+1dRPN1zijXZMeHtOlxE?=
 =?us-ascii?Q?ugXZNTGlBE3nV85PzGaO/9cXXog9JJr+F8vgolldS0MAMEKYmiEA4qQdr2eP?=
 =?us-ascii?Q?3t0zh9P6y2JJ8NOWDm++U/4q2x7NZye03W4ZvxSQz/6zMSTyaYJDTZJNUOSq?=
 =?us-ascii?Q?ycqvHCdeGlilw4Zz1KSciqwpWzcO5DBUP9CYTIkMG97EPa6rBfc4X2pZL2T4?=
 =?us-ascii?Q?kKJ+f/kZGcQTjC6Ddw2dqzbdLLyxiTN2mEjEMylL4l4f3/FV41TJvp+bc5ip?=
 =?us-ascii?Q?JpeNNB4INoSQrp0dUqEgyqjBrh7h36KgYNAjhWNGXMTGNlX9uGdg6dWRodtA?=
 =?us-ascii?Q?MwYoXcYQr6QaudgzDCT6ptxOhGVpZuAXVPvt+BuIY18t9aw3Gd97gI7NIhlG?=
 =?us-ascii?Q?7SVgJjrDs6rB2ZE4lydp3EILjP6DzqDovy5OAzhAk79QwgfK4DArriD2sfPM?=
 =?us-ascii?Q?ryoKDlNB4IlBfUAEVpKLw4Avt/Vgo2z22WH2fin79msxO/ucW0pPDYxTHrzz?=
 =?us-ascii?Q?nOVRL96qw3MGDg8p0CF9JPJdYRmpZkgMjzh70Eol3aRl+xh+JxEyyfQMx/32?=
 =?us-ascii?Q?5nuGEMzIydbyox5v6LZbia90XfeQn8SHAAGr5tWvPoiz5AmHnYz6e11grU4x?=
 =?us-ascii?Q?sTD3/5eAkVr45EEsIHr9a7p27FzNHzZVEGPKQvugJAznV0Zfg/ob7nXY3vux?=
 =?us-ascii?Q?pPu/NsPvGfbiKMqMr3n33gVY6aS/uJjtbw+ffx9cEOS3IMDtpwJVUV6K09o7?=
 =?us-ascii?Q?2r4+WhRzQhprIqN4cWtfk7oJIC8+Pynm3JvYhOeKZ7+2DF6L/m/UrWQV5O8s?=
 =?us-ascii?Q?EAKzvq0haSaWqNcoYG9eQz3BpSpRH512Vp1Q+TmthiJtPyvbcKBGg9FWD6ZS?=
 =?us-ascii?Q?xmm6TeGYw6dyhP1NKlNcbK8vK+DNUBsLTCjEV3TNDtgqous=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f98bd86-dba5-42aa-c8bb-08d8b349a344
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 20:20:12.4247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eoGIzLBUL0VZ4i6lGCDJeUnwANUJGV2KU1BPZzT2VaFR9jSiuvGKqVaedLGd1kWxA9qfE/oX5g7tcwWqN4CmGRFML/+3+3u6dZZEtxjCqVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1915
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> There seems to be a long tradition of dreaming up random formats for
> the subject lines of Hyper-V-related patches.  Look at all the
> different ways these are spelled, hyphenated, and capitalized:
>=20
I am reading this as a suggestion to unify the format of the subject of
the Hyper-V patches. Wei and other maintainers of the Hyper-V branch; do
you have any suggestions? If we have already defined a format and it is me
who is not following it, please forward the document my way.

> On Thu, Jan 07, 2021 at 05:05:36AM +0000, Sunil Muthuswamy wrote:
> > Currently, operations related to irq/msi in Hyper-V vPCI are
>=20
> In comments in the patch, you use "IRQ" and "MSI".  I don't know
> whether "vPCI" means something or is a typo.  I suppose it probably
> means "virtual PCI" as below.
>=20

Yes, vPCI here means virtual PCI.
