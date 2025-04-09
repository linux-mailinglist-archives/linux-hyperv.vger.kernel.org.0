Return-Path: <linux-hyperv+bounces-4841-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8C0A823DE
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Apr 2025 13:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165A71B87760
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Apr 2025 11:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42E3263F3A;
	Wed,  9 Apr 2025 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gi+5sGkH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CAB261593;
	Wed,  9 Apr 2025 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199073; cv=fail; b=ajQFim4GEYhQ06mz0yb1n4MKlHhjXarP4MzHIIlSJI6G3ZPNk4OcO0wYVLUUkpCfOOBrMGopkkh11hzzjFHCwpX8+jVArrbhLJPxOxJ3hScphnH7aYPMwpfeXiI9cJxHqMI/RPE3ofGxJkuKGK3Qin8u7jm+ysMDCJLASTZDsSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199073; c=relaxed/simple;
	bh=TzitwEcx0POaFC1CZq/YqT0eDFFKrCiEjP0tL1P7L38=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dobdocdU6YXlWJW4jxUSsCqc3Bb2coq8NtFRYihpqbuZevgrukrnrZpSqbKV3WLBKUHyG27i84LKgNCRDINYolJqf2Sve6usY6wr8ObosMlNimMDNYA1RgMQJQAJHkEq5JXDEOuuPNrTMqB0LPv4Ncx7EkdFwb5eubcbu6qjILc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gi+5sGkH; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a412fXael8TgivOKnAQbqGT6fCroS1RjhTPXkohYwqVuxXGcleDBSB3fOZWzQ3KFY+b5trb/EKPWgUpczSj7vNn9chrNeDmXn2/fSuZspKjwPmBzPMHvJK8G/qP+VzIsKK0wc3e3urygsZQqVe3AuaKKKQrt7qpZVKR5PJloLivbm9zbmcrGs14GKQ1kn2/VI3fWN1T+8DAppd8E/MKljD5DAUfrzi2EgJHf5zhFMfN7cQGLELazHQVjPigdIVgm/FH1/RY6SltebjQg4isNsgNiLirVjQS37yfjIwC66g7niA27zwlXYwvfWRDrE2J8mkHT16qY5elZQJyA/y4vpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQV6lKyLimUtWYD+SqGWGtPckTIyzlif+6QHrGAMJuo=;
 b=QXw6c/QsJcPZtF1MvmzmLMBBZ+kiBgbnIB6kEBp8b+fq3snqU5mQP88dWY5mQbr60zxBZu1zGcwDfGcPNSb1MUVyiE+URJbeNzb6x/ZkKbD0eLTHA1g9DZLQR0eqF0qJIZT5KxaEvc1uhOocAzpVdDC5CopjxY9aGJ1Qv9uobPnfLt8Ci4RQiIabJFW9VRiGIMkyuIK/016l8/PrJfbG5J0OE7mDhtTufjUxBTFwCphF6BULoA2IYhvL799ce9LwXv35UofSsLOwl/iiN2dR371pT68GBLHm7K4Tkfi/MzHQonIj1rLqw821G1PQTOTVMNtm9OpPHoQ/jGeNdw6OVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQV6lKyLimUtWYD+SqGWGtPckTIyzlif+6QHrGAMJuo=;
 b=Gi+5sGkHWTqzR+q0qADYcdDjGoi5YEgdKL0E1r2oglmcg10A+3jNopnXiH03WNJUTIym7KwNR/zZs+4bLiaQsMNlO9yTGl0WG58sTOafVd7iuNbukicc+dJaz8CPLF6orKP7vigN0S6AL5jCTcL1QsjrZjbSV4KDichEnnsB444=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 11:44:28 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf%4]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 11:44:28 +0000
Message-ID: <94da0f09-3246-415e-aa6b-f126b475177e@amd.com>
Date: Wed, 9 Apr 2025 17:14:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7b025f3f85ed causes NULL pointer dereference
To: Thomas Gleixner <tglx@linutronix.de>, Bert Karwatzki <spasswolf@web.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 James.Bottomley@HansenPartnership.com, Jonathan.Cameron@huawei.com,
 allenbh@gmail.com, d-gole@ti.com, dave.jiang@intel.com,
 haiyangz@microsoft.com, jdmason@kudzu.us, kristo@kernel.org,
 linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-scsi@vger.kernel.org, logang@deltatee.com,
 manivannan.sadhasivam@linaro.org, martin.petersen@oracle.com,
 maz@kernel.org, mhklinux@outlook.com, nm@ti.com, ntb@lists.linux.dev,
 peterz@infradead.org, ssantosh@kernel.org, wei.huang2@amd.com,
 wei.liu@kernel.org
References: <20250408120446.3128-1-spasswolf@web.de> <87iknevgfb.ffs@tglx>
 <87friivfht.ffs@tglx> <f303b266172050f2ec0dc5168b23e0cea9138b01.camel@web.de>
 <87a58qv0tn.ffs@tglx>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <87a58qv0tn.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0203.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::15) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: abae11af-a782-4aa8-7a23-08dd775be218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWFWMTBza3lvc1dNbEdxa2dvbVVFS1Nlb2QzTTVacUt0b3ZhZUJJYkhqb2RC?=
 =?utf-8?B?ZjNIelltcFhPVy9YWWpaaklKbTlnalAyY0xWVW0yZ3p6WU1hQmhzODJkejgx?=
 =?utf-8?B?QXdjNFMrSWw1UlJiY05ibkdZMkFUZ3lLMzMwRDR0ckxvSS9qbmt4eWZZQTRR?=
 =?utf-8?B?SGFkRkNxcG5hS3JiNmI5Yng1V2tyMEN1Y3BxVWhRdXpXM2xHdVR1dC8zR0Fp?=
 =?utf-8?B?Rm1TUTAvRDhRY2NQTG9VbW9uM2laeGlyWSs0bmovOERIUVZieHpCVkRUVEJp?=
 =?utf-8?B?cnN4MTRyK280Q1BVdWFLNG5HVEY1dEdFOWo1Vm9EVnpDNFZLMDVTWjNXNTZ3?=
 =?utf-8?B?RFZnV2ViSTBnck5qT1NZeGMvcDZZaVVuTFRuTDBsN1paeGVTbitOQ1pLbXdW?=
 =?utf-8?B?b29OS0pMWUtXejNZam8wMnlySXAycUhRd1Z3TU9uSWI1cGpmOXhSbTV2dHNz?=
 =?utf-8?B?M1hsejRaN3c5b0xCK1cra2VPNVlsanQzcXB6amI3SHV2WWJ6eU44ZVUvN0dL?=
 =?utf-8?B?dUg3ekRMRHg4Nmh3d2RQUG85bWhYeXFTYmJuZG9mbUJ3cFlYWUdIaDRrcUli?=
 =?utf-8?B?SmtIZlBmOW9BS0ZhWC9vTWVXMGdwSi9WSSs4TUhuWnVlNDFtYmlweFVLMUhP?=
 =?utf-8?B?SW5UNWoyZmJ2VjJGZHJ4bHJvVTRkWkhkSGpiQk1LVlcxZkxYRVVmWkwrOU5J?=
 =?utf-8?B?RlJKOWZzclY2LzU4ektIY0tYNTk0dFg2eXZCWkFpL2Q2cVdsZVVSUURUZnpY?=
 =?utf-8?B?Sk9UdUFhbXhlTnpqQnFkVG1weDhzWTdLNlBoQ3FUM1NaNUhiYWJwWHZpZkRV?=
 =?utf-8?B?K1JlOStkRUJJdmJoZVloWTdMTkhUWlY5eG9ZVTFsTWNlbS9wRjJhUlVzNXlw?=
 =?utf-8?B?MlN3aC8vSEVPQ1hEM0pJY2hCVlFVSzFEQVNkNjBYeGJZNUN1STNDTGxOTmVN?=
 =?utf-8?B?YUNIY1dxeTlkcEx3RGNWQ09hbEtuaXBKSXhvS1VtYnRhZjhmZFFJM2xFdXpH?=
 =?utf-8?B?MGdaSGZweXduM1N0Um9kZDdPdEpUalF0QXhvTkJ0ckVIN1RLWURNQmlzTkZy?=
 =?utf-8?B?cnhkZ1FFVDVDdUVRVmtFZzJOVVVUSHV1TStGdG1LRnlkUURuR0gzOCtnV01J?=
 =?utf-8?B?dVI2MG8xbWcrY1hvZDRSUDhhOFBGNVg4cU5Ka3NVd2Y5SHlXQ2huNEVJZ1ZB?=
 =?utf-8?B?cUE2eXNFMDZBT1psNnNDMU02cTFsZVkxTEoxWXpjVVFCaklWMHBvSzJ1QnZ5?=
 =?utf-8?B?blBhcUNPdnNpZnhFUG1jTnhFa3J3ZStRdHBQZXEwSkF5Znp1ZGVnaDJnWTB2?=
 =?utf-8?B?VGdTY3RLWFdqTmRmYmxmT1V3N01GS2NXZmVDaEFabk1Kd2hsWXBjVjBOamUz?=
 =?utf-8?B?OFp1c1BLWk9DaGxKM3dvZ2dKSWQycE43aHhQY3ArekdkemZQWmdSenhBZVZ1?=
 =?utf-8?B?VkJDTWxiMzF2aWZLTFd3ejNDY2Y5ZGhtZ0tkOW9ZcGtjNWhkTXM2L3lzS1Zy?=
 =?utf-8?B?Y0t5UWhRUjllRWE3enJBY0s1ZE5FWEFTNUJkMnd0T0J2VmFRSzIyZTdQYk9i?=
 =?utf-8?B?RXdqTmR3WFNUWldDMDZlU0tHZm9oMHJlQUVVbHlGQURnZFVtZlJKUVVpMWFZ?=
 =?utf-8?B?aHBaYitqaTlvUDU5Zm9OZmo0Y3B3S1YzdXVUNXQwZmpwMW1GVlRiTnkyRUh6?=
 =?utf-8?B?RlcyT0RKRG4vVk1zT1lDbzBnazEvbkZXUVAwcnhUYXBydUFDRUNQU3ljZEhR?=
 =?utf-8?B?enNtMVhDcGFBYjV5cnNBR0RYWE50TTV4VlA4Q3lOZ1ZzRkV2djhIaEV2NjhX?=
 =?utf-8?B?S0N4bTZiM3EyY2VuRmNDVXc4cTVDQnJsS0pLNloxOU1ZcmJvcHg3UGRuQTB5?=
 =?utf-8?Q?10ihs1G2IuejY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3cwQXBUZDBOSXNyN2V6MXE1QWk5eGRpeUNTYzFHQXFKOW9ML2RQS1R1blkx?=
 =?utf-8?B?SzVMMTY5bTQ2YVNDUXlhSXpHTWJxa1hDQUtoQmVQejJWU3ZSL1ZCcWdwb2hQ?=
 =?utf-8?B?cTBrbmI1VHEzRHE0TWFMaTQ2VlpsNGdtMlBlYStYT284LzlYWnRmYW5KQVBM?=
 =?utf-8?B?d3NFeXZMVDI1ZUNRd2ExZmh1Nnp0MlJUREVkOVhSOTNaanFQZEUvUWw2Njdx?=
 =?utf-8?B?WFNhUGE4ZWNVd0k5SnBSQnZpSTVEMDJiWDF2MUozeE9ybzJpUUk0TzNxUits?=
 =?utf-8?B?RXhRSWswemhiVjNCOEwwYWNRU1c4V1UxWUpuTHoyOWZKd2dBWXBmU1cvZmpN?=
 =?utf-8?B?a3BPME5vRDhzVlhTSFJBQVlicTZlYW8vUkJkOE1BdWhrVGlrakZ1c3NTOGY3?=
 =?utf-8?B?L0VHTWFLcG5MUk5WODdISURpK0Z1RVhDMkNsaGs4cDVPVXhvaW1pMDBYMnUx?=
 =?utf-8?B?MVZ0TTdlaGVzcGVmKzJ1R29COWJPT3ZFVEpyNTJ4WXlGODRlbXJGb0FGeDdS?=
 =?utf-8?B?U1MwRzBoVEZpNms1RlA2RGRXTkN5ZkhLYytMcW96OUh0ZGwrby91NUdQOHM5?=
 =?utf-8?B?ZFR2ZittV2JPNG91VDkzNkQyNEhFbDhEZ053Y1pyNzhidVQ5eXpWeGFveXBB?=
 =?utf-8?B?Ti9RZDM5S1F2dWdPdW9aNnJtYWgwN3VvZnBGMlFVNDA3WlFyK1F6cGwzdndj?=
 =?utf-8?B?aWV1M0hmczE2RnJMODB5K1V4c0JEb3NFalU0czZYRklEV2NXU1NyQldNbncy?=
 =?utf-8?B?T3FFNFFHY2cwVU5IWTFqRDhTM3cwNmg1Y3FFdVBLVVVPNGE1ZGVEUllBbkVP?=
 =?utf-8?B?KzZtNTlYT3ErNWw3aVFOZHdYazM4cUt6d3lTQ3BuV21Hb24ycHQ3elhmRk9m?=
 =?utf-8?B?dEMzd2hubFVMWm9QYSthTFBPVnhCbU0zVjNJNDlxTXhVQWNxNHYvaGY2YWRB?=
 =?utf-8?B?c3VraFBYR0htRFdiSFhVUktWYzlkK0dySktnSEdOeWoxZlFIOHlYU3FkVmo2?=
 =?utf-8?B?MiswWHlTei9hakpwRnlndVkyVjNHdTl6Mm4rOXNtVHVKN0tnUEZSd2xmdTZk?=
 =?utf-8?B?MkFCTGovNVlVa29iUTJyL3hpbUVqVUh3N0FCalZQYW5PcVJYelhxdndMTTI5?=
 =?utf-8?B?ZDFpa21XbjYvbTBsRlVDRUxoT1pGTDM0S09kdVBJTWJPaW55c3ZublhVeFFP?=
 =?utf-8?B?YzdiLytZVHh1UzRkV0wwUXhDUHpXREplcnhWSTFlR0RFMklMaEJPdlIvV2h5?=
 =?utf-8?B?WFlzOE91RHhWWFlOSGlsTVRBbHRieTVoa0ZqbFlqN1ZISEhKYUFzSDVMUXhS?=
 =?utf-8?B?akhuZDZIQmxPeWJGUU5TdUp2UHUrS3dCdzJDOGNCQ0tnRDRJU3pqL1pnYUZL?=
 =?utf-8?B?LzFjRDR6RURrbmFjNGZOVDhGUnZsTVNNSWJQTnBhdkFEdUkzemVkTTBaV3FL?=
 =?utf-8?B?QkhRbmVBSmRlb08yZDFHY1h4bk1nSGJDVWNGcTNNbW5zSHdYWDZYQzBWSVhF?=
 =?utf-8?B?Ulo3Z2JDa2t4YzJweGpPRGF3VzBRK1psbnQ0Q2RoRFpnMXp0NFBNUjZ6VExx?=
 =?utf-8?B?MFV1RERINTRoYTVpdVBSeWRrd2crZUk1d1daVEZmRUpWQUdVaGtlejZPVTh4?=
 =?utf-8?B?QVdOelRvR0paa0VuUUZHUFRZTnlSU1FDYU4ydVlJNmQrbG1IZlhmRzVDSDNl?=
 =?utf-8?B?elFpbXA4bTYzQnJZaEJ4OEc5V01KVWZ6QnFCUjdaeWZzVGJDWDRlS3Y1K1RL?=
 =?utf-8?B?SnVVZFlQNTF2MzVDak0xNVVmTHNWdHVxMnBvSWY4bUk5R2lDalpQcTZUZUo1?=
 =?utf-8?B?NkM2ZGl0aktaQWRpTTZFNGJQeVNoZ0U4RjI2cGdScGc3N0lyY050K1RGRGEz?=
 =?utf-8?B?M3FENWRuSkFQZHZhb005Z1RsNnN0aElUUlNMeVdlcW40aWtMSU9CeER4SWt0?=
 =?utf-8?B?aUFTV1g1ZjBvdVRudGc3dlNubVA5a3NmWWJjVWh5L21RNENkc2ZEZEhCS0lj?=
 =?utf-8?B?TmtLdS80c0taeW9rK3ZPZ0t3UmFFbk56RHlocjNmMkE0ZzgvMWEycGpzOWpJ?=
 =?utf-8?B?V0NnVEVEczB1aHVTcDFhUlhWdEI5VDNQK1lnajVIcEh0NEErWFJqRytxSGVQ?=
 =?utf-8?Q?pWimP/fVIEUJt3hgDbutYU8Jr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abae11af-a782-4aa8-7a23-08dd775be218
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 11:44:27.9227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQX0Win8sopr3whF/fFYKlKTl3HIssAOa4PHtPQzfltNOv0gadnfVv893vLK+jGxzmA54D306kfoYIBDZhHcSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067

On 4/9/2025 2:16 AM, Thomas Gleixner wrote:
> On Tue, Apr 08 2025 at 18:20, Bert Karwatzki wrote:
>> Am Dienstag, dem 08.04.2025 um 17:29 +0200 schrieb Thomas Gleixner:
>>>> Can you please decode the lines please via:
>>>>
>>>>      scripts/faddr2line vmlinux msi_domain_first_desc+0x4/0x30
>>>>      scripts/faddr2line vmlinux msix_setup_interrupts+0x23b/0x280
>>>
>>
>> I had to recompile with CONFIG_DEBUG_INFO=Y, and reran the test, the calltrace
>> is identical.
>>
>> $ scripts/faddr2line vmlinux msi_domain_first_desc+0x4/0x30
>> msi_domain_first_desc+0x4/0x30:
>> msi_domain_first_desc at kernel/irq/msi.c:400
>>
>> So it seems msi_domain_first_desc() is called with dev = NULL.
> 
> Yup
> 
>> $ scripts/faddr2line vmlinux msix_setup_interrupts+0x23b/0x280
>> msix_setup_interrupts+0x23b/0x280:
>> msix_update_entries at drivers/pci/msi/msi.c:647 (discriminator 1)
> 
> Aaarg. The patch below should fix that.
> 
> Thanks,
> 
>          tglx
> ---
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 4027abcafe7a..77cc27e45b66 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -680,8 +680,8 @@ static int __msix_setup_interrupts(struct pci_dev *__dev, struct msix_entry *ent
>   	if (ret)
>   		return ret;
>   
> -	retain_ptr(dev);
>   	msix_update_entries(dev, entries);
> +	retain_ptr(dev);
>   	return 0;
>   }
>   


I too hit the same issue. The patch above, applied on top of 
next-20250409, resolves the issue.

Thank you.

Tested-by: Srikanth Aithal <sraithal@amd.com>




