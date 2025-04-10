Return-Path: <linux-hyperv+bounces-4870-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7237DA84CE3
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Apr 2025 21:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 622A37AF703
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Apr 2025 19:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF06290086;
	Thu, 10 Apr 2025 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WHzYBZza"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010013.outbound.protection.outlook.com [52.103.13.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C882853EF;
	Thu, 10 Apr 2025 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312967; cv=fail; b=foKK4NBV6AEIdQqqFYTHFzfjHjBWXWhv1V25haNLOP/mo8xWTfHOJIdY1OTm9wz9Jm7ZGWb1f/3wR7eyCiJ/s+NMVpsdh84kh1MocmqFgRUKV0+bFxfaxV5Qj8R8sGFMcKDQW0un5TDycLwnqx3j/A5DNuPcRgobrKOzfwuP+Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312967; c=relaxed/simple;
	bh=/bEa5fxT5nth+aOEJSxpkT4brgwWyB28zbj/VlvoTkk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d+3RuKEBw7IoYVgFwTfleLE254I2xI0hgM/PRcGxjemjiBTA6KpiOcOxwp5qAaXEZiGKd88mctO5OZTFvbqLMkAlRYL05E9ZMlP7qZ3fyuQ/Hw227tC/W++DdRBU0yXQhH+G4u5Gi3PNu2WV35W5b7Hoo2pD26VXzAVFH/mAp+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WHzYBZza; arc=fail smtp.client-ip=52.103.13.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQs04IYzuBBEUIgEU/KJAeKGslipJfj3o2s+39siloJFsbg0kNF3T25BRs57GeH+ml+hpoHWgKYMdkpxDZjhdgmtyejz8ahtmlQu9ooT8uYaLuqtdlGKQkrrZ3+BFBFeBNt/6DSVvbrui6KeUOTBOqx0ZQKtbUKS1AOb1KPBK2c0b7lOeJLAtGRgLkCR4pB6Y2HUSxU+hpfF/9afNRzlNPCQLeJBWuY2D7K/60wPT0gdQZY7XeeJrolXJudEn7a1TGC1sQSZ0pw6OH/ZxS18xAl+qyJy977DC9tuEtTHbU+q8Pmnb0LxMo8uQ8KnyQwYzI9QVqynsmoYk22oeNFuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bEa5fxT5nth+aOEJSxpkT4brgwWyB28zbj/VlvoTkk=;
 b=OzHmsL+noBL2R7BoOeyU7jOmAqUyHJcPxQN0wRoES7tqp4tCsDumpScPaASmM7Lldzu11seimRejOblsYpjDAaNy1xrfUGIqK88W/JtsP70160cUCDQMcR9yneUG2LMSH0Qb6yAuP9nAEX1jP8JdzAwwSuObLQ7YM+B7giQ0f/AiwbUfuReg+OnNG8CrmOKbMRbk0tDmRU35i/e28cAfHNktuCF87WcfhdiaaXJSOK2SKkQlM0gUtOo0AXt8vzVe2gTKDnP3pGIpd84OfOI223eJ0pzyUQgDG+Rx//Ov7t+mcRLTOnlI6djxgris0k9Eysl9DiOOepcSj47fSYZlxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bEa5fxT5nth+aOEJSxpkT4brgwWyB28zbj/VlvoTkk=;
 b=WHzYBZza3bXcLqgBWMG5QqGGJ8E2IryM2K9XsWzTMnd1IfPBQ+3idxdl7GOYPPUlrUOGgYcaKzAZeOTrzQfmNHKHM9JEGQ7SndU5xzqrZjHdctSewTZpwCxCYHZW7LcXndBSyTM3PrBK58+6CFJwCQahgR++CBZF8eXa/5rcwku6JdLtOQEjr1Ga7ZSb5Bve3OpNNh7Vga5uNAiHT3VbAp04SxAhkvj7l+iFjmEkYCjbN6FRjx/+d01blYbrYXZADiiUZVesQD6/8Fm8ueRQCdqev9IfyDgkMtZEeLRV3B+VCQgKo1uQ4dCi+ezAwa2COT/S7Qu0ODhZrBpcNzbFsQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7474.namprd02.prod.outlook.com (2603:10b6:303:75::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Thu, 10 Apr
 2025 19:22:42 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 19:22:42 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: He Zhe <zhe.he@windriver.com>, "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: vmbus CVE-2024-36912 CVE-2024-36913
Thread-Topic: vmbus CVE-2024-36912 CVE-2024-36913
Thread-Index: AQHbqeBE1oL0kNw5skqLnwrnBYdwgrOdRv2w
Date: Thu, 10 Apr 2025 19:22:42 +0000
Message-ID:
 <SN6PR02MB415791F29F01716CCB1A23FAD4B72@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <ecaa2736-1e5d-48aa-b06c-df78547a721c@windriver.com>
In-Reply-To: <ecaa2736-1e5d-48aa-b06c-df78547a721c@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7474:EE_
x-ms-office365-filtering-correlation-id: 3bf128d0-5435-4e79-9094-08dd786510a4
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|461199028|15080799006|8060799006|19110799003|10035399004|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8U5cSfu8p/ELqweOt586L7Chf7xGQ2Fpi5jazSmIFzUMkg+ZWREmot5j12N5?=
 =?us-ascii?Q?xZIEnSbtmExnpqnHDr25DwaxnJCpYVKtgRGDAdWaQoLNH9McaC5L6n5p7huo?=
 =?us-ascii?Q?QuUPNtvwUH4xrlPvvN0W06NcWKY7zp3fJzXHhFCBtAwA10TiitB/SGM6wV5p?=
 =?us-ascii?Q?+WnjtQrdqbVB+ShlcEUm30EQ8jSQWqbEUzoOwG3tS4Ues7mFtvR0Co0dJSBk?=
 =?us-ascii?Q?TRsFfAdPhWUdOsOGKndlnWABQAWAXUsBvUzfa5BPv2dRfHGH/oOI6CyGgIIJ?=
 =?us-ascii?Q?yYmiwrwQLLtx/BCS2t8u90uHtFZtKkaKb1o+5ZRflGV9aU6+4bz8rcw1aA1k?=
 =?us-ascii?Q?3f1HlRJg1FaMyTamHrd4rfePi6FrtkcZFPMF0yW8N/L+WtAVhaZ0HONsA65/?=
 =?us-ascii?Q?+3I1wvtpCAGlLQBYvrcWmbkibIM+R7VkhQ93HsP8tAaiqn36CT5MS05Sdgdc?=
 =?us-ascii?Q?+VFTQ7D2zHhSiEdle09vsaozIwLYIrcyIrj5xqxkpXPllVk8SQmV+tC7JAZS?=
 =?us-ascii?Q?8SNErkHz6LlRWb3WLH6zRhFpGIdm1hbBtvJXwRl973nHYzJXPnRw9Jr5AI04?=
 =?us-ascii?Q?fkDSjm+cEbHuI8suQ0IHTxDQv1W02d1CfOlxH21WashPzFQbwV/G39Amn22U?=
 =?us-ascii?Q?/CDTnRnAPRjC+IbFN/TYgFjUQrUsCuUVTmiUj7r13wRnUQJEk1aX7uzrCXX5?=
 =?us-ascii?Q?xh5aapsvjS0WRLIra8UI/RhXRdiIFX6qj7Z4GgmU3GyXSc097/9AGozUy4TB?=
 =?us-ascii?Q?v3FeR1BUg7hH82s6D++17wxZmbWKwMiwHseO5cDFVG6irwFbnxMLzIAYSWBI?=
 =?us-ascii?Q?au0MidJ8cAmC4URFrz7iNXh6i9/EiKAKVXaoCXbJ6/m6lIaDV2kXlkg7LtaW?=
 =?us-ascii?Q?eojBJtNSpq/PPXilwO1slEsKrpjfGuvSF0UOQ2pO9X8Dr4BkC8JDLzKFhbof?=
 =?us-ascii?Q?M+ZNcqDEOvGq4LYBksLvrEwfmcrZ43LcxYm9L/xE/UeA2LRLv0p1JWYKWIEy?=
 =?us-ascii?Q?WQdvp/sJyyTyu1wXulk7ewpdhXLSW6SgKZN3+wr4V+3nreZ+cTijZ3nKA8xF?=
 =?us-ascii?Q?k1xiNJMhmOLanaoxT23z9eF6OyORkQsVbqLrjSg96Ji3k8aOWQVQTsiRplLl?=
 =?us-ascii?Q?8Fzwl4USpcfkMmtcKMW74zWwZAXQZ3P1Jw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N5gz3VVqT0fklYqDTCw+cC9zhkA4eNhXnpZjuQSZIYkT97vuMlnl4PwkSwW0?=
 =?us-ascii?Q?1BWsjbf7MqUpJ1naQSipUa/Qt+3ULR7Rp1ErfaQ1gdszTPIhFHoNMMZ2BVmz?=
 =?us-ascii?Q?4z6Star3xlv7dz2+m/3NObqUcFsMztrG4AyB1ygaHWMYgolU/FQGaFwIXDY7?=
 =?us-ascii?Q?rraQ2Sz+nDaKDc+95CJkb/cWby4Y+/1YiG2n92xRPIp4J5bvOJ/DAkxvq4yd?=
 =?us-ascii?Q?u1vYGDVTNrYcudPt6FkzC2Wxf86McIMtqAEkNqPQkrdT/K8gJpEBzL+YJJ7U?=
 =?us-ascii?Q?Wj/epJnChT8UvScgsQRrTVrFdFImwtc4jrN+SEhR9uOdmSwomhYutgCLTsr9?=
 =?us-ascii?Q?CgoKSf1FkyJEv+rymhkMZ+kd7qOAyS0EZHF6LerHokeZTqwXcDh0sDDEptK3?=
 =?us-ascii?Q?K4ITrH95ktKy0V4n+G1IzOM7NWUmBciRuWeGM0U3LxUK54L4qUKW2RW2ZFt9?=
 =?us-ascii?Q?DmupzRSfrgTSjbqLbDH5jkxkkj38UXQJhkY9j0eNCgbTO1fhQ4I0pfGdw3+q?=
 =?us-ascii?Q?7/GnLj+iFCOygBURh0x2fpSbZYYysXU+2Vpf/aa0qF9ka/1yMcirGPP1iA1n?=
 =?us-ascii?Q?ka1njpWWU5ogKfuCu04LW/bRW1wtVpijoCjLro+pwb9vZVC5IB8UkWa/WMra?=
 =?us-ascii?Q?996PLoXQkxMorCODKFhF73LU1MA3XFogIUCp8Xek3toFXnD6lbd0h120RY5A?=
 =?us-ascii?Q?oJI4y60QQIGxa/rZZ3NN+SWOFb2PNUHr6sbeHYGpwSHtrszXv2Uy0OWQGq1z?=
 =?us-ascii?Q?YIeOlzkiZ37md0HaUQtwgoA3E9SJ6rc0v88bKTxlmYmQcC06RFBfQMur51Xb?=
 =?us-ascii?Q?o4SoiIH948ugClmSfYSJw3wtWYWqBO7IF1vA1ZRPowl4zsEC54jJJDIqEf54?=
 =?us-ascii?Q?vAf68DwZG/G2v4S+faoTsuMZWGjxWiQJw+wXNnMBprOKhjleMAwJIa8vogJE?=
 =?us-ascii?Q?3HJ32BLHRBvDuJBZ5n8LnAfque2/FM5CqHWEPUa0Gjwf0/i4a6PcG4N75UNC?=
 =?us-ascii?Q?bqsUbHVuC1pFnfnnUuQvA+X9UO9IVvbnppIqNz2Dr/htpZVNulqKjxJjQ+nS?=
 =?us-ascii?Q?stKe722TiJkfxsF1nZbfMmtmHwEtgb44um8vahyA5wTXpGdkWF7SRgxlkibN?=
 =?us-ascii?Q?lsS6yX/coj7qLwrZ49I52Vn5vDMhYG/+oJQrMcfQB7QWPJleL6CVGtBPtu2G?=
 =?us-ascii?Q?i5GHGFxqC0Lm0+OzNC9lqQUqfLWXpE4Nt+xjCiIJ8r1C3DtAJsRmH8PkYHs?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf128d0-5435-4e79-9094-08dd786510a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 19:22:42.2361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7474

From: He Zhe <zhe.he@windriver.com> Sent: Wednesday, April 9, 2025 11:15 PM
>=20
> Hello,
>=20
> I'm investigating if v5.15 and early versions are vulnerable to the follo=
wing CVEs. Could
> you please help confirm the following cases?
>=20
> For CVE-2024-36912, the suggested fix is 211f514ebf1e ("Drivers: hv: vmbu=
s: Track
> decrypted status in vmbus_gpadl") according to https://www.cve.org/CVERec=
ord?id=3DCVE-2024-36912=20
> It seems 211f514ebf1e is based on d4dccf353db8 ("Drivers: hv: vmbus: Mark=
 vmbus
> ring buffer visible to host in Isolation VM") which was introduced since =
v5.16. For v5.15
> and early versions, vmbus ring buffer hadn't been made visible to host, s=
o there's no
> need to backport 211f514ebf1e to those versions, right?
>=20
> For CVE-2024-36913, the suggested fix is 03f5a999adba ("Drivers: hv: vmbu=
s: Leak
> pages if set_memory_encrypted() fails") according to https://www.cve.org/=
CVERecord?id=3DCVE-2024-36913
> It seems 03f5a999adba is based on f2f136c05fb6 ("Drivers: hv: vmbus: Add =
SNP
> support for VMbus channel initiate message") which was introduced since v=
5.16. For
> v5.15 and early verions, monitor pages hadn't been made visible to host, =
so there's no
> need to backport 03f5a999adba to those versions, right?
>=20

I agree with your conclusions. The two CVE's you list are for Confidential =
Computing
virtual machines. Support for CoCo VMs (called "Isolation VMs" in commits
d4dccf353db8 and f2f136c05fb6) on Hyper-V was first added in Linux kernel
version 5.16. So the fixes for the CVEs don't need to be backported to any
versions earlier than 5.16.

Michael Kelley


