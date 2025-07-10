Return-Path: <linux-hyperv+bounces-6179-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C714EB0017F
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 14:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9AE5880EC
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 12:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3622421FF42;
	Thu, 10 Jul 2025 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ChXerkMJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023124.outbound.protection.outlook.com [52.101.127.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30044244684;
	Thu, 10 Jul 2025 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150004; cv=fail; b=uiqtRuQFRiovIxN4et2LS5mh/DVn2JS+nHBYUJAf1mgpIeUtGLj5grcgyKpIP4V6CJ5X4nnYYcjWfR8JCTRLB+bLulP893zgeU/XEUtEmv5rKUFlhGVYJDXGVfDtBcRiLzBW5WoEDc7IGYPzSr5L5Bn1+r7/KffuWFnNFtYfKt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150004; c=relaxed/simple;
	bh=EGFNqCm/h4PMwnP4ZCdRmc7xfidfNec+5O0DBab35bA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VgmsC9cgLeeyRlnaSouDCg9t1zQ3cIHioSvz8rEOJxtyV1bn5EtocblZYpTpIBtOnq9NVoeJRef9PMW1JoNzvFGptTNRzbJP/FRLHtuMo+4k1vnVa0UKFblJb1JQmTEws03MbG/pZqmqo+d/xUR6LWnqyF6tKxDOXEEB1VOWwpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=ChXerkMJ; arc=fail smtp.client-ip=52.101.127.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8VhF6mO9JX2nkvnuQsUSIyGRV6HHZjG01+CgXrDLbGCl7mAPYPmQbtXbbgnRqh7vYr2ntY9YIAInp7XmNFzQbBnb+XllTkTcuYhDHyOGUdZ3obQDC82M4kJHKdtX6tOOBsCEz7rOREJYu8QAn5ITkrTBS2tQGaLhHvHRiJeZcEEO4maEwCmBT3qzXga0HgPc80TTq5wVI4kcxJo+oXQeBzj8vJ4CCkksLOAOSX8dsiB2DYHQZPBojJ/42HOBzgeWr7mz4ZrAGvOLUF5NXqw8WOb1g/08j48rixuINIpqfAp0nYCQ9tx43YPxYA24+a9chxZcKwD9qkpS/XaKg8Flg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3Y0QlxEruPKaflK/19hOtVj5+sc4FKIGZAJ0eau0+0=;
 b=l7mPyMX+1hnLLVGAo9raj4SFdXROOvhzv8Ib5V5YQ+I4n3EOVZ8GCF8BkBY2oclEMwQAMINK9W51OIIe07ygEBbikTU31hyVWukPUkT2sQr5C2LWInrLFSRLElMIKsS+uGs7Rx4SO2/xtqwVSRAfS5bbQ2NCbEs71dqgoqVv0O0zsY38zkbqDCaSmLuUzhHwQhF3eDq54M4bOHD3YFe2YSKqb8S3mgr8d6rnWZwkdjOChqJs/DKbfqQhAEyM3X7jQ9UuOs6uSYIr/pV+vntPln1t+281kRUoeuxMlbombotWMf7QrRwHwyBCkA1yb8UHds6Si4J5cbQR/SJr5RCYTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3Y0QlxEruPKaflK/19hOtVj5+sc4FKIGZAJ0eau0+0=;
 b=ChXerkMJUD10dkwVIKfHEmCZY/sgrKFlOXU2R4uJiarKMyTvkfaOirPq/ISqMWX/VK2uUh9AT/l5e+PNg/SA95Gh0ftI5bZ4L3Nvy6+QCRxREd45qjLKxIiVhIZ2XQjoRt5PK8yUoHr/p2gS3+9xbNi4nqdrvGwX5/yFXkojuTE=
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:36::22)
 by OSLP153MB1192.APCP153.PROD.OUTLOOK.COM (2603:1096:604:374::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.12; Thu, 10 Jul
 2025 12:19:59 +0000
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::c9fa:b931:702:dbac]) by KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::c9fa:b931:702:dbac%6]) with mapi id 15.20.8922.011; Thu, 10 Jul 2025
 12:19:58 +0000
From: Saurabh Singh Sengar <ssengar@microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>, Saurabh Singh Sengar
	<ssengar@linux.microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Olaf Hering
	<olaf@aepfle.de>
Subject: RE: [PATCH v3] tools/hv: fcopy: Fix irregularities with size of ring
 buffer
Thread-Topic: [PATCH v3] tools/hv: fcopy: Fix irregularities with size of ring
 buffer
Thread-Index: AQHb8WNMG+H5zRLy3kmZx6ZAHEx1fLQrIBEAgAAmptA=
Date: Thu, 10 Jul 2025 12:19:58 +0000
Message-ID:
 <KUZP153MB14443BE3D49BA0F5FD8F305DBE48A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
References: <20250708080319.3904-1-namjain@linux.microsoft.com>
 <20250709112201.GA26241@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <89ff0e52-377c-4c9f-a61e-f73639304767@linux.microsoft.com>
 <c7e1c5cc-4f80-4425-8afe-88e0801c574e@linux.microsoft.com>
In-Reply-To: <c7e1c5cc-4f80-4425-8afe-88e0801c574e@linux.microsoft.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3097bb83-04af-44d5-ac8f-757f9be0864c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-10T12:18:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUZP153MB1444:EE_|OSLP153MB1192:EE_
x-ms-office365-filtering-correlation-id: 6ea5f273-814f-47a7-a77e-08ddbfac165d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?rulFHW75OKyvbRqgiyWQkPaIWE09X7JjeIUv7C1UKtadrQoh/2b5YvDKx5?=
 =?iso-8859-1?Q?qAJb4n0qnNw/JITHwHt2eJVWvbmqe3MVYOl/kCDvi86wiTDfyoyVpRTk5H?=
 =?iso-8859-1?Q?j7hHiUMqeFArqL4A06JJnwShpG3MJhNz5itjoy6DV7KxDZBjxc4JScG7U6?=
 =?iso-8859-1?Q?b4olPE9wU8C1WRZgHaheJgAE4Q/SECpr/r/AmVAWJoY3yh4agsRjq1mTT4?=
 =?iso-8859-1?Q?TpjJF9sPZxta9m5lvY9ZgSCzb3L3Vu4yDTiIMe25u6q09BCMSPWWzGqB98?=
 =?iso-8859-1?Q?oo/7w/r1XWz3gBILf94ADDPqiRv+BNiRvQX+anXvc8d2xUwfDVyIm7o/hP?=
 =?iso-8859-1?Q?Avl+tAjSGoRmIMe1jTeuE3Zy4frtMo9C+n0fmhkPBdx6M66UPuC6iC+jnS?=
 =?iso-8859-1?Q?6xqsJlWIdLfZe7iEb2MDjEL6LXe181NmcvyW+rsMAaRZBt3eYEcOEColez?=
 =?iso-8859-1?Q?/vN0sGaY+WsDCpVAfKmkhDbT/6DSRSABufA7dpoPRAo/MKIg32INGQLm8G?=
 =?iso-8859-1?Q?2vSjPdr0jky+/08UUnZ8Ek14t0LRo82bsVuwMhyNnzc9l4RQufNdshjy3K?=
 =?iso-8859-1?Q?X3mWuMUDpK5vP2nBVVGSlYSkcI6zelsRZb7p+Wzcfwvv9Kg8XM5pUmvMR8?=
 =?iso-8859-1?Q?s/ULZ78S44vBYxi5c/6V6c59hvFYSe4qdMcxxPsH5Nbq9zVTkvJhNFXjyK?=
 =?iso-8859-1?Q?p1GPHdyJFkiQz+HGjrMSLz4uIRxxuG4Lb39fWXQCtWy2CbJcPf9v5wzwdr?=
 =?iso-8859-1?Q?wo3XeITajqlEA1xYEM/2KXmxBIRhqtPd9BddZ+tAFmyz3Jzyljm8doxnrO?=
 =?iso-8859-1?Q?05wh+aY9H+6+bT+JRdxU7LQBlmT0BwIne1O3Myuw1vzXWCASVyjL2Shzr2?=
 =?iso-8859-1?Q?nT+rqLwm72kiqMPI9sHANwHyArl3JJukYAGwFT7XfQASg59ah76DwBDV1Z?=
 =?iso-8859-1?Q?dI+L43vr0zVXs36hqr8ypKs4XLqk/0YlxliH6IWcUa13oVUHfwJXUg1R8I?=
 =?iso-8859-1?Q?RsXyynh0BYA9QX78b4plEj++H25PTYqhfBg9ViY0MIMuP0KdcCtbsBCY2R?=
 =?iso-8859-1?Q?ncK8gGjnhAww/v/X1c8Hnon+nn8RnFMDZumUMBp+Y1PlpBLJ1q+8PgpJKn?=
 =?iso-8859-1?Q?b4iB7cYPmCXqyXLCzvyRFQABHTgZIdx9nKV55bjo3sv8MhYDmAETlBju+p?=
 =?iso-8859-1?Q?lT3RhaI1nO6yQGJ/T/YbAdhZnO9KZSVafAazi/mUFogYrKPjs0bWKnuEZi?=
 =?iso-8859-1?Q?hNfgI2oy0wgHZTcg0AG0Ox8dlewgG33Kp55U/qrqykEF7kf76FJwxriA1Y?=
 =?iso-8859-1?Q?hJyt3lu+ChuwVRHlEA+PpFihjJEeCi6P7kUrUdXphWFyWVLUQ+FT1z19v4?=
 =?iso-8859-1?Q?mTPT6rqFPb+EAYeEXww2BrkoWzz/6RnglHNYmUFzJ+xF8cAO5AV3GKowPY?=
 =?iso-8859-1?Q?vn37VsDoPGdfXX04+z53WiOVrQYpEehO+MVNhAWzHl24t1pnk8myb3RRmi?=
 =?iso-8859-1?Q?M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUZP153MB1444.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sQZiOddSckQKwbtIxlm+qzkv2GQCtk3Ua7gzRXfcjezNOlEaYN1Ux+9OpE?=
 =?iso-8859-1?Q?6Qa8tqdWg4b1QPoyVvFEdi3P/n/5Nx640HOuD3gu5kGXRRiAEUoRzQlehG?=
 =?iso-8859-1?Q?MJgIaV2UZPAOEe0J24Qeva+ATxQ72JwWrcS4Ov1OgpYMj64VcyVp0aqZJF?=
 =?iso-8859-1?Q?3m+1WaZ6m1yTJv8mRXRApNUvSPx8ajOt3LQftVIkgk7Xqe6FtyNZnNl8Ir?=
 =?iso-8859-1?Q?3iaKljVRzjkqZRar4iH0o4rF4FeQSqVEqYzaMZaGrDmHCEjkXY8Chwt4Hs?=
 =?iso-8859-1?Q?7dHSoJgt/GqFsqbYFUPT/5EcG6wvaRIQ6coeVHYk9xN+MBzpGJleelRKhd?=
 =?iso-8859-1?Q?3rxcsTVJfiUGaZv1lgSs/ZRfgQBlPY6lXgiLk+qjkU8AFOChCFh0z6ZjC/?=
 =?iso-8859-1?Q?7V0Y1EGsuCP0xzaoHJ6cHDu7zJ/cy3+IukUAe0AlQopdR/33AkEk/GyU/D?=
 =?iso-8859-1?Q?TXng6WtLSTLpN/CTbd8RZH5uVMFjtJ856d8wqWILLy6pXXZeqwlH0zc6Z6?=
 =?iso-8859-1?Q?Fx52IuLOeK27TymXApDxlAgNXqac4iCLvooNI28mLdsOdAQ6wmqBitLVJd?=
 =?iso-8859-1?Q?SPMwv77d+bUX5LxaeqyOA+tBzcFfXDo0jjFjQzaqXuYTWDY2ttkeM0JSaw?=
 =?iso-8859-1?Q?9R6MCgWvYYm0qMT6+30uZBv+j/e0ni3QhD2+ILo7xJgo5PsZsMZ1Y0V0FO?=
 =?iso-8859-1?Q?Jw6fn9bOU8p55yiuuLQW+/rRy2IDop3Ibe/k4KWxIWA1OL//KpFzvoscCN?=
 =?iso-8859-1?Q?7mJjQg9dxzDBl8K89TElO52y1SWLhWBAU6OGPDR26xPVwo61bxGVsQHmBo?=
 =?iso-8859-1?Q?E/WbSaAcGTPM7anOXY+Eih3seTF/VUwwZb9EYasxPOgazDBohax+YJbJ9Y?=
 =?iso-8859-1?Q?mA6WUagakbRPSsidFZBGUFRwgpL4c4TK12YKoZVMxv14k5uzigvXgX58BT?=
 =?iso-8859-1?Q?aezVTe51yXbgy0tnyvdnc9PvGKWp5MX1H1WpMBxVLmnC0QhoL2b+W949Bv?=
 =?iso-8859-1?Q?zCuSL2z19ceNV2ap1Nq2BIxr+FpYRnsUSoEhUMg1Bl07VFO3dMHvOkJAxT?=
 =?iso-8859-1?Q?/aJDVVTC2n2OLCdJDBuLtsWvQXARcJh4Zk1H3/UBND0Vyvr9XlrDneAfFf?=
 =?iso-8859-1?Q?V90g7GKUHBJyczwMFj4RtedI8RMOnlLnsZnVVAJ2m6MruYEFZujmrATucQ?=
 =?iso-8859-1?Q?DPx3uo5pnMAvGavSwdUPM9ABO34Jx/tnGqrTWBAh8SM+W97apQyT+JaacL?=
 =?iso-8859-1?Q?Pvk8g5OwA8aNkkW4rnC1VmmBa4TAxNNoym5n56CrfZ7DqbAeyRsTTsB4Lb?=
 =?iso-8859-1?Q?rVJiXPzjr/dJ8d+hAwHBueaQr0nlCaHzbmEsl5kk7rMbzBKU4j+jkmUpDa?=
 =?iso-8859-1?Q?AgX6D9cyRFZkoZ5CrxLnEdW8h32vwXNiwhD4R/FBQuI61SCH00g/yopxhu?=
 =?iso-8859-1?Q?sci1Udx1UKuKJH8gL3Ys7ndpqJj3HrK4D8iQzi2j4E4LmDcCal0QF7jyof?=
 =?iso-8859-1?Q?WV9loFue8DPYJ1agTVuJfwSs6YEXtxhSAp6IylJZl4M3upuviNPjkGFwCc?=
 =?iso-8859-1?Q?cNuku+3qMfX1fFFz9j6BsuyR4THhYb01kzVcN++iwXuaZmTbD4UQvp9kKd?=
 =?iso-8859-1?Q?DukKppasrbvADs/Hn5n0PgAaxp+0fzQqyH?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea5f273-814f-47a7-a77e-08ddbfac165d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 12:19:58.6771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m41hGZuLPF2n022lNCjLZWz/ulZrBUSYODlbb0J4PF3LIcyRnseOZo20D2k+CC7mHlsYkJfryUVmSxwLMjQoAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSLP153MB1192

> On 7/10/2025 11:54 AM, Naman Jain wrote:
> >
> >
> > On 7/9/2025 4:52 PM, Saurabh Singh Sengar wrote:
> >> On Tue, Jul 08, 2025 at 01:33:19PM +0530, Naman Jain wrote:
> >>> Size of ring buffer, as defined in uio_hv_generic driver, is no longe=
r
> >>> fixed to 16 KB. This creates a problem in fcopy, since this size was
> >>> hardcoded. With the change in place to make ring sysfs node actually
> >>> reflect the size of underlying ring buffer, it is safe to get the siz=
e
> >>> of ring sysfs file and use it for ring buffer size in fcopy daemon.
> >>> Fix the issue of disparity in ring buffer size, by making it dynamic
> >>> in fcopy uio daemon.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: 0315fef2aff9 ("uio_hv_generic: Align ring size to system page"=
)
> >>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> >>> ---
> >>>   tools/hv/hv_fcopy_uio_daemon.c | 82
> +++++++++++++++++++++++++++++++---
> >>>   1 file changed, 75 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/
> >>> hv_fcopy_uio_daemon.c
> >>> index 0198321d14a2..5388ee1ebf4d 100644
> >>> --- a/tools/hv/hv_fcopy_uio_daemon.c
> >>> +++ b/tools/hv/hv_fcopy_uio_daemon.c
> >>> @@ -36,6 +36,7 @@
> >>>   #define WIN8_SRV_VERSION    (WIN8_SRV_MAJOR << 16 |
> WIN8_SRV_MINOR)
> >>>   #define FCOPY_UIO        "/sys/bus/vmbus/devices/
> >>> eb765408-105f-49b6-b4aa-c123b64d17d4/uio"
> >>> +#define FCOPY_CHANNELS_PATH    "/sys/bus/vmbus/devices/
> >>> eb765408-105f-49b6-b4aa-c123b64d17d4/channels"
> >>
> >> We can use a single path up to the device ID and then append either
> >> 'uio' or 'channels' using
> >> two separate variables.
> >
> > I am planning to use it like this, please let me know if it is OK.
> >
> > +#define FCOPY_DEVICE_PATH(subdir) "/sys/bus/vmbus/devices/
> > eb765408-105f-49b6-b4aa-c123b64d17d4/"#subdir
> > +#define FCOPY_UIO_PATH          FCOPY_DEVICE_PATH(uio)
> > +#define FCOPY_CHANNELS_PATH     FCOPY_DEVICE_PATH(channels)
>
> As per your suggestion, using it like this avoids the need to change
> hard coded device path at two places, and it looks better from code
> re-usability POV. No functional changes.
>
> I will make this change in next version.
>
>
> >
> >>
> >>>   #define FCOPY_VER_COUNT        1
> >>>   static const int fcopy_versions[] =3D {
> >>> @@ -47,9 +48,62 @@ static const int fw_versions[] =3D {
> >>>       UTIL_FW_VERSION
> >>>   };
> >>> -#define HV_RING_SIZE        0x4000 /* 16KB ring buffer size */
> >>> +static uint32_t get_ring_buffer_size(void)
> >>> +{
> >>> +    char ring_path[PATH_MAX];
> >>> +    DIR *dir;
> >>> +    struct dirent *entry;
> >>> +    struct stat st;
> >>> +    uint32_t ring_size =3D 0;
> >>> +    int retry_count =3D 0;
> >>> -static unsigned char desc[HV_RING_SIZE];
> >>> +    /* Find the channel directory */
> >>> +    dir =3D opendir(FCOPY_CHANNELS_PATH);
> >>> +    if (!dir) {
> >>> +        usleep(100 * 1000); /* Avoid race with kernel, wait 100ms
> >>> and retry once */
> >>> +        dir =3D opendir(FCOPY_CHANNELS_PATH);
> >>> +        if (!dir) {
> >>> +            syslog(LOG_ERR, "Failed to open channels directory: %s",
> >>> strerror(errno));
> >>> +            return 0;
> >>> +        }
> >>> +    }
> >>> +
> >>> +retry_once:
> >>> +    while ((entry =3D readdir(dir)) !=3D NULL) {
> >>> +        if (entry->d_type =3D=3D DT_DIR && strcmp(entry->d_name, "."=
) !=3D
> >>> 0 &&
> >>> +            strcmp(entry->d_name, "..") !=3D 0) {
> >>> +            snprintf(ring_path, sizeof(ring_path), "%s/%s/ring",
> >>> +                 FCOPY_CHANNELS_PATH, entry->d_name);
> >>> +
> >>> +            if (stat(ring_path, &st) =3D=3D 0) {
> >>> +                /*
> >>> +                 * stat returns size of Tx, Rx rings combined,
> >>> +                 * so take half of it for individual ring size.
> >>> +                 */
> >>> +                ring_size =3D (uint32_t)st.st_size / 2;
> >>> +                syslog(LOG_INFO, "Ring buffer size from %s: %u bytes=
",
> >>> +                       ring_path, ring_size);
> >>> +                break;
> >>> +            }
> >>> +        }
> >>> +    }
> >>> +
> >>> +    if (!ring_size && retry_count =3D=3D 0) {
> >>> +        retry_count =3D 1;
> >>> +        rewinddir(dir);
> >>> +        usleep(100 * 1000); /* Wait 100ms and retry once */
> >>> +        goto retry_once;
> >>
> >>         Is this retry solving any real problem ?
> >
> > Yes, these two retry mechanism are added to avoid race conditions with
> > creation of channels dir, numbered channels inside channels directory.
> > More in patch 1 comment by Michael.
> >
> https://lore.k/
> ernel.org%2Fall%2F&data=3D05%7C02%7Cssengar%40microsoft.com%7C5db27
> 7813c2d41ca6d7308ddbf98930f%7C72f988bf86f141af91ab2d7cd011db47%7C
> 1%7C0%7C638877384276448917%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0e
> U1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCI
> sIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DMXfEStja1KkKSXjvh%2Fn%2Frp
> QyF1jCwOwmnI8KQb5O3qk%3D&reserved=3D0
> >
> SN6PR02MB41574C54FFDE0D3F3B7A5649D47CA@SN6PR02MB4157.namprd
> 02.prod.outlook.com/
> >
> >>
> >>> +    }
> >>> +
> >>> +    closedir(dir);
> >>> +
> >>> +    if (!ring_size)
> >>> +        syslog(LOG_ERR, "Could not determine ring size");
> >>> +
> >>> +    return ring_size;
> >>> +}
> >>> +
> >>> +static unsigned char *desc;
> >>>   static int target_fd;
> >>>   static char target_fname[PATH_MAX];
> >>> @@ -406,7 +460,7 @@ int main(int argc, char *argv[])
> >>>       int daemonize =3D 1, long_index =3D 0, opt, ret =3D -EINVAL;
> >>>       struct vmbus_br txbr, rxbr;
> >>>       void *ring;
> >>> -    uint32_t len =3D HV_RING_SIZE;
> >>> +    uint32_t ring_size, len;
> >>>       char uio_name[NAME_MAX] =3D {0};
> >>>       char uio_dev_path[PATH_MAX] =3D {0};
> >>> @@ -437,6 +491,20 @@ int main(int argc, char *argv[])
> >>>       openlog("HV_UIO_FCOPY", 0, LOG_USER);
> >>>       syslog(LOG_INFO, "starting; pid is:%d", getpid());
> >>> +    ring_size =3D get_ring_buffer_size();
> >>> +    if (!ring_size) {
> >>> +        ret =3D -ENODEV;
> >>> +        goto exit;
> >>> +    }
> >>> +
> >>> +    len =3D ring_size;
> >>
> >>     Do we need this ?
> >
> > Yes, because len is being used as a temporary variable for storing
> > ring_size, and it is modified when we pass it with reference in
> > rte_vmbus_chan_recv_raw. In order to avoid calculating ring sizes again=
,
> > we need to keep ring_size separate.
>
> I misinterpreted your query. We can remove this line, since len is
> reinitialized to ring_size before using again in main() function.

post fixing these,

Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

- Saurabh

