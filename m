Return-Path: <linux-hyperv+bounces-9018-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFDXNBuwoGnUlgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9018-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 21:42:03 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C391AF397
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 21:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B46263018299
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 20:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5C546AEDF;
	Thu, 26 Feb 2026 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="B6VPzRhF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021133.outbound.protection.outlook.com [52.101.62.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD104611FD;
	Thu, 26 Feb 2026 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772138440; cv=fail; b=kg1VUqqrEwMl84eZOSURT4iqp2pvq2bc+e/azZ2VGRMbk2rV0Il6Wyq3pCkvBBcAZN2Z0jBp2YglhFBsSOYjlNtc3fIFdHRQTGdUHLcRe8P3o2gogw6BeU0pGf/uPQR02RyNNSwUznXuRs+s506rO9jMYyHM105UH2BLGEgpnI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772138440; c=relaxed/simple;
	bh=nPQlogu2dO3oFLNYuWsYVDLnNz1afhxsdzzo/Y0Ildg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O3z9tk3kuwFOE6ksqkiUhlChDPJXJd5uI4fLTdp7lgTCuICpQDUMYjbAPT/ZTwkDu5qlzbzYxDS+/k+cz+12NI6dLtcREb//aZZdmneeF2rovLGKWVgSlj0fJsMkyVnzuHpWZzYlAvUa6xJ2cMiyW4Duecb1afCQo+YJidnUsEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=B6VPzRhF; arc=fail smtp.client-ip=52.101.62.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6pgfitM5s7e5C1MydpPRDB6Slvq4MrxdYqyJ1cJCUMLcmaQHNC33MnVXmVHC3cPTsrSNJTS/kzfVo4JO13JDpHN3hWc7ysKyskWh77/3SEGp9C/ZNuAqkOKE9/hvUZtjjMIDEv2+JJrU2o0vAuz97W+0LN84rJBbMDNJvV5R963IgLBGF3Utl+ZQEf26xc24m9clym6EAjYiGpexbA+AdQPptyvJl+2WkmL72o9pRfQezhWGxS5mf0/DYA71fQXyNnxNThhnv4mJYpg1hvKdzo4HQqjDPRTaK7lOc361htzyilLzaz0R/N9SXlaxqUWQJHGjsHBCssjwK22n0zosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPQlogu2dO3oFLNYuWsYVDLnNz1afhxsdzzo/Y0Ildg=;
 b=GrnxKalVq+S8ion5Bia3CsSoEuSpSvktuZIAl6f/i5seYfGyeO+O1ySO7nw0VMSGGM//F/jRwkQ96rMPsTpxhgtP4lYZWFO3ovK88W7uSrlepa1tHO0xFnnOVRQgPUS6TvM7x3RP0+kpXrsYqcXfbJzbTFFEbONunCVfXXqjm2FsV3WSPRAKGucMmHs5ei0EVRpRSbvg12pj9esqr6N2dsK2u8/nVPE05PDlXafgrCjXCz/jtudOfMagadaaepJlznVGq/6JdZG10lMosoq4OF2KmJ/Vffz2/9knykE+ltO7J9br8Qyw21p5C34cfsJn72UNoSJ/W5p8S1iyYx7eLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPQlogu2dO3oFLNYuWsYVDLnNz1afhxsdzzo/Y0Ildg=;
 b=B6VPzRhFPU1PBDkcx87sY/MX+yjSLoWidiZ6FwVm+SaYgS4pGRBtnxPRVYtIzsJjoLDfereA2yu6SMRekHRowyUINpZkfPa3rkquZ53cKIt2mIVdzG9UEcHy6V3I7VMJkfSURzKJzsmkYNng4iuRgtjUBP2enHIGeln/ZJ3gJwc=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by LV4PR21MB6751.namprd21.prod.outlook.com (2603:10b6:408:357::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.9; Thu, 26 Feb
 2026 20:40:33 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9678.008; Thu, 26 Feb 2026
 20:40:33 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Long Li <longli@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Long Li
	<longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Shradha Gupta <shradhagupta@linux.microsoft.com>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net v2] net: mana: Ring doorbell at 4 CQ wraparounds
Thread-Topic: [PATCH net v2] net: mana: Ring doorbell at 4 CQ wraparounds
Thread-Index: AQHcp1YfNnhXh6DjLUC+foiYIdZZLbWVcV3g
Date: Thu, 26 Feb 2026 20:40:33 +0000
Message-ID:
 <SA3PR21MB3867C66522EAC16C3BBEE907CA72A@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <20260226192833.1050807-1-longli@microsoft.com>
In-Reply-To: <20260226192833.1050807-1-longli@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bf0665bb-d438-4ee2-969b-5f6aa02c8d09;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-26T20:39:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|LV4PR21MB6751:EE_
x-ms-office365-filtering-correlation-id: c884b157-6847-4b69-c3b3-08de757749eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700021;
x-microsoft-antispam-message-info:
 +JyeQYatR2XOpHHsS60TQjGWj4+tzxY+5Fz+BuxzZG2sn8klbda+lNYSjYjxf55XT/4coW4V47WwG9A77tSCdrzRtPxLpLx2E4LxsMJiziYc43pjZWGfbTKnorbwU7s9/xozAmVmIDfDAYizuVN5pE9EhVSf0UP1iZNGHdqCNWu/9mXWoMLT70wHgZOUY4LgCyTAAmsE4X4wDtpI8MNe/ON+WgBpD16qSUeznNxSCmRK75nujg8hMiUVX1MlN3kFPk4uwiKcxAx8k2aYsapPTPxRfOETDO5DOEBZCumGiv5BQacrpxOiBybpkqi1ztNm2/gZPLPPdTXC6ufGzKWnlPOM/XSf9YPFFeEnIW60Hq3L6zEhprBDFXTKXB0BMckjYiZoUmVRo1vSKb0Qo8EOa582XOJBQAIzvi3aX1wp9HMh4O3QxaDCqZr/GHU3pBzNlbogysCDfev0Mz+y/2ftafQGKnPwMGG4C8g55kRJlKYSCSszAB8+cfTs+z16p8So8ykcsjoDowdRaaQE4oXT8hJJB5fj2O41NtDLNJTtAUAzwKBG2B54baG0+Y/Ku2lmra7GfqvcZzdNkbjh/emO6mTzLepu+byeVZB3VXyDZIFS00m+3WcknmmO624qARNTtTfhFwKEDhw4BmLMH9Hlb9aPNAuAHR4HZlJPPx5PhSC7XPhGn2ZSWT0EFPoFtmycUDCavsXSBLLc8sB9GvVofnOw+girQHw2qJqLXmtGt8poBGWDO3nXv2lr24g5rK2lAkV52r/AyncwCQCpu3/t1OvULmuDlbcU3mjU4vLcz0TXEAgQ0BHMagFZfjDUTxW+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MzhOQJaSBXe2O1lMfSgJXXJ0R7JPucVWvGfeeD026yqTo5CMLbyvhr2yqF6B?=
 =?us-ascii?Q?nf/zAiytpIGsYeF6acYjC6pDokJ45LILPvb8DUwxz0pb72PQsL1F+VRAaVLR?=
 =?us-ascii?Q?n00cttMSzkFYYGtFSzTKGKF6w3rjFB2Y92R7e+896Vs5w5Wr2mlpohF0Ukif?=
 =?us-ascii?Q?Cgm/Fv9FqdDpoN+W12pOXLs/OWq4+QA45WpXQX0lkYHp7YCSAV1XE3SG3oCr?=
 =?us-ascii?Q?2B2uJhrZ5SbG6+EAStSdI5hwHEzVMSjXWICs82DJtaw9B5REvCezSr4X3T03?=
 =?us-ascii?Q?GxIdn1bmdR0IcMy/u9XUpFbOjVOLO1A9dAyu7PjflXu8EwRirJvJf8/WOMBD?=
 =?us-ascii?Q?lE/cb8p5d2kTEQnuDcOhgDb+B0Gjcq8hz0zM8GK+jc3UHb5CSCIO2xuE7zwX?=
 =?us-ascii?Q?sB1pNrXHmzqrQuweQdFD799VIa2LX/JNoYZay5+FaRHARthpSeEtLALX3Fwt?=
 =?us-ascii?Q?8s/pLJSP9d52p4ufmnlYtjNWYzLQ94QF5i8QJC9gDIYBU54FEHR4N2iambOF?=
 =?us-ascii?Q?AkwBUnhmJZuTPvKTqr7GuMo/HIoWHG847UmmZ4mDc9WNmmeZLs44RikhHyJA?=
 =?us-ascii?Q?nzCQv4n74vofWChrqCeOPJjS5WUINvd16WAgwsxABYzLBBNR2PWkq/BdEymR?=
 =?us-ascii?Q?vF/PuWUlyfEVjgegZiz7b7n2oAbNgfZCLdiZ9e9e0BFQHUkUVRWzZ5s+GpEl?=
 =?us-ascii?Q?JEYqbs/ZNlj1d0rnccUFk0A5+SVQ+msdLt9PMbRHMGfqw/LqAQ1fCY09vO/X?=
 =?us-ascii?Q?JKIqgnUmSePWxoHG33oFOAaqMyVSfHq5Gdx+znZJ8gtlo9U4lwpFbQEK6AUb?=
 =?us-ascii?Q?b8zh/2q4UtIaqldUF1e0zB1j+8IDYfkcHk92IHPyzmxIvmShfqe3/MM3I62A?=
 =?us-ascii?Q?q+913vWiVWCVvWLkbSkgsNU62/eqXjtGNnAbL6QfQaAIA4Bw3ahMwN/ApBWh?=
 =?us-ascii?Q?JTrFz3ceJGtIepAAwSnfWRcWioUmTD4+Ii6VjCYidmtVTaqZlbiZ9bPWOByF?=
 =?us-ascii?Q?+Rq/dlh9DD322533DyzEmiMLsuwny02TA/xQgUxMHPARunDvdrcfTdbRhtcn?=
 =?us-ascii?Q?4rz/3IMnb1BbiC52b0Vm2919gRiePuyLbnsWAntQ48eiz9pJDMsqI/rQnxjK?=
 =?us-ascii?Q?I9J099GI9ImFd1tqogQI97rkj1Ej0ETuIuazAVOJ+elmIS+Q73/nJNBbmbGQ?=
 =?us-ascii?Q?lNsqSJvTa0vA58/DxXVgv9XQdGHJl4NzxjrexWPXgiuwJnQL8qTIpkYTHsnW?=
 =?us-ascii?Q?0E2q5Tj1UHNLleOV1BHJMHnbNNe5HMX94X/4quhhuFfsdPUuXpGZjv41Cz5N?=
 =?us-ascii?Q?oqRqFePEugskPrSGWYLM9RBv5yjsuDS8FJjfU3jpkEJ+ArrKusQ+K4M/Vo4s?=
 =?us-ascii?Q?n6spwU7uibWLLDfwrDTw2TMm6rO5DxS+LC1h2DgbxhTfUTNPUpcvAdqxQdLF?=
 =?us-ascii?Q?hjiP0+qiKVKlz2Tz3L9dHe3bjZ1HpNJC5alPhbSRG0Z0Ve/TZj9c+QhqkXw9?=
 =?us-ascii?Q?yu/M7xfLZRqRzeKEUSR4R/FLQ0ZS+5FAiutgFBEqt4E46LWcTCW2oNhdUi69?=
 =?us-ascii?Q?HlI62tdITsvhOt9PbPyzw2AH7NXpLBU4Dq7Shjrwc4cawqZ7VNwENo7W7Bpb?=
 =?us-ascii?Q?CertEp3YX1WS83K963aLz16XqRmKSO1RoUGXoL3iR1W4G90C650sKKEIyc5b?=
 =?us-ascii?Q?ZLx/rJgZ0ZZ/+KMELT50/KUxKR2aLXnsYhWvVgcFYCaTXht6OCDrObJ9Tuwp?=
 =?us-ascii?Q?MZjCzQHYsw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c884b157-6847-4b69-c3b3-08de757749eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 20:40:33.4317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PRHFuc86aKmq2z2qZ2uJw97fw7UAtxKvu+C1GCRbCddNOeclGhQ47rP3/7yU+EhPoSQ7Lb1SlC8fc4roLGziKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR21MB6751
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
	TAGGED_FROM(0.00)[bounces-9018-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davemloft.net:email,SA3PR21MB3867.namprd21.prod.outlook.com:mid]
X-Rspamd-Queue-Id: C0C391AF397
X-Rspamd-Action: no action



> -----Original Message-----
> From: Long Li <longli@microsoft.com>
> Sent: Thursday, February 26, 2026 2:29 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <DECUI@microsoft.com>; Long Li <longli@microsoft.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>
> Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>; Erni Sri Satya
> Vennela <ernis@linux.microsoft.com>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org
> Subject: [PATCH net v2] net: mana: Ring doorbell at 4 CQ wraparounds
>=20
> MANA hardware requires at least one doorbell ring every 8 wraparounds
> of the CQ. The driver rings the doorbell as a form of flow control to
> inform hardware that CQEs have been consumed.
>=20
> The NAPI poll functions mana_poll_tx_cq() and mana_poll_rx_cq() can
> poll up to CQE_POLLING_BUFFER (512) completions per call. If the CQ
> has fewer than 512 entries, a single poll call can process more than
> 4 wraparounds without ringing the doorbell. The doorbell threshold
> check also uses ">" instead of ">=3D", delaying the ring by one extra
> CQE beyond 4 wraparounds. Combined, these issues can cause the driver
> to exceed the 8-wraparound hardware limit, leading to missed
> completions and stalled queues.
>=20
> Fix this by capping the number of CQEs polled per call to 4 wraparounds
> of the CQ in both TX and RX paths. Also change the doorbell threshold
> from ">" to ">=3D" so the doorbell is rung as soon as 4 wraparounds are
> reached.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 58a63729c957 ("net: mana: Fix doorbell out of order violation and
> avoid unnecessary doorbell rings")
> Signed-off-by: Long Li <longli@microsoft.com>
> ---

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>


