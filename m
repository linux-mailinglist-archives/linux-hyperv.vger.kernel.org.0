Return-Path: <linux-hyperv+bounces-10398-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ARVJnSu72mSDwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10398-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 20:44:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C07478CCA
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 20:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E46CD303740E
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 18:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F31F3E3D96;
	Mon, 27 Apr 2026 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PFBZxjiL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020076.outbound.protection.outlook.com [52.101.56.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448053E5573;
	Mon, 27 Apr 2026 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777315353; cv=fail; b=p7CSkOw1HZspzLRbj+x9vbVAWid2TsqlbfLdWGB0LvRMSPmuiPx6tbbMLbZTqFF6mpkUSHTEZyfJJn2XSJvdO7GMN2rGxwrvn276Q5pMfBZwBBUq4ANIR5lyVtnqEOldg2J37cje1ZxgqbFUPx/ak6819rKS6SC8bqBRmassYSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777315353; c=relaxed/simple;
	bh=FUNibP/cO5R4cAD1JbO6RA2ULgVtis7iiBI/W9QhYPI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kMKswi8R/+0JvVfM+TdjnE7+67fOsFxj/Ima1o4PTfcM3ahiwd+uXnB2l/WU0Qf9p2fLxKzgA9EDEx43b/5QB34qZmIUqUrhgrMfuXGkqQG2f4wcRmrL7X3sGvJ4+uCeqCXl2tmz1GPNXyVeDiiWnbHy1kAQFelXcg1sJMGm5IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=PFBZxjiL; arc=fail smtp.client-ip=52.101.56.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6atEoWYkRAX4XRv2FedDChz4bleyri6VV4ZNmBF2M+L7RqlFSF4GE/uTlimN0DUUaKM/AcCgUziPYHc295QmACtX1f2WUFjqMXrStclZJZxigqlJM8rTLS2WIxYrmmpnz0+4GSlKlg36IC5d+5WS5zUhYqf+LYbrKmfJeIqk3inO3vmUfp5Qmdvlv3gHGFny6wzXri6xvwfGR8A9iF3cyNqRy3WB5OGh/8R+25u84AMdzhOcSOvBNv+ltHfAIsoOR8B4sb9EXQGsp9rQfCXvlZ/6Vfb5MtWU2EmpCUWd7VqSEk5496E8SNbEDmoFUz7tZe+uXbzSiwYy8s1AuL7ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqqPh8aSReHLCMn3DmKlF7XyaLBkZIYT6aLqF4ub1nI=;
 b=LLep+/up7bEi0kUfU0wQ4Wf4+WyFvChWeCTMvoT18EiWcpbtdE+5oEs+e3dXdcnAKELhmZnYqvqZHN3xtt0l5S1sblqQvXmj92+s+myRa/8r6f017+yVDThpecqDtTJ0WYzs/Z6Rb5KmHYlG5u1OhXK/Yf3QGWzHQsuyrFUZYJbmW0I+MMgXYAX76XGwajfNgHRaKZ6e3wjqW89FQhfwjDdAPDJtub+X6/OK0noinhhjfZ3XzYcvFie+lC4F+n4Bdq5PbhQ8UUkO/Esuw8aBtvg0Yf6srCMqNg0DpilRgq5ch6wSP0UDv0o7uXwJneHMhAApZ52Vxb34kLPBXEY4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqqPh8aSReHLCMn3DmKlF7XyaLBkZIYT6aLqF4ub1nI=;
 b=PFBZxjiLxBsvIhgmX53Ff/yqcUqFBlfVSdqY+k8gj1fM+UFkeYbTHiWdLbHesg5OpfLIaQCzsLoN8jMeMkEJsTbgw3SAxCnKdOqgEitqoQ0Kz0kBGnImSWyFQwTpcsbtpsnA3fkibEXpKI6JafuZrpb7NiuUICbBcTxzGoIxfgQ=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA3PR21MB5696.namprd21.prod.outlook.com (2603:10b6:806:493::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 18:42:27 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 18:42:27 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, Saurabh Singh Sengar
	<ssengar@microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, KY
 Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Long Li <longli@microsoft.com>, Stefano Garzarella
	<sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Himadri Pandya
	<himadrispandya@gmail.com>, Michael Kelley <mhklinux@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Deepak Rawat <drawat.floss@gmail.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"stable@kernel.vger.org" <stable@kernel.vger.org>
Subject: RE: [PATCH 2/2] drm/hyperv: use VMBUS_RING_SIZE()
Thread-Topic: [PATCH 2/2] drm/hyperv: use VMBUS_RING_SIZE()
Thread-Index: AQHc1jw02yJrERFkmkeSl7gccH8LxLXzPWxQ
Date: Mon, 27 Apr 2026 18:42:27 +0000
Message-ID:
 <SA1PR21MB6921B5A2441DB3E9A1312AC0BF362@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260425181719.1538483-1-hamzamahfooz@linux.microsoft.com>
 <20260425181719.1538483-2-hamzamahfooz@linux.microsoft.com>
 <KUZP153MB14445757C6A5DA5DEDA9A09CBE292@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <ae9NxmDBTkzPP3H6@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <ae9NxmDBTkzPP3H6@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=866de344-17d1-4da0-ae37-df720ba729ed;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-27T18:37:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA3PR21MB5696:EE_
x-ms-office365-filtering-correlation-id: 0cf98fbb-de6e-4f13-ea49-08dea48cbb18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 HZyTNBGw5pDp3DxMEyljCszlE9jJDXvDjXMufGASsRxujHBoVWg3NSmGu/N8dJwF/12OlRpbM26ErfJ9BrPPXHVWU6ZwjH+hwlEK2t4YxJMspKV6MKRR5FVxjTxr6KgtGKiKJ70cawtrHiW1OsgmmYDg/+znDI/hwjVmKZoO8ey6inZR43gnkPMoCuTmIvN+WtlNkfwSOGslB99+EusMt60vZny+g5cuTA6+kZKnqri9ZCCcP21bIeSNm1ihThdCwjoNGMeQd9VllLiTxxbvpsi+ppGn8quavSe63APetxSsDD1uteWxjjA7bVbD3wIO9K3PZGD/yS7WRZFnTfSXpbB34OcTbzGZU4qdYcV61RAAznYmOf0f5KINgw3N9CiaGZnUtkVshcfbJuyZFTbxkkyCELHQKQfLQty43+QsO97iXfEvfIjf1L4qHKgxG4c5Sj/xMEz70q+xYaFfdi+hZj7ccelpgIM4GaaUGAn0unIW7jhy0pU/kUyO+cwJq6In4E3LCTTa04LQfJzQPcfVoDrksJH9vSrFZ/7Unc69+XmZ4qxit4atZuypbAJkaKe6ARuDF5yeIoO8/0PVjrwtNCYnOg/TedqDk514Wui/WMP5EGvWyJL1C8H03J6RHhEouTQuvjbfUneJji5ik/JbrRuMcuRArp4dgtMiPm3UR7zaUOHjJq4IhuF84/RP0gfMAJjGEOP7s2XN1jPsaYkRPeB6zqbFFBoMBmjKzGqR3sgMTVS60Du3PB4oCie6bmMSFtUMjBSyNf3PVDyY1rJvZKWPEIY+aiw6NvG1M5xJHvc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SPUXqpozLWgLQtrc8f8iWys7aY+CaXq9cRjdYO9ugfGE73flp1zlEWdrbMDt?=
 =?us-ascii?Q?J9XlFzymWF7aV8jgnVqI6XbjhaKk6yvWigSAAbiijS4ybUFDVXkzzNMXB+XI?=
 =?us-ascii?Q?Nftq5vA3kF1yDzhg+qII/v3iB3BOyIIN30522Ico5J+uTJdH7B8LnBTPBHGu?=
 =?us-ascii?Q?e/8fA8ZdbWuJUI2qF0ExbiGzQNasDQaChnjNoOlOfu6fqO7B5Pf5sc3Y1fy/?=
 =?us-ascii?Q?LDrj3hdZmz1Aote4NwqJ/rtFP60CuEdPSt7WcdXZtpjVRr/bFTKPwcxbJBvY?=
 =?us-ascii?Q?i5Nt5nTsy+ymT00VfuJZfTDGrv8rBToJR7d5R1S05GQUf2BPO/y0IUjYVAHZ?=
 =?us-ascii?Q?a48bp7hEmBOUbYf6L0DgayqaIobkGYO8ZwKcSIJfWJeTpaudYG+Bgq+pZQfu?=
 =?us-ascii?Q?gZiWHmH/oOZevogPVWEZaTFsx+S5pWNNwZW6F0cBjgFkXgRbjTza6TgkxpBG?=
 =?us-ascii?Q?0e4WWHZw15sDkbv6j+5cnAV/j6hw1CVImIDdAQc5St46GF4DXBWNwv4pLI/n?=
 =?us-ascii?Q?Qm+Loak5ZoyC0Yos6CAT6rXruo5vCRrWQeUEHqvCYTH4Np25V00vvucrBYcY?=
 =?us-ascii?Q?ZAkzdk864zmV7T49wRL6dXsARWTm64fyB7c3JBm1Z3+Oo4FUPhmfyLmpH1VB?=
 =?us-ascii?Q?eM6aqXTe5p1MtxmMX8n0JyN6xxuFlCRUB4a0FcZcSQrTpgZkmWWnpnpNaSTc?=
 =?us-ascii?Q?IOMkvNNOFkW9vnOpQ5zHziWluTt7t+Leb2dWmY7dZXqYuqTId3X2Rvk8dYXT?=
 =?us-ascii?Q?Q0QdW9J81t/8BAGM1/tMOocrKSHuyHqdeyqpISSXYGY1rORssGZe6Lhcwpjc?=
 =?us-ascii?Q?D7dWOUzT8NUrKBEnKfi2XU+ZwaB8GzCpGwpx5ScynbnzVzPBKMUThAFpygLO?=
 =?us-ascii?Q?NGjnd5wet/3W3ADmmij2xiSs3vvr4pqbJfH7XrDo/sduZT8V6bjjYBiYslnm?=
 =?us-ascii?Q?+A8uBE0qcVNF6B6oWNOh+UV7gvOBBFuT8+fd8XZBDXUY/xF4cEPYmhXhOSR5?=
 =?us-ascii?Q?9N2k1UOyL2x3gLfm5q4QpG9kSYGAnBlRSNrt4YoSt2APUtZQDxNMxHzdSKpO?=
 =?us-ascii?Q?5XLIElS3oFOGlCoI4jvNxKviy9tn8xtb9qAHKjT/Kbcs3yWB4OtJJDwJQj8p?=
 =?us-ascii?Q?VeYGy25B/yWY0zbgQc8YM2oXpj7WflczMs913uz4svKfT8TDQW1bqbY3qgjG?=
 =?us-ascii?Q?AWN2gsbcgOSP/wJK41hGNpCMohT0304JTlB3KUQKVP853xujph96U+KiuFYU?=
 =?us-ascii?Q?qqeCxxhv3fP3fn85KWyzuL0IhMsporbSi7E7kLvuYQvdEm/IoKcQEgyN+hpH?=
 =?us-ascii?Q?JfRV7usSqsUKfirMdpqlFaEWJUdBUSbLER+MIGnui5rHGfHTGKfmePW2yg9U?=
 =?us-ascii?Q?P7wJugJEVdDc1hj+sNJTbXho7n2ZzwKKwOttC7eyJOZZaMewGHplJ17K6t7D?=
 =?us-ascii?Q?/pjie3ibn24yZA4gvCV4tMDz6ikPUQVNczA0iydNEv19Fi5qUd+J6UqzqQ24?=
 =?us-ascii?Q?hZ1/FyAib1dA7PFoApieXFw9UhnFtVupoEyt+7DMxPyTs5+OWit+berjTjls?=
 =?us-ascii?Q?kbc/rKEBvbv3b0pF31JqCUhUxoJoxsJoeY5DVRd0DxwHBvwLPekeiBnSbPaR?=
 =?us-ascii?Q?QECpJ7Y04GTHgg7nalt/Ya0cPMx+tw/yyfA7eH/2PDdQ1kDSP1zTawA+OTjE?=
 =?us-ascii?Q?BeHhLbDcQHeSdV8S0xoyrTcnjzpXQeG3/QTrlD8jTqU4DvLE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf98fbb-de6e-4f13-ea49-08dea48cbb18
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 18:42:27.4455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AMKtozZnGWueXimcAAfFDjc1x/ET/61y8KX8x3/723m1J+pNC3+bIgE2G/xKgoIslK+gRXDZC44ArR+C434/sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5696
X-Rspamd-Queue-Id: 12C07478CCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10398-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,kernel.org,redhat.com,davemloft.net,google.com,gmail.com,outlook.com,lists.linux.dev,linux.microsoft.com,linux.intel.com,suse.de,ffwll.ch,lists.freedesktop.org,kernel.vger.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SA1PR21MB6921.namprd21.prod.outlook.com:mid,vger.org:email]

> From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> Sent: Monday, April 27, 2026 4:52 AM
> To: Saurabh Singh Sengar <ssengar@microsoft.com>
> ...
> On Sun, Apr 26, 2026 at 05:00:24AM +0000, Saurabh Singh Sengar wrote:
> > > Subject: [PATCH 2/2] drm/hyperv: use VMBUS_RING_SIZE()
> > >
> > > VMBUS ring buffers must be page aligned. So, use VMBUS_RING_SIZE() to
> > > ensure they are always aligned and large enough to hold all of the re=
levant
> > > data.
> > >
> > > Cc: stable@kernel.vger.org
> > > Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic
> > >  video device")

IMO the Fixes tag is unnecessary because the existing VMBUS_RING_BUFSIZE
is 256KB, which is already aligned to 4KB, 16KB and 64KB.

VMBUS_RING_SIZE(256 * 1024) is still 256KB.

> > > Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > > ---
> > >  drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> > > b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> > > index 051ecc526832..753d97bff76f 100644
> > > --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> > > +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> > > @@ -10,7 +10,7 @@
> > >
> > >  #include "hyperv_drm.h"
> > >
> > > -#define VMBUS_RING_BUFSIZE (256 * 1024)
> > > +#define VMBUS_RING_BUFSIZE VMBUS_RING_SIZE(256 * 1024)
> > >  #define VMBUS_VSP_TIMEOUT (10 * HZ)
> > >
> > >  #define SYNTHVID_VERSION(major, minor) ((minor) << 16 | (major))
> > > --
> > > 2.54.0
> >
> > Although this lgtm, but this may change the behaviour on ARM64 systems
> with page size > 4K ?

Actually the behavior won't change, because
VMBUS_RING_SIZE(256 * 1024) is still 256KB.

> > Have we tested it ?
>=20
> Yup, I tested it on an ARM64 windows machine with a 64K page size guest
> kernel.
>=20
> >
> > Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>=20
> Pushed to drm-misc.


