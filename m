Return-Path: <linux-hyperv+bounces-6844-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B89A3B557BC
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 22:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC72AA7C5D
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 20:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C74E298CA3;
	Fri, 12 Sep 2025 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PsGxXi2n"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020106.outbound.protection.outlook.com [52.101.46.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AFF2652B2;
	Fri, 12 Sep 2025 20:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757709696; cv=fail; b=pKci6Y9ynGt+kh40uRsFhadZkMQSTPX8JrGJKjzLq4wE1jDZl7mqqvX/iWDWZR1PwfwlhIFJuD6qqQanwTreSzuAs2GfSzvWZFlDiPU0+wJASSQd9ffhkeUgoqss35OmuFBYnilsm5buySMLO29r0W1F6XPeS6WBnpQrE+deJi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757709696; c=relaxed/simple;
	bh=Rnw268tDUUhjvYKS9ttBwamH2lgbUuqip93iQGr3InM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JYN3JPzjy+5hOA6f48v8Rs8Jl68mMQCD7f2DpVLpFqXWD18+Yq48OqOM/c2qn/MlhOIa8FIM6K3S/CG0vigsHEGbPTKYMS7i1gJn0+ottlaUpcMSk7RskTgfNSKT98UiK8sboB0xLlDt3LMfeKgWpd2BPS7I8nSA2Ezqby9s/Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=PsGxXi2n; arc=fail smtp.client-ip=52.101.46.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8m7ktv/0IfLnmtbxLB6+kviMxV/X+qMlwaX9se+KcfiECcrKc6Bfbuoos5R0MnU1FZDHRRNF3d2DR3GlYF94Z8KDLAvi9lTyafIDKTQxGxL6VMqkPYNlw9ZfLGoWauMYr9x1UJBJkhDJMzoDo0mHZdESUIEICTEJJFe71eV10s9q+oM5UpGlwV6omsZsLt3vYZE6K+2Q9EwjJVi0OY9VYMQ+zQDdDGrPfbc9T0+HNFMPiKPN98MoeAdb4XaibRvooiQikHZZE5SsCcQz8fuGxxmunPpTyMA8GNEbjFmkXTmy+WaoeqrZUT9nHPAKZiO32SkM6u6mDmr25ri6PfrFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rnw268tDUUhjvYKS9ttBwamH2lgbUuqip93iQGr3InM=;
 b=kov/cBjoYEIL/CMIz5To5axL3sBeXgIrIv45yppLVUmkAVPvhHajDmiA7klHm0p07TmCDzNGnlDP+IRcCnEAYC96o0BFTbnsPupkqcUzujgsi6CmxHj/RZYYDHAqE1VAacinpoQo37s5WoqR6RU6Ob3QFRdsruXPtk8/lysEkdTXlUTEU7IV22dtPUNTkwPmPL1jcguj/4G1S9pMpOS6Cw8PbWZDHGiXyjK+STHDhzSXnyP5V1VBBY1paBqGsJusQ5Itym3RC0uKg5Mzk3DiMWMhA3gj3alEObE+8D/3iXU35IK6sTim3eo2MjdBZh0elhL5yaRtvxZ82gHEHZi59A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rnw268tDUUhjvYKS9ttBwamH2lgbUuqip93iQGr3InM=;
 b=PsGxXi2nar2Tf8WWBhGod63cTeL4Aq9WlXcE/ghQC+ISNUnRf0pV1tdAaSefr/JZCeXVSheTOG7+flji5+EoTfKYX270BF1hdDxhtT6lzXR37VOsV32o4RW72LXTeSb3akuKwyUA/7Udfxk5cbOyOgKUrXLe02fAeMaYfOpzqCU=
Received: from DS3PR21MB5878.namprd21.prod.outlook.com (2603:10b6:8:2df::6) by
 DS4PR21MB5322.namprd21.prod.outlook.com (2603:10b6:8:2aa::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.4; Fri, 12 Sep 2025 20:41:32 +0000
Received: from DS3PR21MB5878.namprd21.prod.outlook.com
 ([fe80::72b7:dfed:2b1d:c845]) by DS3PR21MB5878.namprd21.prod.outlook.com
 ([fe80::72b7:dfed:2b1d:c845%4]) with mapi id 15.20.9115.002; Fri, 12 Sep 2025
 20:41:32 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>
CC: "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>, Chris Oo
	<cho@microsoft.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ricardo Neri
	<ricardo.neri@intel.com>, Yunhong Jiang <yunhong.jiang@linux.intel.com>
Subject: RE: [EXTERNAL] [PATCH v5 04/10] x86/dt: Parse the Wakeup Mailbox for
 Intel processors
Thread-Topic: [EXTERNAL] [PATCH v5 04/10] x86/dt: Parse the Wakeup Mailbox for
 Intel processors
Thread-Index: AQHb592wQqp/wGZIlkOjlYhiE1DE6LSQe0lA
Date: Fri, 12 Sep 2025 20:41:32 +0000
Message-ID:
 <DS3PR21MB5878E8CCE452CAF760EA1F23BF08A@DS3PR21MB5878.namprd21.prod.outlook.com>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
 <20250627-rneri-wakeup-mailbox-v5-4-df547b1d196e@linux.intel.com>
In-Reply-To: <20250627-rneri-wakeup-mailbox-v5-4-df547b1d196e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8d38b468-965c-493b-b113-0b995844e84b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-09-12T20:40:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5878:EE_|DS4PR21MB5322:EE_
x-ms-office365-filtering-correlation-id: 6b7dc282-9675-4247-6ef5-08ddf23cc242
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|7416014|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?anRqbjhLOVJTckgwRE14UVNSWThhajNlVXYzU2FnM2ExZ2VGbis3dlM5RW56?=
 =?utf-8?B?RWQrSjlmZmdwaVNGa2l0NzNiRUozZHlwYyt5aHlVM01RK1ZrTGNKMGE1cEVk?=
 =?utf-8?B?akxwWXJ5ZjJ3eWFDT25JcHdyMjI4YVZ2alBkZXk5WW9KV2N6RTBJNDh5M2du?=
 =?utf-8?B?azNLa1d1aStyUER5Q21UdXFjN2c5NloyUzVieForZzVudGZ1QXlyczV1MUF0?=
 =?utf-8?B?WnhrUkdhVmFOZXhvWkk1U0E2RDJldTVTYWE0d25pZm5PSzFuRy9LZUZtbFlw?=
 =?utf-8?B?REtFeHJ6VjYwOStOZDQ1cmIrSFA2QzVMWU0xd0cwTEErMTNraHozWU5waEVL?=
 =?utf-8?B?YmxsYnFBRjFHWWpOTnBnS0MxQ1VjbjlkSTNSZU5GS1JZa2pKam93MGh0ci9L?=
 =?utf-8?B?U2xjRTlTWG95TWpiK0NPSm8xUkhSUDhHQ3cwL2xKR2JwU1dsckd1REpyR3lF?=
 =?utf-8?B?alRsTzJWWkxRMFF5bCs2ajdrMEgvWlNTTVJ6WFU2Wnc1cVF5WkdCSDEyRys0?=
 =?utf-8?B?R3JJdXhESHQxU2dEVGY5ZDhia2RxcUc4Ukl3R3FMNXNTdkplVmlyUHFVNlJL?=
 =?utf-8?B?UWhGUUF1djFxOG5TVk9DcTZkSklBQ28xUEN2MlQ0WmQzWWdFeUVaTWh1Skdw?=
 =?utf-8?B?cldHcytNUTZ5NlZIekZDenJ4Ym15M0VadVd6S3JNQXlrWXNlOTlMUTVQaWZs?=
 =?utf-8?B?NEZNQUZpbkJXMlhNdlpGajc5MTJ1eTRDcG1hSGhGMnF6T2ZIMzB0ZGhMWHl0?=
 =?utf-8?B?M2NmN1lYY2VuMU9VcWc4U0NicDNtc0t2SVlxZXBIdXBtVlp0MW5XdTN3djZG?=
 =?utf-8?B?a2dSNjJLTlFaMTl0Y09PVXUvUVVVTGFhSm0yYWJhanBCbUJTRW1BZUtGWFRj?=
 =?utf-8?B?U2lNejZocmRma0JVNHQ1K3RGVDdCcTRKcWplalZYN1dlY1BacVdhQURUbm1H?=
 =?utf-8?B?ejhpYzhCaWhMK3FjSEFURmZSdkgrNnlUSy9xR3JNV2FGdUVaNXVzemhkZ3lr?=
 =?utf-8?B?NEcybHpZcStiQzhWZjF5SXNTZ3BzSWRIUGpGOUtmSGJJSlcwUUM5aDl5cm54?=
 =?utf-8?B?TzBDdHdGK2lOUHBrdHg4TGx5RENwU3lleEJ1UDR5TFlCV1Y3aHM3UEdCYjdI?=
 =?utf-8?B?QzAvL3piVHIrcERHa1h0Z2xaSi95eHgrMXhuRnVNcGhTdktKS3RLakRnbTdu?=
 =?utf-8?B?cG95N0pPenQwM3hHUUZUUHk2VzBCenQ0S3FrcUZURXl2QVBqcmNNV3VOZFYz?=
 =?utf-8?B?MXhLV2ZOeiswclZ6TFA5RTJNRWxnaUFSWlg0WkdCclpIN2FKRWhQcHVUcjRG?=
 =?utf-8?B?V3FYZ2EvVjc0cUpRbTU0UElJS2pIMHJOaFp6a3l1UVRvV2tHVGVQZUFwYnVW?=
 =?utf-8?B?NkREYjNKUUdaYllxSXlVdC9PQVVzWlQvejk5NjhrVUZSM0psVDRPalRETGxI?=
 =?utf-8?B?QWJGMGJ0ejhlbjZScWNwZXBsTEFOUmNzbmRKdDIxWnFpWEw2QjNjK0NyM3Nm?=
 =?utf-8?B?bzhhSkU1eDZ1dGVkRXRSM3JoeWpLQy9FOWQzU0NRRUNZRkMxUWplM2lTRjFx?=
 =?utf-8?B?OUdJL0IyMURhd3lHV2ZHajZnN2dDRXJPbTQ5Kys1Wi9qdkdBTTFRZHdSRUcv?=
 =?utf-8?B?Q0NmZFd5YnZ2bTlVOWkxaVFSeFdKcXRVb2FYd0tGSkhIZGNTbFp4amxCak03?=
 =?utf-8?B?VUhab1JtY3JTYy9mSXIySDUvVDRtYzU1VDZqWVFQVGx5bG03aVI0UDdsN2Fz?=
 =?utf-8?B?bFZ2b2VjMVdQQUtrUGRtbkswTFJvcFRmMEQwRStIMXRGUWM1WUtIYzRWNjVz?=
 =?utf-8?B?bUxrWGdiMVVsMW1XVjRySTFvUGxVSGVRV2cyZDY1ekpxUDBnQno1M3FOczln?=
 =?utf-8?B?V0xseTU2emptR0NRNjA2YjBmR1EzN2dOYVNRUHJ6NWpXQ3RGL0JyNy9RUVJR?=
 =?utf-8?B?LzZ3TGQ2M3d4bjB4V2FoczYrMmtqeUMyRmUwUFVrM2RHMzh4Uk1DODBuUy9k?=
 =?utf-8?Q?mKkUJqiC02j4r25oWKwzQ121+O0kfs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(7416014)(366016)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RTRQcThuMHlES1dLMkNaa28ySkp1M1Y2UnJvZjNncjRJenU5cHdtMzZoSnFs?=
 =?utf-8?B?WnFUS2VpOS9kb0dzVk5wODBPZlBjem1BL0VqZlAyUHpucmtrSGszNENpY1Ni?=
 =?utf-8?B?cjBXU0wyU1NRWllqWEdBakRCc2hhVTFrRW0zdFFKelhLMzVocnA0TVB0SkNN?=
 =?utf-8?B?cTBiK2JPcTBVZ2EvRHg1KzFsR0J5eWNVSVh5c0l0YWJTd29PTHQyZkN2eXZy?=
 =?utf-8?B?dSsvbnhLN3JqZHdBdjNoQWwvb3hWMUFDRHNjWFNSb0VoSHBKOG1rL2V2ajJj?=
 =?utf-8?B?dkR3YkVWbldzWnptak1XdFhaTTBHUHBuemxUTWZVUEtMdk1TYVIwWDIyUWtw?=
 =?utf-8?B?ZTFyMDVXVE0rSjFHdm1HZElCaGUzYkdtT1NGTHZuTWFUK0NpT3hsbEtFanEx?=
 =?utf-8?B?bC9BV3BhRnZyOEUxYzRXbHlSc3JtMFFxSEVHa203aVJVeUEvVGJYV3JtS1dt?=
 =?utf-8?B?RHhmUVZocy9LdVlMNytFa2djWlVLbktqK3NaN2lCSzIydjErUUFwS0FGc3JE?=
 =?utf-8?B?a2R1cXN4aFhJckVqM2MxWVprN2U2bjBhbEZLY3p6eTI4Q2FqdDdaT3h2dlFJ?=
 =?utf-8?B?TFVpYUhPVm1zV1hsSkVvTGlQemFxQ1ZKOVZjMWFFbmFxeFE1QnhMV0VWdzVu?=
 =?utf-8?B?OTRFRTQ4R2p2OXZCN2pJT3lmMHhvVUVlM2xKOXhlblpxcm9GZjNFdk0wR09y?=
 =?utf-8?B?Z1doM2dnMER1TkMyTzREZ3FnWXRNOHVYNUpuNG1ucldVSFhERFZvZEJzWFNJ?=
 =?utf-8?B?eHNFMXFNZk4vV1BXMEFYcXE0NlpnT3AySG94eWh2YTQ5V0VraHNsSERLclhs?=
 =?utf-8?B?ZHBaSGtvUHlxRG5CZUVJY3ozSmFVNFhjOGd0ZFFSendSb0gzNmRiclhOOGh2?=
 =?utf-8?B?S1lxZXg4QTN6ZWNkNkhIWnJtMlRLUllqODJudWkrNW9FUGs4NXBEK1lLTThn?=
 =?utf-8?B?eEJyeGVxbHRvZEwvcGo0VUdHeWFTUHBiUVVxcjl5cXJiM2ZHUWpZVWd6S2FS?=
 =?utf-8?B?R05jNDR2aDJVdUE2RVErNUNCTHNxK0NKbHRXRlNMZnh4d003aFBmZUdGRUF2?=
 =?utf-8?B?SHlzaDJXQ1A1c2xHd0QzNGxyN0J1eDBLR0RBRU1MVm5ubjc3SktCVFZoQUxF?=
 =?utf-8?B?Zm9EY0FGZnVIanBRSURVaklFZGR5MlZucUgrN1pQZVdiYWRRNWdteWV2NnE1?=
 =?utf-8?B?cGJ4c1pkYjRMTEwxbUZlWWZ4VmMrclUvZGJUVDBBRHJaYXZ2bTA1TXVMai80?=
 =?utf-8?B?Z3JIc1pGQ2pBcGNoMU82bnBFK3NoRkpNWWV4OXRiVjVKZnFkTmorRFBaZk5N?=
 =?utf-8?B?cy9ZMmJzSGhiR1VrSUxQdlRqVWpsaDRCUDBIWkdwM2VYdXB1S3pIcXBKeHND?=
 =?utf-8?B?MkV1Yi9xVU05MVNocVdUWnp4YVFMNUtBSFNGaUQzaGJZaGROZVBPSzhOTzhB?=
 =?utf-8?B?RDZhUDFESnJSSEg0eUllNUcydDdmT2d1VVBMMU13V0xaRk1rR0N2bGZwSzEx?=
 =?utf-8?B?UzIwdHFoZTVhOVBTdXYwbFJORXB6YkVWbW05UCtpVUhvTTYySHBkOEpaQ1lX?=
 =?utf-8?B?Y3JZWWNIYU9wUVZKc3hRMGsrU01ibHpzUjRIdkxhUVpkbENEVFNUWGxwcjNM?=
 =?utf-8?B?RVFNVi9RcUtkVnJXRm9uVWlTZjR2ckViSllFaksyODQxb0dYb2JSUnFxNmhr?=
 =?utf-8?B?c3dUMHZXdk1KUGlvS2RwR0paQStEQVVRQUxvaFhuSlJEcW5zeGpUd3ByQXNw?=
 =?utf-8?B?OUhPQUU1MlZucDFpTDQvRHI2YUtNVE81TFF2cDV2dmFMLzRRVDlPTnRvZng2?=
 =?utf-8?B?NVRNa1FFdmxYMmxtRGpTdVlpV3RHM0F2blZQekZZNDl2Nm45bCtLU3NqZjFn?=
 =?utf-8?B?elFoSVVZbU5VYTBDT1ZJejBWbUZSby9SMjQvM0xlMzZoY0ZOTnRFN2p0Q0Zi?=
 =?utf-8?B?NWlkZ2tkbmNZMGZvTklvVXRCcUVjVm9BaStPNVBUaTdJYzBTNnczYkVObHRU?=
 =?utf-8?B?VUpqWlNmaTdER0F1MzNCanFWckpvRjhXcHNVbVZUaG1NMmZIQlZxQTlaSlZW?=
 =?utf-8?B?RUloRWlsV1JyV0dBUGpFdUdPb21KbnlHcXc3UVFsTEk3cFFaYTlZSWNoV01p?=
 =?utf-8?B?MitIbDFCUk1xVUFBdm1SVXlUR0NXWjlGSS9tQnA4SVRqVmkydG5ybmN0dUNQ?=
 =?utf-8?Q?o5iN1p+b7HMW63/0mlVmHz8wfBxg/mJOj7C4NMc/epXu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7dc282-9675-4247-6ef5-08ddf23cc242
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 20:41:32.7280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JOpxpxruoZ9MjFqLzSKKKS/au3+P+ryZznZ35zXadc7OOrMw1ynoK/dFTYuCDwbwHlGGhA7fbBlGHx898rVMyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB5322

PiBGcm9tOiBSaWNhcmRvIE5lcmkgPHJpY2FyZG8ubmVyaS1jYWxkZXJvbkBsaW51eC5pbnRlbC5j
b20+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAyNywgMjAyNSA4OjM1IFBNDQo+IFsuLi5dDQo+IFRo
ZSBXYWtldXAgTWFpbGJveCBpcyBhIG1lY2hhbmlzbSB0byBib290IHNlY29uZGFyeSBDUFVzIHVz
ZWQgb24gc3lzdGVtcw0KPiB0aGF0IGRvIG5vdCB3YW50IG9yIGNhbm5vdCB1c2UgdGhlIElOSVQg
KyBTdGFydFVwIElQSSBtZXNzYWdlcy4NCj4gDQo+IFRoZSBwbGF0Zm9ybSBmaXJtd2FyZSBpcyBl
eHBlY3RlZCB0byBpbXBsZW1lbnQgdGhlIG1haWxib3ggYXMgZGVzY3JpYmVkIGluDQo+IHRoZSBN
dWx0aXByb2Nlc3NvciBXYWtldXAgU3RydWN0dXJlIG9mIHRoZSBBQ1BJIHNwZWNpZmljYXRpb24u
IEl0IGlzIGFsc28NCj4gZXhwZWN0ZWQgdG8gcHVibGlzaCB0aGUgbWFpbGJveCB0byB0aGUgb3Bl
cmF0aW5nIHN5c3RlbSBhcyBkZXNjcmliZWQgaW4gdGhlDQo+IGNvcnJlc3BvbmRpbmcgRGV2aWNl
VHJlZSBzY2hlbWEgdGhhdCBhY2NvbXBhbmllcyB0aGUgZG9jdW1lbnRhdGlvbiBvZiB0aGUNCj4g
TGludXgga2VybmVsLg0KPiANCj4gUmV1c2UgdGhlIGV4aXN0aW5nIGZ1bmN0aW9uYWxpdHkgdG8g
c2V0IHRoZSBtZW1vcnkgbG9jYXRpb24gb2YgdGhlIG1haWxib3gNCj4gYW5kIHVwZGF0ZSB0aGUg
d2FrZXVwX3NlY29uZGFyeV9jcHVfNjQoKSBBUElDIGNhbGxiYWNrLiBNYWtlIHRoaXMNCj4gZnVu
Y3Rpb25hbGl0eSBhdmFpbGFibGUgdG8gRGV2aWNlVHJlZS1iYXNlZCBzeXN0ZW1zIGJ5IG1ha2lu
ZyBDT05GSUdfWDg2Xw0KPiBNQUlMQk9YX1dBS0VVUCBkZXBlbmQgb24gZWl0aGVyIENPTkZJR19P
RiBvcg0KPiBDT05GSUdfQUNQSV9NQURUX1dBS0VVUC4NCj4gDQo+IGRvX2Jvb3RfY3B1KCkgdXNl
cyB3YWtldXBfc2Vjb25kYXJ5X2NwdV82NCgpIHdoZW4gc2V0LiBJZiBhIHdha2V1cA0KPiBtYWls
Ym94DQo+IGlzIGZvdW5kIChlbnVtZXJhdGVkIHZpYSBhbiBBQ1BJIHRhYmxlIG9yIGEgRGV2aWNl
VHJlZSBub2RlKSBpdCB3aWxsIGJlDQo+IHVzZWQgdW5jb25kaXRpb25hbGx5LiBGb3IgY2FzZXMg
aW4gd2hpY2ggdGhpcyBiZWhhdmlvciBpcyBub3QgZGVzaXJlZCwgdGhpcw0KPiBBUElDIGNhbGxi
YWNrIGNhbiBiZSB1cGRhdGVkIGxhdGVyIGR1cmluZyBib290IHVzaW5nIHBsYXRmb3JtLXNwZWNp
ZmljDQo+IGhvb2tzLg0KPiANCj4gQ28tZGV2ZWxvcGVkLWJ5OiBZdW5ob25nIEppYW5nIDx5dW5o
b25nLmppYW5nQGxpbnV4LmludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWXVuaG9uZyBKaWFu
ZyA8eXVuaG9uZy5qaWFuZ0BsaW51eC5pbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFJpY2Fy
ZG8gTmVyaSA8cmljYXJkby5uZXJpLWNhbGRlcm9uQGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQoN
CkxHVE0NCg0KUmV2aWV3ZWQtYnk6IERleHVhbiBDdWkgPGRlY3VpQG1pY3Jvc29mdC5jb20+DQo=

