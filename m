Return-Path: <linux-hyperv+bounces-8872-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ7bBcPzlGl1JQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8872-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 00:03:31 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 834E5151ADD
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 00:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42305302D085
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Feb 2026 23:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFBA2FF148;
	Tue, 17 Feb 2026 23:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="XnPrtrNp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4897028D8FD;
	Tue, 17 Feb 2026 23:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771369391; cv=fail; b=eDW6yeiJUuPsWx2ieTdybdewtDsc+Sbcbd6OBn9CWe0gdVhAOzXtS6Z2VcNyijo81tB8JtdfSgK1LXR0IEZG0NhzYdNEk/8aj13Nqbqa85x3+n6GladbhJYFNlF7YlG4T/D3GyLDvReAF8fGs337leWuQ47i3D9TXNL3pvApeMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771369391; c=relaxed/simple;
	bh=08mu+eC80TNpDrwD2mdTC/4TBTozrDCtDhKVBIj2OtQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e9/Zm5fjtETYGLXlD/2Az86RGdy8ElQxZzKoYZgznSF9GAreX3K7YgXEjc5GZEyQzoqf/t3xMx+YR5BLsqfvVH14XGnjeSY6njsVXYmRDCDBiQqT/my1bP+QqU6t7njbNrQ6kxoBeSTaX/W1un806Z5RxFX+ffIp5Wos5erY+CM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=XnPrtrNp; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7n6gM5RW8T/RouVcg5eccJfBENbiIBZ0SqgEXzOTJvgDohqTPseS5G7JcVsDtSTR0/0fQibt+GoJRJsedgv/3U2MOuKJTaSs9JIfS+tYd1If1KSTGsAvL0ckugA3EYpy0F5ktYJg8SPWCclrv/EtwrI03/gjGJcitv2kBgBUvakA/UKZB5Q+61LKq27KyP2zlR3yvhsy+afv36IaXGBC5R6RTXI24j+LPTLGJ+EYq2sB8tQGt6s9jjTC6jeAXYXCZpkteMsb/IjYygPw7kZ2Fsw917dUE9EeiLvJrrTSvdXtG6oDe4tbfIvze1tD/+c8SCYBHwaX54FF2G65Z11dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08mu+eC80TNpDrwD2mdTC/4TBTozrDCtDhKVBIj2OtQ=;
 b=y+M/oIDN5VeS/qQb1n+qeolkZfgRzEL4NeiJiL9pyqDRvTBIeaDEGZzpehuQHYpXGDfA2upbk5j0rmg/kJq8rRFIA7jW4lBm/a4Zv0pxjz/uOdfIZl2Rq0rebdGqbZTS85sICUIBoITLT0HKN8wAJz+GP6g6n2NuSBrHcVlyf+4sBEBeZ6TZeXaEkw72CdktvdZ8TPZ8D8WkPvZfz94WPskfYU7AMYtKRTMon0CziDO13FxViskqlnG7k9IxBFTSJqLQHs0YGIQDUd/T5I9jutDf3s0pOChzfrTLMwsnaHuPb/L/TS891PhxkODs47rnZ7Ib7rV8C4C9R95Lq0mjLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08mu+eC80TNpDrwD2mdTC/4TBTozrDCtDhKVBIj2OtQ=;
 b=XnPrtrNplJXeUcmxtTrw17EHXpKVGAnYDxJtkPSrByXfpfN0w6CNUl4BQ9HbFeASaasDN54cNcs9uJTTDbGrmQYilIO8ioQo7KC6XjRFqOfyEy8j8t/TXTswy9wI1OBUKPfavuTgOdr69fkHd9xumP6A1A1UMoPKnwWw2MT1U/JBesRlPkoFFf7fTKNIIRYaJrrd4cxnEIcxnAI91iqqSf4ufhldtmEdn0l5Zmt2Mx3YGKpLSnOVQOF3RbMyyXPLkOfRgVi/Hj4OiJqDaCkRT0KZpAzBPg8Ejab/XwzcaC45mW6Mv6sB+t6sLGWUCBwbvsThR9IG6+yju8UR7/14+Q==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by GVXPR10MB8083.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:115::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 23:03:04 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4072:14dc:7d1:74c7]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4072:14dc:7d1:74c7%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 23:03:04 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "kys@microsoft.com" <kys@microsoft.com>, "decui@microsoft.com"
	<decui@microsoft.com>, "bp@alien8.de" <bp@alien8.de>, "longli@microsoft.com"
	<longli@microsoft.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "tglx@kernel.org"
	<tglx@kernel.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"namjain@linux.microsoft.com" <namjain@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"levymitchell0@gmail.com" <levymitchell0@gmail.com>, "mhklinux@outlook.com"
	<mhklinux@outlook.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>
Subject: Re: [PATCH v3] drivers: hv: vmbus: Use kthread for vmbus interrupts
 on PREEMPT_RT
Thread-Topic: [PATCH v3] drivers: hv: vmbus: Use kthread for vmbus interrupts
 on PREEMPT_RT
Thread-Index: AQHcn2DM4hZzCftgRECM2RPVLCcwcrWHhGGA
Date: Tue, 17 Feb 2026 23:03:04 +0000
Message-ID: <033ecfefc85bdb7c508d488c5004913d87057142.camel@siemens.com>
References: <289d8e52-40f8-4b22-8aa9-d0bd3bd15aae@siemens.com>
In-Reply-To: <289d8e52-40f8-4b22-8aa9-d0bd3bd15aae@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|GVXPR10MB8083:EE_
x-ms-office365-filtering-correlation-id: 473dbf0f-719a-4bec-bc95-08de6e78b4f3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dW53NFhuQis1a3oya2pMcWhweHZ4T1JBalYvMTQ3YlZwZzZ2MUpxZFVMeEND?=
 =?utf-8?B?NlA4RDdlcjVNV1BYekx2bTZLeklneFRwSFRIYjY2N2ZRMEh5UitJOVRrSFlG?=
 =?utf-8?B?ZSsra3JlU0FSSGtkZVVWNmtBYjBuVldTM2E5b25uS1NSaUhuMW54Q0FrNHFl?=
 =?utf-8?B?OTNpYXJkUUtnQlY1WERKcHE0amRnUDlUZGdnTFhDWmE1akoxRGpFVVhJSGZo?=
 =?utf-8?B?MWlvK3BDU3AvdE5pTm1semdiVjVYNlIzajNJMGQwbUgxdFlNckVRVm5UREpn?=
 =?utf-8?B?M1poTkt6L1JEaElLczZLUXhVQ3JTY01WSWxBb2p1anMxTkkvdkRrVXZvWGJm?=
 =?utf-8?B?NHpUL2FqK3FGL2FJcStNeHVwTEY2Ylg4TlhBYWtVYkR5UHdJQ29PZTk3Wlhp?=
 =?utf-8?B?NFlSZFJDazAyVTVrWUdoWmZ6azNRTzVjYzZ3ZkJ0QWw4bVJVMjNxUmxiMnRu?=
 =?utf-8?B?bDR3SFhINFcvYnRDdFBiVHpPVUJRR2xicnZnNFc2ejFIWU5RVk1NeVV1enFk?=
 =?utf-8?B?QlZXelNrbGJZUjJEQnp6QkdtZjhxYXdVak1rS2s1ejYzdi9IV0FXalZ5T1dr?=
 =?utf-8?B?TDNDdnNVSEhLRDBrbllOVzNBTmhpTFRTNVhsWXNXKzJqWGpPZ3VpbVJyenFx?=
 =?utf-8?B?Zm9JNERHdERJTjJXN2FSZDYyNy8wUnV2aEdLNUtpVW5jaU1jRU5KaW1BZHZY?=
 =?utf-8?B?VEV4bG9IMllUZndQVUNoM1dRWWlmeG9XOFQ0cmxRL1BwTVhIRlFEcHZnSWx6?=
 =?utf-8?B?L241TEJ0UUcxVWlYMXJWQS9BVkI5RlY0TG94Z29kdG9rQ0tEMnl2Z2dyK1Ir?=
 =?utf-8?B?QU4yeEpDOEdjVlRtOEozdWRyaW1IMHpUaUh2SkJ2eTNjMkhENU1Uci9QZU9W?=
 =?utf-8?B?U3I0VEpKR2Y4WUtpTGkvWFBpQnhqTmtMK2RySHJ3ckN4cWZxNWtLSytsVWFu?=
 =?utf-8?B?VnBsMjZHWllGcUwzc3dNaVJPRE43bWRDODhFUGNFbG95V2ovQk5EaDdlUFll?=
 =?utf-8?B?M2M1YWMzbTYyZllVbVVXWEJkdW5QNDVqYWk4UFhIbVhGeW9yR0dGdkJhQ25L?=
 =?utf-8?B?NENqb2laUUp4VDErQmh5T1BnQXlDRngrYXQ0V21paldNSit3QmVwTkhxbHNR?=
 =?utf-8?B?dktUTVVHN3lTUndFb3c5OHpoOWtCSnBEQVU2SGxINUhBczY2STdxWUdMMXFS?=
 =?utf-8?B?NGhTTmlzTjBBdTIxb21TZERrK09PMnczS1Y2dnl3dHQrVE9ZaWhxT0ZBYkVs?=
 =?utf-8?B?cUpiU1VQZHZPbVFxRXZwQ2pGYlZEMTlvQlhGTWtGMGVEelZ2RXA3OE9YQ05M?=
 =?utf-8?B?Sk8zR3pyVUw5bmZSUFJ0L1JwQW9vYldaVk1DOHByNXB4L1hWS2NzMC91TDdQ?=
 =?utf-8?B?R2FqaDFpZDI1eks5MUs3REUvbFJZeXJrSGRSaGNXMFJ3bmhHWFBaT1UvU2J4?=
 =?utf-8?B?TTBOLzdRMHgyRnlGYTM2WStZTDM3VXAvUnBNdW5jaURRNEMwSFZpQW5hS1Ri?=
 =?utf-8?B?d2FMMWNSWlpCSkcxN3pGb1hUOHRVb1FiNXdNcGx5cms0RkhtUWhSSUlIZjNj?=
 =?utf-8?B?MWZaelRrRkJibVgwdU90UWEvbzFOdktsUmdrM08rV3ppRDlTYW5VYnUraFZG?=
 =?utf-8?B?M2tZRzhFY3pLeVVQY3Awa3NVTXNlUEMxOXJWeTA4RmhvcUNYUWJEbTNCc1c4?=
 =?utf-8?B?WW14NC9CZU9hSVBSL0lkaUJ2STRCU1hHckN2VzAvdFB2UmQvejJiNzhzMWty?=
 =?utf-8?B?bzJydG9tNE1OdmVpd1lhNGlBSjVtT1ZLV2ZUcHVqTitmWkFHT1NuNTVIa2xG?=
 =?utf-8?B?VUE4dnV1T2p1Y0tFa1ZSUmhZNk9XMXQ3YnhNQjJNa0xqVVN6WHRMbGgza1d6?=
 =?utf-8?B?SGJNOGxpOXRhSlVBYWhVUHZxQzF5M2NreDdqTURjdGJ5SzE0SUIxSUJ1cDBa?=
 =?utf-8?B?dDBGWjYyNktlelFlOXlWblA3ZDRGb3l1ZlZqbEhhc1h4NlNrQXgvdzVTUFhV?=
 =?utf-8?B?QnVnZkJxKyt6Qm5jWnJ3YW1wTkVZTGJuWGNLT3RLbXR3VUdIQjBUT1FSTjd3?=
 =?utf-8?B?akp6bXc1U1ZSaGUxOVN5Ukd3eEE1SFhSOFkyRVhOMVJFVExDUmpHRENQUUV6?=
 =?utf-8?B?Z0ZhNFM2UEZPN1BleGNreUpkOVJ6bXNTWjFuYzJoTVMrUWFTYUh4WHlwL2Y3?=
 =?utf-8?Q?MuxUq/v0O+GU9ix0LmlQOKZwwguZZO//y/gkMXW2ZzK8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d3V5TGIwWmVJU1BzQ291RlBPWG1nSzJXdW1sdVBkM0tHTy9EeVp4R25QbEwz?=
 =?utf-8?B?NTZiRmNkbmtOWHlXaUFGSHk3UzNSMmwvZzNxbTNxWmFoUzhBM05ueEFsNkEv?=
 =?utf-8?B?NFJ4Mm40N0w1UW5ObWVvN3dKaGJkQ251d2YrejFvZjl3VGJEczlheDZ6VitH?=
 =?utf-8?B?ZXRrNFkzbTkyZ2Q0aWxsMG9VUEZpWU43enZCZDdUVWJ0SlZ6NGt0dTRpNVk4?=
 =?utf-8?B?QXhTSEFWbFc5SmtrMjUwdEphaDNSbWdzc3BZSFgrR1cxZ3U4WElyVTEyb3ZQ?=
 =?utf-8?B?LzNjM3dWMXM3d1NLRjc4Z1JUUm9PZmNwVUE4RnAzQ1VYam9JZjFpREZFTmVu?=
 =?utf-8?B?Njc2VWpjZTdFdStsbURzeVRoT2tOZ1pkbCtMdkZRRVN2dndZNWdGMGEwLzM1?=
 =?utf-8?B?eFJSbzBna1B3R0xadjM0akp2KzhzME1lUzdOdnd6OWEvK2VDNm1wSm5ha2VP?=
 =?utf-8?B?RlNCci94L0wvVEFlVGFKLzNGK2RPM3hOL3VuVFRVY1Fyd1VNT3BQVmhHTkpv?=
 =?utf-8?B?WTFJMzQvb0tiTThnQnhTbE5IYktuZkhaMGYxd1pXbzdzODduV2RlZ2RLR3Zk?=
 =?utf-8?B?V2hERkRzcGVXWFpLRW45cEtJQkdRUzNYM1pFR0Z2dGN4c0V4Q3FFUWhDd0Qx?=
 =?utf-8?B?ZmUxTXVBcTNIVFFXTUlKSmpRVFlzcGtXY280M1gzUWo5aVoxUDMyN2dkUVMv?=
 =?utf-8?B?OEJ5MmZkOVpDUFF1UjdUd09kQTV1azRiV2pjVEdyWEhXU3lUQURDa2ZBSVBO?=
 =?utf-8?B?RWs0MEZSbTNTbU01U2lqVEhyYkMraytzM2gvUzNEU2FEc1JHcEp2Mk1nWndY?=
 =?utf-8?B?YjJHRkpCL0dXTU8rMmVPeHg2S2IyRmlwMmRSVFE0UjhOUHJwTkhHNVY0cjNT?=
 =?utf-8?B?YXJsa0dadHAyenhPRUlRZW5SNlNRdzVmNXZCZitmbHh3ZHRZL1EzTW1oWVZF?=
 =?utf-8?B?OTY5LzdTUHgyV3FZWEo1ZTRmWjdFb1NtSjJnc0xjTE5lYStValhLaUxiYTJu?=
 =?utf-8?B?ZTgyaWR1QUEyY1RGNTJFV3lybGVFLzhyQXE5YnlyS1RVK0xZVWMzaklPYlI5?=
 =?utf-8?B?UVRuNmJmaGZwOVVVNkZWakI0MGlYTDh3eGcyQjJmVm12ZzArdFkrYVRUclRG?=
 =?utf-8?B?bzljWHlsejE2SFpCUCtsakFQZy9WNTRwTzF6VTRvZlcvdEFIUTdPOGFuMEQ1?=
 =?utf-8?B?UHNRMGpVZ3BHcFpCYUdodnRlYmRmMzRDSzJSMlVGbU9WU2RSRDN1K2dSd1F1?=
 =?utf-8?B?aFozbGJHMkpVMHBRNmdmb3k0S3hRdmh5dXJjQnBlOGFTeldnenRXNUN6Vnd5?=
 =?utf-8?B?RTdFT1pjSW5RQ0pYdHdyd1VYQU9IZCs4WUU3ZVpPbE1Lb0xGWlhYdmVtWWp1?=
 =?utf-8?B?akw2Tlp3R3N2Mmp5eVV6dHhXdVlNUDNyc1pyaWhBNCtweXN4YU1acWwrc3lN?=
 =?utf-8?B?em1JamdmTldHejh3QUhtckdpeUVqZG92SzFzQ1RxQ0NaZEJIU2pjR3RLUmZj?=
 =?utf-8?B?bk80RXJ3dnRISjBYVFFhWUF5dS8ydkhOcjJ2Ukh2M0tuRFBtV2VEdk56WTZG?=
 =?utf-8?B?M3A5Sk1xZTFNeWZoN2NiRjlHeXhRSXBHWGJ6ejNra0hCMW83ZGEzazJuTXpv?=
 =?utf-8?B?M29PSDFSTTg2NEZPK2pvemhXREhlTnNBL1ZXajE0UDNmY3c3d1hnRWNydHJz?=
 =?utf-8?B?VHpkRmJPV1RDa0ZiRWJVMmF3VjNLZzhZcEVlVDRvV29XZGxVaUpsVzBaV0hz?=
 =?utf-8?B?NlZESTA4djE4cjVRYjBITkRsUW9qMDF0ZzZGWVo1WGZ4U0t5N3JXRWxiWGRN?=
 =?utf-8?B?V0ZvL004cVlZTHlpaEFRaHpGNGxMaVBQU3RrSnV1WExGbFRLZ21wUE5mWmN0?=
 =?utf-8?B?UHc4cnVML2dLdk85NHJaNERRdkYzNHVXRW9XVEJHMk4vR0JDQkRRWW5lK21J?=
 =?utf-8?B?TjVRYUxTSHF6djlhZitJUjBMeHZZQzVxTmZTaHdjQjNrSkE0T2JNa2JFVUto?=
 =?utf-8?B?WXVBbDhHSlpkNTdTWGpBYkRtcmFxeitJdSs1dU10cmJoMzVGQXBldWJOSlp3?=
 =?utf-8?B?bkxJRFVPWUl3NC9lNDNUZmJuMS9sY21JQUI3RDhMeTB5MjQwamJscTFuZmdM?=
 =?utf-8?B?UEtocFJTNFl0UzJzNTlNQTBhWU9GbmNkanlYU29kV0Q5SlRTUGFWSm1CbjhJ?=
 =?utf-8?B?Tm5mNVFOWlVnMUxwQUlKOThuL1cwRGlRMUpYYkpyQVlCeXFaZFYrZWx4N01z?=
 =?utf-8?B?WVZhc3BNOUkrU3RMRFVYVHhpMkVEVW1GTnlyK0Q3QVZhRGJpaDRKZ2U4elVr?=
 =?utf-8?B?djNVRDhYWm40c0pGU3J3eUp5bE5EQ3dUdDZ5ZHJVWHkzeGRsSWlCMkRkK1Vv?=
 =?utf-8?Q?CSPDBKVheXnUjDY2FrdHzaG16JZhZsrDJCo/xlAie0Qbh?=
x-ms-exchange-antispam-messagedata-1: A4w+efHwnNGgS+gstPXcwrLbLQdZYU8CLvY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <893434C96AF8B64ABAE4E94E7ED034C4@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 473dbf0f-719a-4bec-bc95-08de6e78b4f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 23:03:04.3575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJeCMGVET4CToabYYp8xh2CP1XdITmqcXqNAzkd7omZVA1tdovuXDjE1XV+Gv3YutiiK0a3PZOedNvEV5O+dy7NSlRFBf9Tfw7Hl7WW2tnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8083
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8872-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.microsoft.com,gmail.com,outlook.com];
	DKIM_TRACE(0.00)[siemens.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.bezdeka@siemens.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,siemens.com:mid,siemens.com:dkim,siemens.com:email]
X-Rspamd-Queue-Id: 834E5151ADD
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTAyLTE2IGF0IDE3OjI0ICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBG
cm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiANCj4gUmVzb2x2ZXMg
dGhlIGZvbGxvd2luZyBsb2NrZGVwIHJlcG9ydCB3aGVuIGJvb3RpbmcgUFJFRU1QVF9SVCBvbiBI
eXBlci1WDQo+IHdpdGggcmVsYXRlZCBndWVzdCBzdXBwb3J0IGVuYWJsZWQ6DQo+IA0KPiBbICAg
IDEuMTI3OTQxXSBodl92bWJ1czogcmVnaXN0ZXJpbmcgZHJpdmVyIGh5cGVydl9kcm0NCj4gDQo+
IFsgICAgMS4xMzI1MThdID09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IFsgICAgMS4x
MzI1MTldIFsgQlVHOiBJbnZhbGlkIHdhaXQgY29udGV4dCBdDQo+IFsgICAgMS4xMzI1MjFdIDYu
MTkuMC1yYzgrICM5IE5vdCB0YWludGVkDQo+IFsgICAgMS4xMzI1MjRdIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+IFsgICAgMS4xMzI1MjVdIHN3YXBwZXIvMC8wIGlzIHRyeWluZyB0
byBsb2NrOg0KPiBbICAgIDEuMTMyNTI2XSBmZmZmOGI5MzgxYmIzYzkwICgmY2hhbm5lbC0+c2No
ZWRfbG9jayl7Li4uLn0tezM6M30sIGF0OiB2bWJ1c19jaGFuX3NjaGVkKzB4YzQvMHgyYjANCj4g
WyAgICAxLjEzMjU0M10gb3RoZXIgaW5mbyB0aGF0IG1pZ2h0IGhlbHAgdXMgZGVidWcgdGhpczoN
Cj4gWyAgICAxLjEzMjU0NF0gY29udGV4dC17MjoyfQ0KPiBbICAgIDEuMTMyNTQ1XSAxIGxvY2sg
aGVsZCBieSBzd2FwcGVyLzAvMDoNCj4gWyAgICAxLjEzMjU0N10gICMwOiBmZmZmZmZmZmEwMTBj
NGMwIChyY3VfcmVhZF9sb2NrKXsuLi4ufS17MTozfSwgYXQ6IHZtYnVzX2NoYW5fc2NoZWQrMHgz
MS8weDJiMA0KPiBbICAgIDEuMTMyNTU3XSBzdGFjayBiYWNrdHJhY2U6DQo+IFsgICAgMS4xMzI1
NjBdIENQVTogMCBVSUQ6IDAgUElEOiAwIENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRlZCA2LjE5
LjAtcmM4KyAjOSBQUkVFTVBUX3tSVCwobGF6eSl9DQo+IFsgICAgMS4xMzI1NjVdIEhhcmR3YXJl
IG5hbWU6IE1pY3Jvc29mdCBDb3Jwb3JhdGlvbiBWaXJ0dWFsIE1hY2hpbmUvVmlydHVhbCBNYWNo
aW5lLCBCSU9TIEh5cGVyLVYgVUVGSSBSZWxlYXNlIHY0LjEgMDkvMjUvMjAyNQ0KPiBbICAgIDEu
MTMyNTY3XSBDYWxsIFRyYWNlOg0KPiBbICAgIDEuMTMyNTcwXSAgPElSUT4NCj4gWyAgICAxLjEz
MjU3M10gIGR1bXBfc3RhY2tfbHZsKzB4NmUvMHhhMA0KPiBbICAgIDEuMTMyNTgxXSAgX19sb2Nr
X2FjcXVpcmUrMHhlZTAvMHgyMWIwDQo+IFsgICAgMS4xMzI1OTJdICBsb2NrX2FjcXVpcmUrMHhk
NS8weDJkMA0KPiBbICAgIDEuMTMyNTk4XSAgPyB2bWJ1c19jaGFuX3NjaGVkKzB4YzQvMHgyYjAN
Cj4gWyAgICAxLjEzMjYwNl0gID8gbG9ja19hY3F1aXJlKzB4ZDUvMHgyZDANCj4gWyAgICAxLjEz
MjYxM10gID8gdm1idXNfY2hhbl9zY2hlZCsweDMxLzB4MmIwDQo+IFsgICAgMS4xMzI2MTldICBy
dF9zcGluX2xvY2srMHgzZi8weDFmMA0KPiBbICAgIDEuMTMyNjIzXSAgPyB2bWJ1c19jaGFuX3Nj
aGVkKzB4YzQvMHgyYjANCj4gWyAgICAxLjEzMjYyOV0gID8gdm1idXNfY2hhbl9zY2hlZCsweDMx
LzB4MmIwDQo+IFsgICAgMS4xMzI2MzRdICB2bWJ1c19jaGFuX3NjaGVkKzB4YzQvMHgyYjANCj4g
WyAgICAxLjEzMjY0MV0gIHZtYnVzX2lzcisweDJjLzB4MTUwDQo+IFsgICAgMS4xMzI2NDhdICBf
X3N5c3ZlY19oeXBlcnZfY2FsbGJhY2srMHg1Zi8weGEwDQo+IFsgICAgMS4xMzI2NTRdICBzeXN2
ZWNfaHlwZXJ2X2NhbGxiYWNrKzB4ODgvMHhiMA0KPiBbICAgIDEuMTMyNjU4XSAgPC9JUlE+DQo+
IFsgICAgMS4xMzI2NTldICA8VEFTSz4NCj4gWyAgICAxLjEzMjY2MF0gIGFzbV9zeXN2ZWNfaHlw
ZXJ2X2NhbGxiYWNrKzB4MWEvMHgyMA0KPiANCj4gQXMgY29kZSBwYXRocyB0aGF0IGhhbmRsZSB2
bWJ1cyBJUlFzIHVzZSBzbGVlcHkgbG9ja3MgdW5kZXIgUFJFRU1QVF9SVCwNCj4gdGhlIHZtYnVz
X2lzciBleGVjdXRpb24gbmVlZHMgdG8gYmUgbW92ZWQgaW50byB0aHJlYWQgY29udGV4dC4gT3Bl
bi0NCj4gY29kaW5nIHRoaXMgYWxsb3dzIHRvIHNraXAgdGhlIElQSSB0aGF0IGlycV93b3JrIHdv
dWxkIGFkZGl0aW9uYWxseQ0KPiBicmluZyBhbmQgd2hpY2ggd2UgZG8gbm90IG5lZWQsIGJlaW5n
IGFuIElSUSwgbmV2ZXIgYW4gTk1JLg0KPiANCj4gVGhpcyBhZmZlY3RzIGJvdGggeDg2IGFuZCBh
cm02NCwgdGhlcmVmb3JlIGhvb2sgaW50byB0aGUgY29tbW9uIGRyaXZlcg0KPiBsb2dpYy4NCg0K
SSB0ZXN0ZWQgdGhpcyBwYXRjaCBpbiBjb21iaW5hdGlvbiB3aXRoIHRoZSByZWxhdGVkIFNDU0kg
ZHJpdmVyIHBhdGNoLg0KVGhlIHRlc3RzIHdlcmUgZG9uZSBvbiB4ODYgd2l0aCBib3RoIFZNIGdl
bmVyYXRpb25zIHByb3ZpZGVkIGJ5IEh5cGVyLXYuDQoNCkxvY2tkZXAgd2FzIGVuYWJsZWQgYW5k
IHRoZXJlIHdlcmUgbm8gc3BsYXQgcmVwb3J0cyB3aXRoaW4gMjQgaG91cnMgb2YNCm1hc3NpdmUg
bG9hZCBwcm9kdWNlZCBieSBzdHJlc3MtbmcuDQoNCldpdGggdGhhdDoNCg0KUmV2aWV3ZWQtYnk6
IEZsb3JpYW4gQmV6ZGVrYSA8Zmxvcmlhbi5iZXpkZWthQHNpZW1lbnMuY29tPg0KVGVzdGVkLWJ5
OiBGbG9yaWFuIEJlemRla2EgPGZsb3JpYW4uYmV6ZGVrYUBzaWVtZW5zLmNvbT4NCg0KDQpTaWRl
IG5vdGU6IFdlIGRpZCBzb21lIGJhY2twb3J0cyBkb3duIHRvIDYuMSBhbHJlYWR5LCBqdXN0IGlu
IGNhc2UNCnNvbWVvbmUgaXMgaW50ZXJlc3RlZC4gV2UgcmVjb2duaXplZCBhIG1hc3NpdmUgbmV0
d29yayBwZXJmb3JtYW5jZSBkcm9wDQppbiA2LjEuIFRoZSByb290IGNhdXNlIGhhcyBiZWVuIGlk
ZW50aWZpZWQgYW5kIGlzIG5vdCByZWxhdGVkIHRvIHRoaXMNCnBhdGNoLiBJdCdzIHNpbXBseSBh
bm90aGVyIFJUIHJlZ3Jlc3Npb24gY2F1c2VkIGJ5IGEgbWlzc2luZyBzdGFibGUtcnQNCmJhY2tw
b3J0LiBVcHN0cmVhbWluZyBpbiBwcm9ncmVzcy4uLg0KDQpCZXN0IHJlZ2FyZHMsDQpGbG9yaWFu
DQo=

