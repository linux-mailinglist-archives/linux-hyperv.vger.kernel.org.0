Return-Path: <linux-hyperv+bounces-8862-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Dk5GhpFk2kP3AEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8862-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Feb 2026 17:26:02 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0F2146217
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Feb 2026 17:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D702301AB97
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Feb 2026 16:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F6D33372D;
	Mon, 16 Feb 2026 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="A1zVTVxc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010037.outbound.protection.outlook.com [52.101.84.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB34D263C9F;
	Mon, 16 Feb 2026 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771259109; cv=fail; b=HLCiwaYM3GijMvOEbvOMDQATRFAtmIWaEl+Gji4Ky7G8MoGlvxb/R123USDXvWl91wIrIJg5yc+lx+4VeC0wRgkn1tz6ki5xsyNJ7tiIMcrUQqeAqEE8NowUAGNs5IPERZg2xezqd1birgoqKAQoOjcERfR5io2OyX1HP66dXC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771259109; c=relaxed/simple;
	bh=N+aokoKOTWQsVZI4IZpLhEfsQ0lHEHgu2B7IWBBd82g=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=tCE1y6x4niwpgYCFr4nZ5fb5yqhpH9c7XyH0vOWAnKyJGzDayGv/RvH5RG8UKvc6mFHpNDNQQl6hN9OUJHxSaH/UboQzv+HXBDaDiyinD94G2BfHQY0s1kIOWT2WaIFiv3EcOPYcJGQVwEkkZ0RzH5x2qNR7mNm3it7vV12o408=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=A1zVTVxc; arc=fail smtp.client-ip=52.101.84.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=So8oahLD5Im67koGkdDBbOXJP0i9x5nhxYtJKhg4I8bJQ7UxsPcmfyKPYGbVZpplUI5SrO5xac05ay3p1fL/M6kN64CHDvQuoNgvJ7gs00HT/Vc8A8nGX5D4ilQkjBlyieBRLe7UVTAJR7gUSjnodPX6f0q+hTFc8tjxa6Yf1kYYiWFjMkn0pxqGOJQd4OrLMDrd4VG18ua5rwbF5UQ53tJWJko8LIXSQ9T7Su5gduGEsg1OPB0LG+xzVX/Oc+u3EQJpDzjB4wux0RLdlgvx6mLoOgzz2g2e+JAMyA98zqXJGC3YktaRLb29k870578nH4Y5NWRtWwiU/26sSs/mCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uahA7ONprhO4pORNu6Npt1qoP+4Xm55Lz0DO7pTJ8fE=;
 b=DAIz0GnvKP+pvhS37YYcGPfEfvqqmei30ftIsfrFdLlDDR9chtkuW8ByxKlTU+XabK9jHwKLLydj2jyEo+yt5BbZGW5K+hxo/p0TCiSTSCH3goBCF+EUsKXCLlxgtH4Qmw0639UQzTcD8EwqLHN6699c9N5W+4EbOAGYwSL5Bblq2cXhsZqldR2SyxFdCct1KAFVNwLi3UNIugzwIkH3gZ1nyP/5T4w+GXEhDKhiLGbW1Yh26KvtSA5DnGxIZ0JNFPeRoY6Hag2O2d6luQ6xeUIVuTPRDOsXr1LxfRp5JvzwyH7opj2qHom7NupNvO1+QkI2mxBTomk/KVJY1RDQ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uahA7ONprhO4pORNu6Npt1qoP+4Xm55Lz0DO7pTJ8fE=;
 b=A1zVTVxc0ioH1FYSWMcKxn1IPNlCNfjrQH0xF84f7RH6aBQTYb37h3zkBylZjv+D9VBAbMblaFG6SchTXDJU9eQUsQjhXzbVpkPe1vSu2wtiv9Wr6nYyT/HL99PDOFISIiwrex3x9WSReso40h7RddZhBgHYdACrSMKCQgkuwr+yQ+t8ppUgjEPeADR63DaqFxZ6UPy6f4M7Ul4Vu7ZdlDeLRrdiUWcB0unDvR6fVpryXsxY5V/rN3Pc/KRN2OcdMj/XwFW9kuGQ5YBGwJBpUTP6/aglJuG3zN6gyMF1BXf0G2tGCoHc6ZPNhl1QXapjD4aRg1gNjA04xiLDCFUF1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3581.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:141::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 16:25:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 16:24:59 +0000
Message-ID: <289d8e52-40f8-4b22-8aa9-d0bd3bd15aae@siemens.com>
Date: Mon, 16 Feb 2026 17:24:56 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v3] drivers: hv: vmbus: Use kthread for vmbus interrupts on
 PREEMPT_RT
Content-Language: en-US
To: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 RT <linux-rt-users@vger.kernel.org>, Mitchell Levy
 <levymitchell0@gmail.com>, Michael Kelley <mhklinux@outlook.com>,
 Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
 Naman Jain <namjain@linux.microsoft.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0307.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3581:EE_
X-MS-Office365-Filtering-Correlation-Id: b0eb3cbb-40d8-4aa4-f4e5-08de6d77ee1d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzNVbmxTQjRsWnIrY01sTk1JRTQ2eHR4R2RGdWZwZ3dheDB2THEvNEl5V21Q?=
 =?utf-8?B?cnlrNCtLMnRmanN6MnhJbnpoaWp1eHUxL1QvYmgxQjNLVmo2eTNsZzJXdEJv?=
 =?utf-8?B?ZVl0OUZOODROVWtNaFRHVHpMc1BEWE5YWXFKM2RObWxzS0RZb3F5VmNxRzlT?=
 =?utf-8?B?MXJieDg2OTE2V3VPazY3UjZNQkhVOTFHVzFwNXV0clhJQzJONDNVUUc2b3Zm?=
 =?utf-8?B?VkVpL3lud0tLaHFkMENOeHI2aFNKbTIvZ2NMRWN5UjNWaWpwc2h4TmF5OUxh?=
 =?utf-8?B?bG0yUmdZZjdSd0o0WEExZXZmci9rREsrUFozZjNIS0F1eHVHSnR3QXFVRDVh?=
 =?utf-8?B?amRGSG1ScWF5V3AzMzFQUDJuakpwR3NpdDJieWxoVUFHN3hkRkNGc25SZnVW?=
 =?utf-8?B?cnVSaWxEUzVTSTJJN0s1VTlVZzlFNGt0NmhyTUxaOUNucDBQUVcwc00veEds?=
 =?utf-8?B?UGdOUy9IcXFRc0lFTzZjTWFJemZLNm8yaG0zRUxlZkdQWlJNSHRrZExCWEFu?=
 =?utf-8?B?bGVCSFJTNTN0M0NHU3JzZlozejNldU54Mm9VNWlCMzVpU1VqR3lrbFk2ZVJ6?=
 =?utf-8?B?TFJ2bittby8wTDZ1WEtQcm1qaHBzK2x1RzdPWFpteWxXSFJLMGxYSVZrdi9R?=
 =?utf-8?B?MWcwbHRtSkhrTnJ6STR2dE0vbHJHNmNRM3phY1FjTWJLL1JpVkIzM2V1bGxC?=
 =?utf-8?B?ZkhBcFp5NEdmOURpL0JJQ2c5dndFbjFLQXhERzMrTEE2czIvN2wzaHRTNUlR?=
 =?utf-8?B?cjEvNjdiYmZZQzQ4Zld0cTRiZUdnV2lnYktML0JUV3dTZVc5a1dnZmpuZEIx?=
 =?utf-8?B?Z2pRRHFpY1Q1Um03K0lZbkFITEdoMk43ZmM2NFBHTkVhYTJXcjFCNmpDMGpl?=
 =?utf-8?B?eEw1R0JrQjk0amNxZTREMnVGdmt0WnZDMHBmK3dDb3NOQ1FOZHZoZE9WdVkz?=
 =?utf-8?B?ejBLMENnd2tWdE9oZW55UzBLL1haQjVKZXhRL0JzRUpkem1xd0FSQndpdlda?=
 =?utf-8?B?SUY5cmlmYk9pOG8rSmlTQUh6UXlLcmMyWVRjSktuWUNMWEJBWGxtSUxxbW9O?=
 =?utf-8?B?TjJPRVVJS2hxNjNQWHQvWTdwSzBzWVZpWXlOek14NEp6WGxvcU1XU1doaklT?=
 =?utf-8?B?dXdza0VNcElTUitYdWpUUE1sOHRJTzVnR1dya2NINGpyT2xrZDhCY0o5R3Jr?=
 =?utf-8?B?UVdiVU1mWTZqMHZmcmhhSTVTRmZyWFRMRFdrS1pLK0w4UjVEbDY3TFFraHBq?=
 =?utf-8?B?RFZHektnWEFhRlBSbjdjb0ZpUWtNbSt6UGZDNTVnVGhJbEhTbHFRQ05vdjQ0?=
 =?utf-8?B?WHVsRURzMHZ1NU1lU25GOU9zZEJKb1phbTFHZm5YVmhiTDNHM3NtZldGU0wx?=
 =?utf-8?B?bnpVRm8xQm1LTjZQb1dvLzV6N285cVcwSGc3S25IZjcwa091NTB3VExRR2l3?=
 =?utf-8?B?eVVvS2lhaGs3L1NMcXR3RS81NU5DeDJoSnJYbEsrM0lpQnlLK3ZLNEdlMzlT?=
 =?utf-8?B?ZTVLcnRsNjE0R2FYcmVmcU5BTk1XL1FQeWhGbzlBZVl5MHE0cGx1TVhkMnds?=
 =?utf-8?B?MnNxMU9INEdIeXllaGp6alk5N0g4NVRGaW5xRXp0dVljTHJ2QVdZSU5CMEpT?=
 =?utf-8?B?TzhXTytQdTdSeWV3dU53ZUtMbThWSXp5d1pWdTltU1kwL0ttTE91SEQ2bVR3?=
 =?utf-8?B?c09jMFBMdHdMWFF5Q3d2TXUxakRIaVpXMzRvTGtQVVpTMW5sVWtTYlNvKzhM?=
 =?utf-8?B?UVFyMHJxMjFTRDJBZnh5U2NoOWp0YmpxUHQ4eWlmOUpJb0ZPRThpYXMvUHdC?=
 =?utf-8?B?UENlZ293dTd3YlpZWnBCK1BDUFFSZmtWakx4bVhycTlKN25UWVkySVV6UGRj?=
 =?utf-8?B?VWtHamtKQTdwNXFGdzJ4V1RadHIxWTNCMFQ4ZEsvQnhzeDFMWG0ydjhNL0dO?=
 =?utf-8?B?dEF3MWwyeHh2alNlV0liNnB2dlEzc29yZEZNNXVvZy9vKzRHa2pSaVFrcUU2?=
 =?utf-8?B?YWlDUWxId3BvMEZmSGFZL3pETm1vODJKK0Era0I5ekJCeTYvMzQ2OTUvM1Vq?=
 =?utf-8?B?Z2I3K2dhdENzTWtlYlU0OFRzRjlpMFFqbzVRcTJTaHNWYTlFMXc0QUZNdmpC?=
 =?utf-8?B?dVRJZVZ4VmJrdHRhdXI4bXhXdGp5czdHUlVtVWVibThBeElQL2RRMCtHQ3RV?=
 =?utf-8?B?Mmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEZITmdrak9TN1puUTVQZkMyZjVMTGdYZzZidEV5WndXa0Y2RDgwOGpaRGJh?=
 =?utf-8?B?ZlRMQlJWRVNmbEIzZXZaZVdZM1lBSUdLWDhRSm9zNEcrb3dRRURxcUw4QlZN?=
 =?utf-8?B?WTBhY0hQcjRoYkNNU2wxdWFFelZEbW1OV0ZmZHQ2djZKMTJlWkJpcXZpUHp5?=
 =?utf-8?B?TWxDQ1NtYjczK0pEWEFUSVJJUEkycUdOQVZVdFB5TTlwbEZlQjlVWjBrVXNZ?=
 =?utf-8?B?cGFCTlBYV21TZCtwcy9QTnF5RUUvbDB4czRQa0dCRk9STUFRQ2lsSmtsc3Rn?=
 =?utf-8?B?QnJvT0lWdTJycWgwemdDZzg5OXJxM3RjWDZqRkFBTDgwMjVCSWRXdk5LNkM5?=
 =?utf-8?B?OFJUZFN5NXRuTXVLYmgwOW9YK0FJenNRb0pTM2diQzR5eWtyNWVYUmxjVXF1?=
 =?utf-8?B?bmN6TGJyM0NWdWs2TFRhQlJzQmRpUlVMNkhJSllMSXhBUFl1b2VuaDk4SlNw?=
 =?utf-8?B?SGY3ZWE3dUIzMHgyMkJ4Y2I5QVg1V3BQWGE5aVNSODVad2hHQi9qN3RVUDJD?=
 =?utf-8?B?SjZaa3B6VUxRSS9QN1ZhbzNUKy9abHQyZFBpQS9MNFplQ0tBcXprT2hUbEZP?=
 =?utf-8?B?ck5mb1VHTnlvUENHYVk2ak1Eb0hoVmo2Q2VaR0JTcUN6OE5YUWVDOEJkS1hT?=
 =?utf-8?B?WXhGVitFQ2VVeGhJdEM5ZGdYWjJkN0ZrSVVRaXhMQ1c4Umd6V3VJS294ek5L?=
 =?utf-8?B?QWhFQmkxVFMraEdnK3IvTHZ0QkZQTFQ3QXdtSm43S0w3Rm5qUGdkZDIxWkxS?=
 =?utf-8?B?U1B2UGt1WjVsdm5xWDZjL2JRaEZ4S0VLZjgzMjRnYzZhVG5jTUVNcGZ2cTAw?=
 =?utf-8?B?T1luZmtnYXNLWCs5OThaeXZMN3dMQXVKMVVGRjdxTU85eVV2OXI0UlJpNmIy?=
 =?utf-8?B?VWMreFQxNE1oWmI0UGRIQmRDb3hJV2VkNjFCbGhnWmNFVkRkVXNFZlEvbHRR?=
 =?utf-8?B?a1BmS0xYdVlQR2hkNnhPWlBFRHRvVFJxeG9VNjNMZFdOUVpqN3R6MU81RSta?=
 =?utf-8?B?MitYem92dE0yUTBhV3JMVU5aYnVsNWY1YTk4SW9oUDBwMkVDNG44RWt6Y253?=
 =?utf-8?B?T0c2d0xPalhDK0I3SWR2aXFPb3RDdE9oMUVLc2lsbUcxYzhOeC9pTjJmRzRw?=
 =?utf-8?B?aW9iVVE3a2hMOTBYei9mN0szV0FyNHJUZnA1U0VIUGRqRkVKa0NyRWJTSGpa?=
 =?utf-8?B?UGlVWk5SU2owQ1pZNXIzNmh0V2RvYVpSai9mVVBaK2VobXZhOHhjNU1SVXh0?=
 =?utf-8?B?V0hyekdCdzRuUjdDVVFNREhVR2NqRFlpNHZFd1ZUc2xPd3ZXMlpNVis3ekdU?=
 =?utf-8?B?cjh0V2RCeUc4MzY3djRpeVQ5S3IrV3M4WXI3Rmx6dXpVdWZHVEtKUDkrQTlp?=
 =?utf-8?B?YldxMTdZaHBQajhSbm5uMHp0NjNJNmdIaVRPMFU3bTQ4cW1jVUxaeVFtb0NF?=
 =?utf-8?B?NEdnci9PS0w1SmdtdlVOZzVEYlFHQktuWVFmUC9sNWIzcEVxdEMzYnh6dUpv?=
 =?utf-8?B?SXNvUGlySVZaTnd0T3ExL1crb2J5WFFlYlNSdXEzU25FVzlvRVZHandFaHZC?=
 =?utf-8?B?VHBuMHI5OXNRTVBkR3NGZkpCMEp2QU10VVVpdGh4ckpDem1QVThFWm1nRVVi?=
 =?utf-8?B?cEQzQUh1a3E0emp4b1Z3OXN4WFlYQUliQUZBaWlmanJtNVNOSFo5YjNQb3J5?=
 =?utf-8?B?WE9qNVJXc2N4eFh1aERKbGV3MkVKVXRGalYxRVJaT1hOWkJXUE1EaGc1djNT?=
 =?utf-8?B?Q0lMdDZ2SEE3OHI5VkJUVmtJeXpZQy9WcytXMHBodlhDU3o1Yjg5d0lEajlE?=
 =?utf-8?B?QU9yeVZkQ0tFdktUdk5RaGFhYmQxWDA2YjFYQkFFVVZicFhnR1Fic0E0RmI4?=
 =?utf-8?B?UElPaGN0NFZiVGVtODc5SlJMNVNCYU5aQjJBVk9tSThyMVRKWjZGMUp0b0Ft?=
 =?utf-8?B?Q2d2Mk1yYkwvTThXWStYUEorRVU2dHF4UUliUmpaZW1UWkxFaUNVZzRoR0dF?=
 =?utf-8?B?bElOZ1JqbE9wZTJ6elorWmQ3cVQ0R1BRUTNFbGJSZEE1VEh1MDRObnBvWE1C?=
 =?utf-8?B?M1owT2ErQTRWQ3JpQXVSQkQrK0Rsak4ycFpiR1I4cDJmVUdhTU5neTdNZ0I1?=
 =?utf-8?B?VTNzUW5kT0drT1BSeXRxdlpUNDZjOFE0VjZKWXJzSjFJOTF0cWMzTzd1U05m?=
 =?utf-8?B?NE5BVjJsYTU4bW16SFZJY2pLZGtZQmxPb0xzd3ZXZVZpVVRhcnFpZ2pUVlNa?=
 =?utf-8?B?TlhkV2t2NEZCSGhzVEJrMDJaQlhNRzhaOFRmaEpWYUpPRjZYWG5kNTNzMC8r?=
 =?utf-8?B?VERGRnJCRnNtL3JzdmZXT2RkcVNuS3h6T1ZJdkl6bmZQUkhxQXd2UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0eb3cbb-40d8-4aa4-f4e5-08de6d77ee1d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 16:24:59.8577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDPMLJ2pCkzNrk2eSI3xRZxNTxL2XCyc8bUwokY3xGWPMRlFenS/foJNXVJBok9ZmG6gj8wr50iDkcTbY3Z2xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3581
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8862-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,siemens.com,gmail.com,outlook.com,linux.microsoft.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[siemens.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE0F2146217
X-Rspamd-Action: no action

From: Jan Kiszka <jan.kiszka@siemens.com>

Resolves the following lockdep report when booting PREEMPT_RT on Hyper-V
with related guest support enabled:

[    1.127941] hv_vmbus: registering driver hyperv_drm

[    1.132518] =============================
[    1.132519] [ BUG: Invalid wait context ]
[    1.132521] 6.19.0-rc8+ #9 Not tainted
[    1.132524] -----------------------------
[    1.132525] swapper/0/0 is trying to lock:
[    1.132526] ffff8b9381bb3c90 (&channel->sched_lock){....}-{3:3}, at: vmbus_chan_sched+0xc4/0x2b0
[    1.132543] other info that might help us debug this:
[    1.132544] context-{2:2}
[    1.132545] 1 lock held by swapper/0/0:
[    1.132547]  #0: ffffffffa010c4c0 (rcu_read_lock){....}-{1:3}, at: vmbus_chan_sched+0x31/0x2b0
[    1.132557] stack backtrace:
[    1.132560] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-rc8+ #9 PREEMPT_{RT,(lazy)}
[    1.132565] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 09/25/2025
[    1.132567] Call Trace:
[    1.132570]  <IRQ>
[    1.132573]  dump_stack_lvl+0x6e/0xa0
[    1.132581]  __lock_acquire+0xee0/0x21b0
[    1.132592]  lock_acquire+0xd5/0x2d0
[    1.132598]  ? vmbus_chan_sched+0xc4/0x2b0
[    1.132606]  ? lock_acquire+0xd5/0x2d0
[    1.132613]  ? vmbus_chan_sched+0x31/0x2b0
[    1.132619]  rt_spin_lock+0x3f/0x1f0
[    1.132623]  ? vmbus_chan_sched+0xc4/0x2b0
[    1.132629]  ? vmbus_chan_sched+0x31/0x2b0
[    1.132634]  vmbus_chan_sched+0xc4/0x2b0
[    1.132641]  vmbus_isr+0x2c/0x150
[    1.132648]  __sysvec_hyperv_callback+0x5f/0xa0
[    1.132654]  sysvec_hyperv_callback+0x88/0xb0
[    1.132658]  </IRQ>
[    1.132659]  <TASK>
[    1.132660]  asm_sysvec_hyperv_callback+0x1a/0x20

As code paths that handle vmbus IRQs use sleepy locks under PREEMPT_RT,
the vmbus_isr execution needs to be moved into thread context. Open-
coding this allows to skip the IPI that irq_work would additionally
bring and which we do not need, being an IRQ, never an NMI.

This affects both x86 and arm64, therefore hook into the common driver
logic.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v3:
 - move logic to generic vmbus driver, targeting arm64 as well
 - annotate non-RT path with lockdep_hardirq_threaded
 - only teardown if setup ran

Changes in v2:
 - reorder vmbus_irq_pending clearing to fix a race condition

 drivers/hv/vmbus_drv.c | 66 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 6785ad63a9cb..749a2e68af05 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -25,6 +25,7 @@
 #include <linux/cpu.h>
 #include <linux/sched/isolation.h>
 #include <linux/sched/task_stack.h>
+#include <linux/smpboot.h>
 
 #include <linux/delay.h>
 #include <linux/panic_notifier.h>
@@ -1350,7 +1351,7 @@ static void vmbus_message_sched(struct hv_per_cpu_context *hv_cpu, void *message
 	}
 }
 
-void vmbus_isr(void)
+static void __vmbus_isr(void)
 {
 	struct hv_per_cpu_context *hv_cpu
 		= this_cpu_ptr(hv_context.cpu_context);
@@ -1363,6 +1364,53 @@ void vmbus_isr(void)
 
 	add_interrupt_randomness(vmbus_interrupt);
 }
+
+static DEFINE_PER_CPU(bool, vmbus_irq_pending);
+static DEFINE_PER_CPU(struct task_struct *, vmbus_irqd);
+
+static void vmbus_irqd_wake(void)
+{
+	struct task_struct *tsk = __this_cpu_read(vmbus_irqd);
+
+	__this_cpu_write(vmbus_irq_pending, true);
+	wake_up_process(tsk);
+}
+
+static void vmbus_irqd_setup(unsigned int cpu)
+{
+	sched_set_fifo(current);
+}
+
+static int vmbus_irqd_should_run(unsigned int cpu)
+{
+	return __this_cpu_read(vmbus_irq_pending);
+}
+
+static void run_vmbus_irqd(unsigned int cpu)
+{
+	__this_cpu_write(vmbus_irq_pending, false);
+	__vmbus_isr();
+}
+
+static bool vmbus_irq_initialized;
+
+static struct smp_hotplug_thread vmbus_irq_threads = {
+	.store                  = &vmbus_irqd,
+	.setup			= vmbus_irqd_setup,
+	.thread_should_run      = vmbus_irqd_should_run,
+	.thread_fn              = run_vmbus_irqd,
+	.thread_comm            = "vmbus_irq/%u",
+};
+
+void vmbus_isr(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		vmbus_irqd_wake();
+	} else {
+		lockdep_hardirq_threaded();
+		__vmbus_isr();
+	}
+}
 EXPORT_SYMBOL_FOR_MODULES(vmbus_isr, "mshv_vtl");
 
 static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
@@ -1462,6 +1510,13 @@ static int vmbus_bus_init(void)
 	 * the VMbus interrupt handler.
 	 */
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !vmbus_irq_initialized) {
+		ret = smpboot_register_percpu_thread(&vmbus_irq_threads);
+		if (ret)
+			goto err_kthread;
+		vmbus_irq_initialized = true;
+	}
+
 	if (vmbus_irq == -1) {
 		hv_setup_vmbus_handler(vmbus_isr);
 	} else {
@@ -1507,6 +1562,11 @@ static int vmbus_bus_init(void)
 		free_percpu(vmbus_evt);
 	}
 err_setup:
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && vmbus_irq_initialized) {
+		smpboot_unregister_percpu_thread(&vmbus_irq_threads);
+		vmbus_irq_initialized = false;
+	}
+err_kthread:
 	bus_unregister(&hv_bus);
 	return ret;
 }
@@ -2976,6 +3036,10 @@ static void __exit vmbus_exit(void)
 		free_percpu_irq(vmbus_irq, vmbus_evt);
 		free_percpu(vmbus_evt);
 	}
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && vmbus_irq_initialized) {
+		smpboot_unregister_percpu_thread(&vmbus_irq_threads);
+		vmbus_irq_initialized = false;
+	}
 	for_each_online_cpu(cpu) {
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
-- 
2.47.3

