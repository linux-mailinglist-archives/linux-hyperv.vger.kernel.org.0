Return-Path: <linux-hyperv+bounces-399-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5F07B56D4
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 17:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1589F282442
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 15:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1CE1A713;
	Mon,  2 Oct 2023 15:42:43 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482C363B
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Oct 2023 15:42:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AE393;
	Mon,  2 Oct 2023 08:42:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gnhx0+yfTWJeQQO50pS2eYtv431NmTkW1ltstymdzMpi1sBS/aFCZyDaDyaTKwxK5yA2dm0/6fH1tchaqnX/MvGX2soAF+G8BVH9lrAwqwWPAQBQs0NPj2/gaHt4Y6uq6QmKlWK4ailiXyhx6/HboKUUzG6YaXXZPeeUCln70oV+DDvVCoFMvYyUJw50E+xzfTEZSYYGRZveVnx/ouvJjfhiTmvi9cXdlk/OHVeRPaHeG1zIst3IYWlX41gxtG8NjR+KbfawxQWS+OClCIstMEBHS0/SDaf40uEFwoLoAIoJtULAB4CIu3aD98FaRwfRp4fXlwG8ORLuJWdyJQGKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2lufn424Ss4gHxsGp7bt/PkhbtvNXKEumfJkE46RB0=;
 b=nh//5hynD1T+1EJH4CEfPtAu7+oRbdMDWBUa1uKCpv5QX2tWWjFnHbJVeNNZMvBAIrk1NLK9iNUdL/C0adAAJ1ERSAlgzv93Uh+oIFinP67c8Gi+0Bkk3vYcZtgPAF4daI6DmaWE6UtC2cwG2MBXDImL4CetZkN1/YUmhn/g1q+0PhmSPRS2yyO3nhtgtOn2Z4strzVP0hbY/uDTw7GYoo70QPQe8proVaGTa3dmtrvTTOKr+4gbbCIYc/um1PcOivWw2wLLTJ44HLU3yerXrnQ+coMg9aYkKsBHewFXNSR0COum4b3XcwbxmA4ISrjYBYo4TGPtHQ8I8cDOTD5jnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2lufn424Ss4gHxsGp7bt/PkhbtvNXKEumfJkE46RB0=;
 b=TS4FnI6rZ5KyUN3rX333en/0TmtqDNajK5CPiEcMNlzKO+8mFVg1wLG6ZQr4kCn2GEfUc0w2npkaiFAEudOmDpayUuTYhFI6/b+Y2efWQKKNsqHKry0cV/YKIQ2cP/3WejCkug0OmlkHQQeaxLARL3RUc/SCmYOl7ou3GWE9Ok4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Mon, 2 Oct
 2023 15:42:38 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2b54:7ddf:9e2e:751c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2b54:7ddf:9e2e:751c%3]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 15:42:38 +0000
Message-ID: <6cc4dea3-915c-1842-10f6-c3a8137cfdc9@amd.com>
Date: Mon, 2 Oct 2023 10:42:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/5] x86/coco: Mark CoCo VM pages not present when
 changing encrypted state
Content-Language: en-US
To: Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
 peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
 kirill.shutemov@linux.intel.com, seanjc@google.com,
 rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, x86@kernel.org
References: <1696011549-28036-1-git-send-email-mikelley@microsoft.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <1696011549-28036-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0067.namprd05.prod.outlook.com
 (2603:10b6:8:57::12) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SJ2PR12MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: 8699b45d-8a81-4181-9908-08dbc35e349e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XYJe1nVrXXSYPbojTnJEGfBC8MXYs6l2QpqIXaVTtZwrDmnjaiT5dM5mK8vACiEcPz8BMLZQviUYn6noLQyvjqfiZo5+8GhuIeqV8LMWV5aYiAEdoCUSSaDUW8c8mc75iePImGlM1/mcTXWxZP/5eEfmbm3nMtRCr6mY6xOQsjGMptb4tWJ35XrzVhPGgvS+30zAm71T9Q/UQjsO9aWjrn2+ACPQl8z54V+y5nmRYockOjHtVI/j3VxCtTB2V2AMdww9V1cGoO889NxoBiAR20PGV4DMBV44Y8G4GYO/e1802KojX7VaNlmxBOEqa14LcQe4wZjdpkCY98S3TlR5e35BzXbnocorwqE44qALFY8Z4KWhMNP2zd5vqvCskFmuFWM0WykxVQwftK8P+H6PsRr1pWbLN7DwrkwqzSot3KBGcm8PeQbYYssEJE3i+u1gWh0O1Ls/ZwyAfXiYzsxnJGBTsb+zwMvRaxEaUIag8Q0PIUhGi7W7XZ2avCnFXF3chF4uKdBwvMoNYWns4NIXFjJF33xVasRpD1SYF+dfwa3raf+2D9ifZk8RWqt+c3EsWsGBrZDigHXGN4toy+C2L5Bl/wYtZBYypiUW2xKoDZCwmzxM0V9FyMipjhODWJg+eBesjLLwKH6nO8PmsvgNkOxc3PCQt30GSzzMJsuAJps=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(366004)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(45080400002)(53546011)(6506007)(6666004)(6486002)(966005)(478600001)(83380400001)(6512007)(2616005)(26005)(7416002)(2906002)(41300700001)(66556008)(66946007)(316002)(66476007)(8676002)(5660300002)(8936002)(36756003)(31696002)(38100700002)(921005)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzNSZXZwbWhmYmVjNTVQWWs5QmdNT0V2N0s3OHhjMkgxK2xoTDVwU3B2UDVt?=
 =?utf-8?B?UHE5WWdXcS9RM1EzdDEyU0g2dTYwT2tyRUFxMmtvOWtFOEZPanQ4c0dRbUt6?=
 =?utf-8?B?SXFhUTY3cDNNakowUzF5WE5nbmFmUkEva0tsSUZCVFpmaWp6ZEhhVm5HSTh3?=
 =?utf-8?B?WXBZN1dFdHBaWUQya1BZZzI0cml2YUgvNnliSHVIQ0xUejkvMm45eDltcVMz?=
 =?utf-8?B?ZDl1OSt5TitRZDhIR2lEMFhySFNvTmhDSHdOczFPbDdxQlREdG4wa1RFVlBz?=
 =?utf-8?B?aHNzcmxkT0g1VE1JSlZrQ2pHSjF5QStGTUZOSW1PbC9zNVkvRThzM1ZUWlBW?=
 =?utf-8?B?RnZxcTlxK0RXeGpWd29XanBOZjZJT1pkM200UUE0WVRZMEd1SWpFN1BlS1BU?=
 =?utf-8?B?RUh4c2V4dFNNZHFBU3J0eDB0YlkwQWRiT3IvOFUvQmtsTjBJRmdUUHpyN2FX?=
 =?utf-8?B?OG9UUTJOamY5TGdicWdVVGVNRms3ekZQV21HWUQ4dllxQTRMeTZrbXFqYmda?=
 =?utf-8?B?UmhycXNhbzE4Mkx6cXJWVU8zditFd3FvS212MlpIZEwvMVhJcTZ2VzVJYTRy?=
 =?utf-8?B?UGJ0WHBreWJDaUU5SzNLV0FaZ0lJc1pzbUJWL2xzcUpqaWdQNkV3U0VqNGRF?=
 =?utf-8?B?cXVpUnpwa3ZhbzhFbU5xQjFxVzFYU1JaejlTQWFneHVlbm5kM3JVNk1JZmZX?=
 =?utf-8?B?ZnRmTW9jZ0h4emFJdXhqSXNaK09kaWhqSEFqZEg4VEwzQ1M2RXNyNndmSHZh?=
 =?utf-8?B?c1d1OExoK2FCUU9raTloYVhHRC94K21LMElSTFNkMFdPM1p6K0lwRkRRa0FS?=
 =?utf-8?B?eG1LbWd2RXBnMGVZZDRycmcvU2haTVFYT05jUXdBMEppSElONVhmcU5TN1Rq?=
 =?utf-8?B?ZjdEUlJ3QS9qREZzSHo0SmxLc0RnVTI3d3piWmQvSnJYSlBqV083T0JOMjFO?=
 =?utf-8?B?WnQ4NGdmRWUzSWtPcmM3cE1EaThId2VBd2JCSDlTbjFsOG1acnJSNnBCMXMv?=
 =?utf-8?B?eDZkQ1N5a0V5cWhDOHBITUNLVkMvQ25yNlNRKzdrQy8wV2lFbkRjOUJ4YmdV?=
 =?utf-8?B?ZzY0ek5HMDAxemY4dVAzWStLNDFlT2pQUWs0WXl2VG5pd2lMTkZORlRBbmVy?=
 =?utf-8?B?YUh1d29xcFJHRmRCVHQrY05oRUpmRTA1ZENPVW5PcTgvcVhYK2dBT2FLMkYw?=
 =?utf-8?B?Mno5bG9uNGh5Q0RxV0I2Wm1BT0s2TFFJb1habE8xTXJqWFdtUmpCeXBHNHNn?=
 =?utf-8?B?dmlXeWp2NENYV3dVMFkrOUo1MXU1T1I5ZGFZZW9zNExwNzRrV2M5WFVKUks4?=
 =?utf-8?B?bzNQZmxtY1dZbEEwRFhacS9VK2g4eTRYRHhDYzhMRnBpVkVFODFmaWZaTWMr?=
 =?utf-8?B?WitDY1V6ODI2QnFxdWxhTHZOTW4ydXlrb0hPbFJaMUltUmtFOEVXZmlJZFNW?=
 =?utf-8?B?OWNLK1NvWHRnUzZhU2YwM0JRL012K2pqVVZSUThRbUlybThtWkdrVVFVVlky?=
 =?utf-8?B?V1NQeTlCL05GVUJDVFBBbW1leFFKcVVPVnFtdGlHVXpKQjk5Vm5SeXFtL1kr?=
 =?utf-8?B?eFlDeERXbGN5cEhaWW9IVi9UVkI0WU1lWmdlYXBuUENFVXNPSlNIVys0OTg4?=
 =?utf-8?B?U0FoSDBCdE0zMW0zQ0FRcnB4bzRNdEZUbGNQV1dnd1RUYUVrU2JTRzFlR2M4?=
 =?utf-8?B?cndjSXVOMHI4b1VpWlFTRVQ0NnpVbCt3ZXFKcWlDekhFb294MnZRVW4rVE8x?=
 =?utf-8?B?SnRmSkJRTXBPMUFXdGVsZnVEUUFhaVZBcVFSdENza2M2T3lEYTVoWW1STGVT?=
 =?utf-8?B?dmpJTGNBbXgxeGhTRXViQWpKNHhvcnNUTWhyZS9Gc3hYOWpJSENuRkxXN0E0?=
 =?utf-8?B?RXBGaVBVVWNYb0Rpb1dPa0J0czVxZU5iN1JtR1Q5NUJPZTh6NlJuNnc0bHlI?=
 =?utf-8?B?RWszOTd1UGdab080QUtJUlhtaEdMT2dhc2FPWlpSL3JwYU9KZVRHZ0xUc2tL?=
 =?utf-8?B?VnBOOXJsZmdOZVVXT3JUd2t6SkFjYVF1WDJPUTc4NVZlZ3RjTTNTN3N2NE45?=
 =?utf-8?B?VDAvNTR3QmlwSzhjSi9mTVR3eUh1MHZGQkVUVERNQk5XZzlHam4yMm1ZU1hW?=
 =?utf-8?Q?eBtCVyQJpHB7r5OwrbE8Bn8Uq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8699b45d-8a81-4181-9908-08dbc35e349e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 15:42:38.1762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1IAYXduOiQqGtlCqpXfI87brMuaD1pIsD37J52NyOLkyalXqI4KXB2jhaiPLfdUuDHaKEJVbpC7OlY21qSGg+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8690
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/29/23 13:19, Michael Kelley wrote:
> In a CoCo VM when a page transitions from encrypted to decrypted, or vice
> versa, attributes in the PTE must be updated *and* the hypervisor must
> be notified of the change. Because there are two separate steps, there's
> a window where the settings are inconsistent.  Normally the code that
> initiates the transition (via set_memory_decrypted() or
> set_memory_encrypted()) ensures that the memory is not being accessed
> during a transition, so the window of inconsistency is not a problem.
> However, load_unaligned_zeropad() can read arbitrary memory pages at
> arbitrary times, which could read a transitioning page during the
> window.  In such a case, CoCo VM specific exceptions are taken
> (depending on the CoCo architecture in use).  Current code in those
> exception handlers recovers and does "fixup" on the result returned by
> load_unaligned_zeropad().  Unfortunately, this exception handling can't
> work in paravisor scenarios (TDX Paritioning and SEV-SNP in vTOM mode).
> The exceptions would need to be forwarded from the paravisor to the
> Linux guest, but there's no architectural spec for how to do that.
> 
> Fortunately, there's a simpler way to solve the problem by changing
> the core transition code in __set_memory_enc_pgtable() to do the
> following:
> 
> 1.  Remove aliasing mappings
> 2.  Flush the data cache if needed
> 3.  Remove the PRESENT bit from the PTEs of all transitioning pages
> 4.  Set/clear the encryption attribute as appropriate
> 5.  Flush the TLB so the changed encryption attribute isn't visible
> 6.  Notify the hypervisor of the encryption status change
> 7.  Add back the PRESENT bit, making the changed attribute visible
> 
> With this approach, load_unaligned_zeropad() just takes its normal
> page-fault-based fixup path if it touches a page that is transitioning.
> As a result, load_unaligned_zeropad() and CoCo VM page transitioning
> are completely decoupled.  CoCo VM page transitions can proceed
> without needing to handle architecture-specific exceptions and fix
> things up. This decoupling reduces the complexity due to separate
> TDX and SEV-SNP fixup paths, and gives more freedom to revise and
> introduce new capabilities in future versions of the TDX and SEV-SNP
> architectures. Paravisor scenarios work properly without needing
> to forward exceptions.
> 
> This patch set is follow-up to an RFC patch and discussion.[1]
> Compared with the RFC patch, the steps listed above are optimized for
> better performance and particularly for fewer TLB flushes.
> 
> Patch 1 handles implications of the hypervisor callbacks in Step 6
> needing to do virt-to-phys translations on pages that are temporarily
> marked not present.
> 
> Patch 2 is a performance optimization so that Step 7 doesn't generate
> a TLB flush.
> 
> Patch 3 is the core change that implements Steps 1 thru 7. It also
> simplifies the associated TDX, SEV-SNP, and Hyper-V vTOM callbacks.
> 
> Patch 4 is a somewhat tangential cleanup that removes an unnecessary
> wrapper function in the path for doing a transition.
> 
> Patch 5 adds comments describing the implications of errors when
> doing a transition.  These implications are discussed in the email
> thread for the RFC patch.
> 
> With this change, the #VE and #VC exception handlers should no longer
> be triggered for load_unaligned_zeropad() accesses, and the existing
> code in those handlers to do the "fixup" shouldn't be needed. But I
> have not removed that code in this patch set. Kirill Shutemov wants
> to keep the code for TDX #VE, so the code for #VC on the the SEV-SNP
> side has also been kept.

There isn't any code for the SEV-SNP side at the moment.

Thanks,
Tom

> 
> This patch set is based on the linux-next20230921 code tree.
> 
> [1] https://lore.kernel.org/lkml/1688661719-60329-1-git-send-email-mikelley@microsoft.com/
> 
> Michael Kelley (5):
>    x86/coco: Use slow_virt_to_phys() in page transition hypervisor
>      callbacks
>    x86/mm: Don't do a TLB flush if changing a PTE that isn't marked
>      present
>    x86/mm: Mark CoCo VM pages not present while changing encrypted state
>    x86/mm: Remove unnecessary call layer for __set_memory_enc_pgtable()
>    x86/mm: Add comments about errors in
>      set_memory_decrypted()/encrypted()
> 
>   arch/x86/coco/tdx/tdx.c       |  66 +-----------------------
>   arch/x86/hyperv/ivm.c         |  15 +++---
>   arch/x86/kernel/sev.c         |   8 ++-
>   arch/x86/kernel/x86_init.c    |   4 --
>   arch/x86/mm/mem_encrypt_amd.c |  27 +++-------
>   arch/x86/mm/pat/set_memory.c  | 114 +++++++++++++++++++++++++++++-------------
>   6 files changed, 102 insertions(+), 132 deletions(-)
> 

