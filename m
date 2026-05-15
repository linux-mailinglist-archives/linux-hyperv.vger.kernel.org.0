Return-Path: <linux-hyperv+bounces-10915-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NFzA8c0B2qQswIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10915-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 16:59:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C64C551C90
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 16:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1663F303641E
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 14:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD49E3B6C15;
	Fri, 15 May 2026 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="F1dW21Rh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012049.outbound.protection.outlook.com [52.103.10.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCD53B5310;
	Fri, 15 May 2026 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778856703; cv=fail; b=aoocZKSjeK6cZhjaQnCDhURtSxbaIkeRwqh44EZxZmH6TYkBiHB9llFsAFpjdfu7zpmC04WcJkk/1GgKKyrRHuQZAYFs0fTdpM3FyyFaBbPjButeQCQT6CKiTYTzyL1T3g8U4JLVAmODfiaSRsnHnMZZZGSvDT1qs7lxBDo4QB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778856703; c=relaxed/simple;
	bh=33r6PRj6oHXc0LbWO1mb8BuKbmYyzgAGqTujEcsaz9M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QPHJ+ZhBNsmce4aTts5ZPKGAQ7oTA/1awGvKLeuZpPr59klGPX+kVnXdQMy472tTJpHVs99jBKuJ7zq+KA5oDm7NgMpslwyGPSz27P29Q+hzWMAzvAXcxUlSohhNXv0yuldu22GJv/cAdBbLvZRBfi4IXikIds48GwZYVr1rYRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=F1dW21Rh; arc=fail smtp.client-ip=52.103.10.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpBsq3buN23ObKJX0YWBa5Z1nfRSdixd+MeEMEEHXHKWFtm7b9RPLrXSi0bJzv2VANK0/PhlBM0gUXE2txTb1WxeTBm9R5x9dxWymtlaeYU2t2JDC1L+95muScUkQ+Zvvf8GPMINOPMC7aQbvruh3XVXXtlog3ZEtLTd6F9Wn/U3ZMJLTCbqEyLOInJVQxT4ZL6V0P0RMB20Kydt4siHLFpKPTgNa/CzhxOvSrR3tu0qPGNNS8EwR+zU9hEVliLpH471LhMD7XN6IfpudDdbLiTn8W/qhZtQ9W8/XsO675IEq7GTfgdmX3iiyYfrbYJBEBINK3QKSjfQzFTokDxFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVfar2pwCnWhJ2TQTqJKjZGvqPKG3krQ7uqGS1WtwUs=;
 b=BdLjj+ePeQEpvpPZGABIB5IrePlnMpcxHwd4aPX0UH9ggVEp1SqklUGiYfKR37VqpQwdyQwdDIgZarxtzqDiJO+nJdEY1Gqqy6B6bRMIVOpDgaiuK5W7Vs8xIu2Z+NeWuvAJl1TsUOEc4d3L62/Vo3fjCfTtm8Q65DFYb2H/MYXNd5PlOuwoziwmywWhfdhfcVrnDjFTs0Y1fQeZRL7En8vLqRwvUuy8kCqKtxL8NH/+f0aBP7hn5rHbhvbROmResJGfs5Vv8sNzeMvkVq+R3ijnEPlPP8n+BMrzn9K++huwf9jhjkKmJ+W+Uhjz5PyiZMfG+JtBm/vw3tQ+oLbz/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVfar2pwCnWhJ2TQTqJKjZGvqPKG3krQ7uqGS1WtwUs=;
 b=F1dW21RhrxM8BhQ4VGsqVW6mP7DOceZ9Sv42vCOSMzxANcz1J5BKBl/LMHGuxoO94uD0nwqmq6+A2Sui/7de7P4ofOJICT1wqwuhQybtNSeKGdeM0vXYRyghRcReMpipDEWDOc46NxFQEkPtXs8trsDbyk1atW+JGwv1uDrCbgISlrMtKO1lVX/58Uu+zEhO87npIi+ci0wOtYveOFw3JG+IaoKbNu5zFeSjSrhmC7+Ywj7CzVYn8lFFi9l4bsBI0hj4QvrPzqSKdR8dhncTJwtfgqDaN0p8NqXjLqvkwOTZ8xa0bHxfNKMMvjIOb1P/vA29tZXNr5sYFdtyDSxQ7w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA3PR02MB10115.namprd02.prod.outlook.com (2603:10b6:806:398::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 14:51:39 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 14:51:39 +0000
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
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>
Subject: RE: [PATCH v1 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Thread-Topic: [PATCH v1 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Thread-Index: AQHc4WKng45scVRbCkamiCGsElTD+rYN1+PQgAFLfoCAAA56sA==
Date: Fri, 15 May 2026 14:51:38 +0000
Message-ID:
 <SN6PR02MB415734108A86BDFB66AEE4CED4042@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-4-zhangyu1@linux.microsoft.com>
 <SN6PR02MB4157FB81CC9B6347DCCC8C56D4072@SN6PR02MB4157.namprd02.prod.outlook.com>
 <qeyycsdnejwrqle4zwrvkjvkvrpjifeanwxjaa7i7y2ab7rnt2@b6gvugqayarg>
In-Reply-To: <qeyycsdnejwrqle4zwrvkjvkvrpjifeanwxjaa7i7y2ab7rnt2@b6gvugqayarg>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA3PR02MB10115:EE_
x-ms-office365-filtering-correlation-id: 1ad705a0-4b18-4958-2cf2-08deb291786e
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|15080799012|19110799012|31061999003|13091999003|8060799015|8062599012|51005399006|55001999006|19101099003|37011999003|3412199025|440099028|12091999003|102099032|56899033|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vzokSle3ENeWswNj60DjNGWjU7wIasZac+lyxUTn3qMtlvXq16E4Gr+VjJCC?=
 =?us-ascii?Q?z3z4KZEjeUruLoAjpK3imTTWs7w3UcnjRzPoYE3fyYBCnd/x4J1E/TBt5gaR?=
 =?us-ascii?Q?6D7qnJIxoq8LKO6zEkQBZo6+OeSZP+cuIJVS89c9LxQaYq6xiFr0BHeZJg2C?=
 =?us-ascii?Q?a9iyMM1CF4h0bnxNuqB3GJGv3cxoGZ4YjpV2mcE2pLKtJWeu2bmi7GLj0Ebr?=
 =?us-ascii?Q?OM8n2I1h66AS1X1MGf8avZ/F/hGAXfY/ynaoatwscr45f8KZcHguJ2vLM2KZ?=
 =?us-ascii?Q?cvnpP5UXeYfSTy79OFYDijU6t1mZt05SrPFvVcRrr3s+X3uHMTfHQhZonV2E?=
 =?us-ascii?Q?gbd7Cn96C+gqe+HqMEE6jvK701J9TwoqSbUGYw8rqiy38U0e7WBsCWvLmzGP?=
 =?us-ascii?Q?jse6rqbaH/FCfiALtlsIzTVz3UX6zbNWuR7Jm3L136W3gpgKON+3A3tXL6em?=
 =?us-ascii?Q?GV3hFvHJJ+b1s7wJTpeiRmzofshhfeqVDaZ+jlJw1+T9bFN9Hd5Zk8qHtWL9?=
 =?us-ascii?Q?I85H7Otznu2K9W66RpIuFti74DrIa0er+QBT0alghQXYjW/cA+s9GJ2By0ro?=
 =?us-ascii?Q?hxUVDWWe5aUuAL0yOvi9RFZ70+ZquRqme6zo5ljv6MnfcAmYId47Z9svwhn1?=
 =?us-ascii?Q?0/3lxUa8pjebdDH/icyY5yzBQSk3BpOpjxP3tKMLVtjKQaRkcHzaqP/Pi5hB?=
 =?us-ascii?Q?Wybw6/yceFefo+7jaKpdvhz/5gwbbjZ2aW21J35EUMjEZPp2Q3yexu4bUq+a?=
 =?us-ascii?Q?nVrAhwtaJaFc3YPXOUhdNS7awa6gSe589f/WgOh59vWCZprRIvAFn1Mk1kMG?=
 =?us-ascii?Q?z9dnXatSKCK7fQS+kgzks7srzGoPHZWjjLQWrLLFavTN83B2p1NelAfSWBN6?=
 =?us-ascii?Q?zPqL3sZ3sLe0NdsLFisrFFdX5Hu4MyOoFpAfOLYZnY0InMSt2h2P3kRmHQjI?=
 =?us-ascii?Q?setI3zuMkPANYqeN6QGkoRmeUzA0iT57IZa8+/uJwIkn1nt+7pWua3zFta8b?=
 =?us-ascii?Q?rKDWGb9QmGWmz99z9FCxzOH6YPXiGu0oN0ptBO/+5Et+wpaYygMU9PJViNvi?=
 =?us-ascii?Q?KLgCQo3J/StYLsr7jqxO2sEQgQZURHx4z5Ec+jbaVWlLEJamR8dK2J0poJ5K?=
 =?us-ascii?Q?z1VPRcoPglIs?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?853qDf4J4HJ63cGmjl0b/75kSXKktsx/wqVh22Y0XMLVqecT05j3Dr3ipmq+?=
 =?us-ascii?Q?oOS725NgRF3qml+PxTg7vG/bRgJ5NPAxgwJEImQ+axoUnTObAMV6zABXiRkK?=
 =?us-ascii?Q?lI2hInRS6mG1F5br2qF/aDIj56/hodjNN7W2lHOq5QMmXnzc1vn7/jtAYOor?=
 =?us-ascii?Q?2AIT1yJnqjxdpCQoQ4ySOKqkE/BL/up+kWNOz9V/yqcefQCkbduclz9l+OM7?=
 =?us-ascii?Q?YNE3qCKKC+0NJSlQQnwaGYUrRwYZcxA/Gwa0ABX6bDiWUOSs33Rlj8SBkglf?=
 =?us-ascii?Q?xWEQpsCH8DpyVAvmSL9Z/D2vSIjoBQOhVvwHQVr4mdSGKigB6rPcEpGjnVF9?=
 =?us-ascii?Q?LXmnY4aYCHf1jOhpJA4Jo4qSIXW7Uyz+8RTEKiNdnCF7gVISWhlGupWgtK2I?=
 =?us-ascii?Q?6jxGgvdpflXk0Kb8Vd19Hk2xmiFpQX4xZaCTLFSPwvIMSht6kBbsT/qLbZCD?=
 =?us-ascii?Q?xN0Xw3LHd7XtZjH06mTl32mXxrfFLnpiZ0+D3Ay86X1NSKgb88gkbZ0znjvl?=
 =?us-ascii?Q?EsxxOQ0DNmFsVuUW4yUWsd7O+4Cat7j9uHlwbk5t2Zl8e7CBhO0BhkmBrEkG?=
 =?us-ascii?Q?aa7Tvt+EBbfRT1D2ImFRxJ6MuGDqhjBBRs9QHIpO+Fr3F+pB70pJjUisX/T6?=
 =?us-ascii?Q?T0fX1IzkQD8+/rWJbfl9TqKrIwznnoI7ITS92dxREo8tCHlf3ESx8mBOK3+m?=
 =?us-ascii?Q?Zj5yxm5BfOqtmxE/hLH/gouzRusWsrk8idIdBP06PlHtN9bJTbHO1oDCMa/d?=
 =?us-ascii?Q?irYdx3/BEXVEmkSYjgnzgR+K6v6KAXPCuKGvf6XwWd5DTv5JmequEcADenzG?=
 =?us-ascii?Q?KxEpv9BE2qOGHsYrE+dC/rD4wQ1FYZKj7B1/eh/AZHcmGnLy/jt/cq8uIbG/?=
 =?us-ascii?Q?jA8i9Ol8WO02TOw/CfkyA2BXXSbOEZqXjwP70diBy6NomV2scK3HEhLHsiNX?=
 =?us-ascii?Q?R2iVMTP4j8Biyn8DU9d/8IgsL6vxZ2fkdIEXz/sUK0qmOmDqI/9L8C4gFDSJ?=
 =?us-ascii?Q?K2BT4+59ZlTE4bdXjgpsBcZw6JsCpiKvtAEuGBH1uPjMbGwP4YCL3SflEnOa?=
 =?us-ascii?Q?jyo0NQFd3YHjne2rqna+CXBj1pnhJHWSgytr3hLzWIpi+1r+hEBnZ+LQFfQi?=
 =?us-ascii?Q?pf6XciEjnEyqUW5WQW1A+d8S+zz8jA9okKeTWyA0XJOVxyUqNfRCgtOStFQ6?=
 =?us-ascii?Q?XDxHTZ3RCpoNb1UIER7b2a287ZYup9Xobn1dr09OvnSm67LuDWe4UENM+iyn?=
 =?us-ascii?Q?WazaVFUfyTFXpoknK1XgZqEyt9GU+GEchN4GINOgEjFhqJ3Bma9ke8GWnMGm?=
 =?us-ascii?Q?+VX2VWTx61PFGkHUmqUsnr1h6HKVVjgWVOuZ+k0oMcFcOnSs6srJXSLsey0R?=
 =?us-ascii?Q?7ynonc8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad705a0-4b18-4958-2cf2-08deb291786e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 14:51:39.3649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB10115
X-Rspamd-Queue-Id: 0C64C551C90
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10915-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_TO(0.00)[linux.microsoft.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,domain_id.id:url]
X-Rspamd-Action: no action

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, May 15, 2026 7:=
00 AM
>=20
> On Thu, May 14, 2026 at 06:13:24PM +0000, Michael Kelley wrote:
> > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, May 11, 202=
6 9:24 AM
> > >
> > > Add a para-virtualized IOMMU driver for Linux guests running on Hyper=
-V.
> > > This driver implements stage-1 IO translation within the guest OS.
> > > It integrates with the Linux IOMMU core, utilizing Hyper-V hypercalls
> > > for:
> > >  - Capability discovery
> > >  - Domain allocation, configuration, and deallocation
> > >  - Device attachment and detachment
> > >  - IOTLB invalidation
> > >
> > > The driver constructs x86-compatible stage-1 IO page tables in the
> > > guest memory using consolidated IO page table helpers. This allows
> > > the guest to manage stage-1 translations independently of vendor-
> > > specific drivers (like Intel VT-d or AMD IOMMU).
> > >
> > > Hyper-V consumes this stage-1 IO page table when a device domain is
> > > created and configured, and nests it with the host's stage-2 IO page
> > > tables, therefore eliminating the VM exits for guest IOMMU mapping
> > > operations. For unmapping operations, VM exits to perform the IOTLB
> > > flush are still unavoidable.
> > >
> > > Hyper-V identifies each PCI pass-thru device by a logical device ID
> > > in its hypercall interface. The vPCI driver (pci-hyperv) registers th=
e
> > > per-bus portion of this ID with the pvIOMMU driver during bus probe.
> > > The pvIOMMU driver stores this mapping and combines it with the funct=
ion
> > > number of the endpoint PCI device to form the complete ID for hyperca=
lls.
> >
> > As you are probably aware, Mukesh's patch series to support PCI
> > pass-thru devices also needs to get the logical device ID. Maybe the
> > registration mechanism needs to move somewhere that can be shared
> > with his code.
> >
>=20
> Thank you so much for the review, Michael!
>=20
> Yes, I looked at Mukesh's series and noticed his hv_pci_vmbus_device_id()
> in pci-hyperv.c has the same dev_instance byte manipulation. We do need
> a common registration mechanism.
>=20
> Any suggestion on where to put it? drivers/hv/hv_common.c seems like a
> natural place, but the register/lookup functions are currently only
> meaningful when CONFIG_HYPERV_PVIOMMU is set. If Mukesh's pass-thru
> code also needs them, we might need a new shared Kconfig option that
> both can select. Open to better ideas.

Unfortunately, I have not looked at Mukesh's series in detail yet, so
I don't have enough knowledge of the full situation to offer a good
recommendation.

>=20
> [...]
>=20
> > > +static void hv_flush_device_domain(struct hv_iommu_domain *hv_domain=
)
> > > +{
> > > +	u64 status;
> > > +	unsigned long flags;
> > > +	struct hv_input_flush_device_domain *input;
> > > +
> > > +	local_irq_save(flags);
> > > +
> > > +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> > > +	memset(input, 0, sizeof(*input));
> > > +	input->device_domain =3D hv_domain->device_domain;
> >
> > The previous version of this patch had code to set several other fields=
 in
> > the input. I wanted to confirm that not setting them in this version is
> > intentional. Were they not needed?
> >
>=20
> Oh. The RFC v1 set partition_id, owner_vtl, domain_id.type, and domain_id=
.id
> individually. In this version, I just simplified it to a struct assignmen=
t.
> No functional change.

Of course! I should have looked more closely at the details before making
this comment. :-(

[...]

> >
> > Previous versions of this function did hv_iommu_detach_dev(). With that=
 call
> > removed from here, hv_iommu_detach_dev() is only called when attaching =
a
> > domain to a device that already has a domain attached. Is it the case t=
hat
> > Hyper-V doesn't require the detach as a cleanup step?
> >
>=20
> The IOMMU core attaches the device to release_domain (our blocking domain=
)
> before calling release_device(), so I believe the explicit detach in the =
RFC
> was redundant. I simply didn't realize that at the time.
>=20

Got it. But after the IOMMU core attaches the device to the blocking
domain, there's the possibility that the vPCI device is rescinded by
Hyper-V and it goes away entirely. Or the device might be subjected
to an "unbind/bind" cycle in Linux. Does the detach need to be done
on the blocking domain in such cases? In this version of the patches, the
Hyper-V "attach" and "detach" hypercalls still end up unbalanced. That
seems a bit untidy at best, and I wonder if there are scenarios where
Hyper-V will complain about the lack of balance.

Michael

