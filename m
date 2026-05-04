Return-Path: <linux-hyperv+bounces-10615-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCbcCu0U+WkY5QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10615-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 23:51:41 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 977424C43D5
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 23:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72D2A3011102
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 21:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC4436C9CC;
	Mon,  4 May 2026 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gZx6xCHG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020074.outbound.protection.outlook.com [52.101.61.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE925324718;
	Mon,  4 May 2026 21:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777931497; cv=fail; b=up4b7gCODtcKLxojMqsMUBMy5iEm3yXeV7O9hEfo6YA5YC1+O6bE+avtDQ+PzJHYGqlLpcBPDxZeSsMZkp/eYnjtkszYF+F+0+rqaTg8onLJu2yZ/2aIALTekzxmfWb/frGU0TQNf5eX1RIoD1FVtSKITcmX0WGl75/cQfrXObI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777931497; c=relaxed/simple;
	bh=knwixMAhgZcadGYNXjRNmR932NFhI4qxExgA2dXAsv4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lNRAEXJDxKJrSAhzHrx14pCYDW8f2IwOEYAXubjL1h3eIWmr5it0QSItiiZTUZm1GECKROm+34IWO+5HC7GBafdGrK3oCkhy2kX66U4wZS5xhwJIuoTX7yi2uOgj8rcDpTnPnBGbfSEtqCddgq1SUlsnVsDNSfuamNGXwUCMNL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=gZx6xCHG; arc=fail smtp.client-ip=52.101.61.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4cSv3OMwC2td2ab8Kef3prLK2bQdAYcp9dCh47ZFWW7ngRd4kqwz2iHCYm1vYiIU+arqYGp7n2uyirX/W6WuWg6/5EPvlRRwGecHN3VuQx5NXBpRDxJPvdHwzkSAcmsQo6u9jydJ4H9OYcnYFQOAOA0eZ9BcmBJGdlwNwDKA5UDJVECKzhhwG6rS/pdwmdxHIbBVLPkFW0ZaOwTlZ3fNE6bISe9oLzvPnvmA7Mnj2MWtF+CE7pWgXy84GiR5nnPb74Lub8SYM8K7ExVL1rvSYQvJuerXfFfALaeEWrnSJo7TkHyISqlniosaoNFcJCz3GMoIqo8wwYAslOyenpKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzpW8+nEZOhR68NlIZUdfoPcvFECazp3lgdIkdj1F10=;
 b=I1/L8v9FrAMJHpGLTYAzknoAJx0BcowRECjyGSHLJgiam10wU/O8S0dVBVE9Rv8U4/A+R1AKePLgUvty+u0NagJ9Vlct+ZtCCjBp8EePW/Q49cZPxdMygPZoLHvIiWAdpUn6t57bbFLxegHI+CaMbU9IHsA9p8fzN+RF+Z+OjyjpZB3z6upapBkTDBX9PDcX8Vgnq1vzkP4JlCebi8/P962AoZgXHscUr+bUiYfONfe2X1SKlOGmcCii+e4PIPHstfGIJrrmwAYHlzGFnYmxburZNP25+8kO4jMAi9w9H/lLxxhm7WeiT1Bn/C97/XwXuUEKEHOJggifkXMpPYHd2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzpW8+nEZOhR68NlIZUdfoPcvFECazp3lgdIkdj1F10=;
 b=gZx6xCHGiRBdHBxehwPw6Csts2bXmqkwFdXGaSBBpr9knH4sa6XPcrQGyb8YKuInaSG3Vhho2FY4Sj5RAXnMHJ7dm59ZJ7swUw66Tqd2wB9xXNTvkakxvsy5tPD+HVNN8ZiVX5CGKzNb2GJEbr/SVwK5sddu4C8wIWzRmdHJZbE=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB4327.namprd21.prod.outlook.com (2603:10b6:806:3df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.5; Mon, 4 May
 2026 21:51:30 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%6]) with mapi id 15.20.9891.008; Mon, 4 May 2026
 21:51:30 +0000
From: Long Li <longli@microsoft.com>
To: Simon Horman <horms@kernel.org>
CC: Konstantin Taranov <kotaranov@microsoft.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>, Haiyang
 Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v6 1/6] net: mana: Create separate
 EQs for each vPort
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v6 1/6] net: mana: Create
 separate EQs for each vPort
Thread-Index: AQHc2CXaUSKEUxi2tEiQPQU00CBaQrX62m4AgAOULSA=
Date: Mon, 4 May 2026 21:51:30 +0000
Message-ID:
 <SA1PR21MB6683034821F55FBF65FB9CBACE312@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260429221625.1841150-2-longli@microsoft.com>
 <20260502150717.281387-1-horms@kernel.org>
In-Reply-To: <20260502150717.281387-1-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d9caf4fc-e7c8-4278-b84f-17c84e7d285b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-04T21:46:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB4327:EE_
x-ms-office365-filtering-correlation-id: d1488621-78da-4232-8fb5-08deaa274cf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 P5wF7zk6uHpQ3NVqCcBr6Zi8ZRm711srtwP4ljKgSK2ZFyq/ySOZecWVUqOpCTxO4bfalIvr3lDvPb6M14zv1O2NAL2d54ClFF42BTXbNlCiro47JXcd9C2CsafJwUpkdLTSAxo0QR/7lzn0OqKpYMhsKVg/WNDtlQ8uuErjFaPfmYKHIwHyYPxIaeo3+851DhzH5xMoBCs96OveBgGEJR4X0QXjl3S7iHLBl4HgIMGOIkyMBXduuS2gQq1ICe/lMAqn76CSa+mLUx7zVJS+OXfAdyxz93S1rJeKIPGDNtjfFX1XUCQDPQUzG2VSbutwTYNYGZb1RRQDI82ekG0CW6LNU1ftn06HlsRtBFw5QTTBq2ah1VC3O6ntCVrH54j/bv6DktCKtUkccmTvUdlGtzaZBWt2v2Fljs/80onQLiliqP6rA5lORZgJVor4Cfi1PJCQ3lKBfw54YIUV6yZukRdBBVgw0bMrNXFXtx+q2kbPNcr/NoMNIf5gMAG3OjdCM4XuTfVSiQTjGlHZteDErtkowAFiJd7Bdh7hFCQUMRcZpu+JE/uFBLMJAfkhDpQVlbgc6DyLUytWpRr8THFtJh0gg8sxVTSGjCgYwV3KT6khSlloNk7EdzueK1jDcT6/oZuQZ5/pXdkAWsgIasGZLVaseWeoJHFhOJsbyIeSL/2uQPD5V9DxtBI/8K6VHRbe
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eYjnN+B/pXxzCKulCLkrOsY+MGYXhoVgoArURc1Xf9TDwj32U8rF+aWitUOn?=
 =?us-ascii?Q?ymkKK+Qh+VKma2syAnUGh2iE1TCqq6dV5od0y+8x8SGVuwtuS3RfC0I8p96y?=
 =?us-ascii?Q?XoUtV8xbCzJgCFx2U1XGSQ5tFygAf9xBJT0KqKVtP2xObIKvEUi9PO1mh0ur?=
 =?us-ascii?Q?wwinfkDJDWzqbqkUQLMHxaKhrFYTZ5TFALadWrKqRCIolJ3iSAHrqmu047Z2?=
 =?us-ascii?Q?DbV2CBKqU+KpFOj9PN3l/51kHNtHcZ0kVKnptUtKjGw2hgwEH1zl/3BowP2W?=
 =?us-ascii?Q?+c0ItdhC0Knh2XsWv6gxpZZu1LQ4f6hheUTiYe9Ac3nBMmRhSUNwtH+BXjln?=
 =?us-ascii?Q?tMvN8FHB+NyeMORGfeptMI43qyAi8JapSUOTrsg/ymv/71tQFiueMEZVh8uI?=
 =?us-ascii?Q?aBVwzRNCQF+t8izRSmFrWSjMglS4kAB9nLZvWiXVD0TB1Ld0mXdKbEyWROLM?=
 =?us-ascii?Q?EBs8awjqPgdbRY7U3VHj0FeawGvrgZwj38xEAOayOrmeFgX6+ggxJTAz02Z7?=
 =?us-ascii?Q?MBp8u4QaiS8jdHWsIDJ6gGNyK6gD+bzVlJydnlZhmO4DNTajzUM4y6eaGdTC?=
 =?us-ascii?Q?+2IrFNM8H3RxODkYp7Ft20hlyE337x9cZ/WjpAOKdt8EV9WVNOaz/pGyupi4?=
 =?us-ascii?Q?ZLYt/YNo2soH7lGPWWBR+OxHqH4CdVm9JAb4oT44ZugNQsc3k1hKRzrhcTRH?=
 =?us-ascii?Q?Bx+xo6Vq2kqWudg1iGEemSRyAJs4PPs6yvWSDrS8kSOGZrnLgM29BpBCYAsJ?=
 =?us-ascii?Q?w4bx/qTW1Kc1cUFe33IGc/3xjSjRNdBWoet2RubTA54uXYuEZoCHfBUVWs0W?=
 =?us-ascii?Q?lXsn6Wm0k8i/bx8dnSQUOKcaLHsH1VZ7pin7Pk1AQ2qroyW0Yg5L2fSHSyVL?=
 =?us-ascii?Q?WAhT3LK5qvoXFUKho6MVzH1Nbcz1RWgosR9wGWcd67+bmv1ddZHlyDhzeU7z?=
 =?us-ascii?Q?LOq9NUYQtYbzLfA3lTVCwQnGspemzET6I112maEURniuWdKLLwmjCsAjGAEU?=
 =?us-ascii?Q?Zak1BB7hPKFoQoSKe0RHLP5E/FRtWX8CvC9SYEfu5or58WZ7CKz6lUQs8aGE?=
 =?us-ascii?Q?yJpYkRGG4Y9r6cUgN2oy4av77tD2ERVHdy1YA+rizf1Nq+N3/hSmORTpuHPL?=
 =?us-ascii?Q?npXWWzXPm1k2KL2oWdNDtXVjc34ot1ZDXIm8y6/5KsbPQVNXAzULc1tZTCQ9?=
 =?us-ascii?Q?NPorVrE6vxbLES2oeX1bQ0K0FAT5cSo8cmMtNed4I+q/i8YZ/7GG3HwvMYXb?=
 =?us-ascii?Q?Nxhl6oLkTx1ub/JpZPuYM8C/mghjeSlSK9zaHdj3YyMqQfaRgo/7AZqSSiWV?=
 =?us-ascii?Q?q9uBt9AoXkUOMh5G19qy42wWbR8wRoReMATOmW4rZZ4qNjEQI7Dux3wjuHgg?=
 =?us-ascii?Q?14eVse+PQtvL2YjtoBqC5/SU4c4Ulm6KnCpbOlfMwbwyNYKUmljrl4aaPqzA?=
 =?us-ascii?Q?LC3PGAsAm/Kwj8BgEom/YI8pPUuErtG72OGaLjViEK4UHwYC1YmsEWqE/REN?=
 =?us-ascii?Q?JZ6CFByWK18Re2fDmVTNjt8s6D28VA+W/rRdutIMTWCy7AyHWfof2pgJTUW5?=
 =?us-ascii?Q?Pxb5LBnRXrBf33j4+oCnUuCJvmd0kWS5vML8GGBC2X/peOjfbBTTzWjGrmD1?=
 =?us-ascii?Q?5kewUMaBJDFPAs/4780x8UKXzAnsyznuLRs3Hk3I9MPiroK0s+9ljfRH23jz?=
 =?us-ascii?Q?RXF4C5qg4BSz8kVPwdhOfJDf3rv3CPIfHMJCpGkGO2nlr1Dc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d1488621-78da-4232-8fb5-08deaa274cf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 21:51:30.4605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5xtjuzTnIG6bdXrKC097nSAi3EJLWeGYEnMts6YdYNghez7N/1OHSLhiYDn6ajUg427GNQkp4T2qWcIDXcGTnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB4327
X-Rspamd-Queue-Id: 977424C43D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10615-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

> From: 'Simon Horman' <horms@kernel.org>
>
> This is an AI-generated review of your patch. The human sending this emai=
l has
> considered the AI review valid, or at least plausible.
> Full review at:
> https://sashiko.d/
> ev%2F&data=3D05%7C02%7Clongli%40microsoft.com%7C3344dd1ec8e44fc6d4a50
> 8dea85caa2a%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63913331
> 3118303655%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYi
> OiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0
> %7C%7C%7C&sdata=3DGJTF8DNw%2FzYNsPz0lC%2FDFZpcCwqjuCmfVu7smim81x
> E%3D&reserved=3D0
> ---
> net: mana: Create separate EQs for each vPort
>
> This commit modifies the mana driver to prepare for assigning vPorts to d=
edicated
> MSI-X vectors by removing EQ sharing among vPorts. It moves the EQ defini=
tion
> from the mana_context to the mana_port_context and exports EQ lifecycle
> functions for use by the MANA RDMA driver.
>
> > diff --git a/drivers/infiniband/hw/mana/qp.c
> > b/drivers/infiniband/hw/mana/qp.c index 645581359cee..6f1043383e8c
> > 100644
> > --- a/drivers/infiniband/hw/mana/qp.c
> > +++ b/drivers/infiniband/hw/mana/qp.c
> > @@ -168,7 +168,15 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibq=
p,
> struct ib_pd *pd,
> >             cq_spec.gdma_region =3D cq->queue.gdma_region;
> >             cq_spec.queue_size =3D cq->cqe * COMP_ENTRY_SIZE;
> >             cq_spec.modr_ctx_id =3D 0;
> > -           eq =3D &mpc->ac->eqs[cq->comp_vector];
> > +           /* EQs are created when a raw QP configures the vport.
> > +            * A raw QP must be created before creating rwq_ind_tbl.
> > +            */
> > +           if (!mpc->eqs) {
> > +                   ret =3D -EINVAL;
> > +                   i--;
> > +                   goto fail;
> > +           }
> > +           eq =3D &mpc->eqs[cq->comp_vector % mpc->num_queues];
>
> Is it possible for the EQs to be destroyed while this RSS QP is still act=
ively using
> them?

  No. The EQ id is consumed only at creation time - it is passed to firmwar=
e as cq_spec.attached_eq during mana_create_wq_obj(). After that call the C=
Q-to-EQ binding lives entirely in firmware.
  The kernel never dereferences mpc->eqs again for that RSS QP's lifetime, =
so there is no ongoing kernel-side access to the EQ struct from an active R=
SS QP.

>
> If the EQs are created by the Ethernet interface being brought up, or by =
a RAW
> QP configuring the vport, this RSS QP will attach to them without increme=
nting
> pd->vport_use_count or taking any vport reference count.

  This is by design. The RSS QP (RX side) does not take a vport reference, =
and symmetrically mana_ib_destroy_qp_rss() does not release one either. Onl=
y raw QPs (SQ side) take and release vport
  references. The refcount is balanced: RSS QPs are pure consumers of an al=
ready-configured vport.

>
> If the Ethernet interface is subsequently brought down, or the RAW QP is
> destroyed, mana_destroy_eq() will be called, freeing the mpc->eqs array a=
nd
> destroying the underlying DMA regions while this RSS QP remains active. T=
his
> regression could allow the hardware to DMA completion events into freed E=
Q
> memory.

  Destroying the raw QP also calls mana_uncfg_vport(), which deconfigures t=
he vport entirely. After that, firmware will not route any traffic or gener=
ate completions on this vport, so there are no
  in-flight DMA writes to the EQ. This is the same pre-existing behavior: t=
he raw QP has always been the vport lifecycle anchor, and destroying it whi=
le an RSS QP is active would have broken the
  vport regardless - this patch does not change that relationship. Before t=
his patch the EQs simply outlived the vport (device lifetime vs vport lifet=
ime), which masked the dependency but did not
  make the out-of-order teardown any safer at the vport level.

>
> Additionally, since mpc->eqs is accessed here without holding pd->vport_m=
utex,
> could a concurrent teardown of the EQs lead to a use-after-free when read=
ing
> eq->eq->id?

  The RDMA core serializes QP creation and destruction on the same device c=
ontext. A concurrent teardown would require destroying the raw QP on the sa=
me PD simultaneously with RSS QP creation,
  which the IB core does not permit. The !mpc->eqs check is a defensive gua=
rd against wrong call ordering (creating an RSS QP before any raw QP), not =
a synchronization point for concurrent access.


