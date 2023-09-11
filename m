Return-Path: <linux-hyperv+bounces-24-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9B179AAEC
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Sep 2023 20:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C4F280DCB
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Sep 2023 18:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5425A15AC2;
	Mon, 11 Sep 2023 18:57:26 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3954DC2E9;
	Mon, 11 Sep 2023 18:57:25 +0000 (UTC)
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021019.outbound.protection.outlook.com [52.101.62.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6BE1B6;
	Mon, 11 Sep 2023 11:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdS7ys6TVywF869UCtXiNnBV3qctvOEkzFLQt8apaQF66DaMS7Qgc1/jzkPKtPHoQMtJ5ATywkAsgDp+tVhvqeoFaWs7UGxjqHql0GN5sC9/bjUn9J9SieVomSP68KOCm2FfROiPZXkoLA6QVXm2vQWD2CRk3dz1p7B40Yb15CouSjAEEwWx1wl/ljrOVSwJC342KzBzKKagBu4Y7zZx3Dw6EpHv2kaU2k1Fo0e3bCMMzdXFebvN56qBLgP/RmaUp56smtaCDbny9G+KO8ncyfmfHGDKvfvxorySdU8OtL/uYDN/i8w2vaX2BJWa5aGKMOrZOZgDx1ACGjZvdTS2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pB4vJvSsYoj1VbLuy+JiCi8/49qWa3kIjHRhICiaXXY=;
 b=jJlxXaXfJVHxMjwZwsEwXYDktp031U2hf0ODlJbF9/mEq2RJi+fgub8JH2zpPdV13+xlyLdDnMA7YDN4tgGyuY6T8WVCInlW8K5M+vFKDs04LSkHVE8/tUxlIdxOJMs5+ivuMEUUbMAlSE8H6heCE3qwgkfuMDbgxGajFvXwrV8ZfDccgVjdA9LEUaJndr+MBd3EGn/zs2NOcJBz4xcdleCtlNg++54dMf+8B8UZUT4vFFy9eSGCOAINHpAUIjSFi6ZhKiv5nwGFCx4nP/HDJ9w8mKzhwXORm2L5PvzSm+7H7xxNs+jAYyLuh3HMn55ohFeKXLy8uJ0iAAnAXvRwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pB4vJvSsYoj1VbLuy+JiCi8/49qWa3kIjHRhICiaXXY=;
 b=PAUZ+5ZsP/jBydFkrlfT5Pe7ivSQ3EfSRIEgC1oMguRWN6TleLJ26myXn1k8i+xzPmN+OgsZFVm/QnFIKW0NCzotpBbu0W+7hNEBxl5do5I3XdONUTSLYVUz/8Ote3athRsmdDiCmvAOSYyNlLbsSCkXhp+d9LIk+JQuCqraVfM=
Received: from BY5PR21MB1394.namprd21.prod.outlook.com (2603:10b6:a03:21c::20)
 by CY4PEPF0000EDEA.namprd21.prod.outlook.com (2603:10b6:92f::2:0:15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.11; Mon, 11 Sep
 2023 18:57:21 +0000
Received: from BY5PR21MB1394.namprd21.prod.outlook.com
 ([fe80::fca6:ff67:efb6:f94e]) by BY5PR21MB1394.namprd21.prod.outlook.com
 ([fe80::fca6:ff67:efb6:f94e%7]) with mapi id 15.20.6813.004; Mon, 11 Sep 2023
 18:57:21 +0000
From: Ajay Sharma <sharmaajay@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, "sharmaajay@linuxonhyperv.com"
	<sharmaajay@linuxonhyperv.com>
CC: Long Li <longli@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>, Dexuan Cui
	<decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ajay Sharma
	<sharmaajay@microsoft.com>
Subject: RE: [EXTERNAL] Re: [Patch v5 0/5] RDMA/mana_ib
Thread-Topic: [EXTERNAL] Re: [Patch v5 0/5] RDMA/mana_ib
Thread-Index: AQHZ5KwOjzbv5vFcSU2j0jIgYOlpn7AV+Q7Q
Date: Mon, 11 Sep 2023 18:57:21 +0000
Message-ID:
 <BY5PR21MB1394F62601FEFE734181FFF7D6F2A@BY5PR21MB1394.namprd21.prod.outlook.com>
References: <1694105559-9465-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <20230911123231.GB19469@unreal>
In-Reply-To: <20230911123231.GB19469@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6936e8ff-78d2-4828-9d4d-16951fbb395e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-09-11T18:53:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR21MB1394:EE_|CY4PEPF0000EDEA:EE_
x-ms-office365-filtering-correlation-id: 127cd17a-cb57-4881-838a-08dbb2f8edb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 S809J9sGdCTPje86EXFwDBeoXIc6gTYK40n9yFmbJpqF2HJuP21Dyn3wxW4oYHtcZRPlns6sU52/mFGOzvNUNC9AtNuNH8nQiE/xpK6Y2C/K58RmsrCKUfb3Si3lLArtAsNisM9WSN1LCx9zM2CcRrHGhd7WuuvFfwlgFjDzlzmeNIyqU4zlaaAC2qhVxSCRoASFfD0mF+lLw7JTDEWm0aNGe+Fqk6nemc4v+8Uol7IsOdsseY3mXwWEEM0/pSranVuP7u42OzBDG+5gSGRS7k6dgTcrGHNac3ONXJmrL9Ycyta4Fq8tTyPh2lZwfKjudBpuc8L1/zCyu99MjsgdC6CGYtagGoq4M6Wa2327x94HerImIfV+514rRAIRz/AuhmPN7tTZIl4JyDUZK1DsVFQKGWlVKEJFuJ4n/ayX0jG8DY5eQ/010gtJaYjAhdAfZ8/TaQMLf2pw/oLk2BylzwPZkTZEMdKKXD3C/pAQOO87u8v3O1cd8LPJAY3RKIXcGVLg4q3fVG7dI5aFA8d1c1oA7nTCNOBwxkIEJKG757jUhlskFgi0G2nxps1Rgzkpt47IAMyAHd8IoQ3vuDv28Fw5fvoFqztaQO2PnEOJE8HHGNnjitxsHaTh+X5bnxmcnItJ6Ew+E6+wf+7H30f5BYxEa2HKpoWjesynClDXhO0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1394.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39860400002)(396003)(376002)(186009)(1800799009)(451199024)(38070700005)(38100700002)(52536014)(122000001)(5660300002)(8676002)(82960400001)(4326008)(82950400001)(8936002)(2906002)(107886003)(83380400001)(7416002)(33656002)(86362001)(55016003)(8990500004)(478600001)(6506007)(7696005)(71200400001)(76116006)(66556008)(110136005)(66476007)(64756008)(66946007)(53546011)(54906003)(10290500003)(66446008)(41300700001)(9686003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WqEA9c93misZLqwYS/1ViS/yOMX75Ic7eYs7g3Ca/n4TP9aUKDe7kmW5z0Tk?=
 =?us-ascii?Q?XXMT54r/EA3vRJSqiZj1mkAUwAdSNqufitpQSICLaIDpRsL4bFBzNIyKIQjq?=
 =?us-ascii?Q?g51pc9nJyOjeOFa8wDOGJxN42nkUTQBjwJgp9hPTorgxw9k+nK9qHydH212m?=
 =?us-ascii?Q?aAJg8TMRc+c3VsruYOy1YyIZbGKeyV2znDvJqooFRTDqJChAqvPQR8RQsRD6?=
 =?us-ascii?Q?SzRh3+u0KHWbXvg7JsQ3rWpm35w9EWG10XqJyApAiikjvf3vMC+PgWEAwi+Y?=
 =?us-ascii?Q?0WTSZ8f8A0VSiORJ7XndsHt0n85bcuWvl9N/OiwzgAZJuxGn0Gev077TI0nY?=
 =?us-ascii?Q?vNHG9Qjyme99oZbWKFUhXXGBQ1ru4PmyQ/agWiQahWyxH7mjG5TQvro1QPNm?=
 =?us-ascii?Q?0KI3d4TBLR1+M5AAts0oatoy92/uHtkPuo9fgNiZzHNRtLayCD7EnppF6gC/?=
 =?us-ascii?Q?6qfPcO8OOvcds8fvCG6+67MA9e/TVwpgkTTq1NQo5b9siODoXGBBZSdOMH3F?=
 =?us-ascii?Q?lkZrkAT+uwSzLKo0HdOGM95HiRUyJAzIm/QRW5+TDUbkgfJLMODIqEZVO/jf?=
 =?us-ascii?Q?+sKD+pazbLR1xPK6ApTV83US4ZcpeqifLOc74xKuoogRigRI1HrS/T2gUQb4?=
 =?us-ascii?Q?v7VVVnoSWzt3ia4RxAbyPO3j8LvD1manQiRNcUJOS2YRmT2QhNFgkXOo2lX6?=
 =?us-ascii?Q?rR7nvqPJnI0B02QV4b1nN4LZpNac3l9/2jqIt27YdaOGL8GI7Q2VbOU+uG6X?=
 =?us-ascii?Q?y7369bdCkkP6zzWwqEm2PRmeD5JqJSCEdVuxTxfl4PjM3cs07WGJUyZMHVb1?=
 =?us-ascii?Q?FXv8Kjxa0CjKzfgvWXZKz2NLvhkMholarlDzV3FY5Bw2LqKvuyxROtESWYW6?=
 =?us-ascii?Q?J9sz/rUt0E2Tw9E0MOA+oD2uTZW4xHQQlUATxA5Y+k1DqpMomNJ7I7jnVE4F?=
 =?us-ascii?Q?WKLM+STzzQf9s6PeqbJbbRuMQjeohOe5Lsoy/rKsc6+tPLciRh2qNlNeZZ7C?=
 =?us-ascii?Q?MgIb3fNLzMtZz5kTvCpQTeNLLbhkOebAFkZMTOpXr7jHFyPekVZcd2dO4FyG?=
 =?us-ascii?Q?F8ntY1xGtJSBkgJzh4QdCQqNmTFClhfGF8Jfztn5oAlfasbjImCEdESXT7Og?=
 =?us-ascii?Q?sVWNeMmMgCCu3MO+iqjCsZ5ivijuCNjP7YovRiZHWDAUl3Y5HZsn41yKOehf?=
 =?us-ascii?Q?I+zzoygL0+iOlRxeDhE5Vhw4YF3dpomvRFKeFSR+SBy2vsbosw2rO3FaMM3A?=
 =?us-ascii?Q?bhv8UdoM3Nz5KeY77nJp9T5sImJ1hhYzJjf2rzmae4JZtksSDDGk911p34Yx?=
 =?us-ascii?Q?ZI9+1GcXu2TadmJFd2yFurnliGPg4cGRDpHPWOGuYXFZbVwxPzLiX6cUKgCU?=
 =?us-ascii?Q?1/lEg8hsCFA8bpExbxYE0SGNf/1RBHUlbMR+bLewkr+DSXVM9RMA2uUxkAsd?=
 =?us-ascii?Q?m7alLMBRRFIPE0/7SFdMVOvKNAjubom8HbHUhgMf5qEGFANDLnIJiVafjpd1?=
 =?us-ascii?Q?gZPCizYgzk/PR8zW3OuQf8gJKJ2LUVMG7Boce92q8yA/8t3OxdMKxgaaypeM?=
 =?us-ascii?Q?TjtZqOIDt6zQFipIgzYymiXCzs9sVRLTH2WCgUJ3?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1394.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 127cd17a-cb57-4881-838a-08dbb2f8edb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 18:57:21.2517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fx01pTMyV6OxGNjtAPVrHyTZRY0WSFvK2nTz9SEHRbokRexJU2YcjTrF8Zwsq0Zxp6/fv3HajaxACbKBn7ClLjgi+KmTonEB7ajbI1uDIFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PEPF0000EDEA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I have updated the last patch to use xarray, will post the update patch. We=
 currently use aux bus for ib device. Gd_register_device is firmware specif=
ic. All the patches use RDMA/mana_ib format which is aligned with drivers/i=
nfiniband/hw/mana/ .

Thanks

> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Monday, September 11, 2023 7:33 AM
> To: sharmaajay@linuxonhyperv.com
> Cc: Long Li <longli@microsoft.com>; Jason Gunthorpe <jgg@ziepe.ca>; Dexua=
n
> Cui <decui@microsoft.com>; Wei Liu <wei.liu@kernel.org>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; linux-
> rdma@vger.kernel.org; linux-hyperv@vger.kernel.org; netdev@vger.kernel.or=
g;
> linux-kernel@vger.kernel.org; Ajay Sharma <sharmaajay@microsoft.com>
> Subject: [EXTERNAL] Re: [Patch v5 0/5] RDMA/mana_ib
>=20
> On Thu, Sep 07, 2023 at 09:52:34AM -0700, sharmaajay@linuxonhyperv.com
> wrote:
> > From: Ajay Sharma <sharmaajay@microsoft.com>
> >
> > Change from v4:
> > Send qp fatal error event to the context that created the qp. Add
> > lookup table for qp.
> >
> > Ajay Sharma (5):
> >   RDMA/mana_ib : Rename all mana_ib_dev type variables to mib_dev
> >   RDMA/mana_ib : Register Mana IB  device with Management SW
> >   RDMA/mana_ib : Create adapter and Add error eq
> >   RDMA/mana_ib : Query adapter capabilities
> >   RDMA/mana_ib : Send event to qp
>=20
> I didn't look very deep into the series and has three very initial commen=
ts.
> 1. Please do git log drivers/infiniband/hw/mana/ and use same format for
> commit messages.
> 2. Don't invent your own index-to-qp query mechanism in last patch and us=
e
> xarray.
> 3. Once you decided to export mana_gd_register_device, it hinted me that =
it is
> time to move to auxbus infrastructure.
>=20
> Thanks
>=20
> >
> >  drivers/infiniband/hw/mana/cq.c               |  12 +-
> >  drivers/infiniband/hw/mana/device.c           |  81 +++--
> >  drivers/infiniband/hw/mana/main.c             | 288 +++++++++++++-----
> >  drivers/infiniband/hw/mana/mana_ib.h          | 102 ++++++-
> >  drivers/infiniband/hw/mana/mr.c               |  42 ++-
> >  drivers/infiniband/hw/mana/qp.c               |  86 +++---
> >  drivers/infiniband/hw/mana/wq.c               |  21 +-
> >  .../net/ethernet/microsoft/mana/gdma_main.c   | 152 +++++----
> >  drivers/net/ethernet/microsoft/mana/mana_en.c |   3 +
> >  include/net/mana/gdma.h                       |  16 +-
> >  10 files changed, 545 insertions(+), 258 deletions(-)
> >
> > --
> > 2.25.1
> >

