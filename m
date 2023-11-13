Return-Path: <linux-hyperv+bounces-893-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140477EA0AE
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Nov 2023 16:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ABCFB208D5
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Nov 2023 15:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B0121A09;
	Mon, 13 Nov 2023 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="InED4dKF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95940219FB;
	Mon, 13 Nov 2023 15:55:13 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020003.outbound.protection.outlook.com [52.101.61.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B615D52;
	Mon, 13 Nov 2023 07:55:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ml6dNREu3CdIQEQyc+hmkz/8eBkR65bAUuJRLzcteEj3cPsRsiG4YvO2yjWirojL+aeBxiwSTOHHIPRUTI3X9Yzz0NcFf/EMNCFknF/hDMm+BCEHFhZsKolTNAttyh3FZaIs2TmCW96n5QblmVPlSfSaxkRM3dYbtfVm9M2acEn9S7533Sy939CAT47H++Gtarbf3xjRFpQJPosGgSd8DMs8FQO7uchlVKZkAops9OxKTc23KMuKW6/4myKg+Bl4QZnZHEThwLuZ57Fi/pyW0rERyawyJt2MUYOkiPGmWW6jshyYuXjrYwUrpVq9qqwEcFCb2aHFp5pBs9V4HAYsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfiWG5ACVV9KBCXe7Cify/3qOIddnIhIlpkIMAfDVqY=;
 b=oHsqshGW1z6IW9V4hCGIPMYUCE2jZyb4mQQU27ZxKrxs1jlalLX7sPDwnVNL6hiEy4yWH1JZNHR3nSQtWDVl3xm2ghjJ/eULQENlJ+ZkmlcRLRx9ZLHZegLTvH5lhFru8VGJfsPNrKIjCS2q1/MgZn+edlG7B8wdonuvkppBCdGbAlQGOYdFv861KjMzArbRhscBG2hX/+K77UffXD2OwE+VH7GJFBBYxSuLw3flPPUuilvDhIkflGpgmrOFWFKHHI2D/NAUt1kuL9FBwDkMD0JlMixzGXTj9vStx2Obz8nZM+dN2QVN0rvGiUAuI0fp7prOen/TMx8B1U9btu4lXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfiWG5ACVV9KBCXe7Cify/3qOIddnIhIlpkIMAfDVqY=;
 b=InED4dKF+qzxsPytGlxJ2AMsJNcFR4ZdBam+w/quVJTCAYpVK4f2hCXlu0WuCK70EUFHhNigVKUPs2lIAlOoNUGMiuJa+iyvD8i2G26zeY6qPTbozSiSxp2yJ4cuiBfA98r2g4+syd0RZ/SayRgNCmL/QDkqix+q1+7PTUTNFAU=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by SJ1PR21MB3579.namprd21.prod.outlook.com (2603:10b6:a03:451::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.3; Mon, 13 Nov
 2023 15:55:08 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::4cdf:6519:4a36:698b]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::4cdf:6519:4a36:698b%7]) with mapi id 15.20.7025.003; Mon, 13 Nov 2023
 15:55:08 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Simon Horman <horms@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net,v4, 2/3] hv_netvsc: Fix race of
 register_netdevice_notifier and VF register
Thread-Topic: [PATCH net,v4, 2/3] hv_netvsc: Fix race of
 register_netdevice_notifier and VF register
Thread-Index: AQHaE+O38w7LvfyPp0q+k3AsaX62SbB2cPqAgAH6bAA=
Date: Mon, 13 Nov 2023 15:55:08 +0000
Message-ID:
 <PH7PR21MB31169E29DF8600F857CC141ACAB3A@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1699627140-28003-1-git-send-email-haiyangz@microsoft.com>
 <1699627140-28003-3-git-send-email-haiyangz@microsoft.com>
 <20231112094115.GE705326@kernel.org>
In-Reply-To: <20231112094115.GE705326@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1def63a8-9389-4bd1-9e6e-e5bbd7969247;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-11-13T15:53:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|SJ1PR21MB3579:EE_
x-ms-office365-filtering-correlation-id: 90d82748-3030-4c85-6883-08dbe460e94b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LGb7OLN6Cea95Jr+798/N6/+9oAMSBFPkF8hIsZ9X98aAuL86zm2yQTXdRWu0jd94DdXT3ECbOMLvAsdYTQWLXW3i6KF5+u8oZyHrLZu1L7LxC+gKn1Srb/WlQdMnqp5ddIRTwYGttVJAuOIGPNDLLkThyRXUwJtZb9nQ0RLbEsIrRYoVUamBTWdQuqxCAj7znh2AUes5NBRRpZ62pBLGRsYYB85/uKpANke+xBcQTf8kDQ9eNOKfH7NIVQyBySQkXuU42vgOlykPneu/G5UeSFU3UCbq7I0jmioVzNk9DGhao63uSWwKJvhKmOhdnVHtekM+la07t36pOd6Rl/RMFTxM/Cn1ECBl/VFf4FVOCVxIFnLDitv2DBJ1dRSxFZL9lX3LW1z/oO+OGL7u6u/tYQcfKO/3r9Ud8d1CZi4lOt+X7Ga7lFLRJd0EKnuu8eDuk54EXDIvvlvQaqkzNyEWGm+OB+He4EeKfm6ECQoSSWjdizY7ZAF/2I7FXqKcIkjmmWLcFq9kIdXFK84v8UkIgUGx0CnxcEL/H7xMz4n26lLNKhKFlL30/NHdF1WI7wPb/OV7nHCA6AWSy4t+gT6rVQ067XGXJc1kofQ831QoDpanppF2Qem2rQq7FbeaP1c8gby37W/VgaQYAdtUDWV5SrgD0L3VWRQNG9l83GG7ww=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(55016003)(26005)(122000001)(33656002)(38070700009)(86362001)(82960400001)(82950400001)(38100700002)(83380400001)(52536014)(5660300002)(7416002)(53546011)(7696005)(6506007)(10290500003)(71200400001)(9686003)(4326008)(8936002)(8676002)(76116006)(54906003)(66556008)(66476007)(66446008)(66946007)(64756008)(316002)(6916009)(41300700001)(8990500004)(2906002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wfxygEO9qGT1HssFRUvY239tvftzeVbR2p/+sRbg/lwY60jkFb4mLPYeu5cn?=
 =?us-ascii?Q?YXhlh2m2sddfM4/h0+Y+VRJUkArqS6Lsj7sUe25M6jEmC67y4Tsatx1V5rvR?=
 =?us-ascii?Q?i7QtMWJplu/x5LHriwP2DiDiE4SQanTFUySPXU/QUrxXqyZ18LaaGFGxOXJ9?=
 =?us-ascii?Q?Fqab4ia61HJ2LdqlFkPa+n5p94voWpBF6P4ETNrF6yUGxxshAjDZeui97yO6?=
 =?us-ascii?Q?fyskxJ7nSLivFdYc0vl7a17BJTuYgnqqlMSEdMnjVtFkq7oqJgDS+glw21aj?=
 =?us-ascii?Q?LkZUnmhEPDTnLt/BO1RbdWa6J9OUb+nP/P4uYjDgL2c2lS7YPEDxR6GxcFQK?=
 =?us-ascii?Q?tMdqzCrZsIAVEj2viU74naPMhhFLc8nkiEtSXMnJPlmKGREcVt5qoDfBP22+?=
 =?us-ascii?Q?6gekmx3KOd96S6mF/qVXPccordN6AH7r67/xiLrMOf9l3rJRp5U8pEDboReR?=
 =?us-ascii?Q?JKmkbaaSHYDB+QBHUcDm1aa79OizEiwpIxwIEVZbDPnsAqJFlHIOqEizIBjD?=
 =?us-ascii?Q?ILkzx4s137uzMxNdzYxpxEDABJoMVHSF4psXAAHN4v3n0bhXkcofxA5wwwTL?=
 =?us-ascii?Q?YfIBjWzLy08UBsKsdGyLmiS27VLeUW2Gmtl+BkAWYsB225/zgmo82V3/TphN?=
 =?us-ascii?Q?QpsJ76dkKJR+I6e5dXZ2mdLE1DK0RzxEamEztCN/zIuAT4g54pTsLjdqkv7P?=
 =?us-ascii?Q?Gn1Z3WafD8VCGdorTOkQO55piPcq7W9cc0pq3HXoLeor9Zr+InbtufauKWF6?=
 =?us-ascii?Q?3gCTDSeUNu7IO5ZLlWfcCSCmDtMMv+8/LwUKhjtunLeIb/tC0qUP46NN/En+?=
 =?us-ascii?Q?JxqwEgS+aqudikdaxhiTbLr7asckyNWc0rinZbpAMj/HgfVW+C+zT26GqJsA?=
 =?us-ascii?Q?d4aCoauj7+KCPBhK3l00J3DmkAlJvE0NqX3fpil1ESJvEs9jK0hzInWc3UJ7?=
 =?us-ascii?Q?OHWY98HIYVxtFGdeuhOBXoAjkeaM4vbTWp2RFPbPcmlS4n0HwrkDxRSN5nZj?=
 =?us-ascii?Q?EE9rsSfYO9MLDeKwxVfK4lraOcZ7NxqND5/5oEHpf/glmR35hQpvIpb0oMaK?=
 =?us-ascii?Q?GT/zTodrzK+lgJVJNTPDhoKjR3G747YtXvdsLAxglCQ93YRXQe7maiHgh/tI?=
 =?us-ascii?Q?eSlHbk5MJQqvpun26PqyK//djeZbU8uoPcX0nMH8DVQS9fRp1RY0PVvDcp7y?=
 =?us-ascii?Q?XQRXoeIX03IhMyrVNAzRCAfBlJts0FR5e02JxKpA2XRGKHeDVarsEgQzJgRh?=
 =?us-ascii?Q?Idrks+nNsT1A5gtrhzzOUi6tllJQdpVSuBx0NUYI0mKTHs0DEOPW0e/vMNPy?=
 =?us-ascii?Q?ax8ejCXtyNjkTwZ+GNFJkp218C6mbJW77ri1f/VCAjf/0hlib8t/PAa1Hcos?=
 =?us-ascii?Q?pZTIKmMOwwpXQ/KdiLRYGRdogH7NbjaIrdwGygsfbnl8TaIg0833QSbmutP8?=
 =?us-ascii?Q?7qZkDVKXAzW54cmnv5lSf4XJq52cd80sesbb3bvn+zRiguayidbkoFSKn4wA?=
 =?us-ascii?Q?zr5JUNDOa8FID1ymPBUZ7CathepZ+kr2pTW3TOG2O9v341jCxzhKYV6EUgsg?=
 =?us-ascii?Q?T3DlE8cAbybz/BTrrmE8+dnCOV/1LnQeZcaEs/zd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d82748-3030-4c85-6883-08dbe460e94b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 15:55:08.4592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I7VwCEP+YE1Q64vc02zuJDbWb37r6sDw3GBVc1BWSu9RPNbc47zixuut3ti/5YMUBvgK/c+iKDS8qLDgx5k09Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3579



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Sunday, November 12, 2023 4:41 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; davem@davemloft.net; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org
> Subject: Re: [PATCH net,v4, 2/3] hv_netvsc: Fix race of
> register_netdevice_notifier and VF register
>=20
> On Fri, Nov 10, 2023 at 06:38:59AM -0800, Haiyang Zhang wrote:
> > If VF NIC is registered earlier, NETDEV_REGISTER event is replayed,
> > but NETDEV_POST_INIT is not.
> >
> > Move register_netdevice_notifier() earlier, so the call back
> > function is set before probing.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: e04e7a7bbd4b ("hv_netvsc: Fix a deadlock by getting rtnl lock ea=
rlier
> in netvsc_probe()")
> > Reported-by: Dexuan Cui <decui@microsoft.com>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> >
> > ---
> > v3:
> >   Divide it into two patches, suggested by Jakub Kicinski.
> > v2:
> >   Fix rtnl_unlock() in error handling as found by Wojciech Drewek.
> > ---
> >  drivers/net/hyperv/netvsc_drv.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/hyperv/netvsc_drv.c
> b/drivers/net/hyperv/netvsc_drv.c
> > index 5e528a76f5f5..1d1491da303b 100644
> > --- a/drivers/net/hyperv/netvsc_drv.c
> > +++ b/drivers/net/hyperv/netvsc_drv.c
> > @@ -2793,11 +2793,14 @@ static int __init netvsc_drv_init(void)
> >  	}
> >  	netvsc_ring_bytes =3D ring_size * PAGE_SIZE;
> >
> > +	register_netdevice_notifier(&netvsc_netdev_notifier);
> > +
> >  	ret =3D vmbus_driver_register(&netvsc_drv);
> > -	if (ret)
> > +	if (ret) {
> > +		unregister_netdevice_notifier(&netvsc_netdev_notifier);
> >  		return ret;
> > +	}
> >
> > -	register_netdevice_notifier(&netvsc_netdev_notifier);
> >  	return 0;
> >  }
>=20
> Hi Haiyang Zhang,
>=20
> functionally this change looks good to me, thanks!
>=20
> I'm wondering if we could improve things slightly by using a more idiomat=
ic
> form for the error path. Something like the following (completely unteste=
d!).
>=20
> My reasoning is that this way things are less likely go to wrong if more
> error conditions are added to this function later.
>=20
> 	...
>=20
> 	register_netdevice_notifier(&netvsc_netdev_notifier);
>=20
> 	ret =3D vmbus_driver_register(&netvsc_drv);
> 	if (ret)
> 		goto err_unregister_netdevice_notifier;
>=20
> 	return 0;
>=20
> err_unregister_netdevice_notifier:
> 	unregister_netdevice_notifier(&netvsc_netdev_notifier);
> 	return ret;
> }

Thanks for the suggested idiomatic form. I will update it.

- Haiyang


