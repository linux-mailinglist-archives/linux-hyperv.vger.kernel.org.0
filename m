Return-Path: <linux-hyperv+bounces-832-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8037A7E7605
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 01:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD322815B1
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 00:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E58382;
	Fri, 10 Nov 2023 00:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gqjmquRw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6558836E;
	Fri, 10 Nov 2023 00:43:59 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020002.outbound.protection.outlook.com [52.101.56.2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03D0D5C;
	Thu,  9 Nov 2023 16:43:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0PK26wo+h/iNFJd74mPlj31RaylXEoeH0rfDf99JIF7Db4+43Xmw8czCPcR7NRig7yptWP1Th281I21MbWZRGem+hg2/c9YplSlzUlLs2ZxZmb5m0dhcQRFInXwiyK08CX3ORUUfO9BsQggwaCX3G4fxyPHH4Rvyb/RxxCU5h591QA0JL550lp1vZKOQlc39H8b9xqcqyOgB59SQX6I6jjjRHmGba88a0J84AgTHa/qMOOOajkrG6eYi4jAcuOWgelaj2QVefhR1BNDp/qloMgaTw8F2lrtu3W7q1H0vVsVZkeKbuxNweHux1Id4FJy6poEkkhALHtUeBzCMWAsTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uBPtvrgAZo9yJE+88ikCEMJjIaSK1DBwNU2G2Ebr9U=;
 b=jG28Zzdczpn4EaVtvA5m6vnN+nNIkHPfm+5MgPnMHXNlC1cKRUOU5jAMkzrEmOmFUGzNpzp7B2AKzhjdoCqj2Cy2rkHRi0kNQOwultht6aEuj3L936ElGQ2yjIYVX2+2IGi/F4NfqYT21bX8eKvSR1x/6glWYETJxHLeNSRvtvv2v+cMeWL5tYIGkNEuv1oD60uWluNL1TWIdPJZadI5G2BZ5IYqWQpGT3ikVVEcJYq0ZJTt2V/agWY3+3Evvjdm9NAd85IA2xF07neXmPhDn5B51XdsHxQfhmUpoUmgQgoXmUuBk2qKdKGaUbSYPAvKq9sFxpqJjm/CBZ6aDE5afg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uBPtvrgAZo9yJE+88ikCEMJjIaSK1DBwNU2G2Ebr9U=;
 b=gqjmquRwsXp+rWHlOAKHzOtQfXPDJqPPl5vzkHJT3FPjhFgetLpekVaAUDF1h3g9BQKpS2LQPDeOCYRrWfEVFZF5Af6xNWjCWRXzS57x+qx7wUPbQjb7JIUr+6kxugFuye3R7tuKp13XE5tHcCvVEUQYNfoENe6MkpxePtBfU0g=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by CY5PR21MB3468.namprd21.prod.outlook.com (2603:10b6:930:f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.8; Fri, 10 Nov
 2023 00:43:56 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::3c1:f565:8d:2954]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::3c1:f565:8d:2954%6]) with mapi id 15.20.7002.008; Fri, 10 Nov 2023
 00:43:55 +0000
From: Long Li <longli@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v4] hv_netvsc: Mark VF as slave before exposing
 it to user-mode
Thread-Topic: [PATCH net-next v4] hv_netvsc: Mark VF as slave before exposing
 it to user-mode
Thread-Index: AQHaEpbleF6H2i0O6EK5idFzE7vPXbBxP20AgAAPDIA=
Date: Fri, 10 Nov 2023 00:43:55 +0000
Message-ID:
 <PH7PR21MB3263EBCF9600EEBD6D962B6ECEAEA@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1699484212-24079-1-git-send-email-longli@linuxonhyperv.com>
 <20231108181318.5360af18@kernel.org>
In-Reply-To: <20231108181318.5360af18@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=345524a1-4083-4926-a93b-814f0709dff1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-11-09T03:07:08Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|CY5PR21MB3468:EE_
x-ms-office365-filtering-correlation-id: ea72eeed-db52-4fcb-2ac9-08dbe1861e5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ai7CNcYYGqlDM3V0BY95Nk1sVlIJMlit4Ual55hcdkCyeDd8Uw5ovzoJNacJMQ+sY5PTZnIvVPyZhnQm3Z9kA5mC5CBa7KNKikkeezPH9LoDRq28uX6cBQGRIPczUNd/exvLuRehUy0fJo/OFAW7HFpxCdZs6A5m2oI9RrUaqPYtzRs33Meo9xqnv78IRJ32kG9BNKWn0TDpV3jgSj8OFg6beeJDWeMtr7AG9+1NP/U3I+PnccaZRVjtxqyZdHFDmZHwlnwGTZotGyeB74Xx1s1OdKWObhHUi9RID6KSqsIKg/jc5P9MfpiymAOCMzyNx85wgQVcPZV5/Qd5hN/T0au8j7FmONn2B88GoU5vfMHnu+huT2DjyVVnwd9Xkwvh9bc2UeLoSRSJlyoOMHTxYu8CSHJOnAn+CTkOVHeGDx/PxZtETn93RUUjoMGYwyrNDzj0Gb/k91jV13WxPBX0x3xR0QZDKWEY1gDEbBstM8WNW38MGum1ljkK+MIS1BO40yktlRSTtv7ln5RpHKDUF+tWIdEAa1J00nCkwmg/073Q8yc2jdR+l9XP6TwW2bs20vYX1jpSDm6Q4+tUI6fjxDSA4sZT6ePQIIefDwGQVKptKIOXFreu2ZSaeVqO9YQEQ0RKLIDLEQrejNwFZjs8vQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(966005)(10290500003)(478600001)(71200400001)(6506007)(7696005)(38070700009)(82950400001)(86362001)(82960400001)(122000001)(41300700001)(316002)(66446008)(5660300002)(2906002)(66476007)(8990500004)(110136005)(54906003)(52536014)(66946007)(76116006)(66556008)(64756008)(8676002)(4326008)(33656002)(8936002)(38100700002)(9686003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5gLViMWWKaGX6F9OhhEcedArurgnFz4siLc9prsAKpeRuxH2sZBwQht6XJkn?=
 =?us-ascii?Q?xLqHymKEwh7lBUnu7s2amrr0d4moOljMNCw0EpIwyIkmtUzsmTsZgqRrnA1i?=
 =?us-ascii?Q?eQv0ELPj6/5rL2zHZ4Zz/RJ9xGd1+Rv2YSr3PJY/USCKBPZksJl3bbzs5bdX?=
 =?us-ascii?Q?ZXuoZc2u9AH+Z0t5BvjCtogPg97Y2OfBhIzAFvsXcG5ffFUOlJeNq1HVbNTF?=
 =?us-ascii?Q?+s0FFyoGbQoydoHA/1zq8JGDun8JgrWnUnszZMyx4/BJd7oU03EoVKCy88oW?=
 =?us-ascii?Q?+AdqUdXTxrhaGbqLeKmx2Od0j5W9upgBMix4w9N5zdZ4fNwl2tBPWFJtnEMw?=
 =?us-ascii?Q?6gCQew04n43Q1dKGf3ISOUaCodnfGrA4MM5YhbG/8Hy5q/lOcn3UaK8QvhEg?=
 =?us-ascii?Q?7wWM3OqqHwi3FSJGifUcjEhEIGvPnqo2prta0qs0O26/xi8Zir59Aq7OWY5E?=
 =?us-ascii?Q?pMgW3FpJTf6Mnqjj2vCC1rzonz9DfzhdpZ2k5QQjk5STc5EYWyV3xX7HU+vr?=
 =?us-ascii?Q?W7bmBJbR3eoBuqLMop3exuQiY1AqXcVpI1r9/vYB/K8uUbZyKiWRQaSl1yn2?=
 =?us-ascii?Q?lw+IPTKE+NoAs/PIAnwVMoneSQ33QzOqLmA4wpEklAjCKUCa8o6UCaETFUC1?=
 =?us-ascii?Q?G71xbzqvQ2xdKhPG+ioitEgIRVC7cGnkxIZ4xalSy46zH3KCq+n1I76+4BGl?=
 =?us-ascii?Q?CeD3ZHScZtJJEx56pSlUVRifsu51mj+h+0OQWJ7o+/zO9c71HGTQpO5z96kc?=
 =?us-ascii?Q?YtRBQh62KMeyZsQlOmKMKfWYbs6eV11kDMqFXXZOTqZ3kQH7yT9VGVPplcPd?=
 =?us-ascii?Q?iJe8OJYDtfq+fg4B1nfBLi2n1WtH/av4PoMsBwk/AP12qdwrypEjE6NfJ+5O?=
 =?us-ascii?Q?Z7QLLSFERLbs+Ci4SrN0jfLxLYlkySetUGboAnOdg7EbuCs8bDPzOVTqSivE?=
 =?us-ascii?Q?bW7C9JhtOR174LYmGbOVL7pYEIIgqsyBCJ3I+TSkoRs+yEi0OOVTTniqIhcn?=
 =?us-ascii?Q?W9FnGw71O8esBoI+N5MTf/xHplSyvzCnpeGcjJBnm+bcY0fURQwCjOMZL9lv?=
 =?us-ascii?Q?Ft+gRWmfIrir8rTHmu8glZ/yzzzWHfTXcTtzn3l58yiMTYdf8HJKavqlKPdf?=
 =?us-ascii?Q?T+hIi85il023H0dPZmqqnv2ftXtdf2Tviyj50r1HT/n5rY5LcNvYJ8Okxkn2?=
 =?us-ascii?Q?d29sexoCPfVSLrlz9XkgQY1sQrMsbO/Ai5rXyTDS9WBcYrTR2t7rTL74aCK7?=
 =?us-ascii?Q?BfLrbfDL2Zyj3CI+6woCmtD5whk6aOaKcPkeGc/9oI7h2g90aYGQ/CgD2q7k?=
 =?us-ascii?Q?2FxEOEfyQWXAyfUSdqyptz48E/Eahzto4px/FxTcMw2J/ZIRN3jGC/p1cVhg?=
 =?us-ascii?Q?egqCJPK6bxA/NH5jXdfHSR1UeAPbsABkZtL1lbUnINH6hNGuw6amDGPVxgkI?=
 =?us-ascii?Q?pfN7GwAgawBK4KQ4Cioa+a+ReAmF596X3xeCQv1qFtD8M+2oXGJ2GTx1mykX?=
 =?us-ascii?Q?IVgjHFROLAyERehyFVO+Ip25nPMIUiU6CZYwwTyONl+kQBThsN05Sslq0V2R?=
 =?us-ascii?Q?rhEQwSzvUNxHoU0Ld2sIg7XjuvhjWfafapWVwTMYW44McFfOh/ZYyak1HZKK?=
 =?us-ascii?Q?zzHVw0fBJTHfn8dyqxbuoLJBEYxSl69K4lRc3raNeW3i?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ea72eeed-db52-4fcb-2ac9-08dbe1861e5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 00:43:55.4248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pFSAQFrM0Qs5K4hbOHlVo0O8hzXWfDlhyA240Wqmz5ou97hUB98QqjdbQP05G2fuArPFC4pGgBq46QPyZlw8/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3468

> Subject: Re: [PATCH net-next v4] hv_netvsc: Mark VF as slave before expos=
ing it
> to user-mode
>=20
> On Wed,  8 Nov 2023 14:56:52 -0800 longli@linuxonhyperv.com wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > When a VF is being exposed form the kernel, it should be marked as "sla=
ve"
> > before exposing to the user-mode. The VF is not usable without netvsc
> > running as master. The user-mode should never see a VF without the "sla=
ve"
> flag.
> >
> > An example of a user-mode program depending on this flag is cloud-init
> > (https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
t
> > hub.com%2Fcanonical%2Fcloud-
> init%2Fblob%2F19.3%2Fcloudinit%2Fnet%2F__i
> >
> nit__.py&data=3D05%7C01%7Clongli%40microsoft.com%7C5fd05bce17d2471c74c
> 00
> >
> 8dbe0c9728b%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63835092
> 80435
> >
> 56592%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz
> IiLCJB
> >
> TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DzAL2hc8338ci8Tl5
> ktZjk
> > mWZKCKWMqa%2BGlsE7Ty9g00%3D&reserved=3D0)
>=20
> Quick grep for "flags", "priv" and "slave" doesn't show anything.
> Can you point me to the line of code?

I'm sorry, The URL I put in the commit should be: (I didn't realize the cha=
nge has not been merged, here is the buggy code)
https://github.com/canonical/cloud-init/blob/3f515387142007fe0992a45486a1e0=
49198a82f2/cloudinit/net/__init__.py#L1094

The code above needs to work with and without netvsc (the possible master d=
evice) present. It doesn't work properly with both conditions as of today. =
The patch series (with Haiyang's patches) fix that.

Because the code is specific to HyperV, we know we could be handling a VF N=
IC that is possibly a slave device, so checking on "slave" flag is a reliab=
le indication whether the VF should be handled.

The current workflow in the kernel looks like this:
1. VF net device is created and expose to user-mode
2. VF is bonded to NETVSC (if NETVSC exists on the system)

With the current kernel behavior, the user-mode can possibly see the VF aft=
er 1, and before 2 when VF is bonded. When this happens, the user-mode does=
n't know if the VF will be bonded in the future (it may never happen on sys=
tems without NETVSC). In this case, it doesn't know if it should configure =
the VF or not.

>=20
> > When scanning interfaces, it checks on if this interface has a master
> > to decide if it should be configured. There are other user-mode
> > programs perform similar checks.
> >
> > This commit moves the code of setting the slave flag to the time
> > before VF is exposed to user-mode.
>=20
> > Change since v3:
> > Change target to net-next.
>=20
> You don't consider this a fix? It seems like a race condition.

I will work with Haiyang to get patch sent in a series.

Thanks,

Long

