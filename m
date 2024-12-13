Return-Path: <linux-hyperv+bounces-3478-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7979F1736
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Dec 2024 21:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41F047A1613
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Dec 2024 20:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092C419006F;
	Fri, 13 Dec 2024 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jTI1SgIV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020092.outbound.protection.outlook.com [52.101.85.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A26118755C;
	Fri, 13 Dec 2024 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120432; cv=fail; b=MqV3to/qVRs5fd1yYHMK9gUg4O7bZ7r79tH8fmt2LHHONPWiFFPBbwARBLHoLZXkiKtdPo6trqERtm6QcOmHUZsSlD8dI+JwqdJMnwLUGKKlLoSDjxCxxQSI8zBjL/3/0UXcwrltXnQwKgPtcsztnt9dDf7GxwPnhuF/ecBVY9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120432; c=relaxed/simple;
	bh=PEbNw/ihNkt2tyjsxbfzVUuW7YiNFLneyZ5bLwWlZDE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IQTevisK7KaKt80lFHU3GMuQYB7pozNYEZm5h99eBoLPf1wlxAytvwTUmtSpLGXB1YYxfbffpQ8JtF2/WvBLwK7ohr5wnXfY369UjK/PCUzloWBa18aukBgpCXy/jACIG84YNJdskQpIqpcRlv3y5W0vuJXPwFXFbYCgVduelkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=jTI1SgIV; arc=fail smtp.client-ip=52.101.85.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5ttx+pZALshv7SxuZCczguB/aar1rn4u1XdUBw6scT3Wo77v0daxj7Y7GjUZtnbNRjwys0CEJilNsvatcVLQ0qvdBDcNauwBO1yUKq+/FbtrM9XGV2tArYoc3E0co0D6dtgJQHzcm1MjEdhjJOq1vxpiq+HL8iiRaqMf+7EmGaaV95KIRGP4cV+NBju5pTI/l9pGdTiQ6PBK2sr/SscuRaZ20Jt2EsHVz6VAfh68UZqGs0BZHZAfq/7vwtLRCpQCpx4vLpsA/aau32pRTV1vw5McrL536sctIDYBlL59j/yfusYtmuKGGF8F0I1INp9nB84ZJGcz9M42Cn1WHkeVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DR8SX2HWmcki6MyMAsvRRSFPUV/UJ7nXCQIOsDe7+Q=;
 b=dMerid3yU+HDI35J2UaTArM7bvrPNFxTpStImig5VbiQOQMVUcQ9A8qa207bYsGxVqc9MCLpY/hOgLjB0Z2gyrsz/o4O9CGPiFlSDocGPRpJ0eicLpXdlgNQ/lNi4Ce5MELVA/xUlYIFYxmX+Mkp6cOsvsln+2skU+rzjAA7ohya+2LLMpUOweSnScBXF+rkdjd9Ap/FxzWmpWiIiCMx3Z+yHa9Dt1EEZI47mjOWcfQsP8TCIHBJNy1Ok99qoQDtgvQT2CyVbDNavYtkPdmyCuzzGA4HhRd4mW0pSIPOz3t/XUBSltKr1vEARoHuRqCdWote8jYTj3FwOpmYVCQ7Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DR8SX2HWmcki6MyMAsvRRSFPUV/UJ7nXCQIOsDe7+Q=;
 b=jTI1SgIVBtzuScx6aZbCtURdTCUd5t0eiXBCAX8+ue8iAkqOhhHvvBia3TnNj6BLRznKFQTY+h20dQAKL2Le1sJiEp5iYz4bkgK7KzgfYjIU0K20+OYQP9vId9heY7Oqw5tLUZfxH0sZadKF1fhG78SrrUXZXsSoIaFJkyWKCbc=
Received: from SA6PR21MB4413.namprd21.prod.outlook.com (2603:10b6:806:421::19)
 by SA0PR21MB1868.namprd21.prod.outlook.com (2603:10b6:806:e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.6; Fri, 13 Dec
 2024 20:07:09 +0000
Received: from SA6PR21MB4413.namprd21.prod.outlook.com
 ([fe80::897f:6c98:6341:ae07]) by SA6PR21MB4413.namprd21.prod.outlook.com
 ([fe80::897f:6c98:6341:ae07%6]) with mapi id 15.20.8272.000; Fri, 13 Dec 2024
 20:07:08 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, Erick Archer <erick.archer@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH] hv_netvsc: Set device flags for properly
 indicating bonding
Thread-Topic: [EXTERNAL] Re: [PATCH] hv_netvsc: Set device flags for properly
 indicating bonding
Thread-Index: AQHbTYeDFmyaI1VCoUGaKU7gSwnXerLkme7A
Date: Fri, 13 Dec 2024 20:07:08 +0000
Message-ID:
 <SA6PR21MB441317AD5315C6BEE9F1E731CE382@SA6PR21MB4413.namprd21.prod.outlook.com>
References: <1732736570-19700-1-git-send-email-longli@linuxonhyperv.com>
 <20241213095028.502bbeae@hermes.local>
In-Reply-To: <20241213095028.502bbeae@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=740b68b0-ce08-416f-b8c3-137d824d618d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-12-13T20:06:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4413:EE_|SA0PR21MB1868:EE_
x-ms-office365-filtering-correlation-id: 5254c0b4-fe19-481f-9496-08dd1bb1b929
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sAoPs1zUoLN1mMq6V0PQHhFLLDX+saeQlx4bqA6glv4kdu/ldjhaRtmVuUKA?=
 =?us-ascii?Q?l3RDSKjFVJUh7kGSoFowpofAYs+2g1zzkGkbPGcPMmSI5FKD0KvTNE49lrfe?=
 =?us-ascii?Q?9CYtT368wYmgC2f54kfuUnrgszfYLm5SkvvG/XQEO9rhxWqkB1BJ9DGPTSjx?=
 =?us-ascii?Q?JHMlQNwSO05GuG72FzDRZAaxGgl5h0v40X89BRDqlQFTG+2jwcArLM1yO2Oz?=
 =?us-ascii?Q?mIX0OsdLbAQl3CPROXH0WnZo3jbif9+A0lKlTIbvSm9g+Ov/QZV2kkz7CeQ8?=
 =?us-ascii?Q?9VBlE5e1/1QNMbABC8v4sjtDltz9o2iwSwW61TTcjoFvWP1uAHFQxIIQDM/M?=
 =?us-ascii?Q?U0eivcZOz2K9S/ILy9T/N5BXwWdwPUN8XjF3JMZ3CgbF7CfqFSQ72c04AUXB?=
 =?us-ascii?Q?CU5MsEWe9LKYGqSvjEqnlytM5G2uYmsdlSM2I4hzE2ui2kAfcsXalWgrUkWE?=
 =?us-ascii?Q?5wOs+VhIrVgu3VMia2KkZW4fdC18Xn/zpmeXHfvs4YPid6KTct2iQ5887WZ+?=
 =?us-ascii?Q?3U/5kd75Dhc8cVSibLvPHwhZC8WbuJdPpBPh7VxbCdycpLxZRnmyRw+UwVlW?=
 =?us-ascii?Q?nNy3yaKY0MBpw/6N0ePepRo8Y05kEYyNq4e95YVu/qXq36s+p2rxzzEWRrjp?=
 =?us-ascii?Q?EVrstKRQbofpnwf4aPD/EboNSiUlmKijHQrPj2UVRrGABPNHDngOKtJuon59?=
 =?us-ascii?Q?d3ZLZCuSXO8HiJOxVcwwdJ4ZC7QxEtsnjD283O3Gy8mtT0JiK6YM+btaT1qH?=
 =?us-ascii?Q?Dc6YOJKrgexvuJq3d+yD0f1cvgEyvzxehLxKitVMAZoW6bE6hFNd1fA3IdOR?=
 =?us-ascii?Q?M5EJNRbpfiwCPmB74pv5Apy1Dat5XuNd4U/vfMitah9VlnGs8EPWhqOb0eeM?=
 =?us-ascii?Q?ohCyIaT6H+GJ5/PTVKqIZaeuaRjpiDOMWNoGCqhAVxU9D20JSig3C8dkYEJZ?=
 =?us-ascii?Q?N8Rd+jo0EYG63DxaWCDIIgKrv7mjg05/5HmgsSBLNOWTB8eGiFFyy9Y3sAKr?=
 =?us-ascii?Q?1psmKtTP9YHwWtf/3uONCSwzcChktWC7lsTxIo5DgzcDqNk3kEfhqmLhkb67?=
 =?us-ascii?Q?jG4Akd+xdH+oDXIuDumz3NHme+1lpIFU95pBtRZwWwrMkQhphsgBxWOBJu1Z?=
 =?us-ascii?Q?nun0aVomi9TfAzYtzB8C26RKd1mmPS/xpVSOMjXnzdZM/tSF/gVAJ/Ny3X9K?=
 =?us-ascii?Q?rjagSloVq5t8ONuDIReGOXI1AZge8A01UPkFM5v4+Yz6OdxHMUQOcwtmJqIz?=
 =?us-ascii?Q?EApSr50SVRhkYmqfjYz44gXQf5IoQ1yBeVcszGuQ5hPxaYSeUgvp8BOMcYRV?=
 =?us-ascii?Q?ULtscb0uj8Bu15R/cKdara62ws8k3b84o3N5JLvaB0ixGm07lwUYtDskMo5p?=
 =?us-ascii?Q?0Wrb/4KNeep4W8xXK8sD6gk8+07Tu/d6pL2TNW3VH/MtNlPBdNaLRwdhy9B5?=
 =?us-ascii?Q?MQDj+7tNe3Ag3QShT+xY0ICh2cvs5f0p?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4413.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CLjVVX60EntGJNYnJFJ1BsblbhbkzjZRJ5ueyV4I1WwPgy/VJDs+3c5pMZ5G?=
 =?us-ascii?Q?aq8ZRHPtlwrOfYl/UKX9qJfOfAzyxJ5iSbtquOJDIpUyzevz3txl9lijKUrJ?=
 =?us-ascii?Q?aSbKCHIyPNPJXUrW05EUy9zBK0RWlM+Kcq7284Ht23ZCLl+nWD7snZaSvBE8?=
 =?us-ascii?Q?fpdgqzifM2eFftp1CN6IdIQZatkMsw1BZXd+WRXBuI/QMH4l/A8NGRt/GP4A?=
 =?us-ascii?Q?p7TXQz13uK6vWVxN2DHE1HwPtA/zHzkUBELv0JUBwhwl069Kx6kpW+gzXjyn?=
 =?us-ascii?Q?FxmXzNGi0MgEj1HSCe3jowt0omZa9GY4WayF3ghf8w1xjzAuc8FpVUZxnr6C?=
 =?us-ascii?Q?CuQwDRYEB/vmHJRTJOzwJZEmK3KPSML8/6e3YbQ3lkfQ34YKFOwQ0+Ky9Pn6?=
 =?us-ascii?Q?X2h2hn/qtkYIG4kbO4y/BhTCr8nBDWcKN2ccE8qt2AmknCUYGEqnUNNSyaWG?=
 =?us-ascii?Q?c9rrfIMveCOoW7LpkbkTKGmntogNDOIIdzL/GPzn6Zfv34CsctRo/0o5dNwa?=
 =?us-ascii?Q?HQCX40mSpSauT02lahknCOlXr6Ie+t3JlA6ZTu/vXBheosm3w3XmSyfxBVul?=
 =?us-ascii?Q?JmqUkQKGF99V2YKyJZ3Y1qB6zQ4Es1IKkoT9wMx9WVsUcwyhih389TmicIeL?=
 =?us-ascii?Q?X0Vbw7uMmRZxO7C+OgT9/syye9exyiApWGXkE+BF9FHEpWhdLTSXNsZW32B3?=
 =?us-ascii?Q?mwWzAqjHU5CBHrM5VViNZGCXDWP9Zr2CCtZHwjyIsVZgesqW/L6jth1D+hdE?=
 =?us-ascii?Q?LIKSHOazIiFPkIZIOadt5YsMegSk5uC7fH5Ag3qSWctdiBlHfK1oXXBjgqwk?=
 =?us-ascii?Q?KYOS/cNkmetTwMfNvrz4ixI6bJpYUXvmKGsX4m1gC9uXrv0HPjP2WieQlifu?=
 =?us-ascii?Q?sXjWSj3xpr9jtFPCXL21BkWIKvIKJkp7c2xjhaS4cNXALsoDGTunRSW9Tgd8?=
 =?us-ascii?Q?l7/5tBAjcDNOGsO1bn9N8eUCp8Hb9MbsEWGcRvAk5LRMTtqEtnmkpT+WQHRl?=
 =?us-ascii?Q?q0Ua2Jen1xKSiWewU7hLqUROCFBIE1cmczdgMMQ4c/vuESn6bH1AxWiP/myU?=
 =?us-ascii?Q?MscZXWHn++LWve9OIQiJxGQfHj55wGIwy85C6z4xkhS6fxOLi/uTpCDRy3lI?=
 =?us-ascii?Q?tuTWBCBW6iym+DM/dcTW10GqDwhV4/0ZM7iIpjDdYAoXehUiIOqDYy+it8wP?=
 =?us-ascii?Q?4XwakQaH3SSL0Lyx91zdGW4t9mhtfMvScv8xAm/E85Om3Fb9N3X5dBAYN8Pf?=
 =?us-ascii?Q?jRR7bhz5ncgeVs7BYtmpYlPGy+VMJgLmQHBI/vlqoUPPavlR/N05weq9L8d3?=
 =?us-ascii?Q?wd8T8wV3fDlQZbnW3kxCjuWNiKFVWYUpLTTQk4iQuGTKnzE1XhATVucNK0ea?=
 =?us-ascii?Q?pS1i1bRewq1ln6tTVVfDz0AF2+PPVgQtm8raMCK1FrywEv2nq6aQyksFHB/1?=
 =?us-ascii?Q?X/xDesry7/R1DcrW9e5tDDo/PibJoK4pImhNOGSxZ5tcGR8QwjwTgQbRBFU3?=
 =?us-ascii?Q?2JiMZCsbjEMI7h9S1uXLAPCArM7fPEKI6vObo11zlAvhdovirVYBbg8Rt/Tg?=
 =?us-ascii?Q?C+Uhe456JagRkoQlBlsdYIUKo/hzPpHmohJyXN/e?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4413.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5254c0b4-fe19-481f-9496-08dd1bb1b929
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 20:07:08.5127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V4XRztePGTXKvR8nEbckc3k01MDP+tScXuUKnrvMzuQrxZpPufpuBeZnHjKxYpCyyZKDz8S5b9GBn3WDgSBp/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1868

> Subject: [EXTERNAL] Re: [PATCH] hv_netvsc: Set device flags for properly
> indicating bonding
>=20
> On Wed, 27 Nov 2024 11:42:50 -0800
> longli@linuxonhyperv.com wrote:
>=20
> > hv_netvsc uses a subset of bonding features in that the master always
> > has only one active slave. But it never properly setup those flags.
> >
> > Other kernel APIs (e.g those in "include/linux/netdevice.h") check for
> > IFF_MASTER, IFF_SLAVE and IFF_BONDING for determing if those are used
> > in a master/slave setup. RDMA uses those APIs extensively when looking
> > for master/slave devices.
> >
> > Make hv_netvsc properly setup those flags.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
>=20
> Linux networking has evolved a patch work of flags to network devices but=
 never
> really standardized on a way to express linked relationships between netw=
ork
> devices. There are several drivers do this in slighlty different and over=
lapping
> ways: bonding, team, failover, hyperv, bridge and others.
>=20
> The current convention is to mark the primary device as IFF_MASTER and ea=
ch
> secondary device with IFF_SLAVE.  But not clear what the right combinatio=
n is if
> stacked more than one level.  Also, not clear if userspace and other addr=
essing
> should use or not use nested devices.
>=20
> It would be ideal to deprecate and use different terms than the non-inclu=
sive
> terms master/slave but probably that would have to have been done years a=
go
> (like 2.5).
>=20
> For now, it makes sense for all the nested devices to use IFF_MASTER and
> IFF_SLAVE consistently. It is not a good idea to set the priv_flag for IF=
F_BONDING
> (or any of the other bits) which should be reserved for one driver.
>=20
> If hyperv driver needs to it could add its own flag in netdev_priv_flags,=
 but it looks
> like that is running out of bits. May need to grow to 64 bits or do some =
more work
> to add a new field for device type. I.e. there are combinations of flags =
that are
> impossible and having one bit per type leads to a problem. Fixing that is=
 non trivial
> but not impossible level of effort.
>=20
> My thoughts, but I don't use or work on Hyper-v anymore.

Thank you. I have sent v2.

Long

