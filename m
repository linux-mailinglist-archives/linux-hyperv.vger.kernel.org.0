Return-Path: <linux-hyperv+bounces-4365-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06571A5A660
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 22:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44A697A42E9
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 21:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB071DD525;
	Mon, 10 Mar 2025 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bFeDZgSg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020095.outbound.protection.outlook.com [52.101.46.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34954437C;
	Mon, 10 Mar 2025 21:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741643172; cv=fail; b=q3/IBQO2aA6Gsy7XFY6aBDSEwukNdq3d7nxsss8rBzwLrToEJ/TODtwnz0o4iohh8eWhjphW/MT74nOsvZYIGHN9GTnUlIl5UQYuI1K9CPNmgnKzskIoTIaCx93K//B9DVpBiRkDLs2JYJd6NWkt28Yw/1Pv2Gdqj3ROdi+dCxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741643172; c=relaxed/simple;
	bh=L4/FNvQPbmam0DtLcG+1l2q0ipZmYZevBmctUk8M/pI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NVTHkITCw1/BegShXrDu8Qk+Gm0411RSPiAlKaOq/FMKoh5b+gF29erG17pl7OKm6u9MHU1IBsHgVwF+GOn8xGO4F0Zj9QvmvY+0w3Lw2JP5ti/CTmzAza/7roVK9ifbpr7eOOzF9zGXfBSW9NKCtIEqk/OUBNM4vMgRQcQSroA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=bFeDZgSg; arc=fail smtp.client-ip=52.101.46.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tO3Y2Lc0wNiSmh9Av0/5vrUeaN2qQrdwCs6tDSGSu6cEiPKICdEPOeqLvFfwOfaDCH5BS0j/6tI/wo7aQ5j8RZk3R1+pl7ZUYDcNYe+rVPWZcpCapWDj7FYgg8MLS8ZP78mIJD48+/glMyiIDuOnmP4xZP9P9wZ22o1DnZZUdbT7uiU/V6sAtGbRH6/YSnlkH7OgmV+7GY37q4B5zU5okB38W9Mu0SZcqey7Lmh5OAaptLLkXBG92M3DoAm04eGu6eEp+pMES7hXmmi02oY6Qs9C3wx2YcmXvEp+FiaCi6wwIOWBLX+lRahRjLY5g7B6K2YvZrqmJ/KL+fUhXQnIDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5Nwyqsxo6CFU+TjT3+7qx881vJnv9/4nOMnQWWg9p4=;
 b=AG4cWKJPMDRxyDdVn+rnuGHa4hsxJe2Xk9lU7TNNGlHHNqT+aWj6gJINeAtZqLAoE0mnIzYle9mST9eFG0Sa9VmDTRsN7KSv5Zd3jswaunKk2MPmAeegqVDWVWEq+acxyMyE2Mj6nllwY1UjkZokFLOd8RFuPuRuO8IBafxdQ6rSxVCP18Yq88lA4C6HIa+GMgC46Xpa5RyD+Mk1AQu9V4VV3owVqbwqxfbdgTBhTrOu+c7GhQ1IZutK5XQ2JKB92lEsBsSz0JkYngF1hZtKOk6tlSqOTrvo5ZQPhDc5JRerbiUdzSMOyDSkLWgv6viKhwhHce/z79QLFUAXsOnKaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5Nwyqsxo6CFU+TjT3+7qx881vJnv9/4nOMnQWWg9p4=;
 b=bFeDZgSgcXWRyfgP9wkOubZ4e8opI2Ji3H/Tkda6chGB6E4LQBXlxXqVEnxalNGszH8UPla/RbVWOfA1HqDf2v6bLJB6W2voSqbowZeprt+ve4veeCXafblB3Gq/SXAjyrKDO97ilDuHSHaDLbNkesK0zyb6STHZ+VM51sORE7Q=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4388.namprd21.prod.outlook.com (2603:10b6:806:422::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.21; Mon, 10 Mar
 2025 21:46:08 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8534.012; Mon, 10 Mar 2025
 21:46:08 +0000
From: Long Li <longli@microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>
CC: Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [patch rdma-next v5 2/2] RDMA/mana_ib: Handle net
 event for pointing to the current netdev
Thread-Topic: [EXTERNAL] Re: [patch rdma-next v5 2/2] RDMA/mana_ib: Handle net
 event for pointing to the current netdev
Thread-Index: AQHbjtGAHu5I1ObjAEGtSbYSnlR/rrNmhdBggAZnwsA=
Date: Mon, 10 Mar 2025 21:46:08 +0000
Message-ID:
 <SA6PR21MB42316CA1E7C6CF083A89ECE4CED62@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1741289079-18744-1-git-send-email-longli@linuxonhyperv.com>
 <1741289079-18744-2-git-send-email-longli@linuxonhyperv.com>
 <20250306195354.GG354403@ziepe.ca>
 <SA6PR21MB4231E9B17697BFE4857A7E55CECA2@SA6PR21MB4231.namprd21.prod.outlook.com>
In-Reply-To:
 <SA6PR21MB4231E9B17697BFE4857A7E55CECA2@SA6PR21MB4231.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d3c7ae03-0f2c-4013-b7e7-807bf0e3f508;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-06T19:55:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4388:EE_
x-ms-office365-filtering-correlation-id: 8f5cf251-7e4f-419d-ca60-08dd601cf7a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZBUrbtXhX1J+ZOcyJyeBpm98IPi7urgzhIgL/nZWH/2dgu03+fh9ECmFVLDm?=
 =?us-ascii?Q?pYMrSoqNvbbsNwxwMfPDBd/JnMRSW9dOQPLsqAOMHtVQPflBQIkfQ8swytav?=
 =?us-ascii?Q?8x+KUK4aCGV920esYQ0DF7gCO5qTrw4kpp8bnnA3XIWCYsdDy2PWl8owuB7r?=
 =?us-ascii?Q?P9j3Niawi5Y4WhXCs4ep5RuM68occWCBn5M/m10Toa+Qyar0fOcQ7eXJv2f8?=
 =?us-ascii?Q?HopbFe7fsUsPXkcQ/Pi7vwKjSr63zux0ZAGbYkQKpYaWeDB7wp2cP/bAZ060?=
 =?us-ascii?Q?PIsY8mnYHlCLfZVwvGtc1ydmcAXlMoejl5+83aq/7lhXJQkCqG7jxyelb1fH?=
 =?us-ascii?Q?IdE99FDpQUnub48sABTwhpnJBjaddVGtlhrEtex7iM3dKBEcWz2li4sta03R?=
 =?us-ascii?Q?rDY5fKaVjTMipOERp9YADc4F8mNaRSF2T2B5HI/sm+wSlVzYTPyUa6JBweqE?=
 =?us-ascii?Q?SC8wjzYVca9rxEhLwVXlJHSZkN7NGNil4GeeoTL5hmhUQDEvns2qbVw35of/?=
 =?us-ascii?Q?6nc9QrNvhSc55bCbe17/xxobZo5y6NqtzyO48OdpGtx4Pbv/8Pv1VlEFEN45?=
 =?us-ascii?Q?0v2WOpf0MLuckM4o7i+fXpaYPTEUj5dS4TYKergR/JBJ0E52PnuzAAxYqsEO?=
 =?us-ascii?Q?1jWO+KOtxV9bBf6fifBI6moeYuey7XLVitv5fIPgqEPEVP7rbX5AxQdN7yeV?=
 =?us-ascii?Q?XFk0dNBj8d86FACWtaIqMfjkUumqay7uwuoWIsqCOKqszL+LolxQ+1hr00eB?=
 =?us-ascii?Q?7JAYk5qRAauZimhbhyRaSi9E8By8XSD0rA1+7aVdcBvQBfERZYKWoZ534Cie?=
 =?us-ascii?Q?QBCYmUdtBHTlnlRk74GGrzM6fv34qFRlI5ao0W8fg/+QGlyJ75D+kVqohBFh?=
 =?us-ascii?Q?Amz2mDvkK8DPlowvSmmqP2f5OPHigvoIqCReQOyJ+yWXDoJtrpHtw9lpjQ26?=
 =?us-ascii?Q?8JioEj0wITdVEXrNYuPrXL5rNirJzefzd/koR9nZ4kVooFgVp9Wa7QAbX8cl?=
 =?us-ascii?Q?H0QZk83zW7eNBuYJszHyuIAE2VFk7NWkoKAaxJspGB0Z728PMznlTOknZNIg?=
 =?us-ascii?Q?M4LeLRsQL153E7ydNx5He2wivfVqqVwiDqLbbVBAW0NMrYyvaL5Ruo7PPcIh?=
 =?us-ascii?Q?2DCbxux2tD9ZmbEcqVVd+pGcitxbQP7/8YbZXlRdPJIryXh37+TesC3QmeMd?=
 =?us-ascii?Q?EldSHH9vVq/BGv4y5NVv9Vl3oQgdgHrOD6q+4fVwgpNq5ePB/Bm/fGGHewnm?=
 =?us-ascii?Q?NASla3dyKP7FAym6zMIv9H3Phq+fQAUcRwPRCbCquqCb86V/UFMApzgsy3f1?=
 =?us-ascii?Q?/9YlEeh9nyRY0omnWHPSiYWWzHOIeL0BUVxEDpLkdvnP2vfTRq76oJZmv/bR?=
 =?us-ascii?Q?FKF4g0SCXCCvTeqlqK3Vj+zsjvk8nA2PdYgFS5Wbn4UomcPiDuf4cW/F3kOU?=
 =?us-ascii?Q?zYqyw4EaTFLCwJIGIwPM7cwyb+lLdf3+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nt8hsTQmT0DoTpMAdo7+Jm2JjOgXywbMP3ojBWaMdBahKDE2KWvwZaDEv42o?=
 =?us-ascii?Q?+LxCW/q+Bgwzj+okqi3o4x2CjYeUCAKnvoyfkmH1FW6/VMwINlaO5yy6BMjl?=
 =?us-ascii?Q?N7Ri/HgEy8/PaWQsEkBX6o4OsiuegGUR+KUzP/1luTYOe5RhCgMCDILBWdNU?=
 =?us-ascii?Q?VpQhO8UdnIvkGWNGEbKF/D8dNGppS8mbv0AR8LCpbtm8l0maU+OkdTvB8kPS?=
 =?us-ascii?Q?FUgkzcz84F/pisXNMt5HnFwLUGxT/PF+bAg59pyaQEjQ06EBFF0OHCFBbwBc?=
 =?us-ascii?Q?yMQdWV9RAZWFN6ttE4wvMUMHtlM2HTTkurAKxWq/ES+j/KHyZ57dkBpZL51r?=
 =?us-ascii?Q?+d6qz4Ff11AQD+eRyLcBp+xYRrnF5J6FrlzcjD4V+hxMN1YzdTzpIAKAhSIw?=
 =?us-ascii?Q?fJh6RiN8kpIg3KMetle0c9c3UAci2qibLkn+CGrYQApq3FeiWrtvhgdsxWID?=
 =?us-ascii?Q?N1MQXFJc20lz+HsKsyQIy1aVtYhctiC5MgaJdynDn8D4HyNU62dYVRjtG9Vu?=
 =?us-ascii?Q?lmDjs45PKM3BC2Fg5kSng0ZHmyXrPGxwxewgVKWDR1ufMC3j7CEmbFE39uiD?=
 =?us-ascii?Q?WalIot+i7hisqB43kUuLfIgwOC5O5SIf1WVqyl3pnWILnnatJsRBpEI/bpgG?=
 =?us-ascii?Q?BQXELRAt7YrvnAssaOJ1eJxv3qGankWcYWYxhxHPAkhfVm0IlhUlrOkqfT/t?=
 =?us-ascii?Q?H+BT6o2Kj7MRYAO3rt7wbPEgMZ6YccIMQuW6afD08mIN6AJd84VaZ/hByLbT?=
 =?us-ascii?Q?uYmEzpXyVyIvR2TJrHiPROsKtZL0IzN8bysvpjiufRi4Tcyy5DMAPj0FuHrN?=
 =?us-ascii?Q?Ls+yiqsjE/qBMeyeAJjJ+oTKcsPI2o3vRcHoMngBrRJFwiOTZoyXRiNIF2RH?=
 =?us-ascii?Q?Fj1xyzx4KUg/vRo7luVw+0oOv+ASdxwui3qc51T1/BS4axkrYoL/N+6lMb96?=
 =?us-ascii?Q?HOENUy80vNxwR7W3JJ1AxaJqufgyao8Y1pekY0daX3UPa1Rp0D5KkxdPgl01?=
 =?us-ascii?Q?Z74GKKY+0r61Z26ITk7flBsmlwbaXBS2q49wxAoSd43HXNZXwygD4dDcuw0Q?=
 =?us-ascii?Q?JzlCRmoyUu4jdQn5VSBP6SAr8hFumrpP6OejUQwDTz3llVn9qoq5r0/zyXGp?=
 =?us-ascii?Q?UOmuHN/v2KIrY7u1Pxws9UXibcb4NpKCMdCkAXKhobqV7GH3/qhdNf/WqtX/?=
 =?us-ascii?Q?6bWTZleBISNR8LQPqOP5ZF5UhLaNp6DiDojH91tA0gSIpXpBS3Bw/n9p7+2D?=
 =?us-ascii?Q?lWmkbo47FAeEeqKRrx+3R+7E5FXeMHU8TKOYqAgtanWa/c/NwZlm3K/+1oDu?=
 =?us-ascii?Q?GvdhHfZ4ehfAZFpS6esScTkhRX5e9UTm+4sNeAdhCEPG2Vtcteeh1hOMlsbs?=
 =?us-ascii?Q?Ezhc8Q2OlNFb4mMA9WeHKg+MZXDRXkFl1ZioVxuAMRmfTHqYUpAcOSp05jGt?=
 =?us-ascii?Q?TugNIkKKJIL7ggchcAfO63ZWh7H+ibse53gIK7M8JvG9RtQWgxkEOSdtT46U?=
 =?us-ascii?Q?UB1FsowempZoQlXFRYOsOo50onilnOoBXfuQ9bGtAKZynz30z26ObBKddqfN?=
 =?us-ascii?Q?4gsdliWvUhQKob4nzTrYGevjOcpdRR5JpJkJ/udL?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5cf251-7e4f-419d-ca60-08dd601cf7a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 21:46:08.5989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QQwhFLEOaZNQ6jHOohOz7gxMJlg4rWRFS6ZexTSn4U9o8R/M9iWuD0FFBf85Yu3MMrWbrREV89zCCpB1K/m90Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4388

> Subject: RE: [EXTERNAL] Re: [patch rdma-next v5 2/2] RDMA/mana_ib:
> Handle net event for pointing to the current netdev
>=20
> > Subject: [EXTERNAL] Re: [patch rdma-next v5 2/2] RDMA/mana_ib: Handle
> > net event for pointing to the current netdev
> >
> > On Thu, Mar 06, 2025 at 11:24:39AM -0800, longli@linuxonhyperv.com
> wrote:
> > > +	switch (event) {
> > > +	case NETDEV_CHANGEUPPER:
> > > +		ndev =3D mana_get_primary_netdev(mc, 0, &dev->dev_tracker);
> > > +		/*
> > > +		 * RDMA core will setup GID based on updated netdev.
> > > +		 * It's not possible to race with the core as rtnl lock is being
> > > +		 * held.
> > > +		 */
> > > +		ib_device_set_netdev(&dev->ib_dev, ndev, 1);
> > > +
> > > +		/* mana_get_primary_netdev() returns ndev with refcount
> held
> > */
> > > +		netdev_put(ndev, &dev->dev_tracker);
> >
> > ? What is the point of a tracker in dev if it never lasts outside this =
scope?
> >
> > ib_device_set_netdev() already has a tracker built into it.
> >
> > Jason
>=20
> I was asked to use a tracker for netdev_hold()/netdev_put(). But this cod=
e
> (and the code in mana_ib_probe() of the 1st patch) is simple enough that
> everything is done in one scope.
>=20
> Jakub, do you think it's okay to use NULL as the tracker in both patches?
>=20
> Long

Hi,=20

If we don't want to use a tracker, can we take the v4 version of the patch =
set?

Otherwise, please take v5 (this patch) if a tracker is required.

Thanks,
Long

