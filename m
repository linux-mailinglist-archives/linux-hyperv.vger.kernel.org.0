Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1587F49E556
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Jan 2022 16:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242697AbiA0PCN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Jan 2022 10:02:13 -0500
Received: from mail-centralusazon11021027.outbound.protection.outlook.com ([52.101.62.27]:32731
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237314AbiA0PCK (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Jan 2022 10:02:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HivM1KLWkF5O+OUizgMkw2/1gNNZkwT8yubqD0BFwUIlh/FUYMra/EfEJGLs4gROSvPbTyqP70upmfebchkmDCiuJpKm6Y2uljfaq3oL+ndpj12IRAVZfouVbpHg/4ML67XdglQt1+nFaLJ5vG6CiFQUmmNJUyY2vGxzgz9P/gIoGYICKOy/XYczlo25DTNMZJ0fxp9tyhgAZ9vyabNjx64gLAoJ/Qe2AkppHJ3q3C/i3XuhU00qin9H6fObtooEDpCIYb2igI1DbXLZIDZnZRKzTc02XhuMcAbY8WOiU0f1LRyuExPI16tiywsqwtb5sKM0S+E1ywyxGOTXGqA+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/a0XMVz1RG+YLTVA2V8RE8O0gSqZg+YWtAaOFFVUhMQ=;
 b=RY9oxkofKmYPnn+uoUVpDzavmk1yJCENz0Nr51UoZoyLmy+ICrczxWmJI2F6KGJJSWFWv3TkeU4nM5+hdhaYk2ygT54wrNkW0DZwdIJM8zGbxh32oQzfhOZC9IUjQ8Ddv0bbCHuqPcIfc0C7bvLzWMyOXGhbsL7+ThKRen5cjqWYi1gZBy7WoWOvDh0M0Mil8hRkeu8a7J3tqO/gQgdUV+lxfPlizBYUU04YGyg9gUK6eIZhE11+KTRBS2mTeg7rODMVao2JCHKoZAHTwTe76RjaLTNkfSQDF/u96AUCmh9AGL4Pi2g8HJexjaAyTTTo//xEgx2ynfdVqHcJjOXA6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/a0XMVz1RG+YLTVA2V8RE8O0gSqZg+YWtAaOFFVUhMQ=;
 b=djwxe5SnuSqwlZ0kv3+u3FE3VnjI+HEtHPI3KbaOv0GY2FMV1Gett5vPSVQcxWVc7XP3ItA9p8HtO9li8dMwdM5++bqhyApxco5VBZtcaigf7d6urXS7K71rmS+8jY13Ts2pO4HTL6RaC9kqZY3zbdGdnTr0EBuh4zzrQhK960g=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by PH0PR21MB1880.namprd21.prod.outlook.com (2603:10b6:510:1a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.9; Thu, 27 Jan
 2022 15:02:05 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6%7]) with mapi id 15.20.4951.003; Thu, 27 Jan 2022
 15:02:05 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>, Yury Norov <yury.norov@gmail.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 43/54] drivers/hv: replace cpumask_weight with
 cpumask_weight_eq
Thread-Topic: [PATCH 43/54] drivers/hv: replace cpumask_weight with
 cpumask_weight_eq
Thread-Index: AQHYEIkT9Q6vYA1gsUeLLWD0pXcM+qxx5hyAgAUUIpA=
Date:   Thu, 27 Jan 2022 15:02:05 +0000
Message-ID: <MWHPR21MB1593C8511E18E4539CECAEC5D7219@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-44-yury.norov@gmail.com> <87sftdij76.fsf@redhat.com>
In-Reply-To: <87sftdij76.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cf567589-b34f-4cc7-8eae-4173ac164e09;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-27T14:53:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 171bd682-13f8-47a1-c26f-08d9e1a5fb7c
x-ms-traffictypediagnostic: PH0PR21MB1880:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <PH0PR21MB188021B99F06454C9B638824D7219@PH0PR21MB1880.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I5k1LxknNRM7XUCc7AgiWzUoqqYBNKV8RVSPQdWvGRjJwbh3/MOE+0zv/QAitH638dc8AbkcDaMJZoZcgiL+BvHoiypMR6A19RXbsRnMDnSON7OVhTyJngosVlNTc7ESIsTVCXGkSTDMyFA7FnncZUIMJvtDvjBG4Kg33pLT5FpNF4dxDA27QaM11pzNc+o6bWWcRqyYIymaB5tlqZ2uIBBSDCEipISbeOXe6rOOtbsPg5YKLvWbsA9IZbMNYZoEkACXrtGGpJmR3yXFCABkvGYXMIbIDUaQ+XBX126EXFCEaqcMuyhyJK4+M/CsJ9Ep1HdO6EKE4QRo2ikXmG81lBohebi5/LJ6OACXBaEkETF9QYG7gJzMOS1qClr+L19MHLvE2N/EJ6SNmWoPXbJPHx0VPpFq5xHPHvdMg9Ml+Pe6wpIR8gTeYLXyYFMmgAKuu/ijdbUyBvf2/gas4ppRLmbtGciLu8uEFaVmhmiyeEOQas0Q25ep+/Ufh2+WbGPCikY0/Sp90mcms+oF3ufPTu9yzGy8FpEPTy6bGLUvb2/OuYIu+bwpPyxpNJlHMtKELMm9id4KO0KtSHxh/ykakFngxuIHmGL6Oj7EpzVgz+qq6xMZQw4EiaaqXlMRWegRFkMwQfwmh7A7Cc4xgogDBKQopW/W+JpOHu0ysWBRpb25pJCm1odMGBrtgo8RV+RnQaH/m6jBkveK/l9AN03FZZcOgXMadKpeQuh9vXJyRdzYlji/Ze7jatl9Tq3AInbZBvDLRTrrkOQEXsryR/OjYbLEB5NiRESDL++InlGsot4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(76116006)(82960400001)(82950400001)(4326008)(9686003)(38100700002)(66946007)(66556008)(7696005)(64756008)(8936002)(8676002)(8990500004)(66446008)(66476007)(33656002)(55016003)(6506007)(83380400001)(2906002)(54906003)(5660300002)(7416002)(26005)(186003)(122000001)(71200400001)(110136005)(508600001)(86362001)(10290500003)(52536014)(38070700005)(16393002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?kWXI4RfQ1+1CZH6oFxPmG/nPb0WPOsf56M/cPzLn+T2n1jGqc0UqFtcfpb?=
 =?iso-8859-2?Q?384CaxwyiwARE874+e+VLmXFtXkPPVt51BgXLP348CVxOrKVWITDMijIPd?=
 =?iso-8859-2?Q?/Oomm3ziUivu8eev3zIyz2SDYKWhUFia83ispAgfHbSv6e8BzbxtmSZ/UV?=
 =?iso-8859-2?Q?k29xW6zJPyv7LgPvFA1nOii5Jsph/eqYy4WdgYYiEfmmUuydt+ciyAWpnI?=
 =?iso-8859-2?Q?gvyGjeFUlESs7FgK/MFCGxdGFJFl+4VDydSuiMuHJTgRJqaG/pIqB5SiIC?=
 =?iso-8859-2?Q?/AZGR9a3Jqi/EBPeb20gyAEZRxNODvAuH9PdIJiDajv5jRSpHqj2WO5bU8?=
 =?iso-8859-2?Q?EGHI/0IyeG570kb3dyltMB/fjbrxHsXE/kyCbw4mH5QfK786Tu3RzW+CHU?=
 =?iso-8859-2?Q?iEpjKzpp7FyAgIlR/KXYjrfYEfbTUJseGwpypUJXrlR1FSTk2XjpKKaVN2?=
 =?iso-8859-2?Q?OL9L5CNfNUMrrF8YIZIMrh53oB51744bORHe5GsUHxNo1NDLL7ZhR98uIq?=
 =?iso-8859-2?Q?WYGUpdPZk029MCH0CLi/YuYpdX6/2QtSxiu2k6nvNMaryG7fwQYzA179dq?=
 =?iso-8859-2?Q?7g4CDMDTRYVy4dSZ8rKr9WVTw3c4BtylbIoEooLQ7n/hEaxnkw8gamv7ui?=
 =?iso-8859-2?Q?tHlbZZGdUk0iAhKnmbtLXCRzJh6l2f+0F6oWHT1VzhoCa9is9+8nQ1llhU?=
 =?iso-8859-2?Q?OVQm6l1rfLmaIMHzKOwC4dNGa5U4fOnB3QbSUI72ZGzkJhGIqgvpZxBe27?=
 =?iso-8859-2?Q?Qnhr18wAyCdrW1qeaVWqH54uCIPQKTjx4v/s2N41mAfOYeFtnwQwAfXr4/?=
 =?iso-8859-2?Q?x4l/CcrHssoqep4/pcu8IM4pbBQxFZnsjqnM6v8cA494T2dAMTfpqmrVjG?=
 =?iso-8859-2?Q?ei3eJ1U8V9+WI/+3mHgc8b5m48lpfJ1syeDHYqOOPrd0inS7yGSRWqJH/U?=
 =?iso-8859-2?Q?IOhTwRiJffu/ojXjzyqjpuzJLkch+Y5w6zM3orh/+il+xiPertW7ATzSpQ?=
 =?iso-8859-2?Q?xqOxsJNJpyYWvP3GVKrhHHmTvc3hZCV6S2UNDop2c9xj0AjNYDBoKhGcbU?=
 =?iso-8859-2?Q?OGnbpH2Q+22+xywiVDv6ctmIE9fbaHdSVQuaHyoGsY2eC9LKEosvdc0tbY?=
 =?iso-8859-2?Q?54SXs6BMr0cC0r7Ltg8wwwml5TvtWyP9YWMhzzo52yaUMdBPtlyOl13Zkd?=
 =?iso-8859-2?Q?MjaXnGABowQ5qPGH7oOOcUcsokfJx85juB4UNdG2R8Hg2X6Qj/Gu+y/Z/U?=
 =?iso-8859-2?Q?CNCxWyRdx0pkmKKRD45FI3B308XwqMMoFAWp3XtSrgIXFl49jSI223bEAd?=
 =?iso-8859-2?Q?m41KCGYRkdGcSABGkfTXwuxDVJOIDWWfmYc9N2iS5vwF89C8xWWDQN0/nd?=
 =?iso-8859-2?Q?X/FFlXNaR69vEEqjc9TO1AYtEDLHGVZTdpuI8x9KChmWJ4NCHa+strTj6S?=
 =?iso-8859-2?Q?3bbzLLo0EjPmAxapF9sk3RnLmYVTKMB0Ml0totoOCcrEfDuzOfalnUzeSZ?=
 =?iso-8859-2?Q?NQz09CBG8yOp1pmIwuL0UhoDp0IaZKhJIY5omnYhEnKtKgCi6yxpnp1nby?=
 =?iso-8859-2?Q?SieihRBEHqB8JVAHJ+duWrB9XAbffGawZWws/rr//C5vJ+mv9Y+eFRlrq+?=
 =?iso-8859-2?Q?tuGbhUGu8u5wtHHs53nc7eHfq02tj01/4nFpc59KXiwwOKVy8PIEaLc5IQ?=
 =?iso-8859-2?Q?8pERszcZuuElp6sIP/hUDoy4yiOzrO+4XpP2EtL2bazzVHJ/iuwirLle7Q?=
 =?iso-8859-2?Q?HS3w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171bd682-13f8-47a1-c26f-08d9e1a5fb7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 15:02:05.2753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a3nJO4R/3F7V8EnsSqnfIQ7zdVohFteG8QX6UoI104GJXRjazCTWei0avSpA7G2xKaeb8zIheRBfXkDU4uoc1JwQb91tI1xAVmVklMEtp/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1880
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Monday, January 24, 2022=
 1:20 AM
>=20
> Yury Norov <yury.norov@gmail.com> writes:
>=20
> > init_vp_index() calls cpumask_weight() to compare the weights of cpumas=
ks
> > We can do it more efficiently with cpumask_weight_eq because conditiona=
l
> > cpumask_weight may stop traversing the cpumask earlier (at least one), =
as
> > soon as condition is met.
>=20
> Same comment as for "PATCH 41/54": cpumask_weight_eq() can only stop
> earlier if the condition is not met, to prove the equality all bits need
> always have to be examined.
>=20
> >
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  drivers/hv/channel_mgmt.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> > index 60375879612f..7420a5fd47b5 100644
> > --- a/drivers/hv/channel_mgmt.c
> > +++ b/drivers/hv/channel_mgmt.c
> > @@ -762,8 +762,8 @@ static void init_vp_index(struct vmbus_channel *cha=
nnel)
> >  		}
> >  		alloced_mask =3D &hv_context.hv_numa_map[numa_node];
> >
> > -		if (cpumask_weight(alloced_mask) =3D=3D
> > -		    cpumask_weight(cpumask_of_node(numa_node))) {
> > +		if (cpumask_weight_eq(alloced_mask,
> > +			    cpumask_weight(cpumask_of_node(numa_node)))) {
>=20
> This code is not performace critical and I prefer the old version:
>=20
>  	cpumask_weight() =3D=3D cpumask_weight()
>=20
>  looks better than
>=20
> 	cpumask_weight_eq(..., cpumask_weight())
>=20
> (let alone the inner cpumask_of_node()) to me.
>=20
> >  			/*
> >  			 * We have cycled through all the CPUs in the node;
> >  			 * reset the alloced map.
>=20
> --
> Vitaly

I agree with Vitaly in preferring the old version, and indeed performance
here is a shrug.  But actually, I think the old version is a poorly coded w=
ay
to determine if the two cpumasks are equal. The following would correctly
capture the intent:

	if (cpumask_equal(alloced_mask, cpumask_of_node(numa_node))

Michael



