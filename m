Return-Path: <linux-hyperv+bounces-630-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8258B7DA286
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Oct 2023 23:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32F91C21043
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Oct 2023 21:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1943FE37;
	Fri, 27 Oct 2023 21:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Eb09xeSJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801043C08B;
	Fri, 27 Oct 2023 21:35:11 +0000 (UTC)
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021006.outbound.protection.outlook.com [52.101.56.6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B96B0;
	Fri, 27 Oct 2023 14:35:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6u7doVB/kd9doDw4SwcSNaLEWRzO7tHQbjzD2P0Th7qx0CCS9ijl9CEhn0E8Y3W3FjaGLQJHaa0V5K+xL3jvyghB79LAheZSdZGrrK1jBBHhq1I/0fmdLJ16H+4d4rFMLIbpKN25rqfhyoPR7tooLFpK0qyYVzko9yWM0OfQ5Jef2/NxnYfdA/Kz5U9J8aBOyeHmHnBUD81jRvX1Z9W5D/Y+p7YPVvgTEQglq7aUsBfcj1cfHN9mcaxU04g+fGPybLbdmrhLhCBHMM9g9aDZg8p75pXnR84n2gH13dv9amhywtG1raiaY4U4l3XH/XVE1flxKUIwC/M5tJCEWd95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTs7Fp42ZygZg/ikiO5/CnbruF0SW2MN+e1NREjDenQ=;
 b=fBwsYf4bwZ6ljzfAZa9BP8o4kauNkm6WrZ97OMQWS4hVPhy2EKfn/0bMCsvVo9+JKfCVz2q1VBX/bfvQadsgQDDVhhAsLOHSBRUQn+7v+Ya6Vgo1uYPcT1L8MolISN1pK4vJUQMRQ92mpTIQ1G0/UD0Z4BP6E+kZkcSWlSbpnTNRdkmcFsTkyApHlY52ckIIFtI2N02zKCoXSpKozrc4Y0ichelQML8wHvjTHFYsJ0ivtpM9sL6xTX73q3+WYH/ASsBTbkZyo9K25MJezaq9luchTGrwVlhweK/nR2XmcfJNUacqgWDy7HCBULecYLWcL/O50ipMdBRNIDfq2dbMaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTs7Fp42ZygZg/ikiO5/CnbruF0SW2MN+e1NREjDenQ=;
 b=Eb09xeSJFeu9dhwusN+t/pBVtylYPfPWH0VFST5tUv1ZO6ywAKckOVbjEOTKs6m7hr3Rrpsk6JKgw1XIHRGmMASzMa7IONK6RAoN2ZXYcBWlRNgB+a6j0mzbYJGY+JzPLk7z9cyKbFVcsHNs8fliHrfVZtBMHby/gUwXCFEsiOo=
Received: from MN0PR21MB3264.namprd21.prod.outlook.com (2603:10b6:208:37c::19)
 by PH0PR21MB2064.namprd21.prod.outlook.com (2603:10b6:510:aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.5; Fri, 27 Oct
 2023 21:35:05 +0000
Received: from MN0PR21MB3264.namprd21.prod.outlook.com
 ([fe80::9f51:f462:e8d2:d242]) by MN0PR21MB3264.namprd21.prod.outlook.com
 ([fe80::9f51:f462:e8d2:d242%5]) with mapi id 15.20.6954.005; Fri, 27 Oct 2023
 21:35:05 +0000
From: Long Li <longli@microsoft.com>
To: Ajay Sharma <sharmaajay@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"sharmaajay@linuxonhyperv.com" <sharmaajay@linuxonhyperv.com>
CC: Leon Romanovsky <leon@kernel.org>, Dexuan Cui <decui@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [Patch v7 5/5] RDMA/mana_ib: Send event to qp
Thread-Topic: [EXTERNAL] Re: [Patch v7 5/5] RDMA/mana_ib: Send event to qp
Thread-Index: AQHaAH3QKoiDSqFL1EOXA9O+c+9Ua7BXuxIAgAM/awCAAz6OIA==
Date: Fri, 27 Oct 2023 21:35:05 +0000
Message-ID:
 <MN0PR21MB32641E489F378F0C5B357795CEDCA@MN0PR21MB3264.namprd21.prod.outlook.com>
References: <1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1697494322-26814-6-git-send-email-sharmaajay@linuxonhyperv.com>
 <20231023182332.GL691768@ziepe.ca>
 <MN0PR21MB36067E337A53C3BAF8B648E5D6DEA@MN0PR21MB3606.namprd21.prod.outlook.com>
In-Reply-To:
 <MN0PR21MB36067E337A53C3BAF8B648E5D6DEA@MN0PR21MB3606.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f66c6187-e4ae-4c1e-b328-36065610560a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-25T19:58:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3264:EE_|PH0PR21MB2064:EE_
x-ms-office365-filtering-correlation-id: 4a9015b2-fdef-4ae0-9e10-08dbd73495fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 N4djry/HjGlz6PW8MM9Oxv/aYueGzQptSlC/uS7DbLG/VsCV/GBKZyxLMoOHT1/qag7BSZOdkaQJ0HbBjwm3fyxsr2FR57ck2EL+GLnWM5mrFODTNv7MBChYRLO0Hdy9XaC+5/yUYR0sZL6RwZMw9r37Fe3jjvRhMz6iqDQaSIkKO/mp0r3n9aGmnTgV7dRyxI6o2pZ8zdjqp6NWS1OxX3/LlQfTlrM7Ym7LCav6t7dAfh2sZooiYoqQkn2okLAgHQkWfXIBtaXw6VBT+mPxT3xnP1I9OJ2CvOwGAFNSGx0EDDupBoQ45i9z08MHZVVMvrMoeznnzctYxeAMIZZLEPBbytdE0l7nLbd6qyMi2SySk1T3B3bopDMzS50QeikD5fUjse9jT3ibw6iCakJmGR63BZw7FyGl7VZXBRrJinvdoeU17n8e8fzIH3QtZz1HFsnQDlvp1+GpCPr/JvjQDIKnqMyUsT+b1lDCxYoZZx4SyngZ704aqvFqxW88Vta6xpcw9PDdMU1ADF9UCS+DDmiXwcFi/JUMfpHvxTpLLpVTpBSmgQkKIDReNau82ztmyUyHuAZ76/M+CBZgtPg7wckJKG5td8Mh0cawYXx/4wrLclAoy1E2VMrZ5ldwvvnbbZNFk/qvKGvXhCVi0tH6Z1A+u6DKe1wLBCnk2/bqNHPLvNTxodKTtry+25wYKJ6bsPTts7hgmjGE7opaktPjQg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3264.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(366004)(346002)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(53546011)(52536014)(7696005)(55016003)(9686003)(86362001)(478600001)(6506007)(66556008)(66476007)(83380400001)(38100700002)(71200400001)(64756008)(110136005)(66446008)(76116006)(54906003)(66946007)(10290500003)(316002)(4326008)(122000001)(41300700001)(8936002)(8676002)(82960400001)(2906002)(7416002)(82950400001)(8990500004)(38070700009)(5660300002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ivxBtTqTb26GHTOctLOcWl1ntaQh2gFPViRKztKhKYVFyHSLy53rg4stIGAL?=
 =?us-ascii?Q?OSm5qJOsIJhH51gzf7Hxx9EhHFJkO+pEk1ZgTPBQEoH3YxsUjVbLU1uQ5cAz?=
 =?us-ascii?Q?7ISZ0MzDI2ZMMzRqytqKUUGnZUMa349KNNx5XOAgf245m9GBsUJRvE6/MF7K?=
 =?us-ascii?Q?en6pd4voIM8BTKI7FuzAuz/IFMwu8BYqXJ99vhLp79UYNzvO3Cs7LNOgCa+b?=
 =?us-ascii?Q?hMW/tnBunqelDLyiisFYAxMpxbPpSIdEeAkbMKUsO4oFsDni39ftDhWWZWIq?=
 =?us-ascii?Q?kZtj07vW6C/ehMWL1hDPEl3TUiUoM81H/JhmVxEPQDW1l1BZo4KBK2z0k5CN?=
 =?us-ascii?Q?7h/uzzR99iiEKXv8EE5cTV5IJeMxiVxRghtRsukBgv7MvvqJXrCDyYoxJahm?=
 =?us-ascii?Q?ca73a+VERMDk+02wOG8yEKyzzEoG92OIIelgQ1a28pXKZHkGS0sue3nJdWd+?=
 =?us-ascii?Q?Y6W5rkGf6/zRzUdUdezv0UdLYkoZbyLU7AaqDjhYHrpsf16fYqCclsUG1t2I?=
 =?us-ascii?Q?f7ceLQiv229Rrx/lvLAPLkh8Eja5mAWtf3ftsP8faxYZ/euwsn7CbZ9Gk48o?=
 =?us-ascii?Q?Y9wO/FtKpzjPFNNlb4crVXGqU/t/4O+4sEiAS3RcXHqTXmt5HG9IgCbOMM4V?=
 =?us-ascii?Q?bq/zzqoYlodQm4lhAxavY9wrGaaFe/iHcIUmEYd6xVfqn7dz50wsQGgSYLuv?=
 =?us-ascii?Q?nZJnfJ2W8rqo/BYz5iH0e382rtSdylkuVWwRixpRXvyxsdwUcmeVc3ifntCO?=
 =?us-ascii?Q?Jytxp5VKhjrAc86KZa6mub7Qf1QawmEKTufZydrMSBA/LJayj+FyxpCieh4s?=
 =?us-ascii?Q?mYGivSFdCKcrPpyVEfD1mNyyfPtV1qhZ18w9XP7XuE6GgXVCC/Q9sglAkcGg?=
 =?us-ascii?Q?WITnVAnVi7uYNFEdygptNFmOUNka9cA/KpwOXw9DwgJdWQNQvEQjq5NVViOl?=
 =?us-ascii?Q?n0iI69872+iNWrPWsM0t8GqLh9ferQSaNXxkDMDtHLAH/7cp/7LZAR1P4bEu?=
 =?us-ascii?Q?upHS92QflNeoEN3B9UgD9JO9d6Pr0338Nhzb4OWs8/EpZ3eAc7q+NVZsJT2w?=
 =?us-ascii?Q?3QSGUWyAPbdFSVqzZN3dlEBKm3CggV5hfF13OgNPgMfgYZGmh6WvY3zqnmLV?=
 =?us-ascii?Q?vYD9QsFeoywvn4cmMO0spcnpct6kXrvC0jTHsTSM0ftAWO0y486AFKfRD1nP?=
 =?us-ascii?Q?URch6vN0/lXr8eUikP2LVAvBU2zf0kqe2ZJ5NwO285jyLA1voBv8ioE3U7dg?=
 =?us-ascii?Q?4ePDlamvbSsmNEOs3TWUkStsEq01/DrZw6D7ebY5Wd5FYmuTFwBcI5xQrW7B?=
 =?us-ascii?Q?oanGnoXCFB4AeuFSvC9fZr6OnE0rbo3VMYOsdPEpIj6RHMJz86C9t8CvmdQL?=
 =?us-ascii?Q?2Ap0napIPO4vPt0AGGD6obw6Hlh2WVHoJszfwSs+LNK2IxsDUNyhQdyMBq+o?=
 =?us-ascii?Q?uHpXyIBm41sUYtLiJTsk+twOmOMIA1oeb90Uyd/RNgCv0BcAikCjQLnAXUzB?=
 =?us-ascii?Q?Az8xbo9BFCfL+HqwI0zFEeiu5RoBViIqwZ81rLTPklmrNbtG3Af3vslW1G+e?=
 =?us-ascii?Q?kekkSYQKaYfEk0b7czCq4R7wiNZDpizKH89+IBxGfaEvp21BLG06bU/Tvd+G?=
 =?us-ascii?Q?NxhX0QuuImmFqLczKmhD355GMQ4r9hY/2c8cfkW1VACM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9015b2-fdef-4ae0-9e10-08dbd73495fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 21:35:05.7465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +o6VxhrYRTK0yLNrE0svAML+Gh/5LuAPih4ZGBKp831KAJrUUkX1Igtn8rc2HJVvWqLH3+TVgQLo2YiAd+Yccg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB2064

> Subject: RE: [EXTERNAL] Re: [Patch v7 5/5] RDMA/mana_ib: Send event to qp
>=20
>=20
> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Monday, October 23, 2023 11:24 AM
> > To: sharmaajay@linuxonhyperv.com
> > Cc: Long Li <longli@microsoft.com>; Leon Romanovsky <leon@kernel.org>;
> > Dexuan Cui <decui@microsoft.com>; Wei Liu <wei.liu@kernel.org>; David S=
.
> > Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> > Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> > linux- rdma@vger.kernel.org; linux-hyperv@vger.kernel.org;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Ajay Sharma
> > <sharmaajay@microsoft.com>
> > Subject: [EXTERNAL] Re: [Patch v7 5/5] RDMA/mana_ib: Send event to qp
> >
> > On Mon, Oct 16, 2023 at 03:12:02PM -0700,
> sharmaajay@linuxonhyperv.com
> > wrote:
> >
> > > diff --git a/drivers/infiniband/hw/mana/qp.c
> > > b/drivers/infiniband/hw/mana/qp.c index ef3275ac92a0..19fae28985c3
> > > 100644
> > > --- a/drivers/infiniband/hw/mana/qp.c
> > > +++ b/drivers/infiniband/hw/mana/qp.c
> > > @@ -210,6 +210,8 @@ static int mana_ib_create_qp_rss(struct ib_qp
> > *ibqp, struct ib_pd *pd,
> > >  		wq->id =3D wq_spec.queue_index;
> > >  		cq->id =3D cq_spec.queue_index;
> > >
> > > +		xa_store(&mib_dev->rq_to_qp_lookup_table, wq->id, qp,
> > GFP_KERNEL);
> > > +
> >
> > A store with no erase?
> >
> > A load with no locking?
> >
> > This can't be right
> >
> > Jason
>=20
> This wq->id is assigned from the HW and is guaranteed to be unique. May b=
e I
> am not following why do we need a lock here. Can you please explain ?
> Ajay

I think we need to check the return value of xa_store(), and call xa_erase(=
) in mana_ib_destroy_qp().

wq->id is generated by the hardware. If we believe in hardware always behav=
es in good manner, we don't need a lock.

Thanks,

Long

