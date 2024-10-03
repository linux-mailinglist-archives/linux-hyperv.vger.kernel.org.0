Return-Path: <linux-hyperv+bounces-3108-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D1098F2B1
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 17:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A28E8B21259
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 15:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D522D1A0BF6;
	Thu,  3 Oct 2024 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NAdeFpWb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020134.outbound.protection.outlook.com [52.101.61.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3011C1A08AB;
	Thu,  3 Oct 2024 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969745; cv=fail; b=codsLdz9WetSiS0wHT93k2LPnxvVU7zyJz+9XtVOtRCBExvINKSsXCjo+M4n19XP1q8WOPuUPVOMZkasfoSNyjcd4RaawUaUfeF2ehKRVz1nVbnGUa82z4P9ibb3PCtgpxtaCzMzPexPki0ftaN5bx2gGmZyt5p8A15JpCPXWBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969745; c=relaxed/simple;
	bh=f5og6NvasviNn6b764qd0KB2yR3z3mUxcJPVT+ITBBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OY7yofJtm3QwonHUoYxKWpBNPqu9ru0kwcKWKH30E7hFDuAx2Xs61wzufhwwG/XoO8a79EAGvnzZQkdf81vXA6tJqv2CI8LICIyeMjO6LNToNuWnPyOM6l3WxCPWyEJYqmq3KgISfxUAOrKUewKXR46Zof9JZK0xB9UHDNoBox8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=NAdeFpWb; arc=fail smtp.client-ip=52.101.61.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDm6T/2TfpNq5hrJn+b7DgqidopusLVfEnnqKaBFRQqsfYDt1gzAHwr7XbMG0tvWzwW+AkLQhrj3e48Q+upSu7KzSZWsQCI4IKbR3SGywDznxrYyVnAzyocL0quzDs1ilUBX0KhAvJptIC1sc62fFVKY4iJzltGbhBRbsDkgygb9SItM2kZHgfEFCH/r0cU4AhdXTQe4tspKcTgbj9zMEfvngMg0weXz2nEsAZCEfY/7ikVRkMJzhgItAxMc5h9AHrFeDMuIg8Pk7rczG7qYd5nhQSRV0vlTUbrRa+RnvzA9kRsvA+wO6Jdvc0ivnHZGvHPXp2v7A+UYjedRxKSwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5og6NvasviNn6b764qd0KB2yR3z3mUxcJPVT+ITBBw=;
 b=I3C188ZTTa6vGc6lB6Yr2QkzDZHnFpNUYPEJE5hjwEhIGhTMk+U2pGQa6+as5T3ldsUqgw2grQY3Nd8spYhgXs/LmiPk5g0wSvQDxzAnknzRNAu7GT3GeTPpls05FQMDM3IjPC/8HYKuA4Ru0uYb1EnGczhyeMoixxWm49J2+eMDhbjq7LtTiUg6hfOCvWCBzPi3OZ6qBn17SOW0ahzcNxnwp2+w3O6xZIDe8QFerfMGvR05d2R0P2oa9iUrjlVx/rcpkp+lvQ+CbYRz7sLDFERZF9bIhvyszAoe/xgjY1TwdIglf01cjYhomlBa3hHZophNzGic3QMNrxml7lxSyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5og6NvasviNn6b764qd0KB2yR3z3mUxcJPVT+ITBBw=;
 b=NAdeFpWbcjJWcY2/8m7T8b0Aby8ghPp+vYpp1t0LXsIQZTtvqQskcsw/TelLp649EvsopefDVt/mHYE2UtXmEbAVET5PMbVCHCXW6PL26myn5btztEvUtZJHXw5BJDpP+xvBxh//ZothLOPytfJFcHaG9Fkp0ZjZ1jbUM80xGtM=
Received: from MW4PR21MB1859.namprd21.prod.outlook.com (2603:10b6:303:7f::6)
 by CY8PR21MB4047.namprd21.prod.outlook.com (2603:10b6:930:5f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Thu, 3 Oct
 2024 15:35:41 +0000
Received: from MW4PR21MB1859.namprd21.prod.outlook.com
 ([fe80::a12d:cc9:6939:9559]) by MW4PR21MB1859.namprd21.prod.outlook.com
 ([fe80::a12d:cc9:6939:9559%6]) with mapi id 15.20.8048.007; Thu, 3 Oct 2024
 15:35:41 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net] hv_netvsc: Fix VF namespace also in netvsc_open
Thread-Topic: [PATCH net] hv_netvsc: Fix VF namespace also in netvsc_open
Thread-Index: AQHbER+TDt3OdK8iTESj8UX/9+N5+bJ0zLyAgABT+tA=
Date: Thu, 3 Oct 2024 15:35:41 +0000
Message-ID:
 <MW4PR21MB18597355B7156EC46BD793E2CA712@MW4PR21MB1859.namprd21.prod.outlook.com>
References: <1727470464-14327-1-git-send-email-haiyangz@microsoft.com>
 <a96b1e00-70e3-46d8-a918-e4eb2e7443e8@redhat.com>
In-Reply-To: <a96b1e00-70e3-46d8-a918-e4eb2e7443e8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=de358aa1-8895-4fe6-8df8-edd1f4e9dff0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-10-03T14:35:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR21MB1859:EE_|CY8PR21MB4047:EE_
x-ms-office365-filtering-correlation-id: 5fc7d5bf-4a48-4a83-3d49-08dce3c10a05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eTNqWjZVU1RMbEtwN3pJQVBGWnlPMmpjWmYyWDd1SDRvT2ZzZEpvWWJDeStZ?=
 =?utf-8?B?MFltbG4vY3lqaU9SbWIvcUtqR1E4TFJwUGd5YmNxZHN1NWVHWUNFTkFqaXFQ?=
 =?utf-8?B?Kzh6QTR1bkpPemhKM2tMb0NKbVdBMHBLSGM5cHlJenRXUWhQNlMyeWhxVFdD?=
 =?utf-8?B?Mjd4ODFxSEpJRkdxWU94TnFJRDRxcWJieDZhVkhsdEU5V1VjZ3dsZzJtK1hB?=
 =?utf-8?B?SG1PNUtMOUxiSmNleEhRMTNPN3Q1Q1N2eHZjSGF2c1ZnS05yazJjbXRoTmpN?=
 =?utf-8?B?aGI0R0ZsWHRERjdNQmtjR21GY0J6TWNXcnVmTk5QYTQxQUpJRUpMR1orM09p?=
 =?utf-8?B?eXUxWWlGaEtsM010U3o2SXJWRlZNNTMzUWNJQUFHeXlvZ21Ga1c3TVpyQW5t?=
 =?utf-8?B?aCtwUFl2clZZbHZtZ3pKb3lqWThIWFdEek56bVF2bWdQaDlNS1duMFRoSkdL?=
 =?utf-8?B?OUtyUklpbEJENXJKZCtzazFsRE11RWdJc1YwVGhiTGJGRXgzN0VkL3VsTnZr?=
 =?utf-8?B?Y2h1VDAxZHNDZERWYnFIWmMwR3hyOHV1UUdMUDhxU1AwbUFtL1k2dmdVN3Rq?=
 =?utf-8?B?UEFyeHR5S0FSTEgydUFmNEVLWS9pNXlNRUNBQmNFVWdudTNVY1ltRnBrTGJZ?=
 =?utf-8?B?RWY1cXpxN1R2NEpBWFR3YlUvMUs5NEp1Nks4R1hEdXZ3ejNQaDlaaXRoMkZv?=
 =?utf-8?B?eWtURGpiR0lDYTJqMC9oeGRVQll5L0Vzc21LWUhDVXhhdFc5VGJJdmJMK25v?=
 =?utf-8?B?Tm14K2I0RmFyMmw0aHZNOW1vL21FSmFYS3FTZjJBRWc1Tm03STdVNjhhVEtP?=
 =?utf-8?B?ZUJDYnpOdXNSVzIybUpwc2ZDTkVUelBHc1JWcjA2UWpERW1UN2N2bUNnaDll?=
 =?utf-8?B?bGhZQ2dMYVBHWlhQSFAwSDk2TWwveWY3QTNTZ2xjVk5Vc29wQlZOQ2hKR1Y1?=
 =?utf-8?B?TWxSVEh4ME9yeTlCSnZ1WFhSbE9DQVFmTm56SnR3OWxOc1J4am5lZG00aVJz?=
 =?utf-8?B?L2VycC9tNVk4Z204N0FOYzNnSS9IMTFBa1JIVllGTzBWTEsyenVCTXNnWEQv?=
 =?utf-8?B?QndlVlFjTWtiMjRBaGJCa2dCYjVaRFRCKzQzZUpIVm9vOXBhbnFYTDcwS2dr?=
 =?utf-8?B?cjFTdFlTWVRLMWVscUVYenZiNk1yS0g4c00vS1UyZGhmem0rRm45R2pvb2lT?=
 =?utf-8?B?Wm55b3A5QkJnbUFKZ1IrWmJtV05wUk5tTFc2N0UxdnpHTXdlQjFRdGwrSTFv?=
 =?utf-8?B?ZXdUYzRlZEpkWHp5WC9HNytkQ0xQaFQrSEpnd3JKaERTR3diYVRkRkNjTUxX?=
 =?utf-8?B?Z0p3Z3EyQ0ZpbHV3bGM3VkVSVFpmQUlBd2paSEcwZmNUSTE5L01ZWFYyRVF4?=
 =?utf-8?B?Uk9Sd1hWV3N6Z2RDa1FWMms2ZUVuTCtyeUZPbU1WMjR0RGhpYWRnRGpUT0Fr?=
 =?utf-8?B?MjNmMXNEcnNqdHZubU0rT1RpSHZUd2t5UWNhb2VJSm5Qd3IvUTZHclFDR1BH?=
 =?utf-8?B?TWtWNHJrR1pWQUM4OXUyYUFZcGkxdEc0emYrSVJ5SmY1V0VoZUFDTVRCbU50?=
 =?utf-8?B?cGxEdWhmTTdyOHdiRWxxbnFXMGdnVUVaT0xhWE95RVFjcnVkbGJ1L3VhTS9H?=
 =?utf-8?B?ZVlKcS9NaWhYalhhM1RtVnQrMTFkNCtwM25Damd5QzFkNzloRmZMMDBzb1FN?=
 =?utf-8?B?TW1EUHVmVmxHbElONWJhbzcrNWNHM1Y1WXFvVndDajUreVJ2QjJUOVA0TlNx?=
 =?utf-8?B?QnhRR2lhODFleTVtcGU1YjEyeFpZa2FCMVlGd0VHM0FsVmNFSWZEZE1TbGxM?=
 =?utf-8?B?ZnNLRXVMQTcxOHdvUGZPdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB1859.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0pRYTNNa0c2czJzd0kyNXpiR0o2UFhuT2FISUFHdGQ2enhHenJtenhyMGJR?=
 =?utf-8?B?MVJoMG1JY1YyTEN2SzloN3hxZ2dMM2F2YjhlOUExL3RTLy84U2F1VUhIY1dK?=
 =?utf-8?B?cGtzUm1WMWx4azkwcTVhQXhuWFRqVmR2aUkxV3NnSVB3SmtTUmZmMDY1d3V5?=
 =?utf-8?B?NHBPeU5ydWROVUhaeWhranlBVlMrZkR3bWtDQVhTNTlJaTZjTXdlZVRaTnJL?=
 =?utf-8?B?NVhvU3ZmL3YxUXo3V1FNZXgzanBxbGlzRE9QU0FkZmYyVmlvdWZqWThBRTNX?=
 =?utf-8?B?OStMQksvUy9RaE9XMHRNZ1hCcnQwSVBkd0RYM3lrK2h0QzFNUW82WUFXalA2?=
 =?utf-8?B?bXEvZ2MzK0tlWlozTjFIWVRQdTN1cGNIa2lkVTEvenlIRzlDdTU0d0tCcUJL?=
 =?utf-8?B?NXBCYzgwczlnek8yRHVGeE5TUVg0Y0QrdmNvWFpzaXNTMlBFaVF6VDFveUFO?=
 =?utf-8?B?QnlyTXlGYmNjTnB3eW1uWE53emVvbDRoZlF2ck5sanNGWCtlU3NjVmR1N2hm?=
 =?utf-8?B?RmRReHJNckJVM1NKVzJscGw3YmgxeXJCNG9jTG1ydDN2V0s4ck1EMFdvbTNx?=
 =?utf-8?B?RnBLYUVKdkJISmlNTXpvQnFzVkVuM1N6TVZZYS95UXJvRVNobTRNK0M0MEN6?=
 =?utf-8?B?ekZiVWNSbnlGSnllNHBGaHJQZmxyYStZNk1FV1lGTFc0cUg4KzZmRzVhcnlC?=
 =?utf-8?B?bEliYkJzbVRTZ01iWHoyVnc5WHV3dnB4dEZCNE1HeDlBaXlqSjM4YTZHZGU2?=
 =?utf-8?B?T2lTL2VseUVRTU1IczhDRGp5dnBFQkU4RGRhUTVsRUZPWDRqSStpeXJFZTY3?=
 =?utf-8?B?SUxIdTdyQmRSTEc5bWRLTUROa3FjTjRGTUJlYzBZZW9HdU0wS1U3eVpLNVZX?=
 =?utf-8?B?dGVxdEdoRXhCQk1mMXg0aDNCQjZETXFJRmlINGd4QTNPQUt1azRvQTV2dUJw?=
 =?utf-8?B?OWR0UHYxMWtFTWlscnhBY2QveGJCclNJRlYxR2ZiYVRxZkZheWpKT1BOTkR5?=
 =?utf-8?B?Um5xTkZhbE1waW1uYUZvS3NaOGVkUVd0VC9KSEN2NEh0YS9OTEs4c2RJNXNZ?=
 =?utf-8?B?QXkrTmd6STdNMVFJMnZxZEJTWWljQlVtaVArMWZsbWx3NnZtaXMxNm1BODRt?=
 =?utf-8?B?VE5mVHBnSE1jbWhMekh4YUJEN1RPbE05MVo3WmtwR2ZWNGQ1dWduSTd1UzFv?=
 =?utf-8?B?WUc1anJpUWdYbEN6bS9oUWhpM1VJc1U2T08vWW9IcUJVcXBkYlVCZklMcWJZ?=
 =?utf-8?B?S1ZTV25YbHdzeS9QeXM3NlB3aTJOUGlDanVaVENtdG5wVlNjdVlWTXQzczc1?=
 =?utf-8?B?K2VlNEZKcGU1M05FR3ZrMXpDMHljaC90K2NnMWNOWC83cmpvN0llUzNyMGJI?=
 =?utf-8?B?STNDNkRKV2FTbEZ4YlVwTzE3cUFvRGdZbERPL3pnSkVlc3JLRmc0R3hqVTIx?=
 =?utf-8?B?RU9yQ2FyU2Y2S1VONUNoei91UmpWMmpVWnAyakxuSnhNcmQ5akNyRXUyUUlG?=
 =?utf-8?B?ZkZsN3hndmNEN1NURS9INFllOVZnMjlGbUdPWGgxcEVNZ2V1SXAyRmZMMUU4?=
 =?utf-8?B?T3pSdUxuOUlWQlVJMHlTZnJVdldWRzZRQ2ZXQmtpR3pLWHhFdzVCenozZlJ3?=
 =?utf-8?B?MXZJejFDNVR6U210eHUxalIwWjdSVExBcmVHcVlDbFhualdXM1p0a3BBYWRr?=
 =?utf-8?B?d2hIek9STG9RU2lnNXJUdDBzRTdYdnJDOTRlZkFvRWRob3VhMFFBankxZG55?=
 =?utf-8?B?NFkvMUFiZ2JNWG5zRUVoNmdjMkVWTEtIZ24xZDBtSzdUQ05DUEZqTis0SWhZ?=
 =?utf-8?B?ZDFzejVsc2dJTWZUT1ZzdTlSM2tKZ2Jocm04K2s3MUJsMmpHa0Q2S2VxaHk0?=
 =?utf-8?B?T1NEMzNET01oTWppMkNZbjNET2dQTEhoZWQ2WmpUalZ5YjBjaWtBUFZ2MWgv?=
 =?utf-8?B?cjlUQkUyb0VZU0pBU0lwZU1jRHpJK1BXb1ZzSHJGbkVneGVoUlZpRFVRRXFx?=
 =?utf-8?B?MlVMcFpVQUQwUCtjOEpwS3BDSzlsS0FzRFRXMSsvSFB4SUl6RGNIVUhaTHFC?=
 =?utf-8?B?L2htSTRtNDl0TVBua3ExMVo2bWd0UEx2Yk5KcWM2L2ErRU15Uk4rMzZuc0Vy?=
 =?utf-8?Q?/gUHykbVP/jnzcDn21horKDwn?=
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
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB1859.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc7d5bf-4a48-4a83-3d49-08dce3c10a05
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 15:35:41.5783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AMtppFFFXMW2wg/obaT4/ZxCE8pXa6vwUSBIwc4gb/7hfUi9Wx5OIPB0SP+Laefk9f4Z/ZsGwko/9KfJ8RGd6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR21MB4047

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQWJlbmkgPHBh
YmVuaUByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAzLCAyMDI0IDU6MzUg
QU0NCj4gVG86IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+OyBsaW51eC1o
eXBlcnZAdmdlci5rZXJuZWwub3JnOw0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBL
WSBTcmluaXZhc2FuIDxreXNAbWljcm9zb2Z0LmNvbT47IHdlaS5saXVAa2VybmVsLm9yZzsgRGV4
dWFuIEN1aQ0KPiA8ZGVjdWlAbWljcm9zb2Z0LmNvbT47IGVkdW1hemV0QGdvb2dsZS5jb207IGt1
YmFAa2VybmVsLm9yZzsNCj4gc3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc7IGRhdmVtQGRhdmVt
bG9mdC5uZXQ7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzdGFibGVAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0XSBodl9uZXR2c2M6IEZpeCBWRiBu
YW1lc3BhY2UgYWxzbyBpbiBuZXR2c2Nfb3Blbg0KPiANCj4gT24gOS8yNy8yNCAyMjo1NCwgSGFp
eWFuZyBaaGFuZyB3cm90ZToNCj4gPiBUaGUgZXhpc3RpbmcgY29kZSBtb3ZlcyBWRiB0byB0aGUg
c2FtZSBuYW1lc3BhY2UgYXMgdGhlIHN5bnRoZXRpYw0KPiBkZXZpY2UNCj4gPiBkdXJpbmcgbmV0
dnNjX3JlZ2lzdGVyX3ZmKCkuIEJ1dCwgaWYgdGhlIHN5bnRoZXRpYyBkZXZpY2UgaXMgbW92ZWQg
dG8gYQ0KPiA+IG5ldyBuYW1lc3BhY2UgYWZ0ZXIgdGhlIFZGIHJlZ2lzdHJhdGlvbiwgdGhlIFZG
IHdvbid0IGJlIG1vdmVkDQo+IHRvZ2V0aGVyLg0KPiA+DQo+ID4gVG8gbWFrZSB0aGUgYmVoYXZp
b3IgbW9yZSBjb25zaXN0ZW50LCBhZGQgYSBuYW1lc3BhY2UgY2hlY2sgdG8NCj4gbmV0dnNjX29w
ZW4oKSwNCj4gPiBhbmQgbW92ZSB0aGUgVkYgaWYgaXQgaXMgbm90IGluIHRoZSBzYW1lIG5hbWVz
cGFjZS4NCj4gPg0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gRml4ZXM6IGMw
YTQxYjg4N2NlNiAoImh2X25ldHZzYzogbW92ZSBWRiB0byBzYW1lIG5hbWVzcGFjZSBhcyBuZXR2
c2MNCj4gZGV2aWNlIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYWl5YW5nIFpoYW5nIDxoYWl5YW5n
ekBtaWNyb3NvZnQuY29tPg0KPiANCj4gVGhpcyBsb29rcyBzdHJhbmdlIHRvIG1lLiBTa2ltbWlu
ZyBvdmVyIHRoZSBjb2RlIGl0IGxvb2tzIGxpa2UgdGhhdCB3aXRoDQo+IFZGIHlvdSByZWFsbHkg
ZG9uJ3QgbWVhbiBhIFZpcnR1YWwgRnVuY3Rpb24uLi4NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3
Lg0KIlZGIjogSSBtZWFuICJWaXJ0dWFsIEZ1bmN0aW9uIiBOSUMuDQoNCj4gTG9va2luZyBhdCB0
aGUgYmxhbWVkIGNvbW1pdCwgaXQgbG9va3MgbGlrZSB0aGF0IGhhdmluZyBib3RoIHRoZQ0KPiBz
eW50aGV0aWMgYW5kIHRoZSAiVkYiIGRldmljZSBpbiBkaWZmZXJlbnQgbmFtZXNwYWNlcyBpcyBh
biBpbnRlbmRlZA0KPiB1c2UtY2FzZS4gVGhpcyBjaGFuZ2Ugd291bGQgbWFrZSBzdWNoIHNjZW5h
cmlvIG1vcmUgZGlmZmljdWx0IGFuZCBjb3VsZA0KPiBwb3NzaWJseSBicmVhayBleGlzdGluZyB1
c2UtY2FzZXMuDQoNCk9uIEh5cGVyLVYgLyBBenVyZSBob3N0cywgdGhlIHN5bnRoZXRpYyBOSUMg
KG1hc3RlcikgYW5kIFZGIE5JQyAoc2xhdmUpDQphcmUgdHJhbnNwYXJlbnRseSBib25kZWQsIGFu
ZCBhcHBzIHNob3VsZCBvbmx5IGludGVyYWN0IHdpdGggdGhlDQpzeW50aGV0aWMgTklDIChtYXN0
ZXIpLiBVc2luZyB0aGVtIGF0IHR3byBkaWZmZXJlbnQgbmFtZXNwYWNlcyBpcyBub3QNCmFuIGlu
dGVuZGVkIHVzZSBjYXNlLg0KDQpXZSBoYXZlIHB1Ymxpc2hlZCBkb2N1bWVudHMgZXhwbGFpbmlu
ZyB0aGlzOg0KIlRoZSBzeW50aGV0aWMgYW5kIFZGIGludGVyZmFjZXMgaGF2ZSB0aGUgc2FtZSBN
QUMgYWRkcmVzcy4gVG9nZXRoZXIsIA0KdGhleSBjb25zdGl0dXRlIGEgc2luZ2xlIE5JQyBmcm9t
IHRoZSBzdGFuZHBvaW50IG9mIG90aGVyIG5ldHdvcmsgZW50aXRpZXMgDQp0aGF0IGV4Y2hhbmdl
IHBhY2tldHMgd2l0aCB0aGUgdmlydHVhbCBOSUMgaW4gdGhlIFZNLiAiDQoiSVAgYWRkcmVzc2Vz
IGFyZSBhc3NpZ25lZCBvbmx5IHRvIHRoZSBzeW50aGV0aWMgaW50ZXJmYWNlLiINCmh0dHBzOi8v
bGVhcm4ubWljcm9zb2Z0LmNvbS9lbi11cy9henVyZS92aXJ0dWFsLW5ldHdvcmsvYWNjZWxlcmF0
ZWQtbmV0d29ya2luZy1ob3ctaXQtd29ya3MNCiANCj4gV2h5IGRvIHlvdSB0aGluayBpdCB3aWxs
IGJlIG1vcmUgY29uc2lzdGVudD8gSWYgdGhlIHVzZXIgbW92ZWQgdGhlDQo+IHN5bnRoZXRpYyBk
ZXZpY2UgaW4gYW5vdGhlciBuZXRucywgcG9zc2libHkvbGlrZWx5IHRoZSB1c2VyIGludGVuZGVk
IHRvDQo+IGtlZXAgYm90aCBkZXZpY2VzIHNlcGFyYXRlZC4NCg0KQ29uc2lkZXIgdHdvIENhc2Vz
Og0KQ2FzZSAxKToNCgktIFN5bnRoZXRpYyBOSUMgaXMgb2ZmZXJlZC4NCgktIFJ1biBjb21tYW5k
IHRvIG1vdmUgc3ludGhldGljIE5JQw0KCQlpcCBsaW5rIHNldCA8c3ludGhldGljIE5JQz4gbmV0
bnMgPG5ldyBuYW1lc3BhY2U+DQoJLSBWRiBOSUMgaXMgb2ZmZXJlZC4NCg0KQ2FzZSAyKToNCgkt
IFN5bnRoZXRpYyBOSUMgaXMgb2ZmZXJlZC4NCgktIFZGIE5JQyBpcyBvZmZlcmVkLg0KCS0gUnVu
IGNvbW1hbmQgdG8gbW92ZSBzeW50aGV0aWMgTklDDQoJCWlwIGxpbmsgc2V0IDxzeW50aGV0aWMg
TklDPiBuZXRucyA8bmV3IG5hbWVzcGFjZT4NCg0KVGhlIHByZXZpb3VzIHBhdGNoOiBjMGE0MWI4
ODdjZTYgKCJodl9uZXR2c2M6IG1vdmUgVkYgdG8gc2FtZSBuYW1lc3BhY2UgYXMgbmV0dnNjIGRl
dmljZSIpDQphdXRvbWF0aWNhbGx5IG1vdmVzIHRoZSBWRiB0byB0aGUgbmV3IG5hbWVzcGFjZSBp
biBDYXNlICgxKSwgYnV0IG5vdA0KaW4gQ2FzZSAoMikuDQoNCldpdGggdGhpcyBwYXRjaCwgVkYg
d2lsbCBiZSBhdXRvbWF0aWNhbGx5IG1vdmVkIHRvIHRoZSBuZXcgbmFtZXNwYWNlDQphbHNvIGlu
IHRoZSBDYXNlICgyKS4gU28sIHRoZSBiZWhhdmlvcnMgb2YgQ2FzZSAxICYgMiBiZWNvbWUgY29u
c2lzdGVudC4NClRoaXMgd2lsbCBtYWtlIG91ciBjdXN0b21lcnMgZWFzaWVyIHRvIGZpbmQgYW5k
IGNoZWNrIGlmIFZGIE5JQyBpcw0KcnVubmluZywgYW5kIGl0cyBzdGF0IGRhdGEuDQoNClRoYW5r
cywNCi0gSGFpeWFuZw0KDQo=

