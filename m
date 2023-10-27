Return-Path: <linux-hyperv+bounces-633-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3119E7DA307
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Oct 2023 00:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C5F4B2128E
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Oct 2023 22:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3B03FE58;
	Fri, 27 Oct 2023 22:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AHTjOfOR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE043FE37;
	Fri, 27 Oct 2023 22:00:58 +0000 (UTC)
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021006.outbound.protection.outlook.com [52.101.56.6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AEF1B5;
	Fri, 27 Oct 2023 15:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aheZK60JAfqCbSYmcIowFkYw5RlMdok6y2A31+HrroBiQuU8ssB7lZYKXBJOa1Ly11K3b1PZ57p8FGOT5xlYVsIJfieoZg3Ds5jdHroNg3xMBzI1yHFTBGJPBgbqLYQnQbLhwk9Ih3VDjH6easzWzfJeJ8+c2PqxUjc3rmrA/KN6zvpvq0o/PcJxpv07/P8WVAL/3wLU1AcKEQjtDdZdBep5KbHOfqIiDxVfpdKazUp9Ak8JA7fouICxtmPi3kCeScg4tKYdVxuva5YUmfqXw6gNfs7FkQ5p0Pv7UwQ9mDY6fJxBxJnplyjMsDU6RtMDcl4lMh0Wm5WwtWpSY0WQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgnPAa7MDqErV1E3fdT00i14f77wVJZQgF5DxPdN1So=;
 b=E37PIYikhobEr5vTeWON7eYqmsNd0uoh46qxcjqtlOdIzq+wqHH2BFCCp8C1q6MnPz86lSwrh1ClFx86h55ASOlsu92Dxv1XFc62YiF4VgLn2ADLGL/uq4PcAT9OSK3rFUzu7bbr/nJ25EO9TVksUCERNJzk3xgA7vHz6YU+AFbXUyFVr4/WauWrWr60k7GvQOqV5DzsWF3HFE/LuEv6wpD/HR+bCb6K8uzPV1wBNjXJ00wQl/BL2GeMVQ/kciXggecmQYxsSWWhTXJ8sZ9EcdhkY0k76eHz8rfEQuurvc5NR4YN/vBQJTH2K5YzPhK+F86x+sanTDg/2GM+V939mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgnPAa7MDqErV1E3fdT00i14f77wVJZQgF5DxPdN1So=;
 b=AHTjOfORuEmUIIpDrLa1J56oz/6vgSbbNTzJHfyJVu+bS0xTXZwJlpGHO3jwk9bKYhgsBRnTGMhCBTatOhru/kcB3XRKjoL3jVkNrCKJH9Pkqq0K8hCe7q7pLpMV+NIUGKFVhSkTsRK5tCuzJt9Ovm/ewZqXItAx+0qhAlEwBZA=
Received: from MN0PR21MB3264.namprd21.prod.outlook.com (2603:10b6:208:37c::19)
 by DS7PR21MB3247.namprd21.prod.outlook.com (2603:10b6:8:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8; Fri, 27 Oct
 2023 22:00:51 +0000
Received: from MN0PR21MB3264.namprd21.prod.outlook.com
 ([fe80::9f51:f462:e8d2:d242]) by MN0PR21MB3264.namprd21.prod.outlook.com
 ([fe80::9f51:f462:e8d2:d242%5]) with mapi id 15.20.6954.005; Fri, 27 Oct 2023
 22:00:51 +0000
From: Long Li <longli@microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, "sharmaajay@linuxonhyperv.com"
	<sharmaajay@linuxonhyperv.com>
CC: Leon Romanovsky <leon@kernel.org>, Dexuan Cui <decui@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ajay Sharma <sharmaajay@microsoft.com>
Subject: RE: [Patch v7 1/5] RDMA/mana_ib: Rename all mana_ib_dev type
 variables to mib_dev
Thread-Topic: [Patch v7 1/5] RDMA/mana_ib: Rename all mana_ib_dev type
 variables to mib_dev
Thread-Index: AQHaAH3PCZllm+SYuUWwqEhIBkx06rBXuKyAgAaIS+A=
Date: Fri, 27 Oct 2023 22:00:50 +0000
Message-ID:
 <MN0PR21MB3264740D66154E9EEEA4620BCEDCA@MN0PR21MB3264.namprd21.prod.outlook.com>
References: <1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1697494322-26814-2-git-send-email-sharmaajay@linuxonhyperv.com>
 <20231023181457.GI691768@ziepe.ca>
In-Reply-To: <20231023181457.GI691768@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=847f682e-04fe-44d1-b39e-01bab2efae6a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-27T22:00:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3264:EE_|DS7PR21MB3247:EE_
x-ms-office365-filtering-correlation-id: 143eda6a-a141-4232-2ea9-08dbd7382efa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2imql3tCsfdnAHeqMNkrSw2EtXp7LjyhLj0BnDsffkEydkWy6gMsE/z9/mCuXCu3u35gGsMu9qRG9XX3PhY/1qezDCMBc/FkposKKoZcYMYT9rTBCpyoOBdOqczur/itaGbwXEWrz7FiAhsOP7oYo6QZQRrDTC+l9da6ee2IDW8AcvSiawTSU0XzlkhmD36VsRBFATtgxP/G4WzyA+guliCj6psQMxTmNJjO185xJ/AmBfgRr4UoJ6EF62kSKLdD+ZexmMxGLNkB/gj3B9Qyv/yxD6gyZig/1o9OV1tKOns7Sc3HjEIm3n+l3XWYMbdsPRrSvbavbYOH+NPY2JytUEt2mNNgXNdUAYrWDbC3UU4YZ8A2V0V/MChHhXFWTueE3I5/VxC6nW9eYVaOQzxioHKsKCyutHp+T6jaZmpyRiJZrBMbkMtymo2+xaoQgKlHgN/cPEUEu/nzRPJod4UPQIGwsLEJUuetoatwyu3SfUUUQZtiHwY0/712EzpF3xN669QWFqql5tCr5fUET2U80njDxRFXEbofqzwSo5oHPFvjUz7XbXIq4vIAnWLUzBfLKqPKcM0kcDSeiwjhHqjQnErYSpTvHIe5mqYIsnVR16fKQuD9LaUrg4AhcyOAoc9OMXV1IrRE2hGWBHi2RK1ZwK81Ql18VJSErYri3ctpaTM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3264.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(8990500004)(5660300002)(2906002)(7416002)(41300700001)(4326008)(38070700009)(107886003)(71200400001)(82960400001)(83380400001)(122000001)(33656002)(86362001)(82950400001)(38100700002)(478600001)(10290500003)(76116006)(316002)(52536014)(8936002)(8676002)(54906003)(55016003)(66556008)(66446008)(9686003)(110136005)(66476007)(6506007)(66946007)(7696005)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?d8PVLUTxGaJUfr6UzX0a2aAjybK773uerywTPf46Y/Mz8NWL9KYlUyylFDEg?=
 =?us-ascii?Q?KPfOx0go4eskQwd1ba/pzrzPQuGfWEm6I2af/lxsUixz/UJEp6ZD1rrrhzAp?=
 =?us-ascii?Q?LXumrWw+MgFzbkE8gAb+hgV/gdg+hwOnpMjlLyr089SlUo35JssMvG52fEU9?=
 =?us-ascii?Q?51+nTQCU7kr4HwlIWmVPVA7xt4ae+i+w/L2InpMzvioAFE3YluGp+cDExoK2?=
 =?us-ascii?Q?pXbRS+fv1s2kLebk+mz73xLxxojxs2f5h9NQxOhTjDGtfLX+QiJj3G7dm0Nz?=
 =?us-ascii?Q?vdCvMOJFuhAhH5Wdv41JN2gGcevQBY5KtL4ZbASz+tY0Pc9cZsTL0Yb9uFf2?=
 =?us-ascii?Q?BcxE8GkKpixPdbvGcxHj7eRgkkxD2kKzg8ZanENoX3Lr45vfCH1/dD7cHRdu?=
 =?us-ascii?Q?AyNTF194IQXv+tdrx7DLInBXEGKVdA7d4jHQhmF+lGvD4FaB+gUpkIHygTFN?=
 =?us-ascii?Q?tbRl0FoJVFfqZJV/36Z+Pw+FQdWG6OluA7gcLwsqQwG/4c/QCYeIU4iMZJ4+?=
 =?us-ascii?Q?Yk/x53lJfGMWFechaHTSx2Tcn/kAjwULoZh2Gnl+hCjo5vCCSMgJ1PotUcTo?=
 =?us-ascii?Q?47bvYC7I8P93HRLdiWO+0bl+0yV8bsOM0BRCQ95wvJHaaRP2JKIOz3kexagj?=
 =?us-ascii?Q?FxiRXHPOO38FXLcRk9VVtdkOxQWt3XsTN2riiElcNFmnKXz0SdmW2+UsI8Bg?=
 =?us-ascii?Q?tV3AUR1xMIEJf0aWrcuJ6InAWuokCrHiOr/xUeOLE/ZRNCzz7ZVsjn/zaRgo?=
 =?us-ascii?Q?dIInsMOGYAtfNCrbi2fWTEgKQTZ4xU/ou15wAGVeqZ74PXoJOzQ98K3Cuq1w?=
 =?us-ascii?Q?+zMkZMj/geKCS+1vXMrtDZyPc2+6g733u5S/tA29k9/FSVq0LUkX5lZXNw50?=
 =?us-ascii?Q?BQXO/00S+vxRDpLKarfJRcTCJQ1RtvhyVPG1tdNBpGLTsENkkbPIy8mRuZHy?=
 =?us-ascii?Q?0Ibf0ZNGkSEM1bIPCevK6z7uekkPyqdU861+8b4Ihr/4qwkkxXLu688+CEi0?=
 =?us-ascii?Q?IlhYW540CNYkG2HhUH7MjsblzKkjhOoZVQyR2ooh+Fg8K3sJj6RfABGB4i3m?=
 =?us-ascii?Q?6P4ZVmZ9WmabHkLB2Cx5FS9ydsNM86toho3/0Cge9krru+LXiur9E1mcs3yC?=
 =?us-ascii?Q?rsJcJYGrmpSRtoaEDyzMx/DYQX4smT1JyC0+9gKMxW752aGGh4ye53dubpXX?=
 =?us-ascii?Q?2VD4aydWCl8G0lWuGfho+o2qWAAHQpWTsn2kb4mnEKoS8hCVEYWw4yLAvTq3?=
 =?us-ascii?Q?KEeF5TMnZzNOgUSsc18XrG4W9r0+f7FayGabN15l+qoU/lyoz4CP4sdHI6dA?=
 =?us-ascii?Q?IuzYgveWp4izt7WmSDMASv62/pbTX/fh1DJ0bN+3OyUHR44b84rW4M7xpXrb?=
 =?us-ascii?Q?PyetCj3wfSkgHdNvP/VYOpuXSvb2qvtDTLnCz/LsBNT/b6oNoyW5Lpdpscxp?=
 =?us-ascii?Q?q2cdCD7F8N+71dizNo2o93ZPlGnrSCJZmvRfM7688LKbK2hORMmX0nkt+Fos?=
 =?us-ascii?Q?qYwbFaXiW1FhIGeLhz68EqRsxrj4j+E4iD1iqO/0wGhsn3JjdDaWxLLVsgDZ?=
 =?us-ascii?Q?EclitCF9p0Nz/gaHBqylfnTDhulAYvI0vUagj5L9L8OI2LFe6gXhbCq5Y4dC?=
 =?us-ascii?Q?SVfv2kXY87G8XwwOKMdgLck+SMPTBp/JNEApyc2pbMyK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3264.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143eda6a-a141-4232-2ea9-08dbd7382efa
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 22:00:50.8809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BsKMITgTOqaT7nlBoM+GQWi/cxdBr+USeCPfEjgW3v4Q0Y1ZOzY4XFG3oW6HseiCsDbg/rkTpGsI43KRlWoa0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3247

> Subject: Re: [Patch v7 1/5] RDMA/mana_ib: Rename all mana_ib_dev type
> variables to mib_dev
>=20
> On Mon, Oct 16, 2023 at 03:11:58PM -0700,
> sharmaajay@linuxonhyperv.com wrote:
> > From: Ajay Sharma <sharmaajay@microsoft.com>
> >
> > This patch does not introduce any functional changes. It creates
> > naming convention to distinguish especially when used in the same
> > function.Renaming all mana_ib_dev type variables to mib_dev to have
> > clean separation between eth dev and ibdev variables.
>=20
> > Signed-off-by: Ajay Sharma <sharmaajay@microsoft.com>
> > ---
> >  drivers/infiniband/hw/mana/cq.c      | 12 ++--
> >  drivers/infiniband/hw/mana/device.c  | 34 +++++------
> >  drivers/infiniband/hw/mana/main.c    | 87 ++++++++++++++--------------
> >  drivers/infiniband/hw/mana/mana_ib.h |  9 +--
> >  drivers/infiniband/hw/mana/mr.c      | 29 +++++-----
> >  drivers/infiniband/hw/mana/qp.c      | 84 +++++++++++++--------------
> >  drivers/infiniband/hw/mana/wq.c      | 21 +++----
> >  7 files changed, 141 insertions(+), 135 deletions(-)
>=20
> Please no, don't create pointless giant churn like this. It only hurts ba=
ckporters
>=20
> Maybe just target the functions with more than one type
>=20
> Jason

Yes, we will drop this patch.

Thanks,

Long

