Return-Path: <linux-hyperv+bounces-11639-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uMz2N04vNGqjQwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11639-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 19:47:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4146B6A200D
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 19:47:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=dGVv6RhC;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11639-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11639-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 437183037DED
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 17:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3713451AA;
	Thu, 18 Jun 2026 17:46:54 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011000.outbound.protection.outlook.com [52.103.1.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA1175A89;
	Thu, 18 Jun 2026 17:46:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781804814; cv=fail; b=SYPyp3ADT8Uzsk2w5pKnECE0B+xIJr4QQgT6MQ7qdYCCK5Z0eij3XLsVLK6inhF9yVYy2EBdKMYgx0bSTav1+sgHQ/gY4tAau9oDZSYbkGBFNOQc2JzefbZXUXIaWaU1ONRn/VJOE06vTz3Py47s+awHxryrjuB1zrIz/Zq2KgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781804814; c=relaxed/simple;
	bh=WEKud2XqDoZyV6eDQgHKCdspqaRzyKwyCRJRI8BOZWs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=md2RGD9BORMFJBJJhpWu395VRIVReTw3cBZHU7Ym3PQUcnDpTXqcSqz0Z/BeE7An1WHUH2G1KawOnvJ1Kwy5EtC4nfeiu0Sf6tVFdJZRj3R+hhxi7DXpuFv3fEWB77SRC0bHwzG6xkQ4iY6vkCkgHqhdExQshUVKp8Mjf62rzMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dGVv6RhC; arc=fail smtp.client-ip=52.103.1.0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrOQthnZdvDq+bII3solVlxhGzYFB7wfub9Kgyf8JDufUqHEYBEA6nVRk4OuELIGdz+zcUjWOqFDR36Fv6R6VUQ0aQtGpgcTM+tcwB/8IXwJhTBJHu+Kou3vzwqYOrg4uLmJk8ZdrTvwq5NTpoQViIukzzzFJbtgEWZ5NYukNbPhUsetRjOfAs+ku0S3WIwAW9ZiNMd7OH4c8GIwObMUfYjBj4ADqA8JcWOpVORiL2KgEg4+P2XM8MUZL4IYGRrY9Fu+o2Jyc83vwm7XOBDAb5V4mEfXrYWNVwnnUToZZE4QRf13zvdkUaCqUCl0l4+txqoZRacerPMJzt0NYimg0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ff6B9h2bDqDreualdjwrvCV2gB0AS+twaJbsZvMW4tI=;
 b=waOKXVnVRrPFr0+jtcdJ4VrMaayfCDf+msiaVzcZ5rbtz58u2xcF2iH+BqfM5Hlb8qVmuP4aTtpZ6U/2PtS7PHEDyGcWgFeRTdKOVsPpNaLEAvsrRYDlSFRERXyPV+zb+xP3Tep2H733UQF3KLoCU9TC8BZN8b/AQhinD192+skkxofVmM4IyfRZ3x1XO4V1y65sx1i6erTt+vrWEe7JWg+7HbhEiCm3IEiziC/UZBg6tfPcIgjFn4uwbUb5WWJIATjxlWKo1i/0UNSZBYIsIGwZ3zwp/IRnUZtk2mL/Sazk2tf+tU13kpAnWI3YV+HWmIiQ5Fla7V0SvR+5t15uKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ff6B9h2bDqDreualdjwrvCV2gB0AS+twaJbsZvMW4tI=;
 b=dGVv6RhCUWssB1YHE3tHXBHXjoHy7mq2uwpXB3u+zku5QJrJG9JEr2D4U9FHC+HHuEPWUEZ/DR2HSdb3nBzuBv6Gpj7MIdm3pmO/BEulecEwh/RAs0rBJFb/Hyyk1hM85DgD4TYy4N4CloxehGsSz3KIG7rUbuNidg9dGNcH62j9131sxxb6gnU954X5jogKLyDQBCTR8uDbS9cD00GLI0DZGAYMV7r7/z+H/0c3YPfjqA+iaLZSQyyO1B+C95s1hlbKJmjDLXS3OZMixN5OE0InMMvK69sfgA/QXfGqBBR2bIf4IMpMJMSJZcO2bsG5sNAJsvIlkxlIMqVt6VP0NA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA6PR02MB10791.namprd02.prod.outlook.com (2603:10b6:806:440::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 17:46:50 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 17:46:50 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "sudeep.holla@kernel.org"
	<sudeep.holla@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"thuth@redhat.com" <thuth@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, Michael Kelley <mhklinux@outlook.com>
Subject: RE: [RFC PATCH 5/6] arm64: hyperv: Route hypercalls through RSI host
 call in CCA Realms
Thread-Topic: [RFC PATCH 5/6] arm64: hyperv: Route hypercalls through RSI host
 call in CCA Realms
Thread-Index: AQHc+DtQSBdU0YLChUKm5SKt3TSb3bZEpGnA
Date: Thu, 18 Jun 2026 17:46:50 +0000
Message-ID:
 <SN6PR02MB4157A7A417362F66947FB41BD4E32@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260609181030.2378391-1-kameroncarr@linux.microsoft.com>
 <20260609181030.2378391-6-kameroncarr@linux.microsoft.com>
In-Reply-To: <20260609181030.2378391-6-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA6PR02MB10791:EE_
x-ms-office365-filtering-correlation-id: e298af82-f01a-4304-e9c8-08decd6193bc
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUXBahuwteIkQeW30lJPuxOI05fU2m3MB6kJdzcYuQpFDHx425r7x/O2aE03zCtMQfeQ25W0RpsIhYryBu6E5qiusGTyG3LajniBxF2goB56Er53AXJsU4RbhmS0qYV/CVF56SBSC54fp3FSxs9gAR989ybROiGU4v/KiN6Cp1AnPSFPvlAfx+UHthTDi+ou5JL8AcZqvIjOZ90FcNSUUEadWf9kJ86PtCJaqgNkSZ9WMXncVUI0wMHl+8e/jjqQSr3T83RYRszxLxS5kCeiSF3v0QNlrXe2L2/ar6Y5uRK0ovtQT/P0EN7jLiwIpvRTII9KTLxW9o7ZGQdk94xQLCq67p7/UnT3iDd3idW5FUuD2ff6ZPy2ihwj2fE4uLfcVGC4sUXCyMjsCL6z/S6PT563xQOg2brGbaewp51tAoS131AXT1WDAgJsp08uk3EmacbERTjd6CKkC88nKCRdmmdjPsRi/zsJcA7unJcnl7ELh+UgXi1lydag8Z+SzsqBYgyfF/C2MCtujVzJeg6TWYHWHcLtCJuY3RtsBPrDPLiAJuMbgpqZvmNwyVVQf5+hFfLaX6TJGgvP8gYt8ntRfxy/e+kfYxdJ3Ro9NtmBHp0pypy/SBDxqq8oqD2hS4SFT7Vp6hOMVfyCX1IqY5oNR9IvKKLwcH1gFfDE88GS4wuzRe8B/J6fmIlsjOJRV46KvOCJgnw80X/P02BgX6nSZbu+3vJ8Q1cMQSyUH0PNFxb+34pKl/cYzt8U9SfpKpyvfE=
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|41001999006|31061999003|12121999013|8060799015|8062599012|15080799012|19110799012|16051099003|19101099003|13091999003|51005399006|102099032|40105399003|3412199025|440099028|12091999003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?O2wHSDdgHdhVVx7wmMG8QZs8376ohLU84Uw8pRx393g0qY6XB+UzGNEzGdkJ?=
 =?us-ascii?Q?1uOeFcwASR+V5mgBHeJo+HV89Mr/eufh/n4hh/w0YsdQCZUADvQPd9ft96ij?=
 =?us-ascii?Q?QiucnEDhLPuJeDC5HTY0w9Q97pwNJYMuWS+CR16m8qy//dWJ8OZChLbGROzL?=
 =?us-ascii?Q?n6vfZfjXkIT48dJBPPxpeqsd3FhBPW0eIeo6qYGqSTAJLaaQzeZ993FWh5Mv?=
 =?us-ascii?Q?xyqrkU6Tx5VBBWL4/DFl8+UwweNlAcbY+ulHAUMcGswDtg1b7CvDPHzowyGr?=
 =?us-ascii?Q?GszA+KsStPLqBp5QjojudPv6vjLOUS/HTTVsj0YBULewlnIHTSFAXQKxnATO?=
 =?us-ascii?Q?1S83bKXEMzAG+SuD16UEUjTy733X7/gGySF0C+0iddCQDk2L94uGnQ+UKt2Z?=
 =?us-ascii?Q?lLdXCyBU+qCwJNr1sNB53wbn1ool4YWfKqvBFhUWFSCWor6QxXCcDXj6oe5g?=
 =?us-ascii?Q?OJlZseU5cysCB94nv3VcOuq1LsrcCbOa5x4wNOj8Es3UmnVb8gKMKYCEPZTY?=
 =?us-ascii?Q?X4UUQFfI9qWvc4Dqoo73q3qIGmi1MU/Bu4w3qD3pyrPCb1YM+agtrlmv0OsW?=
 =?us-ascii?Q?EmKS7AjPIchFrGpa6RJgYqmbJ9mZWzPdxFdXTNYB2+bV6/CHjOpQRCY4tShp?=
 =?us-ascii?Q?yppc4KgA+/qqQ3FP8WsZ77Zr6Ffs2d385kSKBB1LVrwOiAVcHXX0WmRmKiUo?=
 =?us-ascii?Q?hmDUNy44SY2h5jNR1wpI1o3ZEQVry7/mdoq8F4TC30ojQM6CpptoF16Bln0N?=
 =?us-ascii?Q?+DHWfuzAADRafXTwx6eqxkfBvXyVpcLJvjOLDXyv2twJGJymEX2U3p30XAlA?=
 =?us-ascii?Q?OcSzAOjR2Jbb41upt5oyeCteNonqsoX0GYF78FPG14RXvNlr8loaeXrMXdKZ?=
 =?us-ascii?Q?IzgOP+BY6/cRI4mJ4EDiMCw2uGA12t9Mce7O2p9HGphNUY7CbB8w42uUEN4Z?=
 =?us-ascii?Q?Q0PYVddl0mPWJZJzVgdXJG3FC7ObA6/yFob/C6mneLGWI65Y6ImNVhagzXoM?=
 =?us-ascii?Q?Fl01o7j55zDf2WGJtas9sMmqyQEF1SgUX16+vWJHdEXltMzTX2P2N1Sw4KZZ?=
 =?us-ascii?Q?aFKQ7JqFMSmHupJbUIT5pQwr0dNpaLl7CE9FwyUB+1/Ru9Zt0u/ggiOUWa8L?=
 =?us-ascii?Q?MWJ4dkH8Xu5V7e8tiosoO+9z2HofbMYNmA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oIuftWyck0i5c9sVrW5UhhcAATyD+VeQh0ua/+We3+6efh0FKZPJcAQmuvOL?=
 =?us-ascii?Q?yHKNtUneRmnqTjutWfOGczTMiYiuEdvpmRcK2Ei+udKGTJ+jFakPw2BDU5MC?=
 =?us-ascii?Q?dsGOqiBVMi1P/dSn3qTjj1NcXzxZkxva33UXusIqIzIPUWIpoQuW6OIs255t?=
 =?us-ascii?Q?9eQmpsOh3Dn9pgBEdS0eXJbG5uS5a3fxv0qWLKvNv2E7wPql4hkPjbosLkHP?=
 =?us-ascii?Q?L35AB8pz0adoAMpT6D15z4/a6DLvER9c7xXUxBiS3TZDKP2mGu1LbWn/3hMP?=
 =?us-ascii?Q?dEYIMkxdy0Z+pMrDes9JZAnhlCTkhCFeRdklZR/Y3PeQEjCy/vs8JuExpbvA?=
 =?us-ascii?Q?J30TusHM533JuckQUrPvcU78XrdUdsuBv0vmuNzfPuzFFCwMEtS84bhg7Xj+?=
 =?us-ascii?Q?WdPWnD06j/xooi3Li/bojYTbGF2c1EO1RUXjY5pzvFQguYyHE6bNrCcFAILK?=
 =?us-ascii?Q?svD9tuBfKehUX+eSLc7kDiR38sK8icPmjRO3mqhx+JAxNJp/DQwqUsn08WJG?=
 =?us-ascii?Q?kns1hB/TusNbpffoaSbtYwk2I66b5QzjT2taN8QJU0bUD56L0csNUc+TFDT2?=
 =?us-ascii?Q?c6eWaNaodGY27pMZix7hRyv2uVT/bVjFojlulyMFntWcc7BnbiV0btqwmtLL?=
 =?us-ascii?Q?ZOdyCFOd2y5NsDVOyfgEy3wHjbyQRb7O0dJxG8PoFpgzG8Jdc9touafYMvhV?=
 =?us-ascii?Q?bcTgJ6L1eUmT3EsM/hi/odDpzR0QqSJu9MhRgwjjzTC+fcTLy7UwfEgnK72j?=
 =?us-ascii?Q?Zg7t2tJId2nkVda0hxzdJnPmhtOs0a0bDOoube37Z7LJPr4cZndNX793sohd?=
 =?us-ascii?Q?MKUDudU1F+G8AscZQ7ukW+sMael9uQBrYV3lo5/d5PVRAXvZ5ercaPfNRWER?=
 =?us-ascii?Q?+OgBupMYBduoItlIG7VnUPX5/fCcCdWwwukxzMdx9KczfpAoOP+X4LdkGlwm?=
 =?us-ascii?Q?5xmUNcRCjzcAG/BJ2HayfaPrLgksUTmgiCI8+l+/2xBTzygMhwKhN91UyqnS?=
 =?us-ascii?Q?z9KtWye+YwmG6RDvoIqLD1Ff/1J6XwXKMHdmxA0dPB7eIBbh94lpJYNMjk40?=
 =?us-ascii?Q?KgAcc+VMOigcOZq63RbpNKyxCtWV7dlUgxwAQl6Q9cqjG+FbiJhRiJpAHT9v?=
 =?us-ascii?Q?yogrdAiiq/W70FTLCw28rW5d7SAofXqecUqzFBk5GZRJQsWZBEaEG7jiskH7?=
 =?us-ascii?Q?hYqL5wWI4YrUUBsQHDCrwiNviXLqq5Qj7joUs6cIHo79yrKgPSpxP2TKbi4d?=
 =?us-ascii?Q?enOlLhAlim+Z/7un8W0B1YQBlIW8sUno3Hzb9XIialWAkgKL/KVWi8Yl4xcz?=
 =?us-ascii?Q?HTwNr0xvmr8KYutSJo1ECf6wFuQiGXAUNdopQly7SPIYglEFteonxyl5NNib?=
 =?us-ascii?Q?TfrIYS4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e298af82-f01a-4304-e9c8-08decd6193bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 17:46:50.6882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10791
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11639-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kameroncarr@linux.microsoft.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:mark.rutland@arm.com,m:lpieralisi@kernel.org,m:sudeep.holla@kernel.org,m:arnd@arndb.de,m:thuth@redhat.com,m:linux-hyperv@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-arch@vger.kernel.org,m:mhklinux@outlook.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,arndb.de,redhat.com,vger.kernel.org,lists.infradead.org,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,outlook.com:dkim,outlook.com:from_mime,vger.kernel.org:from_smtp,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4146B6A200D

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Tuesday, June 9,=
 2026 11:10 AM
>=20
> Modify the five hypercall wrapper functions to check is_realm_world()
> and use the per-CPU rsi_host_call structure when inside a Realm.
>=20
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/hv_core.c | 175 +++++++++++++++++++++++++++++-------
>  1 file changed, 141 insertions(+), 34 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
> index e33a9e3c366a1..1759998ef2667 100644
> --- a/arch/arm64/hyperv/hv_core.c
> +++ b/arch/arm64/hyperv/hv_core.c
> @@ -16,6 +16,7 @@
>  #include <asm-generic/bug.h>
>  #include <hyperv/hvhdk.h>
>  #include <asm/mshyperv.h>
> +#include <asm/rsi.h>
>=20
>  /*
>   * hv_do_hypercall- Invoke the specified hypercall
> @@ -25,12 +26,32 @@ u64 hv_do_hypercall(u64 control, void *input, void *o=
utput)
>  	struct arm_smccc_res	res;
>  	u64			input_address;
>  	u64			output_address;
> +	struct rsi_host_call *hostcall;
> +	unsigned long flags;
> +	u64 ret;
>=20
>  	input_address =3D input ? virt_to_phys(input) : 0;
>  	output_address =3D output ? virt_to_phys(output) : 0;
>=20
> -	arm_smccc_1_1_hvc(HV_FUNC_ID, control,
> -			  input_address, output_address, &res);
> +	if (is_realm_world()) {
> +		local_irq_save(flags);
> +		hostcall =3D *this_cpu_ptr(hyperv_pcpu_hostcall_struct);
> +		memset(hostcall, 0, sizeof(*hostcall));
> +		hostcall->gprs[0] =3D HV_FUNC_ID;
> +		hostcall->gprs[1] =3D control;
> +		hostcall->gprs[2] =3D input_address;
> +		hostcall->gprs[3] =3D output_address;
> +
> +		if (rsi_host_call(virt_to_phys(hostcall)) =3D=3D RSI_SUCCESS)
> +			ret =3D hostcall->gprs[0];
> +		else
> +			ret =3D HV_STATUS_INVALID_HYPERCALL_INPUT;
> +		local_irq_restore(flags);
> +		return ret;

This code sequence for handling the realm case is almost exactly
duplicated for the three hypercall variants. The only difference is
how gprs[2] and gprs[3] are populated. So I think the code
sequence could go into a helper routine with the appropriate
values for gprs[2] and gprs[3] passed in.=20

> +	}
> +
> +	arm_smccc_1_1_hvc(HV_FUNC_ID, control, input_address,
> +			  output_address, &res);
>  	return res.a0;
>  }
>  EXPORT_SYMBOL_GPL(hv_do_hypercall);
> @@ -45,9 +66,28 @@ u64 hv_do_fast_hypercall8(u16 code, u64 input)
>  {
>  	struct arm_smccc_res	res;
>  	u64			control;
> +	struct rsi_host_call *hostcall;
> +	unsigned long flags;
> +	u64 ret;
>=20
>  	control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
>=20
> +	if (is_realm_world()) {
> +		local_irq_save(flags);
> +		hostcall =3D *this_cpu_ptr(hyperv_pcpu_hostcall_struct);
> +		memset(hostcall, 0, sizeof(*hostcall));
> +		hostcall->gprs[0] =3D HV_FUNC_ID;
> +		hostcall->gprs[1] =3D control;
> +		hostcall->gprs[2] =3D input;
> +
> +		if (rsi_host_call(virt_to_phys(hostcall)) =3D=3D RSI_SUCCESS)
> +			ret =3D hostcall->gprs[0];
> +		else
> +			ret =3D HV_STATUS_INVALID_HYPERCALL_INPUT;
> +		local_irq_restore(flags);
> +		return ret;
> +	}
> +
>  	arm_smccc_1_1_hvc(HV_FUNC_ID, control, input, &res);
>  	return res.a0;
>  }
> @@ -62,9 +102,29 @@ u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 =
input2)
>  {
>  	struct arm_smccc_res	res;
>  	u64			control;
> +	struct rsi_host_call *hostcall;
> +	unsigned long flags;
> +	u64 ret;
>=20
>  	control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
>=20
> +	if (is_realm_world()) {
> +		local_irq_save(flags);
> +		hostcall =3D *this_cpu_ptr(hyperv_pcpu_hostcall_struct);
> +		memset(hostcall, 0, sizeof(*hostcall));
> +		hostcall->gprs[0] =3D HV_FUNC_ID;
> +		hostcall->gprs[1] =3D control;
> +		hostcall->gprs[2] =3D input1;
> +		hostcall->gprs[3] =3D input2;
> +
> +		if (rsi_host_call(virt_to_phys(hostcall)) =3D=3D RSI_SUCCESS)
> +			ret =3D hostcall->gprs[0];
> +		else
> +			ret =3D HV_STATUS_INVALID_HYPERCALL_INPUT;
> +		local_irq_restore(flags);
> +		return ret;
> +	}
> +
>  	arm_smccc_1_1_hvc(HV_FUNC_ID, control, input1, input2, &res);
>  	return res.a0;
>  }
> @@ -76,24 +136,44 @@ EXPORT_SYMBOL_GPL(hv_do_fast_hypercall16);
>  void hv_set_vpreg(u32 msr, u64 value)
>  {
>  	struct arm_smccc_res res;
> +	struct rsi_host_call *hostcall;
> +	unsigned long flags;
> +	u64 status;
> +
> +	if (is_realm_world()) {
> +		local_irq_save(flags);
> +		hostcall =3D *this_cpu_ptr(hyperv_pcpu_hostcall_struct);
> +		memset(hostcall, 0, sizeof(*hostcall));
> +		hostcall->gprs[0] =3D HV_FUNC_ID;
> +		hostcall->gprs[1] =3D HVCALL_SET_VP_REGISTERS |
> +				    HV_HYPERCALL_FAST_BIT |
> +				    HV_HYPERCALL_REP_COMP_1;
> +		hostcall->gprs[2] =3D HV_PARTITION_ID_SELF;
> +		hostcall->gprs[3] =3D HV_VP_INDEX_SELF;
> +		hostcall->gprs[4] =3D msr;
> +		hostcall->gprs[6] =3D value;
>=20
> -	arm_smccc_1_1_hvc(HV_FUNC_ID,
> -		HVCALL_SET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
> -			HV_HYPERCALL_REP_COMP_1,
> -		HV_PARTITION_ID_SELF,
> -		HV_VP_INDEX_SELF,
> -		msr,
> -		0,
> -		value,
> -		0,
> -		&res);
> +		if (rsi_host_call(virt_to_phys(hostcall)) =3D=3D RSI_SUCCESS)
> +			status =3D hostcall->gprs[0];
> +		else
> +			status =3D HV_STATUS_INVALID_HYPERCALL_INPUT;
> +		local_irq_restore(flags);
> +	} else {
> +		arm_smccc_1_1_hvc(HV_FUNC_ID,
> +				  HVCALL_SET_VP_REGISTERS |
> +					  HV_HYPERCALL_FAST_BIT |
> +					  HV_HYPERCALL_REP_COMP_1,
> +				  HV_PARTITION_ID_SELF, HV_VP_INDEX_SELF, msr,
> +				  0, value, 0, &res);
> +		status =3D res.a0;
> +	}
>=20
>  	/*
> -	 * Something is fundamentally broken in the hypervisor if
> -	 * setting a VP register fails. There's really no way to
> -	 * continue as a guest VM, so panic.
> +	 * Something is fundamentally broken in the hypervisor (or, in a
> +	 * Realm, the RMM denied the host call) if setting a VP register
> +	 * fails. There's really no way to continue as a guest VM, so panic.
>  	 */
> -	BUG_ON(!hv_result_success(res.a0));
> +	BUG_ON(!hv_result_success(status));
>  }
>  EXPORT_SYMBOL_GPL(hv_set_vpreg);
>=20
> @@ -108,29 +188,56 @@ void hv_get_vpreg_128(u32 msr, struct
> hv_get_vp_registers_output *result)
>  {
>  	struct arm_smccc_1_2_regs args;
>  	struct arm_smccc_1_2_regs res;
> +	struct rsi_host_call *hostcall;
> +	u64 status;
>=20
> -	args.a0 =3D HV_FUNC_ID;
> -	args.a1 =3D HVCALL_GET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
> -			HV_HYPERCALL_REP_COMP_1;
> -	args.a2 =3D HV_PARTITION_ID_SELF;
> -	args.a3 =3D HV_VP_INDEX_SELF;
> -	args.a4 =3D msr;
> +	if (is_realm_world()) {
> +		unsigned long flags;
>=20
> -	/*
> -	 * Use the SMCCC 1.2 interface because the results are in registers
> -	 * beyond X0-X3.
> -	 */
> -	arm_smccc_1_2_hvc(&args, &res);
> +		local_irq_save(flags);
> +		hostcall =3D *this_cpu_ptr(hyperv_pcpu_hostcall_struct);
> +		memset(hostcall, 0, sizeof(*hostcall));
> +
> +		hostcall->gprs[0] =3D HV_FUNC_ID;
> +		hostcall->gprs[1] =3D HVCALL_GET_VP_REGISTERS |
> +				    HV_HYPERCALL_FAST_BIT |
> +				    HV_HYPERCALL_REP_COMP_1;
> +		hostcall->gprs[2] =3D HV_PARTITION_ID_SELF;
> +		hostcall->gprs[3] =3D HV_VP_INDEX_SELF;
> +		hostcall->gprs[4] =3D msr;
> +
> +		if (rsi_host_call(virt_to_phys(hostcall)) =3D=3D RSI_SUCCESS) {
> +			status =3D hostcall->gprs[0];
> +			result->as64.low =3D hostcall->gprs[6];
> +			result->as64.high =3D hostcall->gprs[7];
> +		} else {
> +			status =3D HV_STATUS_INVALID_HYPERCALL_INPUT;
> +		}
> +		local_irq_restore(flags);
> +	} else {
> +		args.a0 =3D HV_FUNC_ID;
> +		args.a1 =3D HVCALL_GET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
> +			  HV_HYPERCALL_REP_COMP_1;
> +		args.a2 =3D HV_PARTITION_ID_SELF;
> +		args.a3 =3D HV_VP_INDEX_SELF;
> +		args.a4 =3D msr;
> +
> +		/*
> +		 * Use the SMCCC 1.2 interface because the results are in
> +		 * registers beyond X0-X3.
> +		 */
> +		arm_smccc_1_2_hvc(&args, &res);
> +		status =3D res.a0;
> +		result->as64.low =3D res.a6;
> +		result->as64.high =3D res.a7;
> +	}
>=20
>  	/*
> -	 * Something is fundamentally broken in the hypervisor if
> -	 * getting a VP register fails. There's really no way to
> -	 * continue as a guest VM, so panic.
> +	 * Something is fundamentally broken in the hypervisor (or, in a
> +	 * Realm, the RMM denied the host call) if getting a VP register
> +	 * fails. There's really no way to continue as a guest VM, so panic.
>  	 */
> -	BUG_ON(!hv_result_success(res.a0));
> -
> -	result->as64.low =3D res.a6;
> -	result->as64.high =3D res.a7;
> +	BUG_ON(!hv_result_success(status));
>  }
>  EXPORT_SYMBOL_GPL(hv_get_vpreg_128);
>=20
> --
> 2.45.4
>=20


