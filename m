Return-Path: <linux-hyperv+bounces-11502-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RZO6MmQfImraSgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11502-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Jun 2026 02:59:16 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 429666442F9
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Jun 2026 02:59:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b=cqHSyYkQ;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11502-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11502-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microsoft.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C334D3044960
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jun 2026 00:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDA72E54D3;
	Fri,  5 Jun 2026 00:58:53 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020115.outbound.protection.outlook.com [52.101.85.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18D32459CF;
	Fri,  5 Jun 2026 00:58:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780621133; cv=fail; b=QVPDQVjt8ywwPmxXC2l6O/qmCzsTT+IIRqwug0hzd4jyF9pEG7LCuIeSUf8hlKseWGbH1bXPMRDxBEQRnSvSMSTaWDGVJ+RXWTFE28/HxTrPCCIVghBEvLXiGjjZ7C3bY4HAjhXaZpVHH1JzvFD2Xn877u9AzcSxc9jRQgU2nIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780621133; c=relaxed/simple;
	bh=cfB9lZJ1Op9bYgW4LmAQig8m9MT6YTrNyjg7GnVNkCg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MgUscZ7T6N+p+GJnM7gH8CSj4F2DaQQLdswVHj9KPlPJEow/e42qWpnG7hlpp/6AkdINwWtUHueiv+amCdWmtgBxjYaDUbE5FFOV7lIfe0LDt8JpUm8HC5692o9WRSZld9SX6MUNY89xUFMRdGft84aQK8UEqqr166RJ0N0AiPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=cqHSyYkQ; arc=fail smtp.client-ip=52.101.85.115
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+h/vzfc6Hql1utYymCG11n6Kzf23qnffJn34k/Fxj01DDn3YIT9N7ne+LlnPxzP2+O2Yn+avPQjE6zmIE0xQBpINwHZNJRAnCHqIJMgPaum4Kk+t6bbD+3ned/zjizg2fLzPQMkyk+jhu0UFMXqzDh/q5tq8Y2tc3eCAmmkNs++Ahs5Jfi0tpDSzhOMX4Sur1YAk+1+3c1dpbcilfP092C8yHdreSG5+H0dphdtAs39lZl/c8pDDwdBfLoH+k8PJqlhW74uu2N5cPjRJnd2MZcwupRK0zyrCYBcOYzRkHrpKrW3libtRiJDZ+Cul4aAe8rMwbvslSAs64eJcrCQuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5AVXGJBVq8R4Kqqhzgy31bBZsQhNuvSXvU12qBL9zE=;
 b=yfHXiBggG9teMpDrf083V/bKlJY7ThxwEFxI10HSb0gcuW+EfkcGXbYpXUX3LDx2Igi0vT34G2w68scM7zfFRY+j25BH8vjet38sykpAcrNb4xMKLfr3yGneRBByuIFP7wNLNct6SmsEEkFDBEMeLnP7jeQRVYtRW4+NXHGgU6JoFxAdzfTWZ84JB+Ab4TePtI9KAlLlXMEKVTdLdKVqyE4uwCuaYQ6f7T7pOkcQTZPm218OvIq+3XASlvcI4190sp7zdtgG0Gbpuqa8cs4S4wHBTOnnKmxdonen9aN4QGBpoQutiYN+KOLkVDBBKF6GO3EMw7PLYZcTaodzYnW2zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5AVXGJBVq8R4Kqqhzgy31bBZsQhNuvSXvU12qBL9zE=;
 b=cqHSyYkQYMgDKaetwkn5Kj+oSD9w2wdcdRYxv3kAhMLjx5S7QsG52pZPT2mKv0/sAkXQIQ13cYnwYu5ur7J5VkKHm7v+ZiQTe/1qLRanyQK/Jm0+dg9MCvZzMVJSu4xrir0uQvAyz43Tc6DVm8OV8yITupIzHlWdzjKW+J9KZ/k=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6080.namprd21.prod.outlook.com (2603:10b6:806:4af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.3; Fri, 5 Jun 2026
 00:58:40 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%3]) with mapi id 15.21.0113.000; Fri, 5 Jun 2026
 00:58:40 +0000
From: Long Li <longli@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Konstantin Taranov <kotaranov@microsoft.com>, "David S . Miller"
	<davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Jason Gunthorpe
	<jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>, Simon
 Horman <horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v11 0/6] net: mana: Per-vPort EQ
 and MSI-X management
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v11 0/6] net: mana: Per-vPort EQ
 and MSI-X management
Thread-Index: AQHc6lhTyIkZh41VFEGbRGEZk/VnV7YivmWAgAFG0OCAB+hzAIAAH5aAgAMqyNA=
Date: Fri, 5 Jun 2026 00:58:40 +0000
Message-ID:
 <SA1PR21MB6683B6E7F5A29C68B00FC01CCE112@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260523020258.1107742-1-longli@microsoft.com>
	<20260527192735.34a794cf@kernel.org>
	<SA1PR21MB6683A7B2415BEAF17BD0EB4ECE092@SA1PR21MB6683.namprd21.prod.outlook.com>
	<SA1PR21MB6683230E973519C12E2AB797CE122@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260602173607.34063034@kernel.org>
In-Reply-To: <20260602173607.34063034@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=25e9a4e3-4eec-45b8-ba90-3b289d9e0e9e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-05T00:58:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6080:EE_
x-ms-office365-filtering-correlation-id: ab0ce05a-44fc-4bd4-db31-08dec29d953c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700021|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info:
 /2AT2gj72E/vFqJ6b6aRw8NqZ9OWDCCwt8MH1ISRgjA1/axjzrjgTWJaremYyOSCK3da6eoW20vao/3nzkQcweZtYhg9IbSySYZSv+KcMrkkS4AZPlrQi7MOypiaP97QJoe6PSVHzbPLlalRXgM1irmO/pPC/fr7iQ6akiu2WDPPtAkiDB8xtBOnZxyJze7EF0xqdqr0VkowmvxCK2o3rDYLc5fH+LTe7eZkOUu15mSxvJlfCIzUIpRmfq4D58JbJ60Eomgi351ZGiPf0V35yrxnWrfAP2JW960axi/xSOgT80l9Mc4IG++Kf7511y8ycLSLgh3kCB8LAfCNz0aqd5I46sjb+t7PIlaQThdcNRmfMbysSlh9D8j/qfJvpblX5512fHk7eMOrSK2yDBohdCOFj8miqBF7s433E/aOAhhKXKctT+XRbUMC8S+kxx8vS9pfqNseExOKYvcZTpJbapr5OQbaGjL8jqmKXhAUwQbtfiVv8E4Trq3uY1H6H83tPsdK5D7ixsMHWCm4cQ6GLvUS4IDHDZkrzTLPFK+4FVvAI9enNTK2zc6O8TmA5K6tyEpOI0AVOAcvao9PUtXdhqeJEQUYjHZQx3kkBByBbGrOfkD1C1/pilDDgl6KlbX1C6Lq2hK82owoFaUM/CvGXiy9PH7duUFGE0QbjxpfGcGMEa/UOEOIYDfxWQkfZW2jtPLRI4th5uB5+e1qgIpMXS3/1iUNpDEcI7Uk0bneBkG6dXdjspiy3H6ubL/BpuzK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700021)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?25Q2GLWm8Db3XZR7kcKhRYxFERWs93VgYbm3prBZgoR49j6RDHa7Rn9GS8Mj?=
 =?us-ascii?Q?DNF7gVcacPxa89A/RiwgSAKCv9wsYobgxbFBeuExu6nAaP46u/YNWLZypwB+?=
 =?us-ascii?Q?bzv2tFPBFGyDgpguVu0whyRBgZ+vGx9oRKrWgTx85CTCDIoynDqKAtLA/R03?=
 =?us-ascii?Q?SS5TBW/GP3TC9/ymjQRHtgtWTp2qM7F1Nh/yfAZODZJf9n9sLNEqvMLd5fjr?=
 =?us-ascii?Q?y/bKhNI1cH9MQM1Z1z5b4282nHs6vm3StuOInh+LjAo7GOc/6A13+IHLMeeO?=
 =?us-ascii?Q?mX3tIOZNDqNRm84VoQq4fGw42Xb6/kzrGPGXP9K3c4NMAEnHROUQSvyiqHXp?=
 =?us-ascii?Q?SZG1969JOJ9gzYyCF8cpZvCKOI/6Aqz9tSZy9vbcIvtLLMuFLH/ndWOxBBRd?=
 =?us-ascii?Q?JcjRlj2Shc7o41tZNrkpdvCHc62qVKwLUSxpbL5J4EcTcFzM1Nh+0OJn6ExY?=
 =?us-ascii?Q?OyY0p8Jpj9IgnQiCff6w3VqriYTd7gfrW9LLOHpJXa7L/kGytJDoHNDskXIE?=
 =?us-ascii?Q?zAYEIjQX/+gUGlt41R3tNQo1KWvcgIAH0Bygr/iIC77k2U/Ksp9BIINqkbrw?=
 =?us-ascii?Q?Vb3Sxa11MS/xoG2hRwYro1Xn6pZgyf+4Ll4EorXM4MaSTR13bq+iQoxKYcU6?=
 =?us-ascii?Q?WCZG1lWko5BgzchF0LEw5qZfUrqPKvTmzQUQxhsi6cJ5OmDbY/q73rW1WN+j?=
 =?us-ascii?Q?jImOXpblx0peumXranR2OJLOqdvmdus/DrHIoUOF8Wd5/im4T0O5SQOMtmi9?=
 =?us-ascii?Q?AOeCw9aeID7Hw0hSkzQWxqw3Vg2n3h2bLa7MRbrHDjtj9wTydBPdNlPyZKWo?=
 =?us-ascii?Q?GLc/r9CO+jncqejo4+mObcTVKBH+ucwAAsVn1wWyTtW9LWMJ1Jt2lpP6FgFh?=
 =?us-ascii?Q?Gg77es4sm2f837/Wmkmt/R3gUTwt2wby7pIaUHQnpRWIUTU0GANgGOXxyxS1?=
 =?us-ascii?Q?DaOibjNEfg1iBcXIdOdXzaOGGIo1F7PAqMb2DYrXSIc3YsfpbOYc5rogMt5t?=
 =?us-ascii?Q?R1x7/7qraDCG7bryloqANjaHPXrqkQwW6pHO633j4x7LNPzO6T7NDIsz4jrd?=
 =?us-ascii?Q?6dMEZhhRFW1UO5R1ho0RDndmx6ETDQmwUDdZR7tZZUHP60EnZxFoR4hc0/Nz?=
 =?us-ascii?Q?MVN3lhmRA9fbyEwJYTYB4qy4uP2Iwdk0YDjlTlO12eKCx/PHEGIO6qMZrR5h?=
 =?us-ascii?Q?Vr/3RPuQfB4LnTRafOafMVAB8z2diAkMpr3ixtRCyIXkmN8QWo4zH/fPDK9z?=
 =?us-ascii?Q?ZHj2ZrrsmRG9JRIKlvPSpVZhXK+8kgom7Zgw/51QIuxut8WEAIYsDhFdSZKa?=
 =?us-ascii?Q?/9ioKO9lwabmbx1eJ7HPqUwgVZomjbOAwo6Z9Bp2mhnIqKUyJZHSAjhADMjD?=
 =?us-ascii?Q?/1vdc4pr+lKpGQSVdFtnQCpnyBHuzW6HcO0nfxbCiOZZjcmjsUooj6Z+vNYO?=
 =?us-ascii?Q?41CVc2jrDqwFHDIiUSQ4ZJPhDFLiHKC35C2khrZCacTKW3ePt0OFCumXvvoP?=
 =?us-ascii?Q?KEnahMfPjDBwzyUtMzGsQDhacmLDRsBhGMDimE171wB4PTOItppoTVImdgzj?=
 =?us-ascii?Q?rp61z7Pc1cQWuE0jObItQeW0m9KblGAxfxOxJgLXCpI2n0J+16xLFvImu5jX?=
 =?us-ascii?Q?xus1CpanO/bk5WzqooYLjNU5rmNL7yyPBkAKeJ7cNGF0w7XU/xwpn4CVImS5?=
 =?us-ascii?Q?dYCA0k5pLkYktDqnLx78xKPTzm4wFQuchxz1SRDfXzF19P6O?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0ce05a-44fc-4bd4-db31-08dec29d953c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 00:58:40.2282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOOBbfV8h4h4UqwI9V197mf1HjUCfltP8yV0JbYI39GNo1C3Gyn9Mu55GJ5xFiWR+4IcBsl470SZjUXpM+dM7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6080
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11502-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:kotaranov@microsoft.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:jgg@ziepe.ca,m:leon@kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:wei.liu@kernel.org,m:DECUI@microsoft.com,m:shradhagupta@linux.microsoft.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,SA1PR21MB6683.namprd21.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 429666442F9

> On Tue, 2 Jun 2026 22:48:05 +0000 Long Li wrote:
> > Changes in patch 6 from v2 to v11:
> >
> >  - Error handling updated from NULL/-ENOMEM to IS_ERR()/PTR_ERR() for
> > mana_gd_get_gic() return values
> >  - Added mdev->eqs[i]->eq.irq =3D gic->irq to populate the irq field on
> > all RDMA EQs for consistency with the Ethernet path
> >  - Introduced a separate msi variable instead of modifying
> > spec.eq.msix_index directly
> >  - Commit message updated
> >
> > The gdma.h changes are identical to v2.
>=20
> Hm, yes, Leon seems to be AFK since May 19th.
> Please repost with his tag included, the list of changes you provided doe=
s seem
> immaterial. I don't want to merge v11 as is, there's a good chance people=
 marked
> this thread as ignored by now.

I have sent v12 with Leon's tag on patch 6.

Thanks,
Long

