Return-Path: <linux-hyperv+bounces-1484-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D6D842FB5
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jan 2024 23:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F511C23D61
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jan 2024 22:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051C178680;
	Tue, 30 Jan 2024 22:31:03 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11021006.outbound.protection.outlook.com [52.101.85.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A02131A94;
	Tue, 30 Jan 2024 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706653862; cv=fail; b=T1zEOgYvMumw9GH8owznqsEZ0OVkMcZtG54sBvu3708KN/wPt4SpjpIRBrY92apsKaHhn6D4NKEReTd99WOANG7nXiJySfh+sDTUsdc+mwAuyPbT7NvR3Nwa/40yUY3Ffh4ggbVmba2bi58wtr+coeGofqNT60fYJvREIqLj++o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706653862; c=relaxed/simple;
	bh=92oegkFNJ3gN0Dcdg9FFyvYccW23opPh7Wg7E1/mX34=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ijYEhwkDQe38CQ85Pt6wkT8ycUT49e2WgFTx4cADGrJT4lcWaG5MWFyoppah6GCu4EEP3vG4NbMPgxA0gKEiZTBa5Tfj4BgBz7Az2c3Sq7WUzZO1zHD2N1pMuhCn8188HXftXUqLqOUCvZXT8QNINbZ/ieRUVvdDrvfHrgEZjVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; arc=fail smtp.client-ip=52.101.85.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiwlMbyoUEvuo+ElIJ1D5lwrfGcm7GAi3NUeds+u/8c2++3RbQlbhlBwt7wx99tc2VCByOKOPN7aYK6zeuhmZMUZzHRU9UVdUgFrIb1s/n9O8fgOsq+dBCv3vSoF0c/pfUUqO7OjLnaGHAYD5pD3FtY41alRY2op7rvioAYbmvameA2aXVdvHRjIyijD7YStKbkGVFSDydT++Ytbw3Ua57ZwB0GgG3X98Sxbmyn5bzYcMPFsrCJI2ffue0F2k4xEZ83thQS9+QI+no9tc/JZyCp2NAqDoQIkI5Bu+2IPJCpnI3GnvkosVMZhRipr18Qt8R9QIu2psTOq7m4ezy+iqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIE/1/sVRaRGUnzkSJ/Lys9O1Z1YuSgXKxReNZWYQtE=;
 b=i6YQr55ODioifStDY3ERro3/tpHf7U7//nfSz+z738aMHItp2ptSUeVCKyRVcnLs5XftBhHdhuftk/tvdkqtTveHgzLRwjXFOaJOMgMQ0yUr7+fpvKb2YZkbljJ631nO0+bOStGWMXBXgPUSllbUMAicNYNY1NgySHh598dbBnQWniv1l6NShW6y0DG0qpPaHxjf6iVKu+5ujPfE9+Rce7MBOX1sveYiiMgEkogLYh+r1VSbr2b++NgJuaBj2WQGBdDbG2Hs7ED192ttsZHIUl4Gnrl4DVWyQk/MxhQOUFZ1pJZQ+53zmEen2u9w6VWpdi3o85fHzmi8UYKdd+fRiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by CY5PR21MB3684.namprd21.prod.outlook.com (2603:10b6:930:e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.6; Tue, 30 Jan
 2024 22:30:57 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::5d07:5716:225f:f717]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::5d07:5716:225f:f717%4]) with mapi id 15.20.7270.007; Tue, 30 Jan 2024
 22:30:57 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Shradha Gupta <shradhagupta@microsoft.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] hv_netvsc:Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Thread-Topic: [PATCH] hv_netvsc:Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Thread-Index: AQHaU0yZPmSUZITQDkq6vegFrHdKtbDyrTeggAA9BYCAAAXtwA==
Date: Tue, 30 Jan 2024 22:30:57 +0000
Message-ID:
 <SA1PR21MB1335E9C26AC6E3E1795F25E5BF7D2@SA1PR21MB1335.namprd21.prod.outlook.com>
References:
 <1706599135-12651-1-git-send-email-shradhagupta@linux.microsoft.com>
 <SA1PR21MB1335C5554F769454AAEDE1C8BF7D2@SA1PR21MB1335.namprd21.prod.outlook.com>
 <DS1PEPF00012A5F565EC849626E8F32EDB5CA7D2@DS1PEPF00012A5F.namprd21.prod.outlook.com>
In-Reply-To:
 <DS1PEPF00012A5F565EC849626E8F32EDB5CA7D2@DS1PEPF00012A5F.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=beac0a21-5dac-4c54-8eec-76ca3372c098;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-01-30T18:26:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|CY5PR21MB3684:EE_
x-ms-office365-filtering-correlation-id: 7d6a7e21-08d0-415e-7304-08dc21e320ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rRbR2Xl+h79HYkYtcYyrHYVMfC0upCEFzNyBaG+IGEx+WzO6YbWf9eJ6OoC5F6L5bYHPgGDrzNDR4m0oaKkNgxn+SLNv19khuSoRaiMGEWAQggMO6/8B9WJtL84+pW80b849uq3uBj07V6car65fjyYkeG8CK1XaULxycRQyrimVdPQNcKPg+K8hIeDgKDBlQF52Y3KmqUCqZK9nfaft27iszKaC54R+pjQMN3Ri+GUjY8B3WdYm3OiVAYb3KNZADOjZSRoQegCis177z8SuCDrYajy1KcI8sjC34N+bGit2kZbDl+AiHI6yPVZPV4EHU2w4w1qyCvz3CUhF7TZN05aHl4xEqBJ/KDyyLZV425nFTP3u1AIVtWwXkdEPTVjrWzBEAH5C5s3zKvOclmUS67Sva8K4t1Ws6KS8N64WQL0If/Si/VKVYAOXYTi6xDwbHzc3JMhK9qMtDrajWSMcY3FjM4WsA8YkxZjLfN3h1sUd4gctA8R8rFRcij1ER3zXmLDdMVaRxyo8XF+V6EsPZLfpLRVMszd4A7OzpmEnhmhNc73XsVuFSOD+qqljZ80IL6uQSXemuhE3cWE13sNOCF0TOT0QG4sJ46qZKddFwb22//vOmotVZmRAc5SbtAyDBFaM4Y9eXvIxqtULrG+Csg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(26005)(55016003)(41300700001)(921011)(38070700009)(71200400001)(8990500004)(478600001)(10290500003)(7696005)(9686003)(6506007)(83380400001)(38100700002)(82950400001)(82960400001)(122000001)(86362001)(66556008)(33656002)(5660300002)(64756008)(66946007)(66476007)(76116006)(54906003)(66446008)(2906002)(316002)(110136005)(7416002)(8936002)(8676002)(52536014)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4kQAMlWfS/Vey8VYOnCjGlAzSym58CrsckhZNQ0BZ5Of3JkVaOlI2+8q3npK?=
 =?us-ascii?Q?9VgS2DtLFjWrAjZ8yfwdQuXBGq2tr9/eyMfm8D7VIG06LPGWZyZBji3qjyxG?=
 =?us-ascii?Q?t4r9OtTl64QtD374foyhQiK+LTnWLeGFDfYIbvzGYncoKUHTeHeq+HGvWBto?=
 =?us-ascii?Q?JLVfv2dH3fsXLPHy/0GflwVCOlrqqNCxkhKtD1VDPVUfLprAgnHMlnZCdZ2I?=
 =?us-ascii?Q?ugcVsXyrdFeJTUTVIyomD9KMHv3gUkFQUafE5N3aYojQPet6Lzc59suVv+sD?=
 =?us-ascii?Q?vVFUHzfMxwmKsO9fgaoKAe/wxUulKIbcmKFi4sKNSJmZ0loYVnA6AEsNi+Gf?=
 =?us-ascii?Q?T5KtQhYCerg7XKyIuIqOv/WJcPtu/7KPVKcmQlhWOhwXDv/41JjikQyZWl8h?=
 =?us-ascii?Q?be0s/X928HFUYCAI40rL88jxFJDTb31Lr9GVCimNJpt1DmmKvHAqkaTKD0ii?=
 =?us-ascii?Q?eGjyWlnvJcBcXW5ghqwVIlhEECKyHKswo4Z3PNbqTGSyEwlpx74FJqnOOjha?=
 =?us-ascii?Q?5J6SESEmGw24VupvvhgYtJhVkLvjx8X2BxK7NtWhYbcKzeO8JWfuYlOKC8B4?=
 =?us-ascii?Q?ghu0MTyuVAjtl/Wdurw9FCXA9uLVuCMxkNydqWPWVGnS+KqETjweJWY1wIL+?=
 =?us-ascii?Q?6sEPhkhio7i8oix4KeH+UUUa4Do5TnullcmQ0gNgJzSlTQUqwejcXwvdRdS5?=
 =?us-ascii?Q?WnEtWFSl8PZSmJwoC2DA6+uYPHMmsrRQXQzXAtfaMpeqOEXHLRJf4np2lxZO?=
 =?us-ascii?Q?g1Xd6ve8y7Htsce+3zZE+lmaPgTzF25zNKo/Iz3+wDlImcvEL5Tp8JiTSEI8?=
 =?us-ascii?Q?d4Q8xduwNihvx0ursqWT0AOsYu0pGzzNfnuPo9F6W36pIish9ww0aRMTYBmi?=
 =?us-ascii?Q?JoImsv7JkG80BXpxw+tm9czL6cgi2DLio+ptLAkyoXYM/AXtdqeJ5liIBOLe?=
 =?us-ascii?Q?47JVkrapcZyf7tb8gBM5t4LAtJbVePVbay4443umR865HFLktYwbR/NvQkjj?=
 =?us-ascii?Q?pF9zIzt7rdu1nwWya1QlGfH510E7M8gLXfk+jc+lf10embmLiZozxpbHrEOy?=
 =?us-ascii?Q?A/xCBoq08JOt5K+ud/NsSeL7hScuAZ0VwMzOmBQoyIK/U2+aIEu/ovgEQNyT?=
 =?us-ascii?Q?oBzZulZNg/JBt2qizJTkVxYfqU8bVDqtTw47b8B6ulYYlppVDBTY7ljdrY8B?=
 =?us-ascii?Q?YE0V35wpoimANynhE8/oGnbtI5dcGhTPLEeHhl1ai4IJlwyAe+QVcFVXKvx8?=
 =?us-ascii?Q?t2dGrFBDKdYxZ3O9aNtU9r+rTtmJUvu52MZ0LpSe26tuLB9cgUSyOGXh7mYI?=
 =?us-ascii?Q?nWZo/q3FFKLrtVhyMEHu1e72dfVvGudzAXcLcXp3dXC1GsMfNnaEsMcz8/v3?=
 =?us-ascii?Q?AeEcXhe4/sY7jJn4f6nbABLA7DJJUOC/92ZdIsc0s78GIIfALRcB7BkxdczU?=
 =?us-ascii?Q?waTX2x9IBKpSYNGnFXNN87dd6AyXczzgh0Kcot2u6XNKlfwgVtx/CEF9iQKL?=
 =?us-ascii?Q?5Y4hA1frpRG9q+0Cp6vP73g6s8MnReTmDvogtESmrtrTc82g2fWI+9WZUbcT?=
 =?us-ascii?Q?QWGRj9vjZFkdUCjaisw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6a7e21-08d0-415e-7304-08dc21e320ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 22:30:57.3031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ABp9nRjv17ZIxt6mPtOqwrsz1/Lva5lmj0zozxAaanSFveBNfxcTCTuEMkns9wfopU6yU/MY2tlnSXn8LB21qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3684

> From: Haiyang Zhang <haiyangz@microsoft.com>
> Sent: Tuesday, January 30, 2024 2:05 PM
> [...]
> > > @@ -2205,8 +2209,11 @@ static int netvsc_vf_join(struct net_device
> > > *vf_netdev,
> > >  			   ndev->name, ret);
> > >  		goto upper_link_failed;
> > >  	}
> > > -
> > > -	schedule_delayed_work(&ndev_ctx->vf_takeover,
> > > VF_TAKEOVER_INT);
> > > +	/* If this registration is called from probe context vf_takeover
> > > +	 * is taken care of later in probe itself.
> > I suspect "later in probe itself" is not accurate.
> > If 'context' is VF_REG_IN_PROBE, I suppose what happens here is:
> > after netvsc_probe() finishes, the netvsc interface becomes available,
> > so the user space will ifup it, and netvsc_open() will UP the VF
> > interface,
> > and netvsc_netdev_event() is called for the VF with event =3D=3D
> > NETDEV_POST_INIT (?) and NETDEV_CHANGE, and the data path is
> > switched to the VF.
>=20
> In register_netdevice(), NETDEV_POST_INIT is earlier than
> NETDEV_REGISTER.
> This case: netvsc_open >> dev_open(vf) >> NETDEV_UP >>
>  netvsc_vf_changed(event_dev, event);

I see. So there should be no issue here. Thanks for the clarification!

> > If my understanding is correct, I think in the case of 'context' =3D=3D
> > VF_REG_IN_PROBE, I suspect the "Align MTU of VF with master"
> > and the "sync address list from ndev to VF" in __netvsc_vf_setup() are
> > omitted? If so, should this be fixed? e.g. Not sure if the below is an
> > issue or not:
> > 1) a VF is bound to a NetVSC interface, and a user sets the MTUs to 102=
4.
> > 2) rmmod hv_netvsc
> > 3) modprobe hv_netvsc
> > 4) the netvsc interface uses MTU=3D1500 (the default), and the VF still
> > uses 1024.
>=20
> __netvsc_vf_setup() is skipped from the netvsc_register_vf >>
> netvsc_vf_join(),
> but called from netvsc_probe(), so the VF mtu is sync-ed to 1500.
> I verified mtu sync in test.
You're correct. Sorry, I didn't notice that in the patch __netvsc_vf_setup(=
)
now is also called from netvsc_probe().

