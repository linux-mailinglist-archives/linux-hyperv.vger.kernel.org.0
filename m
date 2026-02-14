Return-Path: <linux-hyperv+bounces-8856-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RC2eA1KFkGktagEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8856-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Feb 2026 15:23:14 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 621E513C2DF
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Feb 2026 15:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E899B3010279
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Feb 2026 14:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E8523D290;
	Sat, 14 Feb 2026 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wG5QPlcZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011053.outbound.protection.outlook.com [40.107.130.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5F4228CB0;
	Sat, 14 Feb 2026 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771078991; cv=fail; b=Wi5sHI6hOL/HBO6qCr3BKHTU64KN7sWqdYZqBEdjLgaK5WyDo9NIx8CJrA8bliIVDjeOE/V2SriRqlzEL/pHoJBTSWAxvEP5tnRpCV9dp5blniAA7oHha4ut4UsiWfhhPKwUeoRwAIt6wYskfCQqDq8VA9wlyQkjLhRi165sX2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771078991; c=relaxed/simple;
	bh=e2GT8qhnrQ4Nr4F1RWa1NkXlOX2BnjqOgNTNi8f5cRQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BoYubghWiaa/ak+TbvY/I+oJlJGaq9gEtsvZsVET4Q/7+sp7FVX6kMucbSOZNugQg0JA/4ozJLX6KJCuhNGsavp+gGRSg3NMe95fLZ9gB7iJbCIEYB7LaqEgdgHPNSgODYL3UcKoW/BAQom6dLGKkCqGFZ4KkcqtEFSj6iy2yu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wG5QPlcZ; arc=fail smtp.client-ip=40.107.130.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnxTgHAfZydyBhZ/I/gdf5HYzGW7cdJYNOYWrzyO4FTLHvqrXTVclgnt+S4M59JASOpaEBx6zlQKNZstgCIM8zwiOJLIK/z/gm49oxPTXBY191kIJAGuJkSTrtidcboFdRVC4D21++hzL2oAsEfoPxht7LlPj8mx111rbul87BvZn7XseaUmo0cQY/wJmq7vs6McC9J21bORRGprHmyl+HmtoGzf6L9B4UdavW4Dghqyv3u3D6dLUJjZHmIvXI6FcY5kXipOBQo4OCnEXy3JddeCCUn0OffUgK3BP3q3TsCBrszAkxMYoqfw3cY0lQf7YEZ5COMNYNPwbQlXWPAnPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2EPFJ3bohdPt+FJvbF3HQpYL42DwAj6cKVAGpGCAN8=;
 b=ZfZdZpOqYv6TkjvGECWp0pLImagZvGN+5gUeA+85U+KULVT5aO5uYthejmSuF+ziFegCjA5+ZJ3/wehsmATwc6OVKxhtl/NtABIc0Btp00jeFG/WEJgtTh/LBk6Siz0oGUgWQBtr75NxKuZhaHq8uLy7CJ3hVSeH7GXWo0JzkMkG56Qs4VyokRL4Yh7eNvfAJ0/a5yf0wAk+g3LIwxv9vT/dlN6w9+6st9Evqy5aV9KqgNBGESyWnoJSwqdKvzF9JOgxYwlJDnGik8zatviBYrnpH8yD4u3ewtbrax2AkmwDpgWbKnxQ7HLEyi0UAZF9T6PWnEjVXa4uoGYkfM5hJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2EPFJ3bohdPt+FJvbF3HQpYL42DwAj6cKVAGpGCAN8=;
 b=wG5QPlcZ/MFfKz6n7L+yJiiw3F/7zlr89HnYZrrhcnF/ChDbIEzXMtiQNZHe56j6Y4app1Jcd+Q5U09uKDHXAJXx4HFa9VbbOL2JmA1S8zzPiBVrjtCpvsPwru+NCjxl/61F7VlNung033k88Umk4dcW/QMFDnMcI2tFpIAXRAXn2yZdNLGRokggxFvL4p03/pZKGbQsd9XnooUpGSRW120MI+eA5cHuYXDnw2zXVFozHMRqq1TrTh3M991894/cwwJgzjMNUMx1Kcmnofy1SNe/DXPTbshm+Zm/q0lyMyTk8zcAq49kW6+OX16BHTzWitDNNs28EKMELiZUC2hXVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8581.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Sat, 14 Feb
 2026 14:23:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9611.008; Sat, 14 Feb 2026
 14:23:04 +0000
Message-ID: <438c3c7b-6a57-4ed4-a968-d43142f53afc@siemens.com>
Date: Sat, 14 Feb 2026 15:23:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 RT <linux-rt-users@vger.kernel.org>, Mitchell Levy
 <levymitchell0@gmail.com>, Michael Kelley <mhklinux@outlook.com>
References: <514e068c-1b85-4e39-8388-c1d2b106b4e9@siemens.com>
 <aY/4D/JVu7TjNOku@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <aY/5eBLvodLYbV0a@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <aY/5eBLvodLYbV0a@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0345.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8581:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c993a1-f963-4540-9dac-08de6bd490f0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFp5WS85dEtLL0EzTndrTjFvdThmL0t4VjVXcTFUSk4wTUFBdy80TDUrV0xO?=
 =?utf-8?B?RFoyU2ZnSkNxSlUzSUNqYlRwZDVkaHErc0lIbjBBeGZ3cWFWVjR1d3dWQmln?=
 =?utf-8?B?TW9XZEVhWFhxOUNoYU8zZHVJNjFIdUxoSnRTUUxkZEdIQm1lRVJJMkxKbkFC?=
 =?utf-8?B?WktGQ3RZVHo3VXU2NnNnaC9mVGtFMUtlNHVENVlkbDNoR1BLcTFqOGQrbE9u?=
 =?utf-8?B?c25RbjViMEdVS1lHc0hDTjQvc1Y2MjNhK215ZlNxNjJyYzJSOFlOeWhBV3U3?=
 =?utf-8?B?eTdGNVFxZ2Jhc21LTjVld00xNCtXOFdnZENybW9YRUdpckNNREU4ZGlRSHdB?=
 =?utf-8?B?VEh0YkYvcFlFMGRDUVNmbHZhVitLNXZyT3lNdGhDL0V1eU1wS2IydXlPaXlm?=
 =?utf-8?B?ZTU5akRBaDdiSjJhMUhSRXBTNW9WMVVrOUFZOWh2T2E4YlhST21sczVpbUx3?=
 =?utf-8?B?MnlxRjE3dUJya3huMWxNajNJekgvZHlrUkpQV04zNlpqc2I2SWl4SUxTWjA5?=
 =?utf-8?B?S3RSMGFvWWdsUHFhQktKRUxZUkp4NDdheFQrM2RPclNFeElPSFF5MElHTHhY?=
 =?utf-8?B?NE1pcGJjb21uVWFmNEVLTVFhamVRZmZGenVkVzdjTVdaY3hRaHNpRVMzZHZV?=
 =?utf-8?B?RnNXMTdNa1hrL2p5Rkt2UnFQbGlpckJiekltU0x5VE1CRjN3enA0QVhlTE1W?=
 =?utf-8?B?NFhQdno5ZEt4WTc0d0cxNFVyRXRsMnA3SEpNRHZZWFZIWGhlU2RYeVQ3Z20y?=
 =?utf-8?B?MUdKdExKMzM4VEl2bmtLRnpkQnRwUnhxMUplRWZXdlBEaE1SOGJXenNhanQ2?=
 =?utf-8?B?YUs0VndZSVB1SmpXSEtFd1hmelF0bDBpVTBhY2hHbDV5MUswdFlNTUNzUTds?=
 =?utf-8?B?YWlNM1VhTnpZYlhCa293a0F2RWwveXZRZG9EdFBlbVRlRVJoT0pVVUdLb29H?=
 =?utf-8?B?NTc3UUFyaXZkckpmWE5ndklzMnpmWlBXL2NVSnlJbXB4SytyaWxHOHZzRTBz?=
 =?utf-8?B?eWJqK1RLLzVOTS9ucmQraTkyNEhhK1cyWWFSbmdDb1ZoZUZZY3lLVGJ6UDJv?=
 =?utf-8?B?eHZQVGJ0VlRaWDAwNThSMUJRY1FaYVM2WEptWHQzdE0reUtybk9xWGdLQTRk?=
 =?utf-8?B?M0M3TTNrMGxRUUtpZzdLeU5YYXp4d1FHUFBFd3pHWG5ZdVlpZ2N3K2M1WVB1?=
 =?utf-8?B?UG40RFk0Ky8wWkZ1bWJFdTdpVk1ISEpjaGFuWk1vQ3JkTUhrV2ZrVlV6RlV5?=
 =?utf-8?B?Q1FDejh4d1JjYjltNzJxbGt1ZjAvRUwxSDc1b1FrQWxVbzczSFlwL25KVmhL?=
 =?utf-8?B?ajJ3ZWtWRFYzUE5TZTlteHZOajdYYVZtNDlNUUd1Q0RoTjhaaWJTOFdTanZF?=
 =?utf-8?B?b2lKK2J5Y3VQUllnckdhczZmRDN0emtTdjF1VTM4aU5JbVM5NWl2ZUpFV1Rx?=
 =?utf-8?B?RHFJaTBtY2xnbzJ6RlYxaXpGNFE5bDFhWmFLb0J0VG91NktVdlB6UVI3ODFp?=
 =?utf-8?B?dDJ5YVY5c2laaG1HZ2luYXNFaFJwT0ZGL2dPTUZGWllZN3VlSmhLVm9QMlRt?=
 =?utf-8?B?S2ovYStlZk81a2c1UFRXMlpkNFJEVE4vbWM2Y08zUTBFbG84bUx1Tk1CTUFY?=
 =?utf-8?B?MmJscWppckF1cHd3OW8ySW9ORCtYQmNTZ0xkckY1VlM4ZGZONmY4TDFXRDRB?=
 =?utf-8?B?cmlHNnJxQkxqNXRkVWZoNitMWlE0YUc3Q0srTWNNT0kzWmlIK1lKV1VoTXhD?=
 =?utf-8?B?djEzMm1hWDFNU0ZRU0ZORXpqVlk3azVpaEZac2tjOGQ2cHhsZno0ejZSVjdB?=
 =?utf-8?B?VU5DSDdEcGlxU3lXazRPK3ZNVzhtOGllK0pXR3lmOEtwbXNTY3kyVzRXQ2tU?=
 =?utf-8?B?RWJFYzZsNjJUa2NxUU5VeXREdnVwbE1HVjBuckY2dHlhTkFSQzBxLzhuM2V2?=
 =?utf-8?B?aUkwNjdpQ0VISUdDVWN3WU9la2pveE5VNERGemJNYjFSMEFUM3ZJU0JxczRW?=
 =?utf-8?B?OFdRVnloRWVUWWd6eGtSTU1RUjdvK0pVeVgvZ3Jucm9reWdiblZrSjlBamM1?=
 =?utf-8?B?RElHaGE4bkxSVTMwMTcxOTRzeTBwSmVhZVZGcUxqMU9CT3k3S3ZNZmRaSmJC?=
 =?utf-8?Q?yDIE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzdrSHB6Ykloc3VPekh6aFpyM1dVcEJSVHE2bndnUGkrckVFVlJGSGpSQVFP?=
 =?utf-8?B?aCtKM2NsNmdzZFlpQXlidVFlYlQ1NStUWWlvdk55QUVPMVBOK21YTGJOM0pN?=
 =?utf-8?B?dU1yRGhWanVxVHAvQkRKdGhXalpDM29iVUwyQjloU1hpcUtISE5HSEhabzY0?=
 =?utf-8?B?a1o5MFBBRzhSUXJLbkFwREl0dzQ5YUNYNTMzN3I2ZHpqaVJnWGZBYUtRRUg0?=
 =?utf-8?B?TFVITGdNRUJjMktzaDhpY3lDTm9HQzhTRURKRk96YkdWNGExYTFNWVNZQm9C?=
 =?utf-8?B?eXM0NGxBV0NMdnp4aTJGRk13OWM4RG4rdjJTRFdUeStsNzNlQTd5WEhNc0ho?=
 =?utf-8?B?dnBkOGMxWXByd1llSXVGMkFSeFhSQWxuWDNQSitUeEV0YUVHT0JZcDIreG1J?=
 =?utf-8?B?WURnZjdKQTdqa3dhQUNGR3ExdVRoeGdtL0RoVGtPVnp2NXZoVjc1c3dmRzBs?=
 =?utf-8?B?RmkyZnUwM1B0WFIrQzVXc2phQTl1RmFaK2NycXdEekdBWHluUkxnbEZza2w5?=
 =?utf-8?B?YkVkRkg3K2VHTDA1K1lzL0U4OTB4eExiWFdVWjNnQ1pLME5nS3ZMb1NUMFlL?=
 =?utf-8?B?ZHB0QWp1RWtMM3phcEhibW1HWSs5L3RnQzhqWEt5VzFkam4yZlNMOHFCZFI4?=
 =?utf-8?B?TUhzMHpTRC9rbnpjenk1TTNQMmdFeUdYMFFtSUc4NmdrY1ZSbm1XdlVNVElU?=
 =?utf-8?B?MzZPaHl5VXFVOTRiZGo5TmYySmZudWxVQ3VJc001WUpkbnZaeXd0dWNtSWh5?=
 =?utf-8?B?TWRMTGJIQ0lZTGxYL0NodTE5Y2N0dS8zMlRuVmFSeUIxMEs0Skh3NVJVOGZN?=
 =?utf-8?B?d1l0TkRVUjZHRCtlc3F0cm9iNmhRcUQraXdZSjNmM1hraGlHcUxOMEJyQlFO?=
 =?utf-8?B?NUxlL1h5NzFtODhDcnZlVmdwUVV4UVV5OFpzc0UrakFSRFFlTk16VCtsREVy?=
 =?utf-8?B?NTZCdFJ2V2p3d1BYNEFjV1Y3VG9rbkdjSHlGNDAxUmRhckMyWUlXckRNbWw5?=
 =?utf-8?B?bmc1Y0V3UEZ5YjBkUjhzcmltMENwZHJZL0NaakJKekJ3WURQS3o2aDM2NElE?=
 =?utf-8?B?WS9vVUQ3THdtMlQ3bUo2M0tsd1pwbzh4Y0U1OStxZFg5MjUyQ3dCR0svRFpi?=
 =?utf-8?B?RVRWQUhQMVVJZURVSHFMbDZ1cFdrZ3hncFNWVjlzTUhrMUZjdWhSaWhMcTJ2?=
 =?utf-8?B?d2NObXR0dGNLZWRMNi9lRlM1ZXdURGFkcjl4d1ZPRVU4L0FsWGtQMzFPdVY5?=
 =?utf-8?B?cCtoSlBEd1AwUEl5Z09lTGVXMGFSbGZ1Nm15RDBMVmcvb0JIcjlCNzYvNWFB?=
 =?utf-8?B?cW5aSEMrYm9QMExzb1QvZFdTSVNrL2hYS2wxcGFqelZhdS9EbnUyOTRZS0lu?=
 =?utf-8?B?dHFJQkhlTmV0Nkl4OEdLeVVuOGRvS0duQkpEcFEwa2Z2VkMya1doQ0pDeDdZ?=
 =?utf-8?B?M293L2k0ckN1UHVZUjBqSzFERnhFNWNQdy94T29kc0Y5U1Z0b0ZYMklmTXlD?=
 =?utf-8?B?bzg2SnVtMXRiNjZld0ZTaGtyOEwxR2lhWFk4bm4zNks5RnAvQ3RQcUZSZE5H?=
 =?utf-8?B?dDh0MXErQ2FTcWdSVmtHNzZDL3YrYlJoV1RwTWV4bGlwWm44ZmdDTWIzR0pO?=
 =?utf-8?B?eUFsMTNVRWNPdWwvcTZKdXhObkFrOVdXZVBXQi9mSnVCZ1JSRDdQS1JPdlFN?=
 =?utf-8?B?L0crMG9mcThhQ1pwblhRUE1EcllvTDZlSzA3THhKZW5uMEdqUnNoQ3JjbDRv?=
 =?utf-8?B?QVZYOXpPQndnMm9XSTJ6ZmRmS2xKQU1YbXpjVmVHYysvei8vZmY2SGZhZ0pi?=
 =?utf-8?B?azFWTlJydHFLZTd4SzUvcHJtSFlTYldLM2N4M2Q4V3pjZXZFWkRJU2trMDF3?=
 =?utf-8?B?bWN0aHNIVlZqa1VzaGJ2NHpBN1crV2daQ1dJWGcvTE00R1JCeENjdDhxMW1B?=
 =?utf-8?B?WHZKMXZKL1JFWnZPcjhUK0hsYS9ZWGZRRnFMM3haRTVCWmEyR2JHOWczZGR5?=
 =?utf-8?B?MVZXcy9XV2o0VjRyMndUeEVMMWRBMjhoWktWZkh6VDVXRVpMSDEzZ0JLajN3?=
 =?utf-8?B?TjdQdGpsMzdLZmxKNy9KeTJYMzVWOVNWQU83WVUxeEZNbFVQTkUvOSsyVnpn?=
 =?utf-8?B?NGdUMHZTbjlHTVFVN3hwTVdna3JqZDRKN1N6Q1RhTzQ1ei9CZW1VV1hhaWRq?=
 =?utf-8?B?VWt3MzgwWWdQazFqdzlJRlN0VC9Ud1A3VmFDcjVSQzlDTFpmYksvWC9maUxh?=
 =?utf-8?B?OW9hWXRqUWJHZU1Kb3ZCQTFJTW5sc0VodjJqZTVzS0NVVnRBVnBMZjNEUDhk?=
 =?utf-8?B?QXpwRDZGQmZLaWhmamxzUStCakloNG8rbGx4KzEwR09FQzA3QVljZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c993a1-f963-4540-9dac-08de6bd490f0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2026 14:23:04.4850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whRy3l6Ymhk2MfyHd3zf2LD1gjf3R+OZF59s6o0HMPLvvZqKrKyzbBgh8BhbS/CKkCwyMgjp3Y3a9+qv+vDpZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8581
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8856-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,siemens.com,gmail.com,outlook.com];
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
X-Rspamd-Queue-Id: 621E513C2DF
X-Rspamd-Action: no action

On 14.02.26 05:26, Saurabh Singh Sengar wrote:
> On Fri, Feb 13, 2026 at 08:20:31PM -0800, Saurabh Singh Sengar wrote:
>> On Fri, Feb 06, 2026 at 07:47:54AM +0100, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Resolves the following lockdep report when booting PREEMPT_RT on Hyper-V
>>> with related guest support enabled:
>>>
>>> [    1.127941] hv_vmbus: registering driver hyperv_drm
>>>
>>> [    1.132518] =============================
>>> [    1.132519] [ BUG: Invalid wait context ]
>>> [    1.132521] 6.19.0-rc8+ #9 Not tainted
>>> [    1.132524] -----------------------------
>>> [    1.132525] swapper/0/0 is trying to lock:
>>> [    1.132526] ffff8b9381bb3c90 (&channel->sched_lock){....}-{3:3}, at: vmbus_chan_sched+0xc4/0x2b0
>>> [    1.132543] other info that might help us debug this:
>>> [    1.132544] context-{2:2}
>>> [    1.132545] 1 lock held by swapper/0/0:
>>> [    1.132547]  #0: ffffffffa010c4c0 (rcu_read_lock){....}-{1:3}, at: vmbus_chan_sched+0x31/0x2b0
>>> [    1.132557] stack backtrace:
>>> [    1.132560] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-rc8+ #9 PREEMPT_{RT,(lazy)}
>>> [    1.132565] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 09/25/2025
>>> [    1.132567] Call Trace:
>>> [    1.132570]  <IRQ>
>>> [    1.132573]  dump_stack_lvl+0x6e/0xa0
>>> [    1.132581]  __lock_acquire+0xee0/0x21b0
>>> [    1.132592]  lock_acquire+0xd5/0x2d0
>>> [    1.132598]  ? vmbus_chan_sched+0xc4/0x2b0
>>> [    1.132606]  ? lock_acquire+0xd5/0x2d0
>>> [    1.132613]  ? vmbus_chan_sched+0x31/0x2b0
>>> [    1.132619]  rt_spin_lock+0x3f/0x1f0
>>> [    1.132623]  ? vmbus_chan_sched+0xc4/0x2b0
>>> [    1.132629]  ? vmbus_chan_sched+0x31/0x2b0
>>> [    1.132634]  vmbus_chan_sched+0xc4/0x2b0
>>> [    1.132641]  vmbus_isr+0x2c/0x150
>>> [    1.132648]  __sysvec_hyperv_callback+0x5f/0xa0
>>> [    1.132654]  sysvec_hyperv_callback+0x88/0xb0
>>> [    1.132658]  </IRQ>
>>> [    1.132659]  <TASK>
>>> [    1.132660]  asm_sysvec_hyperv_callback+0x1a/0x20
>>>
>>> As code paths that handle vmbus IRQs use sleepy locks under PREEMPT_RT,
>>> the complete vmbus_handler execution needs to be moved into thread
>>> context. Open-coding this allows to skip the IPI that irq_work would
>>> additionally bring and which we do not need, being an IRQ, never an NMI.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> First I would like to share my opinion that, although support for the
>> RT kernel is not on the near-term roadmap, we should welcome RT Linux
>> patches.
>>
>> Coming back to this patch I can reproduce the stack trace referenced
>> in the commit when running with PREEMPT_RT enabled, and I have verified
>> that this patch resolves the issue. Next, I observed the storage-related
>> stack trace mentioned in Jan’s other patch; applying the storvsc patch
>> fixed that as well.
>>
>> However, when testing without PREEMPT_RT enabled, I see a another lockdep
>> warning below (both with and without Jan’s patches). IWanted to check if
>> is it possible to address this issue as part of the same fix ?
>> Doing so would make the change more useful beyond PREEMPT_RT.
> 
> 
> Sharing the stack, missed in previous email:
> 
> [    1.612866] =============================
> [    1.616197] tun: Universal TUN/TAP device driver, 1.6
> [    1.612866] [ BUG: Invalid wait context ]
> [    1.612866] 6.19.0-next-20260212+ #8 Not tainted
> [    1.612866] -----------------------------
> [    1.612866] swapper/0/0 is trying to lock:
> [    1.612866] ffff895a03dfd3f0 (&channel->sched_lock){....}-{3:3}, at: vmbus_chan_sched+0xda/0x350
> [    1.621086] PPP generic driver version 2.4.2
> [    1.612866] other info that might help us debug this:
> [    1.612866] context-{2:2}
> [    1.612866] 1 lock held by swapper/0/0:
> [    1.612866]  #0: ffffffff9b7d4660 (rcu_read_lock){....}-{1:3}, at: vmbus_chan_sched+0x38/0x350

Current context is LD_WAIT_SPIN (2), but the sched_lock is
LD_WAIT_CONFIG (3), which is invalid in RT. So this is warning us about
what this patch is addressing. But my patch likely misses some
lockdep_hardirq_threaded() before vmbus_handler is called to annotate
that fact.

Jan

> [    1.628045] i8042: PNP: No PS/2 controller found.
> [    1.612866] stack backtrace:
> [    1.612866] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-next-20260212+ #8 PREEMPT
> [    1.612866] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 09/25/2025
> [    1.612866] Call Trace:
> [    1.612866]  <IRQ>
> [    1.612866]  dump_stack_lvl+0x6f/0xb0
> [    1.612866]  dump_stack+0x10/0x20
> [    1.612866]  __lock_acquire+0x973/0x24e0
> [    1.612866]  ? __lock_acquire+0x449/0x24e0
> [    1.612866]  lock_acquire+0xb6/0x2c0
> [    1.612866]  ? vmbus_chan_sched+0xda/0x350
> [    1.612866]  ? vmbus_chan_sched+0x38/0x350
> [    1.612866]  _raw_spin_lock+0x2f/0x50
> [    1.612866]  ? vmbus_chan_sched+0xda/0x350
> [    1.612866]  vmbus_chan_sched+0xda/0x350
> [    1.612866]  ? sched_clock_idle_wakeup_event+0x22/0x50
> [    1.612866]  vmbus_isr+0x26/0x170
> [    1.612866]  __sysvec_hyperv_callback+0x43/0x80
> [    1.612866]  sysvec_hyperv_callback+0x85/0xb0
> [    1.612866]  </IRQ>
> [    1.612866]  <TASK>
> [    1.612866]  asm_sysvec_hyperv_callback+0x1b/0x20
> [    1.612866] RIP: 0010:pv_native_safe_halt+0xb/0x10
> [    1.612866] Code: 48 2b 05 d8 00 97 00 5d c3 cc cc cc cc 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 0f 00 2d 99 33 1f 00 fb f4 <e9> 40 9e 01 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55
> [    1.612866] RSP: 0000:ffffffff9b603dd8 EFLAGS: 00000242
> [    1.612866] RAX: 0000000000040d85 RBX: 0000000000000000 RCX: 0000000000000000
> [    1.612866] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff9981172f
> [    1.612866] RBP: ffffffff9b603de0 R08: 0000000000000001 R09: 0000000000000000
> [    1.612866] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
> [    1.612866] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff9b628490
> [    1.612866]  ? do_idle+0x20f/0x290
> [    1.612866]  ? default_idle+0x9/0x20
> [    1.612866]  arch_cpu_idle+0x9/0x10
> [    1.612866]  default_idle_call+0x83/0x210
> [    1.612866]  do_idle+0x20f/0x290
> [    1.612866]  cpu_startup_entry+0x29/0x30
> [    1.612866]  rest_init+0x104/0x200
> [    1.612866]  start_kernel+0xa13/0xc90
> [    1.612866]  ? sme_unmap_bootdata+0x14/0x70
> [    1.612866]  x86_64_start_reservations+0x18/0x30
> [    1.612866]  x86_64_start_kernel+0x148/0x1a0
> [    1.612866]  ? soft_restart_cpu+0x14/0x14
> [    1.612866]  common_startup_64+0x13e/0x141
> [    1.612866]  </TASK>
> 
> - Saurabh

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

