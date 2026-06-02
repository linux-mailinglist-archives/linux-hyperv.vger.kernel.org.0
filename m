Return-Path: <linux-hyperv+bounces-11458-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ruPcDo5gH2qalQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11458-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 01:00:30 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFADC632BC2
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 01:00:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b="XeBuQBJ/";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11458-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11458-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microsoft.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D69C530B5F5A
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Jun 2026 22:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F993C7DF5;
	Tue,  2 Jun 2026 22:54:47 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020084.outbound.protection.outlook.com [52.101.61.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E483BC69D;
	Tue,  2 Jun 2026 22:54:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440887; cv=fail; b=qqrk4pg8Gr8nv60rKMCJPb4f5Wc9Z4aavIu8NK/eNKyQKWrlABU7AZf3TITaH4jL9T2ihDMTTdxylRwXCMIKNjTbarvj65a+ho3GQ9IOWMGGfiRaMqqGN63/8Lz337ikgtH2O19ZTAK/9sr45Y2VzxvLi8+gzmwclh8rvypjTS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440887; c=relaxed/simple;
	bh=Xpdk9TaTHorm9HlXjyCoC58kfnqqOoQcrnrDOkPNRm8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hA36sTUEP+ABn9chy03GiywiTSj2TxIKkjMagkJ594kmMnmtjWb9d0kFDhe6ZDINMnh1TyDmRy9TnyyYY8N2+FOmH0fIybAdE/K82EQVC4QbNEbazZRoHXwjMnq123fjHDRwWntfALKIyZcYro2PG1VB+M9nka8Qksrqwaz20Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=XeBuQBJ/; arc=fail smtp.client-ip=52.101.61.84
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQzqmC/7rMTc1Oo/7Mj2ZdlNIjQiAU4jsO02iYZDZSXT62ZaVe9smVWM2MDWBnrEAJz9Xv4BOdDg5XzxaaGvwEl1dO8s/XxuXLwKC8k9d0atcI1lS76D6FJR9SLN0jOFI6Sj00ql5fuZtK7b0QM6Z8AQez7YVGhDZLm4OQGbbPsG+9Z3txsueC0i5lCYyYwUOHAGm8F0dBzVTCSFWyDfWIPg7fs3VONywg2VkLJSaiQjnamhIDXKJMwsLa0vSknnYCGcWE2LxpcIp1OdbtxZNkVa4D3pOfwsY2jokwC7zi15fWnrzBd3VUzdDbO0q6kC6LuTlUMhQ0SDZN318O4UBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xpdk9TaTHorm9HlXjyCoC58kfnqqOoQcrnrDOkPNRm8=;
 b=pdE0+ONekArjfRXA6PSCuPU2xe7EN3MAoIQCEu1quNpOKWNQcQUx+s4ZoDdirbjJR20rEMwlSMwMiVQ1qNAWRG5E9cUxhX5cw8sSFjcnwONFJeILdRo273ekcAS1SAUvATFgr2KDjhpqHDBHbl2YnCtIGDNA3Klr+0twWjVHnUbArjROs4rD+cPOfjdcEIGtnzSsffCd+jkM+5a0gEHccvMl1ESt4520EGquBRUImpYGA1XmXltci37KQdgRMsgD1RToyHqiSigpn7ztUx2ORAWNuKGyB/6ZgMtpGNSHJbKWaoMWG0doM2WdaidvXFGYl1uS7rj1WdIRMp5ZK2txJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xpdk9TaTHorm9HlXjyCoC58kfnqqOoQcrnrDOkPNRm8=;
 b=XeBuQBJ/eZ6i4nvkJyVm+50cTDRXG2EGhjJTWRtM01XQkVqKMw+eqP/fgOWy5+ffeJbw0BpwAc5HPXcsVVN8trBQ6Hj1PeJEAJX6yaCZhzqIGqjr+MgVlWvO4BEfIUcpHSeSRq+sBdgUn451OxAYw1saGkAX92p9VV0Ziqi2OSo=
Received: from BY1PR21MB3870.namprd21.prod.outlook.com (2603:10b6:a03:525::7)
 by LV9PR21MB4685.namprd21.prod.outlook.com (2603:10b6:408:2e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.5; Tue, 2 Jun 2026
 22:54:43 +0000
Received: from BY1PR21MB3870.namprd21.prod.outlook.com
 ([fe80::9faa:4fb0:486b:8267]) by BY1PR21MB3870.namprd21.prod.outlook.com
 ([fe80::9faa:4fb0:486b:8267%4]) with mapi id 15.21.0071.007; Tue, 2 Jun 2026
 22:54:43 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: LeantionX <leontyevantony@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, KY
 Srinivasan <kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <DECUI@microsoft.com>, Long Li <longli@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net] hv_netvsc: use kmap_local_page in
 netvsc_copy_to_send_buf
Thread-Topic: [EXTERNAL] [PATCH net] hv_netvsc: use kmap_local_page in
 netvsc_copy_to_send_buf
Thread-Index: AQHc8qfKB0BXHB9Pzk62Qp6U9hmxR7Yr3puA
Date: Tue, 2 Jun 2026 22:54:43 +0000
Message-ID:
 <BY1PR21MB38709E89497445EECE3C931DCA122@BY1PR21MB3870.namprd21.prod.outlook.com>
References: <20260602155210.90987-1-leontyevanton1995@gmail.com>
In-Reply-To: <20260602155210.90987-1-leontyevanton1995@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=002d5649-d222-4e97-97ee-254e4c322d46;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-02T22:48:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR21MB3870:EE_|LV9PR21MB4685:EE_
x-ms-office365-filtering-correlation-id: 5babe118-683e-4e03-6573-08dec0f9ef9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|7053199004|6133799003|18002099003|22082099003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 I2q0f90AQZITeugzb1pxZi3oG7c3uj5hUGRK6QzlZW1YEdn2K0fvxijjB0sOcVlzjGfwUjZHWP147oBNpQXCUW0h+xQubkaS+z1F8dTe5oMloRaTGJMIP6DcIjDHAHjnPpRCZR6KufkrfZxahNtxwDG5H9F5ekPii2/BuyDGTPL2lvmI7Mypw7dVfMImlTNrEmS2rq/ddHqRKgXbp5/VSKqRgpqN4J0ypsJdaC2I4sV3tKZymho018+ebA+zeTMc3uHgLa+BsztSCdhzEoaj3qfJXQCwWtZ43UOBFjPPPl5Io0V3f4LwJnuBaL5toQD6nGXTIqTIENj118ygjTin1zXkUQvxSqaLH6JRM/NqhXmD6rTxKa2+OZG6+hXfR5QxFJvnspvCAQ1ZTVo8m3uxVBJQrSk+/fLZZUk5jymdVGvwui06crCaxGWvhpQepGCvxuU7OGIVoQP9YaJOpRTOoEJsiC6pesE92+HCWvMagcCPCQ2JpfEjlIe3oJCQWEF9Bhkz6H6FLxzLslGD7z2O9P54h8NDbmG0AUw2o6NOT6vZ+t7II1aApxLgO+rt9r6Lcfsr3u1A9OUW1Xy6wqYDtkEFRJzpYtwCDi6hOkGvdKMOmb1uk6mj3ngqudbpySPx4FjQgrNBXnlKv4+mtKO8XwCCTiH8YoCNXPn2IjxvZ2n/4pYVvsLSwjcUnUHH6wZUVBvNnqWlqJJBLHDecXkY1cfoiiCjuvD3XoGcB1LyT+xRBcTjOSGZIFOtD/neGze4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY1PR21MB3870.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(7053199004)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/pYa252eFFRrG3d2Fra3pCSJBfFm3nasV5h6MYxyZPeSBmBBeg4Qv44/FD6X?=
 =?us-ascii?Q?iD/SFhodz5OEsdaV7wON7Ba6f0jxYePYlx7LFh5md0HCQoGZxejQuE8bJzzM?=
 =?us-ascii?Q?NNq2D5neYxqYOVGpu633u4+1+5SzrUdYXAbW3zjzqlKo27/eQOTpUXcd2O2j?=
 =?us-ascii?Q?hVhoBMnGwAlSrTfOcIa075thG0+UY4HtCdU0pF1w+VwXKC3ujaQW8jVr7aA1?=
 =?us-ascii?Q?rO+rqDgJS3fJJm8ya6RTwZxzWg7sKwIFxpMi9OhVfaCGN9ykFeXFbTJsFnkD?=
 =?us-ascii?Q?9OOG7kGUkv3Am/EPxH9IATWOdq7Kxp5A0JnzrtTuqRrVVOWGzI1+gxwOWq/c?=
 =?us-ascii?Q?V04Lb00DEx81RpR1lxQgPFOFR1rDN31eRpZRHQeG00k4HFV8GieGdKDJfOr8?=
 =?us-ascii?Q?abtA9mQ5PzhmBj/7G8y4/aQZ/WAxxyRI/gLkRSDGEneIDcemOy+UVKM3DIXx?=
 =?us-ascii?Q?sWuUEi7ar/i/kcY7PU5ITY+eJ7o7ardGF0je805Isacojxim0LvUpodyvU8E?=
 =?us-ascii?Q?pPPMIDF41hTgqLiP9Hk5iRTycBZMSoYOM8JjqFr8WJAMzCykw/8vuc2vyXSG?=
 =?us-ascii?Q?mw0x0WRVFd4Kzuqu62aZT69DhVqzyJqw/GafibHMkMUqyDnFZeLw6VtJk0Be?=
 =?us-ascii?Q?nPktSeFn7xeE+QF1K1D/RiHT8tsbv6TIWaG5uA8ilvmuuUac1fVv3EVpMjG/?=
 =?us-ascii?Q?NQOTszyf10VQK/76CsVkNsBm/11CdPqEuKd0hLNadWJVkqRxvdaJ/fGQl+/2?=
 =?us-ascii?Q?XpyHLkOmgCpENeAxHI7R8xaYUSU8R+JE1IcOl861Hb/fo0YFNKk5rR17WTLb?=
 =?us-ascii?Q?F2IINkjtnRhlB2NnZsHoUJbOz0q1+DWIJGj831NIrPp5vVld+FeyIkNvNCzo?=
 =?us-ascii?Q?9R8zA9x8edEvdVfjyup6ft9HkfMCQ0gRjrrgOJArjM7nYhFIkqdwc4y3hHAp?=
 =?us-ascii?Q?QlCIjDtGCwsXTpwz9fm5ifApnPQw9qELaoorOaZYVDQ7DyTTbGiO7U4QNNsh?=
 =?us-ascii?Q?qFzhLSWCa56KMK8z1J7AEEPy2V15yQ296tl1AGOv3sxQ40JohNr+jIt2QrJ0?=
 =?us-ascii?Q?wFbwTmhj+X5TaDSBIFIZP26iBIB5k8/SstUDMMO7Ms2gqYDYMdZu979ExlK6?=
 =?us-ascii?Q?dC94F5D/TGYtPmBHJkuBLyTNsAzi9ENbB1xMtHNILzz35IA2Z/JPKFwMG6uI?=
 =?us-ascii?Q?+fTdP++ClCAZA0m5NbeeZKImoPG/2g0xhAJQHhrncrW+bD6tpNbzQSPBQ+5D?=
 =?us-ascii?Q?O/2iE0AuUXMy8zB7lt7PtnglzAdWuO+QfR0ZzPzXejCcg6KBzlEYy7/hciS6?=
 =?us-ascii?Q?RgYGfgyD4CNqkCBazIOP952Ez5mk8OUqwHOvn3L2fyd6HG9Bqth1PjwwpHNO?=
 =?us-ascii?Q?Mr5ZNIrdKnvmJ7QO1OhIZa1hAMk51Al8LFeWNVTdijt2a3O2wAzpWOs8s89E?=
 =?us-ascii?Q?cNQIdi66sN7aeWCBUl3fXeGLaA4VZMXNcIMevhn2vyxvyDogd7meJlgWWkkO?=
 =?us-ascii?Q?mAUD3YR5CuaIag5Js3SegBpVndW1xRQwuf3Q0h2xBx4lR4rx/kFk6F/pMGxM?=
 =?us-ascii?Q?ORwjDlADzZ+dcuDgFpTBqmmYfSAbdTVO41oIgdS4cJTFHfigBPwWKse4QfB1?=
 =?us-ascii?Q?qLonZBVPvJE+/pslVmHITIRLfvbgltJ+Ma65katpzwMc73Bg3VnjcuIMCkqM?=
 =?us-ascii?Q?EWynQxfy4hhuhcnUQ2+3eKM4tekdhIEqO0Yi77pn0zlk+SOGECEmrosl59ug?=
 =?us-ascii?Q?Hfxyzjcnog=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY1PR21MB3870.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5babe118-683e-4e03-6573-08dec0f9ef9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 22:54:43.1867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xViHl3BtpW5JSGSvIhd4pPFxlhTFkTgHgUeJKvASfjUjuZAjXAO6CPQEGfJSkVhL8gH+ogv4iefFdx5Sl2sXkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR21MB4685
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11458-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:leontyevantony@gmail.com,m:netdev@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:kys@microsoft.com,m:wei.liu@kernel.org,m:DECUI@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[microsoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[BY1PR21MB3870.namprd21.prod.outlook.com:mid,lunn.ch:email,vger.kernel.org:from_smtp,aka.ms:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFADC632BC2



> -----Original Message-----
> From: LeantionX <leontyevantony@gmail.com>
> Sent: Tuesday, June 2, 2026 11:52 AM
> To: netdev@vger.kernel.org
> Cc: linux-hyperv@vger.kernel.org; KY Srinivasan <kys@microsoft.com>;
> Haiyang Zhang <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <DECUI@microsoft.com>; Long Li <longli@microsoft.com>;
> andrew+netdev@lunn.ch; kuba@kernel.org; pabeni@redhat.com;
> edumazet@google.com; davem@davemloft.net; stable@vger.kernel.org; linux-
> kernel@vger.kernel.org; Anton Leontev <leontyevantony@gmail.com>
> Subject: [EXTERNAL] [PATCH net] hv_netvsc: use kmap_local_page in
> netvsc_copy_to_send_buf
>=20
> [You don't often get email from leontyevantony@gmail.com. Learn why this
> is important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> From: Anton Leontev <leontyevantony@gmail.com>
>=20
> netvsc_copy_to_send_buf() copies skb fragment pages into the shared
> VMBus send buffer using phys_to_virt() on the fragment PFN. On 32-bit
> x86 with CONFIG_HIGHMEM=3Dy, phys_to_virt() (i.e. __va()) is only valid
> for LOWMEM addresses below 896 MiB. For a HIGHMEM page it returns an
> address that has no kernel page table entry and lies outside the
> kernel direct map, so the subsequent memcpy() faults. As this happens
> on the transmit softirq path, the fault is fatal.
Please include the stack trace in patch description.

> A HIGHMEM fragment reaches this path whenever the page backing an skb
> fragment lives above the LOWMEM boundary, which is common on a 32-bit
> guest with several GiB of RAM (for example when the in-kernel NFS
> server splices page cache pages directly into the reply skb).
>=20
> Map the fragment page on demand with kmap_local_page()/kunmap_local()
> instead. Using pfn_to_page() on pb[i].pfn maps exactly the page
> described by the page buffer entry. On configurations without HIGHMEM
> (amd64, i386 without CONFIG_HIGHMEM) kmap_local_page() reduces to
> page_address(), so this is a no-op there.

So, on 64bit kernel, it has no performance impact?

Thanks,
- Haiyang


