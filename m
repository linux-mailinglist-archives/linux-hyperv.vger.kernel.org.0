Return-Path: <linux-hyperv+bounces-9874-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PvWG29PzWkWbwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9874-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 19:01:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ECB37E51D
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 19:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7789A30D02CB
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2026 16:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C73478E2C;
	Wed,  1 Apr 2026 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JWwB0+Vr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012017.outbound.protection.outlook.com [52.103.10.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6D147B43B;
	Wed,  1 Apr 2026 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062602; cv=fail; b=Ioi/P/9yWpSizgGVN3drawDRuXE8Q+T504haTzQcZ6F06wMiwcDNqayurY/OqYzAPo0xslgYa+pmBf+nJD4pW3O2jAR+PGe6Ix1OW/JI/ugJTL2hfqfSbD+8j/j1x3P2R/rwBEBzUMAxIpU3t/MUPruqlF1QKrJcB7GEN2vtVbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062602; c=relaxed/simple;
	bh=2tDj1u0iUl3KGYAGP+n0G7lzd9iYiQZ3kImk/Sw88pQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U6MadKN9o5JkhAbXVaXLvWLYev5MAYRtt1dkBnzJl7pTPAv5He6sRYIerKxGn+92emye+90ybeIVzpD/4m17E9Kfc9/qpUIWSO4ndRTBl/7QgU8rMK4ZXfqtiyAMBPPqoePFSsrWQ5orlZa84wy8KdxbOKPNABY04/7/4YSq3qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JWwB0+Vr; arc=fail smtp.client-ip=52.103.10.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fz2Vwo6t4m2PCCb3fLado9rjYZnD2KMwGqlzhCnvi0XU8SrK6fvC73UX4t99XoDiAFt4vtuVMKfS0VE3HJ8bMv9MGdkKoCIVru5izh5z9yPBbHqYyv2Y5iJfKLjZpRIyPXuUv0XtbsUNz1xfjgntt3utKEJRCTp2W4swLl51wiVLdwU1wnS+84K844Cu3quAx8g4TjLljnCFAWsdCQ4WjXNc4l9DHJhesSD30pxCrqVt6lqBAsAW9vuqlj3QlUp3zRKwAYJrYKXLxei7u0nk+DqODJmd4P4HXN9rll6aLrmH4KbyZcNZXtboGSrOokuRFdUop4cCtDfiYVlurfZyNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xo6+N6+VCrJRYzXtm6SF+5TNIUrSiBCHYfB9eXITMCA=;
 b=VesAVe8U2J4w0L+m7ZJ8LeKm0SFeFvDqs+QXr5LLsktWcOIaHxCo7GYgGah3wLUNToaTlr70CP/IsxwYlEPWra4pkdUVnod3OJcXuBtPl97Ibd6ipRU2B7GAiLANneNTX9YiHGcOL3LzCvkiRokbVypI7yLF4LzVkjhSD8fOXtzbFA6xv+LpU6PJJCtzPeEV+C4h2giV9X1trzykRPwZJNDImwRqsTEurhX3v/Fegi8j13VjD61M5/+7sQIZbDVTwTxd8W2F78V2l+T8kGMMSXjUTaEB/tJQdqy3q1QvnP6X1puvaHZ1y8sx2osHAUBiDascIJKcN74//P7cB8jkiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xo6+N6+VCrJRYzXtm6SF+5TNIUrSiBCHYfB9eXITMCA=;
 b=JWwB0+Vr4f9QBpD84/xmJONnuy9NTg95mZtBhT2k2z7CYJ8brvYNEZIZsemjYxPEOJ+F5HC1JSIWiWbrT2smNI6gGqfo6uD808lKdYqGK3zGgIY3yqhvdY3KLz1sTuCV7T90Gl7vvTsBwfQpqImJV2eY2a79fBUkQ4Ccd7h+xG5HgzBBTtSizDw+JmUcX8SBl6bijheSG+R6lh7l3Pxkvbqa3i9W49+ZSORj3eDDofB1nXL5kisxm7kcvJ4FKxlzb/uqFjK2l9hIVABEqDHXjtV34Af4cA1eApAj4NpsOPF3R3B2UnMP+xONmwRhbzhzhs8T9FCjNb8dvISkVTJGNQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6701.namprd02.prod.outlook.com (2603:10b6:208:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 16:56:34 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 16:56:34 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H . Peter
 Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
CC: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, mrigendrachaubey
	<mrigendra.chaubey@gmail.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 04/11] Drivers: hv: Refactor mshv_vtl for ARM64 support to
 be added
Thread-Topic: [PATCH 04/11] Drivers: hv: Refactor mshv_vtl for ARM64 support
 to be added
Thread-Index: AQHctT5V2BuRVBWyKkCpWfaIbANGJbXKhn/g
Date: Wed, 1 Apr 2026 16:56:34 +0000
Message-ID:
 <SN6PR02MB41573C4A21BA96A534E5429CD450A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
 <20260316121241.910764-5-namjain@linux.microsoft.com>
In-Reply-To: <20260316121241.910764-5-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6701:EE_
x-ms-office365-filtering-correlation-id: c79b5d5b-b5ba-4c3a-3ba4-08de900fa175
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6SHOTtrW+lBXVoS+Ao++RiO/3/Eqn5LMb+M6lQ2y8Pje8T9KuKx8ZL0u93Ez8xcbLpP+D5aHB7SmBY7rffJWax9HDOjGf9mqYNHkF6bJDk9p1TRChZxgdpIPmJRW2ljBzy8h38NzMxgTNxLcdRUPkg+SeBw5ovDamYMldcLXFJdTEYiUpUlcjo4xZ7Wmf9SbasJn2mMbsK3aEWkUYzzNcyr0YL+sAAkm26phxMsuXiCZ7FohngeIz3KIOQmGcdqGNTB6PINs+kDy2qYXFRG5rjcUi5XEAbw3jvRUFTaG1gd9ZpIGpySTNPu2B+YT0UX8Y65LLZZKxFVy/uj/7up5NrwKyxHWRtphxTpl5XYyi8lXaCtFjdYBbi++uwZln42ZnwrNNtWRYDw2NkKPkDP/Wiz3cvc4fzrgj8EukBnnHNInYz9ilAYUdNeKo5bKEynuRu1c2Ak4uf/BoI23u9wyI+qe6+tN3ZgFb9LFllqv5rYAv8ZthxmbpQU9EF+eEPa8n+eXr9cmDtsaT5kM+26IGjzjWJ2BDT+KDWXv6/ORDKlCLIO6pIbEn9Taa8zRJaE+/RCa+27EUlgCNuOloRB1NYGYpGDa0b6TWYHDs/0r5Hs7VOpg+ZBdnXQWTLNeHxMWfPhsK1ZgVjOsziswwhacBGF0aAMTMDwxYr2aX2AqAy7E5WuxibC51nYKRy0ubSdjvYjfY2+lKRht5/WruvyUOJvv4QKowQueUYgt4n7iFV4fw=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|19110799012|37011999003|31061999003|461199028|41001999006|51005399006|15080799012|13091999003|440099028|3412199025|26121999003|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ne+eZC/tVYEGQBa4rGD6c/xp3ZCwrRwbXNsUftwgBsdTXlLV6+2AGBRWAQdN?=
 =?us-ascii?Q?UWUwST4ml0KLfeJyLF2usMU6h/e5QxSjFiKX0cZanONA2bUqM4cjsWELv7Od?=
 =?us-ascii?Q?Lnx4j3HXUc4i0/p2lmcVmC+hKLulDU7CCL7xqQ8KTHDRStT0Chuz+gQzCJAs?=
 =?us-ascii?Q?svBG6w9lgb4KrK1IXy5fWSoz/8vPuuD1Z/HCUXRPZjqk0MwqJOUXwXcMuD6E?=
 =?us-ascii?Q?bodbs0CC7kKCzAxh+8dwAvJGVcvU3EgfBHuv6V0bJl+DII1FzD/9cFrTknoK?=
 =?us-ascii?Q?in1/Z4ece5F25c5PakPZL5JJPo0LExirPyxMIws/m8BxE6llzlGrKBOqqZFd?=
 =?us-ascii?Q?wSlergAph/OSZlJ9F5hPWGW4X+LSFuvMZKe2afuLKaZJCqekXiT2UcYEvyO8?=
 =?us-ascii?Q?eHDoDZjeFUfYZyFepgE5PQqPp7hZKcXLh2lNggqcqBfrVXm6TMJCv6M/CT8h?=
 =?us-ascii?Q?588O+Ewo7+LJsBkLsrn1ov5OjQ+nHWQjuPeQV1PVvdPk1RlApXwgFlxakrYp?=
 =?us-ascii?Q?F2aK0kn8hEFAArpN06SlYbcUH9PlcietxQMrM3jPeBne3NmahwvAAelZDdLq?=
 =?us-ascii?Q?zmmAPU2vHewDILx8lr5RucTZPgYwyqpGcJcVX1WV99Tvsvh2a9Az6ijTvHTv?=
 =?us-ascii?Q?+KOAEO4C2WmGPrUY95kOj4leU5XAgn05SnaOMPO1ZLB/1/g/eN3OM/Y09qse?=
 =?us-ascii?Q?H9fXmFm2P8xs6YEEtDzw4JOUvr97h6czK0rYyrOuD/SBr2Ymta1jgGIz5AGC?=
 =?us-ascii?Q?hHeSPm2GlBFdmeRCuglpfVSdxOOyIFk0Jyfpm4EJOndHfzrTM9U4JvcTkQ0Y?=
 =?us-ascii?Q?AO3x5H5WBBMsrTQWZs7IcHvaSV0aYKx3pIiS58PRPrx3Hoer9ib5OMfCuZ+l?=
 =?us-ascii?Q?TAYkQTCfaB7rMmiKVoTgvlnq1+fJuVSuUjo4SgKWBn2cQfDnHZJDV1AHZlC8?=
 =?us-ascii?Q?WTMCciV9wpXDEaXIisCZGghVxX8DwIap1RC4T7pfMfmhFFWWB9IJgg0ODiTD?=
 =?us-ascii?Q?Z+r81D55edWxYpYRAjvD4cF1LHrakxQ4vx24wdFnS5z5tqqjHgWO+VRcr4Y7?=
 =?us-ascii?Q?k1cxcnLq?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Po8XvPk2QSNGDAN/4h7XtNAJsdNtrp7pxW0OaE0UE7PsBMWhC3iv5t4gUDlU?=
 =?us-ascii?Q?eE+l0FLRIKZz8/rHwnCTQgR4qHQi3DCXPmoqwM6Z2sQm/PnCCMK8dd0HTHQO?=
 =?us-ascii?Q?vaziy+7YNyurywODBrwsIVg4N9gsapxW7ICpwri2ablAY6XsicbueksTK3YZ?=
 =?us-ascii?Q?28XWQbbj4yNeChGVduNbqG7fMhYUKAfMFFCcMmk771y8z8DewHL1MgzIjiFa?=
 =?us-ascii?Q?SWE5OtfvvoA1Jw16+k0U+7HYqOh0nTDnyrtro0G7QeKEebFDIuMCOPBp9Bi7?=
 =?us-ascii?Q?Ue7/ufL1IRIrFiQiZiNqUGOoLKPf7mDpbNHtFcfHX6+xnGLtJrCRkSoP90gP?=
 =?us-ascii?Q?7Zm+qxIJlK2ek1NTEZGR3Pz7Yl6FBKllLDFVzmR2KSg5g6hq+rEd4LmFuprf?=
 =?us-ascii?Q?6EVE3bNu4XjCeHg8XZdxc8NglvxdbrQjfqFd59PWjhBC8xprm969gxhE0hsW?=
 =?us-ascii?Q?AAI57bSKjaMwY0uVP6UH4eOfoCEmlE7ttNxRLXj8MLp+FQTHtdOjeIOa9/CW?=
 =?us-ascii?Q?2qhEWiHDfJOEIZc0dO5bzH1MPf1Y9Mr+ba9XzXn3gm8rDRT46TW9xxRpj3LR?=
 =?us-ascii?Q?MCq5MR5nGwDfL8Fvf8aFVGSL+JrZ32HLPEhsvP0zI99F/2pBmYmOZ7UACnJy?=
 =?us-ascii?Q?84BZjn8ZUNHpcp4Kl9HYdgH1c2ZaKBhZhWMVeiQ8InrW/BM8g21WEmwL0ctF?=
 =?us-ascii?Q?bcU3V3ZfJdouT27evHn/8ThgagkO+HTEIOV84WEhG6JPwXaTlqJjTBq4dz+2?=
 =?us-ascii?Q?ClRrtHH9RAa5yZBDg7SHi9GhEGfdV+iEKsG/zjlojZ1sJj4Gs4fReQcmI+Lf?=
 =?us-ascii?Q?8qPesWx7Iz46tH5lr8EKziK6Slrg8A2a+uRP430F5iFyd40AgA1wszz2ViG8?=
 =?us-ascii?Q?S/ZoIh32TuYqoy92eExWIgGtHGt41PRyErGWXRY/ZJEvtB08xlH8mphs/SwI?=
 =?us-ascii?Q?UFF9wHjtVibo1gmMIPnuiIj/W3oAeMgfnmFzBHkK4lcpIpEv7Cs1l2jnOc8G?=
 =?us-ascii?Q?mTQOxTQzcvawH01i6v1lizEDa71dP47yHY8hRq07Zpuuu4OSXx5BWg1P/DYb?=
 =?us-ascii?Q?aOWlnv+0jVqpa3yC0ENDCViTTRwSbwlTJs0jnbbHDPbIWOM6ZoWa8WjgASmL?=
 =?us-ascii?Q?+CE0opPQHKEwPOJFUrBPrecHaLJ1XM/rk30irMLNnDSRVpUkD6TKP7xER53t?=
 =?us-ascii?Q?Agb4hRHk3MSiU+rd7Glr9oSo2j7oBYQRdKkWULc78kzH4QTk+uvCioH5oZMK?=
 =?us-ascii?Q?lLf7OUNxWzfs9xpXNalxwve8IvY1SG3lPxX4WLiTBlOEuGvrBtO4g9LEiKKt?=
 =?us-ascii?Q?9veO2Kipj4KUHM6Fr61t7W0dcxLY7G21henQb1PGYJDgpxUIndhuXjoYiK9W?=
 =?us-ascii?Q?2FkNXfs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c79b5d5b-b5ba-4c3a-3ba4-08de900fa175
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 16:56:34.0290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6701
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,outlook.com,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-9874-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 08ECB37E51D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, 2026=
 5:13 AM
>=20
> Refactor MSHV_VTL driver to move some of the x86 specific code to arch
> specific files, and add corresponding functions for arm64.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/arm64/include/asm/mshyperv.h |  10 +++
>  arch/x86/hyperv/hv_vtl.c          |  98 ++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   |   1 +
>  drivers/hv/mshv_vtl_main.c        | 102 +-----------------------------
>  4 files changed, 111 insertions(+), 100 deletions(-)
>=20
> diff --git a/arch/arm64/include/asm/mshyperv.h
> b/arch/arm64/include/asm/mshyperv.h
> index b721d3134ab6..804068e0941b 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -60,6 +60,16 @@ static inline u64 hv_get_non_nested_msr(unsigned int r=
eg)
>  				ARM_SMCCC_SMC_64,		\
>  				ARM_SMCCC_OWNER_VENDOR_HYP,	\
>  				HV_SMCCC_FUNC_NUMBER)
> +#ifdef CONFIG_HYPERV_VTL_MODE
> +/*
> + * Get/Set the register. If the function returns `1`, that must be done =
via
> + * a hypercall. Returning `0` means success.
> + */
> +static inline int hv_vtl_get_set_reg(struct hv_register_assoc *regs, boo=
l set, u64 shared)
> +{
> +	return 1;
> +}
> +#endif
>=20
>  #include <asm-generic/mshyperv.h>
>=20
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 9b6a9bc4ab76..72a0bb4ae0c7 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -17,6 +17,8 @@
>  #include <asm/realmode.h>
>  #include <asm/reboot.h>
>  #include <asm/smap.h>
> +#include <uapi/asm/mtrr.h>
> +#include <asm/debugreg.h>
>  #include <linux/export.h>
>  #include <../kernel/smpboot.h>
>  #include "../../kernel/fpu/legacy.h"
> @@ -281,3 +283,99 @@ void mshv_vtl_return_call(struct mshv_vtl_cpu_contex=
t *vtl0)
>  	kernel_fpu_end();
>  }
>  EXPORT_SYMBOL(mshv_vtl_return_call);
> +
> +/* Static table mapping register names to their corresponding actions */
> +static const struct {
> +	enum hv_register_name reg_name;
> +	int debug_reg_num;  /* -1 if not a debug register */
> +	u32 msr_addr;       /* 0 if not an MSR */
> +} reg_table[] =3D {
> +	/* Debug registers */
> +	{HV_X64_REGISTER_DR0, 0, 0},
> +	{HV_X64_REGISTER_DR1, 1, 0},
> +	{HV_X64_REGISTER_DR2, 2, 0},
> +	{HV_X64_REGISTER_DR3, 3, 0},
> +	{HV_X64_REGISTER_DR6, 6, 0},
> +	/* MTRR MSRs */
> +	{HV_X64_REGISTER_MSR_MTRR_CAP, -1, MSR_MTRRcap},
> +	{HV_X64_REGISTER_MSR_MTRR_DEF_TYPE, -1, MSR_MTRRdefType},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0, -1, MTRRphysBase_MSR(0)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1, -1, MTRRphysBase_MSR(1)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2, -1, MTRRphysBase_MSR(2)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3, -1, MTRRphysBase_MSR(3)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4, -1, MTRRphysBase_MSR(4)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5, -1, MTRRphysBase_MSR(5)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6, -1, MTRRphysBase_MSR(6)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7, -1, MTRRphysBase_MSR(7)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE8, -1, MTRRphysBase_MSR(8)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE9, -1, MTRRphysBase_MSR(9)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEA, -1, MTRRphysBase_MSR(0xa)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEB, -1, MTRRphysBase_MSR(0xb)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEC, -1, MTRRphysBase_MSR(0xc)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASED, -1, MTRRphysBase_MSR(0xd)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEE, -1, MTRRphysBase_MSR(0xe)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEF, -1, MTRRphysBase_MSR(0xf)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0, -1, MTRRphysMask_MSR(0)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1, -1, MTRRphysMask_MSR(1)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2, -1, MTRRphysMask_MSR(2)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3, -1, MTRRphysMask_MSR(3)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4, -1, MTRRphysMask_MSR(4)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5, -1, MTRRphysMask_MSR(5)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6, -1, MTRRphysMask_MSR(6)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7, -1, MTRRphysMask_MSR(7)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK8, -1, MTRRphysMask_MSR(8)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK9, -1, MTRRphysMask_MSR(9)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKA, -1, MTRRphysMask_MSR(0xa)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB, -1, MTRRphysMask_MSR(0xb)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKC, -1, MTRRphysMask_MSR(0xc)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKD, -1, MTRRphysMask_MSR(0xd)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKE, -1, MTRRphysMask_MSR(0xe)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKF, -1, MTRRphysMask_MSR(0xf)},
> +	{HV_X64_REGISTER_MSR_MTRR_FIX64K00000, -1, MSR_MTRRfix64K_00000},
> +	{HV_X64_REGISTER_MSR_MTRR_FIX16K80000, -1, MSR_MTRRfix16K_80000},
> +	{HV_X64_REGISTER_MSR_MTRR_FIX16KA0000, -1, MSR_MTRRfix16K_A0000},
> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KC0000, -1, MSR_MTRRfix4K_C0000},
> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KC8000, -1, MSR_MTRRfix4K_C8000},
> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KD0000, -1, MSR_MTRRfix4K_D0000},
> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KD8000, -1, MSR_MTRRfix4K_D8000},
> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KE0000, -1, MSR_MTRRfix4K_E0000},
> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KE8000, -1, MSR_MTRRfix4K_E8000},
> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KF0000, -1, MSR_MTRRfix4K_F0000},
> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KF8000, -1, MSR_MTRRfix4K_F8000},
> +};
> +
> +int hv_vtl_get_set_reg(struct hv_register_assoc *regs, bool set, u64 sha=
red)
> +{
> +	u64 *reg64;
> +	enum hv_register_name gpr_name;
> +	int i;
> +
> +	gpr_name =3D regs->name;
> +	reg64 =3D &regs->value.reg64;
> +
> +	/* Search for the register in the table */
> +	for (i =3D 0; i < ARRAY_SIZE(reg_table); i++) {
> +		if (reg_table[i].reg_name !=3D gpr_name)
> +			continue;
> +		if (reg_table[i].debug_reg_num !=3D -1) {
> +			/* Handle debug registers */
> +			if (gpr_name =3D=3D HV_X64_REGISTER_DR6 && !shared)
> +				goto hypercall;
> +			if (set)
> +				native_set_debugreg(reg_table[i].debug_reg_num, *reg64);
> +			else
> +				*reg64 =3D native_get_debugreg(reg_table[i].debug_reg_num);
> +		} else {
> +			/* Handle MSRs */
> +			if (set)
> +				wrmsrl(reg_table[i].msr_addr, *reg64);
> +			else
> +				rdmsrl(reg_table[i].msr_addr, *reg64);
> +		}
> +		return 0;
> +	}
> +
> +hypercall:
> +	return 1;
> +}
> +EXPORT_SYMBOL(hv_vtl_get_set_reg);
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index f64393e853ee..d5355a5b7517 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -304,6 +304,7 @@ void mshv_vtl_return_call(struct mshv_vtl_cpu_context=
 *vtl0);
>  void mshv_vtl_return_call_init(u64 vtl_return_offset);
>  void mshv_vtl_return_hypercall(void);
>  void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
> +int hv_vtl_get_set_reg(struct hv_register_assoc *regs, bool set, u64 sha=
red);

Can this move to asm-generic/mshyperv.h?  The function is no longer specifi=
c
to x86/x64, so one would want to not declare it in the arch/x86 version
of mshyperv.h. But maybe moving it to asm-generic/mshyperv.h breaks
compilation on arm64 because there's also the static inline stub there.

>  #else
>  static inline void __init hv_vtl_init_platform(void) {}
>  static inline int __init hv_vtl_early_init(void) { return 0; }
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index 5856975f32e1..b607b6e7e121 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -19,10 +19,8 @@
>  #include <linux/poll.h>
>  #include <linux/file.h>
>  #include <linux/vmalloc.h>
> -#include <asm/debugreg.h>
>  #include <asm/mshyperv.h>
>  #include <trace/events/ipi.h>
> -#include <uapi/asm/mtrr.h>
>  #include <uapi/linux/mshv.h>
>  #include <hyperv/hvhdk.h>
>=20
> @@ -505,102 +503,6 @@ static int mshv_vtl_ioctl_set_poll_file(struct mshv=
_vtl_set_poll_file __user *us
>  	return 0;
>  }
>=20
> -/* Static table mapping register names to their corresponding actions */
> -static const struct {
> -	enum hv_register_name reg_name;
> -	int debug_reg_num;  /* -1 if not a debug register */
> -	u32 msr_addr;       /* 0 if not an MSR */
> -} reg_table[] =3D {
> -	/* Debug registers */
> -	{HV_X64_REGISTER_DR0, 0, 0},
> -	{HV_X64_REGISTER_DR1, 1, 0},
> -	{HV_X64_REGISTER_DR2, 2, 0},
> -	{HV_X64_REGISTER_DR3, 3, 0},
> -	{HV_X64_REGISTER_DR6, 6, 0},
> -	/* MTRR MSRs */
> -	{HV_X64_REGISTER_MSR_MTRR_CAP, -1, MSR_MTRRcap},
> -	{HV_X64_REGISTER_MSR_MTRR_DEF_TYPE, -1, MSR_MTRRdefType},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0, -1, MTRRphysBase_MSR(0)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1, -1, MTRRphysBase_MSR(1)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2, -1, MTRRphysBase_MSR(2)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3, -1, MTRRphysBase_MSR(3)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4, -1, MTRRphysBase_MSR(4)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5, -1, MTRRphysBase_MSR(5)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6, -1, MTRRphysBase_MSR(6)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7, -1, MTRRphysBase_MSR(7)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE8, -1, MTRRphysBase_MSR(8)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE9, -1, MTRRphysBase_MSR(9)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEA, -1, MTRRphysBase_MSR(0xa)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEB, -1, MTRRphysBase_MSR(0xb)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEC, -1, MTRRphysBase_MSR(0xc)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASED, -1, MTRRphysBase_MSR(0xd)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEE, -1, MTRRphysBase_MSR(0xe)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEF, -1, MTRRphysBase_MSR(0xf)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0, -1, MTRRphysMask_MSR(0)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1, -1, MTRRphysMask_MSR(1)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2, -1, MTRRphysMask_MSR(2)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3, -1, MTRRphysMask_MSR(3)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4, -1, MTRRphysMask_MSR(4)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5, -1, MTRRphysMask_MSR(5)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6, -1, MTRRphysMask_MSR(6)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7, -1, MTRRphysMask_MSR(7)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK8, -1, MTRRphysMask_MSR(8)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK9, -1, MTRRphysMask_MSR(9)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKA, -1, MTRRphysMask_MSR(0xa)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB, -1, MTRRphysMask_MSR(0xb)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKC, -1, MTRRphysMask_MSR(0xc)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKD, -1, MTRRphysMask_MSR(0xd)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKE, -1, MTRRphysMask_MSR(0xe)},
> -	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKF, -1, MTRRphysMask_MSR(0xf)},
> -	{HV_X64_REGISTER_MSR_MTRR_FIX64K00000, -1, MSR_MTRRfix64K_00000},
> -	{HV_X64_REGISTER_MSR_MTRR_FIX16K80000, -1, MSR_MTRRfix16K_80000},
> -	{HV_X64_REGISTER_MSR_MTRR_FIX16KA0000, -1, MSR_MTRRfix16K_A0000},
> -	{HV_X64_REGISTER_MSR_MTRR_FIX4KC0000, -1, MSR_MTRRfix4K_C0000},
> -	{HV_X64_REGISTER_MSR_MTRR_FIX4KC8000, -1, MSR_MTRRfix4K_C8000},
> -	{HV_X64_REGISTER_MSR_MTRR_FIX4KD0000, -1, MSR_MTRRfix4K_D0000},
> -	{HV_X64_REGISTER_MSR_MTRR_FIX4KD8000, -1, MSR_MTRRfix4K_D8000},
> -	{HV_X64_REGISTER_MSR_MTRR_FIX4KE0000, -1, MSR_MTRRfix4K_E0000},
> -	{HV_X64_REGISTER_MSR_MTRR_FIX4KE8000, -1, MSR_MTRRfix4K_E8000},
> -	{HV_X64_REGISTER_MSR_MTRR_FIX4KF0000, -1, MSR_MTRRfix4K_F0000},
> -	{HV_X64_REGISTER_MSR_MTRR_FIX4KF8000, -1, MSR_MTRRfix4K_F8000},
> -};
> -
> -static int mshv_vtl_get_set_reg(struct hv_register_assoc *regs, bool set=
)
> -{
> -	u64 *reg64;
> -	enum hv_register_name gpr_name;
> -	int i;
> -
> -	gpr_name =3D regs->name;
> -	reg64 =3D &regs->value.reg64;
> -
> -	/* Search for the register in the table */
> -	for (i =3D 0; i < ARRAY_SIZE(reg_table); i++) {
> -		if (reg_table[i].reg_name !=3D gpr_name)
> -			continue;
> -		if (reg_table[i].debug_reg_num !=3D -1) {
> -			/* Handle debug registers */
> -			if (gpr_name =3D=3D HV_X64_REGISTER_DR6 &&
> -			    !mshv_vsm_capabilities.dr6_shared)
> -				goto hypercall;
> -			if (set)
> -				native_set_debugreg(reg_table[i].debug_reg_num, *reg64);
> -			else
> -				*reg64 =3D native_get_debugreg(reg_table[i].debug_reg_num);
> -		} else {
> -			/* Handle MSRs */
> -			if (set)
> -				wrmsrl(reg_table[i].msr_addr, *reg64);
> -			else
> -				rdmsrl(reg_table[i].msr_addr, *reg64);
> -		}
> -		return 0;
> -	}
> -
> -hypercall:
> -	return 1;
> -}
> -
>  static void mshv_vtl_return(struct mshv_vtl_cpu_context *vtl0)
>  {
>  	struct hv_vp_assist_page *hvp;
> @@ -720,7 +622,7 @@ mshv_vtl_ioctl_get_regs(void __user *user_args)
>  			   sizeof(reg)))
>  		return -EFAULT;
>=20
> -	ret =3D mshv_vtl_get_set_reg(&reg, false);
> +	ret =3D hv_vtl_get_set_reg(&reg, false, mshv_vsm_capabilities.dr6_share=
d);
>  	if (!ret)
>  		goto copy_args; /* No need of hypercall */
>  	ret =3D vtl_get_vp_register(&reg);
> @@ -751,7 +653,7 @@ mshv_vtl_ioctl_set_regs(void __user *user_args)
>  	if (copy_from_user(&reg, (void __user *)args.regs_ptr, sizeof(reg)))
>  		return -EFAULT;
>=20
> -	ret =3D mshv_vtl_get_set_reg(&reg, true);
> +	ret =3D hv_vtl_get_set_reg(&reg, true, mshv_vsm_capabilities.dr6_shared=
);
>  	if (!ret)
>  		return ret; /* No need of hypercall */
>  	ret =3D vtl_set_vp_register(&reg);
> --
> 2.43.0
>=20


