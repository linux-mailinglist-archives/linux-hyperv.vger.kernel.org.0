Return-Path: <linux-hyperv+bounces-8861-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIqXKHAMk2nw1AEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8861-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Feb 2026 13:24:16 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ACF143500
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Feb 2026 13:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83C55300E27F
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Feb 2026 12:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B106230DEC4;
	Mon, 16 Feb 2026 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="a8dI5xI4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011052.outbound.protection.outlook.com [40.107.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847EC2F4A05;
	Mon, 16 Feb 2026 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771244653; cv=fail; b=jL33ou3hE1oC9WHGAgBXoIjlK/xIVoeEtgGeCaODxrjSLjNSkxXCpnY/ycB6gtJiDTFozdik8p8+ODZ7+8zqKTVfKgzfKepzK+g9lL2fSaRtVte0b+aM55tS14Y5qOf3tVDTbdBaXKG6BRqPhO4ur0cTJujIVy3vspY4rw2Kqv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771244653; c=relaxed/simple;
	bh=eX/vv3etr31L+NUWr6UAjZhpOi5/xe6S8zXouiwI5mc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TZIJjcaqFKfNji4o1FNA00C8gPqcJLbt3e/7uEwBAOYXUYrdZ2wWuSkE7LKHVznrUOQnO4pTTBDBcQoXNOo2DzoKeTwDwsjfQPMypctRKd8sYnlRgJqb25qAliRrnvr9t8HM0qX7ecu9o2gyK/13aA+V972V5Q1fhuI/zpRSQ8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=a8dI5xI4; arc=fail smtp.client-ip=40.107.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sx6/gvtCwGQmCdg6iZXE2nZAdXVHG/+auJi8B2FRrfk+j95DZjFb4DQIuWZ30JaadqPMC+Z7Oq7/oqnlA75oYdnV2V8101J5Jp6xahQ7UQx525aBDtaO0s79jV+uXOgEGsxaUeTPFmETBnOMsgx/4YCtKQlwRpL6wmDizyprGnMc78xo7mLRQXhwcwRe2bhvmnQIB8969IQCnHmQudA9FEBC2zV41tn2mZEYmaJXVx2pdEb64ZV62I1kFyBeJ/4Hn7ELAFCMmD9IaDDzGckSZyet81Wfi1c+Jp0eRJ5d9/jimMPBOxQi+WHx+pY41cFitacIfoYwIwGGGEMPkQvsgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpiiZSXZIo6hk+6p2htcso4Z31Aay76knTGTkS5XVzc=;
 b=NJ4VevObJ/FHqERhHOlWb6pXysFMnuNjYWtHLOjpCQGEcbo4ZFob/uBm7Zf7ondFMlms6Kp1z//6QS0JRQ8yxjes4SYzWPg1tlmdNsyGvup4JTLEftbvnM/9NpsqQvoMrbrR5bjMRfX9Ijm96aNy9iq8J4ch65urwqvPQ2da+dHYUxXIVSOQi61LT+Bk70j4BYtp9Lo6bnYh4sjBby5ysPFhDw/ZI4BHzAgyOeD+vQsaHatM8gz2zaOMKsxqvebHp3Q05vwBXxGSn/fE9B449cXH4JAyaNIJEuVT+gsSL9tkeq0NkuKJt5vNCPVcctvUQPSqNs0lmANmORVqW32Stw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpiiZSXZIo6hk+6p2htcso4Z31Aay76knTGTkS5XVzc=;
 b=a8dI5xI4ddD3waCFCRK4f0EgwVwrhuX2J9XtMQXQWV/Rilq7oQhYy2En0/q+LRfrscRVicBA8Wqdpb/oH6LNEXNUsKlW6V+Gj4ZtUKIKW1ylq7pkSe0JOMJFi1P5DOuaObZ5E3ErN9QBuA+xHGrwm0dP+Oi77pLxq8PT7A5Po3D4HNjcKXVows5T20zz9aEYvsCjJbZYLe8QGPmjl2oH2yOo9wldaZMBPOTnqfXXk0lLOD9tXtntc8DnmDbYyrx/dwfZAn1KNTBOvflPGI41xyOc9us8lk4wnTQ+O9wcJByTVuOd/fMYdiXKUq/3n4xWCWzbJL3ZCTIUWy9oK1BOYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DUZPR10MB8236.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 12:24:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 12:24:07 +0000
Message-ID: <4dedb1c0-ae80-404d-ad1c-06f0a29ef566@siemens.com>
Date: Mon, 16 Feb 2026 13:24:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
To: mhklkml@zohomail.com, 'Michael Kelley' <mhklinux@outlook.com>,
 'Florian Bezdeka' <florian.bezdeka@siemens.com>,
 "'K. Y. Srinivasan'" <kys@microsoft.com>,
 'Haiyang Zhang' <haiyangz@microsoft.com>, 'Wei Liu' <wei.liu@kernel.org>,
 'Dexuan Cui' <decui@microsoft.com>, 'Long Li' <longli@microsoft.com>,
 'Thomas Gleixner' <tglx@kernel.org>, 'Ingo Molnar' <mingo@redhat.com>,
 'Borislav Petkov' <bp@alien8.de>, 'Dave Hansen'
 <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 'RT' <linux-rt-users@vger.kernel.org>,
 'Mitchell Levy' <levymitchell0@gmail.com>, skinsburskii@linux.microsoft.com,
 mrathor@linux.microsoft.com, anirudh@anirudhrb.com,
 schakrabarti@linux.microsoft.com, ssengar@linux.microsoft.com
References: <133a95d9-8148-40ea-9acc-edfd8e3ceef4@siemens.com>
 <SN6PR02MB4157B6A9C8BEFA312F0D9D68D499A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <eb5debe8-b7d6-4076-b295-9a02271c2ee6@siemens.com>
 <SN6PR02MB41579F60E39CA2A3CA8A5A75D467A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <1b569fcf3d096066aeb011e21f9c1fe21f7df9b5.camel@siemens.com>
 <SN6PR02MB4157DB59F0F7BFBF56612651D465A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <b084a7b6-c394-4337-82cd-8b9cb911d8d5@siemens.com>
 <005a01dc9d30$a40515e0$ec0f41a0$@zohomail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <005a01dc9d30$a40515e0$ec0f41a0$@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DUZPR10MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 38603db6-9c12-46c0-987a-08de6d5647df
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SW13YXdBZmY0b0FTY2lxaEZEN3IzUW9pNVFTNFJVT0ZaM3o4UnVJamRaek0x?=
 =?utf-8?B?TndRRVBPTkRUNURhY0NMcUIySmh1Z0p6TVpjdXBrd3A5VUVBMm5wMUw0bFJY?=
 =?utf-8?B?RVY4VUtDYlJxT1U0QW8vSi9nOUV2TmFWWWFMWllqSFBjUTBTOTZNZzkraTVW?=
 =?utf-8?B?VzZjOXZDUUJHWGdaQmZaU3d0RkR6dUF4cGIxaG00cjluYnZ1aml1VmxYSW42?=
 =?utf-8?B?RjQ0RktRcXJDdmFsSVI1MG1EYXE3emFrd3Q2Y1BnaFZzOEgwUlk3bHpIa09r?=
 =?utf-8?B?SGFyTy9IZm5ZaXFYMlJyTmVsM0VKR0M3NlFhN0N4cHBFOHV6MHpKa2lQSUZ4?=
 =?utf-8?B?WCtyVDZYUklIVFFMdE5RV05nMmRzV25IbjBGMXR0OHl4MHNkTlArM0ZvSm1m?=
 =?utf-8?B?WDlCTWhtWEFYbjNYclo4QUNHRzZMNmJIYm1lTTF3b2FjY1J0SUFpdGtPWGFn?=
 =?utf-8?B?RnpiV1RHMzlFQnQ1c3U3Y0RkdGk3RmVYK2M3d2FLWjhYeEVvNnBlV2VqK0Y3?=
 =?utf-8?B?REFuTFI4VWlVdXdXUEExc2MwVFdjMkowYTAvS09CcVNuY0NyVElMeGZjMURq?=
 =?utf-8?B?Q1p2cDB6VUtQTmx1eUNuZzEyblRBajRIelMxKzJJelRIbFpiMzZRd29ZY1RC?=
 =?utf-8?B?MU5MN2oxOE0xcFJFbmE0dVJkT3NCTFhELzBrdDhUMEgvT2FuR0NtUnBqQWw4?=
 =?utf-8?B?VGRZSEVQSlg4SnRKUk1VWUdaRlJKWUZ4QmE4MkQ2QnpzUjU4TFVpWXE3N2RM?=
 =?utf-8?B?TXBPUXlJbUZUL0VCZGlXMThvclAyYzdzYlpiWFZwemUvWkRNbzM2OVJYRzlj?=
 =?utf-8?B?ZlNiS0JYWm1peFp4K2xRNnJ6SlR2cjBDK3kvZ05HbHVmNDRQUTIzeGVTdnBT?=
 =?utf-8?B?SmVTUkhabjBPVU9Gdmp6THZiVGUyaWY1TkVrQyt6NDlNSFd5UGQ3K0NsbzVF?=
 =?utf-8?B?amkvTWxzUDljNUE2TXhZdmtlL0pQM2t3Q0NsRGFzYWpxUlY4WnRUWEo1NW9G?=
 =?utf-8?B?OTlQYzBRays4aWRHOWo5WXRpZUtuRlF1MFBNdFVHSEgwVzZyL05heGZMVG1C?=
 =?utf-8?B?UHM1WjNqeGtKRm1DMSt3Ris5UWJCVmFoT0JKYnI4T09weW1sRUJBUFJScUcv?=
 =?utf-8?B?RzY1cWhvRGsyK0p1aE1veVc4Z1hvQXdlWkpSd2tESWJEbWdnSUI2SHdCU0sy?=
 =?utf-8?B?bEN0TVdHUGJGcG9wY1lhN2YzUDJVTVF4RjNlaGtiazdES2VMeENHRllCWllO?=
 =?utf-8?B?SDZIZXZwRHRmZjFidUdYRmk3Ry8wU1pTODJiYk1tZC9nakhWb1UvVFV5TGlu?=
 =?utf-8?B?ajlscnFtZzlnUlNCOUExUHo1R1VMVFRVRFhMTWNFT2dWMjMvZzFKMXdyMWhp?=
 =?utf-8?B?TkhrbUl2QnBjblp5SjNKUEI0VURQcmZ4WHBhOGRXeEh1YmVHK0tjQ2s5ditR?=
 =?utf-8?B?L3AxMXE1VHowQTNKUml6aFlYMkF3eDFIUVRuOWpadGpXTlBoUTk3cWFQZG9s?=
 =?utf-8?B?ZE43U3VZOG5oUzU1UEdML25zTS84VUV0YzBmNUtDTTdObEVkSzgvYmcwcko0?=
 =?utf-8?B?aWxvUG54TWJsOW9oR0N3eFZOb1FHNkZwVFp2cDlKdmRHVTFycWFBNlNNRVNa?=
 =?utf-8?B?anNaalJKQzlNTTVUMWNVUTVpc2REc1lCT1oyaWJ6aDBMdnRrNTg2Nm5ka0hl?=
 =?utf-8?B?ZDNnV1dZcER4RHA5YUhOR1J0dGozSG81VWVKUElURjhFVi9NODR4K1ZoTE9L?=
 =?utf-8?B?VDNYL2VQaVRmQXVwL0xMK0sxRkNXbnVISFdSSkRBSEx4MDFkSGV0TWpSVUlp?=
 =?utf-8?B?WSs0Z2VUTzBLWlFUb3hNalhSekhGaDdSUTh0U1p3Q28rMSs4V0hUaW1qOG1n?=
 =?utf-8?B?aGxVRnFVbFNIUGF3WUNHZHFzcnBmT1JJNkx4Y0hMSU1GT3NraUxRNWlxaXY1?=
 =?utf-8?B?Vk1zblFFKzhyMkVlbUNXeVVjWU1QMXcwSlNwSEFXbWtIaXJuQkhGOWhONExQ?=
 =?utf-8?B?T3h2SC9tK1Q0ZzBESDdRckdYQWc5RWdVMHplUGFMc0dmR29nMTB0K3luekN2?=
 =?utf-8?B?NTh2V3J2QzhiZEZkdWtaSDQ0bHZabGdPTFp3K1l1N2tvSlVuWEtncGUyMlpv?=
 =?utf-8?B?MHhBci9sbXRjbmVkcEJWYWs4RW9wa1NQVTFNLzV2ZlpqSGx4WlZmSyt5NlRy?=
 =?utf-8?B?RUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dENWRmJtMm42dFhsMzBObkR0cEZTa2pycmlYZ0JGZDIwazRVaHNweUZQMUI3?=
 =?utf-8?B?N2svWVViN1dreWpOaW1waFJxdmY1L1pzaEJVOW4zODdnamJ1ZExtV0V2aE10?=
 =?utf-8?B?WlVXaTRqalJaSzBpaklDYXFMMTJ4OHpkZ1FCOS9ZSVQ3cTd0bnkyZ1krNW9V?=
 =?utf-8?B?RlNLRlM5TkloSWxOZXBBWDlUeDA0MmxlK05vRWU5KzhXZXVGOUpBcnBYSmN3?=
 =?utf-8?B?RG9ENkdEKzVhM0pOL3FPSmdUSEV1YVI5ckNZb29HWjlsdjlteWNqZFN5Q3B2?=
 =?utf-8?B?QllkdURHSEU2bU92N1V0Nk1tVlVFUW1kUG81WUx0ajhQdmhtRHIwaytFd3V4?=
 =?utf-8?B?R2pob2FnL3dMTHd5RGx0Mm55VlRoMjFMcmJ5Wm1oeWdpa3ZJL0pVeW1kRkpP?=
 =?utf-8?B?MTgxL0N1ckNmSWdvYTNrb3p4VzNrS1FuaXV4cmQxbUhZV01Vb3F1WFNZdFdI?=
 =?utf-8?B?UHBsdENJUkttOENpNkIzUjZFcTVNeGszNUlNUjNiaDdjSFNpSnJFYkk5SnN0?=
 =?utf-8?B?bmEreW1oeDV3RzM3TEZnbVZGRjZYSUpha0FIUUlBMytpQUFLSEhzQ1RnTjhq?=
 =?utf-8?B?NXVUeVdVRE8yMGV2UmdwMDBqckhSeVJSbVVnTzFUdFJoaWxDdlU4NVR6STR6?=
 =?utf-8?B?ZEJoY1BNODRMMUxpNkVhMjNiS1NsamJxYnA0Q2Z0enllWmtnVGRuZ0RqZUQy?=
 =?utf-8?B?Mnl1ZVlsY29rQlViNDV4Vld6bTg2cG9BL1JOS3hPZU5Md0RlSzZwWE4xWGU3?=
 =?utf-8?B?azNNWXNhVHRzS1QxMkg2b1hPZG8xWFVCSUREdHIwZFR2SjlOcnFQQ2tWU0Vl?=
 =?utf-8?B?eUFPK1pCbHRSdXpHR2JwMVM5R0FxblJjdGpmcmM1YnpzVUY4eGduUGJHaklW?=
 =?utf-8?B?bDdjTlZqM0w1M3dFMTdXZmtlM21Da3k4TVB3SjJ0T0d1SURyR2NRN21EdTUr?=
 =?utf-8?B?LzZST0p4bWpxWTNWYm5mV09HVTlGM0MzeDBPM0k5M3JrTW4xZGE5c2dlaVVa?=
 =?utf-8?B?blFVZUdIVnF4b2NNUWxCYWxtOFFnRGEwOUdkMHVLRC96aXBzUXBBbUtSeUNa?=
 =?utf-8?B?eUVkVThmNmRzN2lTS3V0N1JSMklwOFB3bWE4SFQwQ3JRSzQ0NUUrbTNHSWJY?=
 =?utf-8?B?RWxvdlRzaC9RdmpaSGRVMVlEOEVUbnpiTjJGL2VUcDY4dERCanptcDJxaUdT?=
 =?utf-8?B?cTJHSkVDQWxlWDZlZ2ZkdXQvRVBaUEp5U3hsRnpvbzRvdVdMbHFheS9TVHlZ?=
 =?utf-8?B?anZxSnpVWW93T0Q1QWI5eWxyTHphTmJLcWdxZStxcVVYeUM4R2taNkx6YTM5?=
 =?utf-8?B?ZHRLY0h6Y1hUS1pCcFlJOU96RGFRMjdoVTZJbkdqUWhZVlEyWCtEa3NxTnFE?=
 =?utf-8?B?M29OZ2ZkZE9ZcTFKL0doYmI1T3ExamlBY0NPbWg1L0ZLbmVPbkxjODRZVURt?=
 =?utf-8?B?MmJIWHNLOE9iSjJEM3FBclg4YlhGb3ZqcHM4enl1UjVpUzBxQis0bTJLZ3VV?=
 =?utf-8?B?d01iQzk4MzlhamdWZUtCWWZTM21peDRTYjBEY0lMbmoxZzFBVUI2WGFSK1E2?=
 =?utf-8?B?aDZidTdmOU1jY1hjSUpEUG81TjY3dGNLNjhXcFFRYzVCb2Urejcxek5MV0NX?=
 =?utf-8?B?R1poOFdQK0d4YzZ6M0xCWnFzSWhrZjFBWFV1c1dpd3NmQjhTZVZHa3o1TWFS?=
 =?utf-8?B?bWZYMVJNOUhTZ1lMV0g0Uk02bHhVUGRjdENvejNXaUlKKzBMckgzdnMvaTJp?=
 =?utf-8?B?U1JEMHR4aUgyUFJDTXduOHF2TkYzd2tLQ1FPNlZPbndkMzlVRTNReVg2VmxG?=
 =?utf-8?B?dDM1OFVMaVdUVDlweS9uWkEwZ2Z1aUh6dTZKVzRLTG9Id1hhVHBpMVMwalMz?=
 =?utf-8?B?SXE1Yks0eUxUdmxBMHFHbk05RTRFY25veURLaGFCMjkwZ0E2Uk1tQW5OUjY3?=
 =?utf-8?B?TXBLNEF5a1Y1ZW5IdmVOUENGK08wa3Q5cWkraEJFcStKMkg2MUxhS0M4TitU?=
 =?utf-8?B?RTEzSkVuSzdaVTJxQXhwaXlQcWFZenlnRWszZ05zaTJJS0tZNEpYdFBaRXRz?=
 =?utf-8?B?S08xVjRnMnJmcW85WS9NVjhEYWFORndQZ2Jod3gvNUpRdHlGdWpRVHI5eXBm?=
 =?utf-8?B?ZHN0cVVqVzBSZTY0NzRYS3I4b0loTzg4NElYeml0MmI2c0YzK0tjeDBIYVRM?=
 =?utf-8?B?allXSXdaYklYdEpYRElOUXFnSFBINWtrRmtlemdSNVhRKzA1YmxvQnBFMitw?=
 =?utf-8?B?OHZwUmlVU1h3aHRZK3Z3ZlFqQmhwZUlQSGJBVEZpY3J6eTZBS0Vvb3duNVFC?=
 =?utf-8?B?RmVET3hJMnI1c0IwVmw1MUpDUHVYaDlSNlFOTjF1ZDhuMXpGdTY3Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38603db6-9c12-46c0-987a-08de6d5647df
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 12:24:07.5171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOBJx1Fzhc9FNKfv3wtRWedN1GhlXzQHnd6F9E/E/Woph0ew4xtQKN5DgHvBuWwzu7E4nVRWBDRow9VabHkguw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8236
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8861-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[zohomail.com,outlook.com,siemens.com,microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.microsoft.com,anirudhrb.com];
	DKIM_TRACE(0.00)[siemens.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15ACF143500
X-Rspamd-Action: no action

On 13.02.26 22:35, mhklkml@zohomail.com wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com> Sent: Thursday, February 12, 2026 8:06 AM
>>
>> On 09.02.26 19:25, Michael Kelley wrote:
>>> From: Florian Bezdeka <florian.bezdeka@siemens.com> Sent: Monday, February 9, 2026 2:35 AM
>>>>
>>>> On Sat, 2026-02-07 at 01:30 +0000, Michael Kelley wrote:
>>>>
>>>> [snip]
>>>>>
>>>>> I've run your suggested experiment on an arm64 VM in the Azure cloud. My
>>>>> kernel was linux-next 20260128. I set CONFIG_PREEMPT_RT=y and
>>>>> CONFIG_PROVE_LOCKING=y, but did not add either of your two patches
>>>>> (neither the storvsc driver patch nor the x86 VMBus interrupt handling patch).
>>>>> The VM comes up and runs, but with this warning during boot:
>>>>>
>>>>> [    3.075604] hv_utils: Registering HyperV Utility Driver
>>>>> [    3.075636] hv_vmbus: registering driver hv_utils
>>>>> [    3.085920] =============================
>>>>> [    3.088128] hv_vmbus: registering driver hv_netvsc
>>>>> [    3.091180] [ BUG: Invalid wait context ]
>>>>> [    3.093544] 6.19.0-rc7-next-20260128+ #3 Tainted: G            E
>>>>> [    3.097582] -----------------------------
>>>>> [    3.099899] systemd-udevd/284 is trying to lock:
>>>>> [    3.102568] ffff000100e24490 (&channel->sched_lock){....}-{3:3}, at: vmbus_chan_sched+0x128/0x3b8 [hv_vmbus]
>>>>> [    3.108208] other info that might help us debug this:
>>>>> [    3.111454] context-{2:2}
>>>>> [    3.112987] 1 lock held by systemd-udevd/284:
>>>>> [    3.115626]  #0: ffffd5cfc20bcc80 (rcu_read_lock){....}-{1:3}, at: vmbus_chan_sched+0xcc/0x3b8 [hv_vmbus]
>>>>> [    3.121224] stack backtrace:
>>>>> [    3.122897] CPU: 0 UID: 0 PID: 284 Comm: systemd-udevd Tainted: G            E 6.19.0-rc7-next-20260128+ #3 PREEMPT_RT
>>>>> [    3.129631] Tainted: [E]=UNSIGNED_MODULE
>>>>> [    3.131946] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 06/10/2025
>>>>> [    3.138553] Call trace:
>>>>> [    3.140015]  show_stack+0x20/0x38 (C)
>>>>> [    3.142137]  dump_stack_lvl+0x9c/0x158
>>>>> [    3.144340]  dump_stack+0x18/0x28
>>>>> [    3.146290]  __lock_acquire+0x488/0x1e20
>>>>> [    3.148569]  lock_acquire+0x11c/0x388
>>>>> [    3.150703]  rt_spin_lock+0x54/0x230
>>>>> [    3.152785]  vmbus_chan_sched+0x128/0x3b8 [hv_vmbus]
>>>>> [    3.155611]  vmbus_isr+0x34/0x80 [hv_vmbus]
>>>>> [    3.158093]  vmbus_percpu_isr+0x18/0x30 [hv_vmbus]
>>>>> [    3.160848]  handle_percpu_devid_irq+0xdc/0x348
>>>>> [    3.163495]  handle_irq_desc+0x48/0x68
>>>>> [    3.165851]  generic_handle_domain_irq+0x20/0x38
>>>>> [    3.168664]  gic_handle_irq+0x1dc/0x430
>>>>> [    3.170868]  call_on_irq_stack+0x30/0x70
>>>>> [    3.173161]  do_interrupt_handler+0x88/0xa0
>>>>> [    3.175724]  el1_interrupt+0x4c/0xb0
>>>>> [    3.177855]  el1h_64_irq_handler+0x18/0x28
>>>>> [    3.180332]  el1h_64_irq+0x84/0x88
>>>>> [    3.182378]  _raw_spin_unlock_irqrestore+0x4c/0xb0 (P)
>>>>> [    3.185493]  rt_mutex_slowunlock+0x404/0x440
>>>>> [    3.187951]  rt_spin_unlock+0xb8/0x178
>>>>> [    3.190394]  kmem_cache_alloc_noprof+0xf0/0x4f8
>>>>> [    3.193100]  alloc_empty_file+0x64/0x148
>>>>> [    3.195461]  path_openat+0x58/0xaa0
>>>>> [    3.197658]  do_file_open+0xa0/0x140
>>>>> [    3.199752]  do_sys_openat2+0x190/0x278
>>>>> [    3.202124]  do_sys_open+0x60/0xb8
>>>>> [    3.204047]  __arm64_sys_openat+0x2c/0x48
>>>>> [    3.206433]  invoke_syscall+0x6c/0xf8
>>>>> [    3.208519]  el0_svc_common.constprop.0+0x48/0xf0
>>>>> [    3.211050]  do_el0_svc+0x24/0x38
>>>>> [    3.212990]  el0_svc+0x164/0x3c8
>>>>> [    3.214842]  el0t_64_sync_handler+0xd0/0xe8
>>>>> [    3.217251]  el0t_64_sync+0x1b0/0x1b8
>>>>> [    3.219450] hv_utils: Heartbeat IC version 3.0
>>>>> [    3.219471] hv_utils: Shutdown IC version 3.2
>>>>> [    3.219844] hv_utils: TimeSync IC version 4.0
>>>>
>>>> That matches with my expectation that the same problem exists on arm64.
>>>> The patch from Jan addresses that issue for x86 (only, so far) as we do
>>>> not have a working test environment for arm64 yet.
>>>
>>> OK. I had understood Jan's earlier comments to mean that the VMBus
>>> interrupt problem was implicitly solved on arm64 because of VMBus using
>>> a standard Linux IRQ on arm64. But evidently that's not the case. So my
>>> earlier comment stands: The code changes should go into the architecture
>>> independent portion of the VMBus driver, and not under arch/x86. I
>>> can probably work with you to test on arm64 if need be.
>>>
>>
>> I can move the code, sure, but I still haven't understood what
>> invalidates my assumptions (beside what you observed). vmbus_drv calls
>> request_percpu_irq, and that is - as far as I can see - not injecting
>> IRQF_NO_THREAD. Any explanations welcome.
> 
> I haven't setup detailed debugging on arm64 yet, but in prep for that
> I went looking at the places in the kernel IRQ handling where
> IRQF_NO_THREAD influences behavior. The key function appears to be
> irq_setup_forced_threading(). This function first checks force_irqthreads(),
> which will be "true" when PREEMPT_RT is set. The function then checks
> the IRQF_NO_THREAD flag and the IRQF_PERCPU flag. From what I can
> see, the IRQF_PERCPU flag is treated like the IRQF_NO_THREAD flag, and
> causes forced threading to *not* be done. So the behavior ends up being
> the same as when PREEMPT_RT is not set.
> 
> Since the VMBus interrupt is a per-cpu interrupt, forced threading is not
> done. In that case, the stack trace I reported makes sense. Take a look at
> the code and see if you agree.

Indeed, missed the IRQF_PERCPU impact on auto-threading. I'll rework my
patch to perform the transition arch-independently.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

