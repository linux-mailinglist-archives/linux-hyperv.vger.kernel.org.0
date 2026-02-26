Return-Path: <linux-hyperv+bounces-9017-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OhIDeakoGk9lQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9017-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 20:54:14 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D15021AEBCC
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 20:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9581302B392
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 19:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCABA4657E6;
	Thu, 26 Feb 2026 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KK/t+d6Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023105.outbound.protection.outlook.com [40.107.201.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0C84534BF;
	Thu, 26 Feb 2026 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772135317; cv=fail; b=jl44FjJjSwyGasEdbCFdF7yfJM9D+Lnom6CGWRbL/8tmG0b7IdmyLZRGF4vE54mvEawDK6WsEFrdVHL8ybLVTxxZ2523dHNMyWtWyjSNoD67Xla27PVtMJv3rUWkLP82kWk/5w3DRO9Zz7TU/DTuLOj0yuXKQ7YYbItrVLysZVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772135317; c=relaxed/simple;
	bh=6ZhFEuT1xaxqqezxyPpHIbf8Jfy8fsOa+uXVbD7EKWI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VkjTr6nTnnX/GN/z+cgupBHtgkq9UVT2eaMo1HVIWP933EmX6NTbZOLBvRUdeOSxIAy/QkfjD9E+tFAu9RIZSIM66ZdkEO66eXUVUXy44w9///ASRvIe6BmBjDBO9WnwKRuzOUxfiAGtnoMH/0xpRu0bR1ePtSALG1rAKlDf2Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=KK/t+d6Y; arc=fail smtp.client-ip=40.107.201.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbbXZrX6zJ5OhoWh3nQL2TyjdeZ7WQksXy1Dj76X6IdGS3JgWSZWLuV1ziqbbNUFoAyDzB2Njkfl2Xx2kwBmD4lMDmfB4KiFS/fASY+rV4yYodUT1DEr2LNO1cY9t1cz76hKJLumS/DcdBAkhOub89GML4NCzGbMEiFRVJzzVp/UuDQis2ouB0nNSfvgB1sx2hOccfRFyozht1A+xqeRExNJ3pvD1e3tT4PJpepooNZQfTebiymC/WATxWPOEysIJ+rmRMhgUFjLAWW5UygXwuKk1Jw5mIX8ylC7Uj0btAoGoTmuL9XEcYjnlCNiAMwYeZ9LDaFDV6p7WfkHKcSJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBRjUzBd33cu85rAUs6b1PvgsWzymJ+vXXZxsKL/ZW8=;
 b=GJnQRiTH5gDvIV8SnA482uC9vdEObsLlEr/DdqGjeqlbB2K9J4m4ID321thfr+yURSpJ8WUs+oLwLlZC3t1z/F9GZjjqD3aWLKrGsAjiHwubRBnsFdXiERtVxMR/h7xqqPnEPJvxl3skO/oBh1qD5URffHDAY/URZargyFmJeddmSAEBOaM4u9oVgUnu7GMeErN2MjwF6Qh9x+efT8TxCxfNctzqJ62ghQC6s29PZpUn9+vGTXYv5JO7yiDdllU5XTQNCYPR5ec0HOU1ZNKRHz5g4rWP7XHfkxkAjoZItiK3c6pWbm/5AT9txXsYCsq/UReCopeC7jSEM/e3iYsPKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBRjUzBd33cu85rAUs6b1PvgsWzymJ+vXXZxsKL/ZW8=;
 b=KK/t+d6Y3gJQQznHD7bzB7CV+7MFZlza7VSIcN8+lqXR3nJzPAQuFtkb5POXs38NpUdOb8GcUr5/fCuieYbEi3CPSnj891BNhItB2dGTu6m5SrZKumTNAIH4rxQl5i3KOzB1Nlx9Ta1IEhrCVcW5uGKNMCSdleoro51TaAU5b2s=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DSWPR21MB6966.namprd21.prod.outlook.com (2603:10b6:8:35f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.9; Thu, 26 Feb
 2026 19:48:30 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%5]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 19:48:31 +0000
From: Long Li <longli@microsoft.com>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>, "horms@kernel.org"
	<horms@kernel.org>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "ernis@linux.microsoft.com"
	<ernis@linux.microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Dipayaan Roy
	<dipayanroy@microsoft.com>
Subject: RE: [PATCH, net-next] net: mana: Trigger VF reset/recovery on health
 check failure due to HWC timeout
Thread-Topic: [PATCH, net-next] net: mana: Trigger VF reset/recovery on health
 check failure due to HWC timeout
Thread-Index: AQHcpKEB0nVc09Lh2069xcpeS8HmdrWVZ0Qw
Date: Thu, 26 Feb 2026 19:48:31 +0000
Message-ID:
 <DS3PR21MB5735F00E300CB4B7E54DA710CE72A@DS3PR21MB5735.namprd21.prod.outlook.com>
References:
 <aZwUDlTkb5xunIkH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <aZwUDlTkb5xunIkH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0f825b0a-340c-433d-bb1f-6481016ef6ce;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-26T19:44:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DSWPR21MB6966:EE_
x-ms-office365-filtering-correlation-id: 10aa41a7-f7be-4433-3bcc-08de757004fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info:
 bx3iuiRuhaKuvCIUBtFxKllulZVcnMb59ozP1bGJ/Du7xrRkIzThg5Uio0cs9BDUPshOG26XOAZZiw6sLES1TJLwLtqlh3A3fSNhVqQj5Nbo2uQxp2q/fF9WIFZTKV5EjnXdCOTPBgxRpWxXm9HiY0VFywdAf6kbuZVk4h0Ej3emPISd1iahFTLsTYT6p4vaU9jGYgybkcqtRql0OYq04z02WOF6X9wAh2uKmrxUO4ZGXtXV69GD6VtkAfNlVPfOtZHZ/6PAIHBQn/i6yumDSNd06RsCcJvpVxoh52jqq8ATSRuAA3i6wYBkG4p5khunKZKlXmOUjTMBdwTsEGePlVmh8Aq9ikmc32VPacqwOeDJ5RxUw4V+NVTRBj1tOzBEMUEz3X5rkMqaW2cjT7soF/DnmU6C5rAKUEaC2UVjXbBz4jrhXXrP/8eWGrLZdn3pWZoEeqeFcUVdwOfUrKKGEI8y/zeQaCYEdiA3mTMMQ7SKmmJ/X2Iy7isbWeqI8m4VacsRG/aO+DEqXu9HQ4EBdTadhJ4egZzqOH995R2MfiEy4cl+z+cuH4rS7TOkI77RbxC12FB1guKioOBkHQ5COWr7YXn13fV8oAIAXC6+8fakSrnZsGcFXEhpMgxd1gIF0wZvAbS9OlJnGKG5M9QWdOUbpJfqPGSyvVAA29IwcCoZXdx79iVKFm4VMHRIKEQKd0kIiE92zoNNjOxFImUAGonL3Z2tJpx0ICUVsZ7WBtgZyLp64Iqw30hevl6INoX9oyvEyYXinPQj/7zU4IcGs6jFgxR2HKCxOkDIxAfpp5vvjoxHj9SkHH27dE6RIHGV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5735.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?j8gdug8iRWpeRiQ3HlZCGp9P8niZt2mVrpEN49+5fKfbK6CMC/M4G6byMH4e?=
 =?us-ascii?Q?OOh1BqZHWUjPdpN+j95hSd7MCMbbXFbotxQvT3U4aarY2WoX5HPL3RD90ca7?=
 =?us-ascii?Q?ukzVWVqY0NCLWO54X9Q43b+Lgay/WSCuvqRqZ4krsXy3UAGogrH6PLM58sO4?=
 =?us-ascii?Q?WLWafsipMa3MbaG+vHcrZ5EK+mURWUi7SBr0FcWv/enH8cRfPRaqNuCDyjQz?=
 =?us-ascii?Q?3YgwJ5R48xmV5dNXBpjM9qP3nT+8xJDVPIREW5ZCT9b/29NJcvBnHKOq5Gal?=
 =?us-ascii?Q?/STMgd6AlGRtE5RoZS0q3lX3r6RzW9mczt2enON7YmGBPutprBXpALSUTU2F?=
 =?us-ascii?Q?kxetk+VsZDW3QjyYM3xqAUlmsWzr3FHFnV6uFrOFMsNiLiDJ3hpTw8iO5763?=
 =?us-ascii?Q?Rr05DMErNKf3I5fMv0P+gVX5pobpMFIgseI2heshcxCeDhTkW1aHE7doBHlw?=
 =?us-ascii?Q?/7fxJXfp49+j7ykkHen8Pf6/qKCi6msa2rK5bqKs/n8V6UoS9/hDm2L17y9g?=
 =?us-ascii?Q?4Z+1pn6LMvpAA+DdasP2dAS3dS1Vi5/CX+YG9Q84gobIZBkTjm8ukboUl+cP?=
 =?us-ascii?Q?Buu39l/r+9UibUdh1E2SuoE4WOqaoAs8yeJpDnotdPs6tMljZVMwFsSG7f+7?=
 =?us-ascii?Q?lB/wLoI0BlfJ1e1f16AbKmkK1jHJN9lfpQS5+hIWsNzq9f4m+iGT9DcBiHN/?=
 =?us-ascii?Q?3N/w7XZ+zEBwI41iQQYXaXqEc6Xg8E96mRJYIym17lYzlXUaA3jXpITPrS0t?=
 =?us-ascii?Q?qqLIKizCkRWfkzHRdsf1BrCosyIiIGpF2PxbNudIjn4wdQB4ix9gvi+MV30v?=
 =?us-ascii?Q?ESqRBcknZ6bOnB8I6BGvaOUQ1KbGcderBJftdbEOGrzLsAijCIq5ih5ygja8?=
 =?us-ascii?Q?jpsJ0vK++99+2TvqsgeDYV+ig6Pt9mYb51sFStaPl4WLgS9c08BQ25itcUbd?=
 =?us-ascii?Q?GZcBL4rhEKI4KQ/jYtFZX5rqvSwdDPQCSTdsLxTsWd2vPvI9IMde8b7q+c/1?=
 =?us-ascii?Q?U6rI8rhDvC8wKgsaZ7eDJ3ENTPLa7jLbUR/ce5bn95dezY7/dEiHPggUEhhs?=
 =?us-ascii?Q?mpS2sE4UJu4cVlkYbChcvi9ZHnIwlhc1AMJFRB4dogAC4vQKDMclRfrGa5k3?=
 =?us-ascii?Q?yq+tH8K5hROmqGv485TeHUOmA9U8bLPWvVo6dzbSGBECvWsQZJFWr1TejEXO?=
 =?us-ascii?Q?dW1hKvEChdRh5qkviCeOJpyOSXMaE3EeWwGqHuOaURG7Oh/Tt1RogrLCcojm?=
 =?us-ascii?Q?LzpHn1+Q5YNWZy8k2K6O04AsymhIuvhHuNnK5zs2sPZe7vHynmg1WBMFtBHd?=
 =?us-ascii?Q?IGwihM6cObV+DHO6GuT6pPxWNUGoMiZaXOuldvuNNf1HKQYDN3mLIHqoJqxi?=
 =?us-ascii?Q?iw7yzYmPaYg9KkjRDXhetTtuGFPk3hVYUlp+bbZD8rajNW0KGhUsvzzelApA?=
 =?us-ascii?Q?/uheD05gBurwpixZXoOhaU1t5MByi7xEBADcr7Nz4LrY84GtlsBE2V82OHCf?=
 =?us-ascii?Q?lO9V0TfJgO5rRgliLrg1zFWqY/w5/+2hY5y2EvMVha2acbCHuKWELCj2SXBO?=
 =?us-ascii?Q?fEn3GA2MxcponXYFI2jM7wXtRfAhLddMxLhjh+uXU0tDuq7lcqqWdObI4H7j?=
 =?us-ascii?Q?EL8cHeu21743T5o1eRx5w2Qyg0fnZNFF03Z3jo/aQHODLQXBjBMYnSZoRzjb?=
 =?us-ascii?Q?iKNssCxboJcIjzJwMkBYX6m/KS3BNT+jc0j4FYy0BUA/kwIA?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10aa41a7-f7be-4433-3bcc-08de757004fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 19:48:31.3468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sRg9lUm4QwVQb7+S4dzzHNI41+DxN2hKctUXIC5anuUwSL3+k1XrNwi+dP0dyEGcoZlLM76mt0PaTYS696mcsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR21MB6966
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9017-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[DS3PR21MB5735.namprd21.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D15021AEBCC
X-Rspamd-Action: no action

> The GF stats periodic query is used as mechanism to monitor HWC health ch=
eck.
> If this HWC command times out, it is a strong indication that the device/=
SoC is in a
> faulty state and requires recovery.
>=20
> Today, when a timeout is detected, the driver marks hwc_timeout_occurred,
> clears cached stats, and stops rescheduling the periodic work. However, t=
he
> device itself is left in the same failing state.
>=20
> Extend the timeout handling path to trigger the existing MANA VF recovery
> service by queueing a GDMA_EQE_HWC_RESET_REQUEST work item.
> This is expected to initiate the appropriate recovery flow by suspende re=
sume
> first and if it fails then trigger a bus rescan.
>=20
> This change is intentionally limited to HWC command timeouts and does not
> trigger recovery for errors reported by the SoC as a normal command respo=
nse.
>=20
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 14 +++-------
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 28 ++++++++++++++++++-
>  include/net/mana/gdma.h                       | 16 +++++++++--
>  3 files changed, 45 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 0055c231acf6..16c438d2aaa3 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -490,15 +490,9 @@ static void mana_serv_reset(struct pci_dev *pdev)
>  		dev_info(&pdev->dev, "MANA reset cycle completed\n");
>=20
>  out:
> -	gc->in_service =3D false;
> +	clear_bit(GC_IN_SERVICE, &gc->flags);
>  }
>=20
> -struct mana_serv_work {
> -	struct work_struct serv_work;
> -	struct pci_dev *pdev;
> -	enum gdma_eqe_type type;
> -};
> -
>  static void mana_do_service(enum gdma_eqe_type type, struct pci_dev *pde=
v)
> {
>  	switch (type) {
> @@ -542,7 +536,7 @@ static void mana_recovery_delayed_func(struct
> work_struct *w)
>  	spin_unlock_irqrestore(&work->lock, flags);  }
>=20
> -static void mana_serv_func(struct work_struct *w)
> +void mana_serv_func(struct work_struct *w)
>  {
>  	struct mana_serv_work *mns_wk;
>  	struct pci_dev *pdev;
> @@ -624,7 +618,7 @@ static void mana_gd_process_eqe(struct gdma_queue
> *eq)
>  			break;
>  		}
>=20
> -		if (gc->in_service) {
> +		if (test_bit(GC_IN_SERVICE, &gc->flags)) {
>  			dev_info(gc->dev, "Already in service\n");
>  			break;
>  		}
> @@ -641,7 +635,7 @@ static void mana_gd_process_eqe(struct gdma_queue
> *eq)
>  		}
>=20
>  		dev_info(gc->dev, "Start MANA service type:%d\n", type);
> -		gc->in_service =3D true;
> +		set_bit(GC_IN_SERVICE, &gc->flags);
>  		mns_wk->pdev =3D to_pci_dev(gc->dev);
>  		mns_wk->type =3D type;
>  		pci_dev_get(mns_wk->pdev);
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 91c418097284..8da574cf06f2 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -879,7 +879,7 @@ static void mana_tx_timeout(struct net_device *netdev=
,
> unsigned int txqueue)
>  	struct gdma_context *gc =3D ac->gdma_dev->gdma_context;
>=20
>  	/* Already in service, hence tx queue reset is not required.*/
> -	if (gc->in_service)
> +	if (test_bit(GC_IN_SERVICE, &gc->flags))
>  		return;
>=20
>  	/* Note: If there are pending queue reset work for this port(apc), @@ -
> 3533,6 +3533,8 @@ static void mana_gf_stats_work_handler(struct work_stru=
ct
> *work)  {
>  	struct mana_context *ac =3D
>  		container_of(to_delayed_work(work), struct mana_context,
> gf_stats_work);
> +	struct gdma_context *gc =3D ac->gdma_dev->gdma_context;
> +	struct mana_serv_work *mns_wk;
>  	int err;
>=20
>  	err =3D mana_query_gf_stats(ac);
> @@ -3540,6 +3542,30 @@ static void mana_gf_stats_work_handler(struct
> work_struct *work)
>  		/* HWC timeout detected - reset stats and stop rescheduling */
>  		ac->hwc_timeout_occurred =3D true;
>  		memset(&ac->hc_stats, 0, sizeof(ac->hc_stats));
> +		dev_warn(gc->dev,
> +			 "Gf stats wk handler: gf stats query timed out.\n");
> +
> +		/* As HWC timed out, indicating a faulty HW state and needs a
> +		 * reset.
> +		 */
> +		if (!test_and_set_bit(GC_IN_SERVICE, &gc->flags)) {
> +			if (!try_module_get(THIS_MODULE)) {
> +				dev_info(gc->dev, "Module is unloading\n");
> +				return;
> +			}
> +
> +			mns_wk =3D kzalloc(sizeof(*mns_wk), GFP_ATOMIC);
> +			if (!mns_wk) {
> +				module_put(THIS_MODULE);

Maybe it's not necessary: check if you want to call  clear_bit(GC_IN_SERVIC=
E, &gc->flags) here?

> +				return;
> +			}
> +
> +			mns_wk->pdev =3D to_pci_dev(gc->dev);
> +			mns_wk->type =3D GDMA_EQE_HWC_RESET_REQUEST;
> +			pci_dev_get(mns_wk->pdev);
> +			INIT_WORK(&mns_wk->serv_work, mana_serv_func);
> +			schedule_work(&mns_wk->serv_work);
> +		}
>  		return;
>  	}
>  	schedule_delayed_work(&ac->gf_stats_work,
> MANA_GF_STATS_PERIOD); diff --git a/include/net/mana/gdma.h


