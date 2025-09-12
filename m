Return-Path: <linux-hyperv+bounces-6850-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C2DB557DD
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 22:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C74E16EC16
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 20:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D3A2D3EE5;
	Fri, 12 Sep 2025 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OQm+2pDn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020111.outbound.protection.outlook.com [52.101.85.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C450A15C0;
	Fri, 12 Sep 2025 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757710077; cv=fail; b=ZUpDDudyuiGh6Y6yrN1vnOx9Uip2deXQO8rPPACRm36kFThwQD8p/k6NmoDT/7Gg3GkIKiWj9n+WY4whAxsgZChAnhYMsYzf+59kextrYhODWn5tjNvntyh+tYptWX1o1fVkV6J42/3lCElcuEGJYZDNPs8RdNT59R3KakaOAfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757710077; c=relaxed/simple;
	bh=ZLDYOzvtn6AqGu9h1vNekywftG+SEXaccDieSsUQDaU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qIpBGSIFDD6SG8tltkU1BT0WA18TOjbN49UFgIA/WdKiUoRUnVmlXedQsGFmpaIoMP8Pq3m+B0HtdswMzHnj1Skci7Z2MTgETW5H5hQluUVI6O8CWMOM3L9sUu/GBr2kK8qarDNTE801qhVhTMHdHdrGNeO4hR8r2u5YCItnUgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=OQm+2pDn; arc=fail smtp.client-ip=52.101.85.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dixeeX4Eoc5IudrU6RKXYJQAMUppnhb0UlQR02WmYLWWZFv60R6gMVQzvZem4eFEMZdKyjQm8Xq0a/GTisyNoCNMxF58NDO0FNzfVLRXA9cHWNfhUY3JSqrRt5A8aNlX3e1VPtVeOjobMe+oDsduzabZ6rtcPZvmr3J17PUx9fqBhcQ7LCFDVUfXgLaBU7zIkG08oOd4MMZMG2zi5bYggmyZ4FqGC5nKnVwZlZSiiECjqVhuO2zAfCigrz/0DsOpsKlOYoTFazhH6mluINTZe7HnS78VZQIa3pGm4IukXtyoznnKWAZ7Puro6X7b8Svmf+BdtIci66D3XCGGqn1fXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLDYOzvtn6AqGu9h1vNekywftG+SEXaccDieSsUQDaU=;
 b=jgp9OWOEZ1VxaJ7CyI/Fj9T1v0CDVqejqYhpN31P1q76yZImObTkrbtKxWcd7LYDW4VXwgJ4DyE/sLJFPM6QKsKtYB3utNwkpYjtThjKjQdj65UekHgQPkoKKfuY9xI8UD5Z2Wlv2xzGFaX0WwG68NeOcjTYI4tFTqBimpczN5JOm8f4DNvgQicpYImK8wtFl3HinznVtNfcYGsV3eeZZHrhOF3F9+VkKmaj1l5TjDoGjYtGX8hazXMAkB3AlJpoGkwmeem9m7hGBkL6TE/rjbEi6JkXjgR1oLHAah9mHGVOv9xv7UHCH7yoLQGUnOZBW2keq5BMjsdorYJ1cci1Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLDYOzvtn6AqGu9h1vNekywftG+SEXaccDieSsUQDaU=;
 b=OQm+2pDnqB2VfRI4r6UEVRIPiGWeU5HRfZdKSvIB8lMfPjE6PQaKNDWGyNbe7sgtJqbMAsHQ48lvoU7nnGb0Ac3JFx/g9grch6LaiyHaUlLwUjy4wDKTaEdoDw7I7HV1MyED08+Zh8MV+DWR7/gWKNDlwX1HCmvj3jmlsl5uqnA=
Received: from DS3PR21MB5878.namprd21.prod.outlook.com (2603:10b6:8:2df::6) by
 DM4PR21MB3781.namprd21.prod.outlook.com (2603:10b6:8:a1::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.2; Fri, 12 Sep 2025 20:47:52 +0000
Received: from DS3PR21MB5878.namprd21.prod.outlook.com
 ([fe80::72b7:dfed:2b1d:c845]) by DS3PR21MB5878.namprd21.prod.outlook.com
 ([fe80::72b7:dfed:2b1d:c845%4]) with mapi id 15.20.9115.002; Fri, 12 Sep 2025
 20:47:52 +0000
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
Subject: RE: [EXTERNAL] [PATCH v5 10/10] x86/hyperv/vtl: Use the wakeup
 mailbox to boot secondary CPUs
Thread-Topic: [EXTERNAL] [PATCH v5 10/10] x86/hyperv/vtl: Use the wakeup
 mailbox to boot secondary CPUs
Thread-Index: AQHb592xG7vqeA8nY0qNs35WkkCj+7SQfTBw
Date: Fri, 12 Sep 2025 20:47:52 +0000
Message-ID:
 <DS3PR21MB5878BD23A845865D898E3C4DBF08A@DS3PR21MB5878.namprd21.prod.outlook.com>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
 <20250627-rneri-wakeup-mailbox-v5-10-df547b1d196e@linux.intel.com>
In-Reply-To:
 <20250627-rneri-wakeup-mailbox-v5-10-df547b1d196e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=07ba2062-6c75-4dbe-a70c-71fce1751640;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-09-12T20:47:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5878:EE_|DM4PR21MB3781:EE_
x-ms-office365-filtering-correlation-id: e32f5149-e0e0-4411-7d3f-08ddf23da4c9
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dnRoblJXMjBMMDlJdW5nN3FONEtnTGRSNnNxTGJBMXBKSk4zRWYzTzg5REtO?=
 =?utf-8?B?NldDQ3ZYbkI4czRsOFZMQnpKaFZrWjdkQk5MSmRsUW9ZTVp2aWlIZzVqRjZI?=
 =?utf-8?B?emNlM1dOZ0JTY1BQbzRYUHhlMzNEckN4NVQ3L3QzSVQ4NkFIT0Z1enpTVFR2?=
 =?utf-8?B?VGlFQTZOR1o5QitPTzViYkNEZjUyYmZhODlwbm1zUmhkYzdMVHFuQSs3NFJB?=
 =?utf-8?B?dWlJbVlubVpMYzY4eU0zZmplREw2KzlzK0FFTWdnVlpJQnJJaUIvditna1ha?=
 =?utf-8?B?MnZ3NCtxOEppRWNua0pPWTRjM2ZVZ3RqMUwxZVNGR205c2dtRXlveGFlemcx?=
 =?utf-8?B?QjhxNk1HSUduNTFYNmJmek1QdFkzYjVJWGNmdEVpS293OGUzL1owekpVSTha?=
 =?utf-8?B?cDlPT2cvdXF1aTFBWlBFVmxPUkc3MnBWaTlrYlpxY3ZYeU1sQ29LcU9qNE5M?=
 =?utf-8?B?TXFiQlIyNHlhbEFMeHV0RG1LL3FvNXdhVm9KQnUxbGtEdDZmcDg0S1dIaFpo?=
 =?utf-8?B?OXloNXBPa080b3owTW9rTVR3bEw5OFhKaEJlLytrWUY3MStwZUZMSUxUTzNz?=
 =?utf-8?B?dmtsQVVKM0lVN2FaanRoZFAyTW5McXVEeCs5QTFIK1lMWWhzQzQ3ZEhINVdk?=
 =?utf-8?B?UnRqZWZqWFBHemR5bjZMZ3pocVV5MW9LNEE1bjRuNVBvNG1neFBkd1JDQktK?=
 =?utf-8?B?UlloZFVUWWJNaEp2RzZCeHJ6NDU4THRBbGthWlh3TWNONit2QTZSUzcwdXYz?=
 =?utf-8?B?YXRiaU1oalI4eEdNZkg3WlVuQkR3NDRQdVoxRm1sRHplaFlLVVVDVzBlMHhz?=
 =?utf-8?B?cFVBeVJoNHVpVDZucm41eG56eDVlVEVxSGpteTRsQTVkY0ppb0QzUWlZTCtj?=
 =?utf-8?B?S21lVkltWlFJdkwxNEhYYko3eHQxL3hLRDVFRE1NV0hkLzV2M2hQTnZHNzFs?=
 =?utf-8?B?by9ObThPOTBYN1VOOHM2WVQwVXU1TGxtTHcvSlFHalptcU5SUmJKUU83aW9S?=
 =?utf-8?B?alBuMk5ML0FrYmdwSFhtT1VIbnZwdE1SZGt3N0Z4d2VNMCtYNjJ4RGN2ZHpV?=
 =?utf-8?B?Vk1zSkN5ZUgzN3kzZXJFSXBwZjZ4THVGb3RJTWlhV09xcWkyMWRJcTBSODdM?=
 =?utf-8?B?clpjckNVWEJFNzEyazZ3TThMOXA4eFVvVGZXYnNwSTFqSmRWL1hTZ0xzZnlO?=
 =?utf-8?B?cmp3MHdjNFBHYlZRMTh2Q3pyTlQ1T3JQaStjUENMTWl3Z0c4WU1UY1o4N1Bt?=
 =?utf-8?B?RkNDL3BVZlcyckdtOU52eEpwODBWYktPRVl4VVhReFNVMHVwakZCMkc5TDVy?=
 =?utf-8?B?UVkwQUFteHgvUG1HUi9VVUxobDFYMEVqVVBZQ0JxY21WMWhUUFdwYytsdzJr?=
 =?utf-8?B?MnFOOVdVbzAwS1h4bjVZeTg4OWxoSWxtWmx2T1loNDhiMWRmZUpQK2lwRS9J?=
 =?utf-8?B?UWdzZ1BwUmhUTVh1L3l1ZGIzRUpqNU5ZKzdtSDE1cWtXNTRXSnhyb1ZSRGdv?=
 =?utf-8?B?MTJyU1hETXFNRUsyR2hoQ3FZeHVCcnlrczI2Q2Y0RW81cHNhQm53RXdHL2Vk?=
 =?utf-8?B?dTJmZWtkQ1VMOURPKzlHcnZFTjdGR1ZwOUVpd3hIZmFCVGdLVUU0eUJkQnBu?=
 =?utf-8?B?RHNHSGViVStpSFJuem12anBWTTVxMWhoWlVsenJGc2owb3dXL3BINThNRTFP?=
 =?utf-8?B?S3l1VzNqcHU1YlI0eWNhWDZiRVRYTUZqODZnSFlxNWQyVVpIZXJvRUNxK1pB?=
 =?utf-8?B?K20rVzBFaVd3WUV3dE5EY1d1MTdVM1F3U21CMXRTNVIzdUNNd1h0Y2FsREJl?=
 =?utf-8?B?aU5vVytTaVRLMmcrb1NqNzN0NnQ1dExqR1pRd2M3dzg3aUVTWXZvVnlzYlBj?=
 =?utf-8?B?WlZzT1dPTCtydm5wbU1VNXJJYVBPRDhhdXd1cXBEZUJBai83Wjg4N0kzZWZx?=
 =?utf-8?B?RjhpYmpDUVErQ2hWMEZDVVFPSFZFM01SUkZEbkVqZTJLcDBYa0x0NDZpZEw2?=
 =?utf-8?Q?94gndVhx5V79FzXAABmF+1+koTG2uo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZFZpNStHU2gzT0pmZzVXQUhRY1FsaUdITnZOdjlETGM0R2lSS3FFaXlTNVZm?=
 =?utf-8?B?emh6dWtwekFUc0VRWERWQzkyRjN4Z1FlTlNlY2pIN2d6WmcwajNKbU0xNzdW?=
 =?utf-8?B?VlVHQThLT3M3bDFZUWRBaFpjeTliVFFxMVN1cHNobCtweFRYeWg0WFRxYWtE?=
 =?utf-8?B?UzZIbHpPMW9Vd0oxVlNnMklaa2JuS09Yd3hYVnpIdEs3Um1iWU91K2JiTldD?=
 =?utf-8?B?SHlrMGtoU1RZQzlUc3BnOUU5dUZqUDg3MEJqMVVXSGk5MGpESzBuRkU4OE1m?=
 =?utf-8?B?d1MycGxsZkxmdG9zcVVQeEUwdGo3N0IxZTBjQ1JEZXlaN09FZnppVldwRWhJ?=
 =?utf-8?B?cklYWW4vbDhtMUg5YWxyNkxuK29CSVdTc3NxcndDQmM3TjFydGVGZFFrNFl3?=
 =?utf-8?B?N1M2V2pCVHp2Q3ZNd0tCbzJORjFOYlpSb0VzektGKzJiang4MkFtWlAzSHpN?=
 =?utf-8?B?WlVnVFBaYzRBN0o4WGtIdXdKQjMrUUlaNHhmcjJWV3RqN0xDNXVkbUxvTDdF?=
 =?utf-8?B?UGNlYVFjTUpEVWtCeXY3bFZpTU8yRkkzSUphMjVLSHJVbVM1bGRNYUJERU1p?=
 =?utf-8?B?UEpPL3c5azdJL1RXVmdKR21Qa0c2bXg1VzIxbWRyNmtXOGRIbTN1VC9IMlVk?=
 =?utf-8?B?VUVReUUzaG1vdlhYYnBpc3FWTndIZ2N6MC8reHNPdVFKbER2SHNmWUFYTUMr?=
 =?utf-8?B?eGJDek5kQ3p2YUl1T1dWM2JBWTNpWEMrdGNZa0lDRUdqRGpqbCt3Y2NhRm0y?=
 =?utf-8?B?c2hhTTdobXNTazRGVzlIcUtEaThvVlJxZ3lVdEdGck5mRjZnNWFZUndwcEZC?=
 =?utf-8?B?NGgvZmN4b2xLUXpRQmUwVkNYcFRyS3hlTTdjTTdZMlZOR0NLV2NVdjJjUC9v?=
 =?utf-8?B?cmZCNVFKaTQ4V1hPKy9YMU1nZVdVQmZvMUE4SGNtY1NlL1N6bzhyTUlzM0Ux?=
 =?utf-8?B?VFZ5Qytlby9DMkJWV05BQjRIZS94dGcycE4vSVlLSUFXTG5WMnhUNnVhVnMz?=
 =?utf-8?B?T2ZWY3hCRkw1OVdndC9uVU9VcklVeEFxTjdDSVppNnBvUjFrTVRsbGxLRGhM?=
 =?utf-8?B?dlpiajJxNFdpY09MbVhJNHJrYTRTWjhPdFpuQkV4TzhlcG4ycFVLMlBJT005?=
 =?utf-8?B?YUc4Z2hjVEtGdy9OWnhPYUNUY0ZGbjlxV09WbTMwbzNDUWFGZGtpclNJbnU5?=
 =?utf-8?B?eU8zWFY5ckFpbW5KdTE1aUprd3ZlZ0pkY3U3RWRKRXhTcElYcjAwVFBYNlZW?=
 =?utf-8?B?M250QmpJc1dZK3B3Qm9zbHNPNzlicFV4ZGFEcmRzSGlsRnNNR3ZzUVV3U3Mw?=
 =?utf-8?B?TitUZGdUSW5RcW5zWENOTVVVSVFXVVFSWjZqbXhBSDdsajI1c212ZkpKdWVi?=
 =?utf-8?B?aVVlcDNHdW95TWk0WTNiQmQ2ZWQ5emFPS0hjZnhYbC84SlpDdjhTNVd6WjRW?=
 =?utf-8?B?VnJEZ2k5d0IwaUJvTWQ2YnEzUDFLZngrYm9BNCtxK1BTUDVra3ZMSENuUjl0?=
 =?utf-8?B?Y29rdWhmMXlkazZ0M0dEVEs0Y0Q3dVlJWm84MURrSVloUkJ4UnhtVmM5djUw?=
 =?utf-8?B?WlNYOGkxV1BXZGpXTGExc05rMTVwRnBEcUhmMXpXZ2thMFpxeEI5R2ZrVldm?=
 =?utf-8?B?QUkvSUQ4TytDdWxHVFFzdThLQU55UmFRU1hZNTl4aEovbGlFTHJ1ZjJ2SGZY?=
 =?utf-8?B?SkZFc0dhWThDUExZNi9QaEcrMEtnNkNaZlJ1eUZLYkN2dkdHWnMrcDBxWDZh?=
 =?utf-8?B?R01sbTZBN0VDQkI0bWpQY3BEUGcwSytJdEkweDY4Nk5neHlpWkxLNUJ1dEVF?=
 =?utf-8?B?OENzQjRqZHBFN0ErSlNZNVV2ZUxES3RhMEpmdVRsSHRtKzF4K2NjYUJZU21a?=
 =?utf-8?B?T0ROU0ZRVUtCYU8rYmg0VlA1d1l4WUJPL2VCbW9sYkt3RXZlTjBndlBuUjZF?=
 =?utf-8?B?bFBxZ3lUckcyTnRqQ2w2YnMwazNBbEp2Tm9BYnZORGoxZFZSdjFMNXlUU0tz?=
 =?utf-8?B?SFpVb25WK3NYUzNNd0hkaE5LREhOenorbEtibVZQYXRwbTRHckRQcEtZbTNO?=
 =?utf-8?B?Ky9Ldk1nQTh6WnRiYXU4UU12amNHMDUzL2xLU1Q2bUJLeTVTWTRrVm5SU2Ri?=
 =?utf-8?B?UjE0NU83L3gyWXNFU0pQbUl4NWZCd3JvandKNThlK1pZSFRFZGREQzAzYVRz?=
 =?utf-8?Q?47RWaXFRe8KclCY8QSLuBJQcEqmRajAA1CUE7+DqE/0z?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e32f5149-e0e0-4411-7d3f-08ddf23da4c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 20:47:52.7903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xL1iJFvt1q+Xvq5yUjNoqh73gn36zUQBv8t9bQQTcQAuZECJM/ZQX1lYyx1DrbTMja/0q/pr4TPtCX0J6uuREw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3781

PiBGcm9tOiBSaWNhcmRvIE5lcmkgPHJpY2FyZG8ubmVyaS1jYWxkZXJvbkBsaW51eC5pbnRlbC5j
b20+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAyNywgMjAyNSA4OjM1IFBNDQo+IFsuLi5dDQo+IFRo
ZSBoeXBlcnZpc29yIGlzIGFuIHVudHJ1c3RlZCBlbnRpdHkgZm9yIFREWCBndWVzdHMuIEl0IGNh
bm5vdCBiZSB1c2VkDQo+IHRvIGJvb3Qgc2Vjb25kYXJ5IENQVXMuIFRoZSBmdW5jdGlvbiBodl92
dGxfd2FrZXVwX3NlY29uZGFyeV9jcHUoKSBjYW5ub3QNCj4gYmUgdXNlZC4NCj4gDQo+IEluc3Rl
YWQsIHRoZSB2aXJ0dWFsIGZpcm13YXJlIGJvb3RzIHRoZSBzZWNvbmRhcnkgQ1BVcyBhbmQgcGxh
Y2VzIHRoZW0gaW4NCj4gYSBzdGF0ZSB0byB0cmFuc2ZlciBjb250cm9sIHRvIHRoZSBrZXJuZWwg
dXNpbmcgdGhlIHdha2V1cCBtYWlsYm94Lg0KPiANCj4gVGhlIGtlcm5lbCB1cGRhdGVzIHRoZSBB
UElDIGNhbGxiYWNrIHdha2V1cF9zZWNvbmRhcnlfY3B1XzY0KCkgdG8gdXNlDQo+IHRoZSBtYWls
Ym94IGlmIGRldGVjdGVkIGVhcmx5IGR1cmluZyBib290IChlbnVtZXJhdGVkIHZpYSBlaXRoZXIg
YW4gQUNQSQ0KPiB0YWJsZSBvciBhIERldmljZVRyZWUgbm9kZSkuDQo+IA0KPiBSZXZpZXdlZC1i
eTogTWljaGFlbCBLZWxsZXkgPG1oa2xpbnV4QG91dGxvb2suY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBSaWNhcmRvIE5lcmkgPHJpY2FyZG8ubmVyaS1jYWxkZXJvbkBsaW51eC5pbnRlbC5jb20+DQo+
IC0tLQ0KDQpMR1RNDQoNClJldmlld2VkLWJ5OiBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQu
Y29tPg0K

