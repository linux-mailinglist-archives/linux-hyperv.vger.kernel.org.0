Return-Path: <linux-hyperv+bounces-8880-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDsbFKtglWn9PwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8880-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 07:48:11 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE1115380F
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 07:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D08530065D9
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 06:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998022EA468;
	Wed, 18 Feb 2026 06:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yTlBVLq/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011063.outbound.protection.outlook.com [40.107.130.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770E8194C95;
	Wed, 18 Feb 2026 06:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771397288; cv=fail; b=Kt3mU0dhYTw9H0nO8D833se/YCwSf7niIPYxpBoTh7otVEWQn0J/vawPcvTk5Y3qxppYX7CT/ODYf8VBQ8YMrdMgWk5tvSF8pOPowwZqO3qhRfC/zdKTotg/nYP0cdpJmn0L/eWTwOIIPfqsH/g54eIiq26XzZfTH93w5M0tcWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771397288; c=relaxed/simple;
	bh=t6E3K9Oead1jB+NfH0EAgzGIRtA8HzJXXmnXuQuatuU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oS0MQzlXPiyA6O1z4OL2w8tRuY1hEGAMZCH7dvKOgF4nXn5vypww0nQ+Ocg6nz1vENUKt0bHb2u50QyTIj6ss8KpCaKrgtqrQG/r3t8whWiRcxliy+ioDaJ9P7AqxPDJaMdE6CELjrLzTmDEa1N2PoqVObyF0AoOTC4rrAVoeUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yTlBVLq/; arc=fail smtp.client-ip=40.107.130.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSffHgTitK7cq1oi5ak4w53i+n3eBkomqT68b8rlhDx6hjCKuijTP1i5/O603lgen2rmW0asM+cRzkBnN1DIKx1Sv8QJpnsDWJPCqciUkiQWL/aHaBZhSSZVwC06+1vVB2EVTTWAEdU0ZZO2rNkr/RR3RxcU4MmhP31XnHLWX3K6ybMg/TxpbZ4P9OT5DULGg27GGNj3vsEmAlChgNOlsamU3onDA2BisZIzk/895EqdLhaijdldH1QoUsbeGIdNxO61EsyXBkzy9QyRG6jE1ssEUVvaTQUIjjYMQbPLruxHpxOYxAd9udwcVhEHtEqEtR7eRPuaUBr4PYE4XS5tsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWGExNi1hE1X7qYZ3QYeU10btFuMfhurbkazy09Oegs=;
 b=iaS7bBczHaqjXHHk/7sOqC4g46Siiy6ltwXjsDuSfSDMnMoEr9YxQT1EkXgZC67xa/3L+Q5O4Bn6+VIl1L04T7Pz4z7Od/u/7ryBbaIdUTeQoEDnGb6OW0lj0oh3XEtdjAgt75ASLTbSC970I51xAcNXqi0yCCMMWwxQhrqGbaXlOtoddGhCEdeWG+1nCrdRv8DHJ6c8S1i4aPIIH35PVIGQw9cxhvFFOtVjkzrN8npdIm6AFdwGnE2fOxIBVXpfDElxAz1ZoL5IteAfoUmgQNnnNIAqHg6HV4JbSKSArtUI5usubSQhBxuXcWVG1ZRxsemzJl5G5VhQZ9rPKrTFyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWGExNi1hE1X7qYZ3QYeU10btFuMfhurbkazy09Oegs=;
 b=yTlBVLq/8JYWFKHRFG+kN+9azRUuRJJIH0I7e7eKkYhyuOBJb8wI3YbTx3y+MyVeL1DMU56YCJ8S8Wng5t2hrTHhcAcQldG+s38LhhWMVOxl0GikPhvlq4v+V7jKSDgsd0XJqnolL3Yewc6IgULURNX7tyV3dwX+6MHtNuV0ovKZLpnLS8kZ1G/DhWGNwlE0cdWMi7hcgTXzLsG4Pmx75RZ2/xCZwvKxqQYZiTIdKNqW+VVNNhZh/VcqP4HmQX2Yi4y6KJdXA2oQxhcUY94AuKnNllpRQFQ8QdhLXYYvBwKKvnOrqfnAvcxMKzf6dEIvZqXeyy3F5XnLm7ErTiVpzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6919.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 06:48:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 06:48:02 +0000
Message-ID: <1e431e0b-3e53-45c0-b097-c7bcb7d677d2@siemens.com>
Date: Wed, 18 Feb 2026 07:48:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drivers: hv: vmbus: Use kthread for vmbus interrupts
 on PREEMPT_RT
To: "Bezdeka, Florian (FT RPD CED OES-DE)" <florian.bezdeka@siemens.com>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "decui@microsoft.com" <decui@microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
 "longli@microsoft.com" <longli@microsoft.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, "tglx@kernel.org"
 <tglx@kernel.org>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
 "namjain@linux.microsoft.com" <namjain@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "levymitchell0@gmail.com" <levymitchell0@gmail.com>,
 "mhklinux@outlook.com" <mhklinux@outlook.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>
References: <289d8e52-40f8-4b22-8aa9-d0bd3bd15aae@siemens.com>
 <033ecfefc85bdb7c508d488c5004913d87057142.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <033ecfefc85bdb7c508d488c5004913d87057142.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be079a1-b698-47e0-fde3-08de6eb9a926
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OENURFhVR0xDZTg2S3hnSkJjZU9HbG9xTis0VmVzaXJEVnVsNFBRQVJWZnJN?=
 =?utf-8?B?OVhWT2hJemdwL1p6K2xSVlFyTXNVSEFGVjZLWmZsRmNGVm5hazBlMTVqeDVr?=
 =?utf-8?B?VDIyZlllWHNiTjR3WWx4UFUzK1RGNUwxdGl4Zld0bmdqT0hFSnFxTGc1UStQ?=
 =?utf-8?B?aDBWVDlkM0kwYi9iUXNnSHdPK01WQkJWb3ZyMTBkTmNUU0lWaXp1L0lKU1N1?=
 =?utf-8?B?cmRGTDY1RFV4OExUVTZlM3htSDlnYjRNSXZqQTk1Z1pQMERTN0NOV3UxdjB1?=
 =?utf-8?B?RGFsNnNGeUpzbW9EU2NPSURvTENBY3d6VVdvOGs4RXRTajROT0lpek1vbDZh?=
 =?utf-8?B?WHMvOHdLaS9EZ0ZlNUxGaU9PaUdjbCtkcmFTaDhQbUoxWUNJa3BzV252bnpC?=
 =?utf-8?B?VTZWaXVyVStmbWFrZlBqbFpwalYwTkt4UnliSnBNUlZXS2JsR1EvSzdRbGVv?=
 =?utf-8?B?UGQxNGZaOHMydGNyL3lwbVVXU1RTZzBxTWtPejJqaG1TMitJZWxCNmZhWkdK?=
 =?utf-8?B?V2pnQ0lhSjkxZzd5dkRWS1JWMmlTWXlFOU5scjBXdFlsYXN0ZWNac1ZsYnpB?=
 =?utf-8?B?RlpzU2RDU1ZudGN4c1Zia2I2VlFuWWVHTjJERWhEMm5zT1dhR3JycjRwMVh1?=
 =?utf-8?B?VGpGbDFjaEVFNEt6ZFM1OGV5bUNqZUg2S2ZONjVFVjl2SEtYMEJzQXQzMG1N?=
 =?utf-8?B?MWRuVzU3RHM0cVpVUko2U01RYmtuQ0Q3bXMvcTlONG4zRHlmWE9JaCs4OWQz?=
 =?utf-8?B?K3N5a2l2UG9MRGYyaWtDenpQcnc4U1grOWdFMHIrSVdKN09vL1p6Y2FQUm9w?=
 =?utf-8?B?SG15OHl1bm1YczFaWW1OUzdjcjlWWmg4dDR5Tit3eURFMk4vbWYyeDZ2emYw?=
 =?utf-8?B?b1dtMTF6bmVhV1Q4N2lnREhIb0U0UXFWb1pScDVyRTNnc2dXeUpnajluWmls?=
 =?utf-8?B?Z0Z6QWZiRUdFUWgxTWt6UnB3UDZTU3dyaHA2bFpvV29zRlY4WExGcnJxNUNz?=
 =?utf-8?B?Wk1NRkVHUnhpR0tUNnI2L0FaTTJySGF4UEhWNWExYjQrSTFKZ25GNTg4OUZO?=
 =?utf-8?B?RnA5WFAwb3pMY2hGWXJQTGpDWmNwRXdmNStRRGc4aHQ1RlhKanRLRjJ5NVhT?=
 =?utf-8?B?eVNjNmdDZTZRcU8wakMyaDVZTGtyempQQVlCYjFCRUFQcDd6QTVVV2pMYjg5?=
 =?utf-8?B?OVB1anloQW90NmZQeFVhS1YreS9CNTJhKy9vRGM4MEVqWVNTOS82c3I3TjRq?=
 =?utf-8?B?ZUxaclBpeG1YTGxoNW90MkJBSG1ZVk9NSUZFNDJjd0J3dTlTZkhUZzF3bTl5?=
 =?utf-8?B?OFJLTWNReUVPRXo0bXBlRDJVODY3L1lMVlNIRkQ5dko4b3FHNEEvRjBXWkVP?=
 =?utf-8?B?WmtobUhLVDZFNHI4cWdEN1k5SklzSitvNDhzVm0yTkkwR3Jya1YzMlduMWU3?=
 =?utf-8?B?QkhDQWtoUlplWnZOY3pPOVJibzBlWUNKZ2xab3pPeDRLUmMveG1hSXdJNDJC?=
 =?utf-8?B?ajZTaDUwNnR0RjFQeGgvdmdUNUR1KzkzOWdoRGJHQzlhUTQ5YmNTNVBOVUlh?=
 =?utf-8?B?MEY5MHkxdmZFR3RSRWlDYUlxMWp1UFFWVVQ0Si9zcUJxN2ZFL1ZDYTBUK2ph?=
 =?utf-8?B?bmVBK0JyejdpMXZjcTVZU3pTYlZFRVdGMnJxYWZhenZiZFYyRitLVGtVcjll?=
 =?utf-8?B?V0k2MUlMbGdlVTBXV2xSdzlBQjd3NlRTS21tLzBFd2w0UC8zQVhrNjVMOStS?=
 =?utf-8?B?YkNoZDlXaUtZMDF0QmIwaC94WS9KaFA4a1ZzUHQ2VUttSEhlbGNCWW9pUC9K?=
 =?utf-8?B?djFEUExLYThMYWhNWnU0QkQwdE81bGx6OWJ5emlQSjQ3NURhaDdRK25UU1Rz?=
 =?utf-8?B?NTJDcTNUSUErT2sxRlBydTd2Qk9uWkVnak1wMytxNEdNaU52SHdlUVZMSE8r?=
 =?utf-8?B?eUxJWGhZSjBkdE0yZy90V3JMMWNjcmMrRlVnbzVYaUVmdVhLVmpwV295TmxZ?=
 =?utf-8?B?K29Nc2ltaElSUmhVdUx5UE1QRk5iWjRjWHRLeDNSQzljdlBrVmFqay9DR1BR?=
 =?utf-8?B?Y09SRnBNdWFNTmp5QWJ6ZDVjbnZ2UVdhcmdSM1JPMzE4U2tDZ1pzeXY5YSt1?=
 =?utf-8?B?ajgyeXFDK2JZU0RzMkNSN2twM0xmeFN5aENvdk9UcVRVMUEzckNrenE0TTB4?=
 =?utf-8?Q?cWJDbVQvFhHKb65Pmfv69h8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGxrZmk4cjBSKzNveU8rN1ZWUW9RV2pyK2QrbHlmdWJMMXZXRk05MlErU1pW?=
 =?utf-8?B?Vjk2aldIc0ttUldjcXVxUHJxOFNqQ2RtSVhsVDhSTE5MK0o5SGhTNlovbklJ?=
 =?utf-8?B?djNhWXcvRVBmcHhGM3BINWx4SitOWVhoelZtRXRHK1ppQWhWWVdJY2hBU3ll?=
 =?utf-8?B?ZVBXMGRGQXNKelhuVDhYM1pvcmF4eEdPMGM4dFU4TmRmZFpGdUZmRVBTTlVk?=
 =?utf-8?B?ZFlGc1hoc0wyZGpadUNsbndVbWtWOUs1NVJQeE55K3k2dTNoT3owVGhDdWRl?=
 =?utf-8?B?ZHZmT3hWTkxVT2puUFJZZmNDVnVUTnVpVnJPVWU1UnpMRFB3czQwVkQxV3pK?=
 =?utf-8?B?aEttdzhvMFloVFZUSWx2QTE3bXFWNTZVRDlMYkdpaFQzeVlKbk5SRjY1VTBj?=
 =?utf-8?B?YU9yOGkyMW5iWnlmbHJVT3dzRk8rZm9kSUU0NVk2ZkFjczE5aHVIMFpqYnBK?=
 =?utf-8?B?WmdGS3kzcDZxZm5TRmdXRWxoYk9MTDRwNlFrVnBnNVN6eFFBWjdRUHY0QkZM?=
 =?utf-8?B?a3NtYVl0Vi9HY08zU0Vsai8xOEZ5bEVUZlo5UUFkVmRXQUE0V3o3Si8zd2Rm?=
 =?utf-8?B?RXdIdXZ2UmRUWVFWRUNYSHduVHFEbmd2NTRMVGlTVUZuYW55aGxkYnoyTzE5?=
 =?utf-8?B?TmlLSlFtU295V1BQTlJjbWoxbFEwTVBlZEcweXhSSjBpMVNyZllXbkpDd3By?=
 =?utf-8?B?c01DckNOZUh1a1FkZ1dsVjhKeEVrdHJuekVCWk5EQnRuWWVOaE5QakNSUzd6?=
 =?utf-8?B?YjRBSzJnUXJ3RVJYZks1Y0U1TThDeWFYb2U2UE45aVdPZkRmSDdLUE54NzB5?=
 =?utf-8?B?RU43aGlJVGpOV1Y0QkN3bWFKN1JnTkVkZFlYWGY1OW1rV3BwNTRqV05zTlJn?=
 =?utf-8?B?QUtVdjZ4Q09CaUUrbmxkeTMzOTN1WDNkUnBZRUNWYTZrSlVzVjYwTENNUFI4?=
 =?utf-8?B?aStQVHdTUFBhU1BPUXVoN3hHRVY2bmJicTFZeWRlSXFDZDJ4SlQ4QnhQSmhn?=
 =?utf-8?B?T1BhR0Y5T2JNajZSN3o4R1NzRGpjZkN3MWJOYWJ5S3FrK09uM0x3cUZ1dkpR?=
 =?utf-8?B?NGxpT25NVERJSWt2UHBXVUxsellPVE93SjVtbE5BeWNpazF5S0tFaDFsc1Rs?=
 =?utf-8?B?ZWNmVmd3SDhwY1FFV0pOWlkxYm1XQlpTN2hhWEtTKy8yczBKYTdIU2k5enJE?=
 =?utf-8?B?SURSYXNHaEdLWXhLaVAybktrTHpqUzUranJKMDFiK1R3ci9GY01hNFd3WXFB?=
 =?utf-8?B?Vkl5QlN3ZHV0dXpSMUhjOHFzOEVPRDcyaUZqNlBYUkVJTXdabmJDRDJDNms3?=
 =?utf-8?B?U3VEVE51QXpaV0VSUEt1Z3d6SUpUT1RTbjlvRnZabHFMWHRyY2ZoUGUvckZa?=
 =?utf-8?B?ZjRiR08zZ28wV0IwWWRKbWRaN2RVYWxobWRTN2NhTjBBcUNFRVY5dGRWa0Y2?=
 =?utf-8?B?Vi9XdzhPb0lKOWYzcytxcnBXbnJGaXZYM05jSkQxbEh1NDBvNVdaYUV1YkVm?=
 =?utf-8?B?RnNhaUpMUndJS20wRzhBckhlTjllWllLRDh4N2N4WThEUmRnT05YSHBCdXBF?=
 =?utf-8?B?Qm5FdFRhNFRmQTlYOFRrVnl5UGdXV3lYWlZZRnl2TW5DSEU3Ni8yVzNyazF3?=
 =?utf-8?B?TjhLeTlNUE1DT2YxNFY1MTZpUVdKRWxBVXdDUCtibUVMZGJ3UnRwWkp3Yk4z?=
 =?utf-8?B?aXhCSUhVdTIwVGZXcklHRVZoMUtlb3NHT3BYajJneXVRczBZbTJETkhJSUlo?=
 =?utf-8?B?WjJPQTBMQzB2d0hCaUI2MVV1NmJuRnczeklIZS9xbFByamFRSHl6MnpnK2pZ?=
 =?utf-8?B?VllBRHB1VkJoTStkRXJVUDNuYmRFdlNaMTQxbVFFVDVranpGTGR2VEZNNnFU?=
 =?utf-8?B?d1dHQzgrVk5KRTdSSDBodEI0a0ZPN0FaV0F3Y2lmNDhGVVNnYnNYM1NoZDR3?=
 =?utf-8?B?NlA4YlkzS3RkeUhWKzRqeEgrK2ZWa0RpRVBudTVhTzkwa0VlT2hYQ0d3TXNL?=
 =?utf-8?B?U29DeFBPS0k3K3hUbkY3bk9KbzlpUXExWTcxSjc0VWJrSnlTc3hjUkJ6ZkV3?=
 =?utf-8?B?WjRtUE0xRm1IYVdPK3dPMk9GQkNQZHFWc3U0UFg3azBkMlYxais4cHBpU2h1?=
 =?utf-8?B?MDZCMmJVSGVzY1l6aWZ2NENaaitKa3pqRXlUeUNON2oxTWtrRnJNd1U5eUw2?=
 =?utf-8?B?ajZEeE1hUEdtc2xJazFPVEFaNXVjSWxsTjA3RzI3M1ZWczI3WE03YjZ6RXdC?=
 =?utf-8?B?TkJ1MTQyMTllczlxS1lHWjg3UUowWWJQcHhFc25QM2s4SnE2aHFGK3Vsbyt4?=
 =?utf-8?B?MXVqUk92UUlpNXhuWElFTTNzV25pcHJ2QTliMWVLR2FCNGdYdThYdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be079a1-b698-47e0-fde3-08de6eb9a926
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 06:48:02.0762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASyegT8BkBI7GO/pJD6/jlIhY/53/ERWGI2Ubz1HNVDNWrqV1vBu/ALaU/6MRCYlyyQ+okuBpSwWLstpmaAOnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6919
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.microsoft.com,gmail.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-8880-lists,linux-hyperv=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens.com:mid,siemens.com:dkim,siemens.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EEE1115380F
X-Rspamd-Action: no action

On 18.02.26 00:03, Bezdeka, Florian (FT RPD CED OES-DE) wrote:
> On Mon, 2026-02-16 at 17:24 +0100, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Resolves the following lockdep report when booting PREEMPT_RT on Hyper-V
>> with related guest support enabled:
>>
>> [    1.127941] hv_vmbus: registering driver hyperv_drm
>>
>> [    1.132518] =============================
>> [    1.132519] [ BUG: Invalid wait context ]
>> [    1.132521] 6.19.0-rc8+ #9 Not tainted
>> [    1.132524] -----------------------------
>> [    1.132525] swapper/0/0 is trying to lock:
>> [    1.132526] ffff8b9381bb3c90 (&channel->sched_lock){....}-{3:3}, at: vmbus_chan_sched+0xc4/0x2b0
>> [    1.132543] other info that might help us debug this:
>> [    1.132544] context-{2:2}
>> [    1.132545] 1 lock held by swapper/0/0:
>> [    1.132547]  #0: ffffffffa010c4c0 (rcu_read_lock){....}-{1:3}, at: vmbus_chan_sched+0x31/0x2b0
>> [    1.132557] stack backtrace:
>> [    1.132560] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-rc8+ #9 PREEMPT_{RT,(lazy)}
>> [    1.132565] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 09/25/2025
>> [    1.132567] Call Trace:
>> [    1.132570]  <IRQ>
>> [    1.132573]  dump_stack_lvl+0x6e/0xa0
>> [    1.132581]  __lock_acquire+0xee0/0x21b0
>> [    1.132592]  lock_acquire+0xd5/0x2d0
>> [    1.132598]  ? vmbus_chan_sched+0xc4/0x2b0
>> [    1.132606]  ? lock_acquire+0xd5/0x2d0
>> [    1.132613]  ? vmbus_chan_sched+0x31/0x2b0
>> [    1.132619]  rt_spin_lock+0x3f/0x1f0
>> [    1.132623]  ? vmbus_chan_sched+0xc4/0x2b0
>> [    1.132629]  ? vmbus_chan_sched+0x31/0x2b0
>> [    1.132634]  vmbus_chan_sched+0xc4/0x2b0
>> [    1.132641]  vmbus_isr+0x2c/0x150
>> [    1.132648]  __sysvec_hyperv_callback+0x5f/0xa0
>> [    1.132654]  sysvec_hyperv_callback+0x88/0xb0
>> [    1.132658]  </IRQ>
>> [    1.132659]  <TASK>
>> [    1.132660]  asm_sysvec_hyperv_callback+0x1a/0x20
>>
>> As code paths that handle vmbus IRQs use sleepy locks under PREEMPT_RT,
>> the vmbus_isr execution needs to be moved into thread context. Open-
>> coding this allows to skip the IPI that irq_work would additionally
>> bring and which we do not need, being an IRQ, never an NMI.
>>
>> This affects both x86 and arm64, therefore hook into the common driver
>> logic.
> 
> I tested this patch in combination with the related SCSI driver patch.
> The tests were done on x86 with both VM generations provided by Hyper-v.
> 
> Lockdep was enabled and there were no splat reports within 24 hours of
> massive load produced by stress-ng.
> 
> With that:
> 
> Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> Tested-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> 
> 
> Side note: We did some backports down to 6.1 already, just in case
> someone is interested. We recognized a massive network performance drop
> in 6.1. The root cause has been identified and is not related to this
> patch. It's simply another RT regression caused by a missing stable-rt
> backport. Upstreaming in progress...
> 

Submitted:
https://lore.kernel.org/stable/05ae6b87-0b53-4948-a1ed-2a3235a5f82b@siemens.com/T/#u

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

