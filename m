Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FE776DA0B
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Aug 2023 23:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjHBV6K (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Aug 2023 17:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjHBV6I (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Aug 2023 17:58:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C7726AF;
        Wed,  2 Aug 2023 14:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIOpl7SG0pgWrvDO808mHhV4XL9diduY/u7M/1HtGMLrCGuKSkm8UMYZB974I7xeDq7yfzn+Pt8noFYohj07VTjLaGlZ0RX0r3mp/R9Pupk0UxoPnuwuglXGENNlGnB83fFe7gr+w9hFwznAxQSODm0G0jx8RRI7owy1MWMUWxn3WzuieOYP1RpI4NhU2zIv7n2Bd88+LPU9xXf3Hf0iO2DDX2fK/OALF8eD04vZN5KotAY3BIn3zJvQOgOzXH3NcVchehidwtcfKxJCzX7yEJwIQ6EfuzsSXUynKuVGoNi/GYH+ZBz7Pu2PiGV9h+mvgedx4AcLLWpWWy+4dvtGMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HymMt0C9LMD5aNI/MJb2LdzV+Zqy+ImZZ1OdulC8Hik=;
 b=VC7fjE8O9ofmLXFoSrxCd2NhpLPU/jyoBbSg2uhsEd1hvyh1d/0EdkER3eg5prY9HRXFkJY18E3vmJwQlw1RIWX1lYFzCMHCsBtjmraM6g1vX9KP8L2suRyNfbiGUd1Bb6mmKJpCpz75cC3CBeyRwKFnaGmW4jEzy32O2fbloG0LVn9niqCRfwpJLatNYOWR/vP7oZPPSP/0WJ+A/tnwdDv4QOaQH4ipJ5VeQdwfRp0gHV5Y8ePXVzOeg22CMEZ2oySJAXMkyvKbdYPe/bdg0w6b+dA7kSvL/XY68ZrV5n9Dkw62z72fIilwjJ+N14D05DCty5se6d/t2vc6Mgl+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HymMt0C9LMD5aNI/MJb2LdzV+Zqy+ImZZ1OdulC8Hik=;
 b=aPLa1pLVnm1sxgqd07cYEPjQVMIKpbS4vMBEaNDvuGk8VyGByOBJcT8pfGQXQs41+w93JS5jeNg17hlWKC6gU+vecNK28Ofs5bj8f21uDOJOIasSfUGY/ODxz9opuXP0BUhzeYS1Z4/WV9hzkvSPOQUHAzUEejOtQbNZflmvtHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CYYPR12MB8923.namprd12.prod.outlook.com (2603:10b6:930:bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 2 Aug
 2023 21:58:02 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6631.046; Wed, 2 Aug 2023
 21:58:02 +0000
Message-ID: <08bf0835-a4fa-38b5-4cbb-b2058a6a2da0@amd.com>
Date:   Wed, 2 Aug 2023 16:57:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 1/1] x86/mm: Mark CoCo VM pages invalid while moving
 between private and shared
Content-Language: en-US
To:     Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        kirill.shutemov@linux.intel.com, seanjc@google.com,
        rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, x86@kernel.org
References: <1688661719-60329-1-git-send-email-mikelley@microsoft.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <1688661719-60329-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0017.namprd05.prod.outlook.com
 (2603:10b6:803:40::30) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CYYPR12MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 45559adc-863e-423a-f414-08db93a38b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q7mWz3N8Us9g0C531sexqKb2XyrfgdIvIF76nUIXOPz3Qu5dgQRecuEXxyGU0lGHpzobDxQAJQ+16FgnWONuXbg+tx7ChIQG0O8P1h9m7biHyGNVh3Glu6d/loxAg8YMRYHCM5e/+WtaCLVtMpx/jph1ya5Qph0rsfKYDqvf2BAaxHTi1uD0POVkW6Qn9Se4yAYorgbbeQzmwdfeb/PMxVOqE7C9a/qJS6pKZMJxWtx8F/YFQp907t25fqJB34GNyKsankHXfyRMvH7NgEp7jksAP52Ch45yLMLG4bLx/4RuOuTRa7Ps0FFlsoli7HFIa6DkbsXX9cHWb6BPN+X05O1sjVkLUaKV+kPZMQSjJZ6me1l7WP+Nk1EL1fOv2g7NI/yGGhCiIpqOXNuvc652TA+rsnwT+OcrAjcon+tRWKwNp+yZqm2TgMQbcZ1tffKxJ4VuRfrfjGEiknQQ31hNFrdGy34ITGV+byz5dHnWcsvo6YZkXA0FIQiT8yOjD1AJ3AmowsZJ8Uh+HgVLjNj9AZAM/BfEbBT6xtvmZrwFx2DXmg/Wu1YRkXTS2Bf2dBpgZYfc/CtcsQx6lMFvtvWxmIdwVI1HiHHd9A0hFc6yrQEd93PYxQ3keFKDEzFFFuQ/rkrLCT2R3lr6g8IW4zQfRiia13TvSLp1D7QKu0N6/SY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(6029001)(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199021)(36756003)(31696002)(86362001)(31686004)(45080400002)(478600001)(38100700002)(921005)(2616005)(186003)(26005)(83380400001)(6506007)(53546011)(41300700001)(8676002)(8936002)(7416002)(6512007)(6666004)(6486002)(316002)(66476007)(66556008)(5660300002)(66946007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmVtdXByOHdGaGJ3aFlkTitVNGhrdEUraWpJdVlJQUJvR00rMEhHN3ZodmVl?=
 =?utf-8?B?Z2hhdFFBdXpESlhhSllSbGN1MVdrWEJaVC8xM3Rzd1RldXFxaGhMR3E4UlMx?=
 =?utf-8?B?WndCeWVxVG1sRjIrZWVxdTdOdi9idFM4aUNCM04xSUxQYTkyQllpTlNSbzJU?=
 =?utf-8?B?Rk5CcGxESjRhd3VKRUJReUpGQ1BaSkIvZERtMEwwUHh5SHVzTUZqcUtDVmhM?=
 =?utf-8?B?TURERHBEMTNUMjEyMFg2emNza21ldFMyc2g2cHZLRzR2c0NOSFZlYXNWSkZI?=
 =?utf-8?B?cFZNRFpxMFlyMk1RcWR0L1FHa1FkMFVmN0wreFMwd0ZVSGs0K0tZRlRvVW1p?=
 =?utf-8?B?M0djdlhpYmZEMTY4RWhWYURxc1JBekdHbkYxZDV2bktZbGtQQjdDNUY3RlRm?=
 =?utf-8?B?eTJPWE5abU9GV1l5RVpmejlvMkluVDhpb3YvNnpjdjRwbFBoK1gxd3BjVmFZ?=
 =?utf-8?B?K1JWZjBmaTFScFhNVFZwNHh1NC9KUTVTdjk5bVNtcVFzcHNIS1pYRFJ3eTNU?=
 =?utf-8?B?UUt3bjI5bTUrV3pNYWNqMkV2L3ZiQzA0bHl6TG9Sd0xlUU9MS205VytVZnFj?=
 =?utf-8?B?emNXQVpoYkZFbUx3VllzcHpLa29VOWhDd0FETVliUlhmeGpTQkdjc3FnZjd3?=
 =?utf-8?B?WUk4bTRjNStxU2M2K3o1Q1lpcFlpU0hwcFZHelN2QnlOdjhpZTVpSVNvRm9h?=
 =?utf-8?B?Vm5aOHlpSWU0L1E4Mkd6akRwR2JZSzFCcDZ1RWtUaHJOVEtpUTR0K2FWVEYr?=
 =?utf-8?B?a0s4QzkrMHNXZ1BmcE53VjhkZlA1NVY3cGEzelR5c1pRNWZ6V2poMy96Nmsv?=
 =?utf-8?B?ZVJqTlVHQ0QzaVloRXptVTRlZG9taWN0WTVqdDNGUmhPS1lBaXZqZEdmMEov?=
 =?utf-8?B?ZUJnbUFnTXd5OWF1MVpORUhzcEErVHFCWnVRTURLdENmUk9nTXBUcXR5Vk14?=
 =?utf-8?B?NGcyK2UzWlZIaTMvRjdOeFVBeTRoRDNTdWRoV3ZvTjh0V3JoSzB3SHEvOWpE?=
 =?utf-8?B?V0NQTVhnSjljc2JUSVNXR25lcUpRMThkL1FIMFAyVTU3UEh0R0p0UEltV2x5?=
 =?utf-8?B?MmRUUW1LNHNVcmJJWmprNVlVV3JGMTFYY0wvd0RVdUxhRmZjWDlZSzQ5dk83?=
 =?utf-8?B?Q0w2YWNnd0t4cEpDOHljaEdUUDI4M2pJVGlNWUFJSU9vdlcySlRNWEJybUtx?=
 =?utf-8?B?WU9WdEhpN2QvaHJtMXF3Sm9EVkloc2lQVys4QThiYXhLdjRmMUd1MFRBSVNC?=
 =?utf-8?B?TnBNQS91d3Y1eGsvM1JZZGRyUnpKWDFiSForZDd4STFjcE1rZ0NjY0p6K2hW?=
 =?utf-8?B?V2l1UFJDbEpibmNObC8xZE42U0VXMkFxYU1sQ1RMTG96QlZVcXpkZ0VlTWIw?=
 =?utf-8?B?YnowQUYvS3JBT01mMnFJVy9Ic0RCRFFTZENaYVNuMTZaeXp4R2VJOGRyM1dy?=
 =?utf-8?B?Q2pLZGhkcW9hN0FYWlp5SHl1UmlDOC80Q2NnSW9Na3N5SEdwN0NtOWh5UXpv?=
 =?utf-8?B?RGtVR2dPTkkralFSdkNocTZMVkZGSnBUKzZjUWFLYlJwSWdUM3Y2N1gxYjZ5?=
 =?utf-8?B?eCs4TXhadFVwc2JkK0Foc1lLTld6T3RZb1NMc0x1V3AwNk5kSjVFM2ErMW5v?=
 =?utf-8?B?NjMwYUhVVEpSUE1qWlMrUGJEcTdVaEJ1cTMyK1NCZ2k0SVpXNU5hMXNSL1h4?=
 =?utf-8?B?cjN0NEFDWnhiYUs3Ym5Camd3WGg1UHp1UE5kRjNZTXg1NldySTRCaWQ4R2J3?=
 =?utf-8?B?R3MvU2sxVW5YcGFWSW5tQjhYaTN2TS9xY0I3Y21RY1hRVDhDbzF1R25MeUJk?=
 =?utf-8?B?d29pTGRndXQ1Y3I5N3ovaVBBK1BOaFgrcFhSN2g3bXp0ak9wakNLMFBPTGFX?=
 =?utf-8?B?OU5hWUMrSTBoRGtZTDBVdDVjd3dMVWlvdnF0Qy9LcVdPMGk4Nmg3eEErNXpW?=
 =?utf-8?B?K3NGek5QOUVua0dvbnNPY3BHeU5YcytuOVYya21tY2xITUZiVWc1UzNnMTds?=
 =?utf-8?B?ai9DWGRyTzc0a0lwSkJmSkxsNDU2T3RFWElubS9WeXBYQ2E2NTJPWE5mNW5W?=
 =?utf-8?B?L3JSYjVZZElzSjZKU3BlUmpaVHFIdks5SjZ4LzBHdXY4dG00ZW1BOHlzSDFJ?=
 =?utf-8?Q?ozH8YxmhpswLTjgMo0GKoaPh2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45559adc-863e-423a-f414-08db93a38b02
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 21:58:02.5888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2BrQ0csK2i3T2nbgvKaEWbSfY7oA3y4d9or8dzCBik/qfaO50ZiQdER2v0/jaXmdLkAxH4Yn+4502Wruci5Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8923
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 7/6/23 11:41, Michael Kelley wrote:
> In a CoCo VM when a page transitions from private to shared, or vice
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
> load_unaligned_zeropad().  Unfortunately, this exception handling and
> fixup code is tricky and somewhat fragile.  At the moment, it is
> broken for both TDX and SEV-SNP.
> 
> There's also a problem with the current code in paravisor scenarios:
> TDX Partitioning and SEV-SNP in vTOM mode. The exceptions need
> to be forwarded from the paravisor to the Linux guest, but there
> are no architectural specs for how to do that.
> 
> To avoid these complexities of the CoCo exception handlers, change
> the core transition code in __set_memory_enc_pgtable() to do the
> following:
> 
> 1.  Remove aliasing mappings
> 2.  Remove the PRESENT bit from the PTEs of all transitioning pages
> 3.  Flush the TLB globally
> 4.  Flush the data cache if needed
> 5.  Set/clear the encryption attribute as appropriate
> 6.  Notify the hypervisor of the page status change
> 7.  Add back the PRESENT bit
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
> This approach may make __set_memory_enc_pgtable() slightly slower
> because of touching the PTEs three times instead of just once. But
> the run time of this function is already dominated by the hypercall
> and the need to flush the TLB at least once and maybe twice. In any
> case, this function is only used for CoCo VM page transitions, and
> is already unsuitable for hot paths.
> 
> The architecture specific callback function for notifying the
> hypervisor typically must translate guest kernel virtual addresses
> into guest physical addresses to pass to the hypervisor.  Because
> the PTEs are invalid at the time of callback, the code for doing the
> translation needs updating.  virt_to_phys() or equivalent continues
> to work for direct map addresses.  But vmalloc addresses cannot use
> vmalloc_to_page() because that function requires the leaf PTE to be
> valid. Instead, slow_virt_to_phys() must be used. Both functions
> manually walk the page table hierarchy, so performance is the same.

This all seems reasonable if it allows the paravisor approach to run 
without issues.

> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
> 
> I'm assuming the TDX handling of the data cache flushing is the
> same with this new approach, and that it doesn't need to be paired
> with a TLB flush as in the current code.  If that's not a correct
> assumption, let me know.
> 
> I've left the two hypervisor callbacks, before and after Step 5
> above. If the PTEs are invalid, it seems like the order of Step 5
> and Step 6 shouldn't matter, so perhaps one of the callback could
> be dropped.  Let me know if there are reasons to do otherwise.
> 
> It may well be possible to optimize the new implementation of
> __set_memory_enc_pgtable(). The existing set_memory_np() and
> set_memory_p() functions do all the right things in a very clear
> fashion, but perhaps not as optimally as having all three PTE
> manipulations directly in the same function. It doesn't appear
> that optimizing the performance really matters here, but I'm open
> to suggestions.
> 
> I've tested this on TDX VMs and SEV-SNP + vTOM VMs.  I can also
> test on SEV-SNP VMs without vTOM. But I'll probably need help
> covering SEV and SEV-ES VMs.

I wouldn't think that SEV and SEV-ES VMs would have any issues. However, 
these types of VMs don't make hypercalls at the moment, but I don't know 
that any slow downs would be noticed.

> 
> This RFC patch does *not* remove code that would no longer be
> needed. If there's agreement to take this new approach, I'll
> add patches to remove the unneeded code.
> 
> This patch is built against linux-next20230704.


> 
>   arch/x86/hyperv/ivm.c        |  3 ++-
>   arch/x86/kernel/sev.c        |  2 +-
>   arch/x86/mm/pat/set_memory.c | 32 ++++++++++++--------------------
>   3 files changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 28be6df..2859ec3 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -308,7 +308,8 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
>   		return false;
>   
>   	for (i = 0, pfn = 0; i < pagecount; i++) {
> -		pfn_array[pfn] = virt_to_hvpfn((void *)kbuffer + i * HV_HYP_PAGE_SIZE);
> +		pfn_array[pfn] = slow_virt_to_phys((void *)kbuffer +
> +					i * HV_HYP_PAGE_SIZE) >> HV_HYP_PAGE_SHIFT;

Definitely needs a comment here (and below) that slow_virt_to_phys() is 
being used because of making the page not present.

>   		pfn++;
>   
>   		if (pfn == HV_MAX_MODIFY_GPA_REP_COUNT || i == pagecount - 1) {
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 1ee7bed..59db55e 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -784,7 +784,7 @@ static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long
>   		hdr->end_entry = i;
>   
>   		if (is_vmalloc_addr((void *)vaddr)) {
> -			pfn = vmalloc_to_pfn((void *)vaddr);
> +			pfn = slow_virt_to_phys((void *)vaddr) >> PAGE_SHIFT;
>   			use_large_entry = false;
>   		} else {
>   			pfn = __pa(vaddr) >> PAGE_SHIFT;
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index bda9f12..8a194c7 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2136,6 +2136,11 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>   	if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
>   		addr &= PAGE_MASK;
>   
> +	/* set_memory_np() removes aliasing mappings and flushes the TLB */

Is there any case where the TLB wouldn't be flushed when it should? Since, 
for SEV at least, the TLB flush being removed below was always performed.

Thanks,
Tom

> +	ret = set_memory_np(addr, numpages);
> +	if (ret)
> +		return ret;
> +
>   	memset(&cpa, 0, sizeof(cpa));
>   	cpa.vaddr = &addr;
>   	cpa.numpages = numpages;
> @@ -2143,36 +2148,23 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>   	cpa.mask_clr = enc ? pgprot_decrypted(empty) : pgprot_encrypted(empty);
>   	cpa.pgd = init_mm.pgd;
>   
> -	/* Must avoid aliasing mappings in the highmem code */
> -	kmap_flush_unused();
> -	vm_unmap_aliases();
> -
>   	/* Flush the caches as needed before changing the encryption attribute. */
> -	if (x86_platform.guest.enc_tlb_flush_required(enc))
> -		cpa_flush(&cpa, x86_platform.guest.enc_cache_flush_required());
> +	if (x86_platform.guest.enc_cache_flush_required())
> +		cpa_flush(&cpa, 1);
>   
>   	/* Notify hypervisor that we are about to set/clr encryption attribute. */
>   	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
>   		return -EIO;
>   
>   	ret = __change_page_attr_set_clr(&cpa, 1);
> -
> -	/*
> -	 * After changing the encryption attribute, we need to flush TLBs again
> -	 * in case any speculative TLB caching occurred (but no need to flush
> -	 * caches again).  We could just use cpa_flush_all(), but in case TLB
> -	 * flushing gets optimized in the cpa_flush() path use the same logic
> -	 * as above.
> -	 */
> -	cpa_flush(&cpa, 0);
> +	if (ret)
> +		return ret;
>   
>   	/* Notify hypervisor that we have successfully set/clr encryption attribute. */
> -	if (!ret) {
> -		if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
> -			ret = -EIO;
> -	}
> +	if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
> +		return -EIO;
>   
> -	return ret;
> +	return set_memory_p(&addr, numpages);
>   }
>   
>   static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
