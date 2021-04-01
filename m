Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E488351416
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Apr 2021 13:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbhDAK7v (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Apr 2021 06:59:51 -0400
Received: from mail-eopbgr1410131.outbound.protection.outlook.com ([40.107.141.131]:11291
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234336AbhDAK7T (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Apr 2021 06:59:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaVjsyH5HWxZL2fVR1WXhgfwtuT9r8vns05MY15+ZIU+70LRb8/zIFn8L/lIi7e18KsAtJVnlGzHp8Dw7c7Qw/uKXzE+gnVJB3/e+iviVIlHqUW+xRhH7O2cRyem+DwKLyh6HLbu/BPdL1w8DPMB0OIuCWg1BZwiMA+4zY/LF6VuCLNAbEqzCrZ1GLhHwxLB9FrF2FS8kCBD0OHpd2YbmXDeIZi7xnsD+gHMGzqWmYzQmr/JcMHfXqsT3SLRfJkchg4Sluu3JT0stHgoLG/3atLCaRB5sD5UdkmssZNucaSs5zGDjCclDX6Akam95+Gc/CppP55qa2sgUmpFNozInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBnSNyEQ4+n0IfClSmayoekAUJgxtFLKBnvPxD89qac=;
 b=iSTN2nozyoWb2b4hJDYZ0WRh/Y4EcMUaUPoyle2eaB/w3iv/i7vbp7Ft01i8y1a3LaDy1eIfh1/eEBIqhCvxPt7x9rRd8pFGw+Ru6kTyCJ4J19vAqecbx4LW6XnsQmADW5bVu0g7dA8CnLkn8PMd/52jK2WjvyJJcStsOlV+5hqksP7NwsnPpq04OXxVzrrP6R+Bzys0I4DjSNoQhaCoJ9/FFjG7kcOI7sIpBGYZAyOTmGW7+I+80Aa/Y1TQudV/OS9bOw3x+7kIRtFirQHDOIb9UVgq5AHeqNh2ZSGa6+XMza9WdyhjUCD/fg0HGM/5fkQYZCzUqnG/9Q0Q/JbgsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBnSNyEQ4+n0IfClSmayoekAUJgxtFLKBnvPxD89qac=;
 b=ICIV1OooPu4vC2H6B2eoBTUDtU1MANgsjrMvRs3IE8NLWAODbF1r2TMXNrxg4AL07T2RW+Tf9Bb9s0HXC4QHFbkjyt39OKZakaPi/W7WYKPS/MVYz/S0iOjRgyT4LjTM521KZHchF2n0PEOdwZRQukWzH30NQ1jUDY0ixm1EhfQ=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TYCPR01MB6656.jpnprd01.prod.outlook.com (2603:1096:400:9d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Thu, 1 Apr
 2021 10:59:16 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::e413:c5f8:a40a:a349]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::e413:c5f8:a40a:a349%4]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 10:59:16 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Thierry Reding <treding@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: RE: [PATCH v3 02/14] PCI: rcar: Don't allocate extra memory for the
 MSI capture address
Thread-Topic: [PATCH v3 02/14] PCI: rcar: Don't allocate extra memory for the
 MSI capture address
Thread-Index: AQHXJXcG+5u1h/7Mf0S8wvROOYQXFqqcp96AgALYqkA=
Date:   Thu, 1 Apr 2021 10:59:16 +0000
Message-ID: <TY2PR01MB36924566960FE203EF3B2FC9D87B9@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20210330151145.997953-1-maz@kernel.org>
 <20210330151145.997953-3-maz@kernel.org> <20210330152857.GA27749@lpieralisi>
In-Reply-To: <20210330152857.GA27749@lpieralisi>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [240f:60:5f3e:1:30e0:e1c4:8f10:3212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44742a11-5ebb-4f88-b5b6-08d8f4fd314e
x-ms-traffictypediagnostic: TYCPR01MB6656:
x-microsoft-antispam-prvs: <TYCPR01MB66566514FC9C90AF41AB6EFED87B9@TYCPR01MB6656.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kMCoqHNYwJEcw4JyAJbiNoSjOPBD5mmVTiZcIJ42FdN0oJmJYvJwhlm2Tmeg+iZrCHOz6FvfdPMHOz1xybYih8fNb6JB5zRtCYXR90+ygV7czS7Dm2M2qdxcA0CEhU3LObNoBORB5LwAxiLqKXxosRpV1YEEMZLgKanMehMChgzDye1MHNS+MOsmyV9Kn9IeZo7+SJEXEqJ1M/jf/tANGOevMQbbZmusrcgtrsQKJ+ogr3y96Sib5HpkqPahSL6FkmVE/10cSmE4a5p9wECLHfoG0NgTE7QNip4gbEPuwsPQGtTtZuOTxJLqQdWDdxJOPLHynnsP7u+2/xDtDdq34TsGDofSRAH8bRhamLh/lokLobl6iWVbZuwAGA1JVbK7mj6nOrj1ZHdLi9rjnvWh98BFAqGMuOkC0gPoRrfoHVf9sdmUO9GUol+IDJHt+9yCitWsHrfa809TA0aflhXhOQi2uFo8qOflbZ5DnDzDcINOsf1OOdjgChjtk1VbvEVLt6TF5t3axaqUXoaZHRYt+sUbXHiQjQx7F0bzibm3WJK8Z2zVBnJcm08clXSV9PCWSwXPOXXjid21rfnFrojB70spctY62w/C2EA/87Soz8ENJ/x5AVs/2Pl0i+Filv9FhOGpcLUWtgRv3gEsXeS9i1TIgNKmMImKsFq5YHD1RLM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(110136005)(5660300002)(4326008)(33656002)(66946007)(478600001)(7696005)(83380400001)(54906003)(186003)(6506007)(8936002)(8676002)(38100700001)(86362001)(9686003)(55016002)(2906002)(7416002)(76116006)(66476007)(316002)(64756008)(66556008)(71200400001)(66446008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gPyjddPLC//OX/VzRDZ9M7Opb+zucWQvxhqGAYywK+j/uExuF/NWfBxPNZXt?=
 =?us-ascii?Q?j+XIqdNEYaAZwRQlLOyZPKpVMhT5H22f5kBsPUzw1fq4B+/8oEfBPMtYjwep?=
 =?us-ascii?Q?LwAAICoCgmm6+vXJ0kDGJq+9FA4y34dRREP/o9POHzyp5qBaHKD0onWBHVPD?=
 =?us-ascii?Q?aaoB9dlCbkex1KI5lXyCbR+W8Tps55NHvUvVkBbAcBU/3hUFTLdNrUqr6df3?=
 =?us-ascii?Q?T/4Zs0tc+RYnfvNB0nYNylob1Fm40CZ/7D0x9O3vmy1FQtxLG3k+lZyd52wr?=
 =?us-ascii?Q?WLD/IrGDDe9YwpazQZNQBro2/MCmih2gr4Z1BP/9bstRvVt95L5FpT6yISgX?=
 =?us-ascii?Q?jTPQNtcMm5HXne3jn728JfnAWdNU/aQZ0qWqrLGLstQdVzC5koXFzBQkJYo7?=
 =?us-ascii?Q?+lHhKe593dRSqiR7R/heEDAM4iVCcchT3ucclFZSs0hHfmXzteSOAPsBs1jY?=
 =?us-ascii?Q?04i9HwD+GDPVcoJFrgWHfA1WOYJk01TaR909PcOrrYMgtCA3Fi6vRMdrTvy/?=
 =?us-ascii?Q?QfoNMtwKiaEwXNW3aijcHc40KSX15JX8PeWAwGM50M5sUlPZ1IZg0XxEaQXz?=
 =?us-ascii?Q?rrEBPtfxxaadUgBdEs14zcOniI9oBu+VTJZIxtaI6hZCqb76DqHNHXB+/9XH?=
 =?us-ascii?Q?7/fMTyKRWhFsyYH95FQsW8qUFM//ESVYN5vyV0G9PKKSjamupyO7JXpnemcQ?=
 =?us-ascii?Q?Utg+qLYjB6BGuxs/mQh7Pyft7bUuR2aIoSOHbF0+mwMM+YllmXtWu4RS0zwg?=
 =?us-ascii?Q?bGipPaZ5tOB3NlyD/s5jNOTBpz6EQpOz7tWveECB225Y7RrJFX0xtwjIDJf5?=
 =?us-ascii?Q?if0V0KKTXOpT7RECvL/fiSZQufPRrBcDrWGPKGYA8HsTFZJKn60zLrXXJVjX?=
 =?us-ascii?Q?KLF69uFCY1zyAY9LLcw1b21IeGUqvMcd1wD0iyh+rDRB1BhbE7GwEwZ3wYXQ?=
 =?us-ascii?Q?Cktn/rP6CFVlVwgVwQrAsgPwT7ca2rIWRsC+XE1qbpALFeL1NYiWP69MVMZG?=
 =?us-ascii?Q?ADPEA7Aapaz4Mm6IppAlq/KMTOlaK6npZitWV3zG7Kkqw7rCpRzxj1YBuh+j?=
 =?us-ascii?Q?oKQ+6ZxYlJ7sRvuAATjLKWcLNwCLjuIE2reHKUnPfZWll6DsUKn17JjiVQ2v?=
 =?us-ascii?Q?yIPyMbMmhwgxosfNpwp6RXtGnfOEonVIS0QICdmb5BVOid6HVH/awY5Yn8o/?=
 =?us-ascii?Q?5gNmJUFehyW0mrzOxYIYGf1+sUwTUf2rJMQcKw+XTvXPhuB5Xnowl4FgdN2F?=
 =?us-ascii?Q?hqR7weCk7FVTN37A4yByjreIsOUdX2PnrSFdHK2cIFGmxCEqXwWePZ6nloSX?=
 =?us-ascii?Q?kQ5ex6cE6pX9ggVAtyoUtrO13CcMFqQd/W6Ycsmk8/j1/qRPr3yytkReURO/?=
 =?us-ascii?Q?zJ0PLqU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44742a11-5ebb-4f88-b5b6-08d8f4fd314e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 10:59:16.2111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LcEgNJjADl6LHZnO+kPHZOziidTGgtgapanU0ndez/FB1+gEs0Kk6q333UW3loj8jxtHShbLjRreZbpg81j5DQPfjTHyW+6sFoZCQ6IQ6wM3X1zUfcOFoQeVKs04bLbW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6656
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Lorenzo, Marc,

> From: Lorenzo Pieralisi, Sent: Wednesday, March 31, 2021 12:29 AM
>=20
> On Tue, Mar 30, 2021 at 04:11:33PM +0100, Marc Zyngier wrote:
> > A long cargo-culted behaviour of PCI drivers is to allocate memory
> > to obtain an address that is fed to the controller as the MSI
> > capture address (i.e. the MSI doorbell).
> >
> > But there is no actual requirement for this address to be RAM.
> > All it needs to be is a suitable aligned address that will
> > *not* be DMA'd to.
> >
> > Since the rcar platform already has a requirement that this
> > address should be in the first 4GB of the physical address space,
> > use the controller's own base address as the capture address.
> >
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/pci/controller/pcie-rcar-host.c | 18 +++++++-----------
> >  1 file changed, 7 insertions(+), 11 deletions(-)
>=20
> Marek, Yoshihiro,
>=20
> can you test this patch please and report back ? It is not fundamental
> for the rest of the series (ie the rest of the series does not depend on
> it) and we can still merge the series without it but it would be good if
> you can review and test anyway.

I reviewed and tested this patch and it worked correctly.
So,

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

