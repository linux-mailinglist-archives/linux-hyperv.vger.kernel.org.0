Return-Path: <linux-hyperv+bounces-4217-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5C2A4F1F6
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 01:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB08F16E3B3
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 00:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A00FA95C;
	Wed,  5 Mar 2025 00:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RSAzCazl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022128.outbound.protection.outlook.com [52.101.43.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EF56125;
	Wed,  5 Mar 2025 00:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741132862; cv=fail; b=d4S0sCO815yRfalAEZatFZT+F1zY1x8prhz9Yuirs/uMIkEblPj9D5gQe/XufyP6BTnjnUvE/ficStdictltWKqoafa2B7J7dyvtQqF3Lq2rr0HtXNYmGeBufMRoyljtHO3qFYUgtgkc65BoltQRSyP29Y01c8gDwIk67i7Gg3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741132862; c=relaxed/simple;
	bh=OFQz/kT/r6ux3Tx0rhFiBdS0OEFPdwzdXjftY3K4GJw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=is9deJ0s3DVs/IqYsVXnWEbC0P5cAs06D1XAQjK3Zn0g4sRWANhZtu5VsCANYN+tvBfBGgntCONg3JC9+FxNZjDkHjP/hyfuux0KI1XoNW8RYTbs6rAVFJDuy4NEQBRG1m1hW8q3DxgpEsa4KqHzMFXrOOSvfTCDSMQZRZYaev8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=RSAzCazl; arc=fail smtp.client-ip=52.101.43.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGXzrldU0kXnTH0voPW80m3L4+EN3rQYiqehiaYj2TYwV62sQfKrD39+r7piZH4KR3yc6BM9IbWkipTKNho4XgBR9DBVePU2+tUS5T40+TsP3g0kgO228UurkHUqiJh/cyReyI4UFFnkTOKOQnJPd5FT+D5kJ1/A+JE1a486JtOzYE2qcG1WvCGGR8hrINveag360mHQ4TuA3YqPWZXTYED8LPCqNfqUCD/QofxaDQNXDtBsA1m5g52e79t6/TgjbibuBNgWKPMCwPBEUXlEjQZR9VgJEik0a14JD08gUHTnmjGl2youHQ1jiN/jtaRqDr0He4dnBiLQkK64O0TFiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SXckUSAY+DGPfDXkJboKPxE3MssJ1GtUolw7CVnKao=;
 b=Lv7prp3G2lc9e/xXP6AnxM1KGxqYdngutbuh5xBRAnBfnYL/PfwBi5IO+xPK4jnNGpfZtd9lK1ucKh75eVCPpUtfa1vgVqfR4E1ttaOptbw68/c8h+2qHKVm2qm30uAHjMcrq+W4BMg/o5lGpBl4Mb8dGg7YwCYMJuQFfaGpVlhPL6YunKAnjeV/5YyZogwlKRYhLjeSr/E8qZ8+HZ+j1bawHevRaN07NyA+JkuZ7fGybJaLvy7JWWaLnfZi97xYI1hp5PtMZfL6aLOv1SwirCqbBRbTetNSjL3tM3IRT+YBlZi924Jg20tr3B27NlunZtDJozbnrabCzZJEV23tvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SXckUSAY+DGPfDXkJboKPxE3MssJ1GtUolw7CVnKao=;
 b=RSAzCazlw2lQ5lNjrZz2XJyOXlKvrPaPaHiQfq2DSlDfPcyBosDZVhyhXpx2u0fFVEaJHHsglHSqgNRSfX2g0rntaBl4s/BfKVxHc9WTpE12/xKZdg8hVZZ19uN0V07LoUkzyBhTWjk1We/kVR05xQ55neBUXc4qJPs6365azhA=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA3PR21MB3961.namprd21.prod.outlook.com (2603:10b6:806:2fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.12; Wed, 5 Mar
 2025 00:00:58 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8511.012; Wed, 5 Mar 2025
 00:00:58 +0000
From: Long Li <longli@microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Ratheesh Kannoth <rkannoth@marvell.com>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>, Leon Romanovsky <leon@kernel.org>, Konstantin
 Taranov <kotaranov@microsoft.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [Patch rdma-next] RDMA/mana_ib: handle net event
 for pointing to the current netdev
Thread-Topic: [EXTERNAL] Re: [Patch rdma-next] RDMA/mana_ib: handle net event
 for pointing to the current netdev
Thread-Index: AQHbjNA/zhmjkp3O9UuGRnLmVPtXL7NjSSPQgAAYIYCAAEhD8A==
Date: Wed, 5 Mar 2025 00:00:58 +0000
Message-ID:
 <SA6PR21MB42318A621DA625465D88780FCECB2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1740782519-13485-1-git-send-email-longli@linuxonhyperv.com>
 <20250304063940.GA2702870@maili.marvell.com>
 <SA6PR21MB423174BA15D8A909CB2A6950CEC82@SA6PR21MB4231.namprd21.prod.outlook.com>
 <20250304194139.GE5011@ziepe.ca>
In-Reply-To: <20250304194139.GE5011@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4d9dfce4-2378-47d6-8abc-47dddc497aba;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-05T00:00:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA3PR21MB3961:EE_
x-ms-office365-filtering-correlation-id: be8bcbe3-8d5d-4366-1119-08dd5b78ced9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mIZ7psXEu6yTBEIzzZZvDJTl7oUF0eBSxMF/dI3bKHK895vGMCIPHaMw+dsm?=
 =?us-ascii?Q?cBMZ2I8eBQyGXOPdD5j12WXlVySwCnQttEFgyL9HC7eFJp7T9Oipe83xn5ip?=
 =?us-ascii?Q?viGZK6QldcLl9wI8H/2TTFuwGfrQDDZDiQipZ+gg2EszQZzNU2GCOFQZRCdh?=
 =?us-ascii?Q?jUolhq5uMEeGB1t+/ljrzlYeD4I9OvJNccguumJ6ntnW86ii1Q6AZy0sWJBO?=
 =?us-ascii?Q?yzX5/kST4Wmcm7c24UPKGL7mzxvRZ/zz9qMiExWLDOQp+4SV0B9tLpkDd32/?=
 =?us-ascii?Q?J9W3wcUoKp46Sm25f1XBZ8FNGK8T6K/MQJMA18/6QbW1WoFlufZqxCOBvg22?=
 =?us-ascii?Q?c+2STgnA6ubKnl0v2jlKafNJDoZkI/i0203HA8RAfQTyEuGoSFjq29UoG8LT?=
 =?us-ascii?Q?otQF6rOcIC4CDhjm8tkAehiKiDFLzKvNbVaUiJsxOHr2s3HHIgorcSSmelau?=
 =?us-ascii?Q?Ui6JhUSCAEFsctJAtSpgZW3e9LRvRi+sDGEs7F8HditYzQWZzuLuuQfqn6pG?=
 =?us-ascii?Q?vy1l9Q/hGlZJQ42BzUEFNBOPjkwZN4eNg7mv6dcWIVOZFZ+pA2zw63lZ5R3b?=
 =?us-ascii?Q?spF0VfqLKs7NP7ylrj3y6Pce61MFMhvUqWTQXcRs2k5YRX800wTyFGbCVgtB?=
 =?us-ascii?Q?FPYmZZfncsWoBg+ZD+BVNDCIzR4klOEbqWuaGMJxrEbenDRp+OL9M0nr6l9Y?=
 =?us-ascii?Q?oXfArf6R98VR+0oynR98jCTS5E98jE+7RxBnPAe8sCvZZTOSnPput85IDhhK?=
 =?us-ascii?Q?SoXfj+ZvlpamhEJS7RxemlPi4YJqD3Cxdn5Pa8AgCqdTxDXSvJMiaF6x6zhb?=
 =?us-ascii?Q?Pd0I6rNOR5aua0Dvmn9mWv3nUZMeGSUAqqDDEbxrHMr7nuHX0w1EY3wljcdN?=
 =?us-ascii?Q?CMfeRjcdTz3i9uoxbgpLjbHcdiE+ReHGtVLC9pmxLvI78yOmYe/WNYDivg5P?=
 =?us-ascii?Q?/C+Velto/hatxV5/56Fm6gyH+lhoHJYka9eMSghvFc/WSzVvACsrhimA5/H5?=
 =?us-ascii?Q?ZDAxiUqO1zBFWh2hDsUnSw3OezZAqjXCIZCXJSghaKiOxXNI2idctfuyKvxL?=
 =?us-ascii?Q?oISzO/Nd7BCDhd/xrykHHNjpE7Tzi9TbA0WBQydsE9Pt32fMJ+pJXxsmF4YC?=
 =?us-ascii?Q?tfS2Qm/uhmSlU/uYrQJaHsej/l766eBOz0ovHKTRBA9FSwdkiEhLK9JlZUZk?=
 =?us-ascii?Q?Fumhv8N2WifvvtogHox+SzvehSVDQJbWoBGJfN2RJ4oWRCMNMlFId8uz3ZLC?=
 =?us-ascii?Q?4uZuG1PJN2WpIH++keGOypgNyWRfKoH153p+2TX6zdHdyPs8+xgyZRbzSsuH?=
 =?us-ascii?Q?Hak2gmKjC9TUDz0wxYysql+kSxHt4FrCre2AqZVQxZ7aOVPEBRvBIuWXplZm?=
 =?us-ascii?Q?kw1oHLvKLKt2Fwmx8azZG5QcTKssX9pkKY0vH9zZXrlQI6kiIadvetwUVK2r?=
 =?us-ascii?Q?xNPjCD9wMTiaIptB0uQmtYfvy70CP6An?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aUg3qurD7n6vgZ7jJpSeBnmCxXNkb44TsPIBuZ5pE44FQaCtx/0qr0BkPZ0f?=
 =?us-ascii?Q?o3D4Ys/MnXQnBbd9Iot3fQkHmD4F8Lxl9T8z/RJcQiixMfNvMjmYiiVd6WJN?=
 =?us-ascii?Q?rbhiY73NywMzyvE/hHgxpMYU1/tQ+zmUhB4upJ/Pn7jrK54hHR3JvrCIdTbL?=
 =?us-ascii?Q?2CNcB3E0JoTAkFxDZD+r901hcGepkxfwky8HHRiK5iwdZ7CrS3xaCOzTlKb7?=
 =?us-ascii?Q?mFse8n2aaqFPfHSX9FAt7DLUACtVZxmziaVI71aJ9h+n0/bD8csazXDdBwCv?=
 =?us-ascii?Q?vMLTH11oYLivzPnLiyUVVc/mHkVZbqj9iWop6Y322gGsqFR6idCyScBp4TqD?=
 =?us-ascii?Q?8S0cJJ0X3+FcTSWXc60Pbl/QSC3tMG5TQOZCkqhgcDWGFshGqjbkSsRnmgyp?=
 =?us-ascii?Q?eb2pJdK9J1K5cSe0rMil0VULY7dfATAUULR5CC9/u8V1rkBOPMENT+2kZSzN?=
 =?us-ascii?Q?zbr3bn+VW8T57V9vKBctQHgPyGBTBqgxRpx3hpniKOEXHzkXQTGWFd4Vmbct?=
 =?us-ascii?Q?Y7PoKS94ISoC6KVZ41G/zvdRhnakk/VDeKNk0uZVLynsknLMxEd+8SgquW6a?=
 =?us-ascii?Q?lDaFzFpoj1YZ1+Mm6iYhdlkUZsBH5nESxW/Emn9HpHCPsg10xvjvu95ZZ3/E?=
 =?us-ascii?Q?cDNGFY5fQ5YHwYyjiPoYoYyDusedfwjIprgVEWcQqW0U5qexICUIWgD47Gct?=
 =?us-ascii?Q?0yP1y4YU13WmzIg2/C2fRg7Z+x8FupUYz0Pf/QtR2IpBxQ7UI8BvucSzw2Px?=
 =?us-ascii?Q?Upb+wrblc4OVPb8Aj2BmhymamuRfu/NybTZfHbv+r2rWuQ37Igmzk5bK0Wvr?=
 =?us-ascii?Q?vkJiEhE8YgMP3SF6Fs3L/yTahTDOuCw0ypUcRpwYG82xoHZr3a0iXwrGA69F?=
 =?us-ascii?Q?qTQB3E3c0jo1xAD4r8izTGPTX5bli+LlNsc6D5NMILntzrrLbib7JMzyfxtC?=
 =?us-ascii?Q?7MAgV6YXx9jGeMgnRvhRoze3fpyiaXUbA/NbeyULetYeBa8k+e/c3MUpcplj?=
 =?us-ascii?Q?w7bbi+WmqRdFgBP2xLNnJMzQZXDM9ql3YIv3tAcEDPm65FKfreuzjFnrO/2S?=
 =?us-ascii?Q?ndqM23QgWbZCxyCWIU56gs1BEXytf5aLiFj3/S8lFarPTp3MmlccC+qnLhCJ?=
 =?us-ascii?Q?6sXKMxG9CwK6dPPnCyjyjaKwAuJf3tj08vGxJXF/S2twcQyMTppOQw1LA5Mf?=
 =?us-ascii?Q?/tF2tSTR5JhXAAxWWaCsfpFmETP/b5O+r+0bXKCWb4fsWmg9IqYnA5c08Vfo?=
 =?us-ascii?Q?vRnqZi1M2vNSdnPFx/4va+SzK9Hd3LtNCkDHT9HeEklA02ymK3BPwu/ALXE1?=
 =?us-ascii?Q?uA1cEJGyOARe7+1HIzLQdobGJmzMFM46etHKZARRGnmgNRbng0G6l/9EN7hP?=
 =?us-ascii?Q?g5UyjWFLumNyNqqFpvVb95POGH0hkHsI2LhmgivUQ4SxyocMcmGyQfRM5ImP?=
 =?us-ascii?Q?PZAuFhG4b3Fhq25NiAtY+3EPixJu6uuC4gQqzu5tQf/LSPr0DeWdVsEjFGFj?=
 =?us-ascii?Q?9tCbX4upZpbmeiRC3bFVr9QGGjwa/bp0iIMTMXZS6ZFEF9eS9Akp+98+1nfq?=
 =?us-ascii?Q?HBvnjb0mrl19ut8bUytRoGmSBNAMKQkxCv8sm7kWrKBUqqrs1ftObreWJf/8?=
 =?us-ascii?Q?jwSkIj8bAgje89aIMKyQu41al7UXxTHx84LrPqfty0pz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: be8bcbe3-8d5d-4366-1119-08dd5b78ced9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 00:00:58.0609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ylbU+AskvrZtpOMByBrgycl9Zo6ZCv4P1Fo8p6Yb5K0SQsCl4Hh5U+Q+PBWPwzphD79sc5cTeUn2gGD48Xdk9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB3961

> Subject: Re: [EXTERNAL] Re: [Patch rdma-next] RDMA/mana_ib: handle net
> event for pointing to the current netdev
>=20
> On Tue, Mar 04, 2025 at 06:26:03PM +0000, Long Li wrote:
> > > On 2025-03-01 at 04:11:59, longli@linuxonhyperv.com
> > > (longli@linuxonhyperv.com) wrote:
> > > > From: Long Li <longli@microsoft.com>
> > > >
> > > > When running under Hyper-V, the master device to the RDMA device
> > > > is always bonded to this RDMA device if it's present in the
> > > > kernel. This is not user-configurable.
> > > >
> > > > The master device can be unbind/bind from the kernel. During those
> > > > events, the RDMA device should set to the current netdev to relect
> > > > the change of master device from those events.
> > > >
> > > > Signed-off-by: Long Li <longli@microsoft.com>
> > > > ---
> > > >  drivers/infiniband/hw/mana/device.c  | 35
> > > > ++++++++++++++++++++++++++++  drivers/infiniband/hw/mana/mana_ib.h
> > > > ++++++++++++++++++++++++++++ |
> > > > 1 +
> > > >  2 files changed, 36 insertions(+)
> > > >
> > > > diff --git a/drivers/infiniband/hw/mana/device.c
> > > > b/drivers/infiniband/hw/mana/device.c
> > > > index 3416a85f8738..3e4f069c2258 100644
> > > > --- a/drivers/infiniband/hw/mana/device.c
> > > > +++ b/drivers/infiniband/hw/mana/device.c
> > > > @@ -51,6 +51,37 @@ static const struct ib_device_ops mana_ib_dev_op=
s =3D
> {
> > > >                          ib_ind_table),  };
> > > >
> > > > +static int mana_ib_netdev_event(struct notifier_block *this,
> > > > +                             unsigned long event, void *ptr) {
> > > > +     struct mana_ib_dev *dev =3D container_of(this, struct mana_ib=
_dev, nb);
> > > > +     struct net_device *event_dev =3D netdev_notifier_info_to_dev(=
ptr);
> > > > +     struct gdma_context *gc =3D dev->gdma_dev->gdma_context;
> > > > +     struct mana_context *mc =3D gc->mana.driver_data;
> > > > +     struct net_device *ndev;
> > > > +
> > > > +     if (event_dev !=3D mc->ports[0])
> > > > +             return NOTIFY_DONE;
> > > > +
> > > > +     switch (event) {
> > > > +     case NETDEV_CHANGEUPPER:
> > > > +             rcu_read_lock();
> > > > +             ndev =3D mana_get_primary_netdev_rcu(mc, 0);
> > > > +             rcu_read_unlock();
> > > ...
> > > > +
> > > > +             /*
> > > > +              * RDMA core will setup GID based on updated netdev.
> > > > +              * It's not possible to race with the core as rtnl lo=
ck is being
> > > > +              * held.
> > > > +              */
> > > > +             ib_device_set_netdev(&dev->ib_dev, ndev, 1);
> > > rcu_read_unlock() should be here, right ?
> >
> > It can't.  ib_device_set_netdev() is calling alloc_port_data() and may =
sleep.
> >
> > I think this locking is okay. This event only comes in when:
> > 1. the master device has changed to netvsc. In this case ndev is guaran=
teed to
> be valid as this notification is triggered by netvsc.
> > 2. the master device has changed to itself (the ethernet device parent =
for the IB
> device).  In this case, ndev is valid because mana_ib is an auxiliary dev=
ice to ndev
> and it can't unload itself at this time.
>=20
>=20
> Why not return with the netdev refcount held so you don't need this weird=
o rcu
> thing?
>=20
> Jason

I sent v3 with netdev refcount held. Thank you.

Long

