Return-Path: <linux-hyperv+bounces-9166-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIBJCRzkqmkwYAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9166-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 15:26:36 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1D0222A29
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 15:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5BF8305546E
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Mar 2026 14:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC6531A046;
	Fri,  6 Mar 2026 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endava.com header.i=@endava.com header.b="zFdWvKbp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021113.outbound.protection.outlook.com [40.107.130.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CC9189BB6;
	Fri,  6 Mar 2026 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807112; cv=fail; b=YvQd/V/CdYl8Xp1BOxV8sS3tUlrYY+igbYRj265utXb7S1HyZ2WC8pi3mQUEhgENhtE1Vv8xl1BbJwmHmrPW3UucwttbyC5yNGeGZTAdFu+darU92j/6ZZg4anWLPEZa7bZ9an+cVup8Uhu79EsbxzQhoQYK/3U/CNdyXTHFmiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807112; c=relaxed/simple;
	bh=IVSMToH8b0aZPfKHKm0y+jylcX8feZFIgz+/kfFwy7A=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AGtfYZQJ+fyGZ4aKsHnK1oBiQjy8snfDoiSctRTQ7VQMS3ZQ+7U8qt/6+0NBTUfPssVbF4SfyqqrtxI6FoqqH7/FOwMD6sA0YCCMa5ntAIRHURD0bB2QKcdDyDc/wBL7e+7hjR7G6IFY8sS3KkzyeoufxMEfS8FNE3fNE0WjP0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=endava.com; spf=pass smtp.mailfrom=endava.com; dkim=pass (2048-bit key) header.d=endava.com header.i=@endava.com header.b=zFdWvKbp; arc=fail smtp.client-ip=40.107.130.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=endava.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endava.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2kPDo2NFgOOy++g+swTa5ApnFLYZAq7V9whuWDkP6CFbv9X8Cb2wyg40Lb+r75iHOH7/SajvZ3bEmJx/BTV4G87rm9dLAbyst8b5oQ9yxtACjwA0vFunZn7tBPVSnKSYSztdkP+ZG5eXwkKSPPlBeIOCJ4lDJbwVqXjJu5sGxx1BurloopLX2/oB0auxcsgTnrQqa4Q2GACr8q5nvgMjGRWl2YoPY5ISsVEpl/Rzg0KKTZcWlL/GZyyM1qIgpjtFjY+A2KRARhNtGPuhpC/4OdVxX5ICFcoIGT8pueVi/pIQd8lFj9Aipp9Q3iM3SpuOZMLqSxFd0UAXSz5NTqDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVSMToH8b0aZPfKHKm0y+jylcX8feZFIgz+/kfFwy7A=;
 b=mWyyqCUOxpcjHC4LPpa2x8AO52MWXUZJr69IVgg+PiBhHJv+0jCG6GuXX+l8aqHTd4TlRNl3UDLgFUK5VwFxfabK65XCJPBH9iEieR+s0DyjIVIxi4BWRdABRHBjKC/Z5aq8tc1lvDwIzGwKhMymXNDqgcJ4K9hH29U70Uvkgb4AkuWCq9WhwWRlKOuyEmRRHZtbsWjBJtGStViHWBrCHhmane4kCHsdHLBNYYYeJf4pvJTO4MRhADXbBMipu4wHiVjjYh/U7IJUmbHctTuuddyCKvzo0NYBUwhI33HucOpCSxy+5LZqYf+ijidW4numBPUk9hUAc/JL0dL1RNln4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=endava.com; dmarc=pass action=none header.from=endava.com;
 dkim=pass header.d=endava.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=endava.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVSMToH8b0aZPfKHKm0y+jylcX8feZFIgz+/kfFwy7A=;
 b=zFdWvKbpHsXAocaRk/wF3cxEkaUXzjNb18I4Cq6YQCvFbWagBhPZwr9Fgu+O/Cbohx54nTeXnAl2Nv+1FBSiSGwAXSY/e7/Zsa3Ck2mwvXDZbWBCNCrqIklf4b6jQBuSkfVVv6GpaBMSO8yWkMlN2KYtLIeN6qn5k4gryQnoe68rDwlV8Aoz/jSO4G94wChhBFOkKR9O0PLE+KZ1a24Ym7GyKta/zSWtzCo4WoT0mEk3k3hn7ojGWpjawClfW1sQB0+tRlX8A8Ew+Y/FgSZx4KIgispRelxpEMTRWUYorhzvPsVD47fVnC1jy2ST+gtVT7urRl1VBf4aE9e5f8Ok9w==
Received: from GV2PR06MB10444.eurprd06.prod.outlook.com (2603:10a6:150:2f3::5)
 by GV4PR06MB10345.eurprd06.prod.outlook.com (2603:10a6:150:2df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 14:25:04 +0000
Received: from GV2PR06MB10444.eurprd06.prod.outlook.com
 ([fe80::f627:5789:fa58:d866]) by GV2PR06MB10444.eurprd06.prod.outlook.com
 ([fe80::f627:5789:fa58:d866%4]) with mapi id 15.20.9678.016; Fri, 6 Mar 2026
 14:25:04 +0000
From: David Balazic <David.Balazic@endava.com>
To: "pmartincic@linux.microsoft.com" <pmartincic@linux.microsoft.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] hv_utils: Allow implicit ICTIMESYNCFLAG_SYNC
Thread-Topic: [PATCH v2] hv_utils: Allow implicit ICTIMESYNCFLAG_SYNC
Thread-Index: AQJmEqkSo0qAC77a/HyL7eBPonxqdrSOwq5A
Date: Fri, 6 Mar 2026 14:25:04 +0000
Message-ID:
 <GV2PR06MB10444A50867D11E0BE593B225827AA@GV2PR06MB10444.eurprd06.prod.outlook.com>
References: <20231127213524.52783-1-pmartincic@linux.microsoft.com>
In-Reply-To: <20231127213524.52783-1-pmartincic@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_63de93b7-8949-4e3d-a08b-0d778f7f5cab_ActionId=5c6fa833-2471-4e1c-86ca-a82fd3487be1;MSIP_Label_63de93b7-8949-4e3d-a08b-0d778f7f5cab_ContentBits=0;MSIP_Label_63de93b7-8949-4e3d-a08b-0d778f7f5cab_Enabled=true;MSIP_Label_63de93b7-8949-4e3d-a08b-0d778f7f5cab_Method=Standard;MSIP_Label_63de93b7-8949-4e3d-a08b-0d778f7f5cab_Name=63de93b7-8949-4e3d-a08b-0d778f7f5cab;MSIP_Label_63de93b7-8949-4e3d-a08b-0d778f7f5cab_SetDate=2026-03-06T14:17:44Z;MSIP_Label_63de93b7-8949-4e3d-a08b-0d778f7f5cab_SiteId=0b3fc178-b730-4e8b-9843-e81259237b77;MSIP_Label_63de93b7-8949-4e3d-a08b-0d778f7f5cab_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=endava.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR06MB10444:EE_|GV4PR06MB10345:EE_
x-ms-office365-filtering-correlation-id: d4529156-f965-4990-6ca4-08de7b8c28dc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|7053199007;
x-microsoft-antispam-message-info:
 G+9y4mnVREorlcjCn0+Gj9F1fzA/74FJfI0uODl/5ZUjeBQj2WwBtfsr2CJixdsqpRdvadzDIDZQcBwvmkGBdzbVZMGNo5St4kDYVFUkkahKyUeP21d2JwU0ij0+QuxB5e0pqv99k47u2DPcf5kgTTOJ00j1me8b1ET1VBcnHNzSPfpNGjFU3aiokheTKv/AFWEXWhLGL2kjYrocRHLECwlOgNjOUBoVChgiuRfQtO4xMljp2R5OKfSWvKhSnAkIXLwEba9KwVXJ5lEV1MRFfpa52kAXMx7dIjccY3VKRCA3h3JMV8wxOEL+0JzmqgR5uNBlnR/77W3WHVjLcOHXeMoe622ac8XkrC6NqvtRoQIzRtt+PGpMf/XfsCPi/kTc+A/MBAcepqR4x8sSCqwV0ZIoAEflvCilEDddyEcjdnFlrDa0ktYi3JtERkQuicDz7oWQk/2+jfZkdR+nCaRFGOxSzK0lmJmyM6TRcRq84P9++W+RO4sAZSNw2INc4CTdzDGct7cfWbwtU/r+/ChUzNosWSnpL2Im7RDFfVXIA2ipN7fIQuEAOuLtD6qsG43LeysdKbT4spZc37A5NImQvWouuiu8tzH5FUUMp9SHOS0XpDmvjkVeMYZ5uJ1Z773HLuAgiURUJTPc36GuJcgo1JuHABgR9T01XTdLLc8tXbZw6ZJ9tsl7AawMml+tur8/SWhsMn76NlKROx+RH4tHBf2TiDf2/P+o3Lv9DVxmzEwQgMicuDuN11xZvxjmQxRs+f5bTJqDvav9vXV6cF+3rklNCgbbwM8BLPdV49ZmwBw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR06MB10444.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UmtmWE5kTGFSaS9FRWZuNmpCSWo5QzRURW04VTFIMlBPcVNGbWVvOTlZcVNu?=
 =?utf-8?B?alY4TEVDZTVwWVlUdjFOWVVCb1hJbU16SlovL3lMZk4wdEs1Mk1yNmNYa0gy?=
 =?utf-8?B?MGdGcUVoVURSQUpLQTJxMTNxUjFJV2xSWW5TbWlOQmptYlFvUkhLTzQ1Ukc1?=
 =?utf-8?B?enZwZm0xeGtJNmhnQUtrYktXZU10aUdrZUZscFcza2ZhRHpFWTJTWEJpalJZ?=
 =?utf-8?B?U2s2RFBPb0pybjdLNks2elpNOHl0N0hSQzMyVkZUL25ieWJsY0MvVzUrV2JM?=
 =?utf-8?B?dUtXQ3VhMjcrcnlIMnRoQjUrM2NsNTB5S3dyUmt0YVg1MXRUbWhBN2d6djlG?=
 =?utf-8?B?NFR6SW9NSlk0a2tvajF6UUtuUis0M3hiWjJXVHZWSHpma3pDUzVqN2l1b05G?=
 =?utf-8?B?N0ozVG1RWmNrOTVKK0k1eUJieS8wMVc2K2FJY3dUSGdHb2gySnFNNGhCeTl5?=
 =?utf-8?B?YkhVbk81c2JzMmR1SjIvSHY4L2thWHphWUgrTG1iTCswc0x5b3IwYStTZmEy?=
 =?utf-8?B?M3pueGZPWUVBVFRubTViWTBXRTR3aVUyQUM2R201TjA2NWdnOURCd1czREYx?=
 =?utf-8?B?dU9MNkZVMGZvYlhHYjBDYXh0NUlHUDJCYVBMWUxEMVVZQWdBZktYTXB2NXFh?=
 =?utf-8?B?cytnelVxbE9RbEc0dzFRcEhRcEdZWDFsZmo4QVFhd0hHTTVjY0hidG9LZUU2?=
 =?utf-8?B?YmJueTJIWTRJTkFyMlFkSzlNUVVYMW5iR3RyYlhaQzBXcHZNV3lzQTljVG50?=
 =?utf-8?B?VUdmZUNTY1U5OHRMdTZrNlQyWlFLUVRTZFdkZHhIckRReTRlWmlQSjRJV2pk?=
 =?utf-8?B?dGRoc0hKLzBhSnNsZHJNYmMyQ20vU1phM0VrN0JVUlRISFJsWEd3ZW9hSVpI?=
 =?utf-8?B?OUxtM1VQZjhOSFpYUDNDeUxaSjBiTmhhVGc0MUliUzF3MzJKU0tEczVrYTY4?=
 =?utf-8?B?NlBMUTNyZCtuSXNMU3pYK0d5ejFvWU4vb2cyTnI0MFNoZ09CWitkMUhjYllm?=
 =?utf-8?B?SG50UUlwa2ZMRlVoS2M5RXpVMUVuQm9PWmp5ZGljZFRmZ0s5d0p2WU1XRTg4?=
 =?utf-8?B?YVJDcXBmT2JPbDhlaFlDVXB3d2VyRi9aS0paM3pOUHd6eEMyUmpLMno5NDQ0?=
 =?utf-8?B?aHV3aVFocFczTGxnNy9sRVBpSkFDSExVQks1Rjd6UjZiSkU5TVNwZ3dNQnZD?=
 =?utf-8?B?QStwU3JlL2h6aG1hZ2FnYUNGQkRiNHNlWlNTbUpRTVV1emhPcVlJQTBiNHVG?=
 =?utf-8?B?WStYRFJ6ZlM2elBFNlNlUDcyWkk3cXVBSXUvMWI0UG1qVmxjR3NBTzBZWE1w?=
 =?utf-8?B?SDRYT29JVTBEWmpUamxsQW9xWStLcDh5R0FpK0M5aHltQnkvbnhyZXlzbndm?=
 =?utf-8?B?Ull6UFBlVGdSWHdCZ3ZJdGxXU25Dd0Nmc3JqMWN1YTdnZGhNY0lpSVdsNHBB?=
 =?utf-8?B?L0dsOWNFVk5iTDlkRzVLNTFLaGRHdTRtY3pTbXhoSE5yZjVadVVvZGRxY0ln?=
 =?utf-8?B?REcrbzdRTzFHTHZVMkVJa3cxeEI3YkQrL1Q4RUlQMStLUG5KeG9pOGh3Vkhi?=
 =?utf-8?B?M0J3Y0k4NStTcEVRbnYxMEF3dFlPYnQ5aEVwbFZpcDVpWDEzVEpVRWtoV3Nw?=
 =?utf-8?B?cnIzbHdydmQwUXhmYWpsbW1paW9zM0JLQ0NVTk1QWWlpa0tmbS9CdU1ISHpL?=
 =?utf-8?B?eitsWUJzUXl2Rndqc1Rub2RnRDU2YlFBbVhJaEdzUm9KU2tjREw4L2FNa1pI?=
 =?utf-8?B?UTJ0VTREUjBjZ3UvbkcrUm1zcW5lQm9sY2M3citoaExnOHlCVXhIblROSE5L?=
 =?utf-8?B?Um5RRlVxdSt4M0NRbG9EdWt2cVhPeGM3NUxnVHVmSDYrSjQyQ0s3M3BPeWZH?=
 =?utf-8?B?MmZraG5yQUFpdGdDY2Vabi9POW4yNy9HK28vTkZNQ1haNkV6dFBmcXQzQXdF?=
 =?utf-8?B?ZlNVVjJscnpLbjZScDBjamk2QlVNSmpZWkxUdjVEZi9EaDV6dEg4OFZieHlV?=
 =?utf-8?B?cFY5NjNRQkR0aGU2Tk1XS1VTVys0QURsR1NQZ3dPcXR2Tm83S3EvbWVHTTI4?=
 =?utf-8?B?R0lBWHRKZ1ppTGlmbTNXbzZDb202ZEZxdzQxT255ME14c1VndVRnTWNuaFdZ?=
 =?utf-8?B?NHQ4bHpZQ29vRFRseHhDSTYzemxOMHBjaHI0L1NjMmc4UzNxQnJ5SGZhbTV0?=
 =?utf-8?B?RTQzUE50Q3lyWWovOG80TVRkS1lYRzljTnZ0TiswRzJ0MGczMWVKeDdjMmdX?=
 =?utf-8?B?bStpd3U3UytKcG5TK0lCVEV2VFRENEp2TitPVWZ3Skk5NTVzY1V0akFEbUkz?=
 =?utf-8?B?TXhvKzNFcGd5L1pKOHI4b0cyOEQ1NnU3R2ViTWl6TlpBMG5BbWRPUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: endava.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR06MB10444.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4529156-f965-4990-6ca4-08de7b8c28dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 14:25:04.3756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b3fc178-b730-4e8b-9843-e81259237b77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R864DDQnEtWbuX8EM2h2O+lDWKPHWtQBnAqbXmeSlH+V9IXfCDbfNrzO5COXDs1qpwpqmO8a0Q6DLhoGfInrIokr5vF9XT2JUjswjQkI7CA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR06MB10345
X-Rspamd-Queue-Id: AA1D0222A29
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[endava.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[endava.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9166-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[endava.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[David.Balazic@endava.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

T24gTW9uLCBOb3YgMjcsIDIwMjMgYXQgMDE6MzU6MjRQTSAtMDgwMCwgcG1hcnRpbmNpY0BsaW51
eC5taWNyb3NvZnQuY29tIHdyb3RlOg0KDQo+IEZyb206IFBldGVyIE1hcnRpbmNpYyA8cG1hcnRp
bmNpY0BtaWNyb3NvZnQuY29tPg0KPg0KPiBIeXBlci1WIGhvc3RzIGNhbiBvbWl0IHRoZSBfU1lO
QyBmbGFnIHRvIGR1ZSBhIGJ1ZyBvbiByZXN1bWUgZnJvbSBtb2Rlcm4NCj4gc3VzcGVuZC4gSW4g
c3VjaCBhIGNhc2UsIHRoZSBndWVzdCBtYXkgZmFpbCB0byB1cGRhdGUgaXRzIHRpbWUtb2YtZGF5
IHRvDQo+IGFjY291bnQgZm9yIHRoZSBwZXJpb2Qgd2hlbiBpdCB3YXMgc3VzcGVuZGVkLCBhbmQg
Y291bGQgcHJvY2VlZCB3aXRoIGENCj4gc2lnbmlmaWNhbnRseSB3cm9uZyB0aW1lLW9mLWRheS4g
SW4gc3VjaCBhIGNhc2Ugd2hlbiB0aGUgZ3Vlc3QgaXMgc2lnbmlmaWNhbnRseQ0KPiBiZWhpbmQs
IGZpeCBpdCBieSB0cmVhdGluZyBhIF9TQU1QTEUgdGhlIHNhbWUgYXMgaWYgX1NZTkMgd2FzIHJl
Y2VpdmVkIHNvIHRoYXQNCj4gdGhlIGd1ZXN0IHRpbWUtb2YtZGF5IGlzIHVwZGF0ZWQuDQo+DQo+
IFRoaXMgaXMgaGlkZGVuIGJlaGluZCBwYXJhbSBodl91dGlscy50aW1lc3luY19pbXBsaWNpdC4N
Cj4NCj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgTWFydGluY2ljIDxwbWFydGluY2ljQG1pY3Jvc29m
dC5jb20+DQoNCkhpIQ0KDQpBcyBQZXRlcnMgbWFpbCBkb2VzIG5vdCBzZWVtIHRvIGV4aXN0cyBh
bnkgbW9yZSwgSSdsbCBhc2sgaGVyZSAoTEtNTCBhbmQgTEhWKSwgaWYgYWxsIHJpZ2h0Og0KDQpJ
cyB0aGVyZSBhbnkgbmV3cyAgYWJvdXQgdGhpcyBidWcgb24gSHlwZXItViBob3N0cz8NCklmIHRo
aXMgaXMgYWN0dWFsbHkgYSBIeXBlci1WIChob3N0KSBidWcsIHdhcyBpdCBldmVyIGFkZHJlc3Nl
ZCBhbmQgZml4ZWQ/DQoNCkkgZW5jb3VudGVyIHRoaXMgYnVnIHdoZW4gdXNpbmcgV2luZG93cyAx
MSBFbnRlcnByaXNlICgyNUgyKSBob3N0IGFuZCBPcmFjbGUgTGludXggOCBhbmQgOSBhcyBndWVz
dHMuDQpUaGV5IHVzZSBhbiBvbGRlciBrZXJuZWwsIHNvIEkgY2FuJ3QgdXNlIHRoaXMgcGFyYW1l
dGVyIHRvIGZpeCBpdC4NCg0KV2luZG93cyBndWVzdHMgZG8gbm90IHNlZW0gdG8gYmUgYWZmZWN0
ZWQgYnkgaXQsIGluIG15IGV4cGVyaWVuY2UuDQoNCkZlZWwgZnJlZSB0byByZXBseSBvZmYgbGlz
dCwgYXMgaXQgaXMgbm90IHJlYWxseSBvbiB0b3BpYy4NCg0KUmVnYXJkcywNCkRhdmlkIEJhbGHF
vmljDQoNCg0KDQpUaGUgaW5mb3JtYXRpb24gaW4gdGhpcyBlbWFpbCBpcyBjb25maWRlbnRpYWwg
YW5kIG1heSBiZSBsZWdhbGx5IHByaXZpbGVnZWQuIEl0IGlzIGludGVuZGVkIHNvbGVseSBmb3Ig
dGhlIGFkZHJlc3NlZS4gQW55IG9waW5pb25zIGV4cHJlc3NlZCBhcmUgbWluZSBhbmQgZG8gbm90
IG5lY2Vzc2FyaWx5IHJlcHJlc2VudCB0aGUgb3BpbmlvbnMgb2YgdGhlIENvbXBhbnkuIEVtYWls
cyBhcmUgc3VzY2VwdGlibGUgdG8gaW50ZXJmZXJlbmNlLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50
ZW5kZWQgcmVjaXBpZW50LCBhbnkgZGlzY2xvc3VyZSwgY29weWluZywgZGlzdHJpYnV0aW9uIG9y
IGFueSBhY3Rpb24gdGFrZW4gb3Igb21pdHRlZCB0byBiZSB0YWtlbiBpbiByZWxpYW5jZSBvbiBp
dCwgaXMgc3RyaWN0bHkgcHJvaGliaXRlZCBhbmQgbWF5IGJlIHVubGF3ZnVsLiBJZiB5b3UgaGF2
ZSByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgaW4gZXJyb3IsIGRvIG5vdCBvcGVuIGFueSBhdHRhY2ht
ZW50cyBidXQgcGxlYXNlIG5vdGlmeSB0aGUgRW5kYXZhIFNlcnZpY2UgRGVzayBvbiAoKzQ0ICgw
KTg3MCA0MjMgMDE4NyksIGFuZCBkZWxldGUgdGhpcyBtZXNzYWdlIGZyb20geW91ciBzeXN0ZW0u
IFRoZSBzZW5kZXIgYWNjZXB0cyBubyByZXNwb25zaWJpbGl0eSBmb3IgaW5mb3JtYXRpb24sIGVy
cm9ycyBvciBvbWlzc2lvbnMgaW4gdGhpcyBlbWFpbCwgb3IgZm9yIGl0cyB1c2Ugb3IgbWlzdXNl
LCBvciBmb3IgYW55IGFjdCBjb21taXR0ZWQgb3Igb21pdHRlZCBpbiBjb25uZWN0aW9uIHdpdGgg
dGhpcyBjb21tdW5pY2F0aW9uLiBJZiBpbiBkb3VidCwgcGxlYXNlIHZlcmlmeSB0aGUgYXV0aGVu
dGljaXR5IG9mIHRoZSBjb250ZW50cyB3aXRoIHRoZSBzZW5kZXIuIFBsZWFzZSByZWx5IG9uIHlv
dXIgb3duIHZpcnVzIGNoZWNrZXJzIGFzIG5vIHJlc3BvbnNpYmlsaXR5IGlzIHRha2VuIGJ5IHRo
ZSBzZW5kZXIgZm9yIGFueSBkYW1hZ2UgcmlzaW5nIG91dCBvZiBhbnkgYnVnIG9yIHZpcnVzIGlu
ZmVjdGlvbi4NCg0KRW5kYXZhIHBsYyBpcyBhIGNvbXBhbnkgcmVnaXN0ZXJlZCBpbiBFbmdsYW5k
IHVuZGVyIGNvbXBhbnkgbnVtYmVyIDU3MjI2Njkgd2hvc2UgcmVnaXN0ZXJlZCBvZmZpY2UgaXMg
YXQgMTI1IE9sZCBCcm9hZCBTdHJlZXQsIExvbmRvbiwgRUMyTiAxQVIsIFVuaXRlZCBLaW5nZG9t
LiBFbmRhdmEgcGxjIGlzIHRoZSBFbmRhdmEgZ3JvdXAgaG9sZGluZyBjb21wYW55IGFuZCBkb2Vz
IG5vdCBwcm92aWRlIGFueSBzZXJ2aWNlcyB0byBjbGllbnRzLiBFYWNoIG9mIEVuZGF2YSBwbGMg
YW5kIGl0cyBzdWJzaWRpYXJpZXMgaXMgYSBzZXBhcmF0ZSBsZWdhbCBlbnRpdHkgYW5kIGhhcyBu
byBsaWFiaWxpdHkgZm9yIGFub3RoZXIgc3VjaCBlbnRpdHkncyBhY3RzIG9yIG9taXNzaW9ucy4N
Cg==

