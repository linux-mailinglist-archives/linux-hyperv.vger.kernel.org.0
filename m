Return-Path: <linux-hyperv+bounces-3373-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F0C9DAE1D
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Nov 2024 20:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86129165E89
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Nov 2024 19:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE47B1FF611;
	Wed, 27 Nov 2024 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ae61GqQf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021091.outbound.protection.outlook.com [52.101.57.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D5382D66;
	Wed, 27 Nov 2024 19:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732736804; cv=fail; b=fLEt8IZpYV1PFDUV3qXBluCTSq1wXHl+brRSOGQi5BrEy6e2JffY7L4oHgUzJUA/33DTtxzd1ytM1yKLi/BBug5UpUhXzIBamYll/UnLm01IdSU3SenDC/hvhlYjjdMvNK+phcAmawD2Jo+WPk8sV2c0bCKPVgcuxAGKVbPG0JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732736804; c=relaxed/simple;
	bh=XwmsTAIpM2CBqTLqQkQCIXNG6xwsknLyTp1oU9ZNdsk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fkkmoDefOuzM+gkClMpdWjCzelKIoyUBQ34uOW3Wuk1+HD+SSsG3yyVNdA3FkI8piD3r/5D6dGWcOaF6z28XZ74EEuIpxCEs1P4BWg1TBL3sfMjfADl9bcit8wHgjCdk01i5Ud59v/T+v0vqltabsGnq/895nOfWBFVPk2xAXo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Ae61GqQf; arc=fail smtp.client-ip=52.101.57.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTVD4fBJA5/HnmPRXBDV3ePs849F2ouy2klIHXa+30fXRWkKvmDlSYkYYp/paPbShvDcdHHBAn25hbq97JIyUFw7EmtgrzD+fKgsh+sMWzb+kRSd95T3IXB5sO7MSRNEnmVKxJ2DAugpeqLODN2abEe6XR9kKrK1ajlkOXsD3Yl3J+j6DpwIiQiYpqcXmEhhRTAY/5gEaYjfNK3HTt6jCyNpZx99MmBhJV3eSM7qwob5VIbr0aXw/MbSsI/BUE7vyk7h+fCE2wQ1QpjjI7WNiI1l6AIabV+jSXkeghDYBh6Z19eQ/YYiXLx5iht/HnftPMvGoYPcWbRZlcirCn1/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xhq/aM3BstxwWx5WuCAysLQlSKruTwhI4voen1VfcJQ=;
 b=Cyphoqk/4vXu5F07sOakIhf9coclpqKRdw7VAvOLAXZAcmWLrfqYPiIhBAMbQS6y6VZVrz6aQzb+b98fU+Pyc4K7s9dSIXaU4czgh98NXKBh+4PR9SihtnFlwes/Ce755qUK+eCwh3ecym2s7aqNnqN5jGCHeXY3jWMtqOjgp5tfPeXZhibQSHRb23ZxKRDG/s8cwSCo7BK/wM2LE78AoAdeh5iPrnvWimvxkjT7ZmmPjy6M65Wdc1ckHNjkzMknMZW/qjtGccorY0mY5KG5QSxxVu9VcfmAtcMX3+PIhGAJV7OVdp1uww3w+OlLQmBo9LIvvChpMGyAnnTB6EJAxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xhq/aM3BstxwWx5WuCAysLQlSKruTwhI4voen1VfcJQ=;
 b=Ae61GqQfyeSzhaZpQ82mJLbOaoXwH+/mu/xt39z/rgu7llZ9QG+0HC/beGFZMpWvbI4EOsBZjEUYnVGW0rWSAJd6gqBTQG8m26GrSjK5XTHgtGu+UPabEPXbZPszlZTn31T++7GVp/GeJgLLmBN90ogp1aD/Pq3S9+VAlw0jW/U=
Received: from CH3PR21MB4398.namprd21.prod.outlook.com (2603:10b6:610:21b::6)
 by CH2PR21MB1416.namprd21.prod.outlook.com (2603:10b6:610:85::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.3; Wed, 27 Nov
 2024 19:46:40 +0000
Received: from CH3PR21MB4398.namprd21.prod.outlook.com
 ([fe80::d17f:89c7:62dd:247d]) by CH3PR21MB4398.namprd21.prod.outlook.com
 ([fe80::d17f:89c7:62dd:247d%4]) with mapi id 15.20.8230.000; Wed, 27 Nov 2024
 19:46:40 +0000
From: Long Li <longli@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Parav Pandit <parav@nvidia.com>
CC: Konstantin Taranov <kotaranov@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, Wei Hu <weh@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	linux-netdev <netdev@vger.kernel.org>, "open list:Hyper-V/Azure CORE AND
 DRIVERS" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct
 device into ib
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct
 device into ib
Thread-Index:
 AQHaxupwGAu99WXsuk6CZeFbpa7lGLHZiusAgAA3HoCAADQIAIDnyovQgAdWm4CAAEchAIADHbcw
Date: Wed, 27 Nov 2024 19:46:39 +0000
Message-ID:
 <CH3PR21MB4398E0C57E7B6BC73B1A8F04CE282@CH3PR21MB4398.namprd21.prod.outlook.com>
References: <1719311307-7920-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240626054748.GN29266@unreal>
 <PAXPR83MB0559F4678E73B0091A8ADFBBB4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240626121118.GP29266@unreal>
 <CH3PR21MB43989630F6CA822AF3DFB32CCE222@CH3PR21MB4398.namprd21.prod.outlook.com>
 <CY8PR12MB719506ED60DBD124D3784CB6DC2E2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20241125201036.GK160612@unreal>
In-Reply-To: <20241125201036.GK160612@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=05580c46-b5e5-40fa-bfd9-956e19cd3595;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-11-27T19:45:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR21MB4398:EE_|CH2PR21MB1416:EE_
x-ms-office365-filtering-correlation-id: ddfeeafc-a153-4dfb-39d5-08dd0f1c362e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?N/Z8ibbuA0OyNADzx5QMR1NPp4hmc8fjs+sosSLstT3hlzYHttM5TUikTfe1?=
 =?us-ascii?Q?ZRxb0cQLpNFMxSnEuQl4DyP6P+X9OGEIuQ/PVdRYuyDZN+86zhm6BVCZQ2pt?=
 =?us-ascii?Q?XLqeUMIrFEfUVynYQx4W/d5g1011PG8KfxZvfMQ+CQzdo0b2plUhrROb1Its?=
 =?us-ascii?Q?kNJI0goC5YVoUm+sCJ1FnqQimkt+pjOHGxmKoWq8oFbFNJYaNRlya5c9VA1F?=
 =?us-ascii?Q?j94neL0gwpQ3l21EI0ejckmZfe4i/ZO2s7jygWNYM52F85v9IsYt49h+K8Lz?=
 =?us-ascii?Q?Y9Cb1peOvkLXzYIo1JXrn0fJFj7vlihOv9KFi4PlgyyAw2JqmF45IC3bG2XQ?=
 =?us-ascii?Q?xrrkAFfEzorAVnCcVzfivgU5l9WkYNQDk62P1B92zaMXq6rBt6frPxSzfef/?=
 =?us-ascii?Q?dz+JP4E6IsvMMJyzRH7c9gkSSdXe+yHEZLl6zOPv8JdlI4q2zBrWpRyum1cJ?=
 =?us-ascii?Q?Gzkcw6PM6EJSrHr/ThmIYy0FeWLEGrowZgsmbPHpArn9Ot0VN8lZWel5XHP3?=
 =?us-ascii?Q?Q6PXxLLeYh0TFcEZMhncNvar9Ws4KjqYUN8RE4qzaIVKYqFmv1Fnt9FwEkQP?=
 =?us-ascii?Q?GMq+t3dpfpBO1EKvhWjRcxXZn9X/akX8jtKuDm49q2VrGdWZJI8p0/htshgF?=
 =?us-ascii?Q?Ax+xTgBBZc7XciZV0aUQEmbzz7jjMK2af3LrTL9VW/Rw+7Efk58t9RSv7suV?=
 =?us-ascii?Q?9u7ESbDlJRQQ+nqHRld+GCNLUVsgvWTntLdhnfB2K27SW1Zt5ehhlEed/S9S?=
 =?us-ascii?Q?D+qqt35Yg6aOMyfgKnbafJ9Ti4pWVeglH6g+mYKH5FL7cUcjL4ucI8395Wnd?=
 =?us-ascii?Q?Y+0JHxMs5NrUsdecpYzYufGge9/ToxyT/zb24JL4dIoZPXPpkRLEq1IMdt/I?=
 =?us-ascii?Q?Mra/h7PlAdk8nXy1H5JWyXPicHzNkKoHYD7yMw5YL049myDQTtr2lay3RXh1?=
 =?us-ascii?Q?X0AqZ91ZYa5U+DGjpBmjHDD2Jje//w9HTF7JO5nSxCXT8sJgwcGSeuEKKPA+?=
 =?us-ascii?Q?HNYoeaQt9Or0e6jZZ2rso2al/V5BlMJxVzjchxyNtCsEN4Phb/E88SkoB54y?=
 =?us-ascii?Q?jl0+NJ94dRKazV0MhmS3Lk9jb/wEsj9ysPTywLsdHKTG9QFllIWseqygdkQD?=
 =?us-ascii?Q?Wke5By/hLU6W6bL2/GHo8EtZVAzl/7WF6Tn4FtMNehVUoj2M9k6MKcU8uwl8?=
 =?us-ascii?Q?ZdyJ3oUbUjjpcl6zmbOPPu1Zqcvql/CDfZdo+oEOxE0i7jDazGAhYLYkGd8c?=
 =?us-ascii?Q?BbbqDzxiuXFP9ZMXNDH/bL9620/xmRI23hi7l7k68u6HPEUKqkh0aifNHLcW?=
 =?us-ascii?Q?XnD+z67n8J8xWWuWy2ToJltkCCS/g2E2kinYDXAe7gSiAg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR21MB4398.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZVeuBHvrEAADGPA13KecGXeAh1aFzhKJwZGmbHTIEvjlx1XtYyvuRlOh6K/m?=
 =?us-ascii?Q?DdgtaPoh7s5ZMojqcuYljnnf5yCCzK30QkPJnl48h8Xt9Jaf8la4zJprhDrP?=
 =?us-ascii?Q?eyg5+ZyE/mzHKgiejKifuVc98WsXZms27+1DnY7NLJ2C62TVIFrkZ6MEEESI?=
 =?us-ascii?Q?/waW4N6olqSLML+yREyJGlsst6zMfzeDW7y0pUZKkTzPlZ53Dd6xWDEp+MKt?=
 =?us-ascii?Q?BdYgQdQsXa8NJw0Jl1Wl3ZmITut4EavmDoDPi5P/NTQFxy0ECyjmtq8wjI7a?=
 =?us-ascii?Q?TDrXEwmdURxlqqi8C7XQbqoZ3lz05Sr3c5BH68bqXr2aPhT1ZzxG3y8vsJS+?=
 =?us-ascii?Q?U+OimDBPjwVJ+YFP1oFBDVMpo+RXfTAc13ISRFQ7JDCvSzPeodO1Db3XggII?=
 =?us-ascii?Q?97PPUeAkXtW1CwRacgrAZc3kpeH1qYHOfm6IbGr8CARD6hg/5q4KVZsFPQjg?=
 =?us-ascii?Q?dKyq4hTWO8S5Ej4JOlzoHTUg7dDe9qTpn93PN6bbtNDyMDP0j345fuOyqAHa?=
 =?us-ascii?Q?JUxOBIZG/oTOxIo/ebPoqhUL8z0xRBGwxdO04Y1Yxt0wLHhASJ5y6nOmSjt7?=
 =?us-ascii?Q?akmQxwW9EKt6DgKvfvpbOSH63KdqneTNTpJ5edP0nr0XO8/m180axcHHziCs?=
 =?us-ascii?Q?Jyb3teCVvShoaSmzbA2KkH8VL+5ebMZwgft2wxV1Iw4KzLLSprpyV0qR4YOS?=
 =?us-ascii?Q?CgGulMIulUJSAqkGxkQeNyWCizfv8O59D8Ch1QO4Sl7/JudnQxGsYvpIzfJC?=
 =?us-ascii?Q?m3Wc8EJRN6UL+uALnPZsWx6HeICjG3qTuLXhbrNj3aU5tKKHuE/mSIl2ZvSP?=
 =?us-ascii?Q?XFRnaYJuz7qKkW1dGXS8nbatwsa0efMlbujotz5vaOds/QEg8ngPI1uW/+m9?=
 =?us-ascii?Q?b9aJdzReLkzLKREwpGTqOE9dr9ovtTH+u2EIrPEGhPc/UEovH9Uq31JBu0qF?=
 =?us-ascii?Q?b3qvXEeh4sqBURDoin+i6hBbc0J2fRzefc5BxV/am3sR0rRbH+Oaovp0mSY7?=
 =?us-ascii?Q?Eozm6XlZ81h6gDMKijRcGLpZ9RodhDkb/fMgL6SRthgB5Umm7dREiaSwaDlU?=
 =?us-ascii?Q?1GbWK4RnqJabNOyX4nihtKLRDRoEEUvSB1f0cnUVtKQJD7AiyUaFw2Kqc4LT?=
 =?us-ascii?Q?S3uHilag2fVUf3bb9hUjVd1d6yRVlBSMNKzluyIa6jM/jnFmOtrEFprKd5YT?=
 =?us-ascii?Q?Y2PNFkcnEC13KbShQUHv3hhAH2qf4N+YHA/8w2QonnwRMqhMwDOJfgjLgHlp?=
 =?us-ascii?Q?f9kApHwHbGJ4eeGg0ftJEEx9yhWfWBzcFPyMh++uFD2zAjpDT2fWWTILpcYt?=
 =?us-ascii?Q?isq/2B0QX+F9d5wIhi9Zs4EU330C2jqKw1OuV8hgmoZKf8S/S5ZdrkbtqoFX?=
 =?us-ascii?Q?dRfPXxWWOxTKeONF7PWnjN8NWk5qv1oZWcJhJ82w8wvODE/2rg1ogkt+MmOp?=
 =?us-ascii?Q?7RPIImeRqJqiCd2T3jqhSIP3H5CbFwGMlVfWFRB5Pd1AXwuug3NbhkTj5qUa?=
 =?us-ascii?Q?iQWKQqY65/oUC6dUspLee1fu7gF+qxnZQDGHsRT0f9lS1rbqNgQ1thn2ZGQw?=
 =?us-ascii?Q?UxVI+SmWSzvY/Hd3dZfI/jE3VtM31+JKlQG0iwUAeRupH9GMIzK+KI0bY5q8?=
 =?us-ascii?Q?5PfjwHxzP+4LwP7WiC9k3SpW0ykdeTTdwuFh5173Bcnd?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH3PR21MB4398.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfeeafc-a153-4dfb-39d5-08dd0f1c362e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 19:46:39.8421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sW2gpOz6k+KaOy4OS5XWO9PdZ49kk/7+6riK63yl5u9k/TcSjufL42h94auY4oFKclfqcarszad4H01zevmnsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1416


> > > I think Konstantin's suggestion makes sense, how about we do this
> > > (don't need to define netdev_is_slave(dev)):
> > >
> > > --- a/drivers/infiniband/core/roce_gid_mgmt.c
> > > +++ b/drivers/infiniband/core/roce_gid_mgmt.c
> > > @@ -161,7 +161,7 @@ is_eth_port_of_netdev_filter(struct ib_device
> > > *ib_dev, u32 port,
> > >         res =3D ((rdma_is_upper_dev_rcu(rdma_ndev, cookie) &&
> > >                (is_eth_active_slave_of_bonding_rcu(rdma_ndev, real_de=
v) &
> > >                 REQUIRED_BOND_STATES)) ||
> > > -              real_dev =3D=3D rdma_ndev);
> > > +              (real_dev =3D=3D rdma_ndev &&
> > > + !netif_is_bond_slave(rdma_ndev)));
> > >
> > >         rcu_read_unlock();
> > >         return res;
> > >
> > >
> > > is_eth_port_of_netdev_filter() should not return true if this netdev
> > > is a bonded slave. In this case, only use the address of its bonded m=
aster.
> > >
> > Right. This change makes sense to me.
> > I don't have a setup presently to verify it to ensure I didn't miss a c=
orner case.
> > Leon,
> > Can you or others please test the regression once with the formal patch=
?
>=20
> Sure, once Long will send the patch, I'll make sure that it is tested.
>=20
> Thanks
>=20

I posted patches for discussion.
https://lore.kernel.org/linux-rdma/1732736619-19941-1-git-send-email-longli=
@linuxonhyperv.com/T/#t

Thank you,
Long


