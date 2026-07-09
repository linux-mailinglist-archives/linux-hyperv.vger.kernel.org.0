Return-Path: <linux-hyperv+bounces-11885-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CSaUF0HzT2oPrAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11885-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Jul 2026 21:15:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E194E734D56
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Jul 2026 21:15:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=P2nDBvhL;
	dmarc=pass (policy=none) header.from=outlook.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11885-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11885-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43D70319E8FB
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jul 2026 19:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8154E393DFB;
	Thu,  9 Jul 2026 19:06:24 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010022.outbound.protection.outlook.com [52.103.23.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B542732FA14;
	Thu,  9 Jul 2026 19:06:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623984; cv=fail; b=a4JS0fuOgYd1kNsd4pR/0IWjAm9nX5cevbagh/9rSj3eIcYzwN2Krv7sIsVvDuOpvJPaLE0CvAPtF9Z/baT/vvhrCMYb2UbsKSfcAZWf9J+4HeUzmbze3jckVCNZKYWvujdFmaQdqWyonqrNmOPZRUXatjGWJS+xqWvWtOruRwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623984; c=relaxed/simple;
	bh=apELpCjwfho2nZ2gFHmc50q8/mmVqTKLFBwBzUVRidU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KNCkekjF0EuC9YiUg7JD+78wKpG+dMJicjtnftNputpz7s+SuQb1bLXcWeSPYeouRYCmJCwIhyOJBh97qPAAY5xUdjRmn7F5OGZYHVe4m5Jj9dwaLwdJqKGchnTvD+oMuolgXizTmztyHgY08qHSsVjlVYEi6c23ppL4hlRcc6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=P2nDBvhL; arc=fail smtp.client-ip=52.103.23.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvjYyQxZyh/xzR35Y/exNAIuZTEcoNwxk2a2ZFd231oyT6XmjaImJGx9A5pw+cUFCSqKDvKDyNdQMf2WRlEm8hT9qNEssejzqyreIN3UabKMbpCE1JQlI2zFzvlLDmSIaUamdNl5Qcc8wwI/WNFiBHAQn8I1eHhI+9PgzSeQyDEs8uHzwGp8Oh5H6RNwPg4y0rwiiBnELtAeweM7i6afFphTteceVsQigw0SnkSFXfDcuB7B1hSTsVOiZ08jdx/vEa0GpGaAiLgN/7C95S7G6mP+1Sv9Tre0UYfy31wGIz+ela2YcauWFTm4cU3yJLkAQg+vhRZ7AJeBYZjqWzGZow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCpIBjqfrHL4uqv/qDy6NZwCBJVTyr3t6uyRUihpmsk=;
 b=ycXKzQ9N2hpJZCggJzlTbpRrjO3R8MQZg7BtYkOAOHnRqWvJSKWLN78HwamMKbII4agffIAUNU5aCJ6OEobFcRbqoWG+u1p4r0KwOziiqTitzBSLbC1WqsBSbX/jThm6gQXlP9r/NEMN58P27xcPwTKORktUoP+zz+X27DjTIaWft3mr6tjas1CsRlHe+sRHyAzGc6vSu+SDfsAZHNpu1FnNm575HM4EkgUT816bGd6lmMCD7DXrKloJPET13iAK3ViR9pMEK86r8qCUREVv48CRsNtNuXPN/E9VltpbFGeo8XAHr4ED0qgM5dWHqVHIfK5hhRJ3HKe1Dc/cHHHtEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCpIBjqfrHL4uqv/qDy6NZwCBJVTyr3t6uyRUihpmsk=;
 b=P2nDBvhL9075sNFij/pTjeQvplU5/+nN1Qf0rcUvlUoAknAJy7RdULD/QR5lAUPqq6XbZdIV6k9EGQwwew+aRvez2eNPCbX+GZ9i9KZ6UgblPOoTWERzRB3qFvq3L/yGS3rWtKLNzf+k1oNT8Z/FdqUh9HGpKEn31vIk/6xydpBCU8zz2rS1eHHiy73CSsBQILFBHWUtpLEBlU86xumX/39IUYpI4Gqyv7dZapVNRi9nzGF1awxg3OM6mUz8qCxSTv5EhedTVtCVdVkp1j6weX8ClKTRKu0qHQ9FiPyipgGKAvbwv76SW2XMO7KBrHjqd2BVBSMYRbB2p8FplnkYmA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SN7PR02MB9282.namprd02.prod.outlook.com (2603:10b6:806:342::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 19:06:19 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 19:06:19 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "wei.liu@kernel.org" <wei.liu@kernel.org>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, Michael Kelley <mhklinux@outlook.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
	"tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>
Subject: RE: [PATCH v2 1/4] hyperv: Introduce new hypercall interfaces used by
 Hyper-V guest IOMMU
Thread-Topic: [PATCH v2 1/4] hyperv: Introduce new hypercall interfaces used
 by Hyper-V guest IOMMU
Thread-Index: AQHdCjycyNh7qs1rXECHBzYrllgCabZll5Dw
Date: Thu, 9 Jul 2026 19:06:19 +0000
Message-ID:
 <SN6PR02MB41579A957E1C81583BBA1119D4FE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-2-zhangyu1@linux.microsoft.com>
In-Reply-To: <20260702160518.311234-2-zhangyu1@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SN7PR02MB9282:EE_
x-ms-office365-filtering-correlation-id: f2040904-ec2d-403a-9cf9-08dedded28cf
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBvhuFgLLe5qs4jWk9CHdv0AeU0cRM4g2KqdeRhhQPOp8TdzRrmnDWhAYftAyiWcHROiGL4wcgjeZG6u4mOQtdIo2FYS3FfxzulEv8/YGuyRDFXvQeG5hfiBNs4kKV36sPvZl6yBzPT9i660EugPLauA6tDquaIYSsH5N1uAvsrLTvVdrqSXot+xZOVACSaCfNrB8TtkV31eDkdAwzDSDvjZtNs9HOd4qGPeOnGXrQ5dBBSxOTPoltGf30o8D1iIV99kQXzbZ88ftgjk320xUQr3HFCn6/s1Ej2/A/0JSSQN0IzX1di6xi7u+p61wiJJW3m7prPuw1HYE5LSvU0UzUiW6HNbMmLXBXdL0RCt+nZVAn8rdm0U99YE9IUlsTIVYx/jjp9lJ4g+RiUUWlI/VmEbfaZhy7gaFkAvfWe1+DTi+PMnFC+Jo3aLr3QLE9+b+AdamIkAHiClTWfutW5ZKFuhwula6X2l6zlzqMuMR8FxibHu78hGy8SP5n6tHkosnFbhBoJtWODentdIZQGbkYWVbYk0NZBpglkYureAfIusgKe7xYMIpp7lmG/dV6XgOfW0hJkQqDs2grBCbqEOJdU9dJvJezftNxOO5hciKn2WTM509DgLdK13gzAM89toXlA4tKS+DGgQSUG4EDRZQqpsyWsEPbsPNSJzV/h+rKpt2bAKuiA0gFS6oPE+0gqL5/Pm0WpUqKJTOs0qWmCVKB0kT5/A/W/MiLXYvElVZ1V6v6A4gBq4C9WzfZtyWgbz119dOgEYN7zzETBEb1d12bPo
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|19101099003|25010399006|31061999003|15080799012|8060799015|12121999013|13091999003|19110799012|51005399006|8062599012|41001999006|3412199025|440099028|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?eRK2xNWj7Uhqw0v+cjabvjclA9TwWA2CN43mqUQkPHd8Qgb+H34kD1v7gibB?=
 =?us-ascii?Q?Pus7rehLTKteokAj7fE970EbKLe23GfBBWNTlYS2mdNFxreYHlnpvazNpwtq?=
 =?us-ascii?Q?dTD1f266IsZnPbVZlR0lFRyr3MDCada/kVF5n44zJRdT5/ned6eFQmfyd7Rg?=
 =?us-ascii?Q?77kPqu8UcpxugqNtLqk8/IL5JUbaK5k+tYgMkF4QGAD9elpH3t9Iaar6iqjt?=
 =?us-ascii?Q?V+YaWj3PsrDUkBpdeqHvky6ymLvz92DWLA65+JRwn8sJJC9qEGkb+1cc2HI1?=
 =?us-ascii?Q?w6Li9pAUAe68uHN8TRAPnFCXoN0eGsF94dg04BK9nYUTIqQU2CNkh26oIjdk?=
 =?us-ascii?Q?HxOheGcw210z2HmYAxXrcfMMiXGsbq4fkixtyncFiQtA489ON1naUlKDm2qw?=
 =?us-ascii?Q?lBronOClIDKQDtj+R2r9Hg4XRlC1ygId2eI8GqL5mzFVb+ZN6q2X2kITFMlb?=
 =?us-ascii?Q?+M+0uwqvHcnix/fIRx3JQH0BlKB7nE8gSNkUsae/aDgLOXqz3it3gg9j0DA6?=
 =?us-ascii?Q?ckIz9TIW1zVljnUQ/fnKNva+LTGcgYqaYns5bJmb7OTxm8J/WrhkhbFX/fMc?=
 =?us-ascii?Q?gPQ3T1YO1W8XnMA8Q2IHBzVGs1ScQJPVTOMtrQaCB2fdkHMNQm8fdQHYrxzz?=
 =?us-ascii?Q?jxJ5vpkLeca9wCsMB4FI5HHQelruHMm5+Ua7kXMu17neCoK+B7WGqLZy4t30?=
 =?us-ascii?Q?Ah7hXZZvjG3pLNz8IQqijNNzRI/cyOS8MJyexl/ywnkWWtZpTpT0eDS/mIYb?=
 =?us-ascii?Q?80swl7ZSIeHGjII/gCXo2IijUNAuVQ+xof82xDXDZy52o/xyUTmy71nO+Fur?=
 =?us-ascii?Q?SERPx90PlJSEW9f0H5zsCuu1r2j5O+IkhDtPLlxgBZebSYBeCWLROU7iGkDL?=
 =?us-ascii?Q?Ht4nlQiw9ZpD2+M0z7Vc3jSQvcCG/7w2/HYMa9LssBsDeL8c5f+sIAuxiRre?=
 =?us-ascii?Q?nVYViRxcaM7gCyzk7FoY5aQz36Mp6V4bWcFb2Hhq8YANST4pExbV9o7AQtWS?=
 =?us-ascii?Q?4Gl+RnPfjDYL65uE8pnGrZFECtCjSth8Di3Lxtuxn70w7wVmHeWCBEgWSVrD?=
 =?us-ascii?Q?escXv9cgJFpPEQ0xRMlRqN3lzacYDg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nAjqTR0L57/XBHK83DZZhqvsx+KqgAZWmFW9WBjo6oicnUgKDyxuxDpH3u0p?=
 =?us-ascii?Q?rcxvz28lDZ9uZGmApkGyrJgRBornuP8iYHUoFs5veDHMyNZekkjdMEfxrQA8?=
 =?us-ascii?Q?+iHEatTfjVhcPxHlygczNYQqEyivVpfef94I3RbvXzHmoclIy0YrNqY9EEhK?=
 =?us-ascii?Q?GAkeqryLPp+hg+QHh55i2GFwmZ7rjnVBs7X6SMnyHUjipwDRc6KFGGygiHaZ?=
 =?us-ascii?Q?WWEyLRl9QoQcHUk7ZJ4XkEluT5Aa1O/J93uqq9HMf/Z0AGT6eEwHqwXw5uN2?=
 =?us-ascii?Q?edoQVm41KgVOfdzUSwIrnkbJzF1jdZv6BKurZ/+fjuSsIMmtiroobTGf20vX?=
 =?us-ascii?Q?n76qUAw49TVnl2JDJ3U2ZC0vi/VWvjA96KeuZTn0IApMb2c/NCkmxrKT8frX?=
 =?us-ascii?Q?q8PYJaFv4mxWfh4eBszQ+O2N6D/MaLreAvvnC/rsZVrv0A6/DxtkkRws8VmQ?=
 =?us-ascii?Q?/UP2inKivjoMcg8dcJ7v0javHPYyTE5RW6ZJTJ9oStQTc1uSRgtea5+eNb8J?=
 =?us-ascii?Q?14FAbKzhCDiPF5X1O8/UVbFT2mdi+gaFHKUwe3oQVb/ZJale5DW46FvPBjFF?=
 =?us-ascii?Q?kHHNHU7fq01vuB+IWBeBq5fYWClBPXmowQWrTKNwqkIuSfEMgwuPtlwGbeN0?=
 =?us-ascii?Q?mTlHeTPEojstRIsDAdCEhy6BPUTBNXa4zAWqjUiNBgSt5W6iSgcSuicKyqrq?=
 =?us-ascii?Q?5fdUnOzyWvPRKH40QktDhKzW61OqrInXfm7louHBL6LLfuw8J1/LSwelqS8P?=
 =?us-ascii?Q?zYpcm+WCfkzjB0cC91yXpil1GNhm/MJikJkoMZuQn8D5I/mhxchFwPYkMQj2?=
 =?us-ascii?Q?0jKF+pJpaRGjvMSgPRQFDyLxSuHusDOPFdrfveSUH+SfljSgglldECjusXY+?=
 =?us-ascii?Q?BsMiD8vfVlIScBtuZ5ySpNSFtHvu7j0l0/PQ7c/ztX+TKD4pjAJ+aUUpIw6T?=
 =?us-ascii?Q?2atWFPOfdAyqNpJk9beoCZ0KyLPSojPwpawq8PnBXJOYompuwS61jglX7Z9j?=
 =?us-ascii?Q?3QUKV8+W7jH53HHN7+1sBwL83qEYUBI+A2131aUCr4MKkcjcndsKGfEwGRLl?=
 =?us-ascii?Q?ie6sZSra6Afz88JEGROOs5kI8qZ2Mf3o/PlXgWl/vVsfJ1iEcD3oJDotTDvL?=
 =?us-ascii?Q?Vn7R8JMD/d2cndLwKO0MhBoKGrai6pcS1G1bYILZa6DbklU8g283dDKYKwNa?=
 =?us-ascii?Q?MRDjs8nrAb7uujEgZXUrF+ETstq46zxJ2piXAynAqx0cPURsZAVzc0przvcs?=
 =?us-ascii?Q?cupLEIJq0S4N8BSYf6r+D/P7Eo65IMNCQArk3b4UjteYW0m04FCuEAX+9Kuy?=
 =?us-ascii?Q?0KmrAkuxZ2Ld4/ms/gcj7AETsuGWRRk2HAC2fWupfnpp6SxN7GiWA8XWW9nK?=
 =?us-ascii?Q?MQroaas=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f2040904-ec2d-403a-9cf9-08dedded28cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 19:06:19.4269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR02MB9282
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11885-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhangyu1@linux.microsoft.com,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pci@vger.kernel.org,m:linux-arch@vger.kernel.org,m:wei.liu@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:lpieralisi@kernel.org,m:mani@kernel.org,m:robh@kernel.org,m:arnd@arndb.de,m:jgg@ziepe.ca,m:mhklinux@outlook.com,m:jacob.pan@linux.microsoft.com,m:tgopinath@linux.microsoft.com,m:easwar.hariharan@linux.microsoft.com,m:mrathor@linux.microsoft.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,8bytes.org,arm.com,google.com,arndb.de,ziepe.ca,outlook.com,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[26];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,outlook.com:from_mime,outlook.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E194E734D56

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Thursday, July 2, 2026 =
9:05 AM
>=20
> From: Wei Liu <wei.liu@kernel.org>
>=20
> Hyper-V guest IOMMU is a para-virtualized IOMMU based on hypercalls.
> Introduce the hypercalls used by the child partition to interact with
> this facility.
>=20
> These hypercalls fall into below categories:
> - Detection and capability: HVCALL_GET_IOMMU_CAPABILITIES is used to
>   detect the existence and capabilities of the guest IOMMU.
>=20
> - Device management: HVCALL_GET_LOGICAL_DEVICE_PROPERTY is used to
>   check whether an endpoint device is managed by the guest IOMMU.
>=20
> - Domain management: A set of hypercalls is provided to handle the
>   creation, configuration, and deletion of guest domains, as well as
>   the attachment/detachment of endpoint devices to/from those domains.
>=20
> - IOTLB flushing: HVCALL_FLUSH_DEVICE_DOMAIN is used to ask Hyper-V
>   for a domain-selective IOTLB flush (which in its handler may flush
>   the device TLB as well).
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Co-developed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h |   8 +++
>  include/hyperv/hvhdk_mini.h | 124 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 132 insertions(+)
>=20
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 6a4e8b9d570f..5bdbb44da112 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -486,10 +486,16 @@ union hv_vp_assist_msr_contents {	 /*
> HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_GET_VP_INDEX_FROM_APIC_ID		0x009a
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
> +#define HVCALL_CREATE_DEVICE_DOMAIN			0x00b1
> +#define HVCALL_ATTACH_DEVICE_DOMAIN			0x00b2
>  #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
>  #define HVCALL_POST_MESSAGE_DIRECT			0x00c1
>  #define HVCALL_DISPATCH_VP				0x00c2
> +#define HVCALL_DETACH_DEVICE_DOMAIN			0x00c4
> +#define HVCALL_DELETE_DEVICE_DOMAIN			0x00c5
>  #define HVCALL_GET_GPA_PAGES_ACCESS_STATES		0x00c9
> +#define HVCALL_CONFIGURE_DEVICE_DOMAIN			0x00ce
> +#define HVCALL_FLUSH_DEVICE_DOMAIN			0x00d0
>  #define HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d7
>  #define HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d8
>  #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY	0x00db
> @@ -502,6 +508,8 @@ union hv_vp_assist_msr_contents {	 /*
> HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_MMIO_READ				0x0106
>  #define HVCALL_MMIO_WRITE				0x0107
>  #define HVCALL_DISABLE_HYP_EX                           0x010f
> +#define HVCALL_GET_IOMMU_CAPABILITIES			0x0125
> +#define HVCALL_GET_LOGICAL_DEVICE_PROPERTY		0x0127
>  #define HVCALL_MAP_STATS_PAGE2				0x0131
>=20
>  /* HV_HYPERCALL_INPUT */
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index b4cb2fa26e9b..493608e791b4 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -547,4 +547,128 @@ union hv_device_id {		/* HV_DEVICE_ID */
>  	} acpi;
>  } __packed;
>=20
> +/* Device domain types */
> +#define HV_DEVICE_DOMAIN_TYPE_S1	1 /* Stage 1 domain */
> +
> +/* ID for default domain and NULL domain */
> +#define HV_DEVICE_DOMAIN_ID_DEFAULT 0
> +#define HV_DEVICE_DOMAIN_ID_NULL    0xFFFFFFFFULL
> +
> +union hv_device_domain_id {
> +	u64 as_uint64;
> +	struct {
> +		u32 type: 4;
> +		u32 reserved: 28;
> +		u32 id;
> +	} __packed;
> +};
> +
> +struct hv_input_device_domain {
> +	u64 partition_id;
> +	union hv_input_vtl owner_vtl;
> +	u8 padding[7];
> +	union hv_device_domain_id domain_id;
> +} __packed;
> +
> +union hv_create_device_domain_flags {
> +	u32 as_uint32;
> +	struct {
> +		u32 forward_progress_required: 1;
> +		u32 inherit_owning_vtl: 1;
> +		u32 reserved: 30;
> +	} __packed;
> +};
> +
> +struct hv_input_create_device_domain {
> +	struct hv_input_device_domain device_domain;
> +	union hv_create_device_domain_flags create_device_domain_flags;
> +} __packed;
> +
> +struct hv_input_delete_device_domain {
> +	struct hv_input_device_domain device_domain;
> +} __packed;
> +
> +struct hv_input_attach_device_domain {
> +	struct hv_input_device_domain device_domain;
> +	union hv_device_id device_id;
> +} __packed;
> +
> +struct hv_input_detach_device_domain {
> +	u64 partition_id;
> +	union hv_device_id device_id;
> +} __packed;
> +
> +struct hv_device_domain_settings {
> +	struct {
> +		/*
> +		 * Enable translations. If not enabled, all transaction bypass
> +		 * S1 translations.
> +		 */
> +		u64 translation_enabled: 1;
> +		u64 blocked: 1;
> +		/*
> +		 * First stage address translation paging mode:
> +		 * 0: 4-level paging (default)
> +		 * 1: 5-level paging
> +		 */
> +		u64 first_stage_paging_mode: 1;
> +		u64 reserved: 61;
> +	} flags;
> +
> +	/* Address of translation table */
> +	u64 page_table_root;
> +} __packed;
> +
> +struct hv_input_configure_device_domain {
> +	struct hv_input_device_domain device_domain;
> +	struct hv_device_domain_settings settings;
> +} __packed;
> +
> +struct hv_input_get_iommu_capabilities {
> +	u64 partition_id;
> +	u64 reserved;
> +} __packed;
> +
> +struct hv_output_get_iommu_capabilities {
> +	u32 size;
> +	u16 reserved;
> +	u8  max_iova_width;
> +	u8  max_pasid_width;
> +
> +#define HV_IOMMU_CAP_PRESENT (1ULL << 0)
> +#define HV_IOMMU_CAP_S2 (1ULL << 1)
> +#define HV_IOMMU_CAP_S1 (1ULL << 2)
> +#define HV_IOMMU_CAP_S1_5LVL (1ULL << 3)
> +#define HV_IOMMU_CAP_PASID (1ULL << 4)
> +#define HV_IOMMU_CAP_ATS (1ULL << 5)
> +#define HV_IOMMU_CAP_PRI (1ULL << 6)

hvgdk_mini.h mostly uses the Linux BIT() and BIT_ULL()
macros instead of explicit shifts. But this is hvhdk_mini.h.
Does it need to play by a different set of rules for
compatibility with the original Windows files? I think
the Linux BIT* macros are preferable if possible.=20

> +
> +	u64 iommu_cap;
> +	u64 pgsize_bitmap;
> +} __packed;
> +
> +enum hv_logical_device_property_code {
> +	HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU =3D 10,
> +};
> +
> +struct hv_input_get_logical_device_property {
> +	u64 partition_id;
> +	u64 logical_device_id;
> +	/* Takes values from enum hv_logical_device_property_code. */
> +	u32 code;
> +	u32 reserved;
> +} __packed;
> +
> +struct hv_output_get_logical_device_property {
> +#define HV_DEVICE_IOMMU_ENABLED (1ULL << 0)

Same here about BIT_ULL().

> +	u64 device_iommu;
> +	u64 reserved;
> +} __packed;
> +
> +struct hv_input_flush_device_domain {
> +	struct hv_input_device_domain device_domain;
> +	u32 flags;
> +	u32 reserved;
> +} __packed;
> +
>  #endif /* _HV_HVHDK_MINI_H */
> --
> 2.52.0
>=20


