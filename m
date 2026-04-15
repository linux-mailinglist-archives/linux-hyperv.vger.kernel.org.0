Return-Path: <linux-hyperv+bounces-10183-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBY6OGix32lCXwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10183-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 17:40:24 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45064406033
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 17:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 616853125833
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 15:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEFD3DDDD0;
	Wed, 15 Apr 2026 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OsaH/n2k"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021075.outbound.protection.outlook.com [52.101.52.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83BE3DDDCF;
	Wed, 15 Apr 2026 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776267065; cv=fail; b=bTJJ6ekOJKcfSWvVXcdWw8jxTvC+rxisGXAf/sNS72MXNOtR8wVNCo4baLpvTp46sPOLPn6M3dLDlJcPUtlur7b1+dyIMXxJ5xpUnY2W7bLoS40EGcjMbIseo6JSTOq9NqF8OlG1RU/XmXDLz0Bt3CMwR7cuBmRiOEUjeJLW3M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776267065; c=relaxed/simple;
	bh=fwa+PqOKIOZcWPoBTXQfTUdEDJUYb3sp9Nr4ntM35kA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o15yduiKjAtwfrO3V+nseju5zzzDZDn/738oom+uoetT1wehyhO6co2oi8oRBiX3JlrhbWHRudDdHN+UDiZWcDUtF1t7PLOqMmOmMlhC8QmXIqJEMY4wny9t/lAHQzo/NoGZmP8tk+Utfz3yR2Q7FFGe14tCUB+EoZ6UPzY4bSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=OsaH/n2k; arc=fail smtp.client-ip=52.101.52.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaVi3J4MoJ0eq9o5vjZPS8JYazfCIWXA8Ao/DU3miB31wpIW9hcFs2jCwhQyeHY8oQpacuZrqqYcp7XxZmE9mYarHs9ATe7JR3u3AfTZYnw1DW+euHlCGWesP1e+xZABfQtmNcSEMLw5N/DDzkCmkrXkKTQOcSGTZaGHsk+Puv2vZMVx2Fh2Nppt6dY8+7ARh6jh6xq1vnWcBysLRZKFI8krqxZYeUTFQdY9NS/NB/wxVCD3A0CyJozlDkZ/pWsDz0l5mYFfyDXM1hLerfZNMKjpB3abqsHUDerZN+xJs4bvAa9hKlVCDWwXbCmnwQpSDNdyIgbnwzQqM95FCeBL+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3s6fi1i9t08sayq9XMqDdMuqYgsPnQenKBclcQBVi8M=;
 b=oBaDv7vfhFUsk2Hb7O8YFIIHa91+G3Okv03eYsFqtQyW46NjjDK2dMjlv6s0dsFqhTyNAP6csDq/Kwqh/31u1bXlj72rxve1RRGjkriiB5Z8GmQLOhDPGgH4SqNeziMrDvwzmI3hpZsMnSPMrVJqgQ7e9N7WVjKN9wMU3s8L2CwRRKxPCEp2Zm3qSqY8kZpsPbBTzKBEOhcMsnaorJyNs9Gl9x8rAquM0bHBae4cncnR7k2ToD7TwTa6iEsoP2RhgQwJTJviNfqzCXgk7IaE0LXlYuIXsHVECM+3esu3P7oMVGhceUYnYAflnSOkoBZl0gY6FUtSlhEfZk9TLfoVQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3s6fi1i9t08sayq9XMqDdMuqYgsPnQenKBclcQBVi8M=;
 b=OsaH/n2kv3HfHOx7DlXLeu/Ipb+BQ3hvNhCmgGk1jzKBVGTjJMUfGEAOt/0tIwa/S8w6hsw6CBa7y1Bcbp4Pi8hmAIxKwnHZ4gQHmR8XU0m+73jnQcWQJGRFh9xOrULd5ZPVpj2UL8purbxOQFKAm23q0o87/15k8j84VI/iVjU=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA1PR21MB6681.namprd21.prod.outlook.com (2603:10b6:806:4a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 15:30:59 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 15:30:59 +0000
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
Thread-Index: AQHcwvqZ7/kLR2JkdUmudlv9HY41bLXRHh0QgAOgeDCAAHmtkIAKqeRQ
Date: Wed, 15 Apr 2026 15:30:58 +0000
Message-ID:
 <SA1PR21MB69218F955B62DFF62E3E88D2BF222@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260402234313.2490779-1-decui@microsoft.com>
 <SN6PR02MB415794E53D2B621F6A8BA382D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB69215C164B06109C6682984EBF5BA@SA1PR21MB6921.namprd21.prod.outlook.com>
 <SN6PR02MB4157D5C8EE35A221B130FC5AD45BA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157D5C8EE35A221B130FC5AD45BA@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=064ced81-0360-4c14-8a5a-ba65234f13c6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-15T08:44:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA1PR21MB6681:EE_
x-ms-office365-filtering-correlation-id: 2f78d024-0e97-4abc-3b04-08de9b03fe77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021|921020|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 VzDfPxf7ZS7O5PMxgwQEeTlO81DA9QmfCCEapHqZt/IcBuJLFI3tkWh1duJvUq+D4Iwo3Lz/4sjg3qYhTB3h1wazTNqW7URYJ0s58sNAXgv5XxS6V1xuaEiPcolAHtJQw5wMut9jui0g/IXqm1l+QaQCY08B49+nrOJPV20E0kR4CfyynjkhwAaGT0pmsdgMi5QAJ3JAJ0mqhZxKKdHMRag+NehsKnKPXUBkJQWt7mMJ/XjI74wXwA5+dihxlfPfEfqbX7D1taO6+FXZJ69Pq0HdUKg2xhwimNlv+4p071sd2uHEx29gS9GYJMZlrPVjnaUuoy6BLJIONbLoT5tCaWm+ClRmNPe0q/3toi+qA03Asw6m+Pz4lfJxHFwyIAlzFBajAamUPNG4C7ezbH06ajkoJaBzMzc2tJsx7qldDfHHPjMapMrMGz39lXPJRxRPb306+bV/g5Lg1QljNaM5p7448HznaOebiDstBRBVIP2YauUxDK39ckeO3OUI0gSPQJYUIPrSIkFltdJeI7Z3iUkpGd2UzggBCCkMp9DWIocnalCgsOBVOT5g2dqvQTXM1OvEnMWVclL9Qjv+EM0CbEjr0u+JIUlB2K2p1PIeptVbcecjJl7RnOry8JfgacV7mDxxKicYZj2PNqOm2hd/nUM2k93m38DsUw9mYXY6t7+bBf+7EihdHZhL9Pp2mFX9OldV1Lh+cL+HU5r8rR2XTG9ts1dDi2W9lQk5+pCKI8IVDqj7Ie9joJlPiOgDbgqPT5gIfJWdGi42bmLY1KXtxXrv7a4TvXaPL9ufsfzDYANwisHKF0WrqqHK7pcpjSsB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f4v5mFIvVl4BapmrYX3CqGBpXHBruBU040pdRuhcp9FKX9RI5h1Qk/ZLeWxK?=
 =?us-ascii?Q?VqNgcSrAlV4udK0BB0p6eQ77ltutyOa9AKYTQc/N7QMPp2Gd1o10ZlGhCCR7?=
 =?us-ascii?Q?/fKtPqwTT+FnI7qyKJ3cUlbH7STA+XWaVp1pafY2iwoOukL4sWFo8XT7+tVs?=
 =?us-ascii?Q?oW7iInaODKZrhrbV3qMCQOCa67q8X04KxcFALJyTTha1T4vryJaM9Enlg5dv?=
 =?us-ascii?Q?7hRBg7DIeaAswQWDlEwyghre6i93oD/qbWODSwhJgH4889n+VB8I+M4GiSql?=
 =?us-ascii?Q?ZuoEU1HhU91lG2E89p6nkWd4X2AnGNqhBDH4s8KVsYJrBtC0EnpscbSspeSA?=
 =?us-ascii?Q?s8XlUzpPtvRvDW+TWUlbL6msvzceVjIDQYN6/uDYUai73ESw5NfFpMqnuTIM?=
 =?us-ascii?Q?YTY4qeVyJBPhnUoOqzdbCe+ZOTBFRzudNSOLDHdRmiizlncXuCVmBAyZAvzY?=
 =?us-ascii?Q?Z7ZB4iFGy/s6PiSi7chnBGkNvuNxacTT9nLQIuvAF1SBO5dXEOGnxO/tQSju?=
 =?us-ascii?Q?aAHGq+jX5SRD9gvYTiXcVpu+zqIpIcqsGWD3AuW3wtfuUpJbj7+yUfc7j9pQ?=
 =?us-ascii?Q?VNA6mFsXPKg+pjBgitLg5kNz0kV0nLHrjRLZKJ+IXtLkN4KvuHN/sJ+xXsgY?=
 =?us-ascii?Q?pJBtqrevPh8dU74ECNwRqq9Lq+X4qQReENJ/zOXWeE8joObWHkQM25Ab2edF?=
 =?us-ascii?Q?s+Bz/YC77CL6rtt6vh7RFLK4KtIOzKD2C/lrRkkS28e83lgUQdjxp1z0E24P?=
 =?us-ascii?Q?RggfVC4eNXgvMM7xqy9MKmt6+1dkoTr8CJJfnx+40cIPv9EJeoPv7wqjjsZ0?=
 =?us-ascii?Q?1joBLExB0/tVZgFtNyWYHp56KrKDOkh18SVIxZiB6oA93rVnHBU83JZTeeTX?=
 =?us-ascii?Q?DZUc4tEJa0RfYYJGE7kKuNv5lUSVuaTf69ErrFcJU9Z8MhcK1GN1nsHj0XPS?=
 =?us-ascii?Q?vQhRJDRemCwUf1YLtAJU5MKYJNMnzpZzv/UMsMdQOjIaU8hleABSpyN3g5YB?=
 =?us-ascii?Q?voyLfAyJW0H9o/KXQRAMDt5RMTRz4uzNH+Q+l3e2HEQw+YGaZT72m+XEdlcN?=
 =?us-ascii?Q?5PkjBHTeN36qAIQl0VQ2WxPcl190BWjIJ9oFgMIVOuE6HaIqILUVxhI+Rug0?=
 =?us-ascii?Q?nfs62QWX4jKSXVy2dBLEJUzcoyRRuxaHCoAi1WfiItiaI7drE2RKOjkaVPNT?=
 =?us-ascii?Q?+D+nNpemr8kmEgXnBLYNPabduEFaDQ+B3LVZWzbkruLznIMvC6l6sXar2NaB?=
 =?us-ascii?Q?Bm35REjPxnQtHi+b3U9B0tRs280Wx9Ow2+jabbws1O+0p2+yabWsiSc60oqm?=
 =?us-ascii?Q?gWamA6mp8sw6IgfAUyVFEBBLYuZdFT/LS18xVOnXzfHKb2Ac6yHDhLu12iTi?=
 =?us-ascii?Q?CGlbfEqhACRVotP55WA8GEli3GlzOx4UAkIo2PNkr4tUBaSP3FtcGm+XNoWa?=
 =?us-ascii?Q?Gq28c6phIFkLiBbWgJZP/m4zj79E+/had3cSL54LtuogcP4mGNmbd/9WES4b?=
 =?us-ascii?Q?V62KbBv0avaUl0fDJCbilVd3sj6tJSW32h/PehZQeeBFggQ3Ily2Jn/e7bAO?=
 =?us-ascii?Q?Mp6AGi01PDx9R3TNJRUtJIP5Kv1g64KW7wMetg4upwjvyuIYbHuqpJc1kP+f?=
 =?us-ascii?Q?nnTQxPmDow1e67kUxNCVFwlVpu1pf9jvRDLPW3qsYdDF5Q5AYlsUoXss7VSJ?=
 =?us-ascii?Q?tTNPUorunjHy3wBWuKhbaDETY9R1jY8ZtB9fqMeLNAgF+ago?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f78d024-0e97-4abc-3b04-08de9b03fe77
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 15:30:58.9323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ViTB2mr3DtDwPZP6IOa+yR06kIVEngsicjmqO5iLIfiqmTlxCyCIQfSJoNj5sUnEANXy64vg1j1ljJ+VWdBJ/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6681
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10183-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email,SA1PR21MB6921.namprd21.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 45064406033
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Wednesday, April 8, 2026 6:54 AM
> > > ...
> > > A slightly different approach to the whole problem is to change
> > > vmbus_reserve_fb(). If it is unable to get a non-zero "start" value, =
then
> > > it should use the same assumption as above, and reserve a frame buffe=
r
> > > area starting at the lowest address in low MMIO space. The reserved s=
ize

The framebuffer base of Gen1 VMs always starts at 4GB-128MB, even if
the low mmio base is 1GB.

> > > could be the max possible frame buffer size, which I think is 64 MiB =
(?).
> >
> > It can be 128MB with the highest resolution 7680*4320 (I hope the
> > highest resolution won't become bigger in the future).
>=20
> Indeed!
>=20
> >
> > > This still leaves low MMIO space for subsequent PCI devices, and allo=
ws
> > > 32-bit BARs to continue to work. This approach requires one further
> > > assumption, which is that the host, plus any movement by hyperv_drm,
> > > has kept the frame buffer at the low end of the low MMIO space. From
> > > what I've seen, that assumption is reality -- the frame buffer always
> > > starts at the beginning of low MMIO space.
> > >
> > > This approach could be taken one step further, where vmbus_reserve_fb=
()
> > > *always* reserves 64 MiB starting at the low end of low MMIO space,
> > > regardless of the value of "start". The messy code for getting "start=
"
> > > could be dropped entirely, and the dependency on CONFIG_SYSFB goes
> > > away. Or maybe still get the value of "start" and "size", and if non-=
zero
> > > just do a sanity check that they are within the fixed 64 MiB reserved=
 area.
> > >
> > > Thoughts? To me tweaking vmbus_reserve_fb() is a more
> > > straightforward and explicit way to do the reserving, vs. modifying
> > > the requested range in the Hyper-V PCI driver.
> >
> > Agreed. Let me try to make a new patch for review.

Please refer to my testing results and my thoughts below:


On x86-64 lab hosts, I tested Gen1 and Gen2 VMs on the latest
Hyper-V build, and on Windows Server 2019
(Hyper-V: Hypervisor Build 10.0.17763.8510-8-0), and I saw the
same host behavior on both the hosts:

1) The max required framebuffer size is determined by Set-VMVideo,
   and is reported to the guest hyperv_drm driver via
   hdev->channel->offermsg.offer.mmio_megabytes.

   1.1) For Gen1 VMs, the framebuffer's base is reported via the
        legacy PCI graphics device's BAR: the PCI BAR's base is
        hardcoded to 4G-128MB, and the size is hardcoded to 64MB,
        but the hyperv_drm driver can use a framebuffer size bigger
        than 64MB when Set-VMVideo specifies a big framebuffer.

   1.2) For Gen2 VMs, the framebuffer's base is reported via the
        UEFI firmware, and the size is hardcoded to 3MB, but the
        hyperv_drm driver can use a framebuffer size bigger than
        64MB when Set-VMVideo specifies a big framebuffer.

2) The low mmio range is affected by the PowerShell command
   "Set-VM -LowMemoryMappedIoSpace". Note: the command only accepts
   a value between 128MB and 3.5GB.

3) For Gen2 VMs, the low mmio range is also affected by another
   command "Set-VMVideo", and the framebuffer always starts at the
   beginning of the low mmio range.

   3.1) By default, both the low mmio range and the framebuffer
        start at the fixed location 4G-128MB. If the max
        framebuffer size is X MB bigger than 64MB, the
        low_mmio_base decreases by 2*X MB.

   3.2) With "Set-VM -LowMemoryMappedIoSpace 1GB", the
        low_mmio_base is 3GB, the low_mmio_size=3D1GB. The
        fb_mmio_base is also 3GB; if the max framebuffer size is
        X MB bigger than 64MB, the low_mmio_base decreases by
        2*X MB.

4) For Gen1 VMs, the framebuffer always starts at the fixed
   location 4G-128MB.

   4.1) By default, the low mmio range also starts at 4G-128MB,
        and the size is 127.75 MB, i.e. if
        hdev->channel->offermsg.offer.mmio_megabytes needs 128MB,
        the guest hyperv_drm driver can't find enough available
        mmio in the low mmio range, and has to use the high mmio
        range.

   4.2) With "Set-VM -LowMemoryMappedIoSpace 1GB", the
        low_mmio_base is 3GB, the low_mmio_size=3D1023.75 MB. The
        fb_mmio_base is still 4G-128MB, i.e. if hyperv_drm needs
        128 MB of mmio, it still has to use the high mmio range.

5) Note: the mmio range [VTPM_BASE_ADDRESS, 4GB), whose size is
   18.75MB, can not be used by the framebuffer.

To recap, according to my testing, the pseudo code of the
host/guest firmware that determine the low mmio range and the
framebuffer range should be:

max_fb_size =3D round_up_to_2MB(HorizontalResolution *
                              VerticalResolution * 4);

if (is_gen1_VM) {
    low_mmio_base =3D 4G - 128MB
    fb_mmio_base =3D 4G - 128MB
    low_mmio_size =3D 128MB - 0.25MB
} else { /* Gen2 VMs */
    low_mmio_base =3D 4G - 128MB
    low_mmio_size =3D 128MB

    excess_fb_size =3D (max_fb_size > 64MB) ?
                     (max_fb_size - 64MB) : 0;
    low_mmio_base -=3D excess_fb_size * 2;
    low_mmio_size =3D 4GB - low_mmio_base
    fb_mmio_base =3D low_mmio_base;
}

If ("Set-VM -LowMemoryMappedIoSpace" sets a target_low_mmio_size) {
    target_low_mmio_size =3D round_up_to_2MB(target_low_mmio_size)

    if (4GB - target_low_mmio_size < low_mmio_base) {
        low_mmio_base =3D 4GB - target_low_mmio_size

        if (is_gen1_VM) {
            low_mmio_size =3D target_low_mmio_size - 0.25MB
            // fb_mmio_base is still 4GB - 128MB
        } else {
            low_mmio_size =3D target_low_mmio_size
            fb_mmio_base =3D low_mmio_base;
        }
    }
}

e.g. for a Gen2 VM with the below commands:
   Set-VM -LowMemoryMappedIoSpace 128MB \
          -VMName decui-u2204-gen2-fb
   // i.e. the default setting on a lab host
   Set-VMVideo -VMName decui-u2204-gen2-fb \
               -HorizontalResolution 4834 \
               -VerticalResolution 3622 \
               -ResolutionType Single
we have:
    max_fb_size =3D round_up_to_2MB(4834*3622*4) =3D 68 MB
    excess_fb_size =3D 4MB
    low_mmio_base =3D 4GB - 128MB - 4MB * 2
                  =3D 4GB - 136 MB =3D 0xf7800000
    fb_mmio_base =3D low_mmio_base
    low_mmio_size =3D 4GB - low_mmio_base =3D 136MB

    In this case, we'd like to reserve low_mmio_size/2 =3D 68MB
    (rather than a fixed value of 128MB) for the framebuffer mmio:
    actually we can't reserve 128MB from the low mmio range,
    because the range [VTPM_BASE_ADDRESS, 4GB), whose size is
    18.75MB, is reserved for vTPM and other system devices like
    the I/O APIC, so the available low mmio size is only
    136MB - 18.75MB =3D 117.25MB.

    If we further run
    "Set-VM -LowMemoryMappedIoSpace 150MB \
     -VMName decui-u2204-gen2-fb", we have
    max_fb_size =3D round_up_to_2MB(4834*3622*4) =3D 68 MB
    excess_fb_size =3D 4MB
    low_mmio_base =3D 4GB - 128MB - 4MB * 2
                  =3D 4GB - 136 MB =3D 0xf7800000
    but 4GB - target_low_mmio_size =3D 4GB - 150MB, which is
    smaller than low_mmio_base, so low_mmio_base and
    fb_mmio_base are both set to 4GB - 150MB =3D 0xf6a00000,
    and low_mmio_size =3D 150MB. In this case, we'd like to
    reserve low_mmio_size/2 =3D 75MB for the framebuffer mmio,
    since we don't know the exact framebuffer size in
    vmbus_reserve_fb().

    With the same PowerShell commands, if the VM is a Gen1 VM,
    the low_mmio_base =3D 0xf6a00000, and
    low_mmio_size =3D 149.75MB but the fb_mmio_base is
    4GB - 128MB =3D 0xf8000000.

Another example is: for a Gen2 VM with the below commands:
   Set-VM -LowMemoryMappedIoSpace 1GB \
          -VMName decui-u2204-gen2-fb
   // i.e. the default setting on Azure. Let's ignore CVMs here.
   Set-VMVideo -VMName decui-u2204-gen2-fb \
               -HorizontalResolution 4834 \
               -VerticalResolution 3622 \
               -ResolutionType Single
we have:
    max_fb_size =3D round_up_to_2MB(4834*3622*4) =3D 68 MB
    excess_fb_size =3D 4MB
    low_mmio_base =3D 4GB - 128MB - 4MB * 2
                  =3D 4GB - 136 MB =3D 0xf7800000
    but 4GB - target_low_mmio_size =3D 4GB - 1GB, which is
    smaller than low_mmio_base, so low_mmio_base and
    fb_mmio_base are both set to 4GB - 1GB =3D 0xc0000000,
    and low_mmio_size =3D 1GB.
    In this case, we'd like to reserve
    min(low_mmio_size/2, 128MB) =3D 128MB for the framebuffer
    mmio, since the max possible framebuffer so far is 128MB.

************************************

On an ARM64 lab host, I also tested Gen2 VMs (there is no Gen1 VM
for ARM VMs):

By default:
  low_mmio_base =3D 4GB - 512MB, i.e. 0xe0000000
  low_mmio_size =3D 512MB
  fb_mmio_base =3D low_mmio_base
  The default framebuffer size is 3MB
  (i.e. screen.lfb_size =3D 3MB) but hyperv_drm:
  mmio_megabytes =3D 8 MB, which supports up to 1920 * 1080.

With the below commands:
   Set-VM -LowMemoryMappedIoSpace 512MB \
          -VMName decui-u2204-gen2-fb
   // the command only accepts a value between 512MB and 3.5GB.
   Set-VMVideo -VMName decui-u2204-gen2-fb \
               -HorizontalResolution 4834 \
               -VerticalResolution 3622 \
               -ResolutionType Single
I thought we would have:
    max_fb_size =3D round_up_to_2MB(4834*3622*4) =3D 68 MB
    excess_fb_size =3D 4MB
    low_mmio_base =3D 4GB - 512MB - 4MB * 2
                  =3D 4GB - 520MB
    fb_mmio_base =3D low_mmio_base
    low_mmio_size =3D 4GB - low_mmio_base =3D 520MB

    Since 4GB - target_low_mmio_size =3D 4GB - 512MB, which is
    smaller than low_mmio_base, so low_mmio_base and
    fb_mmio_base would be both set to 4GB - 520MB, and
    low_mmio_size would be 520MB.

    However, the actual result is:
    max_fb_size is indeed 68MB.
    but fb_mmio_base =3D low_mmio_base =3D 4GB - 512MB, and
    low_mmio_size =3D 512MB, i.e. the 'excess_fb_size' is not
    considered on ARM64!

    In this case, we'd like to reserve
    min(low_mmio_size/2, 128MB) =3D 128MB for the framebuffer
    mmio, since the max possible framebuffer so far is 128MB.

With the below command:
   Set-VM -LowMemoryMappedIoSpace 3GB \
          -VMName decui-u2204-gen2-fb
   // i.e. the default setting on Azure. Unlike x86-64, an ARM64
   // VM on Azure has 3GB of mmio below 4GB.
   Set-VMVideo -VMName decui-u2204-gen2-fb \
               -HorizontalResolution 4834 \
               -VerticalResolution 3622 \
               -ResolutionType Single
we have:
    max_fb_size =3D round_up_to_2MB(4834*3622*4) =3D 68 MB
    low_mmio_base =3D 4GB - 3GB =3D 1GB =3D 0x40000000
    low_mmio_size =3D 3GB
    fb_mmio_base =3D low_mmio_base =3D 1GB

    In this case, we'd like to reserve
    min(low_mmio_size/2, 128MB) =3D 128MB for the framebuffer
    mmio, since the max possible framebuffer so far is 128MB.

************************************

To recap, I think the bottom line is:

a) For Gen2 VMs, we can safely reserve a mmio range starting at
   sysfb_primary_display.screen.lfb_base with a size of
   min(low_mmio_size/2, 128MB).

   If sysfb_primary_display.screen.lfb_base is 0, i.e. in the case
   of kdump kernel, we use low_mmio_base instead.
   This should fix the mmio conflict in the kdump kernel.

b) For Gen1 VMs, let's still only reserve a mmio range starting at
   4GB - 128MB with a size of 64MB, because when we are in
   vmbus_reserve_fb(), we still don't know the exact size of the
   max_fb_size, and we don't want to reserve too much as we would
   want to reserve some low mmio space for PCI devices with 32-bit
   BARs (if any).

   If the user runs Set-VMVideo and needs a framebuffer size
   bigger than 64MB (IMO this is not a typical scenario in
   practice), we have to use high mmio for hyperv_drm in the first
   kernel, and the kdump kernel still suffers from the mmio
   conflict between hyperv_drm and hv_pci. We encourage Gen1 VM
   users to upgrade to Gen2 VMs to resolve the issue. Anyway, the
   mmio conflict is inevitable for Gen1 VMs, if the max required
   framebuffer size is bigger than 108MB (Note:
   128MB - VTPM_BASE_ADDRESS =3D 109.25, and the required framebuffer
   size is always rounded up to 2MB).

c) CVMs don't have the framebuffer device, so we don't need to reserve
    any mmio in vmbus_reserve_fb() for them.

Thanks for reading through this long email!

I'm making a patch right now...

Thanks,
Dexuan

