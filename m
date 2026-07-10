Return-Path: <linux-hyperv+bounces-11915-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id //3pIf1FUWq1BgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11915-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 21:20:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F9173DAD0
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 21:20:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b=R5wnscnf;
	dmarc=pass (policy=reject) header.from=microsoft.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11915-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11915-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B3EC303609D
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 19:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38230380FC0;
	Fri, 10 Jul 2026 19:20:01 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022095.outbound.protection.outlook.com [40.107.200.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FE21624C5;
	Fri, 10 Jul 2026 19:19:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711201; cv=fail; b=KvPx2UWmF0GSFJt3qUORtSBD2HDzL+tVa+qZ/Pm3gYd7M3i0QnflX04eHympYs0z36/c02K4yda4mkKtjvIxNHB+FpZzdouYYyDi47wgvM2uSq+IPNKbiRRWnn7drgUdYeuiIPy22j3pRGo/5MfZ0NWg0MqIRYzhlHdl/UqUakE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711201; c=relaxed/simple;
	bh=zYEjGsOJxqsvMbKbre0f4kcNsCF0kqyc9MLiZSJrZJs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T4ceMae8dfsCMuw9ycBx5n8NUpX3hHFlKGO6Un0y+hf6+oaJ22zfEopw9ys2W3I9+yui+yAMwKnU/cX6Iqfq1B6z404Gsn4iHzJBG4Zr3y66jDJXojoJ0Ri7c+nwK8RsCY74oxqfT4BxbGhhPUlocZMktDisalopHAnoYH9yCmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=R5wnscnf; arc=fail smtp.client-ip=40.107.200.95
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ub0oQrgDE/IkNn5xzXphLK+217s6vz7tx5x2Cvk0Bb1CrpZ9OKFo4bg46O33dxiSyDU+8g+yceSBN4d4TGs4hi0DvmAMY4vzHrwuFIAYZfSdPf9ltkZ7LDAeXKWizQE6cXMJRkGZosWgfgZdnHALbAhas1bi0Oe2JtjgeHG4iuOSSN0Jwn76woLHIn8pqaAwNxEYClvoN05WoJXzSKEuin6zlbcxVZp05Dav0HeLmWeyjv22u+q2Ai/beqYi8EZkKPc+IhA3s1722eK59RHSCmF6s3hgCiUDnql5wjFZyfBwVI4fQVLjCeEqM8vd/OqqqdCJg6IedXFPNfWTZZyjjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rB3YJ3Zb7szqayxOxbE0zWMSxVrsiYEi/2OPFWi7jEw=;
 b=RI5ViXkvHD/d35Q7VFT0RhMjHtFPyTvictDMk5ceb40zQ33y0h9waMO58g0rQbG0E7bHoQV/v0ngepw1n0Y0aui0RS1JYTi26iBW876UrFahpWGFexQ95Na2+G1J0MgiQk0Kiq3hXxYgW46jOliye0kThgaxKMNkTXe6lPtnNIGprArEeXowUCDH41eYAnfct3YL+kRAuavrO7JgKnWGKP3W7q6IyXjhaS7qAp0Beg1/jI4cPmqKVCOotZ2tX6CIJ6cuusM2Ucyv6wY5RpP1OKQvt3cq6QtAcJMcY+xB8+gx8NcrIMVb4m+UxaBPa1yQhJjGEfhyqrqV04odP/MLdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rB3YJ3Zb7szqayxOxbE0zWMSxVrsiYEi/2OPFWi7jEw=;
 b=R5wnscnfU/EsLfDoF6g72Cz1gt+0npdqDi7EFcWY68XvTRUrbmVlmjKVlKpkXNRl5UZ6yuMBW6/F/js+JaFb/pqz4fWV0CO+gHCbYwVOih94fImP88GAmTrOldqfHvNCmNwM09KTP5ERRaHews1pq2w3Fe4kmPuaT0Q8h1SgJMQ=
Received: from LV5PR21MB4704.namprd21.prod.outlook.com (2603:10b6:408:307::7)
 by LV2PR21MB6160.namprd21.prod.outlook.com (2603:10b6:408:34d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.8; Fri, 10 Jul
 2026 19:19:56 +0000
Received: from LV5PR21MB4704.namprd21.prod.outlook.com
 ([fe80::144b:98da:1262:2ebb]) by LV5PR21MB4704.namprd21.prod.outlook.com
 ([fe80::144b:98da:1262:2ebb%6]) with mapi id 15.21.0223.005; Fri, 10 Jul 2026
 19:19:56 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, Long Li <longli@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>, Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [PATCH net-next v3] net: mana: Add handler for sriov configure
Thread-Topic: [PATCH net-next v3] net: mana: Add handler for sriov configure
Thread-Index: AQHdDxzRuwpAv3AkSEm3Nb+ln6fZ8LZnItnA
Date: Fri, 10 Jul 2026 19:19:56 +0000
Message-ID:
 <LV5PR21MB470461A0C1153760D4C14645CAFD2@LV5PR21MB4704.namprd21.prod.outlook.com>
References: <20260708205924.2408673-1-haiyangz@linux.microsoft.com>
In-Reply-To: <20260708205924.2408673-1-haiyangz@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4887e6d9-7f0e-4329-ad3e-5d18e8fa4bcb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-07-10T19:15:58Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV5PR21MB4704:EE_|LV2PR21MB6160:EE_
x-ms-office365-filtering-correlation-id: 2c46991c-f255-473b-0a12-08dedeb83a57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|7053199004|38070700021|921020|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 jwAnouHZ31dge/PJm5K1k3XP7KGESTnfM1ETjQKi7WU+E0t7PXX72QHdbdDRaZGGTq5j+VXe5TzZ/XxUETIOc3c3yA9J9nFc3b6tiVOUfwmcP6fXAl6f7C8qQR2KhZok4eIyIpDz9y1Km1+v62YUvLIUJYS7boV0ujWINQaOU5C+h/wfoaFvTueVKoMm2HlJUV3EvOYf5gmH6TGsQUI2DAUERGbWPO+6IgeZJKrvRipRYF6vUnEKfAwkonhob/KWIZZnVZ6xY74ybX7vuTAGLnDTjZBvA/rdzxLGsG18ScMy5b5GDDEJtOcVcJadBVbCTbS4/DYqmnryVM7vACqLvPrynw3/Ji3VS+4UC9tKi6Rbhs8zv5smTYpf8bv9//DjV2Wiu4ZDlxNRoZdq1UjELHO+ccUFcEbFhMEwDngrr3xdUJ4hu3hmDSBgpOWUjL9vj2+WZYhWbh3lTWhwAQOZT2F4KB8KTv+y5qD68ctDSNGdqSm3Uo7TObvp6X9dTE8Vff6YouL12HNDsCDpuncvRKCyIvBj/pkhLdULjftLV2IREIIzxHm+oRf7uI5xNQeo3nLS0/DyVp2aOfDZY4rh0R9lbSIMXL7HJ0K/lCg4Ukt+TNWAbgtNay/9guQqf0xuXuckl4swlweKV7a53eGTo5FJBrhhWireW9QAdrKfLM+zjTZ3Ym5Dqba+tsBpm/ANe9wrQbcdATwG6z6exXncABKEPMSGKjCGHhPe4Tl3IgtIYeOLqS1ybUFt3QjQW3y9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR21MB4704.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(7053199004)(38070700021)(921020)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XP99cptgBGIpkIKH7sK2EpnYNmr5YwjoWVm56xEZy0cIcwczj3R+OEJ1lVyS?=
 =?us-ascii?Q?khAq2PBkaNVYGyiMKzm4lJwei6TOYZYLGJbXBcaUVPmFHXzwUl6mLHsDtnjr?=
 =?us-ascii?Q?iwlG+E1byw+4eTC6ODANWyNCrwcFmp8d2Vlwdg15BIKWRhtqfgFW6uBXVOnh?=
 =?us-ascii?Q?PhqAnrQOY+vzJI15Bk89RKyZ+YlWHgh86MODtbdEabZA1SsbfQ17nY897v5h?=
 =?us-ascii?Q?01h4rXJr3KRG34cqzWWjnxpI86mziDlNIDQpfgMHxZsGKCvKKj7aFd22z/qx?=
 =?us-ascii?Q?EjAzfexPDCCUp/beIf4f2ZAOZV9HXfu887pEvLQ0QI0KEhAP+/H5zO7b7Ynk?=
 =?us-ascii?Q?yMZDm5nEtt04I1Z+WlliLSAvAXuVotwBtTHckIdeEZqqWHuX25LUtlLaSXvb?=
 =?us-ascii?Q?m78+H/GzFp0psPYu4rrIx/uimRmxxYftVAtQxh49Q8l4YlAge+3SAySNAqtt?=
 =?us-ascii?Q?eDVyJsrjnbVwTLzwbMGkoiw5R2iIc7rvYCC5oBzWUih0BnAsWVQgYzBJc1+t?=
 =?us-ascii?Q?1S4kU64X5QDb86vGx8kFwITnqheh+WdVFW9LYMe3pIrF+Co9pyhUeihQG+x+?=
 =?us-ascii?Q?sYHNLVog0mBos3wXjvQgJmZu5HZBE0hZvwk2qLETT7vn8ALBoMUB08XY1w+c?=
 =?us-ascii?Q?df6DxcDpXVbyH2MBZ4+GpQk7FkTZPUBI6sf5s6XUrUAo6lBenhvFoxW9PYGf?=
 =?us-ascii?Q?R/kRCXdGC0yi/f//2f9hbWRynf9d8QyUmz6xaIEj+CF0mpKAEsihspzI/m0l?=
 =?us-ascii?Q?rffc6aPqgmPi23daClWqmCKsslSvlbpk7LVTSxaWapZblMtQiDAKXJyQnnZj?=
 =?us-ascii?Q?Rzc98rP3qGXvtl3jKPuVmKIQoMOhufrOjCyrWs7Dgye3pMNW9ZkVUPw33qUD?=
 =?us-ascii?Q?NgD4djXV5Uqdxp+UFr98RfOfW6rms0/q7WmXvXEjywhhYGupJcWVjfF7Gtmn?=
 =?us-ascii?Q?gPMO+4FwpTjENZRc3fuQSoUkpPNz3bstqyryI4gN5HM0QWBp0+4RdBOZRpzL?=
 =?us-ascii?Q?TsiVmSu+uLZ3waFwoRiVFDD00cDCmGLDa2xwUIygkzJILBFLDmURyIK9Glsj?=
 =?us-ascii?Q?88iN0KPW/U6E/UfMhov83aCKD2mvo6hq0tdSMSWetv0M/q05h8QNghp+k+fF?=
 =?us-ascii?Q?zsTi+ENOH6WtyBsbtVfbuM/zUGfWOXACVhwnQD5PlBBsyJzHPoOhjsY33BLJ?=
 =?us-ascii?Q?qu8B+7xTzwxFu+H1Qia5gyyZZK6XMAhVYHgrrkStG+lQLgggmmfCcZGFwukq?=
 =?us-ascii?Q?ltx/7tORlKPz7zBCQA/K6a68w/aDVLOmtVEmUN24UZx+kOZLEpq09t8tUOZE?=
 =?us-ascii?Q?eoEdLzvCnHK0AmfWAxfQwFlFCpJ0y+bSpPybEubuCIe6XfrXgqQY6nsb0w/h?=
 =?us-ascii?Q?FIUEpVqY7pOhtWzxNoQ0bFAB8Q0lPzpGScpF6RYvpv1wR0Fbu3i2lWT4wKdp?=
 =?us-ascii?Q?wxarFDs50Hfb+yT8+VCEVRp7NVryVxkwIx5fGwwSxqhNtGDx4Dua+iKh6wZO?=
 =?us-ascii?Q?F30zLsCuPivycSQyWFEr36yaiudvS5EP6IbRN7v3xAiCn9YuvnBAPDFfsYAL?=
 =?us-ascii?Q?CsA1vXl+cSIJUCMiIhL/5iqT71XdyZuBf2RpLcYi1OgNc6O65jdZPYha6MpN?=
 =?us-ascii?Q?ec4jBfcgzBPTH5RuQQE6/yzAKb+BQeJP7v+GeLCYO6g1AW7McrVcwYgL2I66?=
 =?us-ascii?Q?0P1XLP67NZFih3N1U26IMasvynu+TNWuXwHqnzF6oPZvGxix/r3dAXb3vtMC?=
 =?us-ascii?Q?GTUxOn0stA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV5PR21MB4704.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c46991c-f255-473b-0a12-08dedeb83a57
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 19:19:56.6664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ppyOQ+boyCPgbGPMEzwEw9SOLnviNcDBp09Op/rAmc1a3qFZaUmV1A8PjJXLRzPFGXFjgPLa2G3jtvuqdh5kRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB6160
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11915-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:haiyangz@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:kys@microsoft.com,m:wei.liu@kernel.org,m:DECUI@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:gargaditya@linux.microsoft.com,m:shradhagupta@linux.microsoft.com,m:linux-kernel@vger.kernel.org,m:paulros@microsoft.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09F9173DAD0



> -----Original Message-----
> From: Haiyang Zhang <haiyangz@linux.microsoft.com>
> Sent: Wednesday, July 8, 2026 4:59 PM
> To: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu
> <wei.liu@kernel.org>; Dexuan Cui <DECUI@microsoft.com>; Long Li
> <longli@microsoft.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Simon Horman
> <horms@kernel.org>; Erni Sri Satya Vennela <ernis@linux.microsoft.com>;
> Dipayaan Roy <dipayanroy@linux.microsoft.com>; Aditya Garg
> <gargaditya@linux.microsoft.com>; Shradha Gupta
> <shradhagupta@linux.microsoft.com>; linux-kernel@vger.kernel.org
> Cc: Paul Rosswurm <paulros@microsoft.com>
> Subject: [PATCH net-next v3] net: mana: Add handler for sriov configure
>=20
> From: Haiyang Zhang <haiyangz@microsoft.com>
>=20
> Add callback function for the pci_driver / sriov_configure.
>=20
> It asks the NIC to provide certain number of VFs, or disable
> VFs if the request is zero.
>=20
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> v3:
>   Updated sriov disabling paths suggested by Paolo Abeni
>=20
> v2:
>   No longer change VF autoprobe as discussed with Leon Romanovsky and
> Bjorn Helgaas.
>=20
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index aef3b77229c1..80a9118a90bc 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -2456,6 +2456,8 @@ static void mana_gd_remove(struct pci_dev *pdev)
>  {
>  	struct gdma_context *gc =3D pci_get_drvdata(pdev);
>=20
> +	pci_disable_sriov(pdev);
> +
>  	mana_rdma_remove(&gc->mana_ib);
>  	mana_remove(&gc->mana, false);
>=20
> @@ -2517,6 +2519,8 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
>=20
>  	dev_info(&pdev->dev, "Shutdown was called\n");
>=20
> +	pci_disable_sriov(pdev);
> +

I will remove this unnecessary pci_disable_sriov() as found by AI review,
and submit an updated patch.

- Haiyang


