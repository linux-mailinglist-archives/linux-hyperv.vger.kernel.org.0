Return-Path: <linux-hyperv+bounces-10074-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sM+ILpn31Wn4/gcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10074-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 08:37:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 425C73B79ED
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 08:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E87DD301D302
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2026 06:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907F5285050;
	Wed,  8 Apr 2026 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BHPNsoQi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021126.outbound.protection.outlook.com [40.93.194.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A0B13635E;
	Wed,  8 Apr 2026 06:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775630227; cv=fail; b=osNFe3LUgrQaY6PaDPaxKuX0pkoi6JBp13twuAoxh23ZwCwknHU3Lg9FGglwsEMt0jrVCcnAqqQ9JL4h/NUhHHrFIFoUlqpsn1rZoZsZRFN7L511vyUgiuuDPUtSLIOYviP70wSkiFW93ewbHC3Sx+xhZuystQdl3WQr1UrZtMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775630227; c=relaxed/simple;
	bh=NZadV6yu4FKajW/hwofgEkn2K2u9oL8imPLolk1AOZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sz9+4riv/5j1qxJn8nRcZq7O+qI5A+DM/zW/2jRdXmqtRn10zTNSFNZskA37Lv///pCD4VNBkWWuJA91xyo2lQU21d/hDv0MrqlAHWLqjI8AbAM1EjAKoZFAqYUBBFgvAF/3SJG69mCjhSZ2j06eLsN7Oog486BC81m9yu3rYuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=BHPNsoQi; arc=fail smtp.client-ip=40.93.194.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekJfUSNmKS8MAx9Nx4GYTI4mcyH0P3hfyu+XHiWEl9zfWS91cKxYi5H0f7mxSRLTrPXVAP9mGy3XErO02yYPA6QnBtuZAzcsMmxB3c4y+wE/ultNmbYGbcSY+luB9rUZk91W6Vbx/iGIIJQB7/C5KWjkIsAKjz8LVXTgBYEoP56fS94oSr3Z4v0hk7T4Rb4ZRQOgPA+ClUAk/czwEUrgsWqkc4SGg+7aO/8dm35lbZbvJ5bxR/KEEOu0vq/NOjf9gi0Sh2pv2xUtMuW3IspmTDVRPi35vRblu6dv+61b8WXrN6zexSQ90kdPmFvAU/ik363A8M1tz/EkmAQKhMtPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpvcuKnBSKSU4mnOBCrRymVepKzYRkrVYw0l6MaCEE4=;
 b=OuLLVBdzsP6sF8VhkLEzoLUh/va1ScFksLfF7PrlQ/a1bsiY6z7YJgryVWCwW8A0juPb6s+8FYEyKh1I7pZnnHCEX58a78fTAqYQvL3JleiPGsQG6g8APJo6Q7uKNkc1sxw1vy33p0qhU86WqDqZHgUy/cld5oF02+QX2kBMV1jRA9dY9vbxvGR0iOsypeHeXPXqPoTc3Hnrl7MWg6/syqSN+IcBMLnTy+XpEJt5Mt9P3UD8UNQwI/qiUKwQZJ2vWOwGVcodBFP8uT4dFZ3dYVDT5ec+vFAWGwQcvGN5wvqBZYSD7ujLZXHwaqyOeJ+rnYp43omVNnJ1Xve5clXWaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpvcuKnBSKSU4mnOBCrRymVepKzYRkrVYw0l6MaCEE4=;
 b=BHPNsoQiWiK9SRbdv8HqxXIfWzFKumYZ5GrCyBo8YGuq8jXRXOaTmjCta7KCPv9elvgXnpXzbI3aUGTdB20YAIHmiDcXWkFH0v3FoVUDtGRZvYOe/g593OQTvOh9PVh5f02RDFykmbq04uMFOW0anOtK0SnQB8rWNbZnUiSfIOI=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA1PR21MB6201.namprd21.prod.outlook.com (2603:10b6:806:4a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.8; Wed, 8 Apr
 2026 06:37:03 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 06:37:03 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, Matthew Ruffell
	<matthew.ruffell@canonical.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Jake Oshins <jakeo@microsoft.com>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, KY Srinivasan
	<kys@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Long Li <longli@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>
Subject: RE: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Topic: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Index:
 AQHci0NePIGSa/9NGkCUvIR93cd3gLVdwUXwgADOvQCAABBuYIAAnjqAgAALUwCAAMhuoIBsfVtQgAT9UMCAA5rD8A==
Date: Wed, 8 Apr 2026 06:37:03 +0000
Message-ID:
 <SA1PR21MB69216C00774F3AE9B306748ABF5BA@SA1PR21MB6921.namprd21.prod.outlook.com>
References:
 <SN6PR02MB4157545DAFDCCE0028439DB2D497A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260123053909.95584-1-matthew.ruffell@canonical.com>
 <SN6PR02MB41573CD2EA6CD82A0C238F66D494A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB415759DBA9428256D379841AD494A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB69213185A6FE899BD2D4BFC3BF51A@SA1PR21MB6921.namprd21.prod.outlook.com>
 <SN6PR02MB4157F48F3B37D74E3A9F1AFBD45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157F48F3B37D74E3A9F1AFBD45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d75cc511-7c8e-4c16-9c76-62720ea69a12;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-08T06:16:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA1PR21MB6201:EE_
x-ms-office365-filtering-correlation-id: f27cffe2-ddb9-4e2f-898d-08de95393ebf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 dS34Uu9HZQ49jZxBJsHoB2ry76o3EiyNtuLjZ8865GzHWK2E94IdDErywOhgKocilSKUs8Dx6zEMV9tsa4itS2SuytDoVljhkHb1L/nviNe9QMSXCDBqN8dGg/q3quG6LHoO28zm5P8DTLFL/CNQBl7bmHaoX5Htgsf2uGM+4fIEGgmIhW89oLKlgCpV0WgFVcJxvouV/VCfQQmEv4BjWtYXLBooRL6ZhNiuAYYBcHjzJ4BeLmShieCxnpL9OBWlmEggjxKOjiB2f5qX5tpkPTQkciOxV9EtFAhYzjwrD5dEpUjShMSM7kMdeZlB84XdjNd3putLyGLXIMiFHsIZywpzPQoUAx3sIAX4lUPYRjaTMTTFWX7pXOhk4zs9BELvOjQZ9F0O7qSzC1DpD056rbSxB1gJOwO91YwoKOf787vPSNYof8GVXsS4bKiyqo5g5mNkGF5UbjVzDmjTxlGaULs031EVXm9UoV2MMJR2lLEw9MT5rURff9GM4gjF88ykbphFuGgYJAAJS3JWcrerTEFTZuh2rWHVNZiMvWnKN5+tt7Rr6hfGsijvC1F100Dff1RpSYZI2NIcuOfR+yXkNiXw/rNvR1RgQKYEYtNJLhyNLci10ccIr/TuQ1IhKGjYbCaSOoz5x1J9a2l7BBwo+5Kfx27T+WUla9avuBo2kd3smjnkORhGzetViJrIS5/I9UhiFCKBhumbYamkd6qdjELxx2GO8knDdrsC2i4rqDnd0EEck+gF7VsPmI1r8+mGAzR+bqcalVfOgT4sKzCxbVnj/clZ/INlbhXywaoTYjQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8hw1SpEMFy31dSrQL7AK5Q70SzZMbmUfih33Hyxj2iZ74ySOZf13VLd3un4O?=
 =?us-ascii?Q?bJhqlmNLR0WT5dVyOA5KGH41rm+gr8rHnVdsPMC2HXPm4zdsiSp/WFXpmnMJ?=
 =?us-ascii?Q?Af9dOLgwYbw34RaJSfCyuZvTgs+2096Y3He9zFl9aXPtFrvyACCvDj/tGF4h?=
 =?us-ascii?Q?XsZwbsTrf6E4nYKBww7FpLNJeEdbEdfF8IzkF8aSkrTKkjMlzmU2noKdy+4j?=
 =?us-ascii?Q?x81kpFvdQ9MDSCMWei8aLRPxOZB82s8Ek3+0uy44daPbZr7HXV5HFS5VYQPd?=
 =?us-ascii?Q?/CYaOrZxTgO8TzeFQM33OuUuDsVlnYS/bxhddhUFai6BS6cSh7Jdv13DyAJu?=
 =?us-ascii?Q?osri1kfSJSXawao0Z5qbRKP6tSoqQK+mj1F6R8tywHI8gYJFZ2Vi7qW94AUz?=
 =?us-ascii?Q?YafHsTiIWA5Ln3mEBQGjqVsMLL/mdE1V7zR6XbeFR1a5GXl5kiiC9IgAr7k+?=
 =?us-ascii?Q?STanlR+QU3OfcLxcsWh/ua6m1lCsfxr+rMRf44ix9ocDfyHiVDcrBkxMY5Hw?=
 =?us-ascii?Q?Zk1YEiqcA5NaFh9wRdQFYUxen1oCE4U5ojC+xZtXIa+atLJ/Eyx0M3T0hDUR?=
 =?us-ascii?Q?sCfgyk2HPQCqSz0EMp8ULSjgB9kLs2G9k6WYXL2rpDUyzQYk1/9K2QqlCGjY?=
 =?us-ascii?Q?PFA7Y7AEN+OM2itRlbWQYa58ZAMjNMGVgpTUELYJ2ZMOh2J0d5fwlk4Cuwm/?=
 =?us-ascii?Q?g5mVxm25bSaD6y9x8kGy3sEtvnGdEea9i7fgNSyll6+29eCEo6LB5WmOFrYY?=
 =?us-ascii?Q?X+rVi1k5jDQ+956sWKgyK+fHW4Sfgy5bAUzr8vlcQbeGNJxwPmUvffYvvk1y?=
 =?us-ascii?Q?RSii7uncVC5/PhXgN5NaGiNPgjyvBKkPeg+IJEclwhmWHpHK0Fj9Q6jI0v0H?=
 =?us-ascii?Q?RUwU8it7WV5BeuotHbXK/Utd1yX/qL4TQjMaKeg2K2AzngMq+eLMD3pKJ+RM?=
 =?us-ascii?Q?/uuI/NB58WBu19FJ0aPp6DW71hQKuYTQkUFu9hymHyYZ8ND4By/EIJ5/2aYF?=
 =?us-ascii?Q?sC6QUTsO4NlH8IPN0mH4lWno5kwArtg2UUuEmcPxhMLenYKZ5rpsvbHZOzMx?=
 =?us-ascii?Q?6cttsfgvzjDhKm935mURSh6vuS1H+bofgjzwMLcHNXnQxcK9nBxzK6HO8tkF?=
 =?us-ascii?Q?z/kEBkhfDCKKKehhR3m9/AOkQvPGuXpBgXvwAL2xMzvQEmB0oSbRAkiecFvy?=
 =?us-ascii?Q?s/sn/RihkKHhy+6sm3z5ysn0x7bPdPqGl7CIlAhsh02Agfx/0HzQH9exE1sm?=
 =?us-ascii?Q?0wk1mgesv0BQhJHsXOQydnUWiHxQFjvyYYpDhZPfL3+lvdapdyZDBy1tX9Y2?=
 =?us-ascii?Q?+eETpi9tP3HuCXTImvAaJlB0fTDUp0/2qZeqypqcM2ABuL6xAL0g3wHspOx/?=
 =?us-ascii?Q?6ctpN7BBYY88TPf/dbHSS9CCDQ9zzwkjQcovXdZ49kOuERVS31qlHZHpZUmy?=
 =?us-ascii?Q?E4yPbXVG3oYOnw1xxeIFAif6VdrGX+SK5I29473iGZm2pScggekOaY2PKSEU?=
 =?us-ascii?Q?eKhDLAFaFI/CM/XEJWbuW0/9L3VGnIoknOYvayBwyQEy61edY0sEaWbMrHME?=
 =?us-ascii?Q?bAQ91g3tQ+P2h2OX+xEvYIbNjj2NfKj76UzsiNXw9uRKPWpNuNpgxGHAz6qX?=
 =?us-ascii?Q?VAUuPDLImwH7UA/13jnRHPU6BoSUx8S5RAIRsN+wrtvUx8757RZSPryQIi+A?=
 =?us-ascii?Q?JnJWOnBqHYUYYw76W7M3Cn7k9E4D03l5w0iM8IWwR9MtET63?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f27cffe2-ddb9-4e2f-898d-08de95393ebf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 06:37:03.1483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ToqU4H+joWQA+frfpdnJHr7osf9+ZZTde4em2OEYm7l1L0mhcjzCYLC+u9gAdz8c4jibMpm8HHeiYO1rgJj3MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6201
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10074-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,canonical.com];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 425C73B79ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Sunday, April 5, 2026 4:13 PM
> > ...
> > 96959283a58d adds "select SYSFB if !HYPERV_VTL_MODE", but we can
> > still manually unset CONFIG_SYSFB (I happened to do this when debugging
> > the kdump issue), and hv_pci won't work.
>=20
> Just curious -- how would you manually unset CONFIG_SYSFB? The kernel
> makefile always resync's .config against the Kconfig rules, which would a=
dd
> CONFIG_SYSFB back again. The Kconfig files essentially say that removing
> CONFIG_SYSFB is an invalid configuration.

Sorry, my description above is wrong: on the mainline kernel that has
96959283a58d ("Drivers: hv: Always select CONFIG_SYSFB for Hyper-V guests")=
,
I'm unable to unset CONFIG_SYSFB.

When I was able to unset CONFIG_SYSFB, I was actually on Ubuntu 22.04
(Ubuntu-azure-6.8-6.8.0-1049.55_22.04.1, released in Feb 2026). I thought t=
he
kernel has 96959283a58d, but actually it doesn't...

> > IMO vmbus_reserve_fb() should unconditionally reserve the frame buffer
> > MMIO range. I'll post a patch like this:
> >
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -2395,10 +2398,8 @@ static void __maybe_unused
> vmbus_reserve_fb(void)
> >
> >         if (efi_enabled(EFI_BOOT)) {
> >                 /* Gen2 VM: get FB base from EFI framebuffer */
> > -               if (IS_ENABLED(CONFIG_SYSFB)) {
> > -                       start =3D sysfb_primary_display.screen.lfb_base=
;
> > -                       size =3D max_t(__u32, sysfb_primary_display.scr=
een.lfb_size,
> 0x800000);
> > -               }
> > +               start =3D sysfb_primary_display.screen.lfb_base;
> > +               size =3D max_t(__u32, sysfb_primary_display.screen.lfb_=
size,
> 0x800000);

Please ignore the change above.

> On arm64 the existence of sysfb_primary_display is conditional on
> several config variables, including CONFIG_SYSFB and CONFIG_EFI_EARLYCON.
> (see drivers/firmware/efi/efi-init.c) If you can take away CONFIG_SYSFB, =
you
> could also take away CONFIG_EFI_EARLYCON and end up with build error on
> arm64. So I'm not clear how this approach would be more robust against
> invalid .config changes.

Agreed. Then let's keep vmbus_reserve_fb() as is.

Thanks,
Dexuan


