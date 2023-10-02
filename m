Return-Path: <linux-hyperv+bounces-400-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630297B56E6
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 17:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 14CA12828C7
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 15:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551041CFB1;
	Mon,  2 Oct 2023 15:52:30 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE62E1CFAA
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Oct 2023 15:52:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D7C93;
	Mon,  2 Oct 2023 08:52:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEIv2R5dv1VLnafIeyRc6d/ep+NjMxmhBPR1fD3Hz97Ly39I4nwPKGZ9S67KCYADqhFMcHa7cV1H4rccYlo0iDBQ/smXEVQTYvEnXfF9Cgf2MzxsI/Q64oM9VlBY8tx9mrfVR0Xn2bdozPMNLessk6F9ujf9f6c7dBbgVXY87nG+u0Ip2+T+2etMM1JT68WHX7BTlj3tBZuAFp/uKZ9O4U6Y0Q0F5uEVUTvwDnRjkDICgXKFznnRDQEeMIBFywNcFJb16FG/AGgQZWheYUKmeY+/Un0lRS2XWKvAnotE5ycPseRoI/EGUraVWcLRNS2ji2wUiLaWEyJkuRrBAwzSKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kUVl9D2vqnPYgYlAoHfWiE/IW15lexs77CwC+R2y0o=;
 b=XSuCak5XyQUP/vj5LQCN7nNI/j+/X8UMFMR15iZZE8yZ8j5TOYHS1SpjlNW7pj1VlloW17i3RVklK2rKE7dPwpsGoaRMM9gwbNeN0TIBHAXEUDsnrbUumkUwL0eeyQCwDo8yVmnP/U7c83NTi48dqQ4n/Sjf1aus5ANd1/TU9RX4VPPjOen2TIkm0CcX3iL1OXmAVViMsUZ3v/FHTcTYmvs/1iZabmwu/53dZIcAcRmnhNL+dicDqrcdquj75fjmMv+X6y5KqoJKU4nHRufsfRwX9ssK2HjptIi4H0a5rMZsy4xeB/K9TTTntyJ26xwQxfntDavxUx6dGcO9P3O5KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kUVl9D2vqnPYgYlAoHfWiE/IW15lexs77CwC+R2y0o=;
 b=Mt1mYWT2JR8gSuOpjg5DpVRuPcDxLd1vjcA0mlfJoOrd00cq0by/1IpK8381/FAbJqfZSdzEFWj30EmxCs6P6VVX3Ffo7Bot1wzTGzftz7PWORKfzSFIxjVVox4p2i/CV73Fxe8kEW2+4TOJ3GbxOInu+7KOr0ID8BP5w337ToY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DS7PR12MB5720.namprd12.prod.outlook.com (2603:10b6:8:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Mon, 2 Oct
 2023 15:52:25 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2b54:7ddf:9e2e:751c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2b54:7ddf:9e2e:751c%3]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 15:52:25 +0000
Message-ID: <3557e754-1974-7830-0150-19e5a32c334b@amd.com>
Date: Mon, 2 Oct 2023 10:52:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/5] x86/coco: Use slow_virt_to_phys() in page transition
 hypervisor callbacks
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
 <1696011549-28036-2-git-send-email-mikelley@microsoft.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <1696011549-28036-2-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0087.namprd07.prod.outlook.com
 (2603:10b6:4:ae::16) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DS7PR12MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 6155f6db-d4d4-419a-4fd0-08dbc35f9272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wH74EkuhI79u3dPrV/s4Y1T4Mg486BsAn/rm0ZzoaZDHIx6TTaZiaidjujwZybQrRwlTQ/wbQVBUK0568EsG/ibsGdYAThcufw54V3aE3BFJyvxetb2ThPGFJE3ltQ91mHZS4nfn6Q+LnSOul/iAIBcQkE75WpWFNvF2PbU9hlVWOmqr1MD2ymMVGNgh9RT+no0GXEbWAUOzD2J8wYqmx3hDDNzN4Gzvek1flelR1xX8+SpiVOz/PmTScamBdTpqJCreMiYAgZiQEOnaPhD3uflTCjagZELAqA0EAu8FTfYlx7maE5rrHh8Aw6wj+1KfXLtmMk28yp+fhpYrG77LSOYZHr1fVmSwUEkfHtYsW1jdz1D2ggkWDvfo/Va2RYE3jNl82cyi2CWiWdTjBHTwx2cbeVKcLRfYWVj8FLO+xXYwc3pen4XelR7yNQo1VweBsvl7KQPO2ZoIuOhRF1B1oAkUWpJgCdpKgYermYDc3VlvvyPS/7TPJaW9glME7JmRD1+9td3aOaZSsgoS3BxmTPXUqZqwoUVnfnqN4sQNKzlZDf/gyAiF8VYbvztw456v67uixp4m7I0RumzXGJF1pUXWPzzxrLVtNe85eOkaf12I9D996j+cXXJX4uH6kOa3pU9gdrJCmW5cT9FjhV+JTCVe4YSpaeqM7hvwdhs0GPo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(8936002)(66556008)(316002)(66476007)(45080400002)(66946007)(5660300002)(31686004)(41300700001)(7416002)(8676002)(38100700002)(921005)(83380400001)(86362001)(2906002)(6512007)(36756003)(6506007)(6486002)(478600001)(31696002)(2616005)(26005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnVQRjk2eGR0eUdTd0xWbGRZOGxhWkYzc1RqK28rTFFvY0JOVWFHZml2cTU1?=
 =?utf-8?B?bGdUTzVVT0VhWFVBRXR3Y1B6c2MzRldocHd0UlU0Y04zalNDMzFFRUkwNnNH?=
 =?utf-8?B?QXlrMHZNa01tWWpKN0NCY2dhMFJiY0s4S1hPcHFMMUZDL3pkK3lERGl2K3Ux?=
 =?utf-8?B?VzRqMGpzS3psdkhkc1d1QjRGY0YxM3VZMmkwZVA5TTAxd3E4MU9XY2xFOTB1?=
 =?utf-8?B?cVZ5QTBCMEQ1Ym9TNi9TS3l1OGkxeWxybDQ4ZHRLbkxVRjRRMXp4MHMzTk9a?=
 =?utf-8?B?c29wMGxoNTNmeCs0Y0dIWHplZG5GWjNhY1gvQkRTcXhJaGRZcURFM3g3UzBh?=
 =?utf-8?B?b2JCOFRyVGhKQVJnRjZqWjBCVWlVaDk4ZUY4aEpvUVczeWtITjlkVFlHZ0tv?=
 =?utf-8?B?QWRCaURXOVhNRWpzL1hwTjVhVnJmSDhRSW5UcjdqZ2Frb0lXT3Nmalh3S3Rz?=
 =?utf-8?B?dXNzaHYzeVM5UnF6RmFEaEFWajVJL1d0QUlKRXlJSGdvYU1YQ2syWllHOUt5?=
 =?utf-8?B?Nkp4UXhCcE1Ya3I0ampRTVMvSHVHUzFpRXdKRzQzM1NLblFleXhNZlBpWkVt?=
 =?utf-8?B?N1RCcUI5QzRRK1E1N241SUR0Ymd3T3pNaGs5aEVYaytEZ2svRk1PcHBGSzZW?=
 =?utf-8?B?UGdnK29lYit5NlU4WHZXZk5zN0xhdytTdjRmNS9VSlVxU05Ca1RxS2dPZzVL?=
 =?utf-8?B?d1IwU2dadGlXTjVLZjg4U25NV1dWdEF4L1h0Um9IdFhWVTB3ZkdPbzIrUTNI?=
 =?utf-8?B?dE5nL0pyN1RlQ1hvZkRaTE9VQlJGRHBxTGVOVk9wWThWV1dmdGZMMndVUmk0?=
 =?utf-8?B?cEl0YWtRMHVlaHBvWWxwc2JsN0ZHU0hkUUNhem9naTlsUDNSZ0R5ZVlHb2JW?=
 =?utf-8?B?V0FSNHNNOG9SSkJvdlFvSGVqczlzY2pTWXMzS0JsaFNCdndNS1Bsa3FwT2xX?=
 =?utf-8?B?Y3YwU0ZBczJTSGF5NzY2QzdjSFJnWk9zZ3pmalBmL2hnSU5HTmkrYWJaNUFy?=
 =?utf-8?B?VlBuMEJwNmc0NEV6cHE5cHZsRnN2akMxRUNHeTBsUU5VQUlFbzBrN3ptS0xP?=
 =?utf-8?B?TmdENVlwMXU3K3lpb0dSeXlnWDFaNXQzelRXcHI4dVlkN1EvVUxsSXJaSFU1?=
 =?utf-8?B?c0FlVE9xR0F1MTBIaEJBR3lCOVNXU0IxU2VzeFNYSTluSVpsL0dLbnJ2YjNZ?=
 =?utf-8?B?SVMzSmtWTGhGR0ZsVjJMSGUvVUxjNm1mKzRpcER1ekRYUzlNenFUcFc3VVUz?=
 =?utf-8?B?d2dlMUFRVUw5ZmhQUGVzekp4dkNXdEM4N1Q1OWo5TzBhU0pSL2IzYkhoNElQ?=
 =?utf-8?B?YXp6UWdsaHVQL0ZBbkZqSGVqSUpaOWdLaDFXSFJDRVphbFZNelF5eGlyNnB4?=
 =?utf-8?B?WWpWblpNTEF6dysvbUNhY0lDWXBKcXpMcEYwMGc4Uk1uQVhYM3cxcmNYcFc4?=
 =?utf-8?B?bGVnN3IrZVoyelpzMlc0OW5WcXZKQUp5bEFVSTVmUVpyVHRqRFF5Ri84bFVS?=
 =?utf-8?B?OGtLVXhEV2dpbExiSkhXQ3M5WFM4QmQwcWowV1lXVmlweUdseG1jdzJJT2xj?=
 =?utf-8?B?b3cyb0EvekJUYVF5OTlSMk1OMnduSFNNL2M3b0NlbTdFbjF6OEk0NXZ6c0R1?=
 =?utf-8?B?Z3hkeGRkamtuSmxlb1JZNmU2aURrZXFzSWE4by9EclhMS2lMb0xQZk55TUg1?=
 =?utf-8?B?MEZRRElEeFlIWldRU0hBZWpNb0pnVzNVVVhtMkFtQ25PM3UwQWRFa3RaZmZW?=
 =?utf-8?B?OHB3YU03TDMyNmNZMTFZamlnb2dxTTgzbFM1bFJ2eDBLZ3hablhMWU5nZHlm?=
 =?utf-8?B?MjNTbzdGOCtPMkJkK3JUemtJekJ2Qk9LMXJ1N2ZVRUxIVEpGWTUwU1F0c0g1?=
 =?utf-8?B?dUROWlZRRk12Y1dSaFdXMk91elhsVnplcEdOQUVCODJsVXl3c2pUUEhmSkJW?=
 =?utf-8?B?K1pEZldCNWpraE02OGhWeERqNnlDbmlQQVk0elVsSWdybzF1QmhyM3hQMXV6?=
 =?utf-8?B?ZkZNVERZejJEeVZMTHdiMFJzRFk0QWxCNStNRFBxZHJtOTZxNlZKa2FQczd2?=
 =?utf-8?B?TnQwMzZWaDN6bnNadUtMdWM1MGs2RVlUNHFBd3pDQWMzWEt0LzB4QXNkMXdr?=
 =?utf-8?Q?pqYdofiGDjlYmWJHB/A271cym?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6155f6db-d4d4-419a-4fd0-08dbc35f9272
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 15:52:25.0359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWE72B30Rc2x6HHmdVTksxQLt/v6mcfI3kmBAM2STEz2nf/FS4togS0wVXccjQKBCUJOYA6sIx2yCF//ei0yqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5720
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/29/23 13:19, Michael Kelley wrote:
> In preparation for temporarily marking pages not present during a
> transition between encrypted and decrypted, use slow_virt_to_phys()
> in the hypervisor callbacks. As long as the PFN is correct,
> slow_virt_to_phys() works even if the leaf PTE is not present.
> The existing functions that depends on vmalloc_to_page() all
> require that the leaf PTE be marked present, so they don't work.
> 
> Update the comments for slow_virt_to_phys() to note this broader usage
> and the requirement to work even if the PTE is not marked present.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>   arch/x86/hyperv/ivm.c        |  9 ++++++++-
>   arch/x86/kernel/sev.c        |  8 +++++++-
>   arch/x86/mm/pat/set_memory.c | 13 +++++++++----
>   3 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index c1088d3..084fab6 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -524,7 +524,14 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
>   		return false;
>   
>   	for (i = 0, pfn = 0; i < pagecount; i++) {
> -		pfn_array[pfn] = virt_to_hvpfn((void *)kbuffer + i * HV_HYP_PAGE_SIZE);
> +		/*
> +		 * Use slow_virt_to_phys() because the PRESENT bit has been
> +		 * temporarily cleared in the PTEs.  slow_virt_to_phys() works
> +		 * without the PRESENT bit while virt_to_hvpfn() or similar
> +		 * does not.
> +		 */
> +		pfn_array[pfn] = slow_virt_to_phys((void *)kbuffer +
> +					i * HV_HYP_PAGE_SIZE) >> HV_HYP_PAGE_SHIFT;
>   		pfn++;
>   
>   		if (pfn == HV_MAX_MODIFY_GPA_REP_COUNT || i == pagecount - 1) {
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 2787826..f5d6cec 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -784,7 +784,13 @@ static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long
>   		hdr->end_entry = i;
>   
>   		if (is_vmalloc_addr((void *)vaddr)) {
> -			pfn = vmalloc_to_pfn((void *)vaddr);
> +			/*
> +			 * Use slow_virt_to_phys() because the PRESENT bit has been

Since __set_pages_state() is called by more than one path, please update 
this comment to add something like "because when called via the 
set_memory_encrypted() or set_memory_decrypted() path the PRESENT bit..."

Thanks,
Tom

> +			 * temporarily cleared in the PTEs.  slow_virt_to_phys() works
> +			 * without the PRESENT bit while vmalloc_to_pfn() or similar
> +			 * does not.
> +			 */
> +			pfn = slow_virt_to_phys((void *)vaddr) >> PAGE_SHIFT;
>   			use_large_entry = false;
>   		} else {
>   			pfn = __pa(vaddr) >> PAGE_SHIFT;
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index bda9f12..8e19796 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -755,10 +755,15 @@ pmd_t *lookup_pmd_address(unsigned long address)
>    * areas on 32-bit NUMA systems.  The percpu areas can
>    * end up in this kind of memory, for instance.
>    *
> - * This could be optimized, but it is only intended to be
> - * used at initialization time, and keeping it
> - * unoptimized should increase the testing coverage for
> - * the more obscure platforms.
> + * It is also used in callbacks for CoCo VM page transitions between private
> + * and shared because it works when the PRESENT bit is not set in the leaf
> + * PTE. In such cases, the state of the PTEs, including the PFN, is otherwise
> + * known to be valid, so the returned physical address is correct. The similar
> + * function vmalloc_to_pfn() can't be used because it requires the PRESENT bit.
> + *
> + * This could be optimized, but it is only used in paths that are not perf
> + * sensitive, and keeping it unoptimized should increase the testing coverage
> + * for the more obscure platforms.
>    */
>   phys_addr_t slow_virt_to_phys(void *__virt_addr)
>   {

