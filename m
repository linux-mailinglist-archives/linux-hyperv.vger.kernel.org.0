Return-Path: <linux-hyperv+bounces-2434-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A972908CFE
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 16:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2AC2B21161
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 14:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0386FB1;
	Fri, 14 Jun 2024 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="efEEpRor"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6245E7464;
	Fri, 14 Jun 2024 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374002; cv=fail; b=SPMVq+Hluawhtc/ro2cHBim+8YUpr0VDwbbfHraTV30sbdSPS1B3p1JU/A0TiFJqKnJBQG00clFoiRWliihobMGnBDm2/U/K0Hs9sKUG4yWzFAgJ5bLzE4zBvnWn/Sty6WTm8henSje/SS2VJaBMTe3z55xCQcjddRSTSGv7j5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374002; c=relaxed/simple;
	bh=GVZztyhdyUTnpT12NHFMnS/oZrQHG8Xv6PNO0i++EPo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h4upteTDetfQ+ltV7u8KzoWxfJ/2I1yQIPfZdERqR1rUM2PVWLR6OEQCJ2JZnAFFtHO4HueuYI4ZVioVyJQt8UMSnWpOeE+Yku4PgnpxMUVMTs5kqqRLBAp2XYO/cwzIkESXbNdubIrkKt5dVJKSHKji349zYoAXNjzOR5/oNsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=efEEpRor; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbM6rEdfLGs49kD82BgP7j+LBZG8rH1hhL+M4vK83f7Ay5U/2SL7fzX1ctzVp1kmwN+lOwdd5ddge4PVkojx0ACKsc2GX0VJOE8Hz80sno4HC1d3jdAw9BoO5bONazNtGy/blAiLad9UASfT+juQfk0HlAuAU8cKkmcQHpKvH5JUmi7fijoL3IeQ9sUwOuSTicMh5P1MQsCvxeGvb6gadbLZsgvO8magWQIcOAIphgcsrsz2JOpxaJauu28eXdk7jLVcO7PheX4geQvNIODTr5bFgx2O67C7ElDHQfSx3chvfkeY0V/ZdmhqnsMWZbo3aRgLb4swC7dILMe60+QJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RLh9Anf1ZfoOXtJF0X1Xz9qe+njWPaPngrM3HBY7po=;
 b=ATiaRU4H3RKT7ZPobbBRyUXOd1M0fHnKY7KoYWmaQf1GnAMbtcGSTU1DQ4BlS6ygUkFUh3b4j2tyCh0NnO/UqjOE7nve+L8ssiULPtMEVSQQSC53xKLrHUpX3d7yvAW2KRTGAmXthGsXhzVFUWav5nBKMvVValXwUSINV4XFuQxJrTa2fY3aNVgxzNiUCj0opb+dCGhwP9Jgo4NVhUWswKzWPLxmQaMVv52xZ6kYzF88RwU5u0QBfPFPZUUA9RSvKlifxtv9m2jJqc6j5BHUBOhF9PgSWZGtoXeuivvZRWrNmvkCDUcQmkTp3FWdHIYZrUUUhiyAp6K+B4TwDG5Jcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RLh9Anf1ZfoOXtJF0X1Xz9qe+njWPaPngrM3HBY7po=;
 b=efEEpRorLOkoeAIVomBode5gQBzT4qoYxOtoK+HcEHVL696nLJnAconGHvz1lICBh4zNyHm3SVSJOpd7AYkqfhkiLXolOTEBpCk+TvefHi8Ra/KltcQAf7Pix7/hZU38o23yL1/kxFn0KuJSif/0tIH1hLD3UQzIjXxBp86Gk7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26; Fri, 14 Jun
 2024 14:06:33 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%6]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 14:06:32 +0000
Message-ID: <8efff872-7843-2025-dce2-a5dcdbf31143@amd.com>
Date: Fri, 14 Jun 2024 09:06:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCHv11 18/19] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
To: Borislav Petkov <bp@alien8.de>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 "Kalra, Ashish" <ashish.kalra@amd.com>,
 Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>,
 Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Tao Liu <ltao@redhat.com>
References: <20240528095522.509667-19-kirill.shutemov@linux.intel.com>
 <20240603083930.GNZl2BQk2lQ8WtcE4o@fat_crate.local>
 <icu4yecqfwhmbexupo4zzei4lbe5sgavsfkm27jd6t6gyjynul@c2wap3jhtik7>
 <20240610134020.GCZmcCRFxuObyv1W_d@fat_crate.local>
 <hidvykk3yan5rtlhum6go7j3lwgrcfcgxlwyjug3osfakw2x6f@4ohvo23zaesv>
 <nh7cihzlsjtoddtec6m62biqdn62k3ka5svs6m64qekhpebu5z@dkplwad2urgp>
 <20240611194653.GGZmiprSNzK0JSJL17@fat_crate.local>
 <2kc27uzrsvpevtvos2harqj3bgfkizi5dhhxkigswlylpnogr5@lk6fi2okv53i>
 <20240612092943.GCZmlqh7O662JB-yGu@fat_crate.local>
 <w6ohbffl5wwmralg255ec7nozxksge4z4nnkmwncthxzhuv46d@qq46r2wrjlog>
 <20240613145636.GGZmsIpHn16R04QlaN@fat_crate.local>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240613145636.GGZmsIpHn16R04QlaN@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:806:d3::8) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|PH7PR12MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c11dd07-a9d3-487d-7b32-08dc8c7b31cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzhmd0RoanVqR1F1TC9UWUw3OTNyNFhVbzBlKzNnQjRPdjk1dGx2RlpIS0ZD?=
 =?utf-8?B?MkpKdzBZZnhCMzVZTVlsSDN3YWNlTmV3VVUrTEU1TnVNc0Q4R0FHWXdYTldJ?=
 =?utf-8?B?ZDhxTFg5dnMyUkNLd3QvbkZLVjZIa2Z6QzdHKzRFS0hBdVZ3UlhhZnIvbFcv?=
 =?utf-8?B?cFdYalUzeVVGOE0vMkp2RUwxbVNlTHQyOUViVm1LRURwWTJYaHhYUDNub21p?=
 =?utf-8?B?ZUZLTER6SmdMUG1hYk9hV0NsNk9LU3psVjJ2STRNM3oyZHJobElVZWd0N2U5?=
 =?utf-8?B?OGZNQldUbG1zbDBjejd5bVNBZ05zUUF4S3owOXlhUjhaK0lkTkEwRkxmYVVG?=
 =?utf-8?B?OGZlelR5YlhCOWN2aFhnWGg2NEFuWTFXUHBtR2k3QXBZUExTeUZrWUsxUVdB?=
 =?utf-8?B?U2xzVEhja21pYjNCVWtkS2dibXhWejVtMC9XNlhmdFRiVEJuejJSd0t3SDhR?=
 =?utf-8?B?dFFZMUE1NDVWdno1bTlVek5VWFFJZUQySGhqS1VLTHZBQTRTc2JGcHJnWjNq?=
 =?utf-8?B?TC82TWFuK1cvWGIyMENQUVpqL2lOdTlFTzNXS1JJdERUVVNSSGExNit2Y0hh?=
 =?utf-8?B?em40dERqQldhNG9OSS9KRk9sclRrcDIxR3VyaWViN28zQXRwY2NVd0hNMGNv?=
 =?utf-8?B?THQ4dDVJNlI3YnVBY3U5UnhtQlpoSjlBRFY2ZUowdUNEa0FtMUtkQVVPMU1Z?=
 =?utf-8?B?Zm1VLzR3ZmRMVE9zQXRBTi8yMStqL293MUd0bUdHbXI5MVBtMEF4VUxDeVJk?=
 =?utf-8?B?WFJTVHVXb3VFRVhSZEFsa0RCTlNjNXZFTkxab0tyRlNhZFFKUUdmd01YZitj?=
 =?utf-8?B?U0dYK3c3elBqZ1dHOERtQU5Pb2tkQ204VCsyTGNNSXYrUUN0NzJUaVdhTXQr?=
 =?utf-8?B?MmtlaVRnRWVWd3FmVU95WFBLUTg0dzJRUis0SUdxR3lqR25PQzVGVnNOVG92?=
 =?utf-8?B?UURwMXZLUE8wazQwTVEvRDMrSVpIOWIwSFQ2TEdoL3hFKy9qRkp5UXhqcGZG?=
 =?utf-8?B?Q2hwNTFTQXF2Vnk4aE9URFBQamhpNzlSRE1jV2ZTMzFrdEg2VDNTTUZRUXVi?=
 =?utf-8?B?SDhEdTNnSitNNFJrNzdVZVRXeFpSV2tGOHpIY3JicWhuK1Nia2NKRUxlM3RF?=
 =?utf-8?B?a29XeG1CQmFVdWk0M29BMlVtK05OR0FGOGRWSDdMa3BkUjlibnlUbHQ4cnBm?=
 =?utf-8?B?S3lmSkJ0TksraG1MUlUwcGRISGUvNncrQ3BBUDJBSFRHRC9yamlxcnkyWXNo?=
 =?utf-8?B?ZlJHVmY4MDduZkJPTWkxTk9YbXBlZnJNdEZsS1ltWjhOUFkyYlZzUndmSDk3?=
 =?utf-8?B?Vy9jR3EySVZ5U1ZyWFAzVVE5M3d4SDFoaWdDTEd0TjJrZHNHQkJVWTMvRCty?=
 =?utf-8?B?cVRNaGhiSVRIeDdsanNxM1Jxa041citWVnZzczN5cmI0cWdwQTM2ZnJHam1J?=
 =?utf-8?B?cUxhL1N3L0dsNXhvYkpCeGhBMFVyQUNvaytSeThLQUc2eW9aSzlzc0VmRWh1?=
 =?utf-8?B?NWpkdjZ4RXRlNm1HbGhzMkluN3poYlFDZGZlVytEUDBHV3VqRFNaV2pDeUE4?=
 =?utf-8?B?NGZJcmd2UnNHMEtXZ2pNdGhaZSs1ODhJYmp0UjdTb1R2M0VQVjhlZ3kzVWpk?=
 =?utf-8?B?L1ZTaG9GSEk3SS81cHVaRlRuaGw0TVlLek5meTNTY1hEK0V6WVVocGE3dG5i?=
 =?utf-8?B?SWdzVXZYby91MVVCa3pxWnJuTVR3NGkzUzRQSjYzRU93WWlFYkRGTDRtcTdC?=
 =?utf-8?Q?Pw12QPDGbaHcmvthXiXT5uATeHPPKPSUO4SQWkj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlFQUHZwVStuSmR4b0VmMXBjZys4TXAwRUU0UFVKclh5NXV5WklJMWRxQjFR?=
 =?utf-8?B?K093bExKL09tUDA4bTE3ZHNKVHA4UUR0akQyV2NPUkZ6N1BYdE1Gd2szMW9Z?=
 =?utf-8?B?MjJPbzNNTnQzVk5qRGFPcmpBSVB5MEdlMTBJS3pPL1o4UEpyRlhPVmlWMTdT?=
 =?utf-8?B?Y1duNlFkbEFKU1ByRk4wcWRZNlFOc1E3ekgzalRCL3Y0Qjd0a2xzbFFwWEsx?=
 =?utf-8?B?Mll0a0tDUE1qVHZaY3R3RUhpK3QwNFh5bVpGT1dMOXVyNUhmb2pYOGdxNWhm?=
 =?utf-8?B?NjFXV3pIUnhKNktiTFo5Qk90ZlJyeWFHOTBkVVArbHdjdW1CbEpMMW9vMFFS?=
 =?utf-8?B?Z3NHakdzTWpUT2M5VGUyMHJQYW0wWk9aZUVDRmxRckxEUHBqZEhUeUtOTkFL?=
 =?utf-8?B?YThFbGNQSnpzRkdmckdBb3NKU1RUSmxMZlR6ZDlEcFI3Rkp2OVo1dENvTDg1?=
 =?utf-8?B?d1BwdHR6RTRlaHVpTHYvRGFaRnB4M0hreHFGaWZIMWt6bWxidnMvYU5kTzdh?=
 =?utf-8?B?VXRQdFdXWm1MWVlqbjZmQ1lyV0twSHB5SHpBRXlaRURHOHdXelFMSTBaOUpY?=
 =?utf-8?B?SzlMOEFRV0JLQmtRaXVDREFyQUplcUczZTVlV24xRmRqZ0VieTFLNVRPbi9Z?=
 =?utf-8?B?M0QzbUNLTG1NNndqN1orNlprczAxR0pGbXI0MUJFZ3VyVXJtU1VQZmNEZFZ5?=
 =?utf-8?B?OTcwT0hGWGZHSTBvcU5HMDd2aXBQc2w5ZE5LOXlJNjlVZm9qaHlnQ0JKZS9n?=
 =?utf-8?B?T3NnaXhEM1paS3VScXNmVGEwWjNLL3gzYk56cmlYVWlXRndDMk9WVUVBS2hx?=
 =?utf-8?B?YjBKUno4TTZRNk1OY0p6YVpYbVVad0JHQkpLQkV3empqZlR1aHlxRnZGbHVx?=
 =?utf-8?B?a0QwN05zMG1mS2NRSlVtalNLdVVvYlhNU0xoUVJnVXlHV3VhWW9Ia3lMZ05B?=
 =?utf-8?B?Zi95MzR6S3pHMGVDUmE5TmlZRm5nMzBnT1QzQ2JDNGhmdFVqbW9OaGY4RnhL?=
 =?utf-8?B?VGRjakZGcEpHSStPaXZDUGtPQjBVK2FsWFZrZk9WS0RSWCtPWTlodnVBaXEx?=
 =?utf-8?B?aXZSZUd6UW5PUmphNWdNZWRjTmkyNDk0NktQYmd3MDl5S2pTSFJDTzVTMGNV?=
 =?utf-8?B?ZWlkSVhQV2VxMm8vTkh4aTFOdjlzc3RMUkJTMzQ5OFZ4RElQQzNNUUljNlI5?=
 =?utf-8?B?QVhXRHp4WlplcGlHK0FCbktGSG9VL3BKUGtOcGpCOVVpRXVpc0FlQmlmZ0Fm?=
 =?utf-8?B?bS9Gc3UvVUt0R21wejBEWjg2dzYybE5ZdjJidU1BK2t4ZkhieGFydlRLSlg3?=
 =?utf-8?B?eUI0RWgwdW5VUk1qc2ZCaFYwVmUzL2NsK3pybElUR1R5S3BRSHRDUEg2OEUw?=
 =?utf-8?B?MFBQcWhMUnoyMklLMGJoZk5zZCtZbm1LdmpTYjNFMlZOUEJJcnI4dXBicUZ5?=
 =?utf-8?B?RkQ2K2RoUW5neVJqMmJJQURTMFVGSnk4anMyRmUxQng1NEFzd2JDaU1LMHAy?=
 =?utf-8?B?anJkdndUOVRJQUlEL0w1TU55U0dQQWhHaC9FYlVwSjNoK0d6VFRHTnBteklj?=
 =?utf-8?B?V1lZNFF6N0xCMmxTUE1OeWpwbEkzWnpZZnJEazBDbUdvUDNYNW90dWR2QXRu?=
 =?utf-8?B?MkhYWGIrdkh6ZStJckZWT05yMEtEajVmMXlXUEVVOHhrdEZBTzIrZDRpa3RF?=
 =?utf-8?B?S0hFbW1mUnZPV29YVEgvSzFFK3d2YVRRVjlzMVdqaHNsUnJ0QzVGWjJwM2tm?=
 =?utf-8?B?dlNZd0RBRjVic2V2VFE2c1ZaeTdJelhSVmVnRjB6cHVTYms1T0JWRXJIcS9Y?=
 =?utf-8?B?eWdKaEJsdG0ySUcraWxFMmdQZEpyRkJlRGtBRkJhOHRyaWZjdkVPc2hIMlFq?=
 =?utf-8?B?V0dOQVQzYnR0K204Ukh1L25jNnNsL3R1SWVQRnVpT3RmanBWS2FtdVFHVlYr?=
 =?utf-8?B?VFgzYllMbXFRY096bEJpSXkzRFA5NE5nek42SGNDOU8rTmdtckNGWW4yN00v?=
 =?utf-8?B?YmYxQ1ZZT2JXSGU1TVU1Z3pLTlA1WUFBczI2Kzh1dWNMSWJ5RjlzMFNxK1VL?=
 =?utf-8?B?VlNJdVVNdHpBNjJOL0VQRVdSdks3bXZlQkVrdWNuOVZLSS9XQUxIYkE1aG9T?=
 =?utf-8?Q?/frAGsg28rE+8RL9Ej1A9lIaF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c11dd07-a9d3-487d-7b32-08dc8c7b31cc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 14:06:32.5614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zy+6Qy/Rpf+7zbB4ef6qGf0oK8kp/RSrKQxpBEFZazKmvyrVrwuK+LMezPuOuFTSmbWDHEkyFarxOAzCPwW2LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5805

On 6/13/24 09:56, Borislav Petkov wrote:
> On Thu, Jun 13, 2024 at 04:41:00PM +0300, Kirill A. Shutemov wrote:
>> It is easy enough to do. See the patch below.
> 
> Thanks, will have a look.
> 
>> But I am not sure if I can justify it properly. If someone doesn't really
>> need 5-level paging, disabling it at compile-time would save ~34K of
>> kernel code with the configuration.
>>
>> Is it worth saving ~100 lines of code?
> 
> Well, it goes both ways: is it worth saving ~34K kernel text and for that make
> the code a lot less conditional, more readable, contain less ugly ifdeffery,

Won't getting rid of the config option cause 5-level to be used by default 
on all platforms that support it? The no5lvl command line option would 
have to be used to get 4-level paging at that point.

Thanks,
Tom

> ...?
> 

