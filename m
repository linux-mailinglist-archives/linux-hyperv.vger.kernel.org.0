Return-Path: <linux-hyperv+bounces-10111-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ9IDPV52WkzqAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-10111-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Apr 2026 00:30:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B893DD39E
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Apr 2026 00:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12DB43009B2C
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2026 22:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0627F3DF005;
	Fri, 10 Apr 2026 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="F8vrVLtN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022140.outbound.protection.outlook.com [40.107.200.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C73358DA;
	Fri, 10 Apr 2026 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860189; cv=fail; b=irhrrXmEdY636PpvAuxAzBRJnjku7shTvoRfnVjxL8AqLH1oq4z6aGMe6drHNSaMUm3X1qn5Nr0IcDZnkJZv3rfGGjlHvE6HntoU5sl1w8jK2JnjCt0Nx9C7oD3T+JgK3060ORHhN3V8pgy66FDmDltijDOSMFXzCJ8YIUBEZYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860189; c=relaxed/simple;
	bh=aKRdzfhw5BgHGBRv0FW7Fecfbx8c5U76j9pUz5FlyxI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b/63FkBnMSAPgb9vXR2FU0Yrt+kdiNhRGkqcrI3sF5HKYCvtVJCX3oyRRQU7B8u3+BGg+qtQA3GFPorLGjxYzzMByZAHRICeq4kjArQs/XiTLos5ek4L/sBzL/a6M+w/4NOHEwBd/bqavgiztCv07unIaNeU9ib4v26rBIHGrkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=F8vrVLtN; arc=fail smtp.client-ip=40.107.200.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nn/opkCK3IURKCO7pmOoGWe33mU6eYBSTqfKK2mRYULYr8PevVNAuv5jfzuENUKXEvXfXSPCU312rLtY0CX5B7fxvH+l2r4NwhPJ9uLHUKAV9GmeX5oYlg2ohi04lvDr1ZxZrjAtjI8oboY8bbMU7ox+fIRVLXoSEMLUHQaofHjqRc45LLEKiC1BF7W+oebLTB4anbAQIBeZnlfpCk9CG1CorqJ03O7GZuZmuXnLrrxwVVcpfVTa8+u5B5vR0rkr5xPoFUpY8X8n5FcK/i1jb2LVfStZFpR7v4dDxcs4doIGFOA2LVDPlSQHpj94OgMwXcW5xqZcTHClGqmtiosQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKRdzfhw5BgHGBRv0FW7Fecfbx8c5U76j9pUz5FlyxI=;
 b=O3RCUtCZHuVUZhITVs8waz8PMttZ3CfdzhbD9dkqUjUwbDKArGKDQBKmi2h8vV5pahwImfOhvJZWqpBQd5tedPDommS7g4k1U6GWs+1/81LLYXFwTlbaZonSDtiWH4D0iLyj/sarYBDvs4DwOnVqLXcFwtwABWhZmVo4PmybmXPHsCa6C1oA2h/0m707R6oMouFyod+rCTHatMy66nm3llm0yPrzMsWSEeLuTbV53yau3S+MbDh7AkGubptAFFvgNiWV5cuhqMyeFjRzq0qJbAxCQM3oVXMz9NLGYa7SKVp7BxbTpPDxnaasoEXz/Goc3dSvqnlD/jVa0nX8B8YMMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKRdzfhw5BgHGBRv0FW7Fecfbx8c5U76j9pUz5FlyxI=;
 b=F8vrVLtN1UXMG5SRL1CkZk7HQ7EUoC8U9lf5pGGLGiMFqMdvFvDxqTRdbxr4U8oV9m+V0jb9zzPxoE/fVk1P8UkOwwnd3BpW+eaUpSnKXHSiDAZGufzvCpbgbYnd11y7oVV7QxTC1BGdn16HOIXHuMme1iKEdCtHrAjGFGaqToM=
Received: from LV0PR21MB6670.namprd21.prod.outlook.com (2603:10b6:408:337::12)
 by LV0PR21MB6120.namprd21.prod.outlook.com (2603:10b6:408:33a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.12; Fri, 10 Apr
 2026 22:29:46 +0000
Received: from LV0PR21MB6670.namprd21.prod.outlook.com
 ([fe80::c354:baab:cb7e:3c96]) by LV0PR21MB6670.namprd21.prod.outlook.com
 ([fe80::c354:baab:cb7e:3c96%6]) with mapi id 15.20.9818.006; Fri, 10 Apr 2026
 22:29:45 +0000
From: Long Li <longli@microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>, Konstantin Taranov <kotaranov@microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next v2] RDMA/mana_ib: hardening:
 Clamp adapter capability values from MANA_IB_GET_ADAPTER_CAP
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next v2] RDMA/mana_ib: hardening:
 Clamp adapter capability values from MANA_IB_GET_ADAPTER_CAP
Thread-Index:
 AQHcskxp/rldcz8WSE6y5yrJ7Ov/rrWxl2eAgAAP7gCAANlFAIAFtXdAgCBm4YCAAHC7cA==
Date: Fri, 10 Apr 2026 22:29:45 +0000
Message-ID:
 <LV0PR21MB66700DC2FB827B93ED6A5714CE592@LV0PR21MB6670.namprd21.prod.outlook.com>
References: <20260312181642.989735-1-ernis@linux.microsoft.com>
 <20260316194929.GI61385@unreal>
 <SA1PR21MB66832D25A93394735624F454CE40A@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260317094408.GR61385@unreal>
 <SA1PR21MB66833EBAF447BA0B102862FCCE4DA@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260410154327.GA2551565@ziepe.ca>
In-Reply-To: <20260410154327.GA2551565@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c0818b64-e5c1-450f-b66a-1f323b73fee7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-10T22:26:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR21MB6670:EE_|LV0PR21MB6120:EE_
x-ms-office365-filtering-correlation-id: 8c1b9ffa-349e-4e67-f585-08de9750ab40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 v28Gaxcq126tQsMl6N0RerkdSNo2E2V/xO2o+e4PKrcgQ6oyqZcthscyajYjv3+CLgAX3drcr6NxaiP8RT9yfYQbt8khEYP6v8+Pcjd3aLC/YMzMUETWMslaLtHtLm4yNlo56SeWPI08wIwOVaN5hgYLuguhS+aplTt4FPHOlVDU6ry7IRIt/Fbn4GUofSDWVFmiIigekOMChxeuZbLlRSf3Jin0gX/f9IV3rXxrqsoJJnOJ7zxvswpiMXl9BwRUxsW3IUh51CwUsYFx4E+uhynUbczfIiq51sihWsi/FZgHgmuIBjtteuDEDLL2ASD4ZZSPRdmPlSET12Q17jnxF+wvPjKJKk5mpCK+bz1Q1l/QKiwq2GCLzpXtsL5/Bfl5ynSgqu+JzYRDhnzLdJFhYSbVKtKGxFymV2LdyjiHP8vhZyMvIe4Vhasaxcx33PpFJVprqjciZ2pfqf5PTfNhthy2Z9rYmEC9qlBoez0rLyVlAUp6O+2G2eTytSvxhPLWay6KfrwCcvHik/10q/SUMmD5h3GipCzD05XmF29TVDRo3vrRXmVY+KuXkY3FUAH+wiJ+/jZOiGvF/iw97VtOT0JxLdCt/AQsrwRchRi1GDux8g6YPE+q8mT7ePnAWav2oAY2BFTKfGm9cBTyl5p5JHo6LG3J3Kwm2pjNxxyNMIDRPARXcoNappqQBBj4OUepvcFNylkzSvZ70zPKGVfle8gG3V3+BFvj5iZIki2mNRDGafcVm+cHwW+1OA9bvTXY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR21MB6670.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GtA1mBzHZub3cOG+egN5bXbgVbIsisZUVYCyFecePbDD3BAATIHUDN1tGKWS?=
 =?us-ascii?Q?YgYcq566z9U4UTxPp0fe031Y6zgo6ZqeuZlwpJCjsercqPhMT5FqFzOFSH7o?=
 =?us-ascii?Q?bP0Q2XsvKTllxqtK/hNgKdIL/kawKIwGi7A7SuzxZJ8ad5zEsURVSNr5uRJV?=
 =?us-ascii?Q?aNyBr02ngC9TE50UP9YGs3ktoU7EX7EH07/6VtGUR7GG1+ZJcOHoi9Dtpv9s?=
 =?us-ascii?Q?8RkmaTC1sk2+OvnP2UPSoLJl++9wIHS1f1CGvCVqENRJzzrk6MeKA7dFwz3W?=
 =?us-ascii?Q?ddf9KctGd3OXo1U37MJwBjvmloTvbVpXxINfV3Jqag5H9H5S26gRJQ5wkAi7?=
 =?us-ascii?Q?D9FRMnzNiXK93oOjKq5CG61rFBYvoQWk94V1Cv1uwD9SZuDbhZdw5Ekpgp5d?=
 =?us-ascii?Q?q6+LmFqZKRNEdz1YdFLF3a5Mov6AAuwcHU+vP0a0S6UROj/ALLidT28vYxrU?=
 =?us-ascii?Q?GCHIM8Y3mdVkCJbyped27rXDsb7stzfm3xb3JMKb/AMd6HX7JWSGjUc/szWz?=
 =?us-ascii?Q?6xUYxXSqeM3ZU15R/LYIo5yS6Xywvgll2l196miWPnuJUBUJEZRS5xxHnCxp?=
 =?us-ascii?Q?r5r5wBvzRbjPgaK6vEFMN43uezBsKHUJAgC7N4IVXqdPuqRCGLvBnOcZcVeS?=
 =?us-ascii?Q?DpoUdz0TThcY1ANVgbN9ALkVJc7yAtHjj5wTulfrfV2e3oS23vGViyPMh7GT?=
 =?us-ascii?Q?QhcCDghKtlAemhFzh3WMBkmnaXkfchFWuWk1VaS02FTfkuzL7C2L9hEacfYx?=
 =?us-ascii?Q?roNKDvmQuP2XzMnf05fvko1Whl+yE1lJ1BI4127xFDnISrvErowYFU/i+Z12?=
 =?us-ascii?Q?SydPDoYU/HgXLzYGrpC7oews6wKD7SOwlbpeQzMX1JSforfFiOis2p43fg8u?=
 =?us-ascii?Q?3Ox5Yrd6FTpRofch/YKwjYWEIkGK5kKoGRxjsKlY6AhfZ5a2W5IhQ5tLSz7F?=
 =?us-ascii?Q?r/Hbgkfl9Ckz/qDLda8yjVyNOZio6LzpQpivwLz2xC194iJUGrnnd96cSqha?=
 =?us-ascii?Q?8h8ZKn2Kf4RSUWCrYHRWcequDZCa8lugiENAD0D7flWuXajuHMxAXd5Dt8GG?=
 =?us-ascii?Q?4f6ec+Yy/3HVi1KyWfTDKaNwdNnwmQUhiCR0G2mn8R/LEPh2iHHVbC1DUOYP?=
 =?us-ascii?Q?WjdWe0ZhVeFo46/1p/F8rPaAS42pMCEMVWvo2EisVpqKvU/zX+gH/DWf4rIf?=
 =?us-ascii?Q?nBYkaRf+1fgg1Zre+6hVEdfeKieI08cpMGemQJXcpjH0ZeSlWDnRsS1GCXZE?=
 =?us-ascii?Q?tcfh9ukPRIOcpV1BGLygrTHX/sQK5LYiaXU6/PTmCUyBvw6W8itl7jlthDid?=
 =?us-ascii?Q?9cvnmhP4KM/Cc/PfMsrq49zJHJo4eeB3Nh14q1Db3i8/6DPM0gLNkQt0FgPQ?=
 =?us-ascii?Q?7D1TNwTh8pD571Hno3fzTMLFWhpU7Klc0p3sYNfpYshwMVALPQ+HQ908j7KI?=
 =?us-ascii?Q?lfkATW4JTE8C+wFx9QH/RdZststLzKjIIbrbzaok/KFg+bfZH85Zj4L/pQHG?=
 =?us-ascii?Q?tuxq3znacmV/vNzb9RWOGNLyGVJIUcI5R+f+DtHfVnIsqUbwyKJ9Qy+2TISq?=
 =?us-ascii?Q?KaJfYtyCmpKGsj3CJIpUOgIgx33s6Z+9WCJI5q2SAr6uJIRqg7BhfveuDlwT?=
 =?us-ascii?Q?LyOknUZqHBBh2l6V+KNBVZmSzfgGOc6jbg7CXVCs9A2bXRp/vbK/2YZu22fi?=
 =?us-ascii?Q?0TIdAsTds52tjhFd+xOZbWRJJNTZqi6118l7YD2zbrTADKob?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV0PR21MB6670.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1b9ffa-349e-4e67-f585-08de9750ab40
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 22:29:45.9104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dodTJOEH+uwp+jUSkKsw45LsCcc39UX95UFU+lbfFmT5rBu2WlOpiEtWtReghqOJR1HWxVw5fB0U8YR/uxQyXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR21MB6120
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10111-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,LV0PR21MB6670.namprd21.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 86B893DD39E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Sat, Mar 21, 2026 at 12:56:39AM +0000, Long Li wrote:
>=20
> > How we rephrase this in this way: the driver should not corrupt or
> > overflow other parts of the kernel if its device is misbehaving (or
> > has a bug).
>=20
> If we are going to do this CC hardening stuff I think I want to see a mor=
e
> comphrensive approach, like if we detect an attack then the kernel instan=
tly
> crashes or something. Or at least an approach in general agreed to by the=
 CC and
> kernel community.
>=20
> Igoring the issue and continuing seems just wrong.
>=20
> This sprinkling of random checks in this series doesn't feel comprehensiv=
e or
> cohesive to me.
>=20
> Jason

Can we follow the virtio BAD_RING()/vq->broken pattern in https://git.kerne=
l.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/virtio/virti=
o_ring.c#n57.

Add a broken flag to mana_ib_dev. When any hardware response contains out-o=
f-range values, mark the device broken and fail the operation - during prob=
e this prevents device registration entirely, at runtime all subsequent ope=
rations return -EIO.

Long

