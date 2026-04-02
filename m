Return-Path: <linux-hyperv+bounces-9932-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFi+LHC6zmmTpgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9932-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 20:50:24 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5338E38D69D
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 20:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE2FC301670C
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 18:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C1031C567;
	Thu,  2 Apr 2026 18:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VTnpKIq5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020092.outbound.protection.outlook.com [52.101.201.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B1913FEE;
	Thu,  2 Apr 2026 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155773; cv=fail; b=p0OiyIjvENh1RyLA6mdvC/xoMSIFID3mU4CrihDKZvEiwHe52sr1qWtS20fP8I/pMieheflAON0y0VbiD11RzNyfEvoJdcAg8OgfMA74pqMUzi2Wa3zAtQeyp+RSohvE0MAHWUIWJThOIHtXPTsCCauHxtpNNpe7pmghdxuQFOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155773; c=relaxed/simple;
	bh=cjBAteypZZligV8rxpCStTjdsd3Y1JloU5xHOF4dgAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QQwct9DksUTQVbelfeZ/ReyyyUCdxlD83NjDHW+YSuRY60Nec4WPqyx010bXyNQCAU75+Mv0CJa4wNtkT6D35oFF7j+jRSRgbPchGniReqBfm0/bh5c+ZOzFHu6wJccThGfoLfZOC++i/usXk22Ooa/1nihBwmXGHv3g4mkd14w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=VTnpKIq5; arc=fail smtp.client-ip=52.101.201.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKX5LkpVCgi53R5tY83scYWQqA1wTGuPb5eEhj9YG6TUV9QapKocYyFfasewybaXMJMkHmFkgSkIU2hdgLQkhS7apWJD8c9yb3nly4Q8q4wdHpT12Ajj1KNd+LhU2QVNajAI/05ow5KLSGOiwmXkVZoa7HfBm/VrxQDAV0It8PS+6U5j8Hrn1Hf+8OhrbS1vwXzyRBUBrvctpKQOL/3+DTyrCDRB/3yPozT2L0NEYwassgyeA6jg1yFkS7hrIo/PosAX8rXCpOo/h67cn9AGexxu6aWhoc8hZowOMqYN/X6BUuJ6wk1m8oWNBnKs/RQELMBWrKC4BJRw78FQnkwpEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mu0Jq9y4DvwLYip+tmR90/Sboo6ZKO5c+IZXPo0fHT8=;
 b=Ol0htvpaPz1j3NXT21wY2tb3maVNCjOCGw/DuSRSEDXXgOMuAFKE98t5SywgYzI2KVkoIHY0sSxJNhXz8hR2HNK39xsmADvOQ6yS4q6/ljcsg63dxcN6az9yKdNaxKZUHc+eTqCxgfsfsxNq94Q3XGMLjHYbvPVgQ+0bv5vaJ5nHLDiV+CQJa0y1NP3DPcXdQyHCpQg4d2MN+f1+loEQ3SBHlhVIHVBRDB+gR2Jaj7gu/Dgsqm7HX5m5tuxEUtqm/WjOGVVXGU7dkFscSSpgTmQyv6td5dggpwhxQqeNk/UaRWoiS6XUdsTUdqFS9xRn7QDhPsxGVeTB45bAZItpyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu0Jq9y4DvwLYip+tmR90/Sboo6ZKO5c+IZXPo0fHT8=;
 b=VTnpKIq56nqnd2IIze7XTj65jr9jqm9xM6tSM7BL540XSY/3hKWjedv30gJZb2r1+2KIjwnQiaAzL2xw/IgFK01Dlt1o/91Ted9ikrIYgtlfD1BZ7elCQ1xow2nlcB0wbls8P/u6VPZb/+mURVZ+GgeKnGpnKJo2af/lSlpJY7g=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA1PR21MB6272.namprd21.prod.outlook.com (2603:10b6:806:4ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 18:49:28 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9769.014; Thu, 2 Apr 2026
 18:49:28 +0000
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
 AQHci0NePIGSa/9NGkCUvIR93cd3gLVdwUXwgADOvQCAABBuYIAAnjqAgAALUwCAbTsFEA==
Date: Thu, 2 Apr 2026 18:49:28 +0000
Message-ID:
 <SA1PR21MB6921BADC87FF09BA8231800DBF51A@SA1PR21MB6921.namprd21.prod.outlook.com>
References:
 <SN6PR02MB4157545DAFDCCE0028439DB2D497A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260123053909.95584-1-matthew.ruffell@canonical.com>
 <SN6PR02MB41573CD2EA6CD82A0C238F66D494A@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB41573CD2EA6CD82A0C238F66D494A@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4d1d8d16-9b07-46b6-8a12-10b2e002d5f7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-02T18:23:13Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA1PR21MB6272:EE_
x-ms-office365-filtering-correlation-id: 0073102a-9e9d-4923-0eb7-08de90e891ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 ODcceD75LddH4NS6vVObezD+/EjlexO7zDRFhQ9BTNvStWud+gwkkwfh2X6HzMWCGZwRL3jgmyd32Fp+EP02hz8Q/f1DCQHQGTFAD33sOmEB3hYGKE4ivBVw8argAAlvrggftHIHKMyrDvZ/f0N0cSwa/BUN45z3dqay2Js4bl8x9PT01bPq/OhW8VuO8GHVuWzBD/oah2zQ3uphVmILt4bcszMTLpRygndNOE8bYtfH8Lmgv5uLCCOhHGr25pfEhnq/HDFtO3sT9snh/g7CzJOHYDm9585Aw44O2b1eIGzGHugmjI3OlR7AS0HPhaqGMRjqrxvyL83J1Zm6aNCICh0R6+GWzpy4kHG5x4Q+yZhI62hoU/I/4E3akWu15CCS0j8lvn653F+ictVpT4jr/9JsBzId6NxFUeX4lt589WBXWuPO5gGkt2k5osRiddNWUJbUeAT6+SBcSzsVK9e4Ckc4OcxSP0Gb6b1vEJ0Kk+vZwsNLH42OYlMHegVWaMQ44rD+zadWJmPB960stPbIrClH3k2CrnxRF+BobBfIMKGiUnMIkRT1rJqmyLItmXhB9Ou4vYF4gUK0VDAakl04VQjNCkhGx1t3acwxVj3kh7G73iCicYilBa0vNpK24V6tH5Y7YdoXixfZbxJG9i6i5rukgOj5QlWjEDLBdCk6CjwG4gDzhd/RjKWmGe3UwgQii3FPlu2r9PT63qWrWUV8O/J3lEBZkbB/d1cVHqP/U1hOECreoT6KWB1cCMaFH8za
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?I2p86R9YdtHvGoDeD5XqEPps7nk9AVguu8AU/cyH3zXwXFzmA9cTB9dj5aoC?=
 =?us-ascii?Q?Al/AwADOJUYFnovlrEa0GCj0g6jZcitLZMZV4Lb3g+Ww+Akj8HLJG17j8tmQ?=
 =?us-ascii?Q?s67AOh13bxLpqwv4XTaMQHd2IILZ1YdESdH9mnj7bZpvtZG4rfwktXyGL6yT?=
 =?us-ascii?Q?rQIO4UwyTvErORQXLNpCIPUjuXtpXCTAcgxIdjcGzrcYoenE024fbi0Poo+2?=
 =?us-ascii?Q?cmI0zmaso0VNn0vcNZD93UHbi+sN/6j0w0L94ENHktyq/EOOCJEjOXrSDFMo?=
 =?us-ascii?Q?g92kjtElJMMTi6973XL+wC8Z1l9t2bLWQQEAZ2sregYlm8ftTbbpXFMR1ep4?=
 =?us-ascii?Q?V0q9CrSxZASfKPy5lPbGy4iL6N7mFLJ30b68V/x36jsdCVMb5fWmp/A8KqXs?=
 =?us-ascii?Q?rwdlWMA7OClxHozqxh3Y1zZbfS70FEeoLLLjdpnr7ER1tOCe0EMjF8yL65HM?=
 =?us-ascii?Q?MzdbSy70SQLUlzs7ASdPgctJ80ET81gCoPWpH5P8DEakRNzF+5ab/5Az8I8Z?=
 =?us-ascii?Q?cq6Xs94mXryFP/WBn8+A5K0pRhF4hGGaM1ik4jpFUoTFgb88+Qb9hkhO/Pio?=
 =?us-ascii?Q?98tUCGj9FNJlCuITU5zr2ne7UcZ9aM09lCw5tASHEG6FHx/jnIAA0d7iQw1O?=
 =?us-ascii?Q?aw/5Xt2mSds9mrcyRDnfTOvF7lbGZh0464rt03MinG49omaFMlF/g5Kb+qOQ?=
 =?us-ascii?Q?UUoSR+XKOUxCOpPEMKTt/yEJMFV0pUF9nyccdm0eSDq6BFZEK96+gGNQQE5a?=
 =?us-ascii?Q?F/f3LZBIB41LuCF+roeBxdLYy9/1zOgtmJJOF7bxwHtGC58V2YdCdR1fGfiM?=
 =?us-ascii?Q?YwP5shs8BTd3SOgI45t/4aGpC3sju78qqYV//RL4lhq+YCHoca4NvXCZt2wJ?=
 =?us-ascii?Q?XmKQwqUYsU9vyLbsNam2FsGsmburvejfGaQ7mUrQlkkxrCBkYkP/ERtdjs5I?=
 =?us-ascii?Q?+dCiVUWk16FOnr8fzGK7gTiXb5NW2G3CokFdP8te8a6D1dhfH4GRO8bQYRbE?=
 =?us-ascii?Q?dYOgQSSw5+/TRCMISCW6SPFkDmFZPaVFkntObXbnU/jEOZq3ITngi1iHRamj?=
 =?us-ascii?Q?wyc/miXwA+ft01IdQ4uXj0Ze7v91sLdWNI6LMtq8hQ1J7lhZlaMxsw3DjNys?=
 =?us-ascii?Q?1wkLzIXkvZ5JKeX4RJaeZ5A2GDgoWzS6N8Y7Qvt+Dt/bF1gLGX7tUL5IjM3h?=
 =?us-ascii?Q?ntopn8k6/z4CWKZTL+iIKbqlQe+eyi6bC6mpAw8euPM3AWkdR2hRfTDc7Cwp?=
 =?us-ascii?Q?7/E/R9Cjvn/MBGcZOXTr0Bfinja9jof5E2E4pEnkMAeiEEflV8nsYb3n76X6?=
 =?us-ascii?Q?2vEfw7uJOQQj5tFWcYpww0eNplWbAJOoeCDosTHAu5/+HcjsN9oHx1+LjbXm?=
 =?us-ascii?Q?4J4/ME4rxezsGTx3B/P5znSzziLz3J/F+KebeSs07IRgjuOvxpJMn5iryhkL?=
 =?us-ascii?Q?uyHT1WsnOqmkNL22LgV8zumMPZmnku07ioeZGQmuW0d8u5xGBFZjqruMobyn?=
 =?us-ascii?Q?2iHepTo6My+Y2Aou95xndGa788r2KZXaQwIT6GunVOYs7Gz9acpU/pEWunLp?=
 =?us-ascii?Q?gIUSi/GARYchDi7JFcTxoIP6UWfCdeR2IEW3nsnhGDd8EIoe9GwJUNgD0aJJ?=
 =?us-ascii?Q?bwmqOAR0NchdA7+g/H2HrEiqCmcNGAkJrr2iWnoIIFBVxtzOxuaK9uJC3HXJ?=
 =?us-ascii?Q?ISFrUuYU0tMg1Y/gOy6IfbZABTB8Eod0Z7XN+XVL+1qDiAqX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0073102a-9e9d-4923-0eb7-08de90e891ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 18:49:28.7446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vpAnx81dBVHXNQcOrl3XmVbDKT5jywHXFeF17Pt4v30f4Bwbnwrn6gC4Us4974QleYNTqcpLctb5U2Ps4pGfIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6272
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9932-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 5338E38D69D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Thursday, January 22, 2026 10:39 PM
>  ...
> This is good info, and definitely a clue. So to be clear, the problem rep=
ros
> only when kexec_load() is used. With kexec_file_load(), it does not repro=
. Is
> that right?

Yes and no. The answer depends on the combination of the version of
kdump-tools, and the architecture (x86-64 vs. ARM64), and the hypercall
(KEXEC_LOAD vs. KEXEC_FILE_LOAD)  and the Linux kernel version (there
have been patches fixing and breaking kdump over the past several years...)

Please see the reply I posted about 2 hours ago for all the details.=20

> I saw a similar distinction when working on commit 304386373007,
> though in the opposite direction!
I think this happens because you're using Ubuntu 20.04:

> https://lwn.net/ml/linux-kernel/SN6PR02MB41572155B6D139C499814EB7D4F12@SN=
6PR02MB4157.namprd02.prod.outlook.com/
> To further complicate matters, the kexec on Oracle Linux 9.4 seems to
> have a bug when the -c option forces the use of kexec_load() instead
> of kexec_file_load(). As an experiment, I modified the kdumpctl shell
> script to add the "-c" option to kexec, but in that case the value "0x0"
> is passed as the framebuffer address, which is wrong.

Before commit 304386373007, hyperv_fb relocates the framebuffer
MMIO base,  so KEXEC_FILE_LOAD doesn't work for you, because the kdump
kernel's screen_info.lfb_base still points to the initial MMIO, and hence
the kdump kernel's efifb driver fails to work properly; KEXEC_LOAD works
for you because the kdump-tools v2.0.18 in Ubuntu 20.04 doesn't have that
commit (see the other reply from me)

The kexec on Oracle Linux 9.4 has that commit, and it's not buggy -- unless
we'd like to claim that all the recent kdump-tools versions are buggy :-)

Thanks,
Dexuan

