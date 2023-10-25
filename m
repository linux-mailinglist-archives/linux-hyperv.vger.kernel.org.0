Return-Path: <linux-hyperv+bounces-579-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A707D7501
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Oct 2023 21:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F963B211C3
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Oct 2023 19:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95E6328AF;
	Wed, 25 Oct 2023 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dImF7ysu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B562D631;
	Wed, 25 Oct 2023 19:59:23 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020003.outbound.protection.outlook.com [52.101.61.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD40B93;
	Wed, 25 Oct 2023 12:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnIVo5ppdFBQaqe0KQyki5VggtPkxQkh/4JkyQITaLRQVJfAx2cEIHtsKuOuc1uoDscQCMuaHkpOMjQ1wceflK+TojVePbPuGeNECZ1M93aTEQxiZrVt3RDI5Q9H+ZjZR0UzxIOCDA8+coPruRTGg+Mpr1oRXleVKeJLXvSQgTrgXVgpFOY6LkJpQSSwsNVRp+RF3JUxnm9eg/ja5ImmJ+42eFq8fO4HBWwIsjK35JoKZllXJ9AvaJx1J6Ud7mE4DAuawJfz+2zDJjQhjvzhz4IQIJmCMdokwzmq0xWxceOo3qFP7DeEDuxalo+C7WRdGJxVSnNtIUpk/kNlDIh8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaA47M/zBzjGXZn1kn6bGdPzf4IAsRnhbwm54qmPzPc=;
 b=E8fmJXF54EedDjYMUpExP+NPZZ0R0Cz7Atd4oib7N0D7oynN7UuoLswUUhoyg36PUvsYEfs8PikrQO69/wgOUBmfNA77unDZyfNXFvYBLDoJ2yY6MS03pIffXT1gOhUpcd84VtOf4C7+AkC70wWIne6RWMtFFZm26E0msJnoWCFgd8EFCE20iEtYjO5X3SZwLo9u4boJRvKBB3oNVkgiTQyNAtjzWTdTwmlz1NcHuy3rL81BZlr1SUCthLwfDaXIkBmy0HAoFuJ8A2m5QLWsh2Hh4qy2mxNKrbpoyxclwT+oFSlTYXXPkHvlGdwcBGTgBt2zlAEgCZg9l0xaIcSE8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaA47M/zBzjGXZn1kn6bGdPzf4IAsRnhbwm54qmPzPc=;
 b=dImF7ysug44h6Pj5EJS+Kx/E98RjbQl19k8Owh9/P97/bgBz2UfBbtf6cWL+wBj/a6uq7TT32meXI283mC2sVYYurzXELtZl2p31BjjdDvUS/fCKXzmBfh0ve3BlDdCRSFjbNQdyIQhEyOz96UuVo9XMjBa0THySGTmWH/v3PBc=
Received: from MN0PR21MB3606.namprd21.prod.outlook.com (2603:10b6:208:3d1::17)
 by DM4PR21MB3394.namprd21.prod.outlook.com (2603:10b6:8:6e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.8; Wed, 25 Oct 2023 19:59:18 +0000
Received: from MN0PR21MB3606.namprd21.prod.outlook.com
 ([fe80::a2b3:122e:e242:3d3]) by MN0PR21MB3606.namprd21.prod.outlook.com
 ([fe80::a2b3:122e:e242:3d3%4]) with mapi id 15.20.6954.006; Wed, 25 Oct 2023
 19:59:18 +0000
From: Ajay Sharma <sharmaajay@microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, "sharmaajay@linuxonhyperv.com"
	<sharmaajay@linuxonhyperv.com>
CC: Long Li <longli@microsoft.com>, Leon Romanovsky <leon@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ajay Sharma
	<sharmaajay@microsoft.com>
Subject: RE: [EXTERNAL] Re: [Patch v7 5/5] RDMA/mana_ib: Send event to qp
Thread-Topic: [EXTERNAL] Re: [Patch v7 5/5] RDMA/mana_ib: Send event to qp
Thread-Index: AQHaBd4Nz4tomQKWP0yFd70oWlQrWrBa72lg
Date: Wed, 25 Oct 2023 19:59:18 +0000
Message-ID:
 <MN0PR21MB36067E337A53C3BAF8B648E5D6DEA@MN0PR21MB3606.namprd21.prod.outlook.com>
References: <1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1697494322-26814-6-git-send-email-sharmaajay@linuxonhyperv.com>
 <20231023182332.GL691768@ziepe.ca>
In-Reply-To: <20231023182332.GL691768@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f66c6187-e4ae-4c1e-b328-36065610560a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-25T19:58:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3606:EE_|DM4PR21MB3394:EE_
x-ms-office365-filtering-correlation-id: ea31cb09-eb05-4d63-f2cc-08dbd594df99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NSAdIt6i4H4QuLoOgXARa4Kx55axQ30rBJL4GeqwNtDtWwimFxdre+UvqmVnZpiGEc7W3sGAkkjyw6AAH8CMDLUwdsOn3koRRSBNBmZbqCe33il45tazN/J5fIJlRdml5kOj/CoYZTyNkcVh8HJ9Jl1kOim1gULAmXK73/wFKCLc3d9N4uXJ1lowgbh7I9BEgGd9BTWx7cK9jHWKtdG8K3uCVPUmx9efi9xujwiYJ3EXVMlvT/8ksqpgjicQfd1uxaQVlexUhu5OzHdDEcXhmG2YvoqtSN3SSKEP6svGyoRPvq6Tuv72oZ8vwS4ek5l87YyDL5Zrc6u0tnc6D9tmF+4nDT40DAHTegEWPJJ+L5hYi7rYDPQP24q3lugTrNWLnKCejpUMZ6u2DZTJCpEGVA9g/q8v1szZ/DOFblTnUzL5C49CdpPX3yHBTl0IFoH3+vlhamO8uGeJQr3RgHAXth/MrjQuEZXWJ+ld0xTXrgdpyl9PgRR8S70KqKK2JSjWS3clsa5Wj1T6+17n7S8LPcGX5o9/yeTq3I/cF27PbhLXOGEvg6P4VEgYBBaqvGMxv9ZYRoOptGAqhQc4Pp6sL9u9cEpQIywFEa4qVYy34/rZy5R4Tu80oJrukHdSOfNQ6WV/A//P+s9CU2ISrv/ka0cXpC5rY3FKMZOZYN3kHSM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3606.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(346002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(9686003)(53546011)(6506007)(7696005)(71200400001)(478600001)(10290500003)(83380400001)(107886003)(2906002)(7416002)(5660300002)(41300700001)(8990500004)(66556008)(64756008)(66476007)(66446008)(54906003)(52536014)(76116006)(316002)(8676002)(4326008)(8936002)(66946007)(110136005)(38070700009)(38100700002)(86362001)(33656002)(82960400001)(82950400001)(122000001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6ZiwQyZpGXV/S03lIM9omR0cWznzKtJd64cHM8YJvj70DsTWQDFjKypSDSSO?=
 =?us-ascii?Q?xOsJ+EVZ4RZldVIL99FlYpL7ZK30LvkPn4saxn5iSqwGf0qFq/K+3C7weFtL?=
 =?us-ascii?Q?XkVcqGALGZx0coqRZwt3G20Ps5FI3Sfd2KMl53jz+z+0nuJIySjwNCGbPbvX?=
 =?us-ascii?Q?48kCOaloNgGL0igul263rb66p90ikfLEmGX5EyIoQ7YHbQihPyAGZlW2iQkD?=
 =?us-ascii?Q?zrNZ/+hM60j232aRB7HWgRhsCME5iiElOCCy2XqcE54+//luFZ1WXd3GMdKE?=
 =?us-ascii?Q?U/8u7dyYEkRNqmp1R+Dghg+9tW4Rp7oJUy+pXn5eBdTK5M8aVnxLdSwcRLvw?=
 =?us-ascii?Q?XtstMJTSCafFdwGZd4wF9ErecF3ewTIqeK1zos5R5aEfCg0aXRaDkJmpauys?=
 =?us-ascii?Q?fkT0ycdNE37hr5Jo9E2o7maWDq6kk39kQk4iRO3cHjyPyJ5/Q27hHLAU2ZZO?=
 =?us-ascii?Q?hGoJt9LFCAjdwQJKH/g1dWgoNmLHSz+vfbJWiVprYH0sslv/oKym/UNipj70?=
 =?us-ascii?Q?8HIPRKSjdbUyOeGb5q2JV9OX+XAe4y7bN1TVsMElURraVdv4BxXbWIzqtWXa?=
 =?us-ascii?Q?ejfd3BwJ48M7oQCtPH6N9mrXFzOfHZXuNVDra7jPYYCd0hZw7J1Dq4AVhtC8?=
 =?us-ascii?Q?2mCaGc9KMb/1qbIAGf9NuaG7XQqgWpE92TyHtgmwQ/1vpCSib9FJMBVkknOD?=
 =?us-ascii?Q?4oZB6EKQbQu5cUtoPLHmjgNm5ptnGF/bmiWnZ2p+1Fxlw6SzhMZKFVCTmWQV?=
 =?us-ascii?Q?qZ8HK7IOpkYSBapfu6tGr+ctmckikhshpqQFwdXbXMh1rjq5vKpJWSllXjbJ?=
 =?us-ascii?Q?/il+JE8aA0nUX7dNfGZ7qmqJ6/ZW9HWQY25x0nAPKKl953Plee873HBMaMjf?=
 =?us-ascii?Q?Y+AcQF59JHp6fTqsCyP9BD0gn0g2+c0tQvSiflvxhCnNDxcXOSX1LGoNw1YK?=
 =?us-ascii?Q?lbMI3PvKfA8u1Z2rzQfHVBWWAknvn3ET8Pjml6wsLYYp5tdgOSzNN2A3jeM/?=
 =?us-ascii?Q?cS2Kn555jS5j232l45g8z2a64LEBh2NvGF7NhNBW1JCz9HjGJOQ1hsV9oNuv?=
 =?us-ascii?Q?Cvk+0iM2Q1S5xFp49Vv51fdWF7dPmsf9GWno50mTwTwZosJ577cKksppS3Lj?=
 =?us-ascii?Q?Ew6M3ukfHaXnRXcdPyU9IFbAGBnyNVf6vWU9U+qJFD/IOxjOwfzopbZQhwtH?=
 =?us-ascii?Q?qBFMBOeDIqZeA4ULflOqU3GFNWpx8GXNUwu12HXdxHb7C8I3ejLYeAEzFu0x?=
 =?us-ascii?Q?KFsAOBVNLBN6+SiV9GsHuPw8CDi1J2/+AayQDZ7BivkJhV51NZeHsn95k5NL?=
 =?us-ascii?Q?/xcb6tVH+RulMCpHQh+qc5XrAG7zlasRpHreOlH0GXqEe6cB0SIx/AIfi14W?=
 =?us-ascii?Q?4aBsK4xzd83wTwPOh4/a7skxpmxvUO9Cnd+zAVHZxopmEfJtKIfrqay6hRw+?=
 =?us-ascii?Q?A4N0b6T4l93k8aRVJkdpjPtXsgsxQlB5dejdF6Ll95OA+o+uWO85enKmIERe?=
 =?us-ascii?Q?un3eLgtxa9sntP1vJF64RvJKht2+CS2/wBwoplWnRtXwRp2ZoW+d2WLI18Vd?=
 =?us-ascii?Q?TBsZ4TMhb8xrPzOR7KTGtvQQ0F3vy2n4TEdxTVmp?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3606.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea31cb09-eb05-4d63-f2cc-08dbd594df99
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 19:59:18.5796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lCd5rENeEEGSVekFtwyQ3N0KAeBjMjhwrb9mQsO95s2xfaDaMM00nGX4vJot5+F6vG+pHmpixDREtd7etdrPq+jQ90wmyUrFV7z0vfqJsMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3394


> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Monday, October 23, 2023 11:24 AM
> To: sharmaajay@linuxonhyperv.com
> Cc: Long Li <longli@microsoft.com>; Leon Romanovsky <leon@kernel.org>;
> Dexuan Cui <decui@microsoft.com>; Wei Liu <wei.liu@kernel.org>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; linux-
> rdma@vger.kernel.org; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Ajay Sharma
> <sharmaajay@microsoft.com>
> Subject: [EXTERNAL] Re: [Patch v7 5/5] RDMA/mana_ib: Send event to qp
>=20
> On Mon, Oct 16, 2023 at 03:12:02PM -0700,
> sharmaajay@linuxonhyperv.com wrote:
>=20
> > diff --git a/drivers/infiniband/hw/mana/qp.c
> > b/drivers/infiniband/hw/mana/qp.c index ef3275ac92a0..19fae28985c3
> > 100644
> > --- a/drivers/infiniband/hw/mana/qp.c
> > +++ b/drivers/infiniband/hw/mana/qp.c
> > @@ -210,6 +210,8 @@ static int mana_ib_create_qp_rss(struct ib_qp
> *ibqp, struct ib_pd *pd,
> >  		wq->id =3D wq_spec.queue_index;
> >  		cq->id =3D cq_spec.queue_index;
> >
> > +		xa_store(&mib_dev->rq_to_qp_lookup_table, wq->id, qp,
> GFP_KERNEL);
> > +
>=20
> A store with no erase?
>=20
> A load with no locking?
>=20
> This can't be right
>=20
> Jason

This wq->id is assigned from the HW and is guaranteed to be unique. May be =
I am not following why do we need a lock here. Can you please explain ?
Ajay

