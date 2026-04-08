Return-Path: <linux-hyperv+bounces-10081-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFArK7we1mluBAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-10081-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 11:24:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D9C3B9D35
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 11:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C806130037F5
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2026 09:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D444533F370;
	Wed,  8 Apr 2026 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jtQvqYyH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021134.outbound.protection.outlook.com [40.107.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7235D2C027B;
	Wed,  8 Apr 2026 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775640249; cv=fail; b=AWDi4sGYNtUXZkL26vHa9rpTzws0DKu3WKjE9VGYz/FVCcXF67MQAwBo8zQ+eGQ+0VLCCsYQIc/FZ28VY4LMVA8eJ9uHDNuHWW/1gIy0IeXdD1f2sdsTwlolST3t9qJVbcdCmkVw7h8TSLlu5F35fewy7Cynm5+qzUH+Zq1fUdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775640249; c=relaxed/simple;
	bh=BQQbgl7cuJ8vSaR5yXX71HXraCZIyrOcuS4aVFA0DlQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U+PtuhM1MvTz3BZQmy91ySfvCXzJQvpdhhU6nbT8O7068QDokHCaxDIHuLoCDrffIWmCxbA9i5k4XnMAxGIaUrohp37oZ548qlPEC8ataMvAR690NFt17z3fS6ae0Cgc3EBBJZ43zISgcuW4Yldhmx7jsOD2thTKVBuPL1OZn7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=jtQvqYyH; arc=fail smtp.client-ip=40.107.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F94x5DC9D7l/xQGe6gP/mhB21fkHP+TQPok6W8yaayHPk5QwD0wfSPzovBIsQ7cJ/U0R/mzdWcCnqK+qUkf+D/CrRO0RT2zTNrrbqc/WOODb277c/Tlvoa7UArqUPuabu+GDaH0+5kYE9vA7RsxLUx9AyT3jbVTMFcWqqKkxFUOxd864mwbBDXNBByUZVU7NMOz/fl+a6irK33X8Bl5bBkBhhVCu78pDUtLb+72Qx9cwrLTy7nI0J51oOk3ZbdMI9+ddeWpnfnI0Eq9drJd5CKequTF+3GZPckDqSr6uns4lHCD/8Xa39eq4wOic38umZhmv+48Ve0SfwJ5uGEavAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQBrZljt7aRXwzN9db6mwZI8sQpBlE2Mw2X1kOGZdbw=;
 b=bxjsr1DTf+ArGRAEj9KBkarnsS6wb2pcHG9S6d6GJAI0ISVSdjYEJApPftOqyuhNxJY5H5NUtfx0lx0xgGZOvhmEFEGuBdDubfkRUbKxJu8lvBEuu5YMNxEFaytsrll5Rb3Rm7O6LLKTMTyRgzAAFo+fMxMViZmhf5uYurLqT/KZeWM6p6+ccDfIg7XIUrTFhtuBMR+A8nk1UrN7apzYCgYDFAQqLkaXeF971RDpkI5w3maR1105XQg8Ux0rSCXBv+MT0LlB6tpM6FOB9LUAfVows/gbGPuiPVEggNaxPugN3iUS1T4HpQx0BbcjnlfmLFMXChveCXaJeFKE2lxXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQBrZljt7aRXwzN9db6mwZI8sQpBlE2Mw2X1kOGZdbw=;
 b=jtQvqYyH9wlsR0BZyS9RuVyxOSWQMKX//5cVdnZn+BBgRPKAr7X4Ep+ftDHP6uD4v2jhhM2659YfPo+pm7yc+9T9UlsNRigzJRCyHJL+10fbJTtKFiJHA4Wcr2fFR4j+FYniNbVdV0RfkcfQp1D0xUeQceqKfzzHGw6V+xzdb1w=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA1PR21MB6584.namprd21.prod.outlook.com (2603:10b6:806:4a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.34; Wed, 8 Apr
 2026 09:24:05 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 09:24:05 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Long Li <longli@microsoft.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Jake Oshins
	<jakeo@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "matthew.ruffell@canonical.com"
	<matthew.ruffell@canonical.com>, "kjlx@templeofstupid.com"
	<kjlx@templeofstupid.com>
CC: Krister Johansen <johansen@templeofstupid.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Topic: [PATCH v2] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Index: AQHcwvqZ7/kLR2JkdUmudlv9HY41bLXRHh0QgAOgeDA=
Date: Wed, 8 Apr 2026 09:24:05 +0000
Message-ID:
 <SA1PR21MB69215C164B06109C6682984EBF5BA@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260402234313.2490779-1-decui@microsoft.com>
 <SN6PR02MB415794E53D2B621F6A8BA382D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB415794E53D2B621F6A8BA382D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8081b72c-a943-4099-8407-b0c722844253;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-08T06:38:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA1PR21MB6584:EE_
x-ms-office365-filtering-correlation-id: ebc7f554-ad5b-4acc-778a-08de9550946e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 5HIsaWU6h2QcByCAv18YXwi4DXaU0ZRSXb5DA5p57N+WJDu27n6stAENgrCfyRXG5RrLuxHbd529NO92jm5VjAU0FWWQ/xXub+CaMOLLbbLKZ/aJs6nereekX2st/2Nu6WgyQ71wX+2tArMEx2zc1YwcoQA3yEb97rtUCup1GsCKSHNvHA6KZkkdpMX55jeAw95gIF1J8LfUI78eqkU/GnrQQPfYOQ+DhCn9JMjMDJdCUSmpcNb9UCq/8h8xVoE+RQMbWqdJhCzh3Ee/WTL9PvOr5z5cL7EGxKvlqeJtrBTpoAV3f8QOYgqGpm+1XT2QqnVUGrrBClXiyEif0djv/5B0Q7z8545g7SJ0qGXXlsYigPE4tiYd9LkXJ1DIkaud2uAYhLLdEK/W1fPPhNkWIT7HmF8o3QHvqGUGIHJ1YTJzRT6VaWD55XrogQl3uAi3I8fiEfwUGRLL7gwS4cOEArfgHGbonY/Y4EslS5JBqF/3iVwBvbZE5ozuU8RIHEFJZ0E0eLFHv8mv+0ZmglLw5s99QF1XetmIghMtlgko1lKhevqy965LGdG9+2ffRqXFcLxusmydi7e6ousNHLmTLe3lzuP9sGNQhysj2hudoF0GehRidd0H+AiqvvqGe5oWZNDiG5G2ziwFnlPMCs0qg9uytIljxIfR/HIqTqBgNJdbHxHvF98m1NmSqWr0jGZNXmF7C7r+r+7nDS1FyEsURTj3HxNjOpMFoDlSsfO8JKheVtRQtj6BMQ8k9lQNR7iVG9WwOWMqJtiA+Rw/bOGwloq2GEqepJNk2sB9bJG6CWfqYvwbjHN/80X4FSLm0S55
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iN+gotDcZLOMwo/ZfYB29gkdb4co7HKL9MTGHy9BCTHllKX2gapY+ke+z+Xl?=
 =?us-ascii?Q?fmoVzQ96zz0E65eBP9D5CjJKaf0ecCTDxDOK/F+7GsW2gPgMRVc0MBx+NNl+?=
 =?us-ascii?Q?2pX8hzoTHiSwpZKNVfjrUOR0ofTiZ4w68WbX0A80w1tPu3cEbArM0l8PjXUJ?=
 =?us-ascii?Q?oLO/Ry72Lmbc9FL0k09vOWUrMK5/6swl1yYAO3XWInulV7h53yrjpj84Neja?=
 =?us-ascii?Q?V7xavuilFmzg4Ziz071a54wUQXs6TgyDhQWGer7QyCwd/fop10SVY91zl1HR?=
 =?us-ascii?Q?oEl+abpEnkGcYl0kcyYKV5mJfUrVDcjuzciNEu967QCjYD3klDV+bdfO/eJC?=
 =?us-ascii?Q?ORjG7hNS+oHMAg/Q5AXodZBHKaL8Y7bBvhcjoLvA+bu8bkhGQ7rAlUvisd9d?=
 =?us-ascii?Q?/drUsQvosIK2Xgsi4E3VKxBibs2zFbcpMnxE+O/pF9zUyzx09Nl6Z4mXPtBP?=
 =?us-ascii?Q?xh51d1cDPGC1eI1HmH+db2JeLmIg2fjHSufEAb5PLo+g8VT++ifIm3kgsaAe?=
 =?us-ascii?Q?lXezEAsfzQ+22m2ofjQ9CXyQo/Uxew7f5ErnceZmn16IzN5YWfRTWFYm3Svb?=
 =?us-ascii?Q?sdmEC195DLA0/CcJAVNLyYxsQ/YsBUk0FLnE8GZpWNbcOirDb11hzeSKAWfv?=
 =?us-ascii?Q?fv7mmIu4CeiQhDFtl0lmodU0pgReKOHd9bS6h2E6itZ8vrSLsa0Ix2RKAdYn?=
 =?us-ascii?Q?ldSfdlJanMq6pu7BXq2/CzWC5Z8X1hlqwY6ZQr7nF3byGLTq+ChihuOpgmcP?=
 =?us-ascii?Q?TInFXgLJuORtOQE6i3cmddCSh+Zu5VD8UFLsS3gFqpz2bQeV0yNp7i5kzzs0?=
 =?us-ascii?Q?c1MxEHsJ4Y5VknFZ4H6LHggcb00kuUWPI3GfqEkYPHaf29465nPkSFh2T8+m?=
 =?us-ascii?Q?n6J0Dy6SSiPzU0nga4gv5PKr6fCMzBUIBf7XgvxCRKRNd+rWIKrkaxYengly?=
 =?us-ascii?Q?eJivzPNqzBcmTX88i0lr4pPw+Wigb1ZXjJOqJBZageXRgvSbDSWUupsfiKJj?=
 =?us-ascii?Q?kROKA5nurbiYcu8ZOyM1pEVdGy/XAaJqT5hNmJC6p0d67sbua3cDqh2ts0jF?=
 =?us-ascii?Q?mbM3ySPZ+b2zkiA+6ym/seDBlM/JoxmZK/15XYENrVDvxRjw6CwqXGzmdqod?=
 =?us-ascii?Q?ZSZLFeorEZYnnWv53SvWIBMgDITMps3rlQ8TL1jid/fvgKkTupQZ2h1XcoAZ?=
 =?us-ascii?Q?qTDnjDVd05vvo9VuVWgzSbguZwNis+W/5wWf6fiMXMgDqx0oJhPcV3iJTJGY?=
 =?us-ascii?Q?ukouL+SdrydS4cFJSqMdJ96G/hoHvEyLzPx0LP6sQX2rlJxnI6eEl3tPYQmJ?=
 =?us-ascii?Q?Vxt18LCSqCQh1dOUfUG/vlMhXStFtn+wi31UapJ4aV+/CtGFYSl5M/XAKF2o?=
 =?us-ascii?Q?8l/SyO8HMdf7U8ZAU9QRGYsOd+geELKWEOerifIHnz1NxtjWp+aoOCi5TMtz?=
 =?us-ascii?Q?Y93EkQTSD9v0ELjwDfX8Ri3S1ZPQGFZx53w12Yk2FMMpl+4MPppq9sw9Ak1z?=
 =?us-ascii?Q?vGIvJbdXivhZ2AXst90Mx4XShutyKMfJ+PhKbMcjv7b8tkHQNRvpIEpokIsR?=
 =?us-ascii?Q?svnWrUcvkJtbhcBRla07GOpNIEfYAqUNp3TCwvRLObg0Hj1u/AAaoRTLHN5w?=
 =?us-ascii?Q?eoSbuhel3+tuCvRMX8MIbtnRZYjPo7IYdnl+uY2QT9Dgo43DjgidYlF1/EB/?=
 =?us-ascii?Q?fpyG2mgvLLpA720wkO10H6fs87KPOMYEVm2CYEmMmjr6pDKt?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6921.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc7f554-ad5b-4acc-778a-08de9550946e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 09:24:05.3300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZUBYyBaPxFfEgHKV7Wg3CcVMNmKOHX1+lnZH/pBNLnS2bDkn2fU7+grTgnSLPrzJLnEQH6wSRIY6EbixGEcNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6584
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10081-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,google.com,vger.kernel.org,canonical.com,templeofstupid.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 25D9C3B9D35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Sunday, April 5, 2026 4:15 PM
> > ...
> > Note: we still need to figure out how to address the possible MMIO
> > conflict between hyperv_drm and pci_hyperv in the case of 32-bit PCI
> > MMIO BARs, but that's of low priority because all PCI devices available
> > to a Linux VM on Azure or on a modern host should use 64-bit BARs and
> > should not use 32-bit BARs -- I checked Mellanox VFs, MANA VFs, NVMe
> > devices, and GPUs in Linux VMs on Azure, and found no 32-bit BARs.
>=20
> Just to clarify, since this patch is predicated on all BARs being 64-bit,
> hv_pci_alloc_bridge_windows() never encounters a non-zero
> hbus->low_mmio_space, and hence also never allocates from low
> MMIO space. So hv_pci_alloc_bridge_windows() does not need to be
> patched. Is that correct?

Correct. For 32-bit BARs (if any), IMO we can't really do anything for
them in hv_pci_allocate_bridge_windows(), since they must reside
below 4GB.

Note: while the patch doesn't fix the MMIO conflict if there are any
32-bit BARs, the patch doesn't make things worse for 32-bit BARs (if any).

> Taking a broader view, fundamentally the current MMIO location of
> the frame buffer may be unknown to the Linux guest. At the same time,
> Linux must ensure that PCI devices don't get assigned to the MMIO space
> where the frame buffer is located. While the current MMIO location of
> the frame buffer may be unknown, we can assume it was placed in low
> MMIO space by the host -- either Windows Hyper-V or Linux/VMM
> in the root partition, and perhaps as mediated by a paravisor. Probably
> need to confirm with the Linux-in-the-root partition team (and maybe
> the OpenHCL team) that this assumption is true.=20

IMO this is a good idea! It looks like the framebuffer base always starts
at the beginning of the low MMIO space. We can reserve some
MMIO for the framebuffer at the beginning of the low MMIO space.

> Presumably the
> hyperv_drm driver doesn't need to move the frame buffer, but if it
> does, it must stay in the low MMIO space.

It looks like this assumption is true.

> This patch depends on this assumption, and effectively reserves
> the entire low MMIO space for the frame buffer.=20

To make it precise, the patch reserves the entire low MMIO space for
the frame buffer and the 32-bit BARs (if any), and there is no MMIO
conflict in the first kernel (assuming hyperv_drm doesn't relocate the
MMIO range), and there can be an MMIO conflict in the
kdump/kexec kernel if there is any 32-bit BAR.

> The low MMIO space
> size defaults to 128 MiB on a local Hyper-V,=20
Yes, by default, the low MMIO base =3D0xf800_0000, size=3D128MB,=20
but the range [0xfed4_0000, 0xffff_ffff], whose size is 18.75MB,
is reserved for vTPM: see vmbus_walk_resources(). So by default
the available low MMIO size for hyperv_drm is 128 - 18.75 =3D=20
109.25 MB.

The size of the framebuffer should be aligned to 2MB, so if the
framebuffer size is bigger than 108MB, it looks like there is no
enough MMIO space in the low MMIO range, e.g. with the below
command:
Set-VMVideo -VMName vm_name -HorizontalResolution 7680
-VerticalResolution 4320 -ResolutionType Maximum
, the resulting max framebuffer size is=20
7680 * 4320 * 32/8 /1024.0/1024 =3D 126.5625, which would be
rounded up to 128MB.

However, according to my testing, with the above command,
the low MMIO base =3D 0xf000_0000, size=3D256MB, so it's probably
ok to reserve 128 MB for the frame buffer.=20

In case the low MMIO size is <=3D64MB, we would want to reserve
less MMIO for the frame buffer.

> and is set to 3 GiB in most
> Azure VMs (or to 1 GiB in an Azure CVM), so that all gets reserved.
>=20
> A slightly different approach to the whole problem is to change
> vmbus_reserve_fb(). If it is unable to get a non-zero "start" value, then
> it should use the same assumption as above, and reserve a frame buffer
> area starting at the lowest address in low MMIO space. The reserved size
> could be the max possible frame buffer size, which I think is 64 MiB (?).

It can be 128MB with the highest resolution 7680*4320 (I hope the
highest resolution won't become bigger in the future).

> This still leaves low MMIO space for subsequent PCI devices, and allows
> 32-bit BARs to continue to work. This approach requires one further
> assumption, which is that the host, plus any movement by hyperv_drm,
> has kept the frame buffer at the low end of the low MMIO space. From
> what I've seen, that assumption is reality -- the frame buffer always
> starts at the beginning of low MMIO space.
>=20
> This approach could be taken one step further, where vmbus_reserve_fb()
> *always* reserves 64 MiB starting at the low end of low MMIO space,
> regardless of the value of "start". The messy code for getting "start"
> could be dropped entirely, and the dependency on CONFIG_SYSFB goes
> away. Or maybe still get the value of "start" and "size", and if non-zero
> just do a sanity check that they are within the fixed 64 MiB reserved are=
a.
>=20
> Thoughts? To me tweaking vmbus_reserve_fb() is a more
> straightforward and explicit way to do the reserving, vs. modifying
> the requested range in the Hyper-V PCI driver.=20

Agreed. Let me try to make a new patch for review.

> And FWIW, it avoids  introducing the 32-bit BAR limitation.

This patch addresses the MMIO conflict for 64-bit BARs and not for
32-bit BARs (if any). The patch does not introduce the 32-bit BAR limitatio=
n.

Thanks,
-- Dexuan

