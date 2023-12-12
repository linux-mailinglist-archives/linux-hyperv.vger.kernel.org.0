Return-Path: <linux-hyperv+bounces-1316-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B7280E247
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Dec 2023 03:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F541C21263
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Dec 2023 02:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956364427;
	Tue, 12 Dec 2023 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YV31SK3W"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW2PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022023.outbound.protection.outlook.com [52.101.48.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB633B0;
	Mon, 11 Dec 2023 18:50:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1w5x/glCgFuU3G4H3fI+RO0/u2bnTflfKZnwZ4gy2fm3MvdvXkQOXVNEc458kcnW49dGX/p3Y8tdF77URHPrY3gjOSPeVezb61Klcg1UCbv59XnPMMPSD5vYDe8R8OzvdRWc1h1Jclbme+P4I+HFwxfgew3eOAVqzpb9dD+sr2pmq0JTauiVExG6CGy2j6fdNOyjm0I+5GRE+M2wGJhQ/TnbEsP4BODA/f8ovy0tDFuyPIqE1wuDcJLOv8UZJDnnBmZp5xJaZhuFgUjGlzWbC/oZmW0Zz4BrrBAbmnPjUmr2fTKixe9qzepjCfK04VHZ8SOpztDxgyM2GqHI7l/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/6z0dUJP6BReJvjn7W6br8Y7jkZctaLSUdS6rJQ6U4=;
 b=ODvLULexVB88nIm60xjJrh3Xmrjx7swf3OMeQh0TU95PVKEMoAA3pmXV7R+904INZ+StaTzX1IK4V2Ja99SE2HPAJVLaXkza0RcZ3/bbrRlfW0K0qRqfZ/Dqw7GvsBvMcM8EOsjCi11hPnztF76+p/zLKZ9LBPU1bXTC0yIs9kcyEHqXUeTg0jBVAIdl3ZfzuG8kN3mKE1p4Oh1RDfDxsgN9mXq95VtqE4lvtHjJvFCfQBsPFqwl54m0Ci0s39kw0+2fGe7lush1gcFdsH52Yj8mmNR8HM4+Pf/vjYUrYMgI7BfYqtKtj+7K4QBfUFkfVj3dXQBENQ1v2vyPdouMxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/6z0dUJP6BReJvjn7W6br8Y7jkZctaLSUdS6rJQ6U4=;
 b=YV31SK3WM3m7kYm9MFMBKAuxk/fRL6ULOeLhw2YzdKpWFdLJCbQGcR6OzNOCddY7VbvJfDY2aHgml7RPemesrDRmfMZpYEaWTw+fm+wMNyEiBPcd4V7nGFU8NLDC7/NSS/04U0g6J2B9ATMlBI+9i+N2DxvY/sapzO0zcxDh73I=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by SN3PEPF00013D7A.namprd21.prod.outlook.com (2603:10b6:82c:400:0:4:0:10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.3; Tue, 12 Dec
 2023 02:50:17 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::3c1:f565:8d:2954]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::3c1:f565:8d:2954%7]) with mapi id 15.20.7113.001; Tue, 12 Dec 2023
 02:50:17 +0000
From: Long Li <longli@microsoft.com>
To: Simon Horman <horms@kernel.org>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Ajay
 Sharma <sharmaajay@microsoft.com>, Dexuan Cui <decui@microsoft.com>, KY
 Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Patch v2 3/3] RDMA/mana_ib: Add CQ interrupt support for RAW QP
Thread-Topic: [Patch v2 3/3] RDMA/mana_ib: Add CQ interrupt support for RAW QP
Thread-Index: AQHaJwYcW9RdlsZ8pkm66KZmXy298bChPbQAgAO89JA=
Date: Tue, 12 Dec 2023 02:50:17 +0000
Message-ID:
 <PH7PR21MB32630ABF9D63B726FC64A78DCE8EA@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1701730979-1148-1-git-send-email-longli@linuxonhyperv.com>
 <1701730979-1148-4-git-send-email-longli@linuxonhyperv.com>
 <20231209173352.GC5817@kernel.org>
In-Reply-To: <20231209173352.GC5817@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2b61052a-032c-4795-b71e-ccb313dd3a28;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-12-12T02:38:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|SN3PEPF00013D7A:EE_
x-ms-office365-filtering-correlation-id: 3094112d-ed17-40c6-3ec8-08dbfabd12fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HhLVK9PXvS5FQPKBPPGO7NwTaUSt5mLdXaXqZlulHavwygtJb/mvQRvGb6zfK9VsNJPw02GSzLMZgPw1Eht5lNTAds4h4SdMVIDy1Vf6hMbG534vfHj5xpE7GgGnuByLCPE4s1Gig4wNa9wPM/YRtd64masnVMAv6n9UfSi+4ZL2klwyt5yeJs1nLz7dHFkY9LRiDbsQK+K64zcqDaHRWDOt/H+acm8TlO5lTV9FGqnxAD6pPS5D5zxtktU3L+12/s/XCD8seffR89Y18PfvcIcywl0rRlfm6W6oS4rHLF5Hlf1gCY+/ocigyuNJZ4cSGFjowGFXfQBbo3RTTp/CdEUpbG3B95OBNdBEyX9iKfA44bu+bf3sRmDjFycXM8iwVQRK+9eMLF5XzeZ49sNJu6Ul3mmtqnR7B0j04YM970wMQefifDumVJWsVdAiD51DGFjqq3H/r0oAEoCbCjzYL3RvIDDdQHMbFhdaTQI/5m9qZkTmd5f0ai++6Fr30HtJBerSHQEKzyYcEhTo3P9AECoCHZjtLG8Dfig7eXqUTX4htgZh3SJ1Tshjn3KtiGDgtiM/eQsihUQxsJx+e1qhdC0D8CKEGx732NJ1qW5jAKBj8nkyJMuy5icZWcV0v2IkSwPBXCaH8BXqiqM+WOVteSTDU38gsgR3CHJl+ks88Ao=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(8990500004)(7416002)(2906002)(52536014)(86362001)(41300700001)(33656002)(5660300002)(38070700009)(122000001)(82950400001)(6506007)(9686003)(7696005)(55016003)(478600001)(10290500003)(82960400001)(71200400001)(38100700002)(26005)(66556008)(66446008)(64756008)(316002)(66946007)(110136005)(8676002)(54906003)(76116006)(4326008)(8936002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?49jwWsPwqygHerhc094DpKPdYtJ5hPofULtm9fLyz6qUZPQlcCfkSJC70gtQ?=
 =?us-ascii?Q?nt3pCJ394zdfs9kPiY73K6TKXKJDOTqlJEM2oze74PVhTPgRih3p2Ra/aqvv?=
 =?us-ascii?Q?caWv02tjCJ3yYP4CxpyLfaRurvJib9bilRN/d9qyXWkdFOXm8hKu1ct0Pa/r?=
 =?us-ascii?Q?uOrZ/Zl6G0c+Jl54WwbT48tMrr+t7pn+ZasJ9MOa0qnKDaN5SC2Qigxlysqi?=
 =?us-ascii?Q?5c4/duM6CBaymPajby5q/36PMpwS9eDxplcDfAPMDbaZsurbzXLtm+EoqpAQ?=
 =?us-ascii?Q?7olFMbzlyENwddnKoSj9WvLLGCeOI6ndzZfy5qx0pKjiIMrQ4BEg888se0/e?=
 =?us-ascii?Q?Mv/YbxQp5YUM0gDdW4BoYjy0M8BJk257Kn2KNc2nPzVkJ7SHwLRt4oBS7AXV?=
 =?us-ascii?Q?utL7mwTiqV3v+DBxp+occAClW662tOCq2uBJnelArj4UQWf7b6cPoZp/vsXV?=
 =?us-ascii?Q?zaIWDTYjpSe9d72pZa2yiWOgr0K1zfQncIQ+IabYttQvi8xbXUDgyuKxll0j?=
 =?us-ascii?Q?XJIqWN4Bj+4psUFAP+mnWmnYQPHCQMrwZ6l3vMjB77+kr4y0Ut69sm06hmyb?=
 =?us-ascii?Q?QS4COXGIfJNUUpI6cBAqCiEn8C5lGtcxL5LvUOLwwB/GxQ4KsYkSsOdzLJ/O?=
 =?us-ascii?Q?BMTuTXBwewMl4nr9pc/JynDuoyo3Umh3Z59uMuneivzAjs+pPSDHbSuVAAEo?=
 =?us-ascii?Q?PeCnbHZ/W6thYes3CRaltfLQcmHyTRSZWlwPi3jwIWuBfa5CMLG2ibnpcxSy?=
 =?us-ascii?Q?/BwVX/6Kv/HpL7zTmxo1GznMfV0uKcK8jaTLtowuSTWAsr/sAQ8TpLdHcKGx?=
 =?us-ascii?Q?2w3lLW+HyOeT6WFr/qzuT+OLxWebKRir+guVG+sD9CqU2oSCP322x3iSSH3m?=
 =?us-ascii?Q?/9Qu31rDkUyONCpbjf8rvl7ijfHVnjBQSExlX1+MmQoyuBF5BQvDQbAavogU?=
 =?us-ascii?Q?ixU4Z3WPocp/GOEB8tePO03YV4FwLEB0gxx/esKbI90g60heHBljPIyxsSrB?=
 =?us-ascii?Q?aB/0P5VuWUI9vKeHRWA713sXgKfuEVbgFkeDFPATcQ8AubqQoelyHI9i8h9o?=
 =?us-ascii?Q?l4Xo7J8gRMkTETcqFR9Q0dWJg1P5pVykP09+xRTCSA3V5Q+z7SfE8Us0iX5N?=
 =?us-ascii?Q?BjQcVCODzESfGdB7lnoW6Q5XdA29hWYm7/VBz0DA3XsuhLgN1R+9LOFa0yLv?=
 =?us-ascii?Q?xd93cSfuzduiXk5AnakvYr61QI+f6iCvq1T2lI/ohLDapf3x8PieOAVD4sOS?=
 =?us-ascii?Q?UIAhZsOr72ON4xiereeDBWIhYE5uytY1/Mw5b6HOeLfQUVuFQ2PMkrJqXgB5?=
 =?us-ascii?Q?OIH/mxD1UYwmpXA5G1uakp116uD38a/2T3Jx0FSmP5nosYKiREPu9arIk0eh?=
 =?us-ascii?Q?gq3DK88ndxsrGEM3wY/jCYHvpO0ipcMgErpyTLwKiEHn3RRSFU+HLjdHEqlq?=
 =?us-ascii?Q?qwdYQy++wBFz9bm1tWN3h+YKAIUEmvZgI48hLOS6XW9iNhpnucKmQ8F/dA6b?=
 =?us-ascii?Q?oqVUkesuIXMkNHaG03CQIXWfBCy+OcyiHGGYpfgC/uhbl2UiRPdHZ05Esxfw?=
 =?us-ascii?Q?h+9LZ40R3cizPiKDnfSxX3cUoVYOzex2ven/az11?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3094112d-ed17-40c6-3ec8-08dbfabd12fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 02:50:17.6824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lqbJbMLAe971PncbxVkaLKU2S204gd/SmrchKvXp8Z26yUGU0F+1WRNU9y7mpUkoOkGY4q5+HrYdqLegRrAOfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN3PEPF00013D7A

> Hi Long Li,
>=20
> some minor feedback from my side.
>=20
> ...
>=20
> > diff --git a/drivers/infiniband/hw/mana/qp.c
> > b/drivers/infiniband/hw/mana/qp.c index 4667b18ec1dd..186d9829bb93
> > 100644
> > --- a/drivers/infiniband/hw/mana/qp.c
> > +++ b/drivers/infiniband/hw/mana/qp.c
> > @@ -99,25 +99,34 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp=
,
> struct ib_pd *pd,
> >  	struct mana_ib_qp *qp =3D container_of(ibqp, struct mana_ib_qp, ibqp)=
;
> >  	struct mana_ib_dev *mdev =3D
> >  		container_of(pd->device, struct mana_ib_dev, ib_dev);
> > +	struct ib_ucontext *ib_ucontext =3D pd->uobject->context;
> >  	struct ib_rwq_ind_table *ind_tbl =3D attr->rwq_ind_tbl;
> >  	struct mana_ib_create_qp_rss_resp resp =3D {};
> >  	struct mana_ib_create_qp_rss ucmd =3D {};
> > +	struct mana_ib_ucontext *mana_ucontext;
> > +	struct gdma_queue **gdma_cq_allocated;
> >  	mana_handle_t *mana_ind_table;
> >  	struct mana_port_context *mpc;
> > +	struct gdma_queue *gdma_cq;
> >  	unsigned int ind_tbl_size;
> >  	struct mana_context *mc;
> >  	struct net_device *ndev;
> > +	struct gdma_context *gc;
> >  	struct mana_ib_cq *cq;
> >  	struct mana_ib_wq *wq;
> >  	struct gdma_dev *gd;
> > +	struct mana_eq *eq;
> >  	struct ib_cq *ibcq;
> >  	struct ib_wq *ibwq;
> >  	int i =3D 0;
> >  	u32 port;
> >  	int ret;
> >
> > -	gd =3D &mdev->gdma_dev->gdma_context->mana;
> > +	gc =3D mdev->gdma_dev->gdma_context;
> > +	gd =3D &gc->mana;
> >  	mc =3D gd->driver_data;
> > +	mana_ucontext =3D
> > +		container_of(ib_ucontext, struct mana_ib_ucontext, ibucontext);
> >
> >  	if (!udata || udata->inlen < sizeof(ucmd))
> >  		return -EINVAL;
>=20
> nit: mana_ucontext appears to be set but unused.

Thank you, will fix this in v3.

>=20
>      Flagged by W=3D1 builds.
>=20
> > @@ -179,6 +188,13 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibq=
p,
> struct ib_pd *pd,
> >  		goto fail;
> >  	}
> >
> > +	gdma_cq_allocated =3D kcalloc(ind_tbl_size, sizeof(*gdma_cq_allocated=
),
> > +				    GFP_KERNEL);
> > +	if (!gdma_cq_allocated) {
> > +		ret =3D -ENOMEM;
> > +		goto fail;
> > +	}
> > +
> >  	qp->port =3D port;
> >
> >  	for (i =3D 0; i < ind_tbl_size; i++) {
>=20
> ...
>=20
> > @@ -219,6 +236,21 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibq=
p,
> struct ib_pd *pd,
> >  		resp.entries[i].wqid =3D wq->id;
> >
> >  		mana_ind_table[i] =3D wq->rx_object;
> > +
> > +		/* Create CQ table entry */
> > +		WARN_ON(gc->cq_table[cq->id]);
> > +		gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
> > +		if (!gdma_cq) {
> > +			ret =3D -ENOMEM;
> > +			goto fail;
> > +		}
> > +		gdma_cq_allocated[i] =3D gdma_cq;
> > +
> > +		gdma_cq->cq.context =3D cq;
> > +		gdma_cq->type =3D GDMA_CQ;
> > +		gdma_cq->cq.callback =3D mana_ib_cq_handler;
> > +		gdma_cq->id =3D cq->id;
> > +		gc->cq_table[cq->id] =3D gdma_cq;
> >  	}
> >  	resp.num_entries =3D i;
> >
> > @@ -238,6 +270,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp=
,
> struct ib_pd *pd,
> >  		goto fail;
> >  	}
> >
> > +	kfree(gdma_cq_allocated);
> >  	kfree(mana_ind_table);
> >
> >  	return 0;
> > @@ -247,8 +280,15 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibq=
p,
> struct ib_pd *pd,
> >  		ibwq =3D ind_tbl->ind_tbl[i];
> >  		wq =3D container_of(ibwq, struct mana_ib_wq, ibwq);
> >  		mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
> > +
> > +		if (gdma_cq_allocated[i]) {
>=20
> nit: It is not clear to me that condition can ever be false.
>      If we get here then gdma_cq_allocated[i] is a valid pointer.

I'm removing this check.=20

I spotted another bug here: mana_create_wq_obj() could fail and break the l=
oop early. I will do a proper cleanup and send v3.

Thanks,

Long

>=20
> > +			gc->cq_table[gdma_cq_allocated[i]->id] =3D
> > +				NULL;
> > +			kfree(gdma_cq_allocated[i]);
> > +		}
> >  	}
> >
> > +	kfree(gdma_cq_allocated);
> >  	kfree(mana_ind_table);
> >
> >  	return ret;
>=20
> ...

