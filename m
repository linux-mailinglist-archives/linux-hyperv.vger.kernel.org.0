Return-Path: <linux-hyperv+bounces-506-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679467C4210
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Oct 2023 23:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0401F28184C
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Oct 2023 21:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F30225C6;
	Tue, 10 Oct 2023 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ew9MJ6TR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D124315A6;
	Tue, 10 Oct 2023 21:10:04 +0000 (UTC)
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021023.outbound.protection.outlook.com [52.101.62.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3DD94;
	Tue, 10 Oct 2023 14:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drDRjJWMecvm4GYdbfK4haX7RcUk6iIaPK+b1f9hhqaxSfJ6vJ/sjES4KL98V96ol7FOY0txQ7WBiLFSZXYFT6E/wlOxmB6k+Xx14MIVhNQDpBwh6a2Elz6ZdOV+FH5LZPmngFyhalPK3ts+E+SKysn3whpEfplc8+HFsrk2cQLdY8Xxgetk2kkh4/NXv1874qTbqO2U4rOsR35xm1o6Ry5gutr+yV6Z1ri63FOgvHZHta8W7BKfII5AWxK264pzD5CT9AKSJ9QDWxWrPv8lVZvqhCqVhYudNFDbXideM5PddyntDn8gCJjzBASSFc/7r6uIIr7DiKFln8tmHIJhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFnXmaGWIwNp80GJjrK51XLmbkcvl7FNw2OZjgs/3rU=;
 b=h7xdy63ML9pNYPJTQMOonyOyjuS/lfB+QPLnIe6fklwB1H7wO02Z/+25lpWOVXCK4/5Yce5+Yr86ZNzhh6gpriTH5AeZvTEKJHWPjfE66vpAOMx/KVML/5xeBq5jqEUHw3lPvWL6V+1peqWP5yMiXd9jhnZMfnRy0T6tC0lA7SKEA+/Mte9aOqExtFGrYBRNuM/XKZFM9PVwugPv59YFJmAksCzn7iqO89xluF31lPtHawJx8VDPFEkv/DgNUfn3bttk2G7N0GcKov3u5Vjlam6qaldukSLUazfCjj2gsuauni66LGwYRaSkmB5+95s/v3Q5akZcJmuLV1cAdcyPiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFnXmaGWIwNp80GJjrK51XLmbkcvl7FNw2OZjgs/3rU=;
 b=Ew9MJ6TRj4x4rfPqUv5uucEQGsY0aOXK6n07yT6JGKNqjIx22qacgZhXk3ZjiwtQqM+eujzOaNgt7bu1WKwHWAvMty7o4hEJ9o0cJUQbFx44vsywKpwueAmetgxtZqFnZnoguzaxn+4R+8BIw+emA50xMccT+eeVC6CzYycglEI=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by DM4PR21MB3609.namprd21.prod.outlook.com (2603:10b6:8:b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.5; Tue, 10 Oct
 2023 21:09:57 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::36cd:bd05:8d58:e8f0]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::36cd:bd05:8d58:e8f0%4]) with mapi id 15.20.6907.003; Tue, 10 Oct 2023
 21:09:57 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "davem@davemloft.net"
	<davem@davemloft.net>, "dsahern@kernel.org" <dsahern@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, KY Srinivasan <kys@microsoft.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mfreemon@cloudflare.com" <mfreemon@cloudflare.com>, "morleyd@google.com"
	<morleyd@google.com>, "mubashirq@google.com" <mubashirq@google.com>,
	"ncardwell@google.com" <ncardwell@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"weiwan@google.com" <weiwan@google.com>, "ycheng@google.com"
	<ycheng@google.com>
Subject: RE: [PATCH net-next,v2] tcp: Set pingpong threshold via sysctl
Thread-Topic: [PATCH net-next,v2] tcp: Set pingpong threshold via sysctl
Thread-Index: AQHZ+69YvRb6AGIE90C77PuAO4ZvjLBDdKcAgAAQAVA=
Date: Tue, 10 Oct 2023 21:09:57 +0000
Message-ID:
 <PH7PR21MB3116FD5BA40773BF4975E239CACDA@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1696965810-8315-1-git-send-email-haiyangz@microsoft.com>
 <20231010201154.31898-1-kuniyu@amazon.com>
In-Reply-To: <20231010201154.31898-1-kuniyu@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5f889c7c-a1c8-46eb-803e-432d85bf1bcd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-10T21:09:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|DM4PR21MB3609:EE_
x-ms-office365-filtering-correlation-id: 21854c06-d959-4fda-fb73-08dbc9d541c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 K5YuZxtSJyqo1F/kISY8BAuxHm1q3iioNYVieDvFo5F09w9+xgi+hfZefH2uKaG/ILKaLBHXn7bE1smgwxcfFJ5+3r3+Lf3VJexvv71GxvXYcYrFgg+aT+mfmGiHgVmbam+3icEuePo4D3yXGCosHcV9oxJY6OMTzwN6kJzcSZTM/dbGFcYTEDwRMsGLLis53QTbCADJowhF09WvJvMFQGm7ynEWjzxU8joNzyNKIntND+zWoHIQ5BhMygyTVk7SU6cpkUok9eRPJh+y9Y+r8jFPsDNuzMf3BMyaVdPI0gq5AuRtRrcoB/1hrLOaD9Ic0cAqrM8jgl4Ps0RdP1syal+pWTBqVikSH/S9xNg8KhfvTp39m+PsNot35gJs8LqOTKlqyOjgi+HQVtm/f+vWMlmkAyyNd23zJwuM4puwW82XIddxMMCrBxZJIOlkgByUYdoTbQlfwk8+T4O+dkwykpInwi8xoQIGNUQNTgwb9/hM51rb3u5Sbb5yThirFsG+NHIWsgxIfsQNbPlXnfchn8GNb7Zbu3pFUXrZPM6n2tyjrfIvUQV2s37iSgu3a+RGHRPp2UDKsdcIYI3Hb9VRQT00xG0GqjikrByVfRsXSr6sVQ+iPAe92oTWtNOZx9VnRNTeWWeLNFRxlNNGbZd0TeGthY9aDkfeIh0K2aQmeigwsN78CcbeNIk6tGbpXuji
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(38100700002)(66476007)(66446008)(76116006)(64756008)(66946007)(6916009)(316002)(66556008)(54906003)(8936002)(966005)(5660300002)(4326008)(122000001)(52536014)(8676002)(86362001)(2906002)(83380400001)(10290500003)(478600001)(71200400001)(7696005)(82960400001)(41300700001)(8990500004)(82950400001)(6506007)(7416002)(53546011)(55016003)(38070700005)(33656002)(9686003)(26005)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zL3cVCIhxG8OUDBWWEn5bFOTXF2OvJL1Rbs4Ku0KTzYt9qEvsWVuj01DZ6xw?=
 =?us-ascii?Q?FN7ipjMwhrc9K7s41G37zYiMweyFejVNiZy1TaGYpn7SE0Eqh/JDUZ/Y4KpP?=
 =?us-ascii?Q?x5u4qlF5dnX9cHp2B7FZp9P/F3okrItWeOM7W+O4Yw5jQyuofwfnL+XwXTZf?=
 =?us-ascii?Q?PS5DOa3Qz3OH8t/Grluf5eMdcWGAzScampQbdFJySBqvCVCvr4ghcindyrcy?=
 =?us-ascii?Q?JOfpDcv46lImbcF1QTF7YsCnxiJ4SebkG6FZa9zwucprD730amwSApo7KwTl?=
 =?us-ascii?Q?No5OgrpZAgds+zlrRsYya0S1gGMhpFyLYKJBo3AEYeNO7YCljEG5WMn2RA5j?=
 =?us-ascii?Q?+twdKWzks7zikRIpxF5cAz4MXvk6KQ+oziCOqR6vKtqdcwtHZfCkxP6WREez?=
 =?us-ascii?Q?EKnaGd17knzh+h9TmpQYWIt8MlgZMmAX3/pmg1VLBKloRltREB9KzaS0oi+6?=
 =?us-ascii?Q?0/6Vmk3woDViJbyuv1tDXZBoWkjfnNZBrskJgy4SwPbsD1VRkXsQ+TRbwfvk?=
 =?us-ascii?Q?docXrE6exbUuYgEuSdVuOSEEsA0fCZom/p4ggudd6CPKKXxWiiCcUcgk8N+J?=
 =?us-ascii?Q?LjcRgYuScdR9Zc94qPdxV+c39hCqcm9nb+acwQMUC+oaWn2S6UpfFs5Y1iVQ?=
 =?us-ascii?Q?2RT4Dle2yhtAyOCIfkL9zeOHynaI4jkrv36v2nRHZiOjLOTEfJJXf3kQL3a/?=
 =?us-ascii?Q?3PCaKIrBnRFH3eJxs7xJjZ3+yR9I06W4LfJmJC0kqmwIw8sGgkpoxolCn5ZC?=
 =?us-ascii?Q?qdVjF91dJAp7EQWatAd5YkulqUtxlDZbyrprQCyRPgoLca/M1AJ/HH8ApWUZ?=
 =?us-ascii?Q?oRwrJ2Bc34oU1aCKNS+b3xer0ZlDFaOMmNk5+8vcZR74Wjd0PZaeijblkl94?=
 =?us-ascii?Q?s9DUVon8+PmtUskzgdQ+0+gda0bgGHxzCNb7dqLeYVfVgOKJG02J1HTrz8PH?=
 =?us-ascii?Q?04wWMFKfbmT0gMt8OtU92X1G3A7oPfCPTWdHBEADePghV+rv/jVHkshea3QV?=
 =?us-ascii?Q?SivE9nWBJk1NShlXt5i+b8QF36afgYqTj4XHf1WzQJYwmxqSvVWKCqUPBEwr?=
 =?us-ascii?Q?Q+UMsqLOilXShw/Els86XZKcY3+MMwCQ8+yEzdrk6IO+cTLQFpxYiD13pChW?=
 =?us-ascii?Q?LVmsyH+k6QvV5yuMo8BYwcqJq7PfQ2W+KiP/1NiWoZtzBj3qorj3EZud5od6?=
 =?us-ascii?Q?EofvCzELqlivHAynD70gdVq7EpTLnF+TxRksx7wH+l+suASlHQwS+tcYUwI3?=
 =?us-ascii?Q?SByD16p3dsyM9No6hudeKlLA+GpbEnjAPrAxFSoE4063CDAPkzK98n5NZMGB?=
 =?us-ascii?Q?asd4+QNJqKPi1lBbD+s2AlY0LiBYwUFrC0ipaEhUiZHwFicQLY3yFmuZy+ZA?=
 =?us-ascii?Q?TzsNy/6jKnQbhzcP2gV8tYL2gkMFL5pIQm/zo5i9D7OA6Lq1UTnLfZ3eyuFg?=
 =?us-ascii?Q?bwxpX70yLHqwCmTR++HPEM6gt/TP9MGfDozfYeJnTQdfvREuv6OW3njkFhW/?=
 =?us-ascii?Q?qBqEQWMGRmnaOAuJZTtUe3byqHySvxFaK1O/CD0Kw64hvFV6d2zjAl6oQAx0?=
 =?us-ascii?Q?pHkvqdHnVU8K4ln8BN554/EySf9c1KUHjTJqOcFR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 21854c06-d959-4fda-fb73-08dbc9d541c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 21:09:57.1265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IOUQ92ovp9ZDzOe1MWxhvXtqGUXjcMxs9FUHkvDi3sE1PZQVJnqKSSru8CTCcp6tb9P8dhBnVJvQ8eOUFD0mGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3609
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Kuniyuki Iwashima <kuniyu@amazon.com>
> Sent: Tuesday, October 10, 2023 4:12 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: corbet@lwn.net; davem@davemloft.net; dsahern@kernel.org;
> edumazet@google.com; kuba@kernel.org; kuniyu@amazon.com; KY
> Srinivasan <kys@microsoft.com>; linux-doc@vger.kernel.org; linux-
> hyperv@vger.kernel.org; linux-kernel@vger.kernel.org;
> mfreemon@cloudflare.com; morleyd@google.com; mubashirq@google.com;
> ncardwell@google.com; netdev@vger.kernel.org; pabeni@redhat.com;
> weiwan@google.com; ycheng@google.com
> Subject: Re: [PATCH net-next,v2] tcp: Set pingpong threshold via sysctl
>=20
> [You don't often get email from kuniyu@amazon.com. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> From: Haiyang Zhang <haiyangz@microsoft.com>
> Date: Tue, 10 Oct 2023 12:23:30 -0700
> > TCP pingpong threshold is 1 by default. But some applications, like SQL=
 DB
> > may prefer a higher pingpong threshold to activate delayed acks in quic=
k
> > ack mode for better performance.
> >
> > The pingpong threshold and related code were changed to 3 in the year
> > 2019 in:
> >   commit 4a41f453bedf ("tcp: change pingpong threshold to 3")
> > And reverted to 1 in the year 2022 in:
> >   commit 4d8f24eeedc5 ("Revert "tcp: change pingpong threshold to 3"")
> >
> > There is no single value that fits all applications.
> > Add net.ipv4.tcp_pingpong_thresh sysctl tunable, so it can be tuned for
> > optimal performance based on the application needs.
> >
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> > v2: Make it per-namesapce setting, and other updates suggested by Neal
> Cardwell,
> > and Kuniyuki Iwashima.
> >
> > ---
> >  Documentation/networking/ip-sysctl.rst |  8 ++++++++
> >  include/net/inet_connection_sock.h     | 16 ++++++++++++----
> >  include/net/netns/ipv4.h               |  1 +
> >  net/ipv4/sysctl_net_ipv4.c             |  8 ++++++++
> >  net/ipv4/tcp_ipv4.c                    |  2 ++
> >  net/ipv4/tcp_output.c                  |  4 ++--
> >  6 files changed, 33 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/networking/ip-sysctl.rst
> b/Documentation/networking/ip-sysctl.rst
> > index 5bfa1837968c..c0308b65dc2f 100644
> > --- a/Documentation/networking/ip-sysctl.rst
> > +++ b/Documentation/networking/ip-sysctl.rst
> > @@ -1183,6 +1183,14 @@ tcp_plb_cong_thresh - INTEGER
> >
> >       Default: 128
> >
> > +tcp_pingpong_thresh - INTEGER
> > +     TCP pingpong threshold is 1 by default, but some application may =
need a
> > +     higher threshold for optimal performance.
> > +
> > +     Possible Values: 1 - 255
> > +
> > +     Default: 1
> > +
> >  UDP variables
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > diff --git a/include/net/inet_connection_sock.h
> b/include/net/inet_connection_sock.h
> > index 5d2fcc137b88..0182f27bce40 100644
> > --- a/include/net/inet_connection_sock.h
> > +++ b/include/net/inet_connection_sock.h
> > @@ -325,11 +325,10 @@ void inet_csk_update_fastreuse(struct
> inet_bind_bucket *tb,
> >
> >  struct dst_entry *inet_csk_update_pmtu(struct sock *sk, u32 mtu);
> >
> > -#define TCP_PINGPONG_THRESH  1
> > -
> >  static inline void inet_csk_enter_pingpong_mode(struct sock *sk)
> >  {
> > -     inet_csk(sk)->icsk_ack.pingpong =3D TCP_PINGPONG_THRESH;
> > +     inet_csk(sk)->icsk_ack.pingpong =3D
> > +             READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_pingpong_thresh);
> >  }
> >
> >  static inline void inet_csk_exit_pingpong_mode(struct sock *sk)
> > @@ -339,7 +338,16 @@ static inline void
> inet_csk_exit_pingpong_mode(struct sock *sk)
> >
> >  static inline bool inet_csk_in_pingpong_mode(struct sock *sk)
> >  {
> > -     return inet_csk(sk)->icsk_ack.pingpong >=3D TCP_PINGPONG_THRESH;
> > +     return inet_csk(sk)->icsk_ack.pingpong >=3D
> > +            READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_pingpong_thresh);
> > +}
> > +
> > +static inline void inet_csk_inc_pingpong_cnt(struct sock *sk)
> > +{
> > +     struct inet_connection_sock *icsk =3D inet_csk(sk);
> > +
> > +     if (icsk->icsk_ack.pingpong < U8_MAX)
> > +             icsk->icsk_ack.pingpong++;
> >  }
> >
> >  static inline bool inet_csk_has_ulp(const struct sock *sk)
> > diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
> > index d96d05b08819..9f1b3eb9473e 100644
> > --- a/include/net/netns/ipv4.h
> > +++ b/include/net/netns/ipv4.h
> > @@ -191,6 +191,7 @@ struct netns_ipv4 {
> >       u8 sysctl_tcp_plb_rehash_rounds;
> >       u8 sysctl_tcp_plb_suspend_rto_sec;
> >       int sysctl_tcp_plb_cong_thresh;
> > +     u8 sysctl_tcp_pingpong_thresh;
> >
> >       int sysctl_udp_wmem_min;
> >       int sysctl_udp_rmem_min;
>=20
> Maybe a hole after sysctl_tcp_backlog_ack_defer is a good place
> to put a new TCP knob.
>=20
> After sysctl_tcp_plb_cong_thresh, we can fill 1-byte hole but the
> cacheline seems cold for TCP.
>=20
> $ pahole -C netns_ipv4 vmlinux
> struct netns_ipv4 {
> ...
>         u8                         sysctl_tcp_backlog_ack_defer; /*   402=
     1 */
>=20
>         /* XXX 1 byte hole, try to pack */
>=20
>         int                        sysctl_tcp_reordering; /*   404     4 =
*/
> ...
>         int                        sysctl_tcp_plb_cong_thresh; /*   572  =
   4 */
>         /* --- cacheline 9 boundary (576 bytes) --- */
>         int                        sysctl_udp_wmem_min;  /*   576     4 *=
/
>         int                        sysctl_udp_rmem_min;  /*   580     4 *=
/
>         u8                         sysctl_fib_notify_on_flag_change; /*  =
 584     1 */
>         u8                         sysctl_tcp_syn_linear_timeouts; /*   5=
85     1 */
>         u8                         sysctl_igmp_llm_reports; /*   586     =
1 */
>=20
>         /* XXX 1 byte hole, try to pack */
> ...
>=20

Will do.

Thanks,
- Haiyang

