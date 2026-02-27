Return-Path: <linux-hyperv+bounces-9036-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AodNo7voWm5xQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9036-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 20:25:02 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 451F31BCBC0
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 20:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70E573002335
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 19:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9403A407579;
	Fri, 27 Feb 2026 19:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iHPQ385j"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023117.outbound.protection.outlook.com [40.93.196.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348E63A1D1A;
	Fri, 27 Feb 2026 19:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220300; cv=fail; b=LvqUv00Qcu90puFOWOO/mHhD12vEUweVa1WbVkssK5PV/k5E5HEKRpKIMafLIhHRgPmP9gpDWdQ+8yFVXAKqegflzERIrfP1w17wciRaQWNdguVGQBJfKlYeFlml/KtILYfKITF5YuUbOyDyTJlvxeB3//0N4iWGXVPcw2D/cuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220300; c=relaxed/simple;
	bh=gdxNbco2mOfLoVYW5sIC8QJPRnHlpAaGU8B54TpF0Uc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=du3ROQjLXOR3zi1NMP7ADP03tT7IKxt8VrMKgt6rjQO5h+OeqxEmBiiCJTLAjGEulqs7SMrgE9OXNOzBhJaCdMw7lAiLKpiHwRxanmBgdUN8GXCqs0GSdAFhhdi8jBbF7yX/uvuVF1/och2wj0YEeUxXYtCObuynUyu2DQcLzyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=iHPQ385j; arc=fail smtp.client-ip=40.93.196.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtHB5IEJkMV3/XxDZR0viYrQ/GmwTPISuqU3qTEUtypHawNv/akWtcvJvFvAbV4hYgJTR4JPa97kkcUk1UObNTq8en42VJ7RuSoeW9BxoF3s8pyL/SmIDsWG9i51WbBw8ciK3gvUmPpnVV7JXIjjJH7eViDSDN9WWIRxSZZlIyQFXI0XUcWpB+WKB8MJKaMTnlu7kwUem5GZKDA/MWt0l534a5fUNu0CwmC+BtnRkiKXb390O2Fw4qCkYVYc/wa0Rocm04G0aiBdsB++olpVj8QZR51Of35QR2AnDeKH5coyX+KFvYLuiGtqkuVxLJ3cJyx35o9ifm0ZfttU7zHFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSCX9rq7hB96Zv8m33TESI3Yj7/3zT6t7DNpEJoGmJw=;
 b=LDrQTPiob2PIJM5Av/cx3TdXQKKiBHn1nLDZhPoTuYjDnANTPZgtrrBgmMVeHA8Z3sqfYJ7cBrDgjJLgSLUVgRN4zbKzMElJZL2nSlSLkjhPwTVxvsmZT0PMJb7B7p95H1mcSsDzmRS10jjaVRV0HPiFhnThOSpKliCg2Ft8+y5fDxZ3FmwUiamdkWevG1+f3mxYUgge6ylEIOznJmPJgFjbWVNY80k3bCUZynFL4m1J5QnnoG/DcxCa1bj6yaGBu/Lq0xG3JAzVrG5VDWMSdHN5Z4EYwmDXxQjjoiIbPnLN8t/JB4OFQsNfyI9UoSWfi4usmFCOLYX5qBtX9b3+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSCX9rq7hB96Zv8m33TESI3Yj7/3zT6t7DNpEJoGmJw=;
 b=iHPQ385j5Su2vJpzrsm9vaQvjXP8oL8hcGwBCg5KqbN9uNlMrH2GHr1EMBI0IwKk/d6Sf7xcr+ZI8KlYJG1kVtWj+EYC02kvNLa1qL62wI7kOVPvgDS9cpms/zNdg7E7WZh0Jssmeo6+XuInYXIEosGoPv5kIjDbJb5hExHWsdw=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by LV0PR21MB6382.namprd21.prod.outlook.com (2603:10b6:408:332::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.9; Fri, 27 Feb
 2026 19:24:56 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9678.009; Fri, 27 Feb 2026
 19:24:52 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org" <leon@kernel.org>,
	Long Li <longli@microsoft.com>, Konstantin Taranov <kotaranov@microsoft.com>,
	"horms@kernel.org" <horms@kernel.org>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "ernis@linux.microsoft.com"
	<ernis@linux.microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Dipayaan Roy
	<dipayanroy@microsoft.com>
Subject: RE: [PATCH net-next, v2] net: mana: Trigger VF reset/recovery on
 health check failure due to HWC timeout
Thread-Topic: [PATCH net-next, v2] net: mana: Trigger VF reset/recovery on
 health check failure due to HWC timeout
Thread-Index: AQHcp8EvXBPawOMuEEi89ARWjViKtbWW7c2Q
Date: Fri, 27 Feb 2026 19:24:52 +0000
Message-ID:
 <SA3PR21MB3867E86E61B97DF093C942D3CA73A@SA3PR21MB3867.namprd21.prod.outlook.com>
References:
 <aaFShvKnwR5FY8dH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <aaFShvKnwR5FY8dH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=36ff9f74-f7e5-4e17-b641-328560d288d0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-27T19:24:13Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|LV0PR21MB6382:EE_
x-ms-office365-filtering-correlation-id: d08a5175-688c-4c5b-38c5-08de7635e1e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700021|7053199007;
x-microsoft-antispam-message-info:
 3GbsdyAn4jHiorwBmdu6shAL1kl0sTJZRv0mGW40Im+Ynq0TkJvvpYOKqD9TV+uXTUmIZlAmrlpmVmKSwsf/P9ZAOqQB6x7/fyVglJE1Vcef2YlgirvhhHP/HjmYifflY2SFT2nK0aCYTdwVIvvMXUKsbtEkf504Qsz969i9tiDkawx2sJsb+hbZqitJEs/uFEl8FNSVnF/0aym8ZwZDoJ0lYdzD7V2qHN4VFVqYZmdjNYwkJxTLAnpAl4fPB/0zEkUPa3wNvUKMXMhbXAmsnbs0JrunDXjy2tIyuxMdtsHG0OOvwjQVi96A5umBG0uo1/2ohxOdxLSU8pqq5VpZJK0j6s4hEnz18TJCiLWPmIffLNTFeBvhbxMswIFJRtgxWprQ3adXM7Vi/OuRZeaj4U2ZpoySMbdUk6uzG9nHbTbbpwCZHXqFy2JC4oDrfVj7Ua2CPH1eEZYxY/nNLH84A6CFZdTHfKug8M5cJFMyO3iZd876fZduNSElxh1kYER1eCtlwXI+2ZbSAxMkbCFKvdeeQdadLvxHVB2HPbiNIq7l2vPX6EXbai91mkADch8wtCCZiyBP8P5VeWyXLFGXG3UOo0E+JTYmMJykHYDkcq/gDh3ypZF5aQyUMKPUAsc9BZLeUUxh9rVRzmR1+a4OTjnOxoagGw+bRjEP8pDQZL4kjDJ1JTfyFF5G6ku4F283ZyzkRFfBgzHWWOsUwwtLD+B1GTVIVss9Zst3GGtzUhze/jfmwBSLOuCrsFhMamFzubzKofx1rTINYQUXzLrZlOC7KXE5sna2ySexiAQ8pj4rzro1gsmiYWzDsss+eErX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700021)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2TGC2FLUfGYCDYDmhCtbQ24GytmniPy8hHxYwzgv1y34EqS4YNKYUdFompm5?=
 =?us-ascii?Q?1L0AIyFIwPO9bpUmk3SnvYNoXIAnx1ldlcVAVhqeR0Re0Q7Aq5C0zFMIqnhy?=
 =?us-ascii?Q?bFPe9/t/+a78Dy0UKSPkv5p637K/H1pAi4bFFz6yqvjX+lOmxz/OFzQLP+oA?=
 =?us-ascii?Q?I7WmC7e4Y+c/DrQXj5KwQ6wC6PdIxSlX85vfzr8aUN6MEShC46uq9II7JOaI?=
 =?us-ascii?Q?/WaR29Uouyk0iTezWTZ8s39g4z7FO7oyP8p1IHiWm6epy4LBQ2p65kvavd4M?=
 =?us-ascii?Q?ncUUDWEEbjBWK4GXsBcW/8QAeuescvTwSrePx5ZueyyhOTxda2h4H/O2iuy/?=
 =?us-ascii?Q?WrKUjnqtdfZW9eqSsqhUdH/AcnlUUlUToloeZA++D63q9o8aTBVhzZDDyPzT?=
 =?us-ascii?Q?7e8dLyxl2c2YYsl1KGs1UYMnAQyEbYuy1Fa8PfriNA+htAMulH5KD2Fqvfy4?=
 =?us-ascii?Q?QXrxXPU1Fzuouee5uV2cR0eidtWxeB+2w8EkyJzSUx20/jsdawpwXMXAk3NP?=
 =?us-ascii?Q?hgK8Rum1w+2SzJEKEwHlawwan2wRIHSovF/IfkW5Puas5A5+iGnxc3/0ffyC?=
 =?us-ascii?Q?F11a3cBVtZaS51CDLn3zqqmPFRM4glzrJ8Yr7RbhDWATWbje03Mnsifaohlf?=
 =?us-ascii?Q?n5SkyXoLkq28Iwwrui8NCKU8GdkS/SDd3NjG6TAj2MVCWjkq53PokbcpTXAg?=
 =?us-ascii?Q?EojIziMvZUQ0itpcJY3ETXcgRWzhTS1l3rL3I/DxBSCuqnuvyjq1svw7kMWy?=
 =?us-ascii?Q?elKFIdS1OITIMgCj9enix1l4d7t0AwO5hpgnDyb8hevA39Xp8oAjNkts44Pk?=
 =?us-ascii?Q?iUYKlSYNAIaybcM1iz2bRc1KzETHZOoWZtzfeEV4A0fNqJZBaFzCbfEOKqgX?=
 =?us-ascii?Q?kHgLVPS6HhjoM3UCQpBXOYyPrZbm9ExEDDu2xvG5jRs+00x7l5vsYUuFaEOj?=
 =?us-ascii?Q?fybY3pxlatIlDMMjvNEgqZgQB3LhPbPzpEr0sOlB7+5a4Z4ZTNqkamuHosva?=
 =?us-ascii?Q?RgUDctJJidM08EEx8/3ZYYGTkVQRd7/pU2hXhGdDOkxowLF/1/2dmtB0tU6v?=
 =?us-ascii?Q?aL+En3okDB7WXIY5K8E0hM1af1xMAxRkDxxdIL90HVvZ8b9Hj1U4cVAgpV0E?=
 =?us-ascii?Q?rhM1jJOGNZbtUxOHnEzPQKxL5OYHQx0MAnOeu0JsbDm8Mh9re9LOgq/9o771?=
 =?us-ascii?Q?VLH98T6vOgoAaSqORI/ILpIeKbhB1nZkLFBMpVypUFEwQAm9tkJ6QTjnZBqj?=
 =?us-ascii?Q?GvVxDaVCDa3qCf3T5fgy4dAZyLqOtJXSwhhKl7l93UYDAqZBN+AdshIStj2t?=
 =?us-ascii?Q?/DL0Kvj/E14PPEmsZR/4XemyyyTrSk0ZTjO2saaYiW4ySfeTTV/62Tl7Y3yp?=
 =?us-ascii?Q?VHFNMJNgLgnQAHick0CdWA1wyXpbblgVEpUJEmmyK97atA/KV8sZWqtAcjmv?=
 =?us-ascii?Q?7JxCo69HL4gAPKBMQgpEmrDEZgkAgiVpFFI9TnRwqULA+PsWv/fo9XleHROx?=
 =?us-ascii?Q?aCJHFnko/bqMtG9w2BDy4rz/SgAPqLTgKOH/Sf+v4AKQdniPo3NUxa8Sin09?=
 =?us-ascii?Q?T7AW7gvRlgD8dZIOd0nvj24Q85EcuJ2aMgBM6GNl86AZbh9CdtPaCAoHDujp?=
 =?us-ascii?Q?sIRCZh1iBPzf5uqx49HOWosniz+opHBA9JqVFOWpZj9ffE0taVyvBCtH7APL?=
 =?us-ascii?Q?7tbFpJcBJenIsz0k9zwlGphaYzbXc3IWWCQAbXZAlvRRNjPjvE7F4wiGB4vj?=
 =?us-ascii?Q?U10OPoOoEg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3867.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08a5175-688c-4c5b-38c5-08de7635e1e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 19:24:52.7833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4J2mrs017SKw/PJVtudqcIVDdtG0PgtWkP2B5Yszgx4IMhmFLt8twWrs4EPxQXrMhCegheqdf29q8mcXm/GBXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR21MB6382
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9036-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 451F31BCBC0
X-Rspamd-Action: no action



> -----Original Message-----
> From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> Sent: Friday, February 27, 2026 3:15 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <DECUI@microsoft.com>; andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; leon@kernel.org;
> Long Li <longli@microsoft.com>; Konstantin Taranov
> <kotaranov@microsoft.com>; horms@kernel.org;
> shradhagupta@linux.microsoft.com; ssengar@linux.microsoft.com;
> ernis@linux.microsoft.com; Shiraz Saleem <shirazsaleem@microsoft.com>;
> linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org; Dipayaan Roy
> <dipayanroy@microsoft.com>
> Subject: [PATCH net-next, v2] net: mana: Trigger VF reset/recovery on
> health check failure due to HWC timeout
>=20
> The GF stats periodic query is used as mechanism to monitor HWC health
> check. If this HWC command times out, it is a strong indication that
> the device/SoC is in a faulty state and requires recovery.
>=20
> Today, when a timeout is detected, the driver marks
> hwc_timeout_occurred, clears cached stats, and stops rescheduling the
> periodic work. However, the device itself is left in the same failing
> state.
>=20
> Extend the timeout handling path to trigger the existing MANA VF
> recovery service by queueing a GDMA_EQE_HWC_RESET_REQUEST work item.
> This is expected to initiate the appropriate recovery flow by suspende
> resume first and if it fails then trigger a bus rescan.
>=20
> This change is intentionally limited to HWC command timeouts and does
> not trigger recovery for errors reported by the SoC as a normal command
> response.
>=20
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
> Changes in v2:
>   - Added common helper, proper clearing of gc flags.
> ---

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Thanks.


