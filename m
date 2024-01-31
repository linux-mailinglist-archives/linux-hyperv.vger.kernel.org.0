Return-Path: <linux-hyperv+bounces-1489-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B88298444BC
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jan 2024 17:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4172899E0
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jan 2024 16:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E0C12BEB0;
	Wed, 31 Jan 2024 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CT8Dxppy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2123.outbound.protection.outlook.com [40.107.243.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9769312BE8D;
	Wed, 31 Jan 2024 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719578; cv=fail; b=kfpxSD2+KsKVjVPd0cSvBpMN7zTAvn5IGKLz6TAJnyot0TYqiELLCHVcieW5XHb9jGz7V21gCtg8VinRqzlDkFwa8AT595ZygLXvCHeulLciIeP0fYfE4jkDA3bKLLRdt7QfGSz3TmS8rnq6YGFKT2k53BsJHYrt2c5m4xWg8Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719578; c=relaxed/simple;
	bh=bZAIexGT0QAgo4i5H3tBbspaRo4Nj4Qf24z1dC4E4R4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qwUEy6YhwaklhzuD6Ro+nsxOqDBa6GVp2/vB2Ss6qi5sXzZuI35/Z17YFPAv5iVubkepT2aEgqsUglEl7BTNxbLhNf7hxIdIzsB2Z8m9tvXac+Kv9iQiy0nwNAbTm8WaVsPzAKdbBzqT84fSAuSm7PQCdKPImLV7KAM6XP/DN7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=CT8Dxppy; arc=fail smtp.client-ip=40.107.243.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lu6P9WCt9qieBo5hLL3mC/YuGCmZ9Cx3jVwQZmurS/fwEY9rGya/WmBh555dk1AfiQ98dlb6cvyhfkEAkptiDmo2r/vUXyRcI+XEbJRT1wwOJE7J5OrftCW5ObjpEWGJgsrxJi7cLZUD7swLqUvNEFi+cYZfNVmzUbZj1RCpTYY3Wi1o7QhB6Zv29vE7t4qSb2iTSwpqXHM4ltE3hbLPu7IVQKxzGQdJBYuGefa6/4Iiu2/qcc+DSyUDS9R7GwXnzbvtBPr1aPPvFulImJkD0nNuBQINvEDt0kIQYYYUEeYzkCvVU6dtgj9BH/pahherGCDSHA6ZOgHBnPScvhf6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiuB8AhCAUEnI22Avq2/9zfXo6sutDSdbO6Wc5sBkM0=;
 b=AB27MW1zxUR6HpL+bPcz4OdP6cWCf2CLyInQ+sY401ceb0dLK9FDyYakdmhERKQNv1376vQx41gepnM97G2AYGfUetDIAiIIWSte/v9ud5k0+0UaS3lDHhd1ztvdeyJgo8p9fG1h3oP0B44QLDq3q4yIXpe6EG0sAj/56bP/K3QEVRA1hnEPLJGLEB23guk6qBVO+PwrYlQ/U3IMAOiF7xDDOHgHL5uBaiseObfOc3SoGNIf97TXAX8A42JWAOmxu+L5RgRqcSECLzCP4s5UDa7evCOe82lyi03fNYMeJHKG0hgufbCH/mq67xdB/Siadyp3Bcq+kaZ4OA+jI6ljnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiuB8AhCAUEnI22Avq2/9zfXo6sutDSdbO6Wc5sBkM0=;
 b=CT8DxppyZyWXtS8v9UbNXec9J+hxXVczDPugRymHu9w9d8P+HXU9FKSK/c8O+S6PgNkP2eeDyslLDcb/hixKZ3XO+okmTG1eeLgwzDrq9jSb1iLoL9pCPk8LBnVwnwtoFd7JzDDUYCgqE0sj2KjUfMnCXWQTGHjC9nlTelzxq3E=
Received: from DS1PEPF00012A5F.namprd21.prod.outlook.com
 (2603:10b6:2c:400:0:3:0:10) by DM4PR21MB3272.namprd21.prod.outlook.com
 (2603:10b6:8:68::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.9; Wed, 31 Jan
 2024 16:46:13 +0000
Received: from DS1PEPF00012A5F.namprd21.prod.outlook.com
 ([fe80::ff76:81ea:f8d6:45]) by DS1PEPF00012A5F.namprd21.prod.outlook.com
 ([fe80::ff76:81ea:f8d6:45%8]) with mapi id 15.20.7249.015; Wed, 31 Jan 2024
 16:46:06 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>, Dexuan Cui
	<decui@microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Wojciech Drewek
	<wojciech.drewek@intel.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Shradha Gupta <shradhagupta@microsoft.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] hv_netvsc:Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Thread-Topic: [PATCH] hv_netvsc:Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Thread-Index: AQHaU0yZNOZ7/lEXVUScWvjgIg8G/LDyyvGAgADDxwCAAI9LcA==
Date: Wed, 31 Jan 2024 16:46:06 +0000
Message-ID:
 <DS1PEPF00012A5FD2F8DBDCA1A0A58C6AC6CA7C2@DS1PEPF00012A5F.namprd21.prod.outlook.com>
References:
 <1706599135-12651-1-git-send-email-shradhagupta@linux.microsoft.com>
 <SA1PR21MB1335C5554F769454AAEDE1C8BF7D2@SA1PR21MB1335.namprd21.prod.outlook.com>
 <20240131075404.GA18190@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20240131075404.GA18190@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=94a4fd25-9eef-4088-8818-4ef9b583d8ec;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-01-31T16:26:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PEPF00012A5F:EE_|DM4PR21MB3272:EE_
x-ms-office365-filtering-correlation-id: 66e5cea3-883e-4c3c-4020-08dc227c1ec2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NctUCgyiMzlNUMdMETXEMZLB9lE8ZwQN4yZ+yT8U0vuEEhVEAqAB4VdWPo7bha23ddSWUmm8H78C8Cm80I4s5nSpV14CwJDY9iFVWVYrUREc+pXchQSlU09m1LKQObsavIxQ2BZGvwK+dDntxNaG6JVJAndRTBv8wjWyf4Hum2yaKubNmOQ1G8XHnkPLinJGZfeBqHRsAfkleUSh7Uuavywm+3mvgQ8lyoMi3CCYWuR/kRyFtrV09xyMos6bAFcDqFEoBjRawV9+U2BAvn3nM6eojv5yTbFSVXpkFhSf1RGSwuQZb8iNiUXlYjBU6X+vA78Cs/S60dfcoquAULtZq6CoUJGECtGl+LryZbr13jad+cfv1TSAuRyeGpYamvnOR5epMpzXyCkZw4/dV9rnuGspdaBzYKBvLr9iSQ9k4CDgBqJz7Gsi5TAXcFeinGkn3fx/ljK6VnRa2m+wTvvWu01hmuPg75j1cV2WDn4+djjSQiGKraGv1S5+qFyL/YCM7kpjHR3XfXCN4ia8Gxz1rcj/CvjsbSKsjXa1lfWgh+ioC6/4y51tTpy0MKs2kY4JB4l1Z4A8+8IlYJkeRKhQ0jta5ltHz3x8g1T2/AYQ+M0yBl0GwdUtmzUeVkRAvXLa
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PEPF00012A5F.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(366004)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38100700002)(55016003)(9686003)(52536014)(5660300002)(33656002)(7416002)(7696005)(6506007)(83380400001)(53546011)(71200400001)(26005)(122000001)(82950400001)(82960400001)(478600001)(66446008)(64756008)(10290500003)(76116006)(86362001)(6636002)(316002)(54906003)(4326008)(8936002)(8676002)(8990500004)(38070700009)(66556008)(66476007)(110136005)(66946007)(2906002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Magro8IAKvjL1QfSuwzNEhJO/6SrchiTvypp5k46i5+5C99tm7gDD4LB2P9H?=
 =?us-ascii?Q?YZtcL1dAvLJ5Npxiqv6+JMqpbtAGDM32N4vfgsknJHmTOMVOEhKLD2AUTEPO?=
 =?us-ascii?Q?e2mjnzPNFNz28s42wgkNNO4gTo1Jvv2LjA51KdRdOhzr4cXIEl/l3Rx2jbIF?=
 =?us-ascii?Q?mG6Wy8RNAgvLnTwdxc7DUImcJdRCMxssPj4G7ReXV9uRFBoUF+cvpokK5WYn?=
 =?us-ascii?Q?+poH03zUwHc8WRm5h3IVFpvo+8AYVOvKdylH7AzZ4IzfDuTL9uaNOtFqyucM?=
 =?us-ascii?Q?AqJEvj46wmnZ9NOSlh+jySYT/vp8ca+gGvLrPrh77RVlEQVigcr779qVpt1W?=
 =?us-ascii?Q?hzEmBwYMG3KR4f6/eIUw7wtkC/QEXiO0Ddsy4P9eL9Rj0xE+kmPQwNpcXA/7?=
 =?us-ascii?Q?rXw4S3QJj4VqqvkJKr8N7Ml0FHcBp6YtomwIXD1maP5+dRY74NlzaQOOoKWE?=
 =?us-ascii?Q?L0bd/Iuy9UL8ewW1Yh8v8iIgBurK2Tyw26XVXUjJHYq7Fi0vcfhhW9k1xr1x?=
 =?us-ascii?Q?ZnS5lQh1T3tEb8aovYn2q19Mz6vhvXvFDABtIuSsRSyyxr21lPWqDuI54lEX?=
 =?us-ascii?Q?EQxhhivT4aZMyoRMHbdV8Y8W2K5dJCRpE17B25D9Kx77lM6zPPJIGtyJmyoT?=
 =?us-ascii?Q?XnsOnsoiJ5Jeva4iYR+fsuhiCxvuma1jfX24wdNcNCVOg+LvmYyqlGi+P5Ix?=
 =?us-ascii?Q?A3MrsWgde28Gw2WkByg5V3QVXrIJce8HSI1q0HnAYsg+Izm6Q6g7ZS3oPAXw?=
 =?us-ascii?Q?GAHCOAgjaS7JFbg4gEwKgF/lWnzTq7IaFCt44bzrZBd9X2dwk5fvWw3TVFum?=
 =?us-ascii?Q?4DXWpPk8OE1dPrRIxtEF7tdl8Sz8AnM9KOBK5qmQz/cjFPsfxgejW8w3plRv?=
 =?us-ascii?Q?oXjhwKIxe9NbKYPCkaZeXQintdrmM/gM89eiarXn5Klzu09deq4ebOfB/3y6?=
 =?us-ascii?Q?brCDHKDdILiI+i1TbHlNNXz/rNfpNhEGIYR1U05d4ZlehheA8GIEHXhymRXd?=
 =?us-ascii?Q?CusY6S5d8n3JpGnJsWBrAgzjSX5QvaB0ZzWEYL5FQaQK/cM9mFMooAy/BHHE?=
 =?us-ascii?Q?v8y+IZ7ZzuoDqbILwndafecVVWi8LDQrjWLPb2pbZl5CujNUIUO/OCWHpI8+?=
 =?us-ascii?Q?TJ/gYwOnxxoOv4wEg+pX5SC5Kxazabfkr/PTMA2z139USiReC6y0lQmnVSHy?=
 =?us-ascii?Q?LA6jyqB1U0796cOFA+TZafA+JjrR3d/HeI5zoXZ0dG6l6NmYsbCXZuo0IiBp?=
 =?us-ascii?Q?6JYRWXMSwbrgNU6lrqYblyqBBVViIiiC4aYY17BKZe391SbF6J5K+DEg9Oce?=
 =?us-ascii?Q?rF5nFKgkgigNdrGeFGjc03qmkFZjK6P0+qkhPvbxLP84YWkL3yFPeTScFjWl?=
 =?us-ascii?Q?CRmwoBPrXGdE75+8Gu3m5oXib4OG6phaJuAJVvahoBlym0fvpFDykvZ3RQBi?=
 =?us-ascii?Q?DKd52wkHFPo6B9mS3eNOJVbf2dMY15UTrRIYxySObwh36ZeVB0EkqUebG/MQ?=
 =?us-ascii?Q?Nz+uBXbBvkBDKPo3XKOyxi8GkjnodDFHVcwQBKv+kTuhEWjfVuQpf99sebuo?=
 =?us-ascii?Q?psCtyLjXQUlM1UfSq4zjiR8Z+5NtRHQsaQ35St+z?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00012A5F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e5cea3-883e-4c3c-4020-08dc227c1ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 16:46:06.6588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZ9Ka7EBWEHc36Yt/okfilKKEz2jCMiicnQH01M1ZFX6+JdWIeqho+5RSpOv6wf8oDfhxs8sFIaDqhkHWyOwOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3272



> -----Original Message-----
> From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Sent: Wednesday, January 31, 2024 2:54 AM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Wojciech Drewek
> <wojciech.drewek@intel.com>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Shradha Gupta
> <shradhagupta@microsoft.com>; stable@vger.kernel.org
> Subject: Re: [PATCH] hv_netvsc:Register VF in netvsc_probe if
> NET_DEVICE_REGISTER missed
>=20
> On Tue, Jan 30, 2024 at 08:13:21PM +0000, Dexuan Cui wrote:
> > > From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > > Sent: Monday, January 29, 2024 11:19 PM
> > >  [...]
> > > If hv_netvsc driver is removed and reloaded, the NET_DEVICE_REGISTER
> >
> > s/removed/unloaded/
> > unloaded looks more accurate to me :-)
> >
> > > [...]
> > > Tested-on: Ubuntu22
> > > Testcases: LISA testsuites
> > > 	   verify_reload_hyperv_modules, perf_tcp_ntttcp_sriov
> > IMO the 3 lines can be removed: this bug is not specific to Ubuntu, and
> the
> > test case names don't provide extra value to help understand the issue
> > here and they might cause more questions unnecessarily, e.g. what's
> LISA,
> > what exactly do the test cases do.
> >
> > > +/* Macros to define the context of vf registration */
> > > +#define VF_REG_IN_PROBE		1
> > > +#define VF_REG_IN_RECV_CBACK	2
> >
> > I think VF_REG_IN_NOTIFIER is a better name?
> > RECV_CBALL looks inaccurate to me.
> >
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
> interface,
> > and netvsc_netdev_event() is called for the VF with event =3D=3D
> > NETDEV_POST_INIT (?) and NETDEV_CHANGE, and the data path is
> > switched to the VF.
> >
> > If my understanding is correct, I think in the case of 'context' =3D=3D
> > VF_REG_IN_PROBE, I suspect the "Align MTU of VF with master"
> > and the "sync address list from ndev to VF" in __netvsc_vf_setup() are
> > omitted? If so, should this be fixed? e.g. Not sure if the below is an
> issue or not:
> > 1) a VF is bound to a NetVSC interface, and a user sets the MTUs to
> 1024.
> > 2) rmmod hv_netvsc
> > 3) modprobe hv_netvsc
> > 4) the netvsc interface uses MTU=3D1500 (the default), and the VF still
> uses 1024.
> >
> > > @@ -2597,6 +2604,34 @@ static int netvsc_probe(struct hv_device *dev,
> > >  	}
> > >
> > >  	list_add(&net_device_ctx->list, &netvsc_dev_list);
> > > +
> > > +	/* When the hv_netvsc driver is removed and readded, the
> >
> > s/removed and readded/unloaded and reloaded/
> >
> > > +	 * NET_DEVICE_REGISTER for the vf device is replayed before
> > > probe
> > > +	 * is complete. This is because register_netdevice_notifier() gets
> > > +	 * registered before vmbus_driver_register() so that callback func
> > > +	 * is set before probe and we don't miss events like
> > > NETDEV_POST_INIT
> > > +	 * So, in this section we try to register each matching
> >
> > Looks like there are spaces at the end of the line. We can move up a
> few words
> > from the next line :-)
> >
> > s/each matching/the matching/
> > A NetVSC interface has only 1 matching VF device.
> >
> > > +	 * vf device that is present as a netdevice, knowing that it's
> register
> >
> > s/it's/its/
> >
> > > +	 * call is not processed in the netvsc_netdev_notifier(as probing
> is
> > > +	 * progress and get_netvsc_byslot fails).
> > > +	 */
> > > +	for_each_netdev(dev_net(net), vf_netdev) {
> > > +		if (vf_netdev->netdev_ops =3D=3D &device_ops)
> > > +			continue;
> > > +
> > > +		if (vf_netdev->type !=3D ARPHRD_ETHER)
> > > +			continue;
> > > +
> > > +		if (is_vlan_dev(vf_netdev))
> > > +			continue;
> > > +
> > > +		if (netif_is_bond_master(vf_netdev))
> > > +			continue;
> >
> > The code above is duplicated from netvsc_netdev_event().
> > Can we add a new helper function is_matching_vf() to avoid the
> duplication?
> Sure, I will do that. Thanks
> >
> > > +		netvsc_prepare_bonding(vf_netdev);
> > > +		netvsc_register_vf(vf_netdev, VF_REG_IN_PROBE);
> > > +		__netvsc_vf_setup(net, vf_netdev);
> >
> > add a "break;' ?
> With MANA devices and multiport support there, the individual ports are
> also net_devices.
> Wouldn't this be needed for such scenario(where we have multiple mana
> port net devices) to
> register them all?

Each device has separate probe() call, so only one VF will match in one=20
netvsc_probe().

netvsc_prepare_bonding() &  netvsc_register_vf() have=20
get_netvsc_byslot(vf_netdev), but __netvsc_vf_setup() doesn't have. So,
in case of multi-Vfs, this code will run "this" netvsc NIC with multiple VF=
s by=20
__netvsc_vf_setup() which isn't correct.

You need to add the following lines before netvsc_prepare_bonding(vf_netdev=
)
in netvsc_probe() to skip non-matching VFs:

if (net !=3D get_netvsc_byslot(vf_netdev))
	continue;

Thanks,
- Haiyang

