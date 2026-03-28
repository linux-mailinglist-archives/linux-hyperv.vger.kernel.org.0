Return-Path: <linux-hyperv+bounces-9823-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cwWwD9gjx2lbTgUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9823-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Mar 2026 01:42:00 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1E134CC31
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Mar 2026 01:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DB26302E7BA
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Mar 2026 00:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9C81F3D56;
	Sat, 28 Mar 2026 00:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ET191slm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020135.outbound.protection.outlook.com [52.101.201.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5699E1EE033;
	Sat, 28 Mar 2026 00:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774658516; cv=fail; b=LF6bvfExW5MwyQ1HE7yS9KOiJDo1Sf7tldNcgcq315zwWWCDgZiXKdLKf+OHAbxmpicV+2iN1U+bMlPU4vrnwZFxWB7ueiWGbnfC1aEUdNqNNzcRuzOia5vL3nfyCfrMPt5EEaYHkQpXs8JPhIjgeFdaREedR56wjitbspXgPuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774658516; c=relaxed/simple;
	bh=3BEzUgV1uwR7ROnutsoEvpYforpHXoduD8wzP/BQ0h4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZFRqigB5kfTW7Je7UiWTAV8zPOqTgGokkAF7OuoHVSG9zpb6ECX2WbddixLtTNfOIMOCLGQKDwYjvjiOCFXJGAG4oHmea5TqZTJ64Ck3H7i5VgIpp9qU3OMXHXRrabSTl7hbe8uRSP//3jtRPrGMrXR8bOAPrEnGuCBrEkzFUQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=ET191slm; arc=fail smtp.client-ip=52.101.201.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1tAamj67BLgko/v56ruQ3CaDDrHhleRJVV5fkn115pwW9TkYeL3E3EYMKf+tEYMkIHAztiMP9VWqDw/nnPWenSztZWYdqsDI97KOz8dS2Dn3tlheHTqbJssG8KGZkg2XW+wgggK1/6r0PlyTNT3xkGWWYjEc1FT7hr6eCCpORLVY6urmUOBfNLKrzwqoF2Aj2O6PdAfIdBs2WHHUqxZYmecmaZTnUzRzNVmQ7sDIIXskw+hKyPHAuPoAAkcMeCh9BjeT4FlMr4b5HnlvMsmcLHFUuieifXBEQy1GIhs/c3M2JFDX/dK+mJ8ECRx+m9bZBVY6hrzgdp8r30gXVVs4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5qKcrBUDkaCVdoC7U4ArXgTD8UoD6CX8FRPgXee+Ts=;
 b=Mk8O3nqqhZhOJA8OmFGXxSbQRZF+JD2G2ToenqYPZQdKAuaHovnmGE2OO6rqxEH/y/z9CjskvlwXSzu6edF6QZSVGXxJ58mwxTZKO27fhSktRgUP8xpj5OsxTk1n9p36Op2MHlNkjA0vRCDSWVVq87eYzziMz1aj0b4bLxEFDz1zPrwsnUuhUCTa+L5KgJLU5fn+nz2SpcN/ZoPlNJ4x0uR6PtWjX6Rl31HOv0lccDNsTB6VaBWPRH4SPef0OpbKC3CJzIQXCAdVhWQCHEfhyU5kykcWXVseSCzF6bKB3tlI96VtxtbGuVNUAHXEQVjVODmfz7BZWIUyYvrNB4KBoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5qKcrBUDkaCVdoC7U4ArXgTD8UoD6CX8FRPgXee+Ts=;
 b=ET191slmHpNeoEOHpv1Qr7CQirlzYAsrvKtFpNIXoWyWOkdWbGIdLba5bq0+e13vLnzeBKmc2oJM4d2uqDfwUCEAZqzxHNZcq9Y7SeiAmwGwgu7RsTooVgEBf+4AnU0XREAHNULW/pXhurs5SG/qBcWfV9eKjdlMCW7fne+VK2A=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA3PR21MB5768.namprd21.prod.outlook.com (2603:10b6:806:492::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Sat, 28 Mar
 2026 00:41:52 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9769.011; Sat, 28 Mar 2026
 00:41:52 +0000
From: Long Li <longli@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Konstantin Taranov <kotaranov@microsoft.com>, "David S . Miller"
	<davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Jason Gunthorpe
	<jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Simon Horman
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v2] net: mana: Set default number
 of queues to 16
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v2] net: mana: Set default number
 of queues to 16
Thread-Index: AQHcuv4vlEAYdkyNzEesZ1PA5JW747XButWAgAALNQCAAU5GAIAADMjQ
Date: Sat, 28 Mar 2026 00:41:52 +0000
Message-ID:
 <SA1PR21MB6683B120D905ED127A0C5DD7CE54A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260323194925.1766385-1-longli@microsoft.com>
	<20260326201841.3b7e5b78@kernel.org>
	<SA1PR21MB668314B1AF002E40B379F1C0CE57A@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260327165512.08f7b6f9@kernel.org>
In-Reply-To: <20260327165512.08f7b6f9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a910f061-32f5-4e60-96b4-e26e75cccee7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-28T00:40:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA3PR21MB5768:EE_
x-ms-office365-filtering-correlation-id: 061a2e02-1751-40e4-9346-08de8c62cddd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 wUzdyT06hDpymJ2GEccx1RWyTDJ6j6cYx5xGAID3135P11Kb0bhQ74WIiwGR0Q3Q/6riZmjDQbUCiBJ8Fc93UkFOrUzK37DWBtxdHLGf2uCmmq3IeH7u+5dIXzaA+wt4pECVQDvlVNz9CTvDjJClcNZ8Pxf6Bfzjock1tjVBtngHqYBYapanuPb/4gEaZWX/Gv78tmnMgSSXNvlEOITu7YKFJyD+0h96nN8h36zZZgzqBpfKd1Esa6vv4HIlj1YLEtlHyN+RKm5L3hI20P9/xyd6XcADaDpyJm5suYJQ+x/WBG5DvmEyUn2+yHIyJWkeIq092hfCqkIXLS6vyFeRZX2IoEMKX7Cfo23QNG8iGnxbPFLyu3/5xu3we7y2mmEnpq6zmRGUPl6Qh8ZVjNI9jzxnRyErsM9QetqQ+F+TdS8Lm7RrcfhL9MqHsYzcZPLNuTNBY3AvC0m0znakibWORn72mYmJRTdzNFBbxaJf4HLYFqRk9Dg1wuyg1ob4M6dIAeqLHrLvd6hlFWQsu03zv/gdA0Y8vNvOQ8g3LukdNdb9ruLCjKsfCsl0Mb7DGWdvhGn86Xhb5b8xXKCwf6uawzEXYgv392Lh0PIgTdIOQ1RflMqYSIaP0pAvfc+Y4ol2f0zVyrDaXRVe9xzr9HsiEUahRN3/BTjqyz5DX7ljhBb6iV8ccFB+WYaJOmKgM/vXAZfgSCh9j/+G49yA8G6DxpfRkp1r97dk2u/eG/In0O5UTW+VFuvDBGncOwPyodOXoLq1Y64HdVMNTnV2a+wAJFW4me2b+rGHlU+9ZIiyIZE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EU/Wn9m5mlIkySYz9/lDY/nMdReCJTYrkDRST5JHFD9m5YBruAbEIcms4Wbx?=
 =?us-ascii?Q?ZTQKplcFiB8PXw31bM887hRCDJYNLtmigdYHPD7e3C7QUiXXqUqSR0rsQGTc?=
 =?us-ascii?Q?g6LAQOzLppt9x+4wR98rFK6cA5OmjemMRmyAMVW9mi8XgH5iwp/HCS86pg5w?=
 =?us-ascii?Q?Olebulw1clA4hLOBKOeHVWsRHIvX1qXfk+K1h0KS76wSEdtoDiry1NFeLbe7?=
 =?us-ascii?Q?2VlQW/+mdWw9Yydt29P8AfHuIcxZX45c2bDU4bvR+z3FWirJiG2MuDkBQOmE?=
 =?us-ascii?Q?X1F1n40ScBghEAMSwm/ykcfXK/ijnUDEvLAitJvpaO33JjVQl9rlhFceAth5?=
 =?us-ascii?Q?8XTogxGpnpxCdUZmELoA5Bkxpjn6/XPrwGe+bRKi/U066t7iM+IXF+lordlP?=
 =?us-ascii?Q?8vMjNk55wnU5FIv9D1hqebtvXtdeAMugOOXAjEEdt6ONdyY0n5GNA3Jote4t?=
 =?us-ascii?Q?3NSN9HuGGxV0cIWo6is3w1aQOgROBGUB8/ectJC+vSzcEzkBWjqlzznx4z5j?=
 =?us-ascii?Q?SCGfvOXlOLvGO8Asgrbz5Y/o4X4LZxAFiIxB4eDNzW1d0WFUEMB94it4f+ZE?=
 =?us-ascii?Q?FSoY5alWGwb+Ffzs1gGOGt0jgHHUrsXO7jvVzlda5WyqcYB4nE1YYUiASdvs?=
 =?us-ascii?Q?VFoK7hiXzy7hHd0cmGLldJ0uT6cRnbN5hYnoG6z/ei9DtScqbjM3ZE64rD80?=
 =?us-ascii?Q?48SIL0tz1nNwIaUXByO1SWTvB3cM5yhH6wWVw8eTFNkg9Bz7NiZicXyRHxiY?=
 =?us-ascii?Q?LuuON8dVuJnVtBXOTMnaOirqvSbYo/BbbwqVnrgeMUvmUZmreK+1Inu9ePQI?=
 =?us-ascii?Q?OVmB99oFJbeeDChoxYa5bDlU1INxQXFkJkRpcQhEiogYPT3lBo68jYo/yHni?=
 =?us-ascii?Q?jBcU3SrMFhtCKbtvNoyJ16XRrN16yxqZB5gkvdpUSznQumWkTkjHo/uvJs/V?=
 =?us-ascii?Q?ogKmX13So89Mg9qYh27tyF4Y1QfrQVDlsj3KkC4jt/yR6hbnb/JuVKKj0y5s?=
 =?us-ascii?Q?4l7jVOzsrO73pSPldFW/crZqX9i/4OjO5wRfULPeAJngYUdYdv8+SI+hUhX8?=
 =?us-ascii?Q?uw4k5plud+TMo1YhUoloTwG9YTto0pX63T1FJBSfRrsos83udmV1IupMbSjU?=
 =?us-ascii?Q?EHFiQNwfpxAOJBQSk2IGXlyOq7rLdyl8chA3oXyRwtBm9VWJOX3G5h6j2u1X?=
 =?us-ascii?Q?fQEuwqoB9VK+94j73imP5j0IVkncxBhD6APDTV/H5ygyaJZvyBacAzh1zUxC?=
 =?us-ascii?Q?Qa3fceh/N1gEut7HCQhnM7LfRhsW//zASxVDQ1n0oAUVjqDGTJHyOz7i9GZb?=
 =?us-ascii?Q?3gvccowjqAuxoGaTZadLXnliGTThG04NVZ0/jvIzRijcg41D/LtfbbsHOOq+?=
 =?us-ascii?Q?DQa4s3JbJHamykTaJDAEi7NHYRlIZR6uaUKyKpK+UrzWkG0XtKcFigCfVgmT?=
 =?us-ascii?Q?2GDDsQHhUqE3lDjLYEPYm194sYDVk6adU+OoTh9+3t3nMczl2EPnHVzs6uDp?=
 =?us-ascii?Q?72C6qn32gZfqFEYuKvKEHtXLBAyIjpIhA/d0/HgXdg80JBMvrMSdQ9Wv5WjT?=
 =?us-ascii?Q?0blX7ZIhOPa84sVWsttL6xjFsBfEqcB8tVqOEQC8ChSK7A4gjmoZ62i3ojik?=
 =?us-ascii?Q?dA3nPTg/lX9k1Y9CLWNQ+ETHZgZsK79Gu4VZjD8i+1mjTaNSJvaXGhsMc3Q1?=
 =?us-ascii?Q?sWCoUXc2SZMP1qjA8ALWAh7r3UoRHA47y1za8hfkYWH0Gtdf?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061a2e02-1751-40e4-9346-08de8c62cddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2026 00:41:52.1210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dp0djmTEmci5jU5sKPqc7tbNmKa532nE14BSFRMKX/mFcWOlokNB5tpx3tqCtAeMQGD7sSgb9qFFHSRlKnMxrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5768
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9823-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SA1PR21MB6683.namprd21.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 8D1E134CC31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Fri, 27 Mar 2026 04:00:31 +0000 Long Li wrote:
> >   We considered netif_get_num_default_rss_queues() but chose a fixed
> default based on our performance testing. On Azure VMs, typical
> >   workloads plateau at around 16 queues - adding more queues beyond tha=
t
> doesn't improve throughput but increases memory usage and
> >   interrupt overhead.
> >
> >   netif_get_num_default_rss_queues() would return 32-64 on large VMs
> (64-128 vCPUs), which wastes resources without benefit.
> >
> >   That said, I agree that completely ignoring the core-based heuristic =
isn't
> ideal for consistency. One option is to use
> >   netif_get_num_default_rss_queues() but clamp it to a maximum of
> MANA_DEF_NUM_QUEUES (16), so small VMs still get enough queues and
> >   large VMs don't over-allocate. Something like:
> >
> >    apc->num_queues =3D min(netif_get_num_default_rss_queues(),
> MANA_DEF_NUM_QUEUES);
> >    apc->num_queues =3D min(apc->num_queues, gc->max_num_queues);
> >
> >   For reference, it seems mlx4 does something similar - it caps at
> DEF_RX_RINGS (16) regardless of core count.
>=20
> mlx4 is a bit ancient. And mlx5 does the wrong thing, which is why I'm so
> sensitive to this issue :(
>=20
> >   Do you want me to send a v2?
>=20
> Please send a follow up, let's leave this patch be and make an incrementa=
l
> change.
>=20
> Thanks!

I will send a follow-up patch.

Thanks,
Long

