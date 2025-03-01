Return-Path: <linux-hyperv+bounces-4191-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC787A4ACF6
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Mar 2025 18:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4D83AB0CB
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Mar 2025 17:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A861DF986;
	Sat,  1 Mar 2025 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YSz6kUKD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2131.outbound.protection.outlook.com [40.107.92.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE1F23F383;
	Sat,  1 Mar 2025 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740848424; cv=fail; b=ctR4tTAL+uFnn61YerAGo1laXkNPa1QpJA8m3YR3PXXsBC0n/jTurt908oRR8dgkRv2zfpOQcBzRl/c0zrQQNoSHz8WfieLwvK9n8ub+FSKTmitu3EQUtZ8RSeu+YX9qtXHpIZUUedS6EHVpBLU7l3h4m2OdhRBpNQt8bCtHVwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740848424; c=relaxed/simple;
	bh=R7qPSNgltoutWMHs1OQzKvOrkDqaVXEZco6Ym5YMAEE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aduYexS7sBgwDlpoB+y3MmUyNEBGZ/dbpVhqmZDMRwQtWU4M12wadIxGUlyS5W6dqCs9e2XO4a1I149uEr+RJu8l09p2ReYpJ+eVSPmjPkqQ+kGBPH1Z0wpG/Mmd5DIPw0RoXMfVtfEG0iH2V1bdd5MmJ+fK7qz1LE0tAT0738M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=YSz6kUKD; arc=fail smtp.client-ip=40.107.92.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Darh25qrgvIn0aYldYpnuue7Dmotb0cimOimXKibe/eXrT2KJX0L090DGlQ/S0eTGdezlHzf7My300UxlGvh9OUjL+r0Do5muyehT2dniVHAS1cXNBHrPvTWg+AOmldXNgjvHJPj0fWG6qo/N/3ruEzjHyWgiwciUdZM2m9gurCBFDlWluNb0UdTOVK9FATpVffFLn7JrfdBLsJpnVcTnqkzIHybUcT/Xqyf5FdcXNVVdJopK7UoTpA5A7sm1atA3bw4UvE/72XpE9a9t0jHGFK2G6loPj+BmFszfolkgKMaz2Oi88toCjYnbEqECT8Wizs7bAOuV6JbVwOT95aoDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7qPSNgltoutWMHs1OQzKvOrkDqaVXEZco6Ym5YMAEE=;
 b=RPzhNwrwzFALTHsOu5yjEVuJ5jQYqwPkyaqN/vC/uDQ27UekpXgAbFzWEqkg7Lh/NGeo0WykXtZ0l6xmp0qmid6sRmy31VJ0ocdmbHFJbDLdSmqCMNgomYU7tL9e/gGGSjaYZC+w3yA7Y+TYnDUnDqUo88B8aW1JsHTBKI2zoRmJ/XDWtkfHjY++9y9cdIrBFaDewImYG7LvvGnteNx2PSulFAsm+jTgld1XTwhEQs5PYLnVfPf/8vfPZUWs0ro9PFswQ+HrLca0fovfpUYQldkP9iK31JxKFof1QiLcrNPDF4MYBLppBEvSTmhRozRntN4hithFAL+Scv/iqTQ8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7qPSNgltoutWMHs1OQzKvOrkDqaVXEZco6Ym5YMAEE=;
 b=YSz6kUKD0RuvnutzSSj4sLlijDpjKjq6IRF+ReCY0iM6oLfwCFgPdbu8eFBHDFI2N4nfvpZqAz9v1TZtxkrTC4EauM4WMiaIFpT8G4IQuLLPaIni3ZwWA8AqU4EMgDfbyKBPdbOOQyTPvq818VQiYRGQ2g8mIgcyzIPsVpE1Hjs=
Received: from MN0PR21MB3437.namprd21.prod.outlook.com (2603:10b6:208:3d2::17)
 by MN0PR21MB3144.namprd21.prod.outlook.com (2603:10b6:208:378::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.12; Sat, 1 Mar
 2025 17:00:19 +0000
Received: from MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::19f:96c4:be9a:c684]) by MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::19f:96c4:be9a:c684%5]) with mapi id 15.20.8511.012; Sat, 1 Mar 2025
 17:00:13 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Yunsheng Lin <yunshenglin0825@gmail.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
CC: Dexuan Cui <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets
	<vkuznets@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linyunsheng@huawei.com" <linyunsheng@huawei.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Alexander Duyck <alexander.duyck@gmail.com>
Subject: RE: [EXTERNAL] Re: [PATCH] mm: page_frag: Fix refill handling in
 __page_frag_alloc_align()
Thread-Topic: [EXTERNAL] Re: [PATCH] mm: page_frag: Fix refill handling in
 __page_frag_alloc_align()
Thread-Index: AQHbik5MH771hPkvl0CS2gCCzDywnrNeTQOAgAAuB/A=
Date: Sat, 1 Mar 2025 17:00:13 +0000
Message-ID:
 <MN0PR21MB3437E18AA793762F242BE795CACF2@MN0PR21MB3437.namprd21.prod.outlook.com>
References: <1740794613-30500-1-git-send-email-haiyangz@microsoft.com>
 <cc3034c6-2589-4e9a-97af-a7879998d7d8@gmail.com>
In-Reply-To: <cc3034c6-2589-4e9a-97af-a7879998d7d8@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8d884ffe-634e-4c8f-8e2e-6e554caf15fb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-01T16:34:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3437:EE_|MN0PR21MB3144:EE_
x-ms-office365-filtering-correlation-id: de3d366b-efc2-4b01-b07d-08dd58e2886c
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BE95oc8l0dxjR9GRmdC5wiy0HZNALub3a+ZEn+5rUrVtOq9IfnzsO+CoaIjT?=
 =?us-ascii?Q?UuSkbZvVnEnsLuYxQ2DKy188eKWSolcNrZd+Mrcx94DnzqhfPqI5xx4tkii5?=
 =?us-ascii?Q?uQQdO5HpJi6dOMUifxrcrB/CbVA25yWByqWJ8KeI8ayrrAlfPNyaKvCrVjs6?=
 =?us-ascii?Q?kwh/YWjO5Ok77IxeCshRAZn7ggDu/9v/2v93tlpV9GdiPSomQlNhiQeiTQE9?=
 =?us-ascii?Q?sXy/DQ5XM++j6TA7rItCfWxcn7wBnL9e7L4o9q11w0RKucUSrw8P+zSCLX4q?=
 =?us-ascii?Q?X8Qi/fQ5SvDMWmFUBQZXuE55CL3aTgG6DJgtKYfIhTvRS88og3JkDE8ih0ZM?=
 =?us-ascii?Q?q3izP2+oAlTO6FPd/7uDMwoNMsEJ0OjX7nGR0+1X7VtMRedIFN9rGkws43U1?=
 =?us-ascii?Q?UycSXbNcJCyh0ju+KZ0LL5OyYoN/BxOAZrSAWqkY7Im34nb94nIwYmNVk+gR?=
 =?us-ascii?Q?gnILekD/Z0QvQ4j4Xt1bY71snOMWhVFpZYiz0D5B+oLyudqHFnEeh1xRPB26?=
 =?us-ascii?Q?YMor68q+TeiK2naXvMZtwYoIeVUh4TzYSIM4UsN9CIPAbuHMEK20lcgiUVUU?=
 =?us-ascii?Q?GlNubEEXC537B7Oaxrbkj04tKtibXp1LS60SYU9nwM4YmlrqIDLw7hHcv0oO?=
 =?us-ascii?Q?nO1fs4nmm6BM6HzK2w/rgOJUrPoPKDq/Iniv5dLtSAhntvWLNaSFnPnDIIzd?=
 =?us-ascii?Q?0PfiYT6pcCwhAm9vw8/d5U2M3goi7Q4yCv1xmfuHLufCO2ABKDQStTuQhiR6?=
 =?us-ascii?Q?KWCl6M6NdiHNRnGecIOrUWSWBA5zh6o/pRjO4jGqg4NhpkWeLictIPlGCtHo?=
 =?us-ascii?Q?GXbT6WH4mjfX8PUsDvZuyHQjmaqCRI0PbCPIK+t/400OjWuzck7Yg6fV99Zd?=
 =?us-ascii?Q?0hVDDyAdmlmR36R0FzdC4SuJ3AgfPSefVtqFFk9e4BuhlC2ZEv9i4t0i/3RN?=
 =?us-ascii?Q?WyeGO+gr5VgzU9i+ZcN7SoV0RIVnd7d97UICTHfAF7tpsXmJGe5kvjheBLNg?=
 =?us-ascii?Q?UElClTPoOBp6SHsxH6Qfgt+XLHE2J0dYbBaeuh8izRhfmrpfAPGmkN2K6nSt?=
 =?us-ascii?Q?T8HE0mKSpE4hta4m/RIP9YjGODgPSB9yN81tW3BgKPpYmqVpAPFfyoJ1W98v?=
 =?us-ascii?Q?zcrYh+x5nllyiFRH0Ae2pSEQUZonaXGbd2IVFz9xY8LxOXOwTZVueSZtHUpB?=
 =?us-ascii?Q?Jjmul+IGnfbPUbUqqt4JeibKAm4/4a5g7QBbIf/xqb66X7t9T/Y1u2e6tt14?=
 =?us-ascii?Q?sk7lSmXYdZTltPjkPnUnaav7YdZ6nketx9f+eZr1DQH/yRAmUGlMHhr2QYOn?=
 =?us-ascii?Q?8C3teOeH9IlPYz1iyzVjSGtV5Dgyw6dxhxqtX8hvpG/CbR3nkBl7AWseF4Yc?=
 =?us-ascii?Q?hyUbKwoaWw8iV2q5IIj1FS4hV21f?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3437.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0699gwolnfmnuIXJL8gO8Cvf2v1+Q3QXuxNE7z4B5t4edv/RJMFxgc+ZxsCN?=
 =?us-ascii?Q?feA5oG0EK/40xgz/J4DsgHyBhRy97A8AVIuhDHRw3QjSretrI041gxzZfkmS?=
 =?us-ascii?Q?LshhWHQo/+5/pYR/8CXT/ujF18MhGmC23d9P/wjfsBlP6ZLfXlRNizioWOwQ?=
 =?us-ascii?Q?1bZFlfQdEUuIGA7VD31L93Nm4NwWbAmS7XKhfi+dD1v7sL+5sDLiDDyPMH92?=
 =?us-ascii?Q?Fn8IkEgte4S4+ymChKZmUGulKf3QhfPxxKXFhA3ZZ2lTfoSmZVBGBxrj0Js4?=
 =?us-ascii?Q?rkVJv9lJ+crgewdbBxn3U+j+If9gitrawivOF5RNo/6q+JcDRIGC1tvf+Zrw?=
 =?us-ascii?Q?IDm7PtyDmqFLWguRM3/U+oEo6p7O2NvKguWLD2M4ugC/51g2KZPp/E4tndgH?=
 =?us-ascii?Q?eJbPIjaGlcaAncLnTG0bivKYBYPqIGgBoZg7DHaj2M4LEXS70Ci//dUjjgrW?=
 =?us-ascii?Q?X/dh6OK7JeVXMZMpZBqjfvCLEnZVnAy+Y4OrOuZE8WrfejRsC+VoUHkkN4lK?=
 =?us-ascii?Q?wzRkG2G9B4GMQylIUytCqq4IrTtdgaGIuLp/p4K+Wao+NM+mPKTKUxU3uV6n?=
 =?us-ascii?Q?AXgl7ZWvHb1yABBvaJYYp0Ak31PjR3XO0PFVsCcPgINYU25WWTvcSLr6RRXU?=
 =?us-ascii?Q?Sj/qUYmMQUPidU5ur7Pxs8Nc/mX+/DVFebZshl69+zrcfvpsHZosoIr2dIZw?=
 =?us-ascii?Q?zn6H2coj3UEKCCSL1aHoVpKDPDWLhc+PzbKTwV3FuT3yP76ffonWgtGPI1Da?=
 =?us-ascii?Q?XxWrMokgoR28mQQeTW/ESMy+6tZd/Y6ydMRuwRAlizlXqAuxVnz0d311Ej13?=
 =?us-ascii?Q?MtkasY66pKKSe992N/SYf+rdGvxNDwp9m0wvo3j/njmZqKaD9rqmsY2AbMWx?=
 =?us-ascii?Q?2BGEkMrGhjFVSj/O63ic0VvBzV5xfxI+241AlBZw0K3O0i9y3G3TuGk04Ci6?=
 =?us-ascii?Q?/ZXKvDRHWp2kRBbDBdzuXggy/ShAtz5o1RIhbgTCAioJDmspGBi/0nFV9k2n?=
 =?us-ascii?Q?zEUeu8Qc+PqxxJvdznin7SQQBedL4q+KYf8RjPMMsA6YUHmEf3jO/hWVx26M?=
 =?us-ascii?Q?BZ86tN5ippJ5SaF67CM99Tl0Q0znPB/YaKrUFN9RkI7xlPvwrbbOzA7TFO4e?=
 =?us-ascii?Q?FaI2ZBxH8CVB12vcJ+XJcicr9HOJbsITHtx965Styqyo0Yk5kQk2Cw1NoHG9?=
 =?us-ascii?Q?Hd4bJeWHEqIYur2HH5nEigeDINUSlk8nuiPwyIkg3UwrOALb98QTLlpWxsJI?=
 =?us-ascii?Q?/zw/U7oAKTfxSHPJ/CeW9XHEK5furHqSfwI1FEPm9jpr8XyPhoHXkBCE/V90?=
 =?us-ascii?Q?AZ8R0Poa0KsT6Ut/ak81TQL1gWrqVYqX1biMNInPMwss0sY82ynDjMIGxiga?=
 =?us-ascii?Q?cJE46R7w/eUoARfPaHrCgaoHo4HJRBH4d/jkIWTinn3tNU4ydX+FQGMauHpd?=
 =?us-ascii?Q?LmCJb0mRc+PIGKMnQ3+Jz3sRm7RZE9lcmd0CF6rimk0GAqXHdZnY32Yhx48J?=
 =?us-ascii?Q?GTIBOnlNJpIcgQ2OB+Q8w9WH4z0rxE5K0WkBVuTaM8yASglOolFqgxDGQeSR?=
 =?us-ascii?Q?85G3rQyFcIm4oDocD6DFkRF7tpaAGYzuRB0zhDkc?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3437.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3d366b-efc2-4b01-b07d-08dd58e2886c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2025 17:00:13.0917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CNjFpupeGuK9b5Mz3K2/4nbK8qKLdil7KjanKjzqC/Z2/2+6sKF84wihDVvb3hMrq57hTVpvyk+fZ8AHR9R/Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3144



> -----Original Message-----
> From: Yunsheng Lin <yunshenglin0825@gmail.com>
> Sent: Saturday, March 1, 2025 8:50 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>; linux-hyperv@vger.kernel.org;
> akpm@linux-foundation.org; linux-mm@kvack.org
> Cc: Dexuan Cui <decui@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> Paul Rosswurm <paulros@microsoft.com>; olaf@aepfle.de; vkuznets
> <vkuznets@redhat.com>; davem@davemloft.net; wei.liu@kernel.org; Long Li
> <longli@microsoft.com>; linux-kernel@vger.kernel.org;
> linyunsheng@huawei.com; stable@vger.kernel.org; netdev@vger.kernel.org;
> Alexander Duyck <alexander.duyck@gmail.com>
> Subject: [EXTERNAL] Re: [PATCH] mm: page_frag: Fix refill handling in
> __page_frag_alloc_align()
>
> +cc netdev ML & Alexander
>
> On 3/1/2025 10:03 AM, Haiyang Zhang wrote:
> > In commit 8218f62c9c9b ("mm: page_frag: use initial zero offset for
> > page_frag_alloc_align()"), the check for fragsz is moved earlier.
> > So when the cache is used up, and if the fragsz > PAGE_SIZE, it won't
> > try to refill, and just return NULL.
> > I tested it with fragsz:8192, cache-size:32768. After the initial four
> > successful allocations, it failed, even there is plenty of free memory
> > in the system.
>
> Hi, Haiyang
> It seems the PAGE_SIZE is 4K for the tested system?
Yes.

> Which drivers or subsystems are passing the fragsz being bigger than
> PAGE_SIZE to page_frag_alloc_align() related API?
For example, our MANA driver when using jumbo frame.
https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tre=
e/drivers/net/ethernet/microsoft/mana

> > To fix, revert the refill logic like before: the refill is attempted
> > before the check & return NULL.
>
> page_frag API is not really for allocating memory being bigger than
> PAGE_SIZE as __page_frag_cache_refill() will not try hard enough to
> allocate order 3 compound page when calling __alloc_pages() and will
> fail back to allocate base page as the discussed in below:
> https://lore.ker/
> nel.org%2Fall%2Fead00fb7-8538-45b3-8322-
> 8a41386e7381%40huawei.com%2F&data=3D05%7C02%7Chaiyangz%40microsoft.com%7C=
d73
> d6a0ae65b4a42681c08dd58c8087b%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%=
7
> C638764338396356411%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiO=
i
> IwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%=
7
> C&sdata=3DFJ7Ggrxxxv6QzKepUiHmtns1GZC2G2oJMcWSzOuFbsE%3D&reserved=3D0
We are already aware of this, and have error checking in place for the fail=
over
case to "base page".

From the discussion thread above, there are other drivers using
page_frag_alloc_align() for over PAGE_SIZE too. If making the page_frag API
support only fragsz <=3D PAGE_SIZE is desired, can we create another API? O=
ne
keeps the existing API semantics (allowing > PAGE_SIZE), the other uses
your new code. By the way, it should add an explicit check and fail ALL req=
uests
for fragsz > PAGE_SIZE. Currently your code successfully allocates big frag=
s
for a few times, then fail. This is not a desired behavior. It's also a
breaking change for our MANA driver, which can no longer run Jumbo frames.

@Andrew Morton <akpm@linux-foundation.org>
And other maintainers, could you please also evaluate the idea above?

Thanks,
- Haiyang


