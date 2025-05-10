Return-Path: <linux-hyperv+bounces-5452-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F44AAB2541
	for <lists+linux-hyperv@lfdr.de>; Sat, 10 May 2025 22:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432771B65577
	for <lists+linux-hyperv@lfdr.de>; Sat, 10 May 2025 20:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4521122541F;
	Sat, 10 May 2025 20:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B5SuwE9m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EkB167Y+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3856878C9C;
	Sat, 10 May 2025 20:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746910558; cv=fail; b=IrSNdAd6rgK2yDULMNvmLX701qnF11v4Go8Wk/oB7MDny85qjF0rekSHfXwJAFJxVLpjEXHOSsqiH6P7i2GV/hHd9MdkADHMQn4/FcoCt/5jrZ5XrnkmHuM5c9eFKEK6WwiDlSjVSgStfVWQZgtqD1ZTNrLfNglkkVR4eH65yFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746910558; c=relaxed/simple;
	bh=D+qVHGKkx8FtmeDCyYpj2OgPmIYoUrNVgrky/wrXhn8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ikOWimEvK3uM5ZcbqyeifC6J9U2bUK29DPDM4g0KitlDn/TCvNFykcQriA7sGO6jQdBwi8m7iGPKzJxbvXNkk93V0/eiCioUkWJiub7Cf0YWoVwSQ2mVGSkTaasXMSPrzySiSRopf8jRZzasHePrUswKiZpdJ0nK+gVFWVATOKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B5SuwE9m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EkB167Y+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54AGut8C026187;
	Sat, 10 May 2025 20:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZerUtB+Gzz1RGulBBRewEUbzk9kpRDbJc+jeARp8u2Y=; b=
	B5SuwE9mOP0fiT+Qc+5VKTptVcZ0/e5/E7tvH9WEOv79zJXHujAZLrGsDy5xJemO
	1aSZIduvt+3hmm3C+IipUFLF8IERTdpHU6lmTBr7+2P2ChlYKqjk1zm9BVdXizRr
	T6nBvQGXgATYDVwCv+AY/AMxbm3PxHqFoSY89FSzKNXoHFcbO/gMiNFz6FyapAbc
	vTDvZRpf9fEUuE2YiYbnPYgvSkhHQwy0qWHf+ewMROqaPZTHyJvz/c92VKp/AzDd
	XPNGYYZh0z8BNLyZT+dZggsAR9dG+2PbJ/uupeazefTSzN3L77oPjfSE/9q/JHBc
	rtKAwbL37fHS91VfuRnM7w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1d28ek1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 May 2025 20:55:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54AI1gfG037607;
	Sat, 10 May 2025 20:55:41 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010002.outbound.protection.outlook.com [40.93.1.2])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw865yav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 May 2025 20:55:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHo3F3/BDQAoKtlGaM4ZjAXe9BtB4v6nO9os/11mXdtJmfhYhJ8TX58skjljeiK+8zrmfaMdDxMYjbGwhkw6OMcOgv74/sEF7jC54D1RISs27SrxXPU6YiKq0/l9ZSNRg7OgPP7WsC7JrgwjJDgBti43sYABqAsoTtQYCvpmQbUwm5/gsxK6JAL6ldahEAT+mJW9aJimh3YSNG1DABPTkQlq1elM383SOCpt5MAYb9SbZCSaWOCRYnLfFo064wbVq/X74hYYnmfEp6LH0zGcqk610rEdg5e7WZkhaGha8XASR5ToQumUFeRoF29hYPRy+lXQwB9PQIGF/OUW5CyIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZerUtB+Gzz1RGulBBRewEUbzk9kpRDbJc+jeARp8u2Y=;
 b=viqd39u1cbZcDbREN2BxpXJJ5hkfPAGyGzg6ehYF7ub64NLDvPUcs8kWQkK8kr2mWOVrjcK4O/wCgpnELFoRNHBzvESvjGSYn7HsknWtr4WXr2Kh5gDYD8CC+iiCEztxvACcKLPg5e0+QuCb/OzygLSYpIPEtt2pYaiFzcrAEK+Yg4DJZ4La0jc6BEikm+SkGUpBkWaKIebvvasFH6zO0UVZjxmZCP9RLoN0D7TpCypRWBIm9LXIjLwvDjAr1TN85xmeas1CzhlcFp5FnEX8Yj+I48TwfZpLeMBe3+ATnP1Afk3Df5BEEuqpVDgdb2wwFVb2Wy1LQ3GdvrxWNJCCxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZerUtB+Gzz1RGulBBRewEUbzk9kpRDbJc+jeARp8u2Y=;
 b=EkB167Y+mzvGk6Ego5xjGp+fRVkOTkFEKSCvZlNwkDYDHIhP7e3Iwb6fakx6tKTbDfHN2ePwYzU9Qg39PmRjQAEYgmvutF1YhLWKA1F6/xrpMyu9AKHH/rx0vdk4CuV0LL30k++jQBenyIgZSRbBVI+rhL7czbUyl6jmnTNk8Zg=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CH3PR10MB7564.namprd10.prod.outlook.com (2603:10b6:610:17d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Sat, 10 May
 2025 20:55:39 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Sat, 10 May 2025
 20:55:38 +0000
Message-ID: <a8e95da8-ab80-4581-b8b4-136a09f9f3f2@oracle.com>
Date: Sun, 11 May 2025 02:25:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH] Drivers: hv: Introduce mshv_vtl driver
To: Naman Jain <namjain@linux.microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <20250506084937.624680-1-namjain@linux.microsoft.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250506084937.624680-1-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0046.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::10) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CH3PR10MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 46353456-6566-448e-c26b-08dd90050480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0FCMHRVL2tCU04ycjB5bTFJME51Qm56dnEwaVNXNWJyc2p0QnVobEpqOFJz?=
 =?utf-8?B?WnVzbXhjS2lTMjRSWnY5L09BSGo3OVFhR3dVTmgyOTUwOExFUW1PSi9NdUVY?=
 =?utf-8?B?S0V3VFZkTEM5UXBRb1N1TEtiL3grRkpMN3ZtYlQwQU5RNkJVZktpa3JsamZS?=
 =?utf-8?B?cW1IY3dwWktBTnFISWxJY0pzOTVHTFBUSzZiUWFUR0NZUTVhMGVwUUNJSEVk?=
 =?utf-8?B?RndndDEvcjZFcWh4dldjbm9zS2JEN2FFMk50RGhia0xJWGo1SUR1by92M3dy?=
 =?utf-8?B?dnhxYVhENmxUWGhhZElTMlJpWmRpbFNLaGdZZ2dERkc2Y0tJUCs5SGFXTUhh?=
 =?utf-8?B?NGlmM09Vc05lRVowdGVvN2hXMEJjMmNocGY3SGppYjVBWVhmaHR2MTBCREdB?=
 =?utf-8?B?YS91K0d0enhrSjdpM1oxUi8xaG5uM2tmL2FKU1p5MjZnWkppR2Y2bVJjT0pS?=
 =?utf-8?B?ZUhHUmdKN1VTUW1ydGpvRnBiUnpnVmU0L3dYSnFQR2NMMlZxLzNKeVI0bko4?=
 =?utf-8?B?M3Y5eXg1NEJsMWVsSWhSQktnMVp2a2txaUlzL2c2cFdkS1NER1l2QzRhOTJn?=
 =?utf-8?B?RnhlNER0Q0haZ290YmpET0FXUmlCVlQ0T0tmLy9LcGFjZXlHcGx4dzlzTTFa?=
 =?utf-8?B?VlhxYXdBS21JZG5odDJpN245SXpQWUxSY2J3UktLYTdSMllCNFBWSGFqVTFo?=
 =?utf-8?B?UmJUMXptOFErdlB4SENocWUyZENQaUU5ZmM1T3JJVnloaDVCZ1pqMFB4WWgx?=
 =?utf-8?B?UVNWU2RNYU5HZTNabXFJS0VUMmNoRUdjd1pjYlVySDR2L2kzTlhBSWt2Yk5X?=
 =?utf-8?B?V3JjN0lLU0RNRHd2SzRrNWxqbG9EVTVZQ1NWblJnbVBKQVY5R0Mwb0owVDg1?=
 =?utf-8?B?RDRnRXF5ZXByR05aQmlCU3VodWQyakVTSWZWU1kwblRnVzdHMERZOVQzM3JT?=
 =?utf-8?B?b2VGQ1luR3M1b3J1V0N1K3ZSR0hRRTFYcVdYZFlwSkpRdGJPMndrK1QwR0NQ?=
 =?utf-8?B?cFdFNlJNZ2ZaZi9RN2RRd0pVbUduT2Z0NGgyNlpwN0ZNQXhGWGRaOWNUVFRT?=
 =?utf-8?B?S3pnS1MrUDhuZWJ2MnF1ajNkakh6TUN6b3BTcy91M0ErclFad0gxbC9KZ0pV?=
 =?utf-8?B?M2FNTGdQdTVKOHdJcTczaTNFdkVxLzMyVFNQQ2d3QTNpL3JTT0JoQzZxbFRN?=
 =?utf-8?B?VkFVdi84MDlnVzRQUzArRm5tZWJSd1FGZXFQc0IyYnJCcDNpcTI4czgxZDZk?=
 =?utf-8?B?YXRUa1FVQitVUDRoeXd1NWxJYStlMVBkYXdmV1p4NzdiZWNJT2FWYUNDR3Uz?=
 =?utf-8?B?cy9HQVZXUW1McTBhSm1PeW54cnhKSUlWb3BCZjRFSjdVSnJkSmZ0YUl2WFBF?=
 =?utf-8?B?cmNOS3p0NjhEQ29ieXIvS2ZLMk9Wc2Jlc2twVmdOVnQ4ajFEZzZ6Q0Z4dFFD?=
 =?utf-8?B?UWJwRzZvRVNLL2RDaDFremVpOTl3OXRoSklBN3k2M2ZaWDFDT2Q1T1NHK3RQ?=
 =?utf-8?B?VDFLcmJUMCtRRDVqa1kwMytWSUN3QWVIcEhWeVFvS1N3UHFiVHRDZG03Ky9D?=
 =?utf-8?B?ekd2eUdoSHF2eUYvM20wNjkwZFp1LzFIdExIZjlxa0tXTk5telZ3MGtlRExV?=
 =?utf-8?B?YXBzRDZjRy9JMmdJZW5YK2lKaUlDTWJ1VmR0eXdsOW5nWEc3T0RGazBUWTUy?=
 =?utf-8?B?Sm1mczZ6M1RpSDdvbmRRQzRSM3FFMHlQZGNZSUFQRzVMYUxKbHhVemR4bFU2?=
 =?utf-8?B?bDRkVTBySFVVbEswMW1TdlFrREM2SzcvenllQldRL0gzRE9rMnd6SGNpY01R?=
 =?utf-8?Q?sLuP7B8tZIHuPDmenCRjE9d3BEkMf3d1h68t4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0lSY2YvdjlvM051ZjJCSE1hdjFVVjFjOUxPV3BLQ0lDbE9ERUNmRFA1bzE2?=
 =?utf-8?B?bHVaRms2dEtFT3JIRUlzQTdZcWNyV29tdTRFNCtUSHlYTVVCT0hhTDBRNkJs?=
 =?utf-8?B?aHNmQkVybkNHYlZqNGtpb0JiNHNyY0MzVW5ma1hSUWZCeDRqVlFnRnJadjJX?=
 =?utf-8?B?bFhTM01wTFptYnI5OU13ZFJKeFdiS1FISmpVY1hQdnZCc25EQUxOVWhDMkZa?=
 =?utf-8?B?Sm9JWkxFYlk5RTRWQUNZMXdlMzN3TDg4YjRhek5VSFJZVU5SOEE0RkJXY2Jk?=
 =?utf-8?B?WnhQZTRET1RYeDByUndJQkNLWkl6RTk5SHhocUlKYStFZ1BZbjNnTnZkMDRE?=
 =?utf-8?B?Mk15TER1a2FyVGpiVVJGOVd0eTJjcmVoRFYxZGpYQ2RUVTZuTkMxbXNDSXh0?=
 =?utf-8?B?dXhMajFEYXcyVjFuelpMU0FVM2p6eTdkRld2NmUwUGZrVzVoaWtMWS9YcjBr?=
 =?utf-8?B?cGhmQ3UvRjR4UVdkd1k3TFdwLzBtdzNleUVmVmNXUHZTMXowYUh3ZWRpSFUx?=
 =?utf-8?B?N2YrbXRFM0x6MXNxbGgxRXA0cXhXSEF1R0xNNis5cm1OMTVDMUVCblUxVzJW?=
 =?utf-8?B?RVFpTlQyNFlWV0tjZkt5em9sdG94V1FXZ3NZcWJPTkVlYnFLdFE4UGJzRW51?=
 =?utf-8?B?bE5tM1h3SW1CZHFkbnBKZ2h3WnZhZWxNU0pQRGVwZ3FFZU5PL3ZnMEMyVzFl?=
 =?utf-8?B?YjBUdWtuK3NNMUJJYlh3ODVndzRnZmZSZDgzclZsNG8rMjlHSDdrR2U1UXFT?=
 =?utf-8?B?dWduWVZueUFUblpVUVJ2aFVNcitIK2dhU0NFT0lzNmErZWZyaVE1V2RmU2Zk?=
 =?utf-8?B?aUdwODhtL055M0RzYTR6Z0VOcEpPaUNDKzJJc0pyMFpoejQzaFQyYStpWXFy?=
 =?utf-8?B?ZUNvT1BGRU9JN3QvVkJQdXRHaSt1VzFFVVlyNVVxalNYWVp3MFkxYkFOM0JI?=
 =?utf-8?B?andyTjE4c1ZtdWhoNkZRRGMxRFhaOHVqdW5NUVd5bzI4eGI2dllJL1lURnU0?=
 =?utf-8?B?UUVSWVRkQU1Pa2E5ZkFoQVdQR2FrNWczQXRFK1E3a2c0R0hYV2l0M3FqQ3Ur?=
 =?utf-8?B?N3QweWZveEM2NG5BZlRHTDN1bEMxOGhncTc0YlRIQ3FkRnhBMlJQUENWVFZn?=
 =?utf-8?B?Q1lGMDBhK2dDMFRzem9sRHNkbjBKM1lyeEZQTG9YeHFtKzNwblZsNi9UOFFG?=
 =?utf-8?B?WjJUdjZ5Y1pmelROOTk1NXBLeHF3OGFTekRlVndNQll5enNyWE5XZkhMcUxV?=
 =?utf-8?B?K0h5S1lqcWVQZVNGOThKL29JQ0hneGtjMUxENmNmcDgrMUVCbm1RR3N0TFlM?=
 =?utf-8?B?WTNYenN4RjNhMC92c1B5VlJvbUhQM3gwOEdjZC96TCtqRmpoK0pFS1hpYzNa?=
 =?utf-8?B?Y0NpL3d6UkpBRVBsS0R1cjlKS3VCb2RDWnlaKytHWWhvTUxhZWVqL3dKV1Fl?=
 =?utf-8?B?a3lCblBmd1M0Q1g5cVlLdHNsRHVhMGwyVEJKZVQ4OTlmZGhqcXg3RDNoeEdG?=
 =?utf-8?B?Wm53c3ROVS9xSzVZdkxCZW9tdmcrVmhFSkFMRTVRYVRSdFBKYVBEU2xRRXM2?=
 =?utf-8?B?c1ZpQzRkWjloQWJrVjJsV21CMWxnb1k0azlIYUM2c1NwTk1MQ2tuWTE4Sm5U?=
 =?utf-8?B?U0MyeitSbkZGdXY5M3dVYlRwM0s1dzBLenpiNWRXVm1NVzdJMm9DUXlZUWpH?=
 =?utf-8?B?em4wRHFRZnh1ejdTTUJjdE02bk45TGNIZDVsOHpYTUVxVGRrdnVZa3U3dWow?=
 =?utf-8?B?Z0IweTF4ZWFjRWZoQ2ltVEpQbTUyaGJ1d2lKQzNSVHRIRmtUYS9VQndZRHdN?=
 =?utf-8?B?SkpjU2JJRU5rVk81TWNBMU1nK0R1bU82citOVlVqZXVOOEVOU2E5a3JmRmZw?=
 =?utf-8?B?RXQxSEFpeHEwS2UwcVVyeVFpUUU2c2hZZVRkM1Avam0rdUdPYzRyeEV1Q3F2?=
 =?utf-8?B?Qk4raFgvL0NibmV5TXJxUTlGSzZuTjVKVFR3aXdidVkrbDNtdVRjQjRubzFS?=
 =?utf-8?B?ZUQ1N2theXliZkorK094SG51bmMwVnFJVGNCeUc1WE84OWVZTFRISC84Y0VE?=
 =?utf-8?B?TVZmRWZhM01kbndGeXJrdm5qSVF0V01MQWZUbTJBSFBjUFZoRFpwdE43Smly?=
 =?utf-8?B?VlhGakozR2dDMUFCTTVEWXZ5eUpKM05IR0dwb1krenZUQnpLaTZtbHN6eTVt?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dFX4rYpL1zV4RVHuwc/lIrqAvz9ahvTVff43OCJLzBak/oTmMWGuPzQmj3c1InhdR/v33tkcyEjTHWcCcWWSSGJt9gmUQ1ncaugMzVYzyCPHAoYyMWyUsylQxzhVX6UVQXxzvwg4bYYx8HyU5QhJJ1euMIJ1KX5XW1TE1K1pPUCtEJnVDBYM6lP+acAHj+x5isn8dcrSR8wwM4+WdxWkR+PdlluLwSh7BQzVAqzPv/nnLL8XwY7nMH5vBCS4DEG+ZCpQTCEJM/nPwlw/WMv074j1wu0X3pxmdvyd+PTUV3BmdD4m9l1UgUm4CEgZrkUZcCh09HGSolPtdvO3rMr9pL+cJfKPGy4XBm9YFATJeHab9GJ2+3cpQpvkxCPC5O2bh4SNm6w63nHWARyz4i55PBAjc5eROz0CZI4PzktxZqC3rZnHclsqrFTpu29Aeoa7JQtNESJ1KldqThs+BC7fLE2Q4LcC/n1dzZAzJo13YfGSOxZ5P+OiMgIR8RTVfVslw+1cAeABdQGuy4M9F2lyFgPAHxLswwhI0aHK9oLQzn7QWj071/BiWpNmXche95OwBFBE63BUtedzCg/NAr0vjfo00+QCDFHTYzqoDF0yYZ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46353456-6566-448e-c26b-08dd90050480
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2025 20:55:38.7617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MRBLYnpKMfWSXfGzu/WMU/F+MlQu2CYUCT5mc2tcPYY//nNshQtf4slvED19jSlUBv+Wtrmxvv5lIxg+hlqvRMPsGRM4ZHaQyhQF85yl3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7564
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-10_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505100216
X-Proofpoint-ORIG-GUID: h9mkPekoLoh2MZ0vSkBy6Z9pk9FhttDB
X-Proofpoint-GUID: h9mkPekoLoh2MZ0vSkBy6Z9pk9FhttDB
X-Authority-Analysis: v=2.4 cv=XNcwSRhE c=1 sm=1 tr=0 ts=681fbd4e b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=ZFN0griWAAAA:8 a=yMhMjlubAAAA:8 a=n8WjZE4snUHQ-fmtsD0A:9 a=QEXdDO2ut3YA:10 a=ghK585u1ejaZrkaFSurp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEwMDIxNSBTYWx0ZWRfX05TXuP6WcNOi pQOEHMUTbCBBj9x5fKfpL8C0YXVbbiOSpcX/JwT1Ck9jbQW5IMWoQrrk2G4F1UYC4mfSPmBUOaO 27a50UP+c8wQo0/7ZbLH0KojjH9LKvpAbp07U78bJQ3zG28yfqIyhdwuDc/RTwKOSLfNomS6u/5
 jiUqHsw5FnictZ1lCCnvhJLgMMiq5NdfdEKnfbixGyZahJcMDT0hK/QblF8NDdHWBTCM4Ime0tF 3lFVphRPIvDdJJgFW36znpaDxtcN5T/qhLCeDFpKtFCmoelCKGeDrJSw8aQ5aJzqke1ySxw936e ixE3UKdGFQh39Emt4I0APmFi4t3nGVNS3Cj7T4W10MTZy/K2Ot3ilHS/QKxybLmuCpTXOin+tOQ
 0JnK2sGxJ1usBn4J8IZ4fgMrli8ddcQN5qHnINDPgrAhgqnRwMv5KOkUnaEAjv8aEyN7y1J5



On 06-05-2025 14:19, Naman Jain wrote:
> Provide an interface for Virtual Machine Monitor like OpenVMM and its
> use as OpenHCL paravisor to control VTL0 (Virtual trust Level).
> Expose devices and support IOCTLs for features like VTL creation,
> VTL0 memory management, context switch, making hypercalls,
> mapping VTL0 address space to VTL2 userspace, getting new VMBus
> messages and channel events in VTL2 etc.
> 
> Co-developed-by: Roman Kisel <romank@linux.microsoft.com>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
> 
> OpenVMM : https://urldefense.com/v3/__https://openvmm.dev/guide/__;!!ACWV5N9M2RV99hQ!JP9UlleLto2qc_MQzB8ehw1vxtg1wE6rkxawFxyrIWJPPUOdoUk5fpa89l-uhlMNKAdgnWdKXhj5g1AEuVZImYkjDA$
> 
> ---
>   drivers/hv/Kconfig          |   20 +
>   drivers/hv/Makefile         |    3 +
>   drivers/hv/hv.c             |    2 +
>   drivers/hv/hyperv_vmbus.h   |    1 +
>   drivers/hv/mshv_vtl.h       |   52 ++
>   drivers/hv/mshv_vtl_main.c  | 1749 +++++++++++++++++++++++++++++++++++
>   drivers/hv/vmbus_drv.c      |    3 +-
>   include/hyperv/hvgdk_mini.h |   81 ++
>   include/hyperv/hvhdk.h      |    1 +
>   include/uapi/linux/mshv.h   |   83 ++
>   10 files changed, 1994 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/hv/mshv_vtl.h
>   create mode 100644 drivers/hv/mshv_vtl_main.c
> 
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 6c1416167bd2..57dcfcb69b88 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -72,4 +72,24 @@ config MSHV_ROOT
>   
>   	  If unsure, say N.
>   
> +config MSHV_VTL
> +	bool "Microsoft Hyper-V VTL driver"
> +	depends on HYPERV && X86_64
> +	depends on TRANSPARENT_HUGEPAGE
> +	depends on OF
> +	# MTRRs are not per-VTL and are controlled by VTL0, so don't look at or mutate them.

# MTRRs are controlled by VTL0, and are not specific to individual VTLs.
# Therefore, do not attempt to access or modify MTRRs here.

> +	depends on !MTRR
> +	select CPUMASK_OFFSTACK
> +	select HYPERV_VTL_MODE
> +	default n
> +	help
> +	  Select this option to enable Hyper-V VTL driver support.
> +	  This driver provides interfaces for Virtual Machine Manager (VMM) running in VTL2
> +	  userspace to create VTLs and partitions, setup and manage VTL0 memory and
> +	  allow userspace to make direct hypercalls. This also allows to map VTL0's address
> +	  space to a usermode process in VTL2 and supports getting new VMBus messages and channel
> +	  events in VTL2.
> +
> +	  If unsure, say N.
> +
>   endmenu
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index 976189c725dc..5e785dae08cc 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_HYPERV)		+= hv_vmbus.o
>   obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
>   obj-$(CONFIG_HYPERV_BALLOON)	+= hv_balloon.o
>   obj-$(CONFIG_MSHV_ROOT)		+= mshv_root.o
> +obj-$(CONFIG_MSHV_VTL)          += mshv_vtl.o
>   
>   CFLAGS_hv_trace.o = -I$(src)
>   CFLAGS_hv_balloon.o = -I$(src)
> @@ -18,3 +19,5 @@ mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
>   # Code that must be built-in
>   obj-$(subst m,y,$(CONFIG_HYPERV)) += hv_common.o
>   obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o mshv_common.o
> +
> +mshv_vtl-y := mshv_vtl_main.o mshv_common.o
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 308c8f279df8..11e8096fe840 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -25,6 +25,7 @@
>   
>   /* The one and only */
>   struct hv_context hv_context;
> +EXPORT_SYMBOL_GPL(hv_context);
>   
>   /*
>    * hv_init - Main initialization routine.
> @@ -93,6 +94,7 @@ int hv_post_message(union hv_connection_id connection_id,
>   
>   	return hv_result(status);
>   }
> +EXPORT_SYMBOL_GPL(hv_post_message);
>   
>   int hv_synic_alloc(void)
>   {
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 0b450e53161e..b61f01fc1960 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -32,6 +32,7 @@
>    */
>   #define HV_UTIL_NEGO_TIMEOUT 55
>   
> +void vmbus_isr(void);
>   
>   /* Definitions for the monitored notification facility */
>   union hv_monitor_trigger_group {
> diff --git a/drivers/hv/mshv_vtl.h b/drivers/hv/mshv_vtl.h
> new file mode 100644
> index 000000000000..f350e4650d7b
> --- /dev/null
> +++ b/drivers/hv/mshv_vtl.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _MSHV_VTL_H
> +#define _MSHV_VTL_H
> +
> +#include <linux/mshv.h>
> +#include <linux/types.h>
> +#include <asm/fpu/types.h>
> +
> +struct mshv_vtl_cpu_context {
> +	union {
> +		struct {
> +			u64 rax;
> +			u64 rcx;
> +			u64 rdx;
> +			u64 rbx;
> +			u64 cr2;
> +			u64 rbp;
> +			u64 rsi;
> +			u64 rdi;
> +			u64 r8;
> +			u64 r9;
> +			u64 r10;
> +			u64 r11;
> +			u64 r12;
> +			u64 r13;
> +			u64 r14;
> +			u64 r15;
> +		};
> +		u64 gp_regs[16];
> +	};
> +
> +	struct fxregs_state fx_state;
> +};
> +
> +struct mshv_vtl_run {
> +	u32 cancel;
> +	u32 vtl_ret_action_size;
> +	u32 pad[2];
> +	char exit_message[MSHV_MAX_RUN_MSG_SIZE];
> +	union {
> +		struct mshv_vtl_cpu_context cpu_context;
> +
> +		/*
> +		 * Reserving room for the cpu context to grow and be
> +		 * able to maintain compat with user mode.

here compat, sound like typo to compact.
To improve clarity and ensure correctness
"Reserving room for the cpu context to grow and to maintain 
compatibility with user mode."

> +		 */
> +		char reserved[1024];
> +	};
> +	char vtl_ret_actions[MSHV_MAX_RUN_MSG_SIZE];
> +};
> +
> +#endif /* _MSHV_VTL_H */
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> new file mode 100644
> index 000000000000..95db29472fc8
> --- /dev/null
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -0,0 +1,1749 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Microsoft Corporation.
> + *
> + * Author:
> + *   Roman Kisel <romank@linux.microsoft.com>
> + *   Saurabh Sengar <ssengar@linux.microsoft.com>
> + *   Naman Jain <namjain@linux.microsoft.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/miscdevice.h>
> +#include <linux/anon_inodes.h>
> +#include <linux/pfn_t.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/count_zeros.h>
> +#include <linux/eventfd.h>
> +#include <linux/poll.h>
> +#include <linux/file.h>
> +#include <linux/vmalloc.h>
> +#include <asm/debugreg.h>
> +#include <asm/mshyperv.h>
> +#include <trace/events/ipi.h>
> +#include <uapi/asm/mtrr.h>
> +#include <uapi/linux/mshv.h>
> +#include <hyperv/hvhdk.h>
> +
> +#include "../../kernel/fpu/legacy.h"
> +#include "mshv.h"
> +
> +#include "mshv_vtl.h"
> +#include "hyperv_vmbus.h"
> +
> +MODULE_AUTHOR("Microsoft");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Microsoft Hyper-V VTL Driver");
> +
> +#define MSHV_ENTRY_REASON_LOWER_VTL_CALL     0x1
> +#define MSHV_ENTRY_REASON_INTERRUPT          0x2
> +#define MSHV_ENTRY_REASON_INTERCEPT          0x3
> +
> +#define MAX_GUEST_MEM_SIZE	BIT_ULL(40)
> +#define MSHV_PG_OFF_CPU_MASK	0xFFFF
> +#define MSHV_REAL_OFF_SHIFT	16
> +#define MSHV_RUN_PAGE_OFFSET	0
> +#define MSHV_REG_PAGE_OFFSET	1
> +#define VTL2_VMBUS_SINT_INDEX	7
> +
> +static struct device *mem_dev;
> +
> +static struct tasklet_struct msg_dpc;
> +static wait_queue_head_t fd_wait_queue;
> +static bool has_message;
> +static struct eventfd_ctx *flag_eventfds[HV_EVENT_FLAGS_COUNT];
> +static DEFINE_MUTEX(flag_lock);
> +static bool __read_mostly mshv_has_reg_page;
> +
> +struct mshv_vtl_hvcall_fd {
> +	u64 allow_bitmap[2 * PAGE_SIZE];
> +	bool allow_map_intialized;
> +	/*
> +	 * Used to protect hvcall setup in IOCTLs
> +	 */
> +	struct mutex init_mutex;
> +	struct miscdevice *dev;
> +};
> +
> +struct mshv_vtl_poll_file {
> +	struct file *file;
> +	wait_queue_entry_t wait;
> +	wait_queue_head_t *wqh;
> +	poll_table pt;
> +	int cpu;
> +};
> +
> +struct mshv_vtl {
> +	struct device *module_dev;
> +	u64 id;
> +	refcount_t ref_count;
> +};
> +
> +union mshv_synic_overlay_page_msr {
> +	u64 as_u64;
> +	struct {
> +		u64 enabled: 1;
> +		u64 reserved: 11;
> +		u64 pfn: 52;
> +	};
> +};
> +
> +union hv_register_vsm_capabilities {
> +	u64 as_uint64;
> +	struct {
> +		u64 dr6_shared: 1;
> +		u64 mbec_vtl_mask: 16;
> +		u64 deny_lower_vtl_startup: 1;
> +		u64 supervisor_shadow_stack: 1;
> +		u64 hardware_hvpt_available: 1;
> +		u64 software_hvpt_available: 1;
> +		u64 hardware_hvpt_range_bits: 6;
> +		u64 intercept_page_available: 1;
> +		u64 return_action_available: 1;
> +		u64 reserved: 35;
> +	} __packed;
> +};
> +
> +union hv_register_vsm_page_offsets {
> +	struct {
> +		u64 vtl_call_offset : 12;
> +		u64 vtl_return_offset : 12;
> +		u64 reserved_mbz : 40;
> +	};
> +	u64 as_uint64;
> +} __packed;
> +
> +struct mshv_vtl_per_cpu {
> +	struct mshv_vtl_run *run;
> +	struct page *reg_page;
> +};
> +
> +static struct mutex mshv_vtl_poll_file_lock;
> +static union hv_register_vsm_page_offsets mshv_vsm_page_offsets;
> +static union hv_register_vsm_capabilities mshv_vsm_capabilities;
> +
> +static DEFINE_PER_CPU(struct mshv_vtl_poll_file, mshv_vtl_poll_file);
> +static DEFINE_PER_CPU(unsigned long long, num_vtl0_transitions);
> +static DEFINE_PER_CPU(struct mshv_vtl_per_cpu, mshv_vtl_per_cpu);
> +
> +static const struct file_operations mshv_vtl_fops;
> +
> +static long
> +mshv_ioctl_create_vtl(void __user *user_arg, struct device *module_dev)
> +{
> +	struct mshv_vtl *vtl;
> +	struct file *file;
> +	int fd;
> +
> +	vtl = kzalloc(sizeof(*vtl), GFP_KERNEL);
> +	if (!vtl)
> +		return -ENOMEM;
> +
> +	fd = get_unused_fd_flags(O_CLOEXEC);
> +	if (fd < 0)
> +		return fd;
> +	file = anon_inode_getfile("mshv_vtl", &mshv_vtl_fops,
> +				  vtl, O_RDWR);
> +	if (IS_ERR(file))
> +		return PTR_ERR(file);
> +	refcount_set(&vtl->ref_count, 1);
> +	vtl->module_dev = module_dev;
> +
> +	fd_install(fd, file);
> +
> +	return fd;
> +}
> +
> +static long
> +mshv_ioctl_check_extension(void __user *user_arg)
> +{
> +	u32 arg;
> +
> +	if (copy_from_user(&arg, user_arg, sizeof(arg)))
> +		return -EFAULT;
> +
> +	switch (arg) {
> +	case MSHV_CAP_CORE_API_STABLE:
> +		return 0;
> +	case MSHV_CAP_REGISTER_PAGE:
> +		return mshv_has_reg_page;
> +	case MSHV_CAP_VTL_RETURN_ACTION:
> +		return mshv_vsm_capabilities.return_action_available;
> +	case MSHV_CAP_DR6_SHARED:
> +		return mshv_vsm_capabilities.dr6_shared;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static long
> +mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
> +{
> +	struct miscdevice *misc = filp->private_data;
> +
> +	switch (ioctl) {
> +	case MSHV_CHECK_EXTENSION:
> +		return mshv_ioctl_check_extension((void __user *)arg);
> +	case MSHV_CREATE_VTL:
> +		return mshv_ioctl_create_vtl((void __user *)arg, misc->this_device);
> +	}
> +
> +	return -ENOTTY;
> +}
> +
> +static const struct file_operations mshv_dev_fops = {
> +	.owner		= THIS_MODULE,
> +	.unlocked_ioctl	= mshv_dev_ioctl,
> +	.llseek		= noop_llseek,
> +};
> +
> +static struct miscdevice mshv_dev = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name = "mshv",
> +	.fops = &mshv_dev_fops,
> +	.mode = 0600,
> +};
> +
> +static struct mshv_vtl_run *mshv_vtl_this_run(void)
> +{
> +	return *this_cpu_ptr(&mshv_vtl_per_cpu.run);
> +}
> +
> +static struct mshv_vtl_run *mshv_vtl_cpu_run(int cpu)
> +{
> +	return *per_cpu_ptr(&mshv_vtl_per_cpu.run, cpu);
> +}
> +
> +static struct page *mshv_vtl_cpu_reg_page(int cpu)
> +{
> +	return *per_cpu_ptr(&mshv_vtl_per_cpu.reg_page, cpu);
> +}
> +
> +static void mshv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu)
> +{
> +	struct hv_register_assoc reg_assoc = {};
> +	union mshv_synic_overlay_page_msr overlay = {};
> +	struct page *reg_page;
> +	union hv_input_vtl vtl = { .as_uint8 = 0 };
> +
> +	reg_page = alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_RETRY_MAYFAIL);
> +	if (!reg_page) {
> +		WARN(1, "failed to allocate register page\n");
> +		return;
> +	}
> +
> +	overlay.enabled = 1;
> +	overlay.pfn = page_to_phys(reg_page) >> HV_HYP_PAGE_SHIFT;
> +	reg_assoc.name = HV_X64_REGISTER_REG_PAGE;
> +	reg_assoc.value.reg64 = overlay.as_u64;
> +
> +	if (hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> +				     1, vtl, &reg_assoc)) {
> +		WARN(1, "failed to setup register page\n");
> +		__free_page(reg_page);
> +		return;
> +	}
> +
> +	per_cpu->reg_page = reg_page;
> +	mshv_has_reg_page = true;
> +}
> +
> +static void mshv_vtl_synic_enable_regs(unsigned int cpu)
> +{
> +	union hv_synic_sint sint;
> +
> +	sint.as_uint64 = 0;
> +	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> +	sint.masked = false;
> +	sint.auto_eoi = hv_recommend_using_aeoi();
> +
> +	/* Enable intercepts */
> +	if (!mshv_vsm_capabilities.intercept_page_available)
> +		hv_set_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
> +			   sint.as_uint64);
> +
> +	/* VTL2 Host VSP SINT is (un)masked when the user mode requests that */
> +}
> +
> +static int mshv_vtl_get_vsm_regs(void)
> +{
> +	struct hv_register_assoc registers[2];
> +	union hv_input_vtl input_vtl;
> +	int ret, count = 2;
> +
> +	input_vtl.as_uint8 = 0;
> +	registers[0].name = HV_REGISTER_VSM_CODE_PAGE_OFFSETS;
> +	registers[1].name = HV_REGISTER_VSM_CAPABILITIES;
> +
> +	ret = hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> +				       count, input_vtl, registers);
> +	if (ret)
> +		return ret;
> +
> +	mshv_vsm_page_offsets.as_uint64 = registers[0].value.reg64;
> +	mshv_vsm_capabilities.as_uint64 = registers[1].value.reg64;
> +
> +	return ret;
> +}
> +
> +static int mshv_vtl_configure_vsm_partition(struct device *dev)
> +{
> +	union hv_register_vsm_partition_config config;
> +	struct hv_register_assoc reg_assoc;
> +	union hv_input_vtl input_vtl;
> +
> +	config.as_u64 = 0;
> +	config.default_vtl_protection_mask = HV_MAP_GPA_PERMISSIONS_MASK;
> +	config.enable_vtl_protection = 1;
> +	config.zero_memory_on_reset = 1;
> +	config.intercept_vp_startup = 1;
> +	config.intercept_cpuid_unimplemented = 1;
> +
> +	if (mshv_vsm_capabilities.intercept_page_available) {
> +		dev_dbg(dev, "using intercept page\n");
> +		config.intercept_page = 1;
> +	}
> +
> +	reg_assoc.name = HV_REGISTER_VSM_PARTITION_CONFIG;
> +	reg_assoc.value.reg64 = config.as_u64;
> +	input_vtl.as_uint8 = 0;
> +
> +	return hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> +				       1, input_vtl, &reg_assoc);
> +}
> +
> +static void mshv_vtl_vmbus_isr(void)
> +{
> +	struct hv_per_cpu_context *per_cpu;
> +	struct hv_message *msg;
> +	u32 message_type;
> +	union hv_synic_event_flags *event_flags;
> +	unsigned long word;
> +	int i, j;
> +	struct eventfd_ctx *eventfd;
> +
> +	per_cpu = this_cpu_ptr(hv_context.cpu_context);
> +	if (smp_processor_id() == 0) {
> +		msg = (struct hv_message *)per_cpu->synic_message_page + VTL2_VMBUS_SINT_INDEX;
> +		message_type = READ_ONCE(msg->header.message_type);
> +		if (message_type != HVMSG_NONE)
> +			tasklet_schedule(&msg_dpc);
> +	}
> +
> +	event_flags = (union hv_synic_event_flags *)per_cpu->synic_event_page +
> +			VTL2_VMBUS_SINT_INDEX;
> +	for (i = 0; i < HV_EVENT_FLAGS_LONG_COUNT; i++) {
> +		if (READ_ONCE(event_flags->flags[i])) {
> +			word = xchg(&event_flags->flags[i], 0);
> +			for_each_set_bit(j, &word, BITS_PER_LONG) {
> +				rcu_read_lock();
> +				eventfd = READ_ONCE(flag_eventfds[i * BITS_PER_LONG + j]);
> +				if (eventfd)
> +					eventfd_signal(eventfd);
> +				rcu_read_unlock();
> +			}
> +		}
> +	}
> +
> +	vmbus_isr();
> +}
> +
> +static int mshv_vtl_alloc_context(unsigned int cpu)
> +{
> +	struct mshv_vtl_per_cpu *per_cpu = this_cpu_ptr(&mshv_vtl_per_cpu);
> +	struct page *run_page;
> +
> +	run_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!run_page)
> +		return -ENOMEM;
> +
> +	per_cpu->run = page_address(run_page);
> +	if (mshv_vsm_capabilities.intercept_page_available)
> +		mshv_vtl_configure_reg_page(per_cpu);
> +
> +	mshv_vtl_synic_enable_regs(cpu);
> +
> +	return 0;
> +}
> +
> +static int mshv_vtl_cpuhp_online;
> +
> +static int hv_vtl_setup_synic(void)
> +{
> +	int ret;
> +
> +	/* Use our isr to first filter out packets destined for userspace */
> +	hv_setup_vmbus_handler(mshv_vtl_vmbus_isr);
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vtl:online",
> +				mshv_vtl_alloc_context, NULL);
> +	if (ret < 0) {
> +		hv_remove_vmbus_handler();
> +		return ret;
> +	}
> +
> +	mshv_vtl_cpuhp_online = ret;

a '\n' before return

> +	return 0;
> +}
> +
> +static void hv_vtl_remove_synic(void)
> +{
> +	hv_remove_vmbus_handler();
> +	cpuhp_remove_state(mshv_vtl_cpuhp_online);
> +}
> +
> +static int vtl_get_vp_registers(u16 count,
> +				struct hv_register_assoc *registers)
> +{
> +	union hv_input_vtl input_vtl;
> +
> +	input_vtl.as_uint8 = 0;
> +	input_vtl.use_target_vtl = 1;

a '\n' before return, pleas consider this for other place also

> +	return hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> +					count, input_vtl, registers);
> +}
> +
> +static int vtl_set_vp_registers(u16 count,
> +				struct hv_register_assoc *registers)
> +{
> +	union hv_input_vtl input_vtl;
> +
> +	input_vtl.as_uint8 = 0;
> +	input_vtl.use_target_vtl = 1;
> +	return hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> +					count, input_vtl, registers);
> +}
> +
> +static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vtl *vtl, void __user *arg)
> +{
> +	struct mshv_vtl_ram_disposition vtl0_mem;
> +	struct dev_pagemap *pgmap;
> +	void *addr;
> +
> +	if (copy_from_user(&vtl0_mem, arg, sizeof(vtl0_mem)))
> +		return -EFAULT;
> +
> +	if (vtl0_mem.last_pfn <= vtl0_mem.start_pfn) {
> +		dev_err(vtl->module_dev, "range start pfn (%llx) > end pfn (%llx)\n",
> +			vtl0_mem.start_pfn, vtl0_mem.last_pfn);
> +		return -EFAULT;
> +	}
> +
> +	pgmap = kzalloc(sizeof(*pgmap), GFP_KERNEL);
> +	if (!pgmap)
> +		return -ENOMEM;
> +
> +	pgmap->ranges[0].start = PFN_PHYS(vtl0_mem.start_pfn);
> +	pgmap->ranges[0].end = PFN_PHYS(vtl0_mem.last_pfn) - 1;
> +	pgmap->nr_range = 1;
> +	pgmap->type = MEMORY_DEVICE_GENERIC;
> +
> +	/*
> +	 * Determine the highest page order that can be used for the range.
> +	 * This works best when the range is aligned; i.e. start and length.

"can be used for the given memory range."
Replaced "range" with "given memory range" to clarify that we are 
talking about the memory range of the VTL0 memory.

Reworded "start and length"  -> "both the start and the length"

> +	 */
> +	pgmap->vmemmap_shift = count_trailing_zeros(vtl0_mem.start_pfn | vtl0_mem.last_pfn);
> +	dev_dbg(vtl->module_dev,
> +		"Add VTL0 memory: start: 0x%llx, end_pfn: 0x%llx, page order: %lu\n",
> +		vtl0_mem.start_pfn, vtl0_mem.last_pfn, pgmap->vmemmap_shift);
> +
> +	addr = devm_memremap_pages(mem_dev, pgmap);
> +	if (IS_ERR(addr)) {
> +		dev_err(vtl->module_dev, "devm_memremap_pages error: %ld\n", PTR_ERR(addr));
> +		kfree(pgmap);
> +		return -EFAULT;
> +	}
> +
> +	/* Don't free pgmap, since it has to stick around until the memory
> +	 * is unmapped, which will never happen as there is no scenario
> +	 * where VTL0 can be released/shutdown without bringing down VTL2.
> +	 */
> +	return 0;
> +}
> +
> +static void mshv_vtl_cancel(int cpu)
> +{
> +	int here = get_cpu();
> +
> +	if (here != cpu) {
> +		if (!xchg_relaxed(&mshv_vtl_cpu_run(cpu)->cancel, 1))
> +			smp_send_reschedule(cpu);
> +	} else {
> +		WRITE_ONCE(mshv_vtl_this_run()->cancel, 1);
> +	}
> +	put_cpu();
> +}
> +
> +static int mshv_vtl_poll_file_wake(wait_queue_entry_t *wait, unsigned int mode, int sync, void *key)
> +{
> +	struct mshv_vtl_poll_file *poll_file = container_of(wait, struct mshv_vtl_poll_file, wait);
> +
> +	mshv_vtl_cancel(poll_file->cpu);
> +	return 0;
> +}
> +
> +static void mshv_vtl_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh, poll_table *pt)
> +{
> +	struct mshv_vtl_poll_file *poll_file = container_of(pt, struct mshv_vtl_poll_file, pt);
> +
> +	WARN_ON(poll_file->wqh);
> +	poll_file->wqh = wqh;
> +	add_wait_queue(wqh, &poll_file->wait);
> +}
> +
> +static int mshv_vtl_ioctl_set_poll_file(struct mshv_vtl_set_poll_file __user *user_input)
> +{
> +	struct file *file, *old_file;
> +	struct mshv_vtl_poll_file *poll_file;
> +	struct mshv_vtl_set_poll_file input;
> +
> +	if (copy_from_user(&input, user_input, sizeof(input)))
> +		return -EFAULT;
> +
> +	if (!cpu_online(input.cpu))
> +		return -EINVAL;
> +
> +	file = NULL;
> +	if (input.fd >= 0) {
> +		file = fget(input.fd);
> +		if (!file)
> +			return -EBADFD;
> +	}
> +
> +	poll_file = per_cpu_ptr(&mshv_vtl_poll_file, input.cpu);
> +
> +	mutex_lock(&mshv_vtl_poll_file_lock);
> +
> +	if (poll_file->wqh)
> +		remove_wait_queue(poll_file->wqh, &poll_file->wait);
> +	poll_file->wqh = NULL;
> +
> +	old_file = poll_file->file;
> +	poll_file->file = file;
> +	poll_file->cpu = input.cpu;
> +
> +	if (file) {
> +		init_waitqueue_func_entry(&poll_file->wait, mshv_vtl_poll_file_wake);
> +		init_poll_funcptr(&poll_file->pt, mshv_vtl_ptable_queue_proc);
> +		vfs_poll(file, &poll_file->pt);
> +	}
> +
> +	mutex_unlock(&mshv_vtl_poll_file_lock);
> +
> +	if (old_file)
> +		fput(old_file);
> +
> +	return 0;
> +}
> +
> +static int mshv_vtl_set_reg(struct hv_register_assoc *regs)
> +{
> +	u64 reg64;
> +	enum hv_register_name gpr_name;
> +
> +	gpr_name = regs->name;
> +	reg64 = regs->value.reg64;
> +
> +	switch (gpr_name) {
> +	case HV_X64_REGISTER_DR0:
> +		native_set_debugreg(0, reg64);
> +		break;
> +	case HV_X64_REGISTER_DR1:
> +		native_set_debugreg(1, reg64);
> +		break;
> +	case HV_X64_REGISTER_DR2:
> +		native_set_debugreg(2, reg64);
> +		break;
> +	case HV_X64_REGISTER_DR3:
> +		native_set_debugreg(3, reg64);
> +		break;
> +	case HV_X64_REGISTER_DR6:
> +		if (!mshv_vsm_capabilities.dr6_shared)
> +			goto hypercall;
> +		native_set_debugreg(6, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_CAP:
> +		wrmsrl(MSR_MTRRcap, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_DEF_TYPE:
> +		wrmsrl(MSR_MTRRdefType, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0:
> +		wrmsrl(MTRRphysBase_MSR(0), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1:
> +		wrmsrl(MTRRphysBase_MSR(1), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2:
> +		wrmsrl(MTRRphysBase_MSR(2), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3:
> +		wrmsrl(MTRRphysBase_MSR(3), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4:
> +		wrmsrl(MTRRphysBase_MSR(4), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5:
> +		wrmsrl(MTRRphysBase_MSR(5), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6:
> +		wrmsrl(MTRRphysBase_MSR(6), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7:
> +		wrmsrl(MTRRphysBase_MSR(7), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE8:
> +		wrmsrl(MTRRphysBase_MSR(8), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE9:
> +		wrmsrl(MTRRphysBase_MSR(9), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEA:
> +		wrmsrl(MTRRphysBase_MSR(0xa), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEB:
> +		wrmsrl(MTRRphysBase_MSR(0xb), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEC:
> +		wrmsrl(MTRRphysBase_MSR(0xc), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASED:
> +		wrmsrl(MTRRphysBase_MSR(0xd), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEE:
> +		wrmsrl(MTRRphysBase_MSR(0xe), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEF:
> +		wrmsrl(MTRRphysBase_MSR(0xf), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0:
> +		wrmsrl(MTRRphysMask_MSR(0), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1:
> +		wrmsrl(MTRRphysMask_MSR(1), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2:
> +		wrmsrl(MTRRphysMask_MSR(2), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3:
> +		wrmsrl(MTRRphysMask_MSR(3), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4:
> +		wrmsrl(MTRRphysMask_MSR(4), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5:
> +		wrmsrl(MTRRphysMask_MSR(5), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6:
> +		wrmsrl(MTRRphysMask_MSR(6), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7:
> +		wrmsrl(MTRRphysMask_MSR(7), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK8:
> +		wrmsrl(MTRRphysMask_MSR(8), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK9:
> +		wrmsrl(MTRRphysMask_MSR(9), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKA:
> +		wrmsrl(MTRRphysMask_MSR(0xa), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB:
> +		wrmsrl(MTRRphysMask_MSR(0xa), reg64);

is this typo or intentional 0xa -> 0xb ?

> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKC:
> +		wrmsrl(MTRRphysMask_MSR(0xc), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKD:
> +		wrmsrl(MTRRphysMask_MSR(0xd), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKE:
> +		wrmsrl(MTRRphysMask_MSR(0xe), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKF:
> +		wrmsrl(MTRRphysMask_MSR(0xf), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX64K00000:
> +		wrmsrl(MSR_MTRRfix64K_00000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX16K80000:
> +		wrmsrl(MSR_MTRRfix16K_80000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX16KA0000:
> +		wrmsrl(MSR_MTRRfix16K_A0000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KC0000:
> +		wrmsrl(MSR_MTRRfix4K_C0000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KC8000:
> +		wrmsrl(MSR_MTRRfix4K_C8000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KD0000:
> +		wrmsrl(MSR_MTRRfix4K_D0000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KD8000:
> +		wrmsrl(MSR_MTRRfix4K_D8000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KE0000:
> +		wrmsrl(MSR_MTRRfix4K_E0000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KE8000:
> +		wrmsrl(MSR_MTRRfix4K_E8000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KF0000:
> +		wrmsrl(MSR_MTRRfix4K_F0000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KF8000:
> +		wrmsrl(MSR_MTRRfix4K_F8000, reg64);
> +		break;
> +
> +	default:
> +		goto hypercall;
> +	}
> +
> +	return 0;
> +
> +hypercall:
> +	return 1;
> +}
> +
> +static int mshv_vtl_get_reg(struct hv_register_assoc *regs)
> +{
> +	u64 *reg64;
> +	enum hv_register_name gpr_name;
> +
> +	gpr_name = regs->name;
> +	reg64 = (u64 *)&regs->value.reg64;
> +
> +	switch (gpr_name) {
> +	case HV_X64_REGISTER_DR0:
> +		*reg64 = native_get_debugreg(0);
> +		break;
> +	case HV_X64_REGISTER_DR1:
> +		*reg64 = native_get_debugreg(1);
> +		break;
> +	case HV_X64_REGISTER_DR2:
> +		*reg64 = native_get_debugreg(2);
> +		break;
> +	case HV_X64_REGISTER_DR3:
> +		*reg64 = native_get_debugreg(3);
> +		break;
> +	case HV_X64_REGISTER_DR6:
> +		if (!mshv_vsm_capabilities.dr6_shared)
> +			goto hypercall;
> +		*reg64 = native_get_debugreg(6);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_CAP:
> +		rdmsrl(MSR_MTRRcap, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_DEF_TYPE:
> +		rdmsrl(MSR_MTRRdefType, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0:
> +		rdmsrl(MTRRphysBase_MSR(0), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1:
> +		rdmsrl(MTRRphysBase_MSR(1), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2:
> +		rdmsrl(MTRRphysBase_MSR(2), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3:
> +		rdmsrl(MTRRphysBase_MSR(3), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4:
> +		rdmsrl(MTRRphysBase_MSR(4), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5:
> +		rdmsrl(MTRRphysBase_MSR(5), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6:
> +		rdmsrl(MTRRphysBase_MSR(6), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7:
> +		rdmsrl(MTRRphysBase_MSR(7), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE8:
> +		rdmsrl(MTRRphysBase_MSR(8), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE9:
> +		rdmsrl(MTRRphysBase_MSR(9), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEA:
> +		rdmsrl(MTRRphysBase_MSR(0xa), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEB:
> +		rdmsrl(MTRRphysBase_MSR(0xb), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEC:
> +		rdmsrl(MTRRphysBase_MSR(0xc), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASED:
> +		rdmsrl(MTRRphysBase_MSR(0xd), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEE:
> +		rdmsrl(MTRRphysBase_MSR(0xe), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEF:
> +		rdmsrl(MTRRphysBase_MSR(0xf), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0:
> +		rdmsrl(MTRRphysMask_MSR(0), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1:
> +		rdmsrl(MTRRphysMask_MSR(1), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2:
> +		rdmsrl(MTRRphysMask_MSR(2), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3:
> +		rdmsrl(MTRRphysMask_MSR(3), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4:
> +		rdmsrl(MTRRphysMask_MSR(4), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5:
> +		rdmsrl(MTRRphysMask_MSR(5), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6:
> +		rdmsrl(MTRRphysMask_MSR(6), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7:
> +		rdmsrl(MTRRphysMask_MSR(7), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK8:
> +		rdmsrl(MTRRphysMask_MSR(8), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK9:
> +		rdmsrl(MTRRphysMask_MSR(9), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKA:
> +		rdmsrl(MTRRphysMask_MSR(0xa), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB:
> +		rdmsrl(MTRRphysMask_MSR(0xb), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKC:
> +		rdmsrl(MTRRphysMask_MSR(0xc), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKD:
> +		rdmsrl(MTRRphysMask_MSR(0xd), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKE:
> +		rdmsrl(MTRRphysMask_MSR(0xe), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKF:
> +		rdmsrl(MTRRphysMask_MSR(0xf), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX64K00000:
> +		rdmsrl(MSR_MTRRfix64K_00000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX16K80000:
> +		rdmsrl(MSR_MTRRfix16K_80000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX16KA0000:
> +		rdmsrl(MSR_MTRRfix16K_A0000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KC0000:
> +		rdmsrl(MSR_MTRRfix4K_C0000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KC8000:
> +		rdmsrl(MSR_MTRRfix4K_C8000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KD0000:
> +		rdmsrl(MSR_MTRRfix4K_D0000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KD8000:
> +		rdmsrl(MSR_MTRRfix4K_D8000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KE0000:
> +		rdmsrl(MSR_MTRRfix4K_E0000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KE8000:
> +		rdmsrl(MSR_MTRRfix4K_E8000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KF0000:
> +		rdmsrl(MSR_MTRRfix4K_F0000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KF8000:
> +		rdmsrl(MSR_MTRRfix4K_F8000, *reg64);
> +		break;
> +
> +	default:
> +		goto hypercall;
> +	}
> +
> +	return 0;
> +
> +hypercall:
> +	return 1;
> +}
> +
> +static void mshv_vtl_return(struct mshv_vtl_cpu_context *vtl0)
> +{
> +	struct hv_vp_assist_page *hvp;
> +	u64 hypercall_addr;
> +
> +	register u64 r8 asm("r8");
> +	register u64 r9 asm("r9");
> +	register u64 r10 asm("r10");
> +	register u64 r11 asm("r11");
> +	register u64 r12 asm("r12");
> +	register u64 r13 asm("r13");
> +	register u64 r14 asm("r14");
> +	register u64 r15 asm("r15");
> +
> +	hvp = hv_vp_assist_page[smp_processor_id()];
> +
> +	/*
> +	 * Process signal event direct set in the run page, if any.
> +	 */
> +	if (mshv_vsm_capabilities.return_action_available) {
> +		u32 offset = READ_ONCE(mshv_vtl_this_run()->vtl_ret_action_size);
> +
> +		WRITE_ONCE(mshv_vtl_this_run()->vtl_ret_action_size, 0);
> +
> +		/*
> +		 * Hypervisor will take care of clearing out the actions
> +		 * set in the assist page.
> +		 */
> +		memcpy(hvp->vtl_ret_actions,
> +		       mshv_vtl_this_run()->vtl_ret_actions,
> +		       min_t(u32, offset, sizeof(hvp->vtl_ret_actions)));
> +	}
> +
> +	hvp->vtl_ret_x64rax = vtl0->rax;
> +	hvp->vtl_ret_x64rcx = vtl0->rcx;
> +
> +	hypercall_addr = (u64)((u8 *)hv_hypercall_pg + mshv_vsm_page_offsets.vtl_return_offset);
> +
> +	kernel_fpu_begin_mask(0);
> +	fxrstor(&vtl0->fx_state);
> +	native_write_cr2(vtl0->cr2);
> +	r8 = vtl0->r8;
> +	r9 = vtl0->r9;
> +	r10 = vtl0->r10;
> +	r11 = vtl0->r11;
> +	r12 = vtl0->r12;
> +	r13 = vtl0->r13;
> +	r14 = vtl0->r14;
> +	r15 = vtl0->r15;
> +
> +	asm __volatile__ (	\
> +	/* Save rbp pointer to the lower VTL, keep the stack 16-byte aligned */
> +		"pushq	%%rbp\n"
> +		"pushq	%%rcx\n"
> +	/* Restore the lower VTL's rbp */
> +		"movq	(%%rcx), %%rbp\n"
> +	/* Load return kind into rcx (HV_VTL_RETURN_INPUT_NORMAL_RETURN == 0) */
> +		"xorl	%%ecx, %%ecx\n"
> +	/* Transition to the lower VTL */
> +		CALL_NOSPEC
> +	/* Save VTL0's rax and rcx temporarily on 16-byte aligned stack */
> +		"pushq	%%rax\n"
> +		"pushq	%%rcx\n"
> +	/* Restore pointer to lower VTL rbp */
> +		"movq	16(%%rsp), %%rax\n"
> +	/* Save the lower VTL's rbp */
> +		"movq	%%rbp, (%%rax)\n"
> +	/* Restore saved registers */
> +		"movq	8(%%rsp), %%rax\n"
> +		"movq	24(%%rsp), %%rbp\n"
> +		"addq	$32, %%rsp\n"
> +
> +		: "=a"(vtl0->rax), "=c"(vtl0->rcx),
> +		  "+d"(vtl0->rdx), "+b"(vtl0->rbx), "+S"(vtl0->rsi), "+D"(vtl0->rdi),
> +		  "+r"(r8), "+r"(r9), "+r"(r10), "+r"(r11),
> +		  "+r"(r12), "+r"(r13), "+r"(r14), "+r"(r15)
> +		: THUNK_TARGET(hypercall_addr), "c"(&vtl0->rbp)
> +		: "cc", "memory");
> +
> +	vtl0->r8 = r8;
> +	vtl0->r9 = r9;
> +	vtl0->r10 = r10;
> +	vtl0->r11 = r11;
> +	vtl0->r12 = r12;
> +	vtl0->r13 = r13;
> +	vtl0->r14 = r14;
> +	vtl0->r15 = r15;
> +	vtl0->cr2 = native_read_cr2();
> +
> +	fxsave(&vtl0->fx_state);
> +	kernel_fpu_end();
> +}
> +
> +/*
> + * Returning to a lower VTL treats the base pointer register
> + * as a general purpose one. Without adding this, objtool produces
> + * a warning.
> + */
> +STACK_FRAME_NON_STANDARD(mshv_vtl_return);
> +
> +static bool mshv_vtl_process_intercept(void)
> +{
> +	struct hv_per_cpu_context *mshv_cpu;
> +	void *synic_message_page;
> +	struct hv_message *msg;
> +	u32 message_type;
> +
> +	mshv_cpu = this_cpu_ptr(hv_context.cpu_context);
> +	synic_message_page = mshv_cpu->synic_message_page;
> +	if (unlikely(!synic_message_page))
> +		return true;
> +
> +	msg = (struct hv_message *)synic_message_page + HV_SYNIC_INTERCEPTION_SINT_INDEX;
> +	message_type = READ_ONCE(msg->header.message_type);
> +	if (message_type == HVMSG_NONE)
> +		return true;
> +
> +	memcpy(mshv_vtl_this_run()->exit_message, msg, sizeof(*msg));
> +	vmbus_signal_eom(msg, message_type);
> +	return false;
> +}
> +
> +static int mshv_vtl_ioctl_return_to_lower_vtl(void)
> +{
> +	preempt_disable();
> +	for (;;) {
> +		const unsigned long VTL0_WORK = _TIF_SIGPENDING | _TIF_NEED_RESCHED |
> +						_TIF_NOTIFY_RESUME | _TIF_NOTIFY_SIGNAL;
> +		unsigned long ti_work;
> +		u32 cancel;
> +		unsigned long irq_flags;
> +		struct hv_vp_assist_page *hvp;
> +		int ret;
> +
> +		local_irq_save(irq_flags);
> +		ti_work = READ_ONCE(current_thread_info()->flags);
> +		cancel = READ_ONCE(mshv_vtl_this_run()->cancel);
> +		if (unlikely((ti_work & VTL0_WORK) || cancel)) {
> +			local_irq_restore(irq_flags);
> +			preempt_enable();
> +			if (cancel)
> +				ti_work |= _TIF_SIGPENDING;
> +			ret = mshv_do_pre_guest_mode_work(ti_work);
> +			if (ret)
> +				return ret;
> +			preempt_disable();
> +			continue;
> +		}
> +
> +		mshv_vtl_return(&mshv_vtl_this_run()->cpu_context);
> +		local_irq_restore(irq_flags);
> +
> +		hvp = hv_vp_assist_page[smp_processor_id()];
> +		this_cpu_inc(num_vtl0_transitions);
> +		switch (hvp->vtl_entry_reason) {
> +		case MSHV_ENTRY_REASON_INTERRUPT:
> +			if (!mshv_vsm_capabilities.intercept_page_available &&
> +			    likely(!mshv_vtl_process_intercept()))
> +				goto done;
> +			break;
> +
> +		case MSHV_ENTRY_REASON_INTERCEPT:
> +			WARN_ON(!mshv_vsm_capabilities.intercept_page_available);
> +			memcpy(mshv_vtl_this_run()->exit_message, hvp->intercept_message,
> +			       sizeof(hvp->intercept_message));
> +			goto done;
> +
> +		default:
> +			panic("unknown entry reason: %d", hvp->vtl_entry_reason);
> +		}
> +	}
> +
> +done:
> +	preempt_enable();
> +	return 0;
> +}
> +
> +static long
> +mshv_vtl_ioctl_get_set_regs(void __user *user_args, bool set)
> +{
> +	struct mshv_vp_registers args;
> +	struct hv_register_assoc *registers;
> +	long ret;
> +
> +	if (copy_from_user(&args, user_args, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (args.count == 0 || args.count > MSHV_VP_MAX_REGISTERS)
> +		return -EINVAL;
> +
> +	registers = kmalloc_array(args.count,
> +				  sizeof(*registers),
> +				  GFP_KERNEL);
> +	if (!registers)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(registers, (void __user *)args.regs_ptr,
> +			   sizeof(*registers) * args.count)) {
> +		ret = -EFAULT;
> +		goto free_return;
> +	}
> +
> +	if (set) {
> +		ret = mshv_vtl_set_reg(registers);
> +		if (!ret)
> +			goto free_return; /* No need of hypercall */
> +		ret = vtl_set_vp_registers(args.count, registers);
> +
> +	} else {
> +		ret = mshv_vtl_get_reg(registers);
> +		if (!ret)
> +			goto copy_args; /* No need of hypercall */
> +		ret = vtl_get_vp_registers(args.count, registers);
> +		if (ret)
> +			goto free_return;
> +
> +copy_args:
> +		if (copy_to_user((void __user *)args.regs_ptr, registers,
> +				 sizeof(*registers) * args.count))
> +			ret = -EFAULT;
> +	}
> +
> +free_return:
> +	kfree(registers);
> +	return ret;
> +}
> +
> +static inline long
> +mshv_vtl_ioctl_set_regs(void __user *user_args)
> +{
> +	return mshv_vtl_ioctl_get_set_regs(user_args, true);
> +}
> +
> +static inline long
> +mshv_vtl_ioctl_get_regs(void __user *user_args)
> +{
> +	return mshv_vtl_ioctl_get_set_regs(user_args, false);
> +}
> +
> +static long
> +mshv_vtl_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
> +{
> +	long ret;
> +	struct mshv_vtl *vtl = filp->private_data;
> +
> +	switch (ioctl) {
> +	case MSHV_VTL_SET_POLL_FILE:
> +		ret = mshv_vtl_ioctl_set_poll_file((struct mshv_vtl_set_poll_file *)arg);
> +		break;
> +	case MSHV_GET_VP_REGISTERS:
> +		ret = mshv_vtl_ioctl_get_regs((void __user *)arg);
> +		break;
> +	case MSHV_SET_VP_REGISTERS:
> +		ret = mshv_vtl_ioctl_set_regs((void __user *)arg);
> +		break;
> +	case MSHV_VTL_RETURN_TO_LOWER_VTL:
> +		ret = mshv_vtl_ioctl_return_to_lower_vtl();
> +		break;
> +	case MSHV_VTL_ADD_VTL0_MEMORY:
> +		ret = mshv_vtl_ioctl_add_vtl0_mem(vtl, (void __user *)arg);
> +		break;
> +	default:
> +		dev_err(vtl->module_dev, "invalid vtl ioctl: %#x\n", ioctl);
> +		ret = -ENOTTY;
> +	}
> +
> +	return ret;
> +}
> +
> +static vm_fault_t mshv_vtl_fault(struct vm_fault *vmf)
> +{
> +	struct page *page;
> +	int cpu = vmf->pgoff & MSHV_PG_OFF_CPU_MASK;
> +	int real_off = vmf->pgoff >> MSHV_REAL_OFF_SHIFT;
> +
> +	if (!cpu_online(cpu))
> +		return VM_FAULT_SIGBUS;
> +
> +	if (real_off == MSHV_RUN_PAGE_OFFSET) {
> +		page = virt_to_page(mshv_vtl_cpu_run(cpu));
> +	} else if (real_off == MSHV_REG_PAGE_OFFSET) {
> +		if (!mshv_has_reg_page)
> +			return VM_FAULT_SIGBUS;
> +		page = mshv_vtl_cpu_reg_page(cpu);
> +	} else {
> +		return VM_FAULT_NOPAGE;
> +	}
> +
> +	get_page(page);
> +	vmf->page = page;
> +
> +	return 0;
> +}
> +
> +static const struct vm_operations_struct mshv_vtl_vm_ops = {
> +	.fault = mshv_vtl_fault,
> +};
> +
> +static int mshv_vtl_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	vma->vm_ops = &mshv_vtl_vm_ops;
> +	return 0;
> +}
> +
> +static int mshv_vtl_release(struct inode *inode, struct file *filp)
> +{
> +	struct mshv_vtl *vtl = filp->private_data;
> +
> +	kfree(vtl);
> +
> +	return 0;
> +}
> +
> +static const struct file_operations mshv_vtl_fops = {
> +	.owner = THIS_MODULE,
> +	.unlocked_ioctl = mshv_vtl_ioctl,
> +	.release = mshv_vtl_release,
> +	.mmap = mshv_vtl_mmap,
> +};
> +
> +static void mshv_vtl_synic_mask_vmbus_sint(const u8 *mask)
> +{
> +	union hv_synic_sint sint;
> +
> +	sint.as_uint64 = 0;
> +	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> +	sint.masked = (*mask != 0);
> +	sint.auto_eoi = hv_recommend_using_aeoi();
> +
> +	hv_set_msr(HV_MSR_SINT0 + VTL2_VMBUS_SINT_INDEX,
> +		   sint.as_uint64);
> +
> +	if (!sint.masked)
> +		pr_debug("%s: Unmasking VTL2 VMBUS SINT on VP %d\n", __func__, smp_processor_id());
> +	else
> +		pr_debug("%s: Masking VTL2 VMBUS SINT on VP %d\n", __func__, smp_processor_id());
> +}
> +
> +static void mshv_vtl_read_remote(void *buffer)
> +{
> +	struct hv_per_cpu_context *mshv_cpu = this_cpu_ptr(hv_context.cpu_context);
> +	struct hv_message *msg = (struct hv_message *)mshv_cpu->synic_message_page +
> +					VTL2_VMBUS_SINT_INDEX;
> +	u32 message_type = READ_ONCE(msg->header.message_type);
> +
> +	WRITE_ONCE(has_message, false);
> +	if (message_type == HVMSG_NONE)
> +		return;
> +
> +	memcpy(buffer, msg, sizeof(*msg));
> +	vmbus_signal_eom(msg, message_type);
> +}
> +
> +static bool vtl_synic_mask_vmbus_sint_masked = true;
> +
> +static ssize_t mshv_vtl_sint_read(struct file *filp, char __user *arg, size_t size, loff_t *offset)
> +{
> +	struct hv_message msg = {};
> +	int ret;
> +
> +	if (size < sizeof(msg))
> +		return -EINVAL;
> +
> +	for (;;) {
> +		smp_call_function_single(VMBUS_CONNECT_CPU, mshv_vtl_read_remote, &msg, true);
> +		if (msg.header.message_type != HVMSG_NONE)
> +			break;
> +
> +		if (READ_ONCE(vtl_synic_mask_vmbus_sint_masked))
> +			return 0; /* EOF */
> +
> +		if (filp->f_flags & O_NONBLOCK)
> +			return -EAGAIN;
> +
> +		ret = wait_event_interruptible(fd_wait_queue,
> +					       READ_ONCE(has_message) ||
> +						READ_ONCE(vtl_synic_mask_vmbus_sint_masked));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (copy_to_user(arg, &msg, sizeof(msg)))
> +		return -EFAULT;
> +
> +	return sizeof(msg);
> +}
> +
> +static __poll_t mshv_vtl_sint_poll(struct file *filp, poll_table *wait)
> +{
> +	__poll_t mask = 0;
> +
> +	poll_wait(filp, &fd_wait_queue, wait);
> +	if (READ_ONCE(has_message) || READ_ONCE(vtl_synic_mask_vmbus_sint_masked))
> +		mask |= EPOLLIN | EPOLLRDNORM;
> +
> +	return mask;
> +}
> +
> +static void mshv_vtl_sint_on_msg_dpc(unsigned long data)
> +{
> +	WRITE_ONCE(has_message, true);
> +	wake_up_interruptible_poll(&fd_wait_queue, EPOLLIN);
> +}
> +
> +static int mshv_vtl_sint_ioctl_post_message(struct mshv_vtl_sint_post_msg __user *arg)
> +{
> +	struct mshv_vtl_sint_post_msg message;
> +	u8 payload[HV_MESSAGE_PAYLOAD_BYTE_COUNT];
> +
> +	if (copy_from_user(&message, arg, sizeof(message)))
> +		return -EFAULT;
> +	if (message.payload_size > HV_MESSAGE_PAYLOAD_BYTE_COUNT)
> +		return -EINVAL;
> +	if (copy_from_user(payload, (void __user *)message.payload_ptr,
> +			   message.payload_size))
> +		return -EFAULT;
> +
> +	return hv_post_message((union hv_connection_id)message.connection_id,
> +			       message.message_type, (void *)payload,
> +			       message.payload_size);
> +}
> +
> +static int mshv_vtl_sint_ioctl_signal_event(struct mshv_vtl_signal_event __user *arg)
> +{
> +	u64 input;
> +	struct mshv_vtl_signal_event signal_event;
> +
> +	if (copy_from_user(&signal_event, arg, sizeof(signal_event)))
> +		return -EFAULT;
> +
> +	input = signal_event.connection_id | ((u64)signal_event.flag << 32);
> +	return hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT, input) & HV_HYPERCALL_RESULT_MASK;
> +}
> +
> +static int mshv_vtl_sint_ioctl_set_eventfd(struct mshv_vtl_set_eventfd __user *arg)
> +{
> +	struct mshv_vtl_set_eventfd set_eventfd;
> +	struct eventfd_ctx *eventfd, *old_eventfd;
> +
> +	if (copy_from_user(&set_eventfd, arg, sizeof(set_eventfd)))
> +		return -EFAULT;
> +	if (set_eventfd.flag >= HV_EVENT_FLAGS_COUNT)
> +		return -EINVAL;
> +
> +	eventfd = NULL;
> +	if (set_eventfd.fd >= 0) {
> +		eventfd = eventfd_ctx_fdget(set_eventfd.fd);
> +		if (IS_ERR(eventfd))
> +			return PTR_ERR(eventfd);
> +	}
> +
> +	mutex_lock(&flag_lock);
> +	old_eventfd = flag_eventfds[set_eventfd.flag];
> +	WRITE_ONCE(flag_eventfds[set_eventfd.flag], eventfd);
> +	mutex_unlock(&flag_lock);
> +
> +	if (old_eventfd) {
> +		synchronize_rcu();
> +		eventfd_ctx_put(old_eventfd);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mshv_vtl_sint_ioctl_pause_message_stream(struct mshv_sint_mask __user *arg)
> +{
> +	static DEFINE_MUTEX(vtl2_vmbus_sint_mask_mutex);
> +	struct mshv_sint_mask mask;
> +
> +	if (copy_from_user(&mask, arg, sizeof(mask)))
> +		return -EFAULT;
> +	mutex_lock(&vtl2_vmbus_sint_mask_mutex);
> +	on_each_cpu((smp_call_func_t)mshv_vtl_synic_mask_vmbus_sint, &mask.mask, 1);
> +	WRITE_ONCE(vtl_synic_mask_vmbus_sint_masked, mask.mask != 0);
> +	mutex_unlock(&vtl2_vmbus_sint_mask_mutex);
> +	if (mask.mask)
> +		wake_up_interruptible_poll(&fd_wait_queue, EPOLLIN);
> +
> +	return 0;
> +}
> +
> +static long mshv_vtl_sint_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
> +{
> +	switch (cmd) {
> +	case MSHV_SINT_POST_MESSAGE:
> +		return mshv_vtl_sint_ioctl_post_message((struct mshv_vtl_sint_post_msg *)arg);
> +	case MSHV_SINT_SIGNAL_EVENT:
> +		return mshv_vtl_sint_ioctl_signal_event((struct mshv_vtl_signal_event *)arg);
> +	case MSHV_SINT_SET_EVENTFD:
> +		return mshv_vtl_sint_ioctl_set_eventfd((struct mshv_vtl_set_eventfd *)arg);
> +	case MSHV_SINT_PAUSE_MESSAGE_STREAM:
> +		return mshv_vtl_sint_ioctl_pause_message_stream((struct mshv_sint_mask *)arg);
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +}
> +
> +static const struct file_operations mshv_vtl_sint_ops = {
> +	.owner = THIS_MODULE,
> +	.read = mshv_vtl_sint_read,
> +	.poll = mshv_vtl_sint_poll,
> +	.unlocked_ioctl = mshv_vtl_sint_ioctl,
> +};
> +
> +static struct miscdevice mshv_vtl_sint_dev = {
> +	.name = "mshv_sint",
> +	.fops = &mshv_vtl_sint_ops,
> +	.mode = 0600,
> +	.minor = MISC_DYNAMIC_MINOR,
> +};
> +
> +static int mshv_vtl_hvcall_open(struct inode *node, struct file *f)
> +{
> +	struct miscdevice *dev = f->private_data;
> +	struct mshv_vtl_hvcall_fd *fd;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	fd = vzalloc(sizeof(*fd));
> +	if (!fd)
> +		return -ENOMEM;

if (!fd) {
     f->private_data = NULL;
     return -ENOMEM;
}
Explicitly set to NULL to (avoid accidental use)
it can avoids potential issues in later functions that may attempt to 
access it. what is your view here ?

> +	fd->dev = dev;
> +	mutex_init(&fd->init_mutex);
> +
> +	f->private_data = fd;

Assign immediately after allocation ensures a consistent state and sequence
     f->private_data = fd;
     fd->dev = dev;
     mutex_init(&fd->init_mutex);

> +
> +	return 0;
> +}
> +
> +static int mshv_vtl_hvcall_release(struct inode *node, struct file *f)
> +{
> +	struct mshv_vtl_hvcall_fd *fd;
> +
> +	fd = f->private_data;
> +	f->private_data = NULL;
> +	vfree(fd);

what about ?
if (fd) {
     vfree(fd);
     f->private_data = NULL;
}
adding a check will improves readability and robustness.
> +
> +	return 0;
> +}
> +
> +static int mshv_vtl_hvcall_setup(struct mshv_vtl_hvcall_fd *fd,
> +				 struct mshv_vtl_hvcall_setup __user *hvcall_setup_user)
> +{
> +	int ret = 0;
> +	struct mshv_vtl_hvcall_setup hvcall_setup;
> +
> +	mutex_lock(&fd->init_mutex);
> +
> +	if (fd->allow_map_intialized) {
> +		dev_err(fd->dev->this_device,
> +			"Hypercall allow map has already been set, pid %d\n",
> +			current->pid);
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	if (copy_from_user(&hvcall_setup, hvcall_setup_user,
> +			   sizeof(struct mshv_vtl_hvcall_setup))) {
> +		ret = -EFAULT;
> +		goto exit;
> +	}
> +	if (hvcall_setup.bitmap_size > ARRAY_SIZE(fd->allow_bitmap)) {
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +	if (copy_from_user(&fd->allow_bitmap,
> +			   (void __user *)hvcall_setup.allow_bitmap_ptr,
> +			   hvcall_setup.bitmap_size)) {
> +		ret = -EFAULT;
> +		goto exit;
> +	}
> +
> +	dev_info(fd->dev->this_device, "Hypercall allow map has been set, pid %d\n",
> +		 current->pid);
> +	fd->allow_map_intialized = true;
> +
> +exit:
> +

no need \n here

> +	mutex_unlock(&fd->init_mutex);
> +
> +	return ret;
> +}
> +
> +static bool mshv_vtl_hvcall_is_allowed(struct mshv_vtl_hvcall_fd *fd, u16 call_code)
> +{
> +	u8 bits_per_item = 8 * sizeof(fd->allow_bitmap[0]);
> +	u16 item_index = call_code / bits_per_item;
> +	u64 mask = 1ULL << (call_code % bits_per_item);
> +
> +	return fd->allow_bitmap[item_index] & mask;
> +}
> +
> +static int mshv_vtl_hvcall_call(struct mshv_vtl_hvcall_fd *fd,
> +				struct mshv_vtl_hvcall __user *hvcall_user)
> +{
> +	struct mshv_vtl_hvcall hvcall;
> +	unsigned long flags;
> +	void *in, *out;
> +
> +	if (copy_from_user(&hvcall, hvcall_user, sizeof(struct mshv_vtl_hvcall)))
> +		return -EFAULT;
> +	if (hvcall.input_size > HV_HYP_PAGE_SIZE)
> +		return -EINVAL;
> +	if (hvcall.output_size > HV_HYP_PAGE_SIZE)
> +		return -EINVAL;
> +
> +	/*
> +	 * By default, all hypercalls are not allowed.
> +	 * The user mode code has to set up the allow bitmap once.
> +	 */
> +
> +	if (!mshv_vtl_hvcall_is_allowed(fd, hvcall.control & 0xFFFF)) {
> +		dev_err(fd->dev->this_device,
> +			"Hypercall with control data %#llx isn't allowed\n",
> +			hvcall.control);
> +		return -EPERM;
> +	}
> +
> +	local_irq_save(flags);
> +	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	out = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	if (copy_from_user(in, (void __user *)hvcall.input_ptr, hvcall.input_size)) {
> +		local_irq_restore(flags);
> +		return -EFAULT;
> +	}
> +
> +	hvcall.status = hv_do_hypercall(hvcall.control, in, out);
> +
> +	if (copy_to_user((void __user *)hvcall.output_ptr, out, hvcall.output_size)) {
> +		local_irq_restore(flags);
> +		return -EFAULT;
> +	}
> +	local_irq_restore(flags);
> +
> +	return put_user(hvcall.status, &hvcall_user->status);
> +}
> +
> +static long mshv_vtl_hvcall_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
> +{
> +	struct mshv_vtl_hvcall_fd *fd = f->private_data;
> +
> +	switch (cmd) {
> +	case MSHV_HVCALL_SETUP:
> +		return mshv_vtl_hvcall_setup(fd, (struct mshv_vtl_hvcall_setup __user *)arg);
> +	case MSHV_HVCALL:
> +		return mshv_vtl_hvcall_call(fd, (struct mshv_vtl_hvcall __user *)arg);
> +	default:
> +		break;
> +	}
> +
> +	return -ENOIOCTLCMD;
> +}
> +
> +static const struct file_operations mshv_vtl_hvcall_file_ops = {
> +	.owner = THIS_MODULE,
> +	.open = mshv_vtl_hvcall_open,
> +	.release = mshv_vtl_hvcall_release,
> +	.unlocked_ioctl = mshv_vtl_hvcall_ioctl,
> +};
> +
> +static struct miscdevice mshv_vtl_hvcall = {
> +	.name = "mshv_hvcall",
> +	.nodename = "mshv_hvcall",
> +	.fops = &mshv_vtl_hvcall_file_ops,
> +	.mode = 0600,
> +	.minor = MISC_DYNAMIC_MINOR,
> +};
> +
> +static int mshv_vtl_low_open(struct inode *inodep, struct file *filp)
> +{
> +	pid_t pid = task_pid_vnr(current);
> +	uid_t uid = current_uid().val;
> +	int ret = 0;
> +
> +	pr_debug("%s: Opening VTL low, task group %d, uid %d\n", __func__, pid, uid);
> +
> +	if (capable(CAP_SYS_ADMIN)) {
> +		filp->private_data = inodep;
> +	} else {
> +		pr_err("%s: VTL low open failed: CAP_SYS_ADMIN required. task group %d, uid %d",
> +		       __func__, pid, uid);
> +		ret = -EPERM;
> +	}
> +
> +	return ret;
> +}
> +
> +static bool can_fault(struct vm_fault *vmf, unsigned long size, pfn_t *pfn)
> +{
> +	unsigned long mask = size - 1;
> +	unsigned long start = vmf->address & ~mask;
> +	unsigned long end = start + size;
> +	bool valid;

valid is descriptive, but is_valid would be more explicit as a boolean flag.

> +
> +	valid = (vmf->address & mask) == ((vmf->pgoff << PAGE_SHIFT) & mask) &&
> +		start >= vmf->vma->vm_start &&
> +		end <= vmf->vma->vm_end;
> +
> +	if (valid)
> +		*pfn = __pfn_to_pfn_t(vmf->pgoff & ~(mask >> PAGE_SHIFT), PFN_DEV | PFN_MAP);
> +
> +	return valid;
> +}
> +
> +static vm_fault_t mshv_vtl_low_huge_fault(struct vm_fault *vmf, unsigned int order)
> +{
> +	pfn_t pfn;
> +	int ret = VM_FAULT_FALLBACK;
> +
> +	switch (order) {
> +	case 0:
> +		pfn = __pfn_to_pfn_t(vmf->pgoff, PFN_DEV | PFN_MAP);
> +		return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
> +
> +	case PMD_ORDER:
> +		if (can_fault(vmf, PMD_SIZE, &pfn))
> +			ret = vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
> +		return ret;
> +
> +	case PUD_ORDER:
> +		if (can_fault(vmf, PUD_SIZE, &pfn))
> +			ret = vmf_insert_pfn_pud(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
> +		return ret;
> +
> +	default:
> +		return VM_FAULT_SIGBUS;
> +	}
> +}
> +
> +static vm_fault_t mshv_vtl_low_fault(struct vm_fault *vmf)
> +{
> +	return mshv_vtl_low_huge_fault(vmf, 0);
> +}
> +
> +static const struct vm_operations_struct mshv_vtl_low_vm_ops = {
> +	.fault = mshv_vtl_low_fault,
> +	.huge_fault = mshv_vtl_low_huge_fault,
> +};
> +
> +static int mshv_vtl_low_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	vma->vm_ops = &mshv_vtl_low_vm_ops;
> +	vm_flags_set(vma, VM_HUGEPAGE | VM_MIXEDMAP);
> +	return 0;
> +}
> +
> +static const struct file_operations mshv_vtl_low_file_ops = {
> +	.owner		= THIS_MODULE,
> +	.open		= mshv_vtl_low_open,
> +	.mmap		= mshv_vtl_low_mmap,
> +};
> +
> +static struct miscdevice mshv_vtl_low = {
> +	.name = "mshv_vtl_low",
> +	.nodename = "mshv_vtl_low",
> +	.fops = &mshv_vtl_low_file_ops,
> +	.mode = 0600,
> +	.minor = MISC_DYNAMIC_MINOR,
> +};
> +
> +static int __init mshv_vtl_init(void)
> +{
> +	int ret;
> +	struct device *dev = mshv_dev.this_device;
> +
> +	/*
> +	 * This creates /dev/mshv which provides functionality to create VTLs and partitions.
> +	 */
> +	ret = misc_register(&mshv_dev);
> +	if (ret) {
> +		dev_err(dev, "mshv device register failed: %d\n", ret);
> +		goto free_dev;
> +	}
> +
> +	tasklet_init(&msg_dpc, mshv_vtl_sint_on_msg_dpc, 0);
> +	init_waitqueue_head(&fd_wait_queue);
> +
> +	if (mshv_vtl_get_vsm_regs()) {
> +		dev_emerg(dev, "Unable to get VSM capabilities !!\n");
> +		ret = -ENODEV;
> +		goto free_dev;
> +	}
> +	if (mshv_vtl_configure_vsm_partition(dev)) {
> +		dev_emerg(dev, "VSM configuration failed !!\n");
> +		ret = -ENODEV;
> +		goto free_dev;
> +	}
> +
> +	ret = hv_vtl_setup_synic();
> +	if (ret)
> +		goto free_dev;
> +
> +	/*
> +	 * mshv_sint device adds VMBus relay ioctl support.
> +	 * This provides a channel for VTL0 to communicate with VTL2.
> +	 */
> +	ret = misc_register(&mshv_vtl_sint_dev);
> +	if (ret)
> +		goto free_synic;
> +
> +	/*
> +	 * mshv_hvcall device adds interface to enable userspace for direct hypercalls support.
> +	 */
> +	ret = misc_register(&mshv_vtl_hvcall);
> +	if (ret)
> +		goto free_sint;
> +
> +	/*
> +	 * mshv_vtl_low device is used to map VTL0 address space to a user-mode process in VLT2.

typo VLT2 -> VTL2

> +	 * It implements mmap() to allow a user-mode process in VTL2 to map to the address of VTL0.
> +	 */
> +	ret = misc_register(&mshv_vtl_low);
> +	if (ret)
> +		goto free_hvcall;
> +
> +	/*
> +	 * "mshv vtl mem dev" device is later used to setup VTL0 memory.
> +	 */
> +	mem_dev = kzalloc(sizeof(*mem_dev), GFP_KERNEL);
> +	if (!mem_dev) {
> +		ret = -ENOMEM;
> +		goto free_low;
> +	}
> +
> +	mutex_init(&mshv_vtl_poll_file_lock);
> +
> +	device_initialize(mem_dev);
> +	dev_set_name(mem_dev, "mshv vtl mem dev");
> +	ret = device_add(mem_dev);
> +	if (ret) {
> +		dev_err(dev, "mshv vtl mem dev add: %d\n", ret);
> +		goto free_mem;
> +	}
> +
> +	return 0;
> +
> +free_mem:
> +	kfree(mem_dev);
> +free_low:
> +	misc_deregister(&mshv_vtl_low);
> +free_hvcall:
> +	misc_deregister(&mshv_vtl_hvcall);
> +free_sint:
> +	misc_deregister(&mshv_vtl_sint_dev);
> +free_synic:
> +	hv_vtl_remove_synic();
> +free_dev:
> +	misc_deregister(&mshv_dev);
> +	return ret;
> +}
> +
> +static void __exit mshv_vtl_exit(void)
> +{
> +	device_del(mem_dev);
> +	kfree(mem_dev);
> +	misc_deregister(&mshv_vtl_low);
> +	misc_deregister(&mshv_vtl_hvcall);
> +	misc_deregister(&mshv_vtl_sint_dev);
> +	hv_vtl_remove_synic();
> +	misc_deregister(&mshv_dev);
> +}
> +
> +module_init(mshv_vtl_init);
> +module_exit(mshv_vtl_exit);
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 857109bb99a0..64340b59634b 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1276,7 +1276,7 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
>   	}
>   }
>   
> -static void vmbus_isr(void)
> +void vmbus_isr(void)
>   {
>   	struct hv_per_cpu_context *hv_cpu
>   		= this_cpu_ptr(hv_context.cpu_context);
> @@ -1299,6 +1299,7 @@ static void vmbus_isr(void)
>   
>   	add_interrupt_randomness(vmbus_interrupt);
>   }
> +EXPORT_SYMBOL_GPL(vmbus_isr);
>   
>   static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
>   {
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 68606fa5fe73..d1369b9e3757 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -882,6 +882,23 @@ struct hv_get_vp_from_apic_id_in {
>   	u32 apic_ids[];
>   } __packed;
>   
> +union hv_register_vsm_partition_config {
> +	__u64 as_u64;
> +	struct {
> +		__u64 enable_vtl_protection : 1;
> +		__u64 default_vtl_protection_mask : 4;
> +		__u64 zero_memory_on_reset : 1;
> +		__u64 deny_lower_vtl_startup : 1;
> +		__u64 intercept_acceptance : 1;
> +		__u64 intercept_enable_vtl_protection : 1;
> +		__u64 intercept_vp_startup : 1;
> +		__u64 intercept_cpuid_unimplemented : 1;
> +		__u64 intercept_unrecoverable_exception : 1;
> +		__u64 intercept_page : 1;
> +		__u64 mbz : 51;
> +	};
> +};
> +
>   struct hv_nested_enlightenments_control {
>   	struct {
>   		u32 directhypercall : 1;
> @@ -1004,6 +1021,70 @@ enum hv_register_name {
>   
>   	/* VSM */
>   	HV_REGISTER_VSM_VP_STATUS				= 0x000D0003,
> +
> +	/* Synthetic VSM registers */
> +	HV_REGISTER_VSM_CODE_PAGE_OFFSETS	= 0x000D0002,
> +	HV_REGISTER_VSM_CAPABILITIES		= 0x000D0006,
> +	HV_REGISTER_VSM_PARTITION_CONFIG	= 0x000D0007,
> +
> +#if defined(CONFIG_X86)
> +	/* X64 Debug Registers */
> +	HV_X64_REGISTER_DR0	= 0x00050000,
> +	HV_X64_REGISTER_DR1	= 0x00050001,
> +	HV_X64_REGISTER_DR2	= 0x00050002,
> +	HV_X64_REGISTER_DR3	= 0x00050003,
> +	HV_X64_REGISTER_DR6	= 0x00050004,
> +	HV_X64_REGISTER_DR7	= 0x00050005,
> +
> +	/* X64 Cache control MSRs */
> +	HV_X64_REGISTER_MSR_MTRR_CAP		= 0x0008000D,
> +	HV_X64_REGISTER_MSR_MTRR_DEF_TYPE	= 0x0008000E,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0	= 0x00080010,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1	= 0x00080011,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2	= 0x00080012,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3	= 0x00080013,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4	= 0x00080014,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5	= 0x00080015,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6	= 0x00080016,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7	= 0x00080017,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE8	= 0x00080018,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE9	= 0x00080019,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEA	= 0x0008001A,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEB	= 0x0008001B,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEC	= 0x0008001C,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASED	= 0x0008001D,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEE	= 0x0008001E,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEF	= 0x0008001F,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0	= 0x00080040,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1	= 0x00080041,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2	= 0x00080042,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3	= 0x00080043,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4	= 0x00080044,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5	= 0x00080045,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6	= 0x00080046,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7	= 0x00080047,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK8	= 0x00080048,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK9	= 0x00080049,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKA	= 0x0008004A,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB	= 0x0008004B,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKC	= 0x0008004C,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKD	= 0x0008004D,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKE	= 0x0008004E,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKF	= 0x0008004F,
> +	HV_X64_REGISTER_MSR_MTRR_FIX64K00000	= 0x00080070,
> +	HV_X64_REGISTER_MSR_MTRR_FIX16K80000	= 0x00080071,
> +	HV_X64_REGISTER_MSR_MTRR_FIX16KA0000	= 0x00080072,
> +	HV_X64_REGISTER_MSR_MTRR_FIX4KC0000	= 0x00080073,
> +	HV_X64_REGISTER_MSR_MTRR_FIX4KC8000	= 0x00080074,
> +	HV_X64_REGISTER_MSR_MTRR_FIX4KD0000	= 0x00080075,
> +	HV_X64_REGISTER_MSR_MTRR_FIX4KD8000	= 0x00080076,
> +	HV_X64_REGISTER_MSR_MTRR_FIX4KE0000	= 0x00080077,
> +	HV_X64_REGISTER_MSR_MTRR_FIX4KE8000	= 0x00080078,
> +	HV_X64_REGISTER_MSR_MTRR_FIX4KF0000	= 0x00080079,
> +	HV_X64_REGISTER_MSR_MTRR_FIX4KF8000	= 0x0008007A,
> +
> +	HV_X64_REGISTER_REG_PAGE	= 0x0009001C,
> +#endif
>   };
>   
>   /*
> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> index b4067ada02cf..9b890126e8e8 100644
> --- a/include/hyperv/hvhdk.h
> +++ b/include/hyperv/hvhdk.h
> @@ -479,6 +479,7 @@ struct hv_connection_info {
>   #define HV_EVENT_FLAGS_COUNT		(256 * 8)
>   #define HV_EVENT_FLAGS_BYTE_COUNT	(256)
>   #define HV_EVENT_FLAGS32_COUNT		(256 / sizeof(u32))
> +#define HV_EVENT_FLAGS_LONG_COUNT	(HV_EVENT_FLAGS_BYTE_COUNT / sizeof(__u64))
>   
>   /* linux side we create long version of flags to use long bit ops on flags */
>   #define HV_EVENT_FLAGS_UL_COUNT		(256 / sizeof(ulong))
> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> index 876bfe4e4227..616b1144dd31 100644
> --- a/include/uapi/linux/mshv.h
> +++ b/include/uapi/linux/mshv.h
> @@ -288,4 +288,87 @@ struct mshv_get_set_vp_state {
>    * #define MSHV_ROOT_HVCALL			_IOWR(MSHV_IOCTL, 0x07, struct mshv_root_hvcall)
>    */
>   
> +/* Structure definitions, macros and IOCTLs for mshv_vtl */
> +
> +#define MSHV_CAP_CORE_API_STABLE        0x0
> +#define MSHV_CAP_REGISTER_PAGE          0x1
> +#define MSHV_CAP_VTL_RETURN_ACTION      0x2
> +#define MSHV_CAP_DR6_SHARED             0x3
> +#define MSHV_MAX_RUN_MSG_SIZE                256
> +
> +#define MSHV_VP_MAX_REGISTERS   128
> +
> +struct mshv_vp_registers {
> +	__u32 count;	/* at most MSHV_VP_MAX_REGISTERS */
> +	__u32 padding;

padding -> reserved?
reserved(reserved or reserved1, reserved2) is more commonly used in 
structures that may evolve to include additional field
__u32 reserved; /* Reserved for alignment or future use */

> +	__u64 regs_ptr;	/* pointer to struct hv_register_assoc */
> +};
> +
> +struct mshv_vtl_set_eventfd {
> +	__s32 fd;
> +	__u32 flag;
> +};
> +
> +struct mshv_vtl_signal_event {
> +	__u32 connection_id;
> +	__u32 flag;
> +};
> +
> +struct mshv_vtl_sint_post_msg {
> +	__u64 message_type;
> +	__u32 connection_id;
> +	__u32 payload_size;

do we have max limit for payload ? if yes
__u32 payload_size; /* Must not exceed MSHV_VTL_MAX_PAYLOAD_SIZE */
HV_MESSAGE_PAYLOAD_BYTE_COUNT, is this max payload size ?

> +	__u64 payload_ptr; /* pointer to message payload (bytes) */
> +};
> +
> +struct mshv_vtl_ram_disposition {
> +	__u64 start_pfn;
> +	__u64 last_pfn;
> +};
> +
> +struct mshv_vtl_set_poll_file {
> +	__u32 cpu;
> +	__u32 fd;
> +};
> +
> +struct mshv_vtl_hvcall_setup {
> +	__u64 bitmap_size;
> +	__u64 allow_bitmap_ptr; /* pointer to __u64 */
> +};
> +
> +struct mshv_vtl_hvcall {
> +	__u64 control;
> +	__u64 input_size;
> +	__u64 input_ptr; /* pointer to input struct */
> +	/* output */
> +	__u64 status;
> +	__u64 output_size;
> +	__u64 output_ptr; /* pointer to output struct */
> +};

this /* output */ is ambiguous. can we provide all description or non(as 
name it self-explanatory) for better consistency and clarity
struct mshv_vtl_hvcall {
     __u64 control;      /* Hypercall control code */
     __u64 input_size;   /* Size of the input data */
     __u64 input_ptr;    /* Pointer to the input struct */
     __u64 status;       /* Status of the hypercall (output) */
     __u64 output_size;  /* Size of the output data */
     __u64 output_ptr;   /* Pointer to the output struct */
};
> +
> +struct mshv_sint_mask {
> +	__u8 mask;
> +	__u8 reserved[7];
> +};
> +
> +/* /dev/mshv device IOCTL */
> +#define MSHV_CHECK_EXTENSION    _IOW(MSHV_IOCTL, 0x00, __u32)
> +



Thanks,
Alok

