Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC8C62B081
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Nov 2022 02:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiKPBZi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Nov 2022 20:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiKPBZg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Nov 2022 20:25:36 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45F212611B;
        Tue, 15 Nov 2022 17:25:30 -0800 (PST)
Received: from [192.168.0.5] (71-212-113-106.tukw.qwest.net [71.212.113.106])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8260320B717A;
        Tue, 15 Nov 2022 17:25:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8260320B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1668561929;
        bh=VDLo8zbPXioYWN/SStu6qUVWfBLk1lWDQR3U6RnVois=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=s+7UOMAfiepeCPyCHW5IlDj7xGLqR8CdM/K1zb4urLoy7cQQhxHbuXZze2NgODi9W
         Ul1J73OByj210UGEbHSpMYLdM6tA3QazVQFWgQ1Q0G2r1pqXXMBH4XlXJaLlOYvrHh
         wnfpKdRAuNO4m3mRoR3vjATUIb9veVLlwg0+K1Zw=
Message-ID: <fd31c242-e510-cba3-4057-8040eab8f41f@linux.microsoft.com>
Date:   Tue, 15 Nov 2022 17:25:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] iommu/hyper-v: Allow hyperv irq remapping without x2apic
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>
References: <1668020853-23950-1-git-send-email-nunodasneves@linux.microsoft.com>
 <Y255HhDbwbI/z5bJ@liuwe-devbox-debian-v2>
 <BYAPR21MB1688800D35F86D766567C1FAD7009@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y26F+H1SuJrad3Ra@liuwe-devbox-debian-v2>
 <BYAPR21MB168819214A20DF2E4835E763D7009@BYAPR21MB1688.namprd21.prod.outlook.com>
 <2f721208-d169-2baa-fa1f-b8450e80ddd7@linux.microsoft.com>
 <Y3JJpyvCcrRZfJkV@liuwe-devbox-debian-v2>
 <BYAPR21MB1688FA95BE87E9D1B607B050D7059@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <BYAPR21MB1688FA95BE87E9D1B607B050D7059@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 11/14/2022 11:09 AM, Michael Kelley (LINUX) wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Monday, November 14, 2022 5:59 AM
>>
>> On Fri, Nov 11, 2022 at 02:53:59PM -0800, Nuno Das Neves wrote:
>>> On 11/11/2022 9:58 AM, Michael Kelley (LINUX) wrote:
>>>> From: Wei Liu <wei.liu@kernel.org> Sent: Friday, November 11, 2022 9:27 AM
>> [...]
>>>
>>> I've tested this patch on these Azure SKUs:
>>> - Standard_D2S_v2 (intel xapic)
>>> - Standard_D4ds_v4 (intel xapic)
>>> - Standard_D4ds_v5 (intel x2apic)
>>> - Standard_D4ads_v5 (amd xapic)
>>>
>>> I've tested with linux Dom0 (nested hyperv root partition) and as a
>>> regular L1 guest.
>>>
>>
>> Okay. I think your tests are good.
>>
>> Michael, do you have any further concern?
>>
> 
> If ms_hyperv_msi_ext_dest_id() returns "true", then
> hyperv_prepare_irq_remapping() will still return -ENODEV and you
> won't get interrupt remapping because it isn't needed, at least not
> for guest VMs.  Is that what we want for the root partition?  Or does
> ms_hyperv_msi_ext_dest_id() only return true in a guest partition,
> and not in the root partition?  See commit d981059e13ff.
> 

I did some digging, and I *think* this function will always return "false"
in the root partition.

The cpuids (HYPERV_CPUID_VIRT_STACK_*) that determine the result of
ms_hyperv_msi_ext_dest_id() are implemented by the virtualization stack
in Azure, so for L1 guests it depends on that.

But, for nested root, the nested hypervisor controls which cpuids the
root partition sees, and VIRTUALIZATION_STACK_CPUID_INTERFACE is not in
that list.

I tested this too; if I boot the kernel with an L1 guest, I can see that
the HYPERV_CPUID_VIRT_STACK_INTERFACE contains the "VS#1" signature.
If I boot as L2 Root, the signature is not present.

I'm reasonably certain, but if I'm wrong we'll see the same breakage for
the same reason and we can fix it I guess.
