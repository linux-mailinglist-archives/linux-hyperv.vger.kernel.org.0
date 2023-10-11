Return-Path: <linux-hyperv+bounces-517-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8577C5BC1
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Oct 2023 20:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D39B1C20A41
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Oct 2023 18:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD9A1D54E;
	Wed, 11 Oct 2023 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OIzOVD5F"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973561F187;
	Wed, 11 Oct 2023 18:49:28 +0000 (UTC)
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021019.outbound.protection.outlook.com [52.101.62.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62974B7;
	Wed, 11 Oct 2023 11:49:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKW+0MKusMPBxNudfjDNesv+Qm4RRzDQ2oycyqcZu7oPV+N2fRdQa+RtpHxfNhNXZ2kFq/jcvR6oJZ8iOQwmMLEQjR9mAVZLkqN5V25UbHfMuP84iqmDk/rniWcxpUEHmAMZY7BtffE37mLp3QcV1pQq44FJj68PY7V6UjN/cePGsT+Tun9IrG/Llg1gfDVbpLmInRT8yZjNgP3wlVtQY+u//RnbgpIepbOxGb96bilXEV0ErFXiMnXhSTukmyvLJZ5h+jzE8ztIaPGH6FUrim3Aiw2EHTJ/+mfiuyathzyKvbSGItGuahQnIX7luaqWJvbvoFdX0h3E0fVwng6VXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuYg9Pnv5KMhyJqeQaXpeRNJWgPhZHBYCQbEkgtTHJY=;
 b=IJTC3ZiI8OKK1GZrl6HKZlyrtCx8pi4Axae1FDrnML11hLWiEqiaCnhiwG/p7KSfmpsK/IR7CDj4FMN9TuLhyk/FOjdpaTBg0uDwITtAttc7IeSxZZcy3v3dtVbLdhxx7PLFD2gclhO8V+XsUNMwRt85Pabr6hFxnznLGCGcvr+h4gPO9vlxveaSfkazkroFiiSrVD4x3uQs3GcL1vJCr2k7Qrl33tDdBBe2Szh+4r4LaPK3/pHRvLgqLQWcqqNkiWiLQWybIb64lpuGhgZ3CumITfpMVFashZsVMc/T7BsEaWFMb0Jc+Fny3Mli4a5cG8D/vDnIJ/VLTQyVgUg7yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuYg9Pnv5KMhyJqeQaXpeRNJWgPhZHBYCQbEkgtTHJY=;
 b=OIzOVD5FMYyG0d/TJ97zqddIh48RfkVHxZOGcMKQO3uvxm5dPD+Yj8Dx9Ew8cs/BwIxY+fRjjI4g79qIgRJcatr1l9U6H9hQHfbZ1BrERj8QgX5iFrQKgbxNjeh77hIVn2Z9+Ip4Mitq7az9sESrV9mCSCl2cd/J2qZGhVSBniI=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by PH0PR21MB1957.namprd21.prod.outlook.com (2603:10b6:510:14::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.6; Wed, 11 Oct
 2023 18:49:22 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::36cd:bd05:8d58:e8f0]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::36cd:bd05:8d58:e8f0%4]) with mapi id 15.20.6907.011; Wed, 11 Oct 2023
 18:49:22 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Yuchung Cheng <ycheng@google.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "kuniyu@amazon.com" <kuniyu@amazon.com>,
	"morleyd@google.com" <morleyd@google.com>, "mfreemon@cloudflare.com"
	<mfreemon@cloudflare.com>, "mubashirq@google.com" <mubashirq@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "weiwan@google.com"
	<weiwan@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next,v2] tcp: Set pingpong threshold via sysctl
Thread-Topic: [PATCH net-next,v2] tcp: Set pingpong threshold via sysctl
Thread-Index: AQHZ+69YvRb6AGIE90C77PuAO4ZvjLBDlskAgAADo4CAAAYaoIAAOcYAgAET4jA=
Date: Wed, 11 Oct 2023 18:49:22 +0000
Message-ID:
 <PH7PR21MB311616744CBE08375C52C2B8CACCA@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1696965810-8315-1-git-send-email-haiyangz@microsoft.com>
	<20231010151404.3f7faa87@hermes.local>
	<CAK6E8=c576Gt=G9Wdk0gQi=2EiL_=6g1SA=mJ3HhzPCsLRk9tw@mail.gmail.com>
	<PH7PR21MB3116FC142CAECCD5D981C530CACDA@PH7PR21MB3116.namprd21.prod.outlook.com>
 <20231010191542.3688fe24@hermes.local>
In-Reply-To: <20231010191542.3688fe24@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=193662aa-397a-42dd-9875-001f0ef29f20;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-11T18:43:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|PH0PR21MB1957:EE_
x-ms-office365-filtering-correlation-id: ed1c5b57-adbd-4879-141e-08dbca8ac8d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6BhBWY59oTV9Y1UjY5ZMY8u7VLhEMhM6e0To2TsmyUh4+dKVmbjTvz5AeiGqw+0qbfTOhX58dCzcz8CnXHzHonB9d85b36/ceXLXIGP5vzltVT4bJBP6q2SbG3J3YAvL3ONxY0dTG9Hg1RBhbXsfjrtbGHoPYY1ggzaeCWWshuNuEQuOz8j4vZU7XS4/gBJPqzz+YgZf3spv8j8dVN+NcioapWb6KqFNTI1/JFLrGt3SlO8aUg46zNHbyH3w0xrORZ6ftJKBRiGYp6Kpqcev7z/8V1utScIsbxYUj0OXBxbOk+ueJupIwDbQCjiqFcI8qWuBrkyXbjr7uegGR9DulurBu5UpvNgDnXBINzskzBMpQhuwH2Egfh6zEx9xkW1iUKSV5t86JH3ikpwT43iMdQKAVFmvvWVSrthLF8mSK05G84vnLWhWhOCm2Q+LHyVsKs38bo45JozZFSo9lylBB931O0xOL3IXnz1PoHp3XjuaFd6N0rMKmJnLMuwM3lAUy6Ut/QP8V6/N7Xbqrund1ZKT20KuGq5zIO4gPYj1HL9eFj92Bt86YnPUbcWg7mb8om6jwQSVVi6w9xmLtAWjOKYBsscajRIsLy2JA3QNKYpZP8XjoWvkiT9egkPySLHgwLUgdFX1HxnfT2lSHpYU+rnAGR6TyXxXEQlf8F48nXI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(38100700002)(38070700005)(2906002)(26005)(83380400001)(66556008)(66946007)(66446008)(66476007)(76116006)(316002)(6916009)(54906003)(55016003)(7696005)(86362001)(53546011)(6506007)(9686003)(33656002)(7416002)(122000001)(5660300002)(82960400001)(82950400001)(8990500004)(52536014)(71200400001)(4326008)(8676002)(8936002)(41300700001)(478600001)(64756008)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QR3NAmSIng1zGSH9MZWggRh5kkhz0au/0Js4edRe8jcIxkM+seD33NCwnZoO?=
 =?us-ascii?Q?DUlMK7kWsz/S4e3YI7LmXtiI+IS4TDqHN4Xqt1MpRMdAV40o8xfJ+cvlS4SM?=
 =?us-ascii?Q?uCnBNxZfUN7VqLTPbW4HoLsF84/faNNjeaelxdC9zB8Gkn5R4Cu3mCEb0MR9?=
 =?us-ascii?Q?7eNdsMk6uCcSTT986RgJCKj1qgXXI/EaRC0er5XQgDOG1uR5kaEhrK7IiZ24?=
 =?us-ascii?Q?TPwU3uACa/9daaqd9+yrvw7379cafIxCigtsuxTYD7K3ooeqnoVFa6gPXa61?=
 =?us-ascii?Q?a4fstW9h6xnMcc0NTb+1JtV74Pddso3B3je5NWAHf97xr9HgwgFgokxfDrPn?=
 =?us-ascii?Q?dpib129KICfra3lHVFxLamRHvex3oMpcRU/gFkBunftaND0d0Sz67ECw23FN?=
 =?us-ascii?Q?zAwxIGOuxoaJg9iX9HY4IJyVuvrFNUFo1EtCjLcCnvbrZfA5258e2Z9B6vSA?=
 =?us-ascii?Q?OiWrBkXER3zRGwTVJRKY5MjquRK07KDIyHTTydYip8AI/NvWIuUBxnVLtzip?=
 =?us-ascii?Q?SVqF5sUMtxg+LgP709Zw5YPo7k82SDYJirieYsrArUN51MSoN/M4eukw3NOQ?=
 =?us-ascii?Q?Byrjx1+aCpCFPT8Iti0hfCaATGKOGbypWnouhnQzwjRIZ57JLtXkEaf8Y1VE?=
 =?us-ascii?Q?tf1lD2VzB3mGuOu3SbQdLo/94Qf9ZEChqRmvplVZKY6u9Fzd5CRDKiAT6k8i?=
 =?us-ascii?Q?z8+tdqGPELHQK0u3c7f8z5fnDsot64OoC0KalqRMuU6+9SWo92xR0W/lqOGx?=
 =?us-ascii?Q?/GVjU0xeDjbkWUXs80znUpMqH33Der9uEjVon+/CacYUf8+q8BGBw/ugZGSz?=
 =?us-ascii?Q?7fWHGEGBvh22pPFn+fO4FKCN1QFqPv3ctskFCRpF36Ry9XZ7y4rZzBnVo4gx?=
 =?us-ascii?Q?X8XjKAn1DkWQCejaBgUSdv1USOtAM79ysBupvapfGTgdiiXE3o8snKL/oUi5?=
 =?us-ascii?Q?9zjz/pLLIXOIoLBfTy2ry0XW7xOyQUk+qrD98TLmXb6dCAeN8yY4OnnGg0+l?=
 =?us-ascii?Q?yobohulLIdk5pp2JPyvS+dcyByNGLlRkv/Bn0UkFObpGYkzBSH9DWKbNUS2J?=
 =?us-ascii?Q?9GelxES/IX2G+sqlzKNuob12puVfwtEtE32YH8OooPvLOP6PIflFPuIEnMdm?=
 =?us-ascii?Q?sPmwl6ThaTQ35p5HeZbOVFTuSnw1EehEOf/Yq3+TCAolu0thZAhCNNSc9DrI?=
 =?us-ascii?Q?AufX+O3eHS/FEAe0YGrlbgfSRVEQFoshM7hUEyrARc19yJ5JN2RRsKGt6+3v?=
 =?us-ascii?Q?eUXNmJJFcoI+55NjkRQj0QRutnDMXQ2mYVZWnOWWwrnsih7vxK1/885Y2B5F?=
 =?us-ascii?Q?GprXFKUuIt9flzNHVLIoAmOcz9UyhQFeyBxA4chROrOgGoRHV/n/rA5x9sdU?=
 =?us-ascii?Q?MrjyCGivXWkDhAkP2Eb+6/er2dbtYvF+okaZwvA9kFmYXbQFTKSuFGaV54Fh?=
 =?us-ascii?Q?hv0dgZdr9qbxrrjy7cWbUM23qap2C/yyGm8SYObWUjF0jjYWYMPTYsh5anAM?=
 =?us-ascii?Q?FwNT0mSDU0pU48bIOP9E0IMeqhIvKC/8VoZ7Voo1NPWnjHqJpTYqWm5R4+oI?=
 =?us-ascii?Q?JMwr6TkOA+dsfr/Xljx4XflbCUwzNf0DXnUEM9Sj?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3116.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1c5b57-adbd-4879-141e-08dbca8ac8d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 18:49:22.6359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z05jSk3ERl1WaYoYMm947lFvMAKPcAQW605AP+7jKMii5LmM27X8AQOa6/kKFa2wRuNfPuvgfelhzNMED+uPQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1957
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Tuesday, October 10, 2023 10:16 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Yuchung Cheng <ycheng@google.com>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; KY Srinivasan <kys@microsoft.com>;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; corbet@lwn.net; dsahern@kernel.org;
> ncardwell@google.com; kuniyu@amazon.com; morleyd@google.com;
> mfreemon@cloudflare.com; mubashirq@google.com; linux-
> doc@vger.kernel.org; weiwan@google.com; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net-next,v2] tcp: Set pingpong threshold via sysctl
>=20
> On Tue, 10 Oct 2023 22:59:49 +0000
> Haiyang Zhang <haiyangz@microsoft.com> wrote:
>=20
> > > > If this an application specific optimization, it should be in a soc=
ket option
> > > > rather than system wide via sysctl.
> > > Initially I had a similar comment but later decided a sysctl could
> > > still be useful if
> > > 1) the entire host (e.g. virtual machine) is dedicated to that applic=
ation
> > > 2) that application is difficult to change
> >
> > Yes, the customer actually wants a global setting. But as suggested by =
Neal,
> > I changed it to be per-namespace to match other TCP tunables.
>=20
> Like congestion control choice, it could be both a sysctl and a socket op=
tion.
> The reason is that delayed ack is already controlled by socket options.

I see. I am updating the doc and variable location for this sysctl tunable =
patch=20
as suggested by the reviewers, and will resubmit it.

I will also work on a separate patch for the setsockopt option.

Thanks,
- Haiyang


