Return-Path: <linux-hyperv+bounces-8415-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QExIEqoMcWmPcQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8415-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 18:28:10 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AD85A861
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 18:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE3D0A67EC2
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 16:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD442355815;
	Wed, 21 Jan 2026 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YppgeWK6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B4533F8C3;
	Wed, 21 Jan 2026 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014039; cv=fail; b=AgdYvgycbbgiqxluLw3lYdWqnsmYggOPerz2hK/Uc1C5PXhrWQFjbo3LQeUYO886+oX8KoKDQN+6BSL4/7A/089RiNpnBM7OkIDGEc+LKe832eGsDyH0qfouIkeS3n39x38ocGTio54Fc9ZASj2JyUWPHbFzUunqNFEiVB6dTug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014039; c=relaxed/simple;
	bh=xuo9BkvaHdCHQCOkONRv5ds4XA1Ve5uvNnGHp7Kj6b0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s6uSR+r+SpB1YzvJLCqGpick4ojiyRquszWrSonPI+E7tOG37ZLGa3FyOFmpRizk2g1RuJpno3tQCoEZdwmDSYwzJb2Q153z64lK7rAPowmk+0F/BlTwVrLS7wjjrY81BbvuBwnSEQ5Au5BlgJbg23JrdNtcKWt4h0riI84970U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YppgeWK6; arc=fail smtp.client-ip=52.101.48.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hx0RyGMoCAoBbTCquj9onaudgBcnrpTE9u/nhAipmZkfQkPAw36g8xwjc04sTTJ3/eaNbMMUE4MJgLVZYWUc4Vn3Rgi7NIcU4s6EyUGYy65ErMMwXlB7LTgYvnXkd9Ev+P4zF6GxLV2SJCskc4fKc48v/9OhVVuLNbXSzWK6u7aHLpOYpxWb9NDf1ILDy/qAA9INALOqeyJSRivQgBPgU6g5P1doHJVd0ziYxSeKcinc4RdNuH7AKYv2+uchBZ22QxpD4ZWkQi3p8Z/Xt7yIXE+ZA9Hamxqpvt+guNnAiRZLANQYdbGQtNEHNdMIWGke56SpbxX6NLQB6VsLv3n5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p49CqijjLPMrT7/S7ANQq9zX3nli7k8Vpxp+vOiSVl4=;
 b=Hq+6KAdk0XT3p5xYnqLXaihoYFAOqBA6T/SMROBmq/lMly4aOz+Tq7U9sqSQW0J1ql29JKIItdtXuG/hBzQHJEt+Q5d7EQtDeCbMAs3Xfkbxi/qTz7sWekEhKudo0ykk2qmcNUERsVdHIb1kEy6KHxkuWAnwBPFcxL+HLmwYkjxvugcrTXLaeBB6pJ/jAMUWA6qUPliNhxLhUpdiM/NenG9hY3Gq3HGk6w+b8e49BoUHTYsHMR1DDemzOy6Su4jt559zh9w+kQZbkk8T2coRiAUu4ieg48bQn9f0z3CkrCMJyjYETYtAaC0PARefPXCJ2QJ5J4x6IThZcX7h78/xkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p49CqijjLPMrT7/S7ANQq9zX3nli7k8Vpxp+vOiSVl4=;
 b=YppgeWK6WKsvPOcW7a6w14KRlkXH40aFSGA3IRAL/rbNVj1BeE2JaPtaHMq+KwqJYYrkcpVk4wZ7fmbAJBS0y5RRMj9UennNBGOS9A4ifcDUjbAFqeqjCQs08Jby8LcUk1u+gB3eZ9HKN/JTtjLeu/j+jAu509QBlciSTGlCg9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 16:47:13 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::4eda:ca5:8634:5b27]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::4eda:ca5:8634:5b27%4]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 16:47:13 +0000
Message-ID: <9e6d4dd0-4060-4fc9-bc55-f9452c92afc8@amd.com>
Date: Wed, 21 Jan 2026 08:47:09 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/9] net: ionic: convert to use
 .get_rx_ring_count
To: Breno Leitao <leitao@debian.org>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Igor Russkikh <irusskikh@marvell.com>, Simon Horman <horms@kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
 Edward Cree <ecree.xilinx@gmail.com>, Brett Creeley <brett.creeley@amd.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 oss-drivers@corigine.com, linux-hyperv@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20260121-grxring_big_v4-v1-0-07655be56bcf@debian.org>
 <20260121-grxring_big_v4-v1-6-07655be56bcf@debian.org>
Content-Language: en-US
From: "Creeley, Brett" <bcreeley@amd.com>
In-Reply-To: <20260121-grxring_big_v4-v1-6-07655be56bcf@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::27) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a75dbb-71d2-4f0a-2bab-08de590cba1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEszK2Z4T2xtaVZMVXU4SFdtWGJ0RzRnVm93RXkzUFlYRWFWbVJTOXVnd2JS?=
 =?utf-8?B?L3Roa2w4OTdPK01uTk8wWVE0NW0yd0k0bTBrMVprWE5wbktVaXEzeEVQTVBa?=
 =?utf-8?B?MTl2ZCtHTWJQMHVjTjNwMVgyOEZwSzh1WWVrVWVsekhGU3R5MDEvYWtrR0E5?=
 =?utf-8?B?YVFZNHNHcm9SUkx6aWdWNTZ0cmpnRm9FQjZvRVo4VWxjdmxSK1VBU3E1VE5Z?=
 =?utf-8?B?TXFwdGJNUGk3WkFvQUNweXpkNHBSL3A1YlZYMVYzY2RobWVzcXQ4YnNHMGh3?=
 =?utf-8?B?K1gxeTk3T2pFZllKK0FJOWpxbXJid21aK1BsK0xpcHVKOXVlWlNzTjVaU3FG?=
 =?utf-8?B?b1ZZT2Jabmx0MTgwQ3ZBbThOcjZVUDI4TVhYWlY4cW9xUmFUV1RCQlR4SUJl?=
 =?utf-8?B?QVNLSmI3ZTNGc2pCSFI2d0NIc3R3Q1hWU0VCL1RCTzZPbDkrRVkwSk1HMllU?=
 =?utf-8?B?U1ZtaGtLTERBanUxNEVmY01GWTJsUUlGNDBIbk9NQVp5WWV6SW1iNXBXMW13?=
 =?utf-8?B?K1FwNWIyQVJyRlhDZGVoSThldnZjSEFSSlRrZE1RZzVEVVBVemJlNE1mWlZE?=
 =?utf-8?B?OURBTmZoOHN4NjNhemxSL1owY2xnNWFuWnYweUdVdFRKaUdxclZIajcwTmo2?=
 =?utf-8?B?cmtXTXdWenVRaVNBM2NKQWdvT2ozdk11ZzVIbmgzeko2V0xSamQzcWFzSDRT?=
 =?utf-8?B?VjMrNk9NOW1DL3FoS09pY2FKZHFmTk1OYTdzVGM2aTY2M1ZpM3dYeVJ3Zkll?=
 =?utf-8?B?TEY5czBNZjBHR2xOU0VITTF2azJTc1ZVSUxUcC9mNXRJWmxKTzA3UGk0TEQr?=
 =?utf-8?B?ZDFUU0YzWHZFTjdDb3ZKZm4zS2lyWU5Lelc0dkRyN0wyWkpmcTliQXUwNDhH?=
 =?utf-8?B?czlEOFZvKzdKdmVlVVRYK3FEY2E2UGVjRGhoTkdFbVVWb0JCSDhYUFVXNlhN?=
 =?utf-8?B?aTl1Nm5QcTlXb051Nks3Ym53N1RaeEU2SWttaklHa2xFanR6STNnSE0zS0hr?=
 =?utf-8?B?UDA2SEtVQWVYY2loeDBidEhOcmJVYUo5aFZhMkVCWExGMHNKKy95L2RRRURq?=
 =?utf-8?B?TW43V1RKQjFRNHhEK3dKWWo2emFqTFZtTlZUQXY1N2ZERGZWK0VmSlhvYTBG?=
 =?utf-8?B?VHRodzZ4SHFLNElSZ2hsQXN0YmpOYjUxamQyWDRYbHhhb2tPTlh5NnpZeXBX?=
 =?utf-8?B?WVhyVXEzejI2d2lxbWhtaFRUMUVkdGtrSFFyejBTTUs5STg1UjF2WUd5dFJK?=
 =?utf-8?B?UlFpb3B0UFErcGN1bTZudVl4VTYzMVVZSjdYRk8yNUxKY0hjOFdqRVBvcVFo?=
 =?utf-8?B?S3diVFVWcktTWTdQcndRbXRvLzd6UExlV1piWEMvSWVhcE5vSVZ0RkwwSEJD?=
 =?utf-8?B?aXBUYzAyTnN5ckYrOU9pZ0pWNkRoMXFKdi84Yk1DUkt3ZmlZdGdpSzdWTzhR?=
 =?utf-8?B?YTF2amlwYUdOSWJsWHkwcy8vRksrdEhPdzc4S2FicW9kU1AwM1lMYWFMTnlw?=
 =?utf-8?B?SndBVjc3WTQveHVhNC9oYTNGeXVEZ2hRL1BGQzNEeHoxaHk0Wk12bllCOGgz?=
 =?utf-8?B?bmpLQzIzaE5kZS9MempCMnhiSkQ5WHlpMDVpamswZ1NTcXJLTXlkUWxGVlU0?=
 =?utf-8?B?RkovS2JiRWZ6TENaYUkzMk1ibmpSNHhteTI2ZUx1bWlCQ0xkbS85Kzd3WGIv?=
 =?utf-8?B?UGFWdHVJWXYyNWI1Tnp1d040R3RtTGYvaHl6SHJ5VGhCZlpFeXZIVS9adnNi?=
 =?utf-8?B?WHM3QmE1SGtTVHhWWERrUVUvdGxCeUtCR0k2Z0M2TFh1Tmh1dGdXNWhwOHRu?=
 =?utf-8?B?bkNJYzA5NElXV3ZReTlwZFJPbGtHR3gzbityYWJFRm9YUCsvMnVHQmt5cHln?=
 =?utf-8?B?NmxRQm1SYTVhS3dVZW9FelhoRnNJYnlPT1N5eGduT04rditCV3REVnRrWnBT?=
 =?utf-8?B?RUMvSXVWWkszM0dpaThSUWVEU2p5RXBMY1UvTldybzV6RU0yWjJwVC9RcGE2?=
 =?utf-8?B?Qzlzdk5xcFBLZUlpTGQ3OTJsaXVFMldtMHZaQzJ6OHR4MkNNSklZUnd5YTBt?=
 =?utf-8?B?bVFBSGp5U1BxZlZ4b2RCVzBCd25mQ1VUVytmTnNYbTRXU0s3L1NVczBpVE00?=
 =?utf-8?B?U2Y5N2ZSQ0pqT2pmR3dOQzJVN1h5dUNwTjBSQ1pOMXNNZTMzaTRleWR3RDBr?=
 =?utf-8?B?VEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STcyQlVtOWJYWDNUbmpzZm5yRVdyTENUcTVldFVWYzBKUWF5Z1ZvVU9MN2NN?=
 =?utf-8?B?REdxb0hMaHpkc25kS3F2a2xidlZ0S2NhZnhQRVVKWDNkUWFSbFp1bmhmOUZV?=
 =?utf-8?B?aWEweTZkRWVsbGJmbytheGpHTTVLVE9TbVZpbjJ0cUU3c3h6aDc4cmExVmlU?=
 =?utf-8?B?dXJMM0ZQOUYwVUNXbVBoNGVnUWtBVko0M0FqMFpwYjNmbDJJVnR4UWkrV2xl?=
 =?utf-8?B?eWtBTzhNYmxiNnZXeVlaWStNVnlsNTc2VW8zaXNkSHV6N0R4dlNGSHJGcUNE?=
 =?utf-8?B?RHFVYlVqS1JkdDNoR3dsNFRFclFhVmdONmkyaXplRnA3MlZjU1EwLzM4R242?=
 =?utf-8?B?MjJOSjZoSnZnSFM0NGpjUHpFdkk4T29UT2RKSGFFZWYvYWtzM2hsM1lvMWto?=
 =?utf-8?B?LzQvQ1R3eWorYitocldQVFd5MmhLNmZEVlQ0L0ZBME5aM0VTeGlKOW1DakNo?=
 =?utf-8?B?QnVwOWw0TWFyUU5pNU5yRHUyVWNMeVJON2JnNk1YeUxSNTE5QVB6Yk13bWI0?=
 =?utf-8?B?amQxaitVRU5NdTR3NUFmcnZielNoWVRaMktQc20ycEo1bFU4YzZwMFVhV21V?=
 =?utf-8?B?OTdzblNrNVlWdW5ucWcvU21pVWxQbnpuOXB3dFRiQytCTXVuSmhaS29NVzRM?=
 =?utf-8?B?cmp2QTVybXQrZ0E1ejdKaG1hdHVpTU91YmpVQ1FJUHltWjE0dFdybGhrOHdl?=
 =?utf-8?B?Zk1jZ1Z3dVlncnhQVmNoUWx0bVptVFYwandFYXNDQjZJODFER2RFK05Ub09D?=
 =?utf-8?B?RktFRmRSRTg1Q0ZtUzh3STRVdDltSmgwYlpBOHJIQnBHN2FUa3o4a0xpV3hk?=
 =?utf-8?B?VlVHTHc0WHZEK3h2ODJOdi9odys5VWsyU1NadS8vQTFxOW9ncko2QTRsakd0?=
 =?utf-8?B?MldQRUhDbmJVYmNKR1BRbXBXVndZSm9CQW1ldUY3c2d4UjdtdHcwVG9mOU9Y?=
 =?utf-8?B?eTY0bWVIN2IreGF1bmNBaFVGKzRaRlBwZ2djN2RQT2dTR3J2TU5KOUpHdENm?=
 =?utf-8?B?S2FNaWJNUXpSK0pUd3lDWGxYdElFc2pWMDhub0xHK1V5cnJkeEpXYmxPdVFo?=
 =?utf-8?B?a1JXYTFGUlRRVVdIVFpsUHpXOGRqRUVWSjVRSEZqQkJpOEZEWkorSmtFRlFK?=
 =?utf-8?B?RVczUHdyNVg1Ky9RcHVNK3c1ZnpiQXBnYlNKMFNERThwTm5za0hJWDZxOGRW?=
 =?utf-8?B?Z0c3Tks1ODFJMnlUZnhpaHlDbEJkZDZ6Q3NsbTVHVnQ3YjVqdFVJZEtHQS9L?=
 =?utf-8?B?VGtPc25QMWFFSTUzemEyRWNRazNHeHlZOVpxdHJHTGk4b1lPTzV2UCt5SU51?=
 =?utf-8?B?dyswK1Bua2FiUzJXbkloOXhCOFdHL1Mrc2kxZXBmYXNQaGZSUXhteUVQdTU4?=
 =?utf-8?B?UmJndEZMV0dMWjJSc2lHNkxFVmJYbHZTRW5Ka2M5Ykp6YlpTVGl5Q2NBTjlF?=
 =?utf-8?B?bkxLQnNuTzBJOWVnTVVPaE55bHpLYXFvdStGajJ2ejNmamdFV2hXSFVvZ0Iz?=
 =?utf-8?B?QkFVcUlOR3l5RE5lb2FXM3JTSlRaZ1dxYmpoVmxyUkYvaUdoaTI1Y1FTK2h4?=
 =?utf-8?B?eGJDZFZkNEo5UGNoQzBoYTJoVnV1TjUzWmlkR25KM2UzeFNpN2hSa2YzcTAz?=
 =?utf-8?B?U3RyRTlzcHBheVdMK0tzMGxrNXRyaitoc3U0cjdtQUN1c1lnQUxicDNKZmdY?=
 =?utf-8?B?RHMwUlJEOXdjZ0R2dnpBaFI4a0NzVm82US80VHE2ZHY0NmxoRFdQODA5T3dt?=
 =?utf-8?B?UHo2a2o2c0czd3VManFkaFRvZHF5akhzei9HMlFZUkdjMUJlbHROS0J1ZldT?=
 =?utf-8?B?bFlYYmo3MWJKaWVZYStHaUpxN2lFT2V5U1dWci9kT1lQYWM0WldWQUpTazZz?=
 =?utf-8?B?L3hiTTB1NWd2aTg1U0lIVXZGWCs1K1hNWFNMc1VNUWVHalJmTGJWbzZGM0x0?=
 =?utf-8?B?N3YweVRVRGFVNVo3OERpL3BxMXcwakIxODZ6WU9Fcm5oMTg1UXNnVzg2YkF4?=
 =?utf-8?B?MmdDNGhpMVRDdCtPSEp3WXg3NTdlOThhMUdoS3NsV2JOV3NickN4QzZlcnZN?=
 =?utf-8?B?cDBrVjlmSGpoenJrTzRaVms1bHovQmtLMENoZTVPYUZORUE2elA2RThiOHdk?=
 =?utf-8?B?MWwxNHBaNFlUanZkd0ZqNkRKanlPUUlsVUFyOHBnUHZ0d3AvR1NGdTAyZ21S?=
 =?utf-8?B?NWtwMVRDNUNoRzBmM1FGclFEa3c2OHBvWXBiYWo2NXAzWG5MRWM0WmppS2Q0?=
 =?utf-8?B?andMME8yYVI4QmhEUldxelNaa2RsMURFZ0tHS0JNdnc4ZzkxVGhoWFR4NE9l?=
 =?utf-8?B?bUxpeWw5cHRpYmNNQThUU25RM0Jlb1J6d282UXBLckNMYi9hQmtQUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a75dbb-71d2-4f0a-2bab-08de590cba1d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:47:13.2866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+gvcaxCOWMAGzCictxYNbaX9Er8CCwiavB9rRbhdK/5XqeRb7PvpqPekYJIKTMqiIQgMF/O6BBJscAW2D6OpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8415-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[debian.org,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,microsoft.com,fb.com,meta.com,gmail.com,amd.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[amd.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcreeley@amd.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,amd.com:email,amd.com:dkim,amd.com:mid]
X-Rspamd-Queue-Id: D9AD85A861
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 1/21/2026 7:54 AM, Breno Leitao wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Use the newly introduced .get_rx_ring_count ethtool ops callback instead
> of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().
>
> Since ETHTOOL_GRXRINGS was the only command handled by ionic_get_rxnfc(),
> remove the function entirely.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 18 +++---------------
>   1 file changed, 3 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> index 2d9efadb5d2ae..b0a459eeaa640 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> @@ -843,23 +843,11 @@ static int ionic_set_channels(struct net_device *netdev,
>          return err;
>   }
>
> -static int ionic_get_rxnfc(struct net_device *netdev,
> -                          struct ethtool_rxnfc *info, u32 *rules)
> +static u32 ionic_get_rx_ring_count(struct net_device *netdev)
>   {
>          struct ionic_lif *lif = netdev_priv(netdev);
> -       int err = 0;
> -
> -       switch (info->cmd) {
> -       case ETHTOOL_GRXRINGS:
> -               info->data = lif->nxqs;
> -               break;
> -       default:
> -               netdev_dbg(netdev, "Command parameter %d is not supported\n",
> -                          info->cmd);
> -               err = -EOPNOTSUPP;
> -       }
>
> -       return err;
> +       return lif->nxqs;
>   }
>
>   static u32 ionic_get_rxfh_indir_size(struct net_device *netdev)
> @@ -1152,7 +1140,7 @@ static const struct ethtool_ops ionic_ethtool_ops = {
>          .get_strings            = ionic_get_strings,
>          .get_ethtool_stats      = ionic_get_stats,
>          .get_sset_count         = ionic_get_sset_count,
> -       .get_rxnfc              = ionic_get_rxnfc,
> +       .get_rx_ring_count      = ionic_get_rx_ring_count,

LGTM. Thanks.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>

>          .get_rxfh_indir_size    = ionic_get_rxfh_indir_size,
>          .get_rxfh_key_size      = ionic_get_rxfh_key_size,
>          .get_rxfh               = ionic_get_rxfh,
>
> --
> 2.47.3
>


