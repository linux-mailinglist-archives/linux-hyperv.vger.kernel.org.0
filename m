Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5897252D3C4
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 May 2022 15:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiESNUP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 May 2022 09:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbiESNUN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 May 2022 09:20:13 -0400
X-Greylist: delayed 514 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 May 2022 06:20:12 PDT
Received: from mail.sysgo.com (mail.sysgo.com [159.69.174.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1E3C8BF6;
        Thu, 19 May 2022 06:20:12 -0700 (PDT)
Date:   Thu, 19 May 2022 15:11:27 +0200
From:   Vit Kabele <vit.kabele@sysgo.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, decui@microsoft.com,
        kys@microsoft.com, rudolf.marek@sysgo.com, vit@kabele.me,
        wei.liu@kernel.org
Subject: Hyper-V: Question about initializing hypercall interface
Message-ID: <YoZB/+EYDDfowVbs@czspare1-lap.sysgo.cz>
Mail-Followup-To: Vit Kabele <vit.kabele@sysgo.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        decui@microsoft.com, kys@microsoft.com, rudolf.marek@sysgo.com,
        vit@kabele.me, wei.liu@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello,

I'm playing with the Hyper-V interface described in the documentation
here [1] (version 6.0b) and I noticed inconsistency between the
document and the actual code in arch/x86/hyperv/hv_init.c.

Section 3.13 Establishing the Hypercall Interface states:

> 5. The guest checks the Enable Hypercall Page bit. If it is set, the
> interface is already active, and steps 6 and 7 should be omitted. 
> 6.  The guest finds a page within its GPA space, preferably one that
> is not occupied by RAM, MMIO, and so on. If the page is occupied, the
> guest should avoid using the underlying page for other purposes. 
> 7.  The guest writes a new value to the Hypercall MSR
> (HV_X64_MSR_HYPERCALL) that includes the GPA from step 6 and sets the
> Enable Hypercall Page bit to enable the interface.

Yet the code in hv_init.c seems to skip the step 5. and performs the
steps 6. and 7. unconditionally. Snippet below.

```
rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
hypercall_msr.enable = 1;

if (hv_root_partition) {
	...
} else {
    hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
    wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
}
```

1/ I thought that the specification is written in a way that allows
hypervisor to locate the hypercall page on its own (for whatever reason)
and just announce the location to the guest by setting the Enable bit in
the MSR on initial read. A guest should then not attempt to remap the
page (point 5. above), but instead create kernel mapping to the page
reported by the hypervisor.

2/ The Lock bit (bit 1) is ignored in the Linux implementation. If the
hypervisor starts with Lock bit set, the init function allocates the
hv_hypercall_pg and writes the value to the MSR, then:
	a/ If the hypervisor ignores the write, the MSR remains unchanged,
		but the global variable is already set. Attempt to do a
		hypercall ends with call to undefined memory, because the code
		in hv_do_hypercall() checks the global variable against NULL,
		which will pass.
	b/ The hypervisor injects #GP, in which case the guest crashes.

Do I understand the specification correctly? If yes, then the issues
here are real issues. If my understanding is wrong, what do I miss?

-- 
Best regards,
Vit Kabele

[1]: https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/tlfs
