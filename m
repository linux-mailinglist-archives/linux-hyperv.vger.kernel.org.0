Return-Path: <linux-hyperv+bounces-4263-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53049A55738
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Mar 2025 21:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9513AB00B
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Mar 2025 20:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A917A213247;
	Thu,  6 Mar 2025 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WbvfaxZX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020142.outbound.protection.outlook.com [52.101.61.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235BA14658B;
	Thu,  6 Mar 2025 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741291312; cv=fail; b=TiOlPiCI5AHrQ50CWCpeNYiTaxsiH0enbqx3wAeGM58MSuvHnjttROcc72sUch+bM9aG5mPK3vMcwhhgN8mSjgb0p6jI2cww2wdv/AblIr+5CrPRkEKB7nAr51tD5qb1yjX33sO7qQUQujgQIhtgf+Q4duQmzWN0DF1Fn0OSX3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741291312; c=relaxed/simple;
	bh=ZqJs94kQKEGgKau7tG1BYHeuctA33hD68lOjllkoJh4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VFUxzDKT4cWTfxX1Sd3K+lzqAVj11Urh5NQ+ujwxNDjCatqOKXdjJKgTlaicYLLPn8dH1ZYMGxEnUV0Ep1Fdnx1UJsKuqOJ+cnJIlhQoV96B0NswdND/oBmxnyyabzk7yATnRJscHDdpw0E0Y+5ZlMeywy37lSS/i626N8AJw3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=WbvfaxZX; arc=fail smtp.client-ip=52.101.61.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOnSaLXV7V1BLVCQyDvSk1ZpQzEVweoNBQNsp+u+Dt/poeXxcroETMIQJztH9QWoDEmuJTFK3hRzUOW2BMi9CMzBWsa1wuFvTTxwd7XY4JWPkivOUob9OKTuNuqgqWIr3nvXQ/GJZ0xsXzinmDshRPE5pVlvuCqI5J8MI9I2gedNaOSlEt8NHQVCy34yPcOwW+NY7FVXscwuL1r+43h7NDIrIgX8kvPu+MEoMPaDukeVheq1j1/FSkkDcYvihJsQRhUDUMMzJDIVIK9l+vdYs5z2NL7AdjtCDSZxEUj7kjQpeOT9mXTRq9cI+oY4a+TWRWfbHgk8zIv7KirseNfLjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoJbAOd1OgbJxi4MyNjtTQBn8uc+v/NFe6MTZbPfZLY=;
 b=weLib7fvXwUqrsOXY0nxEaG5XUO6yURIKnKbC58FO/AHGMlB6vKmueAHhV1ZCAs7Kj0QGO1mivsyBP6DBadipBohrr3Y6P4zaa/474dXOeFlcBxZx/62tZbV1ifbtJPElneQJZesEg7kO8iPlQRt77OAXIFmk4bzqIu7zgYhFZjghMK66H+TNBZPgRKycN/lg4RpXK+V6UMWK/Fx4hNRfVCZMBPvCwwkqr7NYBZ4J7rTYUSaYxrUNt+X8a6cZmtj0HRRIdWjihrZhh5GhlyV9vUmRimr/owmKwL4F+6rLXnCyNtm6tSiAcvUkLJjM7f5YiAFKXMSLPuHHJPG4kEQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoJbAOd1OgbJxi4MyNjtTQBn8uc+v/NFe6MTZbPfZLY=;
 b=WbvfaxZX8+DW+yKtoFEyMrxQP/BiPXflSzurmZUhU0RlrKCjq106Kfkg5KHzKdOZ64mvYHf0cg30n3Mw3m/E9RMn2lt0rTgY4JXR/PD4848zp3Ns/JAfoqOLk7LxJS46Ond98Rqx7KKGzvrHLmk1WGcD9buQgbsWnvWlXYhORww=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4208.namprd21.prod.outlook.com (2603:10b6:806:415::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 20:01:45 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8511.012; Thu, 6 Mar 2025
 20:01:45 +0000
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
Thread-Index: AQHbjtGAHu5I1ObjAEGtSbYSnlR/rrNmhdBg
Date: Thu, 6 Mar 2025 20:01:45 +0000
Message-ID:
 <SA6PR21MB4231E9B17697BFE4857A7E55CECA2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1741289079-18744-1-git-send-email-longli@linuxonhyperv.com>
 <1741289079-18744-2-git-send-email-longli@linuxonhyperv.com>
 <20250306195354.GG354403@ziepe.ca>
In-Reply-To: <20250306195354.GG354403@ziepe.ca>
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
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4208:EE_
x-ms-office365-filtering-correlation-id: acc9b32c-1966-45ab-90bb-08dd5ce9b8f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QpOQ2MyQTCfLMSNWNlVqCqgPFoF3paXo9NJjFNAqWJe4WshA16nyNUfKF2gZ?=
 =?us-ascii?Q?hHqLgihat8n9vsBfPv626IM+z/jYrTQ6nADH4f6O3rJSRHRqyjyVwEYbB98t?=
 =?us-ascii?Q?yh1ezSxul7aEohmBmFoD4FY8apgiGhdxNLFMGZT5fjVSTn08Ogmbid7xXXBc?=
 =?us-ascii?Q?+f7FH0idBQ4czzrBowFMVcppS99hmtu0qFAEtp+r2i9B4MQ7fzV9ZhqyNPAF?=
 =?us-ascii?Q?/Ikw7aYViCfTgy8uN0lQfXwd3ZDLinmH8v+U5wUZxO8CFEqONjp6txq8CY5g?=
 =?us-ascii?Q?5fg7lUzmh03/X2EPjUqzOAkdbV1cMjolvZ89MZ2A0hYKp+qBVIi4Xj1nhARF?=
 =?us-ascii?Q?0jGTOPwnCABBbsy0MbFdHjhCC56RtBPQGp4rrl4kfcLibI4j7ZI+eXGZpCS4?=
 =?us-ascii?Q?6JvUDuucUUlWEIzGv642VEbBbV1KVapbPyrsM1KqLwuejMJYIPhwWf7SEZYE?=
 =?us-ascii?Q?b00NSOS7QgGFEPTNJT1rpfPOsNb1CnYSTNDvKD5dnzDhOJc1kJV2D/uWl12s?=
 =?us-ascii?Q?VuVVL1hJA6V7AbBhaOWa6Qbl/fpzXQ37N9DXY8ubC9AzfBVqSrngiZT4S53s?=
 =?us-ascii?Q?WGIBqc+6R2UJV18s23nsLr+c+6vUbkV+0YTnCxt9ruN8iyEitsUZQ25V1Vf0?=
 =?us-ascii?Q?vomEhEUu0EiKVrNRXIO3bLI9dPIhgSz5womxzIUdTdRca8lmuH0dh0FxoZWV?=
 =?us-ascii?Q?WpeBi4p5dJlX32CP+xRL1AOVqeDBTvF3ZMKLwseNxWp0v3nx9UcUP33+SFej?=
 =?us-ascii?Q?iTazzOcJt1hmTQjVUVUk8WOw/4Osit1dzG2H8pd86Ne1D97RCM9873FeDq+d?=
 =?us-ascii?Q?xmq6awbjrjjyJmmGMqX8FPzWTjtIWSLyCo6SG3fuRBMsNTAKLXToVAM4GXl5?=
 =?us-ascii?Q?chqCyTltlFQlqdKcvqf3e6TDCNxVxF/KVy0jGcaK21SIsye7DbcKTdq3tuXN?=
 =?us-ascii?Q?S23edR+koGiIGLhuPr4vYriRsj3tcspfYnHWZRp4C1Fp43FbBYlnrHgeB3ft?=
 =?us-ascii?Q?K4Jql56n/kWMpi5HB4ZSb0aV07wqHUGu1rZLvxaWsUL4hwU6the3nTRrNQnu?=
 =?us-ascii?Q?xsLCijFriNakDs7IGTw4Sg1SJLNmt1rs0wpetpSVX1KGMzQR/yIDejBfx88f?=
 =?us-ascii?Q?gjmBdwh9pAR5kKxknl3TIgp0jMdOZU3thF++ibMfFLy6P/LzQRq0/+g3fqC6?=
 =?us-ascii?Q?LZQoS4LCJ169QUUhN0g0R77EQ0i6ld3mQiOrelwCZQJLraxcokQxamn0+kjG?=
 =?us-ascii?Q?axyu+xbnD7KEU3HbIlGkfPgOPdVS/JRmdxpwAaw6LDCodEHVt9OkJX7mJDSm?=
 =?us-ascii?Q?LEt0l0qYOCoLhb0JMM6zjjchvwS1w3mwOADFa9tiCBqJ+icAxtvCgaoI74+4?=
 =?us-ascii?Q?rJNg5wgy8goKjNACGyxfqJQcuHiaFp1rBKl0JQ0129/NrfqfWPlGXrqN6Wx+?=
 =?us-ascii?Q?1j/kd+qjeSXJcCqxra7uUY0v0QFAkFQs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0bpXdM2556QAZ7yOItFFMnMv7BzhcmoWA2phbUU6LvM8wi+RECeAGsIz6x4q?=
 =?us-ascii?Q?4ZRiRLQ0EwDUL13kgL2O7fUVs72JF5IfuZ7K/09BfoO5S45VOmT2w4TE6L+g?=
 =?us-ascii?Q?mBo+RmwCW5imlWExGYsTnn9QtMaIS1DXlMr+USxLG769mF1vjtp1VXVBkcLK?=
 =?us-ascii?Q?wRvoqUeoY+TlW8ODBaMYt+PuGuX6qrG+lAzjQ1tOIzy2LM9vOKY4wB7VgZQ/?=
 =?us-ascii?Q?DU19T7VQx5nIj0QorQrSwSeUzV6Jy0tx12ahdIEUAypSjWjmoVPGW7vjT9tN?=
 =?us-ascii?Q?U9SzSRAMS082yQry2VRo9/6+3gzDnAQvYGbdLWa2RValjFfPvm8vAyRCvAZP?=
 =?us-ascii?Q?EKdGo31N6/X64fOF9rSuvRrT3p1mYFW//+c1lPMjWmmGcBsD5tFcVkXOY3A5?=
 =?us-ascii?Q?pMetPtIJNJ4H+KhQX3gg9TSvATxyXTeA58Tfh9Z++vHahHRF4vi4ikjDEZEG?=
 =?us-ascii?Q?J77Z0swLwlrC8qsYtA7P0I1Tqade4IGUvWwULkCTQNJrjBOlbfpVlQqkuuVA?=
 =?us-ascii?Q?ruj7eWP+Joz1XPxIGvsK+Vq8LbNby9sEVCt0M6aqAcRe7HMaz3YEvNOgoe9K?=
 =?us-ascii?Q?BKQz+FIysstfiKRZjmEFwysZbg8LPAPX9d0HEOdFAOuhYSz2sy/PjgwWyqhQ?=
 =?us-ascii?Q?ZXfnLAg2IjzzKMKW+EbZ9tE67dFN0DQFovPNpy8HbiO7YZhDFHugbL17B6LH?=
 =?us-ascii?Q?Eunc/cRhCcuHaH9MUfqTG9+EFmwePc/C5Tw0vM9HL4QzRhj/VK2XbOGp9gJt?=
 =?us-ascii?Q?iuIc92nPnIQCQsAMYSL/YGVGxgGBx8no+TK76eedOBI2mQBRhqDSzWuZe9zx?=
 =?us-ascii?Q?FHExWbrnXrNU/Xj7ideRBA0eQEAdqjHGh+S5iiJjqO1CJ7Ifg6K6SBDbeE+T?=
 =?us-ascii?Q?1eJFyZ2m3/YxafVnNly/iRHZywEWZbGDqXMxmsh2YuRhPra615daSv0YD5Re?=
 =?us-ascii?Q?P6oM/h0dQUNr0gvt9xjA1XRsthj8bmGm70EKjhRSn5mooOnklNfCq+/7Yfc9?=
 =?us-ascii?Q?wbbJdFgy7Q8Y9BnS9E0hLvEI+0wMp3SSKkMPbi2rMkfEoqJBcxn9gI8rJAGK?=
 =?us-ascii?Q?kVXdmI0/Lf0Sv/n2egvLRHJEYE5C60EGIMc9Vw805Dl8ay2qd8k0XH4hzrfZ?=
 =?us-ascii?Q?eYZwlK3oBAo0wiKAfJDv8N5EEjESuPy05+07zo5qDrrpaAHaFTaNCECb7jT6?=
 =?us-ascii?Q?jRgjO9xbKUqYB9wdmUvEGYy2QjnTfqmkP2Iy+TMZzbkvrNJCLit/vic0RKK0?=
 =?us-ascii?Q?DCNwBiyu2+qKW0P5HXF/GCYUJeAg7jVLhQ1RTrWvDiGqvaJcoMtUUPF+ylXE?=
 =?us-ascii?Q?B4ckvpYDQmfExCrHGeurj5NzIFr0pI4HZhhMoAwMWbkw5akVzmRCjgUHZh0X?=
 =?us-ascii?Q?4zZ4tz5akEUdQ2qJOA2s/J/aobNwu/Dedkm1MVHMj5Teun54iHwNZwqLwOBS?=
 =?us-ascii?Q?IlftrPRLCFiK4xSSy227anIY8cV/3CUIYDemwrxPynwmDPps8JaSQ2+WlHj+?=
 =?us-ascii?Q?jv4nJfJgcavBxeSsZ2FL4abZgRhOC4IY4z4KUcY5l41mWZgNC8zwGBGpO5ss?=
 =?us-ascii?Q?lK6fz3JLpMRZ5YqLwda+p8te3YvAGf3Lpyw+a54l?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: acc9b32c-1966-45ab-90bb-08dd5ce9b8f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 20:01:45.6216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I2y5roHcvj3jb87NfBxZtLKpBzht4Vpm89sN4ZlKCfru1ZRE3A7xZRyHmG/FJao5uzRivt8UY/WAiv6OGpnPHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4208

> Subject: [EXTERNAL] Re: [patch rdma-next v5 2/2] RDMA/mana_ib: Handle net
> event for pointing to the current netdev
>=20
> On Thu, Mar 06, 2025 at 11:24:39AM -0800, longli@linuxonhyperv.com wrote:
> > +	switch (event) {
> > +	case NETDEV_CHANGEUPPER:
> > +		ndev =3D mana_get_primary_netdev(mc, 0, &dev->dev_tracker);
> > +		/*
> > +		 * RDMA core will setup GID based on updated netdev.
> > +		 * It's not possible to race with the core as rtnl lock is being
> > +		 * held.
> > +		 */
> > +		ib_device_set_netdev(&dev->ib_dev, ndev, 1);
> > +
> > +		/* mana_get_primary_netdev() returns ndev with refcount held
> */
> > +		netdev_put(ndev, &dev->dev_tracker);
>=20
> ? What is the point of a tracker in dev if it never lasts outside this sc=
ope?
>=20
> ib_device_set_netdev() already has a tracker built into it.
>=20
> Jason

I was asked to use a tracker for netdev_hold()/netdev_put(). But this code =
(and the code in mana_ib_probe() of the 1st patch) is simple enough that ev=
erything is done in one scope.

Jakub, do you think it's okay to use NULL as the tracker in both patches?

Long

