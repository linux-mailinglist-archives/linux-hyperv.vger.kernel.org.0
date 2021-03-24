Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7E0347896
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Mar 2021 13:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhCXMgN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 24 Mar 2021 08:36:13 -0400
Received: from mail-co1nam11on2044.outbound.protection.outlook.com ([40.107.220.44]:7393
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229957AbhCXMgC (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 Mar 2021 08:36:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljQPbF4UG3V3bngusi5ePyxbb7CqapjcWgDYfvxXpEEu2t1m+d5aWFvsVAJtvhsvU25ywulw+va09ymIo6usP6ULM1YNxbS3k1wz4s7dbuBHr7zv9KqIkAq2Aj2jtEoe20SvT4UT5BZd1XzLGI7J+muZbBfCSnMLXIqQzNjqO4S7AnAvVoXTFtGPOcBs2lQ28OUQTATSQt1ocbLT/xFGQfGOhM3Bp6wqWr7/LTURT2q8pR+qm5A6Fo6lSAuSAhWVA2fIK7ETPwvGMu7ffGs2BUQWH+VfDtx0GETKiFXp8R/i17SbykOWE224Cf8yQSymE6lQ/l+lIzuJtKzkXYZhWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CPhcnaD8tUbx2nmKuzs+ON6ZVkZOBKCjvGTUaSntWc=;
 b=f9kqbw+m4Hqji2mb2s5T1X7bgnFdIEbwgRaoZui4ycMbWvUCbzwnRwEtz4okinqFkJ7YQGpa9CEGL6SWzxy2Uypzuobe25Bplp6wE5G9InBgfP+UJLUEc26/Dr35sFFYRLJyNUHDZhC22CTHwX1rPvnSdr9KuOUI+IumUAUT36ExuZOIXfTZGzXh4ifYhaGhtqUfM76li6/W7pzw2+ZeJghIw4u1nYr+SOj34abDdCPtFJqZhzposWiygEELpcjJLLDKwHu968n7QSHogJRN7Mv784A6yGpqUuFg8j+ijGb+DnUIwZQLWR9XswJACe3EdjwpxVKTNAOISEqX2enchg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CPhcnaD8tUbx2nmKuzs+ON6ZVkZOBKCjvGTUaSntWc=;
 b=c+TKVCa5jLLd1r2P5OIt+w7sHX3zBFalvU0yNwlVuN37Nnlu+fbLEJ/6Nu4VRmI2kKaiZqvT6KXFVf/GLN7pjhp7W7QVkMZ5UC7GfBMXwPbAvdTXzuPWKVzqXaqU4WyNO88D6k5emsU7IsJDKGnmbh5Ga1pIFRHyhwaa5sCd7iU=
Received: from BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18)
 by BYAPR02MB4150.namprd02.prod.outlook.com (2603:10b6:a02:f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 12:35:59 +0000
Received: from BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::2418:b7d2:cbb:27f]) by BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::2418:b7d2:cbb:27f%5]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 12:35:59 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Marc Zyngier <maz@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Frank Wunderlich <frank-w@public-files.de>,
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
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Michal Simek <michals@xilinx.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
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
Subject: RE: [PATCH v2 04/15] PCI: xilinx: Don't allocate extra memory for the
 MSI capture address
Thread-Topic: [PATCH v2 04/15] PCI: xilinx: Don't allocate extra memory for
 the MSI capture address
Thread-Index: AQHXH0vHWM2XLA5QrEqpQWX/K9e4TaqTE6sA
Date:   Wed, 24 Mar 2021 12:35:58 +0000
Message-ID: <BYAPR02MB5559D4117C9096D70C5FFE76A5639@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <20210322184614.802565-1-maz@kernel.org>
 <20210322184614.802565-5-maz@kernel.org>
In-Reply-To: <20210322184614.802565-5-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f65a4c04-c102-449f-27a8-08d8eec160af
x-ms-traffictypediagnostic: BYAPR02MB4150:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4150F260176EBC3C2B9735E4A5639@BYAPR02MB4150.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8jMHKArCVXBqJtwzwrtjk33DlK2Vo0g7PdttyAXqARTVWi7kO0Uv3HeH3gjai06rUzZD6FCDx6TIpo3k5EcEZ/qn2O0qrjE0hFnBrO30rt6bfVsBfpGueW+ufRZPetKeU6Oy2Bf1xBlL6AiYjSCnL8GSAvQrZvGZ2H4S5a1um7asSReIuefwIT4RbUJpkyYBfl2LPvSBwPy2OoaLT6IQx6GzevSqnQQAPXu+yfzdgEPonDAI3ddcAk3PNqfClLTsZRKl9YvQJ7hwo4gSHvg+tHIHX8lipfAZ7M+1whcAwgqcsoU5sw7Pk1KETfqjJAb5yFqdnMDVyQynV2rKSRTYT3AX+VKpN43qJZN4j9SSsUWOkge5x/IUl0fU0HorWUEaSvY1ZVq+iEXiur6dvBTwlfXMVchKo9jt1rPy7LlTwZO59TK9tUBRPSyjzkkp+j9sPaqxEAxu7Gih1E0hXaHuYZAKtRIzd3Rr3skojhIBxIcpHGx4QcK1tT9X1WCHLKntZdxIE2EDBTp4t+Rzu5ebuYQVRGjfeIZCGFM3gC/u5Ul3+CRc1lfRVRJvUTkl3HP0wDYzOVXQbMgjdsVastYKJO6YZUdHGnnEJXnvS+T0pmidAcRSLOlZ1lDHTcBzQ5CwRiBYdd1ifyvQ9XaVEu20frmYfGLeHO2HuzTRGI4XUHc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5559.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(8936002)(4326008)(110136005)(83380400001)(26005)(54906003)(8676002)(71200400001)(186003)(33656002)(7416002)(76116006)(6506007)(2906002)(64756008)(316002)(5660300002)(66476007)(7696005)(66946007)(66556008)(55016002)(66446008)(86362001)(38100700001)(478600001)(9686003)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4ROR76gMpWvOltTV1zkk9SgiVSs0F/MLs+s66MUtOSxqZ3iJYenU9CnYH9BQ?=
 =?us-ascii?Q?nm1z4csfg9cJL6xivP1BIsYhwn2OAL7w9KJ5sN9Hlep1zU+cK4earFq2Ll84?=
 =?us-ascii?Q?mO8iFFXGS4+5Z09OXAwmnMZtDZAJngvPKiIvS/OP/aufpWK+4mCdYOOb5nT3?=
 =?us-ascii?Q?M9LsPGIkEh6aI5+LrmFEednG3vBwVBtD5TBWgWAVSSR5VJ9wbB8E5o9ZC7mE?=
 =?us-ascii?Q?Jsbs16+ADlY+0Je+GtnAizdBtrbcbBEUioeYwh9TLAglIGSX+y+dRts7w5yg?=
 =?us-ascii?Q?3f3sn/xh7yVyAtrtAozE1TT9Pn4RDKdtPhivKgltTqTtb3yGZRRDP8Qyot91?=
 =?us-ascii?Q?rj//K/SXv3j1bQSgli9JGJCoA7ZZhH3BUsixmjytLMZPPGN4145ZEFCrNzbB?=
 =?us-ascii?Q?HNAeFebPOG+74oP3LhN71G38Sm1xL/B3ZAzCjTQ0kYrt4Nwmp1uivIcLwpx3?=
 =?us-ascii?Q?hYWw6oAoiq/hU/o0JZkFq7MCOtcwxwilVZn9nuBWxgKR37+tnhm2GPhRjht0?=
 =?us-ascii?Q?qvx1PgKstBU6IvqNuTzHF+AnrOg/e0wVa6GpsmLQM5a/F9s2cOYqICVw24mE?=
 =?us-ascii?Q?Fpo8ity9EGlo2Fpbr/70zCnsdiEVfzx9Y5uhZlG02qMQynffymdJ9GYbKQuL?=
 =?us-ascii?Q?bwlwSkAGv4dLkNIh1BCYHysrdUWVL35avrGxAcbxCkTpqS8SYudXp1INzzse?=
 =?us-ascii?Q?2N++v9wDxOVGHKvKHLerIiD2f5b+4XRhQ1Hi4lp9yoqGEunZkGfVAedDDaEN?=
 =?us-ascii?Q?7sVujopiULkO2HIQbnCIgLaTpjZB0BBY7Vsy4SrAAHgKi8m36UiECKepkKQ7?=
 =?us-ascii?Q?vpKoqmTi2vlGpZcYNDClbbiUvld1sHTgcvnzrFusuADrA5kGOI4WL+mvGRpk?=
 =?us-ascii?Q?hn3lxKVx90/xZhPDAgVC6lQeuaHIuLLMrvKyvQru6JJmvR907yJAA96PCExC?=
 =?us-ascii?Q?QL8i8BSyhk9mYUq/o+8UZhqO/gPI9pvnW4HfRo42DR9nSd2AXqq6DbbakoMl?=
 =?us-ascii?Q?6NQobNvVdl35V6aaxyXZ74Xy8IYP6qddsGBPGhkcd9iahQvuNcoZ7krCiEIJ?=
 =?us-ascii?Q?vOmzdZaIk1vCPoh84Egio8ND9sc9xRAOI8DNhdid2n32tm0tCStTYz0RlSFZ?=
 =?us-ascii?Q?hVi0aA+Lf+5hSf4Cl6hLl/hhtelzEpCuw89R5LIvNzvHI0ygOM36EUFt7rp4?=
 =?us-ascii?Q?7fb3Htpu+jkYFQc0/HQN82ZG9lrmPTdW5psBB6YyCsRMZFOl6Qjy+ahS75tF?=
 =?us-ascii?Q?Ugyy1MaRwY1NrjHaV2MxLRQklnOGbW2igv6uUXWi3WyGF6Shb/QSJLeHeB15?=
 =?us-ascii?Q?LLXW2v1+/LAz0ouoINQa0TaQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5559.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f65a4c04-c102-449f-27a8-08d8eec160af
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 12:35:58.8926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g1EvfL9aKHl1KUrqNwNhVPNjUTv8H5Fd68VVwyzoCoMG93Eh09V0uoLXU37yLxZY8EEfDlFJcI3w4R8nClPHgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4150
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Thanks Marc for the patch.
> Subject: [PATCH v2 04/15] PCI: xilinx: Don't allocate extra memory for th=
e
> MSI capture address
>=20
> A long cargo-culted behaviour of PCI drivers is to allocate memory to obt=
ain
> an address that is fed to the controller as the MSI capture address (i.e.=
 the
> MSI doorbell).
>=20
> But there is no actual requirement for this address to be RAM.
> All it needs to be is a suitable aligned address that will
> *not* be DMA'd to.
>=20
> Use the physical address of the 'port' data structure as the MSI capture
> address.
>=20
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/pci/controller/pcie-xilinx.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)

...
> -	msg.address_hi =3D 0;
> -	msg.address_lo =3D msg_addr;
> +	msg.address_hi =3D upper_32_bits(msg_addr);
> +	msg.address_lo =3D lower_32_bits(msg_addr);

The XILINX_PCIE_REG_MSIBASE2 register expects 4KB aligned address.
The lower 12-bits are always set to 0 in this register. So we need to mask =
the address=20
while programming address to EP.

#define XILINX_PCIE_MSI_ADDR_MASK       GENMASK(31, 12)
msg.address_lo =3D lower_32_bits(msg_addr) & XILINX_PCIE_MSI_ADDR_MASK;


>  	msg.data =3D irq;
>

Regards,
Bharat
=20
