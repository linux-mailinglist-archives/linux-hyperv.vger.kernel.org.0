Return-Path: <linux-hyperv+bounces-595-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D4E7D8543
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 16:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C1D1F21D46
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 14:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683F92EB05;
	Thu, 26 Oct 2023 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XIJTPl0c"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E7B1D52B;
	Thu, 26 Oct 2023 14:52:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2093.outbound.protection.outlook.com [40.107.220.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022BDB9;
	Thu, 26 Oct 2023 07:52:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4NjD2cuawqZFhdaImainGJ/923v9IR6Iu9Oy31zNFzmDg3ESx6nOWbs3lUJVKjpc8rHLjHk90C82tP6MxVk4bH5fTrwultVf84u4rJPmtKPJmhzkfhdXezEPWsdVZa9I30OqAOWdBPy+caI2LSGC81OxjL9t5SUHNcuMuZf9hOjNC+bBiD+7uhQbaZgDan72ytXzY8T9chtoJyOjsSL4SZ4SV4ueCCJSR9dDDCBlf13pc9Ne54TS/x9ZZ0gonnQsUd44xSL1uporWUiNbSm76PTj34CqP2ojjDXT3K4YUTy6q7PVXYYskZcLRll2qxE/0EFC2Z77kQzkQh0ny331A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWLOnAyVOoClued96GvAhsRAx0w/KyLakkq12rAVkEU=;
 b=hoqzrX1/nv73dCO0AmEOWxJr7t4k9+XRg52nnJHzncxKhlItP+JjvROdUSaoAZ3BXz2w4R+qnnxhfj3NN35eKRHiN80hq7HXA+Od3HM9qn+SrNO6gllYwxcLmFgflbYOM5OsH1e53Ksfn9BkFGVmX02UQgWLKBeJahK7FWniqNajik6dmzfjCL9k7NhggdtTPLOeRiHiUQqx/D9jxcnstL/EdZpcrOZ8r7LNhTUx/ysQP7t78zG79XJb6noxn92fhmW7nglER3Uu0Vc8XkkkKEvZnaMLTwAGQ+rskauRD/GijMx6r0daPsOv8BjB7QO9YRGr+g/s6vC2Rqy9JHm2hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWLOnAyVOoClued96GvAhsRAx0w/KyLakkq12rAVkEU=;
 b=XIJTPl0cvwsvJ9HAtPpeuOV1c/aa4NjaYtVCqnUGQYB/EsRE7ptqvDLymh5x6sFrJScsicMmWQQUble6pyvpFLPueHXojLWqx9Zsr42qmoX7zBiAFzMWightHMNCdKnMOqBaXJc1vjrj0ZXpoXeCdzCcqqjsBhySXF/Q9VEnHig=
Received: from BL1PR21MB3113.namprd21.prod.outlook.com (2603:10b6:208:391::14)
 by LV2PR21MB3061.namprd21.prod.outlook.com (2603:10b6:408:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.6; Thu, 26 Oct
 2023 14:52:09 +0000
Received: from BL1PR21MB3113.namprd21.prod.outlook.com
 ([fe80::f9fc:d69d:8f3e:a132]) by BL1PR21MB3113.namprd21.prod.outlook.com
 ([fe80::f9fc:d69d:8f3e:a132%3]) with mapi id 15.20.6954.005; Thu, 26 Oct 2023
 14:52:07 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Wojciech Drewek <wojciech.drewek@intel.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net] hv_netvsc: fix race of netvsc and VF
 register_netdevice
Thread-Topic: [PATCH net] hv_netvsc: fix race of netvsc and VF
 register_netdevice
Thread-Index: AQHaB4iZ4eB3Yz1VyUyB1g8GKVf8w7Bb5KsAgABD5tA=
Date: Thu, 26 Oct 2023 14:52:07 +0000
Message-ID:
 <BL1PR21MB3113F0E65A58AEB1E617C2C4CADDA@BL1PR21MB3113.namprd21.prod.outlook.com>
References: <1698268592-20373-1-git-send-email-haiyangz@microsoft.com>
 <99f1f2d1-8fb0-4e56-9820-86254ce8bd02@intel.com>
In-Reply-To: <99f1f2d1-8fb0-4e56-9820-86254ce8bd02@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=84bd0587-5e81-4dbe-9d62-5f08fd7461a5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-26T14:50:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR21MB3113:EE_|LV2PR21MB3061:EE_
x-ms-office365-filtering-correlation-id: 70613d90-e637-44b9-2089-08dbd6332079
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0LQdmeb7acOjrzLW7JF7gqAKQM2fuLbourRs5CAvp0g+7ndG9zBYnIvsE+Am3faLhU5YUOXUWYWaCR6W6cOlMvD7/6gXs2ck64Hk5qhRx0wC2vlH6SzsdrrHbcNBKrlV42QrMRfdYZVrM4BNDmB5EDTiMKq0EmRqMBYiQNaBlbIL8Lw1sGs5QSpJvBDDDpBtE+j2zcjC6CmydSHjwN/BfFHfhV/xfSs77m9fjqq08i/bHPSz1JOKE3Ub34lSoa/7ACvv+8Qc3F5BKqdmqXhWF2gSor8wQTlqXp1Ln/z9wYzqfUWqcUdVpINDO1KQeRLr4IUvA75vgv0ScgW1JN9lF5XWEm3b6fK9Utmr3slWYRyajEnidPBMnNWaCf2V7B5tzE2o6m48a9OnkJ/xXMwj8llWaC+ivlOo54ukbQWR+T9lcOR0vBJVPbW137i1wHKWHU3ejc67Fg0oDSkzXcH8lIGf5rQobIdTK0W32TORQJODQ/AKcJ+J2CtyUpoHkRnT1zZotEfkWjTA6woe93FHF20VOEyz5q8H55o85A+CWwYa8U/fmj0o9RMoGvbXzC3eBKoOl7XW9Ky9u2jPqmHT3KxEJ+icnquRRKE65yL7eDNpoj1JzswYKF1uJBrq+KUYzm8IBKwcbVs9K5n7cLAa3pX4Owk4BW0YHaDvQVvsIiI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR21MB3113.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(7416002)(5660300002)(55016003)(38100700002)(52536014)(316002)(66899024)(26005)(8936002)(82960400001)(82950400001)(41300700001)(4326008)(38070700009)(8676002)(83380400001)(66446008)(66476007)(76116006)(9686003)(64756008)(8990500004)(54906003)(66946007)(110136005)(10290500003)(7696005)(71200400001)(6506007)(53546011)(478600001)(66556008)(122000001)(86362001)(966005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?L+RSukdKoR7YBcF6+eljsLy+giwC9g5QH5ZktxlBlJGXdw2r4oWbPxY4m+kP?=
 =?us-ascii?Q?wgdWuzArp07zfXK/E6ggBGjNGkEFotY9Apr5VJLgXXiFCPmIgamhLMPYWmZX?=
 =?us-ascii?Q?lTWSA+cjBqMyyDhmbqbr4LGwP8MFhj7e8Q73QWHW3U53nUbxvcyvS0jfCY4x?=
 =?us-ascii?Q?3IOoeI5Q7zqJuw0Rl5utFCWECdlZFAFa4jv1GCw4T7qU4F/xBDVHmQtYSoan?=
 =?us-ascii?Q?46rEMGtjU7ijFOO3TBW49C//I1c4qsSXIXUYem2L9Har594aYk9kHU1Faj4z?=
 =?us-ascii?Q?Fp9hT2yRUI6WZFJzODMo3XlWvsRYLXl6R6LULw0U5mtzDjgBJJy1JJUnBDD5?=
 =?us-ascii?Q?RNpiVnjGMKKcyEU0P+uGDcZmQKWcVY/OYamf5YOSibaW4Gsm3xS5pPOvUhWF?=
 =?us-ascii?Q?yV41jijvRrRToO/vtmA6LoHGsHesRG/3BuqpLtve9JEnqpslhp80zvm+m4ui?=
 =?us-ascii?Q?Hk1fZjubJGJ8yoFZQi1z+W5FBHvMzeEnbcFWPOLhMYosULnEZSE81L2m6vkg?=
 =?us-ascii?Q?SrvKkOCrdrAoYW8RzM9GfsaJskVUA95NjicrXDGBVl6gYcW9RUOnSlT4ZvUS?=
 =?us-ascii?Q?ZqjrnnZ2HqoNZ8LocgQKmWub6Ka7/EcsEdVY9dfIebimu+F2QbwlttT3obfl?=
 =?us-ascii?Q?KMtwduvHZOAU9e4AXyhHuedDmV4H7uR53rl7TPyVERizWoToXKZUETN/0hML?=
 =?us-ascii?Q?ikP8rvNqu9ou5vMCBf/G+yxE26jevPRrc6ho1ORksIdDmi1rsqnvknm35SAS?=
 =?us-ascii?Q?wTnvDMSjDnFAueqgLRm76BJOvR07fl0GBeZeOfNxMgEn847UN+m5UGP3UhDg?=
 =?us-ascii?Q?SAT8hOXcaY1FrK9gzFlw2bG6RovbZwpNV7sbVwwrwrqv4jfI8My4/h3qyYMA?=
 =?us-ascii?Q?likfnM4RM0n6TEhv1jZM0K7xnRYXgBMoeQ4+owGVI2zvwhL/4trNWFJhkeRj?=
 =?us-ascii?Q?vo5A+UOR/6hNaxjZPbOPplFR9pvfBsYzCSR06l5GKbSsk4Krr+f6yVmuANjT?=
 =?us-ascii?Q?fvt3nvz5w4IUKxRrr1LTzIPy+obPj8GXTeNVKYBdRpHTlB2IAzjj/y0Y7kBw?=
 =?us-ascii?Q?W6phbOiArPpLTutNne0gs3vwGU8BQZNO4HiY84S3aJXhqIJK2lbnDMX1UUjZ?=
 =?us-ascii?Q?U+B6t9ytiasR5k5ZZXBQvZ4ygVyMPFgHV5hxwHob6n68zgLlsWKXv5UX+p74?=
 =?us-ascii?Q?pCfs1gwaVV2a7tjJx0k91+JGPlMXCB60p9SOewckKCSuOLTKIxkUgbPveuJC?=
 =?us-ascii?Q?KcS2943EoKFXi6jwnXR3fHK6knG37oKz6S/k+lpms8rF8XbbMqU/GahY2FdL?=
 =?us-ascii?Q?XTr0feX6okfIOyA97IHBNjVNwx7Lf4BKGGxlJM9po0Mh+ehEJau29PjvBdIg?=
 =?us-ascii?Q?wdkYssPtoaPiHY4/msPPAMW4b9wkYrymNTesQiMW1LRXiZ3pdQrrO+yYB1Mj?=
 =?us-ascii?Q?Dz4v/xhnVXPpzOtp93DPzDD4Uana97arnk6Jr+XEt1FZrQi/Vy24pne/Onbc?=
 =?us-ascii?Q?6zj3WPLLwO0qYk/fhf3PFOfG74Dy8txUvcpAFVzx3uQaybGZ4EuDMsCq56kv?=
 =?us-ascii?Q?0wo1pw62H8ML+PG/XwfVnEbV7S4P0y7w+SOrYH07?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL1PR21MB3113.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70613d90-e637-44b9-2089-08dbd6332079
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 14:52:07.9284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +xPttTAlQhCxGr4AwYhKTed6npyE76LZJIqGQXdFBO1A+FXfHO1I+JqGSMtMFO38ugVQYVR8mEArWuklvq6j+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3061



> -----Original Message-----
> From: Wojciech Drewek <wojciech.drewek@intel.com>
> Sent: Thursday, October 26, 2023 6:48 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org
> Cc: KY Srinivasan <kys@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; davem@davemloft.net; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org
> Subject: Re: [PATCH net] hv_netvsc: fix race of netvsc and VF
> register_netdevice
>=20
> [You don't often get email from wojciech.drewek@intel.com. Learn why this=
 is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> On 25.10.2023 23:16, Haiyang Zhang wrote:
> > The rtnl lock also needs to be held before rndis_filter_device_add()
> > which advertises nvsp_2_vsc_capability / sriov bit, and triggers
> > VF NIC offering and registering. If VF NIC finished register_netdev()
> > earlier it may cause name based config failure.
> >
> > To fix this issue, move the call to rtnl_lock() before
> > rndis_filter_device_add(), so VF will be registered later than netvsc
> > / synthetic NIC, and gets a name numbered (ethX) after netvsc.
> >
> > And, move register_netdevice_notifier() earlier, so the call back
> > function is set before probing.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: e04e7a7bbd4b ("hv_netvsc: Fix a deadlock by getting rtnl lock ea=
rlier
> in netvsc_probe()")
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> >
> > ---
> >  drivers/net/hyperv/netvsc_drv.c | 30 +++++++++++++++++++-----------
> >  1 file changed, 19 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/net/hyperv/netvsc_drv.c
> b/drivers/net/hyperv/netvsc_drv.c
> > index 3ba3c8fb28a5..feca1391f756 100644
> > --- a/drivers/net/hyperv/netvsc_drv.c
> > +++ b/drivers/net/hyperv/netvsc_drv.c
> > @@ -2531,15 +2531,6 @@ static int netvsc_probe(struct hv_device *dev,
> >               goto devinfo_failed;
> >       }
> >
> > -     nvdev =3D rndis_filter_device_add(dev, device_info);
> > -     if (IS_ERR(nvdev)) {
> > -             ret =3D PTR_ERR(nvdev);
> > -             netdev_err(net, "unable to add netvsc device (ret %d)\n",=
 ret);
> > -             goto rndis_failed;
> > -     }
> > -
> > -     eth_hw_addr_set(net, device_info->mac_adr);
> > -
> >       /* We must get rtnl lock before scheduling nvdev->subchan_work,
> >        * otherwise netvsc_subchan_work() can get rtnl lock first and wa=
it
> >        * all subchannels to show up, but that may not happen because
> > @@ -2547,9 +2538,23 @@ static int netvsc_probe(struct hv_device *dev,
> >        * -> ... -> device_add() -> ... -> __device_attach() can't get
> >        * the device lock, so all the subchannels can't be processed --
> >        * finally netvsc_subchan_work() hangs forever.
> > +      *
> > +      * The rtnl lock also needs to be held before rndis_filter_device=
_add()
> > +      * which advertises nvsp_2_vsc_capability / sriov bit, and trigge=
rs
> > +      * VF NIC offering and registering. If VF NIC finished register_n=
etdev()
> > +      * earlier it may cause name based config failure.
> >        */
> >       rtnl_lock();
> >
> > +     nvdev =3D rndis_filter_device_add(dev, device_info);
> > +     if (IS_ERR(nvdev)) {
> > +             ret =3D PTR_ERR(nvdev);
> > +             netdev_err(net, "unable to add netvsc device (ret %d)\n",=
 ret);
> > +             goto rndis_failed;
>=20
> In case of error rtnl won't be unlocked.

Good catch! Will correct this.=20

Thanks,
- Haiyang


