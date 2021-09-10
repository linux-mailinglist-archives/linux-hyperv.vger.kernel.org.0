Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DE84073B1
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Sep 2021 01:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbhIJXIF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Sep 2021 19:08:05 -0400
Received: from mail-eopbgr140072.outbound.protection.outlook.com ([40.107.14.72]:6783
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231742AbhIJXIF (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Sep 2021 19:08:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHwOpcNvosBLdN0AYR9CYKEyAMVHK7hqufs5J/FuH6XYf9IlbKlbia3SAQTT2fO3y2mcXBBDkfvusq4/ZsVwt86JQlIZFs7EJt67syk3p78d9TDMlQUOGpvSZDykeqoQjfoLHtQvbCFtG3JmJ9CeextAwwy+peGnxvtfjuO+0HKZOABIrcTCpBFgV+bKPfaOpRueWNSKJW21tTMY469tN0Dx/8/mN1gUxQYn0q3nSggRS8oh8ugRLOhEGJ5gBnIPz3Gwg4gwgJEzyFGRH6jOm/IBN8ib3I9uQVfCOhijPRVXH7IFBvqI+l3z2zeqEMdI+0bcGWP+dFW18ZmA1+gEOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=USMOcNe+e7mKJi1OwIpgvdAMRk45vJxObEWyuY6zBIs=;
 b=gKxqEuqm3ddV0B5hw5xo+Sd3P2L3Ee9Ah38xZI0d+agdmAQVpdTlJxMvaprnad0r/b5HmkvXTkjrei6tF4wMw0dNkFALtMG4gtnA4wQvTMPJZBzatDUgkaX48mmngUJSbYwPytKx0Wv+9vv9O46Y6TgFkkLWUPlD2/P/1OY0HFjrsac93xKd7jHaoa1RC+n0isGgerdEqLZHWLUMi9h5iviRjAc9cHy3YCB9T/lcH443FU/PHjTBRqP2CDhuxyKqwL9qYJgU0UDrSUO6iHRq+y6SgxjQhXwlVRJ5SZBtQtHap9NJJealQ5YHnB7Rs9j13haK5WfQ5hySz9pFH8KTZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USMOcNe+e7mKJi1OwIpgvdAMRk45vJxObEWyuY6zBIs=;
 b=tYrkJyQL817ICVQq2jKpX8BQdb6X+tsDyzrjCTINvwlPiTbS9jk0tRf6p1T++SI8Hls5Snw80M9lLK6hs/L1v61SVQluUCL5zT7TcnlSGvL2XX0EuCzei7SfOANx2mk4c/19mBgLwwB/0qYD7jWA0dnJ6LASR0PLDJhCTeKjY8Q=
Authentication-Results: lists.xenproject.org; dkim=none (message not signed)
 header.d=none;lists.xenproject.org; dmarc=none action=none
 header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB8PR03MB5579.eurprd03.prod.outlook.com (2603:10a6:10:102::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Fri, 10 Sep
 2021 23:06:50 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4500.016; Fri, 10 Sep 2021
 23:06:50 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v2 4/5] mm/page_alloc: place pages to tail in
 __free_pages_core()
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, alexander.h.duyck@linux.intel.com,
        dave.hansen@intel.com, haiyangz@microsoft.com, kys@microsoft.com,
        linux-acpi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, mhocko@kernel.org, mhocko@suse.com,
        osalvador@suse.de, pankaj.gupta.linux@gmail.com,
        richard.weiyang@linux.alibaba.com, rppt@kernel.org,
        sthemmin@microsoft.com, vbabka@suse.cz, wei.liu@kernel.org,
        willy@infradead.org, xen-devel@lists.xenproject.org
References: <20201005121534.15649-5-david@redhat.com>
 <a52dacbe-5649-7245-866f-ceaba44975b5@seco.com>
 <528e8d9c-b148-30ec-d8cc-3dd072eaa7f2@redhat.com>
Message-ID: <c9fc3cc7-2c6e-dc6f-b5f6-0b48fb49aedb@seco.com>
Date:   Fri, 10 Sep 2021 19:06:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <528e8d9c-b148-30ec-d8cc-3dd072eaa7f2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::23) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 23:06:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38f72cd7-d7e4-41de-512c-08d974afabe4
X-MS-TrafficTypeDiagnostic: DB8PR03MB5579:
X-Microsoft-Antispam-PRVS: <DB8PR03MB5579D5B5CFAC5C3B7751606B96D69@DB8PR03MB5579.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dgPMxATIUBWKkjtnSJcBLRqSTjR8V9XA20NFl0HYfunMNVK0Rg/33OR8bITBQPRl49glEWx4GHGwJt8e+NJk5xv7YsXE9zXQhw1AdHrMA0AX1MlP7tRamOnzVxwXqFsLAvIUfzJZIGWiTvodJ4Pqo1a54t79alOYBRtNGYD/bI43j8YJQHL5cr3wtrgVR4mInpLrTq4S9ROQhy7KZOKL9ANgghaOYXrotJnwMCv0HrBILYKQrlsxltVk7DPk6AV+QA0aL++fMune03ZleEMQJIEQJYgRpHckM1ltJgIr0cJ/fTpk35EvotfGbUv6Hsb7xJCj+gasfQmMcYb2FrT8zj06xDjKmE+PxAXlUT1aDvnsruVsbLzj4SYth9pSVeR2LU2/bPaPM9KOHVZHLR/hEXNteqJVEtiCJJ0lIr3iVgwuoAb/8dHJml9hHRFa0P+q9LrI4CX1KpG3mXm32fs6a38YrTLodZv8IP4MqbfEHl/gqu1bZ1N2qpEaxzZLlYo5U3kBzCnUflLcMcdih7kNIetZAPQPBAPTOL4JyAvi+LwsXJJxjPrG8SPgCmYzbUc0Ay1YPb92lRu+ac1xXNNL9h9lbJA4T2IZSy+DYWEs9qMwoWbfnaa12ISWCwwCqx0CQz/bwvUqV73GfqYxLPeGSER7q+klKvKHPaGmbULLu0Lq6MzbHjOFZUJesYDQEtYPh9IAQ66Rlj/wICDX8MKrvy/I0GGEA5Z5Jd81pR6KmyBWgY1l1nO7zj1Q/OphklWJY8itcJ1jy14hi2EX/IcRMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(366004)(396003)(346002)(136003)(376002)(16576012)(36756003)(83380400001)(6666004)(316002)(44832011)(5660300002)(86362001)(6486002)(38100700002)(38350700002)(186003)(7416002)(2906002)(2616005)(31686004)(66476007)(52116002)(66556008)(956004)(4326008)(6916009)(66946007)(8936002)(31696002)(26005)(53546011)(8676002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWRHMDRESVNSSytiT21hNFpFYXk0UE5jZmdtNlplNzdwVjJoOVZyVC8yMXZ5?=
 =?utf-8?B?UXpKeFhVckRTZFlzU2Zaa0lQUmdTbU0za093a2l3c1BKVnpVTDdVVVFPY3F6?=
 =?utf-8?B?dHJVeERUclcyRVI0cFZ2bmIwWitCN0RiendMaU85L3pJMHVVK0xPZjUvdkxq?=
 =?utf-8?B?TEV1UXEvUDg0djZUdFdDdGxiblN4ejNUMURVRkNHREpsMytqOVo3bkJpaFl2?=
 =?utf-8?B?S3NBcFRTZjV0eDNGMWhaK2MzMktUT1RsS3NBa1RYenJ6V3UrSEVZMlFXZXNI?=
 =?utf-8?B?UlZTWWlTVkVxenBoOTYzR3BHTzBLRnJaK3hqSGE3Q2ZjTThzTVMvb2kzanRP?=
 =?utf-8?B?VHE5WHV0UXpRRk9aRXFyR28ybHFvSTNEeFNZbG5vMFN5VytYSGRyaUd4MG5k?=
 =?utf-8?B?bFNPTHpxc0FlVVZHMDYyMGhDU3YrMU1XeTJzNFNSeUtjOHI0NWpHandNV1l4?=
 =?utf-8?B?RGpVVzh6L3ZsMzdsR0RDeGMwcmJuQ0tLYU9hc2t6UG5ZNmNGc1p2ZUx3LzQ0?=
 =?utf-8?B?MGNBN0hxRWx6RTdFMTVTWHpVSDlpR3c1RXYyR0lJRjg5R3hKSDQ1dDZqZ0Iv?=
 =?utf-8?B?Ums2NTluTXViWXMvMnU0MGNaZDJEU2JXM0FjK3AwZW5qelREcVIyV2xkUVlG?=
 =?utf-8?B?RDVWYnlKQ0x5OWFybDdITTdCalRodmJHREtnbzFibW5EWHJpQ1pKWTZSeEJp?=
 =?utf-8?B?L3Rtb0VEUHlOeC82VzFCSWJ6aC83MWoxVGxmMGFTSVJKZng3L1pnWTVRTEw5?=
 =?utf-8?B?bVNTSlZweEFxTUloRitaWkVsNXllaTRBSUZUbFFNaEZNb21kQ0k5SmM3NU5B?=
 =?utf-8?B?eFBWenBQLzh1TGt3cHBQdEdyTE5BTDI4a1lMZXo3VWpEWlExcWl1WnRDcExC?=
 =?utf-8?B?VWI3djcwMFVFY1ByS3VRNGFXZUUyNXRaL1dUNDRjTmNONmJlS2JlQUwwOElu?=
 =?utf-8?B?MTRObStuOHZ2dTNlcWp2OElab2Q4WUpiUFFSQUpRemVsYXVzT0lXZmJxelJF?=
 =?utf-8?B?SnFpZGs5em1LYUl0bGpGeDdqMFJvOGlwUlI4VnRBV1docjhVR25mMmhZeVNu?=
 =?utf-8?B?bHg2aFdlUmcyc0xEU0JvVmtqb3BmQjNzRTNPbFAxUDlYREh0NVhaZTRZQTNT?=
 =?utf-8?B?eXI0TnprWHhYdzlzRHJSMitMYm9LdXpiMXhZMnRwUk1DdUFnOE5FaWFKNDkz?=
 =?utf-8?B?Rm1yYyt5VzZKYzNZc3kyTHUwaFhhNEFIUWxvem0xemlYZUV2eHAreTR1dXVQ?=
 =?utf-8?B?cSt5WHRObG5vMmhBOGIxQ2RBRHRaczMwQlVNNk9TNFl5QmVDRlRsTGpLY1Y1?=
 =?utf-8?B?VHIyakR2S2d0RFA5WDZFNitWZEtlZ1VTOWJuOXRoQTB2T1NjWlRUcFFwRGs5?=
 =?utf-8?B?NkUyTjZ1eUpVWXE3OGRFVVkrWURhQ3FjSUtGTW4xS29xOENsdzhRdmFxZlhx?=
 =?utf-8?B?b2Ira0NqaXhCUENzQTFGaHpBamxhWVdsN3Q0cEtlcDhzS2UxNSt1a0hFeDJp?=
 =?utf-8?B?Z1BPb2R6aVl6QllwVDZQaUpKaUpXcUZ3eCtkWHBmeDFXUnk0RVhPczViRVZR?=
 =?utf-8?B?QURLN21ERm9rNGNUWnhDQTY4QkVqVXFUTWdpSmRra0syWmxpRWR4WTN6N0Mv?=
 =?utf-8?B?amtNdzQ2ZERHNGNYbnZ1Q2xzdzhDbTBmckQ4YmIzMFB1YWptVEE1U1lDcHY3?=
 =?utf-8?B?WmFBeENnSC9DNDZvUis5Rk1Tc2RRcUpSQ0o2SlQwbEpxU1RmSTF5SlM5REo4?=
 =?utf-8?Q?WwqSazMKMnjTRQ1Im2uSH8rhGtT1qj0FrPlDTTG?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f72cd7-d7e4-41de-512c-08d974afabe4
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 23:06:50.3430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAEtbieFv3pp+KYRe9L7bgGRa+/tF4lDZiYdXyXHPuNccYtL4Tz4ZAMytYTIkOp9Q2FX+0I6eEvCAoa8Ta/Bew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5579
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 9/8/21 2:21 AM, David Hildenbrand wrote:
> On 08.09.21 00:40, Sean Anderson wrote:
>> Hi David,
>>
>> This patch breaks booting on my custom Xilinx ZynqMP board. Booting
>> fails just after/during GIC initialization:
>>
>> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
>> [    0.000000] Linux version 5.14.0 (sean@plantagenet) (aarch64-linux-gnu-gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #251 SMP Tue Sep 7 18:11:50 EDT 2021
>> [    0.000000] Machine model: xlnx,zynqmp
>> [    0.000000] earlycon: cdns0 at MMIO 0x00000000ff010000 (options '115200n8')
>> [    0.000000] printk: bootconsole [cdns0] enabled
>> [    0.000000] efi: UEFI not found.
>> [    0.000000] Zone ranges:
>> [    0.000000]   DMA32    [mem 0x0000000000000000-0x00000000ffffffff]
>> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000087fffffff]
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000007fefffff]
>> [    0.000000]   node   0: [mem 0x0000000800000000-0x000000087fffffff]
>> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000087fffffff]
>> [    0.000000] On node 0, zone Normal: 256 pages in unavailable ranges
>> [    0.000000] cma: Reserved 1000 MiB at 0x0000000041400000
>> [    0.000000] psci: probing for conduit method from DT.
>> [    0.000000] psci: PSCIv1.1 detected in firmware.
>> [    0.000000] psci: Using standard PSCI v0.2 function IDs
>> [    0.000000] psci: MIGRATE_INFO_TYPE not supported.
>> [    0.000000] psci: SMC Calling Convention v1.1
>> [    0.000000] percpu: Embedded 19 pages/cpu s46752 r0 d31072 u77824
>> [    0.000000] Detected VIPT I-cache on CPU0
>> [    0.000000] CPU features: detected: ARM erratum 845719
>> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1033987
>> [    0.000000] Kernel command line: earlycon clk_ignore_unused root=/dev/mmcblk0p2 rootwait rw cma=1000M
>> [    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
>> [    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
>> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
>> [    0.000000] software IO TLB: mapped [mem 0x000000003d400000-0x0000000041400000] (64MB)
>> [    0.000000] Memory: 3023384K/4193280K available (4288K kernel code, 514K rwdata, 1200K rodata, 896K init, 187K bss, 145896K reserved, 1024000K cma-reserved)
>> [    0.000000] rcu: Hierarchical RCU implementation.
>> [    0.000000] rcu:     RCU event tracing is enabled.
>> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
>> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
>> [    0.000000] GIC: Adjusting CPU interface base to 0x00000000f902f000
>> [    0.000000] Root IRQ handler: gic_handle_irq
>> [    0.000000] GIC: Using split EOI/Deactivate mode
>>
>> and I bisected it to this patch. Applying the following patch (for 5.14)
>> fixes booting again:
>
> Hi Sean,
>
> unfortunately that patch most likely (with 99.9999% confidence) revealed another latent BUG in your setup.

I suspected as much; however even after inspecting this patch I was
unsure what I should investigate further.

>
> Some memory that shouldn't be handed to the buddy as free memory is getting now allocated earlier than later, resulting in that issue.
>
>
> I had all different kinds of reports, but they were mostly
>
> a) Firmware bugs that result in uncached memory getting exposed to the buddy, resulting in severe performance degradation such that the system will no longer boot. [3]
>
> I wrote kstream [1] to be run under the old kernel, to identify these.
>
> b) BUGs that result in unsuitable memory getting exposed to either the buddy or devices, resulting in errors during device initialization. [6]
>
> c) Use after free BUGs.
>
> Exposing memory, such as used for ACPI tables, to the buddy as free memory although it's still in use. [4]
>
> d) Hypervisor BUGs
>
> The last report (heavy performance degradation) was due to a BUG in dpdk. [2]
>
>
> What the exact symptoms you're experiencing? Really slow boot/stall? Then it could be a) and kstream might help.

Well, as it turns out DDR chips of half the correct size were installed.
This caused the upper half of memory to alias to the lower half. As it
happened, due to some lucky circumstances this didn't initially cause
problems. Sorry for the noise.

--Sean
