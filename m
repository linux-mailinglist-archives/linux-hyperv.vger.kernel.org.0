Return-Path: <linux-hyperv+bounces-404-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0612A7B5A9F
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 20:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8D54A282783
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 18:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C771F163;
	Mon,  2 Oct 2023 18:59:16 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E473F1DA28
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Oct 2023 18:59:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121C5B3;
	Mon,  2 Oct 2023 11:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kr2kvUaM+4aMhYae1fho6hChbajWKuJT250N7BAbgavacrpwweOBa+tfnjnhCwBdNONCyHyOOMMnhc7aPf8ya3LNDZAdNX1B0Ra5oh9znMg06nuQJmQK8LJlHbjpR4ZBv2IqEUAzd9Yezd9wYh8d7VPqjk7frnEPmj0KUzPUo5QyxHUGR37rBw4kXQu+PW8jzsaQPxlPHvdiNAOSTWS2Wu+MeGR9e9BK3HhZvmBQcLaBFkwOjYsN+z4Z6WajxrB34qqGJ4pPu0K/EHQIK7GWBXuwN04fSnhZq+IgzBJN5YvnNTIZ0uJmltYcFsR5SH6ohkiQ7tr9clWoz4EUxWY4Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dh3wosvNJ4p+jJnEsedCSQ4m4RFteE0XA1swHTte20k=;
 b=hOgLusTaMyTixBjIQdMhf0UhLM/hHmGn00KR/grpI2LgQDhEyqavObntyROcv3Jw+1mmAM8VjGyyIDAXRcgLbTZkDyJNfpKgKL0iPsKZnmNZlqgfDdmMigAOZHDTjVaXPzX42FeqeKFX5J18IEWnO8slnhjSo7udQGICWLRxt7WVsgYjLNY2H3nusbA48Nq0tPfOybouDps9m9K77GD51cVPmFRq+VTKY6piEtEQzrRzj8q9M2rk47A/m0tQAzH8ieB4iv/Ybjr+V/w85OxlPzmFL5DqcGWV5oe2v1kvcrOS5mXT6Fmwt3R6SEUioZ9OIl/LsM2JFLwGzuKYYQTTpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dh3wosvNJ4p+jJnEsedCSQ4m4RFteE0XA1swHTte20k=;
 b=l1WHuJtTeSnBnx/OUl4e9U2o7C5cNMCajl09e+WE8U5yuKXZ8MRdU+tmhR89VNegGw3Ah8COHbMDh6eb2M5hEpyeIJdkqtnXXhTo/HCClqehRgvOlJ2/4KGKRCd8wVmR6hwxzGedzNtntRazuwyK04zFdUFw3o/XTnc6IS1yHT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BL0PR12MB4946.namprd12.prod.outlook.com (2603:10b6:208:1c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 2 Oct
 2023 18:59:06 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2b54:7ddf:9e2e:751c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2b54:7ddf:9e2e:751c%3]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 18:59:06 +0000
Message-ID: <2edc7c71-935e-0185-e547-587170a054ff@amd.com>
Date: Mon, 2 Oct 2023 13:59:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/5] x86/mm: Mark CoCo VM pages not present while changing
 encrypted state
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
To: Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
 peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
 kirill.shutemov@linux.intel.com, seanjc@google.com,
 rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, x86@kernel.org
References: <1696011549-28036-1-git-send-email-mikelley@microsoft.com>
 <1696011549-28036-4-git-send-email-mikelley@microsoft.com>
 <c9a06bd0-09aa-5e4b-e2cb-63ebcc93757e@amd.com>
In-Reply-To: <c9a06bd0-09aa-5e4b-e2cb-63ebcc93757e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:806:f2::8) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|BL0PR12MB4946:EE_
X-MS-Office365-Filtering-Correlation-Id: 782f0f0d-7b38-4ff5-0d63-08dbc379a6ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vvEFzPeIjnri6ucDLC8e0bvDkDqfAA6V8VK/RDzZTf3VWj8V7ETZ/iwvk1K8yD6DFQpOH9WuplLrUwgsmN38yMW7cF6/VWxXz6GVbGwhp3vG5qlCTtbWK0pnVzm10FnzvN2ErzYRIGMdFbGyHtxFzXHu1qV1pczpEAmZsxbXptMzxeAOFs50UW+hrHe4vm0SHfVBpDPBtFBNeNtEJyyhOc6/tRCjyHFJwavLUQLWa+YTHKJboaALHvWGrDPlU/7eAeK676zLOVEUd+anChszR4fZKMAl0OXyramnChcgdFasV0nAJ4BDaSYlv0ToSnmz/DvhVFlBpKGyCC36quwEZGzuQxIO+/C95paVzaEYmCzdKNj8JE0Vnz84C6+sbjMTjM29HoMYJKHm7G9rDxiF6+ZHyrkmAxdCUERuVb036PK+bEFDpzgDWbAquxzpq5MBefVNog4DlXLC3wxUPRD2yhi9eg3QDWSbVlBKvfUvJDvkGxST62FxPzal1JAPW4bL+JRirKZsJpBlCYe0hToBV4E04utYILde8y/onhHWBHftEaxnvZrgYNd9ZhIyM1KE2SoXyJni/2nlS2QjLCZr7icasYSrm9TSXYj8dEwlPR0B+DKWmWrXirxM8SUa9Bar8tsMLg1h1aEptVEqZHlnP586Wh5BGeuQJnSSHBga2ME=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(45080400002)(53546011)(6486002)(6506007)(6512007)(83380400001)(478600001)(316002)(66946007)(66476007)(41300700001)(31686004)(6666004)(66556008)(2616005)(26005)(36756003)(2906002)(86362001)(921005)(31696002)(5660300002)(38100700002)(8676002)(8936002)(30864003)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2N6emtUY0t6azliV2NSMytRTmNwRDloellDaFhweDhqT1hwQWt0LytHK3dQ?=
 =?utf-8?B?T3FtSEIyOStmREEwRWdqMW5JdThWNWZLWTN3M1o5YjBQTHBqMk9RVGU0bzJr?=
 =?utf-8?B?dXN3N292ZEJyaGxvYytZb2VUclAzUFMzV3RDQnZNL3dMNzVrbGg0c3VuZlRK?=
 =?utf-8?B?MmtJQ01zQXI4S25YMHpLUlpwTFFEUWZWSE15bklNR2wyRTlJVER0Si9uT0NB?=
 =?utf-8?B?Q05udWFWZkg3QnU0OEhFanBZNWR0QkpnQ0J0N1VseHVJUGI2dnArT0hsVFB5?=
 =?utf-8?B?QVRPR1lUMitCZ0RGaFd4aUozTXlSRHphaEdyQjFmN3ZVZWE0U1VJaVUwcU10?=
 =?utf-8?B?K05MV2Z6enpUT3BvTU1KTm9vYWFXbmd2TDNzUlpjZWtGeWZOYkhKQjVvM0k2?=
 =?utf-8?B?SE5tMGF2SmF6K0U4T3hlMkZadzhIKy9OakpieTAvVlludXhTQ3pKQVQ5OEFQ?=
 =?utf-8?B?VmNDcVByZkVxQW52bUtLOEZpeXN6aVp1bVNJejBPMjVsOGVKMDdmOWYrWTY5?=
 =?utf-8?B?elIwT3pYYmg0RlBveDZWUXM1aFpTOU5PQVd1R3JZWkRJQUI5MUd1L2I0VWRM?=
 =?utf-8?B?K1gvRElVRTFubHpRZGhIUXFCcmc3R3UyNXlweGZxYWJocnpGNy9wQkdHQlZI?=
 =?utf-8?B?L1NvVjRzNDFiY0RLNTF0eCtKeXBmSDM3Q0hXUkRuSzZtamhQK3AzbnUyTlYw?=
 =?utf-8?B?MXgzQm5qM01UclgwUmpvclEwTjFwUUZ1TE5vQ1Q1TEMzOXdueUgzWFBhUzlo?=
 =?utf-8?B?bzA0K3dLbHRxTk9YT28zVVliVTNvSmhKZ1ExUHBHcWRjcU9laEQvQ1cwUkNI?=
 =?utf-8?B?STBVeks4ZDM5dEo2bHFqNXdhNERKdkpLVmF1TVFBU1JCUVZhcWtxZ3hqL0FT?=
 =?utf-8?B?azdUbXdPRTNlNGhlWlc5RS9SZ0NXMzl4aWNJdk5LSmQ0VE1ONUhLb0YwWitB?=
 =?utf-8?B?Vk9Qam9SVXQvRWhFZUlPQ0VYdWgwaUZvQ2EySDdvM1lmY3I3bkJUUmg1SFMr?=
 =?utf-8?B?bXByMEVSNVQ3K2lvNWRVYS8zeEIxUEFNcnQ1WkNzTmR1VDhNTUI2OWkrOWxN?=
 =?utf-8?B?RitFMHdWY2h5a1RQQ1dtM0o2cFhVQTJSRk1ERWFRYTY5RGFQa1RvYStVSnRJ?=
 =?utf-8?B?N3V4VW9OdVZUeEhlMVhJcHYwRStWNGg3K1lDeDFNNXhjemJPTm5TREVGQnZN?=
 =?utf-8?B?bTFLc2gwZWEraHlGTVZRck1yM05LU1NZbDF5bDluN24wWXp6Z1F3TEZlMDI1?=
 =?utf-8?B?WUVVM012LzFkSjBjTHF4S054WHVrbnl0R0lJK3Z2M3VKQmt0Wm9jTXg5dCta?=
 =?utf-8?B?Rmo3dVFrZnQzUVQ5OS9Xa2NGZWJDbG1ETjRBaGkxS25QTiticTQxcldFZHRW?=
 =?utf-8?B?dnVLWkRVZ0ZnS2lvNFBiVU1TL0gzVnBMK20wNTBlWmVvekdndDRWRFFET3Iv?=
 =?utf-8?B?K0lTNWJ0RXlmNXFqZWhvUTkwMlpUK1c3NzBuMXI0eHhIdzUwdzJOOGowOFpC?=
 =?utf-8?B?OWR5WmtINHZnUXU0My9kbWozZkZQQWVPQWJLdExDWDR4ZGdHUFY1QlY2MjhJ?=
 =?utf-8?B?aWprdVJlM1U4WUNCL3d5dU1XWE9lTGRvdWp5Q3Q5bU5WRFM1QWFSNkRhcTlZ?=
 =?utf-8?B?TitXRjZpNjJ4MG5jaFlSNWJBZ3VBd20zSmc0cWFUcjRzRjVPbG1lZmorVFpB?=
 =?utf-8?B?WXhjcEhiVHJ4M3FiQURWYldzTDk1VFkwa2FDNlo3VmZFZnZldFVkMndjK1I3?=
 =?utf-8?B?akVuTmVOSXJJVUY2aWtiZnoyNjh4Q1cvYTVhQzNXL2ZBMmJiTDN5ZWxNNEla?=
 =?utf-8?B?SmFsMXhBbDF6aUg5ZnplZER6RTBYRlZOUXFFQ0Fmc0V5WitnY1BSRStpWWgx?=
 =?utf-8?B?aVVmUTR0eTdiMlVzdWM4dGtEVDBHQ09mcDlGSGZ6TDI2L1psMjk2WndxZGp0?=
 =?utf-8?B?TUF2WWdSb244bVdiS21qbS9ZcnNoZ3krT1hTeGNuT05zOHF3WU9KbUNGNzRi?=
 =?utf-8?B?TG40RXM1NkJadlM1MGxveElKN0ExRis4OFZ2cnFkRWhLcmJKU0ttVkZEaHRG?=
 =?utf-8?B?eWxXdlMyeWhvc29QS01Nb2lnN0p1TE5sbjJoMmVjaEJ3cEpDcmhwWVMvbUVQ?=
 =?utf-8?Q?S+HeLl6qjCaLf0LL0G4k14wi6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782f0f0d-7b38-4ff5-0d63-08dbc379a6ca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 18:59:06.2049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQWN6MjGiZqQjhfAQ4gxGJ2I4NzgZnyMfLbR6slgtw3ZeJaO5NqgEzKRZ9VarNbw1uZANeZRv1QLUVAfWbsCXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4946
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/2/23 11:35, Tom Lendacky wrote:
> On 9/29/23 13:19, Michael Kelley wrote:
>> In a CoCo VM when a page transitions from encrypted to decrypted, or vice
>> versa, attributes in the PTE must be updated *and* the hypervisor must
>> be notified of the change. Because there are two separate steps, there's
>> a window where the settings are inconsistent.  Normally the code that
>> initiates the transition (via set_memory_decrypted() or
>> set_memory_encrypted()) ensures that the memory is not being accessed
>> during a transition, so the window of inconsistency is not a problem.
>> However, the load_unaligned_zeropad() function can read arbitrary memory
>> pages at arbitrary times, which could access a transitioning page during
>> the window.  In such a case, CoCo VM specific exceptions are taken
>> (depending on the CoCo architecture in use).  Current code in those
>> exception handlers recovers and does "fixup" on the result returned by
>> load_unaligned_zeropad().  Unfortunately, this exception handling can't
>> work in paravisor scenarios (TDX Paritioning and SEV-SNP in vTOM mode).
>> The exceptions need to be forwarded from the paravisor to the Linux
>> guest, but there are no architectural specs for how to do that.
>>
>> Fortunately, there's a simpler way to solve the problem by changing
>> the core transition code in __set_memory_enc_pgtable() to do the
>> following:
>>
>> 1.  Remove aliasing mappings
>> 2.  Flush the data cache if needed
>> 3.  Remove the PRESENT bit from the PTEs of all transitioning pages
>> 4.  Set/clear the encryption attribute as appropriate
>> 5.  Flush the TLB so the changed encryption attribute isn't visible
>> 6.  Notify the hypervisor of the encryption status change
> 
> Not sure why I didn't notice this before, but I will need to test this to 
> be certain. As part of this notification, the SNP support will issue a 
> PVALIDATE instruction (to either validate or rescind validation to the 
> page). PVALIDATE takes a virtual address. If the PRESENT bit has been 
> removed, the PVALIDATE instruction will take a #PF (see comments below).

Yes, this series results in a #PF booting an SNP guest:

[    0.807735] BUG: unable to handle page fault for address: ffff88803bef7000
[    0.807829] #PF: supervisor read access in kernel mode
[    0.807829] #PF: error_code(0x0000) - not-present page
[    0.807829] PGD 8000004c01067 P4D 8000004c01067 PUD 8000004c02067 PMD 80001001f8063 PTE 8007ffffc4108062
[    0.807829] Oops: 0000 [#1] PREEMPT SMP NOPTI
[    0.807829] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.6.0-rc3-sos-testing #1
[    0.807829] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
[    0.807829] RIP: 0010:pvalidate_pages+0x99/0x140
[    0.807829] Code: 48 09 ca 0f b6 4c c7 0f 48 09 d6 0f b6 54 c7 0e 48 c1 e6 0c 4c 21 de 83 e2 f0 80 fa 10 4a 8d 2c 16 0f 94 c2 48 89 e8 83 e1 01 <f2> 0f 01 ff 41 89 c4 72 6
1 83 f8 06 75 45 84 c9 74 41 48 01 de 48
[    0.807829] RSP: 0000:ffffffff82803bd0 EFLAGS: 00010246
[    0.807829] RAX: ffff88803bef7000 RBX: ffff888000200000 RCX: 0000000000000000
[    0.807829] RDX: 0000000000000000 RSI: 000000003bef7000 RDI: ffffffff82803c40
[    0.807829] RBP: ffff88803bef7000 R08: 0000000000000000 R09: 0000000000000000
[    0.807829] R10: ffff888000000000 R11: 000000ffffffffff R12: 0000000000000040
[    0.807829] R13: 0000000000000020 R14: ffffffff82803e48 R15: ffff88803bf37000
[    0.807829] FS:  0000000000000000(0000) GS:ffff88846fc00000(0000) knlGS:0000000000000000
[    0.807829] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.807829] CR2: ffff88803bef7000 CR3: 000800000382e000 CR4: 00000000003506f0
[    0.807829] Call Trace:
[    0.807829]  <TASK>
[    0.807829]  ? __die+0x1f/0x70
[    0.807829]  ? page_fault_oops+0x81/0x150
[    0.807829]  ? srso_return_thunk+0x5/0x5f
[    0.807829]  ? kernelmode_fixup_or_oops+0x84/0x110
[    0.807829]  ? exc_page_fault+0xa8/0x150
[    0.807829]  ? asm_exc_page_fault+0x22/0x30
[    0.807829]  ? pvalidate_pages+0x99/0x140
[    0.807829]  __set_pages_state+0x280/0x2b0
[    0.807829]  set_pages_state+0x4e/0xa0
[    0.807829]  amd_enc_status_change_finish+0x4a/0x80
[    0.807829]  __set_memory_enc_dec+0xe1/0x190
[    0.807829]  mem_encrypt_init+0x15/0xc0
[    0.807829]  start_kernel+0x31b/0x5e0
[    0.807829]  x86_64_start_reservations+0x14/0x30
[    0.807829]  x86_64_start_kernel+0x79/0x80
[    0.807829]  secondary_startup_64_no_verify+0x16b/0x16b
[    0.807829]  </TASK>
[    0.807829] Modules linked in:
[    0.807829] CR2: ffff88803bef7000
[    0.807829] ---[ end trace 0000000000000000 ]---
[    0.807829] RIP: 0010:pvalidate_pages+0x99/0x140
[    0.807829] Code: 48 09 ca 0f b6 4c c7 0f 48 09 d6 0f b6 54 c7 0e 48 c1 e6 0c 4c 21 de 83 e2 f0 80 fa 10 4a 8d 2c 16 0f 94 c2 48 89 e8 83 e1 01 <f2> 0f 01 ff 41 89 c4 72 6
1 83 f8 06 75 45 84 c9 74 41 48 01 de 48
[    0.807829] RSP: 0000:ffffffff82803bd0 EFLAGS: 00010246
[    0.807829] RAX: ffff88803bef7000 RBX: ffff888000200000 RCX: 0000000000000000
[    0.807829] RDX: 0000000000000000 RSI: 000000003bef7000 RDI: ffffffff82803c40
[    0.807829] RBP: ffff88803bef7000 R08: 0000000000000000 R09: 0000000000000000
[    0.807829] R10: ffff888000000000 R11: 000000ffffffffff R12: 0000000000000040
[    0.807829] R13: 0000000000000020 R14: ffffffff82803e48 R15: ffff88803bf37000
[    0.807829] FS:  0000000000000000(0000) GS:ffff88846fc00000(0000) knlGS:0000000000000000
[    0.807829] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.807829] CR2: ffff88803bef7000 CR3: 000800000382e000 CR4: 00000000003506f0
[    0.807829] Kernel panic - not syncing: Fatal exception
[    0.807829] ---[ end Kernel panic - not syncing: Fatal exception ]---


Thanks,
Tom

> 
>> 7.  Add back the PRESENT bit, making the changed attribute visible
>>
>> With this approach, load_unaligned_zeropad() just takes its normal
>> page-fault-based fixup path if it touches a page that is transitioning.
>> As a result, load_unaligned_zeropad() and CoCo VM page transitioning
>> are completely decoupled.  CoCo VM page transitions can proceed
>> without needing to handle architecture-specific exceptions and fix
>> things up. This decoupling reduces the complexity due to separate
>> TDX and SEV-SNP fixup paths, and gives more freedom to revise and
>> introduce new capabilities in future versions of the TDX and SEV-SNP
>> architectures. Paravisor scenarios work properly without needing
>> to forward exceptions.
>>
>> With this approach, the order of updating the guest PTEs and
>> notifying the hypervisor doesn't matter. As such, only a single
>> hypervisor callback is needed, rather one before and one after
>> the PTE update. Simplify the code by eliminating the extra
>> hypervisor callback along with the TDX and SEV-SNP code that
>> handles the before and after cases. The TLB flush callback is
>> also no longer required and is removed.
>>
>> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
>> ---
>>   arch/x86/coco/tdx/tdx.c       | 66 
>> +------------------------------------------
>>   arch/x86/hyperv/ivm.c         |  6 ----
>>   arch/x86/kernel/x86_init.c    |  4 ---
>>   arch/x86/mm/mem_encrypt_amd.c | 27 ++++--------------
>>   arch/x86/mm/pat/set_memory.c  | 55 +++++++++++++++++++++++-------------
>>   5 files changed, 43 insertions(+), 115 deletions(-)
>>
>> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
>> index 3e6dbd2..1bb2fff 100644
>> --- a/arch/x86/coco/tdx/tdx.c
>> +++ b/arch/x86/coco/tdx/tdx.c
>> @@ -676,24 +676,6 @@ bool tdx_handle_virt_exception(struct pt_regs 
>> *regs, struct ve_info *ve)
>>       return true;
>>   }
>> -static bool tdx_tlb_flush_required(bool private)
>> -{
>> -    /*
>> -     * TDX guest is responsible for flushing TLB on private->shared
>> -     * transition. VMM is responsible for flushing on shared->private.
>> -     *
>> -     * The VMM _can't_ flush private addresses as it can't generate PAs
>> -     * with the guest's HKID.  Shared memory isn't subject to integrity
>> -     * checking, i.e. the VMM doesn't need to flush for its own 
>> protection.
>> -     *
>> -     * There's no need to flush when converting from shared to private,
>> -     * as flushing is the VMM's responsibility in this case, e.g. it must
>> -     * flush to avoid integrity failures in the face of a buggy or
>> -     * malicious guest.
>> -     */
>> -    return !private;
>> -}
>> -
>>   static bool tdx_cache_flush_required(void)
>>   {
>>       /*
>> @@ -776,30 +758,6 @@ static bool tdx_enc_status_changed(unsigned long 
>> vaddr, int numpages, bool enc)
>>       return true;
>>   }
>> -static bool tdx_enc_status_change_prepare(unsigned long vaddr, int 
>> numpages,
>> -                      bool enc)
>> -{
>> -    /*
>> -     * Only handle shared->private conversion here.
>> -     * See the comment in tdx_early_init().
>> -     */
>> -    if (enc)
>> -        return tdx_enc_status_changed(vaddr, numpages, enc);
>> -    return true;
>> -}
>> -
>> -static bool tdx_enc_status_change_finish(unsigned long vaddr, int 
>> numpages,
>> -                     bool enc)
>> -{
>> -    /*
>> -     * Only handle private->shared conversion here.
>> -     * See the comment in tdx_early_init().
>> -     */
>> -    if (!enc)
>> -        return tdx_enc_status_changed(vaddr, numpages, enc);
>> -    return true;
>> -}
>> -
>>   void __init tdx_early_init(void)
>>   {
>>       struct tdx_module_args args = {
>> @@ -831,30 +789,8 @@ void __init tdx_early_init(void)
>>        */
>>       physical_mask &= cc_mask - 1;
>> -    /*
>> -     * The kernel mapping should match the TDX metadata for the page.
>> -     * load_unaligned_zeropad() can touch memory *adjacent* to that 
>> which is
>> -     * owned by the caller and can catch even _momentary_ mismatches.  Bad
>> -     * things happen on mismatch:
>> -     *
>> -     *   - Private mapping => Shared Page  == Guest shutdown
>> -         *   - Shared mapping  => Private Page == Recoverable #VE
>> -     *
>> -     * guest.enc_status_change_prepare() converts the page from
>> -     * shared=>private before the mapping becomes private.
>> -     *
>> -     * guest.enc_status_change_finish() converts the page from
>> -     * private=>shared after the mapping becomes private.
>> -     *
>> -     * In both cases there is a temporary shared mapping to a private 
>> page,
>> -     * which can result in a #VE.  But, there is never a private 
>> mapping to
>> -     * a shared page.
>> -     */
>> -    x86_platform.guest.enc_status_change_prepare = 
>> tdx_enc_status_change_prepare;
>> -    x86_platform.guest.enc_status_change_finish  = 
>> tdx_enc_status_change_finish;
>> -
>> +    x86_platform.guest.enc_status_change_finish  = tdx_enc_status_changed;
>>       x86_platform.guest.enc_cache_flush_required  = 
>> tdx_cache_flush_required;
>> -    x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
>>       /*
>>        * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
>> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
>> index 084fab6..fbe2585 100644
>> --- a/arch/x86/hyperv/ivm.c
>> +++ b/arch/x86/hyperv/ivm.c
>> @@ -550,11 +550,6 @@ static bool hv_vtom_set_host_visibility(unsigned 
>> long kbuffer, int pagecount, bo
>>       return result;
>>   }
>> -static bool hv_vtom_tlb_flush_required(bool private)
>> -{
>> -    return true;
>> -}
>> -
>>   static bool hv_vtom_cache_flush_required(void)
>>   {
>>       return false;
>> @@ -614,7 +609,6 @@ void __init hv_vtom_init(void)
>>       x86_platform.hyper.is_private_mmio = hv_is_private_mmio;
>>       x86_platform.guest.enc_cache_flush_required = 
>> hv_vtom_cache_flush_required;
>> -    x86_platform.guest.enc_tlb_flush_required = 
>> hv_vtom_tlb_flush_required;
>>       x86_platform.guest.enc_status_change_finish = 
>> hv_vtom_set_host_visibility;
>>       /* Set WB as the default cache mode. */
>> diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
>> index a37ebd3..cf5179b 100644
>> --- a/arch/x86/kernel/x86_init.c
>> +++ b/arch/x86/kernel/x86_init.c
>> @@ -131,9 +131,7 @@ struct x86_cpuinit_ops x86_cpuinit = {
>>   static void default_nmi_init(void) { };
>> -static bool enc_status_change_prepare_noop(unsigned long vaddr, int 
>> npages, bool enc) { return true; }
>>   static bool enc_status_change_finish_noop(unsigned long vaddr, int 
>> npages, bool enc) { return true; }
>> -static bool enc_tlb_flush_required_noop(bool enc) { return false; }
>>   static bool enc_cache_flush_required_noop(void) { return false; }
>>   static bool is_private_mmio_noop(u64 addr) {return false; }
>> @@ -154,9 +152,7 @@ struct x86_platform_ops x86_platform __ro_after_init 
>> = {
>>       .hyper.is_private_mmio        = is_private_mmio_noop,
>>       .guest = {
>> -        .enc_status_change_prepare = enc_status_change_prepare_noop,
>>           .enc_status_change_finish  = enc_status_change_finish_noop,
>> -        .enc_tlb_flush_required       = enc_tlb_flush_required_noop,
>>           .enc_cache_flush_required  = enc_cache_flush_required_noop,
>>       },
>>   };
>> diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
>> index 6faea41..06960ba 100644
>> --- a/arch/x86/mm/mem_encrypt_amd.c
>> +++ b/arch/x86/mm/mem_encrypt_amd.c
>> @@ -278,11 +278,6 @@ static unsigned long pg_level_to_pfn(int level, 
>> pte_t *kpte, pgprot_t *ret_prot)
>>       return pfn;
>>   }
>> -static bool amd_enc_tlb_flush_required(bool enc)
>> -{
>> -    return true;
>> -}
>> -
>>   static bool amd_enc_cache_flush_required(void)
>>   {
>>       return !cpu_feature_enabled(X86_FEATURE_SME_COHERENT);
>> @@ -318,18 +313,6 @@ static void enc_dec_hypercall(unsigned long vaddr, 
>> unsigned long size, bool enc)
>>   #endif
>>   }
>> -static bool amd_enc_status_change_prepare(unsigned long vaddr, int 
>> npages, bool enc)
>> -{
>> -    /*
>> -     * To maintain the security guarantees of SEV-SNP guests, make sure
>> -     * to invalidate the memory before encryption attribute is cleared.
>> -     */
>> -    if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && !enc)
>> -        snp_set_memory_shared(vaddr, npages);
>> -
>> -    return true;
>> -}
>> -
>>   /* Return true unconditionally: return value doesn't matter for the 
>> SEV side */
>>   static bool amd_enc_status_change_finish(unsigned long vaddr, int 
>> npages, bool enc)
>>   {
>> @@ -337,8 +320,12 @@ static bool amd_enc_status_change_finish(unsigned 
>> long vaddr, int npages, bool e
>>        * After memory is mapped encrypted in the page table, validate it
>>        * so that it is consistent with the page table updates.
>>        */
>> -    if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && enc)
>> -        snp_set_memory_private(vaddr, npages);
>> +    if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
>> +        if (enc)
>> +            snp_set_memory_private(vaddr, npages);
>> +        else
>> +            snp_set_memory_shared(vaddr, npages);
>> +    }
> 
> These calls will both result in a PVALIDATE being issued (either before or 
> after the page state change to the hypervisor) using the virtual address, 
> which will trigger a #PF is the present bit isn't set.
> 
>>       if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
>>           enc_dec_hypercall(vaddr, npages << PAGE_SHIFT, enc);
>> @@ -498,9 +485,7 @@ void __init sme_early_init(void)
>>       /* Update the protection map with memory encryption mask */
>>       add_encrypt_protection_map();
>> -    x86_platform.guest.enc_status_change_prepare = 
>> amd_enc_status_change_prepare;
>>       x86_platform.guest.enc_status_change_finish  = 
>> amd_enc_status_change_finish;
>> -    x86_platform.guest.enc_tlb_flush_required    = 
>> amd_enc_tlb_flush_required;
>>       x86_platform.guest.enc_cache_flush_required  = 
>> amd_enc_cache_flush_required;
>>       /*
>> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
>> index d7ef8d3..d062e01 100644
>> --- a/arch/x86/mm/pat/set_memory.c
>> +++ b/arch/x86/mm/pat/set_memory.c
>> @@ -2147,40 +2147,57 @@ static int __set_memory_enc_pgtable(unsigned 
>> long addr, int numpages, bool enc)
>>       memset(&cpa, 0, sizeof(cpa));
>>       cpa.vaddr = &addr;
>>       cpa.numpages = numpages;
>> +
>> +    /*
>> +     * The caller must ensure that the memory being transitioned between
>> +     * encrypted and decrypted is not being accessed.  But if
>> +     * load_unaligned_zeropad() touches the "next" page, it may generate a
>> +     * read access the caller has no control over. To ensure such accesses
>> +     * cause a normal page fault for the load_unaligned_zeropad() handler,
>> +     * mark the pages not present until the transition is complete.  We
>> +     * don't want a #VE or #VC fault due to a mismatch in the memory
>> +     * encryption status, since paravisor configurations can't cleanly do
>> +     * the load_unaligned_zeropad() handling in the paravisor.
>> +     *
>> +     * There's no requirement to do so, but for efficiency we can clear
>> +     * _PAGE_PRESENT and set/clr encryption attr as a single operation.
>> +     */
>>       cpa.mask_set = enc ? pgprot_encrypted(empty) : 
>> pgprot_decrypted(empty);
>> -    cpa.mask_clr = enc ? pgprot_decrypted(empty) : 
>> pgprot_encrypted(empty);
>> +    cpa.mask_clr = enc ? pgprot_decrypted(__pgprot(_PAGE_PRESENT)) :
>> +                pgprot_encrypted(__pgprot(_PAGE_PRESENT));
> 
> This should be lined up with the pgprot_decrypted above, e.g.:
> 
> cpa.mask_clr = enc ? pgprot_decrypted(__pgprot(_PAGE_PRESENT)) :
>               pgprot_encrypted(__pgprot(_PAGE_PRESENT));
> 
> or
> 
> cpa.mask_clr = enc ? pgprot_decrypted(__pgprot(_PAGE_PRESENT))
>             : pgprot_encrypted(__pgprot(_PAGE_PRESENT));
> 
>>       cpa.pgd = init_mm.pgd;
>>       /* Must avoid aliasing mappings in the highmem code */
>>       kmap_flush_unused();
>>       vm_unmap_aliases();
>> -    /* Flush the caches as needed before changing the encryption 
>> attribute. */
>> -    if (x86_platform.guest.enc_tlb_flush_required(enc))
>> -        cpa_flush(&cpa, x86_platform.guest.enc_cache_flush_required());
>> -
>> -    /* Notify hypervisor that we are about to set/clr encryption 
>> attribute. */
>> -    if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, 
>> enc))
>> -        return -EIO;
>> +    /* Flush the caches as needed before changing the encryption attr. */
>> +    if (x86_platform.guest.enc_cache_flush_required())
>> +        cpa_flush(&cpa, 1);
>>       ret = __change_page_attr_set_clr(&cpa, 1);
>> +    if (ret)
>> +        return ret;
>>       /*
>> -     * After changing the encryption attribute, we need to flush TLBs 
>> again
>> -     * in case any speculative TLB caching occurred (but no need to flush
>> -     * caches again).  We could just use cpa_flush_all(), but in case TLB
>> -     * flushing gets optimized in the cpa_flush() path use the same logic
>> -     * as above.
>> +     * After clearing _PAGE_PRESENT and changing the encryption attribute,
>> +     * we need to flush TLBs to ensure no further accesses to the 
>> memory can
>> +     * be made with the old encryption attribute (but no need to flush 
>> caches
>> +     * again).  We could just use cpa_flush_all(), but in case TLB 
>> flushing
>> +     * gets optimized in the cpa_flush() path use the same logic as above.
>>        */
>>       cpa_flush(&cpa, 0);
>> -    /* Notify hypervisor that we have successfully set/clr encryption 
>> attribute. */
>> -    if (!ret) {
>> -        if (!x86_platform.guest.enc_status_change_finish(addr, 
>> numpages, enc))
>> -            ret = -EIO;
>> -    }
>> +    /* Notify hypervisor that we have successfully set/clr encryption 
>> attr. */
>> +    if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
>> +        return -EIO;
> 
> Here's where the #PF is likely to be triggered.
> 
> Thanks,
> Tom
> 
>> -    return ret;
>> +    /*
>> +     * Now that the hypervisor is sync'ed with the page table changes
>> +     * made here, add back _PAGE_PRESENT. set_memory_p() does not flush
>> +     * the TLB.
>> +     */
>> +    return set_memory_p(&addr, numpages);
>>   }
>>   static int __set_memory_enc_dec(unsigned long addr, int numpages, bool 
>> enc)

