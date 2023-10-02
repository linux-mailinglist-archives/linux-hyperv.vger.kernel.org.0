Return-Path: <linux-hyperv+bounces-401-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5177B57F1
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 18:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 228DB1C2074E
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 16:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB1C199B5;
	Mon,  2 Oct 2023 16:35:29 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4CEC2EB
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Oct 2023 16:35:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57300A7;
	Mon,  2 Oct 2023 09:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuWay0CbDPYI4QSfUxQy2RHUthOugXtNGIpvM7teVRTF76BBWauHk1Nri6BpfydCSGa0m6DGhakW4wX3oAiHHsce+kXByQQkbxnqXT9RZLvrCFvdNq2FAfLHelMtpN47CpwqGxqPSm4gK8ly7NlDoGLCsaUigu0YuPVjb0cLbE+PlsZze/46DREi2I1tcRzwgI2Y9aMW2ytet0lnMD5bYfPP+N0USTGKQ6GfqzNui/ytNhw5kFfVxKPxgt6V61nTA5Tk5ff64BSa466N0AGc4kMDujnCkoz4FFhGGjA1uwI9ylSeWkVLB+rZDX/dHNjLqcGG6koZqg4da/hV1FdY5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXyEbsdEeRz6RNxFxl5/u2qmhct7MkK5E+7RVddNwLM=;
 b=P1cRh8weJ6Q4sSFOn2/LIRHAsVbO9/QnvaLkRRFZh/DqQSZlS7DvjrWAERIxItSOHAMJHMcD3wzXGGszfxQ3y4/CHrAIjR1OVcGTumf5GdevCgh1NbMTMSLnZg2R679kTSfxkBpVpr+ViAy0QXSd40VFu+IziM93zsaD4Pyk/MlKp/9lY8BovTGIftdroGoVSerHSGQNRSwtzqzayQ66NJBsPlgDs825Ejy5JwxeXSFknimi5cKk6KwTQlPae0wxko2UD+CJNikVcozBa7mC4V8pyEHb0TvAp1sAH6I3u0w0FLoRGV5W9hTzcBRiUTAs/FAkSQ7tD9pyWJkRFLWt+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXyEbsdEeRz6RNxFxl5/u2qmhct7MkK5E+7RVddNwLM=;
 b=U97wgSePHM5ZWJ6xE2u0RYwN/Nz8lJQuOrQzjeqp58vSxZqtJFLRXLoH4j5ibtRsK8HpGbz3N8/ToAkag8uMr+4Rsefq0w1MZ0MPbdzj8CjqX+VePcjjFchbdYo7kOvbn9S6OhQkPCz1WqwzpS3NBHqtOAn9jP7qJZrQh+Fr16o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BN9PR12MB5113.namprd12.prod.outlook.com (2603:10b6:408:136::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Mon, 2 Oct
 2023 16:35:18 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2b54:7ddf:9e2e:751c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2b54:7ddf:9e2e:751c%3]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 16:35:18 +0000
Message-ID: <c9a06bd0-09aa-5e4b-e2cb-63ebcc93757e@amd.com>
Date: Mon, 2 Oct 2023 11:35:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/5] x86/mm: Mark CoCo VM pages not present while changing
 encrypted state
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
 <1696011549-28036-4-git-send-email-mikelley@microsoft.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <1696011549-28036-4-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:5:134::33) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|BN9PR12MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: 0221d036-8f2a-404c-c913-08dbc365903b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mo8o8y0nzLNv4ewBN5ltx/LG7pC02qqGrhlJvjdhizUizy/CgJNt01GaxJwWPOVmS93EpDLoI8AtadSqgZS58zrjNDGvw/6hIn2X5T1jyZaNdTvtgPgXLe/moSyc0ND8vaLzziymgw7fFoL+JfwmY//PqS9kjVBn5/S9kasGZycO6PIm2AO3imKARLYl5tk6OWehRAkPMXdLT3htqLTFiiGfRyUlNyS/ypjWlxkoRsqC35LKod0tzQDfFGMnlsPUFAZVfEryU6L0DAzHgq4RDxyVVf+8P+QbPUV6ousd0Ny87WMNXLzaSLBrGQMFkMhA+mXPzXQ2RRDAEskNi2ZWmox4TSW1RHdMaxDSPjHJF2DqszI2yzfC1Hu2z1YQuWXGq22ClJs2/hTYQBoxlNHGN3SOeSRNgTI4v7vdgn5+WDGGJIW3gkX617AH52aUTc3B2NpBZJpBtC4Di9md58k+LRuYYKsGwEE+6cykoI+BH5wd78RbprwMfSO5cTYG9SoD4hcv4C3BxRNSJLA16BSj6xp36t8h9TcZkRkeiv3cKvEIAXYJRY9dSCmzZTksOKvpMVPravH80FcmF6Pbwm6rNeBRsfFKN7Avq5ptAA4ZByT8FagsNbBrntksC3eiO5hkJ9gN/CC+cjIE3zsz3oNN75qC1Z9Qd2CkUcknJaNLDNY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(136003)(376002)(366004)(346002)(39860400002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(6486002)(6506007)(53546011)(2616005)(83380400001)(45080400002)(7416002)(26005)(2906002)(30864003)(8676002)(5660300002)(66556008)(66946007)(316002)(66476007)(8936002)(41300700001)(478600001)(36756003)(921005)(86362001)(31696002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzlwbmZnQkE0NFk3dFdlN3duSktWcWNmZkV0MFNiNFdwb3Z3S0QvVmZSTlho?=
 =?utf-8?B?Ulo5NUhtTm5UQTJnSE8wV1NCK2VPK0JwQ3ZpSFJyb3YvNjVLQXlQYWRaeHh2?=
 =?utf-8?B?Qi9pc05BY3h6RklBVU5paUp5WTRXdWdwRXB4cmpHSHhsOGM5R3lCSUJlQTMx?=
 =?utf-8?B?SWVGbVZHYU5wVWpUWEhLOU0rUGQ4azhmS1I1RGk0ZVJhWVVSdTEzVUZlTmhJ?=
 =?utf-8?B?YTZqbW5RNDNub0pCNVF5dk9pb1hHcnc1VHlyQnNvaFg2bWtpTlppUmNVVmdU?=
 =?utf-8?B?TmwrYWt1Q0lkS2JydUR2RkczMzVCSlcrQ3kzWDZ4aUh5MUlNL0NBSUNkeUZo?=
 =?utf-8?B?MmtOakh2MjdibU9QN2E4bkdmc2ROYmpPQ0IveEN1bzJwbVFHaWV2ZWtYRWtE?=
 =?utf-8?B?U1dDMTc3TStYUUJPeENUVFIwbi8raE1PVWIySGtxamVPSGhDRTBhazVqUE4y?=
 =?utf-8?B?TXB6bXlNWUJzVlpETzhIdWFXbkxpWTVYMVk1LzdTbm9hYXJvR0dyUE5QKzJn?=
 =?utf-8?B?bGhTWUhrYVRLQzdJcWcrZ3MwalNTSENSNTJDTm8zWVI3QnJKQS9MRy9EalRi?=
 =?utf-8?B?a09NNDNDbGZsTTJERnhzODJES0NvazhETElzcDUybmJUTm5Od3BvNDdoa290?=
 =?utf-8?B?dUljUlpCME1ocklZeGRqZ1RHS0FiNjJyRUpQN3RGbW5sVEJOZUp2UmNsdy9q?=
 =?utf-8?B?cDlGOTBZL0NBK3RoeWRia2dRZ0JQWnBwb0kvaXBac3Jlb3RVNUNtSGpnL1dJ?=
 =?utf-8?B?K081NU4yY1ViaThJQ1AwUFE2ckNqQUZTZ0VtNUErc3VReXNla2VscmdaMEQx?=
 =?utf-8?B?aUZYL0dqWWYxdzlhbGIyWEwvUHdaekJqU1BLQjYzZ21hcHhBaHZhKzRzT2lz?=
 =?utf-8?B?d0pHby9PVEQ4TWFQUE1oNHFlYU0yOEdmeTdqdW5YdXJlTEhGRkNLemtyYTF3?=
 =?utf-8?B?RkhNMGtzbXJSSnd4ZEtBSXlvR1lDY3NXTFhMNWVRWk0rZnVwQlBORXFnbVhk?=
 =?utf-8?B?Y2E0YnhGQTFJT2NPY3kycDhUSEo4R3ZaSE5PdlFJN3ZhZFhHQ3ZoZlp2dldi?=
 =?utf-8?B?VWtsRElZZllraVNPVE5wdlhRT1JtYUtjczFFbEZYR21QU1k0cTFiZ1lWQ0tw?=
 =?utf-8?B?MnlCM1ZkekptZTUyOXJ6VUdrYm13YjJMYXdkMTZIbTd6a3lmb24rRE1zeXV6?=
 =?utf-8?B?MUJkaVFpWUtQQ2FCem5YTjhkalZGTnpVSDBmeHI0S2MyYmRQZ2gycVhrUkpM?=
 =?utf-8?B?dTRvL0E3OHV0MmpSd2Fvd3ZOZmp0TVBaUUM2OHZUbmttakNWYURmY2RxTXVn?=
 =?utf-8?B?cmxyN2dZWTBNSDErTkRYaDE0UENLT3dueDJBN1ZCQVFUUEUzOUxZNzVwU2J5?=
 =?utf-8?B?NTlQeGxWa0dXUU9JZXRlKzBxVnlpN1YxelFTQ2hxWndJdS9TTHozcDUrRTRN?=
 =?utf-8?B?YUhvU3hRSDB1TmJzTFNRcEl1NkZvODh4RGo5Mjh6N1FrZzR0dkFBaU1rZHY1?=
 =?utf-8?B?OE92OERkdG00QkZMSUxJZlZqU3pRTmhoMUIrQ0ovaWlyQmNISVplcEJ0LytJ?=
 =?utf-8?B?YkVVZkxGdzBJZEYwN0Nvb3RxY3hVOXYwZTJtMSs5by9IMFRBTk9kaHo1VTVz?=
 =?utf-8?B?MW9Bc21BODgwaDBaUko1cjNTeFVLcVZQMkM4NEMwY2VmRi8xVXQ2MVNoSlly?=
 =?utf-8?B?dEZQTWJQQnduYndlcVFxTXBVZEx0My9aOXU5ejh2NkthUjJCLzJsTGhQRWU3?=
 =?utf-8?B?UnBpQkprRXg0WElmc0ZWOGJuc1RHZFFwN1p0THNnVTVJUzZaOUQ0cVRyNUhE?=
 =?utf-8?B?WkpMMzBzUnFiOWJUS3JmUjJnRmx5M0xlQ0NhTEdzdm5TM0ZiMU4zbHVJQS9i?=
 =?utf-8?B?enNzUXFhVHBBNzBCaGVpZFpYeFhFUnpLQWRqVHM2d01NS1U4ZHJCWlRaRnN2?=
 =?utf-8?B?cGZmd0c5Y1FuSkRPa2ZFM3FrU2QrdGt1d09kamttak1pNWVvcFJ0Y0JBK1VE?=
 =?utf-8?B?c1kzYWZoVHR6UzVzUVJ0NWFKMlk5TEJLZU11OE5NdXg3aTFCSVJSMzZEbHZM?=
 =?utf-8?B?M1UxL05QR0ZJVVJ4NnBXajJiUzQ5L1Y5VkhmNGFCWHl5UTJkakh1SWtBSWh5?=
 =?utf-8?Q?3PrgaEDqMtWebStytq4IUkrun?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0221d036-8f2a-404c-c913-08dbc365903b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 16:35:18.4732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIfFiuG0VcIPbhoCkCTsF2AGSy69aNuZFdlB8YaHdTzXHr9oTiqReshVg+smzzY4y9kyv+s5ZR9sJCpWSGNozg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5113
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
> However, the load_unaligned_zeropad() function can read arbitrary memory
> pages at arbitrary times, which could access a transitioning page during
> the window.  In such a case, CoCo VM specific exceptions are taken
> (depending on the CoCo architecture in use).  Current code in those
> exception handlers recovers and does "fixup" on the result returned by
> load_unaligned_zeropad().  Unfortunately, this exception handling can't
> work in paravisor scenarios (TDX Paritioning and SEV-SNP in vTOM mode).
> The exceptions need to be forwarded from the paravisor to the Linux
> guest, but there are no architectural specs for how to do that.
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

Not sure why I didn't notice this before, but I will need to test this to 
be certain. As part of this notification, the SNP support will issue a 
PVALIDATE instruction (to either validate or rescind validation to the 
page). PVALIDATE takes a virtual address. If the PRESENT bit has been 
removed, the PVALIDATE instruction will take a #PF (see comments below).

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
> With this approach, the order of updating the guest PTEs and
> notifying the hypervisor doesn't matter. As such, only a single
> hypervisor callback is needed, rather one before and one after
> the PTE update. Simplify the code by eliminating the extra
> hypervisor callback along with the TDX and SEV-SNP code that
> handles the before and after cases. The TLB flush callback is
> also no longer required and is removed.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>   arch/x86/coco/tdx/tdx.c       | 66 +------------------------------------------
>   arch/x86/hyperv/ivm.c         |  6 ----
>   arch/x86/kernel/x86_init.c    |  4 ---
>   arch/x86/mm/mem_encrypt_amd.c | 27 ++++--------------
>   arch/x86/mm/pat/set_memory.c  | 55 +++++++++++++++++++++++-------------
>   5 files changed, 43 insertions(+), 115 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 3e6dbd2..1bb2fff 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -676,24 +676,6 @@ bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
>   	return true;
>   }
>   
> -static bool tdx_tlb_flush_required(bool private)
> -{
> -	/*
> -	 * TDX guest is responsible for flushing TLB on private->shared
> -	 * transition. VMM is responsible for flushing on shared->private.
> -	 *
> -	 * The VMM _can't_ flush private addresses as it can't generate PAs
> -	 * with the guest's HKID.  Shared memory isn't subject to integrity
> -	 * checking, i.e. the VMM doesn't need to flush for its own protection.
> -	 *
> -	 * There's no need to flush when converting from shared to private,
> -	 * as flushing is the VMM's responsibility in this case, e.g. it must
> -	 * flush to avoid integrity failures in the face of a buggy or
> -	 * malicious guest.
> -	 */
> -	return !private;
> -}
> -
>   static bool tdx_cache_flush_required(void)
>   {
>   	/*
> @@ -776,30 +758,6 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
>   	return true;
>   }
>   
> -static bool tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
> -					  bool enc)
> -{
> -	/*
> -	 * Only handle shared->private conversion here.
> -	 * See the comment in tdx_early_init().
> -	 */
> -	if (enc)
> -		return tdx_enc_status_changed(vaddr, numpages, enc);
> -	return true;
> -}
> -
> -static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
> -					 bool enc)
> -{
> -	/*
> -	 * Only handle private->shared conversion here.
> -	 * See the comment in tdx_early_init().
> -	 */
> -	if (!enc)
> -		return tdx_enc_status_changed(vaddr, numpages, enc);
> -	return true;
> -}
> -
>   void __init tdx_early_init(void)
>   {
>   	struct tdx_module_args args = {
> @@ -831,30 +789,8 @@ void __init tdx_early_init(void)
>   	 */
>   	physical_mask &= cc_mask - 1;
>   
> -	/*
> -	 * The kernel mapping should match the TDX metadata for the page.
> -	 * load_unaligned_zeropad() can touch memory *adjacent* to that which is
> -	 * owned by the caller and can catch even _momentary_ mismatches.  Bad
> -	 * things happen on mismatch:
> -	 *
> -	 *   - Private mapping => Shared Page  == Guest shutdown
> -         *   - Shared mapping  => Private Page == Recoverable #VE
> -	 *
> -	 * guest.enc_status_change_prepare() converts the page from
> -	 * shared=>private before the mapping becomes private.
> -	 *
> -	 * guest.enc_status_change_finish() converts the page from
> -	 * private=>shared after the mapping becomes private.
> -	 *
> -	 * In both cases there is a temporary shared mapping to a private page,
> -	 * which can result in a #VE.  But, there is never a private mapping to
> -	 * a shared page.
> -	 */
> -	x86_platform.guest.enc_status_change_prepare = tdx_enc_status_change_prepare;
> -	x86_platform.guest.enc_status_change_finish  = tdx_enc_status_change_finish;
> -
> +	x86_platform.guest.enc_status_change_finish  = tdx_enc_status_changed;
>   	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
> -	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
>   
>   	/*
>   	 * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 084fab6..fbe2585 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -550,11 +550,6 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
>   	return result;
>   }
>   
> -static bool hv_vtom_tlb_flush_required(bool private)
> -{
> -	return true;
> -}
> -
>   static bool hv_vtom_cache_flush_required(void)
>   {
>   	return false;
> @@ -614,7 +609,6 @@ void __init hv_vtom_init(void)
>   
>   	x86_platform.hyper.is_private_mmio = hv_is_private_mmio;
>   	x86_platform.guest.enc_cache_flush_required = hv_vtom_cache_flush_required;
> -	x86_platform.guest.enc_tlb_flush_required = hv_vtom_tlb_flush_required;
>   	x86_platform.guest.enc_status_change_finish = hv_vtom_set_host_visibility;
>   
>   	/* Set WB as the default cache mode. */
> diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> index a37ebd3..cf5179b 100644
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -131,9 +131,7 @@ struct x86_cpuinit_ops x86_cpuinit = {
>   
>   static void default_nmi_init(void) { };
>   
> -static bool enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { return true; }
>   static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return true; }
> -static bool enc_tlb_flush_required_noop(bool enc) { return false; }
>   static bool enc_cache_flush_required_noop(void) { return false; }
>   static bool is_private_mmio_noop(u64 addr) {return false; }
>   
> @@ -154,9 +152,7 @@ struct x86_platform_ops x86_platform __ro_after_init = {
>   	.hyper.is_private_mmio		= is_private_mmio_noop,
>   
>   	.guest = {
> -		.enc_status_change_prepare = enc_status_change_prepare_noop,
>   		.enc_status_change_finish  = enc_status_change_finish_noop,
> -		.enc_tlb_flush_required	   = enc_tlb_flush_required_noop,
>   		.enc_cache_flush_required  = enc_cache_flush_required_noop,
>   	},
>   };
> diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
> index 6faea41..06960ba 100644
> --- a/arch/x86/mm/mem_encrypt_amd.c
> +++ b/arch/x86/mm/mem_encrypt_amd.c
> @@ -278,11 +278,6 @@ static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
>   	return pfn;
>   }
>   
> -static bool amd_enc_tlb_flush_required(bool enc)
> -{
> -	return true;
> -}
> -
>   static bool amd_enc_cache_flush_required(void)
>   {
>   	return !cpu_feature_enabled(X86_FEATURE_SME_COHERENT);
> @@ -318,18 +313,6 @@ static void enc_dec_hypercall(unsigned long vaddr, unsigned long size, bool enc)
>   #endif
>   }
>   
> -static bool amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
> -{
> -	/*
> -	 * To maintain the security guarantees of SEV-SNP guests, make sure
> -	 * to invalidate the memory before encryption attribute is cleared.
> -	 */
> -	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && !enc)
> -		snp_set_memory_shared(vaddr, npages);
> -
> -	return true;
> -}
> -
>   /* Return true unconditionally: return value doesn't matter for the SEV side */
>   static bool amd_enc_status_change_finish(unsigned long vaddr, int npages, bool enc)
>   {
> @@ -337,8 +320,12 @@ static bool amd_enc_status_change_finish(unsigned long vaddr, int npages, bool e
>   	 * After memory is mapped encrypted in the page table, validate it
>   	 * so that it is consistent with the page table updates.
>   	 */
> -	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && enc)
> -		snp_set_memory_private(vaddr, npages);
> +	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
> +		if (enc)
> +			snp_set_memory_private(vaddr, npages);
> +		else
> +			snp_set_memory_shared(vaddr, npages);
> +	}

These calls will both result in a PVALIDATE being issued (either before or 
after the page state change to the hypervisor) using the virtual address, 
which will trigger a #PF is the present bit isn't set.

>   
>   	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
>   		enc_dec_hypercall(vaddr, npages << PAGE_SHIFT, enc);
> @@ -498,9 +485,7 @@ void __init sme_early_init(void)
>   	/* Update the protection map with memory encryption mask */
>   	add_encrypt_protection_map();
>   
> -	x86_platform.guest.enc_status_change_prepare = amd_enc_status_change_prepare;
>   	x86_platform.guest.enc_status_change_finish  = amd_enc_status_change_finish;
> -	x86_platform.guest.enc_tlb_flush_required    = amd_enc_tlb_flush_required;
>   	x86_platform.guest.enc_cache_flush_required  = amd_enc_cache_flush_required;
>   
>   	/*
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index d7ef8d3..d062e01 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2147,40 +2147,57 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>   	memset(&cpa, 0, sizeof(cpa));
>   	cpa.vaddr = &addr;
>   	cpa.numpages = numpages;
> +
> +	/*
> +	 * The caller must ensure that the memory being transitioned between
> +	 * encrypted and decrypted is not being accessed.  But if
> +	 * load_unaligned_zeropad() touches the "next" page, it may generate a
> +	 * read access the caller has no control over. To ensure such accesses
> +	 * cause a normal page fault for the load_unaligned_zeropad() handler,
> +	 * mark the pages not present until the transition is complete.  We
> +	 * don't want a #VE or #VC fault due to a mismatch in the memory
> +	 * encryption status, since paravisor configurations can't cleanly do
> +	 * the load_unaligned_zeropad() handling in the paravisor.
> +	 *
> +	 * There's no requirement to do so, but for efficiency we can clear
> +	 * _PAGE_PRESENT and set/clr encryption attr as a single operation.
> +	 */
>   	cpa.mask_set = enc ? pgprot_encrypted(empty) : pgprot_decrypted(empty);
> -	cpa.mask_clr = enc ? pgprot_decrypted(empty) : pgprot_encrypted(empty);
> +	cpa.mask_clr = enc ? pgprot_decrypted(__pgprot(_PAGE_PRESENT)) :
> +				pgprot_encrypted(__pgprot(_PAGE_PRESENT));

This should be lined up with the pgprot_decrypted above, e.g.:

cpa.mask_clr = enc ? pgprot_decrypted(__pgprot(_PAGE_PRESENT)) :
		     pgprot_encrypted(__pgprot(_PAGE_PRESENT));

or

cpa.mask_clr = enc ? pgprot_decrypted(__pgprot(_PAGE_PRESENT))
		   : pgprot_encrypted(__pgprot(_PAGE_PRESENT));

>   	cpa.pgd = init_mm.pgd;
>   
>   	/* Must avoid aliasing mappings in the highmem code */
>   	kmap_flush_unused();
>   	vm_unmap_aliases();
>   
> -	/* Flush the caches as needed before changing the encryption attribute. */
> -	if (x86_platform.guest.enc_tlb_flush_required(enc))
> -		cpa_flush(&cpa, x86_platform.guest.enc_cache_flush_required());
> -
> -	/* Notify hypervisor that we are about to set/clr encryption attribute. */
> -	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
> -		return -EIO;
> +	/* Flush the caches as needed before changing the encryption attr. */
> +	if (x86_platform.guest.enc_cache_flush_required())
> +		cpa_flush(&cpa, 1);
>   
>   	ret = __change_page_attr_set_clr(&cpa, 1);
> +	if (ret)
> +		return ret;
>   
>   	/*
> -	 * After changing the encryption attribute, we need to flush TLBs again
> -	 * in case any speculative TLB caching occurred (but no need to flush
> -	 * caches again).  We could just use cpa_flush_all(), but in case TLB
> -	 * flushing gets optimized in the cpa_flush() path use the same logic
> -	 * as above.
> +	 * After clearing _PAGE_PRESENT and changing the encryption attribute,
> +	 * we need to flush TLBs to ensure no further accesses to the memory can
> +	 * be made with the old encryption attribute (but no need to flush caches
> +	 * again).  We could just use cpa_flush_all(), but in case TLB flushing
> +	 * gets optimized in the cpa_flush() path use the same logic as above.
>   	 */
>   	cpa_flush(&cpa, 0);
>   
> -	/* Notify hypervisor that we have successfully set/clr encryption attribute. */
> -	if (!ret) {
> -		if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
> -			ret = -EIO;
> -	}
> +	/* Notify hypervisor that we have successfully set/clr encryption attr. */
> +	if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
> +		return -EIO;

Here's where the #PF is likely to be triggered.

Thanks,
Tom

>   
> -	return ret;
> +	/*
> +	 * Now that the hypervisor is sync'ed with the page table changes
> +	 * made here, add back _PAGE_PRESENT. set_memory_p() does not flush
> +	 * the TLB.
> +	 */
> +	return set_memory_p(&addr, numpages);
>   }
>   
>   static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)

