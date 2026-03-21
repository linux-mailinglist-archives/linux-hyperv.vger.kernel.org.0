Return-Path: <linux-hyperv+bounces-9681-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMEvFELtvWkwDwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-9681-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 01:58:42 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA692E2B7D
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 01:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 458423018D6B
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 00:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4881329391;
	Sat, 21 Mar 2026 00:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bC0Zet5l"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021116.outbound.protection.outlook.com [52.101.57.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACF322D781;
	Sat, 21 Mar 2026 00:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774054603; cv=fail; b=mD/aUqTN4Am/D2c5qFWvNKpS5MsTwUb/X4pH8y8cCzGERC9sLFDZkphOrViJvfc/gcLTZdT+8lD0mFGo2lRlYMImZTZkZSn4hb8OUeFqQv23z4E1sdbVUaQMCEbT/eRTsNRQDRKJvxAvg9b85dRQUsSULsHdkDifuLnvKrAB8iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774054603; c=relaxed/simple;
	bh=S1nFG728O2SKEIrS2vRN/uTzn7Z1c+jGOKHKAVfzv2g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TDa6OWlmPHk+KmVl9cYbdDAdgAfJqCza8zpNNrv8ICauOrl632CDoTMrfm8Hnzd7YnfCPzHsOIzd5DWHnPY2gWPFqHMu7pEMa5O+egxqYIxsWxOiDsQT2vzeZugriOm0IDPVbGHGzjvq7LzYiYo7THGj1CGkC4SvJcAJzETfNUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=bC0Zet5l; arc=fail smtp.client-ip=52.101.57.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLyeCU2fnVFG3GclmSDsFrsJtahZ9MkvIscEQfsvdFtrtQz7z3pizdyOFSxPhjz/I8rVrJi7o/0mxue+fLQ4YviWORMcD46KW1RWBVpnYKeLgJFkLMLX8huKtr4lb1FhOBLGq/XvbLq11jXT4BvcenrErFnW6+6Tz43o40C76NN4P6jW3mlxsr5Arnygq2OBZS2Tk0xOUZ6thfxbbps59Ka8HihkB7aV/EbrEGrO2IIMCPBf3NJv1WCGAkJWjiVNpF3mu/HHHCP+B54pLg6b4NeK1+ybJG80OC42BmGlnrcokhys23/awov+INGUzvqJD+bEevIlWG4zV7STpdDbKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1nFG728O2SKEIrS2vRN/uTzn7Z1c+jGOKHKAVfzv2g=;
 b=e9cPc2dEDJjFfgXj2gElezPZK4kdYbuMxQGqtlC97ceirJqWJkUlXq0fnbEVGczvs4x5Em6wGQMmrBOAZfMmZYrgepNqMwiSQvgkNH/84PTQdLBDhsjRbX7Z8+Q5bbeWxpKTFJjdjXwkKG6EQXiyAleHGv/CrSzPOsTq2E7ZiCG8Zvi2EzSMEJYaCkTjGn0u2d+t6OJrPangsNlSC8dKywGGzOrZjqUzTz2Nqev2ORVaKh4RY0EI5MVNI32d+RkDM+i1egpl4j/IQiRNhhHJGKtvUSATtsHlLI9wmvEPz9FMSP7dN0lGzUIhI3t7b2FhBO0B3R+siT+e36yW5/BWPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1nFG728O2SKEIrS2vRN/uTzn7Z1c+jGOKHKAVfzv2g=;
 b=bC0Zet5ls3OzUj+8Ujla+TeAML8qWlGOY7prUtURcT7i3+ICb92i09/yspesnAUuVSQn5stO4t1G24Jx9ckqX+F3S/HFO6b2czSHO98u0rmVKXhi2sJ7X09YS61jhis+FDev/AojDlcRaHcSKQK495NoqvYPaNN1K3SuAshV5cQ=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by DS2PR21MB5636.namprd21.prod.outlook.com (2603:10b6:8:2b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sat, 21 Mar
 2026 00:56:39 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9745.007; Sat, 21 Mar 2026
 00:56:39 +0000
From: Long Li <longli@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next v2] RDMA/mana_ib: hardening:
 Clamp adapter capability values from MANA_IB_GET_ADAPTER_CAP
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next v2] RDMA/mana_ib: hardening:
 Clamp adapter capability values from MANA_IB_GET_ADAPTER_CAP
Thread-Index: AQHcskxp/rldcz8WSE6y5yrJ7Ov/rrWxl2eAgAAP7gCAANlFAIAFtXdA
Date: Sat, 21 Mar 2026 00:56:39 +0000
Message-ID:
 <SA1PR21MB66833EBAF447BA0B102862FCCE4DA@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260312181642.989735-1-ernis@linux.microsoft.com>
 <20260316194929.GI61385@unreal>
 <SA1PR21MB66832D25A93394735624F454CE40A@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260317094408.GR61385@unreal>
In-Reply-To: <20260317094408.GR61385@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0b9755c5-ec3d-475c-bb4e-911a612380a5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-21T00:54:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|DS2PR21MB5636:EE_
x-ms-office365-filtering-correlation-id: 827a8a1e-745d-40e3-10e2-08de86e4b5d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 X5Yosjcq1fdpusKxT1a7JW+FWnG0GjB/9qErq+Mi6PcS8PQ8eYWnL+JalyxrpLhhlu2EjeXS9ps230iHprrbhSIjk5AF55hQfE3JmkAihItNUVIb9VORjst/6CMMe8a6IGWlEIMfEZn57+kKEoWI8h+qEBqC2NDMm1DCBttUZCGGgvSKXs82VfhtuJbp9BxJLDLTe297Ex8XidCl7s+2OCyBRbfAePgPomtV8mf9m4kYwxAK/lCbt5J0D2BpW8yx+t6MX/LPSNmRAva6svl75iaEp23k765xXj8zT0MspkVz5+hVh6s1tQGgHsTIl0xUymwqzH7RfSMsXSChrMclAQWVUV5SHVt4em3t4JKQIH1+RAka4xMfS4vB7FrbYCj89U5lDLgw+xpKig9Z+lEvOdUalVy7V/3dxQAGPauoPoJSnAzHZCD+v8ErFyteZnGGX5nD/tW4xouBlXidDK5ZV0RtfeuMe3SPwrWWx3F5HdvA+s0RbQz/OL/5aoYVTBHLR4+5w/JAQsvy3taUEu1WZGH0MDOlS8CHALNc3WOQa6lUgIPYhQz0PK3oclvAR+b2xxcy+NjY07osA8Niw/4vjsYxyFZr3a9gAaEfhy47DaslZRk70D1zGkh1m4U/9sALVH3qyu8PuAb5QaTs9S05kiSyJcNVH+vG3oRhUVp2pLFF6FdvkJPDO73YocgJpdsEBoD4pg59N0Y6C+z7ZFzcbtnUr3znfL+pu17M3i30QkDi8Xe81mAu5kZhPsjIBepSiRkOYJNqrTqJq4ps0Qbs4LGdpXzZUvyGJbX1Zv5NY1w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVcwNTNyc2ZsMVk1Qy9LMk0rYWRhVDV0Ukl3dG1ETGpTTHFCdFNGQWNCOUZ0?=
 =?utf-8?B?c2xWMjdNVWc0MStLQmhsQlV1ZzJkSGR5dUpkUVRtdG5ScmpvTzlTZWFicDU1?=
 =?utf-8?B?ZVRkcEhSWmJsaUVzSnJVTSs4MzZ4b1FvUUV0WCtaSERkNklCOVIrVmREak5o?=
 =?utf-8?B?dGRHRDFMcWdXU0RXcnlraUwxUndnYkhYSDZieVd3b2EvRHpidTlaOTQvSGVK?=
 =?utf-8?B?ZkhsV3lXRDcxS2NaTWQvL1NmSUNrRHMyVmNUeVRwakxIUkdiUGxZMWRqQzlO?=
 =?utf-8?B?MmVmdWxqalpzcXV5eTNhZFhIRFdBZjdPVnBHOGdyOEF2QkRlWFU2Zzl0ODFL?=
 =?utf-8?B?NFRDaXJMUlpYUjc1OWsvK1VNU3pOMnZabk0ybTZSUTB3M01YYmFnWDdtOStq?=
 =?utf-8?B?YU1VcnpmeWkwMnRZdjdUMU8wZWNwR2YyUzJtdVNQWEV4dmcySkJtRHNQRFFN?=
 =?utf-8?B?eVkxNmtaTkh2QVVnM0NEL2RobUxPcCtUY0NRRHdUNklQYTJhTzRCQXhiRjBT?=
 =?utf-8?B?RVRSQVlpNHM1aXRuaFVJbmVZbmFFbEp1YXUyVGhHaDFpWWcrUDl2cmE0cWNG?=
 =?utf-8?B?N0Q1YnZJL2Y4S29nczlJS1pyNE5NYU43K1VoRWZ1WmtUQzNHYUhLL1lpMXpw?=
 =?utf-8?B?ZFpHbEplQU9GWXQ5cFZXRGJTbkRjUUpnSGZhQUdhem9JVDZaZktkODk0U1lE?=
 =?utf-8?B?N1NtaTB1Nk5NTGRXUDZFV1RlQlpkMmE1VE5XMlhObDdOZXVWQ25hcE1EN2g2?=
 =?utf-8?B?VmVDM0o4NUlFZkVma0hDczZmQ21iQkZyem1Cc2hucUpETU9PYTNwRjZORENK?=
 =?utf-8?B?enNSZzdJWExmTnhINEdnVnRtcG42WXlud3B6a1VZRTFnQ3ZGZHpTU2xWblBm?=
 =?utf-8?B?VWNMR2VPU2hLc1k1bkgxV2ZCMElGY2Q1MmRuSDltcHB2TEJzOTByRmYvcTYz?=
 =?utf-8?B?UHN4UWdmVG1tSGs3VXJQa2Zwd1ZHMXZHVEpaekdDbVFvUjRsa01IVnMwK0Rh?=
 =?utf-8?B?SXdCWDhDRmRSR2pJQzM0VnlZSElTTkpGYWRIT3Bua0xlVjlKZndKeThhdFpV?=
 =?utf-8?B?NDhXTml0WjVVSmFhUXRFalJ1cjl5OWFlSitSRzhSYmliMU9ZNzBmYklSYkN6?=
 =?utf-8?B?TUprQUtadmlFcFFnYWs0cmFHWTluWjBCWXI0K3EzcG9qd0hFNENoTHh1UUd0?=
 =?utf-8?B?bmdvcnBxeHp2NmRZNEwwN2l0WkJ4cXdJT21ncTF6ME82Nis1R0NHYVJHWVY4?=
 =?utf-8?B?TXJyRENzRHduNnJyeHdhL1BOYTJKMmtFZSswMWR3MHRRSnVZRU53Nm5uZWRC?=
 =?utf-8?B?ak9JaGJ5VkxvQWdwUG5vSjlvczdKc3FFSTYrWnA3TW5TMTJtbzVqTXQxaEVy?=
 =?utf-8?B?cEFudlptTHUyUGdzQXRCbXhNUXZETjIwZER3VTlvZHErdGw5RHlKQjJ5Vnhh?=
 =?utf-8?B?OVRidXNlK3BZNDVqMjhIMnBBc3FqQjlEa1F5T2xFY01MWGdoNlMwZ0NHTXJt?=
 =?utf-8?B?TkkrNDBWMXA3ZVVKZjhQc0xEeUQ3Q3YycE5pdmpJOFE4dXI2RnZLMVJpOU12?=
 =?utf-8?B?SmZmcUFVaElQem5ndzh4RlFucGZsUHMyOFdEL3FrenVOejEwVjEyN1cxSXlX?=
 =?utf-8?B?QmFJNXptUVFyNTZNazhzK3F6TG9sbHBOUzlnRHY1SmErS3Q2R2x1Wmxsbk1v?=
 =?utf-8?B?VWlSYWE1YzBUa2xGZmlaRmR0T1BFcm1iMzhDNmJYWjU4VHBHc2VsUDRFRWFz?=
 =?utf-8?B?WDdaUDFURmlEaUZGSi9ZdC93elUyMnBWUUJVc0xjSFVabWdKSXpFWitibTNz?=
 =?utf-8?B?MHJodmFnM1RrZndCU1UzNVBRSTZBWXh1ZzZWMFBveUlRU3UzaCtJbVgvSlQx?=
 =?utf-8?B?WU9oT2gvR2h2Y2MxeUFQK01OblVobnlzYWxIZkJBVXhiOHlXU0JHc2dYbndI?=
 =?utf-8?B?aS9tRCsxdk9UNkpWM3BydXFRNkNoWEM3UVVjc3dFT2xvLytGcU51NzRrSU5k?=
 =?utf-8?B?QnVpMjEySkJsNGYzaHl0K3lBMUhmMXFOeUtvdlRGQlI2OVpkRDNCbTNlYXR5?=
 =?utf-8?B?V3lwQVZXNC96aTlRZm4yaGFVbkdZN1NSWmpBOStlNGhqZEZaWkYvSGJXd040?=
 =?utf-8?B?UFEyN2hpWGNkblY4QTZYcHo4aVA0VVFoR3UyeXBGeEx5bngvWFlTSk1HT3Nt?=
 =?utf-8?B?dCtMa05tL2Jab0F0WG56NXJnSmpRTDU3MnRsWVoxOWlSWE1qL3gwcHAxZ2xV?=
 =?utf-8?B?WktuVGhldXpieExQU0FLQVpISFB6aWNUTnM2SExZYkRrOWdLMEoyM3dmOEJR?=
 =?utf-8?Q?VQQPVFNNlXpAflCv9G?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827a8a1e-745d-40e3-10e2-08de86e4b5d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2026 00:56:39.3904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O0irk2Gn09fJryFK81wZAtVS2cy/kC6T6gwZQtp4rf0IkRM7uYRq9rpstvspUiEYU7YakJ7pJmJIYdFr3FLOWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR21MB5636
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9681-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SA1PR21MB6683.namprd21.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AEA692E2B7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

LW5leHQgdjJdIFJETUEvbWFuYV9pYjogaGFyZGVuaW5nOg0KPiBDbGFtcCBhZGFwdGVyIGNhcGFi
aWxpdHkgdmFsdWVzIGZyb20gTUFOQV9JQl9HRVRfQURBUFRFUl9DQVANCj4gDQo+IE9uIE1vbiwg
TWFyIDE2LCAyMDI2IGF0IDA4OjUwOjM5UE0gKzAwMDAsIExvbmcgTGkgd3JvdGU6DQo+ID4gPiBP
biBUaHUsIE1hciAxMiwgMjAyNiBhdCAxMToxNjo0MUFNIC0wNzAwLCBFcm5pIFNyaSBTYXR5YSBW
ZW5uZWxhIHdyb3RlOg0KPiA+ID4gPiBBcyBwYXJ0IG9mIE1BTkEgaGFyZGVuaW5nIGZvciBDVk0s
IGNsYW1wIGhhcmR3YXJlLXJlcG9ydGVkIGFkYXB0ZXINCj4gPiA+ID4gY2FwYWJpbGl0eSB2YWx1
ZXMgZnJvbSB0aGUgTUFOQV9JQl9HRVRfQURBUFRFUl9DQVAgcmVzcG9uc2UgYmVmb3JlDQo+ID4g
PiA+IHRoZXkgYXJlIHVzZWQgYnkgdGhlIElCIHN1YnN5c3RlbS4NCj4gPiA+ID4NCj4gPiA+ID4g
VGhlIHJlc3BvbnNlIGZpZWxkcyAobWF4X3FwX2NvdW50LCBtYXhfY3FfY291bnQsIG1heF9tcl9j
b3VudCwNCj4gPiA+ID4gbWF4X3BkX2NvdW50LCBtYXhfaW5ib3VuZF9yZWFkX2xpbWl0LCBtYXhf
b3V0Ym91bmRfcmVhZF9saW1pdCwNCj4gPiA+ID4gbWF4X3FwX3dyLCBtYXhfc2VuZF9zZ2VfY291
bnQsIG1heF9yZWN2X3NnZV9jb3VudCkgYXJlIHUzMiBidXQgYXJlDQo+ID4gPiA+IGFzc2lnbmVk
IHRvIHNpZ25lZCBpbnQgbWVtYmVycyBpbiBzdHJ1Y3QgaWJfZGV2aWNlX2F0dHIuIElmDQo+ID4g
PiA+IGhhcmR3YXJlIHJldHVybnMgYSB2YWx1ZSBleGNlZWRpbmcgSU5UX01BWCwgdGhlIGltcGxp
Y2l0DQo+ID4gPiA+IHUzMi10by1pbnQgY29udmVyc2lvbiBwcm9kdWNlcyBhIG5lZ2F0aXZlIHZh
bHVlLCB3aGljaCBjYW4gY2F1c2UNCj4gPiA+ID4gaW5jb3JyZWN0IGJlaGF2aW9yIGluIHRoZSBJ
QiBjb3JlIGFuZCB1c2Vyc3BhY2UgYXBwbGljYXRpb25zLg0KPiA+ID4NCj4gPiA+IFRoaXMgc2Vu
dGVuY2UgZG9lcyBub3QgbWFrZSBzZW5zZSBpbiB0aGUgY29udGV4dCBvZiB0aGUgTGludXgga2Vy
bmVsLg0KPiA+ID4gVGhlIGZ1bmRhbWVudGFsIGFzc3VtcHRpb24gaXMgdGhhdCB0aGUgdW5kZXJs
eWluZyBoYXJkd2FyZSBiZWhhdmVzDQo+ID4gPiBjb3JyZWN0bHksIGFuZCBkcml2ZXIgY29kZSBz
aG91bGQgbm90IGF0dGVtcHQgdG8gZ3VhcmQgYWdhaW5zdA0KPiA+ID4gcHVyZWx5IGh5cG90aGV0
aWNhbCBmYWlsdXJlcy4gVGhlIGtlcm5lbCBvbmx5IGltcGxlbWVudHMgc3VjaA0KPiA+ID4gc2Vs
ZuKAkXByb3RlY3Rpb24gd2hlbiB0aGVyZSBpcyBhIGRvY3VtZW50ZWQgaGFyZHdhcmUgaXNzdWUg
YWNjb21wYW5pZWQgYnkNCj4gb2ZmaWNpYWwgZXJyYXRhLg0KPiA+ID4NCj4gPiA+IFRoYW5rcw0K
PiA+DQo+ID4gVGhlIGlkZWEgaXMgdGhhdCBhIG1hbGljaW91cyBoYXJkd2FyZSBjYW4ndCBjb3Jy
dXB0IGFuZCBzdGVhbCBvdGhlciBkYXRhIGZyb20NCj4gdGhlIGtlcm5lbC4NCj4gPg0KPiA+IFRo
ZSBhc3N1bXB0aW9uIGlzIHRoYXQgaW4gYSBwdWJsaWMgY2xvdWQgZW52aXJvbm1lbnQsIHlvdSBj
YW4ndCB0cnVzdCB0aGUNCj4gaGFyZHdhcmUgMTAwJS4NCj4gDQo+IFlvdSBjYW5ub3Qgc2VwYXJh
dGUgZnVuY3Rpb25hbGl0eSBhbmQgY2xhaW0gdGhhdCBvbmUgbGluZSBvZiBjb2RlIGlzIHRydXN0
ZWQgd2hpbGUNCj4gYW5vdGhlciBpcyBub3QuDQo+IA0KPiBUaGFua3MNCg0KSG93IHdlIHJlcGhy
YXNlIHRoaXMgaW4gdGhpcyB3YXk6IHRoZSBkcml2ZXIgc2hvdWxkIG5vdCBjb3JydXB0IG9yIG92
ZXJmbG93IG90aGVyIHBhcnRzIG9mIHRoZSBrZXJuZWwgaWYgaXRzIGRldmljZSBpcyBtaXNiZWhh
dmluZyAob3IgaGFzIGEgYnVnKS4NCg0KTG9uZw0K

