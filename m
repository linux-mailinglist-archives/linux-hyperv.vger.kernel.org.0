Return-Path: <linux-hyperv+bounces-11798-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QHtfNfjmRWoQGgsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11798-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 06:20:08 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE936F3674
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 06:20:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b=UwddPTor;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11798-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11798-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microsoft.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 882F9301E588
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2026 04:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE91352003;
	Thu,  2 Jul 2026 04:20:05 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020098.outbound.protection.outlook.com [52.101.61.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E11B3D994;
	Thu,  2 Jul 2026 04:20:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782966005; cv=fail; b=laY+k99RVcHSV6RaUeR0TaYgDxFRx7etx/X3wVN7kGoyrD2pOLJGjHSxHZEImfHBPtEmafV+zHl0ipm529mRVDLTFVUWGrPhlU85B2C2HPx3br5F4FkvaPyT8aEhBpZk+DET9JfEtjbAUVA9hepNyTgDLMy8xZAnovekiXwlZdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782966005; c=relaxed/simple;
	bh=DgYxpxUpFGN1NtgoB5TVMql4UYnLdzbHzG3a4vBXHA8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fk+3nvL0lNEW6aMcN7oWJuzMzWocMJZnSKwd6vJnR0D3BtQ9w23oEggoU8P++kG6QBTzBDvvaVZ3tRBrTNmueoYbEWzZ9b/2XwLCJJiOs9ofkGP/oCek5z4PIfdRtsBaZVhvledjR4gsmYjTi0HjEWAcFtRajPvBgh6sNT1DC8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=UwddPTor; arc=fail smtp.client-ip=52.101.61.98
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1ICIOWsOQkzf+gP2ZJw8L2x12b5zMwvMGanFqgtHxYmtkgVwoKyGGvYuL14utD/PkYXOzuGPaKL+FZbQjqnNL747W11kAMcDNSA7hNB0XV1s76TTfZIQElsC2/iad2KnCZXNQNT8dhD/8vBujApNfGtRV51dl6/QZMONeLePVxYA9aQMloQMIwBeFqxZmzMJk7+ApC0smBCSXJI2y530JDBx3jnd9IsVFe758gKqrKYEXd7v7g+NNm4Ra25w9uG2X1PK6KtN7hgrE7pnTfS5Fh/k1lw/dCGWBoMhi+aWpkNrZaRpmNidJVqermPs2ejFqH5j30r4+sCP38DcLFejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ICWdWkJ8I1U6Wi+zSt7blYlzwa23vqVdqDOjNwjdJ8=;
 b=ueuhBK3MyHj0ruI/eAs60KfunNRZhN2HxYWJtWqpm1b/fro9Dp73g5jijECjpIBd1Mju1WVWfDYulpbAkzkNCT669vWXCthwLGl/SYHBJa7FToACXL7L/i8yZF6O5XKMz+hIuEfjWITMNYCm1MKEU46QQmZWIo+cLxRpVw1lolowj/31ZQ2kYe0CGzfxqPLUS4vrC21IGUPqVFINeI9PjeDV+uiWbGQg2vd0DkJdmoLxsIsrb/Fo2IMt1ZCCb3rE0dHpDqH+pOkWiB7ZMJ5Dwn/pZtGlZNM5AlQAlqZN6SvBH8QDkLIfcCtOA5thfcN9AKrblNE0zTFW0XueBNDzeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ICWdWkJ8I1U6Wi+zSt7blYlzwa23vqVdqDOjNwjdJ8=;
 b=UwddPTor2qTdQmjWSvmYksesbLsCXowZ7+kDMxWV8NZzFqXZBLtiBUnwfkk/HnwSVpW7+R/rTtukkxTftpLbXpNPWHYr1meS+qHWwCZ1dw647ksvp+9N53CPj6iR5VbslkYo+GbCyO00ff3oEWplwuiY8kMqLJKlt1wsxDz3U/s=
Received: from DS4PR21MB6914.namprd21.prod.outlook.com (2603:10b6:8:2e5::9) by
 DS2PR21MB5421.namprd21.prod.outlook.com (2603:10b6:8:2be::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Thu, 2 Jul 2026 04:20:01 +0000
Received: from DS4PR21MB6914.namprd21.prod.outlook.com
 ([fe80::ef10:ddaf:4d07:7646]) by DS4PR21MB6914.namprd21.prod.outlook.com
 ([fe80::ef10:ddaf:4d07:7646%7]) with mapi id 15.21.0181.003; Thu, 2 Jul 2026
 04:20:00 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Simon Horman <horms@kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>, "ernis@linux.microsoft.com"
	<ernis@linux.microsoft.com>, "dipayanroy@linux.microsoft.com"
	<dipayanroy@linux.microsoft.com>, "kees@kernel.org" <kees@kernel.org>,
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net v2 1/2] net: mana: Sync page pool RX
 frags for CPU
Thread-Topic: [EXTERNAL] Re: [PATCH net v2 1/2] net: mana: Sync page pool RX
 frags for CPU
Thread-Index: AQHdBXszlekRpvGA7EWrwr4Rp+B2XbZZp81A
Date: Thu, 2 Jul 2026 04:20:00 +0000
Message-ID:
 <DS4PR21MB6914067E6C2D2798E6C20185BFF52@DS4PR21MB6914.namprd21.prod.outlook.com>
References: <20260624222605.1794719-1-decui@microsoft.com>
 <20260624222605.1794719-2-decui@microsoft.com>
 <20260626145048.GB1310988@horms.kernel.org>
In-Reply-To: <20260626145048.GB1310988@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0941ec5c-fee4-48ba-827a-4bb657f25ddc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-07-02T04:15:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PR21MB6914:EE_|DS2PR21MB5421:EE_
x-ms-office365-filtering-correlation-id: 60a14cac-3d0b-48c9-495e-08ded7f12edf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|22082099003|18002099003|56012099006|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info:
 yMj1xARC5d8oZ98ZgH0GMlOQeJHlI6AuoYmmFo1oRLMUMLtw8cM1v4EIRiPInbwWITrLXYRXBBN9vMwENzCp13g/1vme76vRvN4QUxooOgPKztPXCAB2pU2eMLkHMynx+Mv7Kw4JttT7OCbuOSGfDkvQ05Bi3jNiuOd4WVKLj5V5sthPBGekQo9qy5taVZL6ZKkzgAYr5uChRo8TOx3qeF4tw15rzmmKvcW0UcKttV+yQj4gO9WYna9dlddLeG9egQdNV+yLmPvrXQuxmGqLu4V7C3LbL3CxKvJmEq670OAKfltsDP6jwVb2YaTHfeTBXhOZXcIYi6e/t3shL7IR+dyU/8Wk3KnYaXPi/46DxzR/lkU1cr+9v/4iEuIi7yJ0RV5YAIqjFNRJIC9uMd5EyZuWpK8i+mY6ZxEk8oOPZEY+Qg6dhcp4GrY+CtN4SafDhylEobMxjyyeXSrxrlWUzBQnwjHTFNEcSns5cD94bWoclTNZDwKcqlJH3iWAXgj0YFcc0+FqO3gSoiuZekE+j4YWQZ/xdw1zog08OlAfJuAv1N6QcdqAOOV4KAdv/r3BLEfrW3dm9gMSVhmWs/gl13RYqY/VeIVupYYlcs+3LxXfiooGXZL74GzaNmUyylIYcgbH52M2DJ7WP3SZPN60aPd6sFxO/jK8S8eW+NDzUmshLp+RQ1PQMn9y882OFduHw+VaDF3jh3KBDY4Ndcp6WcMxgYR5fGV/Y8zAhnYwUek=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR21MB6914.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OmD7ValVRGuPwYYNMfm/L0u/11UM3znRwX0m+5BxPPiBcpO8zXl8U5w71G2c?=
 =?us-ascii?Q?K26fTBV4WvAUs36p+IrbAG4xqRBTwoeSISoS4NYTzVL4AqAXR2/vjsUrw7Tp?=
 =?us-ascii?Q?oM52ppKwpd92dtyJWU5CDjvAPuxNfRIjmGgMegcxyKPpMDrLqf82nGkUJRxU?=
 =?us-ascii?Q?uI6YHjndy6O6IEZtEu2uvlSM/WW2KRf/fvbEnKOY9Wxuj0tvqoLoz9kmZN6d?=
 =?us-ascii?Q?5fMuLdB7oTBXkgxxX/25EA91SOW8u/WVoyVQf5+jzF9j89n7B4FiMfae8L2f?=
 =?us-ascii?Q?vDVuCFOhPyIeWLN8vNzZ7ena+r9bqoW91W7zu6fqL+5FPdGw1RSIxKfIGpDX?=
 =?us-ascii?Q?rmKQf8YYnPEoBXyy0LIkhzAm910oUTCB6i87fQ0ejXILBsB35LcEAyyAwiMA?=
 =?us-ascii?Q?qXC6s6BIC9QPAkjNM9Ev7Q9iAUKlVfaEp7jg0tvFdiudU0LTPVyVvL3X4TgK?=
 =?us-ascii?Q?QQUTsb2bUWCpqb53m9vI2P+0tGnL9vm5qmQlIGT78rT8+ZSgL+PIgS0rlbMx?=
 =?us-ascii?Q?s29ieqGHQC5iwAL2ch9D6uFoQDWPEXiIVyZ21xgb4Zkw86H9ejeHdN0DcESj?=
 =?us-ascii?Q?qnf2z2487Ez/1jjGPBFO/B3TM2Htfcu3xL+5UU1OhLELLpFgggpXsIBwBcO8?=
 =?us-ascii?Q?0CUXODFjvQtMjmBPm/6g9ZRyyE1QiIjW41vRyhudxSM/htr9FQMSZU0AGXO8?=
 =?us-ascii?Q?ALyV6XuNlBHR2Ov/+1M9kI/6yzV9hb7X6Z4/qTdkVn27htxUy1RCPGmDTN8g?=
 =?us-ascii?Q?xVKIGfXC1af2jnf6zCbuxHhw8oWY7/6ckBEwTiW7BwlcxZhu5B/8FZq0RmzH?=
 =?us-ascii?Q?xIB6FlJ6CJ9acyw8DKQqAtDC6B6XLc1kBzLvjWOMsZFovnMFPoR5TjrCrRHu?=
 =?us-ascii?Q?GlLVGHq6fpZfHRv+IhI54Hdmsg7PvU/6OrI1KBiAdJFyscubveY/Xcx387cK?=
 =?us-ascii?Q?pqsWyCTPtlmo294QAyyrCazmob0SQffuRtgpxRSAE3SKnQJgXlqrM5jgYI8Z?=
 =?us-ascii?Q?HjkAnxqwD+q9GMsUGn9tgoNj9X+deZWNBCFlvDGytUrOyrKaiL7XxWHRQU05?=
 =?us-ascii?Q?AP7da+wftJ8fk5+mQ34SHW6BeEd2NF8Ik1T4HbrU5LmBJRsFGNqA++iFjNRo?=
 =?us-ascii?Q?OdKtWR5I65u2BKzpAL5hHvDlzBIBd40vb5c5ysv+vq83qg06tlUoLWHux/dp?=
 =?us-ascii?Q?cghxHMh4YvdsCAIlDacAkuD9nmwabzmOTZS3ICP2lJ71PFgef41CjsudNnGD?=
 =?us-ascii?Q?qDwp1GpR+8HRi0G9SgpK8V8lmB/Au4mQcejTuLVuMO8TEatHZQB6sN4Rp+a+?=
 =?us-ascii?Q?8Cc8GMLaaBTU24Pp3rg4QGCNxNR1Mgn0s2Z+vvRBeWd9wa3IKajnDbxUMZ7o?=
 =?us-ascii?Q?DSEwRgvRmo8IRHkExTbm9LzICvPhU48ea7iapNawHAWyP6Dt/FSiSGsr3Rku?=
 =?us-ascii?Q?4eLY2eOPAR+A7htlJRraqABmT2wP10UQG5sNp7y5CEuzi0Q8xZ4a9fkvjWHs?=
 =?us-ascii?Q?btJWathJH6SZksgPce9xwE93RLWgikWUpgdlWOBXavmeUDbvLevxl36JjMpv?=
 =?us-ascii?Q?ZB3AEWJpG+CpcP0SsoS8oXu24l25Me/HcjOVFwceA55Q2qFpbmg6vNQItqNS?=
 =?us-ascii?Q?JkXLB0K7T8L/BtjnU3dLhoUauGDTa8QSNmJcps5oUt/LrM2Jtjpl3ODqUmLp?=
 =?us-ascii?Q?aW7mY6iqqd34EQ0yuWOzgW//ERss6gTx9xuca3rP1FyRsC1m?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS4PR21MB6914.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a14cac-3d0b-48c9-495e-08ded7f12edf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 04:20:00.6577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wiq1xwLt7UzJvrw6USsmvEIdkl1WFeW5DUX9UgDjWr6Wb0F8OiEXwcOBANxWsgbN+pQp5MkXspiiXFXkDQ15/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR21MB5421
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11798-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:kees@kernel.org,m:jacob.e.keller@intel.com,m:ssengar@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[DS4PR21MB6914.namprd21.prod.outlook.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DE936F3674

> From: Simon Horman <horms@kernel.org>
> Sent: Friday, June 26, 2026 7:51 AM
>  ...
> Hi,
>=20
> I'm sorry to be bothersome but I think that the order of the two patches
> that comprise this series should be reversed. Or if that is not possible,
> go back to a single patch.

Hi Simon,
Thanks for suggesting swapping the order of the 2 patches in v2!=20
Totally makes sense.=20

Please review v3 I just posted:
https://lore.kernel.org/netdev/20260702041237.617719-1-decui@microsoft.com/

Thanks,
Dexuan

