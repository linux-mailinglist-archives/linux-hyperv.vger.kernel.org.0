Return-Path: <linux-hyperv+bounces-5909-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE968AD9360
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 19:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC303AD352
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 17:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041A8215179;
	Fri, 13 Jun 2025 17:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hVQu5rEp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021132.outbound.protection.outlook.com [52.101.62.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4570F22094;
	Fri, 13 Jun 2025 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834111; cv=fail; b=u8iV07d3hkmcxT7X8joh4A0QPOkrFt1VnCNNHIngyXm5AdAC2pOe/ZXSDEXL10lyxefpqQs6waaoBtF7w/kmIuRIseabELPqttSNg97msFx1mAhC4fuUgk4jBkJkF+eBcTWa5itpwDJT/ckyXVC90gq6ipIdzjlSjfJ+SPaXQEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834111; c=relaxed/simple;
	bh=kDJrJOcUSwuCjUf2YV+9BPNstFONGBW88GwU2W8X0+E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gtw6rr3340mwzmWJzUQHJX3jvv4bR7ml1CZ0rVDDK6+gFt6BG/g0FcAbadt89kXpZOimZ19TZiCr7zOjPPzVg7GBMdXjXxsSbhvKZIU/nMgJVIaWnmRUjmWnP6fosDWULxuZpJk3aj76fX3HL73cdwunM7eQN7lruaECa75Hdlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=hVQu5rEp; arc=fail smtp.client-ip=52.101.62.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GablrJqeSvkBOFmTWGAl1syIQaPyECiBYGuYQg0hLHw7w5Qc3AiK9TBUw1tTJpPZD63QmKFfdHGECN05TrXYmhWJ/vGPlpwwcx1wCvQaJhnWrGqNhcn/Q6i6dTZC+t2CrHqelfRvBty6pzyd6NPSOBVS5a+bgb6+w7SBYsLQLKZ7HxREARvIvHy8dZF9aQ07kWZV5+mSBqOBosnXZWRsFX+lQHaM6WszJAiKlXhQr/5UFxe7YCvscgr5mFIgmWZlpFPT+DVmdGpZUQ+mnbjZHWvzo5HA+bYlir+doz/1tyQS8SckA8XorLr6d3VTajxkaVC4h0h8/IhvkFQBrNh1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2F2DzXh3WpCrMk4jZ5Xk2X0Z4T4w+8Hw4FjChNfitoM=;
 b=G3HrtQnS+5rBbtaUhQd+4D6aUAyEBQePiZjywGh1jxS2nPPFBtbjVA8WGJglm2uXLj+GsdflRFSpcpye0jWHJbl+aKr9bVQSK4v3mxf9OarLGKJnfnkFFQv0ujomYkqhelZBnpOUSPrKZ9Ii/VT4dxCftNCqOG3ONgonRxBsJS3QinKWMkdWWSCuC6AqrbTMt2z62XlJB0xMSXleq4NI+tQ2rQh3HyyzoA+RQM/7HZy/D+9I62mNpTjQpn7aPheml3Y4cPidEVT6sHzOj9yqjt7C3TsqdGq6mlqpO1NbQpl1NmGAIoqFkF77y065cAqSanoUv1gpOrrOS6WfDRzB0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2F2DzXh3WpCrMk4jZ5Xk2X0Z4T4w+8Hw4FjChNfitoM=;
 b=hVQu5rEppStzWfQ36YjvaWTnJcnTGytM1ByRfr46eFqpEOZu1ayz1sIIAlGm1t7R25IJU9j22TdFGbxYErfPBrwc+rD4o4KOOs4W7ZWWJzwJ7R2Vr/xKG3107ArfLgMntXd8e0sNo1POdOQS5CMu1qFh5aKoXTGkpU+k1DQGQ74=
Received: from DS7PR21MB3102.namprd21.prod.outlook.com (2603:10b6:8:76::17) by
 DS2PR21MB4725.namprd21.prod.outlook.com (2603:10b6:8:2af::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.19; Fri, 13 Jun 2025 17:01:47 +0000
Received: from DS7PR21MB3102.namprd21.prod.outlook.com
 ([fe80::b029:2ac5:d92c:504f]) by DS7PR21MB3102.namprd21.prod.outlook.com
 ([fe80::b029:2ac5:d92c:504f%3]) with mapi id 15.20.8857.013; Fri, 13 Jun 2025
 17:01:47 +0000
From: Long Li <longli@microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>, "horms@kernel.org"
	<horms@kernel.org>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "schakrabarti@linux.microsoft.com"
	<schakrabarti@linux.microsoft.com>, "gerhard@engleder-embedded.com"
	<gerhard@engleder-embedded.com>, "rosenp@gmail.com" <rosenp@gmail.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: RE: [PATCH net-next v2 1/4] net: mana: Fix potential deadlocks in
 mana napi ops
Thread-Topic: [PATCH net-next v2 1/4] net: mana: Fix potential deadlocks in
 mana napi ops
Thread-Index: AQHb3FUu2qkyvKfa1Eu6dbyu/n4CrbQBUO3A
Date: Fri, 13 Jun 2025 17:01:47 +0000
Message-ID:
 <DS7PR21MB3102F21CA7AE05FFF4CA5563CE77A@DS7PR21MB3102.namprd21.prod.outlook.com>
References: <1749813627-8377-1-git-send-email-ernis@linux.microsoft.com>
 <1749813627-8377-2-git-send-email-ernis@linux.microsoft.com>
In-Reply-To: <1749813627-8377-2-git-send-email-ernis@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e0a7d348-537f-4835-abe0-05c7aa7276c6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-13T17:01:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR21MB3102:EE_|DS2PR21MB4725:EE_
x-ms-office365-filtering-correlation-id: ac664f81-1f8a-4731-9427-08ddaa9bfb99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5ZEGQ8Eo4+WLAKWno3UbQ9pSZC97QyEQvcQ7Nkq4EOVOZNakFJg+n9OWUCvA?=
 =?us-ascii?Q?VeX88u9/NNZi29OgZhphG136nlrtYzr8A3x45TWQ05nxz2KipqxFVXrz+i7u?=
 =?us-ascii?Q?KuP1/Hk/rXjAJQHb/Tjzn30B1lsXjXuQs0JAXCERRDnDmCXAQhmyTxlKzBJl?=
 =?us-ascii?Q?daXL6VSUIrjBGoRqRXQ5CEFBdbxjahcTiNj5XTUTrJ/4gxlSqOYzpZ3RfLCI?=
 =?us-ascii?Q?x34y0WvC7PdpexGgj5+mDFEYIurfgbEZMsZnmaMntdsHk6fpZCPbrsRWFLJk?=
 =?us-ascii?Q?aWCnPRELEZ112d5CDHTDTCKXRZx2O70cPdJi8N/2HiY1+8Ormqiz5RNokm8u?=
 =?us-ascii?Q?fCxUpXcF5GfB5BoO9YddnA0WP0DZxZEsfF8qjfTG72+Medr2a7o7A3WOrh5t?=
 =?us-ascii?Q?BTv9+5e89NeN+Qo+FzVYKd52mFrXcguahJnfGE6kmxPYgGnRSR8Pkr6UisgD?=
 =?us-ascii?Q?QmkV+EUOuvP7478ZJeidMUOHm/CYy565KHHQ39HEmO9ogAgM/SHoDLyWF3wy?=
 =?us-ascii?Q?jHPnG87N15BK5gLw2f/HyeOTMDm92hviu2DzplWv69GfpedfBl+riE/AAh4K?=
 =?us-ascii?Q?kGbjAYiU9wuIb3P3XOZwAcPymTUgkPAnC8WUPU6cdtbD3u1dqWYvEfk8SOjT?=
 =?us-ascii?Q?IPju9XTRaXSqmDQz27LWcbSOchMXzwQorE4oUeojC+hWgxCfdGLdUPUCybS8?=
 =?us-ascii?Q?0J67P4eHYqB+CCjwfw6G43KRxphP3/gSooJBsKBx1VU/pBI82xdsUrGYQFY/?=
 =?us-ascii?Q?Q32+m3OqHqvBHdSeCVO3jmsX01Zz2usi6KAxapzj97be9MWhZyaHvHYyHFla?=
 =?us-ascii?Q?GIH/CI7PchTcUi5EuJEjmFmNHJvMXWxsLi6u6ejb34T5TOWK9Y9AKrQrlwxr?=
 =?us-ascii?Q?2uH4hlTERkshXHeXHL9WzXu29VOveUZmHZJ9XpnR+mwzY2o9/DWvtDiKfLWH?=
 =?us-ascii?Q?BR45jJfITZ079l328HN/h5lq0sytWRi6vxD83TcRdrvrXebK77v+6yqpYWVA?=
 =?us-ascii?Q?JNq6etqC1IdogRLJ+9x0N9qqbLR7ZfQFDcJUfW7qUHai0ZA2zXnO/nOm1Q15?=
 =?us-ascii?Q?9+3TKR6Tiq4fxSGoDHl4+5P4nG05sJNxvLASuzWEkuDRKTaH2ZX0OvaO/L1c?=
 =?us-ascii?Q?e0lALpNQf5oV48lCQGZCTQtmNX6pf+ogbPBjHD8exsozhQMBHLXcf5//j8XG?=
 =?us-ascii?Q?qW16yS684p5pbBxt0FdnyxZCOq/tkDefe3wEEsNUBooEc4XLwIjAMLRI6DWM?=
 =?us-ascii?Q?4wty+mVEhpKU3/JP5TkE4X7AU29d7+XjixawB8PX3AflA1eidO+PGBvutJ3d?=
 =?us-ascii?Q?ZHUCesHa8g+YUck0EbvwRp9MIc0pARRfSy6LiBeRap1MMFqxFwZogELE1cyN?=
 =?us-ascii?Q?Q5O3+dGlUp9Oypt6gnPwv+yjum5Qqh6HBlylrbX94Xyrbgzuynmqdwebnm1N?=
 =?us-ascii?Q?npYl7RXXXmHxOlfSVbcU4jz/kvd3IB7ICW5h+4MmHgLM3K5yI1llLSrKFFUw?=
 =?us-ascii?Q?y699rp/J+RdZIY4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR21MB3102.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?twEIpxsOpVdoOvmaN4dvTyRh9ua2cwijReEkXtZdh+W/I9KNa3cJHQg5CUA0?=
 =?us-ascii?Q?Nxds6rhYiZwrgweWl7bG513xssBfep9aXqwLyN9OESjB8ZAMG3Qre34o2FUE?=
 =?us-ascii?Q?H5IcRX1VWeuZov6BQ2bzx8Fh4j21N2lGOa+a/lgH2Bg4A3xiKpuGi7cVJzn1?=
 =?us-ascii?Q?rpEg6vE0n+/usP2TmDEjnTY60WEDUrIo6t8AFwgYzb1kOrj+eDY0a8Xfth7M?=
 =?us-ascii?Q?bKBp5TXNd7F6l/0WZ/cJwLyRUxQNZxF+Rv9tBP+0a9j2vpCTc1+rgs5WIuPO?=
 =?us-ascii?Q?ReMxVndkewbiyLpmh1b/KO2HlIwyBAYpjBFn1ZvoAjoEj9/kYTazZapAlcXY?=
 =?us-ascii?Q?q/1sKjGmZrnRSNZoLSWrNXwvX3QhwpDagNbdjxjLDW7cpbGj4zuppdhEbG9I?=
 =?us-ascii?Q?Gch4jqe0KBgOINugw/zvsaus0Cc6pi/WgtAMZnQ2lrSLZeXkp+VCbFJKFEPg?=
 =?us-ascii?Q?txi+3PzpT4XsI8nfKLSACzd/rmNTsMipffvJ9yAs8JBEo5Bw9iUkMeXKfY3L?=
 =?us-ascii?Q?SSHFIiP5gNdzWWBtzaSMFyA+u+X00Xi3WMx2LwlYwXoL5TXYG+a3wJUWdRUr?=
 =?us-ascii?Q?Wm06WfgoZ7NHUON/RoDjyk6yjUm+H45qSg1oT+sMNtMG6x5LI1QZ/1kfg+NY?=
 =?us-ascii?Q?buz0Znz9o1qUWPTHKJqNT9bjeqPzQUalry2cnC1SEP8ZoRsWvdqaNVZB4msc?=
 =?us-ascii?Q?G5Enwqc1LDV/X8VsTnRuYbrpH6iaf9LQfW4ojqj6SVB4foW5YkRl+osiLPcY?=
 =?us-ascii?Q?2f8wA6bLSfLtoEXFwY8dZpqG/gMSNTPP/I5efpld/WrTOffaYMycuF01KtM+?=
 =?us-ascii?Q?oXWKfCESb3Xz4IifrotCntG4ccNgsP8MQYQD9/GUD6TMpCVEORVJ05LTSfLS?=
 =?us-ascii?Q?pl8VBR1HsUByAZLEoJ2kozz0HcXPL9g/CsUZ4KOGTeeAjXbXj+aMyjh2T+2L?=
 =?us-ascii?Q?9UASrmjwwGEQ90IuPP38rhMo39f7YdKKKTe8LX2eooeT0M05jxbQiv85W20P?=
 =?us-ascii?Q?w2dt9654Bs+lERT8J2nMD6SDfwuDAHS64BaBLAUVd8A0ohoDvYClW9HtVBpp?=
 =?us-ascii?Q?Uak2KECHw96Bzz2c/f8xNX0GMl3wDItcVDTrZYefHf7mc6DFgaLlQ6mxYd6M?=
 =?us-ascii?Q?1fpQafkcH1IDlH5xzEVWW4ZZ9tDTewd1NqG37E5In7t8TYQNXCqpJ4xwWk6g?=
 =?us-ascii?Q?2fUwea3FELQCtpouTfKSspDZe9Xa2xXeEA8MKqu+vFQa4yTZW+P0JOvoysbD?=
 =?us-ascii?Q?xXrAXJzU//IjiVJsDGRSq2NBps2XOlmywo2DWSKLKW5vCYZkYpY48LovrSNn?=
 =?us-ascii?Q?ZZKgU/AjOTw5FZvfEkIefPyLogkcQqkeKyWs/d6IrKxElUENcrmZCEPwmA5t?=
 =?us-ascii?Q?KgSrs/f3Tphq2D7bpxFSVO6R/AT2VMiuJ77oJ52HZtx6cPtUiP4l669iPMrd?=
 =?us-ascii?Q?iXdELmExxPSCLC96SKayOUNxnm3nQNbd3iVK2VZ0R0zzad9HnxqaAQSKrCv8?=
 =?us-ascii?Q?UBG76ghogfUX7mR8Xv+A6oGGZ3v+3kCpI9bTJur4+AWUY8qWHeBV8ZTuhxeF?=
 =?us-ascii?Q?Sw/RiJA6dTv4hAeUGnT7z3atYfS7O/23F2HnJjNB?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS7PR21MB3102.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac664f81-1f8a-4731-9427-08ddaa9bfb99
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 17:01:47.3887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SpgYVoHAoslAEV7zE/xBgkC2rO0wrX1eYViCsuxhZC2IVamRkvBfPqQ4UtAoP2d5AlmIInGhaigGWaUBDneGKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR21MB4725

> Subject: [PATCH net-next v2 1/4] net: mana: Fix potential deadlocks in ma=
na napi
> ops
>=20
> When net_shaper_ops are enabled for MANA, netdev_ops_lock becomes active.
>=20
> MANA VF setup/teardown by netvsc follows this call chain:
>=20
> netvsc_vf_setup()
>         dev_change_flags()
> 		...
>          __dev_open() OR __dev_close()
>=20
> dev_change_flags() holds the netdev mutex via netdev_lock_ops.
>=20
> Meanwhile, mana_create_txq() and mana_create_rxq() in mana_open() path ca=
ll
> NAPI APIs (netif_napi_add_tx(), netif_napi_add_weight(), napi_enable()), =
which
> also try to acquire the same lock, risking deadlock.
>=20
> Similarly in the teardown path (mana_close()), netif_napi_disable() and
> netif_napi_del(), contend for the same lock.
>=20
> Switch to the _locked variants of these APIs to avoid deadlocks when the
> netdev_ops_lock is held.
>=20
> Fixes: d4c22ec680c8 ("net: hold netdev instance lock during
> ndo_open/ndo_stop")
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Saurabh Singh Sengar <ssengar@linux.microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
> Changes in v2:
> * Use netdev_lock_ops_to_full() instead of if...else statements for napi
>   APIs.
> * Edit commit message.
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 30 +++++++++++++------
>  1 file changed, 21 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index e68b8190bb7a..ca5e9c3d374b 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1912,8 +1912,11 @@ static void mana_destroy_txq(struct
> mana_port_context *apc)
>  		napi =3D &apc->tx_qp[i].tx_cq.napi;
>  		if (apc->tx_qp[i].txq.napi_initialized) {
>  			napi_synchronize(napi);
> -			napi_disable(napi);
> -			netif_napi_del(napi);
> +			netdev_lock_ops_to_full(napi->dev);
> +			napi_disable_locked(napi);
> +			netif_napi_del_locked(napi);
> +			netdev_unlock_full_to_ops(napi->dev);
>  			apc->tx_qp[i].txq.napi_initialized =3D false;
>  		}
>  		mana_destroy_wq_obj(apc, GDMA_SQ, apc-
> >tx_qp[i].tx_object); @@ -2065,8 +2068,11 @@ static int
> mana_create_txq(struct mana_port_context *apc,
>=20
>  		mana_create_txq_debugfs(apc, i);
>=20
> -		netif_napi_add_tx(net, &cq->napi, mana_poll);
> -		napi_enable(&cq->napi);
> +		set_bit(NAPI_STATE_NO_BUSY_POLL, &cq->napi.state);
> +		netdev_lock_ops_to_full(net);
> +		netif_napi_add_locked(net, &cq->napi, mana_poll);
> +		napi_enable_locked(&cq->napi);
> +		netdev_unlock_full_to_ops(net);
>  		txq->napi_initialized =3D true;
>=20
>  		mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT); @@ -2102,9
> +2108,11 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
>  	if (napi_initialized) {
>  		napi_synchronize(napi);
>=20
> -		napi_disable(napi);
> -
> -		netif_napi_del(napi);
> +		netdev_lock_ops_to_full(napi->dev);
> +		napi_disable_locked(napi);
> +		netif_napi_del_locked(napi);
> +		netdev_unlock_full_to_ops(napi->dev);
>  	}
>  	xdp_rxq_info_unreg(&rxq->xdp_rxq);
>=20
> @@ -2355,14 +2363,18 @@ static struct mana_rxq *mana_create_rxq(struct
> mana_port_context *apc,
>=20
>  	gc->cq_table[cq->gdma_id] =3D cq->gdma_cq;
>=20
> -	netif_napi_add_weight(ndev, &cq->napi, mana_poll, 1);
> +	netdev_lock_ops_to_full(ndev);
> +	netif_napi_add_weight_locked(ndev, &cq->napi, mana_poll, 1);
> +	netdev_unlock_full_to_ops(ndev);
>=20
>  	WARN_ON(xdp_rxq_info_reg(&rxq->xdp_rxq, ndev, rxq_idx,
>  				 cq->napi.napi_id));
>  	WARN_ON(xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq,
> MEM_TYPE_PAGE_POOL,
>  					   rxq->page_pool));
>=20
> -	napi_enable(&cq->napi);
> +	netdev_lock_ops_to_full(ndev);
> +	napi_enable_locked(&cq->napi);
> +	netdev_unlock_full_to_ops(ndev);
>=20
>  	mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
>  out:
> --
> 2.34.1


