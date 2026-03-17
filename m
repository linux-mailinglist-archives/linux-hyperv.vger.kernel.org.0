Return-Path: <linux-hyperv+bounces-9493-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFQQFltBuWnq9wEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9493-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 12:56:11 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B14F82A950E
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 12:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56CF9303A24B
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 11:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F34E3B582E;
	Tue, 17 Mar 2026 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="YZJRaFi/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340743B4EB3;
	Tue, 17 Mar 2026 11:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748568; cv=fail; b=cYYDKs0Av3RVRnyPbnVNJ3Kr2oDtlkfFc9+WjiEEXioY8J/C8jVvK2ejFuJCVXDUDbYx7wUV1p2hQxMDUAtwcLBXqKAQ/mZZmU8dMFz+Pmt76Zzo4Cn7NRBviZgC5qhcl6CEoV7QgeWJdPnD5wQpYl1YNGGtAi7GicR+3VpukL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748568; c=relaxed/simple;
	bh=/xSf8vbnu5ipqCggllLOmIFG1B2Ffk6T9/W/re/tlqY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CcoilAwt4rxQI9K4EFP+206+0bid4OTmkxvhq2rUmWOaOnNIoVHz9WRs7Z+g2B7gii9Pbr4b5Wxz/rKWxRveebtFfN0I5KwxLOziO0ePAh5v3TZLsIuqjt5U49vkQ1RmyrhuNW08iKfQ3JrXNzkSDAIe4Q5WIg0yFRWoV5iJhow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=YZJRaFi/; arc=fail smtp.client-ip=52.101.66.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mj5YQGlsJgwnjrXY30rhDYK28tazv1Pt8/sBsQ/zE8RxzKGY1/RxCRGIqN53x4COe+/PrliCy5DGA/tn2CPy2WmOMr2DdPz2U99kG92RaviFmPxvQv5RB0P7BGMvRmz9jA6N5r3eqTif0TEigBmf9EXqtbtIvox/7QtxlGrQ8HuJYTNmZuGkIKzuG/RY5aovT51nC6Mh3RHT/qAFj2umFKTrNa28mYoq2tNfcU3wJMOA4s6DsAk3mz8gOQU+YdIBLeCpsOPzCDDV7ray8oZMWeIWqkTOr0mKFqjyrqMYObC5PXgYsuvMFC+5iPTaCdnbPm9lOnVZMvv80rs8+DW9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uNPZipChcNYgLq6Jr0LKJuYoxsiJZWvoZPMi7a2dAU=;
 b=HxQ4PS8tYsGodPU8y5OsTaRKb2ViCO/muoPwIAfkj/9ywHoqPGJ95YJJbwcGj4Gr0BAlYrnE8cmM/96Are9QBVZDgpPoHVdeh3f/FN7EzJBT0dIBpkoQCSiheASOTLZQYkPVY8MlYVmH8sch/FniMGNEEXc9DAkiWMdMzf03MfpsrnjF9e9XGBzlWcMa1Fl2NwHVQRhpJOcxZ0CDZvWxb0WUW9Ev8Z+nDSvJBDA5ieVZZnzNBx3FSxgN8v5ym+0DWnRFySKYU7/gh5m2K94OtP7H80fZ+qzkHGDDGLWQfhAYgqPrBZgipfHvxFzRsvq+nPEFYCcphdTTD55FSjA8KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uNPZipChcNYgLq6Jr0LKJuYoxsiJZWvoZPMi7a2dAU=;
 b=YZJRaFi/xfGxJZk7St9d08jyl5wk3vTjy8fKQ8py/VAbB3klMlGobcHUooSTOkofcwPS5smHVwURT8ikLNekkAE2zNi95DsljB+ucYzmSGBgx7G2qyxpJMEmMgWyMtGZnlhUy73DD14kKySt4fZTN0nxeglaEq7em5KSPbXc7hyDA/QJ1+C6gNiKC0jNZU7ukVs/oOY9dry56hEsV0D4veVBV7xC0YPzpTIFfDygMFwvCn/lR285clCb1LQImua7Uo6oLYxe8XCDRDzJTTbF9rWxQiaBj46Ger8eBypQWPC3FANlSULRerMbHoTPzHwcghuqw4uPcMSKstr6fN6c9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5340.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 11:56:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 11:56:03 +0000
Message-ID: <f718a22c-bbf2-4206-ba7d-391243c84f60@siemens.com>
Date: Tue, 17 Mar 2026 12:56:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: vmbus: Move add_interrupt_randomness back to
 real interrupt
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <1b53653a-98a5-402a-a224-996b26edaa97@siemens.com>
 <20260317110535.Smn9viQ7@linutronix.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
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
In-Reply-To: <20260317110535.Smn9viQ7@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0382.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e918430-4682-4ffb-d306-08de841c2a31
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rNSZxy7+JfFQrqJCxnRF5vTCWE+VVqikvZ0g9j0Ou9AlW+uhhCm1IJSJA5slmbWOnerLxwijQEF9G2Rp2maqSEme9UvAFGgRaWTHLh0wu39SUpFTAg1w+cpLXhhc2QnKG0wTxkQsndlBivH7fPXFB5BOPhWz5bpNNqdg+vtwI6kWnPKdZS/gNHXQBVwsFlUf8LZn+hClqMhouafhEpNUmTJsyGen25ygQxs7OUeKj63QiQd/Luq7s4BP/4nG+Zxq5l8SP55msKaM9odYzdZ3EREVeAt5gOsm5wS4p8ChYjg924guE8ZnMnMVSUE5bMIMmL+1B/xSnIbHnVmAFiyYP1NvJogB4Klmv2zrbANIETIgHz4IgiWPM/VBek+wuWFurOvn11h0MxkujeY27v+xOI/Ui5PfnVsCy2+XjmSu/Z8ECKiRJ50ka/5zYc2Bz1YOepVb4wbOp1LNcDcDkeh63VYolojr/2HZo9ZLcgPiuxet7Q19BLZGv37MR7WkGb4CzCDv/fIXk2RdI+YfH3LglF/ywnNlV4p1vQxTRLryZt4yf5UaIgW/YvT3ZCq2eM5Bc3Sz+w0y8jfoBtjsN6pXpdmYERPlKIVd09bQHJIRx8VPKyuqyWbjxgGUU0k13gvZDK9rOOH4xwT9XvsJglg9gzKf4gG5JyjfCMGtDviSfUydFKIHp7QuPo1iR2R5mmOgxD2D/ZSndfEZiRFSzwBpfBe02ZU3NkuOaVpoe3RTlrw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enR2azJ4K245MGM4cGtQc3dSbXE4dlZnaThZZTlCZ3BIZkxtSndTVGlYbWhZ?=
 =?utf-8?B?WEc1WXlkMVlocEJ2QjB2UHJLTEVXSDVnb0d5VnVITDUwTlFKcDhsY1BNa3k5?=
 =?utf-8?B?cENlS3dzS2VsN0svUEkxZzB6bkxQeFRSTGI4ZVNaaVgxRHFkeFhLUEMxckll?=
 =?utf-8?B?LzJwd081QWswTTdiTmpSSllvWEJvWUlnWFdiTHdOQ3JUZERkR1c1c1oxTCsy?=
 =?utf-8?B?NUNQUnJKOVBrR25pYmt5SU9KS1IzZ2ZORGt2OHlYTElzaDNodlFEM3E2bVB5?=
 =?utf-8?B?aHFEK2FYNEwzRGxaWjErekV3MjFqNWpqUlpsalNncExhVlR6SllvZm04Sk9R?=
 =?utf-8?B?MzRQNVM3WjdPWHZEZkNjOFM0OC9Dc2VrZ1RiZVZrK0g5eWtPUGdJejRJZWoy?=
 =?utf-8?B?cklvMmVTOFJTdlZOK2ovSzQrVHQrVVVVV2ptWUtZaGdxQ3VWZ1ZRSHJoQVhz?=
 =?utf-8?B?UWpKTHE1V2UzZGg4RzRaNTVMTjlQN1MxSmQ2MlE2aXFQS3VJMW5MU1gvVG9L?=
 =?utf-8?B?ZXZaRkx5M1lsaFNNbnBwK0pLTGhiVFdMWFlaRTFOWE5kMUlXUG5NQlBXN0Zj?=
 =?utf-8?B?Y3lRL3pnVnBvbElvNmNwODFpbTZ3bXZaK0JmdGkwaThoU3BKdDR1Mnd5OGRp?=
 =?utf-8?B?Rkp1VHk3RHRYV1hIL1FYQkl6SlllL1FZT1dTK1ZySUM3RjZpS251QUNGV25q?=
 =?utf-8?B?TGNlSEowb2Nrb3VWRklNT0h2L0E5WDZDR0tKZFhxd1FHZWRBby9pcHVSclUx?=
 =?utf-8?B?dGNkaDhuUmRTM1NQbDRrQjJxcTdYQis5VG1TNnlIK1JRKzRTSEJOamxKYkdq?=
 =?utf-8?B?czJUWjBZc2VKQ2dlaVVPdDVnSG9yN0NFRldHNlA5RFdUa3c5MVk0TlhaU2dN?=
 =?utf-8?B?L1hMTjlvUTJ0c2t3bDJHTDdQcGl4OUdDK1JPNFhzWDZjT0V2YjF4eG9zbEV4?=
 =?utf-8?B?S1BFVjcvd1d5QmwrL3kvc2hUZVAvMzdRNWRzRkZQSWpYOVdjVG1kVTN5WVJ4?=
 =?utf-8?B?MVRMMENCSjVZbXV2R3dpeDhPKy8yeXpZNUxCN0dHNHF2dHlSZVFmVkZtR1pq?=
 =?utf-8?B?a25pak8vWVVFOEpYcHV4d085NGREeHdIUVNZeThRRnBZT2grYU8vajlQOVRk?=
 =?utf-8?B?UGw5WVdkdVBqMjROZXQ5eWJlSjhYc2JBNGI0UWVqSHJocGxOeG40cGxzRVVJ?=
 =?utf-8?B?aW1ydVBqSnpBQklYNlMwVHBFa0xQS2RvdTVHOVNzdUhMam5JRUlkdXZIVjJi?=
 =?utf-8?B?eDUzNWJQZ0tzMGlwUnVrRmJkemgwUVdrVjNhYUlaZG96VzBkRldyamJ3OSsy?=
 =?utf-8?B?SDArd0xZZ0FLbVl1MXc2MDVHNEFVNnkvckJtSWt2cnZxU2MrRDlDMDJtQS9s?=
 =?utf-8?B?UWk2ay9DV2hJMlYzR3JCMndFZWtsOVByODhVay9hb0xTNTEwelRBaTR1aXRB?=
 =?utf-8?B?SVpzWktNMTE3bXlJNFphWG9KTVBpc3BLWkNVOGRKMGdzZ3BkT0cxOVlrUEZH?=
 =?utf-8?B?Qk1sbGRDWkIzMVJvL01hendvMzJTZ3dUeURzOWQwTEl0SjJRbUFyY200aGRU?=
 =?utf-8?B?cVY2QjhUNUNQWHJsTXdQNTNOWlduQXFOTGNIbTdWcUVBVGZmNU1UVEdncGNM?=
 =?utf-8?B?S1NoRkgvODFhMmZyODVQNkhpR1ZKZ016ZU1lVTZkekVCUXJLQVJoS2sxNjhp?=
 =?utf-8?B?RUhEbnFweU1zNzlJdlBQNnJpeW5PVDRvOHJYWTQ4QlBzSm9oS3RXUDdBQW1T?=
 =?utf-8?B?U2RLZC92NzNPUXptOG9QcW9OOElNblhDYXlYSHJNbFdNaEh3eUw0Tituc1dp?=
 =?utf-8?B?VnRVTVhRbDZYUFNQbTl4WjU2cVBkeVU4bzd1RzVIUHdINElpWUdXWGtVcFhh?=
 =?utf-8?B?anE3eVEzRTlGQ0VnZmVLQm90S1ltWnFialBCbHpidGVGMWNEdTNGbUJFUG1W?=
 =?utf-8?B?eTVFblJNZG5WazZKajJzNE1xVEpjdDJSdFpCaERVT0ZzQWp5SFVNdVUrYVh3?=
 =?utf-8?B?L1g4YStZWGhhNGZNOCtKVTNxTWgxQWJHS0dZR1kvZmhnVnNVQS9JUndyd1Bq?=
 =?utf-8?B?MTdHb2pVOWdsL0FNWW0rbE9wRnU0WXZPdFNnWjZBTlRuUGFYTEYvbXg1WG05?=
 =?utf-8?B?UWNQdXJxZit4bkpSQXRIM1lJVmswL3FDVWZJU1dMY3g4aDU2eEN6RGYvWVdX?=
 =?utf-8?B?OFdSYUVMWUQ0WEh2aEJyb0xwM1JKZ25vWkhvZnhNWlo4NDZxU3FpbURsSzV5?=
 =?utf-8?B?RVhFUlJqdC9LZVl5QS9wV2k0dHN5K0lzRGdaWDBUdkE1dTNZckVhZHBKb1ds?=
 =?utf-8?B?Sk5GSW5nY2k1d2xPdFVHSWQ4Sk9RdXRsMWFPNUJrM3hJUmpoWSt5ZFJLMGV4?=
 =?utf-8?Q?+wGARzmHMrQ9ZF7Q=3D?=
X-Exchange-RoutingPolicyChecked:
	W9vJxJagZd/ak0eYnkIQU5P2DahD7TD8Mu0cW1UPhjG6B4uN0V9Kl0vb0nOEn3J63RxtpfCSVhjjZBLj+jm6csmpmeomFYN4NrZHsrLGYYql6di4oEh7oIMwvis5dI2HbA1nzR37NrzOi/z2cCMsPeZcJkL6N+SazztIG87pRirxLhB/loY9zK7QnjeUlwGHpAmcUSkzuV3d0+nl1B89ylunhMUaWwWt4lCMakJPaKPYrMsvxq3CG9FHVgcK/iyfeDbW00G2YN/P92uXYjDKKxk8TcPEEcX5FCdF7i2BXoc4dpCrdHZJ3k2dxTQ1rtiVeBqcKoOYuLP8r2tmWCgv3A==
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e918430-4682-4ffb-d306-08de841c2a31
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:56:03.6218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFzPIzqPuxKYE2vzIKntgKzJoyGx42gDnsi68aTuF6+xjtAcLdCMs/i2cQEWfITgc0MsOdTGoQ4TqcRqM1uc+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5340
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9493-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,siemens.com:dkim,siemens.com:email,siemens.com:mid]
X-Rspamd-Queue-Id: B14F82A950E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 17.03.26 12:05, Sebastian Andrzej Siewior wrote:
> On 2026-03-17 09:09:27 [+0100], Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Sebastian Siewior wrote:
>> "This is feeding entropy and would like to see interrupt registers. But
>> since this is invoked from a thread it won't."
>>
>> So move it back to where it is always in interrupt context.
>>
>> Fixes: f8e6343b7a89 ("Drivers: hv: vmbus: Simplify allocation of vmbus_evt")
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  drivers/hv/vmbus_drv.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index bc4fc1951ae1..28025a264861 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -1361,8 +1361,6 @@ static void __vmbus_isr(void)
>>  
>>  	vmbus_message_sched(hv_cpu, hv_cpu->hyp_synic_message_page);
>>  	vmbus_message_sched(hv_cpu, hv_cpu->para_synic_message_page);
>> -
>> -	add_interrupt_randomness(vmbus_interrupt);
>>  }
>>  
>>  static DEFINE_PER_CPU(bool, vmbus_irq_pending);
>> @@ -1410,6 +1408,8 @@ void vmbus_isr(void)
>>  		lockdep_hardirq_threaded();
>>  		__vmbus_isr();
>>  	}
>> +
>> +	add_interrupt_randomness(vmbus_interrupt);
>>  }
>>  EXPORT_SYMBOL_FOR_MODULES(vmbus_isr, "mshv_vtl");
> 
> Why not sysvec_hyperv_callback()?

Because we do not want to be x86-only.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

