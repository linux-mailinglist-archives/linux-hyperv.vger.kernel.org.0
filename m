Return-Path: <linux-hyperv+bounces-2742-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4391C94ACD0
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 17:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47291F28A8C
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 15:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C288684A31;
	Wed,  7 Aug 2024 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FEcU7Mie"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020141.outbound.protection.outlook.com [52.101.61.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A02A8172A;
	Wed,  7 Aug 2024 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044357; cv=fail; b=r+EhZLaNMpyX/2o6sBfXeCcSp8yIMvl+XEsybW0TFGPiE4nIdcmW4RqzW2bU23uWwcoJCCve1u225XsGrmeP50ZNPVk+BzrZ+ahSdriqlFmitkQMcrgtVRoaPu+WiisOCnHp7/sI0zvgUu5dMG1gneAVVngdDjYbHEmhmqrouVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044357; c=relaxed/simple;
	bh=YE/3sxgg6+nALJQBKxu8/vOh7pTTkk9wuIJg0EZoP+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qr9RPJBjAmwr17WVOfnUILGKdVpNI0O+MGCAELS3jcbsPgt634QbO25CEJYerOHxcnWrTfkD/sgoBLZ2R1cb7m3FyCuYCFnUOpkFbinTwZLN58UklQ+xPIrAAbeY3c2nyhkl3DpTE53p/K+JaVc2S2mQmMQe27LObrsPQ/WGxxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=FEcU7Mie; arc=fail smtp.client-ip=52.101.61.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSu9pncav2qD/9r/NEq47751coVlMJksehc6fcZ2FptAXhBptZCdkJeJSYB5A9wrFQAks+KT3tIuNB7NCyfGXkEdmCxgamdYlOn498LWCjBQC1f4S86rdk4J/JxppcaSDz7b2A12jyGwxnNCa0V3XzFsPQ0iJIrde/MPU4NpWJ0i4PsjUTTDjQmTyjTFP19A0/5R/h84oVz3TenFMLlRYofGCFGdyYyGUK9jhGAD/NubZh0zf0R7zO1WOn54NdKQaIugLV1nwQAz3N8JWjk4ma49Dfno1aYONg9O/0W8RF+zgBSD7hkqksfz2Vn288jVCZQ1QbuwQPEp/egexdmK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YE/3sxgg6+nALJQBKxu8/vOh7pTTkk9wuIJg0EZoP+E=;
 b=SXIRDZ0uKQVQgYVa0Uq8Z4a2wgmJ9JPk+aVetnmA6Se4NL1QnTG7RY/cWAh/1tpyUllGeuVc6IZLECC3baoghf7dfmjSKmS4yUWt6BsnW2X5hFozDpcNSczkN+mEZK/CLe1FbKEQHR55xLRahUVUarObP/tDwPn176TLioCf5FN49D/OOq0phOaQtzP5xA9AJGsqtEjZhZ3LHVvM8kinfds6zLhWVnYpFQr6Uu9JaQR0oBnWW9UUGjRLMUiX1bgMuxwSnnt1AXLtlcNGdVQ6bs7mVRcl3t1BT8y27ro/sJ8aZCKuXe3s1A+FxyjRk2Gkb3Mi8IasmOfESR7MXM9zYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YE/3sxgg6+nALJQBKxu8/vOh7pTTkk9wuIJg0EZoP+E=;
 b=FEcU7MiessNvPPF6ax6BzNWjrkDYrQ7WwqDLJc5+XmMyDIFWSrWS4BKXC37V2KFz+k55MnIg6T7lTeQOCrfn3reRUVTvJklSSBVF6efpZ5H5IQQbaefyEIkhAw7GWFpCVdKy9IW6CuRDIPGQeR8arplgT+FqlUP+8UJ7dpx5jog=
Received: from DM4PR21MB3536.namprd21.prod.outlook.com (2603:10b6:8:a4::5) by
 CH2PR21MB1448.namprd21.prod.outlook.com (2603:10b6:610:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.8; Wed, 7 Aug 2024 15:25:53 +0000
Received: from DM4PR21MB3536.namprd21.prod.outlook.com
 ([fe80::d1ee:5aa2:44d0:dee3]) by DM4PR21MB3536.namprd21.prod.outlook.com
 ([fe80::d1ee:5aa2:44d0:dee3%4]) with mapi id 15.20.7875.002; Wed, 7 Aug 2024
 15:25:53 +0000
From: Long Li <longli@microsoft.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>, Simon
 Horman <horms@kernel.org>, Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, Erick Archer
	<erick.archer@outlook.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net] net: mana: Fix doorbell out of order violation and
 avoid unnecessary doorbell rings
Thread-Topic: [PATCH net] net: mana: Fix doorbell out of order violation and
 avoid unnecessary doorbell rings
Thread-Index: AQHa55CcC/tm6VEi9kG4vyXoERrkubIaY/qAgAGJAJA=
Date: Wed, 7 Aug 2024 15:25:53 +0000
Message-ID:
 <DM4PR21MB35365A30785F40EA4E2B36F7CEB82@DM4PR21MB3536.namprd21.prod.outlook.com>
References: <1722901088-12115-1-git-send-email-longli@linuxonhyperv.com>
 <481149de-1212-4a43-a7cb-52351a0e29ad@linux.dev>
In-Reply-To: <481149de-1212-4a43-a7cb-52351a0e29ad@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=982ab5d8-b4c4-420b-891d-3e538cbfaf6a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-07T15:25:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3536:EE_|CH2PR21MB1448:EE_
x-ms-office365-filtering-correlation-id: b5b130d1-3b07-4f8c-ccb5-08dcb6f539da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?TmNMemNkUTU4cm9ZS0g1N3NlaG9sU3R6ZkJ1MW5STkJxMHQ2TkZRTEoyZHdv?=
 =?utf-8?B?bExCa0xwSktNRExnOWtYWWlTVEkvbHNwNGVCL2JkNUd2N20yWVRBRWhXOU5S?=
 =?utf-8?B?RzMzbUFQQTF5cTdlSUxESGV0dW1IZlZqYUNUcnhId2dVSDExWlR4bnlUOXY4?=
 =?utf-8?B?VnFzT0pRd3VVT3NWSzAvVVhBWjllSGlUdEFCeGFiVS93UGw4NEVEQlIrMCtS?=
 =?utf-8?B?enoyVk8xK1YzN1ZNOStuVzdONEhPZ296cVZiczdhMjEwN1V6cGpFWVEzTHh3?=
 =?utf-8?B?VjFaNzhyMlVIUnVPdGVUVEVNNUk1QUNheCs0dE9kY0ltb3EwTXVPamF5dW0z?=
 =?utf-8?B?dnRkajJwZW1UNkt4dzVtYnZvQS94OVgyZDZlbXBqZGxVRVV5VXpHdWxWUnhC?=
 =?utf-8?B?SCtoVVZ3NHlqeDhYbEVPRExSSG1VdWRScGxVZ1dTaWlGWHpYcVpvbk5RNjAv?=
 =?utf-8?B?R2djcU9hSm9Jem8yMFVnb2ZPZkJ0SjVGNXY5YksrRjhlSEVrNjRBbmFLb081?=
 =?utf-8?B?Y1JKTlFVRklYZnhiR2pMRHFUVTF0eWFHNFp1RkRnN2FoOXJQd0piazlmK3pj?=
 =?utf-8?B?ZGdtSWZvZitRN0Z3ZFRQeEt1WDFxS1d5d2NSdGpKcEJhYmh2MjJIdjZUYm8x?=
 =?utf-8?B?Q0dBYWNxbzRpb0hrMWlEV0hUVjdGSXZodkp2ckUvd2VoaVlNUXY0bHVFWG92?=
 =?utf-8?B?UkgwNENEYzEwWHRqbms4YXZsTHVDZ3RJcDNhay8yUG56bmltTDNFTzJqUDV5?=
 =?utf-8?B?MDNKcS9MY1pwU0hPdE9Xb1h6Ky9EK1B3ZFZGeUk2TXZLOXFjMEtVQUNUM05F?=
 =?utf-8?B?Z29TK0FBVzNjMklsMEo3WDhPeWYwRFpERWNneVNrTDhZLytqVmhlRTNXdWda?=
 =?utf-8?B?U0lBMDZ6eTd0Y2k4OEs5YXUyaDNSc0EzazZpSU9EM0dUODlId3I0UVhLU0Z3?=
 =?utf-8?B?eUppYTNpKzVUYnRsVDJ4MUZCTjFPMEpsS1UvWlRPb0JHOWJ0Ni8yK2dtT0FY?=
 =?utf-8?B?Qnc4dzEySmc1bS9SZ2ZpMXlrdGk5RnhtSXB1WU95Ym1CeHRzcTc5WlNOSU1P?=
 =?utf-8?B?c2g4a0puWnZiSEIrREZTcmRuN0V5dXFqVjhyNjZYcDlpelV6ZXZkZ0Jvalk0?=
 =?utf-8?B?VnBaMHVHWVBsVjZLWTZJWStEZ284bytITjFURitWc3Z3YUFLVFRHcHpTdFkv?=
 =?utf-8?B?cTFuQlRhMU1odUlLUFM4US9tUmRLNHhCeVJRWk5rRUNxNGNlTS9lZTIzUFpL?=
 =?utf-8?B?MGIzMWJjSzd0THMra00zOXRnWjJvMk1KY0ZlZUZGb0VENXl6dW51RVNPWHBO?=
 =?utf-8?B?dHVORmVpYldDVk50WVdUekhhcDJGOGw1TXNRWk9zR0FaeVZuaURtRzJaaUxo?=
 =?utf-8?B?c2J2UjFqbjB0UWtqWlNMQmpjQTY2c2FnWnBPOVU2MWlwM1k2ZXdQem9mTVRx?=
 =?utf-8?B?eFZFNE9iT3NEQ1VpeldJNGR4THVWVVExcGg2L25BbmxnNlF3YmVjRkFEVFNa?=
 =?utf-8?B?K1ZicW5RTXErSkcvZ1hGQ3pOcEFLOHJHZkRva2tqNlZoRXJRRHUyOWNaQkFm?=
 =?utf-8?B?SWd5MWJiMm0yQklUaXI5TkNZSzRIcHdVMUdEYXZLcnZ0SHNmYWs4b3R4ZGVn?=
 =?utf-8?B?VkVXSDJQSCtXMEFDZXV2clVsRlVKN3g1WjNBenBTczJtaTV0QjdpL0JsOFgv?=
 =?utf-8?B?eWdKMVcwWHFSdEs4NEdNaGhpbERGQ2RFUGFobTZ6dS84VGFiTENMS2cvTVM2?=
 =?utf-8?B?SGV4ZjBlUFhBdHRnR09PcVowOTR6MEVXU2E1S21pRE16cHppNzZpSWdrVHFC?=
 =?utf-8?B?NG4zV3h2RGFWY0djUTY0aCtWL25oYWdublFleWNjQmJhc3huclQ2WW5LVjh2?=
 =?utf-8?B?a2dDL2V0VERJMlhUcFpBTlppcjJhVE81QXV6aFprVDFIbEZSTkNoaDRFZFFN?=
 =?utf-8?Q?dqXssQHlC98=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3536.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFdYMjN0UlFSbTN3aUYyR3dIMTlpZXJQbWtyc3I3UTZSZWl1UldFR29pL1hO?=
 =?utf-8?B?OS8zaUMzVUFlMkIxOFVjWWx5RlFtbmZET1J6c3Z0eGlZSS8vaFo1V1Fla3FO?=
 =?utf-8?B?R1VWcTBGR1N2OEZXa0JuNmpCNmU1VDFINEdnNkMrL2owRWkzMkpHQmhFaEZH?=
 =?utf-8?B?NE1lUlpENlNQc3RhUU5QZ1IwTWtjVmhPNkRHRzVEUlhjbzBJWnhKNWorelcw?=
 =?utf-8?B?OUR5dkQwSFEvd0Y0U3BUN3pZSFdCWUZyOCtmTGlrb1V3d29SeURKdjFoNW5T?=
 =?utf-8?B?SVZiMjVGaFJycFhFanczNmJUZ0tPbW02akp3VXZldHVvanBTREFLc1MxYlZQ?=
 =?utf-8?B?cGJkZ3hXeGFFNkpMaHczLzFaVlN1d3ZpakU5d05rNWdwYUloZ2VXb3NWa0l6?=
 =?utf-8?B?WWRqNi9lY1l5SHAycWlUamhFMkZWQXVDbVlRcnpsNE5Dc0h0VCtEb3lBMUVW?=
 =?utf-8?B?bm1GR1ZmY1FyeFBhelRVdFFnSDRUM0NEZWJHTHVCWE82b3Y1czVOcWFBYkVF?=
 =?utf-8?B?aW0zMzhZUzJtazFWVzBoMUdLeThDemxTSms3L3NOTW43MjhCTDlOejRraDVk?=
 =?utf-8?B?NHRJUFNWWXVXczVNR29Oak9weTdHSXp5ZG01UWxmSWpqZmI0MmkxdVJ2V1Bi?=
 =?utf-8?B?QUoycmYrQnJtM1BxVHRGNnRaaDlSMDczR0RiV0pDanJST3F6dE92eHVaVkJL?=
 =?utf-8?B?SVNPK2dGUk9TdktOcGJvTGZrbkdYMTljZjBDOUs5L0l2QytDV2VjUEJXTjVM?=
 =?utf-8?B?U3play9TMWdOQ0J4OTlkWTZ1cExFL0ltQjM3K2dEUnFCeFFzUzk2MGNiQStX?=
 =?utf-8?B?ejdLNjdhMEp4SDNVNEJ2aGJoak9BeFBZNHpQZk5RL2w5c0tmMWFKQkQ0SlBp?=
 =?utf-8?B?K0kwOUxqQW96Qy9FUHRnUGNaQWVlUGVNZDJweVg3Y2E2K2xGOEVSNWNrMmk2?=
 =?utf-8?B?SmFLR3c3ZldKVkxHa0o2NHd2Z1cyNmZxMzc4WFkyVG9BcmFnZDVDdzFZRlJW?=
 =?utf-8?B?SVdkY1BDYnN2bWw1cjQyeVdxTkxaVnBRK3Q3RitTVTE0dWV4TTJqOERrMC9P?=
 =?utf-8?B?WnlnT2Fpd1NlNEZGUDVmSzRWamRYQTE1YnZuZ2g0UVNsSUlLSEU0VFNYeHEw?=
 =?utf-8?B?TndmZy8xbm5PdHdZdE9QNVFvSThsZTV6N3pOZ0RZSFRXSGJIM1Uxb2JMWXpz?=
 =?utf-8?B?b0s4WjZ0N2FpQkM2cTFtNkRHT2J3UTVXdmV5ZXJ4RjlIa3p5N2dCYm5DLzVE?=
 =?utf-8?B?RWJUVFI0eG1hbTZ0a3ZVQSszWEVGUmtYVlJWMnJhbW9PMWFjOUxpellUdUdh?=
 =?utf-8?B?Y0dOSFBoRmhBVURXVk9BK3ZYMGlHNFBPWkY0YlZYdlo5eC83TVhZUVJhMXpo?=
 =?utf-8?B?VHZ0VFR6WjRqMjRxWkVaU1pjNXJZV2tPaXBrZHYwRENjOXNKTkhkTGlPcUJh?=
 =?utf-8?B?akZ4aWtiODdwTmxrU1Y3UmxVeVp3Z1J0Z092bU9xMTh5V25YNW41dXJ0SEV3?=
 =?utf-8?B?UDc4ekc0Ym9wcHQvc2hycW84QjJsdFhkQVVWMXlTdDdMYmlXVXpHLzkzR01o?=
 =?utf-8?B?dGNlTi9hcFpDeUwvelNhYS90RE9HYTd1ODZvTG03VEFWcllkTXBZSGJOVG1J?=
 =?utf-8?B?RG94VjlxQlBmbjZhSzg4ZjFlNzh2MmNTalg1ckNRWHJubncvdFY3TVNUVGVz?=
 =?utf-8?B?Vk53WTlsaXp6NGRjdGNMNU0zS0U3dUg4Tm1qTU1oYWhVOFpISlBqSWpZcG40?=
 =?utf-8?B?cXV3TkZTcnorY05xbmNCR2MreXZZYjhyU0plczVDWVNZcWxjYVF5S1REeXcx?=
 =?utf-8?B?ZXFnVkUwNndyWW5icnBQRWNQZTdDU1pmRkZJMGpKMk9Qdkh4bGZQUVBNY1lw?=
 =?utf-8?B?aVhpVGUvTnVZeEo5SisrenFvNDJtZ1JuNHdwNjFheWZCT09EeUtIcjdKZlhL?=
 =?utf-8?B?TXpQcFB2U3cxY0h4cUp0L1JSOEFudHFqM293M29VR0xoM2NzdnRwNXZrUU93?=
 =?utf-8?B?RnZSMXJ0OUR0SWZCUmtZRGxseE9tTlNDNXFtZ1Rpd1R6VndWeXRDMUU0ZjFR?=
 =?utf-8?B?L2t6T1BjQjQ1Z1czbGxqSGp5TnF5ZjU4MzVkaFViaUZpVUlwU3ZTaGZIS3h1?=
 =?utf-8?Q?pmggdtnPfiSfBNLwFw9WywSvh?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3536.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b130d1-3b07-4f8c-ccb5-08dcb6f539da
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 15:25:53.3610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X6ipF/YuTrTel0CmANYHhg5flUBifNGdjAqMvHgHKv1gET6zR/N6fNXkLBsZKVLWImZMCIJ/LwFryNcCc6ixlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1448

PiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldF0gbmV0OiBtYW5hOiBGaXggZG9vcmJlbGwgb3V0IG9m
IG9yZGVyIHZpb2xhdGlvbiBhbmQgYXZvaWQNCj4gdW5uZWNlc3NhcnkgZG9vcmJlbGwgcmluZ3MN
Cj4gDQo+IOWcqCAyMDI0LzgvNiA3OjM4LCBsb25nbGlAbGludXhvbmh5cGVydi5jb20g5YaZ6YGT
Og0KPiA+IEZyb206IExvbmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQuY29tPg0KPiA+DQo+ID4gQWZ0
ZXIgbmFwaV9jb21wbGV0ZV9kb25lKCkgaXMgY2FsbGVkLCBhbm90aGVyIE5BUEkgbWF5IGJlIHJ1
bm5pbmcgb24NCj4gPiBhbm90aGVyIENQVSBhbmQgcmluZyB0aGUgZG9vcmJlbGwgYmVmb3JlIHRo
ZSBjdXJyZW50IENQVSBkb2VzLiBXaGVuDQo+ID4gY29tYmluZWQgd2l0aCB1bm5lY2Vzc2FyeSBy
aW5ncyB3aGVuIHRoZXJlIGlzIG5vIG5lZWQgdG8gQVJNIHRoZSBDUSwNCj4gPiB0aGlzIHRyaWdn
ZXJzIGVycm9yIHBhdGhzIGluIHRoZSBoYXJkd2FyZS4NCj4gPg0KPiA+IEZpeCB0aGlzIGJ5IGFs
d2F5cyByaW5nIHRoZSBkb29yYmVsbCBpbiBzZXF1ZW5jZSBhbmQgYXZvaWQgdW5uZWNlc3NhcnkN
Cj4gPiByaW5ncy4NCj4gDQo+IFRyaXZpYWwgcHJvYmxlbV5fXg0KPiANCj4gcy9yaW5nL3Jpbmdp
bmcgPw0KPiANCj4gWmh1IFlhbmp1bg0KDQpJJ20gc2VuZGluZyB2MiB0byBmaXggdGhpcy4NCg0K
VGhhbmtzLA0KDQpMb25nDQoNCg0KDQo=

