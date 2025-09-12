Return-Path: <linux-hyperv+bounces-6848-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8895AB557D5
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 22:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E27AAC351F
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 20:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1652D29AC;
	Fri, 12 Sep 2025 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XlsTnahH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021121.outbound.protection.outlook.com [52.101.57.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D9C15C0;
	Fri, 12 Sep 2025 20:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757710003; cv=fail; b=bBxHDIePrEZ1/Zr4q0vROp+SLG2Xaez+ROxy4KkjedrrKYJrawSlwrFLcLT2WudV1lwQfwMcVrnEwkqwuz1Wu5DQU+t5DqCeT4NqU9YewN0xSbbuucG6a3ZWa3sbA/fyUnQYpqFH6SyNAamZVFWvb0XSkzwWnUi0Fj3XsDElNwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757710003; c=relaxed/simple;
	bh=W7ngImZOU9b4M9g9+GD8zVNES0DMM51aR6TH9wGDy3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kq6NYEE1/6t4eBqwPjp1tJTCftehb0Ny/Fe9Ke/27iBdH/WfndulANTqcPyYEnzGr5oG7w6W0r10OE32RKGTK+ROqXSwC8FW3jQZCUaBlzV2J9Y+IrSPJU8N2mETBTM8r1P2du3C1jcXNKFr19zLj2BRSR/KpEry/cG78lo4Jv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=XlsTnahH; arc=fail smtp.client-ip=52.101.57.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmYlhk8WW0HOdLZHLSFZLNqxWYOCbxpZpbV+mBz1gqb2F9/v6Cae2c874y5Lmm9zvHcZpDsjnJRwgjpVlaIZF+4uiA2+Fej0Iaplp2Nx1txT+AJhyHHEti/lXUxdEucx1JEYVeOeBz0e14NAJvHSuljmUUnxiLh/q6/Yj+UjF3L/i9N9XgvgCcGdOnDCO5lTQ6ynZrki96DHjXsmRjv4862efMaaZQjhEOIi2HLABAT/A60TUlhXDOkBfHYY+SM1Ahha1HWItPTpLhJBeqIAP8an+AfDkB4mL6bxD/9HVWZNQEeVqMieMT13JGuAlOj2/8QQ6NE/tUunUeF9oMMlVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7ngImZOU9b4M9g9+GD8zVNES0DMM51aR6TH9wGDy3I=;
 b=J1rMRpLEXxEZSBpN2R7f+MfQ9DVN+jRhPLxCYDg6c69tPsl9b7NvqiOwmlJn9ncnZk++L4JxEgycpSWbvzIcVLsGHcUIeaLut5G4/ZHV/7CncN8Sj7yVNk83kd+gViiEALtDgKHTDB5HM5+uBGo9UQUDuN1qKVOYbqImOkpqa94BXj7+bfg7+oKwdoWe0OFMA4TUjg7XYkbZFaXFhEDhsv837f2mV7udGf9C0qOb03sfjCX6cHDMV/WIrapVOe3kcZu2dHQd6qLxYrJqjOnGwPCTnJztqoaHhTf4nyXf3J2RlWNmU2us84szPkN24wn1EFUpWLzfj4FTvgl5Fg0paw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7ngImZOU9b4M9g9+GD8zVNES0DMM51aR6TH9wGDy3I=;
 b=XlsTnahH909jh2YF0YtRIhx18aWE9rFgV+P/+v8j+iUvjN82w37MjuPDN+4GdoFAx+mgwmHqP55sMTyCxAfJdn8k0biIMX4ZHaujVwGTnu5Nzly2Yqo6y4nR1sLehy+DfiESbWLhMkb0H9aFYgoyUmq0NAX04MQbqrFxHGMx+tk=
Received: from DS3PR21MB5878.namprd21.prod.outlook.com (2603:10b6:8:2df::6) by
 DS4PR21MB5322.namprd21.prod.outlook.com (2603:10b6:8:2aa::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.4; Fri, 12 Sep 2025 20:46:39 +0000
Received: from DS3PR21MB5878.namprd21.prod.outlook.com
 ([fe80::72b7:dfed:2b1d:c845]) by DS3PR21MB5878.namprd21.prod.outlook.com
 ([fe80::72b7:dfed:2b1d:c845%4]) with mapi id 15.20.9115.002; Fri, 12 Sep 2025
 20:46:39 +0000
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
	<ricardo.neri@intel.com>
Subject: RE: [EXTERNAL] [PATCH v5 08/10] x86/smpwakeup: Add a helper get the
 address of the wakeup mailbox
Thread-Topic: [EXTERNAL] [PATCH v5 08/10] x86/smpwakeup: Add a helper get the
 address of the wakeup mailbox
Thread-Index: AQHb592y/w9Js6kl4UaxrB7k8LLS/bSQfLJQ
Date: Fri, 12 Sep 2025 20:46:38 +0000
Message-ID:
 <DS3PR21MB5878A0BF0C986D286F8C0A5BBF08A@DS3PR21MB5878.namprd21.prod.outlook.com>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
 <20250627-rneri-wakeup-mailbox-v5-8-df547b1d196e@linux.intel.com>
In-Reply-To: <20250627-rneri-wakeup-mailbox-v5-8-df547b1d196e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=999cba03-08ea-4666-9143-3a15c1318638;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-09-12T20:45:46Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5878:EE_|DS4PR21MB5322:EE_
x-ms-office365-filtering-correlation-id: 04ef5e42-fd5d-4f99-0209-08ddf23d78d9
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|7416014|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?a2RRR3EyQ3JtWDBWL2hLaGNNVnBsQU9IeGRxSDVub3JXOHE1RTdXaFIxSXg5?=
 =?utf-8?B?dFhpMUFBZWwwOGlYMXUxbUM4UlpvOUU5WkJWTFNNbXNIWkJ4eW5NQWwzMWt3?=
 =?utf-8?B?dEk3bEM2MnJ2Y3MzanlyeDlYV1BJc3ZQZkhzQVgwM2ZaZDRJOUJsQTdYeDlw?=
 =?utf-8?B?WER6dnVHWENvTFlQNVVRU1JzbTBsTnhCMFlhYVdSNXRSMUtzTkZiWDZaTy83?=
 =?utf-8?B?M2tDUUM4RWVPR3FsQ2htS3kxMjl3aDdteGxsUXdSWittSU1PdE5Cc2UzdDBE?=
 =?utf-8?B?VTNuVUtqVG10RG4yWkRqQWFXZ21PWUVNS1dOQ1BwZVFyRXNOblQ1WVBhZGJa?=
 =?utf-8?B?czdha2QxQUR0L3RCWmhEMWhIdEliTjhMam1vb1ZIc0R6a0RsVTdMdGZqckR6?=
 =?utf-8?B?RjRuT1Rub2djMlJTV0gxdnZhZTc5MjNaTkFVNWZXOU1TMGFEZm9ITmlQeUY4?=
 =?utf-8?B?M01ZUVNZSXZ5NmlBSUJJc21lbHRsalMvdVA5ZFhRUXQ2SEk3U09naDNHZVJQ?=
 =?utf-8?B?bnVXNnpmZlU0ZkxTL1BpY1dicmtsY214bm0zelU3eU1DWEdBRU42bGcyaEli?=
 =?utf-8?B?QUU4ejcySFBoNWxKQm9qdkhQT3NVT1pKU3pjbXNZQ0VFaFNmbElnNVorQ2Np?=
 =?utf-8?B?RzM0d0NGa3JkZEE2K1gwZ21PNXgwSGxaeElXaDdTdERLQ1VlVVFsT1ZxS09y?=
 =?utf-8?B?WWhpQkIvdGlZbVFUbC9GUXgvdEFRNnAzKzJZWUx5Zmg4RGgwODNjOVdLVFdH?=
 =?utf-8?B?OUpVblZJYnRHQmVReDZCQlhBZnBTdThmVWQ0ei9idFVsSkxOai9IcFdDR1p3?=
 =?utf-8?B?eEs0OXJjdFVIeGFqRENaMGhLcy9aTmg3YjkwZ1VaRFBuamEwRk5GdU1aUm1h?=
 =?utf-8?B?bUxTbnU3NW4rR08zYk1lM3l3MUJBWXFuTTArbm5sdU5iOE5WeUxSYmVZZm5Q?=
 =?utf-8?B?dTRqS2VMMkM0elpBcXNZODEzV0ljcVB1NnQwMFpoaUF3ZEJkVFJCVHNGNVdF?=
 =?utf-8?B?UjhEMElNYitWTTgzRlpWL3RUYllsSlYySnlyMklJc2xzcXNML25nVWRiZUtB?=
 =?utf-8?B?TTB6ckFBcVFvRnM4dFlDZUY4UTdkVm9CamdpaFAzY3pTVnJMdEtmWUNSTWNW?=
 =?utf-8?B?WG1UOVB2dzJtZ0NmV01GMVZETnFLTThsRnpYZ1hTakhHUFVuTURkS3NyUWEv?=
 =?utf-8?B?bFYyMDdjSVh6c0toVUlpekx5aVl2TjRweXlXbzdOcXVia3NqTGw0UmFzSUkv?=
 =?utf-8?B?UUFobkROdXJ1TXEyVDFya2RYdGRvUWx3NVVseUlNRmlKZnJSNFZqM3N1cGcv?=
 =?utf-8?B?eTdRdFBub2l1R1paRmhKTXV0TkNuQy9saXRlVTBMSk9jNklza0ZFcmdNZkll?=
 =?utf-8?B?QjU3QXhSSytiSU1sMzA3anpVbmtTTTVaT3ljK2tOUVBncmsxRHFCazFzY0U3?=
 =?utf-8?B?M0pyY1F0eTRrcVViU0U4bDB1MVdhZ2FCbytTSzR0bnRUY2ZxakE2YWdCS0Iv?=
 =?utf-8?B?dVpVeVkwdVMzeWpwamZSRmxLVGx4WW1qMU5iZlBLT05EdzF2NU5pcHJISzNH?=
 =?utf-8?B?VXdDdlZHOTVhQWhxRUNDQTB3SHVUZC9ucGtRY2dic0Fub1plekVibFNVRitr?=
 =?utf-8?B?TWY3MzJZY0x6ajRrOEhRT01VY1dwd2ZTSGNYc0gvVnY1cUJ6T3F1MkpXSFB2?=
 =?utf-8?B?dGQwaitBbGFhTDROU2hhMFNVZDBwWSs0OXdIdkkwL0w3UEN4R3FDcHIxTVBS?=
 =?utf-8?B?RlprN2NMU2lwN2ZadDYwZGVqbHFyVlVJN09YQnpMVUNOVit5WnhZMkt0LzBh?=
 =?utf-8?B?cTJacFBXOUtsT1ZPRGdQOWZpR2pvM29wcUFhZm1OWTRTZDl0Ym83K2ZLRXpM?=
 =?utf-8?B?NGVSVllCdnJsek9YQUFqVjdtMWpKWGlEYStveDlpTWdzdVZ3bWRPZXg3QS9Y?=
 =?utf-8?B?VGIwcEx6RWM1bC80SlFWM1dLaCsxcytJRXZDUUxhZ1hDSjNRUUVWU2pYcEUv?=
 =?utf-8?Q?90FOr9lLg3bmjOT9IRm3dB/zu3AMcw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(7416014)(366016)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFlHeFB2VGNOcWppeXFpK1A4Q3RnOVVoeko5L3hmZXEvUmFRdFpCT3NyalFp?=
 =?utf-8?B?NUpPbUNKRml1bXFXWDU3OXhOSVJsL2JXNWs5blZWNC9nTlo4dVpVNGtCdHZ1?=
 =?utf-8?B?R0NOMTdGVzVWQlgyajRBYnNETUJaK2wyNTdVZmVsZTljVlRWN3VGcDBFMXA2?=
 =?utf-8?B?SmMxK2p4QW1qWFhBNm9mMk1Tb3pIajNtSXNITms3NEJjbWJKdWtjbXdUQ1dW?=
 =?utf-8?B?RUl6clpKMFVUcjgzMTRlME9nTUZzZ2N3QVUxNC9PT2t4L29tbnNDcjRzVG0z?=
 =?utf-8?B?SEFHM0VSUnAza20zZHYwUXI4ZlRFMm5HY2pPaHRoT0FUSUtYSzJIRXovTWg3?=
 =?utf-8?B?dld3QzdDWVR6YlRIRiszYVlmNUQ2Z1owbDh0NkNjYzFZMFhLcW1XdTJ2eXRh?=
 =?utf-8?B?anlEMnoxNGM3NDFCMEZnME9zQ0lwT2FhZzk4dXBSTy9UYXUyRVpUb3paN1VM?=
 =?utf-8?B?LysxUXpjL3ZLYmt6ckNNUFBGN3hjUXczdnp6Z1kvdmczS2FZWXVzViswQndi?=
 =?utf-8?B?MzhYWXBOWTlvK3VaRXE4RGZIZ0dQbUl6VENVSFZHS25FbWJxSGJINFIwVGVN?=
 =?utf-8?B?TGhTYzVGV0lQdE00ZXRqVnhBZGxNeW9CTG01MjZDRnBKYy9mOTJpZVBBUkZz?=
 =?utf-8?B?cEk5QjRldkNHTzlvZTlKN1hQaFp3ZDhUWERjRExXZWxNdVgxUG82bmVkaVpv?=
 =?utf-8?B?S3Z3SnlHY2svN3BaRVFUSjJJOFZQYXN0TmxOeVR2KzFvaTZjUWFxWVpROEYr?=
 =?utf-8?B?MVRySTRjOVIzREN1REFMTlgzU1RhQlZTamtTV2dJQlhuVERPTFcvcG5sbHB1?=
 =?utf-8?B?OWRHVUgxMTVUUnp1b080c2UwczB5WXl3N1AraWlHUEdMektzK2ZHVTRaNFFH?=
 =?utf-8?B?SUtLUlJoM3V4WGtiZEZkR2dwejdLZkNJdmdYVTFBbkdHaHpYM3BnNnFpakFm?=
 =?utf-8?B?ajhDdEUyNDM3eFh5WTVPNWVGUUxWZWNFYlVaOVRFVHdJSCtzYmNsZmU3Mm5V?=
 =?utf-8?B?SnNraUZHNERYb04yeXFXSVlkVUIxRnhPMy9hbkJEc2QxblZTUkdOeVlvWVRY?=
 =?utf-8?B?R3VRVW9ObzNrQkg0b3BER214YzE5M3dCZ2JmWEdFT1RPTTlZUXFaQXhyNXdS?=
 =?utf-8?B?RU92a2VvRmZNdXViOWwrTlZ1Q0J2emp6ZDJrS0ZGNXJpSUFkcHllZ2pKeFNH?=
 =?utf-8?B?ME9TZlJTemlkcGtmZ1RVanI3NEhJQlo5VnduNWFrV0hCOXNIMDBKYkZKT0tQ?=
 =?utf-8?B?K1RrNFZiOXdPQXorbm5zMzlrL0NNQzR1Q1kwaTQ3UEdwU3ZCbTVBWkZPODJ1?=
 =?utf-8?B?bnZ2R1pUWXVIZW9wYXBDVElaZC82QldpRDM2Vy9GUWtFZTJ4VXl1WHN2RTQ3?=
 =?utf-8?B?bEZBR3lOM2haYmlEaGlSL0FXUkRnQzNndk42cFNtdmZqRDZDWGsvSnNjMkVW?=
 =?utf-8?B?UVRFTU5JanlaTTBzY0pxZWJQS2pPVjRPYWJQSFJTeVkzdzhmZHRTTkFrYS9h?=
 =?utf-8?B?eEdhU1FKb0RwS09rKzAyNFdTRk9mRGVJK0xJQitBVVI3WS9BTGo1aURVUEU1?=
 =?utf-8?B?ZlRqY29sTFNnejJEVVVjekUvQi9CNkx1ME1mY2N4UGIwNEZ1dzY0aHBPZjNx?=
 =?utf-8?B?MGFKVTRMQ085YUl1NitJWEttOVBIa0w0RDJkd2xSbE5SS096cFcvbGgwUmd5?=
 =?utf-8?B?WXN3NzFNNitsOUJiZjNCTW1ZRjlSRVlXb0NZbG0yNUJoOVVFSS8rK3NXTkI0?=
 =?utf-8?B?ejQ5RURJeHR4ZVRpVTU5alFhVGxqR1VqRkNibENkdHZsS0xxZXUvQWIvNjVI?=
 =?utf-8?B?SkRqRjlFNVhsUzhQOVdPSjBnNjkrKzkwNTdQTXpPcTZFSG13YnNjaW02MUlh?=
 =?utf-8?B?SXZRSmVGeEhkSmlBQy9VV08wTjQrR01qVFRzTzBSaXpMcXZ4M3daT2ZqZXJj?=
 =?utf-8?B?aEhKNEZBZ2hVUytUdUYvcUIvQ09Oa3ptQ1d3cmRnUlNUYjkzV2NGMnovLzZt?=
 =?utf-8?B?OTBlc2ZrV1BDM2JzU3N4T3J2c25KV1hBak55d3Z1K2tIZ1NKUENPT2xUck8z?=
 =?utf-8?B?OUpGTkU5NzQ3bTUvVWFOSHRxVGZsbmlIczUwTEllTXc0bmtCaEc0bDhZUjMx?=
 =?utf-8?B?eXFsQkUxRWNGM0F2TitrYytIYzF1anQvQjMzVHlSczVjdEpKNTdZb2EvQWRp?=
 =?utf-8?Q?8j8f3j1mgg5MI41K/UmXT1Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ef5e42-fd5d-4f99-0209-08ddf23d78d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 20:46:38.9510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xvTCjZq9Pvhs4i+dS5ytccq6TPf91O4F00X2ZJWw5xgryUEEkeDWNV0471B/j6AyCJS/Y1VGBiSHgw5QAgrWog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB5322

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNhcmRvIE5lcmkgPHJpY2Fy
ZG8ubmVyaS1jYWxkZXJvbkBsaW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAy
NywgMjAyNSA4OjM1IFBNDQo+IFsuLi5dDQo+IEEgSHlwZXItViBWVEwgbGV2ZWwgMiBndWVzdCBv
biBhIFREWCBlbnZpcm9ubWVudCBuZWVkcyB0byBtYXAgdGhlDQo+IHBoeXNpY2FsIHBhZ2Ugb2Yg
dGhlIEFDUEkgTXVsdGlwcm9jZXNzb3IgV2FrZXVwIFN0cnVjdHVyZSBhcyBwcml2YXRlDQo+IChl
bmNyeXB0ZWQpLiBJdCBuZWVkcyB0byBrbm93IHRoZSBwaHlzaWNhbCBhZGRyZXNzIG9mIHRoaXMg
c3RydWN0dXJlLg0KPiBBZGQgYSBoZWxwZXIgZnVuY3Rpb24uDQo+IA0KPiBSZXZpZXdlZC1ieTog
TWljaGFlbCBLZWxsZXkgPG1oa2xpbnV4QG91dGxvb2suY29tPg0KPiBTdWdnZXN0ZWQtYnk6IE1p
Y2hhZWwgS2VsbGV5IDxtaGtsaW51eEBvdXRsb29rLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUmlj
YXJkbyBOZXJpIDxyaWNhcmRvLm5lcmktY2FsZGVyb25AbGludXguaW50ZWwuY29tPg0KPiAtLS0N
Cg0KTEdUTQ0KDQpSZXZpZXdlZC1ieTogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4N
Cg==

