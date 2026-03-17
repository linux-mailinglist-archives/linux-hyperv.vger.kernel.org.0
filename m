Return-Path: <linux-hyperv+bounces-9484-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMLAOUgMuWk/ngEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9484-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 09:09:44 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F182A5579
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 09:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1FF53004C88
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 08:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CAF3939B3;
	Tue, 17 Mar 2026 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uvu+fh8X"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011064.outbound.protection.outlook.com [40.107.130.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17067390C96;
	Tue, 17 Mar 2026 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773734974; cv=fail; b=AQOAnQxMmFEm28ruXoag7eThRu179veSAYzO1EzAtHI3oYf4wql6xmu/J1g87i8PwjU+MMZQdSd7ayeD8P06u2GHtD85sU3NoJcy50HXV8TuqCEihirbfbMg7EXM8ToxP2M8StMSg6d5WL27ttio3E5OKo5x/CR0H0QRrrsyQhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773734974; c=relaxed/simple;
	bh=r+hk7/ChWu690Y9SHx+3mvvPg4vpuvnfQl6B7vb4lR8=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=lN0MV50FtCZ4+qWlA9O5BlI+eBOaCUnOPhcDIzzNzkG/JvVb3gRNVEvX+QMFTECIIr/juIAdGeV2Va5jfoGNxDZMV1uuYfQVwmYfpAiRhC2N+uvxBmEdKAoRNNI2FF9yzL2WLABeefKqKJEtEN6KjuhuZECznIDteeN/99lmS/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uvu+fh8X; arc=fail smtp.client-ip=40.107.130.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBSye/8kj5OI/10WOdPSvx0fLb34nhrpfmbiu2S15lr1rg7umPyTvId3ReDcwIvxkvUrsHPpmHuai9QBr/aBpxwKvfUOBWoGjPiiUA0Hv/96F3Uw7hVTo6JmFGoOyJ33CRDJd30i4+J25fg4QW3NyAj//lTbLVrw2sDNgy8p2Y2U54h7bMUCXxWtCAdDOx56SXt8u0U9uxVuuM3l4zpd1xm9db0OjdFTmxzvLW1untwdzpUblUIyj+I42bH/2Fwwk+05NjgUWGD6X1E2kAa1raT+XwG0DWddn/6647gTXUtR6aTRcwA5Mh/3DenQMeQwGa8/0FLr9pyiN1jroRC0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5npkbdd3eachbe3gqX/G5pSrN8KFLNj9xol1LnPkYM=;
 b=jyRx3Z4rl45lIvm3HrHiBwyaGcJ7dGBQv+gbE7/4a1IkXtYwSfUzMbxyDheb09ftqR794UAEmQ+0PquMdGe3oNoJg5Plm5jppVgOaq0Se83Bon6GmGddyl4+ZsUZmOAF84NG1AqmuTDjRaz7Fvt214N+7aVn+mzxLVuQXSrjvp/2NBCuCyIDlpCd3M9+66weswdvUJJrqJMCV/uw0LELoscT8u/rmGqpO1SPMmDl0u2n++jdyLwGUFPP9S4y0sc8lmwtXUvOHz6U65WvnLkyM2fHD8Uc51RZsX4Fe2MmJvIt765OZDl9nVUGfSgCfG5tUMZCdp+N4/PQLs57UxKU4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5npkbdd3eachbe3gqX/G5pSrN8KFLNj9xol1LnPkYM=;
 b=uvu+fh8XZ/f3T9P6MfxkYkQCN4w9MfwsdOlbxqATWMgh2sYriMlM1DdBeLnPF9ADClyRGf1sXj3rF0DFcTSpPJIwJ6c4vC2McmXwwLZ0uFkQqVk4eE+lVXgBWezRvAe4tIU+wy/Zrd1aC7CYhlCjTPk58tOe0tCDXLKvo4gU/qPDuX+G06Vp+LIKNAitAX8Yz2eXeD7usrTw1ScODjY9eGZAEdnkICpGnV5PGZiT/U41pc51Ix1mVDetIGBISUCvVmJFHeQz0GqeD+9GJT9/HUtfjsTc2oFBFEggiek2KAnfKRiuA1luRS8LQIJfVgO/zKyfwIXV+iukh9IaLrZ4IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3663.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:133::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 08:09:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 08:09:28 +0000
Message-ID: <1b53653a-98a5-402a-a224-996b26edaa97@siemens.com>
Date: Tue, 17 Mar 2026 09:09:27 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] Drivers: hv: vmbus: Move add_interrupt_randomness back to
 real interrupt
Content-Language: en-US
To: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0290.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3663:EE_
X-MS-Office365-Filtering-Correlation-Id: 65018a5b-9d7a-43be-6307-08de83fc82db
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	QdS9ZGxwoinVJo3s2VlSxPqGtFzjyzs2AoECkk/ucqGb8Wgb6+zjrnalhAfda1ceWkkYoUsNbTWOt1L15KeqAfQgwcNqBopGdOAeLEr2DcLxZvkzfk259Zi6EyTpKVsd8hpT5566Rlxy4atjUSMzyDZ8HvbkBr/SzoBJ1WPJ5bY87eQDfZrb7cwdT8C7ApvTbR2f82ZwTmO3SZqxaIOIFh6EthYnhZ36D8co3A6oc/UQAqMDVDGrx7p4KekAGm2jHsasSd5q+kJBVljSsAA3mBDbEQbbG5QbOgGVic+ZyMA1i4+AhSP/ujC7IS1RoiEGiHnLOiQNmvOSFXquZb+WSbSCXV+lsxIY83Rrq5rxlNrPP8fxzZpBCASDM0eucIiCu0FeMd/BLLh0QKIYkdNPdf1EWCxnpE14PkcOuotndiQMEAR0DwBu6f9cKLIWJO3beYvlEH/HA9/oCQJi6U0UC0daExwvlRb+4MzBbJB/+hJeKqG5IgDRwF3APGD4Hjvg18K8RI7GHJawYniAmFCUk8hECozxp73YxwV+Ju/5Zawa0bcvic/5zL0kFI6g/OuNXk1GHF/EKSQWRNtjdKD8t4DIE73DKZ3zdJwq1DpHvHVsYsjRsSH1KhQmlEFJyu2mZC9QHNp3k1VMtIo3V06ZBIvhsWmeTzNzj9Fb7Tn26TyxTc2TiXU2TbNyv5md7uVl1JoOaBrEWaIh4hvWMvufGJYFfZgGJ6cp5nQD1AR+YD0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3orWUVldnhSMHRIVGxMSk4zL1RoQjA1NWY2Uy9PV09CcUhRdWtDTmttV0Mw?=
 =?utf-8?B?cXhPZ1c4Y2UzeHFFMEFYcFUvZ1gwRnhFem9hQjZ0SFZvallJWGF6dHNGQkdq?=
 =?utf-8?B?QjY1Y1h1LzRScGNMdC9ndU9RWVRxanRRNXBSaUxiYXRDb1pKWktCNTQyZmRi?=
 =?utf-8?B?bW1nbFQwQmZoa3Y4alRVR3BEQkNlTXIvSFRrb2txcXJHMmlpOHdVNlZyWmdC?=
 =?utf-8?B?R2xyZ2FTd3FUNURJazUzUm1SSm41VnBnVHNqZlZ2c1VycXJQdTlHR0dRWXFM?=
 =?utf-8?B?d3NKS0tHM28relF4WWN2Zk42YVhGdVlML0VZR2ZOV2NTNGNIN3NkNXhHMzJy?=
 =?utf-8?B?N05Dc2d6Q0lYSXF5VkpCSWt5bFdHVHZLYXJhZUtrRFZjVWhIVTRRS09iME1o?=
 =?utf-8?B?L1ZLMUlmTmhHYkQwdzNldy9Ed0RKRmRkR0FlSUYvNitldE5RaUthM29tWGMy?=
 =?utf-8?B?am5iK09qSWptbHZHT1VWQ2NVTzlXSG93S3lCdkVsYS9jUEd1YnkxZTJLUS9K?=
 =?utf-8?B?bWhwZWZBWU9UcjkwQzJURGE5WEVnKysybTVVRzdsaGRSeG80cEwreE5teDg5?=
 =?utf-8?B?NkJiYXk4b3I3RU9KWXJsSUtaVWthbmQ5aU1PSEdpS3QwSFVYQjhoSUFUdVla?=
 =?utf-8?B?THZzQUJkWFRFcGduQUJUVlhZM3FYYkFBOEVuTENPUVJ3TVFqMXNpL0JZbnJJ?=
 =?utf-8?B?ZUhMeHg5bnZETkY0SXhCRFBibElDWVFXRkFEeGN3aEQwZUZLOUFFUVRLbkhP?=
 =?utf-8?B?NUJJRDNPMEJJMnZKUDdqRTdaSloyNEtYR0N5UVYwaWxXdGp2UlRkWU1GdzZL?=
 =?utf-8?B?TGZHTTNlQ1lLdWxLWXV1OHl0L2JrMExyZFI3MUFuYVpMOUFHRDhjNE0rNC9j?=
 =?utf-8?B?dVlKZDE1cGRVZTJKSSsyd3l1WFZRRWVvTmY5cW5pSEpKdzZYVnhHWnhOV1ZJ?=
 =?utf-8?B?WXE0eHcxTVRib2tuQ0dKdzk1NEJJMVFxMnV5VWhRbFJDQVVDN0FDYklEd3VF?=
 =?utf-8?B?WktxSkJmbkQvcnM0NlRKZlcweWZRM0tYNDlkazQ1amFYRDRmcGIzeGV3YVky?=
 =?utf-8?B?aXEwZi8yOGVlL0hUVThPYVA2UmRGS1lIa2FFR0JOWWlwdnVBOTJsa1EwOHNx?=
 =?utf-8?B?S0R1LzlwR3FnbFNwR0tXQUlHcWgxemY3S09ZNktsQkQwUi9DVHBaTEUvbXQ2?=
 =?utf-8?B?cFVDT0M2SHRkeHF5ei81ZDJ0Z2lRSFVBWGVGajNpeG5pdWJwNFpOdC94U2lm?=
 =?utf-8?B?UmpNWEQvWUJOT0gwcVlBcWhLR1p1aG9sVmNHZ2h3cm5rUjhFR3JJWWgyb0gv?=
 =?utf-8?B?TGpDQ3JHcEIrdGxGUkRFTnNia2ZQVFZMUGdhTU5tLzQ1ZTFNcVdRUklKWUxC?=
 =?utf-8?B?UDhIczl4VXZXRDJ4Ty9mSFcyWENpKzgyZFFyeEJDYjRUcWJ6alBkRjVyK3p5?=
 =?utf-8?B?aTgyR0gyaS9kQ3ZvZG5XbUZZazRUNkc0QURoV0JQangzSFhSY1kyL3lyd2RP?=
 =?utf-8?B?aG1xR0tIMnB5QWdIU0MwSEhnNDZET0ZLZndUaWV2SXpIVDJIaTBNSHlvVHhG?=
 =?utf-8?B?ZjBTTkxRVnRWWFhwVHRHNjZtSEFhckIvR241dXBpeERqZjRFODN4MXdZNlZK?=
 =?utf-8?B?em5hZ2lJUDQrVU1KbmM2L0JSRmVDaHVwNmptaVJleUp2dThHdHB5Z3kyWlU2?=
 =?utf-8?B?UnZOVHRCQTF6U2NuWEN4d1p4QXZia21yTlRIa3o2ZXNRSW00UVB1eE5OdFNM?=
 =?utf-8?B?aTRFWUd4Q20vMUIrUE9tRm9WVFVYdlBtSUtkTGNlZUE3Uml5NG5icU9rVlhR?=
 =?utf-8?B?bUV5SUdHZ0xHZCtmUW1RaEc3TFZibU9QRE9VbmFTNUJWV0JTNElJV25pVXNF?=
 =?utf-8?B?OGwxZXVZdlM0RFViV2RmekVkVTdOMEJGRWNnaUg5R2tEVGc3UENVci82OVhQ?=
 =?utf-8?B?SkpYTjZGaFh1SU42bzhQVGdTVjR5SUU4RzBUelpMY3cvanl5YnVPS3ZxOEdp?=
 =?utf-8?B?dTdrN0VkUHVxaXlXbUtSUmpTamFaQmR1UlBhMkN5Q0RwREtIZmcwSzRrUW1N?=
 =?utf-8?B?WDNjU2pnekJjZE0yMENWTCs2c3JoT05MTG1CZ0hPc1RlSGl4NnVvOUVUUFR1?=
 =?utf-8?B?aVBuSmcxN0E1aW5mamZseUlHZnkvaXJtZVM2dDZGRWVOcnRDTWR4QkNub1Jh?=
 =?utf-8?B?QTYyc3h3a0R5MGRUY0tDdjh3bjVud3lPeitTeGZseHpzVU1paDFmRVdiTzRv?=
 =?utf-8?B?alRpdUhsa1FFRFBxSnFUdllhZ0M3bEZpRTl0bWg3alJ2VXRDYjF3WmM0WVcz?=
 =?utf-8?B?OVdZbHZzWWtFbCtVYXNrRUVBUTZTcGJrVkhpek1yM3E2anpPRlkvZz09?=
X-Exchange-RoutingPolicyChecked:
	KYfiwsiiDaYEZVeUAOy76CaRsu7LEzKR6U5rIGIOzS0SOhYqMtDm4QZ3ErAu0rJK9ivJ0StKkkRfVruWdq+AnY8S/66Bx5wIoaJ84BiD7zxA/cJOQYrZe3eFb94wqA4YaSEgSZ1PhDhF+jb/CWXMNj3SdUjjxzleKAryBqWwl+CEIuCpmXr9ugL8A7pu7gTRcvN9nhNCDQ7B8BIl+qtOqPldWtJAgXLmp/YEyHKXq6U8gmpd6h5vv5LjyzWzde6t28u4fpRoeZ8rKEHhWcZe7XufvgIVIzQHO6e7DAuC9VugxQI8u+Dynj9+hmjHsnjEvpPZUMxXncvoN45HiEeguQ==
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65018a5b-9d7a-43be-6307-08de83fc82db
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 08:09:28.5335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIghBwI0EVAz9inuEH2MFAyeyYL4y8KnPT2dKX19G1PkE8a7JhHVaPUcdpHQV1Wd1ygjCTVMYMvmVom3G6VsYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3663
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9484-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,siemens.com:dkim,siemens.com:email,siemens.com:mid]
X-Rspamd-Queue-Id: E9F182A5579
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jan Kiszka <jan.kiszka@siemens.com>

Sebastian Siewior wrote:
"This is feeding entropy and would like to see interrupt registers. But
since this is invoked from a thread it won't."

So move it back to where it is always in interrupt context.

Fixes: f8e6343b7a89 ("Drivers: hv: vmbus: Simplify allocation of vmbus_evt")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/hv/vmbus_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index bc4fc1951ae1..28025a264861 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1361,8 +1361,6 @@ static void __vmbus_isr(void)
 
 	vmbus_message_sched(hv_cpu, hv_cpu->hyp_synic_message_page);
 	vmbus_message_sched(hv_cpu, hv_cpu->para_synic_message_page);
-
-	add_interrupt_randomness(vmbus_interrupt);
 }
 
 static DEFINE_PER_CPU(bool, vmbus_irq_pending);
@@ -1410,6 +1408,8 @@ void vmbus_isr(void)
 		lockdep_hardirq_threaded();
 		__vmbus_isr();
 	}
+
+	add_interrupt_randomness(vmbus_interrupt);
 }
 EXPORT_SYMBOL_FOR_MODULES(vmbus_isr, "mshv_vtl");
 
-- 
2.47.3

