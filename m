Return-Path: <linux-hyperv+bounces-4861-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D8CA83908
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Apr 2025 08:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5774C1B637F6
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Apr 2025 06:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC684202C5D;
	Thu, 10 Apr 2025 06:17:50 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D081FBEA6;
	Thu, 10 Apr 2025 06:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744265870; cv=fail; b=VBif8gZhJ+gIOt2sMtjXYTL6wrFPzqvFqSy7VbTmd8VBGK6Ds2KBmaOd+gH+q0rewBDeaXj9Xl/bHPeZBq8CR9vDlL7l2KQtD3Kcs++Pcoz3tNT79h2rE6VV5xUIqjKgNsbL7PXy/1f3AWkYB6wgKI4DLVMWI0C4i0K6UYVbcZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744265870; c=relaxed/simple;
	bh=dYDnabBzsRObnSLWsZ5L1sgJZ2OEzdx3DjnkyKJAe00=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=jXab77YLB2AICdoYwZtOQq5582AhcJpmlYrSTYYj4iTjAQcsHQCpKWr75XzDL5ciMrmO4j90GQ4Izl5pcIsAHq3fDGN9+zDG/6xo8f+0AfPUw2f2nV9/VAgI+eqdjfaIdzd+lURhMGZa1IyOJbehr3loToUZp2dde649+9WAnrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A5eYIF001118;
	Thu, 10 Apr 2025 06:17:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45tsr1pgvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 06:17:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0LUn/PnZ05nCnnHB5w75LhvBGUNWYaKdoSHANYDIhgthO+r403tkROi9fpsoIljbCdk++HdFYGEzJfJlkZtQ7PrxTy5w9RoV6qV6y58ZzA7AvA40IIQMIR5duhXsih+NoGIct/hsvCc2/GMmtxWuZEi1OQ5D1f8cbsLfzrgqNIRbTBEtNKpjYFopdNAD9RAsN4lXqrGSoP8HX6Zcmt3AflDyKbnbG9AooFVG47CjSGWGNhcHBQkMf6LxbwopxZzQsIuf+opUQgj+cbCB7UQCgBhwunVEvdbm+2iu8wSKiMJ/FanqrbQiQKlHbhDzf40EBzrcyECFI9ZhASUTffteg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYDnabBzsRObnSLWsZ5L1sgJZ2OEzdx3DjnkyKJAe00=;
 b=t79P5j+Zrf6e7h/nAyVJOHUkT5b6O1jqpHrXmCeB4pIQsEJj+J1+tioTcAGQW8198obZxoMLBdvQCxggKgaPqHjIxh+m4zFQ2ag3NIAM+vGgrjMk7imVcFNnKjo6m0L99cnx3IMMANKwRCoSqig0VLxz0jLyEShGl2drxexCEvrdqJdtUBOhnw/hZeIqmldYXIvutUIIGy8AMACVFhyQpxpkbevX+p7T4NYvDjA/nnxVgpqwTYFsfLIhsekGJtv79xHQbl/x8Ry9TrWU3FUuXQ4rHE86zXETYdjBlWMUVcV+rgwnUWR7qwcxR9sYWCQBE/ECva19NS6oJc7QFrxYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by PH0PR11MB5125.namprd11.prod.outlook.com (2603:10b6:510:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 06:17:21 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%5]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 06:17:20 +0000
Message-ID: <ecaa2736-1e5d-48aa-b06c-df78547a721c@windriver.com>
Date: Thu, 10 Apr 2025 14:14:58 +0800
User-Agent: Mozilla Thunderbird
From: He Zhe <zhe.he@windriver.com>
Content-Language: en-US
To: rick.p.edgecombe@intel.com, mhklinux@outlook.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        kirill.shutemov@linux.intel.com, wei.liu@kernel.org
Cc: linux-hyperv@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: vmbus CVE-2024-36912 CVE-2024-36913
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWP286CA0033.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::18) To SA3PR11MB7527.namprd11.prod.outlook.com
 (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|PH0PR11MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: ed15249e-a471-4404-7ee6-08dd77f759ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3dDbi9LdVA5THFhSjlDYnB3YkFOa2lDbVNYdzhheFg3V0QrVWRaWVlWdWVa?=
 =?utf-8?B?OGVQL3BXTlRPNG16VHdkRC9mT1NWbjZ5R0JLa1dJVXNHTVdCcy9qOC9XM1Zq?=
 =?utf-8?B?WEtZYTRPck9SdUVZU0EzTGZYd2pIR3Rvc0pyZktyd3pMY2gzckh6K0NpL0FX?=
 =?utf-8?B?YUdjVEhzdkJpTFd6L3NpdVJpM1FVS05jUHZ1cW9yM3BGaEIwQmRYU1dWY1Bu?=
 =?utf-8?B?VVlKUldHSTkrYXpsdWc4SVpWUnhtVTF6TVBIWVI4ZWZIMlFmSUp3Ri92OHFE?=
 =?utf-8?B?Rm83QnRndzJBTHg5eGdSMHIzYUdIbkVMdXhDY3lVZ2FJQnd6ZEY3b2xZTWJC?=
 =?utf-8?B?ckpTUVRJQVJtajFQTmJJRXpzblRvdnZWUDZuMTJrcVNRUk96WVNPYWN5WmVj?=
 =?utf-8?B?ay8wak4va2lza3gvMDdURnU0aE5JNWp5cngyNUw4L0hiUXBRcXFLNitmajZm?=
 =?utf-8?B?ZlRJMEdYTE5NNzA3bU1RY2lzYmJ3Qnd6d09UMmxRUEN3NjRzUStXM0hqd1Er?=
 =?utf-8?B?QlpoSENrSldXbi9vZFVqVjB4eWZIOEFKU1BBUzBqM0JiZDNsSGhUcnJOc0hm?=
 =?utf-8?B?SEcrS2g1bzV6TDQ1dDRrN2I4Riswbm9WOHFNYmp4V3dMeXZwMTFXK3pvbGhm?=
 =?utf-8?B?Y3lEcHFUbWRqOXpRa1JKVHpZNGFnTEFnSGZsWkJlZlVqemFFWWFGU2gxdEtT?=
 =?utf-8?B?MU5PSXdQcXdOQ1VGOC85VldBSFFUWmlwcTRidmJMZXltai9tU3dnODAvUkZp?=
 =?utf-8?B?OFdnU284blVZM3ZGV2c5NXJ0T2VtL1c5SldEdFQvTmZuQzFRRVRLZHNjdUlW?=
 =?utf-8?B?MzVmaXZWY2dxM0hRS003dmdPNGMveVo4VzhLeW0zMnVHTThodmVjMzRNaWpN?=
 =?utf-8?B?Rm5kZzlMNWJtMXZqOCtIRGVsNDFwajhWZTNOaXJkOU9FY2VqRWt0YlRrTjdJ?=
 =?utf-8?B?SFRrSUZlNklqL2FKL3RITUo2NE9xMFJVd2FDN1A0RnhGNlZPSElxUkM3S1Uw?=
 =?utf-8?B?TXZBNnFDQXVmT1VZS2dLWHJWSWI0RWg0R3Uya0h1MngwS1YrbGt2TkF5aVd0?=
 =?utf-8?B?M05ZdUhjYUhTSm9VdHhlbGV4RlBlRUZFbmZuVWF1RTZxK1lqUlkwMHNNdDdO?=
 =?utf-8?B?c2NOQmNqcE5qYldibnlCcDRGK3VNdVFKVG5mbkVDbGs3SndTYkJBTjBrZStr?=
 =?utf-8?B?cklxbDNBSVViT3FuN1owOXhsS1g5dkdyWG5RU1hnUFhwUGZ4Y1lwYUIzb1Vm?=
 =?utf-8?B?YUoyWVI1ckNleHZoSHlpa29NN3NiNHZpYVExR2MxUUhlUmw2MEFNWTl6ZHEr?=
 =?utf-8?B?RmU4WUM1NXBRL1NnZkVZR0w5K3Y5Z0tDc2xlOFdWdFc5cmVIZjZuRnBKamJQ?=
 =?utf-8?B?SUJyT285YWRXZHFkamV1cWpTdEJ2T2JwTUdaREI0cURNRldDT080cXJnaGF2?=
 =?utf-8?B?emNWNm5XbU55SnUzYzJBU092UUdrYzBSQTZrUGlvU0QzaG5PaUw2blhtY29E?=
 =?utf-8?B?YmtQL09CTmZVY3JvWGlYNnFpR0UzTHNtSmdLS1hLSTZQcFFlRnN2UUMxV3lO?=
 =?utf-8?B?SnNmWkRJbEpJenB5UWRJOEZQT1lrbmVYRXM3Rjg1c3FjN0lhQWU5N3NCaTZs?=
 =?utf-8?B?cTExM0crVTBZN1NNdEVnc3orc3RvQWM4cWI3d2xmelExaEk0WWF4cFpob2VC?=
 =?utf-8?B?VjZyRDhrL3k5akxBdURxNXZZZkllYnBNY09ueWZ1UEZMMXZoc25LZmpBQURl?=
 =?utf-8?B?Tnh0ZGtxTFp4bFJsMXJvakd6RTlvUi8xcWR4ZmxKWjJweGx4MnJOc3ZkRWpm?=
 =?utf-8?B?M0tKY2dFNWFHL1pZc0ROZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QS9GQjdoL1JXTHVOVzlHdnA2UW14NmtHTW93YUlXb3pnczUxTVdiRkttY0dz?=
 =?utf-8?B?cjMzUDd1Y2JFbmtlVWR1YWNYWkxtb2tSZHlNV2cxSktsVDRkU1BtNUthVW1Z?=
 =?utf-8?B?OCt3OHQwV0Zlc0o4ckx2MERlNkpjaUkxRFJJNWJiRFYyVXpqNGt1UWNJaG1I?=
 =?utf-8?B?bkpvb1lEdGRWMVU0SDdHaXdTMnJ0Qm1Cc0JTNXFPRVFTSEhPRDZwSkF1bXN2?=
 =?utf-8?B?N1V1VGcwcFBEa3JlWFpmNy9SZVFJY2tyb1pxcEZVc2UzOE03ZWlLZHk5L2tt?=
 =?utf-8?B?dVE5V0ZCY2ZmSXdIaGJKWENUeDJtbWdjS3MxZzk0dHZDRVpTVWN3SjNBQ1FU?=
 =?utf-8?B?Tm81ZE04ZGJHVndDR2I4cUVrYW9udVN5UHdRTjYxaGRZaVZMRjl6RDFXMEUz?=
 =?utf-8?B?QVZsOFRFZllKY3pDUlUvbVpEZEI5MVVYL25LZzhuTDdHZS9kQ3lnM012bGNu?=
 =?utf-8?B?MWUwNHgvQVY1TURHMTlFZ1krbVFYazFMZm1hTDlhMmRKSHVaT0tzc0MzN0FQ?=
 =?utf-8?B?LzJyeFh0TnAzYUM3Q1l4c25Nd1U3OVVGenlGQVlBeDBTWmlQSWQ0bWFXSVR3?=
 =?utf-8?B?enJ3U0NwNnA1Z0hGcVVMSzJCSmMyMDlQV0lvVC9uMnNQWlh3bTR3bTFvZ0tm?=
 =?utf-8?B?TFoyU1I2NzZ1M3JTdXcvMEUyS1phT1ZnM0RTWE9vUGlNREdjU1ZOQVRYQ2FK?=
 =?utf-8?B?RWRKRzRaNkt4NEl3aHVramxWcitTb0pWQ0tJSVlsWmxOYTBCZ2owMGpNS2U5?=
 =?utf-8?B?QzQydFhyYklDRHEvYXZOSGZPL0M5ZWxmeVZJVUF0WThRVnNoZUtvN3VGNHhr?=
 =?utf-8?B?U2xnajdFVnl6NXVoaXNpK1hBVTdpTHpqWkR3VGxmYXppOGJVcGJjUW0rNEtj?=
 =?utf-8?B?TnNSZHhQM2FxMGFadVhFTmVhUFFOTW5jdkowSnNLVE5aa3lRay9nUjI0UjRD?=
 =?utf-8?B?S0hsTFMwdCs4MHZQam5kVDg3dVVPc1hURlovM1hmczR5d0RIc3l2cG5xaFRx?=
 =?utf-8?B?UDRzMUROMlJFNzU5aWNxR2xFWDltMHN0aWhWblRna09HcUJqQmQ2VVRPQzMz?=
 =?utf-8?B?UFZDaFY1TnlkVjNpc3RLYnRyWHNXd0svOTBaaUhQSFBGVFNxb3I0SE1mSGx2?=
 =?utf-8?B?Yk1CSUx3RWRZRWduOHI5Nys5QkYrY3d3Zys0R2ZqTklnUGc4MGZLUndjc1Nl?=
 =?utf-8?B?aHlIWXRMeFZ0WUxKS2RnWXhmRkh0K0w1di9Pa1FXRnpHRDRqYVlRK3Z3UTRq?=
 =?utf-8?B?em9zWjVWTG91ekVscG1QNVE4TndTWlQvS3pBWk5oaHRLNDlvZzNTS3Iwd0ht?=
 =?utf-8?B?T0dOd21WeEpzaWl1Qm52YWR3bDBFVFZXZ2wyVDdUNFJFeU4rSVBsRnVYZUhK?=
 =?utf-8?B?WFo0R2NXdStMUDJhOHhXR3diZnNrcU5zSGpYT3RSdzdzV2J3UlVVQkdDcmZx?=
 =?utf-8?B?QzNpd3FjYU1DU2puQXRiSnc0TXUraE5pMmZ1VnpONmEwV0g2WkFYQXZWcG14?=
 =?utf-8?B?Q2hiZ0xLVlpDT0EvS1IwTU16ZmtTTlZRa0VOUDFzdkVuUWFSazNZTHMzZXpw?=
 =?utf-8?B?RUwwVmJ2Q0ZKOVB6MXJYRjB4Y09GMVJ2OVFRRUlaS2R3WUR3RFZhZDhlUzJ0?=
 =?utf-8?B?MWxzS2ZVSFhzbCtFV3R2QS9UamdlcGVWOWs2MDd3RnhWRXI2Ujh2c2ZmWkpx?=
 =?utf-8?B?WU8xVVVNa0p4NzNPaUNyWmJRSFNZKzQzbE5oUU5vcE4vanNCWWVWUGVFK3Rq?=
 =?utf-8?B?OUhyZ1NDSFpXZ3JRVk5TajVRUzYzM0k4MnQySFpCRHhMRDVKTUlBUzd6enQv?=
 =?utf-8?B?U1FZYUlMSjVneUM5ZDBxYnAzTnFpd0ZTRXY4dkdTQXBvUDdlT0UzOFo0c2ta?=
 =?utf-8?B?dDNHUWRmV1lzUHpDYjJMVW9rVWcwSmZTQ0pIWFNFcGYydXZkYXZhTjBFb2lN?=
 =?utf-8?B?bFhONXdOTUtZcGZFbjl5aFhGM09kMXJhZGVsZFNmNnNWOVhqQXl5SzJXZEc4?=
 =?utf-8?B?QVhqOXdnWHFQTWhVSXdTUDRpbFNubVp1b2VnR0tmZ0xnZkhWdm13TWVqc1Fm?=
 =?utf-8?B?Zm50enUrczR0ckRpaUxzY3N6N0sraWdNS09XNythYXlRN0V4SzZSUFQzM2FT?=
 =?utf-8?Q?nroGTY2y30RAAx5XJ3VVO28Jx?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed15249e-a471-4404-7ee6-08dd77f759ce
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 06:17:20.6165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 469p6YIiEuER0PF8OWfiSNtJWbrzLn/6UeRneyrJOHN9G6pF+xHdvVTVjVRmU1k45fZ1qv+sckc4P6WAulIBwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5125
X-Authority-Analysis: v=2.4 cv=Td6WtQQh c=1 sm=1 tr=0 ts=67f76275 cx=c_pps a=6L7f6dt9FWfToKUQdDsCmg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=8r2qhXULAAAA:8 a=q5Fr2JSw9jctpPho2PUA:9 a=QEXdDO2ut3YA:10 a=8gvLZcY7Nlvl4CGD_6nf:22
X-Proofpoint-ORIG-GUID: 0z61oy0aX_BnNrqnv7ae8T9SkZ6G_Jgi
X-Proofpoint-GUID: 0z61oy0aX_BnNrqnv7ae8T9SkZ6G_Jgi
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_06,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 mlxlogscore=874 clxscore=1011 lowpriorityscore=0 adultscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504100045

Hello,

I'm investigating if v5.15 and early versions are vulnerable to the following CVEs. Could you please help confirm the following cases?

For CVE-2024-36912, the suggested fix is 211f514ebf1e ("Drivers: hv: vmbus: Track decrypted status in vmbus_gpadl") according to https://www.cve.org/CVERecord?id=CVE-2024-36912
It seems 211f514ebf1e is based on d4dccf353db8 ("Drivers: hv: vmbus: Mark vmbus ring buffer visible to host in Isolation VM") which was introduced since v5.16. For v5.15 and early versions, vmbus ring buffer hadn't been made visible to host, so there's no need to backport 211f514ebf1e to those versions, right?

For CVE-2024-36913, the suggested fix is 03f5a999adba ("Drivers: hv: vmbus: Leak pages if set_memory_encrypted() fails") according to https://www.cve.org/CVERecord?id=CVE-2024-36913
It seems 03f5a999adba is based on f2f136c05fb6 ("Drivers: hv: vmbus: Add SNP support for VMbus channel initiate message") which was introduced since v5.16. For v5.15 and early verions, monitor pages hadn't been made visible to host, so there's no need to backport 03f5a999adba to those versions, right?


Thanks,
Zhe

