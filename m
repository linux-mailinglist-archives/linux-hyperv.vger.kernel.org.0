Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358D276C05C
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Aug 2023 00:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjHAWZN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Aug 2023 18:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjHAWZM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Aug 2023 18:25:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17604E57;
        Tue,  1 Aug 2023 15:25:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690928708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6vBNRn+H/dJq3KiQZngBmkVTw7vlHm+rFM/v4+ZfCVc=;
        b=YfVVpMlh3AgWVaOw8BAqH0WNL6zBa3y3ZX/ML7tUNBIuQuW3kyGi9vZXe84DNlGNouwNhI
        vspqSluF6nr+ZKET4ijthsFCpSBWrLrslZAFZrCseQrmqNWz5WYopEmIi6xR1wpMVy2HTG
        HtiCcYZOdEr0+v8XouguUounQcNg0Zjrh02LZToA+6rm6y0P5gE9jQRT7KBSiOqNZNxGfI
        TfOrA6aYGbZzAwuHkTEwOv75RXrKHzkUOIdl5Pdu97qx+RHoVYgM1Dw8GXyZQ8kjdlLE/K
        ppQ7lOf2hB7RFHYmd0a+vOTLBJW+O1PnVz0Mp9A2aziBItdIPRf8Zha+Hh04lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690928708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6vBNRn+H/dJq3KiQZngBmkVTw7vlHm+rFM/v4+ZfCVc=;
        b=qICwBH2O/ACaej1WWGuDl2V2Z5ehM13vyBVJeYwCoQni/JQKI+RGOzbSjHbyvjJUgiuM6O
        uWN9TLIlApESnhCQ==
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-hyperv@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [patch v2 21/38] x86/cpu: Provide cpu_init/parse_topology()
In-Reply-To: <873513n31m.ffs@tglx>
References: <20230728105650.565799744@linutronix.de>
 <20230728120930.839913695@linutronix.de>
 <BYAPR21MB16889FD224344B1B28BE22A1D705A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <871qgop8dc.ffs@tglx>
 <20230731132714.GH29590@hirez.programming.kicks-ass.net>
 <87sf94nlaq.ffs@tglx>
 <BYAPR21MB16885EA9B2A7F382D2F9C5A2D705A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <87fs53n6xd.ffs@tglx>
 <BYAPR21MB1688CE738E6DB857031B829DD705A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <873513n31m.ffs@tglx>
Date:   Wed, 02 Aug 2023 00:25:07 +0200
Message-ID: <87r0omjt8c.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael!

On Tue, Aug 01 2023 at 00:12, Thomas Gleixner wrote:
> On Mon, Jul 31 2023 at 21:27, Michael Kelley wrote:
> Clearly the hyper-v BIOS people put a lot of thoughts into this:
>
>>    x2APIC features / processor topology (0xb):
>>       extended APIC ID                      = 0
>>       --- level 0 ---
>>       level number                          = 0x0 (0)
>>       level type                            = thread (1)
>>       bit width of level                    = 0x1 (1)
>>       number of logical processors at level = 0x2 (2)
>>       --- level 1 ---
>>       level number                          = 0x1 (1)
>>       level type                            = core (2)
>>       bit width of level                    = 0x6 (6)
>>       number of logical processors at level = 0x40 (64)
>
> FAIL:                                           ^^^^^
>
> While that field is not meant for topology evaluation it is at least
> expected to tell the actual number of logical processors at that level
> which are actually available. 
>
> The CPUID APIC ID aka initial_apicid clearly tells that the topology has
> 36 logical CPUs in package 0 and 36 in package 1 according to your
> table.
>
> On real hardware this looks like this:
>
>       --- level 1 ---
>       level number                          = 0x1 (1)
>       level type                            = core (2)
>       bit width of level                    = 0x6 (6)
>       number of logical processors at level = 0x38 (56)
>
> Which corresponds to reality and is consistent. But sure, consistency is
> overrated.

So I looked really hard to find some hint how to detect this situation
on the boot CPU, which allows us to mitigate it, but there is none at
all.

So we are caught between a rock and a hard place, which provides us two
mutually exclusive options to chose from:

  1) Have a sane topology evaluation mechanism which solves the known
     problems of hybrid systems, wrong sizing estimates and other
     unpleasantries.

  2) Support the Hyper-V BIOS trainwreck forever.

Unsurprisingly #2 is not really an option as #1 is a crucial issue for
the kernel and we need it resolved urgently as of yesterday.

So while I'm definitely a strong supporter of no-regression policy, I
have to make an argument here why this particular issue is _not_
covered:

 1) Hyper-V BIOS/firmware violates the firmware specification and
    requirements which are clearly spelled out in the SDM.

 2) This violatation is reported on every boot with one promiment
    message per brought up AP where the initial APIC ID as provided by
    CPUID leaf 0xB deviates from the APIC ID read from "hardware", which is
    also provided by MADT starting with CPU 36 in the provided example:

    "[FIRMWARE BUG] CPU36: APIC id mismatch. Firmware: 40 APIC: 24"

    repeating itself up to CPU71 with the relevant diverging APIC IDs.

    At least that's what the upstream kernel produces according to
    validate_apic_and_package_id() in such an situation.

 3) This is known for years and the Hyper-V Linux team tried to get this
    resolved, but obviously their arguments fell on deaf ears.

    IOW, the firmware BUG message has been ignored willfully for years
    due to "works for me, why should I care?" attitude.

Seriously, kernel development cannot be held hostage forever by the
wilful ignorance of a BIOS team, which refuses to adhere to
specifications and defines their own world order.

The x86 maintainer team is chosing the lesser of two evils and lets
those who created the problem and refused to resolve it deal with the
outcome.

Just to clarify. This is not preventing affected guests from booting.
The worst consequence is a slight performance regression because the
firmware provided topology information is not matching reality and
therefore the scheduler placement vs. L3 affinity sucks. That's clearly
not a kernel problem.

I'm happy to aid accelerating this thought process by elevating the
existing pr_err(FW_BUG....) to a solid WARN_ON_ONCE(). See below.

Thanks,

        tglx
---
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1688,7 +1688,7 @@ static void validate_apic_and_package_id
 
 	apicid = apic->cpu_present_to_apicid(cpu);
 
-	if (apicid != c->topo.apicid) {
+	if (WARN_ON_ONCE(apicid != c->topo.apicid)) {
 		pr_err(FW_BUG "CPU%u: APIC id mismatch. Firmware: %x APIC: %x\n",
 		       cpu, apicid, c->topo.initial_apicid);
 	}
