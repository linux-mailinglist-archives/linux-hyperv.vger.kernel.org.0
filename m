Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344921DC550
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2020 04:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgEUCkD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 May 2020 22:40:03 -0400
Received: from mail-eopbgr680111.outbound.protection.outlook.com ([40.107.68.111]:51877
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727798AbgEUCkC (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 May 2020 22:40:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eq+t4RVtl4y+g8xGPx6jaxV+9N8wFD9FxQx49G9gs+EP+fSczWBuSMqliMEBv5EgKe82JlzqDaXo2y0SFjcxEJK0houai/7zQ/iAcgKT6q6otS9Gr607/h5uTVBnA3CEBb59Nr0aTknRNkJIB5bTBbolmX/zXFVaZOr5JgQibVXWAxvQ8Me9eWkXsa9hkyiYHM/DCDTKMfYmdomp4nAdodezHITpDULvPpeC1ve9XpUHGB7yR3W3HTC74En2Mr6/OKf7nOKQ8/zDFK3GIoJ2jPbN56ta00y+acJyQkVfQH+AFFarUCyOWVtDeh+swYhJ7k+Cfe01bVB2JMSDxrUybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJCn5FPmIIS/h431zQd22jLdo42vFtxF4dOHCH+nt2M=;
 b=LIP1OU3Muc0Jf8I8Reos0idotmdbKvpfDtaArMKxF0eDpf/XIXJUdLrWplErruTCdVKcjGG7g8uOkVQKJ2Q57SIs+Gkm21BBNFiQrlgLkdkchrxqSu9cc1FFaEfgPdZ8lPx57hJaelIBubtt2oNcv8xdW023IAtgZxcNxjFjdGgqJNGnpkbJEeVPlTHSDfUmqa/XPbyy6y9s5zLSi50+Pz0H6xZEZ4vIENVoWpytwPX7niykbHPQvgwANNIIl8TLuO/9NcFbq2Wd+Fp2Y+3Yhf5+Q8jD+YJTcxQujgeLo+ftklO0Kup7eikKSfpznhYUHO8omHGdT9raHyyUDIXNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJCn5FPmIIS/h431zQd22jLdo42vFtxF4dOHCH+nt2M=;
 b=AK4wW+6dqCOKZpymsV710tzDfPt9cbm5OGqjTiBiHMApsgGpuaEbzGqoRxSn3w3Nc9b7H1EhJtKS8rjzjlazAuRYR11YCObN6hchGnwcm9UXTHns84trzPcjwamUr5ogs24imkt66StEiu6EsPIUsfieBeSqkJdsITmUxHE5U/0=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1098.namprd21.prod.outlook.com (2603:10b6:302:a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.4; Thu, 21 May
 2020 02:39:59 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::5a3:a5e0:1e3c:e950]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::5a3:a5e0:1e3c:e950%7]) with mapi id 15.20.3021.002; Thu, 21 May 2020
 02:39:59 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wei Hu <weh@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v3 0/2] Fix PCI HyperV device error handling
Thread-Topic: [PATCH v3 0/2] Fix PCI HyperV device error handling
Thread-Index: AQHWJCyh/f5cuxgdoki6x8K/JICAa6iixF2AgA8khTA=
Date:   Thu, 21 May 2020 02:39:58 +0000
Message-ID: <MW2PR2101MB1052A57E7BE9634821E29E4FD7B70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200507050126.10871-1-weh@microsoft.com>
 <20200511112147.GD24954@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200511112147.GD24954@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-05-21T02:39:57Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8263d610-0dba-4e00-a6d5-0de1012866b9;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce4abb99-648e-4c7b-d42c-08d7fd304158
x-ms-traffictypediagnostic: MW2PR2101MB1098:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB10982358BD9F77C226F99769D7B70@MW2PR2101MB1098.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-forefront-prvs: 041032FF37
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VLcVYNMBGRyERc2bbpYm+X3+YpDxWbVUujLLkfZkEwL/piLX0xEV8RhYBJ0GYKd/SCSS2HIc5za+y0uaRCP1Wo2g7foUOgjAoMUPVF9uBB1jVrceoo+dOrVtDMwF5IsnUDJ7Ccb6VJJaKn2tjU8g0V7ASAuDmpCVcW0B9kjKum/BZYm156ASsXqpoSlhfjm+O/DG3F42JbFRE92KukQ6JVt88Um9n8wO60QCnvnYHmVw1x4ctCi0J3wwl724zODnEwcKPG6keX+brk9rENqUaoOqRy+KJtfIQ+PnCacu32zLxTZ3IVHQNg279LpmFar4S3egmHhNDPA20vjECoeACw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(64756008)(8990500004)(4326008)(478600001)(8676002)(52536014)(107886003)(82950400001)(76116006)(82960400001)(2906002)(9686003)(54906003)(7696005)(66556008)(8936002)(10290500003)(86362001)(110136005)(66946007)(186003)(33656002)(55016002)(316002)(6506007)(66476007)(26005)(5660300002)(66446008)(6636002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: GUru+1kTfn9h2ZyXP3v+jV55jC1BX4YvRSElbkRrZxp92z+QiH9aFiB8N04W+F2/jYQ35AhelYdG8YFjCOgPFXZVb9WQhFXn3onywtipLOdcJaCGnTn5ZhTgUCJwQ0TB7ULgD5wi5fyeva5hOAj2JkdFCc05xzytvsAdfSgY5yj6DtaEncKHkjnY2yMnS9VbmmbpEPP2n+vvvRSTQG98x/Y6VyjcdKHSL6Zr9rsdQ29YG/kS+3KtfgYEVqHI0mQLT+UiFkdn8cwobkUIQFGVtEi43ajJj19AyIZ7thLhO/DQ0yiV5Dx3CXC2Y/9LTUsKgivSVx8bXMZZm3OVz6sPw9rmLgiuwm5dfZQGUF3wr1SWjAtwh3qRtSJ7sNfzxSnlV+K0PGE6UcgRV/wuRR0HR1NYMqgE+md12FCa6dvs7PGYxYt9vHVNi/kGTeHD17JemJVoIwkMzHwshoFuXs4/sHExUXIlm64W6O5C7ffHnGGsY+Tuzm0d3ZOuKbVvJlLe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4abb99-648e-4c7b-d42c-08d7fd304158
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 02:39:59.1183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Bbwlf+qzf2ye5VX8eq29oANDNJq0ShbxI+tYpF/rvgu65tlHfrZppUmdfOdodQLDT3ujd6vv1tGTXWnJxAS3u1cRWRaxkxEMDRUBzOX2Xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1098
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> Sent: Monday, May 11, 2=
020 4:22 AM
>=20
> On Thu, May 07, 2020 at 01:01:26PM +0800, Wei Hu wrote:
> > This series better handles some PCI HyperV error cases in general
> > and for kdump case. Some of review comments from previous individual
> > patch reviews, including splitting into separate patches, have already
> > been incorporated. Thanks Lorenzo Pieralisi for the review and
> > suggestions, as well as Michael Kelley's contribution to the commit
> > log.
> >
> > Thanks,
> > Wei
> >
> >
> > Wei Hu (2):
> >   PCI: hv: Fix the PCI HyperV probe failure path to release resource
> >     properly
> >   PCI: hv: Retry PCI bus D0 entry when the first attempt failed with
> >     invalid device state
> >
> >  drivers/pci/controller/pci-hyperv.c | 60 ++++++++++++++++++++++++++---
> >  1 file changed, 54 insertions(+), 6 deletions(-)
>=20
> Applied to pci/hv, thanks.
>=20

Lorenzo --=20

Will you be bringing these fixes into 5.7?  The main fix is the 2nd patch, =
but
there wasn't a clear "Fixes:" tag to add because the problem is due more to
how Hyper-V operates than a bug in a previous Linux commit.  We have a
customer experiencing the problem, so getting the fix into the main tree
sooner rather than later is helpful.

Thx,

Michael
