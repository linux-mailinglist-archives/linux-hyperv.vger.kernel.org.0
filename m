Return-Path: <linux-hyperv+bounces-2213-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 924A78CE27B
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 May 2024 10:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B9A1C20828
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 May 2024 08:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7928B84E03;
	Fri, 24 May 2024 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cXjlZBXI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11024031.outbound.protection.outlook.com [52.101.46.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC2F38F97;
	Fri, 24 May 2024 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716540347; cv=fail; b=MmdGEqblmwDthS4tblVceURYiSTJidThrplFmR5Y5wwA1+AajJF8vo1vuNJ3ViT7zjZCcdLSWzqn1h8I6DYbwt+QFVfceiWGVVgvkaRYhtxe2V75VcsOR0824eC/UW7V/gVrc0ktaP/Xyntl6Vuyx+M2dWfCm66sJOnK2N1MqCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716540347; c=relaxed/simple;
	bh=vgmhDNjY64znRDOuB1ioATCrf2CNjxsLS8Ye6HmWELk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cP3vf9WJHQuigc9xRIRqeK8FE9ZLEGDI12lziu998WkHlI2//mdLFnh20daxMdERdtvUtH2dQQxW64NMwhjrik8p2btMVNPURxgybWvO2qLXCNZ2J6WALr6UeNyrTp11SoLSO57iPUAIHrGuGVqHARxJ/XzIQ4PF8zXuDnTaEVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=cXjlZBXI; arc=fail smtp.client-ip=52.101.46.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkjAWa7czNPcVAlbitwucujrKI/8cJYq/qzTReo71Gq61P3Ubyt6qidGEWzniou4w3hsaPbLslY7K6PPM/eN4jSIx3ahmsRiWjIx40ANeI4ePBgS6Ch+oHUg/LpWi+beRpCV3xTtPGFo7SXwxWC0dBEjMllIXpb4fBzrmV0OAInDNAFu+fXwJaK9g/FZRm/N7FoTNG+IGsbQ7/slw+4D2fDqq/905FINQIyzzzlHPuSLIKnW/Ba95TiboXut3K/y3jY6HNnx2oWT9W2KaFfeHDBdm+ByIqW2vHywCGsVmefG8svCIIKAjZnnj8IpvPRRJ/nx5avUQeV9mkOrLGzO5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgmhDNjY64znRDOuB1ioATCrf2CNjxsLS8Ye6HmWELk=;
 b=k+Gz6CS49bC0lS0HKxIapBeKdzB0Gs8aEHQQMzKdY+IkjU1F0afu27s1c5Tt50CFNS+wDadoPIhWz1J1G5xplYvkOI7o7iCvV3mFZy0o2Uja1Z2dd28xQ0SvKUgsKBl1Qcbd7+HE0yw+w/NIPoyeIM3OP08udNy/A3xvyxrmYEh089wXDMPbMCI2Y/h5nv+cppoDQ8nSnJJDAvuB9xMUVLb9E9sh58omTQkI+ZT0/I9bKWgTbb20IXKeDDWJWmBQR0GuHgsgNWjgavNo40OsXTu9KFFjY612wiGJK4wY8QgndUVS/dGe9dMpTXSsOdG6WBlAA7ZePp8tvQC/pif7bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgmhDNjY64znRDOuB1ioATCrf2CNjxsLS8Ye6HmWELk=;
 b=cXjlZBXIXp226+2xzZ5d/rcTGkmffgu+CXmLdIr3nlRaSspfMHysrzdPMk9RrWXZyTvl19kUHVocqTkvODtkuzrxY4iltaOgPK5+yQPjmy2xZSj4wdUHFG4QdY9OcKRcyHT5UD7rV6TRYHefBJo/sM5G0wy+TpHdeyGFmb7x7D0=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by IA3PR21MB4244.namprd21.prod.outlook.com (2603:10b6:208:521::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.9; Fri, 24 May
 2024 08:45:42 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%5]) with mapi id 15.20.7633.001; Fri, 24 May 2024
 08:45:42 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Dave Hansen <dave.hansen@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, KY
 Srinivasan <kys@microsoft.com>, "luto@kernel.org" <luto@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "wei.liu@kernel.org" <wei.liu@kernel.org>, jason
	<jason@zx2c4.com>, "mhklinux@outlook.com" <mhklinux@outlook.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tytso@mit.edu"
	<tytso@mit.edu>, "ardb@kernel.org" <ardb@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tianyu Lan
	<Tianyu.Lan@microsoft.com>
Subject: RE: [RFC PATCH] clocksource: hyper-v: Enable the tsc_page for a TDX
 VM in TD mode
Thread-Topic: [RFC PATCH] clocksource: hyper-v: Enable the tsc_page for a TDX
 VM in TD mode
Thread-Index: AQHarR0aBFzCpOqjJUiLi0r0Fn45m7GmDNmQ
Date: Fri, 24 May 2024 08:45:42 +0000
Message-ID:
 <SA1PR21MB1317CD997CCD64654B438754BFF52@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <20240523022441.20879-1-decui@microsoft.com>
 <299a83e8-cb13-4599-9737-adb3bb922169@intel.com>
In-Reply-To: <299a83e8-cb13-4599-9737-adb3bb922169@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=35a5da35-c3e5-48e7-a751-21c02511084e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-05-24T08:22:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|IA3PR21MB4244:EE_
x-ms-office365-filtering-correlation-id: e0e3b046-6eee-4097-ff6f-08dc7bcde52f
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|366007|7416005|1800799015|38070700009|921011;
x-microsoft-antispam-message-info:
 =?utf-8?B?UXNKUjA3SnAvTkw2aEpRVXU1eDRwZWJLaythWG9kMmFEeXpRT0kzRHNDVm1T?=
 =?utf-8?B?YXphWmM3SlFiUkhuVG13NWhZK214Tk5uN25kTmtreGtGcEYzK2NIM3REejJi?=
 =?utf-8?B?T1JmSEJwNjVocW5VR2JKeEcySHEwc0VQRDlwY0ZmR3hLRi82QWg1SHhoQmty?=
 =?utf-8?B?RVBsZFNlZHhvMmY5alVpUUJoaE5Ga2YyVjVSYko3eXhhL3BmaWd2VzlZUHk4?=
 =?utf-8?B?MnAwb2YyR1kxeHR4ci8rWkRTM2d2bDFlWjNraGdDbUxUbDMxdlZMUWhoWmdS?=
 =?utf-8?B?cGJ1OUtXS2lpVGNidzRiQkpybTVvNEZ4bXUva0tDZGtmeDBvNGc3ejNqWUs4?=
 =?utf-8?B?ck4rZkVma3JWTWR6WEdoY3lBd09YeXJLODdXaHhrL2NzUjhkQk1oUUpDcENs?=
 =?utf-8?B?OXcvMlRnY2l4Qy82VGlOS3VoSzNhR3oycmFQMTMzL0VNOCtGbUwwTzhFLzIr?=
 =?utf-8?B?YitTcXovNUFUSkh4S1pRRmJQNE9CeHIxMS91ME56RDFNOWNPY1dLMlpvbHJh?=
 =?utf-8?B?Q3BxTmdKRUw5VmM5aHpibGRPR0tHNUsrNHdoNGRUVDlzTld4NHpOVVRHVUxy?=
 =?utf-8?B?dlBsMXVlMnd1MXNrNCtwcStqaURqOGdNZ0p2QmJ6RWhIZ0U1VmkrODZRVlZy?=
 =?utf-8?B?SzNGL2pCWk9TSFB5NHFXY3NWQlc4bmhkendKa0haS0FWbFRZa0VNUmw3Tlpo?=
 =?utf-8?B?bkZXaUVWUy85V01GQ21Pa0xsdVZmUk1rZCtCTmNnYVg0OUR2ZTFoWnBZclQy?=
 =?utf-8?B?RW1VRE9rNGVITUpVSVIyL25xaWJBblUxN2V5enhmS0VjRXFDYk1yQjRJU2xu?=
 =?utf-8?B?OE80d2hKYWpzZG1tUWE2cHJiQ0x6VkJIOUVtS1Y0STZ1Q0ppQ1VSdStHSkpU?=
 =?utf-8?B?bm9pRFpIYjE2Wnc2SjdVTkVUN1p1Ly96aWVzd2xKTDhoU2lKYmlmbVJXaUpm?=
 =?utf-8?B?eGp4M1dEdmk2R3BQbDhOampSeWxTMTVSY1h2UDB4eW1WaENKWGFLR29KNUwz?=
 =?utf-8?B?YUVRcWtkQUI0eGUzYlRsSlpVcDZNNnN6U24rQWp1NzVmL1h4SmlZY1EvZXIv?=
 =?utf-8?B?eHIrWUhpalZtbGFaako0OUthUktBT3FBL1czblFlQUtuc1ZlMkdBV2VCd0N2?=
 =?utf-8?B?MkdFY2JIMTJlQmxRVUNla1NUQmwzaVhuSDBZRWQ3UURrdzBQNysrRllzMlhD?=
 =?utf-8?B?MDk0aEFzSVdmR2RSK3VubUNUbXl2dWNlZHBZSDFRNzZxQnFYUm5qUVhWeXRk?=
 =?utf-8?B?NHorT1cwQkR1TFU0VXN0L2lUWVZ5YWxPSk9KQ1NCSk8vSVJ4MlN6alhITmNv?=
 =?utf-8?B?d2xFS05kYTlXSFp5dDhFeTZwc21OZEQ1bDBrcUpXZWNZWURtSHhQeDdITzEz?=
 =?utf-8?B?Z3lCaUdraUxqM0VMSTZtOFdmTW4xL3BjeVljM1VDeklHUnZuVHlYWmV1TVN4?=
 =?utf-8?B?TUNWZ2xEbDJiRy9uOXlsdSs4MHFUZ0NJakNCaWNpK1VFSHFnSmRBM3hGdC9L?=
 =?utf-8?B?OHg4MXZ4S0RNSWZ1NFVtTXl2ajdVTHdKVktzRXk0UTJGbFNVdEV3cU5XNVY4?=
 =?utf-8?B?ZUN3ZmhzTW15SGkrWWFwU0RsaUwyMTRlU0VOSG55YU1nTEM3LzZxNzlDVEdm?=
 =?utf-8?B?VWcrQU9YNjBlRElubC9USDdaQ0RQNnR4eFIrWkIzRVExWHhYc1VEM1F2dGVZ?=
 =?utf-8?B?RjhtT0ZSZWVwQlZ2YU9SZ2trdkVYUzEzRE5ISTF2b3ZTQU5FV29ORlEvd1Rv?=
 =?utf-8?B?ZERqRjczTlRpR3g1SE5QOWlna0xFbEsralZHeEcyQmRxQ1N1ODZlaUhsMFZO?=
 =?utf-8?Q?5nAkcI6NiVBToKUvHHmtlyndvxDBBQsGxrhBg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bWU3WFloTkdGTzVRQjlxeTN2YllBK2tkZEM4R0VsRFdQU2x6d1ROM08wT1kx?=
 =?utf-8?B?RTJuQ3VPS282M0lRS3hKK202RGhmdmpsM3VDVExuamtjT2ZPM1d4TjNoZEVj?=
 =?utf-8?B?YlFLeE9NSldkTTVxNndlekxFLzdMTWVjL2tXYTNKS3dMWTZ4aVF2MlZrbDlV?=
 =?utf-8?B?enVMT0NBUlIrYkp2YS9sS1pNRk5WditqalJiVk5IaVluM3BtMkJVb2dtS0FH?=
 =?utf-8?B?NE1zU2FteUdOdzgxWXcyRk5KV1JxR3gxVnhyOERhVnBwTTI3REExdDMxa1F4?=
 =?utf-8?B?TDlFT2NQa25ySWVCeGRYRy9YcFNmamsxZnQzWjJpdkNpYmJSclFSSDdoN2Zr?=
 =?utf-8?B?TUxpYkNBRzQ0RTdMR2FZWkl0aHdlQ3BKa2lLRFkyNUk0ajQyVG1LUmZwekR3?=
 =?utf-8?B?UG02RldnSjdYYVRyeFNLbjBpSFI2UW9mTmE0ai9uWVZ2UktrcThWa1lxSTg1?=
 =?utf-8?B?UTJ5YmdvcGxnM0dmSllPRm1HemRzaGlyU0drczNuL2FCdzNmK3dlMlhkMTFP?=
 =?utf-8?B?L1B3YVhhM3BVUGpETzZuVXc0dUVIRmwzaTJjeXZPU1FJLyt1RFh2c3ZDQ29X?=
 =?utf-8?B?dFRSLytBMUxsVlVrYVFyejV1eXdrOGFkMDR4cy8yMTNZYmN2QldOUWtjTXBv?=
 =?utf-8?B?cENiSnRmOUd5Ulg4c09TdGpaWkZmQlhTT3VndmhjakhuVTFBd0FIc1l5cnNw?=
 =?utf-8?B?UkdWckFpTUtjUmdwNVhlbkRZZEo3b00ycFk2bUI1TmNGMnRBZVQ4UVExT2wx?=
 =?utf-8?B?SnMzakNLTlVoclloaklud0VoQlZyRlh5cGpKeThBUDlEZzNGYjFGYU8vNDJG?=
 =?utf-8?B?cHJ6MXNBMlhtdjU2Qk9RRlltT3RncElYVFBSVEJ1aFdiZEFpNkVhZ3N4cWFx?=
 =?utf-8?B?RGhWM3FuYjhDbDF4aEF5ZEdtdmFTK1dhZHRuK2lUd0FUcFNkMGpPS3ByVEJS?=
 =?utf-8?B?TEJQa3FuUjN2OWFNOHZoWUJJRjVETVFCMEo2NFhhSDh2MVB1bnFhTUNpd3F5?=
 =?utf-8?B?RE54ZGlEbGUrdXVabEg0aWVNL2x1eVNXeEhtSXAvWmg1TUI2d3RXcjliaE1E?=
 =?utf-8?B?Yll4bWFBc1FxQWt4UytFSEo0amFYQi9sVDRNcElHVGlPL2grQjBPUGlncEZk?=
 =?utf-8?B?Z1RiOWhBTUFYS0ZzQzZCWkQ3b3o5MUMza05HdDJpWHUzQk9tQ1JvN0Y5N2d0?=
 =?utf-8?B?YkpaOGpvTWhxMUpzY1c1dFBkcUNhTjNxMHpZVmVBQklJVFd4eUtDaHhLWXR3?=
 =?utf-8?B?MGlZTFdyZHZjTVVqR0N5WXJ6WHAydFptVENnYUhnS2lVZS90U3pGaTVQamdr?=
 =?utf-8?B?VmpPY0xVRFYyYUQvTTFNa1Y5TVJEVElwNU4vcmdjdHlQQTVqQVdSN09VZ0o2?=
 =?utf-8?B?ZVRRTDZ4UDIwY0ozQmZ4NldzenBNejFzQXVaNjI0dklLTEdJWnFoQWt2c3pT?=
 =?utf-8?B?eG50VHBXVWlOM2dEVFh4ZzE4dmFqd3ZiRXVYUVJnQmRzU2R2NTl1RHJEaGtZ?=
 =?utf-8?B?THIxQmZmaUZ6NE14bHdaVDcrdjRmV1J3eXczamYrdGxGTGJVekFHeUZWRGFB?=
 =?utf-8?B?MWVkVnArRXQ3czhwQ21IZ21KQlZRK1J1b0UxSW1BODZWVnd0d3pBeklDY25h?=
 =?utf-8?B?cWNjd3E2UGx4cXI5eXIwbXFLSXJtNGFlaXdhaHplRnRLTWl1R2NBUmhnZ1Iy?=
 =?utf-8?B?NXVmU0o0U0ZtZ1VtVXpST0pnQS9Dalh5bXhsTkJrZzlmcmpTd05WTnhOek9t?=
 =?utf-8?B?QTA5VXBBK3k5bEtUMVhCM0VhR1V1QmJtNFljcVQxKzBaRCtxcVpGN2t0MVBk?=
 =?utf-8?B?TmdhTEY2MEdjc2RVUmZSL2lxdUhwWmI3QXdoOUwrVi9XSkgvTGNUNFBKNnpx?=
 =?utf-8?B?Q0EveE5iaEsyaHVHcVo1enllSXFaZVA0Z3dmVWhqVzRaMklqck9Nb09DeWpZ?=
 =?utf-8?B?TDdHZ04rejk0UDZDNXJTVVBKbzVnaXNqTkV1NFZjQVNaMFV6TGx0WGNSc0hY?=
 =?utf-8?B?SGl3WXVHM1A3VGx3MjVnWmxCbEpOZ1NwbEMzZ3JtTXRLNWxueUhhSEhERkdx?=
 =?utf-8?B?T3R0STVxTmhmWGg2Q0xXS3RZZy8zeUkrQ3FpejhYQW8zOWFYVHRiV09uc3Uv?=
 =?utf-8?Q?Hj8o=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1317.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e3b046-6eee-4097-ff6f-08dc7bcde52f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 08:45:42.2858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2sBCwx9W2i2zqOGXBS2WFXfZtqaHXE4FnIi4nxYcNY858hFumSN3psGGTH1BlO6qVYaXLg261ieECBcg8S6CzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR21MB4244

PiBGcm9tOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgTWF5IDIzLCAyMDI0IDc6MjYgQU0NCj4gWy4uLl0NCj4gT24gNS8yMi8yNCAxOToyNCwg
RGV4dWFuIEN1aSB3cm90ZToNCj4gLi4uDQo+ID4gK3N0YXRpYyBib29sIG5vaW5zdHIgaW50ZWxf
Y2NfcGxhdGZvcm1fdGRfbDIoZW51bSBjY19hdHRyIGF0dHIpDQo+ID4gK3sNCj4gPiArCXN3aXRj
aCAoYXR0cikgew0KPiA+ICsJY2FzZSBDQ19BVFRSX0dVRVNUX01FTV9FTkNSWVBUOg0KPiA+ICsJ
Y2FzZSBDQ19BVFRSX01FTV9FTkNSWVBUOg0KPiA+ICsJCXJldHVybiB0cnVlOw0KPiA+ICsJZGVm
YXVsdDoNCj4gPiArCQlyZXR1cm4gZmFsc2U7DQo+ID4gKwl9DQo+ID4gK30NCj4gPiArDQo+ID4g
IHN0YXRpYyBib29sIG5vaW5zdHIgaW50ZWxfY2NfcGxhdGZvcm1faGFzKGVudW0gY2NfYXR0ciBh
dHRyKQ0KPiA+ICB7DQo+ID4gKwlpZiAodGR4X3BhcnRpdGlvbmVkX3RkX2wyKQ0KPiA+ICsJCXJl
dHVybiBpbnRlbF9jY19wbGF0Zm9ybV90ZF9sMihhdHRyKTsNCj4gPiArDQo+ID4gIAlzd2l0Y2gg
KGF0dHIpIHsNCj4gPiAgCWNhc2UgQ0NfQVRUUl9HVUVTVF9VTlJPTExfU1RSSU5HX0lPOg0KPiA+
ICAJY2FzZSBDQ19BVFRSX0hPVFBMVUdfRElTQUJMRUQ6DQo+IA0KPiBPbiBpdHMgZmFjZSwgdGhp
cyBfbG9va3NfIHJhdGhlciB0cm91YmxpbmcuICBJdCBqdXN0IGhpamFja3MgYWxsIG9mIHRoZQ0K
PiBhdHRyaWJ1dGVzLiAgSXQgdG90YWxseSBiaWZ1cmNhdGVzIHRoZSBjb2RlLiAgQW55dGhpbmcg
dGhhdCBnZXRzIGFkZGVkDQo+IHRvIGludGVsX2NjX3BsYXRmb3JtX2hhcygpIG5vdyBuZWVkcyB0
byBiZSBjb25zaWRlcmVkIGZvciBhZGRpdGlvbiB0bw0KPiBpbnRlbF9jY19wbGF0Zm9ybV90ZF9s
MigpLg0KDQpNYXliZSB0aGUgYmlmdXJjYXRpb24gaXMgbmVjZXNzYXJ5PyBURCBtb2RlIGlzIGRp
ZmZlcmVudCBmcm9tDQpQYXJ0aXRpb25lZCBURCBtb2RlIChMMiksIGFmdGVyIGFsbC4gQW5vdGhl
ciByZWFzb24gZm9yIHRoZSBiaWZ1cmNhdGlvbg0KaXM6ICBjdXJyZW50bHkgb25saW5lL29mZmxp
bmUnaW5nIGlzIGRpc2FsbG93ZWQgZm9yIGEgVEQgVk0sIGJ1dCBhY3R1YWxseQ0KSHlwZXItViBp
cyBhYmxlIHRvIHN1cHBvcnQgQ1BVIG9ubGluZS9vZmZsaW5lJ2luZyBmb3IgYSBURCBWTSBpbg0K
UGFydGl0aW9uZWQgVEQgbW9kZSAoTDIpIC0tIGhvdyBjYW4gd2UgYWxsb3cgb25saW5lL29mZmxp
bmUnaW5nIGZvciBzdWNoDQphIFZNPw0KDQpCVFcsIHRoZSBiaWZ1cmNhdGlvbiBjb2RlIGlzIGNv
cGllZCBmcm9tIGFtZF9jY19wbGF0Zm9ybV9oYXMoKSwgd2hlcmUNCmFuIEFNRCBTTlAgVk0gbWF5
IHJ1biBpbiB0aGUgdlRPTSBtb2RlLg0KDQo+ID4gLS0tIGEvYXJjaC94ODYvbW0vbWVtX2VuY3J5
cHRfYW1kLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9tbS9tZW1fZW5jcnlwdF9hbWQuYw0KPiAuLi4N
Cj4gPiBAQCAtNTI5LDcgKzUzMCw3IEBAIHZvaWQgX19pbml0DQo+IG1lbV9lbmNyeXB0X2ZyZWVf
ZGVjcnlwdGVkX21lbSh2b2lkKQ0KPiA+ICAJICogQ0NfQVRUUl9NRU1fRU5DUllQVCwgYXJlbid0
IG5lY2Vzc2FyaWx5IGVxdWl2YWxlbnQgaW4gYQ0KPiBIeXBlci1WIFZNDQo+ID4gIAkgKiB1c2lu
ZyB2VE9NLCB3aGVyZSBzbWVfbWVfbWFzayBpcyBhbHdheXMgemVyby4NCj4gPiAgCSAqLw0KPiA+
IC0JaWYgKHNtZV9tZV9tYXNrKSB7DQo+ID4gKwlpZiAoc21lX21lX21hc2sgfHwgKGNjX3ZlbmRv
ciA9PSBDQ19WRU5ET1JfSU5URUwNCj4gJiYgIXRkeF9wYXJ0aXRpb25lZF90ZF9sMikpIHsNCj4g
PiAgCQlyID0gc2V0X21lbW9yeV9lbmNyeXB0ZWQodmFkZHIsIG5wYWdlcyk7DQo+ID4gIAkJaWYg
KHIpIHsNCj4gPiAgCQkJcHJfd2FybigiZmFpbGVkIHRvIGZyZWUgdW51c2VkIGRlY3J5cHRlZA0K
PiBwYWdlc1xuIik7DQo+IA0KPiBJZiBfZXZlcl8gdGhlcmUgd2VyZSBhIHBsYWNlIGZvciBhIG5l
dyBDQ18gYXR0cmlidXRlLCB0aGlzIHdvdWxkIGJlIGl0Lg0KTm90IHN1cmUgaG93IHRvIGFkZCBh
IG5ldyBDQyBhdHRyaWJ1dGUgZm9yIHRoZSBfX2Jzc19kZWNyeXB0ZWQgc3VwcG9ydC4NCg0KRm9y
IHRoZSBjcHUgb25saW5lL29mZmxpbmUnaW5nIHN1cHBvcnQsIEknbSBub3Qgc3VyZSBob3cgdG8g
YWRkIGEgbmV3DQpDQyBhdHRyaWJ1dGUgYW5kIG5vdCBpbnRyb2R1Y2UgdGhlIGJpZnVyY2F0aW9u
Lg0KDQo+IEl0J3MgYWxzbyBhIGJpdCBjb25jZXJuaW5nIHRoYXQgbm93IHdlJ3ZlIGdvdCBhIChj
Y192ZW5kb3IgPT0NCj4gQ0NfVkVORE9SX0lOVEVMKSBjaGVjayBpbiBhbiBhbWQuYyBmaWxlLg0K
SSBhZ3JlZSBteSBjaGFuZ2UgaGVyZSBpcyB1Z2x5Li4uDQpDdXJyZW50bHkgdGhlIF9fYnNzX2Rl
Y3J5cHRlZCBzdXBwb3J0IGlzIG9ubHkgdXNlZCBmb3IgU05QLg0KTm90IHN1cmUgaWYgd2Ugc2hv
dWxkIGdldCBpdCB0byB3b3JrIGZvciBURFggYXMgd2VsbC4NCg0KPiBTbyBhbGwgb2YgdGhhdCBv
biB0b3Agb2YgS2lyaWxsJ3MgIndoeSBkbyB3ZSBuZWVkIHRoaXMgaW4gdGhlIGZpcnN0DQo+IHBs
YWNlIiBxdWVzdGlvbnMgbGVhdmUgbWUgcmVhbGx5IHNjcmF0Y2hpbmcgbXkgaGVhZCBvbiB0aGlz
IG9uZS4NClByb2JhYmx5IEknbGwganVzdCB1c2UgbG9jYWwgQVBJQyB0aW1lciBpbiBzdWNoIGEg
Vk0gb3IgZGVsYXkgZW5hYmxpbmcNCkh5cGVyLVYgVFNDIHBhZ2UgdG8gYSBsYXRlciBwbGFjZSB3
aGVyZSBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpDQp3b3JrcyBmb3IgbWUuIEhvd2V2ZXIsIEkgc3Rp
bGwgd291bGQgbGlrZSB0byBmaW5kIG91dCBob3cgdG8gYWxsb3cNCkNQVSBvbmxpbmUvb2ZmbGlu
ZSdpbmcgZm9yIGEgVERYIFZNIGluIFBhcnRpdGlvbmVkIFREIG1vZGUgKEwyKS4NCg0KVGhhbmtz
LA0KRGV4dWFuDQo=

