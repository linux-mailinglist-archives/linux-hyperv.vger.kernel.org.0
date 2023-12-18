Return-Path: <linux-hyperv+bounces-1352-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C3581798E
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Dec 2023 19:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 892A8B219F8
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Dec 2023 18:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199325D734;
	Mon, 18 Dec 2023 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ALTdp+pI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW2PR02CU002.outbound.protection.outlook.com (mail-westus2azon11023019.outbound.protection.outlook.com [52.101.49.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6CF5BFAC;
	Mon, 18 Dec 2023 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0Og/MEqV2uTB4WLwj0G1u54CWBeaYK62DST6kTsCosZTyDknm9ygE6NqSs1+xlGfTJT/NIMhEDJ8GYbXcbfSX81nf5FrUdNSEvelVOwHvVguU4ZyKuyA9TlU5s3N7iZaaKmOmpMAdp1e2swecFHTBe/HJm1alUzMxadAcZLJuzh9hd64d54F/pKcJSLFen8bgPeCJELd2LykzQeGMU8B1nIQrtRH/wFj3mQKUPaSDblvWYyB3/c+gEknH6zrmevo3lkAHwOSF+qX+RHnFMdoJO+0BZtUpxd0sq7FAGPReDXQokC0Eb/PzkwiQTE176VdRZI+PMNA4Sy6voeDgCw8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRALuxch+MrrL8WVi+08sDy/Hi+umbn0BOXKzHUR/as=;
 b=LX5zfDKIpNRlSsBXzlOuZ5KKTRu7HQokrWTYp3XY7BW+dWg1QuKMpwKl0mscig7Nx+zJyZiDS6WcYQUJKsApuM/7ekiuXx/NN3yosueBenLOTklrit9m+MHgSsSMZ4BpNERMzZNHkqqTm2cAWNo6LGtXLkEUZVTwHm8Xk4agTq+koVFolr/9Sh2XQ61o0W58PAmcqqi+fjKk/iMHxIx8UYKRkipbYp1ERUO/Z1uACp9OvQnmmubvYTfL82U+oKo4m0XGWUW3JZKgDaqVLqGINEQMC/qzXH9kuEFR1k4xpsRSy64riEJlQnX5ZstlsEH6U5RFY35JFfBSi2n4KVB6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRALuxch+MrrL8WVi+08sDy/Hi+umbn0BOXKzHUR/as=;
 b=ALTdp+pIA5xHjU5y3cTI4TFpOQoWAS8f2BuXWYh2Hg0Ogjy4+2hfZDh4D0X2pCd5i5vs/zh+HkGCKsg2TfADSqDabVQKNMQvqbiu/2fzOeFXVa28dzI5wdhdGz5C9KOeYayoPqin1/bojciDAifcvQDN7Er+JLwyDBU+zeYYr1o=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by DM4PR21MB3371.namprd21.prod.outlook.com (2603:10b6:8:6f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.4; Mon, 18 Dec 2023 18:23:21 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::38ce:7072:976c:bb15]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::38ce:7072:976c:bb15%3]) with mapi id 15.20.7135.004; Mon, 18 Dec 2023
 18:23:21 +0000
From: Long Li <longli@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Ajay Sharma <sharmaajay@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch v4 0/3] Register with RDMA SOC interface and support for
 CQ
Thread-Topic: [Patch v4 0/3] Register with RDMA SOC interface and support for
 CQ
Thread-Index: AQHaL8RE1cphB7/gbES8vf07BVtO3LCteY8AgAHjskA=
Date: Mon, 18 Dec 2023 18:23:21 +0000
Message-ID:
 <PH7PR21MB3263ADBB8113D2BF2DDC0552CE90A@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1702692255-23640-1-git-send-email-longli@linuxonhyperv.com>
 <20231217132548.GC4886@unreal>
In-Reply-To: <20231217132548.GC4886@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ea974aa2-51fa-4367-9d31-16d19ecf7b53;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-12-18T18:17:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|DM4PR21MB3371:EE_
x-ms-office365-filtering-correlation-id: 0ff16e80-d262-43fe-196f-08dbfff66a58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 W1H/v7HVNV8Yv5neucrntvFa6IlrzwdhA8/ylL2v5ck+G8+fEgxG+dK5nfP22HK80y3vp35RoErfxN2u79ZbHc5ZjVrJv94bfgxcsIy5RyObvUEnr2xMMi2dm5+6Q+j9SgKNJYgFigcNsyujXh6KCRrZiu0U8w5xJwHJCq36SA4YHhhBtVz88SA2XgTE6Ge2kQHjQj5uPowRPprowtSRj5v+wDJV0UAetMhHuH/odbaSgZxLmraxp5GivMwaRYehWbKzIY7T6+0rt3ThnOK/6BE3pCd1Zq+j/gk2cVCS/ueI8AuYlq0pmM7y8hTTH+uq4LvEj74ke3kiu80QN4HRY/YZkpqyORIhfZx+0zaNiIAD4gjeZXwonS+9yPdP2XiFpmZZK8rU77ZvIH2A5EcYRtF73HIsn805YxOw9+pIFBj3FYouxvk7a9w21CYGFhVHFMUaJVRxHCtxiTTzGzNGP1SEai0hbBFrB+p+DovH2RX9P4CSsMvh2/igOZXwj+ddL1m9MO1q+mDq8MAcJMKqTrom3PoGOLlPJ+CZR/4v1zccTQFPHEEh7cDj2tOJsrJJz+5dbSjPmb9uXVhmqdVmkf2pz03wNVBZjRQp9HlyvGAITMJbcpCFu2XY4myHrknlmlWkeT2Ge+cCJobH1bwrjCm7QKjHZbBTv/5kUmk6vHo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(136003)(376002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(52536014)(38070700009)(82950400001)(82960400001)(64756008)(66946007)(66446008)(66476007)(66556008)(54906003)(478600001)(316002)(76116006)(8936002)(4326008)(8676002)(110136005)(122000001)(38100700002)(86362001)(33656002)(55016003)(26005)(83380400001)(9686003)(7696005)(966005)(6506007)(10290500003)(8990500004)(41300700001)(5660300002)(71200400001)(7416002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oE2WS3w0f6E01+1tFLeE75Useaa4kV4wOT06NjioAkVlcs4Ha9ajTYZaaJFF?=
 =?us-ascii?Q?GXLyJVITp7p5l4f1WAB0WQ2kCJnmyzbcnkWwnrGkKTZBXTGT0aqFcnG9hCO0?=
 =?us-ascii?Q?WHbwoPyFU4JZ0HImFFxb8MCf+rvqSsxJhjd6+LsGPYbvIXkI6M/DvVuNlurl?=
 =?us-ascii?Q?Nbv/M8BT8Zulgh1sgGJmjbL12Sgwj9yzkiOO/8IeEAcX43moYlDqtUxbdt1c?=
 =?us-ascii?Q?RAH7xURSZdJiy7+mFNa9RLX4NQWder70ppzoNps7qg1bECBL8mwaoVuuUf0b?=
 =?us-ascii?Q?tk4znbJsWPUCKj70qR7JIa25PMH2SqVBN20nFOGPGR7QAghSCf8j9SptkSdd?=
 =?us-ascii?Q?RK5GYC1ZBE80vh1LiJe0kzxyFswG+krq3wg3STvQzPyq7p6tKzhx5jzifSEm?=
 =?us-ascii?Q?7256tuXtgncvxah59CQ/Y7y5JyFjGfylWvSpqlsHlgzm8YKsl0aezVza+soV?=
 =?us-ascii?Q?ZFx/5JHutZLsCW7vTk2C6eNFpKHpAL0uFnk3blRr2JBewCOg0CmUNKcao7mQ?=
 =?us-ascii?Q?RYoRBGWzf4DCJLTkQevpHxE8qWm1EtR8cBvoRlsuzI1zdltSXKebSLdnHecv?=
 =?us-ascii?Q?7yaEvMWWkcRZvL+MQNfM3d5CnthvPWjLDY+oIaRZ16WumGviJQPEIVdtq5Gw?=
 =?us-ascii?Q?rXEe+2dgfeEGQyolVNgep2HdsUCduscqq0PIYcp3pPtdvm8qVNO5ZV4YJyzl?=
 =?us-ascii?Q?wh0eHaPRoaxrxR2SPGP0FgJn9OfPqBCVEBF6IOSfbSAgZkzSZexBQVdv7NdE?=
 =?us-ascii?Q?42rkzt+H55lpxyGDRM2usJiBt8f5WB0Jd50Uu92TvLGA99wpubKgeIXeMDGb?=
 =?us-ascii?Q?/wpaaMAK5WKIxWoIthgm1AnyxKcJhOh9UvBZHqXzMKHmfR4FUixQgC584sjN?=
 =?us-ascii?Q?Fxuihx/taAqMW0ANVwVZepsYtLdkj61dWQJABNFd5KvTHEP6LSb5519kpGfG?=
 =?us-ascii?Q?/niY0/43S3PpWgHo+A/wi4fJ2fqyoaRarz4T5nDDvFrDTc+iOm3koqvyJvNp?=
 =?us-ascii?Q?UmCodwwVyucUUL6ipZC6CRzpuhxT27KzyTO+iNgEePB2y6Dz9GWoFc+TLq3l?=
 =?us-ascii?Q?e2gQSqHC854NKcCeSUUtljQfqAj3LCcxCeFAgHM7pQM5VwkdkpLPOdgT/S/G?=
 =?us-ascii?Q?cOnM+uk01dFQaHjq1vVqTcbQ59tSme6nr/67JMCsc/2EVpXUpgl21WjUBaXP?=
 =?us-ascii?Q?txZyApHqCi0EBuHSjHUL7Kw+d1nm2/G006QUKzPtKyj2RTHyjdQ2mOGYdlfn?=
 =?us-ascii?Q?DPJoW/VuGJBVPltMHiH/RVIeW2uN+SGqSI+WNm5qZoV1ozPsP7GwbF5zJavy?=
 =?us-ascii?Q?CFyQsISaov2KEpDTXoeidRkMh2tds/ro+YRuYDI/4ToQmlINJIdS+V0AtPWf?=
 =?us-ascii?Q?RITBbABMcjpLq3adsPAKUY3w87moZdlcliGkJA3JHIVt2N9HTPTDY/1RRFed?=
 =?us-ascii?Q?ZhfV7JomAWRxtp0XTP8AyWfanT/sfKX+16u99+r/exs9blSr31nyrJyZzXHw?=
 =?us-ascii?Q?r0jdqS8rCkKOFPtEYAV5iygp7AiZlNcXFQxlTPpEqzTLkoHjnpCQTh1+FZh3?=
 =?us-ascii?Q?h2o4KLmH1vQKtUW2wyHH1TrR0jsZ3SRh0rSECKT6?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff16e80-d262-43fe-196f-08dbfff66a58
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 18:23:21.4233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g2Vs7jKay0lcwVuhZA4SSDG4jI1da6FujlhczHsoob1NlmRyXyju9x9sgg4cLuMvTtXziskwvltQfTRdKodfdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3371

> Subject: Re: [Patch v4 0/3] Register with RDMA SOC interface and support =
for CQ
>=20
> On Fri, Dec 15, 2023 at 06:04:12PM -0800, longli@linuxonhyperv.com wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > This patchset add support for registering a RDMA device with SoC for
> > support of querying device capabilities, upcoming RC queue pairs and
> > CQ interrupts.
> >
> > This patchset is partially based on Ajay Sharma's work:
> > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fnetdev%2F1697494322-26814-1-git-send-email-sharmaajay%40
> >
> linuxonhyperv.com&data=3D05%7C02%7Clongli%40microsoft.com%7Caaadcacece2
> b
> >
> 44117bfd08dbff03b2c3%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C
> 6383
> >
> 84163586869634%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> QIjoiV2l
> >
> uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3De4G1tI9
> VOTGv
> > rA3UF6YQZ%2BM2uDDd71sZpejOvhl2y60%3D&reserved=3D0
> >
> > Changes in v2:
> > Dropped the patches to create EQs for RC QP. They will be implemented
> > with RC patches.
>=20
> You sent twice v2, never sent v3 and two days later sent v4 without even
> explaining why.
>=20
> Can you please invest time and write more detailed changelog which will i=
nclude
> v2, v3 and v4 changes?
>=20
> Tanks

I'm sorry, the cover letter for the 2nd v2 should be v3 (it was a typo). Th=
e rest of the patches in that series are correctly labeled as v3.

For v3 and v4, I put the change log in the individual patches, as there are=
 no changes to the cover letter. If you think I should put change logs in t=
he cover letter, please let me know.

Subject: [Patch v4 2/3] RDMA/mana_ib: query device capabilities
Change in v4:
On query device failure, goto deregister_device, not ib_free_device
Change function name mana_ib_query_adapter_caps() to mana_ib_gd_query_adapt=
er_caps() to better reflect this is a HWC request

Subject: [Patch v4 3/3] RDMA/mana_ib: Add CQ interrupt support for RAW QP
Change in v3:
Removed unused varaible mana_ucontext in mana_ib_create_qp_rss().
Simplified error handling in mana_ib_create_qp_rss() on failure to allocate=
 queues for rss table.

Thanks,

Long

>=20
> >
> >
> > Long Li (3):
> >   RDMA/mana_ib: register RDMA device with GDMA
> >   RDMA/mana_ib: query device capabilities
> >   RDMA/mana_ib: Add CQ interrupt support for RAW QP
> >
> >  drivers/infiniband/hw/mana/cq.c               | 34 ++++++-
> >  drivers/infiniband/hw/mana/device.c           | 31 +++++--
> >  drivers/infiniband/hw/mana/main.c             | 69 ++++++++++----
> >  drivers/infiniband/hw/mana/mana_ib.h          | 53 +++++++++++
> >  drivers/infiniband/hw/mana/qp.c               | 90 ++++++++++++++++---
> >  .../net/ethernet/microsoft/mana/gdma_main.c   |  5 ++
> >  include/net/mana/gdma.h                       |  5 ++
> >  7 files changed, 252 insertions(+), 35 deletions(-)
> >
> > --
> > 2.25.1
> >

