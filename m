Return-Path: <linux-hyperv+bounces-10694-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPwNAm/j/GmGVAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10694-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 21:09:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAF14EDBD8
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 21:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D868303B17F
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2026 19:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96FA4611CC;
	Thu,  7 May 2026 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dldSukbZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010018.outbound.protection.outlook.com [52.103.23.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446954657DC;
	Thu,  7 May 2026 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778180958; cv=fail; b=bKOpaTgupCv6g6hev4XDJhfRr0neiRIj1WuisSHsSCN191ncf8LDGJXOW32fMXMcFaGk2Hp+vCy4Ju/VJ7xyXgkdOb0xeyjbAHSAHDPZam3eKImNjeoY6nFpQ5xRqrLErHleCT1YRTZslq4B4foHfbOZBJzhpEw4A9ZQ5Kkrcg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778180958; c=relaxed/simple;
	bh=DCIlhkPi956jQZ7w1H7Td9mqzKvaRm3IqStZK2TkXUQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YWdApMAiZ3h94XJpzBLoilrO2rFE48OPgRz2i3afxfpPkvSMhqOd9CJ2ZlFj2+ARWRP4viwQr5tAutsCVa4kCUSsIz90ceG8q2HiG8JJEPaKltm0ScHhyZGqEav40el3n4GQftL8aTQSNzp3DutO0fqvLik7rQuOcmJnFH6mcXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dldSukbZ; arc=fail smtp.client-ip=52.103.23.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5wgbRJXsSJ+kWqvTPyo/PSFR/Rj/e3Wa35xNaWWjx9VTZYsPS8JB9E6yIWQQ/u5t0tW8Lrg4iJXRMhAv+tKSQ2zP9LLQH8AHxPiZ/yAGalba8uUH56JKq0fPdPlz0kASuXMnkruN1GY2Ob3e8qn3yFkJ/P4EZfMe0AVa3NTM2oyk2A3AKgJDUjhVRpd9UAAljzobpncG8H91fXrsm3H+udBppuevrz9Bbsev9779s+QyniR4N8CztySYMSZ6JAimtFSr2lJUZD5tEwki8Gr3yTiCSKv3WyOGtLvh8zKuC2F1Jnd/9KlMAPX5hFrvFWveZ4ug4V1tTJjBxjJS10dWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCIlhkPi956jQZ7w1H7Td9mqzKvaRm3IqStZK2TkXUQ=;
 b=roA+Akx53qGArJ67C6uxBze3hAdlWOT6JvbOUgpV+iNfqHdYXHOiLRCYHgl0accxHCVLBU26C/cHLFyvlr42FDCasHO/pBdRa1rQPBuboD0R569uaqZ/U7IANm4bWpDgApnneW0Z9ojAurQWb0Hf39BrefVVL7fW0dbAAWAhnnoB8xrg7xHOCIDlqSTrV/2Q0iWdtjBCgwdQFJY5+1nCptGJsWB39rUslKldQusab25S7Z2IANAzjp7GPbOWD+k997V4awMicRHttwA1+h9tZxQPo31Y4oZY/CYtyXrFaeSF8pQTWYKYDwFfqvxRbNVyNyIEKgekcwiFOxv4cIwmZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCIlhkPi956jQZ7w1H7Td9mqzKvaRm3IqStZK2TkXUQ=;
 b=dldSukbZmIWP4jWx3e5St1xWdhxuWhZ4c4Z6awmFvLh9doRcJ2ZODwOvT9QiMtvl8g6GBbkTYDE8GM3VsfNjICwWz135YV9AxxCjNNepjZgaVqVjV9f+ts5cBE9ceAKIfTjomTX/R8f/PavTH/KOLyZ092gBUo+FYrrrCX1XxqERRnWmg7yGI+NzuEQrPUsL2cpkBuXi/QKG3XdoL73JGqrYZgI2bfHRlXnRwXHljtk8bKD8fdevU8PzEpiy753fV7OMVjGS0SnZGU/uPsg503WrQizA+RcE5WcyrVEx739sG8UXwC5LlYTCJUEOqM6gdEqlfda+NzzC3773BIOhFw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV8PR02MB10118.namprd02.prod.outlook.com (2603:10b6:408:191::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 19:09:14 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 19:09:14 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] mshv: Simplify GPA map/unmap hypercall helpers
Thread-Topic: [PATCH v3] mshv: Simplify GPA map/unmap hypercall helpers
Thread-Index: AQLEyT/u56p58UqNrwhp5FFtB5fEwLQzFfNg
Date: Thu, 7 May 2026 19:09:13 +0000
Message-ID:
 <SN6PR02MB4157F8C28F454788714CFEF2D43C2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <177756065245.17889.140699174692055235.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <177756065245.17889.140699174692055235.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV8PR02MB10118:EE_
x-ms-office365-filtering-correlation-id: c3ae146d-5e00-4059-03cb-08deac6c20e0
x-microsoft-antispam:
 BCL:0;ARA:14566002|55001999006|8062599012|19101099003|461199028|51005399006|13091999003|8060799015|19110799012|31061999003|41001999006|15080799012|37011999003|12121999013|40105399003|3412199025|440099028|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?dy91SWRRVGsxZ1FPSmpkcTk3WUx4MWprQVJzTHV0bkFxZm9nYytQM0tsVFJp?=
 =?utf-8?B?cHVRbU12R0NHQUJvUnE4RklPNERiTTE1OEhJTW9Ob2c2K0t5akIrdFE1NkFY?=
 =?utf-8?B?bGpUbEljbU5hUmdvQVdybXp5ZUxlTjhaRHkxQ0ZNb2tyT29oTGhNcTdYSzRJ?=
 =?utf-8?B?S1IyVkFuM085ZTU1c01MRFBMVUs5NVh3a1FyWXZnYWNUTGlkZkVYUUFNdnRH?=
 =?utf-8?B?NVlFZUN3dGVvbzhmNHE1ZGJGeFNWSkNPdDI5NlFQNWRJNGwweEp0R2lGM0Q3?=
 =?utf-8?B?Z0NETXZYa3cxTnl6c2ZsS1ZSRG5CM1lBQUZMZGQ5KzNWVlY5Y1hnRTYwSkI5?=
 =?utf-8?B?MTVpUVQzaDNKYTN5STdmQ2hTQ3VBaGhxcXJjaEZWTkxKY2lsZFVTZExybEFN?=
 =?utf-8?B?K0Y3b2hKZmlsSWRDR1ZZVzJFWXN3YWczKzBWSXdlRWEvRFNmVklMR3dxeXRO?=
 =?utf-8?B?WFB6amxtUVh2cnZKMy9zbThLK0JmYk9hdlg4bXBPdUFRRGIvYmlQdS9kTXVX?=
 =?utf-8?B?R3I2dmhaODMvcXE2V2JzckFLMlc3SGIycVFYMEgveGhCa2tTOGRBakZ4cHBv?=
 =?utf-8?B?eXpHUExrb3VocHFKL0k3K0REM2U5Z2cycEhZZE9aMGtHUE1JaGt3VDFyM0x3?=
 =?utf-8?B?STV2ZVJieTFGSDU5azM3V3F3dG5sQnRvY0xNQTVadXNYbERyNytxR2h3ZkNH?=
 =?utf-8?B?RnBGSXBFL2JSU3Vidk1kT0ozZGhRNmhvV2cyVnVuWTFRcFJnMFFET0dBUzJQ?=
 =?utf-8?B?a3pPY01ranZmK0tNL1hick1CaTQ1V0Q4OUhKSmNDVW1yREorR050WVl2bEFY?=
 =?utf-8?B?eEJybG1xQ2d3VE00eEhQTEFXdnNqUW94VFJHZWxVNUxGNVFCZUhyZS9wenNS?=
 =?utf-8?B?RzZLbE4ydG9OdEczZHUzdG9XM0xiK3JOK1JFN2E1LzhqV1NRQ1k4WnFUbll5?=
 =?utf-8?B?VWdnUmJBZlMyZXBzcjFEeGVsU1hZMGcwWjVkMEsrR3FxTEU5ckxaSWtKdzNM?=
 =?utf-8?B?UHNSc0V1OVRMeVpzVmp4UWdFaWJzQ3M4dHgrVlc0eTI2SmxFWFJFQjFVUGNx?=
 =?utf-8?B?dGdPcVdnVnN3eVpReGVuUHpLSjlIbVVXNENhdm5Ba25sL3FFcW5LVEh6T2U1?=
 =?utf-8?B?WEExaHdGMGdoY2EyYU1wREYxK1A4cjJ4ZVJSZ3FBVUIydkZuZFM0OWdpVUVI?=
 =?utf-8?B?YUNyb202MnVERm4zcklpSzVvODByak1Bbkk2S2JLWXY0ZVVheXB0czRPZm44?=
 =?utf-8?B?VWxvTnZGZXlFK2lpb3ZxMGJtZzVSR1p5aDA0aTl5REZnQVJvZi82WVl0UG4w?=
 =?utf-8?B?T3RJcnkyMVB1eHZjQURjN0RsYUZhUzBwNmFJT3YydlcyK1k2aGd4cTVWYVlo?=
 =?utf-8?B?cjJZQUsrNUwwTVNidDREVnlWUWtJQWJ0R1VHRHFpTDErQmtLL1NlVFVUTDN0?=
 =?utf-8?B?NXp6WDdTUVNzaCtjc3NMajBuVHIyTFhtbDk2N0hKOG9TU3BKTGdSZWs4RUM2?=
 =?utf-8?Q?XuAj7Cv87wLon2FCVBq+qrY3tOZ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzQ1VHUwSUUzZkg5SHhqNHZNb01BSlM0WXZXd0Job2tVeU1ndmNOYlpxMFRu?=
 =?utf-8?B?RmJtNXlLRzVkYlRNRGd3M3pITzRTcWNzMFhoUTdSQnpsSW5zTWM1TmpJSEVD?=
 =?utf-8?B?eUxna3V1Y1Q0dXN1MkkwV3RFbnVpalJtWG5QL0RZeHB5dkZKUWloNklVaUFa?=
 =?utf-8?B?WDhvamdvMFNJaWlqcFBqTmhFZll3UmJWY0NDZWVBdTVMNUtxdnpUMFg0T0hj?=
 =?utf-8?B?MHlwU2xsS2NvdHRTMzFYaFBPVlJ4NDZ2OUZVb3RhSWlhMXpoeGJsc0hiMGkw?=
 =?utf-8?B?aEwzNEJoZDM0UVFoSkZBNmpRek9rMW1NUHp1NGJnOTVUUFBYZmdGSDJjU1FT?=
 =?utf-8?B?WmtRQkpFZnVRejFwdzJST2VZa29xbjMzaUtqOTJWS2VCRnhXcHR5VHRhOTRr?=
 =?utf-8?B?US9BYndoRkQ5RWFZb2p2LzhyNVdrd0tDVXdtaE5LYzAxUzRhQXJtcHE1aUc3?=
 =?utf-8?B?NmVZQ09FR3VwRkF5R3BFc2s5d0t5cnZiRHZnek5iYjMrYk1zbWhieTdsaHhl?=
 =?utf-8?B?M2RDR0JmR3dEY1FhM0RKSWY1WWticjNCeklwNnVHODRyelA1aE9NY3pqY1RM?=
 =?utf-8?B?dTkzajhDZzBucUZQY2dveFlXR0ZqaTBPUURIekhreXErQ1REcDZldEcvTXFT?=
 =?utf-8?B?MTJWa0h0RVVMR0tvS0xLTC84L1F6eVZmbXdKZE1DQU9xbXliNG1DZFRqY1J0?=
 =?utf-8?B?V0NMQjE4YlViNDlucmtEUDluVzBRa2RrRE1uTVpIM25sVUtiUW8rVUlvRXRM?=
 =?utf-8?B?NU5yN0RKUTVzcmJ6WDBIRG9EQWQvM3d1RjJzcThNWTZLVnlBMWJ4aHZDVlRk?=
 =?utf-8?B?SU10WHZPVzhVTDVXMC9vVFNtRXVVRUJ4UFBuTDZXSzMzaTlva2IwR1ZPRU5i?=
 =?utf-8?B?aTcreWF3UThLWEIrS0VrSStxeEJVc2pBMVVHV3VqTEN5NUN5Y2VOTkszWTNE?=
 =?utf-8?B?SzVFem1HS2NQbXV0ZXNrcTUxL29vUDk3NEFVRzNZM3V1TzNQVEN1VUx1UEpa?=
 =?utf-8?B?WTg1VXRFZnZqaXo0UytPUlNxdFpjT1BoQWlUM3pFaWpUU1MyZHpvWjZhTEtM?=
 =?utf-8?B?UnorYXJSbWY0YmpBWlJpYW0vS3FnVURhSVVjbnJMRUFkeDNxcTZ2OVFYd3lU?=
 =?utf-8?B?eFdHVU9xS2xVZVMzZjNlQUlTVDVlSFYxRkJOZTBWbEdTdmVKYmx5Q09lejhB?=
 =?utf-8?B?NlIzNlczYlgxS01Mc2lvZnBmNkg2a3RRRURVZkwxSU9tdDY1VkRBK0dLcjlz?=
 =?utf-8?B?cFp5SzhYeG52eHNxV3RRUEw0VGRQUXhVTTIyZHNEeUhqTThPY2w3RVlrTUZy?=
 =?utf-8?B?RU1GWmFsR2RZK1B5ZlVGYktEY0VYWFZVMUVGL1A3eDF6dm9DSmR2V0pQaU1G?=
 =?utf-8?B?QWs1dG9IM3pmS2lCSDF1OE5ZYkdUWm5RNzBKSnFvMGFCdDN5TjV1ZDBjc3VY?=
 =?utf-8?B?dXd5RGg4VS9MblRNcERHK2VKOWNkckx1UkNUYjFOVS82eFAxZnNoUGlXTjhy?=
 =?utf-8?B?ZS9qNjhFYnNwMnZ5cWc4QVZVODk3VGdFaTl3SXRCczFreWFORGpPb0FCMlhG?=
 =?utf-8?B?MXoyZlE5QjY4SUsycm9EaTFzcHpTYXRJUFFaMjdGNjJpUmxSaEEzRWJSeFpz?=
 =?utf-8?B?dEp3aFF3Rm5keERoQ2RybU9BUndldHZPQklyWXMxOEZwUVZOSzJjODlkbkYw?=
 =?utf-8?B?RDRCMFEzT2tJdVNFUGlzMi92bFM1aVhtSTRaM0JNbTJWVmwyYVJySStIMENW?=
 =?utf-8?B?enIzMzlNNXd3enVmYmZ5S0NzOXVIRWQ1cFdaTDJkcjN5enFVcGQvSmNLbVdm?=
 =?utf-8?Q?T0+E4xcvPU91nn8fehzaTdii1xRMdmUfgpj0w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ae146d-5e00-4059-03cb-08deac6c20e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 19:09:14.0634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10118
X-Rspamd-Queue-Id: 7BAF14EDBD8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10694-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim]
X-Rspamd-Action: no action

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4NCj4gDQo+IENsZWFuIHVwIGh2X2RvX21hcF9ncGFfaGNhbGwoKSBhbmQgaHZfY2FsbF91
bm1hcF9ncGFfcGFnZXMoKSBhZnRlciB0aGUNCj4gcHJlY2VkaW5nIGJ1Zy1maXggcGF0Y2hlczoN
Cj4gDQo+IE1vdmUgImRvbmUgKz0gY29tcGxldGVkIiBiZWZvcmUgdGhlIHN0YXR1cyBjaGVja3Mg
c28gdGhhdCBwYWdlcyBtYXBwZWQNCj4gYnkgYSBwYXJ0aWFsbHktc3VjY2Vzc2Z1bCBiYXRjaCBh
cmUgaW5jbHVkZWQgaW4gdGhlIGVycm9yIGNsZWFudXAgdW5tYXAuDQo+IFByZXZpb3VzbHkgdGhl
c2UgbWFwcGluZ3Mgd2VyZSBsZWFrZWQgb24gZmFpbHVyZS4NCj4gDQo+IFdoaWxlIGhlcmUsIGlt
cHJvdmUgdHlwZSBzYWZldHkgYW5kIHJlYWRhYmlsaXR5Og0KPiAgLSBDaGFuZ2UgImludCBkb25l
IiB0byAidTY0IGRvbmUiIHRvIG1hdGNoIHRoZSB1NjQgcGFnZV9jb3VudCBpdCBpcw0KPiAgICBj
b21wYXJlZCBhZ2FpbnN0LCBhdm9pZGluZyBzaWduZWQvdW5zaWduZWQgY29tcGFyaXNvbiBoYXph
cmRzLg0KPiAgLSBVc2UgdTY0IGZvciBsb29wIGl0ZXJhdGlvbiBhbmQgYmF0Y2ggc2l6ZSB2YXJp
YWJsZXMgY29uc2lzdGVudGx5Lg0KPiAgLSBBZGQgcHJvcGVyIGJyYWNlcyB0byB0aGUgZm9yLWxv
b3AgYm9keSBpbiBodl9kb19tYXBfZ3BhX2hjYWxsKCkuDQo+ICAtIFJlbW92ZSB1bm5lY2Vzc2Fy
eSAicmV0IiB2YXJpYWJsZSBmcm9tIGh2X2NhbGxfdW5tYXBfZ3BhX3BhZ2VzKCkuDQo+ICAtIFNp
bXBsaWZ5IHRoZSBlcnJvci1wYXRoIHVubWFwIHRvIHVzZSAiZG9uZSA8PCBsYXJnZV9zaGlmdCIg
ZGlyZWN0bHkNCj4gICAgaW5zdGVhZCBvZiBtdXRhdGluZyBkb25lIGluIHBsYWNlLg0KPiANCj4g
djM6IGFsaWduZWQgY2hhbmdlcyBieSA4MCBjb2xvbnMNCj4gdjI6IHJlcGxhY2VkIG1pbiB3aXRo
IG1pbl90DQo+IA0KPiBGaXhlczogNjIxMTkxZDcwOWIxNCAoIkRyaXZlcnM6IGh2OiBJbnRyb2R1
Y2UgbXNodl9yb290IG1vZHVsZSB0byBleHBvc2UgL2Rldi9tc2h2IHRvIFZNTXMiKQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBTdGFuaXNsYXYgS2luc2J1cnNraWkgPHNraW5zYnVyc2tpaUBsaW51eC5taWNy
b3NvZnQuY29tPg0KDQpRdWVzdGlvbiBhYm91dCAicGFja2FnaW5nIiBvZiB0aGlzIHBhdGNoLiBU
byBhcHBseSBjbGVhbmx5LCBpdA0KbmVlZHMgdGhlIHByZXZpb3VzIHR3byBmaXhlcyBhcHBsaWVk
LiAgQXMgc3VjaCwgc2hvdWxkbid0IGl0IGJlDQp0aGUgM3JkIHBhdGNoIGluIHBhdGNoIHNldCB0
aGF0IGluY2x1ZGVzIHRoZSBvdGhlciB0d28/DQoNCkFsc28sIHRoZXJlIGFyZSBjaGFuZ2VzIGlu
IHRoZSBwcmV2aW91cyB0d28gZml4ZXMgdGhhdCBnZXQgdW5kb25lDQpvciBjaGFuZ2VkIGJ5IHRo
aXMgcGF0Y2ggKHN1Y2ggYXMgYXBwbHlpbmcgbGFyZ2Vfc2hpZnQgaW4gdGhlIGVycm9yDQpwYXRo
IG9mIGh2X2RvX21hcF9ncGFfaGNhbGwoKS4gV2l0aCBhIGxpdHRsZSBtb3JlIGNvb3JkaW5hdGlv
bg0KYmV0d2VlbiB0aGUgdGhyZWUgcGF0Y2hlcywgdGhlcmUgY291bGQgYmUgbGVzcyBjb2RlIGNo
dXJuIGFuZA0KdGhlIHBhdGNoZXMgd291bGQgb3ZlcmFsbCBiZSBzbWFsbGVyLg0KDQpNaWNoYWVs
DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2h2L21zaHZfcm9vdF9odl9jYWxsLmMgfCAgIDU2ICsrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAy
MSBpbnNlcnRpb25zKCspLCAzNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2h2L21zaHZfcm9vdF9odl9jYWxsLmMgYi9kcml2ZXJzL2h2L21zaHZfcm9vdF9odl9jYWxs
LmMNCj4gaW5kZXggZTU5OTJjMzI0OTA0YS4uZTFmOWUyOGQ1YTE5YiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9odi9tc2h2X3Jvb3RfaHZfY2FsbC5jDQo+ICsrKyBiL2RyaXZlcnMvaHYvbXNodl9y
b290X2h2X2NhbGwuYw0KPiBAQCAtMTk1LDggKzE5NSw4IEBAIHN0YXRpYyBpbnQgaHZfZG9fbWFw
X2dwYV9oY2FsbCh1NjQgcGFydGl0aW9uX2lkLCB1NjQgZ2ZuLCB1NjQNCj4gcGFnZV9zdHJ1Y3Rf
Y291bnQsDQo+ICAJc3RydWN0IGh2X2lucHV0X21hcF9ncGFfcGFnZXMgKmlucHV0X3BhZ2U7DQo+
ICAJdTY0IHN0YXR1cywgKnBmbmxpc3Q7DQo+ICAJdW5zaWduZWQgbG9uZyBpcnFfZmxhZ3MsIGxh
cmdlX3NoaWZ0ID0gMDsNCj4gLQlpbnQgcmV0ID0gMCwgZG9uZSA9IDA7DQo+IC0JdTY0IHBhZ2Vf
Y291bnQgPSBwYWdlX3N0cnVjdF9jb3VudDsNCj4gKwl1NjQgZG9uZSA9IDAsIHBhZ2VfY291bnQg
PSBwYWdlX3N0cnVjdF9jb3VudDsNCj4gKwlpbnQgcmV0ID0gMDsNCj4gDQo+ICAJaWYgKHBhZ2Vf
Y291bnQgPT0gMCB8fCAocGFnZXMgJiYgbW1pb19zcGEpKQ0KPiAgCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gQEAgLTIxMyw4ICsyMTMsOCBAQCBzdGF0aWMgaW50IGh2X2RvX21hcF9ncGFfaGNhbGwodTY0
IHBhcnRpdGlvbl9pZCwgdTY0IGdmbiwgdTY0DQo+IHBhZ2Vfc3RydWN0X2NvdW50LA0KPiAgCX0N
Cj4gDQo+ICAJd2hpbGUgKGRvbmUgPCBwYWdlX2NvdW50KSB7DQo+IC0JCXVsb25nIGksIGNvbXBs
ZXRlZCwgcmVtYWluID0gcGFnZV9jb3VudCAtIGRvbmU7DQo+IC0JCWludCByZXBfY291bnQgPSBt
aW4ocmVtYWluLCBIVl9NQVBfR1BBX0JBVENIX1NJWkUpOw0KPiArCQl1NjQgaSwgY29tcGxldGVk
LCByZW1haW4gPSBwYWdlX2NvdW50IC0gZG9uZTsNCj4gKwkJdTY0IHJlcF9jb3VudCA9IG1pbl90
KHU2NCwgcmVtYWluLCBIVl9NQVBfR1BBX0JBVENIX1NJWkUpOw0KPiANCj4gIAkJbG9jYWxfaXJx
X3NhdmUoaXJxX2ZsYWdzKTsNCj4gIAkJaW5wdXRfcGFnZSA9ICp0aGlzX2NwdV9wdHIoaHlwZXJ2
X3BjcHVfaW5wdXRfYXJnKTsNCj4gQEAgLTIyNCwyMyArMjI0LDE0IEBAIHN0YXRpYyBpbnQgaHZf
ZG9fbWFwX2dwYV9oY2FsbCh1NjQgcGFydGl0aW9uX2lkLCB1NjQgZ2ZuLCB1NjQNCj4gcGFnZV9z
dHJ1Y3RfY291bnQsDQo+ICAJCWlucHV0X3BhZ2UtPm1hcF9mbGFncyA9IGZsYWdzOw0KPiAgCQlw
Zm5saXN0ID0gaW5wdXRfcGFnZS0+c291cmNlX2dwYV9wYWdlX2xpc3Q7DQo+IA0KPiAtCQlmb3Ig
KGkgPSAwOyBpIDwgcmVwX2NvdW50OyBpKyspDQo+IC0JCQlpZiAoZmxhZ3MgJiBIVl9NQVBfR1BB
X05PX0FDQ0VTUykgew0KPiArCQlmb3IgKGkgPSAwOyBpIDwgcmVwX2NvdW50OyBpKyspIHsNCj4g
KwkJCWlmIChmbGFncyAmIEhWX01BUF9HUEFfTk9fQUNDRVNTKQ0KPiAgCQkJCXBmbmxpc3RbaV0g
PSAwOw0KPiAtCQkJfSBlbHNlIGlmIChwYWdlcykgew0KPiAtCQkJCXU2NCBpbmRleCA9IChkb25l
ICsgaSkgPDwgbGFyZ2Vfc2hpZnQ7DQo+IC0NCj4gLQkJCQlpZiAoaW5kZXggPj0gcGFnZV9zdHJ1
Y3RfY291bnQpIHsNCj4gLQkJCQkJcmV0ID0gLUVJTlZBTDsNCj4gLQkJCQkJYnJlYWs7DQo+IC0J
CQkJfQ0KPiAtCQkJCXBmbmxpc3RbaV0gPSBwYWdlX3RvX3BmbihwYWdlc1tpbmRleF0pOw0KPiAt
CQkJfSBlbHNlIHsNCj4gKwkJCWVsc2UgaWYgKHBhZ2VzKQ0KPiArCQkJCXBmbmxpc3RbaV0gPSBw
YWdlX3RvX3BmbihwYWdlc1soZG9uZSArIGkpIDw8DQo+ICsJCQkJCQkJIGxhcmdlX3NoaWZ0XSk7
DQo+ICsJCQllbHNlDQo+ICAJCQkJcGZubGlzdFtpXSA9IG1taW9fc3BhICsgZG9uZSArIGk7DQo+
IC0JCQl9DQo+IC0JCWlmIChyZXQpIHsNCj4gLQkJCWxvY2FsX2lycV9yZXN0b3JlKGlycV9mbGFn
cyk7DQo+IC0JCQlicmVhazsNCj4gIAkJfQ0KPiANCj4gIAkJc3RhdHVzID0gaHZfZG9fcmVwX2h5
cGVyY2FsbChIVkNBTExfTUFQX0dQQV9QQUdFUywgcmVwX2NvdW50LCAwLA0KPiBAQCAtMjQ4LDI5
ICsyMzksMjYgQEAgc3RhdGljIGludCBodl9kb19tYXBfZ3BhX2hjYWxsKHU2NCBwYXJ0aXRpb25f
aWQsIHU2NCBnZm4sIHU2NA0KPiBwYWdlX3N0cnVjdF9jb3VudCwNCj4gIAkJbG9jYWxfaXJxX3Jl
c3RvcmUoaXJxX2ZsYWdzKTsNCj4gDQo+ICAJCWNvbXBsZXRlZCA9IGh2X3JlcGNvbXAoc3RhdHVz
KTsNCj4gKwkJZG9uZSArPSBjb21wbGV0ZWQ7DQo+IA0KPiAgCQlpZiAoaHZfcmVzdWx0X25lZWRz
X21lbW9yeShzdGF0dXMpKSB7DQo+ICAJCQlyZXQgPSBodl9jYWxsX2RlcG9zaXRfcGFnZXMoTlVN
QV9OT19OT0RFLCBwYXJ0aXRpb25faWQsDQo+ICAJCQkJCQkgICAgSFZfTUFQX0dQQV9ERVBPU0lU
X1BBR0VTKTsNCj4gIAkJCWlmIChyZXQpDQo+ICAJCQkJYnJlYWs7DQo+IC0NCj4gIAkJfSBlbHNl
IGlmICghaHZfcmVzdWx0X3N1Y2Nlc3Moc3RhdHVzKSkgew0KPiAgCQkJcmV0ID0gaHZfcmVzdWx0
X3RvX2Vycm5vKHN0YXR1cyk7DQo+ICAJCQlicmVhazsNCj4gIAkJfQ0KPiAtDQo+IC0JCWRvbmUg
Kz0gY29tcGxldGVkOw0KPiAgCX0NCj4gDQo+ICAJaWYgKHJldCAmJiBkb25lKSB7DQo+ICAJCXUz
MiB1bm1hcF9mbGFncyA9IDA7DQo+IA0KPiAtCQlpZiAoZmxhZ3MgJiBIVl9NQVBfR1BBX0xBUkdF
X1BBR0UpIHsNCj4gKwkJaWYgKGZsYWdzICYgSFZfTUFQX0dQQV9MQVJHRV9QQUdFKQ0KPiAgCQkJ
dW5tYXBfZmxhZ3MgfD0gSFZfVU5NQVBfR1BBX0xBUkdFX1BBR0U7DQo+IC0JCQlkb25lIDw8PSBs
YXJnZV9zaGlmdDsNCj4gLQkJfQ0KPiAtCQlodl9jYWxsX3VubWFwX2dwYV9wYWdlcyhwYXJ0aXRp
b25faWQsIGdmbiwgZG9uZSwgdW5tYXBfZmxhZ3MpOw0KPiArCQlodl9jYWxsX3VubWFwX2dwYV9w
YWdlcyhwYXJ0aXRpb25faWQsIGdmbiwNCj4gKwkJCQkJZG9uZSA8PCBsYXJnZV9zaGlmdCwgdW5t
YXBfZmxhZ3MpOw0KPiAgCX0NCj4gDQo+ICAJcmV0dXJuIHJldDsNCj4gQEAgLTMwNSw3ICsyOTMs
NyBAQCBpbnQgaHZfY2FsbF91bm1hcF9ncGFfcGFnZXModTY0IHBhcnRpdGlvbl9pZCwgdTY0IGdm
biwgdTY0DQo+IHBhZ2VfY291bnRfNGssDQo+ICAJc3RydWN0IGh2X2lucHV0X3VubWFwX2dwYV9w
YWdlcyAqaW5wdXRfcGFnZTsNCj4gIAl1NjQgc3RhdHVzLCBwYWdlX2NvdW50ID0gcGFnZV9jb3Vu
dF80azsNCj4gIAl1bnNpZ25lZCBsb25nIGlycV9mbGFncywgbGFyZ2Vfc2hpZnQgPSAwOw0KPiAt
CWludCByZXQgPSAwLCBkb25lID0gMDsNCj4gKwl1NjQgZG9uZSA9IDA7DQo+IA0KPiAgCWlmIChw
YWdlX2NvdW50ID09IDApDQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiBAQCAtMzE5LDggKzMwNyw4
IEBAIGludCBodl9jYWxsX3VubWFwX2dwYV9wYWdlcyh1NjQgcGFydGl0aW9uX2lkLCB1NjQgZ2Zu
LCB1NjQNCj4gcGFnZV9jb3VudF80aywNCj4gIAl9DQo+IA0KPiAgCXdoaWxlIChkb25lIDwgcGFn
ZV9jb3VudCkgew0KPiAtCQl1bG9uZyBjb21wbGV0ZWQsIHJlbWFpbiA9IHBhZ2VfY291bnQgLSBk
b25lOw0KPiAtCQlpbnQgcmVwX2NvdW50ID0gbWluKHJlbWFpbiwgSFZfVU1BUF9HUEFfUEFHRVMp
Ow0KPiArCQl1NjQgY29tcGxldGVkLCByZW1haW4gPSBwYWdlX2NvdW50IC0gZG9uZTsNCj4gKwkJ
dTY0IHJlcF9jb3VudCA9IG1pbl90KHU2NCwgcmVtYWluLCBIVl9VTUFQX0dQQV9QQUdFUyk7DQo+
IA0KPiAgCQlsb2NhbF9pcnFfc2F2ZShpcnFfZmxhZ3MpOw0KPiAgCQlpbnB1dF9wYWdlID0gKnRo
aXNfY3B1X3B0cihoeXBlcnZfcGNwdV9pbnB1dF9hcmcpOw0KPiBAQCAtMzMzLDE1ICszMjEsMTMg
QEAgaW50IGh2X2NhbGxfdW5tYXBfZ3BhX3BhZ2VzKHU2NCBwYXJ0aXRpb25faWQsIHU2NCBnZm4s
IHU2NA0KPiBwYWdlX2NvdW50XzRrLA0KPiAgCQlsb2NhbF9pcnFfcmVzdG9yZShpcnFfZmxhZ3Mp
Ow0KPiANCj4gIAkJY29tcGxldGVkID0gaHZfcmVwY29tcChzdGF0dXMpOw0KPiAtCQlpZiAoIWh2
X3Jlc3VsdF9zdWNjZXNzKHN0YXR1cykpIHsNCj4gLQkJCXJldCA9IGh2X3Jlc3VsdF90b19lcnJu
byhzdGF0dXMpOw0KPiAtCQkJYnJlYWs7DQo+IC0JCX0NCj4gLQ0KPiAgCQlkb25lICs9IGNvbXBs
ZXRlZDsNCj4gKw0KPiArCQlpZiAoIWh2X3Jlc3VsdF9zdWNjZXNzKHN0YXR1cykpDQo+ICsJCQly
ZXR1cm4gaHZfcmVzdWx0X3RvX2Vycm5vKHN0YXR1cyk7DQo+ICAJfQ0KPiANCj4gLQlyZXR1cm4g
cmV0Ow0KPiArCXJldHVybiAwOw0KPiAgfQ0KPiANCj4gIGludCBodl9jYWxsX2dldF9ncGFfYWNj
ZXNzX3N0YXRlcyh1NjQgcGFydGl0aW9uX2lkLCB1MzIgY291bnQsIHU2NCBncGFfYmFzZV9wZm4s
DQo+IA0KPiANCg0K

