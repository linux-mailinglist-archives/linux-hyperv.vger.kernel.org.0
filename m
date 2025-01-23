Return-Path: <linux-hyperv+bounces-3751-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2875A19D25
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 04:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46297161ECF
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 03:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5046F4F1;
	Thu, 23 Jan 2025 03:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aDytep7H"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022126.outbound.protection.outlook.com [52.101.43.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F75487A5;
	Thu, 23 Jan 2025 03:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737601735; cv=fail; b=eLkDWd/a/vfwAAx+miHl26pHK73VTytfiNHI7MkzmnAtBsSeMsRs1am9CkWar2RnwgPZoV3dhoyaPCf0mkWzaoAF8UV7Ak8gd1Z1LR5KyHXNTeSkhgTHfEu/ha1NM3sHY+mAap+EZAWPXXUILsnBhdu3r/4EnxHLObW3S0Tur+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737601735; c=relaxed/simple;
	bh=yYLRVRLel689K75RKbeDeK0GfODM2FR9p8Gz1sPlXh4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gGAZUkBt9BQRYkj5byYg+4XHM1v+VBiqxNKoHYVfnGk+uyZ3AalCR1ICQlV9Fpl9hNpyDWyEpaCfzAJWTs1SNPdZLul08tYha/x16PEvsbJQv7RtVLH46Bw5nYf2g5u0K/Hp20LYlM9TBnmI4WMfOFgR1W4QZT6lil/i2d/L8aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=aDytep7H; arc=fail smtp.client-ip=52.101.43.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aruri3DbX6fZzBzZhj+QzCb+18TiLnwoDmelWGfjWOnBt30KWV65jyyIfyvdK0yGdk6dIeLhPV68xQ1TQ0C2Tif0Vp+9UwF2/GuhCmc1fNzortgSSZb4bS0BQf/C6T7/N9e5BbfFU0me2/D7+q8XYjA6b+XWHb7Zs/mLMPRYs0uYChVkSkhK16zDd+6k4PCFRAg6dR0M6DDCWipqxTc0qqQVMROsZBBKlmVxuoTAEIv51OFuGXTWUA7wkTLMo/zRJGv8OZ5ozkvShGY1uAepS50P0QrTCHxggEtWEmeViTra7VKczS0HCA0lLtn0Ht9NwAs1kKsE5wJr4v8ew/2I4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYLRVRLel689K75RKbeDeK0GfODM2FR9p8Gz1sPlXh4=;
 b=EC8JnYECulu6HZ1Gu5/8H6hTmq+JDyY7BCXaCC25S8eDKX0vYsO8t/0jiFwVI2+XER35Tcva8jheHshU9kWEpjJSFdMpQ+ioDa7ysSCmRE+iFtw8XyQoHdYafOZpPTfXUoFldR0asg/6ML6lysgpL55kdK4sOaNOgylHtyp4UN6LNu3FVWpn620jvgyYAsX94CQ+vwMaBV5svPh6FCqPLfiB2HAaUhGFxA91+3/eUIsWpweMX7vj4HuEQAShOpPX/awZz/7BMo3XltPaeZn4chPawIDfDTI5SqMEJJjn6T7PH6m5Ho6iaLfkarKYaT+HmZ4ihA6IQqQ/ThMFwZpbXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYLRVRLel689K75RKbeDeK0GfODM2FR9p8Gz1sPlXh4=;
 b=aDytep7HvD9KigrFWeswtrdT20WL9F3pKNw4NVkN8SvkDvcfavrv0cLU/3R8D2wMUUZEUFrNq6J8xc+VqgA9GLHf2+y+iL5FObvrRgQEtpdBidyFc93PMlIb9fj9NsDVa5lRbuKy1i1pA9r7Qay8jgL1uaXHMh/sIEnU3J7bT5s=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA1PR21MB2052.namprd21.prod.outlook.com (2603:10b6:806:1b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.7; Thu, 23 Jan
 2025 03:08:51 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%5]) with mapi id 15.20.8398.005; Thu, 23 Jan 2025
 03:08:51 +0000
From: Long Li <longli@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, James Bottomley <JBottomley@Odin.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH] scsi: storvsc: Set correct data length for sending SCSI
 command without payload
Thread-Topic: [PATCH] scsi: storvsc: Set correct data length for sending SCSI
 command without payload
Thread-Index: AQHbagGi33dHDMlkpUquI/gnvyhfYLMgR6ZggABccQCAAw/dUA==
Date: Thu, 23 Jan 2025 03:08:50 +0000
Message-ID:
 <SA6PR21MB4231FB8BE368335A4EDE365DCEE02@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1737071998-4566-1-git-send-email-longli@linuxonhyperv.com>
 <BN7PR02MB41487C2C9BA6B963758E722AD4E52@BN7PR02MB4148.namprd02.prod.outlook.com>
 <MW4PR21MB1857121CA82F0CE544F245BFCEE72@MW4PR21MB1857.namprd21.prod.outlook.com>
 <SN6PR02MB415751506B4B116CFD081939D4E62@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB415751506B4B116CFD081939D4E62@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=563ecf69-e157-4f2e-b3a3-9ba714c38af2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-01-20T22:51:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA1PR21MB2052:EE_
x-ms-office365-filtering-correlation-id: d7ca1874-35b1-445e-7185-08dd3b5b4301
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8qAlYRFPXJDH6YLxIMp1eQoDbmXI6aK0qKbljhGbpDzihLU2wqtao0nqie5/?=
 =?us-ascii?Q?r/ZJSS2RPm1czen+2JKQ6k4Ylh6MtmPr+JowkBYG2SYYmf/YdOIkz1jlAeKW?=
 =?us-ascii?Q?pq3Xmew9tEHiX8FW0PeIGqfkiIIc5skaCCkp9rEDmyGXXK/8HO80boV8HC4k?=
 =?us-ascii?Q?cqkHkmfrTwxpnY5EcRrO8a2wCgFre6udBM8xpa9/uHJsKxI7/riWV47vVuQ5?=
 =?us-ascii?Q?fSwn0kn1GkIAL8kLz5nt8gOEKp5ZJEM6VhvMJZ+ka6hhgItisiHma3lYAlrG?=
 =?us-ascii?Q?IXLud3LUS59MDvoSZbF7vI9h4enH+8Iq3akW1+zLoRQxdSN0+oiZ0UImU6dV?=
 =?us-ascii?Q?MA4YDLLE6QHpTodJCj56ka1L4nPSqc3obA4PIxSW3utm0qeIwdC5gnM/qPI7?=
 =?us-ascii?Q?7OXXdv5lOt2lldPZzA92EfCHsN3E8JKvSiCfnuAgvW9OJtvSztgfpyT+5leh?=
 =?us-ascii?Q?ZMbqVaCYfn2rA5bBXIeaESccRfpHPrik3w/YKuT+3/SOSZloeknUZC6vvYu3?=
 =?us-ascii?Q?j+/mWbSpBr0gtu/Wsurl2SvY+lveWFDf7zxlR7tLHrza6ixB1xx0oy/11fSK?=
 =?us-ascii?Q?Mk6iREoGMPXzlMlJqd4rxvcazXCKt3PUKcdCnGYBOsZOl9kAfHKTXW0V6MGz?=
 =?us-ascii?Q?oLqTFOb72OgRNa8cOjpUZUSftpwU5MZy85CdcAQa1xbK2Ll6Ks3KlIj2UnPz?=
 =?us-ascii?Q?Rvxf61Qp1gCbvTM5WuGPahR2cHCZy6YeeTG8JZsQOPCn0i4INBsWFZXplHAM?=
 =?us-ascii?Q?7V6jvKMWiHTHew7BNtZJVYTzFLPpjX9l/K+bhEBvYAH9d9JMUD9e6HKSxvGc?=
 =?us-ascii?Q?rfFHmN/H3s2VbyN/NksLMeBos1/CBvPhkQRs7jf5CBOb+aOrKcQRhjRO1Rta?=
 =?us-ascii?Q?4WvBqc/D4cBFK+aBYiHnbWVlZP74V8sdKYBlv5BSq1Cl0rqmzL60hhEkysu0?=
 =?us-ascii?Q?42i57AAGpDIZU3UJTYDxMzld2gSdGnxDO623MCgJxMUByrVgM1j/OLM4Gz4v?=
 =?us-ascii?Q?+TOTXKE4GK5WFFmPrdujVEp/nlHpgN2NdJ6WfhyaGrT86CTH/bC/k3sCt4o9?=
 =?us-ascii?Q?bLniNPlZat8KNowlfuZvGbURSV0Hzue+GWP4cZ6dieJEGFu8nJl0ASUynfWw?=
 =?us-ascii?Q?RNAPxJXCYWLgeutpkBSLu+sDv/mNDsqRwy59hlaXlpeVzFLoHdc8C4++aX9V?=
 =?us-ascii?Q?n2Y2d3rIrTUw8TXIuPWQo13lDNrpPCS4fPphGyzFUCEyMDSc6h6skVJyXam3?=
 =?us-ascii?Q?Vmd9ypSuOJVAz0A7h/B54x2nZsAyjIdCMHfAW0OGDtv1wikP5uRczjaaenmJ?=
 =?us-ascii?Q?nCTivjNIJjmF7B1swRuPv8ehqwsSOt0CMLryvomjz2P+xJKv+W7cFVLrjOxs?=
 =?us-ascii?Q?EUcPCFnIanoTA3RaeWPhpH/ByQ0BRBNMvSuUQ7BvZYLyri6jXv4QGV3B8oxV?=
 =?us-ascii?Q?xu7dN/P4Xo7oQT0MB9Iutyud961i7HWMGr2APhmfteZN36tXsZsVDA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HfecqMIcPp/MX+kRFGQxhu7c1XQAENOI34/w4QGIuVGruOQmUfybsUXcOP5m?=
 =?us-ascii?Q?oeRIfgbRHtqV1uDD/B9cOAyK3LACIpoXWOAfQZgIYJVo2TjnZVOlo2hmeIYl?=
 =?us-ascii?Q?M1IAwJLmjymIPBvHIAwstnO6EKe0UbGyb0Hl2pKpKJ2HMWalBpL9j09DLcb8?=
 =?us-ascii?Q?p84VpRNonQYQDU96oO36EKOcLYNcbbmYE8PLRcdbx5aajA14nFBibzt/JHjB?=
 =?us-ascii?Q?WynR/bpfK3iOLqT7z3dgbEBy2FBq8mHBn9avvy+ek3uZ1nA8Dp9YqNtFeBlD?=
 =?us-ascii?Q?cjTQ+lQecj9b1nyZ7rWnGenkkxvETDpoCjoDRpYKY6lTavFpM9fGi2XvXAIT?=
 =?us-ascii?Q?plc/2dNXqWqH8CTZMt2CZRjaLudWO+MZ+M3CPY6d/BYJFMOalUIjVblcuBwC?=
 =?us-ascii?Q?vF7uOmkVjtb6qzGacuanFtG7fBFiZ413yF5Vg80GdCgyErmueqqsyICtcM1e?=
 =?us-ascii?Q?svOEsW6GACJEtcCZoEPEw1eR+hXoPp1/+K5zxhdrVgXdKx5UjXh8mC/21dTe?=
 =?us-ascii?Q?mSlkv04kg7P/kYkq0UZKz5UvmC/URWFoG0jHzH0phFEYgjnACvrqM1ho6eS/?=
 =?us-ascii?Q?SAykyo0ZI4jCex7qUVjnsLL834/I7qqX8z/7U6owiz3H6SB8ahHMlsj0ODg4?=
 =?us-ascii?Q?LYfRP8aYY85QE4MhW4/KVl6J5J8rUvn5KOOKb2NEbdVFvN11uoV+IwNCZgLE?=
 =?us-ascii?Q?/+Yrp64gDKzz0pnl6gs8CjSDuxddCpdOIiv26nn2rMFHIeAxz6j2zmb+lK9i?=
 =?us-ascii?Q?CENbrI0kFplm1lIOopncG28Sdu343uBfoKcsZQ6o5gyRBdtfE5joMJkVTjvY?=
 =?us-ascii?Q?+yyArA4Ge+QpS9ryxheOnzia/s0CEsb0D58HrfzNN9buw3FxmwEjmKiHncf/?=
 =?us-ascii?Q?WcC/glsx/46+A+uC8Eg/VaoQQ5uIWiUKdvBqgceoR3AsSjMXRFtlj17iZF9d?=
 =?us-ascii?Q?nhAi/B0DwW2Meh3RasWkID00oMuUZKKZhyvArjcwmew3pwPTqOoDMkQl0pah?=
 =?us-ascii?Q?a5Ijn1WZ5UkeMxWO6hq/GqgDjdL4XDYQ/vE0MPrT7PaXfQlJnMWozkt7D4VS?=
 =?us-ascii?Q?WrPjFm07sx/on2DWNBd8l9dKeeXKQExsKM1JRclV8BHMkBYOyH7VmBf64CyD?=
 =?us-ascii?Q?sfbng/VeUzRWgF9RKLXnOg4WkLxRGc1SM0UPfIdO3SsLrk6dEkEbjkmpDZ8V?=
 =?us-ascii?Q?dQybeTtmcepGAQgMjiyztrwyNtK3s0jxKr8YVKAqE/B46PebZwLSVld31GC3?=
 =?us-ascii?Q?L+kN9HQCgHln8rgmbUPon7ndtmuYk4elUj7JYxnONPnm2ex0Wlc66VfKkKHO?=
 =?us-ascii?Q?tUjSSd52CVpHWTgkHiou7F/6fLNWtKXjZnybwX+fgIYbSQe0Ag/sOsJqpp8e?=
 =?us-ascii?Q?YRHduhkhliXPu1QBRy9+z7SlBHUT7SK3J3MWw6/A2I4cepj3govrYx3NBOBd?=
 =?us-ascii?Q?/hHkyy6u62SlDvuVvR6iis6poHnZXxmUMAEv4+BRbyAH0189l2cA3fpgtQeD?=
 =?us-ascii?Q?ZNdYbDqeJJ/0/IlN9Ct12ggDJv1ERcyK6f9RjzSaZK0+HSCGFlmTnVLNVLhX?=
 =?us-ascii?Q?iT8RjdCCr17xJp+0bFEfDtaGHPjIo4cxs0SObgrfWGZ3yoCGwUKlHO/QesaS?=
 =?us-ascii?Q?hSkvfSj0AC3Oh2XDbQpaUXdLSAZt0BKwFRV/Yp3jk6x8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ca1874-35b1-445e-7185-08dd3b5b4301
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 03:08:50.8232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VzIbXdlecOV3ZtDAKyomYzNd8qU6dtzKk+/NZuigb6AcTNPCUO8xj1/Lc11pEmWdafyB549pFSW5mhoXNhRHZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB2052

> > SCSI mid layer may send commands to lower driver without initializing p=
rivate
> data.
> > For example, scsi_send_eh_cmnd() may send TEST_UNIT_READY and
> > REQUEST_SENSE to lower layer driver without initializing private data.
>=20
> Right. Thanks for pointing out this path that I wasn't aware of. My sugge=
stion
> would be to add a little more detail in the commit message, including ide=
ntifying
> this path where the private data isn't zero'ed. Some future developer wil=
l wonder
> what's going on and appreciate having the specific reason provided.

I sent v2 adding more details to the comment.

Long


