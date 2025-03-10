Return-Path: <linux-hyperv+bounces-4346-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9910FA59CF9
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 18:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C998116F2B5
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 17:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDDD230988;
	Mon, 10 Mar 2025 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PavR5VIr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020077.outbound.protection.outlook.com [52.101.51.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ACC2309B0;
	Mon, 10 Mar 2025 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626982; cv=fail; b=ZlRUPZiI3RJ+tgmAc4HL34ocLtogWgWraDy358xsRZ10bx+P1q/nJsDUiCeJhu7ff8+qnzK1pOAvGoUuNFDsqz4JfLjtlpZJQQkS4C4oTBK8UCAESQjaT9PTuKBDIUyzUtfC/qw8P4nda6mp5A+QYyCmXvpxycwvJcO1t5SMRhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626982; c=relaxed/simple;
	bh=UsKy06sollo+BC717JU8LXYxZpkgcDGoeY7n8TW/+1s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FIyJp8mrm9xD7zMH/DqA4q/NDexLsbjboTDFQsq1CyH7GugGFrgNsCsbc/Jcz+WCrNf36CobbpJUuq6WYHqZxK/496xiISYFRr5LnoFlQSBsinMxdfpYy7dZN/fWjpIMSWQkOxdruOBN9faNaeeb5HGf7fI8Vk8gljw8CuTml1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=PavR5VIr; arc=fail smtp.client-ip=52.101.51.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZ84JCuIGeEi1E4gmw87jIHIfeK8Cg654LjcwZ0wl5/cGO7aenNvyrXIdqn1IQrPBzKcbWuQBdSN6C6CqGpEEmngMkExJFH+k+PuB2W1rUDfSOPILS2Dqvx3HHYQ9CE/GKtME52DtLEd09FPye4dA9BAll/hd1GaGi2VA8OaWQpysgwhOh6FON+PCxkrLmtp3eKe3Fdfm983OpWtnWa8EJPvjFGJpq8htYZKOxf26EGVE4doHHxLQw94Yh6cNF67bGYivcw/01cF/QaVWj3xUQNSTjayuh1Hznsg6Hn8jtpFcAUzTUunwsTzGc8fA31tHWQlFT72504Ko69VoHBOCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYiReV62QIWjpqMgplLIiT8NmFNt6Zrv6psbK/5RDmI=;
 b=j5ivMSTuVkKxtW2kPqVbYqjxUyJGNBRkUTQPOZROmm762N4DB2qbZTGe1mY79UYmrJI7ZQmr+VjpHpYUXeT3I9dnR0Ay3FiSSFaXVcpfKq4IS6tCZpksSuictctqb659iGNEAgNdG8CGORUh0a2QJ4tioRAU9PG9NDec3pnkBQeuL2xxZnLoZpBmjnFVp/q01CiQjSmOXyPZdbz1UBr1f7/txlsmMCuTApTOivK4yFj4/TQkjDzoF1A2cBy6RS0hM9UDKcejyKTyPLp6RLSdUkYTwcEu5bibj2kF2VCB/it3R/dMS6PEJrEvNv6VWDXKvU3qLI1SZgvDhB5r6828oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYiReV62QIWjpqMgplLIiT8NmFNt6Zrv6psbK/5RDmI=;
 b=PavR5VIr9RJmE76gjFXq3h0rnq0X8ev+CStYpE6t4agxUbp02GuUmaWcFD0NAzixlBqyrnSuHKW/AINDVsyc6cLi8oj8VDiuNSWLzY/urQpWh7dkRZmz003NGGJmMfn1MJX2QdDfrMQU3YCoKfRVeIEvQi1WXsFj5kaRuBFS1UU=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4534.namprd21.prod.outlook.com (2603:10b6:806:424::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.18; Mon, 10 Mar
 2025 17:16:15 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8534.012; Mon, 10 Mar 2025
 17:16:15 +0000
From: Long Li <longli@microsoft.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	"longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Patch v2] uio_hv_generic: Set event for all channels on the
 device
Thread-Topic: [Patch v2] uio_hv_generic: Set event for all channels on the
 device
Thread-Index: AQHbkLbABa8gGB7X4UeqrCpzK0MNDLNsnU3Q
Date: Mon, 10 Mar 2025 17:16:15 +0000
Message-ID:
 <SA6PR21MB4231D4A8F6D942B405777BECCED62@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1740780854-7844-1-git-send-email-longli@linuxonhyperv.com>
 <20250309054727.GA24737@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20250309054727.GA24737@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=82ee0cec-2669-4a88-af78-e5a864771371;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-10T17:10:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4534:EE_
x-ms-office365-filtering-correlation-id: 4368f681-2fec-4c8b-53a5-08dd5ff743f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ehGQQM1YJ9JazU8TQJjDAXrbMiJvAo8Zu0JwCb/mtQM1M/QPwO+BsjyVAwRY?=
 =?us-ascii?Q?1+47QObANAap2XTRn6Rfv/+7vmjuev5UjuZ+VWLS18NT32Xo3JksW2d40vdc?=
 =?us-ascii?Q?y32DHnh2TueXvPZvad/xgMM52dRBqSQ6oZriq/FiS1Gt8Hyzty+7ofRNRH3+?=
 =?us-ascii?Q?nk/csmA3tQjWYXi0tDSHEcCqBf3Nhs/W/x3N0X6qOphY1GGiCy5JFXGHw3LQ?=
 =?us-ascii?Q?ROQYkXhDqAw7aRmqT+5xF2bA1M5905U6/0OxvaRL+qw2Nyyuw0Ssr1eJFW1s?=
 =?us-ascii?Q?TjhXd393kD8WczHRfff4DFWPOw3fd06Ijzhw9YpGHUSiUdkOPAxQpFz2A7Qn?=
 =?us-ascii?Q?9XQmvB4iFKg4eRp8ICfvPvXxu94KChtOk6C0BVQ2K+YffXNFZklW0niXP58a?=
 =?us-ascii?Q?QZcxDZrLUf9vnuF44LOoZ1GIsqJbwqOKcADOaJqJVXsQwdHtQyAmKQDcW9Z1?=
 =?us-ascii?Q?omuEOGgRNLoeFCoJUWCpidHCyjeGpdpXnjYPgyNri0aiVkvkWQbHDiRdusRV?=
 =?us-ascii?Q?pDzTyQgfI7xh9sJ/e9yU8CjfWC9BxCIQm8R0bNbv6eGzDdWrl1+U416ez2PM?=
 =?us-ascii?Q?LcA8qjxuzFXtLEDvju9AIDijUz9r7KCa0nQ5wuJxzeNYEqR0zlSFQU+ZFUAf?=
 =?us-ascii?Q?rZ8rGlk4VnyyMYUzEUPaSgVTCj8Il/eoDe7AIy4DdhKxJE04KnPPf9x5LOGS?=
 =?us-ascii?Q?Q6R9fgSgVUn4sxyo1eUh2bf9WFEd0Yj8wdiouCySWFD+lKNSX2QFH9Atvp0J?=
 =?us-ascii?Q?x61HKehWuzDjXDJGvYEY3UnHhq02RK2U5Z6PLNlcnRtySRlxTf+UTcN1VPOR?=
 =?us-ascii?Q?tBtQv1M2/z1+XozEam9L5LHJlYBoLsP1x8a0p6fYsVYLI5OcVGaz4M3wM07e?=
 =?us-ascii?Q?vIwgkHKOxr3JPaXNV5nIZJjeCjKSdQT0oHUF9MIELE7+dX4c6QwRIIgAFUkz?=
 =?us-ascii?Q?Q9qGB1F6El2U8p04LVsBNLpWWBc0RJ6zYfQlUnxazs9w5qYxw8yvrQdSGyMQ?=
 =?us-ascii?Q?k8QACop10uxnv8MlAqwYh+eTrSy0LoX/Yu2ISuxFsJL7LnsffuMwib1hFXI9?=
 =?us-ascii?Q?hEk+u52seApNcIEkO0kY3mMdkxHDRwlS5hJHGOCSd+FrfRNpYP055knDBPo0?=
 =?us-ascii?Q?s5u3tCjDIUIfYleWjZ81iK1B1YsgB7E9VhdHGDLJtsSqb2qk7chbtRPgPTde?=
 =?us-ascii?Q?xz/2Tev21cTU4YLUnb3DeT6C0pky/4vclhCU1aoBr3Rvxmtop0rHKZsa2PTM?=
 =?us-ascii?Q?3/ls/hrtFtUuTp3vEskmS9UE9dsc0530KUCGkOkscHq9j8rjOqs0FX9FuuMO?=
 =?us-ascii?Q?Co5im+cQr8QrwMwc3x+6hJd9K5c7kPptqEgDhYKJYQRFAgpuyr0s0KhVKkZW?=
 =?us-ascii?Q?n2ytTCq5rjHgwmpxqC4N7PKrpfLLK29EMRkIh3us72VerCO57JHyHCDe+rZM?=
 =?us-ascii?Q?rrd1Jv06aM/jes9CIX7NF/Dsb/B1co2C?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Bn8cJkZZj1lT0O8PfkkAls1LqvOInuLqD0QAjLD9m04uA5HcqtcydR4lFlqw?=
 =?us-ascii?Q?+MasucFlnrPTUD6/tiCK3a5SiRfXhgINzzjPvN/w+mEomhjgRDC5Qc8D9Vlv?=
 =?us-ascii?Q?RQsT8BJ5Wii6yYsBpBwLf7/SrRmtx6k6pxJRaxyzljB1XPK+rb+lVAEzI/R4?=
 =?us-ascii?Q?NJgKPKIrKe1VYXlzCbottvXKHqTjY1pOIeZenZ7037Qfm5oxNACdWdHJyqZH?=
 =?us-ascii?Q?gcUljUGBX5qEJl0V1UvJIfGBcFCh7P5dZIAqhxz590Z/KJQZhzv8zPHEond/?=
 =?us-ascii?Q?CcwN9x74epBywIYNWw26MoLNUDoe6J7UrzEP1Jqe8vM3mTKR8XZ+M/TbEV/P?=
 =?us-ascii?Q?dSMNVGvJgsgxL9l6B1ETyvmcHfYkE6HlarXgpTNDYr3VfH7dI4M3JtUaWNMi?=
 =?us-ascii?Q?EBag1TA31CzRQSujHGMf9luP8bEv7w5ay5RtTs1Czgpls0SxGqdyaifWKLRY?=
 =?us-ascii?Q?YEtj2gO86h3fmb+bILUxb/EnEhezBHiO8Y3okOazcoQn/37SamLDweSsZ+XL?=
 =?us-ascii?Q?Nl2Z6uIc+UKMCTmuKti4RQmJ7azRwu0ZLaD91A3j2xUZKPxW/G9S/YIlhnoi?=
 =?us-ascii?Q?qILwSyK52BjtgMadCO15rH/l/iYfVMZUE3ks8laTLSI+5wwCP1nbA0cWTsPo?=
 =?us-ascii?Q?F6Q1P9zBbLg/nErbwBJUkm05YyAXgH9xmGE/ZOoF2crpfrLIs/lqq0JZMpER?=
 =?us-ascii?Q?QVU4qShz6gsYzNgitPAzBNcQJAt4NDhoI0Sy5tb4igZlDxljByTwnio/9T59?=
 =?us-ascii?Q?pSAibr5MnWv5F5aXVi1h32UUIVI2iCpZvcX6jLz/HJiuKRuHiou+fzxnhF2o?=
 =?us-ascii?Q?P9/jJ0xrqyc7FNLEHWJmrm0L6wIE7raMHbRkAQti+CqLyafW4EwQMxK3Kb2i?=
 =?us-ascii?Q?ZByrxLsLRJKHFflPQKt7kBKkkG+5I1u4+6Ug9nMMnkgTzM0lklmv8ZuOTDdk?=
 =?us-ascii?Q?zUY5prmpwLSeXB/J6l8z1rvSyh3fZ5l3233xHrz2s5wBgMFrAsthlJu0P8fT?=
 =?us-ascii?Q?I2aNtF6MnmK0t2lL7e7h6PSp8Y1MMQzWVCCEom8Sbgh0D0YvinX0r7RZyLlq?=
 =?us-ascii?Q?VNzHZl5eg3bWlPBnuM2Fcd0+rVWM3bVqBdHDL+g0iSe02XPBf77Sk6yTXpz+?=
 =?us-ascii?Q?83YzQy8UQM2hL15tiFW2Aex4Z3r/EUERepBTL4xp2bLTfhBDQbf85ZeMjlj6?=
 =?us-ascii?Q?oHMlbbzsuUgKQm7gKBZyMd2BAZ9gYHPo9hk6XqH0UpmhhJ6qUDHzGjJIP0Gx?=
 =?us-ascii?Q?c9EHc/cX1SFLIPBmkvit81Afzw2aDrKfgqa+nzGdpcatl5hBpuHjuF/YmFL8?=
 =?us-ascii?Q?g/w7hePx2iEXSiX1S6cNIpWcXGfLgH03LxBLUBWuxmA1ohaM65izNsACINYL?=
 =?us-ascii?Q?91lVSF08C//mqu/qT76rtaNIpjPf/Yl3QMVgKQJG/tEhFL6awxTtC47C5QcI?=
 =?us-ascii?Q?jXxXoyHgbbw1IkIrthFqfF64Vmy7v23+9ZqnT86DV3bSFVtOt9+l8dAvg+s9?=
 =?us-ascii?Q?d16VE8R4tLAgpyr0JSy772sp5k2SpfUjgxq1wv+FAuyZsa3zlaHQWoHq1Ok5?=
 =?us-ascii?Q?bvrj+thkzuPt9SOrOOY4Z80x9hEZ24yzRjjhxgU3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4368f681-2fec-4c8b-53a5-08dd5ff743f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 17:16:15.8247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HTkDkkRKSSBrWPwskcjv8GR+Wb8lLjn6FS7ZqoI9DvF6Ep7Cz0dz9gleaeCmvzso3jSn4YZiTFv2k9S7xXmbJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4534

> Subject: Re: [Patch v2] uio_hv_generic: Set event for all channels on the=
 device
>=20
> On Fri, Feb 28, 2025 at 02:14:14PM -0800, longli@linuxonhyperv.com wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > Hyper-V may offer a non latency sensitive device with subchannels
> > without monitor bit enabled. The decision is entirely on the Hyper-V
> > host not configurable within guest.
> >
> > When a device has subchannels, also signal events for the subchannel
> > if its monitor bit is disabled.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> > Change log
> > v2: Use vmbus_set_event() to avoid additional check on monitored bit
> >     Lock vmbus_connection.channel_mutex when going through subchannels
> >
> >  drivers/uio/uio_hv_generic.c | 32 ++++++++++++++++++++++++++------
> >  1 file changed, 26 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/uio/uio_hv_generic.c
> > b/drivers/uio/uio_hv_generic.c index 3976360d0096..45be2f8baade 100644
> > --- a/drivers/uio/uio_hv_generic.c
> > +++ b/drivers/uio/uio_hv_generic.c
> > @@ -65,6 +65,16 @@ struct hv_uio_private_data {
> >  	char	send_name[32];
> >  };
> >
> > +static void set_event(struct vmbus_channel *channel, s32 irq_state) {
> > +	channel->inbound.ring_buffer->interrupt_mask =3D !irq_state;
> > +	if (!channel->offermsg.monitor_allocated && irq_state) {
> > +		/* MB is needed for host to see the interrupt mask first */
> > +		virt_mb();
>=20
> Why is memory barrier not getting called for 'faster' channels ?
>=20
> - Saurabh

No, the memory barrier is not needed. Even with a barrier, There is no guar=
antee that all pending IRQs are flushed when hv_uio_irqcontrol() returns. I=
f user-mode depends on this guarantee, that user-mode has a bug. This barri=
er adds unnecessary costs when walking through subchannels.

Long

