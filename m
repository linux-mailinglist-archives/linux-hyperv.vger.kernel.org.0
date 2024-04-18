Return-Path: <linux-hyperv+bounces-2000-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D363D8AA266
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Apr 2024 21:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D621C20DE3
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Apr 2024 19:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8D617AD80;
	Thu, 18 Apr 2024 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fVwu+cxM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11023015.outbound.protection.outlook.com [52.101.61.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D859817AD62;
	Thu, 18 Apr 2024 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713466887; cv=fail; b=DCqJYUJ9T23cbD79QLrAD/7kPmnHIAOuEDvjmevuR/ZtsdEK0ZQjVeyk78TLIMwsh+YsFiMZrFmohuqd6dbeJybLwz4jCkKEdtmZiZsf/D633s4m1h17Z5K3ju0GgOO7vXIMdCrvJOsJg8bvR4/gDLbl59hJEh+ozfEs0D674Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713466887; c=relaxed/simple;
	bh=Snd+UveWgpgEM0cvFpPJOpHelBvCXeJz7Vw37uMYgdQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I2qobN9r8TLt9a+gKjX3OYXE3sia+jPPOAMFd5TGgRmq00NFQMAMWQENynsgUrHlRItCe7bq2CD1chaQ4Gm3fnn7mKXoilQ3oTX6tF2lnHV5gMNXUxqWaUhepE+y+O9VTSYKWqzX3BLVv00sQ3xKvhG0Yba+n7nQERiCHmQoG1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=fVwu+cxM; arc=fail smtp.client-ip=52.101.61.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4llOdErjWKkllPADITRvhd9IY4hhVBX6o6xGPv3vKLYTYzOMB58PHo9n/ckav+2Bp3i5GVOIwEj+9OgAW0cPt9VMbCXtQyYttxnClUd2PDOONFtkXERITbISvOV+gpyC06btuaps8MUNBbopZhN3Gz4SUjnE4UWROVekSvjeyVsang3WX177M6tbXnENZ7O9QNpwuTCWS3L3lkNEv7ueZH7ZViOsgOcSv4CXu5h3CTPh0BfdXt9kwNFx7xiIp3FXpxkraUsGX2kkaFSZ+UbRxLYB5DVYTmFh/9r0HegEpmTBc2FMgmV1o/IwNhQg/twdhOoS/WvOCZHvFZRor4C2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Snd+UveWgpgEM0cvFpPJOpHelBvCXeJz7Vw37uMYgdQ=;
 b=QdXx6enmlcl2no5WjQ/sqXTotiZFxS7aHq8PPp+BVC90vQKduwgsg/Rh4h1pqC1jgXeLkDnkWLHk185twDbk1FrRd3Rr5LPPKz4FiAXtqQhhYrsNIHCLYyi3AIdJMPEw/3ekblkfoecR6/8ucFG4/X6aEsTnbiMzJHgcwCXgw81wLRx9GSBBKKUl2ga8DpBJ2NCOPnUhHJsAYuLEu3J2K45ZSULcHdoA1OT8OzasbsI1JwY2uwN4OV4SmCgVbouH6Sypvfwmjc8UthZtWgWfVdsfqCHXICepy3rYgxI3cDiParOGaZ7jzX7QBVcUxtFIYJPDi5zqYmvnmH/DEpnXvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Snd+UveWgpgEM0cvFpPJOpHelBvCXeJz7Vw37uMYgdQ=;
 b=fVwu+cxM5W6530HPJDaT5dkWmN7iiLe8Js5KUbVc5ulmiA9MN4N46yKu0j0qaH1N9pod7umlGZsC/sK96o1zVbCOaPd0qLdM30nWSEEqalb+bpMDaDbx8gXg/p+LbCTgD9l+i18kd/LmidbJatnCK4lhszlwgLKA3gLiBkaquLo=
Received: from CY5PR21MB3759.namprd21.prod.outlook.com (2603:10b6:930:c::10)
 by MN2PR21MB1439.namprd21.prod.outlook.com (2603:10b6:208:20a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.12; Thu, 18 Apr
 2024 19:01:20 +0000
Received: from CY5PR21MB3759.namprd21.prod.outlook.com
 ([fe80::aec4:da4e:adae:568e]) by CY5PR21MB3759.namprd21.prod.outlook.com
 ([fe80::aec4:da4e:adae:568e%3]) with mapi id 15.20.7519.006; Thu, 18 Apr 2024
 19:01:20 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>, Ani Sinha
	<anisinha@redhat.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>
CC: "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] Add a header in ifcfg and nm keyfiles describing the
 owner of the files
Thread-Topic: [PATCH v2] Add a header in ifcfg and nm keyfiles describing the
 owner of the files
Thread-Index: AQHakauwDfAGVwh0yE230RtcTkYkHrFuYOvA
Date: Thu, 18 Apr 2024 19:01:20 +0000
Message-ID:
 <CY5PR21MB3759203A552E72B7F2669FACBF0E2@CY5PR21MB3759.namprd21.prod.outlook.com>
References: <20240418120549.59018-1-anisinha@redhat.com>
 <19df975d-167f-424a-92ce-5135cbeb8a07@linux.microsoft.com>
In-Reply-To: <19df975d-167f-424a-92ce-5135cbeb8a07@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=19129bd3-8b4f-4d1f-a53e-e3592952896a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-18T18:56:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR21MB3759:EE_|MN2PR21MB1439:EE_
x-ms-office365-filtering-correlation-id: 71178a29-0331-4c02-2e01-08dc5fd9ef14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Uk94TDRkdHZlaTVBUEg0YmtRN2szTy95Um8zOWx2STVhZ1Y5b0ZuV3pWZ21x?=
 =?utf-8?B?cUFCQzA2bWt3TG5wQ0xJZVpZQUdZa1JVblJCQ0pQM3NQKzA2RWlmeExWUWZa?=
 =?utf-8?B?TXlyS0pmN1RnT3FLYnFJSzRIc2R3Uk90L0lRQ2dRT3FyS2FXalpQclN1WURr?=
 =?utf-8?B?SG11dEVDL0Z6eS83UzJZMzlYNG5lWjc4V2RWSGtUYmV6M3JHajB5eXZpd3h4?=
 =?utf-8?B?anBzSGU3dmtYcGRyMmhHYTlQK2Z6cm5Gamh2czdEQ1p0VU9FRkoxOWFiaHVp?=
 =?utf-8?B?VTJWMmoyQTY4QVVSMkZIK0xVV1FOaVZJMk9kOUpJVXgzQVNQTTU2WktmOGdq?=
 =?utf-8?B?a01UVUEyN2tZbnFrU2RoL1JPaDhyYVVMOWIrTk96Rm5EQXo2d2QwME5XNWdh?=
 =?utf-8?B?emY4Z2t6Qlh4dHhRRm1rSjNlMDlBYW5GekRSWklTclNmVy9ObENqazgrRnQw?=
 =?utf-8?B?VWY5bHpIcnBpRjVFM0Y2RC9lOStQZStFa1RyakN1VGd0cjVTa0hLaTdweFRM?=
 =?utf-8?B?VmE3TE5tdFNSSzh0c2dLVFJWa1FLT1hGWHpSMFNFZFJtVjVodHdJYXZ6eDQz?=
 =?utf-8?B?TFlET1JIbGxzVjhHc0lmUTZrdkl0VVpKQXYxNENWUUp4Y0o4czJXTlBYeWVJ?=
 =?utf-8?B?YzVTSnRSbUNxSE1FS3RQUUtvbVlzSWxYK3BSVThtOHc5cEw3NW5icmZWdkxt?=
 =?utf-8?B?Vm1PODBuR3RDdFZOMFVyMEhHUFlURjh4OENSSjZGenlhbS9PR0w4TDVHVkc0?=
 =?utf-8?B?MmhxTkdhQVpodkJpamt0L05LbjkweHRHbWFaK0Q0OWRsaURKUzBDUlM1ZUo2?=
 =?utf-8?B?K2xsYjV0eVQzQi9uS1BSMzk5RDRtYmR6VWRDNkNtcUxkWTAvYklZQUg3SFln?=
 =?utf-8?B?VVJ3Yk5IY21GeGJxcVNCVDUzTk0vcjl4R2lVc1NSSlJvaUdMODdRZGJsdG9n?=
 =?utf-8?B?cSt3WHFIT1kvRWR1Y3BhSzhkY2dyeXh4NlI4R0tvRXFEYlFSeVp3WCt0RnRi?=
 =?utf-8?B?cVRDUFpuRUNkQld6SFVDaTR4eG05bHcxV1pLQUJhSGgrendvSEVTcFdOQXpu?=
 =?utf-8?B?QkVuY0RaNE5WekdJbWJJUk5OOHdtbEo2bllOMUtWZFZBVXlWN3JNZjJpWFZr?=
 =?utf-8?B?V25jamwxSXh6YTVOcWJFdU9UcFU4UHJGSDZOYmorYjJXOTFBd3U5Q242MXhp?=
 =?utf-8?B?V0twZjZHN2l0TmdCT2NoeS8vQjBPTXRhWitsVUl3MWRpWWpsU3RMMWxjNzd4?=
 =?utf-8?B?SmlxRGl2ZjJXbkdheGhtZ3FXSElHS2QrQzRCeFIzSGYxQnVDbUhzSG1hYjVs?=
 =?utf-8?B?UzRnVnZnQnJ6US9lRDRCRk1uSXZFNk1CZWRqTXlScEU3M0dlNmVSTDkyZTZy?=
 =?utf-8?B?SXNldHBFaldhRlVOL0J1RkZ6T25KbUlQRGxZdFR3RXMrd1JzZjAyM3FGSllM?=
 =?utf-8?B?WEttNUZvQ0h6NlNSRnJENllnTS9xMEtCek1hR1RTTVZXVlNQL1dIK1hISkd2?=
 =?utf-8?B?SXNDemVIZnVGRDFtTURmK25KSXNsSE5JZmsxUkd3YTh2RjNRQXEvd2k3aU9K?=
 =?utf-8?B?VGpEbUVvTkZ2MWJaYVg4NTBWd21GN09McG80NHl2QUdKNjNDd09uTVM4WllB?=
 =?utf-8?B?QkRwRmVrOUpTRTdBSG9ZbVhmTWZKS3RFK0E1V0Z3NndRMzh1WTFzenFWOXQ4?=
 =?utf-8?B?eHFKbnZ4c1pNNmRCSkI5eDN1Qkh3NXNobzV6K2llQTZUMVRNUEl2b0hBbU54?=
 =?utf-8?B?akpTc1ova2lPa3hXU3VKTzBYK2R5Uk1oYVA0SWtCN1QyTjN5d0Mva2ZTNGw4?=
 =?utf-8?B?OWFRYjdPZFVvVEUySkJLZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR21MB3759.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TlY0UjN3a1c2V1BPbDREZVVzVU5SakFqUVRSSEhDTUhMZncwR2dzNWZCYlpN?=
 =?utf-8?B?ZzFWdE1TZmtFUjZvcGw1cWlqaVhRblQ1eSs5K2doWnhWa0RpSWFobjV6ZUtL?=
 =?utf-8?B?aDVNY1h1czVHUXBiWmJWTTR3aC8xSjZlaTJaL1BSTGVxY0o2aFdNRUJQWjNy?=
 =?utf-8?B?Y3dxaVNxcVl1YWhrY3lRVTFIdlJVU3dVblp0dUl0Z2Q4ZzN3Z1JvMEFIaGM4?=
 =?utf-8?B?Zk1qd2hEVXJLSDBHV2lKQ1lPY1JUYndiQ2twSjBmQ2J5Y2wxWXRuZ3krNk1m?=
 =?utf-8?B?ZmZvazNBV294UlZtWVl0V2g4QUxmVWE1bHYzczMvd3MvMVdkSE9DMjBoMjRs?=
 =?utf-8?B?QVZKZWlRdWQrRU5weHBRQlBIaENhK2tyNXJtOGx4RXZXL0h6L0pCZHBUelc4?=
 =?utf-8?B?MzlSSTJFR1NBRkRsaXhBdThncU1qVU15Q3BVRVJzZDZNSmtrVklwYmF4N3JS?=
 =?utf-8?B?TzFYUzZ5dWtacCtHWEJkYW1McW9YTVEzK1crK1ltcHNTdklJeHgrM1lRRjhJ?=
 =?utf-8?B?NkpTSHZ1Ym1OSk8xL3BjMStDZU0xMzBLM01NRVRNeGJRMnVPbmRETXZnaTNZ?=
 =?utf-8?B?L1NEK1pBbUxkdlhsZlQyYy8yT1V2TElWeGFTa3VPdGMrNWFIaXM2bnRMOUFU?=
 =?utf-8?B?NTdGWEYvdjhCZzVjWHNqU1UzWDBFbWpVY0VUVTlYMHhFWWFLT1N2NW9tU1Na?=
 =?utf-8?B?OWl5Vzk4Zml3WFBJODRCNWRnTzRkNXBaOFJ2UE9vWjgzQTBJZnZvVHo3c0RC?=
 =?utf-8?B?V0lKcXMxbmlTbFY5VEJVM1NraWpmV2wwbUJUV0lKa3ZWcTA2K09JV2VkWm1t?=
 =?utf-8?B?bnhOY1ZxemJOd3hhRmxwUHIwd3JPbUVFalU1a0lpak1TWmtNZlVnMUYrN2RH?=
 =?utf-8?B?YmVCNk4rTjgxNk1tOW9NU1ZlRFZBZFJFN1l5MWc5c1BoaWNBZ0dVRlBPTDh2?=
 =?utf-8?B?WUllMEJsNTFPbU9oK0pidkdhMURRL2V4WGJjOVRjMHlIN0p1YXY5MW5jekxh?=
 =?utf-8?B?ZmJaZGFNOWlocE9kMnVCeWlDMGIvNjIxNkxIOEt6T2YvUS9EYWYxSklkajVR?=
 =?utf-8?B?YkN5RU5YTFYyZ2kxOHh4dFhDM1RMMldoVjRRVnVVK09YM2YxMlMwVjhjSzVW?=
 =?utf-8?B?bnZNOVkwRGpXTnR2R3hXV1Z6dy9QUDNrOWY0azNSdFRRZTFHbHRCQlRwMW91?=
 =?utf-8?B?VVdWWUZpcnEvSFpPZFNMSjZpdjBYY0FuVzNNZlhqUm1jUFZwYldEQUloTE1j?=
 =?utf-8?B?U21qczNmOUdyWlNXdzh0YUlXemg4NHZQcm14bnRGUWl6bUplNWRuV0RIZWc2?=
 =?utf-8?B?SGcvWE9nSGpUWUplSzRTeGxoY3FvclBxaVQ1NnhWOVZOTUp1RFRLcUo5UEI0?=
 =?utf-8?B?NmtGZTFweEhDMXNPMGppdUV1ekVLMjk0QXBFdzRwdmJ6VUhyZ2M5WlgrOFFN?=
 =?utf-8?B?OXVLSjg1cGVVWVRKR2h6Sml6RTBCcUhsamFYUGhsT20rb0VDdSt2SSswL2I4?=
 =?utf-8?B?aVh3d2M2L0NhbUp5MEM3QXN0MTF2ZWR4R0o1TFVKbnNQUjIxa2VBWEI5QjBF?=
 =?utf-8?B?cFY0aGZ2VVkySG9iMGhwWGdmODd1L1dMZHJIRlJUeWJtMDN0bkxiVlg3Mnlo?=
 =?utf-8?B?MFE2ZkNVcHladUc3WndraEVrUndGaVBENitHVm5WWkNEb0dnQUpiTHNWbTlS?=
 =?utf-8?B?TWlsZjZSeDV4YUhTVXRBUEJyUFJmU2k2OVBwbVpQVER2T0Z3VHZYejF6Mloz?=
 =?utf-8?B?YkdwbnVmQlRNTUxaUXEweU1HTWovaU1MSFQ4eEtmb0xML3lRbkRlME9Pb0VR?=
 =?utf-8?B?eXpKREp1a2V1MGJMRlhKS2xlTDRQUDhER1FyOWthR29SN0tVUjRpOCszNHF0?=
 =?utf-8?B?cnZGUFI0NUJJclV6MkJZTkxvTnBNdjE3ZEI1dHNuNkM0WmZjQnprd2thOWVy?=
 =?utf-8?B?b1hsdkQ0ZVhNV2dFQVRZVDBGbzNmcEhMT0ZFREtpdk1OaTRKc1htakZGRUha?=
 =?utf-8?B?MUEzaTQxTDBFR2xwUEIrZ3RubWdHd3FkSHJmTlN5WVFEUVowR1NZdlRkWG1Q?=
 =?utf-8?B?QUtwNkNrajVQL1hqT0xJQlNRVUkzSU03QjNTUFdlaldlSyttVzE0NFVWY05E?=
 =?utf-8?Q?bn54=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY5PR21MB3759.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71178a29-0331-4c02-2e01-08dc5fd9ef14
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 19:01:20.3295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPMFXt4FFAAR0WeEU2vGCDfDBWDiBjTyNndbYQXaEaZsoDm9C9M8bAtE9matjCTwMjVap8LAHwzsmHvugGzj1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1439

PiBGcm9tOiBFYXN3YXIgSGFyaWhhcmFuIDxlYWhhcmloYUBsaW51eC5taWNyb3NvZnQuY29tPg0K
PiBTZW50OiBUaHVyc2RheSwgQXByaWwgMTgsIDIwMjQgOToxNiBBTQ0KPiANCj4gT24gNC8xOC8y
MDI0IDU6MDUgQU0sIEFuaSBTaW5oYSB3cm90ZToNCj4gPiBBIGNvbW1lbnQgZGVzY3JpYmluZyB0
aGUgc291cmNlIG9mIHdyaXRpbmcgdGhlIGNvbnRlbnRzIG9mIHRoZSBpZmNmZyBhbmQNCj4gPiBu
ZXR3b3JrIG1hbmFnZXIga2V5ZmlsZXMgKGh5cGVydiBrdnAgZGFlbW9uKSBpcyB1c2VmdWwuIEl0
IGlzIHZhbHVhYmxlDQoNCnMvaHlwZXJ2L0h5cGVyLVYvDQoNCj4gPiArI2RlZmluZSBDRkdfSEVB
REVSICIjIEdlbmVyYXRlZCBieSBoeXBlcnYga2V5LXZhbHVlIHBhaXIgZGFlbW9uLg0KPiBQbGVh
c2UgZG8gbm90IG1vZGlmeS5cbiINCg0Kcy9oeXBlcnYvSHlwZXItVi8NCg0KPiBMb29rcyBnb29k
IHRvIG1lLCBJJ2xsIGRlZmVyIHRvIG90aGVyIGZvbGtzIG9uIHRoZSByZWNpcGllbnQgbGlzdCBv
biB3aGV0aGVyDQo+ICJoeXBlcnYiIHNob3VsZCBiZSBjYXBpdGFsaXplZCBhcyBIeXBlclYgb3Ig
b3RoZXIgc3VjaCBmZWVkYmFjay4NCg0KSXQncyByZWNvbW1lbmRlZCB0byB1c2UgIkh5cGVyLVYi
LiBXZWkgY2FuIGhlbHAgZml4IHRoaXMgc28gSSBndWVzcw0KdGhlcmUgaXMgbm8gbmVlZCB0byBy
ZXNlbmQgdGhlIHBhdGNoIDotKQ0K

