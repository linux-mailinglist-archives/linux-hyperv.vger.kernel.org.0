Return-Path: <linux-hyperv+bounces-10073-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SqaFBITy1WnL/gcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10073-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 08:15:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E4D3B77B8
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 08:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF472301DC0F
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2026 06:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064B435CB81;
	Wed,  8 Apr 2026 06:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EBhFyA+d"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020115.outbound.protection.outlook.com [52.101.85.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC95229B38;
	Wed,  8 Apr 2026 06:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775628927; cv=fail; b=oFlLimxRSRRgkTEpC0UYLPvVBFUxJZOYGUKu2SQ7p7h/PCXTIn7kiCUvic65YHWYFBjq4BpG+4Clcrydj9KMz/6gCUL6dZvjFc5XCPU/UNdNM7x3Ir5Lrnb5mNN578ep/czA83xbfDhsX+tgJxSCJdSyt1effYvcC38hbPNfZX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775628927; c=relaxed/simple;
	bh=NC6fUV8NFdrryI6L1lc7sgHRhl8vAXgpXfdnFtQ6RrQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uz1Wa6yG5FwuX9G8uLCbzXbQCQJcAM8x46+6LryRtLKcNqmM9afV6ceU5FitnvDDweioVwCIDMJ6JA5j1UxkNJ9AtuZnc3TMXa9gUSsCyhoHGYSdpf07ACbm6J3gVyfWUNQFhOf+qZ/ULwiKmED2VpqZTL9iDhy5DI6zNAHCATc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=EBhFyA+d; arc=fail smtp.client-ip=52.101.85.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWMoMUL0Ef1WFDM9I3BkgTnH5E7Ihb6CX+BCgdVYZEbHD5EaEhLOxXdJhS2NNMuJDALE468AQ5xFALIdAR3BB7SNcFhlc0tCZ/FwK6vBJDjK104VHJuaIUhQB53Qd73qn5OpJNq5cA4ZJYP3MTavig+twcq+fFg7pRvojhKhtz5isSxdegaLF4I+QSV/tqeQ7yh8AlqUXEdFQ6XOD7l4RD7OEh06GjCTVz3es7/w7Kd4b4kOqNzD1ZYsi9Yk3W6nbdvTH+pSR4FXHI+PXZ2IrqC4P0yYuNmahITqTA81zAFGNcM4FejTB0uvAzXR8j6R7yf6T8FKG0iWanDCkdzvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ty3OlZym7ovnn01lILFNvkL2Agcl886hOVrL9YudJY=;
 b=NMAuR3+HI4kfRi4pmeshH7P14vHpcyf54CZmThJTL+IJ+GhmJMFpWSAQ5UqxBqysY8Bf6y/b8y1GUAONJ5qMq9bqkX71sBspYh+hw9ZiLtZeynqJxrFjkQwnpsFErFcLXv86Ms3B5GwCEFiKK6X+9MISb3OQleUxrGHX9H5jIKglEsseAhFZSNsOmljDsLoQBaxTZNESBFkJUJ+8yxLyrgjvaXauyCHgSkK/KmcUONztA1tsRUY/0oWO+Rf9fIxK/rQbqw3f4+ofXGn1hY83bzcGdalaNp4AYt0I4fbgO/iZ3GS/n0dZ8Gm+0J/qJnczrj2nMj75ehgurSDJuG/L6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ty3OlZym7ovnn01lILFNvkL2Agcl886hOVrL9YudJY=;
 b=EBhFyA+d3kvflhNudygGg1SGGIpOZOjpzRmC2xzr+n8X0tDdeZehXGY43u3eNen2158nSKdcq6kI6kwN+4XQVf9Zo8xxEOY3knlJxCWbhtb9U+hjUEgn/MMV+Jfb4FcZyymSMw++QZwFJ3mKShdfSglWBSco6K6EgeuhWx5+I6U=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA3PR21MB5744.namprd21.prod.outlook.com (2603:10b6:806:499::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.9; Wed, 8 Apr
 2026 06:15:22 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 06:15:22 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Long Li <longli@microsoft.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Jake Oshins
	<jakeo@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Matthew Ruffell
	<matthew.ruffell@canonical.com>, Krister Johansen <kjlx@templeofstupid.com>
Subject: RE: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Topic: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Index: AQHci0NePIGSa/9NGkCUvIR93cd3gLVdwUXwgG35paCABdGbsIADk5AA
Date: Wed, 8 Apr 2026 06:15:22 +0000
Message-ID:
 <SA1PR21MB692186FEE8E890A8CBE4C74FBF5BA@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260122020337.94967-1-decui@microsoft.com>
 <BN7PR02MB41486A6DBF839D5BC5D5BC2ED497A@BN7PR02MB4148.namprd02.prod.outlook.com>
 <SA1PR21MB692176C1BC53BFC9EAE5CF8EBF51A@SA1PR21MB6921.namprd21.prod.outlook.com>
 <SN6PR02MB415726C7758C985528ACB912D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB415726C7758C985528ACB912D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e5cb3d60-cfa7-4cd5-968a-6b2312d12ef6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-08T05:48:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA3PR21MB5744:EE_
x-ms-office365-filtering-correlation-id: bb96f1c8-5153-4dc0-077d-08de9536378d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 Ly+UyACHTwogh4D2/4+XywnTQHsc0xyZ4Ele5Nsssq9YZZqVwLTAeNZlF1JzeqC7Z4GN6y/1/bXmbLuEqooKAvLEsJMfXTxRyT+khKLVLj0fOG4BkP87H8E5tse9PQc5xm3SO2Jis+1I1Xjz/ZcFWIkkrkhAzxvWNgodIef0HW9AbHzPB22M64QaDHoguLaw7HXCsahSA+hhGb5uL9D+o7bWzxfdDWVuODEwjfSmcJcALKztqC2vk6YQB/9Nt3m0TW51L/v9UUlQS3qUhjETigPNvVnLuOvXkgW9bBKF6h+1NkmL87ijg+jacO3faqNCUWhDidzoiPZostO8zkR6N8laIe1Q1wU7woCxAVGLFclsVA+UQtCk1X2Gz8Jm6A24lALtTrYtL2rQGSOWaqZMUN1hB86zzOCc/fH2NmxlR69Z9jfLnkIEgiThWQjiHlBEjV18gU6HpfcAKp8SeVfnatin5SUiuTK7f4VRP3cxfCjIdtSPxZw2KSGbuvEVIL/0qaqtuFGFttti48T8htu6ipbRucbnvel7/iNcI+5gal5SCBjbCp0Ch9aVl4k9LTwLSMUWUwDd1CkJ02ox/ZIFkGzirmfEKkSOsLeOLiLI5YOgcfOceWX30qGSBUQcf8TxGZtsh4jFc/92FNn0B5NaT9AsmXIWKcaD+QT2fJ8w494tlZjLW+C9jj8j2SsC7DkrsB39Esdm/jfPTLGnOemIjx51IOvnJCMzXtP5Nf+KLunZuGJzhJE+NHdw7ZCBQGS8Wbp1TYLw+NaQpvdofcONso3Nugt9aTsKM/mu4Z9bsgo2cYmWv0y1xXUpcYH2iIK/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DmDALcgSf/ZMdN6jDgofcjQH7cDP9uVkeIvLW2CvkTXe/4IH4lgo2twguhWI?=
 =?us-ascii?Q?iC2fv9U6AH0HgBWxKAyHXq3GbHH9zt2JGw84e8aZqu7fRJwvWcoMlD/TQe8s?=
 =?us-ascii?Q?wqgo7FoEsUs6EoXJP7r9NySGO04+c9XRfVFu962ZUbBHkxEs2NKwxTQ6tbjS?=
 =?us-ascii?Q?LPmnMqX8rxodGVI+mSG3/MaidW5yVXO9QIvcBkqyZidJ5Smr9r379xaqOXsC?=
 =?us-ascii?Q?fLlq9o8wYnhw08TneUfzdHvQGFlUAws6/lf21TRWj/PpkCr/vWN6J4ju3s3I?=
 =?us-ascii?Q?lq3snNKZFN0+vt9c5xLRQUI0r5ioPWyWtMd/68fzYpl/Nqjm4Nc9nszimPFu?=
 =?us-ascii?Q?2ChU4WBMeAGAvtRT5xN5BMGJevqmO66I9oi9bcUt8JS6K+jGCShVJpAHkeVI?=
 =?us-ascii?Q?wjOGueJbYKXlNlY+ow2Kcwst30krH3YXt5q7/8ZPhrWjdBU9l3QaGKawifry?=
 =?us-ascii?Q?65ytaR9djfNjrrdqlPsFOOcylfoes4J/WXrghgvYWsDhBD6LL2J+Pk9u2l9A?=
 =?us-ascii?Q?7py4g0kx6CbGF9gFEJb/pwGX+VFVa1uDWy8qO0UO4QvmjvopC7myO8/G3aSo?=
 =?us-ascii?Q?ZxwjhBoZmImXCBhKYMPiDRMb5UjurAMUUSc4YUxjLZzQhm6XdSap+dNNok9e?=
 =?us-ascii?Q?mjnisaum7yUdoQjqyx1swMdWtKodw1tND068jVJ5DYBtpW+D2x9zqGfDeYJn?=
 =?us-ascii?Q?sqFG5TpLPD9Y41EbdGN/5R25VaJY3rIo5glkYrOcrAVKpmf1CSF+SPpm186l?=
 =?us-ascii?Q?EY9Np1GZO44LJkeZoDnkTpKVB/p8QdXlyTeAxCi+yf4W5f77Ps3fXzW0zQnc?=
 =?us-ascii?Q?hm7A+fN2qRqXYWXi3rQBkUeEt7SF5y/9w7OZDsH6ZGPDhlFDF93Adu1FxxdM?=
 =?us-ascii?Q?DC7+/ErTbBXBVT+hXSv4ndRjJu4O95g5VgxeFhpMGSSEtnPW9xFBkH2xwoAd?=
 =?us-ascii?Q?Mpx5llNbEWGpshAPTkRZ5NVam1NTnrVPXP6qnJ45ElQHjbrchvjEoifPCOXL?=
 =?us-ascii?Q?8NLhN4k+/nq2uDNb6UjrDuQFQgiOGRIzd4Zd3K8tzc8nZbHAOfJljpRAGtCA?=
 =?us-ascii?Q?Wm+Al1PpL+tFexbv9hZTOIFSxGkpv1jnY+QTx+KaUyJ5q3FSf6t9i/Fk8W2x?=
 =?us-ascii?Q?tafW/fDex3YudDufLKveEDNGxaDVbjbW1qToXIErppG1/wV6e9oUWrGcQyyv?=
 =?us-ascii?Q?/HI36Pk3QwpKJb6++Fu8HyCDz1r9H8sfhUfU6ZEM4PjK11g8BLNconKj4b7d?=
 =?us-ascii?Q?n/Nw9SzZd5dxM6VZbXoy13JrdtGgc7ELI+Hmp3RQicEMuCUcE7pFgONSoimI?=
 =?us-ascii?Q?cJnp+brELaD76oyUQ5dmLGFrVTiU1QxUopFIhINYfTtH9g9VbvO3178VqbY/?=
 =?us-ascii?Q?VU/mFWw+DXIMYEQac1Hr3LuawZ381+MmOr0I1tavMPBxQFdaAloPvevTUwSP?=
 =?us-ascii?Q?R/afSXryl7zZ7nGzVgC5FTIWp/cZK6CRUWsQ4biZ9ZAYWjbBb7/Bl1x862Sm?=
 =?us-ascii?Q?8KeulEqyY02+StyGTxLZYcPEoxXxV3WBWk/uRHnKEAfDA3lrumjSLbfTxVd/?=
 =?us-ascii?Q?+YyiNgvJh0IB/HlgC8bw+uLB1LMvEcyPdmRUSJ7wXqfBbgHm9RB6mAP3pPze?=
 =?us-ascii?Q?vNaIKiE+NEvWFMeBaywDE/gDlqKm0qaZe06kqMq87ozGdXaBTfMnKMe0CO3K?=
 =?us-ascii?Q?JfnwQecSwUugAamYe+aQa8tghLx/qXcFgDxAgjkpqVXFEYMJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb96f1c8-5153-4dc0-077d-08de9536378d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 06:15:22.5528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2JbKeQVmbdSbXAsDoDMTW91dE5zmVHcZcYg5ECfibM/mcwoU4sGmdqyqrgbyl0HAiUwidJMDwUjh+v9sL5eM/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5744
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10073-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,google.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email,SA1PR21MB6921.namprd21.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 66E4D3B77B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Sunday, April 5, 2026 4:11 PM
> > ...
> > Unluckily, setup_linux_vesafb() only recognizes the vesafb
> > driver in Linux kernel ("VESA VGA") and the efifb driver ("EFI VGA").
> > It looks like normally arch_options.reuse_video_type is always 0.
> >
> > This means the kdump kernel's screen_info.lfb_base is 0, if
> > hyperv_fb or hyperv_drm loads. In the past,  for a Ubuntu kernel
> > with CONFIG_FB_EFI=3Dy, our workaround is blacklisting
> > hyperv_fb or hyperv_drm, so /dev/fb0 is backed by efifb, and
> > the screen_info.lfb_base is correctly set for kdump.
>=20
> Hmmm. This worse than I thought for x86/x64. In fact, it means
> a part of my commit message for 304386373007 is now wrong. I had
> described everything as working when using the kexec_load() system
> call because the FBIOGET_FSCREENINFO ioctl was returning a good
> value for smem_start (at least with the hyperv_fb driver). But as you
> point out further down, newer versions of the kexec user space program
> are ignoring that smem_start value unless the driver is vesafb or efifb.
>=20
> Was blacklisting hyperv_fb or hyperv_drm in the kdump kernel
> a workaround we had promulgated in the past? My recollection
> is vague. But no matter.

Blacklisting hyperv_fb or hyperv_drm in the *first* kernel was an
internal workaround, which no longer works since  CONFIG_FB_EFI
is not set in the linux-azure kernels.

Thanks,
Dexuan


