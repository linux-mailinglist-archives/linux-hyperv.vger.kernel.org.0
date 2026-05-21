Return-Path: <linux-hyperv+bounces-11124-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKiAAY/RDmr2CQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11124-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 11:34:07 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F5F5A26D3
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 11:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65D0530BA5A0
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 09:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71DF35F610;
	Thu, 21 May 2026 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KsElKhrK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hjpxMjx/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1CD332919;
	Thu, 21 May 2026 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779354940; cv=fail; b=dnnFK1J1IK4NBF3jKKY5ONvIsRVMdNY/EHnVkJDkunz1+HEZy6NoxxSA/ucRW1PmXOdXDqJz79CeSj6U/jDKq7Jx0XlBAks0KEKeCQHWeSQQCkO06NtKyy/0GbneHATJBCNj8rQ33TYX9Ne7G9s7BAFG7MAi9/RLR/swUj9GTFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779354940; c=relaxed/simple;
	bh=22UV0VkB44X6wDF0RacEja6ntnQCBUUENyoV4Cly5zQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mBSGC1BKuvq9g9H6kgPS0aY/8Ipda4EWoraMue1hTnulv9tJfiihOxF0gzUeO2mXHSm6oajW+ujnvdCsgE6czM4yRmpP9Mch1/aPT71FPDDEB6a5u6l5zxiTGh0Kdt1Tb6kOo97vU26ojS+nKY7WdgZT65eLVVNWEpGwEjUiQiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KsElKhrK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hjpxMjx/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L1PZ5K1648965;
	Thu, 21 May 2026 09:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OIwUQ+Mq3z0V3bUEfW3O9y5O+U+X9Qd2OPUf1RyxbvE=; b=
	KsElKhrKyr9/qDfQUC3Hgt2TLssSO7a71uukg6GD3rY+iHAX+19OeROjsHY+SrHn
	OsdKorNzzWyaBYfori3j234DgZ70RNd21CdeLyUzw/rlIOG8C59rDKxBjaD0MLjh
	vGZc24A96teBnomfr4Ae4KTPi6hHrYrBNUr+/q7Vqb+Q05X8Alk1pebXixwYNuSU
	qbOKJ2KF3+WUmrq+/ZCG838mnOcprdudjJZ3tkxtB0j8g5x6369OfNP5TbuoSJ+4
	QsJ3LO/nzrwIKQkTj2OARK43XPfvOchUI7JWrqlRP45vQ2n/0/3BeEfvchUW0KOd
	hQOkKLMCIGKLhtxzIC21uw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6gxx0upw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 09:14:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64L9EgKB006459;
	Thu, 21 May 2026 09:14:46 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011023.outbound.protection.outlook.com [40.93.194.23])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1db73p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 09:14:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMmkVcDna5+VrvzDnOIFsZGXbZZdiKEPbmyA/VspjZ44wTSTBzigDfkdR5duNRNwBswF5J6LwUXfYGRMdQk+OlKUgz7G7X/yTyr8ItEsvkm6e6qEm/eAXVWyHoJFdDtBXqsqIuF0NTWVOEUp9WCbPzIReFt6cc696WX/fRkcoM96nAgBfAtUmmZpFCPNIGtqzI/y67ENcAWjPx/9pzpV/LC9dApFgoZaevl7zeuAeFY/eMNOdj2vzonOcKChZrpbLEFCS9GpsLzpMOq0X7TxbSIhrRTE5zMMwKCw5LjTcpaVKMMu1nVOzQyyaCJbkRgrO2cunf+eAhce5Es9CZukWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIwUQ+Mq3z0V3bUEfW3O9y5O+U+X9Qd2OPUf1RyxbvE=;
 b=JjOpABXxOqcpvGSSWNFwsAq8NCdlid9tnZMnVe7utug05dXiFP7qZhWFPVlhbQoWYsrLFnM1rhlr/ergqrRjBJTwBJ0h8HSBcPE8z+vwTkA0R7IkLVy0sW1FMzhdsToIo+ux4bLgo0wRnu3lNASxNsl9ZX5WZPRsU0rZFw4AlRwFAx/9yjygoD7qRP8T0WkP3vWqK2/pR/OoFcTnsinJs9OeEIGKBKY92ryRe3lJ5iXfKdEJe1Z84MPSUxovO/iMskwcALUaD+zlopnSAAddkuvkYPVDNmlWcGtcHzfzb5UU686AM6WQqJlbEIz3mdEiWRu0UO98jcQZ1A7HjQnOPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIwUQ+Mq3z0V3bUEfW3O9y5O+U+X9Qd2OPUf1RyxbvE=;
 b=hjpxMjx/gQ1avbUMWez/mannnaNbtZ0/b5UcGRRMaVfRr32bu/OZQbpyblI5Te/AJv2WAEqAqkuYaMwgY2yiXlpAWHvcKcQWQ598a9QYFbnwnrgA6zwmq9qmniESYYjJsXbHH8HVOk57i6EbhBdY8hUksTWHnL7DyLuljZ4jsco=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by DS7PR10MB5901.namprd10.prod.outlook.com (2603:10b6:8:87::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Thu, 21 May 2026 09:14:10 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 09:14:10 +0000
Message-ID: <c54fd01b-fe22-4c9c-8d5f-5b317de07a40@oracle.com>
Date: Thu, 21 May 2026 02:14:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 37/41] x86/kvmclock: Use TSC for sched_clock if it's
 constant and non-stop
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stephen Boyd
 <sboyd@kernel.org>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, Kiryl Shutsemau <kas@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
        Ajay Kaher <ajay.kaher@broadcom.com>,
        Alexey Makhalov <alexey.makhalov@broadcom.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski
 <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, John Stultz <jstultz@google.com>,
        Michael Kelley <mhklinux@outlook.com>,
        Tom Lendacky
 <thomas.lendacky@amd.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>
References: <20260515191942.1892718-1-seanjc@google.com>
 <20260515191942.1892718-38-seanjc@google.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20260515191942.1892718-38-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0040.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::24) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|DS7PR10MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: e9dac266-67c5-4e93-f890-08deb7195179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	24kQvVzRECU0IemoEPxAHq5MIb8pgBFGzdT9zsqt/x5CrsJv2vtqJgCoqDzJlCuQfLv6vAXLP5RV7CP6PMy3q3pOph57C0lwhR2ZqPpACUQDs6r/hFqjI5ZehkJ56wNV5m3PCoRxmsI/KKjKmtpqBUPqOtyZYCHM8rRM9R6cWhpz94PwluGT9yDImi2JKGpIJ8eWrM51Hg+OE+OgUXayoM3RUYsfhzwsPAT5cVahSTA/yX07YUvhvQyHZlOnyKqfetOKEQD83ohuWD6KkHFdP5TtYsrg+CIu64f3lKHUaQ/lWugTnzIFyaSvDwdOslKTTF4b4t//3igTexpD7kJu0VtZKQQtmZmll1Ez7V4n+LTlq0YPKvDn5wL7d4yCvYjdQaphMw988GBe1p8kaX8TWalsnvPlYCeMxwNb/wh4VCxEEPgbDl+j4z3IEOGO7ACiCEEf/Psp/t2GdP20l3ZvEU0ZNBIUM6TwoN17kBMrEXtPHZ/KHp1Ks5VqOGJwZW/SluqCQ8Gf2PzH/qlTec+0XbK165YwLzj0c2+dOSbOepGeT+7cGkJNhnGejUXDH7R/WIFi4+Vs5QcvA33/YHIdcEmzaJdME3OdXuVq4+1idHGCmnlQWvWGd/5XTQzIKr+/aiPinytQGUVviPN+yeJmGWPD15YoBOqxpW0krqyomomE84w0EMjwLiKcOp1Yr2zA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5109.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmkzeHk0dm9Xc0l1ZU13bnIzL294MnJrQ25SNUxOa1JXQi9ZbkJVYTU5OWZB?=
 =?utf-8?B?Znp3eTg2VlQ3Rmtia2JmYjMxUGpjam5RanZGdnZxRnBzVk1VR3BTcVFUVklI?=
 =?utf-8?B?UUdncW5DVk5PK1Noek9YQi9MOEVlcjVsZU1jZVFiTEdMUzBmVnl0QlU2dFgv?=
 =?utf-8?B?N3U2MHpVU0p6K090ZlRaaWFDWk91cFR0SGxwdzk2dW5Id2p4aCswYVhTSDdk?=
 =?utf-8?B?TFE4ZWJRMmFFVUdqOERKd3R0akhDREdlaDVDUGJsV2tLU284ZDJFUTYxMzRU?=
 =?utf-8?B?eEZzQ2hzV3dpYXF0R0d6UmtCQUcvcGNVNHNMSlNvbWJoU2tMTHNiejZyaEN4?=
 =?utf-8?B?VitFTVRtQlpDN0FRRGx3RnEyUmgrZVpxa3kzU2RYY01VRWR5UjNYSnRsdjdm?=
 =?utf-8?B?MTFPcWs0Znl6SWcrZUZkcUxKQTFONDVCR05kKzlWeEticCtWRFEyNWxwYTQy?=
 =?utf-8?B?UlRjSklFenRiU3Jwa0plUGIrNGIxN1h2RzlwWnI3OTBPVWhwWWpEbG5oY3VF?=
 =?utf-8?B?Nzh2WGdoSHhvNG5lRVRrcDRNYjh0Q0JaYUlURHBtS0JTNXI0VkhzTEJxMUt4?=
 =?utf-8?B?dk45ajl5UWd2b3U3ZVcvcXNTdnk0dXhIdzlhOWFlMEcxa2Z1UVVXbnVDV0p0?=
 =?utf-8?B?K1RLNFkrczJwaFBsdERBQktwd3JGaFlvLzZDZi80SDc5NTJudGd1Y2VGOExQ?=
 =?utf-8?B?K0tBalN6RXd2MWNtQTdwZUt1YkdvekMzVW9NUkVXZzlmVnRUQ21wUFVPV2FU?=
 =?utf-8?B?Z1ZMamloYitWR1VqTmt5VnByRlJ1MlNtbzBqM3NrM3pDUWw3Yit5cXFMMU9W?=
 =?utf-8?B?Y2E2bzFmVCtlWWNiZDA3ei9iRWRYRTlyWmZ3U3lDMUpTMzZMSXFqT2pWeFBY?=
 =?utf-8?B?V0ZJaDJQK1hKUlk0QmRxc0hsUHg4TnRxTmxWVVowT3V2Ym1MemZrM3l1T2wy?=
 =?utf-8?B?cWx1M0Ntc0gzNG42Vkp6RmJna0dVT3pnZTdkcGxSRkJYZWR6THVLMGNsenNJ?=
 =?utf-8?B?WGVoWkxsRFZoc0xSWmk1UytKR3FTQUR5VnFQcHFlcnBNSzZVRDEwWjU1K0V5?=
 =?utf-8?B?UDJiZXdCaFQvTDFVYXhENi9FMmwwUG5wTGJGSWtQNndBcnNuSG9xM1BDOUht?=
 =?utf-8?B?N3BWOWs0MEJ3L2ZabWtLTlhlUzk0K2ZsTjNEOXUwTTZlbGJhalFQM0tkRFF2?=
 =?utf-8?B?dGd1bjBzWTA3NFpyQmZEQUY1S1hpMm9KM2NXSXhBNWsrVlF0Q1ZKamRpbThO?=
 =?utf-8?B?RXJ3STliaFp6TysyQzVRSW5vQXhEdXUvUzZIZWx3OWNubTh5RHBwQVNJbzJy?=
 =?utf-8?B?b0ViU2tpMGJGL24vMHlDSjdROStGYUdTR1l0QmVoRUJqMmNmUTRjZ1BHNDNq?=
 =?utf-8?B?R04rQ3ZRK3REek1yNzZseWJtNEMzdUtGdnJWUzlXbCtMNUs1cW55QXhZWC84?=
 =?utf-8?B?b25zcjBuc2hyOCtMU3k4djU4S0tWdEh3V2NZL2ZRcUdUZ1hISHMvTVBKRmtO?=
 =?utf-8?B?Y3h2YzZNN0lMSm9hK2s0Q0d3ZjcxMnpkSFgreExJV1EwVDc4bGFOd2tDOGlo?=
 =?utf-8?B?UmVqQUpQQ3dveXNZa3JsWTl3VkQ4cXhPWEt4b0NyRC9IVXV1d2lHWnVKNTVa?=
 =?utf-8?B?cFNVYUt6NnJiZllhYTJ6N2RMQTB3SEpPbzlvQ0F0TC9tUWFGcXV6QUNIUDIz?=
 =?utf-8?B?VllDSnA2c1FUN1JRempvYUZYeTBNQTByZWJHWTl1SjZhK2ZNcnlYLzQzWVFz?=
 =?utf-8?B?MUY3Q3QzdDd5RG9mbmNaUGdvZHdjek5XVW1KN1Z3Tmx4bGRlb0Ixb3I0QTJw?=
 =?utf-8?B?dTVYa1dOeHBCZFp4SE0vZlBtWDhCeXI1SW9rOSs0cWJoUnNBUVh5bkVkYVI2?=
 =?utf-8?B?KzQ3NVhpVkFoOXEzRTFjTHRHZ3hMRGlaSHpGZTJXeU02QTA2S2RFVDAranN3?=
 =?utf-8?B?WEpVQ2VEWFBqYTFOZEttelRBNE4wU3Zua2ZMR3FsTHpxT1hSSkZ1UzBmVnU2?=
 =?utf-8?B?WUlkUXF6bEg3aXhFU0V3ZUdzendLTXlhS092NGJoK1MwZWRlbkRHTDBEeVZv?=
 =?utf-8?B?UGVhQldtS3Zpb1JBRVhzUkFWKzZ1bFBidnRGMjY1MDl1Z2sydlB5U2ZXOXBE?=
 =?utf-8?B?NE01QUp4Z1RsS3NyMURaRG1YaEVXTzNFM0pyT0xLM2NiWHMzM3BjNUJyTVNs?=
 =?utf-8?B?aitUZXhpRVMvd2lYdkNxTWRwSlBGZGcrS1dPMnM0UHdtMmZVeGZKNm5odlB6?=
 =?utf-8?B?ckt0TTFCSzcyb2Z5OFRtTWM4UHpQQ2xzejFrNTU3WFFWWENBeERIdno3bUxl?=
 =?utf-8?B?T1hpd2dXOUVDWEpQdTFjbkx6Rmd0R2lMTmRxeksvd3lHaVBrNXg4TnR5KzB5?=
 =?utf-8?Q?nUr1LVMVNcqzvIns=3D?=
X-Exchange-RoutingPolicyChecked:
	r/aMK27DBZ5omRmnw87u45ukgI6Yh93acU+nKWkmu64PfRo95asypkVBU1Gw1sR7PxRQYbDxm9eZ1rxVZkgiaxrqjRRMQbFm0FFgVfD0tp7JqkXZyXAUnLxybPm87uEC7JSt2A1fPxDaxqjeYIVU+JyQA93WX4DCDXWY58S78vs+iIYG7VcXfEVdEjn9Au3E7gcnxWT1pOhoBIFlBpeSgZ6YfVUd7xoCK6C5PtZ295BFSxV/ohtWeRryJeq9U8AQ0F4+XLDDDRjLAfzCY/q9XWh47yeTtvnTeCCDqMHNge5aEzBKP8jw7zD6sOc3BFG6ziYg3Vfemk5LfHb34F/Gjw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VwyTa46qmtiMPKOGpWVqduIsyDbdnlqf2k8Suyit6rsPV1gX6PBDLQKZRY7Ns028Rc4Rnci1pmFH2mxQ6GyXfgwtRuKtjviPuOKgmNR0HqwGMRv2t3SGBTq7EF7Pfc1GGzU5OACsJ+n49M+fIAsrxeZTbiriFLjP2Qa0ukHsm2FFdiQCsRgzY/PUAUqZ5WKajdxsUygD5tOuiXuTPSTHCmWG4uZUck20gcwDBMZTYg1lX2RmaN3jcuqQ0FwPhu5RHUQP7eIexi/zjTDqPPcFWWCiuNZ3BJYtBn7P3/THKy75HAuhr666eDh8beDU1R5GQywmXNtERbkToGmPKmZIWeZGVTXnzXy7/kqZvK0xmgFcA434WdTEUHt7mW+oH+woydUzXa08EfNUdEIhbAWv4kU3ksueOtX2cdimUuSH991tu7Vk70XskkOj3TXPQ9Y241WnaR0zrylt3GIGbaAhh2o/lpD6szcAWgzr/ddrOJ73z82EtSeNZasMNK/MCN5+osTD8eUIbN7m9x/4HO37R5o5/PT2jZJVY3zy1bHMh6UOy4CwjD0Sbaqo/FX0/PPh6dhcM82IJ5Wz5julmGpoq+kIWzjPzZNTwOKUaXkKId0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9dac266-67c5-4e93-f890-08deb7195179
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 09:14:10.5028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImDLn1WoPl8lQsGBFpQk9lmKVqJQ48uOknIaKeLR3Q8YHRWuF4NzEkRquo8H7CygzKtocJvwFluBp3+tdzwoeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605210091
X-Authority-Analysis: v=2.4 cv=UOjt2ify c=1 sm=1 tr=0 ts=6a0ecd07 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=x44POAVFR4TL_THfJn8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: c1Aj3caNtlePCMRWmEJ9PHv6-J8wM_Xv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA5MSBTYWx0ZWRfX5/PNePRRk1Sx
 asmthYZA0q/N5hLPX5xdAcnMywXh7LHMNAMsjpZEIcgBWQYPstfPMBRFM4Djf6ei7xpNv1V3tGf
 40dwA1zp+T3aRcQE1Wa3qTNs1QJt5UXUClRigrgiBBi24Q3Ry0mHnUiCP2qBhIZkJBV6ke5K8I8
 /A/P+hTBN996E+9aJhDDY7WWTm/A7RUCAWVEubVdPyqiDwhL1azDDhverIkHH5NxL2o9kDwYeuQ
 hE94H4UtFaMiWOZDi4L5JOMXMVnH3YJZi0OyMX/bRkGaFgzcX7rXrrmsOYbA2zOcm2UF3aUfYoC
 lPpureNOy4G10SB4wYghmdohK7fs+cjb7Yj+pGduY5lZFAoc4SuhtRT16fbmxXpWcQUBR9Se/v6
 UTiQ1EFlKigTqT8ho4wDw6I91gHZTNqMKO5dbgNekm55ytnUwMnp0Odh0G251eD5sBPUZh1FhNr
 rObKcDYHaPgBWMxUMcg==
X-Proofpoint-GUID: c1Aj3caNtlePCMRWmEJ9PHv6-J8wM_Xv
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	TAGGED_FROM(0.00)[bounces-11124-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,redhat.com,broadcom.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.xenproject.org,microsoft.com,siemens.com,linux.intel.com,infradead.org,suse.com,google.com,outlook.com,amd.com,linutronix.de,amazon.co.uk];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongli.zhang@oracle.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 02F5F5A26D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026-05-15 12:19 PM, Sean Christopherson wrote:
> Prefer the TSC over kvmclock for sched_clock if the TSC is constant,
> nonstop, and not marked unstable via command line.  I.e. use the same
> criteria as tweaking the clocksource rating so that TSC is preferred over
> kvmclock.  Per the below comment from native_sched_clock(), sched_clock
> is more tolerant of slop than clocksource; using TSC for clocksource but
> not sched_clock makes little to no sense, especially now that KVM CoCo
> guests with a trusted TSC use TSC, not kvmclock.
> 
>         /*
>          * Fall back to jiffies if there's no TSC available:
>          * ( But note that we still use it if the TSC is marked
>          *   unstable. We do this because unlike Time Of Day,
>          *   the scheduler clock tolerates small errors and it's
>          *   very important for it to be as fast as the platform
>          *   can achieve it. )
>          */
> 
> The only advantage of using kvmclock is that doing so allows for early
> and common detection of PVCLOCK_GUEST_STOPPED, but that code has been
> broken for over two years with nary a complaint, i.e. it can't be
> _that_ valuable.  And as above, certain types of KVM guests are losing
> the functionality regardless, i.e. acknowledging PVCLOCK_GUEST_STOPPED
> needs to be decoupled from sched_clock() no matter what.

Has it been broken for two years because of pvclock_clocksource_read_nowd()?

Thank you very much!

Dongli Zhang

