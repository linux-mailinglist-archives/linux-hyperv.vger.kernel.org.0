Return-Path: <linux-hyperv+bounces-11974-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VdoCBRZWVmp33gAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11974-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 17:30:30 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A27B4756743
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 17:30:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=EXPX0fmi;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11974-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11974-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2502B3022047
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 15:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D86B49550D;
	Tue, 14 Jul 2026 15:29:29 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013082.outbound.protection.outlook.com [52.103.14.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AD5494A1F;
	Tue, 14 Jul 2026 15:29:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042969; cv=fail; b=T7o3ZP81MsqruuJmtxyQ0iWO8QmEgyt55LdUOydj6xNqchdORwBszs9Ybakhx+otl/4cn+JnKKIsZxPtTOwAZ7bkIrt9Hz1hZgNM/eV+0PHdgYEKoxWbw2dlD5Cn70qx+cXY5ff58QRqFSl8HHVjGuThkgWPRROIX8D3WMYRCCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042969; c=relaxed/simple;
	bh=7m59XRU8Iwuj3fN+10f5xbmLKNW++Yb7Shq3eq6DXbU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pyCRdc9YiT45ykEidkR61kSaHelPdfg4PZOAOP+JKFlGkGQlxV+9fQhJ+AWegcG1WGkCEZRfgYzi9n0PK6BXNv44rKRfUHMjnS7Sg96iz1cFSRa4eqxgK1MdA3IuCqS3KL8TmjX4kXS+zAVSQHxBZITWTJqGG5+TDHMe+6oTpOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EXPX0fmi; arc=fail smtp.client-ip=52.103.14.82
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rag/vBGJI983edUTMnXCoLEIXZHDieQOZOJCrlUIcECXhZzMOOhy0NvUAJ43qr5p+ZUL5C2F1ePKQLzgJ0lubFXZK5vh0vc1lmQHSLEcTXvy23Gm6ZU+57/Kryfot5wGupw74kf3wjqFU3vGfJNkVZFLe/3DIxExgMp18MLkTx3OpzioFPeEGv750yovhswO3d1IwOXhzpVk+ftU+VWfWmLmGoXZwFDKUTX+aSH4k9tAMbbg8Csp90sczVqqm8UuESvofvbH2iVDN0XoPlcwfxjPl3+d/RtWAwFBM2JEjypbzyK3i3lEJfxHyZuDTrEmmUHqaF8q/cBXoctaqLTcUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQQZy3zBnhSKDBJe5HA0hMMiPFmLZZfZIT91Z2W44LA=;
 b=GHZZG1d4TgQC7k1UXE78JskqicOGux7WC6gORC8Z8fH4YatX4HY6zkg0ev1C080f8Mp+TJlMLOkkr/JHGhjLiT63M8nJFtx8Z2yWXWTxsS+6tNN5tFzogDkES/Kmju2edhMExF9oxF3PVpnXKixG+072uI06QLUrZL0dCn5szf5/3S9TTR6ngMEGrO1yPwhJvGIymHT0L5FQhgKi5ZM8crs+oue/Rq3BZ/gb51Dy6sXTNwl7GQuWbAc0BrwCZcLqtRLCZrNYbTFo4kBuVWiGszMJnzJjXt2/qODMkruX7bB4+I9S8A6xlOUyP0blzvF3gozGUJKmOjLtgFLGl5eHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQQZy3zBnhSKDBJe5HA0hMMiPFmLZZfZIT91Z2W44LA=;
 b=EXPX0fmiERCHLd1t7h7YHQlkDr3sh+n7W6P7wbZsGO4DxT1m+izmDOg4KwI5p41TkAO+w/DAFKfBd8EnkiAcEx/+osuU4ElJeduntgVXJNgYqD4qxjPG+VbHzqId42LSY7WH3O+DW+2zgZYxKZDZopCahDNxNscKUZiU/xdX8B+744W2MMadRu8jsbjEnlIYM6P0RUhSsX21ZpewX50BEdKZUnJqrRWx0H25ciGQby3LruQFlv0xl45ifRDFh1dtW584gbVT44Ssn8jzeTGNZk+Ijp4FQibhSg/dsJOvxLxEFrA774GErASUqqlaa+hKwZLP4bb3ma0fAksxGZxOEQ==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by CH3PR02MB9907.namprd02.prod.outlook.com (2603:10b6:610:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 15:29:23 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%6]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 15:29:23 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de"
	<arnd@arndb.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
	"tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>
Subject: RE: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Thread-Topic: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Thread-Index:
 AQHdCjyk3FoDd2PvoEaR3JQ0We2DX7ZlmCnQgADQU4CAAknxcIADB1oAgAAOZJCAAKasgIAAx8IQ
Date: Tue, 14 Jul 2026 15:29:23 +0000
Message-ID:
 <BN7PR02MB4148E7619638D5710CDB4532D4F92@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-4-zhangyu1@linux.microsoft.com>
 <SN6PR02MB4157253E030D477FD91B7E26D4FE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <enpkphavwmqrkded73c43vprczslvei4755lkxuedof4z2k3kk@y2jtklbk4efz>
 <SN6PR02MB4157805F23ACA85A668FA065D4FC2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <3ty6yq6oftsvq52skrngjv5xpyixhsyfo3dndhoujt7emxsb2o@y6ischifpmfn>
 <SN6PR02MB41575E067DFEBEACF316CD35D4FA2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <r35cz2l3yz2wyi5d663mxwqoiz2rrl6kzpiw6rsruh7ofk6vu6@temnhcfsp6fa>
In-Reply-To: <r35cz2l3yz2wyi5d663mxwqoiz2rrl6kzpiw6rsruh7ofk6vu6@temnhcfsp6fa>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|CH3PR02MB9907:EE_
x-ms-office365-filtering-correlation-id: 04cacbac-eedf-4d2d-21e3-08dee1bcaee2
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|51005399006|8060799015|19110799012|8062599012|31061999003|15080799012|37011999003|24021099003|25010399006|40105399003|12091999003|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lmO0Emh8HErjPAYK1Gy/AeeUY8FVcZhlMDoO2da5pKEYB3zL3x8KW1g69mnf?=
 =?us-ascii?Q?IhkCzeqXGydbfAHeX+EnBQKUdWJjRh/R6kbWecC16LtRoEs/PvDZZTpt5dIZ?=
 =?us-ascii?Q?F0VPKc0lJeuM1yYo5VKKmERqrMhIgksZMzVj3oI7TNfYSbnaavGx2b9PnlJf?=
 =?us-ascii?Q?WDcASS32L787j1ns2CoEf/adbt2FTKyxUxdCAQH+pk6RtzHh3Ig56O8jjzmM?=
 =?us-ascii?Q?mcG2D/hnAZ44TtPRkkBTYQ0WBRPiTZitI4iAW9+1wvgKtoXMKSKqO4ggeiKs?=
 =?us-ascii?Q?CxlcU+1X3GZxkbYHgjAEU6i4z/mrTCtTESXAX7shN/jYRq3RMPks9WhRkFza?=
 =?us-ascii?Q?1LxcZXECVzkBpLdFq1S/KYodX2PDZJ+P8vIQaETs8weeB+jbGfr0EV2qbSsG?=
 =?us-ascii?Q?9YxqXRfpO/LQ/Z1XwiM+v73e/JMEY5Xv8ZkexDkEgyrvsfohLrsFQ21B9Ogl?=
 =?us-ascii?Q?vKnAXlfP7wKRF/TD6CNDuWes9KbfGv3d8i6UAAlKIt5sruQr82aBFUtzh+k6?=
 =?us-ascii?Q?T+Zxiwvnk7Kf2YNlLBt7UfjHjglM+hBD0MjSoz9ATjN7kgPvjX3UYaeQ8u/C?=
 =?us-ascii?Q?CWtMtZWrnwphMERwYcgew8O/U+baFOUjeJa82GxmKMxDgqNmoj8AG+zTQXm6?=
 =?us-ascii?Q?Zp1o9Vbpgu43tfOexaXzAxEppPuI4VfDh77UeuzoDBXD+aX4KluisXw3X4dn?=
 =?us-ascii?Q?avCdQih5lIneekaSlSNWPTW1JrpYe1x1GQQzz3QrzfKR3lc4qQ96rQx8BmI6?=
 =?us-ascii?Q?Na+p7fbnTrszfEMFtZekcYnTnFsg40qmo/9S4CI94ZNlJMbCSzbHJulshjfu?=
 =?us-ascii?Q?HCDgn90Gr1tYmxBT9vbCWmroeIsoYDxcyLLeGVuCRevA81RDpK84eHS+pLtA?=
 =?us-ascii?Q?oWCOXA0smzXypvBD7+EloEuyXXlhzwtVyMdN8ePherI2qwO71QMaD6NuYDVm?=
 =?us-ascii?Q?NTF+aeQvKDLL4CeiUMlwZIFxbzN8NhpfyXh66CxjkM/A88kuyYB6SE43z6N8?=
 =?us-ascii?Q?NmVtoo23l8cgb3b6K8q6PctQMEwccaA5K8ltUwyRTF3EcAL0az0i2EKWlI1B?=
 =?us-ascii?Q?TA4n0zUP?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cTqe3VCLFDPjMjHYTye+u4PLJr2hZCqrBOe+aN/OAW7zej4JhMkKnCekmpaX?=
 =?us-ascii?Q?+NGpHW/5aso9QqKicae8gLZ8KG08WTAspUQv5mBhDlbgoVs+69Qvs+DINn+H?=
 =?us-ascii?Q?p38xWly+OgwAZ0bNQrUilogXQj5lcXh0Prj4lCWuthnwV2u5uAxusrDSlOPR?=
 =?us-ascii?Q?WXlt+txnTtADavDaMVSyisHq6LUBLnnQaNXKRCLxLJMSWGZ4CZtiRkCVyCAi?=
 =?us-ascii?Q?DGsEwEAwCqz00MuMNIoOvR6uGZQBhcBa1OWP2Jw8UJFPexSWeXVO1wo6P4xf?=
 =?us-ascii?Q?zhTgudC/1IQOum+SQD3woYfPIHmSq0IK5P7HZXd/f6CFBemLl/PLXl/j5CQz?=
 =?us-ascii?Q?m8y2wXqR7Hbta+kVvX6gcspfpct955vZTAaefCk3Mo8w73AynAxQAa401jZR?=
 =?us-ascii?Q?2EYrdfGyVvF68iCa4Xif6fFW5SrW9emH6BRUv8q3PKQUqeuAtrJIMufSU9Iq?=
 =?us-ascii?Q?EFssDqPdgccdSgddD+9CD5WEMt3twxrx6R4sXyD+2IcbN7wQMQ97dfigBWtS?=
 =?us-ascii?Q?oZ628hq5yonK8oqoXhMNKQYEaR/cBlLAU74Of4UWTpY1e54m/Ujv7AOeThgz?=
 =?us-ascii?Q?J+zjRR/WuS2zCdw03UGKWlxvIS0ccLuhp1XUxWl0Wf55y4wrjObVzLBc1ZCA?=
 =?us-ascii?Q?QEQKzDf/AAyvuQmccY8fYDyR+5GeR3zljYH3RdlGuvNfq7q+YrGDyseW+iay?=
 =?us-ascii?Q?jd8gE1YIsWEoTsx/ohRHkyQ/1+kbaZbVzq0PnEVgHYomcmqDy6vDL6NsdOuC?=
 =?us-ascii?Q?SGueOrF0mb4O+s8lVmnTAZwYuxD7Dq736PHh048b6m24tRjTsY2BMUn5J2ji?=
 =?us-ascii?Q?+/66uVpjTrL2oYbolOvRFcbDchQBzNjp6POq5+qb6Q48wA3V8uZ466IeWAB8?=
 =?us-ascii?Q?lZCRWlficvJf4JjTa9AG9U2fvWoHnqhgc3vVcm2UBJGffu08iP4xn8cjF41R?=
 =?us-ascii?Q?CXxOKVZklOzEUEg+Dit8+67eTTmSzekxCTkdWIDRdPDLtvj/oFwcdg7ZgxaM?=
 =?us-ascii?Q?PVO5ujXsRjc7Pt0J82RLdKImNiuxmzx+RpNvhLkfuVSnGdyRoeVg+I+bWhus?=
 =?us-ascii?Q?W1Ijul8HmWb88vtipkGfL76MzhAVGNjj1+96APipRBWrFkRAKVK7wN8bGulP?=
 =?us-ascii?Q?bNusqtMkEOo8oJVAq54q+yNeJnZOiUF7LMaVFzP3cqNnu2TQUP7SZTKMd0WO?=
 =?us-ascii?Q?Uwy7tW/mAXRpX4nrx84pgc6owNiYntXfcNMzohfnWQX0h5PifrzmH3hLXlPJ?=
 =?us-ascii?Q?/S5P8e4Sqm7QnS9Pa6zfdJ3MMt96kXVFkzwWlDYzIq2NGTrQRoaXy1fJ3Etj?=
 =?us-ascii?Q?j5bciHQyo8SiFBlI/GKqTSMjokfjR+c7igWOAVgWNg3/codYDMkiox/47fPN?=
 =?us-ascii?Q?DhRrhd4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cacbac-eedf-4d2d-21e3-08dee1bcaee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 15:29:23.6968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9907
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:zhangyu1@linux.microsoft.com,m:mhklinux@outlook.com,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pci@vger.kernel.org,m:linux-arch@vger.kernel.org,m:wei.liu@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:lpieralisi@kernel.org,m:mani@kernel.org,m:robh@kernel.org,m:arnd@arndb.de,m:jgg@ziepe.ca,m:jacob.pan@linux.microsoft.com,m:tgopinath@linux.microsoft.com,m:easwar.hariharan@linux.microsoft.com,m:mrathor@linux.microsoft.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11974-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.microsoft.com,outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[outlook.com];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[BN7PR02MB4148.namprd02.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:from_mime,outlook.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A27B4756743

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, July 13, 2026 8=
:34 PM
>=20
> On Mon, Jul 13, 2026 at 05:37:51PM +0000, Michael Kelley wrote:
> > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, July 13, 20=
26 9:46 AM
> > >
> > > On Sat, Jul 11, 2026 at 06:31:15PM +0000, Michael Kelley wrote:
> > > > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, July 10=
, 2026 12:34 AM
> >
> > [snip]
> >
> > > >
> > > > One new thought:  Have you considered the hibernate/resume
> > > > cycle? Does anything need to be done with the pvIOMMU to
> > > > make it functional again after resume? I see that the Intel and
> > > > AMD IOMMU drivers have suspend and resume functions. I
> > > > don't know enough about the Hyper-V pvIOMMU to know if it
> > > > might also need suspend and resume functions.
> > > >
> > >
> > > Thanks for raising this, Michael. We have not considered such support=
.
> > >
> > > My understanding is that the Intel and AMD drivers only disable the
> > > IOMMU translation, flush the IOTLB during the suspend and re-enable/
> > > reload the preserved root tables and other HW state during in the
> > > resueme.
> > >
> > > But for pvIOMMU, I guess such job shall be done by the hypervisor?
> > > For a device resumed on the same VM, its logical device ID should
> > > also remain unchanged?  And the corresponding Hyper-V domain objects,
> > > configuration, and device attachments shall be preserved and restored
> > > by hypervisor? I don't think the current Hyper-V ABI explicitly defin=
es
> > > this. But maybe if we want such feature, it could be done by the
> > > hypervisor transparently?
> > >
> >
> > I agree with your and Jacob's comments that the guest doesn't have
> > any responsibility for saving/restoring IOMMU hardware state, as the
> > Intel and AMD IOMMU drivers do.
> >
> > But yes, I'm wondering about the Hyper-V domain objects and device
> > attachments. I doubt Hyper-V can do anything to save and restore
> > them. Hibernation is a Linux concept that the Hyper-V host doesn't
> > know anything about.
> >
> > Hibernation is already complicated, and in a VM it is even worse. :-(
> > As a start, see Documentation/virt/hyperv/hibernation.rst, which I
> > wrote about 18 months ago. It provides some basics as well as outlines
> > the additional complexity in a Hyper-V guest VM. I'll also try to spend
> > some time thinking through the implications for a pvIOMMU, and let
> > you know if I have any more thoughts.
> >
>=20
> Thank you, Michael, and thanks for pointing us to the documentation. I
> need some time to better understand the Linux guest hibernation and resum=
e
> flow and its implications for pvIOMMU.
>=20
> Meanwhile, do you think this limitation should be documented in the
> commit message or the cover letter?
>=20

Yes, I'd say that the lack of hibernation/resume support should be noted in
a commit message, probably with Patch 3 of the series.

Michael

